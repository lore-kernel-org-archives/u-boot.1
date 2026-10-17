Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1145CCF2C1
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 17:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CE10606CE;
	Sat, 17 Oct 2026 17:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W3bzcOh65ANn; Sat, 17 Oct 2026 17:33:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A8EB6606EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792258400;
	b=fgTcY5Kv8I9bK4GZlxYhv5BQLueaV3GiVnuPA3y2M3tIoRdIKw+Dx0tOjJjDznudsVty
	 rgNhZMLgRy5TgOH7x3zz56xIhvdBX5lV7oH7Mfo/efEGyuPY1QWAEeEakNnaz+BX24cNk
	 EY4IClZHQ3foP3/r+sl1rQ3srGHWaVcKuf88ohR5fZQnFf93s3hqEXRmsryrjgrmxrqkJ
	 AXscB0+CZyfdZvlYmyfQ3e+iCL/d4IOw9TDo9g6G7Dx0BFEST7YFGXNg5IDBAc0hPg8cj
	 Wz/nud398Si0AFP118ByhDUXW68fgT71wxNYoHh3yg3w++OvjIi6pzV2LTjHypF8ajg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792258400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tqiTyS34/tFKHi8yRpkInKxrP8i515G6+AZdhpHq/JU=;
	b=gEPy6jnYZb4OKV2xPgFMp9LlPs7L18btzN2KjBwbjnsi0VPw0W5GUW70tjuBBsqDfwem
	 wKovhh/4NeBqi3OT+NjgYeLmGRJNeqWWvfrL2wH6zI+SXH7MkIflM6EGdzSKomOJgZygE
	 ckd0mKMJJiPEYBKNaxevIlhZ5s8/x0tyYhmrMLGYlJZrhbq6fohVef9NGA8rzTi9pZENY
	 zGMbSn9yfQK2vZu4dPjfaSAuSY4/2EdJXwJG8cYwMb7YjjWyBMkeMqRwikkhCIQ1dqEii
	 odgI4rwqgfXT+lv504w85S9Aed9y6LigkVGAxWlo+aHNInIpsA6ZDH7mNDw5Hhzv95g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=KQOmkOd9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792258400;
	bh=tqiTyS34/tFKHi8yRpkInKxrP8i515G6+AZdhpHq/JU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YhX+WaJJH1CkHDMCoE9QOrQDqLRX3F7ZACw2/feJG5zq9ioqWBUrR7opnirsR26vV
	 nWWSbPW1zwciZzbo/A4pG6w0CqpVnVG7wdULxsMbJJCLQvmbovXOBLX1+0HfW5utB/
	 wllSx0GbsuPhqMu17m0BwWV2FMs52PBfOYW3tVGEd97IPMqR4IHqEnFkXAVRqmt9L3
	 a1CXpuptJx+rKLUR2VOWrd5rzosuEewxxtc+pGe1SJ/R7erUmumJBQVFvMvZXd4pp7
	 FQ+ykph0Wt8Pq3VwN1AisQYQMXVJfeYJQ8UjCy+TZP4fuzMFNWXqkNw/dreeEjPuGB
	 g+TaZ1WGYmoQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8EB6606EF;
	Sat, 17 Oct 2026 17:33:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1546C2A8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE4DA60674
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iP0aCmER597Q for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 17:33:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EDBA160675
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792258394;
 b=dkZrmwZvCP/kN4U9eVU7iRa7daQN4okcBMrL7dJJTuA/pj8OSja0nnqnC9+zcI7GxlA1
 3F7we4treCyDvyANetFBc3ZeAwY5HlPBpq6Bp3DTEwJi9wK8X/UnMKpmlHyrMmpAgE0YR
 vgiLEjPc0+ko2qxKApCPKksVlEGYUNAyA0KS1k8cbrdSMM8ifqYhVmTpVWW6Ovwyj8CMM
 82RCoeeVzJLi1n3OyoBLo1+59lPIeaKGagHr+1qEDXOMCHqbNAht707PdWb6MqdaJFH2y
 Wx0jcMOaYe2N7+zxpEYPDGFlgjrZDDKUiGoHaOAWWKQnLphJeeoztL9ltdMMeitvWgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792258394;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=tqiTyS34/tFKHi8yRpkInKxrP8i515G6+AZdhpHq/JU=;
 b=V+dZjyX8UlZHM80Tn7bxCheJ/YCjLSwBdIVU0TaXGuDUU9qog8jHIvt6jpaG5El26Wal
 nH4y1a0gyjPaIaElmE6tC/BmtmLdHiOitNip3VSS0mrmz1JD/xY4AkAB8hiaod1P0iQfj
 H1gEY8dvSZimk80T+vFwM8FUuidnE8D6aI7vSioa67UH4Z8mnU9C8XpW4Hu+hi7IMIFS2
 6zqBQSXYYpj8TQARnlGnhgYOiIANgKrXxb3og+322VVRCEAzDvnfBNd6OWnwrAcj4lcNg
 At4AsHohEufqsMD9X9EZeIDP/byMdaKW9Xyyiwy9RTqB/rI3pC0T1g416WZg+vQM8fA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=KQOmkOd9; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=KQOmkOd9
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDBA160675
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:13 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j6TRS4T8cz8v08;
 Sat, 17 Oct 2026 19:33:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792258388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqiTyS34/tFKHi8yRpkInKxrP8i515G6+AZdhpHq/JU=;
 b=KQOmkOd9QTinIj9fjFupbSmBPsZqL0s3QWLhNpzrbsSMcMQwMwf6CIrsmNFoOjFWmNCU0s
 CYezYUL+n6o1Lhq1g+vcIDkBu6QkYrpNmWMRdJLGqpJ6SpD125VJbFMLSINrCe6C2BBoeG
 11Z5pZ5M4UKnwo0u21m0eRaSWJP1l7Fqjag3MGyu6C24uDIjzOc910/OZgWAVUJcgUkzO+
 YFoLHlIJC8lvIIBKuUWFdCl07KWwll70vxepS49NINNG4gsoIFR5pwrJ5tie5Jm+i1wNiU
 Mx6gHvBT3jhx4xPip+57+YiydFzPjxKGm17pHHDlAylPOMKDY+kfV+DB846WzQ==
Message-ID: <b82cb67a-03ff-4c27-bbe9-882b37276310@mailbox.org>
Date: Sat, 17 Oct 2026 13:43:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/26] usb: gadget: udc: enable async callbacks on bind
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@denx.de, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <20260916123826.517181-10-anders.roxell@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260916123826.517181-10-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3e7bbfad32817948575
X-MBO-RS-META: zxiazfuxw4w4py4kd4e4euj4fw81wuxk
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/16/26 2:38 PM, Anders Roxell wrote:
> The dwc3 driver was synced from Linux v6.16. The new ep0 code only calls
> the gadget driver setup() when dwc->async_callbacks is set. In Linux the
> udc core sets this flag after udc_start. U-Boot never did.
> 
> Without the flag every delegated control request, like GET_DESCRIPTOR,
> returns -EINVAL and ep0 stalls. The device never enumerates, so fastboot,
> DFU and UMS do not work on any dwc3 board.
> 
> Enable async callbacks after udc_start, and disable them on unbind, the
> same way Linux does it.
> 
> Reported-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   drivers/usb/gadget/udc/udc-core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
> index a01a7e6dc21f..79f249cbb114 100644
> --- a/drivers/usb/gadget/udc/udc-core.c
> +++ b/drivers/usb/gadget/udc/udc-core.c
> @@ -949,6 +949,8 @@ static inline void usb_gadget_udc_set_speed(struct usb_udc *udc,
>   		gadget->ops->udc_set_speed(gadget, s);
>   }
>   
> +static inline void usb_gadget_enable_async_callbacks(struct usb_udc *udc);

Maybe this can be replaced by moving the function instead ?

>   static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
>   {
>   	int ret;
> @@ -968,6 +970,7 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
>   		driver->unbind(udc->gadget);
>   		goto err1;
>   	}
> +	usb_gadget_enable_async_callbacks(udc);
>   	udc->allow_connect = true;
>   	usb_gadget_connect(udc->gadget);
>   
> @@ -1164,6 +1167,7 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
>   			udc->driver->function);
>   
>   	udc->allow_connect = false;
> +	usb_gadget_disable_async_callbacks(udc);
>   	usb_gadget_disconnect(udc->gadget);
>   	udc->driver->disconnect(udc->gadget);
>   	udc->driver->unbind(udc->gadget);


-- 
Best regards,
Marek Vasut
