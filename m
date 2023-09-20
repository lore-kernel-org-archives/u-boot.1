Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A879CE79D0
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 11:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9307786AB9;
	Wed, 20 Sep 2023 13:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695211122;
	bh=Y1vCBHtODUQ1B7eVxwt4lQ91mooDh4UvCoaZtOgb0ZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yuvVxNc/24DbYYTTNwgf1NZ6vTR8MlkatWFRO+NcqhBmwOtpPP3DRNM8LvCUv7l//
	 nTu3WKOthxzB4yozXg7yFd+RhwGPUVXsvyzRuAKwSSnTfKG0pgSWFF+s7hFuXDePlR
	 0vetEFkEHnydyqc1J7VCVEc6XHRAv9PhXI1eU/8sY9q2esNhgGdxPm3goeTzR73Isd
	 vExEW/TEBlgi7NdOoK/lPGytElUtE4FioFf0q7opUiuuO4SnB5Oc4zXdVr2+Xj0hPq
	 /019V1QdWjDIJ0hHSwgNewhKicZ+ZA/f9xBCeAgrzakau3WE4lKJTZK5NVJq0/8m03
	 sBTpi3XaC9sxw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DF76F86AA5;
 Wed, 20 Sep 2023 13:58:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1695211121;
 bh=Y1vCBHtODUQ1B7eVxwt4lQ91mooDh4UvCoaZtOgb0ZM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Zz7/oRtgcBAz3BqoPhWTUQvxOqpzJ1aKyX+5krWpfNgrS5m2vdjjDXe1k95HuaJss
 8hdKauYzlhxqxU9K3cLauWFuZaxF2iVrN++zWqmdK4i4cEvZlCfzQ4SP6quRmRPyWc
 Tz89GTAIni90JFQiL+AT9amiwChi3VXS/4IG+4qDopv8DAKy4EeeIAzMZOxSHzHdI2
 RYhtUd8i9SGs9SeOy8UEFFe4z0dZapl+YAD5ioiujA6l7RuZdK3U4pv/c5srtvRaf6
 67JkJyijKdV+K4wTK4UYdy2yylqpkQM0daMlaheAEfOt7ZJKxDX1Js2Nwn9wPffP/V
 J3DTzQ74eWQzA==
Message-ID: <2fbc1593-68f6-1255-a123-9cf407af4451@denx.de>
Date: Wed, 20 Sep 2023 13:22:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] mx8m: csf.sh: pad csf blob for u-boot.itb to CSF_SIZE
 minus IVT header
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 uboot-imx@nxp.com
References: <20230920103352.154366-1-rasmus.villemoes@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230920103352.154366-1-rasmus.villemoes@prevas.dk>
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

On 9/20/23 12:33, Rasmus Villemoes wrote:
> When built with CONFIG_IMX_HAB, the full FIT image, including stuff
> tacked on beyond the end of the fdt structure, is expected to be (fdt
> size rounded up to 0x1000 boundary)+CONFIG_CSF_SIZE.
> 
> Now, when the FIT image is loaded from a storage device, it doesn't
> really matter that the flash.bin that gets written to target isn't
> quite that big - we will just load some garbage bytes that are never
> read or used for anything. But when flash.bin is uploaded via uuu,
> it's important that we actually serve at least as many bytes as the
> target expects, or we will hang in rom_api_download_image().
> 
> Extend the logic in the csf.sh script so that the csf blob is padded
> to CONFIG_CSF_SIZE minus the size of the IVT header.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
> v2: use dd instead of truncate.

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks
