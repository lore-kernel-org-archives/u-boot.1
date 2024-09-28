Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A27CF6493
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AB5288D8B;
	Sat, 28 Sep 2024 22:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H/6k375V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D21F88D55; Sat, 28 Sep 2024 22:01:04 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E4188A1E
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a0cdd77dbeso11569365ab.2
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553660; x=1728158460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i32ILm9Hd1MfGBqdqgEbVXJxgNgLrepEJRycgLT5hkU=;
 b=H/6k375VBGMWNJlng3vJD9NySqB9vKkL0nqtGdI2zrphMOKwat1ALf5G/0E6fOoI50
 savx9doj+1EtPm51ntQHP7RDLydCT+CF+O7GmX/K24KaMIUTM6U2x5YeC9nk6B+Vxtz2
 L2IBBNmeGJUO+MODuHYmZtFdukg1qdrXDU938=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553660; x=1728158460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i32ILm9Hd1MfGBqdqgEbVXJxgNgLrepEJRycgLT5hkU=;
 b=l7cqyuHPxeRYJ0T+IcOvd4PoXOWMLeQefwoza2AKxdgR6DYW7GPZIhMfL0eiW/Gnkx
 cqChQzaLgOCOmZhCiFHs4eTDnivlkMmJpAWHP2yOrL7z2T/RlpN3+knASLrWTW0N2+kd
 0GvFuENoXUbzHYMgoe6+/Yxiv+oYfanbG9uNQYp/JlMXBP8m/Llzc7BofaEcRG3kCIeO
 Eb7E7gxiy4CiTJUo2MybTcEROaqMLYdU/NZ5AhGBBehdUNkpnW3W/QcXhdNSC/fPBLv6
 R0rypi6JBmXvQFvPBT3Ls9oCKfw5BSpO1GyPmQdlrECeOc5frD/1KQLsHy0RSO9CqD3q
 RJfA==
X-Gm-Message-State: AOJu0Yy+Vuz9JGJWPcu5lG+xTkjwjey81/k9Kz0epu6wuXKgr0hIcw5m
 hh36Z3FfFAdpjTmVl+26vCT2myv1mJjLInpRlANUxPJEFXth7Ki0u852tJ10m57g48vk1qSQ5i8
 DCA==
X-Google-Smtp-Source: AGHT+IHCI5e90UeN2/HpiT8jSj/YgECzStvy4Nr+N96kZO8EbjNwBlKBOj7Sd3tATQ3fi3FzZ/L/pg==
X-Received: by 2002:a05:6e02:1ca8:b0:3a0:be93:e8d5 with SMTP id
 e9e14a558f8ab-3a3451787cfmr59356025ab.11.1727553660534; 
 Sat, 28 Sep 2024 13:01:00 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:00:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 16/30] kconfig: binman: Check for SPL instead of XPL
Date: Sat, 28 Sep 2024 14:00:16 -0600
Message-Id: <20240928200030.194546-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

Now that SPL means SPL (only) and is not defined for other phases,
update kconfig rules.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/linux/kconfig.h                | 10 +++++-----
 tools/binman/test/generated/autoconf.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
index a59f2a61e6a..ec9584b2426 100644
--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -40,7 +40,7 @@
 #define _CONFIG_PREFIX TPL_
 #elif defined(CONFIG_VPL_BUILD)
 #define _CONFIG_PREFIX VPL_
-#elif defined(CONFIG_XPL_BUILD)
+#elif defined(CONFIG_SPL_BUILD)
 #define _CONFIG_PREFIX SPL_
 #else
 #define _CONFIG_PREFIX
@@ -54,7 +54,7 @@
  * CONFIG_VAL(FOO) evaluates to the value of
  *  CONFIG_TOOLS_FOO if USE_HOSTCC is defined,
  *  CONFIG_FOO if CONFIG_XPL_BUILD is undefined,
- *  CONFIG_SPL_FOO if CONFIG_XPL_BUILD is defined.
+ *  CONFIG_SPL_FOO if CONFIG_SPL_BUILD is defined.
  *  CONFIG_TPL_FOO if CONFIG_TPL_BUILD is defined.
  *  CONFIG_VPL_FOO if CONFIG_VPL_BUILD is defined.
  */
@@ -107,21 +107,21 @@ long invalid_use_of_IF_ENABLED_INT(void);
  * CONFIG_IS_ENABLED(FOO) expands to
  *  1 if USE_HOSTCC is defined and CONFIG_TOOLS_FOO is set to 'y',
  *  1 if CONFIG_XPL_BUILD is undefined and CONFIG_FOO is set to 'y',
- *  1 if CONFIG_XPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
+ *  1 if CONFIG_SPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
  *  1 if CONFIG_TPL_BUILD is defined and CONFIG_TPL_FOO is set to 'y',
  *  0 otherwise.
  *
  * CONFIG_IS_ENABLED(FOO, (abc)) expands to
  *  abc if USE_HOSTCC is defined and CONFIG_TOOLS_FOO is set to 'y',
  *  abc if CONFIG_XPL_BUILD is undefined and CONFIG_FOO is set to 'y',
- *  abc if CONFIG_XPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
+ *  abc if CONFIG_SPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
  *  abc if CONFIG_TPL_BUILD is defined and CONFIG_TPL_FOO is set to 'y',
  *  nothing otherwise.
  *
  * CONFIG_IS_ENABLED(FOO, (abc), (def)) expands to
  *  abc if USE_HOSTCC is defined and CONFIG_TOOLS_FOO is set to 'y',
  *  abc if CONFIG_XPL_BUILD is undefined and CONFIG_FOO is set to 'y',
- *  abc if CONFIG_XPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
+ *  abc if CONFIG_SPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
  *  abc if CONFIG_TPL_BUILD is defined and CONFIG_TPL_FOO is set to 'y',
  *  def otherwise.
  *
diff --git a/tools/binman/test/generated/autoconf.h b/tools/binman/test/generated/autoconf.h
index 75af48f9116..6a23039f469 100644
--- a/tools/binman/test/generated/autoconf.h
+++ b/tools/binman/test/generated/autoconf.h
@@ -1,3 +1,3 @@
 #define CONFIG_BINMAN 1
-#define CONFIG_XPL_BUILD 1
+#define CONFIG_SPL_BUILD 1
 #define CONFIG_SPL_BINMAN_SYMBOLS 1
-- 
2.34.1

