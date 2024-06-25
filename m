Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61083C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 10:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BF27883E7;
	Tue, 25 Jun 2024 12:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="HA2H+Hbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9612B883FA; Tue, 25 Jun 2024 12:47:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25606883CD
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 12:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0f7a=N3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1719312402;
 bh=icxZWVQY23rw8jSenJEnVha+5Q3rKkXwQlFWLhrM8E0=;
 b=HA2H+Hbb4oRBK9KxJ+1KbAItoyD3pjFGXaLyUP4cag60aBG29KlBpiaJs0ov7lsPDZHrcVWig
 BWyKcd04RpOJXkWXcxSaHdFj8HmYUPgpNBk0JE0vhYZUZWdh1D635VeP/lbuXHGy/nfcUCtdBWl
 SJIyUERfsvMk7DDdrL2zQ4VNwXDP+N7RTU1+iHI3s1eln3/VAU2EDTPYBvck2SAdyVQ+rmGRe9m
 WsvKfQKTfnml578egyo155lx/wk2KlbnIYEndwHP0TWO9bviCztsPYOmndKxSSNOsmeaR/2nRJI
 YjG3bKpy5HTBX01+k8rorWc/XihUsIuMoenh6MbopvTg==
Message-ID: <12057632-0ea4-45c5-8c98-8f689c0338db@kwiboo.se>
Date: Tue, 25 Jun 2024 12:46:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: fix wrong PCI range address in rk3568 dtsi
To: "=?UTF-8?Q?Etienne_Dubl=C3=A9?=" <etienne.duble@imag.fr>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Simon Glass <sjg@chromium.org>, joe hershberger <joe.hershberger@ni.com>,
 "Leo Yu-Chi Liang" <ycliang@andestech.com>, Minda Chen
 <minda.chen@starfivetech.com>, Ramon Fried <rfried.dev@gmail.com>, Sumit
 Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, "u-boot"
 <u-boot@lists.denx.de>
References: <1506177052.15003206.1719232828107.JavaMail.zimbra@univ-grenoble-alpes.fr>
 <6e542e4b-9785-4ce5-b10a-7ed1b54131a8@cherry.de>
 <2b902244-0688-432b-bd04-061a083a0fbd@imag.fr>
 <8224b226-49ba-4a6a-a736-3c0dfee0aa57@kwiboo.se>
 <b238dae1-17f8-48c4-a75c-5d6002a9bea7@imag.fr>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <b238dae1-17f8-48c4-a75c-5d6002a9bea7@imag.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 667aa00bf69586b88e50a215
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

Hello Etienne,

On 2024-06-25 12:12, Etienne Dublé wrote:
> 
> Hello Jonas,
> 
> Le 25/06/2024 à 10:29, Jonas Karlman a écrit :
>> I do not understand the need for such/this patch. The changed address is
>> the internal io address that is shared with the pci controller and
>> devices.
>>
>> Do you have any issue in linux or is it only in U-Boot?, I suspect this
>> change is only a workaround to an issue only found in U-Boot.
> 
> On my board (Nanopi R5C with two RTL-8125B interfaces) both RTL-8125B 
> interfaces work in Linux, and only the first one works in u-boot.
> But Linux is apparently using the second PCI region and u-boot is using 
> the third (with the suspected address). These PCI regions are of the 
> same type.

Ahh, linux is still missing a patch to be able to use full address ranges
as a root complex.

Will re-run some tests on my R5C on both u-boot and linux to see if I can
replicate your issue.

> 
>> The rtl8169 driver or pci system of U-Boot may be of fault and should
>> probably be fixed instead of changing io addresses to work around issues
>> in software. E.g rtl8169 has a static ioaddr that is shared between all
>> drivers, something that may cause issues.
> 
> I am not an expert, but I really believe the issue comes from this 
> address in the device tree.

The issue may be that U-Boot is not fully capable of having overlapping
bus addresses for multiple pci controllers.

To my knowledge these addresses should be internal to the pci controller
and its devices.

The addresses below tells us that system memory address 0x340000000+,
and 0x380000000+ is mapped to bus address 0x40000000+ of each pci
controller.

> We have these pcie entries in rk3568.dtsi:
> 
> ----
>          pcie3x1: pcie@fe270000 {
> [...]
>                  ranges = <0x01000000 0x0 0xf2100000 0x0 0xf2100000 0x0 
> 0x00100000>,
>                           <0x02000000 0x0 0xf2200000 0x0 0xf2200000 0x0 
> 0x01e00000>,
>                           <0x03000000 *0x0* *0x40000000* 0x3 0x40000000 
> 0x0 0x40000000>;
> [...]
>          }
> [...]
>          pcie3x2: pcie@fe280000 {
> [...]
>                  ranges = <0x01000000 0x0 0xf0100000 0x0 0xf0100000 0x0 
> 0x00100000>,
>                           <0x02000000 0x0 0xf0200000 0x0 0xf0200000 0x0 
> 0x01e00000>,
>                           <0x03000000 *0x0* *0x40000000* 0x3 0x80000000 
> 0x0 0x40000000>;
> [...]
>          }
> ----
> 
> Again, I am not an expert, but it seemed suspicious to me that those two 
> entries were sharing the same PCI address.
> So I verified in the downstream repository of the board vendor 
> (https://github.com/friendlyarm/uboot-rockchip/blob/nanopi5-v2017.09/arch/arm/dts/rk3568.dtsi#L1754C21-L1754C31 
> and the second address there was replaced with "*0x0* *0x80000000*".
> Then, updating this was enough to make the second interface work in u-boot.

The bus addresses should be isolated to each pci controller if I am not
mistaken, so changing the bus address was probably just done as a
workaround because of some other unknown bug.

> 
> Like you, I initially suspected the code of rtl8169.c, which has many 
> global & static variables, so I actually spent quite a lot of time on 
> refactoring it, moving things to the private struct, but could never 
> make it work until I found this suspecting PCI address.

Hum, could be an issue in pci core of U-Boot that expect unique bus
addresses across all pci controllers.

Will run some quick tests on my R5C later.

Regards,
Jonas

> 
> Cheers,
> Etienne
> 

