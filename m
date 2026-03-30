Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C181061B12
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 16:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E59284020;
	Mon, 30 Mar 2026 18:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bFtY7GbJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F8CC83DBF; Mon, 30 Mar 2026 18:01:37 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB0C83D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 18:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-415c8a4d2e6so1898272fac.0
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774886493; x=1775491293;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rd2kA1ylBFH8pDHIzigw3tF6Q9FwVnQOJZggknq3p58=;
 b=bFtY7GbJELi09lsJCLtdiY0S2rb2+M0UdMyhH7FbpR6ZMMWatlhP13mlB/VySq/KUt
 l9c5AJfKyrUySswXNmQvPzgB2zsiBPObQOGHbh7FVUumFi1eBF9MLfbQmdM+Uu5rdlG4
 pz6E7j0c7ACP1/5sSckANOHGfWnaEr74faGKLOBWZbxazJW1abyrv9MfTCLkIJrxaUH9
 WKbyN6NhPYEUfb4o8R7UTgjB0x6hIxddGhPVKEs0UYRebcvYwWGgEQSGLqhBfMaKaZY9
 uQNVXuCdKZM9hSB9zdW9xqk++WFxPDRrgHrjikjijV5pmpJG9R6VT6Y1HckGNj1myyAs
 J8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774886493; x=1775491293;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rd2kA1ylBFH8pDHIzigw3tF6Q9FwVnQOJZggknq3p58=;
 b=SL3PqWE+XNIN9Rv9wVphSNutYUFxA/AAfQhuuQGNkN4rpPHD7Mpz2CfK8kZ5YrRlBk
 GhrCoFCa3+MtW9NqU4UQI7dMWZMNpTkwhdhkf6oGAWZrzwR8GloGLaxcnlL+wxSJsoEy
 OrWkYeLDTDwFKud+etL9xwJ4MLtB/H1fpDtul7+L5AnWXKXRZnbIC/XXe6giq6W2Eg9n
 O/vvFPHzTf9M0lexcxu5zYO9SplM2z3N0iihiW32CzqTtcO7NS6shpm5guTiVluxKX5F
 5Ngx4AMWqqMbBH5RyZQUnv27FNyuXJHJ0Jgp8LdbHRP7k9DDYqV3srF8nGKvP2rVlHnF
 xvYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO2z27hCTw8V1yIJKLs4yvXLO6QfMI6KAq64QvvNLm/ZLfheNaOHPXoCCCkDg9awUaLNOXEo4=@lists.denx.de
X-Gm-Message-State: AOJu0YxcTGDG2PDKoLXrj7BcA+R2cyU05RWlIzEdKI/c+KpiBc+O1aja
 Aarzrg18ViJzRaZCA1Myyr/VZfeAJGgfN5GlKJq/o0baQ7mXzTn0HdN0vH3Xvamxyyk=
X-Gm-Gg: ATEYQzz61ikDyuNNxIHnS9D1JZjtcPDbQ9XvKNqwTQ/VlDBKQhuvlwUqqS+NppYHwbh
 zL+ckMBBPwcZ88Ds2HsknVmeKReBRMZcFy5KApqAo5KKO/KG+N1WQET8t3xEFe0yqlvrFIEvfuP
 X2DmE60k6Skt0pyhUIjIRnmtTplrTPGWlm0iiiefQeIIFeEuDSrEfw4XEID1bVz2OlYIMPsVBWy
 X7KZd6kSfCzprHYY1qp5jcc+VbfUo0C04wSxm+LprgcJ4Mn0cnWUFImfNvKYnC9RAks/FOPrpqP
 rvwbdbr9unST8UfnvgxuDLmPWqK6fGWhh6xye5GaoMlRKg7vX8JfTDlLH3lCsiaX3fET7qA+wS0
 EXm2ftYHjaKdAeBoNSQCVPMXOvi5xG1OtbPeLp4AN4FgqhYTrCeKMNNbFr/MMuPTJ49wJcdYlha
 VEeytVWA6VUetX/YTDrrN+IEnrWMpI
X-Received: by 2002:a05:6870:158e:b0:417:5c29:ace7 with SMTP id
 586e51a60fabf-41cec091d3amr6734535fac.2.1774886492237; 
 Mon, 30 Mar 2026 09:01:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d048e1984sm5432952fac.4.2026.03.30.09.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 09:01:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 30 Mar 2026 11:00:35 -0500
Subject: [PATCH v2 3/4] pinctrl: mediatek: print bias info along with
 pinmux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pinctrl-mtk-fix-mt8189-v2-3-05a737ec623d@baylibre.com>
References: <20260330-pinctrl-mtk-fix-mt8189-v2-0-05a737ec623d@baylibre.com>
In-Reply-To: <20260330-pinctrl-mtk-fix-mt8189-v2-0-05a737ec623d@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4889; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=s6Gh2igH0AAVgVmaruwgGpMOUkAwlafwrW2NZp6Iido=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpyp5JY7zpFTZlz6J+gTeXMDs1ZHkP+Z6nGgNkj
 PWbJfRs/fiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacqeSRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A1O0H/RPVWm7NoMCKl9kD60Xw61eusKNv0x4x3BTS208
 xDkSJoIlvui37cT2zm7LwwPuzbOzuzp2//4QjJ1kSGRK/u/wh5zXUS4D395ihwQC16QfRutX3rR
 QVk3UJ2szICz2LPVO32C2zJTGjrfaqXHYSdHuLXmbpH8JPgxye7oUFi0LkzWOn3XxkiRoyWzyBK
 U5EPehCoX7QiUE2AnqAv9cYwRoVFx590zFrgs9rhbo77rjaBGSDlWLu7MIJeGNNzWD5SzsX8+b2
 IBL3vuQoR/Q6fkBgEK1N0aElFcnX66STIBXHKS/o7fRAOyWpq8pLVrBzQwnM4/PvR56Mr2Lv6MX
 v9Dk=
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

Add functionality to be able to print pin bias settings along with the
pinmux setting.

This can be useful to debug why pins might not be working correctly.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 91 ++++++++++++++++++++++++++-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  4 ++
 2 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 1028b8a93f5..cfffbaeef84 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -237,9 +237,39 @@ static int mtk_get_pin_io_type(struct udevice *dev, int pin,
 	io_type->bias_set = priv->soc->io_type[io_n].bias_set;
 	io_type->drive_set = priv->soc->io_type[io_n].drive_set;
 	io_type->input_enable = priv->soc->io_type[io_n].input_enable;
+	io_type->get_pinconf = priv->soc->io_type[io_n].get_pinconf;
 
 	return 0;
 }
+
+static int mtk_pinconf_get(struct udevice *dev, u32 pin, char *buf, size_t size)
+{
+	struct mtk_io_type_desc io_type;
+	int err, pos;
+
+	/* If we fail to get the type, then we just don't add any more info. */
+	if (mtk_get_pin_io_type(dev, pin, &io_type))
+		return 0;
+
+	pos = snprintf(buf, size, " (%s)", io_type.name);
+	if (pos >= size)
+		return pos;
+
+	if (io_type.get_pinconf) {
+		err = io_type.get_pinconf(dev, pin, buf + pos, size - pos);
+		if (err < 0)
+			return err;
+
+		pos += err;
+	}
+
+	return pos;
+}
+#else
+static int mtk_pinconf_get(struct udevice *dev, u32 pin, char *buf, size_t size)
+{
+	return 0;
+}
 #endif
 
 static int mtk_get_groups_count(struct udevice *dev)
@@ -270,12 +300,20 @@ static int mtk_get_pins_count(struct udevice *dev)
 static int mtk_get_pin_muxing(struct udevice *dev, unsigned int selector,
 			      char *buf, int size)
 {
-	int val, err;
+	int val, err, pos;
+
 	err = mtk_hw_get_value(dev, selector, PINCTRL_PIN_REG_MODE, &val);
 	if (err)
 		return err;
 
-	snprintf(buf, size, "Aux Func.%d", val);
+	pos = snprintf(buf, size, "Aux Func.%d", val);
+	if (pos >= size)
+		return 0;
+
+	err = mtk_pinconf_get(dev, selector, buf + pos, size - pos);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
@@ -670,6 +708,55 @@ static int mtk_pinconf_group_set(struct udevice *dev,
 
 	return 0;
 }
+
+int mtk_pinconf_get_pu_pd(struct udevice *dev, u32 pin, char *buf, size_t size)
+{
+	int err, pu, pd;
+
+	err = mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_PU, &pu);
+	if (err)
+		return err;
+
+	err = mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_PD, &pd);
+	if (err)
+		return err;
+
+	return snprintf(buf, size, " PU:%d PD:%d", pu, pd);
+}
+
+int mtk_pinconf_get_pupd_r1_r0(struct udevice *dev, u32 pin, char *buf, size_t size)
+{
+	int err, r0, r1, pupd;
+
+	err = mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_PUPD, &pupd);
+	if (err)
+		return err;
+
+	err = mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_R1, &r1);
+	if (err)
+		return err;
+
+	err = mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_R0, &r0);
+	if (err)
+		return err;
+
+	return snprintf(buf, size, " PUPD:%d R1:%d R0:%d", pupd, r1, r0);
+}
+
+int mtk_pinconf_get_pu_pd_rsel(struct udevice *dev, u32 pin, char *buf, size_t size)
+{
+	int pos, err, rsel;
+
+	pos = mtk_pinconf_get_pu_pd(dev, pin, buf, size);
+	if (pos < 0 || pos >= size)
+		return pos;
+
+	err = mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_RSEL, &rsel);
+	if (err)
+		return err;
+
+	return pos + snprintf(buf + pos, size - pos, " RSEL:%d", rsel);
+}
 #endif
 
 static int mtk_pinctrl_pinmux_property_set(struct udevice *dev, u32 pinmux_group)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 1215fb7094b..bd17964090a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -204,6 +204,7 @@ struct mtk_io_type_desc {
 			bool pullup, u32 val);
 	int (*drive_set)(struct udevice *dev, u32 pin, u32 arg);
 	int (*input_enable)(struct udevice *dev, u32 pin, u32 arg);
+	int (*get_pinconf)(struct udevice *dev, u32 pin, char *buf, size_t size);
 #endif
 };
 
@@ -263,6 +264,9 @@ int mtk_pinconf_bias_set_v1(struct udevice *dev, u32 pin, bool disable,
 int mtk_pinconf_input_enable_v1(struct udevice *dev, u32 pin, u32 arg);
 int mtk_pinconf_drive_set_v0(struct udevice *dev, u32 pin, u32 arg);
 int mtk_pinconf_drive_set_v1(struct udevice *dev, u32 pin, u32 arg);
+int mtk_pinconf_get_pu_pd(struct udevice *dev, u32 pin, char *buf, size_t size);
+int mtk_pinconf_get_pupd_r1_r0(struct udevice *dev, u32 pin, char *buf, size_t size);
+int mtk_pinconf_get_pu_pd_rsel(struct udevice *dev, u32 pin, char *buf, size_t size);
 
 #endif
 

-- 
2.43.0

