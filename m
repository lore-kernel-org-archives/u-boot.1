Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FACC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 09:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7987E87725;
	Thu, 11 Jan 2024 10:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AQGNRdiD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 770EA87725; Thu, 11 Jan 2024 10:50:52 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 502D787A99
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 10:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33694bf8835so4151560f8f.3
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 01:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704966650; x=1705571450;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Hr+Zp6/XS3IW9+cANsoGfZU5cdTZrUycKfc5qf6fN4o=;
 b=AQGNRdiDcRWU81KZntkN4CQxv1y7UTRX6zt04IoaegioYB8uVGEmtQt5/RyQhrTRMB
 saVdEbFvZ5cylaKLdHAh2TubA9+e+A7mG7dMDohXBR25nqA6qx6Sh+yHx9pYTk15qeDU
 J3dmD7w/Hg3QfIEZ2gZcYiNLeK4fnALBVzfQo1bS3JZz6MJA9PsU9Ad/juc+5vHi4j/T
 6G5K5/dMTgVUxWg5F6gIvpI7WMago3mGfjoaTwq4elN/cN+KGOC05c7SYBczScEJAj45
 9bDGlQiSIy8dq+uYdWiNZwZjB22TrFkFpUeKFf1g0VGHb6rjhdEh+z0QIg004KgvXTDe
 /R2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704966650; x=1705571450;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hr+Zp6/XS3IW9+cANsoGfZU5cdTZrUycKfc5qf6fN4o=;
 b=B5+SKbT3jgZRl/AqpaZroRWdQk5kNUBdTiSEaJF2n1DpS1KGmOb4wfBxJ+OSaAqSQu
 rMlR/xa2xNrvHQn1VIClDE0aPcq53OycMfxT0MMx6jHYAgT8dqSmIbNxk2l8hgz8wHUB
 VnQUFU9FERctarfNEArmaC/xUMEuYJlO10GLEr4aAdpvr8ZgnlUnx0r2IuhcappP8KCa
 Fcz5MBVdHNEY97s6uPNEPSxQ4inBlhnazfeYh8jPwLvybLkAgu/X4G9kbc6852HmZ9St
 St0y7QA/n0c0aL1i5xn8A8JM+nMfnOkyWHSymAiryeKjURp2X2pnt5cNhEaHClAcZL+h
 kJDQ==
X-Gm-Message-State: AOJu0YwJAL2tpZ4YB3RRFATwU+c5yLG5lxXFIBr4EmjBifuPRCGRJJzx
 KajV6pMyhuAqTcMggHyn3hu2105BPjKG7y0P2R7GtljLtas=
X-Google-Smtp-Source: AGHT+IEJbsopqSa1rGgU84DkzUekEcqJ2cZnBShYhp1GQEPYWPTlCOfrvgxAW5DA7P1lNUJ4aADxNw==
X-Received: by 2002:a05:6000:1813:b0:337:62c0:796a with SMTP id
 m19-20020a056000181300b0033762c0796amr429521wrh.8.1704966649659; 
 Thu, 11 Jan 2024 01:50:49 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 d6-20020a056000114600b003366a9cb0d1sm747318wrx.92.2024.01.11.01.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 01:50:49 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-dfu-20240111
Date: Thu, 11 Jan 2024 10:50:47 +0100
Message-ID: <875y006vwo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Here are some developments for master including:

- Implement fastboot multi-response. This allows multi-line response and
  most importantly, finally adds support for fastboot getvar all command.

- New 'fastboot oem console' command. Useful for debugging to send data
  the u-boot shell via fastboot

- Console recording fixes

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/19279

Thanks,
Mattijs

The following changes since commit c5e461fbf7cc72f0c1c8a79226b6a5170e56cb4d:

  Merge tag 'u-boot-imx-master-20240108' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-01-08 13:39:43 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20240111

for you to fetch changes up to 6c2f753f4ad3dcee60190949d1286736a6d51d17:

  test: hush: dollar: fix bugous behavior (2024-01-09 15:31:59 +0100)

----------------------------------------------------------------
u-boot-dfu-20240111

- Implement fastboot multi-response. This allows multi-line response and
  most importantly, finally adds support for fastboot getvar all command.

- New 'fastboot oem console' command. Useful for debugging to send data
  the u-boot shell via fastboot

- Console recording fixes

----------------------------------------------------------------
Ion Agorria (7):
      fastboot: multiresponse support
      fastboot: implement "getvar all"
      common: console: introduce console_record_isempty helper
      common: console: record console from the beginning
      lib: membuff: fix readline not returning line in case of overflow
      fastboot: add oem console command support
      test: hush: dollar: fix bugous behavior

 boot/bootmeth_extlinux.c          |  2 +-
 common/console.c                  | 10 ++++-
 doc/android/fastboot-protocol.rst |  3 ++
 doc/android/fastboot.rst          |  1 +
 drivers/fastboot/Kconfig          |  7 ++++
 drivers/fastboot/fb_command.c     | 52 ++++++++++++++++++++++++++
 drivers/fastboot/fb_getvar.c      | 77 ++++++++++++++++++++++++++++++++-------
 drivers/usb/gadget/f_fastboot.c   | 29 +++++++++++++++
 include/console.h                 | 13 +++++++
 include/fastboot-internal.h       |  7 ++++
 include/fastboot.h                | 19 ++++++++++
 include/membuff.h                 |  5 ++-
 lib/membuff.c                     |  4 +-
 net/fastboot_udp.c                | 29 ++++++++++++---
 test/hush/dollar.c                | 23 ++----------
 15 files changed, 236 insertions(+), 45 deletions(-)

