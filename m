Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFADC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 16:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EB4084680;
	Thu,  7 Aug 2025 18:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jVLG0CmR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 440C084660; Thu,  7 Aug 2025 18:35:29 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC6B84668
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 18:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4589b3e3820so12877355e9.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754584526; x=1755189326; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4ckngCW15JY6/WfgI0nrxzZy1YoT2a1/x9qnYZQUJUk=;
 b=jVLG0CmRlUS7j2n+RgHymOIyKaHWbq26YjYhWa0+TwJpwtWPbLP1pqByB8PeEeOYAz
 gKYY59GEmKEA5MQrDN3ysGd3t3yoCNunYQTnFesUSTG/cDIpZ89WqM1jEY7MDj0QJ8rn
 zG48EXSvZAseAG7YHfla0xcBz+H9jTbXdafP+Nkie86vpQTkvR8fvQ31PFaE85XYpIv0
 RyJ7mwXzowQwngyNa+YBsS5VIZv8XvC2UKR3yK5eC4L2VxZYAVTSpNy/qKBds9Z+omEV
 u/GDLDm0h3Kn8SDI7k3epjvpDDI9W7xD7YKe8sIHgbg02x45IZeCIyRQnOgx39akxDpx
 Fvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754584526; x=1755189326;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ckngCW15JY6/WfgI0nrxzZy1YoT2a1/x9qnYZQUJUk=;
 b=PrJQZ/T75USqkQZVYa94LTYz7kPfHdAk7HrNav4UHAqM31JGbWzUiZn9cbMRKtqa29
 DFdnE7IxdNZ8BgdiRmP1vN+Nk3GGzfgOQwKTZQU8OzbTLRSxQtO7GQH/qSVqlfVlsq0V
 I7Ku3GrO+VjA2JQgGEqcXzui6HhSKQ9QkQX3s0DvNT1DqZhTvDQm9hyV8VgaJQgEbMFC
 JdvDoelm0i6xUZUNIM7CeRw0K4cExy5eyMdWmqSSdDyxsaopkJWbpAfQMKIjkD+dqPP+
 zwuyC4NsAdXAe4kZq63ABSI9YGFNiHfQY4/Jzv2dWc7kR3DGvnQ4UvKFNDLWRAIQlVca
 HN0Q==
X-Gm-Message-State: AOJu0YzYj8b1PlZAFOdmu9iA2fMJLblF4WBqG1qtmQbCU//daFjB58xt
 pN//2exRSFvtc4NlZOHoVG8aio3dKYVhPgFYK1uxv1zAu96yY0BuFkAAmdttVbdzx+4=
X-Gm-Gg: ASbGncsZY3vOuFQqDIaJiwldij0AXJIGF2hajH7u8te7j1NKtpJBDQ51U/shsEibh9u
 iCCIXOiK+zX4qmCW+WtE1EfxSQP8Sz59s8HrNhGVziaOuvRNcGAdnoo498kNb+3mfEqYS5mYfOR
 fDyXptx1eabg79wDVUqW7jO4AOr8oRBPzDZpGSgQWnBxzFShUCV31lkVJMQ/vqSZC2dOggU4aNs
 T4hBiLsQcPq2ANZHUPVi2jRNaC+ZPpLPgfYbPfoXbkuC55LMcMyRn8kwv/mq57sKPQhQLr7f68A
 TvZ3GC8jdbNlcvBhJKfFEvlowrsk5rL55FSGqbgUDM6XRRBx63K+BHAHI8Ohi4HFth0dkqES4p0
 WAkh0bGSOPBpqQ4edW0mGhWrH+pz3DKJL2opTM5pd9IRe34qhJCJYJ5L3o7mBjQ==
X-Google-Smtp-Source: AGHT+IGeaHdBhD8qJKFPsojRk6z9czlbROUgpWolSDxWPQTrz5z+YVt27RnAIbr+PrL+57fqGYWMug==
X-Received: by 2002:a05:600c:154a:b0:43d:fa59:af97 with SMTP id
 5b1f17b1804b1-459f43bb16fmr2518015e9.32.1754584526022; 
 Thu, 07 Aug 2025 09:35:26 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5b84674sm108141375e9.30.2025.08.07.09.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 09:35:25 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 17:35:23 +0100
Subject: [PATCH 6/6] power: regulator: tps65941: Cannot test unsigned for
 being negative
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pwr_regulator-v1-6-42a4105336ec@linaro.org>
References: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
In-Reply-To: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
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

In tps65941_buck_val and tps65941_ldo_val hex is an unsigned variable
being assigned the return value from a function that returns int. Change
hex to be an int so that the following test for an error as a negative
value will work as expected.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/power/regulator/tps65941_regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
index 13f94b730d4..2561d6f4c6c 100644
--- a/drivers/power/regulator/tps65941_regulator.c
+++ b/drivers/power/regulator/tps65941_regulator.c
@@ -277,8 +277,8 @@ static const struct tps65941_reg_conv_ops buck_conv_ops[] = {
 
 static int tps65941_buck_val(struct udevice *dev, int op, int *uV)
 {
-	unsigned int hex, adr;
-	int ret, delta, uwait, slew, idx;
+	unsigned int adr;
+	int hex, ret, delta, uwait, slew, idx;
 	struct dm_regulator_uclass_plat *uc_pdata;
 	const struct tps65941_reg_conv_ops *conv_ops;
 	ulong chip_id;
@@ -479,8 +479,8 @@ static const struct tps65941_reg_conv_ops ldo_conv_ops[] = {
 
 static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
 {
-	unsigned int hex, adr;
-	int ret, ret_volt, idx, ldo_bypass;
+	unsigned int adr;
+	int hex, ret, ret_volt, idx, ldo_bypass;
 	struct dm_regulator_uclass_plat *uc_pdata;
 	const struct tps65941_reg_conv_ops *conv_ops;
 	ulong chip_id;

-- 
2.39.5

