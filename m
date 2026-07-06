Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08384C44501
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 15:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4D34846FD;
	Mon,  6 Jul 2026 17:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="ddg5/3pn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D66C8846FD; Mon,  6 Jul 2026 17:04:39 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14FAF846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 17:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6401f59d0=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1783350279; x=1814886279;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NpGfVAfpX6JZuytFQxiP0CjGX8W50AfTeJLahiKLZnI=;
 b=ddg5/3pnrtI8p9gI+0Eq+eSVxZ1Rb3aa+uSdpOEPZWSlhFQdCBbCqJOp
 joYFMHsk2eBctrliy6mXN0Kv9jacESlwAtFChIqD79y2qGFyj935/BOAo
 RSkXP+ea2ip4iOfHE9aSQH/Ig5zj4bAC+/PtPJwYnAB8apk6aTmsLTrjK
 XGjBLKQH/zMCQ/DFaYqGTlhCF77iU7NeKkbg186skdC+8TJTnZLvgJfXO
 nHHwtXOHjledFmgZ0W1AFMEZAY+cocp73O6+hVYvc+sEESZFlCIQEtEyy
 Ms4glYYJZmsuArwSFfS547N/gSiaAQoGju8jf1+hWuKQBMRTjAbKmVpLU g==;
X-CSE-ConnectionGUID: faTA9OAGQxWOddtGMYFcxQ==
X-CSE-MsgGUID: w1SXb5LJQ/iuLYMLvL/cLQ==
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="59298598"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 08:04:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Mon, 6 Jul 2026 08:04:35 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Mon, 6 Jul 2026 08:04:34 -0700
Date: Mon, 6 Jul 2026 08:04:33 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Yao Zi <me@ziyao.cc>
CC: Charles Perry <charles.perry@microchip.com>, <u-boot@lists.denx.de>,
 "Rahul Pathak" <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Rick
 Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 2/7] firmware: rpmi: add support for the SBI MPXY transport
Message-ID: <akvEAWwYbEG23DWV@bby-cbu-swbuild03.eng.microchip.com>
References: <20260626201613.1035208-1-charles.perry@microchip.com>
 <20260626201613.1035208-3-charles.perry@microchip.com>
 <aj8nsG6JrIbBsGLM@pie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aj8nsG6JrIbBsGLM@pie>
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

On Sat, Jun 27, 2026 at 01:30:24AM +0000, Yao Zi wrote:
> On Fri, Jun 26, 2026 at 01:15:43PM -0700, Charles Perry wrote:
> > This adds an RPMI transport driver for the Supervisor Binary Interface
> > (SBI) message proxy (MPXY) extension [1].
> > 
> > This is for S-Mode U-Boot where some supervisor software (such as
> > OpenSBI) runs in M-Mode and handles the low level communication with the
> > PuC.
> > 
> > [1]: https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
> > 
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > ---
> >  arch/riscv/include/asm/sbi.h          |  57 ++++
> >  drivers/firmware/rpmi/Kconfig         |   9 +
> >  drivers/firmware/rpmi/Makefile        |   1 +
> >  drivers/firmware/rpmi/rpmi-sbi-mpxy.c | 449 ++++++++++++++++++++++++++
> >  4 files changed, 516 insertions(+)
> >  create mode 100644 drivers/firmware/rpmi/rpmi-sbi-mpxy.c
> 
> ...
> 
> > diff --git a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
> > new file mode 100644
> > index 000000000000..84af4787187a
> > --- /dev/null
> > +++ b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
> 
> ...
> 
> > +/* RPMI message protocol specific MPXY attributes */
> > +enum sbi_mpxy_rpmi_attribute_id {
> > +	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID = SBI_MPXY_ATTR_MSGPROTO_ATTR_START,
> > +	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION,
> > +	SBI_MPXY_RPMI_ATTR_IMPL_ID,
> > +	SBI_MPXY_RPMI_ATTR_IMPL_VERSION,
> > +	SBI_MPXY_RPMI_ATTR_MAX_ID
> > +};
> > +
> > +/*
> > + * RPMI specific SBI MPXY channel attributes.
> > + */
> > +struct sbi_mpxy_rpmi_channel_attrs {
> 
> Would it make sense to organize sbi_mpxy_rpmi_channel_attrs as an
> array indexed by sbi_mpxy_rpmi_attributed_id subtracted by
> SBI_MPXY_RPMI_ATTR_MSGPROTO_ATTR_START? With which we could simplify
> rpmi_sbi_mpxy_get_attr().

Yes I'll give this a try. I also find this a bit repetitive that the
attributes have an id and a struct where each members are sorted by
attribute id. Thanks!

> 
> > +	/* RPMI service group ID */
> > +	u32 servicegroup_id;
> > +	/* RPMI service group version */
> > +	u32 servicegroup_version;
> > +	/* RPMI implementation ID */
> > +	u32 impl_id;
> > +	/* RPMI implementation version */
> > +	u32 impl_version;
> > +};
> 
> ...
> 
> > +static int rpmi_sbi_mpxy_get_attr(struct rpmi_chan *chan,
> > +				  enum rpmi_attribute_id id, u32 *data)
> > +{
> > +	struct rpmi_sbi_mpxy *mpxy = dev_get_priv(chan->dev);
> > +	struct sbi_mpxy_chan_desc *desc = &mpxy->channel_descs[chan->id];
> > +
> > +	switch (id) {
> > +	case RPMI_ATTR_SPEC_VERSION:
> > +		*data = desc->attrs.msg_proto_version;
> > +		break;
> > +	case RPMI_ATTR_MAX_MSG_DATA_SIZE:
> > +		*data = desc->max_xfer_len;
> > +		break;
> > +	case RPMI_ATTR_SERVICEGROUP_ID:
> > +		*data = desc->rpmi_attrs.servicegroup_id;
> > +		break;
> > +	case RPMI_ATTR_SERVICEGROUP_VERSION:
> > +		*data = desc->rpmi_attrs.servicegroup_version;
> > +		break;
> > +	case RPMI_ATTR_IMPL_ID:
> > +		*data = desc->rpmi_attrs.impl_id;
> > +		break;
> > +	case RPMI_ATTR_IMPL_VERSION:
> > +		*data = desc->rpmi_attrs.impl_version;
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int rpmi_sbi_mpxy_probe(struct udevice *dev)
> > +{
> > +	struct rpmi_sbi_mpxy *mpxy = dev_get_priv(dev);
> > +	struct sbi_mpxy_chan_desc *desc;
> > +	unsigned long flags;
> > +	struct sbiret sret;
> > +	int i, ret;
> > +
> > +	mpxy->dev = dev;
> > +
> > +	/* Probe for SBI MPXY extension */
> > +	if (sbi_get_spec_version() < sbi_mk_version(1, 0) ||
> > +	    sbi_probe_extension(SBI_EXT_MPXY) <= 0) {
> > +		dev_info(dev, "SBI MPXY extension not available\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	/* Find-out shared memory size */
> > +	ret = rpmi_sbi_mpxy_get_shmem_size(&mpxy->shmem_size);
> > +	if (ret) {
> > +		dev_err(dev, "failed to get MPXY shared memory size\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	mpxy->shmem = memalign(PAGE_SIZE, mpxy->shmem_size);
> > +	if (!mpxy->shmem)
> > +		return -ENOMEM;
> > +
> > +	/* Setup shmem in OVERWRITE mode. (flags[1:0] = 00b) */
> > +	flags = 0;
> > +	sret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_SET_SHMEM,
> > +			 virt_to_phys(mpxy->shmem), 0, flags, 0, 0, 0);
> > +	if (sret.error) {
> > +		ret = sbi_to_linux_error(sret.error);
> > +		goto err;
> > +	}
> > +
> > +	ret = rpmi_sbi_mpxy_get_channel_ids(mpxy);
> > +	if (ret)
> > +		goto err;
> > +
> > +	for (i = 0; i < mpxy->channel_count; i++) {
> > +		desc = &mpxy->channel_descs[i];
> > +		desc->max_xfer_len =
> > +			min((u32)mpxy->shmem_size, desc->attrs.msg_max_len);
> > +	}
> > +
> > +	return 0;
> > +
> > +err:
> > +	if (mpxy->channel_descs)
> > +		free(mpxy->channel_descs);
> > +
> > +	if (mpxy->shmem)
> > +		free(mpxy->shmem);
> 
> free() is no-op when the argument is NULL, so the check is redundant.
> This applies to rpmi_sbi_mpxy_remove() and other similar cases in the
> series, too.

Ack.

Thanks,
Charles
