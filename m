Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC453C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 04:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C67CE82845;
	Wed,  9 Apr 2025 06:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="lF+mM1G6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5F4C82845; Wed,  9 Apr 2025 06:28:00 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9852E820AA
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 06:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 1717D20240;
 Wed,  9 Apr 2025 06:27:58 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5mXTWVx_iFqI; Wed,  9 Apr 2025 06:27:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1744172877; bh=bg2shqCnYN6xHD6U7FdslaScQ/7xkgnL8f2YiFAB2FE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lF+mM1G6o9+tsoXL2w1rwQM0QrUvjpKSzh2e5yL+FmZTSne9Ve/APfxz/Zr20wRA8
 +hg0TRDWM9U0KuzTAftV+tRggq9kdh1Pw6Nu2tukLaez9zT3lO6PpD2bWrRE1PQ8PU
 9e1mwNXXeGs1oQnZWg5/Ng9sHms2UPAFKI0T+GlRAcCMuo92KCiexDfrFTmljEtBXB
 DSmwgX70k8xjl+JDbzmhxjeg+w0y7JAL2fcQTY5ihY8FZ5L9vwK0/YIpZJckCqa9bY
 G4yVozrZT7gXxZmkXF/OCxuPvvQ3eRY0SvWoO64Ew4Hd5ECo9UWSNlBTgkMqxZMy0j
 Y+wociXEyOkRQ==
Date: Wed, 9 Apr 2025 04:27:37 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marex@denx.de>, Paul Kocialkowski <contact@paulk.fr>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Lukas Funke <lukas.funke@weidmueller.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] spl: riscv: Disable SPL_BINMAN_UBOOT_SYMBOLS by
 default
Message-ID: <Z_X3OYMogfYdSan7@pie.lan>
References: <20250407033744.4025-1-ziyao@disroot.org>
 <20250407033744.4025-2-ziyao@disroot.org>
 <662e8417-1651-4a36-97d8-e46c30c7b16b@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662e8417-1651-4a36-97d8-e46c30c7b16b@kwiboo.se>
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

On Mon, Apr 07, 2025 at 01:22:37PM +0200, Jonas Karlman wrote:
> Hi,
> 
> On 2025-04-07 05:37, Yao Zi wrote:
> > The default binman configuration of RISC-V wraps proper U-Boot into a
> > FIT image instead of shipping a plain image, thus there's no
> > "u_boot_any" entry by default. Let's disable the option to prevent
> > binman from looking for a plain proper U-Boot image, failing the build
> > with message like
> > 
> >   Section '/binman/spl-img': Symbol '_binman_u_boot_any_prop_size'
> >      in entry '/binman/spl-img/mkimage/u-boot-spl/u-boot-spl-nodtb':
> >        Entry 'u-boot-any' not found in list (u-boot-spl-nodtb,
> >        u-boot-spl-dtb,u-boot-spl,mkimage,spl-img)
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  common/spl/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > index 7d6780936d1..356ddab38de 100644
> > --- a/common/spl/Kconfig
> > +++ b/common/spl/Kconfig
> > @@ -214,6 +214,8 @@ config SPL_BINMAN_UBOOT_SYMBOLS
> >  	bool "Declare binman symbols for U-Boot phases in SPL"
> >  	depends on SPL_BINMAN_SYMBOLS
> >  	default n if ARCH_IMX8M || ARCH_IMX8ULP || ARCH_IMX9
> > +	# A FIT image is created with default binman configuration of RISC-V
> 
> Use of a FIT does not really matter, Rockchip use a FIT for U-Boot
> proper and symbols can be located.

You're right. binman is able to match a U-Boot blob in FIT image as long
as its entry name is correct. We should replace blob-ext with
u-boot-nodtb here.

> 
> > +	default n if RISCV
> >  	default y
> >  	help
> >  	  This enables use of symbols in SPL which refer to U-Boot phases,
> 
> Maybe something like this is what you instead want to use:
> 
> diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
> index ceb916b74a73..e1a5ad573bbe 100644
> --- a/arch/riscv/dts/binman.dtsi
> +++ b/arch/riscv/dts/binman.dtsi
> @@ -30,20 +30,19 @@
>  				uboot {
>  					description = "U-Boot";
>  					type = "standalone";
> -					os = "U-Boot";
> +					os = "u-boot";
>  					arch = "riscv";
>  					compression = "none";
>  					load = /bits/ 64 <CONFIG_TEXT_BASE>;
>  
> -					uboot_blob: blob-ext {
> -						filename = "u-boot-nodtb.bin";
> +					uboot_blob: u-boot-nodtb {

I think the change to uboot_blob node is enough to fix the binman
issue, right?

The value of property "os" is probably wrong since spl_fit.c compares it
to "u-boot" case-sensitively to look for a U-Boot image. But this should
go in another patch IMHO.

>  					};
>  				};
>  #else
>  				linux {
>  					description = "Linux";
>  					type = "standalone";
> -					os = "Linux";
> +					os = "linux";
>  					arch = "riscv";
>  					compression = "none";
>  					load = /bits/ 64 <CONFIG_TEXT_BASE>;
> 
> diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> index 05787bdb92db..6e083bf0537a 100644
> --- a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> +++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> @@ -20,6 +20,7 @@
>  			args = "-T sfspl";
>  
>  			u-boot-spl {
> +				no-write-symbols;
>  			};
>  		};
>  	};
> 

At the very first sight I wrongly thought "no-write-symbols" would
prevent binman to function and should be avoided. But visionfive2's case
seems actually special as its spl and proper U-Boot are split into
different images, where binman cannot help much.

I've applied the fix of uboot_blob node to my WIP branch of TH1520 SPL
support and verified it does fix the binman error. Thanks for your hint
and review! I'll include the fix and drop this patch in v2.

> Regards,
> Jonas

Thanks,
Yao Zi
