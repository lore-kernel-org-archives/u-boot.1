Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4CAE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43CF3806ED;
	Wed,  8 Jan 2025 16:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=per1cycle.org header.i=@per1cycle.org header.b="HlVVWojQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C754800DF; Wed,  8 Jan 2025 12:36:48 +0100 (CET)
Received: from mail.per1cycle.org (unknown [IPv6:2a01:4f8:c013:8d4e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5595780040
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 12:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@per1cycle.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 176FD3F5F3; Wed,  8 Jan 2025 11:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=per1cycle.org;
 s=dkim; t=1736336204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jrqz5zHNNpuUxBGxbXd9gCdhYb9XoMq+jlZbu6Y2Yns=;
 b=HlVVWojQ7SfnrxkVws+JpsOA/z87liIB3O7eoiBkqs+X/tPd9G9CD5YOmGkBR9Zg70j/UA
 Shsn0CMUFrhbvunTFzY1WpfSPaztCe4B83vQy/8tI+9IR3qiLnObvjYMlck4KAiPp+zUF+
 FgApP4YrBywoFUnyshc1vb03DNkG5VKn/rGAfNkcYcIIGW2Z3R4ZIF8SKx6RtdERfBsl/b
 aCyebQQyZcywFD5bjOcwEdnjVMifrwkZhIP1iu25m7AU9XhrfKKtVHwSQV9IFBwOkVmk0m
 3ITe21kieh4sZqLXKytkl7iubUA0wCTIL7RuKKtYkGNSMgg/2oyZ/mxU+arqTg==
Date: Wed, 8 Jan 2025 19:36:27 +0800
From: Huan Zhou <me@per1cycle.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, Ben Dooks <ben.dooks@codethink.co.uk>,
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas =?utf-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Huan Zhou <pericycle.cc@gmail.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Padmarao Begari <padmarao.begari@amd.com>
Subject: Re: [PATCH] riscv: spacemit: k1: probe dram size during boot phase.
Message-ID: <20250108113627.z57b3h5jufe6x7ja@per1cycle.per1cycle>
References: <20250108-get-dram-size-v1-1-4bae32ecf756@per1cycle.org>
 <20250108111105-GYA3276837@gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108111105-GYA3276837@gentoo>
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 08 Jan 2025 16:49:18 +0100
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

On Wed, Jan 08, 2025 at 07:11:05PM +0800, Yixun Lan wrote:
> Hi Huan:
> 
> On 16:49 Wed 08 Jan     , Huan Zhou wrote:
> > 
> > 
> ..
> > ---
> remove above "---"? otherwise following commit message will be
> dropped during patch application..
> 
ill have a check.
> > This patch introduce improvement for get dram size on bananapi BPI-F3,
> > retrieving the dram size dynamically.
> > Have tested on bananapi BPIF3 4G and jupiter 8G.
> > 
> > Signed-off-by: Huan Zhou <me@per1cycle.org>
> > ---
> >  arch/riscv/cpu/k1/dram.c | 40 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 38 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
> > index c477c15cbfb19f0e3a0ee72985b602f5bda352d7..095217f2a4c053f7477d62c0776bcb51e623db47 100644
> > --- a/arch/riscv/cpu/k1/dram.c
> > +++ b/arch/riscv/cpu/k1/dram.c
> > @@ -4,17 +4,53 @@
> >   */
> >  
> >  #include <asm/global_data.h>
> > +#include <asm/io.h>
> >  #include <config.h>
> > +#include <bitfield.h>
> >  #include <fdt_support.h>
> >  #include <linux/sizes.h>
> >  
> > +#define DDR_BASE 0xC0000000
> >  DECLARE_GLOBAL_DATA_PTR;
> >  
> > +static inline u32 map_format_size(u32 val)
> > +{
> > +	u32 tmp;
> > +
> > +	if (val & 0x1 == 0)
> please add brackets explicitly, something like
> 	if ((val & 0x1) == 0)
ok, sry for this dummy mistake ;(
> 
> > +		return 0;
> > +
> > +	tmp = bitfield_extract(val, 16, 5);
> > +	switch (tmp) {
> > +	case 0xd:
> > +		return 512;
> > +	case 0xe:
> > +		return 1024;
> > +	case 0xf:
> > +		return 2048;
> > +	case 0x10:
> > +		return 4096;
> > +	case 0x11:
> > +		return 8192;
> > +	default:
> > +		pr_info("Invalid DRAM density %x\n", val);
> > +		return 0;
> > +	}
> > +}
> > +
> > +u32 ddr_get_density(void)
> > +{
> > +	u32 cs0_size = map_format_size(readl((void *)DDR_BASE + 0x200));
> > +	u32 cs1_size = map_format_size(readl((void *)DDR_BASE + 0x208));
> > +	u32 ddr_size = cs0_size + cs1_size;
> > +
> > +	return ddr_size;
> > +}
> > +
> >  int dram_init(void)
> >  {
> >  	gd->ram_base = CFG_SYS_SDRAM_BASE;
this two line not sure why it appear, also will be removed in next version
> > -	/* TODO get ram size from ddr controller */
> > -	gd->ram_size = SZ_4G;

> > +	gd->ram_size = (u64)ddr_get_density() * SZ_1M;
> while using cast, why not define ddr_get_density() return as same type?
> also it's more reasonable to use phys_size_t as I checked gd_t
ok, will fixed in next version.
> 
> >  	return 0;
> >  }
> >  
> > 
> > ---
> > base-commit: 19fc0b7f7d907119a13e9c207991899f0817f8fc
> > change-id: 20250108-get-dram-size-65cf59a15201
> > 
> > Best regards,
> > -- 
> > Huan Zhou <me@per1cycle.org>
> > 
> 
> -- 
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55
