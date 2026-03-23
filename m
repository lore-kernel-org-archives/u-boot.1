Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E7EF483D7
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F71A8422D;
	Mon, 23 Mar 2026 20:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EcML09WV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64B0184207; Mon, 23 Mar 2026 20:53:02 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28F1A841D6
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-40438e0cba6so321672fac.1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295577; x=1774900377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+D/ZCTYPWw1vAazJOc0yUC+0idzFQNIk1ixBs43WVfM=;
 b=EcML09WVmBNdcv8am51O4FrreQU3qIFmvpxTmXFjaTFxUgYpb7+N94fTp/yb1py1QB
 4eNAlShCFWtvzyT/pbWxUOkYxaKWh+PqnKTj/NuV+kTYCBi3Ht2BnGDllDZ/DSCjzJUB
 MIGTshnpD0odUgNPjqToFP9keJkhraoHQCeUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295577; x=1774900377;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+D/ZCTYPWw1vAazJOc0yUC+0idzFQNIk1ixBs43WVfM=;
 b=iCL5+mbyjHbDfBeTRU66heYBKsT9WY2EJy09AYfGd+swkXzgr6SIxWOMDpWh0IKRY+
 IJrUFkzghSg8JYwIjL2XlBFSXs/FLaL5SSTbaSiIX+KmUCJtrwl9drp1h/+iI9vS9/E2
 m09q/6RYSkinE+ohdTPybD/LACA1iJ3wwHz5LzjKGsSTYKlTPlalIPiW5ZlnJKgkbjl1
 8PtJwOnXn9e3jMcy9M1dRUVSVAtUYmqtbwFY1EHa83Je0Fkwopqbc1ECjvsY2KCY5s/d
 qcFAJDTg3NISUBnNtF8VesBUZ72YOssWRNtnF4kdw60NzuPoAH04sCwm9hHJeFe38/5A
 axoQ==
X-Gm-Message-State: AOJu0YwwE1T1jIhdUYeOmL27RoNIM0c6tA1eEyAs9p3Sjp+2rzvfwJaD
 70y/+p4LSQNnYybcNlqbxbO0ya+C0pv3zemODmQKiwEr+608qRID22BHUq9qLC4TUkY/vshnAek
 y3V9BfF8=
X-Gm-Gg: ATEYQzxYtfT+vEOfeUNF9DG1DowvNVzg/MV4tUR0u+R2Zt7afN1Nbg7Kg7hSCtd9LAs
 ShpwvV/zPXeS8QPhB3YKn1S0o0RisfunkKLw450rVhe3OYK2qohLqv8D1/EOx4Ye9UHM/L1O/9t
 +/SoKGObMLLNqnHoXqVgC4KdoWbOGao7941hJfDE/QRwPTAnffi9FTVPd++FuJNJTDaQSVAFPnj
 8s8G6Dpu8ONet5LlmJUTXnMs06kl4YZokh3wWib6vitAWExETyXZQ/vZpCvV0wTtACN0UJtovdO
 d4J0tqFk38sTqqc6HE0nEyj61NFp4XEpg//S0R7e9rB4O/1I1FBsY/xhw75Dy1rziTy/jMOdJZF
 D8r9pMNZmUeDke4u9IYjaeCc1ZQ0c0IMtxORzLKtuZbHBoVltXGj5JvaC3f6kMvc089CePwPMCU
 Zqa8PwQGXm1hxxrOf/F5e+ptB6HX4I8PWOy1HtoIQ12UEuOg/Hbquxs6xeoJkTGvLlvElrGzo+/
 bx7dZsKDgHJdWWqnX4cETR0bio5W1pUvs6MMJ+a2O3TaJwKdi0=
X-Received: by 2002:a05:6870:3168:b0:409:4a88:aa53 with SMTP id
 586e51a60fabf-41c10f4da2cmr8823295fac.13.1774295576742; 
 Mon, 23 Mar 2026 12:52:56 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c57bdf2b0sm5330214fac.7.2026.03.23.12.52.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:52:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] spl: env: Correct dependencies for SPL_SAVEENV and MMC
Date: Mon, 23 Mar 2026 13:52:55 -0600
Message-ID: <20260323195255.2363499-1-trini@konsulko.com>
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

The SPL_SAVEENV functionality, when working with an MMC device, can only
work with SPL_MMC_WRITE enabled. This however only works with SPL_MMC
also being enabled. Update the dependencies to show that if we have
enabled SPL_ENV_IS_IN_MMC then we select SPL_MMC_WRITE and make
SPL_ENV_IS_IN_MMC depends on SPL_MMC.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/spl/Kconfig | 2 +-
 env/Kconfig        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index d1a85f50209e..57b2bef5e541 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -729,7 +729,7 @@ config SPL_ENV_SUPPORT
 config SPL_SAVEENV
 	bool "Support save environment"
 	depends on SPL_ENV_SUPPORT
-	select SPL_MMC_WRITE if ENV_IS_IN_MMC
+	select SPL_MMC_WRITE if SPL_ENV_IS_IN_MMC
 	help
 	  Enable save environment support in SPL after setenv. By default
 	  the saveenv option is not provided in SPL, but some boards need
diff --git a/env/Kconfig b/env/Kconfig
index 5979f7faa996..532adf884da8 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -847,6 +847,7 @@ config SPL_ENV_IS_IN_MMC
 	bool "SPL Environment in an MMC device"
 	depends on !SPL_ENV_IS_NOWHERE
 	depends on !SPL_OS_BOOT_SECURE
+	depends on SPL_MMC
 	depends on ENV_IS_IN_MMC
 	default y
 	help
-- 
2.43.0

