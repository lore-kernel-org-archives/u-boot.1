Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC42CC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E65488C79;
	Sat, 20 Jul 2024 12:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="auegPYEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08AAF88C37; Sat, 20 Jul 2024 12:50:22 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B39788C37
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3687ea0521cso1334836f8f.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472619; x=1722077419; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMlsRcL6Di+Pn0G0mMUzLT775eTfbhf30NwE4Lk0pYg=;
 b=auegPYErxr1BgwvrhhznoTJeggKiWckKCvAXEotV+YF4xHGu/14vsnbfW2QChU/uTK
 38vzK6ETIijxNUDC1d7ww0POScaCW9PG9/lGryL2PNwb26GhEIY+/T6O/WFRgzsgCmiO
 6/uAXihSJkSeSZACLVZi+cHiVw0uA+Yh6U7sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472619; x=1722077419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMlsRcL6Di+Pn0G0mMUzLT775eTfbhf30NwE4Lk0pYg=;
 b=v0kvwqeVbNjSJgGOesa3loi5AWtKwJpaGg9buhaZhmqhTeVeEHJizvW7DgHpQLv6cb
 Z3Lmf9kpAqNH+IvOJK0D8kWF6AKcEh7q5URbs7Uq1yUxFAJ61S0VV8nBC/kx3mgfgbEA
 vWVqsaYBZ5/QwXljvog+XjqdwYkfDbLL4Fs5ctFrY7HfTzcCr3XIRT5aY0nhBPZYNSyV
 wq6wPA/1Mlu6nGZ89rkryoriI+y10DJqtbIpNYyX9IXIQRqmL1WYTQXMH81kAuZG/XX5
 dBtmyJ30cdvYJkFpk7z5Q7ZhFu3eVjWFGqSML6lczgIuvISk1X8eqk9hPJWS6jja0v9+
 tofw==
X-Gm-Message-State: AOJu0Yzw84frCg9bKx4UND1xfUA/KlCOUrm4XhuGoY+ieM+XfDeeY6vT
 ku1g5b8WF6QiXb74AUT4nxFWY5XGpmRyvpdh1JkgZTsAfTcrHF63KI8S4v+i1PRI8j/QAn6Ium0
 =
X-Google-Smtp-Source: AGHT+IEJDF+FVh7TgeDH7YXhc/mnvNVmBZmLAjDv/uOGsmzpqTFfNVU2PlAQLy6aIDGAqF+DA+qw1w==
X-Received: by 2002:a5d:420c:0:b0:368:3384:e9da with SMTP id
 ffacd0b85a97d-369bb2d6208mr722277f8f.62.1721472618830; 
 Sat, 20 Jul 2024 03:50:18 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 20/20] Makefile: Pass OF_SPL_REMOVE_PROPS to binman
Date: Sat, 20 Jul 2024 11:49:50 +0100
Message-Id: <20240720104950.2730773-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720104950.2730773-1-sjg@chromium.org>
References: <20240720104950.2730773-1-sjg@chromium.org>
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

Pass CONFIG_OF_SPL_REMOVE_PROPS to binman so that it can remove
properties correctly when producing FITs for SPL phases.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile                  | 1 +
 tools/binman/etype/fit.py | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d8e2e6a1b4b..4b61dac8428 100644
--- a/Makefile
+++ b/Makefile
@@ -1393,6 +1393,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		-a tpl-dtb=$(CONFIG_TPL_OF_REAL) \
 		-a vpl-dtb=$(CONFIG_VPL_OF_REAL) \
 		-a pre-load-key-path=${PRE_LOAD_KEY_PATH} \
+		-a of-spl-remove-props=$(CONFIG_OF_SPL_REMOVE_PROPS) \
 		$(BINMAN_$(@F))
 
 OBJCOPYFLAGS_u-boot.ldr.hex := -I binary -O ihex
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 38358292ece..ee44e5a1cd6 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -210,7 +210,8 @@ class Entry_fit(Entry_section):
 
     Note that the `of-spl-remove-props` entryarg can be used to indicate
     additional properties to remove. It is often used to remove properties like
-    `clock-names` and `pinctrl-names` which are not needed in SPL builds.
+    `clock-names` and `pinctrl-names` which are not needed in SPL builds. This
+    value is automatically passed to binman by the U-Boot build.
 
     See :ref:`fdtgrep_filter` for more information.
 
-- 
2.34.1

