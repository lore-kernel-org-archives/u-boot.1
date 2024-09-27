Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F38CF6482
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 21:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 382AA8915F;
	Fri, 27 Sep 2024 23:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727474154;
	bh=BD06Ph8UDvFEGZmRkJf0+5e0Opsybw8hDos3+SNgynY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZrnWu8uX1g/pCzLct96Vy7Xlo1E8N/XzDH+jAPXwFwfeshQ3AgA2vru+7HL7lY33S
	 XoYO7MIx7tC432c6Zr3f4CRkdp0tdTqsFOt1Y80cvmgDKi2zn/3F0NN1pRH4Oeg9Si
	 n4CJWNvaeAub9bx0am2Be6E6+dHyVTyFl4JUbaCYYWU7EM4ztcaXB+GjUqFLoYNcOc
	 f52YRUI5h/cNv4tpeP0eeEaojuYskyTbw0aUgWnScRBKzcCYhImGbeTmYhBRDAbsFq
	 UFHPh5UlF1jKjjf6z6sHLGBBjdM+hvolH9rDZyvV6uigudPBMErdrLucTBnfZ2T4yt
	 BjMS6dROTWwCQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9329389142;
 Fri, 27 Sep 2024 23:55:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727474152;
 bh=BD06Ph8UDvFEGZmRkJf0+5e0Opsybw8hDos3+SNgynY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YiKZwFpbk/GOlgDPKLs4sSZBmdicf9Zl2ble3Y/xyu7phcRJdT27LT/a/NmWOwRXz
 apie4pSGweLPwT91yXhbyBbNhbSY32BYqoUUG2Jk2Leo/KEHQldTYvssiK9gg093im
 ikDziwyjgFT0XJjKvU8M2v0vvVw6Mtnd7EtIDWCH7r3J4uRBRxSQY6WvmdbQJWRCWg
 53n0BRd9xpQJUx8xz8nJXd5X3rTRBxAtUbGKsk25YlnNqJxBNrCOfJMWPLWeBTfECA
 wvHEEXISpRa3Nu/LQChi50EP95wYX52ZMeMxYzQNk9ADm4cdpyphhHL6waHzQuU561
 gNGJ1P8x5yQ/w==
Message-ID: <1bba9e4b-621c-4b94-befe-a3eb468a8b3d@denx.de>
Date: Fri, 27 Sep 2024 22:41:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
 <20240927070137.21816-6-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240927070137.21816-6-venkatesh.abbarapu@amd.com>
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

On 9/27/24 9:01 AM, Venkatesh Yadav Abbarapu wrote:
> The .bind function is implemented to bind the correct
> "half" of the hub that the driver wants to bind,
> and returning -ENODEV for the other "half".
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   common/usb_onboard_hub.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 00808ed45e..9c50ca09c9 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -162,6 +162,25 @@ err:
>   	return ret;
>   }
>   
> +static int usb_onboard_hub_bind(struct udevice *dev)
> +{
> +	struct ofnode_phandle_args phandle;
> +	const void *fdt = gd->fdt_blob;
> +	int ret, off;
> +
> +	if (dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle)) {

Return the error code:

ret = dev_read_phandle_with_args()
if (ret) {
...
return ret;
}

> +		dev_err(dev, "peer-hub not specified\n");
> +		return -ENOENT;
> +	}
> +
> +	off = ofnode_to_offset(phandle.node);
> +	ret = fdt_node_check_compatible(fdt, off, "usb424,5744");

return fdt_node_check_compatible(...);
