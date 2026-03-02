Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E822EA4E04
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3777E83F63;
	Mon,  2 Mar 2026 14:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UY3aQvAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 228BB83F3F; Mon,  2 Mar 2026 14:53:54 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4895683F2D
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 14:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fPgQ64plPz9v7S;
 Mon,  2 Mar 2026 14:53:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772459630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CyQAl5loqlLOkZQW54reJGQOCeTvbz1OBiqiiYP368Y=;
 b=UY3aQvAWkz1KYt0LF9JvYGT1J7xT6lQenj5dO+Kk/9C16bJdWQc7stfIQDnseHRXYT0q0t
 WN+PCfc0aiq2RNERrcXSc0foxWkRwhL9f6wedFzcppbOU8bbc5MVUaBQLi6AniGdgPWySh
 qQlFTytwsGet4/dv5Tbwmm3uAT4K4WiQF3QTXFhIM69/OY6YcDuN44O5btQCMiRx5DQghz
 fNcWU70q6UQJSpVKPR5iS1cex2VhHVLcjRVwfPGut1CghNXKfny/6cvVG5jGQapVOHcoAQ
 emIOUGDy2BiVIPQmi27enUNkAJM528B52P/qdRMwhhrFkX9sdfClL5mGiuhaZQ==
Message-ID: <c1fba062-91e1-41f1-957f-114f255839f3@mailbox.org>
Date: Mon, 2 Mar 2026 13:59:50 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/4] usb: Convert ad-hoc poll/timeout sequences in
 usb.c to iopoll
To: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>, u-boot@lists.denx.de
References: <20260302044532.2891813-2-ronan.dalton@alliedtelesis.co.nz>
 <20260302044532.2891813-8-ronan.dalton@alliedtelesis.co.nz>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260302044532.2891813-8-ronan.dalton@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 27bd0b48bb81731ca9b
X-MBO-RS-META: rmte9jh39amckediiqj5fou45mi364ha
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

On 3/2/26 5:45 AM, Ronan Dalton wrote:

[...]

> @@ -276,19 +279,22 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe,
>   int usb_bulk_msg(struct usb_device *dev, unsigned int pipe,
>   			void *data, int len, int *actual_length, int timeout)
>   {
> +	volatile unsigned long usb_status;
> +
>   	if (len < 0)
>   		return -EINVAL;
>   
> +	if (timeout < 0)
> +		return -EINVAL;
> +
>   	dev->status = USB_ST_NOT_PROC; /*not yet processed */
>   
>   	if (submit_bulk_msg(dev, pipe, data, len) < 0)
>   		return -EIO;
>   
> -	while (timeout--) {
> -		if (!((volatile unsigned long)dev->status & USB_ST_NOT_PROC))
> -			break;
> -		mdelay(1);
> -	}
> +	read_poll_timeout((volatile unsigned long), usb_status,
> +			  !(usb_status & USB_ST_NOT_PROC), 1000,
> +			  timeout * 1000UL, dev->status);

Maybe this could use an error check here too ?

With that fixed:

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
