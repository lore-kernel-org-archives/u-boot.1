Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23A6C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 16:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0235283FC4;
	Mon,  4 Aug 2025 18:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VDo4EPLY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BCFB83FC1; Mon,  4 Aug 2025 18:57:04 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77A1D83FAD
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 18:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b783ea502eso3554520f8f.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 09:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754326622; x=1754931422; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eRQfEvgkUlXDuqoIhm8c+5lgr7f5tlIqUTn8RLmUtdo=;
 b=VDo4EPLYPxj8oiXzRR/RBlVAFjWB5ZPI6+/B1h06IGc0+IKtlbRCyHc6rDPGzlhn6J
 aCBHM6Pfewzq3T6ib+WZ6/oF2ki1p0M6Ym8VgKSrIJ+RJ3TAo5KJq0BgG7MjT5p7SIan
 cBIxk/ncqVOH8cSU5R4cLjemhl7jaLJMLTc6CXLijQz3t1+VPHNvlLdipe6D/0ZcT6Ke
 phFgV2ccRwJS625QbwHwBC1xvRLv8/mq/SosB/gRAlyM3BEJv69rnHNjG6dBsj0esM+S
 I2TeuWSamop8+RZIlsTv7GAuxlZtVgB3aOoRvSdfidW+t96aP4G75B94KHnNW7u9+yp1
 UqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754326622; x=1754931422;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRQfEvgkUlXDuqoIhm8c+5lgr7f5tlIqUTn8RLmUtdo=;
 b=RZ1VeLba06S86wE9+IunQiEC6pPCV6IY/5wvvTvfP3v7xvOb4iOkB2/HLcjRNHR5JE
 xZK6fCeTkMGdKXmAF5QknBfyzqF5CylYUptJR4pVnPV0I4zVzYqsr5nRJknCIRQKKLBP
 sTlz1hvsJarJ2NB+ZHca69kDoieEA+OA5UTwhmVxn87xjfjaesHYlmY7ywz38UXF5uui
 P3nHVjnWoOWUXwmhuPa7u1DV+rIeBlSISLjSbawZjzaznuBAw4z5s3TivIQdg0LMmKbF
 cWw60dp7QnDiAayt1FHsBX3/ltCczibxCv6tbOx3KXueQtuA2sWJK9reqOKsU8qMuJhR
 TJAg==
X-Gm-Message-State: AOJu0Yy+vmkmJiOaZs7QEcaRy0cMC1uMCnjuHd2IhbpFVhI6EyDUFemI
 a14U4yn4osW0tuJa9F/54fD3T4xRpLiXrITNVXGsm0tBReMWDRMHzLNDHlmYl7AIGcn/Dvms8ef
 0o2ml
X-Gm-Gg: ASbGncuo1SSgrB3PzLeeP3MkA4a7PUGFWO+lawkb2f/dtA80/x9DzvnevxVOn2mTXDW
 u9oCLIcJgi9izvv3Ir/F0bIds6p/FrONwbHSvug9V0hq9fr7qpVkSZBnSW3mdd8/aHkFVDB5D7A
 n3RPiYiz4hfURgRFNyOvdv9h38PTBnK/Z95Afro6P6XW71uFA3VwQyMN8Fsp3I+1UPFfiRg4WeJ
 ruI0OvnSC8xRlyS8q1sT80nIPl6cM3tH7jH9rIZs5TpJl3x/8MCxS4dFDAc0oUZ2jjy0YKxZh88
 0nuWU6fPQRetX3Rh6KIcQNIttG4UtB6CYvn/WiUbnPddTshSw68ilUmqK0Co5mVsGWdXWK/HpCg
 5fpHq9HE9j6ACDipYXUQQFplSyQ+Kr3LUE4dctl9NC4wz39lPzvU=
X-Google-Smtp-Source: AGHT+IGgDZ6B6usmHU9RHQqYWf7cFsFcA0re5llImEVBRBO8TlyDz6bt+D/K1Q1DXO7JAqvf6oFlzg==
X-Received: by 2002:a5d:64e8:0:b0:3a5:8977:e0fd with SMTP id
 ffacd0b85a97d-3b8ebc31c3amr288025f8f.0.1754326621870; 
 Mon, 04 Aug 2025 09:57:01 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459c58ececdsm43054265e9.1.2025.08.04.09.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:57:01 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 04 Aug 2025 17:56:58 +0100
Subject: [PATCH 4/5] net: fsl-mc: NULL check dflt_dpni before dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-fsl_enetc-v1-4-0708a826f9fb@linaro.org>
References: <20250804-fsl_enetc-v1-0-0708a826f9fb@linaro.org>
In-Reply-To: <20250804-fsl_enetc-v1-0-0708a826f9fb@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In dpni_exit there is a NULL check for dflt_dpni after it is
dereferenced a number of times. Instead move the NULL check to early in
the function. Also assign NULL to dflt_dpni after free in both dpni_init
and dpni_exit.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/fsl-mc/mc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fsl-mc/mc.c b/drivers/net/fsl-mc/mc.c
index 8c882c7fcf5..aad852f8151 100644
--- a/drivers/net/fsl-mc/mc.c
+++ b/drivers/net/fsl-mc/mc.c
@@ -1539,6 +1539,7 @@ err_get_version:
 		     dflt_dpni->dpni_id);
 err_create:
 	free(dflt_dpni);
+	dflt_dpni = NULL;
 err_calloc:
 	return err;
 }
@@ -1547,6 +1548,9 @@ static int dpni_exit(void)
 {
 	int err;
 
+	if (!dflt_dpni)
+		return -ENODEV;
+
 	err = dpni_destroy(dflt_mc_io, dflt_dprc_handle, MC_CMD_NO_FLAGS,
 			   dflt_dpni->dpni_id);
 	if (err < 0) {
@@ -1558,8 +1562,8 @@ static int dpni_exit(void)
 	printf("Exit: DPNI.%d\n", dflt_dpni->dpni_id);
 #endif
 
-	if (dflt_dpni)
-		free(dflt_dpni);
+	free(dflt_dpni);
+	dflt_dpni = NULL;
 	return 0;
 
 err:

-- 
2.39.5

