Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F0DE77160
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 00:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F33AF89669;
	Wed,  4 Dec 2024 01:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZDx+67wZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE8548966B; Wed,  4 Dec 2024 01:03:43 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B753A88EDA
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 01:03:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9f1c590ecdso1042827066b.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 16:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733270618; x=1733875418; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NETQOyHYklKUEzZYfnQv/CkydVJ15S2rPr6vKU8fw/8=;
 b=ZDx+67wZgC3+v8bjQt3zWAzISeYtQmvM39GjXWr29mgBCK81tuYdQdZQs0yzA3j5aV
 LLmiB+8EzSWXHUSbL73eqyiKY2JMrH3LM0u2VUCKOP6CrzkCyRjqd2PJnggaKKU2rdue
 L3vWjeD80yeaxgdq4wpCSKr+3M+d0NILqO/N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733270618; x=1733875418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NETQOyHYklKUEzZYfnQv/CkydVJ15S2rPr6vKU8fw/8=;
 b=J+PWoVhKAUc+u+lk90dUtomF9VJ3fmTE6nWxU3/yOIuZwcCJ9tLzReZhpGHK38+JeO
 LCZNn+oxQ7LZDv/aD9jNJop5Z89jI9TqWOcxK32p87E2UHsOo8aHUiK5lh2NuiG+nBIE
 pKWQADLUuIP3+Amx69h1pJTPw6F5rlgIKsLYwH92LVOsK7WKtbe80aAHERO/69Xqk3U2
 XTHQi02G4b7AzoIaUBE9L1eGTG0lxraHLTORGWsHiJT0KeEc59ZLDOmnhMpdnnuDsP4H
 pXC9ffHRKvNo14L85qc84z5m0WWzHoZAhNZ4HA/5srDs3Xcz1K3JfMIYzRL5L23rUu8S
 ROMQ==
X-Gm-Message-State: AOJu0YySEx2oV5TrvkrB8ECgqbPiC6NCIYLDY/B3azXtyd663tjX5mMS
 xq6aP2l4YW4Mix43wyy21Wr12vH3JZXyRrFcJl1y0+2wM1I6hsIViRQGWoP9A5F4PvPtmkdEvDc
 XVYQFLYok4e9P2EnvdjOHCOfYR2VH1THCS5oATyxFU0O1nUI=
X-Gm-Gg: ASbGncuCsC96gdClOifH38fAJqIXQe5jwlQJoqnMrOV4xbhU2DBFG25/rrXZ+nNzVFj
 BQET3TYIukURUEnc+8GXACueZob1XRuNz
X-Google-Smtp-Source: AGHT+IGBIsRGDj+YqwdQIfJzEyaDo/4gAm1EIvTwGvVoLgGffszPggTLCr0f1dc+IYuqme3eryKrX+8iemLRPbBmhv0=
X-Received: by 2002:a17:906:30cb:b0:aa5:297a:ac65 with SMTP id
 a640c23a62f3a-aa5f7d4ec91mr428443766b.19.1733270617746; Tue, 03 Dec 2024
 16:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20241203234559.2938192-1-sjg@chromium.org>
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 17:03:26 -0700
Message-ID: <CAFLszThuRngaW_kOTnEakDr6GSRc5TWpy7WT9yvQJmuMP2eUVw@mail.gmail.com>
Subject: Re: [PATCH v2 00/41] pxe: Support read_all() for extlinux and PXE
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
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

Hi,

On Tue, 3 Dec 2024 at 16:46, Simon Glass <sjg@chromium.org> wrote:
>
> This series implements read_all() so that it is possible to read all the
> files relating to a bootflow, make adjustments and then boot.
>
> Unfortunately quite a few things stand in the way, so this series
> finishes off several pending items: zboot without CONFIG_CMDLINE,
> required support in pxe_utils and the differing code in the extlinux and
> PXE bootmeths. There is very little new code, but quite a lot of
> refactoring.
>
> The bootm, booti and bootz commands have all been refactored previously,
> so that they can operate without needing CONFIG_CMDLINE to be enabled.
> At the, time, zboot was left alone, since it is x86-specific and a bit
> more trouble.
>
> This series adds a programatic API for zboot and uses the forthcoming
> bootstd 'image list' to collect information from an extlinux file. It is
> therefore possible to parse the file, load the resulting images and then
> examine/adjust the resulting bootflow, before booting.
>
> The addition of options to extlinux resulted in the PXE and extlinux
> bootmeth having slightly different features. This is tidied up in this
> series, with common functions for both. This allows the same features
> (loading images as a separate step) to be provided for PXE.
>
> Changes in v2:
> - Split out strlcpy() change into new patch
> - Move strlcpy() change into an earlier patch
> - Fix 'initaddr' typo'
> - Rebase on earlier change
> - Add new patch to simplify the code reading fdtcontroladdr and fdt_addr
>
> Simon Glass (41):
>   x86: Make do_zboot_states() static
>   x86: Rename zboot_run() to zboot_run_args()
>   x86: Drop duplicate definition of zimage_dump()
>   x86: Move x86 zboot state into struct bootm_info
>   x86: Rename state to bmi
>   x86: Move the bootm state for zimage into cmd/
>   bootstd: Correct display of kernel version
>   x86: Drop the unnecessary base_ptr argument to zboot_dump()
>   boot: Use strlcpy() in label_boot()
>   boot: Split pxe label_boot() into two parts
>   boot: Split pxe label_run_boot() into two parts
>   boot: Pass just the FDT argument to label_process_fdt()
>   bootm: Allow building bootm.c without CONFIG_SYS_BOOTM_LEN
>   boot: pxe: Use bootm_...() functions where possible
>   pxe_utils: Simplify default fdt in label_run_boot()
>   boot: pxe: Refactor label_run_boot() to avoid cmdline
>   net: Keep the bootstage functions together
>   net: Tidy up the comments to parse_args()
>   net: Simplify parse_args()
>   net: Return the load address from parse_args()
>   net: Return the address and size from parse_addr_size()
>   net: Return the size from parse_args()
>   net: Refactor part of netboot_common() into a function
>   net: Drop #ifdef in parse_args()
>   net: Provide a function to run network operations
>   boot: Avoid using the cmdline in bootmeth_pxe and pxe cmd
>   pxe: Drop the cmdline parameter
>   pxe: Record the bootflow in the PXE context
>   pxe: Allow skipping the boot
>   test: Update bootm test to restore silent_console
>   bootmeth_extlinux: Move extlinux_info into plat
>   bootmeth_extlinux: Move pxe_context into plat
>   bootmeth: Refactor to put options in a common file
>   bootmeth_pxe: Implement the fallback option
>   bootmeth_pxe: Drop the driver-private data
>   bootmeth_extlinux: Move boot code into common file
>   bootstd: Update extlinux and pxe to allow boot interruption
>   pxe: Collect the FDT in the bootflow
>   pxe: Deal with a missing FDT in the bootflow
>   pxe_utils: Refactor to separate reading from booting
>   bootmeth_extlinux: Refactor extlinux to split boot
>
>  arch/x86/include/asm/zimage.h |  57 +---
>  arch/x86/lib/zimage.c         | 102 ++++---
>  boot/Makefile                 |   6 +-
>  boot/bootm.c                  |   8 +-
>  boot/bootmeth_cros.c          |   6 +-
>  boot/bootmeth_extlinux.c      |  97 +------
>  boot/bootmeth_pxe.c           |  48 ++--
>  boot/ext_pxe_common.c         | 134 +++++++++
>  boot/pxe_utils.c              | 507 +++++++++++++++++++++-------------
>  cmd/bootflow.c                |   8 +-
>  cmd/net.c                     |  92 +++---
>  cmd/pxe.c                     |  30 +-
>  cmd/sysboot.c                 |   4 +-
>  cmd/x86/zboot.c               |  33 ++-
>  include/bootm.h               |  63 ++++-
>  include/bootmeth.h            |   8 +-
>  include/extlinux.h            |  52 +++-
>  include/net-common.h          |  30 ++
>  include/pxe_utils.h           |  56 +++-
>  net/net.c                     |  44 +++
>  test/boot/bootflow.c          |  71 +++++
>  test/boot/bootm.c             |   7 +
>  22 files changed, 957 insertions(+), 506 deletions(-)
>  create mode 100644 boot/ext_pxe_common.c
>
> --
> 2.34.1
>

Unfortunately it seems there is a bug in here somewhere, in that it
prepends the extlinux file's path to any files which are read, at
least with pxe. So I am going to need to take another look...

We don't have sandbox tests for this case, unfortunately. At some
point we should try to add some.

Regards,
Simon
