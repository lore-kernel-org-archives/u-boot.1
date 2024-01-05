Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036D7C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 20:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AF76871DA;
	Fri,  5 Jan 2024 21:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FJXRIBL4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A17C871CF; Fri,  5 Jan 2024 21:12:24 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12AF2871DA
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 21:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-67f9f6ca479so9066886d6.3
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 12:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704485539; x=1705090339; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JldKUV4sIFOcxalqTj4YMwAwDfiiVXgGXLgR7VeiZvM=;
 b=FJXRIBL45w4vScDpX0DxtepFWKIucyPv1/rUVs4/JXAIqit2LHrFTVVqtWyXFCulQn
 BF0jZnGHSi8QcH/nt7xbryPcNMSnBsbFjHHyLUL8KE7u35mdSeb1hg02haQiehSE+XQA
 DPEBGLIFUZsf1BTZzk4r8PW5K5QW/F80RuxAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704485539; x=1705090339;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JldKUV4sIFOcxalqTj4YMwAwDfiiVXgGXLgR7VeiZvM=;
 b=o638uPwTR/INq+f6RCFYL9obheB6i9Hsoow2PhkhE2SG9JLqswXkK/epGfUFgjJcw1
 3MTxW5unz/cXOfci+iUXlaMmI/EUkKBRXJEBRFtYdCHEdClLezipNds+/KaV7+3Lq3Gy
 NIrMZMpdciW1Fp7hZp3NG3shq1n+dDa6q1lmNfs7LvCNCFv6v6t/ENBqVHvDcpP5TjuN
 OZpcQqB9lqwggCM4SdngJYByNw41bqaqdGvOa6aI2EtiUqZEnhx51AamGTU2sGaam7qt
 Ei7JEibgfjKRqSMKfwqG/BkTxr2SIh6U1QqtKf9z1+HiQHf5NYr0pBeRm17Eb6ruxFiX
 lhzg==
X-Gm-Message-State: AOJu0YwBjuvx5UoqB4A+9s0U+OQWbnpvhSZsyN3FTR7bwzz/HHkgdsOt
 +dDww0hmN1HCCXVqRLt3v43TyDnLSYolBYQpLQ4tonMtHD02
X-Google-Smtp-Source: AGHT+IF83duCWvIeVO2I8VZ2vhARAFpe0Ju+DGAlDtg+Q1zS9B0/P+4RFZ6F5uP4cJZCDi9tcyAhakoEeRzmlQ3+2LE=
X-Received: by 2002:a05:6214:27c9:b0:67f:9237:53a6 with SMTP id
 ge9-20020a05621427c900b0067f923753a6mr2473007qvb.12.1704485539398; Fri, 05
 Jan 2024 12:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20240104151152.697855-1-sjg@chromium.org>
 <CAEUhbmXhT2Wz0XHEvvbYsOk3XSkVO91Kp4E_qjDJLemuu+yMJg@mail.gmail.com>
In-Reply-To: <CAEUhbmXhT2Wz0XHEvvbYsOk3XSkVO91Kp4E_qjDJLemuu+yMJg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 5 Jan 2024 13:12:08 -0700
Message-ID: <CAFLszTiaC31jm5By9JFKSHU5QfHQLDdHqGwXK9tus6wZ_fGaZg@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] x86: expo: Add support for editing coreboot CMOS
 RAM settings
To: Bin Meng <bmeng.cn@gmail.com>
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

Hi Bin,

On Thu, Jan 4, 2024 at 4:02=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Thu, Jan 4, 2024 at 11:11=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > U-Boot provides support for editing settings with an 'expo', as well as
> > reading and writing settings to CMOS RAM.
> >
> > This series integrates expo functionality with coreboot, using the
> > sysinfo table to get a list of settings, creating an expo with them and
> > allowing them to be edited.
> >
> > A new CI test provides coverage for some coreboot-related commands. For
> > this to work, a number of minor tweaks are made to existing tests, so
> > that they pass on coreboot (x86) or at least are skipped when they
> > cannot pass. Likely most of these fixes will apply to other boards too.
> >
> > It includes several other fixes and improvements:
> > - new -m flag for 'bootflow scan' so it can display a menu automaticall=
y
> > - Fix for video-scrolling crash with Truetype
> > - menu items can now have individual integer values
> > - menu items are lined up according to the width of all menu labels
> >
> > Changes in v2:
> > - Avoid using common.h
> > - Avoid using common.h
> > - Rebase to -next
> >
> > Simon Glass (19):
> >   video: Add a dark-grey console colour
> >   video: Avoid starting a new line to close to the bottom
> >   expo: Place menu items to the right of all labels
> >   expo: Set the initial next_id to 1
> >   expo: Use standard numbering for save and discard
> >   expo: Allow menu items to have values
> >   expo: Add a little more cedit CMOS logging
> >   expo: Support menu-item values in cedit
> >   expo: Drop unneceesary calls to expo_str()
> >   expo: Drop scene_title_set()
> >   expo: Add forward declaration for udevice to cedit
> >   x86: coreboot: Enable unit tests
> >   x86: CI: Update coreboot
> >   x86: coreboot: Add a test for cbsysinfo command
> >   x86: coreboot: Show the option table
> >   x86: coreboot: Enable support for the configuration editor
> >   x86: coreboot: Add a command to check and update CMOS RAM
> >   x86: coreboot: Allow building an expo for editing CMOS config
> >   x86: Enable RTC command by default
> >
> >  .azure-pipelines.yml              |   2 +-
> >  .gitlab-ci.yml                    |   2 +-
> >  arch/sandbox/dts/cedit.dtsi       |   3 +
> >  arch/x86/dts/coreboot.dts         |   7 +
> >  boot/Makefile                     |   4 +
> >  boot/cedit.c                      | 191 +++++++++++++++--------
> >  boot/expo.c                       |   3 +
> >  boot/expo_build.c                 |  36 ++---
> >  boot/expo_build_cb.c              | 245 ++++++++++++++++++++++++++++++
> >  boot/scene.c                      |  61 ++++++--
> >  boot/scene_internal.h             |  30 +++-
> >  boot/scene_menu.c                 |  26 +++-
> >  boot/scene_textline.c             |   3 +-
> >  cmd/Kconfig                       |  12 ++
> >  cmd/cedit.c                       |  28 ++++
> >  cmd/x86/Makefile                  |   1 +
> >  cmd/x86/cbcmos.c                  | 139 +++++++++++++++++
> >  cmd/x86/cbsysinfo.c               |  73 ++++++++-
> >  configs/coreboot64_defconfig      |   2 +
> >  configs/coreboot_defconfig        |   6 +
> >  doc/board/coreboot/coreboot.rst   |   6 +
> >  doc/develop/cedit.rst             |   9 +-
> >  doc/develop/expo.rst              |  26 +++-
> >  doc/usage/cmd/cbcmos.rst          |  45 ++++++
> >  doc/usage/cmd/cbsysinfo.rst       |  99 ++++++++++++
> >  doc/usage/cmd/cedit.rst           |  91 ++++++++++-
> >  doc/usage/index.rst               |   1 +
> >  drivers/video/vidconsole-uclass.c |   4 +-
> >  drivers/video/video-uclass.c      |   3 +
> >  include/cedit.h                   |   2 +
> >  include/expo.h                    |  51 +++++--
> >  include/test/cedit-test.h         |  30 ++--
> >  include/video.h                   |   4 +-
> >  include/video_console.h           |   8 +
> >  test/boot/cedit.c                 |  22 ++-
> >  test/boot/expo.c                  |  26 +++-
> >  test/boot/files/expo_ids.h        |   3 +-
> >  test/boot/files/expo_layout.dts   |   5 +-
> >  test/cmd/Makefile                 |   1 +
> >  test/cmd/coreboot.c               | 119 +++++++++++++++
> >  tools/expo.py                     |  33 +++-
> >  41 files changed, 1309 insertions(+), 153 deletions(-)
> >  create mode 100644 boot/expo_build_cb.c
> >  create mode 100644 cmd/x86/cbcmos.c
> >  create mode 100644 doc/usage/cmd/cbcmos.rst
> >  create mode 100644 test/cmd/coreboot.c
> >
>
> I have applied all patches in the queue to u-boot-x86/master. When
> testing coreboot with the graphics console, I found a regression. See
> below:
>
> With u-boot/master, I got:
> https://ibb.co/swt8ZQ5
>
> With u-boot-x86/master, I got:
> https://ibb.co/5MZ76mC
>
> As you can see, the text is crooked and misaligned. I didn't have time
> to locate which commit(s) is the culprit.
>
> Would you please take a look?

Actually this is WAI since it now uses a proportional font instead of
fixed width!

Regards,
Simon
