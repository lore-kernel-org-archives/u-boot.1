Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE8FC282D1
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 00:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC9C680F4C;
	Fri,  7 Mar 2025 01:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741306809;
	bh=XeF7t3vwyVHsQlYIwK7z03x+x0jDl1ACJA8YpRBM9DQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UCYQt2seSsaIYYWkBt3Rey1SMifyhwDCUGRZa4m6chjZ0u8c1sLYxFj+zrHgaJfWB
	 Dqd6dkohhvmRjDyCc/1GAYXna5PA0oAO4aaBbP25dgouapjE6W1CIVuONUb9inRcC+
	 PIP1QrPqNoaRD6FXMlZkMG6AausbAjXx7kpySzLblS1vDSAUz242Zrp5RqmPu2MJ5n
	 D7D5viOETarTXVSXfXeONJ9RnNbyg6l8nG/Ng/mnwuICh4vvLREzhuZyP9E8mEpgsV
	 E6+G+4u0rEPKxM2NKttyMlNycbwddBtxDbLMItAQaxZK75+7WQwNtbkel/WGhk6FMR
	 07zZIPGSb15lw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B84E1805D7; Fri,  7 Mar 2025 01:20:07 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B545B81417
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 01:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="dmQhIeXR"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 660B41038191A; Fri,  7 Mar 2025 01:19:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741306797; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=XeF7t3vwyVHsQlYIwK7z03x+x0jDl1ACJA8YpRBM9DQ=;
 b=dmQhIeXR8gjeJ3J5DiIzPDg8H7ppwUuFqmhTwbgNcz92nUr6bPWyWjitJfQmOSj6MxSYzZ
 sBqRi05aOYamyMVpOAChKpT0S672nmehVsg5bCKvmie2jX5ES+4I8Vf2VqU/OXZRprdSAo
 NsEP2qjGMghH5eNLHaznG1u3Il6MTUkNUTvkGJLtTfyH7y39SzCzrHhzlmzZ7LxRu5fA86
 IkWJ1wXap8gDpBUFUTk+hCITGWi9puH3J+HExiBM6D4VRI4jzLNWIe3HbVVljoweozZzsd
 8d5ZFW+2b+yq3re72kPUpn+ohMrhS0Map8f4AhfQiDQPIlk1J8vvCk+AUXpCzQ==
Message-ID: <a05cf63b-820d-4b27-8f66-37a6e6c7b372@denx.de>
Date: Fri, 7 Mar 2025 01:04:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Brian Ruley <brian.ruley@gehealthcare.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
References: <20250105203714.158480-1-marex@denx.de>
 <CAFLszThQvKZfwsQudbOfDvnCMe=aeY=ppUhHKj6nV8=PtadDaA@mail.gmail.com>
 <1b77dd3f-e0f3-492b-981f-1dc9962f1732@denx.de>
 <CAFLszTha01kuuPwz0PnbuwvVqv40UDd8mrEsZBeL=z=6k0=ZDA@mail.gmail.com>
 <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
 <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
 <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
 <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
 <cc2896cd-eb08-4c26-b86c-a4f37ccf70b5@denx.de>
 <CAFLszTh6f8efphOYgv7wMU=z6zt0E=uiG6RK5O8hE=q1WtEhhQ@mail.gmail.com>
 <dc010565-03b3-48f6-85e8-1b79e17be14d@denx.de>
 <CAFLszTjcdFKn2ayTrLx930b+P5ebBfX_EE8-aS8sOJTBsqQKHQ@mail.gmail.com>
 <8647abd3-9378-42cf-a1fa-302c7891d439@denx.de>
 <CAFLszTiw01KB4ipwqi1b64A4MP3SyU=zFRymV4moiJ_nBtnHRw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTiw01KB4ipwqi1b64A4MP3SyU=zFRymV4moiJ_nBtnHRw@mail.gmail.com>
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

On 3/7/25 12:30 AM, Simon Glass wrote:

Hi,

>>> One of the main goals of binman is to reduce the work needed to create
>>> a working image. If people have to go spelunking around the Internet,
>>> build it themselves, etc. that is not good.
>> What you are asking me for is not the tool itself, but key material,
>> which is generated by these scripts.
> 
> It looks like someone has done this here:
> 
> https://patchwork.ozlabs.org/project/uboot/list/?series=446218
> 
> so I think we are OK now.
> 
> I've applied that series to my tree.
OK, does anything need to be done about this patch ?
