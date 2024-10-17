Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BD1D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1421C892DE;
	Fri, 18 Oct 2024 01:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k9jGlhDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6893889265; Fri, 18 Oct 2024 01:25:46 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49FA2892BA
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-83ab94452a7so15260239f.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207543; x=1729812343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lIwFAmCbz9P30q4fPiiSOoxSA1Ao4MuMztyLsUW31oY=;
 b=k9jGlhDOMzpEh+2WCcBjrVhynEGVIsQPaRaANBG2x3omg8V4pP3uP/YacUMBqmQhVG
 LE0DaAQ4+mOCoyt/fSI3w1bEov3L6uJE1u+VjeMCD6FiNf5uMdWgrZp4nje0Mqo+UojH
 NnlobU0o5xmy89D0ZwSKukP69NTtytuvo7U8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207543; x=1729812343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lIwFAmCbz9P30q4fPiiSOoxSA1Ao4MuMztyLsUW31oY=;
 b=EOcnUMIMoldoriM42FySvuU/Oq+imHH7djfdshrXifGRF2wgfxoLI3OH13jAAoj0nZ
 0XMGreRIEr3e7dM6Mj9v9mSIEY/4YAPlmhsDGg1pv9oU61dlbDfrQ4tEY1zHueqsw7jI
 WxfvaruHEQICGgVXjVd7N6MwHQV9tCNaG+J3bKXZtnNziXmsDsLMDViciYoYM48Dg+UV
 bwEUddYbv75myCQiwj5m5qW+IIQ+vmSm5DeLrrhPIHHfggR/WnlNrroVdkqAcF9Ord9X
 vViVdHl5EUh61VeN+yVl+RmYoPwUXzSAYoTJwUdnBY+0HU3f+eXUbMQmmlCHkWmKZGS9
 Jgaw==
X-Gm-Message-State: AOJu0YyReu5XufWjM9nnKwk56A8PcqwmidRjzD3PN2aOiGRD/lHrUojd
 qqXhAUpiuSy1eFtOyNrBJMG0aSBXubbsydxvlX5UsnQmAU64uMruLjAVeI3pOlmA44e/AUBmV1g
 =
X-Google-Smtp-Source: AGHT+IEliFfUVOsWRjAIG7gHGtj1rRIO5LGyEX6L9NYmPOc8KL65oabZCIqEAG+qjR3wWMbC8Igplw==
X-Received: by 2002:a05:6602:1685:b0:82c:ddfc:c57b with SMTP id
 ca18e2360f4ac-83aba5da897mr59142339f.5.1729207542921; 
 Thu, 17 Oct 2024 16:25:42 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ac9csm122057173.29.2024.10.17.16.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Janne Grunau <j@jannau.net>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Neal Gompa <neal@gompa.dev>
Subject: [PATCH v4 7/8] env: Provide a work-around for unquoting fdtfile
Date: Thu, 17 Oct 2024 17:25:30 -0600
Message-Id: <20241017232531.726559-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232531.726559-1-sjg@chromium.org>
References: <20241017232531.726559-1-sjg@chromium.org>
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

Some boards use a CONFIG option to specify the value of this variable.
This is normally handled by efi_get_distro_fdt_name() but in the case
of sunxi this does not work, since 'soc' is sunxi, but the files are
in the allwinner directory.

Provide a work-around for this particular case.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Fix 'supressed' typo
- Use backquotes to highlight DEFAULT_DEVICE_TREE

 Makefile                  |  1 +
 doc/usage/environment.rst | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index cd5107d287c..63eb739f28b 100644
--- a/Makefile
+++ b/Makefile
@@ -1863,6 +1863,7 @@ quiet_cmd_gen_envp = ENVP    $@
 		$(CPP) -P $(cpp_flags) -x assembler-with-cpp -undef \
 			-D__ASSEMBLY__ \
 			-D__UBOOT_CONFIG__ \
+			-DDEFAULT_DEVICE_TREE=$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE)) \
 			-I . -I include -I $(srctree)/include \
 			-include linux/kconfig.h -include include/config.h \
 			-I$(srctree)/arch/$(ARCH)/include \
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index cc33d3ec0f2..379125a1982 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -87,6 +87,18 @@ settings. For example::
 
    #include <env/ti/mmc.env>
 
+Quotes are not suppressed, for example::
+
+    fdtfile=CONFIG_DEFAULT_DEVICE_TREE.dtb
+    # produces: fdtfile="sun7i-a20-pcduino3.dtb"
+
+For this particular issue you can use ``DEFAULT_DEVICE_TREE`` instead::
+
+    fdtfile=DEFAULT_DEVICE_TREE.dtb
+    # produces: fdtfile=sun7i-a20-pcduino3.dtb
+
+There is no general way to remove quotes.
+
 If CONFIG_ENV_SOURCE_FILE is empty and the default filename is not present, then
 the old-style C environment is used instead. See below.
 
-- 
2.34.1

