Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21C4E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 12:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51DD7800DF;
	Wed,  8 Jan 2025 13:53:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736340815;
	bh=vWTNrqLZqzk8ybPUWB1aJngiVebOBAEq3+kH25qwnpg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k3GI8PepCIil/0slw7mO1fM7YWtYsuhvbm1NjJscl5QU/jnTTBCoyBHL48t3w9SNv
	 XWE2/BroYWMCXx82XFXtPzNn9+dAdiDnKFALyO3k8A//mVfV6tpcmCMXUShP5fYG10
	 jwHIHf8NiKImLSKTR3tMa5nYQZXGyafci9VRAfhMpkzd4fkw7OpJspp6imRBe7GYDw
	 b8BnZeAJ7Qw2jPtP5tPa+dNHVf/3wVecW1mKA0Gl0raoe3iQrkSkVmOTQY402tfpXZ
	 UAhgGk7jjnnPssZWXrnouxWqOohikbwcCBmNeoEGflPui3vl4J/PE4KDsALezKlYDD
	 YCgH5KvHPaVBg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C8FD8036B; Wed,  8 Jan 2025 13:53:32 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F9328006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 13:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Fj2IOSXU"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 703C71092C1DF; Wed,  8 Jan 2025 13:53:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736340808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vWTNrqLZqzk8ybPUWB1aJngiVebOBAEq3+kH25qwnpg=;
 b=Fj2IOSXUCruOeDYc14+fk4c7MeJxwAmfLzoJODE9vRz+lyRAPmeaXpLOwbcB6GMv7Shud7
 xpmtTofTfq41AGjrT8UEwxo5zm+eHvUQESbdC5NipWthFFH+4NKaDtOxN19/xqFNj5V9PR
 xgEmOhEs3ckEqgAPD941aC8dioVcZjwnL7yzMvEV+05fYUW5gmB5xwt6Aj+78Sld4N3kec
 D0RYRUvXGn030KEOd2y+JZ8mkoGeGBr/NiE3Dv3BT2yGSXYcoCCDyCOA0+f4J8US1D9kiM
 W4H4SUJuPq/jP+PbGk6Yw1EYdnbdXYxQpF0S0VMRFsdKeENeadFyff3LYGV3yQ==
Message-ID: <4215c58a-50c0-4e7c-9d9f-64a8bdd6e9de@denx.de>
Date: Wed, 8 Jan 2025 13:29:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: ehci-mx6: Add i.MX95 support
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Mathieu Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
References: <20250107225919.196131-1-marex@denx.de>
 <CAOMZO5CzsOpKHpuron5JwbHqHMJLT5LRPutJfWk5amzXdYpMqA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5CzsOpKHpuron5JwbHqHMJLT5LRPutJfWk5amzXdYpMqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 1/8/25 2:19 AM, Fabio Estevam wrote:
> On Tue, Jan 7, 2025 at 7:59 PM Marek Vasut <marex@denx.de> wrote:
>>
>> i.MX95 uses the same USB IP as i.MX8MM. It can then reuse the ehci-mx6
> 
> s/ehci-mx6/ehci-mx7
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

The driver is still called ehci-mx6.c , the Kconfig symbol contains MX7 
in it, but we still use the ehci-mx6.c driver .
