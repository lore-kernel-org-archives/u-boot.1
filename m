Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B71E67496
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 02:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4652A8389A;
	Sun, 21 Dec 2025 03:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.b="W4PFjD33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C054838A5; Sun, 21 Dec 2025 03:58:37 +0100 (CET)
Received: from mail94.out.titan.email (mail94.out.titan.email [54.235.81.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEB178388D
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 03:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4dYmDn4X1mz7t7y;
 Sun, 21 Dec 2025 02:58:33 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=eDNWGROvrP1NJ4J0goNLYv9zud1Ys9CCwCzs2LzoSf0=; 
 c=relaxed/relaxed; d=ziyao.cc;
 h=message-id:date:to:cc:references:mime-version:in-reply-to:from:subject:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
 q=dns/txt; s=titan1; t=1766285913; v=1;
 b=W4PFjD336S1JA7XhkILX/kkDuT41OwvzIngGVKPdj9hyDE7jzPtYs+tgp/9wt0Yr0P+PyulX
 ZMBQCbWPJat1BKOQBy9ml8nQBsSciIVV9zh4PF5SLfW3S99OAN6dH9ui0oLPE3O/MpXseuk/O9M
 ImeYu+8EsYSWsVNN2AXHkFz4=
Received: from pie (unknown [117.171.66.90])
 by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dYmDk4wyqz7t7T;
 Sun, 21 Dec 2025 02:58:30 +0000 (UTC)
Date: Sun, 21 Dec 2025 02:58:21 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] serial: Add Goldfish TTY driver
Message-ID: <aUdiTV_roNLPUt-y@pie>
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218185252.957388-2-visitorckw@gmail.com>
 <aUTC-8hYsPDVFOly@pie> <aUbOwayeH6nAYmMi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUbOwayeH6nAYmMi@google.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1766285913438108146.30087.7268545309552845212@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=TPG/S0la c=1 sm=1 tr=0 ts=69476259
 a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=Op86XdCbNhy7LfjcVHwA:9 a=CjuIK1q_8ugA:10
 a=3z85VNIBY5UIEeAh_hcH:22 a=NWVoK91CQySWRX1oVYDe:22
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

On Sun, Dec 21, 2025 at 12:28:49AM +0800, Kuan-Wei Chiu wrote:
> Hi Yao,
> 
> On Fri, Dec 19, 2025 at 03:14:03AM +0000, Yao Zi wrote:
> > On Thu, Dec 18, 2025 at 06:52:50PM +0000, Kuan-Wei Chiu wrote:
> > > Add support for the Google Goldfish TTY serial device. This virtual
> > > device is commonly used in QEMU virtual machines (such as the m68k
> > > virt machine) and Android emulators.
> > > 
> > > The driver implements basic console output and input polling using the
> > > Goldfish MMIO interface.
> > > 
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > ---
> > >  MAINTAINERS                      |   6 ++
> > >  drivers/serial/Kconfig           |   8 +++
> > >  drivers/serial/Makefile          |   1 +
> > >  drivers/serial/serial_goldfish.c | 112 +++++++++++++++++++++++++++++++
> > >  include/goldfish_tty.h           |  18 +++++
> > >  5 files changed, 145 insertions(+)
> > >  create mode 100644 drivers/serial/serial_goldfish.c
> > >  create mode 100644 include/goldfish_tty.h

...

> For reference, here is the planned update for v2:
> 
> struct goldfish_tty_priv {
> 	void __iomem *base;
> 	u8 rx_buf;
> };
> 
> static int goldfish_serial_getc(struct udevice *dev)
> {
> 	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> 	unsigned long base = (unsigned long)priv->base;
> 	unsigned long paddr;
> 	u32 count;
> 
> 	count = __raw_readl((void *)(base + GOLDFISH_TTY_BYTES_READY));
> 	if (count == 0)
> 		return -EAGAIN;
> 
> 	paddr = virt_to_phys((void *)&priv->rx_buf);
> 
> 	__raw_writel(0, (void *)(base + GOLDFISH_TTY_DATA_PTR_HIGH));
> 	__raw_writel(paddr, (void *)(base + GOLDFISH_TTY_DATA_PTR));
> 	__raw_writel(1, (void *)(base + GOLDFISH_TTY_DATA_LEN));
> 
> 	__raw_writel(CMD_READ_BUFFER, (void *)(base + GOLDFISH_TTY_CMD));
> 
> 	return priv->rx_buf;
> }

Thanks for the explanation, this version looks fine to me.

> Regards,
> Kuan-Wei

Regards,
Yao Zi

> > > +}
> > 
> > Best regards,
> > Yao Zi
> > 
> > [1]: https://lore.kernel.org/u-boot/20251212142859.GQ303283@bill-the-cat
