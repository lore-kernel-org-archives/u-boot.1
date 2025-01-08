Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253CEE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 13:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 666B8805FB;
	Wed,  8 Jan 2025 14:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ufH9xpIi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBE00805E2; Wed,  8 Jan 2025 14:43:32 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F4568006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 14:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so172231635e9.0
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 05:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736343809; x=1736948609;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yrwIv1FwQ6CEmd/7tp9U/6iVuhi6K9I2YunCWpLn8v8=;
 b=ufH9xpIi0vGVhtvvE9V8nwzhZpFI6muf4m6PpulthM5Vv/s1IzDEzX6gYSwekncQ2P
 OfuIgbYG2sHOo6BUnI+Wet1E1ISSdpSfGgg05/ZzuzSAaJCMRuyhslY/4EVXlrHjFYSo
 N4O+J/VmJVquKqm7wuUyWB9ZZAwRuRcTrfWuijaWECjSR0Ms/nq7MCYLs0RYf2sKTXm7
 Yyw5X8Jk26a4XDpmJhlJLrB1UNqqvypASIlHYDhzCxe1imZcnHm0vyKzc4C7nJv5rlls
 EQtI4Nf81yZRrenpp9Cutxx5oXB/O/RKd8dV74Lj0CC9gsbzo+wkpBstEBdvLqmjUwzK
 bX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736343809; x=1736948609;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yrwIv1FwQ6CEmd/7tp9U/6iVuhi6K9I2YunCWpLn8v8=;
 b=Bi6PqZw53pbpZW7AeDdu1Pf9l5FJGYDUOn8qKPb9X+sXpdFcZq7gre2XhcPQuhtGzm
 0ZesNo5yIJR+9BGA7sK5Gb7QgvTlvQPPzZoxBivG2z/GbVmM+wrqX4Tq4/pYcLC2/zst
 Z+EqN1dQvTTokCC7O31pnL3ec9DYU1Vo9A5B0hX2QvRh66T1sOqV+mfdJ7iXehAv66Bx
 83KoiHruSiprTHFF7Gqx54qqTPvIwMG80RInhh1hFf58NK+EABlvRYxE3m9EvnnwQwBE
 vnv0uEhj3vjA2ImoFBcbdgeid9ZxzrJCfjZZKY15HmL5ZeY2zej6OR1xtwaUBnBnfeHT
 zMXQ==
X-Gm-Message-State: AOJu0YxMcKGw0XczUMf8soi2TaTmV48HzAr8IsEUAdxJoNrn7pkMEBx7
 hWj0nw28rStuzqx05NK8X294/9u1l85wOZj35wT4P5rrk+75Lq42ILJJ+8OeGdo=
X-Gm-Gg: ASbGncsUX1L/tuLXvWzZjp/x+kRLN+47MfK4aEGvfxzwpD/8GiLMGewzZ/BAK2mtSmT
 Qp54zyV6U9qGQ29U73TS14DoOh+/BFiIXOj41Ck5AJ5VX+pBE4vJxSR6qi0iKRxwwmP1Pc7KPEv
 Mkv27xq47W8R562T8qhcNgyeV1IUH1TZ1RNKPt0zHBmSG/Akmo2Poqa7b6c44vb5rQFgdX4C6Ua
 rySoLNnplFOru6umdp+33I8p22HjrX+5pebJvOcsmZL/oEsD4K4XXgCETHJKEmHxvKJuzdH
X-Google-Smtp-Source: AGHT+IHdvbismbpK5AMHGN6q4qVGmMqsCgw0/BAJ1UYlIEgTcUzjzFSQPcBY3lNhQaJuIq0Gv/o/uQ==
X-Received: by 2002:a05:600c:450d:b0:434:a734:d279 with SMTP id
 5b1f17b1804b1-436e26a8927mr27677395e9.16.1736343809339; 
 Wed, 08 Jan 2025 05:43:29 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e22767sm21166045e9.39.2025.01.08.05.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 05:43:28 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 0/2] bootstd: android: Allow booting with AVB failures when
 unlocked
Date: Wed, 08 Jan 2025 14:43:13 +0100
Message-Id: <20250108-avb-disable-verif-v1-0-009c35710ef4@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPGAfmcC/x2MSQqAMAwAv1JyNhAL4vIV8dDaVAOi0kIRpH83y
 JzmMPNC5iScYTIvJC6S5TpV2sbAurtzY5SgDpZsRy0N6IrHINn5g7FoG3Ec+zhYWhUC7e7EUZ7
 /OS+1fqgRRzFjAAAA
X-Change-ID: 20250108-avb-disable-verif-997f820c0c00
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.3-dev-86319
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

Android Verified Boot (AVB) [1] protects Android systems by providing a
root of trust in the vbmeta partition.

On unlocked devices, system developers might want to disable the root
of trust to reflash only some partitions.

This is officially supported in the Android bootflow [2] but is not
properly implemented in the Android bootmeth.
For development purposes

Add support for this in bootmeth_android.

This has been tested on AM62Px SK EVM with TI's Android 15 release [3]

[1] https://source.android.com/docs/security/features/verifiedboot/avb
[2] https://source.android.com/docs/security/features/verifiedboot/boot-flow#unlocked-devices
[3] https://software-dl.ti.com/processor-sdk-android/esd/AM62PX/10_01_00/docs/devices/AM62PX/android/Release_Specific_Release_Notes.html

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Mattijs Korpershoek (2):
      bootstd: android: Add missing NULL in the avb partition list
      bootstd: android: Allow boot with AVB failures when unlocked

 boot/bootmeth_android.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)
---
base-commit: 6d41f0a39d6423c8e57e92ebbe9f8c0333a63f72
change-id: 20250108-avb-disable-verif-997f820c0c00

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

