Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3941CCAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 07:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8C3583045;
	Tue, 30 Sep 2025 09:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TM++zHpL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42C76834D4; Tue, 30 Sep 2025 09:50:15 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B48C828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 09:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A29F603FA;
 Tue, 30 Sep 2025 07:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAD7C116D0;
 Tue, 30 Sep 2025 07:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759218611;
 bh=8unLluqhNT0KJw2xAm88xaJnhxMu+Dgv2ks35FrOWDQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=TM++zHpLIk01sWypPsP36NG1PjbsZUr1Q1LtGo0BIBxTKFd6Ei0Gnbr4MHeeloQX5
 E4h7JsPwQKAMLIsYeyDxaqjwL8T1bCRzfBGQRdhbInM5+2KCZKF2fPHRfnvCgc541g
 kg6rfqotWe4vQcioN0d8DWejIcVCuOJ803PQUFBk9Jka4hz+wqutctEWCZ8Cn7VCtX
 C4K/JogW0fxN87o5IHmbLhsRIF09VCEgSAJFQIn/urPmFfCkDsZMTtFDYDb2GgesYI
 obdrT5NUBrPiKOFOVigdPQ/SFToAPVSAWSO+bAMHkEh0HNdmW6gKK+1omak82vZcGR
 rXIFSfPgxn1Sw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek
 Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de, Andrew Goodbody
 <andrew.goodbody@linaro.org>
Subject: Re: [PATCH] usb: gadget: atmel: Add missing null check
In-Reply-To: <20250929-atmel_usba_udc-v1-1-e1426271e12a@linaro.org>
References: <20250929-atmel_usba_udc-v1-1-e1426271e12a@linaro.org>
Date: Tue, 30 Sep 2025 09:50:09 +0200
Message-ID: <87tt0kidla.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Andrew,

Thank you for the patch.

On Mon, Sep 29, 2025 at 17:25, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:

> Add in the missing null check for udc->driver that is present at other
> points in the function before it is dereferenced.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/gadget/atmel_usba_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index 72f68dba3a741b7f0aac8ba89b83eefb5e0cce4f..f7a92ded6dab187475249874db37d81a07bf5b9e 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -1147,7 +1147,7 @@ static int usba_udc_irq(struct usba_udc *udc)
>  		reset_all_endpoints(udc);
>  
>  		if (udc->gadget.speed != USB_SPEED_UNKNOWN &&
> -		    udc->driver->disconnect) {
> +		    udc->driver && udc->driver->disconnect) {
>  			udc->gadget.speed = USB_SPEED_UNKNOWN;
>  			spin_unlock(&udc->lock);
>  			udc->driver->disconnect(&udc->gadget);
>
> ---
> base-commit: 9710d98e8942151fc0c62d54100d9d27e8263d04
> change-id: 20250929-atmel_usba_udc-046059597928
>
> Best regards,
> -- 
> Andrew Goodbody <andrew.goodbody@linaro.org>
