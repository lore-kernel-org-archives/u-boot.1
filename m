Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0267CC3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 740648850A;
	Tue,  2 Jul 2024 15:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T1A4Y9kF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B25874AC; Tue,  2 Jul 2024 08:54:26 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94683841BC
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 08:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38027so213001a12.1
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 23:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719903264; x=1720508064; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UHMt2ncuTtHonTuLdimx1zxT37IDvLAX3BAnYG5Y78Q=;
 b=T1A4Y9kF17QK6qJrYsCTKM6dk/Y5R2r06YTFoLK1onM06/ReTIy89c7Lw7RmVh/G7L
 kpvmx50qiJGJ4e9AreoPt6TWh6YpH1NbFx6xsCi04awo4y/06bQThi846QoTji9vt+OB
 4kj0ewwtWrzQCgQ3aJOpU372EXcbFv58S6mUV95pfbKVmmXwGu4N4aUiZRzddGyMxm3Z
 thSpT7y5uBIltGr80Q35FY7QUqbiN/w7Hbpy3Qfh9K4SBfi2KTOVCKSU4W7iFesFbYN0
 PuaV8floxG5Xb3jAcZhfR3NOaCwZFSXsid2peHmgkPrquiFVoes1Iqj+/HaXbI96lwRI
 zLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719903264; x=1720508064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UHMt2ncuTtHonTuLdimx1zxT37IDvLAX3BAnYG5Y78Q=;
 b=pI+hKuRJ2YxubZOedqkvKrC2usL6gnBNJQKJz1JgmxDJ8rUmOKnKR+czarhI32rMUJ
 Q4G3uHlL1dbVtPinDHWfX5sVxQ9oxblwCWYceh7WleCo4luvgBHhz54UFvV6tCIHRHnB
 2jepaYF9cZv3lSSwv9m311Di5+T1ZlHccmfCO/8P/JYnDvzKVuAELtOLg/euNDGFAi8W
 HEiuPxgRA8W0DkHEySKbHvqmZP0LE72EnEHYcFWItN6K8Ks/lmuUznj+ogMGCV/xJA9u
 t+fnIQn0DsDsKp9gdkdNDb7XoW5yBX81UNH8OILPGAS1xqJbTC1zDI6F87fH1YUGdTFW
 Z6TA==
X-Gm-Message-State: AOJu0Yw1blbzRBeW8F46h/htP3pebVXd284tYCe908znhjUdAPn3wZWf
 l0Wlj+2kYBBdNrg5rmGK+K5Gt+C3MIA2CkjFyD+oRLpmgqSAAd7D
X-Google-Smtp-Source: AGHT+IH1ojLAF4Yrnn0zBtMoZwfxRAizSuDGpAGvWiZBFKzmAmqt2ZsTPO8SEEn95FUAML/a/QMb3Q==
X-Received: by 2002:a05:6402:3486:b0:57c:758d:86f8 with SMTP id
 4fb4d7f45d1cf-5879f69c67fmr6329344a12.23.1719903263617; 
 Mon, 01 Jul 2024 23:54:23 -0700 (PDT)
Received: from 9a2819e34573.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58613815e1csm5320954a12.44.2024.07.01.23.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 23:54:23 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: marex@denx.de, simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Cc: u-boot@lists.denx.de,
	l.rubusch@gmail.com
Subject: [PATCH] ARM: socfpga: fix broken function call for arria10
Date: Tue,  2 Jul 2024 06:53:50 +0000
Message-Id: <20240702065351.289968-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 02 Jul 2024 15:00:15 +0200
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

Remove obsolete arguments in the function call. The call's argument list
differs from its more recent definition. This breaks compilation of the
'socfpga_arria10_defconfig' target, with additionally enabled:

  CONFIG_CADENCE_QSPI=y'

The removed arguments are obtained from device-tree declaration.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
The patch makes the problem disappear. While messing with some old
Intels, it looked to me as if this usually turned off code region of
the misc_arria10.c still contains legacy arguments in the call. Thus
broke my compilation. I'm unsure. Please verify.
---
 arch/arm/mach-socfpga/misc_arria10.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
index 93c9e8b0..5c782f6b 100644
--- a/arch/arm/mach-socfpga/misc_arria10.c
+++ b/arch/arm/mach-socfpga/misc_arria10.c
@@ -211,11 +211,9 @@ int qspi_flash_software_reset(void)
 	struct udevice *flash;
 	int ret;
 
-	/* Get the flash info */
+	/* Get the flash info, speed and mode will be read from DT */
 	ret = spi_flash_probe_bus_cs(CONFIG_SF_DEFAULT_BUS,
 				     CONFIG_SF_DEFAULT_CS,
-				     CONFIG_SF_DEFAULT_SPEED,
-				     CONFIG_SF_DEFAULT_MODE,
 				     &flash);
 
 	if (ret) {
-- 
2.25.1

