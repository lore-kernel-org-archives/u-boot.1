Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8550BC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 00:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62528773E;
	Fri,  1 Dec 2023 01:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81C0A876B2; Fri,  1 Dec 2023 01:55:25 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 536F487656
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 01:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=microsoft.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=seanedmond@microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id CEC0E20B74C1;
 Thu, 30 Nov 2023 16:55:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CEC0E20B74C1
From: Sean Edmond <seanedmond@microsoft.com>
To: u-boot@lists.denx.de
Cc: Sean Edmond <seanedmond@microsoft.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 3/5] cmd: kaslrseed: Use common API to fixup FDT
Date: Thu, 30 Nov 2023 16:54:42 -0800
Message-ID: <20231201005507.2080396-4-seanedmond@microsoft.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201005507.2080396-1-seanedmond@microsoft.com>
References: <20231201005507.2080396-1-seanedmond@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Use the newly introduced common API fdt_fixup_kaslr_seed() in the
kaslrseed command.

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

Changes in v6:
- root_ofnode_from_fdt()->ofnode_root_from_fdt()
- "goto CMD_RET_FAILURE" -> "return CMD_RET_FAILURE"

Changes in v5:
- cast buffer to (u8 *) in kaslrseed.c

 cmd/kaslrseed.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
index 9acb8e16386..9339d82649b 100644
--- a/cmd/kaslrseed.c
+++ b/cmd/kaslrseed.c
@@ -19,7 +19,7 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
 	size_t n = 0x8;
 	struct udevice *dev;
 	u64 *buf;
-	int nodeoffset;
+	ofnode root;
 	int ret = CMD_RET_SUCCESS;
 
 	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
@@ -45,21 +45,15 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
 		return CMD_RET_FAILURE;
 	}
 
-	ret = fdt_check_header(working_fdt);
-	if (ret < 0) {
-		printf("fdt_chosen: %s\n", fdt_strerror(ret));
+	ret = ofnode_root_from_fdt(working_fdt, &root);
+	if (ret) {
+		printf("ERROR: Unable to get root ofnode\n");
 		return CMD_RET_FAILURE;
 	}
 
-	nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
-	if (nodeoffset < 0) {
-		printf("Reading chosen node failed\n");
-		return CMD_RET_FAILURE;
-	}
-
-	ret = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
-	if (ret < 0) {
-		printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
+	ret = fdt_fixup_kaslr_seed(root, (u8 *)buf, sizeof(buf));
+	if (ret) {
+		printf("ERROR: failed to add kaslr-seed to fdt\n");
 		return CMD_RET_FAILURE;
 	}
 
-- 
2.42.0

