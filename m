Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F715C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 16:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2135683B4E;
	Thu,  7 Aug 2025 18:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ELJDglwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0854D84612; Thu,  7 Aug 2025 18:35:26 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 613AC84612
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 18:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-458aee6e86aso7586925e9.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754584523; x=1755189323; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4Zr/73J65zfkWMRcZemWU6VrUFIQZelrJl9sOpgY+4g=;
 b=ELJDglwD4Ckc1/QjMU7Q8QWuJE1Pm2Ar7hAzwsx0PoWhk4qwwJdROZYCHYAhweMTTM
 rO69DYD3lzLObiEASqsIXYBEFafLWZ9QPkAqARdsuFPDgfF9cBJhayWJ7xiJopRyUFX9
 QX6nsmpQxVFlc/x5KrrAhWppRm0r3ujKolzP2n7jx+LxI/OVPsskOauMLfoYzYyJWNfl
 RiR5kaDwCZxf0GJc791qp5nCtFqBPIViKmE+vXgTnxGOA8IS6s8abSYM2P6uSVDJr/UR
 bOOTtgFKWIH07sZqL+1g2WFTJTiNmuPVH9YNBzPlqLv555K3bAVmqgERswi7qacoO3pN
 GLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754584523; x=1755189323;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Zr/73J65zfkWMRcZemWU6VrUFIQZelrJl9sOpgY+4g=;
 b=OEL0AFNQp0QQ3LLVyuV0dmjky1Ozp9M/QptwYwBqLFljvPEs9Mefk7jUjkf0e+v18c
 kggP6lMlcotQgkM91QLuzURLJZCf+9VVqY/ahnuuodCHOPgOzOQY+RkViB24UQ6VfyeC
 w/MO/jLnq17SQqTGH7ANxzCEhrhQCOftOAlr0zyRUC9wWWpaCEWUemfjSs8pwjOzQ/Tc
 jgBIle2phpYy52ptgtzAL51cuGu2JC/arcLNQb82Cu6D7bYazdtZqY6wW2Y4xy/8yvSv
 UhFoG9yZkKP3PErbRX6MXU8lyJHXo1lQURIs4sj2vgiDLwKBU0i9eiX8/Q7KADiorLw1
 BK9A==
X-Gm-Message-State: AOJu0YzGOXKsFLc7XAAWCInH0WdoMYPe3uMg1+WcdokAe08tR4KbwYsM
 OLbyTv50bQADFYrhsHxTJwCXFH+RIbocp3/IHW4KsWM4ZsrZHthDsUFz8X8wpokFMHg=
X-Gm-Gg: ASbGncuiI9BcoIlRRTyls0ycvadS66VBMtKTDdPDuvBuH51H1ZSjg48OhA6/vvxmVau
 je3T9ImWpdmZZ01bHj311FHvULd8TT5OH353FBKNGsanJKtKDakIlLiiikoIRfyB8VsIWCIfK0A
 xOj+eVXjFTa8tqkO+U1jiPXFqlSwNLlGI+Kn7TW4mMfgLRUlIImRJpDJQ+z2AaWFvbO7aYu1Ro0
 DPobCAjKubjzvazRTIoVacjSpuf4CRd5pNQbkxiFCeLExeZdHCvu2AZOh8MG1Zs7cBCjG3d3+YC
 9OCAQ0p/sRoCJUDiaHGMXCJTV7BA5ObbOtG4XHODUG6nlXjW3zJEPmUO0yTjoU6spMEuR6EwWRb
 UQkc66Tqjl50Zny6xmXL6IncAgRJpVeHzMZFaCuJeuZwKcNcatvU=
X-Google-Smtp-Source: AGHT+IGIMIEBT68ytComGVjrDgjGUI0o97kSz5HE6mmGmQEtUjuBLDyI6aWRT/BqMz+Kjb3Qfxgn0g==
X-Received: by 2002:a05:600c:a692:b0:459:d616:25c5 with SMTP id
 5b1f17b1804b1-459e709acf3mr51281145e9.12.1754584522840; 
 Thu, 07 Aug 2025 09:35:22 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5b84674sm108141375e9.30.2025.08.07.09.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 09:35:22 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 17:35:19 +0100
Subject: [PATCH 2/6] power: regulator: lp87565: Cannot test unsigned for
 being negative
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pwr_regulator-v1-2-42a4105336ec@linaro.org>
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

In lp87565_buck_val hex is an unsigned variable being assigned the return
value from a function that returns int. Change hex to be an int so that
the following test for an error as a negative value will work as expected.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/power/regulator/lp87565_regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/regulator/lp87565_regulator.c b/drivers/power/regulator/lp87565_regulator.c
index 2212cb5c651..ea9c7685e9f 100644
--- a/drivers/power/regulator/lp87565_regulator.c
+++ b/drivers/power/regulator/lp87565_regulator.c
@@ -82,8 +82,8 @@ static int lp87565_buck_val2volt(int val)
 
 static int lp87565_buck_val(struct udevice *dev, int op, int *uV)
 {
-	unsigned int hex, adr;
-	int ret;
+	unsigned int adr;
+	int hex, ret;
 	struct dm_regulator_uclass_plat *uc_pdata;
 
 	uc_pdata = dev_get_uclass_plat(dev);

-- 
2.39.5

