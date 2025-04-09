Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF76C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 18:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31CC78294C;
	Wed,  9 Apr 2025 20:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WyxAu1xP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF908296B; Wed,  9 Apr 2025 20:08:39 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E72F182944
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 20:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7c560c55bc1so679308785a.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 11:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744222115; x=1744826915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xgfXwglkvTitWeUtKfOAjkdphPUaVs++aAaj5STqdTw=;
 b=WyxAu1xPCgd5mbHbBqw8//SeR9L2VrgedOb950GhZk8u3DJQ3xQ7Q6M2RZiExyFuCb
 xqc0pGnLj1XwehLZL6626DlIgC6rQkJOyd3nE5Xjjp7+Zso0vhjG/IIZWtBvj9GtlKG7
 fj+s0hWSwUWnHhezY2v6M7RUXg9u0WtUHDy5ZYxzga5Aw/jVs8HsoWqrsDsIJnG/mwZ+
 3q5+gooXdWoBHWGs49ceh/KTXgn1jnHkOqbe6kAnGjdriDGBFo9TX/T2A6x/yIHVNRXk
 +EmhwQWhrvROMBCB6jDE6Wwfz0n4uyFmCrRPNtOaHxGaYsXaMEIUFk6oM+G3SofJxtI5
 k6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744222115; x=1744826915;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xgfXwglkvTitWeUtKfOAjkdphPUaVs++aAaj5STqdTw=;
 b=Q1kBBBFj/8Leoqj1APAWtL9OwwszC/rbOF/wrxc5p34fS0/y33QslwxxggpaoFCjwO
 et0IdSfwWho8KzP6d96zdqbSRWYu1lEmf1Pj4xTMWA0uJZ8MDltrZo6RSx8Wu7/oV+gd
 MVe0yeyP6v5wNJXochu9WG0k9K837Jg/JGjnZrqy1epO62Yp9qACuEInW9kqM0GX4i4u
 1OuAiZCrcuU5CnVl3jhiJzjXA8kDAko+HfVndIzOZVUV7PD+TZLbchmeQFOMVCMC0d5E
 8FoW9v1Ro2+NhtjhVNjHpE4sMH97aV12YGsjHmGDzMeNoA3GNh6uNsE0+Ni789PG9lQm
 VDZg==
X-Gm-Message-State: AOJu0YzsdtEyP6fKL8V7x9e4il71/3CCpNdlVrTxSxkdph3fBJiig6UO
 6m7d9sxnoENbzXgF4GJ7OWE6UJ8FOF2vq3QVfk/1ah+UA1nCQQ2MQm7CDiyc
X-Gm-Gg: ASbGncvn6xcXClOgmDfxtANY65uh40dvssT/L1Gss14xKqgEI5TV9ublHclrWp6HMug
 +403Yol9yDsiVjmw93t1KSLMR4l2Cqzhd+x0dumcOdI4ws5roq8WwgI+GhxhSnFLagfgHLspDYs
 FrqqcvtoHbE9TLuHN5/63kilPFPbk7D39Dyy4T8N1cwaVHLcrJg7aw3MI5ZLP3A9wOSfVEq2Zrv
 WgJCINEYpgYKEtkZV710wdRjJIvEGAW3spqOH6jGTCsKY5YzujlsK4OPplzmubsRcYu1MJDJhzi
 pk52quBL1hQplFHbY2SMW6yk+Zx/Hq0MCpL+DhhWJE60ZdxLLK5/ANAQgUxZ9T5AptxiHt1h2BJ
 r3RyNeNfFe9nX81/s/NMnDA==
X-Google-Smtp-Source: AGHT+IEmgwCbVpbqVt2ygjpHng4BnG18UZmlHrvvXc6DojXrhRddPiZHTeCciDioXbGan9Xrd2ZLgA==
X-Received: by 2002:a05:620a:2552:b0:7c5:444e:3f5f with SMTP id
 af79cd13be357-7c79cbd2ba9mr437354185a.15.1744222114983; 
 Wed, 09 Apr 2025 11:08:34 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net.
 [108.26.179.17]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c7a10a409esm103246485a.15.2025.04.09.11.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 11:08:34 -0700 (PDT)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Paul Kocialkowski <contact@paulk.fr>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Jesse Taube <Mr.Bossman075@gmail.com>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Richard Weinberger <richard@nod.at>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2] common: Add CONFIG_SKIP_RELOCATE
Date: Wed,  9 Apr 2025 14:08:33 -0400
Message-ID: <20250409180833.3812679-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.49.0
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

Add a check for CONFIG_SKIP_RELOCATE in reserve_uboot to skip the
relocation of the U-Boot image.
CONFIG_SKIP_RELOCATE skips relocation of U-Boot to the end of RAM
allowing for systems that have extremely limited RAM to run U-Boot.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
---
V1 -> V2:
 - Drop "default n"
 - s/ram/RAM/g
---
 Kconfig          | 6 ++++++
 common/board_f.c | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/Kconfig b/Kconfig
index 6379a454166..1b35ddc36a3 100644
--- a/Kconfig
+++ b/Kconfig
@@ -443,6 +443,12 @@ config TOOLS_DEBUG
 	  it is possible to set breakpoints on particular lines, single-step
 	  debug through the source code, etc.
 
+config SKIP_RELOCATE
+	bool "Skips relocation of U-Boot to end of RAM"
+	help
+	  Skips relocation of U-Boot allowing for systems that have extremely
+	  limited RAM to run U-Boot.
+
 endif # EXPERT
 
 config PHYS_64BIT
diff --git a/common/board_f.c b/common/board_f.c
index 99616fdac80..d51696b8eda 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -476,6 +476,13 @@ static int reserve_trace(void)
 
 static int reserve_uboot(void)
 {
+	/*
+	 * This should be the first place GD_FLG_SKIP_RELOC is read from.
+	 * Set GD_FLG_SKIP_RELOC flag if CONFIG_SKIP_RELOCATE is enabled.
+	 */
+	if (CONFIG_IS_ENABLED(SKIP_RELOCATE))
+		gd->flags |= GD_FLG_SKIP_RELOC;
+
 	if (!(gd->flags & GD_FLG_SKIP_RELOC)) {
 		/*
 		 * reserve memory for U-Boot code, data & bss
-- 
2.49.0

