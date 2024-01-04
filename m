Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED4AC47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 23:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94CA687756;
	Fri,  5 Jan 2024 00:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CxLWUojG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96DF687708; Fri,  5 Jan 2024 00:02:35 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E7D787756
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 00:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55642663ac4so1203586a12.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 15:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704409353; x=1705014153; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5E9+K7A6M8bcBpRPiNnaqvpnPeE6IEvkMszMjK51Ho4=;
 b=CxLWUojGxbTRo8eNJjquvRRyUqg1Sy3zUlvqfLFFbdizDUAHKOge0krDWaG84PwDp0
 qkj1n5mbdkJ8MUSkPhJjt1dTAmG4SkKm1SXjOSgz5urwDFo850HL/Pdz5buDkdNKJLXW
 d1lfEesl8/ksrmG+E7H/MY/e6Zai1JQyg8sHJ5jeqVyb+gfCsvYuqZs0rsICT/UcVtks
 Ar/zX3TcYKo52zj6K54ndFl6gWeWrqHAo0IBxrJQNYAvD1b8NacXoB+zchflaRiIY8kt
 vUC/ccTBxA2B6sIDI4jImslElMNc9zkWb0VjpfJA/mLXBeHHM2mf595z8dbgz4ze6JxO
 BhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704409353; x=1705014153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5E9+K7A6M8bcBpRPiNnaqvpnPeE6IEvkMszMjK51Ho4=;
 b=LffYfPCya3H7lzaApqqbxJn75EskUbnAQaUGPA2C5VxoEq/Q9sd8k4JSNh05oNR9ld
 3a0KFC3X7CFRf8g5SUxKPtMKt4KK361GYqL9Mrzmdn3/jeib7OlZLUmskAx9bhdmqrWw
 hyOF1WF9lO++ekkvM5BZl9vQnJU463ptFt33fhO9lgs/bGdTeArDKzKMbhkJ+GB7GY/5
 pnt9X6+6Bb8Gv9XL0oB3LLHUtn0wptr5Mm6ipeIyiVJvUEZ1TIFnAx1Ff08yVyfDMtrM
 i1fAvFnrPY7xXMpfH02JG5S+2jdZM9NDcatC+o1HUADZonaYTdp9e1z+450ylbdUCt53
 IPKw==
X-Gm-Message-State: AOJu0YycIUiI5IIJDJqkbM0/UtGY/pS37Ui8394aZXfRrEzrFlTU0a+/
 n+ft24hHFm7OLBMc/+utYsCAy1Xma9Rqbz34HRQ=
X-Google-Smtp-Source: AGHT+IE8NCbZzrAR4lBEMWhPdLFM0IrhKd4i9kweWjx323iw+gaRKjIpz4DJ3/VQVzzUoAgGwe7hhQeEG9wq5Km70mk=
X-Received: by 2002:a17:906:696:b0:a28:cf0a:c29e with SMTP id
 u22-20020a170906069600b00a28cf0ac29emr659258ejb.114.1704409352475; Thu, 04
 Jan 2024 15:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20240104151152.697855-1-sjg@chromium.org>
In-Reply-To: <20240104151152.697855-1-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 5 Jan 2024 07:02:21 +0800
Message-ID: <CAEUhbmXhT2Wz0XHEvvbYsOk3XSkVO91Kp4E_qjDJLemuu+yMJg@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] x86: expo: Add support for editing coreboot CMOS
 RAM settings
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

On Thu, Jan 4, 2024 at 11:11=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> U-Boot provides support for editing settings with an 'expo', as well as
> reading and writing settings to CMOS RAM.
>
> This series integrates expo functionality with coreboot, using the
> sysinfo table to get a list of settings, creating an expo with them and
> allowing them to be edited.
>
> A new CI test provides coverage for some coreboot-related commands. For
> this to work, a number of minor tweaks are made to existing tests, so
> that they pass on coreboot (x86) or at least are skipped when they
> cannot pass. Likely most of these fixes will apply to other boards too.
>
> It includes several other fixes and improvements:
> - new -m flag for 'bootflow scan' so it can display a menu automatically
> - Fix for video-scrolling crash with Truetype
> - menu items can now have individual integer values
> - menu items are lined up according to the width of all menu labels
>
> Changes in v2:
> - Avoid using common.h
> - Avoid using common.h
> - Rebase to -next
>
> Simon Glass (19):
>   video: Add a dark-grey console colour
>   video: Avoid starting a new line to close to the bottom
>   expo: Place menu items to the right of all labels
>   expo: Set the initial next_id to 1
>   expo: Use standard numbering for save and discard
>   expo: Allow menu items to have values
>   expo: Add a little more cedit CMOS logging
>   expo: Support menu-item values in cedit
>   expo: Drop unneceesary calls to expo_str()
>   expo: Drop scene_title_set()
>   expo: Add forward declaration for udevice to cedit
>   x86: coreboot: Enable unit tests
>   x86: CI: Update coreboot
>   x86: coreboot: Add a test for cbsysinfo command
>   x86: coreboot: Show the option table
>   x86: coreboot: Enable support for the configuration editor
>   x86: coreboot: Add a command to check and update CMOS RAM
>   x86: coreboot: Allow building an expo for editing CMOS config
>   x86: Enable RTC command by default
>
>  .azure-pipelines.yml              |   2 +-
>  .gitlab-ci.yml                    |   2 +-
>  arch/sandbox/dts/cedit.dtsi       |   3 +
>  arch/x86/dts/coreboot.dts         |   7 +
>  boot/Makefile                     |   4 +
>  boot/cedit.c                      | 191 +++++++++++++++--------
>  boot/expo.c                       |   3 +
>  boot/expo_build.c                 |  36 ++---
>  boot/expo_build_cb.c              | 245 ++++++++++++++++++++++++++++++
>  boot/scene.c                      |  61 ++++++--
>  boot/scene_internal.h             |  30 +++-
>  boot/scene_menu.c                 |  26 +++-
>  boot/scene_textline.c             |   3 +-
>  cmd/Kconfig                       |  12 ++
>  cmd/cedit.c                       |  28 ++++
>  cmd/x86/Makefile                  |   1 +
>  cmd/x86/cbcmos.c                  | 139 +++++++++++++++++
>  cmd/x86/cbsysinfo.c               |  73 ++++++++-
>  configs/coreboot64_defconfig      |   2 +
>  configs/coreboot_defconfig        |   6 +
>  doc/board/coreboot/coreboot.rst   |   6 +
>  doc/develop/cedit.rst             |   9 +-
>  doc/develop/expo.rst              |  26 +++-
>  doc/usage/cmd/cbcmos.rst          |  45 ++++++
>  doc/usage/cmd/cbsysinfo.rst       |  99 ++++++++++++
>  doc/usage/cmd/cedit.rst           |  91 ++++++++++-
>  doc/usage/index.rst               |   1 +
>  drivers/video/vidconsole-uclass.c |   4 +-
>  drivers/video/video-uclass.c      |   3 +
>  include/cedit.h                   |   2 +
>  include/expo.h                    |  51 +++++--
>  include/test/cedit-test.h         |  30 ++--
>  include/video.h                   |   4 +-
>  include/video_console.h           |   8 +
>  test/boot/cedit.c                 |  22 ++-
>  test/boot/expo.c                  |  26 +++-
>  test/boot/files/expo_ids.h        |   3 +-
>  test/boot/files/expo_layout.dts   |   5 +-
>  test/cmd/Makefile                 |   1 +
>  test/cmd/coreboot.c               | 119 +++++++++++++++
>  tools/expo.py                     |  33 +++-
>  41 files changed, 1309 insertions(+), 153 deletions(-)
>  create mode 100644 boot/expo_build_cb.c
>  create mode 100644 cmd/x86/cbcmos.c
>  create mode 100644 doc/usage/cmd/cbcmos.rst
>  create mode 100644 test/cmd/coreboot.c
>

I have applied all patches in the queue to u-boot-x86/master. When
testing coreboot with the graphics console, I found a regression. See
below:

With u-boot/master, I got:
https://ibb.co/swt8ZQ5

With u-boot-x86/master, I got:
https://ibb.co/5MZ76mC

As you can see, the text is crooked and misaligned. I didn't have time
to locate which commit(s) is the culprit.

Would you please take a look?

Regards,
Bin
