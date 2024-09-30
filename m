Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A653DCF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90F1488EEB;
	Mon, 30 Sep 2024 03:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pr2Fp8dj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F35B288E69; Mon, 30 Sep 2024 03:51:11 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B598488E91
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-82aa8c36eefso246846339f.3
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661047; x=1728265847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hE/2l+fok0nB/zUUcCRcOE3twvdbJ43fER9r/s6D2pM=;
 b=Pr2Fp8djjzY94drMXog4OuoctGUmLZWAquCD3kXwlCExOe/lOr3qGRq8P5AQMLe3o3
 lV2buYGNSZY+MHMs7upeFzLhIf/QeqOEV1OOtWBRJ6AwlW32iM1ItWsTk58drCmlZswE
 gvqUoJlnkOJUn16CWukG0Ht3NWX71GRpSu6bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661047; x=1728265847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hE/2l+fok0nB/zUUcCRcOE3twvdbJ43fER9r/s6D2pM=;
 b=iwZ10AecL6MmH1NlmHmQvd39v50/M7F74ui19VT36RYP9X91JUaUk+PCsh7AmiTGee
 gz5al/F3Lac4/HRYtD+Ht7RsJzu7fd668tOzYuLzEnb/6PgPqpbvi/6UMUunEDZ2miSq
 M7z94V3/hrgKsK9n0FbshNkMgfCQGexv/PjuwKZvxQaDPOvsV9K5CCmXPFAa17nxu4Y/
 XqrlivpOdLJaOabTaVW6AzSzGdgK1PzoNJDZSfuKuWOGw0bk3NIm+y2akxMj+Cv8Vbbo
 F8brULSy8tMbqQj1P2hVx1dqOQfp+/55zBMhnF4VKv4KiweLx0o+0FCVSAMEkiXrgmQb
 2ewA==
X-Gm-Message-State: AOJu0YxPe41UkW/0cu+iDyGc5K09dVkw8yXlO0j4Qp7BaqOZJtkbnpsQ
 sHKC6aYvLSyUkMKa7K23hvDO5BivzDOWFr+/uYqS576q/MMM+UgNbMkVkEdTYQS3ctjpNQZAFhL
 6aA==
X-Google-Smtp-Source: AGHT+IHNoevrJK3XskltJHtqwRSsORUczES7Qn2oo6qufp8K6jtzisSO+7A6nNNPPhnsxXTMX/7HJA==
X-Received: by 2002:a92:ca08:0:b0:3a0:c23f:9647 with SMTP id
 e9e14a558f8ab-3a34514afc2mr87076565ab.1.1727661047413; 
 Sun, 29 Sep 2024 18:50:47 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v3 29/33] kconfig: binman: Check for SPL instead of XPL
Date: Sun, 29 Sep 2024 19:49:52 -0600
Message-Id: <20240930014956.1434060-30-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

This is done in one patch since otherwise many Binman tests fail.

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

