Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7C1FB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E81F83F9A;
	Tue, 17 Mar 2026 02:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xm7r18B7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD91F83F6D; Tue, 17 Mar 2026 02:24:17 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD10C83BC8
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4043b909ed4so3280261fac.3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710654; x=1774315454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zixNUny93tnpj7jklotrnHE7BPuVhdWAVA6qKKQkwm4=;
 b=Xm7r18B7fm1cHR2f4Zwg6HOirduWp2ZP6nxYo83mSEJIaz2/NCnPcAF4jUKgtQ3EVr
 266kJQoXD4gVLlUS1/WdlCkkAHOZwKNjrkeJ26TOsOdYQvLA8xN82WRLrWic5dEgaEm2
 7nAR8BumJ7sb+x4tkzhsJqeWFbbxn7nruFzp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710654; x=1774315454;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zixNUny93tnpj7jklotrnHE7BPuVhdWAVA6qKKQkwm4=;
 b=WJUYCBFMCjGV2vILCL9IhF6J5dcrf1akeTjzePpV43UhAnJmYeSfsu8co6fMNlcI80
 fOVvpnVv6oS0OU+ee84Rv+ei32KlAb9Kfc0z6h8k0nIUTyne2FPimSiYrQ6PSbJkgxKE
 7NEHloXhQuBfWqfOrYW9EooY2uc4U8eT2RifbRp6/etuc1wzoTTm/1O7Nh/dZ8w2v7Um
 XO6UF9DGcU088Hn11/mtGaLVTJmNhsIlZO+ZbQEOyOo2i+f+RS0kU8LwvEZCvyClf1Aj
 uM5RyiyGUX3p+DGUZDKLL2wdpxrOJfkyWHLvMitQKidUjnMvksO81DjIj3MeQ0T+UjmR
 HNqA==
X-Gm-Message-State: AOJu0Yw5eYZbbY2LP53QuisrObpnrSvkRabkb/dZDb0KVWbZYUEZyFET
 k9e/V2U26GTQcLwKW3H2vC47mb9Ku4K23N+HM5StOkFrSgYd43RcjLppLsu3U3Jj37MYnUP4INk
 aeRTZLXM=
X-Gm-Gg: ATEYQzzJik7sd5oVM9ZnwJsPLfOlIFGUmm8yX/9BLx4ieB3ARE0u4k/l1dJ1GYto3mK
 JJHfpvOPM2OWI2qsDnrEi525cuggOnwfMo203k5Hy+nQD2G42OyHaifYZW4J2h2fyvEYEC60ZGT
 U1MyEJkhv/x2XY8D1RRkmHZqPEebfFZA0lEaEoXOJhhO/H7hf4l1MHSnSqHMw3fCXydqHLXIPqH
 ReRfk78oiW5rfycwKedil5W/Fi19qDWNHRWcmICsnSFl0KgIIUGg0vZRtIB7HUPU52zWudLnwja
 PlOb7yvZzhDWRFHxhJFewgaC1Ug0Q+DuQ7JcP+ad9YiGBj6UR6xRCSdl4DJU1EZ83ncnk0Scbqu
 dH9Iv436AUZJSfkucO2NboxysrFKtihhOIT39um+qIjnU2abzbdDtz3snV8v2THHr6RujI4MNv2
 iYVAZvkBepJVyKRSfdkr3aDnDMfnJvaLgM9pzUIt3ShKj4TTYaXHr9nx6NdM6puOzW5dXFyZ32r
 VAjMCun+QVlqkJ1aWpVaLelABgbDFJXCE+IoFzaM+UapfObrIo=
X-Received: by 2002:a05:6871:4090:b0:417:621e:f6a5 with SMTP id
 586e51a60fabf-417b916b81emr9094893fac.1.1773710654284; 
 Mon, 16 Mar 2026 18:24:14 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e6c7885sm16946700fac.17.2026.03.16.18.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH] microblaze: Rework TARGET_MICROBLAZE_GENERIC implementation
Date: Mon, 16 Mar 2026 19:24:12 -0600
Message-ID: <20260317012412.4162279-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As exposed by "make randconfig", some symbols such as
XILINX_MICROBLAZE0_PVR can be set without TARGET_MICROBLAZE_GENERIC but
have a transitive dependency on it. The easiest path of resolution here
is that since there is only one valid microblaze "board", rework that
symbol to be non-optional.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Michal Simek <michal.simek@amd.com>
---
 arch/microblaze/Kconfig | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 4261e5009fdc..16c55ddfd95c 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -7,12 +7,8 @@ config SYS_ARCH
 config STATIC_RELA
 	def_bool y
 
-choice
-	prompt "Target select"
-	optional
-
 config TARGET_MICROBLAZE_GENERIC
-	bool "Support microblaze-generic"
+	def_bool y
 	select BOARD_LATE_INIT
 	select DM
 	select DM_SERIAL
@@ -26,8 +22,8 @@ config TARGET_MICROBLAZE_GENERIC
 	select MTD
 	select SPI
 	imply CMD_DM
-
-endchoice
+	help
+	  Support microblaze-generic
 
 source "board/xilinx/Kconfig"
 source "board/xilinx/microblaze-generic/Kconfig"
-- 
2.43.0

