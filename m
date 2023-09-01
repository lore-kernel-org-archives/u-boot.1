Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090E7CA0FF6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 20:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2675686741;
	Fri,  1 Sep 2023 22:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lRq/IdNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1663E867F7; Fri,  1 Sep 2023 22:04:18 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A51186725
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 22:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31de47996c8so2042634f8f.2
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693598654; x=1694203454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Msrb6/nmtExFC8B0sHWpf3s96bn/pi+WsRWwEFGprnc=;
 b=lRq/IdNhSmuzz8CxzcWk5NQvB1jP5nhGEkMZiZ4THDs4D2cGWERuOG1LGe4XbiS24m
 wEzty1xhSSmQu8bIhDmbqbHx5BhvlBZw2xcOj5CF9ZSBEOwWqNU15MCJ49nQ7F3iHWSw
 MNhqvaHAqMOFsU13bSUNk8Q2RMhb+NEe7IaF4efe+73qMr2aUOvaPzdC+JXVyK/QaDWC
 X/1ptJOHZoVEj8drXKTUM3a49ym0lzJL/Ie28XfGUHDldqeoc7fNYYVkEGQkQPq6Bl6c
 EPJhmajJA6NOnaCq41QO1CeORw+w+Yjsc9A2SHHE1vdES8Xlb/1bnxtwrAwNlUveydm4
 4Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693598654; x=1694203454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Msrb6/nmtExFC8B0sHWpf3s96bn/pi+WsRWwEFGprnc=;
 b=K8iYl50afjgUoOa2yZiiv6E2+WjhYZ89DjN2nLCl3GKfHsETJMsMMnfoaszqKeZRqm
 iK2bE2fKZywaIoLPAJeHBTlp2IswWfXSHrFMWszYuzLMwoSamz1Y0Haavcs6dBF7Fkf4
 uxGBbCwtpe6DgDReeeadudtLZ+pohcHs7k6o7zTc169VwcY4R6fdZwolf9DeuSDHgLuz
 yCcdHfduOReRyyp95b2APMi/ZX/oULBTq+sg4nJtk013WWW+KEplLek1XaJLO/OKEpVI
 CGM5DpruHIxp6yhftBSmmRk3d/YgDGVT/I+Gtp0Ja8l6xVdJwKAwCT6hbPnhUzgJauht
 5X1A==
X-Gm-Message-State: AOJu0Yx1/IFzanFCM6mWHOcj34uQFpbTTao/z8D95wTjqCyBlFaIvcKJ
 jnidQy1hHASdWCV9oHSqKrAKp3cCqmxbdGkc
X-Google-Smtp-Source: AGHT+IFqqA86EGml0+nezosNEK4ssAlOkaClPKpr01nJg389fpqGLaXiUtKjxlDdXtTi3IT9ChhmSw==
X-Received: by 2002:adf:de0f:0:b0:319:7788:5027 with SMTP id
 b15-20020adfde0f000000b0031977885027mr2826896wrm.59.1693598654417; 
 Fri, 01 Sep 2023 13:04:14 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 l4-20020adffe84000000b003176eab8868sm6207849wrr.82.2023.09.01.13.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:04:14 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v2 3/6] scripts/gen_compile_commands.py: fix docstring
Date: Fri,  1 Sep 2023 22:03:50 +0200
Message-ID: <20230901200353.90290-4-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901200353.90290-1-jmcosta944@gmail.com>
References: <20230901200353.90290-1-jmcosta944@gmail.com>
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

The referred tool is now in U-Boot. Replace "the Linux kernel" by
"U-Boot" to make the docstring coherent.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 scripts/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 0227522959..63d036a773 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -5,7 +5,7 @@
 #
 # Author: Tom Roeder <tmroeder@google.com>
 #
-"""A tool for generating compile_commands.json in the Linux kernel."""
+"""A tool for generating compile_commands.json in U-Boot."""
 
 import argparse
 import json
-- 
2.41.0

