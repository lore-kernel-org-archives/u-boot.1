Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F8DC4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 13:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE84086EF6;
	Sat, 11 Nov 2023 14:25:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ga1uyf9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B78986F5E; Sat, 11 Nov 2023 14:25:32 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F68886EF1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 14:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7a9857c14c5so105471039f.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 05:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699709129; x=1700313929; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iCWyH8vkIgmZexCqJ9NVCU2vE6GoP+VlX5O7eHV3STQ=;
 b=Ga1uyf9Xcg+HmQKv8k6Qc8fUr/kSMKofPC7JtFB14xkNFj09NUoS3iXQvwHEWRL6a0
 hAvS6zU1WTymdDsmVh8EhhKmvJyFAcSY/i6x9EoiuK4wW/JP5csKnXeGIldeInhK2qxy
 2oW0rUPjMKimMDZMk20k4zDwGsOJ3GyJ0u7SFkAQNVgAcS0XGgrX8Nyx/DEDe6aHKL8R
 MJcJgIA7FZ5HS1oFCWD3j95UbdfnXuFJY61IyATBwpICbn3WXY7hdeYjL/Gxx+DeNGoP
 /gn+hjzDEv+WIlbHmUfx62WIll0IxkujcLLBrJVhbDnUSHCz5E5+jUEkY3C8QO/ZgeRG
 +0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699709129; x=1700313929;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iCWyH8vkIgmZexCqJ9NVCU2vE6GoP+VlX5O7eHV3STQ=;
 b=byOQufoVQy8TqAq0gLzAY3MbUJIQImVK8ykLeG7esWgwQrIlzFiW4JyQes6xas64br
 zT7q/Qm4GVYg3mDpeDw8DSSM4gDX0ihEvYiD9G0K5l08fwx1ZUZ14hbowelXy37bYarj
 dgZkboLpQEwNlr8PHbX9iguUySfHuOYToxFid2gir2nQ1iDKIeiYHNfkyeO1u0yn5c5f
 tO5sKSNrjyScGeRK3SC8OicylDfcUNLul6ZtghqZ/A5bQMSTNBhr/uZsJdDFcDGP+9ZW
 /3+72o6WHqscmBRKdKnSlaudhXSMpT/zHTPEJA0d7JnMx42816fDAFEABgG4Nr4sTrWr
 yPLg==
X-Gm-Message-State: AOJu0Yy9PdSlg08B5vlRI7bEei4k7nZ+iGxvB04QXv4wvYxnit/Iu3pz
 H5CCK/ydutSyHv2rJWlewpc5gg==
X-Google-Smtp-Source: AGHT+IE34kN9xETTqVhWnz7QlWeNSwjrazkcjEA1iyHQeb14WkR9U4Bzmq2GtaoI/a6mAf+q+UTNKw==
X-Received: by 2002:a6b:5f17:0:b0:7a6:b272:fd78 with SMTP id
 t23-20020a6b5f17000000b007a6b272fd78mr2425757iob.10.1699709128782; 
 Sat, 11 Nov 2023 05:25:28 -0800 (PST)
Received: from ?IPv6:2401:4900:5306:7350:68e5:c904:2404:b568?
 ([2401:4900:5306:7350:68e5:c904:2404:b568])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a023408000000b0043167542398sm455496jae.141.2023.11.11.05.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 05:25:27 -0800 (PST)
Message-ID: <01b9c3f4c63cb26a05ef003738b33efca507140a.camel@ventanamicro.com>
Subject: Re: [PATCH] drivers: pcie_xilinx: Fix "reg" not found error
From: mchitale@ventanamicro.com
To: Michal Simek <michal.simek@amd.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Puhan Zhou <puh4n.zhou@gmail.com>, Thierry
 Reding <treding@nvidia.com>, Alexander Dahl <ada@thorsis.com>, Jonas
 Karlman <jonas@kwiboo.se>,  Svyatoslav Ryhel <clamor95@gmail.com>, Valentin
 Caron <valentin.caron@foss.st.com>, Shengyu Qu <wiagn233@outlook.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Date: Sat, 11 Nov 2023 18:55:19 +0530
In-Reply-To: <17a0048c-bdaa-4c82-8b51-b193bf14abf5@amd.com>
References: <20231102082303.354944-1-mchitale@ventanamicro.com>
 <17a0048c-bdaa-4c82-8b51-b193bf14abf5@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

Hi Michal,

On Thu, 2023-11-02 at 10:05 +0100, Michal Simek wrote:
> 
> On 11/2/23 09:23, Mayuresh Chitale wrote:
> > Fix the driver to use the dev_read_addr_size API to fetch the reg
> > property from the DT.
> > 
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > ---
> >   drivers/pci/pcie_xilinx.c | 22 ++++++++--------------
> >   1 file changed, 8 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
> > index 53fd121e90..20b630027f 100644
> > --- a/drivers/pci/pcie_xilinx.c
> > +++ b/drivers/pci/pcie_xilinx.c
> > @@ -140,20 +140,14 @@ static int pcie_xilinx_write_config(struct
> > udevice *bus, pci_dev_t bdf,
> >   static int pcie_xilinx_of_to_plat(struct udevice *dev)
> >   {
> >   	struct xilinx_pcie *pcie = dev_get_priv(dev);
> > -	struct fdt_resource reg_res;
> > -	DECLARE_GLOBAL_DATA_PTR;
> > -	int err;
> > -
> > -	err = fdt_get_resource(gd->fdt_blob, dev_of_offset(dev), "reg",
> 
> I don't have HW to test this but here you are removing reference to
> GD that's 
> why I think you should also remove
> 
> #include <asm/global_data.h>
Ok.
> 
> 
> 
> 
> > -			       0, &reg_res);
> > -	if (err < 0) {
> > -		pr_err("\"reg\" resource not found\n");
> > -		return err;
> > -	}
> > -
> > -	pcie->cfg_base = map_physmem(reg_res.start,
> > -				     fdt_resource_size(&reg_res),
> > -				     MAP_NOCACHE);
> > +	fdt_addr_t addr;
> > +	fdt_size_t size;
> > +
> > +	addr = dev_read_addr_size(dev, &size);
> > +	if (addr == FDT_ADDR_T_NONE)
> > +		return -EINVAL;
> > +
> > +	pcie->cfg_base = map_physmem(addr, size, MAP_NOCACHE);
> 
> Definitely it is better then what was there before.
> 
> But can't use use devm_ioremap() instead?
Ok.
> 
> Thanks,
> Michal

