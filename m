Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC34606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HzVCM0yD;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=hCMYgcNt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2B5D81233;
	Wed, 18 Nov 2026 22:32:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fh6XryZ7JeNb; Wed, 18 Nov 2026 22:32:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EC8E280FA9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795041160;
	b=TQCmLwwv227b+GWCopNAbsBYDerxC7En5aXFuEApUcbqO/wBMmA2TKKyCIMODGOrfeDn
	 J0uWrZkND+/SQvm+VEplG9jUp9gT0IWxN8iLpczB1GCxfay+wbVh9uTUiTFpyzcSfj7sU
	 nvtF5jkAAEvV/dyPOVGsCgjWyFaqLHbavYd6ID2rFWA7+GkEjEsSQz4aR0QL+Y1pxw/X9
	 Gkv+CweQSG5eByXU9bZOMqNqDmSS2p3WpnkSR+/V3wM/z3ofbJpyv00+2Tb3QcvvCcrhf
	 81Nwg8Q1wcmVKImEG1FRcNqdS1jnH6t7MozxoTso6WmjpMBnRrQigLial8fnB43pUsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795041160;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fR3bcypm3mVEx8pNkKU5LyZ5AQNYrFswBbsPFM2n96g=;
	b=drOzyxmEWL2Dgi0foUM3TpAgxYkFpmyGSHHUd16bqhHm7h0Tog7ttyGLftI25S1NZt3B
	 YAhTG6t2QXAhH+KI6d5Xsz4QVrB6S9BqWJk5Vg9fGXAHJHbuDaIDUuy/GE8RTiLmkdR2V
	 zny33k3Ou+otHWxL9iPnG62KymFuLSi+V5/3S9oT9xX9kG8fhnR5pOzb/tPLz+V7Ankzv
	 r1sTx43RR+o1Thck4cyVk3XS43+i4eREwTpRzoPru8ga2k4ZCePK7pN7f+TFHP/jLvPNB
	 +Xc0W6O41ynLFNer91K5H+72r4/DCklKCzWVHSH3PcHOP5I56/+1uC92DrOg/wab7vw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795041160;
	bh=fR3bcypm3mVEx8pNkKU5LyZ5AQNYrFswBbsPFM2n96g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HzVCM0yD0E5XtruhTp8Pf/0RIX3l4z6+rClJtLepOJNf4n99DP9npLljpGTWgVyxT
	 LZH+taW/E4bI5XvvrX2hBslWKG+P4FwdGgfdvdgNA3HfLZp69U+R253e7fWEjYjgK9
	 4Xl/MYsXDiTWaVcutOFMp9yEa57uyZtTptAhdivAUapioItCd3Bgfx1vC6IFfo0ArC
	 00nC+GWdWJjTB51QMzKXXnrFnBppsISC9yJ+1AgJqwpT6c2eId3/2sSujSQ9E4H8HU
	 jNKPtxLGZRALiG9FnbNygZd93yHNavBHVppB1DFIwPUJ2Oygq6MoB2XHlzL8pvRfbL
	 kUiUsAHfOT5aA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC8E280FA9;
	Wed, 18 Nov 2026 22:32:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 94F1E9F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 22:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86E574084A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 22:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0j3aiBAXLHG3 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 22:32:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 64FFC40722
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=hCMYgcNt
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64FFC40722
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 22:32:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B81B910D66E; Wed, 18 Nov 2026 23:32:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1795041151;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=fR3bcypm3mVEx8pNkKU5LyZ5AQNYrFswBbsPFM2n96g=;
 b=hCMYgcNtt4nQTqOkIigjYxmFh37AzkP8bljN2m96NpEhUPvzEkiszjueIPCJh6Rh5pVY6J
 Tl/1Xl7zVXkEwGW2dgxrdnznNW0IXaqVYwqXIKsXUzBlNZYCMnSNKgRxKCeUz0D4EMdKG7
 1Maz9DITJRxq0AOATcgx93iqvlURc5YpIFKblts50+Ttl5ZxXzGXcXcC3wD4N4V6q6tV3p
 Hqc9hX9hFcFzrevOkLsWRvdMdJosotRXf/zmD6uZRHJP6PlT0AUVS4jJO7eVaA4iSphib/
 71d9rbJIzKDnZ6lJVNL8tNUu/sVe97hbn4UALdWgkuCOeHaT6ZUtrbyN2uOGYQ==
Message-ID: <d581d8b9-9fe3-4bcb-a39b-2283c5cf9c60@nabladev.com>
Date: Wed, 18 Nov 2026 07:50:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: usb-hub: Wait for port reset to complete before
 power on
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Shantur Rathore <i@shantur.com>, u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20261118-usb-hub-wait-port-reset-v1-1-3d1cd9a1cfc3@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261118-usb-hub-wait-port-reset-v1-1-3d1cd9a1cfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 7:14 AM, Balaji Selvanathan wrote:
> usb_hub_power_on() sets USB_PORT_FEAT_RESET on each port of a USB 3.0
> hub and then sets USB_PORT_FEAT_POWER right away, without waiting for
> the reset to finish.
> 
> On Qualcomm Shikra CQS2390, with nothing attached to the DWC3
> controller, PORTSC write for USB_PORT_FEAT_POWER on the USB 3.0 root
> port happens while PR is still set. This raises an asynchronous SError
> and "usb start" resets the board.
> 
> Poll the port status until the reset bit clears before powering the
> port.
> 
> Tested on Qualcomm Shikra CQS2390.
> 
> Fixes: 33e06dcbe57a ("common: usb-hub: Reset hub port before scanning")
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   common/usb_hub.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/common/usb_hub.c b/common/usb_hub.c
> index 6a4bcec00bc..c03169f9edd 100644
> --- a/common/usb_hub.c
> +++ b/common/usb_hub.c
> @@ -162,6 +162,25 @@ int usb_get_port_status(struct usb_device *dev, int port, void *data)
>   	return ret;
>   }
>   
> +/*
> + * Wait for a port reset to complete.
> + */
> +static void usb_hub_wait_port_reset(struct usb_device *dev, int port)
> +{
> +	ALLOC_CACHE_ALIGN_BUFFER(struct usb_port_status, portsts, 1);
> +	int i;
> +
> +	for (i = 0; i < HUB_LONG_RESET_TIME; i++) {
> +		if (usb_get_port_status(dev, port, portsts) < 0)
> +			return;

Does this need error handling ?

> +		if (!(le16_to_cpu(portsts->wPortStatus) & USB_PORT_STAT_RESET))
> +			return;
> +		mdelay(1);

Why 1ms delay here ? Use timer_get_us() or readx_poll poll loops ?

> +	}
> +
> +	debug("port %d: reset did not complete\n", port);
> +}
[...]
