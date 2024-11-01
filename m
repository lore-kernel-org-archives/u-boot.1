Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0790AE6F069
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 731858902F;
	Fri,  1 Nov 2024 16:21:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Bp5SXxsh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EED1F888BE; Fri,  1 Nov 2024 16:21:32 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B1618924F
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:21:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d8901cb98so1988039f8f.0
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730474490; x=1731079290; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i4OXjRkK++OZ17olHEnFLCCLb3vVlbpMTso9KM4NXS4=;
 b=Bp5SXxshvNuwT+Sy+ZVp/vgQjGzXTgB206whjTiXgj1L4gq0kLDpctL3XM26SWMx8s
 tzCmJNfsf2zOcRlJQukvFdn9BH2jAHv9PFZ6X6bOyHipN2vhjd8eRnPqGR/1ArzB8CHc
 kGwxmVJSnMsffK1R+h31YJogUdW3glxcmmWe8NgxSrkg9x5Nv6Q2qrOKTl4vnORbookT
 YmY3izC4iGU6uHK/SPUbfw3xLqhea1x1a2P7OGWNZ+ekjv/vIlbHIeBrY7nKVUmS5TKN
 0U2e0HTGiwjQbG/Chp8FEaKnQvmjZFuOSydP7TZaKFoUWBOkauYnLPAIXb2euHn6T7O9
 nE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730474490; x=1731079290;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4OXjRkK++OZ17olHEnFLCCLb3vVlbpMTso9KM4NXS4=;
 b=mxlsOtNmNRV6rmnGv812DeGlEl2fgStoNFHCK9ytXL8otyPY8oj9uIS6j4JK9hntxO
 zECOFqV5FOLmrmiVScWx1RuMNCMvL5c+y7NjQtROext+4xhsn1pB2VuyzjB/k2IrHs98
 FlSl+FYKME1o1S92OpsDCntYTtzw2xN6w02Syv4SHG3UGdX3+uSO2jE9yC1ydb7xDddE
 6Ffw+QNjMS/OHpdJPZdSzD+VYiFcsU/NxWm/R5JtPODsQySlrxm8CZkGMpielYE5MlIS
 10/CYPqtGKHtjyPucVpclQkWbsG8D/FLhz+rJ7N9beesdcKaixjoRUz7mxds/E3CYgwH
 44IQ==
X-Gm-Message-State: AOJu0YyhoItH1E596XKPwNYhrdv9EHe3aZeB/5yIrvccaoNaK5P/xBIR
 8GM+RlSgdoxHqfPLCyF8UVjpKMOWKX0eFtXiRtdY5ET9TuWFRnhz3phiPMlEd8o=
X-Google-Smtp-Source: AGHT+IGsJuPlqqNhEsavjqTPnnomFsyYdImtygtv4DSD8WRx759rQPIu1vS8aQaD8KCHnOMSAqO/mQ==
X-Received: by 2002:a5d:6c69:0:b0:37e:eee5:80dc with SMTP id
 ffacd0b85a97d-381c14efbe8mr5620949f8f.28.1730474489732; 
 Fri, 01 Nov 2024 08:21:29 -0700 (PDT)
Received: from hera (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113dd7fsm5489817f8f.70.2024.11.01.08.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 08:21:28 -0700 (PDT)
Date: Fri, 1 Nov 2024 17:21:26 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 3/8] arm_ffa: Add FFA_MEM_RECLAIM support
Message-ID: <ZyTx9rECRTWfZDf1@hera>
References: <20241101142017.79311-1-abdellatif.elkhlifi@arm.com>
 <20241101142017.79311-4-abdellatif.elkhlifi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101142017.79311-4-abdellatif.elkhlifi@arm.com>
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

[...]
>  }
>
> +/**
> + * ffa_memory_reclaim_hdlr() - FFA_MEM_RECLAIM handler function
> + * @dev: The FF-A bus device
> + * @g_handle: The memory region globally unique Handle
> + * @flags: Zero memory and time slicing flags
> + *
> + * Implement FFA_MEM_RECLAIM FF-A function
> + * to restore exclusive access to a memory region back to its Owner.
> + *
> + * Return:
> + *
> + * 0 on success. Otherwise, failure
> + */
> +int ffa_memory_reclaim_hdlr(struct udevice *dev, u64 g_handle, u32 flags)
> +{
> +	ffa_value_t res;
> +	int ffa_errno;
> +
> +	invoke_ffa_fn((ffa_value_t){
> +			.a0 = FFA_SMC_32(FFA_MEM_RECLAIM),
> +			.a1 = HANDLE_LOW(g_handle), .a2 = HANDLE_HIGH(g_handle),
> +			.a3 = flags,
> +			},
> +			&res
> +	);
> +
> +	if (res.a0 != FFA_SMC_32(FFA_SUCCESS)) {
> +		ffa_errno = res.a2;
> +		ffa_print_error_log(FFA_MEM_RECLAIM, ffa_errno);
> +		return ffa_to_std_errno(ffa_errno);
> +	}
> +
> +	return 0;
> +}

Is there a reason you have to define both ffa_memory_reclaim_hdlr() and ffa_memory_reclaim()?
Can't you just move the checks of ffa_memory_reclaim() to
ffa_memory_reclaim_hdlr()?

> +
>  /* FF-A driver operations (used by clients for communicating with FF-A)*/
>
>  /**
> @@ -1214,6 +1261,29 @@ int ffa_memory_share(struct udevice *dev, struct ffa_mem_ops_args *args)
>  	return ops->memory_share(dev, args);
>  }
>
> +/**
> + * ffa_memory_reclaim() - FFA_MEM_RECLAIM driver operation
> + * @dev: The FF-A bus device
> + * @g_handle: The memory region globally unique Handle
> + * @flags: Zero memory and time slicing flags
> + *
> + * Driver operation for FFA_MEM_RECLAIM.
> + * Please see ffa_memory_reclaim_hdlr() description for more details.
> + *
> + * Return:
> + *
> + * 0 on success. Otherwise, failure
> + */
> +int ffa_memory_reclaim(struct udevice *dev, u64 g_handle, u32 flags)
> +{
> +	struct ffa_bus_ops *ops = ffa_get_ops(dev);
> +
> +	if (!ops || !ops->memory_reclaim)
> +		return -ENOSYS;
> +
> +	return ops->memory_reclaim(dev, g_handle, flags);
> +}
> +
>  /**
>   * ffa_do_probe() - probing FF-A framework
>   * @dev:	the FF-A bus device (arm_ffa)
> diff --git a/drivers/firmware/arm-ffa/arm-ffa.c b/drivers/firmware/arm-ffa/arm-ffa.c
> index c4211c953ef..b7e751e3821 100644
> --- a/drivers/firmware/arm-ffa/arm-ffa.c
> +++ b/drivers/firmware/arm-ffa/arm-ffa.c
> @@ -85,6 +85,7 @@ static const struct ffa_bus_ops ffa_ops = {
>  	.sync_send_receive = ffa_msg_send_direct_req_hdlr,
>  	.rxtx_unmap = ffa_unmap_rxtx_buffers_hdlr,
>  	.memory_share = ffa_memory_share_hdlr,
> +	.memory_reclaim = ffa_memory_reclaim_hdlr,
>  };
>

[...]

Thanks
/Ilias
