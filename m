Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82916C4450A
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 17:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FFC484D58;
	Tue, 14 Jul 2026 19:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="ue+5c/+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 451CC84D5A; Tue, 14 Jul 2026 19:35:03 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12F4284D52
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 19:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=64802a528=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1784050496; x=1815586496;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3VWHu1DvBvDUINqw9LVLImNpGLpZd8J8AvJHPSRWzKc=;
 b=ue+5c/+J3e1iAsOC0jK0vOVx21VPwxu/j/nVgRPCaiBizT9AeTeLnUlV
 LYKqU10SxEXPpxGKEDuoxLZ2d/FXWsL3WnzLVi3WDTwwvFfKABLBA6+Du
 jRYBX1FRJJaQp5CWDBZRvcLC0W6kNysT0jo+t9jJv7OKi7fwuM3WwGDva
 j9EZy4n+Qq3qzxhl7VL6kioHgsBjKkv6p+886l9gfoBlh9yWPUTS77czX
 5EVH+K+eUDLAg+deGw9/Y8CoTiYaE6gJjkCOWoqkadytcmX6d8llll1WB
 b7UyiqR0wcHd1CvQ1k+lzrJuNw9APBqL9tZvnArOvASrqjz61tAPm3muc Q==;
X-CSE-ConnectionGUID: tVU7rIt+Sz+DJqPWqByzMQ==
X-CSE-MsgGUID: FTXsBvpHS2i3Q2HDMbFoBA==
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="69972458"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Jul 2026 10:34:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 14 Jul 2026 10:34:53 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 14 Jul 2026 10:34:53 -0700
Date: Tue, 14 Jul 2026 10:34:51 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
CC: <u-boot@lists.denx.de>, <anup.patel@oss.qualcomm.com>,
 <charles.perry@microchip.com>
Subject: Re: [PATCH 1/3] riscv: Add SBI MPXY generic interface
Message-ID: <alZzO78B4Jrouult@bby-cbu-swbuild03.eng.microchip.com>
References: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
 <20260709175605.1070755-2-rahul.pathak@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260709175605.1070755-2-rahul.pathak@oss.qualcomm.com>
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

On Thu, Jul 09, 2026 at 11:26:02PM +0530, Rahul Pathak wrote:
> SBI MPXY interface implements the SBI MPXY
> extension to interact with supported message
> protocols for platform management and control
> 
> Signed-off-by: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
> ---
>  arch/riscv/Kconfig           |   9 +
>  arch/riscv/include/asm/sbi.h | 268 ++++++++++++++++++
>  arch/riscv/lib/Makefile      |   1 +
>  arch/riscv/lib/sbi_mpxy.c    | 529 +++++++++++++++++++++++++++++++++++
>  4 files changed, 807 insertions(+)
>  create mode 100644 arch/riscv/lib/sbi_mpxy.c
> 

...

> diff --git a/arch/riscv/lib/sbi_mpxy.c b/arch/riscv/lib/sbi_mpxy.c
> new file mode 100644
> index 00000000000..f95cedaabac
> --- /dev/null
> +++ b/arch/riscv/lib/sbi_mpxy.c
> @@ -0,0 +1,529 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * SBI MPXY (Message Proxy) Generic Library
> + *
> + * Copyright (c) 2026, Rahul Pathak <rahul.pathak@oss.qualcomm.com>
> + */

...

> +
> +/**
> + * sbi_mpxy_read_attrs() - Read a contiguous range of channel attributes
> + *
> + * @chan:		Target channel
> + * @base_attr_id:	First attribute ID in the range
> + * @attr_count:		Number of attributes to read
> + * @attrs_buf:		Output buffer (attr_count u32 words)
> + */
> +int sbi_mpxy_read_attrs(struct mpxy_channel *chan, u32 base_attr_id,
> +			u32 attr_count, u32 *attrs_buf)
> +{
> +	struct sbiret ret;
> +	__le32 *shmem;
> +	u32 end_id;
> +	int i;
> +
> +	if (!chan || !attr_count || !attrs_buf)
> +		return -EINVAL;
> +
> +	if (attr_count > mpxy_ctx.shmem_size / sizeof(u32))
> +		return -EINVAL;
> +
> +	shmem = (__le32 *)shmem_base();
> +	if (!shmem)
> +		return -ENXIO;
> +
> +	end_id = base_attr_id + attr_count - 1;
> +
> +	if (base_attr_id < SBI_MPXY_ATTR_STD_ATTR_MAX_IDX) {
> +		/* Standard attributes */
> +		if (end_id >= SBI_MPXY_ATTR_STD_ATTR_MAX_IDX)
> +			return -EINVAL;
> +
> +		ret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_READ_ATTRS,
> +				chan->channel_id, base_attr_id, attr_count,
> +				0, 0, 0);
> +		if (ret.error)
> +			return -EINVAL;
> +
> +		for (i = 0; i < attr_count; i++)
> +			attrs_buf[i] = le32_to_cpu(shmem[i]);
> +
> +		return 0;
> +	}
> +
> +	if (base_attr_id >= SBI_MPXY_ATTR_MSGPROTO_ATTR_START &&
> +	    end_id < SBI_MPXY_ATTR_MSGPROTO_ATTR_END) {
> +		/* Protocol-specific attributes */
> +		if (!chan->proto || !chan->proto->readattr)
> +			return -ENOSYS;
> +
> +		ret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_READ_ATTRS,
> +				chan->channel_id, base_attr_id, attr_count,
> +				0, 0, 0);
> +		if (ret.error)
> +			return -EINVAL;
> +
> +		for (i = 0; i < attr_count; i++)
> +			attrs_buf[i] = le32_to_cpu(shmem[i]);

Shouldn't you call the ->readattr() callback here instead of manually doing
the read?

Also, I'm not quite sure I understand what purpose those callbacks serve.
From what I'm seeing, attributes are always read/write using
SBI_EXT_MPXY_[READ|WRITE]_ATTRS because the transport layer is always mpxy.
Would a non-RPMI protocol do something different?

Thanks,
Charles

