Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9C8C02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 20:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D4680C83;
	Thu,  6 Feb 2025 21:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738875152;
	bh=ewSwOCFHTP+WaWo2jCVhkJmJv55ai68MHNf6krL5+S0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BJCKibImOIJChzh93wABQtEoTbWV4ByXc4OT8Ac0vA45IwuhW9I+YnQMWmD0rAFtO
	 I7ZJhLHT2sDkeQoQPKMGwqqISAc/UzDXkaXqvomG9H4PwV9c48QS31Q2gpsI1M3rjK
	 jvgf0k6Aa6wk5K7V3Rk0rLJa9SEweWj4wxKDLorbSNFPjdQwjLAZ6VbYowcxiguFBZ
	 dEzIirlHNQc6OgCxm9+U6Y6s9wnJIpqrO7fOauq9swIb6Fv/PrrpsfIAPGKyCn6eeZ
	 cU4Y88wWPUZYIt9NwRlZlphnVsZa4SGC+C/vECwC5fvwEykKEQSz3Ii2L1sdzpwcKJ
	 vCbdygn4LYdeA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE24C80CB0; Thu,  6 Feb 2025 21:52:31 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88D8580C6E
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 21:52:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="TFo+ux1F"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DBEE71048AF46; Thu,  6 Feb 2025 21:52:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738875148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ewSwOCFHTP+WaWo2jCVhkJmJv55ai68MHNf6krL5+S0=;
 b=TFo+ux1F0VBJ+kniH+W2sPddypzEEQM4TwXbn4F+1Vtgha9xHc1UYKPZSnpWwVDea7JhdY
 RFI3VGlbYS9Di56b0IcC1laHhxFhZ6JDtpnp+kiwAKIMplpQ3iSZWqhQ0ERZacqyVsQb8C
 TRFJ9R/2apS1DQXc/1L3Q/3U+I2oK+lWU8AMLL/hErw3UKQTcV2KEIg1g0b3ljzQMcOijW
 9jnLLy3an5pi/IZnO29hllkDYvmZQ698jJzyyW9ZF3ISzTEnBjl+Lu6EdKLWTJPxIQlRIi
 OR/Hq14b0NEHbB6a8q59vk4dk42ablB4qsX6CFzyhyULUUx4dludshHLHofEuA==
Message-ID: <b492494b-15a0-4b62-9600-40d9525b8a00@denx.de>
Date: Thu, 6 Feb 2025 21:38:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: mkenvimage: Add pure shell implementation of
 mkenvimage
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Tom Rini <trini@konsulko.com>
References: <20250205143641.65430-1-marex@denx.de>
 <CAFLszTjshfJMxZoj=aZdCmDzTNRz1rRdphHb4UT9uBwKf5vS9g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTjshfJMxZoj=aZdCmDzTNRz1rRdphHb4UT9uBwKf5vS9g@mail.gmail.com>
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

On 2/6/25 1:38 PM, Simon Glass wrote:
> Hi Marek,
> 
> On Wed, 5 Feb 2025 at 07:37, Marek Vasut <marex@denx.de> wrote:
>>
>> Add implementation of mkenvimage written purely in bourne shell.
>>
>> This is not a replacement for mkenvimage tool, but rather a simple
>> implementation which can be used in environments where mkenvimage
>> itself cannot be deployed due to various constraints, like hardware
>> manufacturing plants, but where bourne shell and basic tool are
>> already available.
>>
>> The external dependencies which are not shell built-ins are gzip
>> and grep.
>>
>> All mkenvimage parameters are implemented and compatible with the
>> C implementation of mkenvimage.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> ---
>>   tools/mkenvimage.sh | 126 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 126 insertions(+)
>>   create mode 100755 tools/mkenvimage.sh
> 
> Would it be worth adding a simple test for this?
Sure, is there an existing test for similar case I can look at ?
