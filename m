Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19804C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 22:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 507D4826B2;
	Fri,  4 Apr 2025 00:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K8cN9Rxm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3034826B2; Fri,  4 Apr 2025 00:30:56 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA2B82385
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 00:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac298c8fa50so237797366b.1
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 15:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743719454; x=1744324254; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GF9fVMGMML5e1HwdwKFqDgmnrGuxQ/Tj+YtBcS5Yx7k=;
 b=K8cN9RxmQYjAz347cawigbXbtwY+1w9MUjLZvouNIIpjv4VkkCVYXFxG1foAB/k4FU
 C6LuTiuTcNOYexMaYiXCXk1SnIAR5TtqojBJdnRFXeYoShpJjGaLsRV84xRNdO4lJtxF
 +5nkZlKopAJvbE0/ppHLfoSXma1UddrVpfc8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743719454; x=1744324254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GF9fVMGMML5e1HwdwKFqDgmnrGuxQ/Tj+YtBcS5Yx7k=;
 b=m29NqF2F6ZyEFZxhVr28zMGTjOEwI4cm9kI73uL3avJE8iKznIOAV2ORWP5JuLz+A2
 K1odZdN8UZFv2+vTzM8XN2yOK8IRfYjBAatcUr9jKex94Kuralyy0fl/4IYlDkBAplOv
 D3ammQi0oiF/WWCO5YTwXQkXSqhHEQAx6znKtZHYh55JuBMNoup3IGE4lWKKagDvFpMY
 oIGB5Mbd1zOny9cfdPuz0FTsIOlzLhqJfbCc0ez36pIxRuRFvtU0T6Ao/o62lcs3BD4p
 ypb3f+M6aIZdlea3VKO2V5cdbqoowoBuLIU5zH1wo/DGz5LZZPMrfHcAllmPKXlK7qXP
 anUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmqG5QhhpRaAPcMOL4yWQ9D2A6PwD3Y06RoMWj7ZRTo64EY6NRxg4cnBDZ+sV4K7pktQ2IeHw=@lists.denx.de
X-Gm-Message-State: AOJu0YzClvVr0MSs7x0bSUb8uv6SieQtpfJC/+L8wvN32sdqMiR0QqsW
 Cs4An30k8j4SIJM9fNZI6pILc68dc+KZl6mdeJlYaoM2tAZXNIbhPXkW7RQMym+b9AWjq67W063
 gChHVFLUiP8XD3amo3nAydo9VWkDfQwxsSkNKQe/YBrh6IG2Orat/
X-Gm-Gg: ASbGncvPbfyvtwiVy6NWDS/NlQJPu00rdOq4DQWhPqrmSxzOTQ5iCkCI4m7Ep6crh38
 MczLXYuDu08uIBe2oz/Dl3rs5s+hIrVtBTUcfR7PYWojudnJ71uNPooXWRd+xU24XXRp+csXbFl
 aJIwvuPmPD+88bCWw6fziz9qd7wWR9
X-Google-Smtp-Source: AGHT+IEf/evkJX4eGjSLV0uaOevnmRgd/e6Ynov38BRly+ejC6MBpFR8vEl450TJ6KDJzuUdR5LNSvnKbXA18Yjes4k=
X-Received: by 2002:a17:907:1ca7:b0:ac4:85b:f973 with SMTP id
 a640c23a62f3a-ac7d1819306mr79223766b.34.1743719453660; Thu, 03 Apr 2025
 15:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250306002533.2380866-1-sjg@chromium.org>
 <174234008117.1788726.14383009154862416750.b4-ty@konsulko.com>
 <10a57d25-d484-4903-8f25-e373c451bc21@kwiboo.se>
In-Reply-To: <10a57d25-d484-4903-8f25-e373c451bc21@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 4 Apr 2025 11:30:41 +1300
X-Gm-Features: AQ5f1JpkIxNl9HJa2EkKlWLfrvbziIx9U1LiWwLUfqbuCbbkT2_MWnfvbcBMeFc
Message-ID: <CAFLszThrij_kGPdFcdJLoxJLpoZru=_M_vG4eVKwdPAqDfQJyg@mail.gmail.com>
Subject: Re: [PATCH v5 00/29] pxe: Precursor series for supporting read_all()
 in extlinux / PXE
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, 
 Bin Meng <bmeng.cn@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Julien Masson <jmasson@baylibre.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Korsgaard <peter@korsgaard.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Ramon Fried <rfried.dev@gmail.com>, 
 Rick Chen <rick@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
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

Hi Jonas,

On Fri, 4 Apr 2025 at 09:57, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Tom and Simon,
>
> On 2025-03-19 00:21, Tom Rini wrote:
> > On Wed, 05 Mar 2025 17:24:54 -0700, Simon Glass wrote:
> >
> >> This series includes some patches related to allowing read_all() to be
> >> used with the extlinux / PXE bootmeths.
> >>
> >> These patches were split out from the stb4 series, since it will need to
> >> have additional patches for LWIP, to avoid breaking PXE booting when
> >> LWIP is used.
> >>
> >> [...]
> >
> > Applied to u-boot/next, thanks!
>
> This series broke booting a compressed arm64 defconfig Linux kernel
> (without module loading) due to changes in decompression buffer length.
>
> My arm64 defconfig kernel (Image.gz) is ~24 MiB compressed and ~85 MiB
> uncompressed.
>
> Before this series the decompression buffer was 10x the kernel_comp_size
> and now it is instead limited by the SYS_BOOTM_LEN Kconfig symbol.
>
> A broken boot using current next branch:
>
>   Retrieving file: /Image.gz
>   Retrieving file: /initramfs.cpio.gz
>   append: earlycon
>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x06000000:394d3c' conf_fdt '3df16350' images 000000003ffe53a0
>      kernel data at 0x02080000, len = 0x00000000 (0)
>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
>   find_other type 2 os 5
>   ## Flattened Device Tree blob at 3df16350
>      Booting using the fdt blob at 0x3df16350
>   Working FDT set to 3df16350
>   load_os load 8000000 image_start 2080000 image_len 2000000
>      Uncompressing Kernel Image to 8000000
>   Error: inflate() returned -5
>   Image too large: increase CONFIG_SYS_BOOTM_LEN
>   Must RESET board to recover
>   Resetting the board...
>
> Changing SYS_BOOTM_LEN from default 64 MiB to 128 MiB fixed the boot:
>
>   Retrieving file: /Image.gz
>   Retrieving file: /initramfs.cpio.gz
>   append: earlycon
>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x06000000:394d3c' conf_fdt '3df16430' images 000000003ffe5480
>      kernel data at 0x02080000, len = 0x00000000 (0)
>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
>   find_other type 2 os 5
>   ## Flattened Device Tree blob at 3df16430
>      Booting using the fdt blob at 0x3df16430
>   Working FDT set to 3df16430
>   load_os load 8000000 image_start 2080000 image_len 2000000
>      Uncompressing Kernel Image to 8000000
>      kernel loaded at 0x08000000, end = 0x0d3b5a00
>      Loading Ramdisk to 3cb51000, end 3cee5d3c ... OK
>      Loading Device Tree to 000000003cb3f000, end 000000003cb509df ... OK
>   Working FDT set to 3cb3f000
>
>   Starting kernel ...
>
> Do we need to increase the default SYS_BOOTM_LEN for ARM64 now?

Are you using the 'booti' command? Can you post a bit more console
output or a script here as it isn't clear what boot command you are
using? For now I'm going to assume booti

do_booti() calls bootm_run_states() without the BOOTM_STATE_LOADOS
state in the mask, so I wonder why (as it seems) bootm_run_states() is
calling bootm_load_os()*

So from what I can tell it is loading the OS once in booti_start() and
again in bootm_load_os(). If so, I don't know why.

In any case, honouring CONFIG_SYS_BOOTM_LEN for loaded files is the
correct behaviour, so yes, I think we should increase that limit. For
now, we could add the check to the booti command, since it might be a
while before I get back to refactoring/removing that (now-unneeded)
code.

Regards,
Simon

* It should be possible to remove booti_start() now that bootm
supports booti decompression properly, but I left that for another
day.

>
> Regards,
> Jonas
>
> >
> > [01/29] x86: Make do_zboot_states() static
> >         commit: 299d24eddfeb18a7576187b3010d5462317335e9
> > [02/29] x86: Rename zboot_run() to zboot_run_args()
> >         commit: 95641f4bf98d3c90bfc4ae94515c98c440ffb2e1
> > [03/29] x86: Drop duplicate definition of zimage_dump()
> >         commit: 2de073527bb92b47d49366249cd3fdea5016bcaf
> > [04/29] x86: Move x86 zboot state into struct bootm_info
> >         commit: 75e85df7963f57e4bb80b3d805ba2295b1843911
> > [05/29] x86: Rename state to bmi
> >         commit: 00cfb598e740d8bad79097e7e069ad71d86bbd5a
> > [06/29] x86: Move the bootm state for zimage into cmd/
> >         commit: 4e36b1739b03e81ff395959b58fe33e67c4d2233
> > [07/29] bootstd: Correct display of kernel version
> >         commit: 1592ff27d502efdc79992f57c07ff0cf81bc9305
> > [08/29] x86: Drop the unnecessary base_ptr argument to zboot_dump()
> >         commit: c73da92304280b229e3d8dfd565fae5a24fe3ce8
> > [09/29] boot: Use strlcpy() in label_boot()
> >         commit: 0fd3ed1cd73d6b262c204c27cbe6dc1ad1c09e91
> > [10/29] boot: Split pxe label_boot() into two parts
> >         commit: ff9fef41fe4d329a5c76746cc45f9fbf8fdb9b12
> > [11/29] boot: Split pxe label_run_boot() into two parts
> >         commit: f6aa262f55b78e3a21dd020e47601320c2edec4e
> > [12/29] boot: Pass just the FDT argument to label_process_fdt()
> >         commit: 600bc21da54a300f2825a5e3088719b1ffd5ee53
> > [13/29] bootm: Allow building bootm.c without CONFIG_SYS_BOOTM_LEN
> >         commit: 7f10a7fe126dce5644d933af693eda40497d7755
> > [14/29] boot: Convert IMAGE_FORMAT into an enum
> >         commit: 3c7b13b075488ebcff2923b0a7b46cc11f39285e
> > [15/29] boot: arm: riscv: sandbox: Add a format for the booti file
> >         commit: 098407e67390ed0c369029bab0777a51e5a7bad2
> > [16/29] boot: Support booti format in bootm
> >         commit: d6bb0ea535e4384ed1975ee9c755488f5036a79e
> > [17/29] boot: Support compressed booti images in bootm
> >         commit: ecd50bb4643c9052e5f8b6171ab6c3905ed0ca70
> > [18/29] boot: pxe: Use bootm_...() functions where possible
> >         commit: b13408021d361fbae1c254307f139ad1e6def3d2
> > [19/29] pxe_utils: Simplify default fdt in label_run_boot()
> >         commit: feb8d7fd749413e889ba2c396654f473ba32034d
> > [20/29] boot: pxe: Refactor label_run_boot() to avoid cmdline
> >         commit: e2e87b840162ddf4ec8df3f235be98a74a964509
> > [21/29] net: Keep the bootstage functions together
> >         commit: 2c04afbc957d18e61813315a0694db903754a280
> > [22/29] net: Tidy up the comments to parse_args()
> >         commit: 3ccbc10cd9e3b28d67fe5008943a648b870db1e6
> > [23/29] net: Simplify parse_args()
> >         commit: f1ece5d86e5577ae9bb3325d65ed7003f3cbaf9e
> > [24/29] net: Return the load address from parse_args()
> >         commit: 4b6070e056fc2c11b7621c32151f95f7a045ac01
> > [25/29] net: Return the address and size from parse_addr_size()
> >         commit: f60421204816bd0aa40e9e43c18d4bc5861d3521
> > [26/29] net: Return the size from parse_args()
> >         commit: 25d51d3c798f6e256daa628bb2a9fcc36fde0382
> > [27/29] net: Refactor part of netboot_common() into a function
> >         commit: bfffdfaaf6f492865100197a5b141482799afc09
> > [28/29] net: Drop #ifdef in parse_args()
> >         commit: f278f0cb4996398720328ce33e057678f6ea4109
> > [29/29] net: Provide a function to run network operations
> >         commit: 0f094b8b146679c3980cd2febde4e902bbc4405d
>
