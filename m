Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDFDFD877D
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 213A484372;
	Tue, 17 Mar 2026 15:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2qhERDhw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 027588435B; Tue, 17 Mar 2026 15:24:19 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03D5084355
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4856cd3f1ffso17034405e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773757456; x=1774362256;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yU/imIwMm7qptbkXQbXmh9PIGvt2+esOF2JTYKkt4xo=;
 b=2qhERDhw85w8RQlFaq2dQhU/GEBFSU5MlKscRTtXbeHQAf0kMvToEg51HfDcJwSmy8
 tSghgIZgx+mUxkDWg8/gPLHaE+eFOWFuu0MpTIsT/nk1Od/KWd73e0UU1WDKFS6UZGTl
 sLkl4Ni+TjayKt+ERrEh51uI25/LB1ygHuzz7qpMgEkaFaSeyKTjTVfOoZ7NW6mDkS6M
 Kp7GlRznbdy4GXEF5P0cB3oEqHG3fDOi2ZoFaP8TkfUorQmEuszMPmYnTFBXQZnKCy8k
 y7pa/hhDlyAyO9tBayRe4ylqyVo2OGUPI5IVj/NBHw7Z3xW0ur20uBPkS6y5v8JimEEp
 246w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757456; x=1774362256;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yU/imIwMm7qptbkXQbXmh9PIGvt2+esOF2JTYKkt4xo=;
 b=EHhrWjZAMGRqveg5ywVL4sXEPl2JHd7EG5TecToSqdKHDwgt2RExeF1EGqq8Mdqrbt
 yyJWYzHAUUIhSacB3jya1Jnrwqx1/mlnHe3ZtTqMtQoKlQ/KpvwTlEbU0ogNCiZq2gCs
 TLPE2csKzvTHYuXxLlhct8i06TOxwVLgttOqJjhDYSNaKBZbdMfL9+KQG0R+IAh9IYUa
 /Vo5kntWI3eo/jraWFaKJroSQLo9E4ZB1v7flXnudGmEMOKStp2oiLiqfqngPPAQtelL
 Wwgrei60CwdGtoFX02+lx4/zEmrZbz5KsAMDgXmZzuEH1ezFBkcaoUvZCmG0gfBbJ76h
 xp7Q==
X-Gm-Message-State: AOJu0YyVNoOTH8F36tnOXmhsfupO9MGa0PCMuSX6hxhEsHWaqxu1FHUo
 ee/6N/d1XaykMkHpFhVFwrJT744hng+6JERCyeESKNWvbwwQ36TnbYvCGCuCd41D/bs=
X-Gm-Gg: ATEYQzxC2sh9deYmaDmxc2S3N37YA7oRv+7NP3Ok9FmNrhhlgJPpygQ114kFGI0dMBQ
 Q/YnGeU7eBAipFVNQ6xawhg5oiibQekNPIDWAq8nnaRKAb0dwLas7Ooh+CBXzvMz3YHkdziPsLf
 UqsZFBt/9KroJUBUQNFucMN8Qh9w2SPyHADQDrNcp8XN/UJb3cNFPg3CBjuStaHIUgQ6MRicXW7
 4Eh6GUg3G7xShrXYcCDqTu8uhpNuQj4pc+4tBypErm6gNWIjv7Min9St+105HYeqQGc5HTxX4Iv
 L/c9nASHBJ/u+G02rFXSbe33XEtD6Fyq7K3NmdVAQUNOzUO9OZ7FdXfXk2VyyWXz+6bIj/XIKCZ
 /vnZuMNvOhIv4Y9tbBNXQPecmwt9xC7NWLUbvVMphN2JDUzIU1sNLhY6QhtD5PuE1clS9qWeXPL
 Bhb8FH0c4rXtIJ9Yo1Ea6RqUIKdcUsKmV3AfeMrbzJI+ylNNfB02hxcEUDUHwn5RMYD1CjVCVf8
 KrvaDelLilPHMTrmFLD2iccQBbDpzITBRO1GkrJgnrTi6OgOFTrMqpaBx6VobyBEEhO3d1/Afm8
 +mmV1Ws=
X-Received: by 2002:a05:600c:3545:b0:485:41c4:e2e4 with SMTP id
 5b1f17b1804b1-4855670513bmr306935825e9.23.1773757456377; 
 Tue, 17 Mar 2026 07:24:16 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48556400f76sm125425675e9.1.2026.03.17.07.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:24:15 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 17 Mar 2026 15:24:19 +0100
Subject: [PATCH 01/11] power: pmic: mtk-pwrap: add MT8195 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-mt8195-add-ufs-support-v1-1-7d731ec438ae@baylibre.com>
References: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Add mt8195 support.
Support comes directly from commit e88edc977b00 ("soc: mediatek: pwrap:
add pwrap driver for MT8195 SoC") from the Linux Kernel

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 3e3a691d9e8..8ff6458a5f2 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -276,6 +276,23 @@ static int mt8189_regs[] = {
 	[PWRAP_WACS2_RDATA] =		0x8A8,
 };
 
+static int mt8195_regs[] = {
+	[PWRAP_INIT_DONE2] =		0x0,
+	[PWRAP_STAUPD_CTRL] =		0x4C,
+	[PWRAP_TIMER_EN] =		0x3E4,
+	[PWRAP_INT_EN] =		0x420,
+	[PWRAP_INT_FLG] =		0x428,
+	[PWRAP_INT_CLR] =		0x42C,
+	[PWRAP_INT1_EN] =		0x450,
+	[PWRAP_INT1_FLG] =		0x458,
+	[PWRAP_INT1_CLR] =		0x45C,
+	[PWRAP_WACS2_CMD] =		0x880,
+	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
+	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
+	[PWRAP_WACS2_VLDCLR] =		0x8A4,
+	[PWRAP_WACS2_RDATA] =		0x8A8,
+};
+
 static int mt8365_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
@@ -341,6 +358,7 @@ static int mt8365_regs[] = {
 enum pwrap_type {
 	PWRAP_MT8188,
 	PWRAP_MT8189,
+	PWRAP_MT8195,
 	PWRAP_MT8365,
 };
 
@@ -796,6 +814,7 @@ static int mtk_pwrap_bind(struct udevice *dev)
 		break;
 	case PWRAP_MT8188:
 	case PWRAP_MT8189:
+	case PWRAP_MT8195:
 		pmic_children_info = mt6359_pmic_children_info;
 		break;
 	default:
@@ -867,6 +886,17 @@ static struct pmic_wrapper_type pwrap_mt8189 = {
 	.caps = PWRAP_CAP_ARB,
 };
 
+static const struct pmic_wrapper_type pwrap_mt8195 = {
+	.regs = mt8195_regs,
+	.type = PWRAP_MT8195,
+	.arb_en_all = 0x777f, /* NEED CONFIRM */
+	.int_en_all = 0x180000, /* NEED CONFIRM */
+	.int1_en_all = 0,
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_ARB,
+};
+
 static const struct pmic_wrapper_type pwrap_mt8365 = {
 	.regs = mt8365_regs,
 	.type = PWRAP_MT8365,
@@ -881,6 +911,7 @@ static const struct pmic_wrapper_type pwrap_mt8365 = {
 static const struct udevice_id mtk_pwrap_ids[] = {
 	{ .compatible = "mediatek,mt8188-pwrap", .data = (ulong)&pwrap_mt8188 },
 	{ .compatible = "mediatek,mt8189-pwrap", .data = (ulong)&pwrap_mt8189 },
+	{ .compatible = "mediatek,mt8195-pwrap", .data = (ulong)&pwrap_mt8195 },
 	{ .compatible = "mediatek,mt8365-pwrap", .data = (ulong)&pwrap_mt8365 },
 	{ }
 };

-- 
2.52.0

