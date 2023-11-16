Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D85C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 13:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B3C6874AF;
	Thu, 16 Nov 2023 14:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="m/xMOwQH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3006586F73; Thu, 16 Nov 2023 14:17:54 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E88338746A
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 14:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5bd099e3d3cso569832a12.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700140666; x=1700745466; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AzqQlkS6maNyncHvflY72W9rtJu1IvAcPucij3bgjFk=;
 b=m/xMOwQHLMevWkNtR1k/v1oQt9tK4+XAeSOIpNnn6ED8NUX87+dFg1DhQAWTqNYJYO
 MNgng45B5wuK3SQ3z5glTgU9xpp0YjJOyE7gn7qQ6YQCNmp1CKM/bTq0iKNLkwe9O+WG
 rikGbQzmdnfCkFBQvpvbPeQC6groV/PuVVaxvpCH6uWQm/rr6XR0IVM4dxyR8fHS6ayX
 MkZRx7I9U2patGRvRJrUMfSwPnYYHkRjx2U4m/QEn4qD8n6c/IEusSie+UCE5w9l+c7b
 Hi+F9NmlN2tiRUBp2Q9kPFiL67MbOqnTLCF378Q996c6PwO/Vh0tkH7AeRQ3zLtG1N1k
 pg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700140666; x=1700745466;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AzqQlkS6maNyncHvflY72W9rtJu1IvAcPucij3bgjFk=;
 b=MqNn4M3R7xBJtCIcJkP49dwOFe/C4KLhj0GrRWkXgAtKAS7vfwY1up9/Mx+b/tAaVA
 I7VEL3KVQw6k8UtY0EObqLYkenI49M9nNHMi84R88SKlmzzbOe91N8QGqD0GQzjbBp2h
 YIXN6n4HSV9klzy9+F3l35aYfl4lPOjTRosk84Ca4HBFMguGZTFfSp9QIeGmSsUzzeA7
 kwtQJK32N4J/DY+VkvsvhYfGbZ/zaWx6kC796vFu287zZp4MMYMkFFiIRjLhx/T9L1D4
 kdv6eNqVu3uKVavryUdnfrA6Azh4tIBLz1oEil5K/pVu+CKsHWJEC/Hxhodb0RwTer/g
 EIxQ==
X-Gm-Message-State: AOJu0YziKHlR9CRsC0wb7gxR180Fby6PcleJxia1mPfgSiZeVhNwztuT
 8+w9CmAHm3GRDwULrsJyJnXYng==
X-Google-Smtp-Source: AGHT+IHdahgd83jl2hkipqBUnI5TR9aQ1zyzLES7WIbzQalVAblruwHJY5ZEpftDr4iOZUUSAd3DRw==
X-Received: by 2002:a17:90b:3506:b0:27d:306d:71c9 with SMTP id
 ls6-20020a17090b350600b0027d306d71c9mr10613249pjb.49.1700140666125; 
 Thu, 16 Nov 2023 05:17:46 -0800 (PST)
Received: from ThinkPad-T490 ([2401:4900:57e3:f37f:7382:f75f:c0ae:4df7])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a17090ae98f00b0026f39c90111sm1527496pjy.20.2023.11.16.05.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 05:17:45 -0800 (PST)
Message-ID: <01a7967a2ad7c06c9658e5d7aa6fee20cf23d155.camel@ventanamicro.com>
Subject: Re: [PATCH v1 3/3] drivers: xilinx_spi: Probe fifo_depth at runtime
From: mchitale@ventanamicro.com
To: Michal Simek <michal.simek@amd.com>, Jagan Teki
 <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Date: Thu, 16 Nov 2023 18:47:40 +0530
In-Reply-To: <4594325a-f240-4a6f-927f-6aec53cfa830@amd.com>
References: <20231111173121.92889-1-mchitale@ventanamicro.com>
 <20231111173121.92889-4-mchitale@ventanamicro.com>
 <4594325a-f240-4a6f-927f-6aec53cfa830@amd.com>
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

On Mon, 2023-11-13 at 10:06 +0100, Michal Simek wrote:
> 
> On 11/11/23 18:31, Mayuresh Chitale wrote:
> > If the fifo-size DT parameter is not provided then probe the
> > controller's fifo depth at runtime. This is ported from a patch
> > in the Linux Xilinx SPI driver.
> > 
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > Link: 
> > https://lore.kernel.org/r/1422029330-10971-5-git-send-email-ricardo.ribalda@gmail.com
> > ---
> >   drivers/spi/xilinx_spi.c | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> > 
> > diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
> > index b63cda2091..99ae5be291 100644
> > --- a/drivers/spi/xilinx_spi.c
> > +++ b/drivers/spi/xilinx_spi.c
> > @@ -109,6 +109,27 @@ struct xilinx_spi_priv {
> >   	u8 startup;
> >   };
> >   
> > +static int xilinx_spi_find_buffer_size(struct xilinx_spi_regs
> > *regs)
> > +{
> > +	u8 sr;
> > +	int n_words = 0;
> > +
> > +	/*
> > +	 * Before the buffer_size detection we reset the core
> > +	 * to make sure we start with a clean state.
> 
> nit: can you please remove "we" above? It should be written in
> imperative mood.
Ok.
> 
> 
> > +	 */
> > +	writel(SPISSR_RESET_VALUE, &regs->srr);
> > +
> > +	/* Fill the Tx FIFO with as many words as possible */
> > +	do {
> > +		writel(0, &regs->spidtr);
> > +		sr = readl(&regs->spisr);
> > +		n_words++;
> > +	} while (!(sr & SPISR_TX_FULL));
> > +
> > +	return n_words;
> > +}
> > +
> >   static int xilinx_spi_probe(struct udevice *bus)
> >   {
> >   	struct xilinx_spi_priv *priv = dev_get_priv(bus);
> > @@ -116,6 +137,8 @@ static int xilinx_spi_probe(struct udevice
> > *bus)
> >   
> >   	regs = priv->regs = dev_read_addr_ptr(bus);
> >   	priv->fifo_depth = dev_read_u32_default(bus, "fifo-size", 0);
> > +	if (!priv->fifo_depth)
> > +		priv->fifo_depth = xilinx_spi_find_buffer_size(regs);
> >   
> >   	writel(SPISSR_RESET_VALUE, &regs->srr);
> >   
> 
> When above fixed feel free to add
> Reviewed-by: Michal Simek <michal.simek@amd.com>
Ok.
> 
> Thanks,
> Michal

