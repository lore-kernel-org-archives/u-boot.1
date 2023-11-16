Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59773C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 13:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBF4887496;
	Thu, 16 Nov 2023 14:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KVWZsk3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B426287465; Thu, 16 Nov 2023 14:23:20 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C0A86F73
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 14:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ce28faa92dso7161245ad.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700140994; x=1700745794; darn=lists.denx.de;
 h=content-transfer-encoding:user-agent:date:mime-version:references
 :in-reply-to:cc:to:subject:message-id:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=027cwAU2J6J+9xN1jMkzcCJOrANNfM9SMLSSQ0t97yA=;
 b=KVWZsk3jZ3NaT2vSyUxg/AS9IAEzzjsN8b6to2jSqnJ5vF6F6+sfuaKR9t47OVE5tk
 tEPEgMihKHNOCwqa1T0XiMv1VuIo96AsIKK4nu715FkjvnRaLkqedFRsmVRERy4iqxBF
 MQa32W2TjhaXi2SW+hMMh3t/8QAHV+e2TtfMCy2LJQCt9u94u5WzT/rg1wf5Z1IxJmYd
 pfFbbRmbJ7FuGW24/BS0IeW4ua4KBgQEBAPnAi3tDdbm777QI5xx2WNJwoDkhyHy7SKv
 0ZEAT6qnPCt7HX6szd42qNsr5osmeNaQx/wtX5JZrcxPXY4imEPCdbBs+Z3yfkLuvkjW
 irFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700140994; x=1700745794;
 h=content-transfer-encoding:user-agent:date:mime-version:references
 :in-reply-to:cc:to:subject:message-id:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=027cwAU2J6J+9xN1jMkzcCJOrANNfM9SMLSSQ0t97yA=;
 b=e06y5NWPq+bzcFE7yP/MjfUrIMzSe6xwdQ+itRRR+l2v4BOcCvMkd+lrSqkM/6ZpNB
 7ltrelK+GV4zkWpq2HSMr7tqUk079IjfgdtnQeObAAPlgx8WvMB9Jr2YNFUb2aoMraMl
 /Cw+ALu3tinrH7rBNLEvYkVD4uca8PjuLaEeXuI3Yr/aiAIn84f0Q7hadk7HUiXJz9II
 zMS8tm7g/AM+/oZzMAKPWpejuMMO8fCh44bfiTPoYI3AjkPP3GlSTd+MFzgEyzJDZXT8
 FIGxs28/z2AKq8tssSh+HGaQOjZg5NYHVP562R6ShA+PWsIX7bfhqOLi+VvErN5UB9AU
 sHqg==
X-Gm-Message-State: AOJu0YwmzS5ERGMNN8FHf9nc6ROhM22Oxnwb493EYWkanLuQrnE5m6S7
 YNwR/AJfmR2YsZpAoHkN4bo=
X-Google-Smtp-Source: AGHT+IEqYEVcxV/lM5Nom8tIj7dU3tR+aZBb79kL/7amGcNOSy9kBCOGc1OoaK63+sgDseUwhPC1JA==
X-Received: by 2002:a17:902:db85:b0:1cc:476c:896c with SMTP id
 m5-20020a170902db8500b001cc476c896cmr7855231pld.60.1700140994091; 
 Thu, 16 Nov 2023 05:23:14 -0800 (PST)
Received: from ThinkPad-T490 ([2401:4900:57e3:f37f:7382:f75f:c0ae:4df7])
 by smtp.gmail.com with ESMTPSA id
 iy6-20020a170903130600b001b016313b1dsm9207139plb.86.2023.11.16.05.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 05:23:13 -0800 (PST)
From: mchitale@gmail.com
X-Google-Original-From: mchitale@ventanamicro.com
Message-ID: <f452b3c8a37d8028bbd2b4272b386986fd28d0dd.camel@ventanamicro.com>
Subject: Re: [PATCH v2] net: axi_emac: Use reg property for DMA registers
To: Michal Simek <michal.simek@amd.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
In-Reply-To: <44fc3e3d-a2b6-4e71-8c95-d50ca7c45bcc@amd.com>
References: <20231111173604.93103-1-mchitale@ventanamicro.com>
 <20231111173604.93103-2-mchitale@ventanamicro.com>
 <44fc3e3d-a2b6-4e71-8c95-d50ca7c45bcc@amd.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date: Thu, 16 Nov 2023 18:52:03 +0530
User-Agent: Evolution 3.36.5-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 16 Nov 2023 14:23:51 +0100
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
On Mon, 2023-11-13 at 10:10 +0100, Michal Simek wrote:
> 
> On 11/11/23 18:36, Mayuresh Chitale wrote:
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
> > Reviewed-by: Michal Simek <michal.simek@amd.com>
> > ---
> > Changes in v2:
> > ====
> > Add Reviewed-by Tag.
> > 
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
> This is the part of pcie series but it has nothing to do with it. Can
> you please 
> send it separately?
Yes, actually I intended to send this patch as well as the PCIe patches
as individual patches but the way I invoked send-email caused those to
become a series.
> 
> M

