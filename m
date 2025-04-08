Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20A2C369A4
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 16:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED6BD82B45;
	Tue,  8 Apr 2025 18:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="PkOcAt07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2677682C38; Tue,  8 Apr 2025 18:22:01 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF3D82AA3
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 18:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 9683E25C17;
 Tue,  8 Apr 2025 18:21:58 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xCOKunNgl4ru; Tue,  8 Apr 2025 18:21:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1744129317; bh=RW6fmFvNXQqRzDvXs6sGp9eCoO6aKOebE0b3SATo/b4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PkOcAt07HCcC/imuhvwZPAyTJkYdsiAEckWLVdCQ5wRAY/tcAlOkAWbM5NKmxh+BK
 Rw1G+kDEFzgi9HcHE7qTQTq8dGsCYSet/KZB9PfgBT4PA/9vCluGw082zarMi5KQRe
 hNDGS2Rofq0UG9bYyOqStNpgpHu7StC5vp4Ze1w9toKRlyTz1d7rfw/NTnazRYFzbz
 yqtviiqezJqbxTGQ/NsclHMl7SMQ7vetWCw48KL8o+/51ydzIcPno4VuFzfeAgv1gX
 hQ8KqkGlueICriiFaf2YzHxuK2XP+L4DtcgUSmj/rpCcJfFMIUx7VKENzLCsTIefuc
 brXRkG5qXHSGg==
Date: Tue, 8 Apr 2025 16:21:19 +0000
From: Yao Zi <ziyao@disroot.org>
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marex@denx.de>, Paul Kocialkowski <contact@paulk.fr>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Lukas Funke <lukas.funke@weidmueller.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] spl: riscv: Disable SPL_BINMAN_UBOOT_SYMBOLS by
 default
Message-ID: <Z_VM_5f5-m9SHX51@pie>
References: <20250407033744.4025-1-ziyao@disroot.org>
 <20250407033744.4025-2-ziyao@disroot.org>
 <CAFLszTjmabVKuHF8Ym1OENiiBZrSTd2vVjWvHcQkb552qAuhwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjmabVKuHF8Ym1OENiiBZrSTd2vVjWvHcQkb552qAuhwg@mail.gmail.com>
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

On Mon, Apr 07, 2025 at 10:50:07PM +1200, Simon Glass wrote:
> Hi Yao,
> 
> On Mon, 7 Apr 2025 at 15:38, Yao Zi <ziyao@disroot.org> wrote:
> >
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
> 
> Do you know where the symbol is being referenced? This sounds like a bug to me.
> 
> It is likely to be spl_get_image_pos(), perhaps called from
> spl_set_header_raw_uboot().

The symbol is referenced in common/spl/spl.c:54,

	#if CONFIG_IS_ENABLED(BINMAN_UBOOT_SYMBOLS)
	/* See spl.h for information about this */
	#if defined(CONFIG_SPL_BUILD)
	binman_sym_declare(ulong, u_boot_any, image_pos);
	binman_sym_declare(ulong, u_boot_any, size);
	#endif

> If you are using FIT that function should not be called.

The place where binman_sym() is used isn't where an entry in .binman_sym
section is introduced. Instead, binman_sym_declare() actually defines
the entry.

So whether spl_get_image_pos() is invoked doesn't affect the failure,
since in both cases binman_sym_declare() puts an entry into .binman_sym,
confusing binman.

imho SPL_BINMAN_UBOOT_SYMBOLS should depend on !SPL_LOAD_FIT in an ideal
world, but I'm not sure the impact on current codebase thus limited the
change to RISC-V only.

Best regards,
Yao Zi

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
> >         bool "Declare binman symbols for U-Boot phases in SPL"
> >         depends on SPL_BINMAN_SYMBOLS
> >         default n if ARCH_IMX8M || ARCH_IMX8ULP || ARCH_IMX9
> > +       # A FIT image is created with default binman configuration of RISC-V
> > +       default n if RISCV
> >         default y
> >         help
> >           This enables use of symbols in SPL which refer to U-Boot phases,
> > --
> > 2.49.0
> >
> 
> Regards,
> Simon
