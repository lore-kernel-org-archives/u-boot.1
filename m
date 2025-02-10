Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CA9C0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78EC880BAD;
	Mon, 10 Feb 2025 17:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vaof6Vr8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E5180AE6; Mon, 10 Feb 2025 17:30:44 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD9DB80AE1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 17:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43944181e68so13007275e9.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739205042; x=1739809842; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=igsh4rveWpl6Mz6I85eBreULwLVLJ+//b0lzjwnH25I=;
 b=Vaof6Vr8Wt7EYP1RKvj/NxJbrJxKrpaQ+pMJyumy672WKkZa49IPdVFG43o91shrRW
 ydPpw/u8BeUAyNZ1DdPdwT2Eryd7vR2uJaY/dd4psYa6p1xx3ybPBjYel2YsQvl4Qpyw
 sHHs477ZN217W5IzFuytV/I2hJh2ZpdP8l7N2dfVp8L+s5/vdXSkpsxn1NFg1CTKWtr6
 3xXWFr0lUHXvOCDSDNDZ7q4THRcesxX61oFDpelNzbOwnUrMUTfcikIIwNyPxh/MxsTR
 tH2FwfJKTItzTAbac+BqOUmK5zzPLs+wO7nLYZ2Jsgr7t9Ge3OFj+SwxqALPhxq/hbs5
 flFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739205042; x=1739809842;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=igsh4rveWpl6Mz6I85eBreULwLVLJ+//b0lzjwnH25I=;
 b=jQohSewuhElkB9d1NA9nhUBEv8fdAj7M/hgIBQiooaBx1ZZhln+4+6qHQpTHRXjBNY
 1xSNY/VKUPIhoogGpJ4gvsBevPzfmQ0GL/GbtRyBlknVX/5SMsD7ivIS330aeuZgnCBr
 F4MknXytUJ4f0n8x8ho6V6oc3CTV56a2Q27neIeDbBLvzHpMjIPWVFG6S5PnTRM3qLD8
 SN8/ZvEpEX+onQL0HulgvDD+H4M9rYbAHjJ4KWXGnEMtcTnE2zUhq6df1jAbbN5921Iz
 DLw6ovN7EfZg9lnZTOmLZwGttFiwkDPvA0Em+E6Q1uO7MQX9FBN69hVjbBtimJauU4QX
 gOEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHkRub+2SZGlJAaTrCNiV3AZXfEkY/DIJG+03BvRv79FOB5spd4elgq9ris6BM+gFAaq+c08M=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6ulMiOn9h0PcT72ZP/HjR2elf53IPsc0Yjj0ZQD5/vn29sTKt
 spzQ1JO50J+RCyDTctXh8LmiJwoKdfYQFMboKUU1GL4NARG2RnBkOm1v0GNZTWo=
X-Gm-Gg: ASbGnctH+ajE9HwbYHNpJupcLYIAAMh917g77YkFXWzFYzUhljkbohnfmq2hRI3ZzFz
 UwHBVNXWaVmoCD4etvjhuYZ25PbytnvhekLmMW9C7OKzG6UBUwj9Iz3U/nyevXaGJY2dI4DDSde
 ou7QSK32nn1zgs3+4R5JvO4bPmwh5fwmOcdAOzA5fIaYz82LKOvNGpysHxnypvdXNk5syAAuHQJ
 H6b6lvAiuOPHm4yIouicRoaNz6X4+RUZSRpKoOJ4SzoveEMZJvhqHZID/NwLFuS8fzrUbDTp9cW
 VtPfCbhyYFKayn8tWWcY4OaMuG1kP5g=
X-Google-Smtp-Source: AGHT+IGOGo2mswpUT43a/9Zv6OD2KLIrZhk2Mg5PBiMCYMK7tVjvfy/R40ghKdwc6ceNntLl8SIxDA==
X-Received: by 2002:a05:600c:83ca:b0:434:f4fa:83c4 with SMTP id
 5b1f17b1804b1-439249bcfc5mr143415185e9.29.1739205042383; 
 Mon, 10 Feb 2025 08:30:42 -0800 (PST)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:7693:a594:d8cc:16e9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439447ee508sm36211545e9.6.2025.02.10.08.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:30:41 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 10 Feb 2025 16:30:23 +0000
Subject: [PATCH 1/2] power: regulator: add additional supported LDOs for
 pm8150l
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-b4-rb5-sdcard-v1-1-3c34a8bee77b@linaro.org>
References: <20250210-b4-rb5-sdcard-v1-0-3c34a8bee77b@linaro.org>
In-Reply-To: <20250210-b4-rb5-sdcard-v1-0-3c34a8bee77b@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Amit Pundir <amit.pundir@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=0lDLL9ZO3bf+fx2iozMm08po02kXEKo9ltJhuLxeNw0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhvRVmuvb6z/M71x8oK6Hcb5+7O+JXX8X6JcfYlA2+nawe
 lvYyqCUjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCR5IUM/+sPaAZnOq1Mecr9
 e65x5+mUcxOPLZ/233dF0dsZieaHV7Iy/HcWuL8zlUvDxyL759urt2+5Lq1e+rvszOcN5QEyl6Z
 M3/YLAA==
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

Add the other LDOs that our rpmh driver can currently support. Some of
these are used on the RB5 to power the sdcard.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 70df51b5fa4ee4001b7eff6facc80957ada84391..cd2b1a654c15e09c154c524378768ed1beb83895 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -480,8 +480,15 @@ static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
 };
 
 static const struct rpmh_vreg_init_data pm8150l_vreg_data[] = {
 	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo_lv,   "vdd-l1-l8"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo,      "vdd-l4-l5-l6"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l4-l5-l6"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l4-l5-l6"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l7-l11"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo_lv,   "vdd-l1-l8"),
+	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,      "vdd-l9-l10"),
+	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l9-l10"),
 	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l7-l11"),
 	{}
 };
 

-- 
2.48.1

