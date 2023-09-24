Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA7FCE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74F1986B97;
	Sun, 24 Sep 2023 21:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LFgq/PTW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D8F686B38; Sun, 24 Sep 2023 21:26:09 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97DA186B35
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-351367c940cso3440745ab.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583557; x=1696188357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLKd3xBarAFZkFPS99PXhqWQ1hRwN1Jzv0gg9BAvCx0=;
 b=LFgq/PTW4rOL3SGwWkyCulYof4wKi1FITCQ09cKP7cKYTdpEWt6HyzvtWpR8HtmR0z
 R74t2a9y0WxsB0K4/7cTnOvql23Xf/sqJfycJQ4/I9ihPnXmHyYCACw9Oavgo6VNGkK5
 yRcwcd/Foz9CZsPxBEdIehrxU+C84oIVh3Fak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583557; x=1696188357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLKd3xBarAFZkFPS99PXhqWQ1hRwN1Jzv0gg9BAvCx0=;
 b=syz+SlLD5tPEoGMv5KDwj+idbk1vXCLjLYYJGbvGfrtWBGFgacNts+fS6Msq0TwAW4
 E+mzgPq6a47InVHTjoIoUWZtvYarlnQ36/afJT84nEjTyEwhm3vaSDaeUSPORJZb18j5
 dWRgOgZU1R+//KipqxQXNLlKClnF7ELZHzD3VYZRv8K5j/0UtJwoROtQ0iMwPm+TF46s
 e36n6XpskmyXGYqe6bJFpKGleo1dYVvjlghEp9h3Z/6dHKlYoDCZlR+FCJ3eElX+RKTF
 LzFEJpbdCNWsL9poH9LhB66VYq+iOzl0d6GlFno11W36UR8hA9uAR13qcvmqlDtKbT3U
 o2sg==
X-Gm-Message-State: AOJu0YxfYYVs0NlBMpnWql/xnF2/aAkkbB9ohMjigMr+mBUUGMjVgmVi
 zzikH3w9+54Fdh54Ednwg8A4Z7JupYQjuLOcEwI=
X-Google-Smtp-Source: AGHT+IH3a9yClXlx8q7/hZvVfwfSngH5JJM8Y45PtwPENPXTg1A6mRm6LMlotB7KPqwtoynHTuxSzQ==
X-Received: by 2002:a92:c5ae:0:b0:34f:1b85:5f45 with SMTP id
 r14-20020a92c5ae000000b0034f1b855f45mr3126859ilt.32.1695583557215; 
 Sun, 24 Sep 2023 12:25:57 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:25:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v3 09/38] spl: Enable CONFIG_SPL_SYS_MALLOC_F where needed
Date: Sun, 24 Sep 2023 13:24:54 -0600
Message-ID: <20230924192536.1812799-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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

