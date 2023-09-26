Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B73CE7E638
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCDD886E00;
	Tue, 26 Sep 2023 16:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iqEhUcy9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 622C686E14; Tue, 26 Sep 2023 16:15:46 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B9C686DF0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79f909071c3so301713939f.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737734; x=1696342534; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHpIRDWBXf6KOoJx7Ej9NjLfp9hgziMIZJVTdZ06WSs=;
 b=iqEhUcy99HZtXDXiqRZRkNYUY1vL6Xv2+bjBYOQEcNWMQxaLWqLAuM/ott97BB+Pet
 yyZa/pYGZrEoo8zq5WDeUxeVL3LA1MC/HTGlQzThHlL5CLLH7rUB9T4YolBanz8n6YRx
 BgzXaaurgLk6d3FnJrzOPh1VFmx/4cAC5kX4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737734; x=1696342534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHpIRDWBXf6KOoJx7Ej9NjLfp9hgziMIZJVTdZ06WSs=;
 b=uBTsb0vyHqg1NrKBhll1He7ub1kPB+IF8XjgBmOTQAVAme4TS3ywCsqaSlcLNRhELf
 0qmNVRQM06thzQE6qI4AwqznCJaK67+d1bVPnxPJhEWQVVumFfXKJb84k0dxIro1OAQq
 VP2YeDEMv4vMNyGjfsd2OH0O60DSv0+rf87sEfBOyCNv1UWLFSpTYKOWWYHdgV1mUfUV
 kO166iB8Pow4E6WuiNsCuM7paEJukSy8dilCWgSaZHCVGlEmiPYcNOi5s7ZNOVvvwNPa
 AWJVXFKg87pH0sD9x1UZ/W3x5bjU6G0BMrYSLqakpk04/AUSQS6Cglk1e8IyQWM4KlP6
 uYDg==
X-Gm-Message-State: AOJu0YyaG4melDhODlkjQGuaHc+3crHOKpivhFDsmudSe7GrcVlbqGyx
 UgJ9uMegMTn7l1i7IdOlL4Yl2xSrv2VFNsh3MZg=
X-Google-Smtp-Source: AGHT+IFXfTEbB3xvk55CIh2M0dOqX25wr3wlkZwHaA/CqG4EPHO42LInQdfQT/M1GsjHJA/JTEJAQw==
X-Received: by 2002:a5e:9749:0:b0:785:ca70:46a2 with SMTP id
 h9-20020a5e9749000000b00785ca7046a2mr10056615ioq.4.1695737734640; 
 Tue, 26 Sep 2023 07:15:34 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 11/44] spl: Enable CONFIG_SPL_SYS_MALLOC_F where needed
Date: Tue, 26 Sep 2023 08:14:25 -0600
Message-ID: <20230926141514.2101787-12-sjg@chromium.org>
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

Enable CONFIG_SPL_SYS_MALLOC_F for boards which have a non-zero value
for CONFIG_SPL_SYS_MALLOC_F_LEN

Note that the default is yes in most cases, so no changes are needed to
board defconfig options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to enable CONFIG_SPL_SYS_MALLOC_F where needed

 arch/arm/mach-snapdragon/Kconfig | 3 +++
 arch/arm/mach-socfpga/Kconfig    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 914f4d960534..0e073045be54 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -6,6 +6,9 @@ config SYS_SOC
 config SYS_MALLOC_F_LEN
 	default 0x2000
 
+config SPL_SYS_MALLOC_F
+	default y
+
 config SPL_SYS_MALLOC_F_LEN
 	default 0x2000
 
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 503c82d388ce..114d24381294 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -30,6 +30,9 @@ config SPL_SIZE_LIMIT_PROVIDE_STACK
 config SPL_STACK_R_ADDR
 	default 0x00800000 if TARGET_SOCFPGA_GEN5
 
+config SPL_SYS_MALLOC_F
+	default y if TARGET_SOCFPGA_GEN5
+
 config SPL_SYS_MALLOC_F_LEN
 	default 0x800 if TARGET_SOCFPGA_GEN5
 
-- 
2.42.0.515.g380fc7ccd1-goog

