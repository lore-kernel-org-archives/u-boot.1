Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38C4EE49A3
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D1C9863EE;
	Wed, 23 Aug 2023 15:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="xGseIY4D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6895586435; Wed, 23 Aug 2023 08:53:33 +0200 (CEST)
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com
 [162.62.57.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C78086423
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 08:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=writeforever@foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1692773602;
 bh=0Pi1k38pltV7sQ79ARhRZXexb82GeKeCXGa+Eb4tqW4=;
 h=Date:From:To:Subject;
 b=xGseIY4D336Ltj80WePZXQhB9ANLoghdkYyOQyzeAgcFil7RyYflyJmwyBcO5n+lj
 9D/c9anW0lghqmYBA5tmDM2y7XSMmXE1heKRYGlTVrGIsuO2HmibFSwYRNwEiqReeQ
 Plel5bzqWDdGIDJuARqoXv6lXG+q0VdFSzTkzlHQ=
Received: from lunarpc ([103.47.51.210])
 by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
 id BD0244CF; Wed, 23 Aug 2023 14:47:16 +0800
X-QQ-mid: xmsmtpt1692773236tdevkxao6
Message-ID: <tencent_807B704C8CF66453A9723C0E19D28E962607@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieM7Ye7x+tM+CEYUSLdlaUC9D1a97ee8XmSIUZul9DsvLkAmur4y
 6sJnpWJEmdYhkeZp3tFv7Wn+Rv5tBuh/lpaCA0fKo5OIXAngWNVNTDq3q1GKRDsKjzQLA87eeM5F
 iW1dbH6VC0/ynnHWzv5RRGK/E7cZLiZdf+T0jBKh/abFuyWWwrOk6Uv9Y1ZBdr0YoSmLzov1dTBB
 8aOzQuxyUk6H/mob154r8vICm3kWOezNQ1/+IGDEEdba65kHz2sWR/dAFNUxKatC2BUklVCfBgY0
 dyyU5fqkYX65jETomHU87t8YDLgm8vfoq3Kwf3kJ4esdZKFR6yjCaN6dPnJGrOQrIu5Qi4kVBHPn
 ZGfDYlOLo8TrJQRNkkHplRdedC1BVOWpmygkixUxD24YGQ3GGn/RpI3d289O8iSjewnPvy4e4DqE
 6gHCzcX5C9k2iOLasmZqk2yIJ0o1ATNrbISGtIOD8v6IMpG/QfdkAddPDYPK8PofmHUh8YqMd7Xq
 FRsFMtGFCspv2gqsxbCcXfSsw/8KPQVp9Gq7JQzlqdz/kI0Bfw1rcrmMkgn2Uogn772PsvoaT1oq
 ZjIPopDmY8vq6fpMZV5lKycd73LoHjy3mDw3ZfyEcFdCGA6uTZD4Ihw3K5/J4SmdahCIhoO53jit
 1biasVDgyfGvKCisJ1qNj8ASat2MmKhpj8F+Z/Cn/R4mevrng2DypECbeQP5FnzDObh13V7AKbt0
 p2JM2JTWmzDsgPsb3+bXViPmtJq7yoy8ihTomgp7rCBj02B+xPbgHkp96XvOrWkUuJifpwhKK4Ks
 lGogno4nPJiNULfMCmm01LAeQ0ByCVJMgD9Y7FgLZh5RlR4D5ObVZaGm1pVsj82q2JxIj8C0P39D
 FEMWsAmUPMghpJLJ0Y1F+lOIhmJNZNIQaHWx1I6fKpdqDsiMREpFKLbLUiQAFhZmmJxD7IJJcDNN
 dT5NbeWu9CQd2n3q/BbKFiwnr1tZm59mS3pzpcc85H2Ulx6edhyBiUHX6CkOc17AZUCdtBqQRnl9
 ALvP+GSQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
Date: Wed, 23 Aug 2023 14:47:16 +0800
From: Iota Hydrae <writeforever@foxmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
Subject: [PATCH] pinctrl: sunxi: add SPI1 pinmuxes for f1c100s
X-OQ-MSGID: <ZOWrdAkfD8EdmUIK@lunarpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 23 Aug 2023 15:45:21 +0200
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

SPI1 is also usable on port A.

But there's nothing about SPI1 pinmux there for now.

This should be set when you are using SPI1.

According to the manual, the mux value would be 6.

Signed-off-by: Iota Hydrae <writeforever@foxmail.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index e5102180902..c448e40ab07 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -240,6 +240,7 @@ static const struct sunxi_pinctrl_function suniv_f1c100s_pinctrl_functions[] = {
 	{ "mmc0",	2 },	/* PF0-PF5 */
 	{ "mmc1",	3 },	/* PC0-PC2 */
 	{ "spi0",	2 },	/* PC0-PC3 */
+	{ "spi1",	6 },	/* PA0-PA3 */
 #if IS_ENABLED(CONFIG_UART0_PORT_F)
 	{ "uart0",	3 },	/* PF2-PF4 */
 #else
-- 
2.40.0

