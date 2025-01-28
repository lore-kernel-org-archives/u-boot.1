Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406EEC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 11:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66D4581BEE;
	Tue, 28 Jan 2025 12:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738065276;
	bh=2q1x92kMag4Dlie0CPt9kf+Yh+3gbemZPZ7yrKholVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QEmaXo+ksOMtR3ZJN8PU4Io2yKrQlSWnH9rQkQ+mxiJlX4K3jiSJogXSmhjthkOy7
	 +N35vX6M80Q7y099DVNX9R6Lz0NuYDvlyOShOeOWUw+dnmM6elWAcmwGDoJDKTliRX
	 gELAuWdYHnjuF+ffXqGtmXTrSo6TH3+XZg3WUKtp+RmendiqIBDjjUeXuMPFZuFtiB
	 4F74QSCDxZ9TKAdKjRRAX853HhtaisX5xhiu9xsfsqywBBGa59mldq+viH9LobPpm3
	 W9tciLXjmrZO/ue476UxW2U5wRHQC9j9mI2Z2F27IQ60wPl44OC/lATX31E43cag+C
	 OiXC8un9KzvQA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A2D81D42; Tue, 28 Jan 2025 12:54:35 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77F9381BC0
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 12:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="gsM1zhEb"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B38F310382D08; Tue, 28 Jan 2025 12:54:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738065272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2q1x92kMag4Dlie0CPt9kf+Yh+3gbemZPZ7yrKholVM=;
 b=gsM1zhEb2LvC5KBy35lV/KsgsF2xLLzsEAhkebNgNMxOasnQk7YNMm8McXeM9LZlectVCV
 DlGikrobz+hn4CPVIg1cSqfXWuZhTmsSo0tA+uqg7qtwZuUljuL6E9Oe6q0Lb4w21vskVa
 EIwu2WZIS0GgXBL4Xlep5fqPSGG9iPiyLHU6HpHsgN/GcTgCtG64h4NyseVS7DRIZZHOTo
 hkENZjMtLTfKSr2j1H8ntkQMHIp5+Sf0fKbc4a6WIVkYkucOH5a0nkoUCdFtGpk+M0DqvH
 sRu81kvkCnFP1OlvhSwWS/6EHz0CHi/WG2mrkAyJ0y4P7wC3XxvfkhESTcICaw==
Message-ID: <0a098be0-7e4f-4fb7-ae01-5e319ff144e6@denx.de>
Date: Tue, 28 Jan 2025 11:40:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] USB: Fix NULLPTR dereference when serial# is unset
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Ferolito <michaelsunn101@gmail.com>, u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Kyungmin Park <kyungmin.park@samsung.com>
References: <20250128003010.971175-1-michaelsunn101@gmail.com>
 <2f367a3a-659b-4fe5-be34-e270ee941866@denx.de> <87wmefqp5b.fsf@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <87wmefqp5b.fsf@baylibre.com>
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

On 1/28/25 10:11 AM, Mattijs Korpershoek wrote:
> Hi Michael,
> 
> Thank you for the patch.
> 
> On mar., janv. 28, 2025 at 02:49, Marek Vasut <marex@denx.de> wrote:
> 
>> On 1/28/25 1:30 AM, Michael Ferolito wrote:
>>> The current behaviour of this function will dereference a null pointer
>>> if the serial# environment variable is unset. This was discovered on a
>>> board where U-Boot did not have access to the first 256MB of ram,
>>> resulting in a board crash.
>>> In the event that U-Boot has full access to memory, it will still read
>>> from address 0, which is probably not optimal.
>>> This simple check is enough to fix it
>>>
>>> Signed-off-by: Michael Ferolito <michaelsunn101@gmail.com>
>>> Cc: Marek Vasut <marex@denx.de>
>>> Cc: Heiko Schocher <hs@denx.de>
>>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> The subject tag is "usb: gadget: g_dnl:" instead of "USB:" , with that
>> fixed:
>>
>> Reviewed-by: Marek Vasut <marex@denx.de>
> 
> Agreed with Marek on this. Please add:
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> As well.
> 
> Marek, since this is gadget, can this go through my tree?
Yes of course.
