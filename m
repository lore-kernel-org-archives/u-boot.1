Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD64C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EF9D88506;
	Tue, 18 Jun 2024 09:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O1RqK/II";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E43A5884DD; Tue, 18 Jun 2024 09:55:35 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61062884FB
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-361b376236fso381743f8f.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718697332; x=1719302132; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ng86sJ2ghzSyCipipXjg3ALFwIc9lDdOQozhclnwpHI=;
 b=O1RqK/IIkBZ1+bwOMmXsgfbmHmAom8aP4CrHRSqP261UJebhcXGKYpkXN8C38fZMhZ
 APyMoBs+xwbgIL4Xt9ZFIXkfhsYpWDKy2Ozv/yVgXNKAP8zoxzXaNI7swyoEq8ldo+AS
 w4eO5JkWoe/uGjpQaf41VhAg5RV0Dtv4ToRArM2CFrYdktFPQE9FeCSGnDIofbtnAWWT
 Xl70b2nxavYWSYIMgu11E+DjO05qvqE8FYI1wfdUu1EEalPs0kncSS3yG2CNKAqBfCoX
 2a1DlHOWyerW02RLq4Pd1in/J2zR4H1nUuyfjHnIy0yU7gfgi/3N52ytNu0R7URTHU9L
 +lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718697332; x=1719302132;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ng86sJ2ghzSyCipipXjg3ALFwIc9lDdOQozhclnwpHI=;
 b=ZDCYeBlMzS845BDaDxzoNB+o5vTMaMd2ywe7gYLLI62dazJYRoF2lHu2w0kELcHZQL
 9EZtdsIMhNjaMGUy9kJmNopg8ZmuFOpfeuFAilGCwKJxnqvqSNghhEymSjKkc+wD9fFB
 BYPb7F04ZNJ0qK7bEkgPPVzNfebo1a4oGPuMr54UgA5w2fUYStOVICzLmsCvemqb5DLs
 pvjk4V+D8mJf4qxMekMFEv65GIuCAW83DNCHoTrFCjBcZvPExKhb09BuVRh+jeNGafBW
 aF5n3Pop9PHg7J6RcWUyuKG8++acB4CCwPW3FCuFu8/k8rl/wY/wqCSqCcZpAhyZztRX
 5NSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3jcEr0pmv1iiZOyhCNNfNLakMNOyavgo4QfYtkmnEXTVsOZos7IG3yW0LDptpkjSraxtecEzNVyTYX7n6c16hpLzThw==
X-Gm-Message-State: AOJu0YxVRwY+Ng8Vm3xn7pZoaU+zhXwAtBlHi5H5TsBsfXAnB2QG1aSt
 cCSpn9/tt+C/QBY1whewL3pU68ifZoueW0jji07z86jgcobJcHqoGvLHOTeFxv1sRNHEfcX/493
 qujk=
X-Google-Smtp-Source: AGHT+IF3+MFlbe8WRPl8wVcUhh9+j996lJz1oFd8QJgHy2Xr5j7iGptdYQzdmpJjNqWFNWAk/CRuXg==
X-Received: by 2002:adf:ed4a:0:b0:360:8610:f65c with SMTP id
 ffacd0b85a97d-3608610f701mr7147414f8f.2.1718697331728; 
 Tue, 18 Jun 2024 00:55:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750934a4sm13523173f8f.10.2024.06.18.00.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:55:31 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 18 Jun 2024 09:55:25 +0200
Subject: [PATCH 1/5] phy: meson-gxl-usb2: add set_mode callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-u-boot-usb-gxl-phy-set-mode-v1-1-6b41efa46e35@linaro.org>
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
In-Reply-To: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=QrdXQDAZOcLlaK5yVj7NQO4xP3YC9Lve3402Xe1o/Z0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmcT1wahIGV93lln4pALoceMgxycK4q4efdD1Tb3Sf
 2UH05sqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnE9cAAKCRB33NvayMhJ0a7VD/
 93Bh9V2JqZnPEA+egLwNCqMtbUxPHoAXfB8lV1pjto5BDWPLz/rNzbmSgY+i6Mzkhazhol+5BXEy+p
 Md+oLtv1RjcsOj9X8JmB1S9cKU6h2T46uUGjQNZE0h3xcP1J9QsTFySmxbSPcaLthVPp0VKiPQTFb2
 IYr1ZnXSgqW0OU0kkEU8KiK9P/sRe1EQ8uGyh/0pt1BRmhQsjRvc2nld2E8FwX/bnC1x1aSOCJuzzs
 NlkGNYNBawte5VsnxjD9eF39QNuXdEpvFkNR94mdOXYcTVLEsibWmkw7dk+ojxEB6vYa0kERSIj8mJ
 dL40+2Ll/vXDhQZCp930phfQQUFDxg0IEqFSqi2RK8MNJvIekCLKRk9+0RkawDH7ywiqLSoABrycLI
 7ojrPv2SRFBWvFMnvl/g+u3sb43x2XJbKhr5FMHY3UgNTthVW1JZBglf7IMJh9oiVBYF7D1EOsv9Rx
 UApqWTToU+AF34hZCSokN2yYUiOd15nq7vjZFRrbP5bmGfrd9Hp9eFe0QtDLRwnSqxJyYRhusxyq0s
 hyJgRoWEVYHWo7+wrtVqlLb+1D45bVVl3GnNafY+y7bn9bn0H3pwq12I3RDQlLmYszdFHvdJzuJ7Vu
 yg5RYGv8AyPqkrDzLNr/JlSVxa88AXP5rpxV+rjvbiq8c+4vz8paGr+LMmnA==
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
function.

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

