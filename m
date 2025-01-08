Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CC5E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 12:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2137C803DC;
	Wed,  8 Jan 2025 13:37:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BrDqoGdQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 678E98006D; Wed,  8 Jan 2025 13:37:44 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C77B18036B
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 13:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso16016275f8f.2
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 04:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736339861; x=1736944661; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BDZo1Ax1Pqkegd5Rj/4hOkmI1usoaRy7j/1XylFQIbE=;
 b=BrDqoGdQwVQluqhEsYOCRBtrcmB2/0PVGsMzLFlyBhTEPWO4piKezLC75s3vaVwUAI
 /Vog2Fq2FJo3SneGGU7Q5oyxyloZtIcKo3E4xLNhzqU6lJLokgQkiNJEvVQKTGJFWwET
 STAmgP/uO2PnvxY8I2AfZgPGXuJRuZFxP126w91VW6oD8sVk6vX5vdyW3uIlJW8sbFsP
 9Ibxjsmtmg/JHCzO+/bYh8tCRU70ryJKQDFNXpg5ee0HXsUoaIQx52DBlIDtx296Udem
 cDLtWZ+2CEKt1xeLQio/QLSMac34FIr4+AZ7aIC95KrcmNOeaDnJb8UO1+W+XYV1mQqS
 qGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736339861; x=1736944661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDZo1Ax1Pqkegd5Rj/4hOkmI1usoaRy7j/1XylFQIbE=;
 b=FmjmPMn/bg91ZnWN+T2ZNhmal1EhR/XKQ8mRPfRjV3clPNp9fQmWfPTuLveMGFOg8z
 Fyf58YiJUlCU6MFa9ZYyiCjXfusSe+VUcxD1G8U3I3sLmlj5Uco5AUGz0Dgd50yz7uDK
 BRO7uqKRkthCp4bzptftObTTlvkpVxUzVcca/2uhuJ136LsL8jCNxW+amynJUKFGvDo+
 YcOAXvhtPePQie1jvMbeg/PVBleRX/gyvZoLQzB3VdqjEYTfXHZrExMIYVUExmB2Fimj
 +thXwlWzHj2NRgaNybwNPbEGJWxF6a1wfd/9fn/F/+iU2q/zwUnFSKqBE0gG1a2wpy5p
 +LeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQi22LQIvXHFKyxXe/EW9BxsRZpwsyf+FaMoeNlUR4L3XnUI1FoV0C4YLFVf59YccWmYmskOQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwogUwEAS2IT1Mi/uXg5U18uKutDfhHb9WBtOzRoiCLY2uTTpiT
 bUParMsZSMPHbFfdyYQxF1aTV4kZjvQzxNchXAE8/j+gB5cJQkYJ+ZWpvJKFLzI=
X-Gm-Gg: ASbGnctKLdJjhinHNTTpNWThHGHe2rh/YYazXmkcWfXDGnpL7lf6vftOBbMFbRw+E4g
 AZh4DcDlBX2zX57N0adoI6eH4MkJY+lLhRtDnuACfDOu+Um7Ebg+CW6XWTCqZofpa65RxycWHH2
 +kWXQ3Ej9n9mPhCRMHEbwDcQzwqGrl7aiq/AoYiuvBc4aaeywrpRDT+TaWJlT2/zCY+I65qGrF0
 PRC2N1SjVpvYJEsoPwOXC1BTOnqcYJZzboXT5sw5uk0IRdEoSX+aL1Q4pt0Mw==
X-Google-Smtp-Source: AGHT+IEaQ7Hn7lAhnxmkkORQmqkcewUjib5aI2lIU5dGh64QVagewy15yD+9mWxU1I+GF1+hYXWJ3A==
X-Received: by 2002:a5d:6d02:0:b0:38a:50f7:24fa with SMTP id
 ffacd0b85a97d-38a87357a07mr2268157f8f.54.1736339861248; 
 Wed, 08 Jan 2025 04:37:41 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8472casm53654206f8f.45.2025.01.08.04.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 04:37:40 -0800 (PST)
Date: Wed, 8 Jan 2025 15:37:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Yixun Lan <dlan@gentoo.org>, Huan Zhou <me@per1cycle.org>,
 u-boot@lists.denx.de, Ben Dooks <ben.dooks@codethink.co.uk>,
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
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
Message-ID: <2f6d95b7-da47-4a6c-a566-b73db825410b@stanley.mountain>
References: <20250108-get-dram-size-v1-1-4bae32ecf756@per1cycle.org>
 <20250108111105-GYA3276837@gentoo>
 <34F2FA88-E868-45C0-B73B-98BADEF49263@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34F2FA88-E868-45C0-B73B-98BADEF49263@gmx.de>
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

On Wed, Jan 08, 2025 at 12:21:18PM +0100, Heinrich Schuchardt wrote:
> Am 8. Januar 2025 12:11:05 MEZ schrieb Yixun Lan <dlan@gentoo.org>:
> >Hi Huan:
> >
> >On 16:49 Wed 08 Jan     , Huan Zhou wrote:
> >> 
> >> 
> >..
> >> ---
> >remove above "---"? otherwise following commit message will be
> >dropped during patch application..
> >
> >> This patch introduce improvement for get dram size on bananapi BPI-F3,
> >> retrieving the dram size dynamically.
> >> Have tested on bananapi BPIF3 4G and jupiter 8G.
> >> 
> >> Signed-off-by: Huan Zhou <me@per1cycle.org>
> >> ---
> >>  arch/riscv/cpu/k1/dram.c | 40 ++++++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 38 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
> >> index c477c15cbfb19f0e3a0ee72985b602f5bda352d7..095217f2a4c053f7477d62c0776bcb51e623db47 100644
> >> --- a/arch/riscv/cpu/k1/dram.c
> >> +++ b/arch/riscv/cpu/k1/dram.c
> >> @@ -4,17 +4,53 @@
> >>   */
> >>  
> >>  #include <asm/global_data.h>
> >> +#include <asm/io.h>
> >>  #include <config.h>
> >> +#include <bitfield.h>
> >>  #include <fdt_support.h>
> >>  #include <linux/sizes.h>
> >>  
> >> +#define DDR_BASE 0xC0000000
> >>  DECLARE_GLOBAL_DATA_PTR;
> >>  
> >> +static inline u32 map_format_size(u32 val)
> >> +{
> >> +	u32 tmp;
> >> +
> >> +	if (val & 0x1 == 0)
> >please add brackets explicitly, something like
> >	if ((val & 0x1) == 0)
> 
> We tend to avoid == 0 in U-Boot
> 
> if (val & BIT(0))
> 

That's reversed.

	if (!(val & BIT(0)) {

I have really complicated rules about when to use ! vs == 0.
https://staticthinking.wordpress.com/2024/02/20/when-to-use-0/

> >
> >> +		return 0;
> >> +
> >> +	tmp = bitfield_extract(val, 16, 5);
> >> +	switch (tmp) {
> >> +	case 0xd:
> >> +		return 512;
> >> +	case 0xe:
> >> +		return 1024;
> >> +	case 0xf:
> >> +		return 2048;
> >> +	case 0x10:
> >> +		return 4096;
> >> +	case 0x11:
> >> +		return 8192;
> >> +	default:
> >> +		pr_info("Invalid DRAM density %x\n", val);
> >> +		return 0;
> >> +	}
> >> +}
> >> +
> >> +u32 ddr_get_density(void)
> >> +{
> >> +	u32 cs0_size = map_format_size(readl((void *)DDR_BASE + 0x200));
> >> +	u32 cs1_size = map_format_size(readl((void *)DDR_BASE + 0x208));
> >> +	u32 ddr_size = cs0_size + cs1_size;
> >> +
> >> +	return ddr_size;
> >> +}
> >> +
> >>  int dram_init(void)
> >>  {
> >>  	gd->ram_base = CFG_SYS_SDRAM_BASE;
> >> -	/* TODO get ram size from ddr controller */
> >> -	gd->ram_size = SZ_4G;
> >> +	gd->ram_size = (u64)ddr_get_density() * SZ_1M;
> 
> This is C and not C++. We don't need a cast to assign here.
> 

I assumed the cast was to prevent an integer overflow.  The commit
message mentions 8GB?  I agree with Yixun Lan that the type of
ddr_get_density() should be fixed and probably SZ_1M should be declared
as unsigned long as well.

regards,
dan carpenter

