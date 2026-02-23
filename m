Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EAFEC1120
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 19:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2103883C39;
	Mon, 23 Feb 2026 20:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CZLZR6R8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD5A83C6E; Mon, 23 Feb 2026 20:07:39 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF2F383935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 20:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fKVjK04ZKz9tgZ;
 Mon, 23 Feb 2026 20:07:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771873653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1q+gnhPgIlIYazZht59S0yGs9dCZRpRUz030/53nHg=;
 b=CZLZR6R80TDPBbUFCub+lr2+6KRfpzEPCmsfNCv5sH+dQu0SfwAz1G3wUhE0DruBKxiRYB
 PNoVXhgtzZnN6pFS4I4lsaa1nQi3FckIZCAHMJx/ObkLcyAsiYddH+pWchJCayIT27KDur
 RxDPXOeDozFMvKdbG80pNtinug7yRrYubeH/eTLF4gXgOVD7m76s6d7Dx8VOzyLMPDeA4x
 6W0AlZilItmQumYTmE0+i6X1W0p0KQrRMTuAIRdgWIXDXAck/YSZnghd3GJo79RPUXJcBG
 pe5yLTMq9fU1VejWo/ix0dEk4k6i79lDMLpX+oweY90wXLBW8GrLAjdvnEalGQ==
Message-ID: <3f9ffad2-15ec-4dc3-98f6-7a88df893204@mailbox.org>
Date: Mon, 23 Feb 2026 19:55:28 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: Fix timeout check in usb_control_msg
To: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>, u-boot@lists.denx.de
References: <20260223022033.1286565-1-ronan.dalton@alliedtelesis.co.nz>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260223022033.1286565-1-ronan.dalton@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c48fafcf499c6358a61
X-MBO-RS-META: fymi7ptyb6iyaft87oy41ym7ps3t3ziy
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

On 2/23/26 3:20 AM, Ronan Dalton wrote:
> The timeout check after the while loop in the usb_control_msg function
> checks for equality with zero, which is incorrect because timeout will
> actually be -1 after exiting the while loop due to a timeout.
> 
> Currently this means that -1 is usually returned by this function when
> -ETIMEDOUT should have been returned instead.
> 
> Fix this by comparing timeout with -1 instead. Add a check for
> timeout being negative at the start of the function and return -EINVAL
> in that case, since a negative timeout doesn't make sense either.
> 
> Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Philip Oberfichtner <pro@denx.de>
> ---
>   common/usb.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/common/usb.c b/common/usb.c
> index 6a4ad346f4b..2cbc432b131 100644
> --- a/common/usb.c
> +++ b/common/usb.c
> @@ -226,6 +226,9 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe,
>   	ALLOC_CACHE_ALIGN_BUFFER(struct devrequest, setup_packet, 1);
>   	int err;
>   
> +	if (timeout < 0)
> +		return -EINVAL;
> +
>   	if ((timeout == 0) && (!asynch_allowed)) {
>   		/* request for a asynch control pipe is not allowed */
>   		return -EINVAL;
> @@ -259,7 +262,7 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe,
>   		mdelay(1);
>   	}
>   
> -	if (timeout == 0)
> +	if (timeout == -1)
>   		return -ETIMEDOUT;

Can you convert this poll/timeout sequence to include/linux/iopoll.h 
read_poll_timeout() instead , to remove another ad-hoc polling ?

Something like this should work:

"
volatile unsigned long val;
ret = read_poll_timeout((volatile unsigned long), val,
    !(val & USB_ST_NOT_PROC), 1000, timeout * 1000, dev->status);
"

usb_bulk_msg() may benefit from similar update.
