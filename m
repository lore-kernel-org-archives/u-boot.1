Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CB0D41C01
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 08:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6225C83CB5;
	Thu, 11 Dec 2025 09:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y2XIh2LZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 280B983C9F; Thu, 11 Dec 2025 09:05:53 +0100 (CET)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DE18830E4
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6446c924f9eso606734d50.1
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 00:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765440348; x=1766045148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+eQlZZ5Wty/TGmJgzChRCqBtAhuW6plHbwUSo23RDiY=;
 b=Y2XIh2LZ6Q2KWe9yQAJpQAzv3BlNxwW+J+Vfi4anuehKp/0cln3yiI0m4wpNIBZETw
 VLGR7NXDlyhppfbLPzEdPbHCbkhtCn+qbJ0mrm83kNs3O12hkVDICa+4UwDi03m4yE9e
 R9y9XLtFE1X3pUu9x0RpBqqAmc2tsh/e9tfyIGcYQMKFpNkhKy8EmVmBw8rJObtgI4LM
 LqqzHQoxMX9y0g3CpITTZCWYSl4kYbaA0bNM4iS7gUhn0SHNoUYkSXOMHtKCQInNQUoM
 rFvil37vchNz2N47RwbguPgoEEvb+fPwIG+1zoEeXy1nnaH732D5PUoTeaJtbAKzA7/M
 JiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765440348; x=1766045148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+eQlZZ5Wty/TGmJgzChRCqBtAhuW6plHbwUSo23RDiY=;
 b=fiFEqlMLmIhMDVNxjzeVR9u+olmdIAhS3gW1R0McIFNyQ8aD09O7/RBIMg+XC3V0uJ
 6jzJ6ueBPJTeIFwk6Jx8z/EECtYxGYVnHTdfF6a5Oef9jc9XkkBqhLvYcMcbTLfu9WER
 KEkdCCt9eYtDRTGFvqjJgMCT0wmSkP4lSc+hMEYv3I3+1nxGQKgDtTQYZC4TGtr+LqPh
 0a/tspXkG1BPgFbtSaJinKqI/GI08vHbgCiu8PP5EQMQhTINvr6c8yXdK42XEKDEG88d
 KaYjRJDs3xUTTBojZKruMRlV6bDWVRIrXoZTCGNx/IQheRjer6lCKy+Le1H9U0n4lsCD
 0axg==
X-Gm-Message-State: AOJu0YyRWSsM+jYvbDMU86Sk9vwbV/nyXiZoKAceNhglFD5LqGzUoolK
 JOj+hVBr82lqv85YnxTxSY3mS00kCt3si6OUSzC08A7d3i2zu/v01GaEDBtH
X-Gm-Gg: AY/fxX7nwDDeDl1Bd372wMj3J+KAGi0PJDCZ2Rj28/Q1vkwMsmt/3ppKG1YJNGKTPyc
 49EUS5OXrfJmHIibjPJ2SK8X0R7zvjpBmR+4GF32/5DgRHsO9B9T37OeLAfjOc+oW9POJeM0aoa
 /HXqKbVkLiW8mE4Uu4Sth9oqIRWFstlhN136lbzHPw/UaIk5mAMw36h1SJZd4jC+HDQnsw2y6Yh
 ykla6OEJ64d83dF3LjwC27GooOghBh0XKKoxG2XrpDdCLkvxtcOwtRnB8Mu7TAgaTgBzoZH7i4y
 ymCZNFq1O5/Dorc3NBL0pi3vs16G/G5R1DBfsBqmiDE3hD5uiOT5HzqX7EqC/AY+g1uhtttS/Q5
 XxmcqDVU3QENRaWpyDxUkx/dXziFrSLyJi80jOEK9fL8Y71ikl4jWs3cBpo1EvFkAT9yM3Z5t3w
 uu7NMXE+PkwRakJCzXQiSwxaiNCg==
X-Google-Smtp-Source: AGHT+IFDC8f/iMGLfImcve9ySUGqhV/78nBOoyM29yyBlDFRBAXns8Hfb9KtMvRTrSOnGt0MN2sEmA==
X-Received: by 2002:a05:690e:128d:b0:644:7b59:4219 with SMTP id
 956f58d0204a3-6447b5946f7mr597054d50.10.1765440348497; 
 Thu, 11 Dec 2025 00:05:48 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78d69d83a85sm7256657b3.28.2025.12.11.00.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 00:05:47 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Philip Molloy <Philip.Molloy@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 03/12] mach-sc5xx: Kconfig: Make EZKIT and EZLITE carriers
 mutually exclusive
Date: Thu, 11 Dec 2025 03:03:54 -0500
Message-ID: <20251211080414.5363-4-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251211080414.5363-1-malysagreg@gmail.com>
References: <20251211080414.5363-1-malysagreg@gmail.com>
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

Support for the SOM-CRR variants introduces library level changes that
are not modelled in the device tree. As a result they cannot both be
selected at the same time, so this updates the dependency in Kconfig to
prevent them from being enabled together.

Reported-by: Philip Molloy <Philip.Molloy@analog.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>

---

(no changes since v2)

Changes in v2:
 - New

 arch/arm/mach-sc5xx/Kconfig | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index 170177f4e10..b7c298fe279 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -241,21 +241,27 @@ config ADI_BUG_EZKHW21
 	  This workaround affects the SC584 EZKIT and addresses bug EZKHW21.
 	  It disables gigabit ethernet mode and limits the board to 100 Mbps
 
+choice
+	prompt "Analog Devices SOM Carrier Board Variant"
+	depends on (SC59X || SC59X_64)
+	default ADI_CARRIER_SOMCRR_EZKIT
+	help
+	  Select the specific EV-SOMCRR carrier board that you are using.
+	  Using a SOM without a carrier board is not supported.
+
 config ADI_CARRIER_SOMCRR_EZKIT
 	bool "Support the EV-SOMCRR-EZKIT"
-	depends on (SC59X || SC59X_64)
 	help
 	  Say y to include support for the EV-SOMCRR-EZKIT carrier board,
-	  which is compatible with the SC594 and SC598 SOMs. The EZKIT is
-	  mutually incompatible with the EZLITE.
+	  which is compatible with the SC594 and SC598 SOMs.
 
 config ADI_CARRIER_SOMCRR_EZLITE
 	bool "Support the EV-SOMCRR-EZLITE"
-	depends on (SC59X || SC59X_64)
 	help
 	  Say y to include support for the EV-SOMCRR-EZLITE carrier board,
-	  which is compatible with the SC594 and SC598 SOMs. The EZLITE is
-	  mutually incompatible with the EZKIT.
+	  which is compatible with the SC594 and SC598 SOMs.
+
+endchoice
 
 config ADI_SPL_FORCE_BMODE
 	int "Force the SPL to use this BMODE device during next boot stage"
-- 
2.49.1

