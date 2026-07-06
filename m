Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AE3C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 15:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C2AA846FD;
	Mon,  6 Jul 2026 17:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="D+yxYdDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40CC484852; Mon,  6 Jul 2026 17:14:15 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE64846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 17:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6401f59d0=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1783350852; x=1814886852;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PvPR4CCs/LZnVyZgW84z2kHWJNrcC6nBezUG4YLm7rY=;
 b=D+yxYdDMmQSJfjFSr/CdVU7U13xdNYdAoR4z1Wep5flJmtXPfJLaV7rY
 h6AjY3KY0J0dClGZiebpoMzwbmTJKmWlNaU15iBlV/ylu/2jl9/F4M8Hd
 bj3oeIIetK8TF4ggqw4APg2xlTfB2QI272yhib7tiMOecBLa6KBcKCdch
 x8RjtFW1GWZOWqJ1hSfKgTxY99XK+vGh3dgPLigQLMFK4B3XEH4xvOcEm
 SzMdDYa/wLThNv2sDu1/DjTJCk1v8nwARFD2ksghOeC0z0fi5VtFm3vjP
 Wj6yYyOs5RIFNMplyCnxEh9cjyfvxir3wXM7s1ZgLjLhu6fLUMahG0ayK w==;
X-CSE-ConnectionGUID: tQehHEevTjCYSqFd4wkjXQ==
X-CSE-MsgGUID: 0wP/TEi0RSWfcJxLCdMQKQ==
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="69449334"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Jul 2026 08:14:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 6 Jul 2026 08:14:09 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Mon, 6 Jul 2026 08:14:08 -0700
Date: Mon, 6 Jul 2026 08:14:07 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Yao Zi <me@ziyao.cc>
CC: Charles Perry <charles.perry@microchip.com>, <u-boot@lists.denx.de>,
 "Rahul Pathak" <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Tom
 Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Kory Maincent
 <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu
 <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, "Quentin
 Schulz" <quentin.schulz@cherry.de>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Michal Simek <michal.simek@amd.com>, "Michael
 Trimarchi" <michael@amarulasolutions.com>, Peter Korsgaard
 <peter@korsgaard.com>
Subject: Re: [PATCH 4/7] drivers: clk: add support for RPMI clocks
Message-ID: <akvGPxW+sXp65enw@bby-cbu-swbuild03.eng.microchip.com>
References: <20260626201613.1035208-1-charles.perry@microchip.com>
 <20260626201613.1035208-5-charles.perry@microchip.com>
 <aj8rpdOireFjteeA@pie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aj8rpdOireFjteeA@pie>
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

On Sat, Jun 27, 2026 at 01:47:17AM +0000, Yao Zi wrote:
> On Fri, Jun 26, 2026 at 01:15:45PM -0700, Charles Perry wrote:
> > The RISC-V Platform Management Interface (RPMI) defines a service group
> > for control and monitoring of clocks [1]. This can be exposed as a
> > UCLASS_CLK driver.
> > 
> > [1]: https://github.com/riscv-non-isa/riscv-rpmi (chapter 4.8)
> > 
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > ---
> >  MAINTAINERS            |   1 +
> >  drivers/clk/Kconfig    |   7 +
> >  drivers/clk/Makefile   |   1 +
> >  drivers/clk/clk_rpmi.c | 346 +++++++++++++++++++++++++++++++++++++++++
> >  include/rpmi_proto.h   |  39 +++++
> >  5 files changed, 394 insertions(+)
> >  create mode 100644 drivers/clk/clk_rpmi.c
> 
> ...
> 
> > diff --git a/drivers/clk/clk_rpmi.c b/drivers/clk/clk_rpmi.c
> > new file mode 100644
> > index 000000000000..d2efb057600b
> > --- /dev/null
> > +++ b/drivers/clk/clk_rpmi.c
> > @@ -0,0 +1,346 @@
> 
> ...
> 
> > +struct rpmi_clk_def {
> > +	u32 num_rates;
> > +	u32 transition_latency;
> 
> rpmi_clk_def.transition_latency only gets assigned in
> rpmi_clk_get_attrs() and never used. Since U-Boot's clock infrastructure
> doesn't care about it at all, maybe we could drop the field?

Ack.

> 
> > +	enum rpmi_clock_type type;
> > +	char name[RPMI_CLK_NAME_LEN + 1];
> > +};
> 
> ...
> 
> > +static int _rpmi_clk_enable_disable(struct rpmi_clk_priv *priv, u32 clkid,
> > +				    bool ena)
> > +{
> > +	struct rpmi_set_config_tx tx = {
> > +		.clkid = cpu_to_le32(clkid),
> > +		.config = cpu_to_le32(ena ? RPMI_CLK_STATE_ENABLED :
> > +					    RPMI_CLK_STATE_DISABLED),
> > +	};
> > +	__le32 rx;
> > +	int ret, status;
> > +
> > +	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_SET_CONFIG, &tx,
> > +				  sizeof(tx), &rx, sizeof(rx), NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	status = le32_to_cpu(rx);
> > +	if (status)
> > +		return rpmi_to_linux_error(status);
> > +
> > +	return 0;
> 
> Please return rpmi_to_linux_error(status) and drop the if above.

Ack.

> 
> > +}
> > +
> > +static ulong _rpmi_clk_get_rate(struct rpmi_clk_priv *priv, u32 clkid)
> > +{
> > +	__le32 tx = cpu_to_le32(clkid);
> > +	struct rpmi_get_rate_rx rx;
> > +	int ret, status;
> > +
> > +	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_GET_RATE, &tx,
> > +				  sizeof(tx), &rx, sizeof(rx), NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	status = le32_to_cpu(rx.status);
> > +	if (status)
> > +		return rpmi_to_linux_error(status);
> > +
> > +	return (((u64)(le32_to_cpu(rx.hi)) << 32) | (u32)(le32_to_cpu(rx.lo)));
> > +}
> 
> ...
> 
> > +static int _rpmi_clk_set_rate(struct rpmi_clk_priv *priv, u32 clkid,
> > +			      unsigned long rate)
> 
> This function is declared to return int, but...
> 
> > +{
> > +	struct rpmi_set_rate_tx tx = {
> > +		.clkid = cpu_to_le32(clkid),
> > +		.flags = 0,
> > +		.lo = cpu_to_le32(lower_32_bits(rate)),
> > +		.hi = cpu_to_le32(upper_32_bits(rate)),
> > +	};
> > +	__le32 rx;
> > +	int ret, status;
> > +
> > +	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_SET_RATE, &tx,
> > +				  sizeof(tx), &rx, sizeof(rx), NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	status = le32_to_cpu(rx);
> > +	if (status)
> > +		return rpmi_to_linux_error(status);
> > +
> > +	return _rpmi_clk_get_rate(priv, clkid);
> 
> _rpmi_clk_get_rate() returns ulong. This unnecessarily truncates the
> rate on 64bit platform when it's above approximately 2.1GHz.

Good catch.

I'll keep the return code as int here and put the call to
_rpmi_clk_get_rate() inside rpmi_clk_set_rate() instead.

Thanks,
Charles
