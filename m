Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE71C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 17:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFA1A887D7;
	Sat, 13 Jul 2024 19:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720893383;
	bh=lgs2YRnwZvFL9zGACsqPgijN1K4u3osBMecade6lBIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yECm9GRXLV+Wv27ElmTSfw3yihNkYznq9i2q2eH64Dkxq7aJnLkV0vh7qmG3CV72y
	 FE8J70hAKeEmcnUylZH3SInRaBRYFrZ3wtC44WDueWZ6aGNTXjKF8egDK21jnAVKLf
	 oWP6hqg5jbzWYJ5XwXRH/g6qrdMnGwW+ocFjPFE/QU07bzWh+ECIpXOMdUVksKnJo+
	 6IuulbM/B04IzFI0yvAaew+90PfjX6yJL4jgp0WBJ2VQIkc8QOMWrs/K/AdC9i8UCO
	 83dLabNT4hafOWxW/jofUmBs37uSv014LPSn1/45K8xR/uckfi6mgovxBRK869AXQ9
	 JNlKj2J6cC5BQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 20432884EA;
 Sat, 13 Jul 2024 19:56:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720893382;
 bh=lgs2YRnwZvFL9zGACsqPgijN1K4u3osBMecade6lBIY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UqXJdi1avo0gHItVSaggVl01XBlF4BUAg5IJn0BOkobHJzXNVwP9xAG2mlb6EzhWc
 iyPlnQYS2cPF/5PbHQTJ/j7No/ognoYrOc1OxmaDNC/h6n9LsjLGLkpdOe3Wm4pEXr
 x2NmXkZZvYIfkzrX13ks19Q5mTsQx272kQY1iLCqHEHXnMbtGlyf2x7AO+J3G7bKqw
 L8vyTu9BeTQBTZDHbIGQJekY8qEJzOaWGpKXXBXfhpazwuTMFzJlc8XJLftUBrMscg
 DlovuHgU+dgo+ehp8WHkQQAZZgKyb1lkC7HvrWBG83HlMS81kzBLDv3oK0hYb0IxbV
 zh5MIQSb08y0w==
Message-ID: <07e64fac-c86d-4897-b146-54f1e228b46c@denx.de>
Date: Sat, 13 Jul 2024 19:52:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eth: asix88179: reset during probe
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240618145759.3296876-2-caleb.connolly@linaro.org>
 <87v81fhsbp.fsf@baylibre.com> <d8943137-1748-4f57-8a85-0561d2af05d4@denx.de>
 <87ed82iwfm.fsf@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <87ed82iwfm.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/9/24 2:25 PM, Mattijs Korpershoek wrote:
> Hi Marek,
> 
> On mar., juil. 09, 2024 at 13:13, Marek Vasut <marex@denx.de> wrote:
> 
>> On 7/9/24 10:39 AM, Mattijs Korpershoek wrote:
>>> Hi Caleb,
>>
>> Hi,
>>
>>> Thank you for the patch.
>>>
>>> On mar., juin 18, 2024 at 16:57, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>
>>>> In some cases (consistently in my case with an embedded board) the
>>>> ethernet controller will time out on the first init but always succeed
>>>> after reset.
>>>>
>>>> Let's reset the controller during probe so we always start with it in a
>>>> known state, and don't have wait for the first asix_wait_link() to
>>>> time out.
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>
>>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>>
>>>> ---
>>>> I see this behaviour consistently across three Qualcomm platforms that use this
>>>> controller.
>>>> ---
>>>>    drivers/usb/eth/asix88179.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>
>> Do you want to pick it via usb-gadget tree or shall I pick it via usb tree ?
> 
> According to get_maintainer.pl, it should be you :)

Applied to usb/master, thanks !
