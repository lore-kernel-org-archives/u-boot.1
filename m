Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C3AC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BFB3816A4;
	Tue,  4 Mar 2025 14:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="HyBvpfBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93829816AB; Tue,  4 Mar 2025 14:00:05 +0100 (CET)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60BCB8144A
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:00:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j.ne@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 268E2240027
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:00:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1741093203; bh=LYHDaHH5ncPyWh7fopSQLgfO2jp1dB5IbJCn0If1pt4=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:From;
 b=HyBvpfBB7Hxqyo7pcjX/UpUgWHu9uHEQZj2LljphMTcr4z/MGFLnHmQ3D4A23NOkR
 ojODJub7bD6MkZaNPrVTZHJ5hJZe56oTiDTCl75FNhgTKLVAerbsjIsiY78sdpjPQZ
 EYsvodDL6y4YWUAwMH5B8hrQdyYVbfGWeWzqmnKuCVlCas4BjsoUxHX59usr3TRgvy
 /iH3CRoLji+I19vD3jd8DQZknoLRzohzLSA0amxbY10DTGNmg03kVsMTBlga0mbAqV
 HU/lECS6pP/vtB/uPAKvPltRuglmTWuR+V2sa7ieVGjDbfygs/r2BDnoFqxVFjmXr3
 xhiOWiiwQGz2w==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4Z6bPZ3dN3z6tvy;
 Tue,  4 Mar 2025 14:00:02 +0100 (CET)
Date: Tue,  4 Mar 2025 13:00:02 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: j.ne@posteo.net, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] powerpc: mpc8xxx_spi: Catch bad chip variants earlier
Message-ID: <Z8b5UnGx4uVQWi0a@probook>
References: <20250217-immap-size-v1-0-f9be2e9e7b1a@posteo.net>
 <20250217-immap-size-v1-2-f9be2e9e7b1a@posteo.net>
 <20250303040838.GB13236@nxa18884-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303040838.GB13236@nxa18884-linux>
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

On Mon, Mar 03, 2025 at 12:08:38PM +0800, Peng Fan wrote:
> Hi,
> 
> On Mon, Feb 17, 2025 at 04:48:48PM +0100, J. Neuschäfer via B4 Relay wrote:
> >From: "J. Neuschäfer" <j.ne@posteo.net>
> >
> >Currently, enabling the MPC8xxx SPI driver on an unexpected SoC results
> >in a wall of errors because spi8xxx_t isn't defined. This is quite a bad
> >experience, so let's catch this kind of issue in mpc8xxx_spi.h.
> >
> >Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> >---
> > arch/powerpc/include/asm/mpc8xxx_spi.h | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> >diff --git a/arch/powerpc/include/asm/mpc8xxx_spi.h b/arch/powerpc/include/asm/mpc8xxx_spi.h
> >index 2b2095ad481d19a48e1f8d521626a0356773c0b5..3efd4bdcac2c3725a8065b3bb7faa11c78da0c78 100644
> >--- a/arch/powerpc/include/asm/mpc8xxx_spi.h
> >+++ b/arch/powerpc/include/asm/mpc8xxx_spi.h
> >@@ -28,6 +28,8 @@ typedef struct spi8xxx {
> > } spi8xxx_t;
> > static_assert(sizeof(spi8xxx_t) == 0x1000);
> > 
> >+#else
> >+#error "SPI register layout not defined: Unknown chip variant"
> > #endif
> 
> This cause build error, would you please give a look?:
>    powerpc:  +   kmcoge5ne

A quick analysis of this:

 - CONFIG_TARGET_KMCOGE5NE (indirectly) selects CONFIG_ARCH_MPC8360,
   because the KM boards are based on the MPC8360
 - In immap_83xx.h, the MMIO space definition for MPC8360 does not
   use spi8xxx_t, which is consistent with the MPC8360 datasheet,
   because the MPC8360 uses the QUICC Engine block for SPI functionality

I didn't expect this, and my compile-testing didn't catch it, but in
conclusion, I think my patch is wrong, and I will not include it in
version 2 of this series.

> +In file included from arch/powerpc/include/asm/immap_83xx.h:19,
> +                 from arch/powerpc/include/asm/ppc.h:24,
> +                 from arch/powerpc/include/asm/u-boot.h:23,
> +                 from arch/powerpc/include/asm/global_data.h:98,
> +                 from lib/asm-offsets.c:15:
> +arch/powerpc/include/asm/mpc8xxx_spi.h:32:2: error: #error "SPI register layout not defined: Unknown chip variant"
> +   32 | #error "SPI register layout not defined: Unknown chip variant"
> +      |  ^~~~~
> +make[2]: *** [scripts/Makefile.build:146: lib/asm-offsets.s] Error 1
> +make[1]: *** [Makefile:1980: prepare0] Error 2
> +make: *** [Makefile:177: sub-make] Error 2
>    powerpc:  +   kmeter1

KMETER1 is probably very similar.

> +In file included from arch/powerpc/include/asm/immap_83xx.h:19,
> +                 from arch/powerpc/include/asm/ppc.h:24,
> +                 from arch/powerpc/include/asm/u-boot.h:23,
> +                 from arch/powerpc/include/asm/global_data.h:98,
> +                 from lib/asm-offsets.c:15:
> +arch/powerpc/include/asm/mpc8xxx_spi.h:32:2: error: #error "SPI register layout not defined: Unknown chip variant"
> +   32 | #error "SPI register layout not defined: Unknown chip variant"
> +      |  ^~~~~
> +make[2]: *** [scripts/Makefile.build:146: lib/asm-offsets.s] Error 1
> +make[1]: *** [Makefile:1980: prepare0] Error 2
> +make: *** [Makefile:177: sub-make] Error 2
> microblaze:  w+   microblaze-generic

MicroBlaze is strange, it shouldn't be affected by this


Thank you for your reply!

J. Neuschäfer
