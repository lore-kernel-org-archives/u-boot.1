Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BDAC88E5C
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 07:29:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3007180DC4;
	Sun, 13 Sep 2026 07:29:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AXtua0TqHnOu; Sun, 13 Sep 2026 07:29:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4952A80DBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789284546;
	b=n022I1niuJireBnBZ6H4uQQUwSx7UxQYENQqOM+CqbzHvqC8v83sPu5IdqhxUgFUHOiF
	 dKtxXYdBXlhkmSCCKa54EKtmO4SRzqvTw904eta2Y69FdG1pu3wor5bTgqVE4cCS5a5JT
	 rNLqT/EqEIcXP9ex2bDHMcXcBqBRWzgWFbsZ1Rwx5bW529JGYhLoeWT/DisPLLw1h/Os1
	 wGM0Fzi8mKbEjdBQCud5q92BQxtKB8lq9QPyVEbsfAep7RbFJo06unZucvTWDX0C1wAyK
	 9Rlw4GVKA15NjM18roBO6GxBIGDfyoH9NW9pWfCyS0z5JhVw78spxn+TozA7vfpZPRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789284546;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=kvWqtG8hZFJMLgygx7LjeucB4ewrzdiUOSX7R6QbxNg=;
	b=jxqhQ9IgAV9wSgmzB6WLZBq1mtws1fSbveD+anYEpJSfGnyKvoUJ6XTqcBwtvD6Ckr0Z
	 BivOauEP+rZ7aflhAFYfhsvURjIOkgXgDQggSjAF1FI68UB7SOXfNuolrBCUfWYhz4qy3
	 yacQS9kjlccHbVA8SCyfEtoKp4pxmZc4T5XFzcIR1m/IN/lU3ZHkYP8JHnyIedi5t4k7T
	 taU4WjYNuk8auX/iL4DnqxGQf7KhzGXq7XxGyFVc58FXR2N7+/h2noCPygdnjbrsQyq1V
	 2FpacWsvQtY9ncpp8cDYihgQSBJgaYCMV5Lf7s1sMw+NTroMhQN7vVmhcuv8T5zYUzQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789284546;
	bh=kvWqtG8hZFJMLgygx7LjeucB4ewrzdiUOSX7R6QbxNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ywCYUGsd99sgFsWOObbH+ki6z8fswPaAoEHKY6Iqd/a9VX1h4FyBqJjQFRof9dbt2
	 JM0X4lAguvARht4SJytHBR5ec+UsHGeyPlEEr9CgkrcmLlZNhZR3FKyGZjMaiqQkoA
	 G2LwfGyOzPNi8V7ne/ve4TEzIObk3Li8bqXTbhLeNEq/xpOyDzyCvr2D/Aw4K4SXrk
	 58UzTZsslhBmS2K8Ojl9jlQdtcWiUVQ2+iZq7YMHdfRra/WYcBtfNY8vx0K+jTLRQ7
	 vJNAiGpDgs7KynW30N8SFY+Pai5qziTpmtq2GM8HtoI1Fo2+LyPKw9d3lljxegHW2O
	 fKTTiAN5cLG/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4952A80DBA;
	Sun, 13 Sep 2026 07:29:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BFF2D32F
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2A88400BA
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nwLJNRq3vdOW for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 07:29:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 33AF240022
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789284543;
 b=jPzPe3zmpiKtDwIKGQxm2g/iPXqGsppoQrttHq8vOWrEdk4fRcYUIL+c6TR4CIypfACY
 ozt9nECLX+vzrvWhi103dycYVT3n9USUiMwUk4qXC7lEJozjD4ZyGlY58TLRX1qLq5TIO
 bFlchjromjp+3WIY7B8TrucTMzA2HvZt4x5IfF9j/xxX7wU82GeHLTvKmKkDjS6EiHd9f
 UImEHBoCNl0sL1+EKYEgB7z+tr9U+ipY+yWtVhR5jZWAcMNrgPYF7CrU8OTx06/7aKTJQ
 bTWF+A/uVWoJXvn00iIPkvSCE5bxLGxic67IB9XuXVKp41kDvVHFpVl22LiI3JQm3RQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789284543;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=kvWqtG8hZFJMLgygx7LjeucB4ewrzdiUOSX7R6QbxNg=;
 b=e+k9x96uD7r/n7laK465h6ao2qkunkAZIDBIz30uj3DSAnoySNp/OdtkpD4EGhGTaYx4
 xCuZ8Xbj+AKFMFzG1hLi3ACGHngod7kz2lwEbdZNzVnIIbcPyyp7gli2b+kIDGBcW1wOT
 F+ldiHUOj2a4ohIY9IzqBtlY7+LeNBSC47Cz6aNQkHxsOQBjUyYPFp0OqT9iBzdH2cFYI
 8J5YqwZHq4MM5ZlN06pz91Dooz0S2K7jdrjJwNzSt5yfxltvNh6kTrxKakcHtW+A1Pm3R
 RGnB2oFeoniOlRAFGzRS8BbLA/FYaMYLclptph0QiRp9vDpUnG4BRWPrvpC5I/DTZtA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dZ4BUtR0; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dZ4BUtR0
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 33AF240022
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:02 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso13310045e9.2
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 00:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789284540; x=1789889340;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kvWqtG8hZFJMLgygx7LjeucB4ewrzdiUOSX7R6QbxNg=;
 b=dZ4BUtR0Kjf/mdyJGbT9BaGKkuSMYI3gz6/b/e+QMcasgFdiIO7V2M+Fqwppuc9ytP
 JkprS+OezZslMWkHqO+Zq+t04fGXfI5+93Ki09EEiun5skxrG9m3aSEneURn+pKkVZ8t
 msdqEALzCMZsyVUowdRETCDDD8TDrqWLrnqXT8BwpRRRnxGfiLDtz7ezDkxeZXPk+HsV
 OPdz8BnIje1HZRJlbrik3ZDC4Ys09VCaoiCmrFQX7hR5G9YrDAk6VgSxTeQYtdgaqOdE
 Ekjv+4JCuL9QjPoeEZzzbF1HVNS5INu16JCrJbNj6bfWTXk+CFY21Afq2CGVrvobPKbs
 YQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789284540; x=1789889340;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kvWqtG8hZFJMLgygx7LjeucB4ewrzdiUOSX7R6QbxNg=;
 b=WootjVWk+V9KzNRZmG4iTUDHpHfPDrqNYloNMImoOlpE2ZCzaqZicGnV9HQjZikJtN
 3Tm43w4WgnbA7eoUoMw5RBishG+Ut4vuR3D88cP5cS4r877k/jaeBy3Xsd9MNFA102wQ
 QL9KtR/7cpJ8ntcmoa96fjBxK+PHs//3FO1nkEKDy2BrMvQPeT5LoF8YdRxSeODeb8+O
 yroJCaJzYr7gFPJlrhJkz1sF09C9V4kf9SS5ca12Zr3JeP4N7ixihnS7EG+Eof3MI66f
 0vdA04p7Zt8YIiqNHHHgf6KIYAKG6KUEZtyMMUIlqWJ2kALq+o/YS5YQoQss6ybrxQxN
 Indw==
X-Gm-Message-State: AFuF++mZvQisTEEoh5PsebraZ3KAwv+iL0HeMWuOzitRxij56x+FNgx1
 DMG9ghfsvNeKmtMMpQAOk6xFvUVkjJGXONWpflkbQc/mjO9nGuN1wVBnRwSPV63ZmOU=
X-Gm-Gg: AYBFou18SGQ2K18dr9pFIl+cN1ZTHAScu35/GZA7ZEUtI/Pl7wMAxDjK3idtqPRoi2F
 4evsAt0TRnAn75jL5RzbPyzDcnUXY0LRS1C678YLEkBsenQRqWw3uxtHNDrTXGNNewMtjD218Fm
 zIgoGydxk1LUijmAhII4+ImP1k1PxQbxj7hBs9KnSwf6A3xjNESC9nK6HzcbS4wozDSEKkizL3A
 6ZsrMi4SEjkwxupbYQ7wkzooLhagOwe63jrb1XM1fHsF/QbSYtM1plEUkJHuR+ZMDCjMCmUPZbv
 RIiAqt0n/OPAqRC0Ce36kZAtMr54A1IkUxHavdBD3rPF0l4MPPsu8A5jWartPYWhpytdPC9V4e8
 JA+ErRidTNCu7v1gnDLJBVlJQMxXMntDK6BsnDkdwMBALZENkk47yWSZBRyUUgBaai2DxHvreon
 tVbEwVlBvXQv0Qwcn0T11VKWxFss7f6JT+6YU+ROXccigRgxePj83z+PA9x3vSUM8FwMO7zuFTu
 ch659rIEdCAyZTZUpT1hXKnNILlAjCB9VSbjqAQVu362vWJ43nvW/ZPhoDoU5YWobAakJDvfh0I
 xm4R5cwcjHZ4en4=
X-Received: by 2002:a05:600c:4703:b0:49e:602a:b4ec with SMTP id
 5b1f17b1804b1-49e619d62b3mr187030825e9.8.1789284540008; 
 Sun, 13 Sep 2026 00:29:00 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e71e300f3sm100788875e9.7.2026.09.13.00.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 00:28:59 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 13 Sep 2026 09:28:43 +0200
Subject: [PATCH v6 1/5] fastboot: factor out the USB session runner
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-ccaione-upstream-spl-fastboot-v6-1-dd3ba81a7ed2@baylibre.com>
References: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
In-Reply-To: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The fastboot command currently owns USB gadget setup, protocol
initialization, the service loop and teardown. This prevents callers
which do not use the command line from starting USB fastboot without
duplicating the same session lifecycle.

Move that lifecycle into fastboot_usb_run() and leave cmd/fastboot.c
responsible only for argument parsing and transport selection.
Initialize network sessions in their transport path so their existing
behavior is preserved.

The helper may run without a command line, so its diagnostics must not
assume that a command is exiting. Unregister the gadget before releasing
the UDC so no registered function remains attached to a released
controller.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 cmd/fastboot.c            | 53 ++++-----------------------------------
 drivers/fastboot/Makefile |  1 +
 drivers/fastboot/fb_usb.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 include/fastboot.h        | 10 ++++++++
 4 files changed, 80 insertions(+), 48 deletions(-)

diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index f3929f88dfa..ace877b6e28 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -7,12 +7,9 @@
  * Rob Herring <robh@kernel.org>
  */
 #include <command.h>
-#include <console.h>
-#include <g_dnl.h>
 #include <fastboot.h>
 #include <net.h>
-#include <usb.h>
-#include <watchdog.h>
+#include <vsprintf.h>
 #include <linux/printk.h>
 #include <linux/stringify.h>
 
@@ -27,6 +24,7 @@ static int do_fastboot_udp(int argc, char *const argv[],
 		return CMD_RET_FAILURE;
 	}
 
+	fastboot_init((void *)buf_addr, buf_size);
 	err = net_loop(FASTBOOT_UDP);
 
 	if (err < 0) {
@@ -47,6 +45,7 @@ static int do_fastboot_tcp(int argc, char *const argv[],
 		return CMD_RET_FAILURE;
 	}
 
+	fastboot_init((void *)buf_addr, buf_size);
 	err = net_loop(FASTBOOT_TCP);
 
 	if (err < 0) {
@@ -63,7 +62,6 @@ static int do_fastboot_usb(int argc, char *const argv[],
 {
 	int controller_index;
 	char *usb_controller;
-	struct udevice *udc;
 	char *endp;
 	int ret;
 
@@ -82,48 +80,9 @@ static int do_fastboot_usb(int argc, char *const argv[],
 		return CMD_RET_FAILURE;
 	}
 
-	ret = udc_device_get_by_index(controller_index, &udc);
-	if (ret) {
-		pr_err("USB init failed: %d\n", ret);
-		return CMD_RET_FAILURE;
-	}
-
-	g_dnl_clear_detach();
-	ret = g_dnl_register("usb_dnl_fastboot");
-	if (ret)
-		return ret;
-
-	if (!g_dnl_board_usb_cable_connected()) {
-		puts("\rUSB cable not detected.\n" \
-		     "Command exit.\n");
-		ret = CMD_RET_FAILURE;
-		goto exit;
-	}
+	ret = fastboot_usb_run(controller_index, (void *)buf_addr, buf_size);
 
-	while (1) {
-		if (g_dnl_detach())
-			break;
-		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
-			if (tstc()) {
-				getchar();
-				puts("\rOperation aborted.\n");
-				break;
-			}
-		} else if (ctrlc()) {
-			break;
-		}
-		schedule();
-		dm_usb_gadget_handle_interrupts(udc);
-	}
-
-	ret = CMD_RET_SUCCESS;
-
-exit:
-	udc_device_put(udc);
-	g_dnl_unregister();
-	g_dnl_clear_detach();
-
-	return ret;
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 }
 
 static int do_fastboot(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -167,8 +126,6 @@ NXTARG:
 		return CMD_RET_USAGE;
 	}
 
-	fastboot_init((void *)buf_addr, buf_size);
-
 #if CONFIG_IS_ENABLED(NET_LEGACY)
 	if (!strcmp(argv[1], "udp"))
 		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
index a341af076d1..32e8e072c88 100644
--- a/drivers/fastboot/Makefile
+++ b/drivers/fastboot/Makefile
@@ -3,6 +3,7 @@
 obj-y += fb_common.o
 obj-y += fb_getvar.o
 obj-y += fb_command.o
+obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += fb_usb.o
 obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
 # MMC reuses block implementation
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
diff --git a/drivers/fastboot/fb_usb.c b/drivers/fastboot/fb_usb.c
new file mode 100644
index 00000000000..0e25e43047e
--- /dev/null
+++ b/drivers/fastboot/fb_usb.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2008 - 2009 Windriver, <www.windriver.com>
+ * Author: Tom Rix <Tom.Rix@windriver.com>
+ *
+ * (C) Copyright 2014 Linaro, Ltd.
+ * Rob Herring <robh@kernel.org>
+ */
+
+#include <console.h>
+#include <fastboot.h>
+#include <g_dnl.h>
+#include <stdio.h>
+#include <linux/errno.h>
+#include <linux/printk.h>
+#include <linux/usb/gadget.h>
+#include <u-boot/schedule.h>
+
+int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size)
+{
+	struct udevice *udc;
+	int ret;
+
+	ret = udc_device_get_by_index(controller_index, &udc);
+	if (ret) {
+		pr_err("USB init failed: %d\n", ret);
+		return ret;
+	}
+
+	fastboot_init(buf_addr, buf_size);
+	g_dnl_clear_detach();
+
+	ret = g_dnl_register("usb_dnl_fastboot");
+	if (ret)
+		goto out_put;
+
+	if (!g_dnl_board_usb_cable_connected()) {
+		puts("\rUSB cable not detected.\n");
+		ret = -ENODEV;
+		goto out_unregister;
+	}
+
+	while (!g_dnl_detach()) {
+		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
+			if (tstc()) {
+				getchar();
+				puts("\rOperation aborted.\n");
+				break;
+			}
+		} else if (ctrlc()) {
+			break;
+		}
+		schedule();
+		dm_usb_gadget_handle_interrupts(udc);
+	}
+
+out_unregister:
+	g_dnl_unregister();
+	g_dnl_clear_detach();
+out_put:
+	udc_device_put(udc);
+
+	return ret;
+}
diff --git a/include/fastboot.h b/include/fastboot.h
index b106d617749..f02d2559f2b 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -125,6 +125,16 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg));
  */
 void fastboot_init(void *buf_addr, u32 buf_size);
 
+/**
+ * fastboot_usb_run() - run a USB fastboot session
+ *
+ * @controller_index: USB gadget controller index
+ * @buf_addr: Pointer to download buffer, or NULL for default
+ * @buf_size: Size of download buffer, or zero for default
+ * Return: 0 on success, or a negative error code
+ */
+int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size);
+
 /**
  * fastboot_boot() - Execute fastboot boot command
  *

-- 
2.55.0

