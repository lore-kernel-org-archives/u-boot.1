Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBF1C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 19:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E09C87B84;
	Mon, 15 Jul 2024 21:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YT6HlfwY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47308752A; Mon, 15 Jul 2024 21:33:13 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E914F881DB
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 21:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52e9a550e9fso5622923e87.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721071991; x=1721676791; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8WmZGefQzGf7sONLKpAvXNpoK5r7FN3hkmG8FvSNQ/U=;
 b=YT6HlfwYbkHV7EECufWoBE2YpbCIGjREXgrov0vkkiMckBV3nY33EYCD75utD1Vv5v
 4IjebFH0OYNU+ltCygjrn4xUzhGP99Y0RwaOgo45r5WXZue8UGGdXSe/j/HveEzX4DgY
 Ie6lShoVu10R0XVuBCW70wCCjdQGtliJK5GWMUW0e6Vrp1qkQGK7IFDD/wfLocxj8RA9
 ye2d+qtayJqyUkvzY3VU4c/tRpJav6D0KMnkQ+4vFLYKtJyHzeJ5f9M3cRNnnbB5ur49
 26V/UV0b84Uwszt8yiElJDC7gostorGIOKKGiyu7pQpjKkEety8D+PG9n59gCM9RUX1y
 psAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721071991; x=1721676791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8WmZGefQzGf7sONLKpAvXNpoK5r7FN3hkmG8FvSNQ/U=;
 b=X1VX3BM3IbmuL9B23h4XP6dHVcSISk6P81MghbvcpiHvBiMidaV0a01uvuTASUcdEL
 F8eeKq1IyA6oPgCXO6B+wMweSbJWuZIrKn9WHHM2P+YV4iV9zIrBtU2obIVkgr2Ifm2j
 NUKpBumg1MujamDn5G/1JfPxH/T2/0AS69Jhb6bTqbCzMyGnF8jJNIYcmRYUAwn37zFG
 iTjsJ6I05MwiLp8/M+ZFBh5bWgaeVz9hCzhV95/XR4S0brLq1XGQ9h658P4TEaIc/G7x
 nP+A2OhwRSiu69vfzilbvo8oAZg0whw5j6offHjQWQT8GjBwiT5MhuVPSQJIE2/mwGa0
 6OZg==
X-Gm-Message-State: AOJu0YyUla4kF93FMCWpo9o0eKa3njrHKe8nte04C64kJrNwjb/DiCin
 DoHwKbVBWeg5W39v4ybFJoJ175UpGnz1YV+pfqZvcNZ+pfRoac10Ix9Gt0T0
X-Google-Smtp-Source: AGHT+IFKQpo2+2c4KNanyXlB9PGkeiPf5CiKaCSF0ogfwn7YSLmsronAm/3WWg7ZTscF1Nt3TwvBog==
X-Received: by 2002:a05:6512:12c7:b0:52b:8414:db9 with SMTP id
 2adb3069b0e04-52ecb613382mr2415793e87.3.1721071990590; 
 Mon, 15 Jul 2024 12:33:10 -0700 (PDT)
Received: from localhost.localdomain (109-252-15-116.nat.spd-mgts.ru.
 [109.252.15.116]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ed252d483sm941517e87.174.2024.07.15.12.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 12:33:10 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: u-boot@lists.denx.de, trini@konsulko.com, sam.povilus@amd.com,
 sjg@chromium.org, bage@debian.org
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH] doc: fit: add ELF image to list of image formats
Date: Mon, 15 Jul 2024 22:33:00 +0300
Message-Id: <20240715193300.11770-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
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

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
 doc/usage/fit/source_file_format.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/usage/fit/source_file_format.rst b/doc/usage/fit/source_file_format.rst
index 15990e3ff54..cb5da5af2dd 100644
--- a/doc/usage/fit/source_file_format.rst
+++ b/doc/usage/fit/source_file_format.rst
@@ -287,6 +287,7 @@ os
     arm-trusted-firmware  ARM Trusted Firmware
     dell                  Dell
     efi                   EFI Firmware
+    elf                   ELF Image
     esix                  Esix
     freebsd               FreeBSD
     integrity             INTEGRITY
-- 
2.39.2

