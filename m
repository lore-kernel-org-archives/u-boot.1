Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E920BE95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 005B786E37;
	Sat,  7 Oct 2023 23:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wSERj+n2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="b52urS8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD9786977; Sat,  7 Oct 2023 23:41:32 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C1086B0C
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S2zJJ1hdZz9sks;
 Sat,  7 Oct 2023 23:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+tKkAb8u7o0PTYts8mTy15uXmYCKD841fR0Jc1wIj8=;
 b=wSERj+n2OOJgRdw8RKnfmyHnAWIl+sfklZGY9dUDyWNhuO0MojXxI09U+dxj5SoZ4hDV88
 NIVg7E6cCafZEm9gQDiWYwfTBYQzYFoYaPnopoHV9dAzLtHXvRkf2CSTpQ/B/3jKGjyXuN
 +5mlOipcEJJpYi+JcLbuWRb08LlCbqvFcbhH9UnQgU/UHWltoqR7zWQXpsIv9NjGkbEedD
 fGuGiqzcqUGIU9Dh6XC8Tw8WnFawpnmT7flZffIcZj5JZk668Sd3+/mG9ELKNzrKdXvnUi
 EWMKaocgIDcVpBaBtXuySPFnw/HadpoaE7M7rFWGWzIhO40eXTf4SJyuiEPB0Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+tKkAb8u7o0PTYts8mTy15uXmYCKD841fR0Jc1wIj8=;
 b=b52urS8W9WnLIyygHmB9+SBi7rI5ZL8yjyE8IjL4oack0JcrnBL4G3L5FMCHEurn3dV0du
 8Zz5YWzCQBzzTAQNTz1D1sdgHdegi4y8i+rYs9DRLPuNpDbcNYL/ad6Lt4fFfp0mloG6vC
 3RCPwWn0+6L+O/acc9YgK998lEGSBscoqRC7ujojMTbhdLNkCfsN9cVJ8W5+7l5PjRVV15
 TOJHYTP+9LzVQ5RKY0bg4EDA1KtFl5OPLPLBTDPeOYIdcUMiQipzRiMDsOPKD3SRY+jgSd
 vN5AE9Tfi4YciDjhWfLktswwE6/O6w0pG1ycUwvquwhrLTUmWsfhTftmNQ9r3w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v2 3/9] cmd: bdinfo: Implement support for printing ethernet
 settings via bdinfo -e
Date: Sat,  7 Oct 2023 23:41:00 +0200
Message-Id: <20231007214106.15744-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
References: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8a9ezt774zdi11s49wdkccotjce3gm8h
X-MBO-RS-ID: 8f57ac5537f97c6bcb9
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: Add RB from Simon
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

