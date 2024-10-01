Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED5ACE7D19
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 12:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24988891B5;
	Tue,  1 Oct 2024 14:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727784809;
	bh=wuLBmJWuf8YldX2Vpo1VJxeiRTjERueV+ojwPnYh9nE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oz1P6xqgfI418xKg8JMXCxjLKiN+8ay9hoCkmxRtaVsOgjCU4UYx6WvaBjF6Ztb7k
	 aLHaykXdckEjh7FLnG8MuPzkxmzLGPhn6Qpmw3jzTwKgxMvx7Q6KKA98DPnSLvVSMG
	 TqvpVGNel/e3BikB2vnOyG76bCH6pyNE+fLrXQbNuWMaz2enu/kVm8MY+hAm8DtbA4
	 2fQcXGO3uu0Zcwc3bR4laklMI1kh9fEbJPyGfnJl78oqz1w7Qer8x8/Q2DRTDQVD4q
	 IlRorIrX5VJbwTYEN6gZLPbAct6EGcB89lHHqWMb6ilqQc0fUuH3c6htLad/Z7xeXC
	 5YwoHmCKSf5LA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CF95889197;
 Tue,  1 Oct 2024 14:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727784807;
 bh=wuLBmJWuf8YldX2Vpo1VJxeiRTjERueV+ojwPnYh9nE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NGO/Kne9GSkcje+sTFg9RMgYXsNat/M9EcKo55Q3pknucSpzhFSsF+F5MUovVYiUC
 g7GZaOj4ZrrOZK9/DpDn6w9GhIEQdVTmFYbNLDW9dCd0OwxHcf7Iz/WmBgFA41uqdQ
 UkMpjmAqgUFIQ04uDQzyBhVvhi2nfyx8i5Qi8cHw2nceRsiCEc9oYkmq+La3/vgSme
 JkS8gfFDfxH55tl/QAGDHBO9ymRLu/FPFGuaPOFaqcD20lAywjLV7guaZAyrozo4T3
 ruteHymvLdY5oblQTxxJnEMBenYv4qTZJymc3PGE6cS3OyLuI14S6goDQTOuqgQ4o9
 MLm67EEXEjFiQ==
Message-ID: <ba437b1f-7bcc-4f50-8cad-02479db29dac@denx.de>
Date: Tue, 1 Oct 2024 13:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] usb: onboard-hub: add support for Microchip USB5744
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
 <20241001050529.17922-4-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241001050529.17922-4-venkatesh.abbarapu@amd.com>
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

On 10/1/24 7:05 AM, Venkatesh Yadav Abbarapu wrote:

[...]

> +static const struct onboard_hub_data usb5744_data = {
> +	.reset_us = 10000,
> +	.power_on_delay_us = 10000,
> +};
> +
>   static const struct udevice_id usb_onboard_hub_ids[] = {
>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
> -	{ .compatible = "usb424,2514" }, /* USB2514B USB 2.0 */
> -	{ }
> +	{ 	.compatible = "usb424,2514" /* USB2514B USB 2.0 */
> +	}, {
> +		.compatible = "usb424,2744", /* USB2744 USB 2.0 */
> +		.data = (ulong)&usb5744_data,
> +	}, {
> +		.compatible = "usb424,5744", /* USB5744 USB 3.0 */
> +		.data = (ulong)&usb5744_data,
> +        }
> +
>   };
Consistently indent with TABs and drop the extra newline after } .

Does checkpatch not warn about this ?
