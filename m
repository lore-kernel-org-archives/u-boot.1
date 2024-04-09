Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF910C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 16:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B57C87EA9;
	Tue,  9 Apr 2024 18:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="bZRquM8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5DE187E06; Tue,  9 Apr 2024 18:21:31 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E091880D6
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 18:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=445b=LP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1712679675;
 bh=nKyUeVNsfD0VJ05ii0AOzGG4O8of5zMCeKYlYN/KoH0=;
 b=bZRquM8FCw5Yflpusb8fOwipm2Heseetx79DSQ1OnIFQOry/+X4cOVbhNDons6PETUEqNdK8s
 qGOKEGPCDePA+ab/0BahJ4XNIvMze0xZWo6QgG8wxbPKRtABQP5v/55/DAlLZclqCNEelOBkh48
 skvsVhC3X1cYpsokUJQaLeF9/oif9ykxkPaaAEFOy51sGHvaguHUNQOJ7Qg7PkLG/XrfnGBSC77
 kOlGbvHlgIu1wuH96pzCJsHaClIV9gfbtMeb9Sr+Rp7Nupex3psIDifj6Z4zPSLwzPAg81yP/GP
 vXgVqMxhpK0jlKt1z2SRqwiMw74nYlpTRD8nPEdDX3nw==
Message-ID: <6c4b5110-9ef1-4013-a858-b59637ae6d75@kwiboo.se>
Date: Tue, 9 Apr 2024 18:21:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] rockchip: rk3308: Enable random generator
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-6-jonas@kwiboo.se>
 <3fb8bdca-042a-4153-ae0f-114bbafcb82f@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <3fb8bdca-042a-4153-ae0f-114bbafcb82f@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66156afae7a102f19b2a9e1d
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

Hi Quentin,

On 2024-04-09 17:45, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 4/8/24 20:14, Jonas Karlman wrote:
>> The RK3308 SoC contain a crypto engine block that can generate random
>> numbers.
>>
>> Add rng node to soc u-boot.dtsi and enable Kconfig options to take
>> advantage of the random generator.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2: No change
>> ---
>>   arch/arm/dts/rk3308-u-boot.dtsi | 5 +++++
>>   arch/arm/mach-rockchip/Kconfig  | 2 ++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
>> index 436f66d1b87d..fa31c838d34d 100644
>> --- a/arch/arm/dts/rk3308-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3308-u-boot.dtsi
>> @@ -26,6 +26,11 @@
>>   			reg = <0x07 0x10>;
>>   		};
>>   	};
>> +
>> +	rng: rng@ff2f0000 {
>> +		compatible = "rockchip,cryptov2-rng";
>> +		reg = <0x0 0xff2f0000 0x0 0x4000>;
> 
> Downstream says something different:
> 
> https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64/boot/dts/rockchip/rk3308.dtsi#L1007-L1020
> 
> I couldn't quickly find the TRM for the RK3308 so cannot check myself :/

RK3308TRM Part1 mention following under address mapping:

ff2f0000 CRYPTO 64K

And RK3308TRM Part2 mention following under crypto regs:

CRYPTO_CLK_CTL  0x0000  W  0x00000001  Clock Control Register
[...]
CRYPTO_RNG_CTL  0x0400  W  0x0000000c  RNG Control Register
[...]
CRYPTO_SRAM_ADDR  0x1000  W  0x00000000  SRAM Base Address

And the U-Boot driver:

/* start of CRYPTO V2 register define */
#define CRYPTO_V2_RNG_CTL			0x0400

So 0xff2f0000 should be correct for the crypto block on RK3308. And the
rng cmd also gives me proper random numbers on my Rock Pi S board.

> 
> Also seems to be missing clocks and resets?

Yeah, this is just a minimal node to get the rng driver in U-Boot
working and like most other clocks they are enabled and running at an
acceptable rate by default.

Regards,
Jonas

> 
> Cheers,
> Quentin

