Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D52C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AEC188707;
	Tue,  9 Jul 2024 11:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YRjbN27Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1809886B6; Tue,  9 Jul 2024 11:35:06 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B602886C3
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a77baa87743so528995166b.3
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517704; x=1721122504; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O+8pqXRXLD051mzcdY7+rK8584X5K9gASUiVa7nDUSQ=;
 b=YRjbN27YHQtVGjt/hgGEobf+GWyEiHd9OMfhRGsdx+ggImfVsRtyJd+0GbwT98a1s2
 e2iKQm27+lBQCFZrkiWd6OulRrisHYXsB0Gk6mzPeBe/Qo7YzKXWT5poibIKuPQWsvPj
 yu480ENqgNEjz+CajTeJpAPc4Ic5s9RY4l/hI7FjBXDcL9ZamcuMUWEe7TJih+LVz7xB
 /NvO7wLi2JhlSeKJxGbSTT6O1jsrt1LgIkEmdT9ISCZAz50xHuPihJlzVEDPNhdQ6E6+
 6ROaDV+BFJPfAbbUhVv5I/lNgtLhiRc1pu3doVw6zantrf583Fo9Q6WrzyUZZUvvBaVb
 a/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517704; x=1721122504;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+8pqXRXLD051mzcdY7+rK8584X5K9gASUiVa7nDUSQ=;
 b=aKfFOEsFzWj6DJvlu0zBZr3Eiiqo7Ryv60nxz0FpSZHxtxLNcIKqNCiOO+Oy0SdULA
 d2vXpOdhW30JKvedLuhq/uLc/h/bkcV26bAJYEfI88qrAbyD52EibaUD6z2FUHoIQwXQ
 5Ufw51cbQrmomT5ZFo1P7+nbVLNw16e7xu/3MIJrsJqs2rNamtsKN4MdCgeSNTPahl8R
 FIn0gk4tVnUvqu+iRCku1sMRa6pLhLnXIbkL3KYsh2jyKvEQ+HDiYrLLUBsx/MGGgRFD
 IUcbaUmeWSJN2Z2su0xmrR5h0qEN5C+paUlcCQzzeu8F3THXICm7DKzBws7lvI5F1TOc
 88yg==
X-Gm-Message-State: AOJu0YzTnhnbPjHrFXyK0TmxTZm/VSXVGQKzQCgnZCUGsjQBLdAse5m9
 G98zkCzb67AMU7ngDFG4xRhf+Zaj54RSgetR9IUHnYSznNZKR1eZhs4qV8+vf2I=
X-Google-Smtp-Source: AGHT+IFsVQ/qjw9yOH1sPxY4WCYaB/0WlzueTO2DnnQ1491ASM4M0HBbVGqdGCPntlzPmTtvSHDwnQ==
X-Received: by 2002:a17:906:d7a2:b0:a6f:af8e:b75d with SMTP id
 a640c23a62f3a-a780b689418mr150900866b.8.1720517704177; 
 Tue, 09 Jul 2024 02:35:04 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:35:03 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:45 +0200
Subject: [PATCH v4 17/21] power: regulator: adjust structs for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-17-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3030;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=p3eA/KAJP0cB2BNWrGjlgN2dhvyMiNDyf71KR9zmC2w=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQ09f56S78VJl3jqiZVdrLCGN1IbiqLb+X+d
 0or4w5+xzOJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0ENAAKCRAFgzErGV9k
 tlmmD/9DxjlZqJZxVBBy/2RXmrlOJinuhltl+rSHWAehmZxoiDVwazuPMyH0SZYKNihhlsgXYBo
 faKVpiFRXq6+PecII97Rf6rRaLXdYV/IeYG3kPuoJt3mHb98+SCf4HZHHtKguXTQQGz2Gx+Qpfv
 /t7OczMgrAfme+8ffp30ox+6Bc6A+010J9VE3jI+3ESa4ttA2Gy0UbimvrNkMtC1T4ichhq4kZ0
 MAHZnOfU5391lpz1HLpnBi1KQj34KYC0Yq+z3p9NHk8xHYclFqsByspQWST573CSy+YXqMtv6s8
 5QWExDKpaw0waoX0YBB0ntYiXen+iJv36+WyIGiott+nmwSogALwLAp5IHRQNjGQwhPKN82icqz
 cvoNSDx9QdsXRxO5y7ysd3QdwVBv+HNN1fUUgusPvxiW43jNDE+xtAETASFFnYCT+T3v6VnDNPQ
 C0Kx9pLH7jyDOs8C+pL47lTeB/0EzW5Vbimdk1GGNPecKPAU/YRH9AQT6kMaeW/gNEQUq4hiOJ1
 1Flk///i5kem8mvNUnYNa6XbIXVSvIx7C+IYpg1/D6oQRZt0tehuAm9P4i6wNE+8lVUF6oCibiY
 b18sQytHlCiWPlCkAbrJ6Mh2d6rNXI+zszx8RQ0E7GRK7D2zcPzf1q6SvBXuYZUhpHvqjxJA5e4
 S772j61NvYYJe0w==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Switch to our linear_range helpers and remove unused/unsupported
linux-isms.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 28 +++++++++++++--------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index d0acee9f558e..089623f3a2b9 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -102,13 +102,12 @@ struct linear_range {
  * struct rpmh_vreg_hw_data - RPMh regulator hardware configurations
  * @regulator_type:		RPMh accelerator type used to manage this
  *				regulator
  * @ops:			Pointer to regulator ops callback structure
- * @voltage_ranges:		The possible ranges of voltages supported by this
- * 				PMIC regulator type
- * @n_linear_ranges:		Number of entries in voltage_ranges
+ * @voltage_range:		The single range of voltages supported by this
+ *				PMIC regulator type
  * @n_voltages:			The number of unique voltage set points defined
- *				by voltage_ranges
+ *				by voltage_range
  * @hpm_min_load_uA:		Minimum load current in microamps that requires
  *				high power mode (HPM) operation.  This is used
  *				for LDO hardware type regulators only.
  * @pmic_mode_map:		Array indexed by regulator framework mode
@@ -119,15 +118,15 @@ struct linear_range {
  *				in device tree to a regulator framework mode
  */
 struct rpmh_vreg_hw_data {
 	enum rpmh_regulator_type		regulator_type;
-	const struct regulator_ops		*ops;
-	const struct linear_range		*voltage_ranges;
-	int					n_linear_ranges;
+	const struct dm_regulator_ops		*ops;
+	struct linear_range			voltage_range;
 	int					n_voltages;
 	int					hpm_min_load_uA;
-	const int				*pmic_mode_map;
-	unsigned int			      (*of_map_mode)(unsigned int mode);
+	struct dm_regulator_mode		*pmic_mode_map;
+	int					n_modes;
+	unsigned int				(*of_map_mode)(unsigned int mode);
 };
 
 /**
  * struct rpmh_vreg - individual RPMh regulator data structure encapsulating a
@@ -148,23 +147,22 @@ struct rpmh_vreg_hw_data {
  *				not
  * @bypassed:			Boolean indicating if the regulator is in
  *				bypass (pass-through) mode or not.  This is
  *				only used by BOB rpmh-regulator resources.
- * @voltage_selector:		Selector used for get_voltage_sel() and
- *				set_voltage_sel() callbacks
+ * @uv:				Selector used for get_voltage_sel() and
+ *				set_value() callbacks
  * @mode:			RPMh VRM regulator current framework mode
  */
 struct rpmh_vreg {
-	struct device			*dev;
+	struct udevice			*dev;
 	u32				addr;
-	struct regulator_desc		rdesc;
 	const struct rpmh_vreg_hw_data	*hw_data;
 	bool				always_wait_for_ack;
 
 	int				enabled;
 	bool				bypassed;
-	int				voltage_selector;
-	unsigned int			mode;
+	int				uv;
+	int			mode;
 };
 
 /**
  * struct rpmh_vreg_init_data - initialization data for an RPMh regulator

-- 
2.45.2

