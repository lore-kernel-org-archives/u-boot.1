Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F3FC47077
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 04:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63298874D5;
	Sat,  6 Jan 2024 05:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NwXoD6NK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F4D087463; Sat,  6 Jan 2024 05:12:26 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E7D8874D5
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 05:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e7e55c0f6so218711e87.0
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 20:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704514342; x=1705119142; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dcieJV8pELZaAf0n16OjPhNVcOlrX96OR/tuRH1kSA=;
 b=NwXoD6NKv1hXzkvWihyXE/5zZ4/D/z7nmpnkHIh5ysK7bR2Z0OkVFvPZG2bntjSVhv
 0DXSg/9dpC0jTZ9+g95CyJpmTCnOBGum8628Ytx2YAAT9otV4w6TjHlg8F66QHovyjn5
 yTl9aUf9p0I/LcqzdeTx0hrUaWNhIqN+n0BVzRkwM43oA38GqGIChVr0NhWjqvEcP+hQ
 lmB2w/v38/yChpxGrzxaWK4XEEI1O+S17Aq26WDEmAiBAsGU9yASBA1CaAXaApA8yp9o
 NCENwyByGhpdrFA14wpLTd84WdnNn2AZNEMx0MtP9yTRublCqK/YRAMEYmRWimj5AGLM
 RmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704514342; x=1705119142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2dcieJV8pELZaAf0n16OjPhNVcOlrX96OR/tuRH1kSA=;
 b=CU+FDSdGIUvz4uy5OTef/vIhZ+bxsnNprvalMGWsxU0C47gsT39FlCpuFiKqh+7aXL
 INj6Zes99WMvZD+OeY4p9cY0t3AJnAdzWZ3AAPQXA7pSLfUE4pObQsQRN2GzCz6K9d39
 q3a5Byr42as540sPAYI7jY7IGbu1A2JyjExvEyRi/bfwA66KGcOGPcBfetJnDw6JymJE
 UBJX6dH8YwEQ82/v/Ux9g5qyFZh9sSHfileXpob5mRpXGmm/03U3+4b/Ytglc6DEnw8L
 bEha0Tw2YscJoLvt47tbXhtrPJCzTHLcmHu33Wb67S2q6ryZQMMITrckI+0f7KUifNuo
 kF4Q==
X-Gm-Message-State: AOJu0YxxgC9So60sLruU72mXgYOC8/lE+JfFUhkxUssZW3uKOalGP4oJ
 uglnz4cEb+lTOokKc0PF2X/hyFrs3uqJcOi+CCAgpP1xj+0=
X-Google-Smtp-Source: AGHT+IEBJHr0imTPQ2xCK0/qwlxRvasDaJMTvWFFsRvRd9QYVuQUZ8xvc+KT1ONt1kpQy6Te/MLY4tflKruSl7SocZo=
X-Received: by 2002:a05:6512:11c1:b0:50e:6332:8083 with SMTP id
 h1-20020a05651211c100b0050e63328083mr78200lfr.183.1704514341815; Fri, 05 Jan
 2024 20:12:21 -0800 (PST)
MIME-Version: 1.0
References: <20240104151152.697855-1-sjg@chromium.org>
 <CAEUhbmXhT2Wz0XHEvvbYsOk3XSkVO91Kp4E_qjDJLemuu+yMJg@mail.gmail.com>
 <CAFLszTiaC31jm5By9JFKSHU5QfHQLDdHqGwXK9tus6wZ_fGaZg@mail.gmail.com>
 <CAEUhbmXXi5n4pTRCYaRfrrH-QH3gZjSV+mOe6cwOU=RKv-PWQA@mail.gmail.com>
 <CAFLszTj0KikUYh0=+Bq3RX+BurAxxA8=+NJ61kAqjaKtYs3YWg@mail.gmail.com>
In-Reply-To: <CAFLszTj0KikUYh0=+Bq3RX+BurAxxA8=+NJ61kAqjaKtYs3YWg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 6 Jan 2024 12:12:10 +0800
Message-ID: <CAEUhbmVVk+bb3E+=3rKLw7=VZRRL6q4LwwZpTHajiJEKh5n6-w@mail.gmail.com>
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

On Sat, Jan 6, 2024 at 9:38=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Bin,
>
> On Fri, Jan 5, 2024 at 4:06=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wrot=
e:
> >
> > Hi Simon,
> >
> > On Sat, Jan 6, 2024 at 4:12=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> > >
> > > Hi Bin,
> > >
> > > On Thu, Jan 4, 2024 at 4:02=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> =
wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Thu, Jan 4, 2024 at 11:11=E2=80=AFPM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > U-Boot provides support for editing settings with an 'expo', as w=
ell as
> > > > > reading and writing settings to CMOS RAM.
> > > > >
> > > > > This series integrates expo functionality with coreboot, using th=
e
> > > > > sysinfo table to get a list of settings, creating an expo with th=
em and
> > > > > allowing them to be edited.
> > > > >
> > > > > A new CI test provides coverage for some coreboot-related command=
s. For
> > > > > this to work, a number of minor tweaks are made to existing tests=
, so
> > > > > that they pass on coreboot (x86) or at least are skipped when the=
y
> > > > > cannot pass. Likely most of these fixes will apply to other board=
s too.
> > > > >
> > > > > It includes several other fixes and improvements:
> > > > > - new -m flag for 'bootflow scan' so it can display a menu automa=
tically
> > > > > - Fix for video-scrolling crash with Truetype
> > > > > - menu items can now have individual integer values
> > > > > - menu items are lined up according to the width of all menu labe=
ls
> > > > >
> > > > > Changes in v2:
> > > > > - Avoid using common.h
> > > > > - Avoid using common.h
> > > > > - Rebase to -next
> > > > >
> > > > > Simon Glass (19):
> > > > >   video: Add a dark-grey console colour
> > > > >   video: Avoid starting a new line to close to the bottom
> > > > >   expo: Place menu items to the right of all labels
> > > > >   expo: Set the initial next_id to 1
> > > > >   expo: Use standard numbering for save and discard
> > > > >   expo: Allow menu items to have values
> > > > >   expo: Add a little more cedit CMOS logging
> > > > >   expo: Support menu-item values in cedit
> > > > >   expo: Drop unneceesary calls to expo_str()
> > > > >   expo: Drop scene_title_set()
> > > > >   expo: Add forward declaration for udevice to cedit
> > > > >   x86: coreboot: Enable unit tests
> > > > >   x86: CI: Update coreboot
> > > > >   x86: coreboot: Add a test for cbsysinfo command
> > > > >   x86: coreboot: Show the option table
> > > > >   x86: coreboot: Enable support for the configuration editor
> > > > >   x86: coreboot: Add a command to check and update CMOS RAM
> > > > >   x86: coreboot: Allow building an expo for editing CMOS config
> > > > >   x86: Enable RTC command by default
> > > > >
> > > > >  .azure-pipelines.yml              |   2 +-
> > > > >  .gitlab-ci.yml                    |   2 +-
> > > > >  arch/sandbox/dts/cedit.dtsi       |   3 +
> > > > >  arch/x86/dts/coreboot.dts         |   7 +
> > > > >  boot/Makefile                     |   4 +
> > > > >  boot/cedit.c                      | 191 +++++++++++++++--------
> > > > >  boot/expo.c                       |   3 +
> > > > >  boot/expo_build.c                 |  36 ++---
> > > > >  boot/expo_build_cb.c              | 245 ++++++++++++++++++++++++=
++++++
> > > > >  boot/scene.c                      |  61 ++++++--
> > > > >  boot/scene_internal.h             |  30 +++-
> > > > >  boot/scene_menu.c                 |  26 +++-
> > > > >  boot/scene_textline.c             |   3 +-
> > > > >  cmd/Kconfig                       |  12 ++
> > > > >  cmd/cedit.c                       |  28 ++++
> > > > >  cmd/x86/Makefile                  |   1 +
> > > > >  cmd/x86/cbcmos.c                  | 139 +++++++++++++++++
> > > > >  cmd/x86/cbsysinfo.c               |  73 ++++++++-
> > > > >  configs/coreboot64_defconfig      |   2 +
> > > > >  configs/coreboot_defconfig        |   6 +
> > > > >  doc/board/coreboot/coreboot.rst   |   6 +
> > > > >  doc/develop/cedit.rst             |   9 +-
> > > > >  doc/develop/expo.rst              |  26 +++-
> > > > >  doc/usage/cmd/cbcmos.rst          |  45 ++++++
> > > > >  doc/usage/cmd/cbsysinfo.rst       |  99 ++++++++++++
> > > > >  doc/usage/cmd/cedit.rst           |  91 ++++++++++-
> > > > >  doc/usage/index.rst               |   1 +
> > > > >  drivers/video/vidconsole-uclass.c |   4 +-
> > > > >  drivers/video/video-uclass.c      |   3 +
> > > > >  include/cedit.h                   |   2 +
> > > > >  include/expo.h                    |  51 +++++--
> > > > >  include/test/cedit-test.h         |  30 ++--
> > > > >  include/video.h                   |   4 +-
> > > > >  include/video_console.h           |   8 +
> > > > >  test/boot/cedit.c                 |  22 ++-
> > > > >  test/boot/expo.c                  |  26 +++-
> > > > >  test/boot/files/expo_ids.h        |   3 +-
> > > > >  test/boot/files/expo_layout.dts   |   5 +-
> > > > >  test/cmd/Makefile                 |   1 +
> > > > >  test/cmd/coreboot.c               | 119 +++++++++++++++
> > > > >  tools/expo.py                     |  33 +++-
> > > > >  41 files changed, 1309 insertions(+), 153 deletions(-)
> > > > >  create mode 100644 boot/expo_build_cb.c
> > > > >  create mode 100644 cmd/x86/cbcmos.c
> > > > >  create mode 100644 doc/usage/cmd/cbcmos.rst
> > > > >  create mode 100644 test/cmd/coreboot.c
> > > > >
> > > >
> > > > I have applied all patches in the queue to u-boot-x86/master. When
> > > > testing coreboot with the graphics console, I found a regression. S=
ee
> > > > below:
> > > >
> > > > With u-boot/master, I got:
> > > > https://ibb.co/swt8ZQ5
> > > >
> > > > With u-boot-x86/master, I got:
> > > > https://ibb.co/5MZ76mC
> > > >
> > > > As you can see, the text is crooked and misaligned. I didn't have t=
ime
> > > > to locate which commit(s) is the culprit.
> > > >
> > > > Would you please take a look?
> > >
> > > Actually this is WAI since it now uses a proportional font instead of
> > > fixed width!
> >
> > Since we are talking about the graphics console, and for consoles the
> > fonts used are usually fixed width ones.
> > What it is now looks really bad. Where do yo need proportional font?
> >
> > Can we switch fonts dynamically?
>
> Yes, it is possible, if multiple fonts are enabled; or we could just
> use a monospace one by default.
>

Would you please prepare some new patches, to keep the default console
font as fixed width and select proportional font one some other place
you need that?

Regards,
Bin
