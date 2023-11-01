Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC3FC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9343587722;
	Wed,  1 Nov 2023 17:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wpnc2Flf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F068D87D1D; Wed,  1 Nov 2023 17:28:45 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D301F87D20
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-66d264e67d8so114106d6.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856115; x=1699460915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HhsWoUBe/8cCRUNhAZKN+1XGxKIo4lG9Byg/w65Pg0=;
 b=Wpnc2FlfadHUO36MUE0dQWt4hRnpqg4ceMgB7JsBprgdusr7NVZSdo46BtHx6myaVw
 H90yC73zj5PlLUqAt4I6gm7rl5g0VCAmdMNQ5xl3LXEaEeK8FOWawvjjyorKZeUdX5qB
 qa5ZPq103d1smRWw2gVXM1+K3s28EtB+78S78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856115; x=1699460915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HhsWoUBe/8cCRUNhAZKN+1XGxKIo4lG9Byg/w65Pg0=;
 b=Ex4yZaoOrGIcuiXtqEjQi8OVo/kPEZLuURw9eat7EswhyyO+gwwglBw4ChDwaJFECN
 QSbroCy5g611TlJcTB+PZo62B+ajBxvjFuvBy51vgyjI9fnw6++ArE3sa5Wrew0dClUV
 g7qWEv1nmyfTjB4u/RB5OWu4q/mCfYitlADggdFTWheXgojsWGzWniORPJNvTIhOh6kl
 CK9VH1swwXV9M7ukcX+3hIguhq6l1DHVtRArhXqxsrg4JR3a+uI1WchCXwODULVfhe/d
 WxPU861OM2YUA61qNew6agLZlPbBCqSpajzMuy3uNU51vZzMxx/6sWzAmoXorN4bOSCR
 b4Eg==
X-Gm-Message-State: AOJu0Yyta4YUCaBFG4qMxmr/kUohMNbRycZjMUn06Yqs25wpXCeOXmHD
 VS4mv4Y81+R4Z5WSd6IqcG4xPVl0IwwwiUj1j4YQOQ==
X-Google-Smtp-Source: AGHT+IFtGToayxUqLGm8vjrSiTFlmmG4FvklpRHicLCHZdJFN4OuAGbkrO8kje0axu6zTYgo78O2vw==
X-Received: by 2002:a0c:e194:0:b0:66f:baa4:77b0 with SMTP id
 p20-20020a0ce194000000b0066fbaa477b0mr16241279qvl.8.1698856115364; 
 Wed, 01 Nov 2023 09:28:35 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>,
 Rainer Boschung <rainer.boschung@hitachienergy.com>
Subject: [PATCH 11/20] pg-wcom-ls102xa: Include <config.h> in the board file
Date: Wed,  1 Nov 2023 12:28:15 -0400
Message-Id: <20231101162824.3755579-11-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

Given that this file references CFG_* defines, we need to be explicit in
our inclusion of config.h, so that these will be defined.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>
Cc: Rainer Boschung <rainer.boschung@hitachienergy.com>
---
 board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c b/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
index 01786d938de1..cc3611e2dec1 100644
--- a/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
+++ b/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
@@ -3,6 +3,7 @@
  * Copyright 2020 Hitachi Power Grids. All rights reserved.
  */
 
+#include <config.h>
 #include <event.h>
 #include <i2c.h>
 #include <asm/io.h>
-- 
2.34.1

