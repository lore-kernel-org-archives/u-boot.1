Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22A3D3F098
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 16:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE39984034;
	Wed, 28 Jan 2026 17:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WCLW9ZRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ADAD84065; Wed, 28 Jan 2026 17:48:23 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BD1F8401A
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 17:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-8c52c948d45so966885a.1
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 08:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769618899; x=1770223699; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=plGkDXhnEkP9C+pHHgCZWTFAw3wN9oX+LHYx9U+4BxE=;
 b=WCLW9ZRWzpZluvd9zWXZXour1qNINiguUFdRI0NLNNTNcbQofCxYc4I7E2nLeWCQsZ
 9eHEHuso66k+5frO0nsowNp6G0qyyBFmnNp3IMiSuexA73QV7WVSb4eVo0ebRhTPGjGd
 M+6+PpwBf0Nwrd5JeA69KHCXseNv4fuM7NFEAv+u6dOM7PpoRf5J8fSryo9f7rsoWnlk
 IUS1ydfquRuFv+4QlXPMiM3Vo1cKd1AsHRrkeizTyWNJgO9y4UMgBQ3perPZAwHwFu6t
 9J1ncBAbO9wcFgdEGOR1Rdwte/IQiC0/UYuxdiDJBU/06j/hjB4waKcSMSH+9De16IOX
 ABQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769618899; x=1770223699;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=plGkDXhnEkP9C+pHHgCZWTFAw3wN9oX+LHYx9U+4BxE=;
 b=aXVm/jwohq/oPNTg7onsZGphUYw0Ld3DRy+JyrhrPJ1HV+mYBTNRZS4Dr17hG97Szs
 BDClNcGVqOMiVK2m9EU11T1vFRV/jjcpR2v9L6lMELzByGmkmE4ysO5SGoJMOWZD4Mbk
 nPVFBy+l6sa2m7h1rr4qMZJu/aqLBLrt+QLg5ojOPchH413m7J/OZQCwAawRqM4jEytX
 hk7RzOkzPTsPJzrqqzSrgeA5i/TRrHXkVBMQ/+fNjUoNZgIZXx4cOH4WAiNIAxky1Vq3
 yDpr79KptH6jnLhHH/3TK7I/cN+5WK5HpD/DxXziBmcPWTL+nDen6rkux587eRqyoiLh
 82Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmj7LWdw9CX+eGkZ5kbpR5l0qJTajXi+2T99YbqT0X4V16h95whtISL9BOHGaHPMH7WdQFr0Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzzPFaSUrtm4C6Tt2xFIz5YQlHlJ6JWmt/fFl8NhDjBOovFlsrY
 x1dA3fvg+fSX4D/KGGVbvtLoOCWCCOLcWUChCFf/UOAbYJDi4B1kLu0G7e0A8QtI
X-Gm-Gg: AZuq6aL+038eWnEHOGVu6IAQaNGZGwFAvTye7mt5IPKGjw0xGXc0Z54SEciJfwBqDgt
 XvTU07zGXG2CxbozAHoGAgLapOtayZXvlr/a+gKjf81C9kvWLX7j8lu7KwRUrGMs4r/FRU2CD94
 su3qf8+l1i+xyNiKBEugzJKMteP5yg5EeA/29rXCO80M/w84+enmd3yK8GcXFOse018bPWmPvM6
 2pLDddN9AMcGJXlMsCpRW5Vksb8j6clwj+R2HPS1azQZoll189luYdJKv6lgVGpv38iD8sLpfvr
 PkqUfPYQHW/XMYi0g5pMX8qGUSeRVXs+var76lPG4hSdlfyA2GNh+GSWh1qECCyT7FBhOldqvl/
 QM2ApTRJ5QpzXDDiZzDv5gwQLsIkRzqCwBEsLLzpUgSOdtIMIhtmVqClskWbba0uu9LOOPVGiEo
 SpXKviWd4rduNPdkiOdIvdEH40XWzbLVO6EiIdvgMcvy/12fm7vtriocE=
X-Received: by 2002:a05:620a:1a0b:b0:8b2:5af3:7fce with SMTP id
 af79cd13be357-8c71ad23708mr84788985a.7.1769618899090; 
 Wed, 28 Jan 2026 08:48:19 -0800 (PST)
Received: from ?IPV6:2600:4040:4476:3800:2d8:61ff:fe7c:5d59?
 ([2600:4040:4476:3800:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c711d2ab04sm207995185a.25.2026.01.28.08.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 08:48:18 -0800 (PST)
Message-ID: <708253cc-be1d-f375-0427-91658d5e88fe@gmail.com>
Date: Wed, 28 Jan 2026 11:48:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] tools: fit_image: Fallback to 8-byte alignment for
 flat_dt images
Content-Language: en-US
To: Beleswar Padhi <b-padhi@ti.com>, trini@konsulko.com
Cc: sean.anderson@seco.com, ilias.apalodimas@linaro.org,
 malysagreg@gmail.com, sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com, anshuld@ti.com,
 afd@ti.com, nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com,
 bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
References: <20260128141834.2322865-1-b-padhi@ti.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260128141834.2322865-1-b-padhi@ti.com>
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

Hi Beleswar,

On 1/28/26 09:18, Beleswar Padhi wrote:
> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
> packed inside the multidtb.fit FIT image. While the individual DTBs
> and the FIT image start address are 8-byte aligned, the DTBs embedded
> within the FIT image are not guaranteed to maintain 8-byte alignment.
> 
> This misalignment causes -FDT_ERR_ALIGNMENT failure in
> setup_multi_dtb_fit() when locating the next available DTB within the
> FIT blob and setting gd->fdt_blob, because of the recent libfdt
> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
> version v1.7.2-35-g52f07dcca47c")
> 
> To fix this, check the image type when extracting FIT image data and
> set the alignment size to 8 bytes (if not already) only for flat_dt
> images. This ensures correct alignment for device tree blobs as per the
> DT spec, while also allowing different alignment sizes for other image
> types within the FIT.
> 
> Reported-by: Anshul Dalal <anshuld@ti.com>
> Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Testing Done:
> 1. Boot tested on all TI K3 platforms.
> 
> v4: Changelog:
> 1. Align only the DTBs to 8-bytes, other images in a FIT can have their
>     independent alignment. [Marek]
> 
> Link to v3:
> https://lore.kernel.org/all/20260122172247.2995437-1-b-padhi@ti.com/
> 
> v3: Changelog:
> 1. Default to 8-byte alignment for DTBs in mkimage instead of
>     passing -B 0x8 in build command [Marek]
> 2. Remove previous R/Bs.
> 
> Link to v2:
> https://lore.kernel.org/all/20260112101102.1417970-2-b-padhi@ti.com/
> 
> v2: Changelog:
> 1. Carry R/B, Reported-by, Closes and Fixes tag.
> 
> Link to v1:
> https://lore.kernel.org/all/20260109190026.58464-2-b-padhi@ti.com/
> 
>   tools/fit_image.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Can you please update doc/mkimage.1 as well? There should be a note about
this under -E.

> diff --git a/tools/fit_image.c b/tools/fit_image.c
> index e865f65a400..f842c845771 100644
> --- a/tools/fit_image.c
> +++ b/tools/fit_image.c
> @@ -682,9 +682,17 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
>   	for (node = fdt_first_subnode(fdt, images);
>   	     node >= 0;
>   	     node = fdt_next_subnode(fdt, node)) {
> -		const char *data;
> +		const char *data, *type;
>   		int len;
>   
> +		/* Fallback to 8-byte alignment for DTBs if unaligned */
> +		type = fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
> +		if (type &&
> +		    len == sizeof("flat_dt") &&
> +		    !memcmp(type, "flat_dt", len) &&
> +		    align_size & 0x7)
> +			align_size = 8;
> +

Doesn't this increase the alignment for all images following the devicetree?

And actually, doesn't this happen too late? By the time we check whether the
node is a devicetree, buf_ptr has already been updated. This check will only
affect the alignment of the *next* image in the FIT.

--Sean

>   		data = fdt_getprop(fdt, node, FIT_DATA_PROP, &len);
>   		if (!data)
>   			continue;

