Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE1DCEBF93
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 06:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21DE783CCA;
	Tue, 18 Nov 2025 07:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BDOmYgha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B9583C96; Tue, 18 Nov 2025 07:40:44 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D82683C64
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 07:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-787eb2d86bfso51462917b3.2
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 22:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763448041; x=1764052841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3iG1aNlbgS1JQWqpOB4ILYy6J45Ne7irOoEunRy9Eo=;
 b=BDOmYghahPgjFztp7CU/l7ozsh4hQqVyaqkHS80Peu4W0lSeZ5jW3VfrMCbIkxWKsa
 icXfRdb8Se8tZbObY9hBkVJ79C/Rui+EJOf9LQqy1w62nWqZV0MW4LGk7FiNJPoRD9th
 30DxkS0PLKQ8h5ksHR4RyrNu06Xj4oWKlvNzi3nLNdHMANM4MwIQc9T2zbIyDLody6+Z
 luzL+pCi8O4jvOSj3SfVofoZrKUgGmugUS+B63L/hQ4ixPZRIMgWTALgh0naWbNPKoKK
 L4lIjSfd7+TPVRO0caimyFjQQKdKsjtaAg/z+wL7QJkAtnY3WJSoBdBCaNUwPvnED8jk
 7DKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763448041; x=1764052841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T3iG1aNlbgS1JQWqpOB4ILYy6J45Ne7irOoEunRy9Eo=;
 b=LItYFRTbJOci3S6YVPBrBquLABW8sZ6vtcfQrE1H0tVlrdZwvJaEUi7wWKBb2MixML
 HR4EvQqUVEeU94OgWHtXjf+lf8pZB82VKgRVR/0GEjDVp5zAhdgMHl9GTR80s3vlMeG+
 IKIyc8xO/rovdIVCPdgYveXOhVj4JQo6I5L5+PEFuM6MBul7T7zJGtdOj5rVsFJkVySI
 SUnVnU9IF7uqBNqtkfm41On+uPDVO6E5mrCAp02lTVbglrVkYDUZn7MM6JCrS7eY9tWF
 bKmAhcowDzNiyX+n5shakdWzCTDiokT5hFfRANN3A7YaYiOMkm2WIdw6BBUqmjP1MQC+
 BjMw==
X-Gm-Message-State: AOJu0YxFCLqfhILON4f8PaUjxw8zzzCtMQzyPc2KGN+VKwA/Hm3m92H1
 IE4V9XT/03KzXearlyG+0OudU2Y1j+qSTHlNl8pY7DdGBkdOtISm3zc+FJ5Q
X-Gm-Gg: ASbGnctwZ1yKznelgXP8BVxq9sKIy0rvdp5YF7A4OYV6U5CwDB4aRdQI9qFWGTCfgcN
 huCLRKtpkHkClIKfq/1clSPDAKZzq/vvVxhxWcN33vaEdeR9xU9GA2SqQ0EbHhiSHZ5S+h8BHIC
 2NAu/+Ikb92m2W3/KKgaoa8tXUzCGBsC1Mz0tulf6VpG/qyRgxCS7Ypquofn9JupZ11xKv7v3eM
 JfraFiJWO0/soxSfRdpwP8tTpeC+GHxWcwhHx0TXSp5BY57YSuyBudrO4kbufbZJno/D3oMa+CT
 rlt6K6t7/ZkpNA/L7et2eMIkvo7+VZxlIRPj695/A9lQHqS2w7YL/b5JJzJMaCkye+SCMzy4pUS
 10I/shq1Zy+Mpi2bFk0N7+IlqZe1auBvV35NPS5nORs/B2p6F3HWxmJstGr7tiw3y0V9lf88CBs
 GHo0fyd9ZHBERTeSY=
X-Google-Smtp-Source: AGHT+IHRgb/ED1Ld6aE6diLEXxzjChe8ldQe3c4Z1RN+p7H+uIJiXoZN6odhLBYGgYfnHSUzk6pDkQ==
X-Received: by 2002:a05:690e:4289:20b0:63f:7617:e338 with SMTP id
 956f58d0204a3-641e7655a4bmr10741299d50.53.1763448041026; 
 Mon, 17 Nov 2025 22:40:41 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78822128160sm49781967b3.32.2025.11.17.22.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 22:40:40 -0800 (PST)
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
Date: Tue, 18 Nov 2025 01:39:36 -0500
Message-ID: <20251118064000.14613-4-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251118064000.14613-1-malysagreg@gmail.com>
References: <20251118064000.14613-1-malysagreg@gmail.com>
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

