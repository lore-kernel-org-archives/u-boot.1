Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE68E77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 22:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AFA3800D0;
	Wed,  8 Jan 2025 23:34:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C571800D0; Wed,  8 Jan 2025 22:26:45 +0100 (CET)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34B6D80017
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 22:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=duje.mihanovic@skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
 by mx.skole.hr (mx.skole.hr) with ESMTP id 978FB832E7;
 Wed,  8 Jan 2025 22:26:42 +0100 (CET)
Message-ID: <9b04fcd4-bd7e-4f85-83f5-5e0e2dd8a00a@skole.hr>
Date: Wed, 8 Jan 2025 22:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] serial: ns16550: Add Intel XScale support
To: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de
References: <20241231-coreprimevelte-v2-0-6a5445d92d11@skole.hr>
 <20241231-coreprimevelte-v2-1-6a5445d92d11@skole.hr>
 <0f39cd7a-c64c-45b6-9e69-4612b884c15f@denx.de> <4975523.31r3eYUQgx@radijator>
 <f33c4d86-045f-43bf-841b-7bc8dcb8d382@denx.de>
Content-Language: en-US
From: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
In-Reply-To: <f33c4d86-045f-43bf-841b-7bc8dcb8d382@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Jan 2025 23:34:03 +0100
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

On 8.1.2025. 14:43, Stefan Roese wrote:
> On 07.01.25 19:06, Duje Mihanović wrote:
>> On Tuesday 7 January 2025 12:30:40 Central European Standard Time
>> Stefan Roese wrote:
>>> Wouldn't it make more sense to use this compatible property instead?
>>
>> I was going by the logic that intel,xscale-uart is more generic. They use
>> identical platform data, so it would be no problem at all.
> 
> Please check which compatible property is present in the Linux upstream
> dts/dtsi file for the Marvel SoC and use this one. This will make
> sync'ing with upstream dts easier.

PXA1908 is not upstreamed yet, but it and other PXA SoCs which are
upstreamed use both, so I'm not sure which to settle on.

Regards,
--
Duje



