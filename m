Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AF5E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 13:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4345380612;
	Wed,  8 Jan 2025 14:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736343823;
	bh=ELVzvut/EKgkPEzNWZpWalpkTQpqe9ONxfA6x9k62ME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VYGoiLZXrj4QlH1Zdl9zspck2T5vettsYnclT22ji+eI0YEc5BtVY0CmB3KPUBPRH
	 zweL4NTJ6cNy7om98EzKmnsohgCFvLoHA25AMtT2T7Bntdc858jK67W0rKqOBVK86m
	 QT898Qbsw+bqpxyxKg2unseLlAAoKoF3xWntr8foOpPpk4B9lqOI29nIgx+sFE6paj
	 ODUaOZAlCTs+YInxuns5XE9na3NSmbwZPbC/Ywb/IyizcHZLrTEXsf11guZGx+hT3b
	 qpN5yJVtJBns1oOdQUZDE1EohBZkVQAwg4XwTThPqXj+0AdQHGv6g7pRNRdY6/oL0/
	 dKkqhiikrq5oQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA48180600; Wed,  8 Jan 2025 14:43:42 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA83D80634
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 14:43:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4YSpzD3Gdbz9slj;
 Wed,  8 Jan 2025 14:43:36 +0100 (CET)
Message-ID: <f33c4d86-045f-43bf-841b-7bc8dcb8d382@denx.de>
Date: Wed, 8 Jan 2025 14:43:35 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] serial: ns16550: Add Intel XScale support
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Tom Rini <trini@konsulko.com>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de
References: <20241231-coreprimevelte-v2-0-6a5445d92d11@skole.hr>
 <20241231-coreprimevelte-v2-1-6a5445d92d11@skole.hr>
 <0f39cd7a-c64c-45b6-9e69-4612b884c15f@denx.de> <4975523.31r3eYUQgx@radijator>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <4975523.31r3eYUQgx@radijator>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4YSpzD3Gdbz9slj
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

On 07.01.25 19:06, Duje Mihanović wrote:
> On Tuesday 7 January 2025 12:30:40 Central European Standard Time Stefan Roese
> wrote:
>> On 31.12.24 17:49, Duje Mihanović wrote:
>>>    	{ .compatible = "ingenic,jz4780-uart",	.data = PORT_JZ4780  },
>>>    	{ .compatible = "nvidia,tegra20-uart",	.data = PORT_NS16550 },
>>>    	{ .compatible = "snps,dw-apb-uart",	.data = PORT_NS16550 },
>>>
>>> +	{ .compatible = "intel,xscale-uart",	.data = PORT_NS16550 },
>>
>> Looking at the Linux 8250 of_device_id struct I see this entry:
>>
>> 	{ .compatible = "mrvl,mmp-uart",
>> 		.data = (void *)PORT_XSCALE, },
>>
>> Wouldn't it make more sense to use this compatible property instead?
> 
> I was going by the logic that intel,xscale-uart is more generic. They use
> identical platform data, so it would be no problem at all.

Please check which compatible property is present in the Linux upstream
dts/dtsi file for the Marvel SoC and use this one. This will make
sync'ing with upstream dts easier.

Thanks,
Stefan

