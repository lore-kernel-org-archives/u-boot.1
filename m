Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841C6C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 16:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68FED84669;
	Thu,  7 Aug 2025 18:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SuYP0GP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2654884658; Thu,  7 Aug 2025 18:35:26 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E34D83B4E
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 18:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-459e20ec1d9so12107665e9.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754584524; x=1755189324; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GHuAyfa+moeCbV6o05+Cmi2axPtL2sEGw4pdbmdJnjA=;
 b=SuYP0GP8NGu+x8hmF+4+w4Jl1qwrrt8oFXO3F977fgSiRCU/jWtrl+aB0A7n1LEKrj
 m2ttvl7gQd9vVUHtZUJGgM0QgQhHFOwbtdnXYQtgPxvscna0vNsMB2KviDWim1epZFTo
 9Yp5s7EDlXX+yw6J2ny5mbnpytS0RX3w51F1Qg+/x3hQp0G/6lnJanPdqRKohBU0EErj
 Ai1DUI3hFPP3fLp6Tp+Wzgn5/hOTnaleypdFg6o5Kv3OmcLMmb14VIdaBxHZI3mPYckh
 PGeRvOwvlduyB5bOsgUFq1lCICCZE+f0VkERoAKlBnEHiWuApmIBXjB+F0pYncBAN74Q
 nabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754584524; x=1755189324;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GHuAyfa+moeCbV6o05+Cmi2axPtL2sEGw4pdbmdJnjA=;
 b=jbi6wENgQLPH+pvo4i7uyKxXp9szK0YT8BOFCISHN+C81BTYU5mcsQCNwLHci40KVJ
 BXzVIvztKxRysg+jxTP/zrN4tgot9isS+/10XJoim6lwDgBjQZSBomu0P098lBfILI8I
 S2eJDn3JG/FM8V+VVeldV+QuiLqfVgCj75GVraWZMCDiwv3r7hPdx6DxREaRKiRASZ3S
 bL0jRRP1OVKYaZ/4u/wAVwo8cvK6ty3GGq2W/PgP6rbRD9HAMDQKRGY0JzYT2HifNimE
 FZdDKrqHAiH8kmMoLOekSVbUBwD6mt16ZcUXbvQajLaXzwc6x2/ZgD6U5thwCYTtZbLA
 aolQ==
X-Gm-Message-State: AOJu0YzJq+kbjWrC1DYZljeKOL2huIyXgUxxD+33Z4lC2ygwRFjzLWd5
 Br1vMXc/D+Y4lcKy5j76dBcHJ6LgZfZm0sLtgwWzj7Ey273f+CyFe0p2Znl5uplN7hjuiFsoOJS
 YC5YStI4=
X-Gm-Gg: ASbGncv7DR+y1kuJKcZtYM/NWI16f8asvXWLHqkilifHY7GcF+A3oGm6p0sfpouauOx
 9lr9EkRvHzM1AtT+4DirCruK3B00umfM43Wj8fm8KoqjzovrCM1bjh72bgeVbQleg4K7BWljs4t
 NYdHem+hyl9IyZxfVcJYU+NQRUh1kjv4iKziQUvWtb4dcQ/gm7SbkmiOUVylBG6pgK0e6+kUr+1
 TnnUvD4VlAAWxAOx27XPPH2zaeaDdtYV7qxh+AyTYYOklFkzA7NbJwARxl1pWnHbWNywkgNwy07
 go4SEQWSDkhaaO6zX5dEwsiEZA32qof32+QQ+GvegUZ2MdpLXeY41QSh4CE0kBx2dPpC/Uo4PwL
 qvp1eLi2Iuwq5T4ewdq6A4A9M1AG4AZE7xTbLEbRK0mAq64pYFkM=
X-Google-Smtp-Source: AGHT+IELZG5wFRZFJXu8KCWRjyIV/DIdRk3/3EacIwMWHRycRAVZSWVVekv6KSBRFfCdN9nvo2eJGw==
X-Received: by 2002:a05:600c:4447:b0:459:dfde:3359 with SMTP id
 5b1f17b1804b1-459e7479468mr64978855e9.32.1754584523601; 
 Thu, 07 Aug 2025 09:35:23 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5b84674sm108141375e9.30.2025.08.07.09.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 09:35:23 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 17:35:20 +0100
Subject: [PATCH 3/6] power: regulator: palmas: Cannot test unsigned for
 being negative
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pwr_regulator-v1-3-42a4105336ec@linaro.org>
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

In palmas_smps_val and palmas_ldo_val hex is an unsigned variable being
assigned the return value from a function that returns int. Change hex
to be an int so that the following test for an error as a negative value
will work as expected.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/power/regulator/palmas_regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/regulator/palmas_regulator.c b/drivers/power/regulator/palmas_regulator.c
index 2286eac93fb..7212062c8c8 100644
--- a/drivers/power/regulator/palmas_regulator.c
+++ b/drivers/power/regulator/palmas_regulator.c
@@ -115,8 +115,8 @@ static int palmas_smps_hex2volt(int hex, bool range)
 
 static int palmas_smps_val(struct udevice *dev, int op, int *uV)
 {
-	unsigned int hex, adr;
-	int ret;
+	unsigned int adr;
+	int hex, ret;
 	bool range;
 	struct dm_regulator_uclass_plat *uc_pdata;
 
@@ -251,8 +251,8 @@ static int palmas_ldo_hex2volt(int hex)
 
 static int palmas_ldo_val(struct udevice *dev, int op, int *uV)
 {
-	unsigned int hex, adr;
-	int ret;
+	unsigned int adr;
+	int hex, ret;
 
 	struct dm_regulator_uclass_plat *uc_pdata;
 

-- 
2.39.5

