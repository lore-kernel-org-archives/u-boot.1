Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF0DE77188
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 03:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F2EE8060C;
	Sun, 12 Jan 2025 04:42:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A9U0aiKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30CA2801BE; Sun, 12 Jan 2025 04:42:18 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E081F801BE
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 04:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71e36b27b53so1800639a34.1
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 19:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736653334; x=1737258134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C7AQvuoP+ZPSHFkiQbAmP8AT9q9QiFXgKHLG9VQKdJM=;
 b=A9U0aiKyk2FqHo+lQiJBiB9NO9/qwacK9cwtjUOQ/70zkbU5ZSDRdFt5T2D3j0QWa4
 oSJcFpUtV6l0eoYyGAP3d65SYIEx52MzWL7cvj4bcUEWN/zxl0PgEP9JhROr4yKBB2NE
 ktpms5V2u6my7dr60TmU50ylUiXIiu5Ik9HdaQ+mZm15t97J6dlume6lOPoAv07f2Lgi
 5e7te/tlU5BdEMstTZMX4WI8rugH1EJZqIilbBCiGgwoui7Rwlx41FcnkrI3v3qFxnpN
 +HXQofqS40DHGxlBALUcNuIsvj0mZ6nyebsFeEP5FL/XA1uoKjYRIINtXjABKwHPN4rI
 7s4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736653334; x=1737258134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C7AQvuoP+ZPSHFkiQbAmP8AT9q9QiFXgKHLG9VQKdJM=;
 b=R5LrVY0Hxw+XdDbzqYfBbOjvOvuu2xJH4Jl5tiAiKW6b3PzZNawt6gbAXfwr5FfsGf
 9omLfHuPMUwkoxAwA86LuKUUkF+ky82qc+Zg+bUwoawdWd/JjSePVj8+fhuLdAiNaGQc
 t//dVcoPP6KmWwXLrXKF3FXYFX+3I06o0JkIcFEaVO2E136YWytGVw9KhAo1OQsXpr0n
 l2m5xFXGu2SRiP2tyrfLX57zpFgzhIPONR1+ORZM+ieQoSsvsD0f7xI9GkRGK790MMQv
 u8EBrK0Aa7LoBYaHoYO2Al+tRcRy5YvIgq1V4cP3M5FoY4oa5lmsHBYlNSCEbJw6ujMG
 rjKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEZ1Ylb747JMqml6cXhueqVfoBNvsjGbAyTBxW6F1K+M3waOQIK5eeofPV1V7bNU4BjX2g9sE=@lists.denx.de
X-Gm-Message-State: AOJu0YxLXI/C4QIFap6xuNnqhLxUAimGsttu1VbVc9wP5AvhJ9V81iL6
 fDUtWh04YLuLNpeudItC90KInL0hmaLNogbzCnL8d9CIiiB74eSrNlK84Io535E=
X-Gm-Gg: ASbGnctUIWrTFqYffSpgejFA1YpPBdSaX3Ir9b09H309Er1kJnIWt3M8IbewzmrHoxH
 tTleHRvpz7atxaOCrJ4s4uHKOgges/xNiLl7FUoVbHYnI9TkKcngktaUbONG1B7nkKBr3WUuQAh
 kKPr88rFjFIaExCdd5zCiBx3srwJxRdOMS3aXzwRJjxZ2he72j3ZVW5uL6MJB/qgnGVKEHvVOSD
 xra8Pm/7bxlYY3bU5X8fTEcvkKfxzHD8gHO+UnRXAmEri1gizmQPn+4fGRo2NJzwaU=
X-Google-Smtp-Source: AGHT+IEzqnLrGFdz47Ab7slofyeUHGx1b5rC6rN661SyMjZU6HqhhC2AkCcHA5J/K6pdk8viKjcdCg==
X-Received: by 2002:a05:6830:6213:b0:718:d31:feb8 with SMTP id
 46e09a7af769-721e2e2ded2mr10496710a34.7.1736653334629; 
 Sat, 11 Jan 2025 19:42:14 -0800 (PST)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7231855f028sm2321345a34.36.2025.01.11.19.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 19:42:14 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: [PATCH 0/3] bootstd: Fix efi_mgr usage in bootmeths env var
Date: Sat, 11 Jan 2025 21:42:10 -0600
Message-Id: <20250112034213.13153-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

Defining the 'bootmeths' environment variable with efi_mgr causes NULL
pointer dereference when running 'bootflow scan' on the E850-96 board.
This patch series fixes that, and cleans up the surrounding code a
little while at it.

Sam Protsenko (3):
  bootstd: Fix memleak on errors in bootmeth_setup_iter_order()
  bootstd: Probe bootmeth devices for bootmeths env var
  bootstd: Fix incorrect struct name in bootmeth_setup_iter_order()

 boot/bootmeth-uclass.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

-- 
2.39.5

