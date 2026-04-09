Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0ABF364B6
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 20:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 824A784154;
	Thu,  9 Apr 2026 22:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="gxtcEoXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E20883CF5; Thu,  9 Apr 2026 22:32:00 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBC5E83CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 22:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-464ba2bb3aeso764420b6e.1
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775766713; x=1776371513;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HJNTH+IdV5MnBWRgdyE//pLg1ulj3fSydNceAS4hmX0=;
 b=gxtcEoXEbyex9wa3cmJDx+DHSQ0Sg/OAA6FfAmhf2ygiPVkgRYiFf0/nQ8g4LFXg1a
 1JS9fNnjAKXJwVVFQ79gLTtJ4Psr787EEf/NI1jnKeFHGxuK7SZyJ2J79cGNpQ1JFuyn
 izd526bN7truRCchdKRS7Jx0CH3aWZIxCV6h5mJaaUhMTVGJfn1HBSSF4za8XzQLIvGj
 YoecRojM+UwglHvlOx1VJmY6IJkFVopcrH1wKydscbXI4gf77X74G+XqASFfJTTqJWkr
 Fo10qUWzzFnNHNswkcoVG7Fhti8MgQQwXK+yLLoFNdpthr9c26/S11CNRfCRFjqZUeVJ
 pMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775766713; x=1776371513;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HJNTH+IdV5MnBWRgdyE//pLg1ulj3fSydNceAS4hmX0=;
 b=GJhH20lyPHj5WoEC3jIbU8Aw+scP/qDOWVaK1oAKIrIUhavsWc3ESGAzvDXhoq652S
 ra1cABI5tXfDv1Hr74eP0UrBYR1WT1QCw3h1eNaiQznZhGcT8NuqY093PsHD5M2iNveQ
 SKcp8XDqvzb2vSzC+KGjfFvOI+xX9Ogxjyfodj0G7k6XyYGLpFtuuTbWFnbv6VYRXKP4
 3tzqGLdH0sjxm8SPLyBZS02YAEzBgrZzbqZPlKlxHUlmcucAFHygtzm5Jt1CmzkwmH3+
 miiid4/q2gybFazGw4zb8VAmNqllxVdYdATCHcmbY8Ti7caHz32Fy1n/JklOSb7YXjcf
 GI6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBYbuAy6acZBJcdMgzu+JS/iTiLXPLEYMTsygIIkH5uYuFHGycLzxKpNKQo33MHok3bzaJc/8=@lists.denx.de
X-Gm-Message-State: AOJu0YzdEMKA+TbNK+H81tf5rQyPl6ingUppOwBlsi/qmIKYQFRItutL
 FIKk339WWLFyp7xvXVACSIHIkxGH6c+3FRZWzWwDy18nrmnSXC+kY5zMdXDoVGVQENo=
X-Gm-Gg: AeBDietTpVIxGZ3j7fl6R35ssJwP+LOivWvMg4AnoAbs1DRwGqQfQ1OQbum3inkwaSo
 9sHJJg1G0x3N4o5Si7H4Lg24E+F/F5eEM45hYivpj68tUXWVIxF7G/i9Dy9YqLO2AGmXexYDGNI
 mckOWAGs8COFekMSMvVdz+lnAg1OmGwCq/FHjW++/W7pA/7uF7Q6hUGFDHaUSy55vAIQjTX5sbP
 lip3NxYEUz7mawc1qaBNdN6PgDOe7tZfSGvds5si5dtfP7HRwwlPbihwn/1YAKFk3vCOVaRMcWO
 aCIFj8+zzwuOlZCcwcNfwx6mBZdEdVr5fAXZGhhvZbwXhHr1qCDt35CvG25LClLt/PusNu3y2dl
 eSd0E999dRkj5NJpRsdzHsOw9JGQ5A4+65aE1xkHtX7RldMmbG7WeHAOGZpRtEMdmZnVivXAA3+
 G+jEwlqE4PKzgdB6JTxesJJsbqC+bZ
X-Received: by 2002:a05:6808:3095:b0:467:da0d:537e with SMTP id
 5614622812f47-478b69b77e4mr136064b6e.7.1775766712642; 
 Thu, 09 Apr 2026 13:31:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a548:cf0c:d054:fd01])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a101b75esm293075b6e.6.2026.04.09.13.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 13:31:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 09 Apr 2026 15:30:35 -0500
Subject: [PATCH v2 3/8] power: pmic: mtk-pwrap: add init capability flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mtk-pmic-fixes-v2-3-73e83aa6345b@baylibre.com>
References: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
In-Reply-To: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=igRoS02hI5x6XRIulhM6vY+UmhZJmfbsSIpeu6V78tU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp2AyL0zs37UI1XHztHF0rtSVyMYAOnyJvrJpyK
 zegd7FUqsKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadgMixYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AlhAIAJcW5kt8PhalDbehfvdvvWogZerA54NDCZsvXnj
 m0A+d4Qo9MdgwtTgJDCzeiEXLMJmIIBfgzlp4okBnx9koE4QnueOCMm0FP0Mg35jIASY0qIMz7D
 6URByA9S6h4ZEWejbJ+maE9tbdGlevMfnMmpoDKdBed85nHSM0XkS/c0zuTO7nzWtEdwOnkkhLE
 A5vQBxTWgI2eSfMpZqWGQEFmB6Jp8niFPFwIbpqO/mMm4epHGOnHyPQGrALzG2qm+iGLpwaeSUs
 hsP7PHeagu+zBxBE21tI9RdOujkBjeDfiS5vsXvx2Zvhcpe2iXXt9ULTgYsHZFGOO3EO3AlF/24
 UVFc=
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

Add a PWRAP_CAP_INIT capability flag to specify if it is safe to call
pwrap_init() or not. Not all targets define the registers accessed
by pwrap_init(). In that case, it is expected that an earlier bootloader
has already initialized the PMIC. If not, we now return an error instead
of trying to access undefined registers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 3ed21dcf2ef..38ae44f0abf 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -63,6 +63,8 @@ static const struct pmic_child_info mt6359_pmic_children_info[] = {
 #define PWRAP_CAP_WDT_SRC		BIT(4)
 #define PWRAP_CAP_WDT_SRC1		BIT(5)
 #define PWRAP_CAP_ARB			BIT(6)
+/* To implement this capability, the registers used in pwrap_init() must be defined. */
+#define PWRAP_CAP_INIT			BIT(7)
 
 /* defines for slave device wrapper registers */
 enum dew_regs {
@@ -735,6 +737,11 @@ static int mtk_pwrap_probe(struct udevice *dev)
 	 * Skip initialization here in this case.
 	 */
 	if (!pwrap_readl(wrp, PWRAP_INIT_DONE2)) {
+		if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_INIT)) {
+			dev_err(dev, "initialization is required but not supported\n");
+			return -EOPNOTSUPP;
+		}
+
 		ret = pwrap_init(wrp);
 		if (ret) {
 			dev_err(dev, "init failed with %d\n", ret);
@@ -877,7 +884,7 @@ static const struct pmic_wrapper_type pwrap_mt8365 = {
 	.int1_en_all = 0x0,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
-	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_WDT_SRC1,
+	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_WDT_SRC1 | PWRAP_CAP_INIT,
 };
 
 static const struct udevice_id mtk_pwrap_ids[] = {

-- 
2.43.0

