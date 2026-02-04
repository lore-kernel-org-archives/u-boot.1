Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E96E95360
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 09:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4512B83A24;
	Wed,  4 Feb 2026 10:43:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="qAo+IHHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E57583A3D; Wed,  4 Feb 2026 10:43:31 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95233839D5
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 10:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 5225A4E423D9;
 Wed,  4 Feb 2026 09:43:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1FD3F60745;
 Wed,  4 Feb 2026 09:43:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D96B3119A865B; Wed,  4 Feb 2026 10:43:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1770198206; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Ak3QPTlEOVfdzmwXymVMj5ZL9qlEK7i+zKHGLUC3yWE=;
 b=qAo+IHHxWzQxlp2CPROQOdFVGHM9srL7IjZXzRD20NJsHCZ4YTjFo979SCFYFIfXnZ4AxU
 BPeXAslFv4gNjIHAZ/vpYcC1B0rtku4+ZHR8Hly1o8VZBhAQ968B9ScTsdGj0JJIqXGjpT
 D0Wk8ezJ8qXHqoinj6vXzF67KS8ZC9zj5MVFe146fRUEzybZYHRAYneitUzkldgWdazsh2
 teQ73czZ2ypC4YNcJJFCQ4DYBz0ttcmhDew9kbEYXYRPPqxrKUqtS0Bj84WIKZF1QgzjOf
 +FK7BWT5tuyE7ErTUWtj1zg+ghRIlH3EQ3SfZ+6K/8ANhPU87Qh0KwqrCCHtKw==
Message-ID: <d27c09a5-93a3-44f5-bdf3-ff45fefb442b@bootlin.com>
Date: Wed, 4 Feb 2026 10:43:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing power domain in j722s/dev-data.c
From: Richard GENOUD <richard.genoud@bootlin.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Chintan Vankar <c-vankar@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Kumar, Udit"
 <u-kumar1@ti.com>, "Kumar, Abhash" <a-kumar2@ti.com>,
 "Mantena, Prasanth" <p-mantena@ti.com>
References: <cf501633-465c-4024-a728-ec830ab16af0@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <cf501633-465c-4024-a728-ec830ab16af0@bootlin.com>
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

[Adding Abhash and Prasanth in the loop, sorry for the noise]

Le 03/02/2026 à 14:49, Richard GENOUD a écrit :
> Hi Bryan,
> 
> When trying to discuss with the PMIC on a J722S-evm board in U-Boot R5 
> SPL, I got the error:
> ti_power_domain_of_xlate(power_domain=81fffe2c, id=107)
> ti_power_domain_of_xlate: invalid dev-id: 107
> 
> PMIC device lookup was done with:
> uclass_get_device_by_name(UCLASS_PMIC, "pmic@48", &pmic);
> 
> After checking the file arch/arm/mach-k3/r5/j722s/dev-data.c, the id 107 
> is indeed missing.
> 
> Could the missing dev-id be added it the file?
> 
> Regards,
> Richard
> 
