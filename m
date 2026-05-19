Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E35CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74AE584944;
	Wed, 20 May 2026 01:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h/LpWYq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE7D84928; Wed, 20 May 2026 01:33:11 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BCE884912
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dea20cf21aso4150566a34.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233587; x=1779838387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TtdNiX7S7+2xocH+eLiPSiZzP9QimN/VmkFWf5NFRRk=;
 b=h/LpWYq48C3PI+aehkTVXFXkVtuZEyPt8AsogSapi1Ql6tJE79JDAk/9qV9eSjDb4U
 jnTG9JEThIghEyT9PbOguudU1fgfTyReQOXidITBnIGcDwlMxakgpPVqafyWi9Os9/E2
 IsJXBqpk0Ghueh2OCa93l7yQOfIgHHlJB0imA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233587; x=1779838387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TtdNiX7S7+2xocH+eLiPSiZzP9QimN/VmkFWf5NFRRk=;
 b=RauobTVKlIprIt/dVEplqevFCce05tZ6OZqLogwMUDBC8USa2cqtGUWZpoJTszpV98
 SAKSh1Q9kRE7aUInrF4aSs2o9Lzj7GZzM41qqBOWeuWNM+JxIAQlGwOKWblG4uXTuuP7
 C6kuOkaroRJtrQ4rH/VBF3Uu9CpLKlLaa9UOOQ7czQNsY22+dJ5yFzk6BvZZxcTnIPWE
 oRuduAPTfArhNmwLnzTUCAtzZG6Khk8yDcXLg0NKbRxUkGj3lNCLia+Jb+i9c0wkGFP0
 A2adaCTN54ocZhdoF9SkPsp6PzH27blJOqBiBWz5TjDoCcCZ5tGbE+2AD0TrdPzV40X0
 UpXA==
X-Gm-Message-State: AOJu0Yzfk+aEe5Bp5iw4YrJ2/w/zWZJhUNYEIWrPEr0/v/q7dWCSlYIz
 tUy3QVlKSTfNk/IXcx67JE2rbl9jqTOWwUbgJgcPakptnq3iWcsUC+Zeoizpu/ZPoRn0YBomgvS
 dUlLzgjTL
X-Gm-Gg: Acq92OElnBvHcyEwrNCxeICqkttNNy/aoPkQJ5aauvav+p3VCgzBDQHm/XBZdm2MdBT
 V2i57btS6KDQSrEaXqbzUMbd7ytiWlOarj5IbmxTW67LUSD5+b1qvY40RzhmG7e2p89t7tO2avC
 no6oW7cyqiDWNjVkfzh007PvRohYALaeEpaQCM32PNrypwzcl1x4l/c5EJjVPzsCEMH8AVd/Fwg
 8gGWdKx7d1RyA4FHM+N4twVezWpYfViCeNMxsUjaixs3AZYdfZOgLsOF1vNUcwskQevuhYpgyJD
 U+ssYCd8TN2ITZE7bYbbOfXvZU1A5gTtGFZn+zvnKITh/eH7b5Pl+oB9ArNgKgrjpiFdguDa6Dp
 +fkYL6nDFEnVUZmohjk8UJoqHdVX27dRwL6GL07+Dza9szyL9i4wF6TXBzR3axwwGFWjnH6KJV+
 6h7rcUmLJd6FDlttu0EQ==
X-Received: by 2002:a05:6820:c97:b0:69b:bf80:2db3 with SMTP id
 006d021491bc7-69c9bfafeb8mr13890223eaf.44.1779233587545; 
 Tue, 19 May 2026 16:33:07 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:33:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Edmond <seanedmond@microsoft.com>
Subject: [RFC PATCH v2 16/17] lib: getopt: Add a Kconfig to drop the
 permutation code
Date: Tue, 19 May 2026 17:31:42 -0600
Message-ID: <20260519233207.2765755-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519233207.2765755-1-sjg@chromium.org>
References: <20260519233207.2765755-1-sjg@chromium.org>
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

Permuting non-option arguments to the end (the in-loop bubble shift
plus the nonopts bookkeeping) is the largest single feature in
getopt() and the main reason it pulls in over 1KB on arm64 when echo
is the first user to link it. Boards that are happy with POSIX
semantics (options before positionals) do not need it.

Add CONFIG_GETOPT_PERMUTE, defaulting to n to reduce code size. When
disabled the bubble loop is dead-code-eliminated and getopt() stops at
the first non-option, as if every optstring were prefixed with '+'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/Kconfig  | 14 ++++++++++++++
 lib/getopt.c | 42 ++++++++++++++++++++++++------------------
 2 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 77ebc79e1db..182381d1458 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1026,6 +1026,20 @@ config GETOPT
 	help
 	  This enables functions for parsing command-line options.
 
+config GETOPT_PERMUTE
+	bool "Permute non-option arguments to the end"
+	depends on GETOPT
+	help
+	  When enabled, getopt() permutes non-option arguments to the end
+	  of the argv list so options can appear anywhere on the command
+	  line; this matches GNU getopt behaviour.
+
+	  When disabled, getopt() stops at the first non-option (POSIX
+	  behaviour), which produces smaller code at the cost of forcing
+	  callers to put all options before any positional arguments. The
+	  '+' prefix on optstring becomes a no-op since that is already
+	  the only mode.
+
 config OF_LIBFDT
 	bool "Enable the FDT library"
 	default y if OF_CONTROL
diff --git a/lib/getopt.c b/lib/getopt.c
index d2ccefc616e..3fb41532d05 100644
--- a/lib/getopt.c
+++ b/lib/getopt.c
@@ -53,24 +53,30 @@ int getopt(struct getopt_state *gs, const char *optstring)
 				return -1;
 			}
 
-			/*
-			 * Permute non-options to the end so we can keep
-			 * scanning for options past them. In '+' mode
-			 * (POSIX), stop at the first non-option instead.
-			 */
-			while (gs->index + gs->nonopts < argc) {
-				int i;
-
-				if (*cur == '-')
-					break;
-				if (stop_nonopt)
-					return -1;
-
-				gs->nonopts++;
-				for (i = gs->index; i + 1 < argc; i++)
-					argv[i] = argv[i + 1];
-				argv[argc - 1] = cur;
-				cur = argv[gs->index];
+			if (IS_ENABLED(CONFIG_GETOPT_PERMUTE)) {
+				/*
+				 * Permute non-options to the end so we can
+				 * keep scanning for options past them. In
+				 * '+' mode (POSIX), stop at the first
+				 * non-option instead.
+				 */
+				while (gs->index + gs->nonopts < argc) {
+					int i;
+
+					if (*cur == '-')
+						break;
+					if (stop_nonopt)
+						return -1;
+
+					gs->nonopts++;
+					for (i = gs->index; i + 1 < argc; i++)
+						argv[i] = argv[i + 1];
+					argv[argc - 1] = cur;
+					cur = argv[gs->index];
+				}
+			} else if (gs->index < argc && *cur != '-') {
+				/* POSIX-only mode: stop at first non-option */
+				return -1;
 			}
 
 			if (gs->index + gs->nonopts >= argc)
-- 
2.43.0

