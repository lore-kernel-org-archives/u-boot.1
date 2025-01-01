Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9112E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AE1980317;
	Wed,  1 Jan 2025 23:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nOLZema9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CABAE80433; Wed,  1 Jan 2025 23:13:17 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83E2580606
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21644aca3a0so60975185ad.3
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769593; x=1736374393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w06DkGOeUPrI1zj/oIKyHM9KXi9w7bXjz1crW7/IHqM=;
 b=nOLZema98V6zhyaDdVI45E8M1jcALYLR7zN+Yve7rF5FQly4XDX/8bg0EXP1FKdeHQ
 fToEcDFSq3GgBowv5VCsT0J7TAbEgcAxL1NlvK7GDr4ZdpcXhlp28LEMI1DaPogPj8HQ
 2f2/qOZUFzKctMf/RUewcq708/Y9PLbGqMwxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769593; x=1736374393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w06DkGOeUPrI1zj/oIKyHM9KXi9w7bXjz1crW7/IHqM=;
 b=Con9HSivar3nKr8pmq9opvZ446LnP6LFZRU/KjFf7BllORwhGj4ZYgPqEYOtI3xDkv
 1Ulu7gvJ0J3JmAOqiZ29ff+enu3EJB+9B2rhKdHd0Vj0glaNeutaXxQnIEsc7fioAlXs
 TGCArJ4Cseo0WYNa7ZfTV2s24gPkDC7/OH+wD2aXyOYAfRH5uxAIzSm67AjK4mpYAEl9
 ycq4zxEhk53lYTJEsTljL0UEtZkL2m8Z/G6Ob6AdTehhQZwvEN//zZZQlreIrH8Td4kd
 xLpRR8cIt9TESRV1a1cymm2pAi3vEpvGfSCsryLy4djTAawGbXlak1ZQTlS0lhUhK3su
 ZQhA==
X-Gm-Message-State: AOJu0Yx15diQT3WaRBXnXZiGAouwozdYe9ZPAVOTotkmw1kzcgNLKUd6
 3OnCEUz49Rg5x6mY76rjUv1U7llM9fNzvdQh1VLO5I1FrQfr3oboF+q4r6WaRVP7SXPv+tm2ha4
 =
X-Gm-Gg: ASbGnct8QXUQTkoaf/pRvN70bRohK65K6mOiwZ/DZ0Cueg0XTEGpwl5vINhAypINtTQ
 1RepA42MXX5ROjXSdqbomNjbALj0v8Fqj8Yxrgi9lWl7S8COEG82FzIKsxgVpxOLhIkNruHF0eX
 sF6ZdmMaJQo8MVRzdnNozTIutQMusHC85X21eD7cFnyPusfPkSuIARZGEVAdFgBc3SsczMYNOxP
 07Dk2J+Kr/7HfmFJCdpXPYSAqe5tmQ3fnW0gyyh1L59iEsCz4bk2MQ=
X-Google-Smtp-Source: AGHT+IFZiuEY0euwmGbC24lVBKvxQaqAgGCtGMCiWQTOKeJEr6YeayYlUwrFoARajF8IrIifCHESoA==
X-Received: by 2002:a05:6a21:158c:b0:1e1:faa:d8cf with SMTP id
 adf61e73a8af0-1e5e0845137mr70905674637.40.1735769593534; 
 Wed, 01 Jan 2025 14:13:13 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:13:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 27/67] upl: Init serial and graphics alists in upl_init()
Date: Thu,  2 Jan 2025 11:09:13 +1300
Message-ID: <20250101221003.1944600-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

It is better and simpler to do this at the start, so that an uninited
data structure doesn't cause problems. Update upl_init() to set up the
remaining two alists and remove this from the reading/test code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_common.c    | 2 ++
 common/spl/spl_upl.c | 2 --
 test/boot/upl.c      | 2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/boot/upl_common.c b/boot/upl_common.c
index 3924423abd5..69a6673a9bf 100644
--- a/boot/upl_common.c
+++ b/boot/upl_common.c
@@ -57,4 +57,6 @@ void upl_init(struct upl *upl)
 	alist_init_struct(&upl->mem, struct upl_mem);
 	alist_init_struct(&upl->memmap, struct upl_memmap);
 	alist_init_struct(&upl->memres, struct upl_memres);
+	alist_init_struct(&upl->serial.reg, struct memregion);
+	alist_init_struct(&upl->graphics.reg, struct memregion);
 }
diff --git a/common/spl/spl_upl.c b/common/spl/spl_upl.c
index 067d437150f..81a106570b8 100644
--- a/common/spl/spl_upl.c
+++ b/common/spl/spl_upl.c
@@ -75,7 +75,6 @@ static int write_serial(struct upl_serial *ser)
 	ser->current_speed = gd->baudrate;
 	region.base = info.addr;
 	region.size = info.size;
-	alist_init_struct(&ser->reg, struct memregion);
 	if (!alist_add(&ser->reg, region))
 		return -ENOMEM;
 	ser->reg_io_shift = info.reg_shift;
@@ -94,7 +93,6 @@ static int write_graphics(struct upl_graphics *gra)
 	struct memregion region;
 	struct udevice *dev;
 
-	alist_init_struct(&gra->reg, struct memregion);
 	uclass_find_first_device(UCLASS_VIDEO, &dev);
 	if (!dev || !device_active(dev))
 		return log_msg_ret("vid", -ENOENT);
diff --git a/test/boot/upl.c b/test/boot/upl.c
index c2b571e06c4..89201e445ff 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -136,7 +136,6 @@ int upl_get_test_data(struct unit_test_state *uts, struct upl *upl)
 	upl->serial.compatible = "ns16550a";
 	upl->serial.clock_frequency = 1843200;
 	upl->serial.current_speed = 115200;
-	alist_init_struct(&upl->serial.reg, struct memregion);
 	ut_assertok(add_region(uts, &upl->serial.reg, 0xf1de0000, 0x100));
 	upl->serial.reg_io_shift = 2;
 	upl->serial.reg_offset = 0x40;
@@ -144,7 +143,6 @@ int upl_get_test_data(struct unit_test_state *uts, struct upl *upl)
 	upl->serial.virtual_reg = 0x20000000;
 	upl->serial.access_type = UPLAT_MMIO;
 
-	alist_init_struct(&upl->graphics.reg, struct memregion);
 	ut_assertok(add_region(uts, &upl->graphics.reg, 0xd0000000, 0x10000000));
 	upl->graphics.width = 1280;
 	upl->graphics.height = 1280;
-- 
2.43.0

