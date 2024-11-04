Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543F2D132AF
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 11:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A19F9889D2;
	Mon,  4 Nov 2024 12:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2866988C7C; Mon,  4 Nov 2024 12:22:16 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E1C7388875
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 12:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E00A0FEC;
 Mon,  4 Nov 2024 03:22:42 -0800 (PST)
Received: from e130802.arm.com (unknown [10.57.90.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5DDD3F66E;
 Mon,  4 Nov 2024 03:22:11 -0800 (PST)
Date: Mon, 4 Nov 2024 11:22:04 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Hugues Kamba Mpiana <Hugues.KambaMpiana@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/8] arm_ffa: Add FFA_MEM_RECLAIM support
Message-ID: <20241104112204.GA68550@e130802.arm.com>
References: <20241101142017.79311-1-abdellatif.elkhlifi@arm.com>
 <20241101142017.79311-4-abdellatif.elkhlifi@arm.com>
 <ZyTx9rECRTWfZDf1@hera>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyTx9rECRTWfZDf1@hera>
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

Hi Ilias,

> > +/**
> > + * ffa_memory_reclaim_hdlr() - FFA_MEM_RECLAIM handler function
> > + * @dev: The FF-A bus device
> > + * @g_handle: The memory region globally unique Handle
> > + * @flags: Zero memory and time slicing flags
> > + *
> > + * Implement FFA_MEM_RECLAIM FF-A function
> > + * to restore exclusive access to a memory region back to its Owner.
> > + *
> > + * Return:
> > + *
> > + * 0 on success. Otherwise, failure
> > + */
> > +int ffa_memory_reclaim_hdlr(struct udevice *dev, u64 g_handle, u32 flags)
> > +{
> > +	ffa_value_t res;
> > +	int ffa_errno;
> > +
> > +	invoke_ffa_fn((ffa_value_t){
> > +			.a0 = FFA_SMC_32(FFA_MEM_RECLAIM),
> > +			.a1 = HANDLE_LOW(g_handle), .a2 = HANDLE_HIGH(g_handle),
> > +			.a3 = flags,
> > +			},
> > +			&res
> > +	);
> > +
> > +	if (res.a0 != FFA_SMC_32(FFA_SUCCESS)) {
> > +		ffa_errno = res.a2;
> > +		ffa_print_error_log(FFA_MEM_RECLAIM, ffa_errno);
> > +		return ffa_to_std_errno(ffa_errno);
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Is there a reason you have to define both ffa_memory_reclaim_hdlr() and ffa_memory_reclaim()?
> Can't you just move the checks of ffa_memory_reclaim() to
> ffa_memory_reclaim_hdlr()?

Yes, ffa_memory_reclaim() is the FF-A bus operation which is called by upper layers (clients).

ffa_memory_reclaim_hdlr() is the low level handler called by the operation.

The handler is set by the driver (e.g: Arm driver, sandbox driver) in the driver's ops structure [5].

So, the driver can set the handler and define its own if needed.

The client doesn't know which handler to use. It just calls the driver operation.

This design was followed in the other ABIs already merged. For example [1][2][3][4].

[1]: ffa_rxtx_unmap() operation: drivers/firmware/arm-ffa/arm-ffa-uclass.c#L999
[2]: ffa_unmap_rxtx_buffers_hdlr() handler: drivers/firmware/arm-ffa/arm-ffa-uclass.c#L999
[3]: rxtx_unmap ops callback in sandbox driver: drivers/firmware/arm-ffa/sandbox_ffa.c#L93
[4]: rxtx_unmap ops callback in Arm driver: drivers/firmware/arm-ffa/arm-ffa.c#L86
[5]: Arm's driver ops structure: drivers/firmware/arm-ffa/arm-ffa.c#L83

> > +
> >  /* FF-A driver operations (used by clients for communicating with FF-A)*/
> > ...
> > +/**
> > + * ffa_memory_reclaim() - FFA_MEM_RECLAIM driver operation
> > + * @dev: The FF-A bus device
> > + * @g_handle: The memory region globally unique Handle
> > + * @flags: Zero memory and time slicing flags
> > + *
> > + * Driver operation for FFA_MEM_RECLAIM.
> > + * Please see ffa_memory_reclaim_hdlr() description for more details.
> > + *
> > + * Return:
> > + *
> > + * 0 on success. Otherwise, failure
> > + */
> > +int ffa_memory_reclaim(struct udevice *dev, u64 g_handle, u32 flags)
> > +{
> > +	struct ffa_bus_ops *ops = ffa_get_ops(dev);
> > +
> > +	if (!ops || !ops->memory_reclaim)
> > +		return -ENOSYS;
> > +
> > +	return ops->memory_reclaim(dev, g_handle, flags);
> > +}

Cheers,
Abdellatif
