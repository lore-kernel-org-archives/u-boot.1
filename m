Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A017BC10DCE
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 18:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E470B86579;
	Wed,  6 Dec 2023 19:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N/BD4WFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFF2C86579; Wed,  6 Dec 2023 19:46:55 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38A7386D0E
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 19:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50bce78f145so139693e87.0
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 10:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701888412; x=1702493212; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FV4ozRSRwSQpbP6KN5DXwt1uB2n/42rhSlwsvwGk9r8=;
 b=N/BD4WFqoBotBg2GRlO3ikIdKUZFAmTy43BmMp1rmjTeiYhPZt2AeD/pTR3q6JaReH
 bkjhgkatG9W3OqZZtS8oIGhFLJRTd/dDBMp1Qmx3YSlPKsaOiLf9uai5iLrWuBVIHpb/
 /gI1VkzgWib8Uy5xYLSUQdK1XoDCH7yBmhx0cR8zW0vJYTAXxhyFYAMc8t6jSvKuEjtZ
 3TX/rHBudtIDGxPgpZKYX59U5CpzOYnDJXnV5MzmKJshRN8/blU0CTkmTcLTFakayxwU
 RLzwqpFGR58Idn82Z6BuspNAhhWkaoEcqD0vCkNkd/m5N4PkbvR+G9irl4/xipdJCo5j
 AxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701888412; x=1702493212;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FV4ozRSRwSQpbP6KN5DXwt1uB2n/42rhSlwsvwGk9r8=;
 b=mP09zMh8LOAZ3YPq7ZT/RvUbDJPhSpjQkRxOv0QZ8mhUG05VNnJG7vdjGVRz3BAMij
 37XRbNGfTVjNwiMiVEfHO/6Zk6msRoZySyFltu3h2c2wmbgkLgjUY9c4iXtRsmfpId2E
 1/zT1+Uf5i83imDKUDpLxTkDyWrLy/3BxIoo4o6tHnHS6yrG1ymYzOOZ2uhEVqKwRmbF
 lWBZfnetIawN5Xky9cgj4TgJ0vVeWXKHtwCBih9SPIlvVLxi9HaQ4UkobrYoIC6KI3gS
 FAq7qjb53bxwSvyARKcgrqCm65G9zRJkT3qLG0iNP6iVyQBlwFqHCKyPlaBaWXGF2DMW
 mUXw==
X-Gm-Message-State: AOJu0YzNj3r8hEKKWbAXP9gFYw8opo471h6PDrKz9AH0Bhb1BV7ohXkS
 5mcLNsVLyPFEfqkZSHM3N6g=
X-Google-Smtp-Source: AGHT+IFDXCdWRaQkK3kE/HRrrr5uHQWDqeyvineFP1FtpCSOmNySNBxU8b5pffeXuwtgYgugtmZlUA==
X-Received: by 2002:ac2:5a1b:0:b0:50b:f4ac:3d5c with SMTP id
 q27-20020ac25a1b000000b0050bf4ac3d5cmr379606lfn.102.1701888412036; 
 Wed, 06 Dec 2023 10:46:52 -0800 (PST)
Received: from localhost ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
 by smtp.gmail.com with ESMTPSA id
 d10-20020ac241ca000000b0050be6252444sm1412123lfi.133.2023.12.06.10.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 10:46:51 -0800 (PST)
Date: Wed, 6 Dec 2023 21:46:51 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Samuel Holland <samuel@sholland.org>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH] sunxi: restore modified memory
Message-ID: <ZXDBmxmj6bBoepVR@skv.local>
Mail-Followup-To: Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Samuel Holland <samuel@sholland.org>,
 Jagan Teki <jagan@amarulasolutions.com>
References: <20230721145721.616040-1-andrej.skvortzov@gmail.com>
 <20231101095034.44d14187@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101095034.44d14187@donnerap.manchester.arm.com>
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

Hi Andre,

On 23-11-01 09:50, Andre Przywara wrote:
> On Fri, 21 Jul 2023 17:57:21 +0300
> Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> 
> Hi Andrey,
> 
> sorry for the late reply!
> 
> > On A64 with 2G of RAM words at following addresses were modified with
> > 'aa55aa55' value:
> >  - 50000000
> >  - 60000000
> >  - 84000000
> >  - 88000000
> >  - 90000000
> >  - A0000000
> >  - A0000200
> > 
> > That made harder to pick memory range for persistent storage in RAM.
> 
> In general I now think this patch is fine, since DRAM content can indeed
> be preserved across some reboot types.
> Some things below:
> 
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > ---
> >  arch/arm/mach-sunxi/dram_helpers.c  | 16 ++++++++++++++--
> >  arch/arm/mach-sunxi/dram_sunxi_dw.c | 16 ++++++++++++++--
> >  2 files changed, 28 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi/dram_helpers.c
> > index 2c873192e6..e3d236a4b3 100644
> > --- a/arch/arm/mach-sunxi/dram_helpers.c
> > +++ b/arch/arm/mach-sunxi/dram_helpers.c
> > @@ -32,12 +32,24 @@ void mctl_await_completion(u32 *reg, u32 mask, u32 val)
> >  #ifndef CONFIG_MACH_SUNIV
> >  bool mctl_mem_matches(u32 offset)
> >  {
> > +	unsigned long tmp_base;
> > +	unsigned long tmp_offset;
> 
> The type doesn't match the return type of readl.
> Please use uint32_t here.
> And the names are somewhat misleading, at least to my mind, since they are
> not a base address and an offset, but rather just values at a base
> address and at an offset from that.
> So I think val_base and val_offset would be better.

Thanks for the review.

> > +	bool ret;
> > +
> > +        /* Save original values */
> > +	tmp_base = readl(CFG_SYS_SDRAM_BASE);
> > +	tmp_offset = readl((ulong)CFG_SYS_SDRAM_BASE + offset);
> > +
> >  	/* Try to write different values to RAM at two addresses */
> >  	writel(0, CFG_SYS_SDRAM_BASE);
> >  	writel(0xaa55aa55, (ulong)CFG_SYS_SDRAM_BASE + offset);
> >  	dsb();
> >  	/* Check if the same value is actually observed when reading back */
> > -	return readl(CFG_SYS_SDRAM_BASE) ==
> > -	       readl((ulong)CFG_SYS_SDRAM_BASE + offset);
> > +	ret = readl(CFG_SYS_SDRAM_BASE) == readl((ulong)CFG_SYS_SDRAM_BASE + offset);
> > +
> > +	/* Restore original values */
> > +	writel(tmp_base, CFG_SYS_SDRAM_BASE);
> > +	writel(tmp_offset, (ulong)CFG_SYS_SDRAM_BASE + offset);
> > +	return ret;
> >  }
> >  #endif
> > diff --git a/arch/arm/mach-sunxi/dram_sunxi_dw.c b/arch/arm/mach-sunxi/dram_sunxi_dw.c
> > index 9107b114df..6245815fa2 100644
> > --- a/arch/arm/mach-sunxi/dram_sunxi_dw.c
> > +++ b/arch/arm/mach-sunxi/dram_sunxi_dw.c
> > @@ -657,13 +657,25 @@ static int mctl_channel_init(uint16_t socid, struct dram_para *para)
> >   */
> >  static bool mctl_mem_matches_base(u32 offset, ulong base)
> 
> Mmh, somehow I dimly remember commenting on this before (some other
> patch?), but this function is essentially the same as above, isn't it?
> If someone has some spare cycles, they could be merged, implementing
> mctl_mem_matches() as a tiny wrapper around mctl_mem_matches_base(), to
> preserve all callers.
> 
> Shouldn't block this patch, though.
Good point. I'll do this as part of v2 as a separate patch.

-- 
Best regards,
Andrey Skvortsov
