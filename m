Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A115C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 01:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5CD18404D;
	Sat, 27 Jun 2026 03:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="meCmnzj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B58CA84105; Sat, 27 Jun 2026 03:30:39 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 141C383FEE
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 03:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782523833; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mtmEm6FBcRGmQXm126BKq4DpbAJOfWxwN1aoyPtHZXqCUvCHl1EQvHDU5ZsXUDe6RDmuakRvry/LByqRRMpemScHLJg7stMHCVZt3uoAciNK2e5fEuVXU5X0MiGHLYNHTK45WmFJ5TxfiZM618FBUm1Q9ukWSIcoJsMgViqp2O8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782523833;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=d3KAit1WuNTXBAaAfRPRh4KdkNSnPmbUkaivcGWDxzs=; 
 b=lAaV8n2vujyT2F0NX+OqBLQCL2iYnh46hhSzzR6FKGQhI8Dn16oDB5LXOEI8r08GhVGIAypakVDNTv+K8tsaSmywdMc5GNIWSO1EDEwlSQyHtId9Lf3mUHtKgiUM3eBDAQzhVqpp75Wbk00scozMfqiHcIJeSUpcquF7e961nw8=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782523833; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=d3KAit1WuNTXBAaAfRPRh4KdkNSnPmbUkaivcGWDxzs=;
 b=meCmnzj0vIbzi6NAdN8udpgzQ3yzpPd6SEwU9OZ20ZR7P+P5TYcpQHCPE0jqoi1x
 5VaphHZHyPC+goqEbXf9lu+k+itjhHKl7/KBw9BleerA5CZNPm26rlRa4RSqG2Z5HMH
 R8h3py24IaNn6V3wgUfuClab4NXukTA6iy7nm2VQ=
Received: by mx.zohomail.com with SMTPS id 1782523830693555.1271532198713;
 Fri, 26 Jun 2026 18:30:30 -0700 (PDT)
Date: Sat, 27 Jun 2026 01:30:24 +0000
From: Yao Zi <me@ziyao.cc>
To: Charles Perry <charles.perry@microchip.com>, <u-boot@lists.denx.de>
Cc: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH 2/7] firmware: rpmi: add support for the SBI MPXY transport
Message-ID: <aj8nsG6JrIbBsGLM@pie>
References: <20260626201613.1035208-1-charles.perry@microchip.com>
 <20260626201613.1035208-3-charles.perry@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626201613.1035208-3-charles.perry@microchip.com>
X-ZohoMailClient: External
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

On Fri, Jun 26, 2026 at 01:15:43PM -0700, Charles Perry wrote:
> This adds an RPMI transport driver for the Supervisor Binary Interface
> (SBI) message proxy (MPXY) extension [1].
> 
> This is for S-Mode U-Boot where some supervisor software (such as
> OpenSBI) runs in M-Mode and handles the low level communication with the
> PuC.
> 
> [1]: https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
> 
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
>  arch/riscv/include/asm/sbi.h          |  57 ++++
>  drivers/firmware/rpmi/Kconfig         |   9 +
>  drivers/firmware/rpmi/Makefile        |   1 +
>  drivers/firmware/rpmi/rpmi-sbi-mpxy.c | 449 ++++++++++++++++++++++++++
>  4 files changed, 516 insertions(+)
>  create mode 100644 drivers/firmware/rpmi/rpmi-sbi-mpxy.c

...

> diff --git a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
> new file mode 100644
> index 000000000000..84af4787187a
> --- /dev/null
> +++ b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c

...

> +/* RPMI message protocol specific MPXY attributes */
> +enum sbi_mpxy_rpmi_attribute_id {
> +	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID = SBI_MPXY_ATTR_MSGPROTO_ATTR_START,
> +	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION,
> +	SBI_MPXY_RPMI_ATTR_IMPL_ID,
> +	SBI_MPXY_RPMI_ATTR_IMPL_VERSION,
> +	SBI_MPXY_RPMI_ATTR_MAX_ID
> +};
> +
> +/*
> + * RPMI specific SBI MPXY channel attributes.
> + */
> +struct sbi_mpxy_rpmi_channel_attrs {

Would it make sense to organize sbi_mpxy_rpmi_channel_attrs as an
array indexed by sbi_mpxy_rpmi_attributed_id subtracted by
SBI_MPXY_RPMI_ATTR_MSGPROTO_ATTR_START? With which we could simplify
rpmi_sbi_mpxy_get_attr().

> +	/* RPMI service group ID */
> +	u32 servicegroup_id;
> +	/* RPMI service group version */
> +	u32 servicegroup_version;
> +	/* RPMI implementation ID */
> +	u32 impl_id;
> +	/* RPMI implementation version */
> +	u32 impl_version;
> +};

...

> +static int rpmi_sbi_mpxy_get_attr(struct rpmi_chan *chan,
> +				  enum rpmi_attribute_id id, u32 *data)
> +{
> +	struct rpmi_sbi_mpxy *mpxy = dev_get_priv(chan->dev);
> +	struct sbi_mpxy_chan_desc *desc = &mpxy->channel_descs[chan->id];
> +
> +	switch (id) {
> +	case RPMI_ATTR_SPEC_VERSION:
> +		*data = desc->attrs.msg_proto_version;
> +		break;
> +	case RPMI_ATTR_MAX_MSG_DATA_SIZE:
> +		*data = desc->max_xfer_len;
> +		break;
> +	case RPMI_ATTR_SERVICEGROUP_ID:
> +		*data = desc->rpmi_attrs.servicegroup_id;
> +		break;
> +	case RPMI_ATTR_SERVICEGROUP_VERSION:
> +		*data = desc->rpmi_attrs.servicegroup_version;
> +		break;
> +	case RPMI_ATTR_IMPL_ID:
> +		*data = desc->rpmi_attrs.impl_id;
> +		break;
> +	case RPMI_ATTR_IMPL_VERSION:
> +		*data = desc->rpmi_attrs.impl_version;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}

...

> +static int rpmi_sbi_mpxy_probe(struct udevice *dev)
> +{
> +	struct rpmi_sbi_mpxy *mpxy = dev_get_priv(dev);
> +	struct sbi_mpxy_chan_desc *desc;
> +	unsigned long flags;
> +	struct sbiret sret;
> +	int i, ret;
> +
> +	mpxy->dev = dev;
> +
> +	/* Probe for SBI MPXY extension */
> +	if (sbi_get_spec_version() < sbi_mk_version(1, 0) ||
> +	    sbi_probe_extension(SBI_EXT_MPXY) <= 0) {
> +		dev_info(dev, "SBI MPXY extension not available\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Find-out shared memory size */
> +	ret = rpmi_sbi_mpxy_get_shmem_size(&mpxy->shmem_size);
> +	if (ret) {
> +		dev_err(dev, "failed to get MPXY shared memory size\n");
> +		return -ENODEV;
> +	}
> +
> +	mpxy->shmem = memalign(PAGE_SIZE, mpxy->shmem_size);
> +	if (!mpxy->shmem)
> +		return -ENOMEM;
> +
> +	/* Setup shmem in OVERWRITE mode. (flags[1:0] = 00b) */
> +	flags = 0;
> +	sret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_SET_SHMEM,
> +			 virt_to_phys(mpxy->shmem), 0, flags, 0, 0, 0);
> +	if (sret.error) {
> +		ret = sbi_to_linux_error(sret.error);
> +		goto err;
> +	}
> +
> +	ret = rpmi_sbi_mpxy_get_channel_ids(mpxy);
> +	if (ret)
> +		goto err;
> +
> +	for (i = 0; i < mpxy->channel_count; i++) {
> +		desc = &mpxy->channel_descs[i];
> +		desc->max_xfer_len =
> +			min((u32)mpxy->shmem_size, desc->attrs.msg_max_len);
> +	}
> +
> +	return 0;
> +
> +err:
> +	if (mpxy->channel_descs)
> +		free(mpxy->channel_descs);
> +
> +	if (mpxy->shmem)
> +		free(mpxy->shmem);

free() is no-op when the argument is NULL, so the check is redundant.
This applies to rpmi_sbi_mpxy_remove() and other similar cases in the
series, too.

> +
> +	return ret;
> +}
> +
> +static int rpmi_sbi_mpxy_remove(struct udevice *dev)
> +{
> +	struct rpmi_sbi_mpxy *mpxy = dev_get_priv(dev);
> +
> +	if (mpxy->channel_descs)
> +		free(mpxy->channel_descs);
> +
> +	if (mpxy->shmem)
> +		free(mpxy->shmem);
> +
> +	return 0;
> +}

Regards,
Yao Zi
