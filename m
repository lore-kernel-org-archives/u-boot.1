Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D124BD1D493
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6187842DB;
	Thu,  8 Jan 2026 21:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M/gFeW2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6522A84310; Thu,  8 Jan 2026 21:29:05 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6851C8415D
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 21:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b725ead5800so493750466b.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 12:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767904143; x=1768508943; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ACx5jt1Vn3WNfNGxe1mGxg6MS5wUoaufG0LgO8Y9Abo=;
 b=M/gFeW2X4MrVSo0SDesUSPFzr3CZwzw3s3enhg7MnFamXKcWBIYjWsF+zrMx8en27Q
 mGHBaKcfQ9iJSn1/EW56+pvzdknIk9YwS+9r1cJNTT0hchmkj2Uc5Lrfcrksl5HfB4pn
 p8F3jOVFQqQ7C6b7n82B0Z70smYrD6d00PD/4ExY1kY9BOEhAtFPBGfD7PoDilOaVipk
 Z7x3gaO278XJSFMYRL4HmPUwEGY6jmoXMHtQo5iErv9epdf9UHhCktKBhcEiuzV8Mrh9
 hGyuXHDi1zihwPUeSOucmILgs4LOLEsfyQnnQmmDJqgnAi4OJzdrbdw1s3LrOXapSWAr
 aWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767904143; x=1768508943;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ACx5jt1Vn3WNfNGxe1mGxg6MS5wUoaufG0LgO8Y9Abo=;
 b=rcEFX/stqwxzJFF3UM/CuwDG5XmqeHyFaAPv9G1CFle4N0sfj5nhWDszpfzfrEofPd
 LpH/ugRtWSbWdxRX7ni21dcRWmUdl6gXsVJ3fCnmbqnkE7eKnyZoVrNM0J1WzAsrgMrv
 pOcvQZ+skMdjmisjof1waWs5+i5bdIjNXLvJTpdmafqdNGir/E4oEJ4LxN7KfP2HIUGQ
 pAY5oCp7VUDyFM3QvSm7xfh2zFkaZQrCZdOBgjOf2zXepggSHhB9hKfCWRbrP2ycdeC+
 c3IsQ9qrUtY9ueQPM0kYjLlAUuTj38uKGcR8h5lymxu4pwBQHRCs+bba8MgG7wpPA3S3
 wSHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB+6jMljmi3PShJJirtaaS1vfxg3R+2wjI34sqSt40r+K0ogk/hqCdCVw6zJXlHDAVUJypBh8=@lists.denx.de
X-Gm-Message-State: AOJu0YxJWY4SBDxrg1GOZaLTKop2uewnnNF2SQBThj93DYQEvncBi1cm
 k1ySm7ynzgTQAyfzzAUOfvhQ0Oj0w9SC28MNS+vTUtZE6b0mrqfPxiB6lToOpaYfsio=
X-Gm-Gg: AY/fxX4VeQq5miymfHX/sdnIAeJS6PE09us0cGyCeR9Ri2Ta1IJyX6x59BQrUo6PNx1
 QoB6BZUdlCLdJA7MTIWonPWWPrUv7TBMvhkEFcAZtC+WMYtvn3mcyAjk5q1h9vsoB883m8j+eRZ
 J+F0JHuKrLVwrOuzl1STj4ytOqNraHrD47XolKbOiCP8SRXXnj27qNvuffuGmcvIj9mm11WZEtj
 GZBtROEfBZoFGiqD0Q84NvMKoyQgnSbZOj/ntKTxlSZXpa678SI1dlTtFFrkbzq1CW7l1ddt0VU
 KA9F5ocVJt8U1o7BswA3kpFExZ4YMU3cjx6mUUIktiBZqGbXBl9sSvd7PaLdHGYeT7wm7CVlQ6p
 W3+ASDscFek/ToRB1VSBG2MqdCEKtalAu3KE7u/nRv22U5gjUGt7CTHj/bMpD4IRKU2mFE3mt2q
 Kx+R2VFD93Z8xB7nDa5IRvfCzt7+oc8U+4rAcoy6AWfFNH6ifIyS+lRQ==
X-Google-Smtp-Source: AGHT+IHapEqEOs/GmqeWHlh1iLJPPnDTkyPk/Py5FdZJPchR059FdEFN/B6W33xuoFZs/xYR7m9O+Q==
X-Received: by 2002:a17:907:1b02:b0:b76:f57f:a2c3 with SMTP id
 a640c23a62f3a-b84451ef354mr744200366b.12.1767904142772; 
 Thu, 08 Jan 2026 12:29:02 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a564e05sm930264366b.65.2026.01.08.12.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 12:29:02 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 08 Jan 2026 21:28:47 +0100
Subject: [PATCH 5/6] power: regulator: qcom-rpmh: read votes from rpmh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-rpmh-regulator-fixes-v1-5-d1b5b300b665@linaro.org>
References: <20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org>
In-Reply-To: <20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15-dev-52d38
X-Developer-Signature: v=1; a=openpgp-sha256; l=4440;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=cPtTykY/oHS4Ap/grXRp6rIGGkAwv+X57X6zZG5TwvM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswE4Xbm39mNWlfXNOq0hpc/Sni9ks2tTO8t96/r5vqNa
 /n5pK53lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIn8DGX4H3vva/3MQymHmd0m
 ewS/9r1Rnl53hy33ZdP1b5dfvLb6f5Hhf9LKoGOT7WevTzsQanFJx8Sww994htWa4jwb+auf2M1
 4KwE=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Make use of the new RPMh read support to fetch regulator values that may
have been voted on by a previous bootloader stage. This allows commands
like "regulator status" to report the actual votes programmed into
hardware (though not necessarily the actual states of the regulators
once the votes have been aggregated).

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 76 ++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index b16cbccbfc45..cabdf089819d 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -36,10 +36,13 @@ enum rpmh_regulator_mode {
 	REGULATOR_MODE_HPM,
 };
 
 #define RPMH_REGULATOR_REG_VRM_VOLTAGE		0x0
+#define RPMH_REGULATOR_VOLTAGE_MASK		0x1FFF
 #define RPMH_REGULATOR_REG_ENABLE		0x4
+#define RPMH_REGULATOR_ENABLE_MASK		0x1
 #define RPMH_REGULATOR_REG_VRM_MODE		0x8
+#define RPMH_REGULATOR_MODE_MASK		0x7
 
 #define PMIC4_LDO_MODE_RETENTION		4
 #define PMIC4_LDO_MODE_LPM			5
 #define PMIC4_LDO_MODE_HPM			7
@@ -204,8 +207,40 @@ static int rpmh_regulator_send_request(struct rpmh_vreg *vreg,
 
 	return ret;
 }
 
+static int rpmh_regulator_read_data(struct rpmh_vreg *vreg, struct tcs_cmd *cmd)
+{
+	return rpmh_read(vreg->dev->parent, RPMH_ACTIVE_ONLY_STATE, cmd);
+}
+
+static int rpmh_regulator_vrm_get_voltage(struct udevice *rdev, int *uV)
+{
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
+	struct tcs_cmd cmd = {
+		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
+	};
+	const struct linear_range *uv_range = &vreg->hw_data->voltage_range;
+	int min_uV = uv_range->min;
+	int max_uV = uv_range->min + uv_range->max_sel * uv_range->step;
+
+	int ret, _uV = 0;
+
+	ret = rpmh_regulator_read_data(vreg, &cmd);
+	if (!ret)
+		_uV = (cmd.data & RPMH_REGULATOR_VOLTAGE_MASK) * 1000;
+	else
+		dev_err(vreg->dev, "failed to read VOLTAGE ret = %d\n", ret);
+
+	if (!_uV || (_uV >= min_uV && _uV <= max_uV))
+		*uV = _uV;
+	else
+		dev_info(vreg->dev, "read voltage %d is out-of-range[%d:%d]\n",
+			 _uV, min_uV, max_uV);
+
+	return ret;
+}
+
 static int _rpmh_regulator_vrm_set_value(struct udevice *rdev,
 					 int uv, bool wait_for_ack)
 {
 	struct rpmh_vreg *vreg = dev_get_priv(rdev);
@@ -248,20 +283,39 @@ static int rpmh_regulator_vrm_set_value(struct udevice *rdev,
 
 static int rpmh_regulator_vrm_get_value(struct udevice *rdev)
 {
 	struct rpmh_vreg *vreg = dev_get_priv(rdev);
+	int ret, uV;
 
-	debug("%s: get_value %d\n", rdev->name, vreg->uv);
+	if (vreg->uv < 0) {
+		ret = rpmh_regulator_vrm_get_voltage(rdev, &uV);
+		if (!ret && uV != 0)
+			vreg->uv = uV;
+	}
 
 	return vreg->uv;
 }
 
 static int rpmh_regulator_is_enabled(struct udevice *rdev)
 {
 	struct rpmh_vreg *vreg = dev_get_priv(rdev);
+	int ret;
 
 	debug("%s: is_enabled %d\n", rdev->name, vreg->enabled);
 
+	if (vreg->enabled < 0) {
+		struct tcs_cmd cmd = {
+			.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
+		};
+		ret = rpmh_regulator_read_data(vreg, &cmd);
+		/*
+		 * Don't override if disabled since we will also vote the right voltage
+		 * while enabling
+		 */
+		if (!ret && cmd.data)
+			vreg->enabled = cmd.data & RPMH_REGULATOR_ENABLE_MASK;
+	}
+
 	return vreg->enabled > 0;
 }
 
 static int rpmh_regulator_set_enable_state(struct udevice *rdev,
@@ -339,14 +393,34 @@ static int rpmh_regulator_vrm_set_mode(struct udevice *rdev,
 
 	return ret;
 }
 
+static int rpmh_regulator_vrm_get_pmic_mode(struct rpmh_vreg *vreg, int *pmic_mode)
+{
+	struct tcs_cmd cmd = {
+		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
+	};
+	int ret;
+
+	ret = rpmh_regulator_read_data(vreg, &cmd);
+	if (!ret)
+		*pmic_mode = cmd.data & RPMH_REGULATOR_MODE_MASK;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
 static int rpmh_regulator_vrm_get_mode(struct udevice *rdev)
 {
 	struct rpmh_vreg *vreg = dev_get_priv(rdev);
+	int mode;
 
 	debug("%s: get_mode %d\n", rdev->name, vreg->mode);
 
+	if (!rpmh_regulator_vrm_get_pmic_mode(vreg, &mode))
+		vreg->mode = mode;
+
 	return vreg->mode;
 }
 static const struct dm_regulator_ops rpmh_regulator_vrm_drms_ops = {
 	.get_value = rpmh_regulator_vrm_get_value,

-- 
2.51.0

