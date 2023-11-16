Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E63C54FB9
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 13:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C13888748D;
	Thu, 16 Nov 2023 14:29:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="L1oDyKHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 718FC87496; Thu, 16 Nov 2023 14:29:48 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA11D87469
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 14:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6bf03b98b9bso1477028b3a.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700141375; x=1700746175; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JBLsiUFa8822wLgQ0GXVKoj4tTaejWezfznf0aYXmaw=;
 b=L1oDyKHbf3ZD3ebfWrWSO1/Cd3who7PF+sE90ujVBxP2HgSeO9xYU0dM2fVwB5w1Gi
 Ht9IZb5UjwNha+JgEXMQTBs3MniDysKDL5981pHVTC2F3vpqidAa0YDK56OZuO1+P+1A
 /5t3soFzlAiYcKaiX/9kgI5Jh8HUlwMlbZlAtoulfKKLO1Q8pXkAollQRwRFKd9c9yYK
 33MsCLG975wvHCnmcsIZ6em+p3wk2ou36W36szWvOVS/EzfY3CsgTYjLsa8InxLR0lob
 og8kQexlGvlnqGUMoM1eBCfU0L9CYSa3hjowyQazjMIPrdbovaIJi+xgk5nMLUZimL9L
 cJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700141375; x=1700746175;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JBLsiUFa8822wLgQ0GXVKoj4tTaejWezfznf0aYXmaw=;
 b=HvbfkfZU/vhvD1IHcIxDjS3Xn+fHJUgUISDULSwXBNmHTokOdxI231rYw6Hv+zDTBD
 CD79PJ2P0O50r9o5A8ottWUgIfuxkdtK742XlSMmj46E1B7pyaUZ6aRwEZ5s1BZcXW+8
 ftV9ciqWjmfa2BIhHdgF4A2DnZ4ZeUGe9JP62wR0gU09YBPeysGgzVjyldFr3IHCTWeI
 sWIaQWvg1RnqsB8Gj8QJ99JASIkG+e8m1JIH+sRWa+H5cpTsxgCb4UbPRgFrKjTwE6Ty
 YZzKgY6A4+6h33KO7b4rUTDwdUUie1oj64ufoH7/aPaDZ4WrZzSvk04xSuPcbKHjYAxU
 pr9g==
X-Gm-Message-State: AOJu0Yz3Y5XdhMjpyGKpgeGrIcSc8Q4e07pdtB/Yx6je4zWsK8iONcBJ
 grc4pjJIAD1QBViIQmUFJyxTog==
X-Google-Smtp-Source: AGHT+IEdmQXBW0otl70bWxKvwtsFp7sTkXGwaIp74Zx5p2dvG7kc2/zej5wypSbyai7f1X7aGAtlTA==
X-Received: by 2002:a05:6a00:3016:b0:68b:e29c:b69 with SMTP id
 ay22-20020a056a00301600b0068be29c0b69mr2751933pfb.9.1700141375144; 
 Thu, 16 Nov 2023 05:29:35 -0800 (PST)
Received: from ThinkPad-T490 ([2401:4900:57e3:f37f:7382:f75f:c0ae:4df7])
 by smtp.gmail.com with ESMTPSA id
 y3-20020aa79423000000b006c4d371beeasm4466890pfo.217.2023.11.16.05.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 05:29:34 -0800 (PST)
Message-ID: <e746da595267406ed1cd51778987488eae4c64bf.camel@ventanamicro.com>
Subject: Re: [PATCH v2] drivers: pcie_xilinx: Fix "reg" not found error
From: mchitale@ventanamicro.com
To: Michal Simek <michal.simek@amd.com>, Bo Gan <ganboing@gmail.com>, Puhan
 Zhou <puh4n.zhou@gmail.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Valentin Caron <valentin.caron@foss.st.com>, Shengyu Qu
 <wiagn233@outlook.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Date: Thu, 16 Nov 2023 18:59:27 +0530
In-Reply-To: <fc6ca54c-a609-4a0b-a9eb-1478b9bf3d39@amd.com>
References: <20231111173604.93103-1-mchitale@ventanamicro.com>
 <fc6ca54c-a609-4a0b-a9eb-1478b9bf3d39@amd.com>
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

On Mon, 2023-11-13 at 09:10 +0100, Michal Simek wrote:
> 
> On 11/11/23 18:36, Mayuresh Chitale wrote:
> > Fix the driver to use the dev_read_addr_size API to fetch the reg
> > property from the DT.
> > 
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > ---
> > Changes in v2:
> > ====
> > - Remove global_data.h from include
> > - Use devm_ioremap instead of map_phsymem
> > 
> >   drivers/pci/pcie_xilinx.c | 26 +++++++++-----------------
> >   1 file changed, 9 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
> > index 53fd121e90..c1f5bbbb1b 100644
> > --- a/drivers/pci/pcie_xilinx.c
> > +++ b/drivers/pci/pcie_xilinx.c
> > @@ -8,11 +8,9 @@
> >   #include <common.h>
> >   #include <dm.h>
> >   #include <pci.h>
> > -#include <asm/global_data.h>
> >   #include <linux/bitops.h>
> >   #include <linux/printk.h>
> > -
> > -#include <asm/io.h>
> > +#include <linux/io.h>
> >   
> >   /**
> >    * struct xilinx_pcie - Xilinx PCIe controller state
> > @@ -140,20 +138,14 @@ static int pcie_xilinx_write_config(struct
> > udevice *bus, pci_dev_t bdf,
> >   static int pcie_xilinx_of_to_plat(struct udevice *dev)
> >   {
> >   	struct xilinx_pcie *pcie = dev_get_priv(dev);
> > -	struct fdt_resource reg_res;
> > -	DECLARE_GLOBAL_DATA_PTR;
> > -	int err;
> > -
> > -	err = fdt_get_resource(gd->fdt_blob, dev_of_offset(dev), "reg",
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
> > +	pcie->cfg_base = devm_ioremap(dev, addr, size);
> 
> this can also fail.
> 
> Just put there.
> 	if (IS_ERR(pcie->cfg_base))
> 		return PTR_ERR(pcie->cfg_base);
Ok.
> 
> M

