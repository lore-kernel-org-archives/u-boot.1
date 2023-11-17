Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52683C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 02:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DA388748C;
	Fri, 17 Nov 2023 03:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="T15kVoWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE4DE86FBE; Fri, 17 Nov 2023 03:02:17 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 2A70C8744B
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 03:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id E00AC20B74C3;
 Thu, 16 Nov 2023 18:02:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E00AC20B74C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1700186528;
 bh=kd3n7XWHHgH5Y6kmQf0pGeHGPmzR6XDkUf+rZZxGLQc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T15kVoWbRkHlYnBD22wz8CoJGPO4/kG5t3o9FiUUGOroPKeuEkLQYnVMKWwoNFo6G
 qzbmw5p9deXfluCDWAyG6AYIIxCKs28Fou5o9TOZVd+O4+eC1RSZJKvG4CwSqQNBCd
 /xHm1NYlfBg8rBRN3d+0nrvTwTFEJTc3d4Pfhg1U=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: dphadke@linux.microsoft.com, ilias.apalodimas@linaro.org,
 trini@konsulko.com, sjg@chromium.org
Subject: [PATCH v5 3/5] cmd: kaslrseed: Use common API to fixup FDT
Date: Thu, 16 Nov 2023 18:02:04 -0800
Message-ID: <20231117020207.948636-4-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
References: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
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

From: Sean Edmond <seanedmond@microsoft.com>

Use the newly introduced common API fdt_fixup_kaslr_seed() in the
kaslrseed command.

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 cmd/kaslrseed.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
index 9acb8e16386..23ed7c066aa 100644
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
-		return CMD_RET_FAILURE;
-	}
-
-	nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
-	if (nodeoffset < 0) {
-		printf("Reading chosen node failed\n");
-		return CMD_RET_FAILURE;
+	ret = root_ofnode_from_fdt(working_fdt, &root);
+	if (ret) {
+		printf("ERROR: Unable to get root ofnode\n");
+		goto CMD_RET_FAILURE;
 	}
 
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

