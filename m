Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9ADC021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 12:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DD0E805C3;
	Wed, 26 Feb 2025 13:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LIE1DoJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E9D6807EE; Wed, 26 Feb 2025 13:32:20 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEE30801DE
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 13:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hackpascal@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fc3027c7aeso13206865a91.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 04:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740573136; x=1741177936; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFJijDwHwO+6Evs5Lps6eEx7eNCsSYxRDGzwWVGMZfc=;
 b=LIE1DoJ9Xrh3dgUXAgi3lRk/13HG1FSUvMK8gzKDC1+RUFgdaQp7Q83xOKoB6Surdr
 joBb4nt0xrsafsjzoj/CSHwrz3M15mDGfHuBNtkhKWrE0+l2yFxLFH0w7FLzqQnH8cR3
 7m7d9PO6TFeBCPEFJhn52s78Raxq4R8JMQwYsQPUXC8f9CwZdeIRPFNuvGBBvQW5tny1
 Wh1Dn0PMGhfzdXUOAtYHBBclLWVvAZktjh0MJQ03dhyL0otIWJRCr6rk1XD0dMeH7jsL
 +gsOAPL1G62LiG1dUPOTDMZkGmLd8SwX+RUQurJbxF+d/0ZpQ1TZXlfcm6+HqD0Sr3k0
 7HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740573136; x=1741177936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bFJijDwHwO+6Evs5Lps6eEx7eNCsSYxRDGzwWVGMZfc=;
 b=pLMyoQqb02+QWRIavbSrMJtafpLSyY9iZdc3Jr3C/tlPXooqHTmiZjfwqJVICvxxvg
 JNOPJGJcjpAs0HMOnZqXFEfkhM4aDxRyxGNl0x7hdMPku48FBQ/+pPGt5WQQClUjFu7z
 hphDlNxlW1PNeeE0x9LhaS1lx/Lr3kbyKMx6TyDiwPmSmYwQJT2g0ChHBL1QhnJnn4Hv
 1AhA6eSdPRwXgZA7+TSSgOfS5l/1SdqDmwEOID1HJsnlxlI6MpHjz99NRZSZLSbzKFfG
 BBHhVjMSrrcVEa+dHclb7FelXJ1/P4C86qxZnajEqMjZy3gq6JF6J78iNJaTaMgM+Xjd
 cNuQ==
X-Gm-Message-State: AOJu0Yx29RMzxC/B5rpaLC1TaXuctxRfc7EZJjeVfCAGZIHwPCJPiUIW
 orkgaQyO+nyY4Y9Sb/FWQUR4VgktMl2fSG6gD3z8KEgdoZ0C/9nAUr2Al/Zi1Ca521kzjFO+H56
 QXWzT+WcKWnyyE8eYB16zWL28xGzuQQ==
X-Gm-Gg: ASbGncs6vZXYnaBkZ+b1+voQ9i7EP2DN4NBnGx0L625hI5YWL/LD25vGTPeht5Ec4CZ
 N4HfosuBNSDQzx+3lFo8CU69wRw0rIccGtbQGyKtGRPYl41HqaNkUenWkIQKffme14DicbDNgbz
 fpjY5EY/44/Ns=
X-Google-Smtp-Source: AGHT+IF91Uftb7n4GdnpWGZiRepGUvY1YlkX/NiKqqnrwekFzGxJLqPp/aXFbsw+QyG75gATCbo0luTGL6KrqsBPu08=
X-Received: by 2002:a17:90b:388b:b0:2fa:13f7:960 with SMTP id
 98e67ed59e1d1-2fce86ae5f1mr33786684a91.13.1740573135699; Wed, 26 Feb 2025
 04:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20250125152632.26665-1-hackpascal@gmail.com>
In-Reply-To: <20250125152632.26665-1-hackpascal@gmail.com>
From: Weijie Gao <hackpascal@gmail.com>
Date: Wed, 26 Feb 2025 20:32:03 +0800
X-Gm-Features: AWEUYZldNzstvmnUZooPVMAXcIN_-9yaJKe_bsOJOZCR_Ok2bO-1DRM55GRNVxc
Message-ID: <CAN5eEr0U9a4ik=eF0xXZnfszPe7JytfQ35uOZuTLbeUTgLuZrw@mail.gmail.com>
Subject: Re: [PATCH] miiphy: define mii_devs with LIST_HEAD()
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
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

Hi,

Is there any update for this patch?

Thanks

Weijie Gao <hackpascal@gmail.com> =E4=BA=8E2025=E5=B9=B41=E6=9C=8825=E6=97=
=A5=E5=91=A8=E5=85=AD 23:27=E5=86=99=E9=81=93=EF=BC=9A
>
> When enabling net console and console multiplexing, a boot crash was
> observed using mtk_eth driver with stdin/stdout set to "serial,nc"
> in persistent environment:
>
> > CPU:   MediaTek MT7981
> > Model: OpenWrt One
> > DRAM:  1 GiB
> > Core:  35 devices, 15 uclasses, devicetree: separate
> > spi-nand: spi_nand spi_nand@0: Winbond SPI NAND was found.
> > spi-nand: spi_nand spi_nand@0: 128 MiB, block size: 128 KiB, page size:=
 2048, OOB size: 64
> > Loading Environment from UBI... SF: Detected w25q128 with page size 256=
 Bytes, erase size 4 KiB, total 16 MiB
> > mtd: partition "ubi" extends beyond the end of device "spi-nand0" -- si=
ze truncated to 0x7f00000
> > Read 126976 bytes from volume ubootenv to 000000007f7bf0c0
> > Read 126976 bytes from volume ubootenv2 to 000000007f7de100
> > OK
> > "Synchronous Abort" handler, esr 0x96000004, far 0xeafffffeea000018
> > elr: 0000000041e63cd4 lr : 0000000041e1b844 (reloc)
> > elr: 000000007ff9ecd4 lr : 000000007ff56844
> > x0 : eafffffeea000018 x1 : 000000007fb552e0
> > x2 : 00000000000000fe x3 : 0000000000000000
>
> The cause is that "serial,nc" forced the console subsystem to
> initialize the ethernet driver before ethernet subsystem
> initialization (console_init_r() is called before initr_net()).
>
> During the mtk_eth driver initialization, mdio_register() will be
> called, and miiphy_get_dev_by_name() will then be called.
>
> The miiphy_get_dev_by_name() will check the list "mii_devs" to see
> if the passed device name exists. However the mii_devs is defined
> without initialization:
> > static struct list_head mii_devs;
> and the actual initialization is done in the following chain:
> initr_net -> eth_initialize -> eth_common_init -> miiphy_init
> Since initr_net() hasn't be called, iterating over the mii_devs
> will access to physical address 0 (mii_devs.next =3D=3D NULL) and will
> cause the crash.
>
> The fix is to define mii_devs using:
> > static LIST_HEAD(mii_devs);
>
> As the "current_mii" is defined as a static variable, it will
> always be NULL in board_r stage and initializing it will NULL is
> unnecessary. So the entire miiphy_init() can be remove.
>
> Signed-off-by: Weijie Gao <hackpascal@gmail.com>
> ---
>  common/miiphyutil.c | 12 +-----------
>  include/miiphy.h    |  2 --
>  net/eth_common.c    |  5 -----
>  3 files changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/common/miiphyutil.c b/common/miiphyutil.c
> index 9b8744e5d8..6169ea884a 100644
> --- a/common/miiphyutil.c
> +++ b/common/miiphyutil.c
> @@ -30,7 +30,7 @@
>  #define debug(fmt, args...)
>  #endif /* MII_DEBUG */
>
> -static struct list_head mii_devs;
> +static LIST_HEAD(mii_devs);
>  static struct mii_dev *current_mii;
>
>  /*
> @@ -55,16 +55,6 @@ struct mii_dev *miiphy_get_dev_by_name(const char *dev=
name)
>         return NULL;
>  }
>
> -/***********************************************************************=
******
> - *
> - * Initialize global data. Need to be called before any other miiphy rou=
tine.
> - */
> -void miiphy_init(void)
> -{
> -       INIT_LIST_HEAD(&mii_devs);
> -       current_mii =3D NULL;
> -}
> -
>  struct mii_dev *mdio_alloc(void)
>  {
>         struct mii_dev *bus;
> diff --git a/include/miiphy.h b/include/miiphy.h
> index 5abffd8fb6..8e4b58c734 100644
> --- a/include/miiphy.h
> +++ b/include/miiphy.h
> @@ -33,8 +33,6 @@ int miiphy_is_1000base_x(const char *devname, unsigned =
char addr);
>  int miiphy_link(const char *devname, unsigned char addr);
>  #endif
>
> -void miiphy_init(void);
> -
>  int miiphy_set_current_dev(const char *devname);
>  const char *miiphy_get_current_dev(void);
>  struct mii_dev *mdio_get_current_dev(void);
> diff --git a/net/eth_common.c b/net/eth_common.c
> index 89b5bb3718..ba57d836b0 100644
> --- a/net/eth_common.c
> +++ b/net/eth_common.c
> @@ -31,11 +31,6 @@ int eth_env_set_enetaddr_by_index(const char *base_nam=
e, int index,
>  void eth_common_init(void)
>  {
>         bootstage_mark(BOOTSTAGE_ID_NET_ETH_START);
> -#if CONFIG_IS_ENABLED(ETH)
> -#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) || defined(CONFIG_PHY=
LIB)
> -       miiphy_init();
> -#endif
> -#endif
>  }
>
>  int eth_mac_skip(int index)
> --
> 2.34.1
>
