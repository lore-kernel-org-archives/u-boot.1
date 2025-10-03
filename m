Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78B3CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C888F838FA;
	Fri,  3 Oct 2025 22:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F7QeMpgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66B4D83914; Fri,  3 Oct 2025 22:39:29 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6AAD838EC
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-90926724bceso219933139f.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759523966; x=1760128766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vqx/5dVUAHYQg8lAwHcvlU7rsx6KqUc3nXcoS5u4vmk=;
 b=F7QeMpgwrV1VupEr7HKP6WJqc8mfJPqlqdb/vgIqCwGeemykkezpi2+sG2qZa1yXVr
 Q1MwCG7EqshUwB6E3fVeo8ijY2axFl/OeQ4pajqcQ4884p9RdTWkS71x61X0g5SlTK2c
 bvBgqoTkSY8HSM/N/d3gluZMU9/CEXq7QZw00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759523966; x=1760128766;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vqx/5dVUAHYQg8lAwHcvlU7rsx6KqUc3nXcoS5u4vmk=;
 b=Ittg8TqD2ZJjcSvS6+YfpmvodMObxdHOsOQjWWoEc5YtouY4/96Asb7vZO6gZxGZxM
 ejIkK+UoUncGx9Pkdptrj/hevUuvz6QeAH+1/zouhv7HObjc0GyJw4z0nE48Jf20pspC
 FQSX9BD4zAT5tlQt+80FX+TQoUcFgMI4NMFxjH70CalMkPjhibIJna+tHJcQLxYabzuD
 t84FcEHzUi2u4eag0bPuNqofWKDKu4wdjoiHXYeFIqYBKbjmQKYIbiYabRevXmHM/aUn
 N+L8Vs3L56No/u+FslMWTbBqD/C0w7QOqmvaCiYgQQTgymxz3n/ctc/hfr5o4MuCw2r5
 aXNg==
X-Gm-Message-State: AOJu0Yy2epamxpdUD/DzJwQtbcq+K4vumLzMM2FRK5H46Ih2uRm9yvYx
 Zyr4F5dN8KwjdfYXf2NmzSHewSWsmt3+2QPdgS7S/diyJL2Ehb+AbpGR74oHb2EqzKt85wfTBat
 3vnbcAmM=
X-Gm-Gg: ASbGncv1J66WwgaqyJREpgoOgIn/m9jOsYwA7naMHL7/PFl2k8FcohQNbu1bw8Mtlb4
 wSJ2jdqaSoR5gryGg0KZzUXeVpYM2g1YN7bVdgZRZrNZEYkKChTp8lvPfNFr4fIJBgmZI4xyIT0
 oVyxWiJx5VQQu4Y6ZdTwjbJn+EEUymZOX4fRPhyO7/IdHn3zsxZ76UGBZcE98NflxcrbdR20vem
 zDkZOyHutbBEsEadN4anklS3CBDPQwBIucBYv3xz0Yui5tYYT0umz7JuyebnwyXSrhd/vPlXqSX
 Joz9wLCx8CWQbE4ZVSuTGEfMO8pPqICFtc/8XRiL/BujH6RRWUoxx74SIK16t0ulfkHgSsENlPd
 eP0dzk+AKXbOdrIECey2QujQ6LltODLVunQmoSop0HadRLSQe8JY0/batfP3N4gOr23MC2QYFgZ
 WrtnahTpxjsu+Eh9KYxuBKUgM=
X-Google-Smtp-Source: AGHT+IFxd8LPE4l8yLeC97HSrUXKvdR4m05hPzKMhU+6iSFSSQA/u1HC2ppxgF9jd5J26T87LEmegg==
X-Received: by 2002:a05:6602:6404:b0:911:c5f7:e4e with SMTP id
 ca18e2360f4ac-93b9695dbb2mr535458339f.2.1759523965658; 
 Fri, 03 Oct 2025 13:39:25 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ea313d4sm2233514173.20.2025.10.03.13.39.24
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:39:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] power: regulator: Correct dependencies on SPL_REGULATOR_PWM
Date: Fri,  3 Oct 2025 14:39:24 -0600
Message-ID: <20251003203924.1030022-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In order to enable and build with SPL_REGULATOR_PWM we need to have both
SPL_DM_REGULATOR and SPL_DM_PWM enabled. Build-wise, we can have SPL
have PWM regulator support without enabling it in U-Boot itself so drop
that dependency.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/power/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 65b99e896562..1875e61967c0 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -143,7 +143,7 @@ config REGULATOR_PWM
 
 config SPL_REGULATOR_PWM
 	bool "Enable Driver for PWM regulators in SPL"
-	depends on REGULATOR_PWM && SPL
+	depends on SPL_DM_REGULATOR && SPL && SPL_DM_PWM
 	help
 	  This config enables implementation of driver-model regulator uclass
 	  features for PWM regulators in SPL.
-- 
2.43.0

