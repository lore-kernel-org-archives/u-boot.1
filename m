Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BAFC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 22:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E00888189;
	Sat, 29 Jun 2024 00:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="izLVj4w4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4A3087FEE; Sat, 29 Jun 2024 00:04:21 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9023E88189
 for <u-boot@lists.denx.de>; Sat, 29 Jun 2024 00:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ec5779b423so10333331fa.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 15:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719612259; x=1720217059; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQ33bMhMwtiFr+RSTgcVcisI5CDFJx7qSqvHAIH7PTg=;
 b=izLVj4w4wppkSRHwsu/SEG9wyHfD96Ihj4qzUvamOFkzN5xuxAhy5N1rW6Unc6gVjg
 2EpnC/PdKKf+6RTYuxyVLNqP0dibGlF3rCOszbrH/rpvadOBkTTmRkR0XBExkfqN+IWs
 IvbaKDPJ+dXjv7bL0yXwyMF578Fww7LX+mxb/jrsCOexGngdMzxDx9XW8OqNmPU+83WX
 4hhl9gPTbV1/I+6ht+0lbg2ITJjDUQ7ZVW3TwBD394KL8wH6zhbfQAXBEb7TXkXF5wqI
 kAMCJuHTR+8TMQOlUGthbd1N4LlMZv9AkyHGB7dEMMkb1R3cQGkSRgIhttFo/8qdPwlm
 GEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719612259; x=1720217059;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TQ33bMhMwtiFr+RSTgcVcisI5CDFJx7qSqvHAIH7PTg=;
 b=G1S3HlrfIENNVqu4wv+Auvs/SoZajkr+jWg4UDXImqYNXOOjf+bLFoGRRzTAHBuVOY
 3jpDta/xgxZKJB0DentHsMNTV/bI4A14HvZ4n5ILOOaDhRWtCkHDIBsKl1c1DdtHqpb1
 2J2jsDH6jZhIbiqiXJK17GTgrAoA9h01COvhLco85oE9rVN8tfF21hZWuCjEgUwgbFXC
 qb4S1o5BlsDDDv/wdi4thRZ2H+6Nr46yKRh6YTRdm9TJr0uCCY5l74oAgf8o0O875F0C
 zShRklRmp2AHoY5C5Pu5/DRmwResV0ka8iqQCFwnlltr4brXyBHAPJsOZQ7CE9LaAyBN
 RVUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbWgsl1vcYOaDUzS5fMLbsndIcvUi6bNpQcJZbRk+jzw5Sf9AI/Bn3FIY3enYRPgjwNbQyMK03KT6fg+uooetCrSLAvw==
X-Gm-Message-State: AOJu0YzWZ8me8+KDs84rS3OKC9TAkpL9gvnAzTECfHTp+njNbFkTIdg2
 VJiwHcNc3VJ7O7uwix1sQxI5JD8N78Hg2kv4/l6yaG3ADZHXpKrizCbGtYVK70IiQ20jbATC9YT
 vOORBDijWgY3kFh08WLQtrGdnbtw=
X-Google-Smtp-Source: AGHT+IFjV2UxMDXzZ/ft+D76L9gffXf8cgelXHyWO1iHy1WJuLWcKT0WfKuT0cZ6m46E0GS8eqrzU267+2c6d1RjLsY=
X-Received: by 2002:a2e:9998:0:b0:2eb:eb7c:ec1b with SMTP id
 38308e7fff4ca-2ec59329f25mr131100071fa.25.1719612258422; Fri, 28 Jun 2024
 15:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240615220654.10648-1-mibodhi@gmail.com>
 <Znvt9_7xbdccZkFd@orbyte.nwl.cc>
In-Reply-To: <Znvt9_7xbdccZkFd@orbyte.nwl.cc>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 28 Jun 2024 15:04:06 -0700
Message-ID: <CAJaLiFyTWfmsAVT4NO_Nvq1eHC73dNhxmF7KtYCR4VwOUg8Z3w@mail.gmail.com>
Subject: Re: [PATCH v2] arm: mvebu: Enable bootstd and other modernization for
 Synology DS414 (Armada XP) board
To: Phil Sutter <phil@nwl.cc>, Tony Dinh <mibodhi@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
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

Hi Phil,

On Wed, Jun 26, 2024 at 3:31=E2=80=AFAM Phil Sutter <phil@nwl.cc> wrote:
>
> Hi Tony,
>
> On Sat, Jun 15, 2024 at 03:06:54PM -0700, Tony Dinh wrote:
> [...]
> > diff --git a/board/Synology/ds414/ds414.c b/board/Synology/ds414/ds414.=
c
> > index abe6f9eb5e..f0b55fa095 100644
> > --- a/board/Synology/ds414/ds414.c
> > +++ b/board/Synology/ds414/ds414.c
> > @@ -181,18 +181,9 @@ int board_init(void)
> >       return 0;
> >  }
> >
> > -int misc_init_r(void)
> > +int board_late_init(void)
> >  {
> > -     if (!env_get("ethaddr")) {
> > -             puts("Incomplete environment, populating from SPI flash\n=
");
> > -             do_syno_populate(0, NULL);
> > -     }
> > -     return 0;
> > -}
>
> Could you please leave misc_init_r() in place (along with MISC_INIT_R in
> defconfig)? A closer look at doc/README.enetaddr suggests that
> implementing this board-specific function which acts if the environment
> does not have ethaddr defined already is exactly the right thing to do.
> Also, it doesn't conflict with NET_RANDOM_ETHADDR: If do_syno_populate()
> succeeds, no random MAC addresses are generated. If I manually remove
> the call, random MACs come into play. So having this option enabled
> serves as a fallback for boxes which lack the data in flash.

Sure I will do that. I was mistaken in assuming that network random
addresses were already generated before misc_init_r(). Thanks!

>
> > -int checkboard(void)
> > -{
> > -     puts("Board: DS414\n");
> > -
> > +     /* Do late init to ensure successful enumeration of XHCI devices =
*/
> > +     pci_init();
> >       return 0;
> >  }
>
> FWIW, booting from rear USB port worked fine for me!

Cool! That was the main thing I was interested in for sending in this
patch. One thing led to another... :)

>
> > diff --git a/configs/ds414_defconfig b/configs/ds414_defconfig
> > index ecf9501ba5..501ed51129 100644
> > --- a/configs/ds414_defconfig
> > +++ b/configs/ds414_defconfig
> [...]
> > @@ -25,44 +26,40 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
> >  CONFIG_SPL=3Dy
> >  CONFIG_DEBUG_UART_BASE=3D0xf1012000
> >  CONFIG_DEBUG_UART_CLOCK=3D250000000
> > +CONFIG_IDENT_STRING=3D"\nSynology DS214+/DS414 2/4-Bay Diskstation"
> >  CONFIG_SYS_LOAD_ADDR=3D0x800000
> >  CONFIG_PCI=3Dy
> >  CONFIG_DEBUG_UART=3Dy
> > +CONFIG_BOOTSTD_FULL=3Dy
> >  CONFIG_BOOTDELAY=3D3
> >  CONFIG_USE_BOOTARGS=3Dy
> > -CONFIG_BOOTARGS=3D"console=3DttyS0,115200 ip=3Doff initrd=3D0x8000040,=
8M root=3D/dev/md0 rw syno_hw_version=3DDS414r1 ihd_num=3D4 netif_num=3D2 f=
lash_size=3D8 SataLedSpecial=3D1 HddHotplug=3D1"
> > -CONFIG_USE_BOOTCOMMAND=3Dy
> > -CONFIG_BOOTCOMMAND=3D"sf probe; sf read ${loadaddr} 0xd0000 0x2d0000; =
sf read ${ramdisk_addr_r} 0x3a0000 0x430000; bootm ${loadaddr} ${ramdisk_ad=
dr_r}"
>
> So these should not be necessary anymore with BOOTSTD. I wonder if it is
> possible to provide a static bootmeth (or bootflow?) with low priority
> which boots the legacy OS from flash. It could hold all the details
> instead of the *_legacy env vars introduced below.

I recall from bootstd documentation that it is possible to have a
bootflow on flash. But it seems a bit too much for this patch. I think
we'll have to repartition or find some space on the flash to store
that bootflow script.

>
> A pending issue for me is inability to 'saveenv' - the flash seems
> read-only in that spot. Does it work for you?

Yes it does work for me. With the latest u-boot SPI flash driver, as I
recall, the entire flash is automatically unprotected at
initialization. But we need to be careful using saveenv running stock
FW, because it could overwrite the rootfs on flash. It is common for
Synology NAS that the envs location is at the same place as the stock
rootfs. Since I don't care about stock FW, I saved the envs and used
the location for u-boot envs in Linux /etc/fw_env.config. I'm not sure
if my DS214+ box can boot stock FW anymore :)

>
> >  # CONFIG_DISPLAY_BOARDINFO is not set
> >  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> > -CONFIG_MISC_INIT_R=3Dy
> > +CONFIG_BOARD_LATE_INIT=3Dy
> >  CONFIG_SPL_MAX_SIZE=3D0x1bfd0
> >  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> >  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> >  CONFIG_SPL_I2C=3Dy
> > +CONFIG_SYS_PROMPT=3D"DS414> "
>
> Can we detect whether it is 414 or 214, BTW? bootargs_legacy contains
> 414-specific info as well.

It's a bit hard to do without creating another defconfig. AFAICT, the
only difference between DS414 and DS214+ is the number of SATA bays.
But currently u-boot SATA does not work for this box. U-Boot sata_mv
driver is a subset of Linux sata_mv, and we don't have support for the
right PCIe SATA chip in u-boot sata_mv.

>
> [...]
> > diff --git a/include/configs/ds414.h b/include/configs/ds414.h
> > index 9446acba79..89e55bf0d4 100644
> > --- a/include/configs/ds414.h
> > +++ b/include/configs/ds414.h
> [...]
> > @@ -16,14 +17,9 @@
> >   * U-Boot into it.
> >   */
> >
> > -/* I2C */
> >  #define CFG_I2C_MVTWSI_BASE0         MVEBU_TWSI_BASE
> >
> > -/*
> > - * mv-common.h should be defined after CMD configs since it used them
> > - * to enable certain macros
> > - */
> > -#include "mv-common.h"
> > +#define PHY_ANEG_TIMEOUT     16000   /* PHY needs a longer aneg time *=
/
>
> AIUI, this is a limitation of my local NIC, not the DS414 one. It just
> took too long for link detection and autoneg when directly connected. A
> switch should have helped. Or do you have more details?

Ah! The typical PHY_ANEG_TIMEOUT on other Armada 38x boards is 8000. I
thought the 16000 was for Armada XP when I saw that code. I think it's
OK to use a larger timeout. It really does not hurt?

All the best,
Tony

> Cheers, Phil
