Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012A7C36005
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 02:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419DB81D27;
	Sat, 22 Mar 2025 03:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742611805;
	bh=HwYMTbCzA7a9f7A+QE3eId0Vt/m/jchelVtZOLk0rR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bFcce5S/+dpTiPq0sWNAAqYFPBHRYp4V6wG4ed5STEYdbk2K8cgzhu/d6vxK01RuI
	 bysUR7jbh6Zr4d7PtuVTsBBF9+kDJCR76g4MKpV7cM/rcu4NNYv+BDYLQM1bEKjxTG
	 qOFz4f2iNlsrOk7xmEFzZISe2IAEYLqlN9EN4uzanClyrPlxtSsyDRqQOgCUBMU27I
	 gx+pqB/PMCWUUTJ5m78rTBsJrS+jfK4RWluWN2mlhy0YmWLUuGHHC+UzNwsu0DNBY9
	 HSLZUt2nsQdZTjxEETuRa2cFpxklwsR0te14weigV/1NmpWXBzMzFGSupVHMKpyywp
	 TVD0IY2O0Kf7w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EF8481C67; Sat, 22 Mar 2025 03:50:02 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21656806FC
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 03:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="QXpuxMZD"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E70A0101E9016; Sat, 22 Mar 2025 03:49:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742611799; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=HwYMTbCzA7a9f7A+QE3eId0Vt/m/jchelVtZOLk0rR4=;
 b=QXpuxMZDEXlH3dehMPlX+eA7e3PzbH0WtQFyDV3HJ6AfIeEFmGdGeHHXgKkMtcBPruaAHi
 Ak7gBNk2kevRFtqUHHFT1D/VKOjtl4HHQNhr/5pkuo9x/4So+H6shQT1UjHkgpLPyRt4Op
 qxramRwQ+mTlaeww7ebl1q3S12Ba0ut0bPZxp9VfnErGF3WnUz096+urQsGa95hvsGyTm2
 /AoxbCPQ/u/wL6e9w3As2i4nEvQgKnlKu7iRDCpukQVty6MBSUWQxI7j/rfgDLFokqmxLf
 Kaf1Binsl1nJYqg1kkCPWBVq2x5F618a2ioV0lUHa7kSEt4up0vT6j/CDKHn/g==
Message-ID: <78f7d9f2-6226-49bb-8568-41e7ca0cdaba@denx.de>
Date: Sat, 22 Mar 2025 03:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/19] clk: scmi: check the clock state/parent/rate
 control permissions
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?=
 <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-7-f2c8ba815f89@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250321-imx95-v1-7-f2c8ba815f89@oss.nxp.com>
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

> +static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
> +{
> +	u32 version;
> +	int ret;
> +
> +	struct scmi_clk_get_permissions_in in = {
> +		.clock_id = clkid,
> +	};
> +	struct scmi_clk_get_permissions_out out;
> +	struct scmi_msg msg = {
> +		.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
> +		.message_id = SCMI_CLOCK_GET_PERMISSIONS,
> +		.in_msg = (u8 *)&in,
> +		.in_msg_sz = sizeof(in),
> +		.out_msg = (u8 *)&out,
> +		.out_msg_sz = sizeof(out),
> +	};
> +
> +	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &version);

Would it be possible to query the version in .probe() once and cache the 
value in private data ?

> +	if (ret) {
> +		log_debug("%s: get SCMI clock management protocol version failed\n", __func__);
> +		return ret;
> +	}
> +
> +	if (version < CLOCK_PROTOCOL_VERSION_3_0) {
> +		log_debug("%s: SCMI clock management protocol version is less than 3.0.\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	ret = devm_scmi_process_msg(dev, &msg);
> +	if (ret) {
> +		log_debug("%s: get SCMI clock management protocol permissions failed\n", __func__);
> +		return ret;
> +	}
> +
> +	ret = scmi_to_linux_errno(out.status);
> +	if (ret < 0) {
> +		log_debug("%s: the status code of getting permissions: %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	*perm = out.permissions;
> +	return 0;
> +}

[...]

> @@ -156,29 +267,44 @@ static int scmi_clk_probe(struct udevice *dev)
>   
>   	for (i = 0; i < num_clocks; i++) {
>   		char *clock_name;
> +		u32 attributes;
>   
> -		if (!scmi_clk_get_attibute(dev, i, &clock_name)) {
> -			clk = kzalloc(sizeof(*clk), GFP_KERNEL);
> -			if (!clk || !clock_name)
> +		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
> +			clk_scmi = kzalloc(sizeof(*clk_scmi), GFP_KERNEL);
> +			if (!clk_scmi || !clock_name)
>   				ret = -ENOMEM;
>   			else
> -				ret = clk_register(clk, dev->driver->name,
> +				ret = clk_register(&clk_scmi->clk, dev->driver->name,
>   						   clock_name, dev->name);
>   
>   			if (ret) {
> -				free(clk);
> +				free(clk_scmi);
>   				free(clock_name);
> +				free(&attributes);

Do you really need to free() an u32 attributes here ?

>   				return ret;
>   			}
>   
> -			clk_dm(i, clk);
> +			clk_dm(i, &clk_scmi->clk);
> +
> +			if (CLK_HAS_RESTRICTIONS(attributes)) {
> +				u32 perm;
> +
> +				ret = scmi_clk_get_permissions(dev, i, &perm);
> +				if (ret < 0)
> +					clk_scmi->ctrl_flags = 0;
> +				else
> +					clk_scmi->ctrl_flags = perm;
> +			} else {
> +				clk_scmi->ctrl_flags = SUPPORT_CLK_STAT_CONTROL | SUPPORT_CLK_PARENT_CONTROL |
> +						       SUPPORT_CLK_RATE_CONTROL;
> +			}
>   		}
>   	}
>   
>   	return 0;
>   }

[...]

>   enum scmi_clock_message_id {
>   	SCMI_CLOCK_ATTRIBUTES = 0x3,
> @@ -738,6 +739,7 @@ enum scmi_clock_message_id {
>   	SCMI_CLOCK_RATE_GET = 0x6,
>   	SCMI_CLOCK_CONFIG_SET = 0x7,
>   	SCMI_CLOCK_PARENT_SET = 0xD,
> +	SCMI_CLOCK_GET_PERMISSIONS = 0xF,

Better call it SCMI_CLOCK_PERMISSIONS_GET to be consistent with the rest 
of these fields , unless this is some SCMI specification name ?

[...]
