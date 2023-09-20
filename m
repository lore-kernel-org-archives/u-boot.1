Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9972ACD4933
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 22:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3354686C4A;
	Thu, 21 Sep 2023 00:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mxTnEhyV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="o1FZm9IQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08C1F86C3E; Thu, 21 Sep 2023 00:58:41 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 402E286BC8
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 00:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RrYqM1H4Hz9tSX;
 Thu, 21 Sep 2023 00:58:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TfxsI85NEjBx6n4ePCMgorsJhSzRF1HsUwNU17onQyg=;
 b=mxTnEhyVtSWgurdcX6/AbBFqg0p1hETdYXwiRwx+QYZJ2FaVQXte1t3MOaD/asOaFXAyjK
 QL4z1bUJH76i6CxSjJuBXjqgwQmVX7zeAAzX/D4znKE+3R4icWtsE2jlFICmPemUVWCUZR
 QBP0nPqTFPQB7Pj0rR1CxS/FGY2QCEazRJulQUa6yfj596fYjnvA1JYnenERBcTXZ7E+ev
 v825z4EtrjxJ1Dsh9mSQK4h/kBBNfPNTQSns9aRGGEigtERMkfuf/6QQf+T2PFLbi4TAU7
 G1+XvU+SM1axtjTiBi8MeIOorb80TbxahZQugnU6a9KxTSuZBKJUpytsyhupRw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TfxsI85NEjBx6n4ePCMgorsJhSzRF1HsUwNU17onQyg=;
 b=o1FZm9IQ3qXE7trMG/6AUJM6G23NmbihW5uXopsBA6vH+WzA7j0r1XiwmNRgix/yuCSGsG
 Jr5xBHVZ1D8uKFihT8FXBGakdy9vWzjUCCADQ6PqsGynbtkkxESZjTNe8oPGDdjgXRFgen
 nGLzKIwI72i3KD09IpqYvllpqw4NJJpzLUm5eY0qAZWpVgfmOQ/e9cRh4CGA46q2XtO6FA
 6plndm4yveTFPYFaUwh98oUgZ0hVCtH5tVvUy1GwbU3XzqUwX7Wll8iPObqyBhWdipJktU
 4xZxxudQPbN36iWoG3K8K+0qeYZ3UQ+YAKMfIT4Hvzhnd43UbYrpaKQ92o/RUQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Nikhil M Jain <n-jain1@ti.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/9] cmd: bdinfo: Implement support for printing ethernet
 settings via bdinfo -e
Date: Thu, 21 Sep 2023 00:58:05 +0200
Message-Id: <20230920225811.153474-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c8deae330a380d18a63
X-MBO-RS-META: hh7fx8xacststear81gb6iapfqzi9g5r
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

Add support for printing ethernet settings only via 'bdinfo -e' .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Simon Glass <sjg@chromium.org>
---
 cmd/bdinfo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index c720ee6f9b6..79106caeec2 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -193,10 +193,15 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return bdinfo_print_all(bd);
 
 	getopt_init_state(&gs);
-	while ((opt = getopt(&gs, argc, argv, "am")) > 0) {
+	while ((opt = getopt(&gs, argc, argv, "aem")) > 0) {
 		switch (opt) {
 		case 'a':
 			return bdinfo_print_all(bd);
+		case 'e':
+			if (!IS_ENABLED(CONFIG_CMD_NET))
+				return CMD_RET_USAGE;
+			print_eth();
+			return CMD_RET_SUCCESS;
 		case 'm':
 			print_bi_dram(bd);
 			return CMD_RET_SUCCESS;
-- 
2.40.1

