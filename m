Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DBCC36001
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 02:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5E4281D0B;
	Sat, 22 Mar 2025 03:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742611810;
	bh=+SBKRGNXJOK9wCRbKhTuR5E/sHtdN7oqORFLXoYEdxY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z/6AQ26HLg5gUgT4BBaS/noTVcYNRvLo7yCT/2MkZXgLpfNtQFDBvaBq5XQbpkv1a
	 HNFZPXtmtRg01QnYBC5rXDAUxtjOB6GKWL6nZxniK89smelXAHb/QC1UqMp335E1IJ
	 yiwUoxdzYWq6pb4hZiKEjZaBcWpMconGL+PX1UCNm6nmbwqHFKuBmW7R/SZOEeZ4pP
	 dVcbT6tJTWbE/LveJdWGGcPuxzY5G++3IeGIqrF+CqvOhrUaWSUWpdsfp2oKnS567i
	 GfMzr2uxt9ST3F4Bdek0lzOibXOVV5iDJG5UtCL+NdGFIIG+PcLwtoBFVB2V8TRRZQ
	 ZV+JqL6Dc9bVQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA93F81219; Sat, 22 Mar 2025 03:50:07 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E26BE81D25
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 03:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="R3qTvg66"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CB508101E8F49; Sat, 22 Mar 2025 03:50:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742611804; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=+SBKRGNXJOK9wCRbKhTuR5E/sHtdN7oqORFLXoYEdxY=;
 b=R3qTvg66I/hpwJ09/M50CIpWbEXADgN8iqNoLTX2Ds79EWbj73qJyOW6Nf1M3UekTBC/xU
 K+Yg+kmdxPz6QohdUwO59RLFPLeTqFcuHvr3b622BRV15gKlEbvtdizU2/q2ogwTWKDm8T
 vGR1qAKEz7z5gcv0J4YvMKjb9bJOs/HdCvdqRxSc+cieQ6XrhAO7gnudpn+GR8HZg/IuGC
 tPZJ3PPeiR1G1IqxVg7dyRCp3r7NI3OVcwrK5dFf2G1sA9VGchy3ZQVKxWA6dv91os/Aiv
 YJjBvAYSxvTrI/16Ilff3xDcO165qyqFG+JQmCgGbX7hJZuiJpuA+DdEBedoHQ==
Message-ID: <163ddf29-16cd-4a7c-a37a-142d692ad8d9@denx.de>
Date: Sat, 22 Mar 2025 03:14:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/19] spl: imx: use trampoline buffer to load images
 to secure region
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?=
 <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-11-f2c8ba815f89@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250321-imx95-v1-11-f2c8ba815f89@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/21/25 8:15 AM, Alice Guo (OSS) wrote:

[...]

> @@ -42,12 +53,30 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
>   
>   	debug("%s: container: %p offset: %lu size: %lu\n", __func__,
>   	      container, offset, size);
> -	if (info->read(info, offset, size,
> -		       map_sysmem(images[image_index].dst - overhead,
> -				  images[image_index].size)) <
> -	    images[image_index].size) {
> -		printf("%s wrong\n", __func__);
> -		return NULL;
> +
> +	buf = map_sysmem(images[image_index].dst - overhead, images[image_index].size);
> +	if (IS_ENABLED(CONFIG_SPL_IMX_CONTAINER_USE_TRAMPOLINE) &&
> +	    arch_check_dst_in_secure(buf, size)) {
> +		trampoline = arch_get_container_trampoline();
> +		if (!trampoline) {
> +			printf("%s: trampoline size is zero\n", __func__);
> +			return NULL;
> +		}
> +
> +		if (info->read(info, offset, size, trampoline) < images[image_index].size) {
> +			printf("%s wrong\n", __func__);
> +			return NULL;
> +		}
> +
> +		memcpy(buf, trampoline, images[image_index].size);
> +	} else {
> +		if (info->read(info, offset, size,
> +			       map_sysmem(images[image_index].dst - overhead,
> +					  images[image_index].size)) <
> +		    images[image_index].size) {
> +			printf("%s wrong\n", __func__);

Can you please make those debug prints a bit more informative about the 
failure that occurred ?
