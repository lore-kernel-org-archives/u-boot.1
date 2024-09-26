Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78D0CDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B15388FEE;
	Fri, 27 Sep 2024 00:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HzCNOHYE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB69088FF1; Fri, 27 Sep 2024 00:43:56 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97AAD88FFA
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-458320b30e7so9077141cf.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390632; x=1727995432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0MkL3WAuUEXI+gqXKlZO8Jfq1h/2NSr2Pw4rWxAuH4Q=;
 b=HzCNOHYELudhhr/XLtz6o+95ib3EYIy6fLQ8BUN4rvIu4Y3CnYiEEiWzyoTroJOrIL
 4lDDGLRfgdqeU49lQ+zYEkCL10hVyEZmbJpB1B7XGXvdJSkXPIP/MXjashpXljFaSAoG
 cTl0vWZwFJdBmdVdYqZoEKByBmoySII0Q/aTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390632; x=1727995432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0MkL3WAuUEXI+gqXKlZO8Jfq1h/2NSr2Pw4rWxAuH4Q=;
 b=lC1gnLlT/m43ooI2RRcg8tjYZ8RCR9Gswhc/SaReXuKRDbArp+di+djOl7u6uL06oY
 S+fXU9QmyNtA7UfCLLzWhAyFuJ2AddQRge10tCXC9A9zVSYQJOJNQFp3L/8GLTX+9Mko
 5tAoNorGbLTGpaMwJbqp2bJjtdidCh4VA0LHWfb+cVzzqZGIwDhh8pIncojwM4VRUOxI
 S/LTRaKKoV9ZKYYt22mVDSUfcRcrwwkjwPaLORG/Zht5v4gD+LDuazaZVGpm9Rpx9IZ5
 uKcrXd9GTuEKYYpTD5N4gx9v/ki3zooqe79oyCOdZs08IGEcb58JfZtQkFtJymbnCquT
 ymzA==
X-Gm-Message-State: AOJu0Ywtiica/gR/p9WwxCa4nMe8i8YM9JaTSto5g1zaIkwd0PzyGS2b
 JZKLfkuOrCSFx3dQPmwXxBI3aMT0M56fK/amx7po6+N3D77D2T/jruOYvOb8ajfcU9GsE4PQIJW
 CjfRObRA=
X-Google-Smtp-Source: AGHT+IHB9F4U17AbkKLta3TDXszdSfaTPq/FiTMD463lq1zE+n34b93CeecvMQWecXNxzyRRjxNvtA==
X-Received: by 2002:ac8:5f8b:0:b0:455:a05:b477 with SMTP id
 d75a77b69052e-45c9f1bce47mr14440911cf.12.1727390632313; 
 Thu, 26 Sep 2024 15:43:52 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:43:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 26/42] kconfig: binman: Check for SPL instead of XPL
Date: Fri, 27 Sep 2024 00:35:51 +0200
Message-ID: <20240926223814.1276764-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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
2.43.0

