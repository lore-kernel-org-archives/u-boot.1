Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05B0C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 06:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B762B881AC;
	Wed, 15 May 2024 08:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715753070;
	bh=SSS6D62UvT2AaepSALftynwdhsr373IyjoaneZGic4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aIwLYuNPDxeEjziUFRwmP9HgaBfALw/QG2cm9oFyp5uCwPn5KoZDOvo1cErmFeCvZ
	 ApuR/ZTLPxm4VlXhLPe2zPFqSRJQNOhsjFm07eke0bN3f+xAwf1h7/gSX5soy2kNA7
	 oabNgWxus+JX9Wiy9Pl8W6bhsPfOpzXVnitxMDSqgahCfnBWS48T/KzwgwImbsgHop
	 yezdop1Y92x0FaUB3DWOkzLDYhlJgJHRcXXVYYRBM52/1DoD45ExCIXVa3u7mmvPgh
	 Lcw1sYoK9Keg3A2+nvt3P9bKomT34mBKSbl4CcMDXNtluWimLAdgX6VOMpfxtKCtbZ
	 dA748bP7oMAvQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90D3E881CE; Wed, 15 May 2024 08:04:29 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A56988817B
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 08:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4VfN3471jjz9tGR;
 Wed, 15 May 2024 08:04:16 +0200 (CEST)
Message-ID: <d2e15688-bb50-45dc-9e43-3317e8c7c762@denx.de>
Date: Wed, 15 May 2024 08:04:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] firmware: zynqmp: Add support to access efuses
Content-Language: en-US
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240514140416.156747-1-lukas.funke-oss@weidmueller.com>
 <20240514140416.156747-2-lukas.funke-oss@weidmueller.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240514140416.156747-2-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Lukas,

On 5/14/24 16:04, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> Add functions to access efuses through PMU firmware
> interface.
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
>   drivers/firmware/firmware-zynqmp.c | 31 ++++++++++++++++++++++++++++++
>   include/zynqmp_firmware.h          |  2 ++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index f99507d86c6..7483f2a8709 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -210,6 +210,37 @@ int zynqmp_pm_feature(const u32 api_id)
>   	return ret_payload[1] & FIRMWARE_VERSION_MASK;
>   }
>   
> +int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
> +{
> +	int ret;
> +	u32 ret_payload[PAYLOAD_ARG_CNT];

Reverse x-mas tree ordering looks better IMHO.

> +
> +	if (!idcode || !version)
> +		return -EINVAL;
> +
> +	ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
> +	*idcode = ret_payload[1];
> +	*version = ret_payload[2];

You don't check ret for an error above but still pass the return values
here. Perhaps it makes sense to return with error above instead?

> +
> +	return ret;
> +}
> +
> +int zynqmp_pm_efuse_access(const u64 address, u32 *out)
> +{
> +	int ret;
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	if (!out)
> +		return -EINVAL;
> +
> +	ret = xilinx_pm_request(PM_EFUSE_ACCESS, upper_32_bits(address),
> +				lower_32_bits(address), 0, 0, ret_payload);

Same here.

Thanks,
Stefan

> +
> +	*out = ret_payload[1];
> +
> +	return ret;
> +}
> +
>   int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
>   {
>   	int ret;
> diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
> index 73198a6a6ea..7f18b4d59bf 100644
> --- a/include/zynqmp_firmware.h
> +++ b/include/zynqmp_firmware.h
> @@ -453,6 +453,8 @@ int xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
>   int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
>   int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
>   			     u32 value);
> +int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
> +int zynqmp_pm_efuse_access(const u64 address, u32 *out);
>   int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
>   int zynqmp_mmio_read(const u32 address, u32 *value);
>   int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value);

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
