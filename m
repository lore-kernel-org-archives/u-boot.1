Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDEE10F2865
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 19:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8636383E7A;
	Fri, 27 Mar 2026 20:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FooYdm5O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0E3F83FA3; Fri, 27 Mar 2026 20:03:53 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA19783FA3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 20:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4043b909ed4so1553321fac.3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774638229; x=1775243029;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OIeg3g5Z8Wjbu5L+d2hD8fx43wujEDiPF97pOFYV6x8=;
 b=FooYdm5OI9xMUA6Cm4vLFlnPSm7Ao7O6cDticOJoE0w5Ftjgf4ShMjh5kIbyYnQQ+N
 VhUzUY5tg+8WUlzcRiF2pgVVQR011KiIcjqq9ptkfdtJWYZ6zY8vqvqHQ2/LHV0LGeLp
 MKNbLTmNFC5qZFlH+wj8kYZpoE3NaP4eFRJwy9piPXDq9dHVnY7AEKZVRtkiKGvtUvU/
 cnoI/WjhNhrn7Nqo/eCG9XR0oiKJCBSvP9lpj8AHXBuBxF6rDFjQ09Lchaa0TGjvaXZi
 KSbhef3PAtO+WbxNmbVD/AOktNJx8bwi+RAH7Cvbb1lr5vBAXS6dKWQmj7BBLm/yhwPf
 jnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774638229; x=1775243029;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OIeg3g5Z8Wjbu5L+d2hD8fx43wujEDiPF97pOFYV6x8=;
 b=jyunt+cfguWhYta+XkGSfGGND4uRa4uAIqXE5GXTEf84jasFGdE97NpxbZW0YK9Rm/
 Y1P7RGlDJwhShTQkUrPSPPrQBDgdeTt20hL9BobAeSAVOW0ECi4Sr8bUdj6bV4DPPorD
 RXZeMtAZGJyLUdwDdweyLuZviRw0p0qUXO8ttJlwx5HntGep4b8BjX6sitNag+LEBKFk
 vRBuL7/IAze+AO4/ZNdmM+szGZg6RV3MjsC6rYn3aUMWlYUbCJLxFeIooTeCfB21QAWU
 Vt+IhG9SLizNCp8YFDnnRvcfmnXSe5cBHfwUGiJYGrhMepwIA1SeoAViRP8ATq6H7M5B
 FvmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ5Bd0cOqlqmezxqpy5S18MIlJce52Egn/1kXjLORXOVKMblWMDY1VXU2+DRgkpRJD/Vhio/Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yy88tSuNWaMY0IeSGoyYzgoi82wopx5lSPfiKyRzrszTnTZMq8W
 TX0noGGYniM3VAOIuK+2yIqHv9oO+m+ADkRXzSBRZepmTf43ADXQZ/UbYdm4I3Q7LOA=
X-Gm-Gg: ATEYQzy6imvxRTETw2RH6kzFD0p/0zCZkOPHOiK1suSELl3SExyMIer6QiC9M1nJyLY
 V5rzFzc/OzIW0qc9pALb/oKiuPQXjhryHCvY94PhhPYK5YQBfsgAegL/cwMJikEEVZVhA8dy3bb
 eDxmJj8g37EuTdnQoW6y5or0QYXzhxa+yBZRfsozIV3y0gc29G5yX2Xz98JPFKroH0LS3p7ujdD
 tsQZfI+KW9ieDX6zBzecdLt6TFiyrGDmHTwlVsy38EEmX2ZQjTzITh56Dh/tqeCu1Qnqf4k4pMR
 1bcgrXEp2RBlpfwM4rJWGbBs1ry6iKvrccsh2KZK//5gXHWW4a8tCD0Z/+3t5H7wu/ZVBBBJClI
 6QiyPi/gRZ05VAdraNrVuoVHtXUqdSA86TPbJykqLcsULiteTWVdzgKtOpuMZ2XUeMx5sUTgDqI
 F4cJ6yyA5ZHCj0EFe5GVGLOt5ryuqx
X-Received: by 2002:a05:6871:4096:b0:40a:605b:518a with SMTP id
 586e51a60fabf-41cec2f98f8mr2031826fac.27.1774638229314; 
 Fri, 27 Mar 2026 12:03:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:54a7:4cbc:7d2e:3b99])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d0496591csm113534fac.8.2026.03.27.12.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:03:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 27 Mar 2026 14:03:17 -0500
Subject: [PATCH 2/3] power: pmic: mtk-pwrap: add PWRAP_CAP_WDT_SRC flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-mtk-pmic-fixes-v1-2-ef874ca82409@baylibre.com>
References: <20260327-mtk-pmic-fixes-v1-0-ef874ca82409@baylibre.com>
In-Reply-To: <20260327-mtk-pmic-fixes-v1-0-ef874ca82409@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2109; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BqcKn/pjrlMLvGmGZhOofsWlOYusZcCot4nYBopkCmQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpxtSD4G+vrsVgl6JGwXP2Sfdrt91mwli+u74W6
 fjh6Hdz+x6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacbUgxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AJr8H/RNI9igGUjooDN9t9fy6s3JXdNL83VJA4DEeb2b
 kW47p+vuMVykx2KYbfnY8orohyiKKHWmGFvNNZtPDYa7F3iHjkqGWparX3S1PjGANwRXf2CmaR2
 wGS7RoE41phgZcGzToJY2OgijrsNqmpoCAPc0Ew2Ny/TgkA5eVZosIxIGq/0VQKRKfWy5jNiyg8
 psWFLAnSwjylQ+9Cx1FybfELaMrtegbGuA3XyZOW5LdyDJcoDzcmKbmHZmmOFFTgOzCfNzy+Y/A
 QFgMo4WuIiQ4NdyYCP5VBwjTySlDQCg+U6C9Et0s0noJS1XWJkkwaz91sAsgYtFg3KN8Vnv5iMP
 be34=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add a PWRAP_CAP_WDT_SRC flag to indicate if a PMIC wrapper has a WDT_SRC
or not. Then use this to conditionally enable the watchdog timer.

Prior to this change, since the register was not defined, it defaulted
to 0, so the wrong register (DONE2) was being written to.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 9ff06fdb3bd..d8498646921 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -60,10 +60,11 @@ static const struct pmic_child_info mt6359_pmic_children_info[] = {
 
 /* Group of bits used for shown pwrap capability */
 #define PWRAP_CAP_INT1_EN		BIT(3)
-#define PWRAP_CAP_WDT_SRC1		BIT(4)
-#define PWRAP_CAP_ARB			BIT(5)
+#define PWRAP_CAP_WDT_SRC		BIT(4)
+#define PWRAP_CAP_WDT_SRC1		BIT(5)
+#define PWRAP_CAP_ARB			BIT(6)
 /* To implement this capability, the registers used in pwrap_init() must be defined. */
-#define PWRAP_CAP_INIT			BIT(6)
+#define PWRAP_CAP_INIT			BIT(7)
 
 /* defines for slave device wrapper registers */
 enum dew_regs {
@@ -780,7 +781,8 @@ static int mtk_pwrap_probe(struct udevice *dev)
 	 * Since STAUPD was not used on mt8173 platform,
 	 * so STAUPD of WDT_SRC which should be turned off
 	 */
-	pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_WDT_SRC))
+		pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
 
 	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_WDT_SRC1))
 		pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN_1);
@@ -912,7 +914,7 @@ static const struct pmic_wrapper_type pwrap_mt8365 = {
 	.int1_en_all = 0x0,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
-	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_WDT_SRC1 | PWRAP_CAP_INIT,
+	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_WDT_SRC | PWRAP_CAP_WDT_SRC1 | PWRAP_CAP_INIT,
 };
 
 static const struct udevice_id mtk_pwrap_ids[] = {

-- 
2.43.0

