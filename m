Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2052C001DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 00:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E570B871DA;
	Fri, 20 Oct 2023 02:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AuHdCEHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5351B871D4; Fri, 20 Oct 2023 02:30:46 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FA11871DA
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 02:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-27d5fd02e3dso87641a91.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697761838; x=1698366638; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RsLsbNfgAuzYoyHqTJWMkXqThpFiUAPlZos+nNfq5iw=;
 b=AuHdCEHQ8q71xTO9Lv25D8bnTl6Wu76esbkTmuEoSHfWrWRz4c2IZshA6jpzjOGfRa
 kY9qfPG0SgdywLFrzrcuMlUotVcTShHVNC2Pccu39wdKW7X/oI9Hu4smTzSeFxspoifk
 GBJHmt05r6UCA1rPehra/a6VizXCV7LD1LtuTsusaFlYOnBFtYNO8EWV1FH8LcVovQmJ
 2BOXF5aCjTv7ZgSXpYYrwUW88Bi7LOIjTOCT2oR3ByfnLsoqWMMZGLSA9VfB6kiVS0v/
 Rn04oGDyGTS6EkL+5Ks3Is3UHdhY5Bvr5h8vJwpZa8EK7700JUaUb/cKAEwfiCSOD1Qg
 qKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697761838; x=1698366638;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RsLsbNfgAuzYoyHqTJWMkXqThpFiUAPlZos+nNfq5iw=;
 b=DtXS+jI3MPrqAqjoRESjLGcZosc7JASR5kadyzEuBnd3Negxbtq07AqlyZ4d5W4k7L
 k+C7VX/qKFiYFihbZYLaf5wsWEHp4QNSUbG2jT8IuxvRwjZCUc9qMiC6aeOZ1Avn2GZR
 cCcTkTpbut7XUqnKeuXYMAa1z9nT+MMHvIipg0KIqzCNIQZrSG5jTGoqDz6SRTQBGDTZ
 Z7WIWdu07TqWV2JXBXrLbjwtHQexZx/xHSGUPI/z1AjblFbeUqLRPNuuwi+phpFGXC0+
 kC5berVsYm3wuO/1cyeqQl0g+NcZgahQC4i/P+hfII7En99P/f6mpnSrijRtsQODLR+l
 uYJQ==
X-Gm-Message-State: AOJu0Yyh/O8zuzpJIb7VyWrhLdOjWaFGW1iw1t6Sx73zeYnN0lpxq1uM
 4izjJVaoyf9qZ+1hpVdBOGirbA==
X-Google-Smtp-Source: AGHT+IFJ54iV7/dydGvHs6y5HBZPR+LrAosRsLKtywEPSAmdXw8N1xHWtJ19zpDPq3bY3oj9p2v3nA==
X-Received: by 2002:a17:902:e214:b0:1c6:2b3d:d918 with SMTP id
 u20-20020a170902e21400b001c62b3dd918mr442572plb.3.1697761837783; 
 Thu, 19 Oct 2023 17:30:37 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:8685:4bd3:8dc9:1f68])
 by smtp.gmail.com with ESMTPSA id
 o2-20020a170902d4c200b001c61df93afdsm301751plg.59.2023.10.19.17.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 17:30:37 -0700 (PDT)
Date: Fri, 20 Oct 2023 09:30:34 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Message-ID: <ZTHKKurIp67bx2MJ@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231017140925.GB3119521@bill-the-cat>
 <cac1ad58-5a7a-41fd-84db-f972609f95c6@gmx.de>
 <CAPnjgZ2tJEBNWsx_tLDTWyQ+xNyLj6feDenqEcCe+t3JNEdv8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2tJEBNWsx_tLDTWyQ+xNyLj6feDenqEcCe+t3JNEdv8g@mail.gmail.com>
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

On Thu, Oct 19, 2023 at 08:01:11AM -0600, Simon Glass wrote:
> Hi Heinrich,
> 
> On Wed, 18 Oct 2023 at 06:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 10/17/23 16:09, Tom Rini wrote:
> > > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
> > >
> > >> Since efi_device_path.c calls eth_get_dev() and assumes that Ethernet is
> > >> available, add it as an explicit dependency.
> > >>
> > >> Signed-off-by: Simon Glass <sjg@chromium.org>
> > >> ---
> > >>
> > >> (no changes since v2)
> > >>
> > >> Changes in v2:
> > >> - Add new patch to update EFI_LOADER to depend on DM_ETH
> > >>
> > >>   lib/efi_loader/Kconfig | 1 +
> > >>   1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > >> index 13cad6342c36..fca4b3eef270 100644
> > >> --- a/lib/efi_loader/Kconfig
> > >> +++ b/lib/efi_loader/Kconfig
> > >> @@ -11,6 +11,7 @@ config EFI_LOADER
> > >>      # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> > >>      depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> > >>      depends on BLK
> > >> +    depends on DM_ETH
> > >>      depends on !EFI_APP
> > >>      default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
> > >>      select CHARSET
> > >
> > > Does this work for you Heinrich, or do you want to clarify the
> > > dependencies (and re-organize the code as needed) around networking?
> > >
> >
> > We should be able to boot via EFI on devices without U-Boot network support.
> >
> > We already use IS_ENABLED(CONFIG_NETDEVICES) to avoid invoking
> > eth_get_dev() if there is no network. CONFIG_NETDEVICES=y selects
> > CONFIG_DM_ETH.
> >
> > Why is this not sufficient?
> > Is there a configuration that does not build?
> 
> The point of this series is to disable CMDLINE and fix up what breaks.
> 
> In this case we have some sort of breakage...perhaps Tom has already
> found it, but otherwise could you take a look?
> 
> We should be able to disable NET and LTO in sandbox and still build.
> But this fails at present[1]. You can try it on -master

Obviously, it would be necessary to enclose efi_dp_from_eth()
with "if defined(CONFIG_NETDEVICES)" (or DM_ETH).
Then, we could drop "depends on DM_ETH".

Another possible place for completeness is "case UCLASS_ETH" clause
in dp_size(), but it seems to be harmless.

-Takahiro Akashi


> Regards,
> Simon
> 
> [1] sjg@sjg1:~/u$ crosfw sandbox -L
> cmd: make -j4 'CROSS_COMPILE=' --no-print-directory 'HOSTSTRIP=true'
> 'QEMU_ARCH=' 'KCONFIG_NOSILENTUPDATE=1' 'O=/tmp/b/sandbox' 'NO_LTO=1'
> -s 'BUILD_ROM=1' all
> /usr/bin/ld: lib/efi_loader/efi_device_path.o: in function `efi_dp_from_eth':
> /home/sjg/c/src/third_party/u-boot/files/lib/efi_loader/efi_device_path.c:985:(.text+0xca4):
> undefined reference to `eth_get_dev'
> /usr/bin/ld: /home/sjg/c/src/third_party/u-boot/files/lib/efi_loader/efi_device_path.c:987:(.text+0xca9):
> undefined reference to `eth_get_dev'
> /usr/bin/ld: /home/sjg/c/src/third_party/u-boot/files/lib/efi_loader/efi_device_path.c:993:(.text+0xcc9):
> undefined reference to `eth_get_dev'
> collect2: error: ld returned 1 exit status
> make[1]: *** [/home/sjg/c/src/third_party/u-boot/files/Makefile:1765:
> u-boot] Error 1
> make: *** [Makefile:177: sub-make] Error 2
> 
> sjg@sjg1:~/u$ crosfw sandbox
> sjg@sjg1:~/u$ (passes)
> 
> 'crosfw xx' is just 'buildman --bo xxx'
> 
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index a92bb896c63e..4e9996a92342 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -48,7 +48,7 @@ int pxe_get_file_size(ulong *sizep)
> 
>   return 0;
>  }
> -
> +#if 0
>  /**
>   * format_mac_pxe() - obtain a MAC address in the PXE format
>   *
> @@ -82,7 +82,7 @@ int format_mac_pxe(char *outbuf, size_t outbuf_len)
> 
>   return 1;
>  }
> -
> +#endif
>  /**
>   * get_relfile() - read a file relative to the PXE file
>   *
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 47417cb0391d..57bb6202dbb5 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -349,3 +349,4 @@ CONFIG_TEST_FDTDEC=y
>  CONFIG_UNIT_TEST=y
>  CONFIG_UT_TIME=y
>  CONFIG_UT_DM=y
> +# CONFIG_NET is not set
> 
> Regards,
> Simon
