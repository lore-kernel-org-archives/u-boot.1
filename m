Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA841C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D6A08850F;
	Tue, 28 May 2024 16:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gHrMoCW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6788887D70; Tue, 28 May 2024 16:13:11 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5828288523
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7948b768497so27702885a.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905588; x=1717510388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qf2APuE+yx+tCZ+epmFmcnRLyTR7ef8aF9rr/PJMvTs=;
 b=gHrMoCW3hnCAbfzjUaILf+TMxD3dQr2kSrUsHG7QvAfKyAlr1ji7zaTSjCfmsFqMPp
 EwzRX3BINx7ASrA6edBDxRmY2CsRLuFxxRLkdlhK2LlDuDhlHDbCN7icfW+Jrk3x+3UZ
 Mw8HzP7aPDxpflmNJuRk16/J0nj5jpiulldfY5WBPlZX3dsPv/i33z2yWBafN+sR1NsA
 FWGInohlS3Jd5z3PeLaag3e9e6yWKuPaOqvOVsAPGQqbnNXmtLgSf3QUjlszJbGMqqsb
 DQOibZaRRd0ahgtLWEg5jZCINI7cgx/XyOovEr1lUfQqF+jlS+YqdU6fdYPoDc9nWNOv
 LoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905588; x=1717510388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qf2APuE+yx+tCZ+epmFmcnRLyTR7ef8aF9rr/PJMvTs=;
 b=qOm51D2GtiE4D0DgaUYHghVluUluthIpichGFkSn3RcBkMbIuit8KggLx1kuJU4Xbw
 QyHtXUtVN3wPjfJvkExXv5dn3TADRSD0KJn1j91/hFfDL6vtZ5+65Cox2BnGWvefifzR
 jsW+lGrFeW+ebLC/0id80yyt0vjaMyqvt5JsteweLpv/iOIIEH/W150CU4v45xYIxcr4
 ZvNIYzAOteAMveqKPvm+Hwxiwc4SXH5ua8S+P1z3d4j1ZbEytyjjpWXoe2VETwnGRwrA
 Tm+VtThCeDRy6qXhGUdEA2yneEpGf1UoP1bU9TggM2N2GgKDf9iXs/ALmwR/L72sBUw8
 59mA==
X-Gm-Message-State: AOJu0YxWel6bylzWU0J48lOch//mp+adYmew8uREl217nlyxkkks9veF
 kK25yWIk9tQ7Mx3N8/vxi4nd+NJsdrNv4i78Gziau/0TiFminkyB9a9EnwCvWcO25M3IFs4gEST
 tuRY=
X-Google-Smtp-Source: AGHT+IHldt58z4g7y513IEP57bz8puO2lf1+SrJ9M6I9yecweKO1MMJSbvOcpMe7ez0NQaJLrE2pMw==
X-Received: by 2002:a05:620a:4d09:b0:792:93cf:b91d with SMTP id
 af79cd13be357-794ab096e86mr1118984985a.40.1716905587941; 
 Tue, 28 May 2024 07:13:07 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:13:07 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 08/25] makefile: add mbedtls include directories
Date: Tue, 28 May 2024 07:09:19 -0700
Message-Id: <20240528140955.1960172-9-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528140955.1960172-1-raymond.mao@linaro.org>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
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

Add the mbedtls include directories into the build system.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.
Changes in v3
- Remove changes for PLATFORM_CPPFLAGS.

 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index 79b28c2d81f..2e7eb51401f 100644
--- a/Makefile
+++ b/Makefile
@@ -829,6 +829,12 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
 UBOOTINCLUDE    := \
 	-Iinclude \
 	$(if $(KBUILD_SRC), -I$(srctree)/include) \
+	$(if $(KBUILD_SRC), \
+		$(if $(CONFIG_MBEDTLS_LIB), \
+			"-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
+			-I$(srctree)/lib/mbedtls \
+			-I$(srctree)/lib/mbedtls/port \
+			-I$(srctree)/lib/mbedtls/external/mbedtls/include)) \
 	$(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
 		$(if $(CONFIG_HAS_THUMB2), \
 			$(if $(CONFIG_CPU_V7M), \
-- 
2.25.1

