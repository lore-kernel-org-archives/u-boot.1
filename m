Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C33E7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BCAA86E28;
	Tue, 26 Sep 2023 16:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Un3fcqeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 117F686E1B; Tue, 26 Sep 2023 16:15:49 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11E6686DDC
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-79f9f5135f8so257267239f.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737738; x=1696342538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CIY+IMzOGUnwEh2v/ox7d8p+a4TGa9P+SJuVMp19Ly4=;
 b=Un3fcqeRMqAFiUFiwEjcbw64X+IAdWjGYJNzNLobaqyyIuFhHYytW12EOQ38AKbvoj
 F0SYAb/rdznkNmA3EMpOvhb8Jr11dD27Inep8jxiwsoZOYtqpp+TmBVRaP82L4YLaseI
 61KDTID36Sri2FgKO2+oYIvRLeKFtfpyoslcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737738; x=1696342538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIY+IMzOGUnwEh2v/ox7d8p+a4TGa9P+SJuVMp19Ly4=;
 b=Xv/QWylIDqO98KVWUnCgVXqH78HN+v7E54NP/pbsn9SLgdT5DUexNd8ZG6+A2vuZvM
 Ox6rmEfDUdg+eF8zlidsjDMLN4uO0qdjhM45BaF4ZZMSAdOQLJIIpYRz7ntKJOQ0j0an
 wA0WTbZbFDJoB2cuZsW3OIs8m3bC1Q5wTdS43vzUBCpOfQfqSJzHkIwhCV5EF9Yb5Fot
 5v7IkthPvDCb/OsdgkhXKR1qRTIrJ92BhuG2qRLHHc2Ian+C4YHUFFQKqZwnHWGb67fN
 FPnP20fJfoOusqEnEqf0SWl9xjt/kKoBkQFKRtw57PZaM1ir4TqYrNMwaM5lG2Yx8Gv6
 UDUQ==
X-Gm-Message-State: AOJu0YxqlnEsYPmbkkTE+6EG2V76gMteomijajUZxWNKA21otssn7qWc
 r1Cspzb+kWs1w+mh2sH2FYII+chrOFWK5woExV0=
X-Google-Smtp-Source: AGHT+IHSfxjrL3pPyR0Usboq1MSJnbWjxZkLJOROg+eWAx89bO8P4rRfz4/k7dM9R8yYEe+vQlgvTg==
X-Received: by 2002:a6b:e20e:0:b0:783:4e11:76d7 with SMTP id
 z14-20020a6be20e000000b007834e1176d7mr9299050ioc.21.1695737738430; 
 Tue, 26 Sep 2023 07:15:38 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 15/44] doc: Clean up SYS_MALLOC_SIMPLE
Date: Tue, 26 Sep 2023 08:14:29 -0600
Message-ID: <20230926141514.2101787-16-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

Move the useful help to Kconfig.

Drop mention of CONFIG_SYS_MALLOC_SIMPLE since it doesn't exist.

Correct a 'CONFIGSYS_MALLOC_F_LEN' typo

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to clean up SYS_MALLOC_SIMPLE documentation

 Kconfig                  | 15 +++++++++++----
 README                   | 18 ------------------
 doc/usage/cmd/bdinfo.rst |  2 +-
 3 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/Kconfig b/Kconfig
index 57afe597b0c8..a3061c86124e 100644
--- a/Kconfig
+++ b/Kconfig
@@ -277,10 +277,17 @@ config SYS_MALLOC_F_LEN
 	default 0x10000 if ARCH_IMX8 || ARCH_IMX8M
 	default 0x2000
 	help
-	  Before relocation, memory is very limited on many platforms. Still,
-	  we can provide a small malloc() pool if needed. Driver model in
-	  particular needs this to operate, so that it can allocate the
-	  initial serial device and any others that are needed.
+		Size of the malloc() pool for use before relocation. If
+		this is defined, then a very simple malloc() implementation
+		will become available before relocation. The address is just
+		below the global data, and the stack is moved down to make
+		space.
+
+		This feature allocates regions with increasing addresses
+		within the region. calloc() is supported, but realloc()
+		is not available. free() is supported but does nothing.
+		The memory will be freed (or in fact just forgotten) when
+		U-Boot relocates itself.
 
 config SYS_MALLOC_LEN
 	hex "Define memory for Dynamic allocation"
diff --git a/README b/README
index a1f90642274d..60c6b8a19db1 100644
--- a/README
+++ b/README
@@ -1281,24 +1281,6 @@ Configuration Settings:
 - CONFIG_SYS_MALLOC_LEN:
 		Size of DRAM reserved for malloc() use.
 
-- CONFIG_SYS_MALLOC_F_LEN
-		Size of the malloc() pool for use before relocation. If
-		this is defined, then a very simple malloc() implementation
-		will become available before relocation. The address is just
-		below the global data, and the stack is moved down to make
-		space.
-
-		This feature allocates regions with increasing addresses
-		within the region. calloc() is supported, but realloc()
-		is not available. free() is supported but does nothing.
-		The memory will be freed (or in fact just forgotten) when
-		U-Boot relocates itself.
-
-- CONFIG_SYS_MALLOC_SIMPLE
-		Provides a simple and small malloc() and calloc() for those
-		boards which do not use the full malloc in SPL (which is
-		enabled with CONFIG_SPL_SYS_MALLOC).
-
 - CFG_SYS_BOOTMAPSZ:
 		Maximum size of memory mapped by the startup code of
 		the Linux kernel; all data that must be processed by
diff --git a/doc/usage/cmd/bdinfo.rst b/doc/usage/cmd/bdinfo.rst
index b287d0ff7369..5261085a068d 100644
--- a/doc/usage/cmd/bdinfo.rst
+++ b/doc/usage/cmd/bdinfo.rst
@@ -106,7 +106,7 @@ sp start
 
 Early malloc usage
     amount of memory used in the early malloc memory and its maximum size
-    as defined by CONFIGSYS_MALLOC_F_LEN
+    as defined by CONFIG_SYS_MALLOC_F_LEN
 
 Configuration
 -------------
-- 
2.42.0.515.g380fc7ccd1-goog

