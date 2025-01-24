Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03425C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A357A80BA4;
	Fri, 24 Jan 2025 16:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737732408;
	bh=ibADOhneViXgC9E0/MTZziHYUYt/uB5RNYBLOGut97Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jPGdcTOpluIBhagFnuxvOgw8CL53RuFZ+4rvpp/xMpcy2yJt3HoAI2ad/bDvOzyPj
	 juUzFNtydVNGEwfEBV/RuDGKTubx+/gLfRC6XGqlzNFgwTzawR2ShttJdMgjq7eyZN
	 FqRC/MrybvyqSO7JKgCYGOksGDy+z+9KAwYJpmu4NHeoZCJ0X+Dzaw8CQF2NSoUdmS
	 fEGkbhZdSkI5fiak1eZkFGphvQizRXMah6BoTECOyU9jXeBye6xnYd30jf4gFPjOTY
	 KLKA3GtWbdg42YJ6Oom16haa1U1RovXYkgKMltSjT6bN/2dqk77r1j65nuij3W7UyU
	 uyyqbK+a0xhSQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D27780AE2; Fri, 24 Jan 2025 16:26:47 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D86980B9C
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Ip+0aXU4"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A40DB108860C0; Fri, 24 Jan 2025 16:26:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737732405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibADOhneViXgC9E0/MTZziHYUYt/uB5RNYBLOGut97Q=;
 b=Ip+0aXU4v7P+b7avoWRCsb4eC5SH1W66IcadXnDkey8ot9BGd0AcaLZqFVRyd4Aoml4/ni
 zONuBnbIWfQWJh6fjaqqvF3vLzlVO363W1Slgqpox/W1ymhzy3jpNX6M63KRQqTXdE7ZcW
 GWQczK8DN1N937radOC4zk/SAZplG6C/3EhwXWSOmBbGPYXLpylK1TODN++cOltMpPlciq
 cLaPFOAYwV0SKRFKu35VrdLn4+/bEBKuRRZMmc6sBcbVwzr+N4Or6P7PUDJn2z4WQEKKTO
 RLCRAZSMWmjUMMYST67EWjDW9pHK4QU13EpAnzZSK4YcbZjeLy286boAoVT2HQ==
Message-ID: <02da13d2-4f4d-4203-b5d4-3ec0220cbfd6@denx.de>
Date: Fri, 24 Jan 2025 16:00:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/20] tools: imx8image: add i.MX95 support
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo <alice.guo@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-17-93b28a514dea@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250115-imx95-v1-17-93b28a514dea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/15/25 2:29 PM, Alice Guo wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> i.MX95 uses binman to invoke mkimage to create image container. 2 image
> containers are needed currently. The first one is composed of
> ahab-container.img, LPDDR firmware images, OEI images, System Manager
> image and u-boot-spl.bin. The second one is comsisted of ARM Trusted

comsisted -- typo.

[...]

> @@ -586,8 +639,10 @@ static void set_image_array_entry(flash_header_v3_t *container,
>   			meta = IMAGE_A53_DEFAULT_META(custom_partition);
>   		} else if (soc == QM && core == CORE_CA72) {
>   			meta = IMAGE_A72_DEFAULT_META(custom_partition);
> -		} else if (((soc == ULP) || (soc == IMX9)) && core == CORE_CA35) {
> +		} else if ((soc == ULP) && core == CORE_CA35) {
>   			meta = 0;
> +		} else if ((soc == IMX9) && core == CORE_CA35) {
> +			meta = CORE_IMX95_A55C0;
Why is this core == CORE_CA35 and not core == CORE_CA55 here ?
