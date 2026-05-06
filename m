Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B58FF8855
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 13:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8B7E8490D;
	Wed,  6 May 2026 15:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XNw7LscO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31D28490D; Wed,  6 May 2026 15:07:42 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08BE884903
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 15:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g9bJp5ZV3z9trX;
 Wed,  6 May 2026 15:07:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778072859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hk1pzF29n2IvzhLEOEYNz7f/tCUinXVzDR+2INThrmg=;
 b=XNw7LscOTCBaXeVncLLgV8/Z/1mG6v7giI6Tj0W72D5PRfT5iwgLVuYOw46JD2dDTUuMUR
 Ru/OaH7tiPkitjAERrijrdKCJvqEMRXAdLkJwB89JurRrGfe5t443MzAk+cvGinX7BuBOF
 3RAxeNazsa9g8qAY+r2NNGPJ13mDxwlxWpHXg3D3sI/rHhd2YCf1MPFSGHZPlDBjun3xH7
 X3VFuinSaOT43xDtW+fRqZL2Z8qzh+quKW/VWjYXdpbCV4d5IMUDk2V5roJPBwsqGWnvTm
 k17wTULTupp5TdQDWmG/gcMbzH4Rh367tSzENCdYKIsT18N0VWFlQF/MKUkVZQ==
Message-ID: <a74a7a66-c1f1-4d6e-b85a-49ecc8e2e882@mailbox.org>
Date: Wed, 6 May 2026 13:25:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: dwc3: Fix crash on fastboot exit due to incorrect
 memory free
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20260506-usb-v1-1-e0f426bb1e42@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260506-usb-v1-1-e0f426bb1e42@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 18ynjcqdeqdyn4ctf1ygnn1nr99y5uqj
X-MBO-RS-ID: b13564b8465580f9840
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

On 5/6/26 8:14 AM, Balaji Selvanathan wrote:
> The dwc3_free_one_event_buffer() function incorrectly called free()
> on event buffer structures allocated with devm_kzalloc(). This
> caused heap corruption and a synchronous abort when exiting
> fastboot mode via "fastboot continue".
> 
> Device-managed memory is automatically freed when the device is
> removed, so manual deallocation causes the heap allocator to access
> corrupted metadata.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/usb/dwc3/core.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 0dee14c8b59..be198041f08 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -208,7 +208,6 @@ static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
>   		struct dwc3_event_buffer *evt)
>   {
>   	dma_free_coherent(evt->buf);
> -	free(evt);
>   }
>   
>   /**
Does this need:

Fixes: 884b10e86a05 ("usb: dwc3: core: fix memory leaks in event buffer 
cleanup")

?
