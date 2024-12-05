Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A9FE77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 17:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7E1889526;
	Thu,  5 Dec 2024 18:57:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TFv6l9iP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FEBE89518; Thu,  5 Dec 2024 18:57:56 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B4389517
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 18:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso1393171a12.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 09:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733421472; x=1734026272; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZlfeXdF6CNaurgBWO4UitHe0M419ZUJtBBiOpPXtW2E=;
 b=TFv6l9iPuxWQ86NcHogpERxouodWig+qR1JrB83S6dDylS54zdcvU7STwKhaK/bUtm
 L3QObmSLfWsWNvJ6FJUWPF2e+zo7mzHt1hQF4yf8Bn4mCrkv+EA0M5VITEk2JhOj6qG1
 JME7xMibOUIbY0q4G7dVqJaJjy2BJuapSPRTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733421472; x=1734026272;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZlfeXdF6CNaurgBWO4UitHe0M419ZUJtBBiOpPXtW2E=;
 b=t8WWTLy3Mla1G/N96ox9fFW/XwPirFVxGAX6k84U9U1uqHXOXZv8UmQQYltIlT26fL
 qgEa5PmEidZmoUnN7NJU3LppN68rkqQExyeg07u2IpJwwuC/D7+2r3UymvRoRTMndUqH
 Xrhh4wXjn+K8xm/S5AKgmaTmUI/KlWzojGAmvNOp3xZjuJwxhDLV+PrFppCvWQPN7h26
 B2Rdll2yqdGaYifVWSHv0U+fg9hS0r7SugiyXJEbNDZwuIHOsNmf39XP+n4QYKECFd4i
 /NlmFOlGqCjGkBfMPRU8YSp+GvQD54rEQUElnyXu4vp3/pQhgNhSCI0t3/iIpSArDD9A
 0lQg==
X-Gm-Message-State: AOJu0YzZdZrJbssBs+NuiYwLcdA9WMRgERYr2F6Vn2P4B4nJTsHedpDc
 gJ3dPAIBqN0NrtzeoTPGiqXPOAQzUUX6sXFctkDbCebNZD7yTexrpOWMKy6R622CfChWFPoDXIO
 U+SEDbNDKnRvlyU7GqEjR2SVXN61Fw1fJmL6S
X-Gm-Gg: ASbGncuOnwHARyASVqbvF9rogoBLtonk9qvdn+w5rFtXXafPLWyR5LwQ5Jh89kXqpMR
 9npidSIzC62T47ZwX0Mlbd9po/mKLFWzL
X-Google-Smtp-Source: AGHT+IFWHfIEbvy+aTNKPvCBbbPEJrC9uNPWxQOzMfXdCeSWrlEU/zlkB+2o0Y3dzCq7jXnFYjcV0kvJ/9KLy0N9ihE=
X-Received: by 2002:a05:6402:35d1:b0:5d0:d786:b894 with SMTP id
 4fb4d7f45d1cf-5d10cb80107mr19697020a12.26.1733421472554; Thu, 05 Dec 2024
 09:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20241203234559.2938192-1-sjg@chromium.org>
 <CAFLszThuRngaW_kOTnEakDr6GSRc5TWpy7WT9yvQJmuMP2eUVw@mail.gmail.com>
 <20241204001234.GC2457179@bill-the-cat>
 <CAFLszTi9cF-1NVPm8FqWdmiyAuKTJERzxgbCq=YXDX5zY=MgWQ@mail.gmail.com>
In-Reply-To: <CAFLszTi9cF-1NVPm8FqWdmiyAuKTJERzxgbCq=YXDX5zY=MgWQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Dec 2024 10:57:40 -0700
Message-ID: <CAFLszTiX0XWR5b43DFFJ_AMJKRjfTgpQ02+e6w0Tykc2Jog6_w@mail.gmail.com>
Subject: Re: [PATCH v2 00/41] pxe: Support read_all() for extlinux and PXE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ion Agorria <ion@agorria.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Ramon Fried <rfried.dev@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 3 Dec 2024 at 17:37, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Tue, 3 Dec 2024 at 17:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 03, 2024 at 05:03:26PM -0700, Simon Glass wrote:
> > > Hi,
> > >
> > > On Tue, 3 Dec 2024 at 16:46, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > This series implements read_all() so that it is possible to read all the
> > > > files relating to a bootflow, make adjustments and then boot.
> > > >
> > > > Unfortunately quite a few things stand in the way, so this series
> > > > finishes off several pending items: zboot without CONFIG_CMDLINE,
> > > > required support in pxe_utils and the differing code in the extlinux and
> > > > PXE bootmeths. There is very little new code, but quite a lot of
> > > > refactoring.
> > > >
> > > > The bootm, booti and bootz commands have all been refactored previously,
> > > > so that they can operate without needing CONFIG_CMDLINE to be enabled.
> > > > At the, time, zboot was left alone, since it is x86-specific and a bit
> > > > more trouble.
> > > >
> > > > This series adds a programatic API for zboot and uses the forthcoming
> > > > bootstd 'image list' to collect information from an extlinux file. It is
> > > > therefore possible to parse the file, load the resulting images and then
> > > > examine/adjust the resulting bootflow, before booting.
> > > >
> > > > The addition of options to extlinux resulted in the PXE and extlinux
> > > > bootmeth having slightly different features. This is tidied up in this
> > > > series, with common functions for both. This allows the same features
> > > > (loading images as a separate step) to be provided for PXE.
> > > >
> > > > Changes in v2:
> > > > - Split out strlcpy() change into new patch
> > > > - Move strlcpy() change into an earlier patch
> > > > - Fix 'initaddr' typo'
> > > > - Rebase on earlier change
> > > > - Add new patch to simplify the code reading fdtcontroladdr and fdt_addr
> > > >
> > > > Simon Glass (41):
> > > >   x86: Make do_zboot_states() static
> > > >   x86: Rename zboot_run() to zboot_run_args()
> > > >   x86: Drop duplicate definition of zimage_dump()
> > > >   x86: Move x86 zboot state into struct bootm_info
> > > >   x86: Rename state to bmi
> > > >   x86: Move the bootm state for zimage into cmd/
> > > >   bootstd: Correct display of kernel version
> > > >   x86: Drop the unnecessary base_ptr argument to zboot_dump()
> > > >   boot: Use strlcpy() in label_boot()
> > > >   boot: Split pxe label_boot() into two parts
> > > >   boot: Split pxe label_run_boot() into two parts
> > > >   boot: Pass just the FDT argument to label_process_fdt()
> > > >   bootm: Allow building bootm.c without CONFIG_SYS_BOOTM_LEN
> > > >   boot: pxe: Use bootm_...() functions where possible
> > > >   pxe_utils: Simplify default fdt in label_run_boot()
> > > >   boot: pxe: Refactor label_run_boot() to avoid cmdline
> > > >   net: Keep the bootstage functions together
> > > >   net: Tidy up the comments to parse_args()
> > > >   net: Simplify parse_args()
> > > >   net: Return the load address from parse_args()
> > > >   net: Return the address and size from parse_addr_size()
> > > >   net: Return the size from parse_args()
> > > >   net: Refactor part of netboot_common() into a function
> > > >   net: Drop #ifdef in parse_args()
> > > >   net: Provide a function to run network operations
> > > >   boot: Avoid using the cmdline in bootmeth_pxe and pxe cmd
> > > >   pxe: Drop the cmdline parameter
> > > >   pxe: Record the bootflow in the PXE context
> > > >   pxe: Allow skipping the boot
> > > >   test: Update bootm test to restore silent_console
> > > >   bootmeth_extlinux: Move extlinux_info into plat
> > > >   bootmeth_extlinux: Move pxe_context into plat
> > > >   bootmeth: Refactor to put options in a common file
> > > >   bootmeth_pxe: Implement the fallback option
> > > >   bootmeth_pxe: Drop the driver-private data
> > > >   bootmeth_extlinux: Move boot code into common file
> > > >   bootstd: Update extlinux and pxe to allow boot interruption
> > > >   pxe: Collect the FDT in the bootflow
> > > >   pxe: Deal with a missing FDT in the bootflow
> > > >   pxe_utils: Refactor to separate reading from booting
> > > >   bootmeth_extlinux: Refactor extlinux to split boot
> > > >
> > > >  arch/x86/include/asm/zimage.h |  57 +---
> > > >  arch/x86/lib/zimage.c         | 102 ++++---
> > > >  boot/Makefile                 |   6 +-
> > > >  boot/bootm.c                  |   8 +-
> > > >  boot/bootmeth_cros.c          |   6 +-
> > > >  boot/bootmeth_extlinux.c      |  97 +------
> > > >  boot/bootmeth_pxe.c           |  48 ++--
> > > >  boot/ext_pxe_common.c         | 134 +++++++++
> > > >  boot/pxe_utils.c              | 507 +++++++++++++++++++++-------------
> > > >  cmd/bootflow.c                |   8 +-
> > > >  cmd/net.c                     |  92 +++---
> > > >  cmd/pxe.c                     |  30 +-
> > > >  cmd/sysboot.c                 |   4 +-
> > > >  cmd/x86/zboot.c               |  33 ++-
> > > >  include/bootm.h               |  63 ++++-
> > > >  include/bootmeth.h            |   8 +-
> > > >  include/extlinux.h            |  52 +++-
> > > >  include/net-common.h          |  30 ++
> > > >  include/pxe_utils.h           |  56 +++-
> > > >  net/net.c                     |  44 +++
> > > >  test/boot/bootflow.c          |  71 +++++
> > > >  test/boot/bootm.c             |   7 +
> > > >  22 files changed, 957 insertions(+), 506 deletions(-)
> > > >  create mode 100644 boot/ext_pxe_common.c
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > Unfortunately it seems there is a bug in here somewhere, in that it
> > > prepends the extlinux file's path to any files which are read, at
> > > least with pxe. So I am going to need to take another look...
> > >
> > > We don't have sandbox tests for this case, unfortunately. At some
> > > point we should try to add some.
> >
> > Does the pxelinux test not catch the problem? If not, that would be
> > where to start expanding perhaps.
>
> Right...it needs a little more work, but for now I'll have to fix the
> bug, as it's already 41 patches. I might be able to add a smaller
> test, will see.

It turned out to be a boolean which needs a different value between
extlinux and PXE. I didn't notice it at first. So I'll send this
series once it passes CI

Regards,
Simon
