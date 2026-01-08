Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E0BD1D493
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA5984319;
	Thu,  8 Jan 2026 21:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R9zUXNJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D591E84158; Thu,  8 Jan 2026 21:29:09 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9735884309
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 21:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b79ea617f55so727303266b.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 12:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767904144; x=1768508944; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+M3Ev43EtHekchdO4lYaSBIsrzpPMWF2vdJWpuBo2tc=;
 b=R9zUXNJMGH196vAMRhUACebbGaxXVv0wM8RBVeEeVuuhHiOCaCk82yFLdj6KBgcdOQ
 guFmjDaXhzM9sMjwJlZhvPIIseRbp9Y0BYTwjfg4gHH6ukRsKHN5qmT/0EO1Vv7MTYe9
 utrRGXjQuOBHM5w/j51vMuL2VRXZcqcR2NdTfP9IVvNvURARpOHkx40LM3XM5CYRkDcH
 jCN9rQ0e7d6CMsYh2BEtUKNNAd1yyqrqXsex9QogMGxbczqCmw9ucukix5gR/bLgegJ8
 Pk7vT7uSxsV+joG14oi2Fjd9iG8S38wIFDwf4afR7ldfFmQsctcYU1GNGDw1MYln1nYj
 qnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767904144; x=1768508944;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+M3Ev43EtHekchdO4lYaSBIsrzpPMWF2vdJWpuBo2tc=;
 b=fHNjhdBbNd/EbLuZYXs+uduRAVnUtUO59zAj6yCQroJa9LE4Q4HrKAoxu/z5jYZki6
 SPqZQ7RzZzmnb65FaVJNfO4kb3+5Ew4Onrp8MKpFYBv6UCzK5vpXZg4AtZSy1BqnkE4Q
 GhDu8EmK1VNcHwU0hi8iKf0qhhVAtCXXtB0NZ23uF3HXvBntJ2heHgxDURH1RrIAK/my
 2dY/ssIprIzSq1dMMVu1+lpgBDwSF83oXKaUzykqN8pc7Pl6VtHoRXp5sJcpQyg7sdxK
 vMjuH53YChz4PMItzJoKzFNzSHCtGvlhT77suJVWSRCw0YofHfIa3X2SjS2A+PM32BI5
 f52g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnfwCIMsNkQZQn2qvoOzYLD6WZUrHTCC4sUrIzVUKbMl7TmNuQUxt0QuUh+pHtobJeuNThE78=@lists.denx.de
X-Gm-Message-State: AOJu0YzwiQkj2kvQHbznZ5BkK3WYDDnJ+Ga4pjXakgNXidtFnUu7S/7I
 piw027XpZ+7Z499j8iXQr6fvgakELIN0ja9gl7SUvzzk45jRcvVRFasLEurvDw7UAjA=
X-Gm-Gg: AY/fxX6ereP8dlQj6iMh98q/cQ1rdYQGl+VqMWWxMpkBsn4NKpXynBl2a1T69EFaEpd
 ykMCUB7UfNHfxq9sIyZ0YH5H/VH/9+bTGmQybSRsq4lx6qMgpacmD3KWLq24xmZHbQGX8BuG55G
 60mg1C90HPQjyr0V0CdhvpmW3y8h9XvhrCVMqROhr3inch37gmR37mKQczlG+v0a3WxwcOp98G8
 j5P4s0crSuNnlXff/V7Z9yx9qTzGfoAESXkLOzaX1kpnxtChkU8dUhNtH6ucGfQ+hBWTAy363Hc
 yIie0fgVgiP5SSYcPw0/bfnopop8km/X7r/3SJBfltgYe5rh/ZL4b+YK9paIMan36fptIgqpuak
 xb2k9kD8Ttl/0YwBlHI/pWaPFWEXelUHG2NO62Yv9ZapEbI3EbonUfEwOEtUBhTtqJbohWJSVMr
 Vtd7DzkQpZYUX60MtT1zpwshzJS72cbnmxI7l3Os51ZPKj1Aay/TMgmA==
X-Google-Smtp-Source: AGHT+IF17Ww+QX5sH6vUifkLz8sy/SYyjCOLh8gc1hOFUEjmaqmZdIQffNAvxfyFJcwI+x3u7RHEYA==
X-Received: by 2002:a17:907:70c:b0:b80:4108:f826 with SMTP id
 a640c23a62f3a-b8445179ecemr766531966b.36.1767904143960; 
 Thu, 08 Jan 2026 12:29:03 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a564e05sm930264366b.65.2026.01.08.12.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 12:29:03 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 08 Jan 2026 21:28:48 +0100
Subject: [PATCH 6/6] power: regulator: qcom-rpmh: correctly map pmic mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-rpmh-regulator-fixes-v1-6-d1b5b300b665@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=pmwL4ebtZSEzqM9uZ0kaF3u/lg/FNCkoJmFdFjZLeUo=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswE4fY1M2s0alkFQtiY/mukvqmaVP+Jecc/edWwaze9v
 9mtkD7XUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACZSrcrw32+nlfuOZrlFs9sm
 1K2QPR5XeHrKQvPWYDedf62y8R93VjAytCxwLZwu9GRGX+jxxWHBbvUJu2czFoaefnFw27YbpVp
 eRwE=
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

Currently we don't properly map between the regulator mode ID enum and
the appropriate register values in the mode map, as a result we always
unintentionally vote for retention mode if we actually attempt to set
it. In the set_mode path we did find the appropriate entry in the mode
map but we wrote the id instead of the register values. Clean this up
and properly map id -> mode and vice versa.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index cabdf089819d..3f0f18454698 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -368,11 +368,13 @@ static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
 		return -EINVAL;
 	}
 
 	if (bypassed)
-		cmd.data = PMIC4_BOB_MODE_PASS;
+		// XXX: should have a version check for PMIC4 but we don't have any yet
+		// and we don't use bypass mode
+		cmd.data = PMIC5_BOB_MODE_PASS;
 	else
-		cmd.data = pmic_mode->id;
+		cmd.data = pmic_mode->register_value;
 
 	return rpmh_regulator_send_request(vreg, &cmd, true);
 }
 
@@ -398,17 +400,25 @@ static int rpmh_regulator_vrm_get_pmic_mode(struct rpmh_vreg *vreg, int *pmic_mo
 {
 	struct tcs_cmd cmd = {
 		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
 	};
-	int ret;
+	struct dm_regulator_mode *pmic_mode_map = vreg->hw_data->pmic_mode_map;
+	int ret, register_value;
 
 	ret = rpmh_regulator_read_data(vreg, &cmd);
 	if (!ret)
-		*pmic_mode = cmd.data & RPMH_REGULATOR_MODE_MASK;
+		register_value = cmd.data & RPMH_REGULATOR_MODE_MASK;
 	else
 		return -EINVAL;
 
-	return 0;
+	for (int i = 0; i < vreg->hw_data->n_modes; i++) {
+		if (pmic_mode_map[i].register_value == register_value) {
+			*pmic_mode = pmic_mode_map[i].id;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
 }
 
 static int rpmh_regulator_vrm_get_mode(struct udevice *rdev)
 {

-- 
2.51.0

