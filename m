Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C552E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 07:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7756A801FD;
	Thu,  9 Jan 2025 08:47:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736408874;
	bh=tkFBF5ILQi/ijVoTphGCMEj4vIdkvR+OBkHeGw4nR3w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xJjf0K7Cp4Qj+5GmxnqvOrxlYirQcxe+a41Ah8sRb2r56rDEwiSlX97NayW2KzMgg
	 agMxZhUKEfhr/aF6+ictz/wAAiDX/OVWmmFjEPj9SXmNSyeMBwPLUkZOiUs9kzmj1u
	 eCyy/AX0fxEUw46C3IfDQXAMx+72fo4J4LkdsCY3vkjzi0er/AstRAS7LpqRo79ef9
	 9q78ZQs3Uxa2EvznPW5lcWKwUvzKdyFmj1oDCvf3Zsf8Yr9XAgZew4pQhrOZ/A5zO/
	 42ycx22J5d7oTOXkkSHP8BKHHrJ+rG6nqUVtxOxikA5YdJM5LmfbP4kwG7+NWfkH2l
	 pI8tJ94b4zZSg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3BE280317; Thu,  9 Jan 2025 08:47:52 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8AEE801F5
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 08:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4YTH2D42dHz9sZM;
 Thu,  9 Jan 2025 08:47:48 +0100 (CET)
Message-ID: <f759a21e-ebbd-4923-b70e-f1a3f59417b1@denx.de>
Date: Thu, 9 Jan 2025 08:47:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] serial: ns16550: Add Intel XScale support
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Tom Rini <trini@konsulko.com>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de
References: <20241231-coreprimevelte-v2-0-6a5445d92d11@skole.hr>
 <20241231-coreprimevelte-v2-1-6a5445d92d11@skole.hr>
 <0f39cd7a-c64c-45b6-9e69-4612b884c15f@denx.de> <4975523.31r3eYUQgx@radijator>
 <f33c4d86-045f-43bf-841b-7bc8dcb8d382@denx.de>
 <9b04fcd4-bd7e-4f85-83f5-5e0e2dd8a00a@skole.hr>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <9b04fcd4-bd7e-4f85-83f5-5e0e2dd8a00a@skole.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4YTH2D42dHz9sZM
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

On 08.01.25 22:26, Duje Mihanović wrote:
> On 8.1.2025. 14:43, Stefan Roese wrote:
>> On 07.01.25 19:06, Duje Mihanović wrote:
>>> On Tuesday 7 January 2025 12:30:40 Central European Standard Time
>>> Stefan Roese wrote:
>>>> Wouldn't it make more sense to use this compatible property instead?
>>>
>>> I was going by the logic that intel,xscale-uart is more generic. They use
>>> identical platform data, so it would be no problem at all.
>>
>> Please check which compatible property is present in the Linux upstream
>> dts/dtsi file for the Marvel SoC and use this one. This will make
>> sync'ing with upstream dts easier.
> 
> PXA1908 is not upstreamed yet, but it and other PXA SoCs which are
> upstreamed use both, so I'm not sure which to settle on.

arch/arm/boot/dts/marvell/mmp2.dtsi:

                         uart1: serial@d4030000 {
                                 compatible = "mrvl,mmp-uart", 
"intel,xscale-uart";
...

So both seem to be fine. With this in mind I don't see a problem
with the current xscale compatible approach.

Thanks,
Stefan

