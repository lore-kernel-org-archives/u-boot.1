Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B037BCCFA04
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 01:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13748839DF;
	Wed,  5 Nov 2025 02:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="n5Ci1GFA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BAA4839FD; Wed,  5 Nov 2025 02:41:10 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA3D183968
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 02:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d1Shd5KrDz9ss6;
 Wed,  5 Nov 2025 02:41:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762306865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ctIvF+ur77eEz7dttiQrrLcU+v4cDk6wcqKe6tnOQZE=;
 b=n5Ci1GFAihI0+88dM/i8J/gzH4YrzPeFYKxWyyciEEMOYZ+sIYcyXslxQd0sQemjm8VNLx
 W/r8/Uz1oWCSFNXSQjuAbgmEZK106edOyGbq1qBEQLftw9xUGrumxmzsE+9bLIE7S/Soaa
 /F24/CtlA3yB7mZ9eVidANlbz6t27wECWuthcl9MSU3kWLSnsz/BgXpIHmGyET8MqqkJW/
 InvHdX5NmtsLZSfXuVis37PSJesyFNuIhEDbV+VaUL1wg4T0ETVDStFDoyyhu57DhnRidq
 TC4rfZoecth7x7ko5Eh3lr3K3+Nynr3ZQdSSe0pLhU0CmY17iDGZ/9dvfLECMA==
Message-ID: <f1efd15f-590f-433f-b579-5aae9f4a18f8@mailbox.org>
Date: Wed, 5 Nov 2025 02:40:53 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] usb: typos 'requird', 'current'
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
References: <20251105000751.91889-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251105000751.91889-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 3i1sshomhgtziag5u4mb1nyxzf6sokua
X-MBO-RS-ID: 484f4afa785da007096
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

On 11/5/25 1:07 AM, Heinrich Schuchardt wrote:
> %s/requird/required/
> %s/current XHCI/currently XHCI/
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   drivers/usb/host/usb-uclass.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
> index 7247245a702..1c74d6fd39a 100644
> --- a/drivers/usb/host/usb-uclass.c
> +++ b/drivers/usb/host/usb-uclass.c
> @@ -134,7 +134,7 @@ int usb_alloc_device(struct usb_device *udev)
>   	struct udevice *bus = udev->controller_dev;
>   	struct dm_usb_ops *ops = usb_get_ops(bus);
>   
> -	/* This is only requird by some controllers - current XHCI */
> +	/* This is only required by some controllers - currently XHCI */
>   	if (!ops->alloc_device)
>   		return 0;
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

-- 
Best regards,
Marek Vasut

