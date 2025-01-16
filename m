Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D9DC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 20:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B4AE80312;
	Thu, 16 Jan 2025 21:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c+73NbEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C726A806DD; Thu, 16 Jan 2025 16:52:53 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48ACC80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 16:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d982de9547so2255224a12.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737042771; x=1737647571; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xiyBBVfqFpIzY7eBMo/Wr1ZcT3lfDEC+De4jomZGCAI=;
 b=c+73NbEW+T444P38mIsloSCyzFvJ6HsFZ2qoEywI1Wthg1KUUJ35UQziwbYrXCECL8
 mWZZIYC05B8e2biidQfOjcUJZkh0Kuh+F5atqUXOvptCLPNXavNgR63WK7g01pIBI7n6
 pJptragjY3Cw57TkIq5wGyEs9XuUjQ3rBEFec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737042771; x=1737647571;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xiyBBVfqFpIzY7eBMo/Wr1ZcT3lfDEC+De4jomZGCAI=;
 b=T8+BtAozQUL3zHagp8sceZJyLRsK6bbntzIjHXRx+bN/TAmdvEOQj0C4w8J0DtK7nD
 PQB5mcd2p51ORGpd/vy/+KHqa5Y6GyP0sGab9cFWrTQTA0qe8L+iMgwr2sl0NNfhPhhI
 bIiRqGp9XGeaHtn8YZ0TGeSeFCAa+96dt20i/LCtfb092BzKKs5f8p/Heft5R7Q0cnTt
 JQT0t65j7CY8EvQMcpk+QuD/jjLrh4zIK/Pudrjio5737BXC6Er1jAy8MTZt1U2SyWt1
 yUNjlS0GOBfhbPv6jWc3kB55CMU6Z1FK77RIQpOBrviPLgbw3a2c4kaPQjWh9imA9M0g
 F4sg==
X-Gm-Message-State: AOJu0YxQp7zRZ2D18yZOpXPmgFZd4ZmWO/UyTAh2c7joaVc03dG89aAQ
 uSvytsWlANBN+cs6hGPdi6/SW0EPY9PKWwYnDA+XhJjZexvlcfxdlg6MUgxqDa1ICKB/ocBfM+Y
 LGcWmd0qkEKfdXuEelZimwHkEA1F2X1N1nxTQ
X-Gm-Gg: ASbGncufwAAPWc1QxnceKlnL4Y/4H3rPmVBSrjS6Gumb9JSzgI2rg9tYU7Mj02cT925
 62S0pp9QwRhNw6eVYLHGpkUSop/9hR7elQ6YjwIM=
X-Google-Smtp-Source: AGHT+IGvfKAoGtToWnWgm5kemkyLStPXVI9YoigImsapNyiJYNFz5s7SOJmOADMv3BSqnZh6BKzKsuTCQW0EMhCD1jA=
X-Received: by 2002:a17:907:2d24:b0:aae:b259:ef63 with SMTP id
 a640c23a62f3a-ab2ab5f9b18mr3552594666b.34.1737042770641; Thu, 16 Jan 2025
 07:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20241104175110.1048449-1-sjg@chromium.org>
 <CAFLszTgFdNrRev+7n6j+NqCM+em_p-ONAc=+sztoYaP50HUivw@mail.gmail.com>
 <20250115212439.GD3476@bill-the-cat>
 <CAFLszTiSSq-+cSxVgxLJ8atAAjjxRP2AEQmXMbrf+c3FOepnFQ@mail.gmail.com>
 <20250115233157.GE3476@bill-the-cat>
In-Reply-To: <20250115233157.GE3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 16 Jan 2025 08:52:38 -0700
X-Gm-Features: AbW1kvaKOuQwI-3SErsyg7v85G0XzkDsN_MEyyD9dO2eJhHNRjcPj6VMin2nWrw
Message-ID: <CAFLszTga3RD95M2ujLfuXQor39sfcQrEUe3hwRKABiWx04PiZg@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] bootstd: Support recording images
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Dragan Simic <dsimic@manjaro.org>, 
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ion Agorria <ion@agorria.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, 
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Tim Harvey <tharvey@gateworks.com>, Tony Dinh <mibodhi@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 16 Jan 2025 21:47:16 +0100
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

On Wed, 15 Jan 2025 at 16:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jan 15, 2025 at 04:14:27PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 15 Jan 2025 at 14:24, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Jan 15, 2025 at 06:55:45AM -0700, Simon Glass wrote:
> > > > Hi,
> > > >
> > > > On Mon, 4 Nov 2024 at 10:51, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > This series provides a way to keep track of the images used in bootstd,
> > > > > including the type of each image.
> > > > >
> > > > > At present this is sort-of handled by struct bootflow but in quite an
> > > > > ad-hoc way. The structure has become quite large and is hard to query.
> > > > > Future work will be able to reduce its size.
> > > > >
> > > > > Ultimately the 'bootflow info' command may change to also show images as
> > > > > a list, but that is left for later, as this series is already fairly
> > > > > long. So for now, just introduce the concept and adjust bootstd to use
> > > > > it, with a simple command to list the images.
> > > > >
> > > > > This series includes various alist enhancements, to make use of this new
> > > > > data structure a little easier.
> > > > >
> > > > > Changes in v3:
> > > > > - Add a helper in bootflow
> > > > > - Add a new patch supporting ad-hoc bootflows
> > > > > - Add new patch to export bootdev_get_from_blk()
> > > > > - Add new patch to record loaded files in an ad-hoc bootflow
> > > > > - Update bootstd_add_bootflow() to return the element number
> > > > > - Use the helper function
> > > > >
> > > > > Changes in v2:
> > > > > - Add an image type extension in bootflow.h
> > > > > - Change the tag to bootmeth_efi
> > > > > - Drop patches already applied
> > > > > - Drop patches which add new image types
> > > > > - Update to use a new image-type enum in bootflow.h
> > > > > - Use the word 'feature' instead of 'hack'
> > > > >
> > > > > Simon Glass (19):
> > > > >   bootstd: Move bootflow-adding to bootstd
> > > > >   bootstd: Move bootflow-clearing to bootstd
> > > > >   bootstd: Add a function to get bootstd only if available
> > > > >   bootstd: Drop the bootdev-specific list of bootflows
> > > > >   bootstd: Move the bootflow list into an alist
> > > > >   bootstd: Maintain a list of images
> > > > >   bootstd: Update bootmeth_alloc_file() to record images
> > > > >   boot: pxe: Drop the duplicate comment on get_pxe_file()
> > > > >   bootmeth_efi: Simplify reading files by using the common function
> > > > >   bootmeth: Update the read_file() method to include a type
> > > > >   bootmeth_efi: Check the filename-allocation in the network path
> > > > >   boot: Update extlinux pxe_getfile_func() to include type
> > > > >   boot: Update pxe bootmeth to record images
> > > > >   Update bootmeth_alloc_other() to record images
> > > > >   bootstd: Update cros bootmeth to record images
> > > > >   bootstd: Add a simple command to list images
> > > > >   bootstd: Export bootdev_get_from_blk()
> > > > >   bootstd: Add the concept of an ad-hoc bootflow
> > > > >   fs: Record loaded files in an ad-hoc bootflow
> > > > >
> > > > >  boot/bootdev-uclass.c            |  78 ++++++-------------
> > > > >  boot/bootflow.c                  |  77 +++++++++++++++----
> > > > >  boot/bootmeth-uclass.c           |  29 +++++--
> > > > >  boot/bootmeth_android.c          |   3 +-
> > > > >  boot/bootmeth_cros.c             |  17 ++++-
> > > > >  boot/bootmeth_efi.c              |  16 ++--
> > > > >  boot/bootmeth_efi_mgr.c          |   3 +-
> > > > >  boot/bootmeth_extlinux.c         |   7 +-
> > > > >  boot/bootmeth_pxe.c              |  10 ++-
> > > > >  boot/bootmeth_qfw.c              |   3 +-
> > > > >  boot/bootmeth_sandbox.c          |   3 +-
> > > > >  boot/bootmeth_script.c           |   7 +-
> > > > >  boot/bootstd-uclass.c            | 104 +++++++++++++++++++++++--
> > > > >  boot/pxe_utils.c                 |  36 ++++-----
> > > > >  boot/vbe_simple.c                |   5 +-
> > > > >  cmd/Kconfig                      |   9 +++
> > > > >  cmd/Makefile                     |   1 +
> > > > >  cmd/bootdev.c                    |   2 +-
> > > > >  cmd/bootflow.c                   |  11 +--
> > > > >  cmd/bootstd.c                    |  65 ++++++++++++++++
> > > > >  cmd/pxe.c                        |   2 +-
> > > > >  cmd/sysboot.c                    |   6 +-
> > > > >  doc/develop/bootstd/overview.rst |  24 +++++-
> > > > >  doc/usage/cmd/bootstd.rst        |  79 +++++++++++++++++++
> > > > >  doc/usage/index.rst              |   1 +
> > > > >  fs/fs.c                          |  15 ++++
> > > > >  include/bootdev.h                |  36 +++------
> > > > >  include/bootflow.h               |  88 ++++++++++++++++++---
> > > > >  include/bootmeth.h               |  22 ++++--
> > > > >  include/bootstd.h                |  69 ++++++++++++++++-
> > > > >  include/pxe_utils.h              |  14 +++-
> > > > >  test/boot/bootflow.c             | 126 +++++++++++++++++++++++++++++++
> > > > >  test/py/tests/test_ut.py         |   3 +-
> > > > >  33 files changed, 788 insertions(+), 183 deletions(-)
> > > > >  create mode 100644 cmd/bootstd.c
> > > > >  create mode 100644 doc/usage/cmd/bootstd.rst
> > > > >
> > > > > --
> > > > > 2.34.1
> > > > >
> > > >
> > > > patchwork link: https://patchwork.ozlabs.org/project/uboot/list/?series=433068
> > > >
> > > > What is the status of this series please?
> > >
> > > So, for v4 of this series, most arm64 platforms grow by ~1KiB (a few are
> > > 2, a few are a bit less than 1). 32bit ARM is similar but now mx6sabresd
> > > doesn't build in CI (there's some embedded path names that now overflow,
> > > try make O=/tmp/1/2/3/4/5/6/7/8/9/10/mx6sabresd mx6sabresd_config all).
> > > For size changes, really most architectures are like that, so perhaps
> > > it's worth stepping back again and asking where this should be default
> > > enabled. For the mx6sabresd part, if we drop the recording for ad-hoc
> > > (which I think you had suggested at some point since I wasn't sure about
> > > that direction), everything builds at least.
> >
> > Thanks for looking at it. So what do you think about dropping those
> > last two patches and applying the rest? The increase is about 416
> > bytes on pinecube (Thumb2). Quite a bit of this seems to be bringing
> > alist which is something of a one-off hit:
> >
> >                  alist_ensure_ptr                             -      64     +64
> >                  alist_calc_index                             -      32     +32
> >                  alist_add_ptr                                -      26     +26
> >                  alist_update_end                             -      18     +18
> >                  alist_empty                                  -       6      +6
> >                  alist_add_placeholder                        -       6      +6
> >
> > Then I can use the final two patches as the start of the series to
> > finish off ad-hoc images.
>
> I was thinking just patch #20, but we can drop 19 and 20 instead, sure.

May as well.

>
> > As to default-enabled, moving bootflow to an alist isn't really
> > something we can disable.
>
> I'm referring to the whole bootmeth/bootflow/etc thing. Is this going to
> be put to use by anyone / anywhere on PowerPC? M68K? MIPS? 32bit ARM is
> a harder question there, which is also where this particular overflow
> was.

I'm still not sure what you are saying. Are you wanting to disable
bootstd by default / go back to distro scripts / force everyone to use
EFI_LOADER / ?

Regards,
Simon
