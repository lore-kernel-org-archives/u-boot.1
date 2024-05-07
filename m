Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699FDC25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 17:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0237F886F1;
	Tue,  7 May 2024 19:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DUpJv3Mj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF4C688719; Tue,  7 May 2024 19:56:41 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0FFA883E8
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 19:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6a0f889877cso12851996d6.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104598; x=1715709398; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bD/L5Xe5us9AepjFIeV0rC0bHnHQRSru2Sr3uCB11fM=;
 b=DUpJv3MjjrSPUcCOj4AWNmlflDs/7k8Tf/WfbDOx3deJ+VUhldComs4a4wpFoRyVC7
 yImRb6zkfYXuMtuEp4JJ+YgKTdLXDBv5wL7XAMi7kHkZ3wErNw6eyovLs6ScqJQ9xhEP
 ruc2emwVNB6vaAySzHV2VpSO3tX3uKmZmDrdequ7HDKHtrsjSfWn/tvwHlaWaLq6ThqF
 3FN63FYT4V3B8qr4yX9d6tGs9igqacML9J4kc/fX4DwYeeCg8Yz/e+wOUeZu1Ub9k1g8
 xjfT6lFDp2nrcXLVuiK8LXlYonyx+VOG2ceD2l4xnnNfsm6LGUyxfmEDWJvYS3xLuve7
 Km7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104598; x=1715709398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bD/L5Xe5us9AepjFIeV0rC0bHnHQRSru2Sr3uCB11fM=;
 b=DAzZaQ8j7yu+LRi96d3elND0vAEUUNUN7T7ee1ix6VbPxJstplHmLKqDefdj36D4cb
 dXWreMhQM+JcGObIn3CxH2FB5cPwrX6ro58wd363J+KO+WbdL6Wvt5UhqC6Eq1IXuNna
 KaRtFWA1Nn0LkH6tuB0gooUwbR2t73uARYOeCx9lqN6Yj2wxk9V0IQWAgNrqFRS1LNb2
 Ji5yeE5vNzFc3WxV4Drv4PmgQxiJeniEk36IqN037WJ6FJ3gFUajVWbyCq+amaA0z7hS
 VwGNmh6dEG+5PHJG7UIJxix2y5NgkyHRg6pUr233rEJuIk5ADQ/NNPOtncSA7GZjkeZf
 k1Mg==
X-Gm-Message-State: AOJu0YxsXrti1vMILUtg5q44Qjgpe2SkKP9ltHRtYuRnStTpx6kEvE0r
 8FO/EVCZ7suUszwksShqiIafqSyRJB/imuzA3096P2/x5b+T6j8UF0VqUWGfNpGIoIKmTjoecv7
 r
X-Google-Smtp-Source: AGHT+IGVLX3tOXuiC84JJe4onw7W2ZcoCTq4n4Rg3gbmr5lhJAi7U1KaEsxdd38KQm85IugCQQ9wmg==
X-Received: by 2002:a05:6214:234d:b0:6a0:c903:5cb8 with SMTP id
 6a1803df08f44-6a15157f869mr5839586d6.65.1715104598408; 
 Tue, 07 May 2024 10:56:38 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.10.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:56:38 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alexander Gendin <agendin@matrox.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 11/28] makefile: add mbedtls include directories
Date: Tue,  7 May 2024 10:50:53 -0700
Message-Id: <20240507175132.1456512-12-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507175132.1456512-1-raymond.mao@linaro.org>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
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

 Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 7321fe1499e..80db1dfd8ec 100644
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
@@ -840,6 +846,13 @@ UBOOTINCLUDE    := \
 
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 
+ifeq ($(CONFIG_MBEDTLS_LIB),y)
+PLATFORM_CPPFLAGS += "-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
+			-I$(srctree)/lib/mbedtls \
+			-I$(srctree)/lib/mbedtls/port \
+			-I$(srctree)/lib/mbedtls/external/mbedtls/include
+endif
+
 # FIX ME
 cpp_flags := $(KBUILD_CPPFLAGS) $(PLATFORM_CPPFLAGS) $(UBOOTINCLUDE) \
 							$(NOSTDINC_FLAGS)
-- 
2.25.1

