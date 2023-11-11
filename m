Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2EBC4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 13:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B36FF86EC9;
	Sat, 11 Nov 2023 14:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Sd9ztOpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 924B986F20; Sat, 11 Nov 2023 14:21:29 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 136C686903
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 14:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7afff3ea94dso71633739f.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 05:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699708885; x=1700313685; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gLMTK5BlNKDhR5J/P39h4pdXKUWriX1oEbDedU+xwvY=;
 b=Sd9ztOpQnFEagkS/1hSLdLHrmUUG8r9Xb9zj63nLPJ3CIEN3CGGa0Ym3zeykOtQYv7
 xbMHSjbRcbIxwxlhzqtgAv7mJrkswFvUjHMd3sPCoSiPK4T41bII3c16K5Abp/scuLKg
 g4W3UAPSXbtfkOEQfly6FuhGRAh097TfV5/r0MJgfflAuEy0/0FzSrr3zbCBMAGphowo
 FhZxzy+PPLN/qVD8TIRDgfhoeqKH4L2DDdFSWVm2qnvSfLAezoaPYLykqxbiEeIBma1M
 3BbAY8PsfU6txDThhrMEpG0cl8PglhUm6762vJGG3+N0yv18qJCkbbfZuY0fYFQpFHmy
 fA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699708885; x=1700313685;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gLMTK5BlNKDhR5J/P39h4pdXKUWriX1oEbDedU+xwvY=;
 b=oRKgmcVw2J3MTJxW0u4LksuWboqWrSihyiUVC7j+k6Wnvwb24jgjTTS6zOHSEAftBC
 bOuC52PJAdMle8wAkCxv3ibjVEm5R4jb24n/Jp0a0GBD4m904s85Y99GugYvCxUHhQWa
 lL8Ao9rv83VxCi2vfb6/XaD4s4KZx8YR5upmvW+QDbKLjUgZ2vXSmEbI6D53xb2nZ2Vo
 HDKi1GW43FQB2oybvaRVW8AuYLlxb/HFT1jLZOYBfDqel+mIDvHEsWWz/C3tzj+L4agB
 ERds2957/G+ZN9HnkVD/+WKAFjZikVl/nzEkKQXo6jIY4pl7BoMEPUmjJ0qoxx3Ha/Yv
 oymA==
X-Gm-Message-State: AOJu0YzkQMUx2y9EVenfXHlVpBSGNEAQdrYKIjd+bukxRsI1N9Xlqjvd
 gxsNDoCrVZ/qUdw2NU3Q4fqbxA==
X-Google-Smtp-Source: AGHT+IGsK/mCsy0zErUqmpnFlncMiGvg0UBuvF898DwNdFUG/0r3ZkyedBZ2gZ2WgnYIURoiNgTZ8A==
X-Received: by 2002:a05:6602:281e:b0:7ab:4faa:cb3 with SMTP id
 d30-20020a056602281e00b007ab4faa0cb3mr2367720ioe.16.1699708885500; 
 Sat, 11 Nov 2023 05:21:25 -0800 (PST)
Received: from ?IPv6:2401:4900:5306:7350:68e5:c904:2404:b568?
 ([2401:4900:5306:7350:68e5:c904:2404:b568])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a056638380d00b00459d7c3dcf3sm436376jav.115.2023.11.11.05.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 05:21:25 -0800 (PST)
Message-ID: <66a35cae0fb8b69717e888f8849010310f33cf32.camel@ventanamicro.com>
Subject: Re: [PATCH] drivers: xilinx_spi: Fixes for MMC_SPI
From: mchitale@ventanamicro.com
To: Michal Simek <michal.simek@amd.com>, Jagan Teki
 <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Date: Sat, 11 Nov 2023 18:51:15 +0530
In-Reply-To: <4c31c367-8506-40d6-8060-0776807d461a@amd.com>
References: <20231102082303.354944-1-mchitale@ventanamicro.com>
 <20231102082303.354944-2-mchitale@ventanamicro.com>
 <4c31c367-8506-40d6-8060-0776807d461a@amd.com>
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

On Thu, 2023-11-02 at 09:37 +0100, Michal Simek wrote:
> On 11/2/23 09:23, Mayuresh Chitale wrote:
> > Add the xfer callback which is used by the MMC_SPI driver and
> > generally by
> > the dm_spi_xfer callback. Also probe the fifo_depth during init as
> > is
> > done in the linux spi-xilinx driver and fix a compiler warning
> > while at it.
> 
> They are independent things that's why please separate them by that
> topics.
> 
> Also update subject to describe issue there.
Ok.
> 
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > ---
> >   drivers/spi/xilinx_spi.c | 70 ++++++++++++++++++++++++++++++-----
> > -----
> >   1 file changed, 53 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
> > index b58a3f632a..0d4ff25600 100644
> > --- a/drivers/spi/xilinx_spi.c
> > +++ b/drivers/spi/xilinx_spi.c
> > @@ -67,7 +67,7 @@
> >   /* SPI Slave Select Register (spissr), [1] p13, [2] p13 */
> >   #define SPISSR_MASK(cs)		(1 << (cs))
> >   #define SPISSR_ACT(cs)		~SPISSR_MASK(cs)
> > -#define SPISSR_OFF		~0UL
> > +#define SPISSR_OFF		(~0U)
> >   
> >   /* SPI Software Reset Register (ssr) */
> >   #define SPISSR_RESET_VALUE	0x0a
> > @@ -109,6 +109,27 @@ struct xilinx_spi_priv {
> >   	u8 startup;
> >   };
> >   
> > +/* Detect fifo depth. Ported from linux sha: 4c9a761402d78 */
> 
> don't add linux sha1 here.
> Add it to commit message or I normally just provide a link to that
> patch.
> https://lore.kernel.org/r/1422029330-10971-5-git-send-email-ricardo.ribalda@gmail.com
Ok.
> 
> 
> 
> > +static int xilinx_spi_find_buffer_size(struct xilinx_spi_regs
> > *regs)
> > +{
> > +	u8 sr;
> > +	int n_words = 0;
> > +
> > +	/*
> > +	 * Before the buffer_size detection we reset the core
> > +	 * to make sure we start with a clean state.
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
> 
> newline here.
Ok.
> 
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
> > @@ -197,7 +220,7 @@ static u32 xilinx_spi_fill_txfifo(struct
> > udevice *bus, const u8 *txp,
> >   	return i;
> >   }
> >   
> > -static u32 xilinx_spi_read_rxfifo(struct udevice *bus, u8 *rxp,
> > u32 rxbytes)
> > +static u32 xilinx_spi_read_rxfifo(struct udevice *bus, u8 *rxp,
> > int rxbytes)
> 
> Unrelated. Or do we have a case where we ask for reading negative
> number of bytes?
I will revert the change.
> 
> >   {
> >   	struct xilinx_spi_priv *priv = dev_get_priv(bus);
> >   	struct xilinx_spi_regs *regs = priv->regs;
> > @@ -217,9 +240,9 @@ static u32 xilinx_spi_read_rxfifo(struct
> > udevice *bus, u8 *rxp, u32 rxbytes)
> >   	return i;
> >   }
> >   
> > -static int start_transfer(struct spi_slave *spi, const void *dout,
> > void *din, u32 len)
> > +static int start_transfer(struct udevice *dev, const void *dout,
> > void *din, u32 len)
> 
> All these spi -> dev changes should be in separate patch. I expect
> they are 
> preparation for xfer but still better to do it separately.
Ok.
> 
> >   {
> > -	struct udevice *bus = spi->dev->parent;
> > +	struct udevice *bus = dev->parent;
> >   	struct xilinx_spi_priv *priv = dev_get_priv(bus);
> >   	struct xilinx_spi_regs *regs = priv->regs;
> >   	u32 count, txbytes, rxbytes;
> > @@ -259,10 +282,9 @@ static int start_transfer(struct spi_slave
> > *spi, const void *dout, void *din, u3
> >   	return 0;
> >   }
> >   
> > -static void xilinx_spi_startup_block(struct spi_slave *spi)
> > +static void xilinx_spi_startup_block(struct udevice *dev)
> >   {
> > -	struct dm_spi_slave_plat *slave_plat =
> > -				dev_get_parent_plat(spi->dev);
> > +	struct dm_spi_slave_plat *slave_plat =
> > dev_get_parent_plat(dev);
> >   	unsigned char txp;
> >   	unsigned char rxp[8];
> >   
> > @@ -270,13 +292,25 @@ static void xilinx_spi_startup_block(struct
> > spi_slave *spi)
> >   	 * Perform a dummy read as a work around for
> >   	 * the startup block issue.
> >   	 */
> > -	spi_cs_activate(spi->dev, slave_plat->cs);
> > +	spi_cs_activate(dev, slave_plat->cs);
> >   	txp = 0x9f;
> > -	start_transfer(spi, (void *)&txp, NULL, 1);
> > +	start_transfer(dev, (void *)&txp, NULL, 1);
> >   
> > -	start_transfer(spi, NULL, (void *)rxp, 6);
> > +	start_transfer(dev, NULL, (void *)rxp, 6);
> >   
> > -	spi_cs_deactivate(spi->dev);
> > +	spi_cs_deactivate(dev);
> > +}
> > +
> > +static int xilinx_spi_xfer(struct udevice *dev, unsigned int
> > bitlen,
> > +			   const void *dout, void *din, unsigned long
> > flags)
> > +{
> > +	struct dm_spi_slave_plat *slave_plat =
> > dev_get_parent_plat(dev);
> > +	int ret;
> > +
> > +	spi_cs_activate(dev, slave_plat->cs);
> > +	ret = start_transfer(dev, dout, din, (bitlen / 8));
> 
> no need for () around
Ok.
> 
> > +	spi_cs_deactivate(dev);
> > +	return ret;
> >   }
> >   
> >   static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
> > @@ -294,14 +328,15 @@ static int xilinx_spi_mem_exec_op(struct
> > spi_slave *spi,
> >   	 * as QSPI provides command. So first command fails.
> >   	 */
> >   	if (!startup) {
> > -		xilinx_spi_startup_block(spi);
> > +		xilinx_spi_startup_block(spi->dev);
> >   		startup++;
> >   	}
> >   
> >   	spi_cs_activate(spi->dev, slave_plat->cs);
> >   
> >   	if (op->cmd.opcode) {
> > -		ret = start_transfer(spi, (void *)&op->cmd.opcode,
> > NULL, 1);
> > +		ret = start_transfer(spi->dev, (void *)&op->cmd.opcode,
> > +				     NULL, 1);
> >   		if (ret)
> >   			goto done;
> >   	}
> > @@ -313,7 +348,7 @@ static int xilinx_spi_mem_exec_op(struct
> > spi_slave *spi,
> >   			addr_buf[i] = op->addr.val >>
> >   			(8 * (op->addr.nbytes - i - 1));
> >   
> > -		ret = start_transfer(spi, (void *)addr_buf, NULL,
> > +		ret = start_transfer(spi->dev, (void *)addr_buf, NULL,
> >   				     op->addr.nbytes);
> >   		if (ret)
> >   			goto done;
> > @@ -322,16 +357,16 @@ static int xilinx_spi_mem_exec_op(struct
> > spi_slave *spi,
> >   		dummy_len = (op->dummy.nbytes * op->data.buswidth) /
> >   			     op->dummy.buswidth;
> >   
> > -		ret = start_transfer(spi, NULL, NULL, dummy_len);
> > +		ret = start_transfer(spi->dev, NULL, NULL, dummy_len);
> >   		if (ret)
> >   			goto done;
> >   	}
> >   	if (op->data.nbytes) {
> >   		if (op->data.dir == SPI_MEM_DATA_IN) {
> > -			ret = start_transfer(spi, NULL,
> > +			ret = start_transfer(spi->dev, NULL,
> >   					     op->data.buf.in, op-
> > >data.nbytes);
> >   		} else {
> > -			ret = start_transfer(spi, op->data.buf.out,
> > +			ret = start_transfer(spi->dev, op-
> > >data.buf.out,
> >   					     NULL, op->data.nbytes);
> >   		}
> >   		if (ret)
> > @@ -427,6 +462,7 @@ static const struct spi_controller_mem_ops
> > xilinx_spi_mem_ops = {
> >   static const struct dm_spi_ops xilinx_spi_ops = {
> >   	.claim_bus	= xilinx_spi_claim_bus,
> >   	.release_bus	= xilinx_spi_release_bus,
> > +	.xfer           = xilinx_spi_xfer,
> >   	.set_speed	= xilinx_spi_set_speed,
> >   	.set_mode	= xilinx_spi_set_mode,
> >   	.mem_ops	= &xilinx_spi_mem_ops,
> 
> M

