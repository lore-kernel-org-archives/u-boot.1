Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B296EC43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 21:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC78E84659;
	Sat,  4 Jul 2026 23:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Sgtv7QAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65AA1846FD; Sat,  4 Jul 2026 23:12:12 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ECC78341A
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 23:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gt3Gc3tgkz8tyv;
 Sat, 04 Jul 2026 23:12:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783199528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ByYDVNyCYBfdnR22Teor7kkmnbxJhXMsaCrBEdzMajQ=;
 b=Sgtv7QAZbVDsAyykD8pUSDwtaMtS3YV4Ubuk9tKZ7/rbx6vvFb41IFoSgm70iAqWNtNOkD
 khh29gmg9crbVBss3yUqKGjHXiR0IJHM6k0RRlvxBmcIpTodcDC0SuXVyeF9UL/16AadvD
 AEsGsC4AGq1WC9tlUR1hrPaTwtO7jGSfhxASmoBKna0XmcYCHIUUKlZiCKxla/s1tE5YhU
 14PjiKVtGaU43y3brwa1acqSfYPHksX+pTFSUgCYCVP9nKHIj0uiZpfWFmL/UYozzwkYDU
 t8mfHhKDy/zATzndjf337rbGg16Sy7O+TwpDtItbwDq3dMPgSUlOShUt9s4dlA==
Message-ID: <05a0a92f-1283-4a4d-b99c-85d4be7c9f45@mailbox.org>
Date: Fri, 3 Jul 2026 16:25:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: Fix timeout detection in usb_control_msg
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
References: <BESP194MB2805F883C01AC352DD5EC738DAF52@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <BESP194MB2805F883C01AC352DD5EC738DAF52@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: p343tza6yffphm1j5a8wu9k9ort79wse
X-MBO-RS-ID: 89e93f035e4961a6c95
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

On 7/2/26 3:59 PM, Francois Berder wrote:
> The loop exits once timeout variable reaches 0.
> However, due to the post-decrement operator, timeout
> is decremented and set to -1 upon exiting the loop
> if a timeout occurs. This means that:
>    - a break in the last loop iteration was considered
>    a timeout
>    - actual timeouts did not return -ETIMEDOUT
> 
> Fix comparing timeout variable to -1 instead of 0 to
> detect timeouts.
> 
> Found with smatch.
> 
> Fixes: 2fc8638403c7 ("usb: Assimilate usb_get_descriptor() to linux")
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>   common/usb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/usb.c b/common/usb.c
> index 6a4ad346f4b..5905b2b5d7b 100644
> --- a/common/usb.c
> +++ b/common/usb.c
> @@ -259,7 +259,7 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe,
>   		mdelay(1);
>   	}
>   
> -	if (timeout == 0)
> +	if (timeout == -1)
>   		return -ETIMEDOUT;
Please rewrite this to use read*_poll_timeout() instead of this fragile 
obsolete ad-hoc polling.

Thank you !
