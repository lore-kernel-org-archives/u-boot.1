Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278E4C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 07:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC1A88013;
	Thu, 20 Jun 2024 09:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="deooOwXW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE8D87C83; Thu, 20 Jun 2024 09:43:12 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CA0987F3F
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 09:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-421b9068274so6744165e9.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718869388; x=1719474188; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FDDH6W1yI8NI4YqelULBhfcX0NinRTSGgqj9ke2z5fw=;
 b=deooOwXW3TyWY/tE7L+P7AIgxGTKqLqy87+pFhBdJH/of2uErdDcqyVmAiUr5MtCBB
 45gwQKYxB9KJ4s2J08XY3fVdCdZtpPUbGAMi9ZvDBhRq8x9HogSdr3VI721Suj/bx6tH
 QHVPv80eB+yP3Q2KqLe0vGg0hpiTHDk4+vcSvkgnrESlcJTsMNq9Kw4EzHMpnFvVCIKT
 rlL+ek+JIZSYSLsoO/v0hVe8VvMHkM9dtOqmU+3bpOWQHkvPSCWRRAqJSzuDpQvuI+1m
 fkETRqaKCZAcHD8ocmYnHV6/SHXoE69tV/gSjVfrq2DyrsfcqBA6zuzcnQTMa1gGEoV4
 2ZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718869388; x=1719474188;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FDDH6W1yI8NI4YqelULBhfcX0NinRTSGgqj9ke2z5fw=;
 b=TAeXItvY9+zJ7y11FvvCHwiSWtLZGFoVsVdbBgNSMg16niwZufUcC9bMVqV9JLUd2y
 GqFkCkm2nITy2XJglBwfB5qSrx1NBGB6g8+QeDKlm6hBSqHFqKPCGNWrUZR8wQFUjAr9
 I5WzdUDxPbMj2ANjWcok8gAtI8QDCymFxQH7zYQc+sQ6IJkHsoo6OHYgOZddc1NfoKEa
 z1Nkq8P/+unwHL0Dfncf3n1VekWrQ2tXE3CSf1iUetQUwZs3FjHuiKAqRTOgR5Ug1atf
 LU/R8zq74oDW072Fqn6tKPgA2aH+MhjRnu4nhf5j6LHVcDyTwrdpxIbRwKa1MaAu8Gve
 Pkgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmu9CzmKubkKqS09JOMWAJIRQFKLKhYweViODvA1Be0XAbaFkdwIk5epFeosjS7mzE22s5Kh6eXZcd5qNBAUifoKauNw==
X-Gm-Message-State: AOJu0YwAE4yDlsVHkMUKWIKdEaQTbyjsFYl/k4WtFzp8kOby2z2wpunX
 KkxDnvjeOZQM+CZT0uPUS2NsNLlBIL0LYo9y9ve4lYc+muaf6jj0ERTK5igQJIE=
X-Google-Smtp-Source: AGHT+IFuZPiJdS7+bsHAg8eP4mr2HBiOTNyD4jjT3flArtUqMKnFD5afdjg4Ey4iS43n5RKZiUWaEQ==
X-Received: by 2002:a05:600c:1d08:b0:422:4fcd:d4b3 with SMTP id
 5b1f17b1804b1-4247529f03cmr31522135e9.37.1718869387591; 
 Thu, 20 Jun 2024 00:43:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0b6402sm15506785e9.10.2024.06.20.00.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 00:43:07 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 20 Jun 2024 09:42:50 +0200
Subject: [PATCH v2 1/5] phy: meson-gxl-usb2: add set_mode callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-u-boot-usb-gxl-phy-set-mode-v2-1-b81c027bc02c@linaro.org>
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=IWJf0JYlcNf5Di+OmZ8xUtR2HrzmkAk7v7H7DdmZDZE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmc92FbQJ1hDAvd8TBFcIQMBelkib766wFy9HIvJ66
 nkO2eV6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnPdhQAKCRB33NvayMhJ0doHEA
 C2oIVpgGSx/ONK7UhrvNkc0MegEPcaanVPO/wYSfrXrYIxhMArRqWSOtV0Vh6b2rHiy8QSkLKfZP5i
 /dFe2lDHrl7sT6jmNzmui4ik6Km0PgWobAA0zuTiiy7Q+4cz02yFSwrQgxp0FD23T6VB6sPU8pmQWZ
 54PuJLrD3J8lg1dLp5foE21MlPM0ihC2EttLwGFacBtSAmn1HNwXYWGqq02FTcppjTZ//PaFgRhliy
 T98IDIBoGbUjmYqLM3a1J/3MiZDDSfcKmC5Betwni2w7NkC093I0lDpmueOlR+dhWBWEH/c9yNPmMD
 0PLbk0wtyKPLh5wcCDAvCP3PdDqA5EZvMfXZd4VhPAASF0JnbdDPgacSMj1e01Qcc67VAI1C5eczJd
 WWCbjHL4GOQ0JtqZNS4ATZJoWt+77PDTJtUBtrRPGNyAyjo2L/C9gSxMjZL8jQPRBEl+cu/3Rf+AC4
 Iclo6R7hF88dIwMmnyNlAdWZgBoIkb15uC+PsU2rt7xDc87zqXorxdN+nkTQvMxuenK2d+WnJlXujw
 MVOd3gSoKm+Jtk4KCtZdwJxgJoUy87WUDXVX+uCSzRi9PdrkwaWt3zSvRuPma5L4hyuhSRapp0EmFy
 XteXzFtZUwKcl6SqFesbwkT8GdmoUtlmMUTlT2TceA9ufCwdxUQ0RkPho8ZQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Implement set_mode callback by calling the current public
function, use a temporary function name that will be removed
when the public phy_meson_gxl_usb2_set_mode is finally removed
in a following change.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/meson-gxl-usb2.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/meson-gxl-usb2.c b/drivers/phy/meson-gxl-usb2.c
index 92c285103c..e051e66224 100644
--- a/drivers/phy/meson-gxl-usb2.c
+++ b/drivers/phy/meson-gxl-usb2.c
@@ -150,6 +150,28 @@ void phy_meson_gxl_usb2_set_mode(struct phy *phy, enum usb_dr_mode mode)
 	phy_meson_gxl_usb2_reset(priv);
 }
 
+static int _phy_meson_gxl_usb2_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	if (submode)
+		return -EOPNOTSUPP;
+
+	switch (mode) {
+	case PHY_MODE_USB_DEVICE:
+		phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_PERIPHERAL);
+		break;
+
+	case PHY_MODE_USB_HOST:
+	case PHY_MODE_USB_OTG:
+		phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_HOST);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int phy_meson_gxl_usb2_power_on(struct phy *phy)
 {
 	struct udevice *dev = phy->dev;
@@ -161,7 +183,7 @@ static int phy_meson_gxl_usb2_power_on(struct phy *phy)
 	val &= ~U2P_R0_POWER_ON_RESET;
 	regmap_write(priv->regmap, U2P_R0, val);
 
-	phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_HOST);
+	_phy_meson_gxl_usb2_set_mode(phy, PHY_MODE_USB_HOST, 0);
 
 	return 0;
 }
@@ -183,6 +205,7 @@ static int phy_meson_gxl_usb2_power_off(struct phy *phy)
 struct phy_ops meson_gxl_usb2_phy_ops = {
 	.power_on = phy_meson_gxl_usb2_power_on,
 	.power_off = phy_meson_gxl_usb2_power_off,
+	.set_mode = _phy_meson_gxl_usb2_set_mode,
 };
 
 int meson_gxl_usb2_phy_probe(struct udevice *dev)

-- 
2.34.1

