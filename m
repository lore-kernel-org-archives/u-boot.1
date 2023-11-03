Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB89C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 18:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39903870DF;
	Fri,  3 Nov 2023 19:40:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cYa9fssW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE4B86CF7; Fri,  3 Nov 2023 19:38:58 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id A56A98716D
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 19:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 698F220B74C3;
 Fri,  3 Nov 2023 11:38:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 698F220B74C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1699036730;
 bh=Vg+z5AvRa+xE35z5p0uqsNo95QFSETHwJroYJJZrqpQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cYa9fssWrW830MEaGaD2WIbUf3No7rpyKA5Zr4obVNyIoYrska0i4bzx3B11oieIT
 q/LMVvR24qTuGSi8v2YPXkaZWHPn/qvPXuXKRBPyUYWa6ohKJ6TE1Km2ssE/Sqn9Qc
 sAMr3enwWpBKUy8CdfbNIu4XwNf0yzgsYx0g7rMg=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, dphadke@linux.microsoft.com, ilias.apalodimas@linaro.org,
 trini@konsulko.com
Subject: [PATCH v4 3/5] cmd: kaslrseed: Use common API to fixup FDT
Date: Fri,  3 Nov 2023 11:38:42 -0700
Message-ID: <20231103183844.2308934-4-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231103183844.2308934-1-seanedmond@linux.microsoft.com>
References: <20231103183844.2308934-1-seanedmond@linux.microsoft.com>
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
index 9acb8e16386..6f423702e7c 100644
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
+	ret = fdt_fixup_kaslr_seed(root, buf, sizeof(buf));
+	if (ret) {
+		printf("ERROR: failed to add kaslr-seed to fdt\n");
 		return CMD_RET_FAILURE;
 	}
 
-- 
2.42.0

