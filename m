Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C279C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 20:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2134805D7;
	Wed, 12 Mar 2025 21:57:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="c7nAX3mL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A09780756; Wed, 12 Mar 2025 21:57:50 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F7048003E
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 21:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 65ECB3F2C0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 20:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1741813067;
 bh=7sWjSKYdfzk3AIo61Pvsl30YnnUQ8vxoxCtxjxDWKE0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=c7nAX3mLU5gg/RcgnP9vMcyBQPRSrJpcYLy7P3RM3AykHJWnqV38H37khJidBNgo8
 SRtyqc123TSvvbDW/S6e5p24viFRNgtXkOhBNIBVDC/LhC/IZQirZV9qti9NOSVBq9
 i93zyfc1qWtsYnMhPVb+XhFWDlqqfV/jS3Im4f9WLpWcGUyEAxBjxF961qiLZUSEyC
 c0GJfJ0ojfS8Thbh6Wh3MAmRka5JQiqmoa/tPGl359Ok1ziNaVmb2M+JRL6yn6pNKE
 TZsLrjArHHM6rHxQ3U6kd5YsE1wZli0bE7O+1xdPPOl9qCbuqWDo1AkqfDar90QH3Y
 xr9NCSJo5LB5Q==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-391425471d6so84844f8f.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 13:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741813067; x=1742417867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7sWjSKYdfzk3AIo61Pvsl30YnnUQ8vxoxCtxjxDWKE0=;
 b=VQX1MW2mycy5HgyRhp8Cf4hKlb8eBrLVQ5tqHq69j7GUMvB92qZKOSouQGQbDL/Wni
 4NcBr3DnklOBmp83WCdr1NTa2+0irbxX2wwYorj+SdM3Iqxw0vNTzqSAkQEiHsEFKzai
 WOPtcTKMXS33Lv+n3ZelyEG+mFm+8L+s3fZMPoMfyPBwMgvYOk+efrWTvyAk3D4CkneF
 HgUvIyVelafHZXSH6aMxv1qPcQGVjkdVjsIRQ8zw7eBRHHicTY9L9IVYX+A/0y3lz9qh
 Fulsks2thjv1RFOW8uERnOnP87IDrlbLOZfjDYk/QRqtOYgjwBzHrlqaFIQKWfWE7iuH
 ahAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcW2s5PNABqv+imGdRpu7+u2YMWJFjGSzGHVX5zPk09JrRRBgRCy5qgA0dZEhiNWJRVpxmGEE=@lists.denx.de
X-Gm-Message-State: AOJu0YyvMoICt93xkOSrhiv7DfUKMvGR0g1mCHntWVVyetmTichMgP6c
 K+a1Y54mgpnTpJB5IUZcSwieVWZGQXCMoZWJinIyGzz8NPjrj88nmWtpAIKuHhGsj2Ps42KPzmw
 GvFPFku26XaEdf5NC32HjhDSn1I5uc1np1opczBiOB4B/CWQ3I9RVCGKoq2Z+wR6RzSU=
X-Gm-Gg: ASbGncuhk2arskJgAvsi70g70G5KREOcNGD3G85G1LZWFuEPCVPZcRFnDPfWpIckQG4
 URICS02fRXb+17wpy33q2bBhWlUtTOpuv9H8cz0WFkAF5EL55pldYSpqX2deTQizwshAwoZR5E1
 zFrWg46AfuI0qGWHYOKZ9kmTTCH6XDn+pOPJNxBMtR/g5PVFOGiyU37TqRDX/h1skhUYCo6qryO
 nAu8L8SBcwY4G7Ai3Ijni6adQhw4pdOudEeyofjC2llgrQ7vaISVO5rSP9noieQMIrIunKGcD4W
 NduxJzd+vUK32KGsVtARld1BkzhHMqbqJubG6Vt5DK3wmu3yJAVfaTwBWZkoPGOPFNGmpC4mO0P
 F7IiAog==
X-Received: by 2002:a5d:64e9:0:b0:391:4873:7943 with SMTP id
 ffacd0b85a97d-39148737af1mr12983586f8f.32.1741813066796; 
 Wed, 12 Mar 2025 13:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtSXaNumkGo0Num+oFcewf5izCy15vOH7hxsBT3i42ONsCMF7/XuzPaNokuJMoD6O4pAGdaQ==
X-Received: by 2002:a5d:64e9:0:b0:391:4873:7943 with SMTP id
 ffacd0b85a97d-39148737af1mr12983563f8f.32.1741813066384; 
 Wed, 12 Mar 2025 13:57:46 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:345b:e644:8505:68cc:d761?
 ([2a02:3035:6e0:345b:e644:8505:68cc:d761])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a8c5cb4sm31922835e9.25.2025.03.12.13.57.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 13:57:45 -0700 (PDT)
Message-ID: <6e801422-2cbf-4a66-892e-02091cb563a5@canonical.com>
Date: Wed, 12 Mar 2025 21:57:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/8] blkmap: store type of blkmap slice in
 corresponding structure
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-7-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250312085424.1201148-7-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 12.03.25 09:54, Sughosh Ganu wrote:
> Add information about the type of blkmap slice as an attribute in the

%s/blkmap slice/blkmap slices/

> corresponding slice structure. Put information in the blkmap slice
> structure to identify if it is associated with a memory or linear
> mapped device. Which can then be used to take specific action based on
> the type of the blkmap slice.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Tobias Waldekranz <tobias@waldekranz.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since V7: None
> 
>   drivers/block/blkmap.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> index 34eed1380dc..453510cca62 100644
> --- a/drivers/block/blkmap.c
> +++ b/drivers/block/blkmap.c
> @@ -16,6 +16,10 @@
>   
>   struct blkmap;
>   
> +/* Attributes of blkmap slice */

Please, provide a description of the constants in Sphinx style 
explaining what linear and and memory slices are.

Cf. 
https://docs.kernel.org/doc-guide/kernel-doc.html#object-like-macro-documentation

Best regards

Heinrich

> +#define BLKMAP_SLICE_LINEAR	BIT(0)
> +#define BLKMAP_SLICE_MEM	BIT(1)
> +
>   /**
>    * struct blkmap_slice - Region mapped to a blkmap
>    *
> @@ -25,12 +29,14 @@ struct blkmap;
>    * @node: List node used to associate this slice with a blkmap
>    * @blknr: Start block number of the mapping
>    * @blkcnt: Number of blocks covered by this mapping
> + * @attr: Attributes of blkmap slice
>    */
>   struct blkmap_slice {
>   	struct list_head node;
>   
>   	lbaint_t blknr;
>   	lbaint_t blkcnt;
> +	uint     attr;
>   
>   	/**
>   	 * @read: - Read from slice
> @@ -169,6 +175,7 @@ int blkmap_map_linear(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   		.slice = {
>   			.blknr = blknr,
>   			.blkcnt = blkcnt,
> +			.attr = BLKMAP_SLICE_LINEAR,
>   
>   			.read = blkmap_linear_read,
>   			.write = blkmap_linear_write,
> @@ -248,6 +255,7 @@ int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   		.slice = {
>   			.blknr = blknr,
>   			.blkcnt = blkcnt,
> +			.attr = BLKMAP_SLICE_MEM,
>   
>   			.read = blkmap_mem_read,
>   			.write = blkmap_mem_write,

