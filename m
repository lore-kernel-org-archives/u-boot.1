Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55185C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 13:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C2B986F5E;
	Sat, 11 Nov 2023 14:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Yo1p66FW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBD6586F5E; Sat, 11 Nov 2023 14:23:59 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A0786903
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 14:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7a956887c20so111601139f.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 05:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699709036; x=1700313836; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kguLRuNubVJfD3zeqi0ipcdwuZwQTPjwGoeo76/3cn8=;
 b=Yo1p66FW+BCELEZXnKEeNOaJooJWclqnxEeIyARBEvJVV3mDeDjsLSh+dHof372Kt2
 CUCLc5MQVX0EIsPpxVOySVQT3SrID+aKkWJt/jOgBKRhukgLkkmyJDuCbh3/9pSvEbNF
 udhztPabj853PuSJuP55PGXnBl/wl/QUyEsSb7IxSfIqq68ieJTDE81cZdc7juSchlxv
 cMTETmdozN0GA57IuxTTJj/0rb27jQgtLwSvdGC69mdZBWO9DFzLHe0MUfoUOswkbL9G
 HppzXiK2rb3uC48mBuUoURnKomWmYZH/dudGefgjTl+lSo3hn1VsLBsMn2nw3eShX0eh
 Y7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699709036; x=1700313836;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kguLRuNubVJfD3zeqi0ipcdwuZwQTPjwGoeo76/3cn8=;
 b=hxMTAAMtb2Lw06JLrman59tcM7TV0a7t7XLMaMw+NRu375Mfm5gaeikWMm5yCcJ0jq
 Qejzwdpy3oi5PLHy85xB0yqYU6yzEHW5RDD8rXw6BNexrQbxK5OEDWgwOX7bdGf0cCCe
 co2NGf/0S6VL/mg3qrUMa4SIFcHAAKzvZrfItpJVTW0DY1NrpGokMs39sBWLwaOl0G0o
 l5WkD9JfjDsjOSvYGnmSnAF1i3pHtUY8AGrIZWDh4mBS5tFr0O+7f9icxw3D/Q66cFBH
 NPYryB0dxkR2+ePN5+rucKRoa9KfRKN+XEbhNd3jmfO/qUXyA/hSx1Zke4eUm9xgDmvE
 lCtw==
X-Gm-Message-State: AOJu0YzyVSi51YatRgTad6a4XkiAFYJXHRANkls3Hbt3Fom1Mf7mNLEr
 VPXZvPA45u323Q67pUzHg0pIlA==
X-Google-Smtp-Source: AGHT+IES8USpCdPfU8naAS0Co6DcMaD45lhLo95GjN1T2ttF5aM/1Kh9xlPCcmD39UzxyuFKvStlmA==
X-Received: by 2002:a5d:928d:0:b0:7a9:77ac:5455 with SMTP id
 s13-20020a5d928d000000b007a977ac5455mr2407254iom.9.1699709036465; 
 Sat, 11 Nov 2023 05:23:56 -0800 (PST)
Received: from ?IPv6:2401:4900:5306:7350:68e5:c904:2404:b568?
 ([2401:4900:5306:7350:68e5:c904:2404:b568])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a056638348b00b0042b37dda71asm431917jal.136.2023.11.11.05.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 05:23:56 -0800 (PST)
Message-ID: <2303998bd7d8293906afa297f0a60e829f27e67c.camel@ventanamicro.com>
Subject: Re: [PATCH] net: axi_emac: Use reg property for DMA registers
From: mchitale@ventanamicro.com
To: Michal Simek <michal.simek@amd.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Date: Sat, 11 Nov 2023 18:53:48 +0530
In-Reply-To: <b13846bc-10ef-4d40-9444-7ab05a3c8645@amd.com>
References: <20231102082303.354944-1-mchitale@ventanamicro.com>
 <20231102082303.354944-3-mchitale@ventanamicro.com>
 <b13846bc-10ef-4d40-9444-7ab05a3c8645@amd.com>
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

On Thu, 2023-11-02 at 10:15 +0100, Michal Simek wrote:
> 
> On 11/2/23 09:23, Mayuresh Chitale wrote:
> > As per the xlnx,axi-ethernet-1.00.a DT documentation in linux, the
> > AXI
> > DMA registers can be obtained via the reg property or via a
> > separate
> > node for the axistream DMA controller. Currently only the latter is
> > supported, so add support to fetch the DMA controller registers
> > from the
> > "reg" property.
> > 
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > ---
> >   drivers/net/xilinx_axi_emac.c | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/xilinx_axi_emac.c
> > b/drivers/net/xilinx_axi_emac.c
> > index 54f2232768..ef151ee51b 100644
> > --- a/drivers/net/xilinx_axi_emac.c
> > +++ b/drivers/net/xilinx_axi_emac.c
> > @@ -903,12 +903,11 @@ static int axi_emac_of_to_plat(struct udevice
> > *dev)
> >   
> >   	ret = dev_read_phandle_with_args(dev, "axistream-connected",
> > NULL, 0, 0,
> >   					 &axistream_node);
> > -	if (ret) {
> > -		printf("%s: axistream is not found\n", __func__);
> > -		return -EINVAL;
> > -	}
> > +	if (!ret)
> > +		plat->dmatx = (struct axidma_reg
> > *)ofnode_get_addr(axistream_node.node);
> > +	else
> > +		plat->dmatx = (struct axidma_reg
> > *)dev_read_addr_index(dev, 1);
> >   
> > -	plat->dmatx = (struct axidma_reg
> > *)ofnode_get_addr(axistream_node.node);
> >   	if (!plat->dmatx) {
> >   		printf("%s: axi_dma register space not found\n",
> > __func__);
> >   		return -EINVAL;
> 
> This looks good to me. Can you please send it separately?
> It is really independent of change from other patches.
Actually it is a separate patch.
> 
> Reviewed-by: Michal Simek <michal.simek@amd.com>
> 
> Thanks,
> Michal

