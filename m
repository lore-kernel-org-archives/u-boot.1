Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64430C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A2DE82C10;
	Tue, 20 May 2025 07:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fvdxna39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E15AF82BF3; Tue, 20 May 2025 07:22:47 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F297F82BD9
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso50406255e9.2
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718565; x=1748323365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OG92kuwzpTCKHLc7zmNK40MbdlcZyxZZSL53UbY0+N8=;
 b=Fvdxna39qpXPhAxXFHEWVS/Xev+2RXLcs/NEB3vjQTjJXg21Ezi4TkfVqkwooDyYki
 WaE4700F3H+ZgmyCyAnc7xLgHB38Q9eahEmOir1kwo8Ss9o22ztqVec2o21vNhRotGlK
 bfb02StPiIYRmpIEASueBFGPiEm+VcQfWKaR49mSo/yU1K+ioMXQVa4qntyhzPX76RfS
 7Shep8KuVZD89Qa1UukS8XZLKti6IgK1z5D5LOwAJrY9Le5Dr5BCcmjgJZOam7lYzSK6
 crSunB36Qr9aKcSYqtaZaO/TWWgynwbUAc+dwklfks2j9CDZK1R3LGkbimT9jLr67eSQ
 Jkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718565; x=1748323365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OG92kuwzpTCKHLc7zmNK40MbdlcZyxZZSL53UbY0+N8=;
 b=UPFNaE2FxMENWYoqxbMZSTjnfDIAtg0V9pfFLFSkwmzMrSIbyorLWYLy+eTv25pAtC
 4O1svNbH9Osat5xFedkXmCMAFEgTJOKU8Ooi2EPC/JtJWxoflZfhvknZGmSQjork0M3a
 eTDWRE82Gfqo0f0yHj6uCv00o8rRjGfsNkCb/zoFmhMkfUCO1qdc+ji1zwhlWEiGN53o
 irv7xw2jELRplMA4dpPc5tJiNpy3rGm7kFu27MEL6Q1jRYsqrjxFCbBvuItCNo30a2s+
 Xk18ffT/8O/91zVZWpkbJHhiiL/Njk411Kq2Rf68ZUNKMG2BTQrOWxA5X0RMOssh50lk
 Eysw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn8qfOwm+PYKUoRKRfnazBXGLaJZrt6bX9sxqtjbW2g/nSkWLwu1YOYGcnBDbRgRrWReLzziE=@lists.denx.de
X-Gm-Message-State: AOJu0YxlGcb6Y8ZE/KHLFqXslZv+zb6j5Gsx0KWDk5WiBanqOa9eYGVL
 MRJGr+0ariR6eMoWDn1Li23nLYJP2ib5TnjUer7hxm8jSlH5VLNEN3e3Bcu+KDCwXWE=
X-Gm-Gg: ASbGncsFFld0cNRhJ1QD0w2v4HjUf/yoZwFSC0FQBqjboE4COvu5cuh5l+e23ZZ0Z8A
 LMDE81/NcFuFEE7gQFdUa5M4ObX5b8BLCfNWKxQP+Mub8lhc5O57v3cozjedVTsOghOywSXy7lg
 m4svuY60ktkvI3kFxU0mfURWe/QcHWYSC4F9S6+0Zln2wb9jC2x2qypjufSpW7vArDasXoJ36/7
 vpi08G9btaa1KfZO93OsCRXHvlTEKJTlQBUiPNPK4l7K4DqZI94JPjk/SKCh+0YsTtUvmM24tFs
 zZJBp9uje+dP+EWReqBufV07Kjk6hTSuvXCPdF5Q2bqKB9RbrGfIG66m3+JdADIzWofJIyJGQsk
 xWHbSxNHsrQ==
X-Google-Smtp-Source: AGHT+IEUDTzkZ4WjNvO4DkNgPijwnM8W1fOiMrieVDDeqM3Xnp3wTNbpWHtcOsfB3qBTobVnxS4fLQ==
X-Received: by 2002:a05:6000:400f:b0:3a0:b4f1:8bd5 with SMTP id
 ffacd0b85a97d-3a35fe67aa7mr11415768f8f.18.1747718565459; 
 Mon, 19 May 2025 22:22:45 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:45 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 19/24] kbuild: generate modules.order only when
 CONFIG_MODULES=y
Date: Tue, 20 May 2025 08:21:30 +0300
Message-ID: <20250520052153.307194-20-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Backport from kernel although it is unused since it makes diffing easier.
commit 1d8001ef358 ("kbuild: generate modules.order only when CONFIG_MODULES=y")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index ed58bcab291e..2b2beb01bd3b 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -82,7 +82,9 @@ ifneq ($(strip $(obj-y) $(obj-m) $(obj-) $(subdir-m) $(lib-target)),)
 builtin-target := $(obj)/built-in.o
 endif
 
+ifdef CONFIG_MODULES
 modorder-target := $(obj)/modules.order
+endif
 
 # We keep a list of all modules in $(MODVERDIR)
 
-- 
2.49.0

