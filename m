Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083C0C77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 15:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 822BC80C83;
	Fri, 27 Jun 2025 17:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rXlDshJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9041E81D5D; Fri, 27 Jun 2025 17:09:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DB55806D8
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 17:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c2fb=ZL=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1751036938;
 bh=eOLeTTRgxZTSngILn9SvWOsCw463Ny7EezxjlFxWOCA=;
 b=rXlDshJgvlqHC8L7v8i431F63TNBpyn6yDln9C6wiih/jagTPaffQhrlsWbkQEaLfi53pg3l8
 146ZAUs01xlqp0s7KaoMb54vZOcJl/1LaoERDWnnpJ7uBkzHWlMXEcKPnq7EcGnW35XLKYXJPSi
 hSdTT3GEVBFEfcWSiWTyryXK3nKHEFgW7zG7WqnmpIt1c5+AWMkWxwVh+3jFbPUOW7wSnYt2FsT
 Rfrjn9LffmGy0xhJ8LzREvyL+vKYzED1gi/c42REj9/FAjvwaWcR7NM4DL2z3tZ+5POvA/i7pAy
 j3tDZwedrIK0Co05H5Vny+tLaPP9rhvIp2KeVYCGC+UA==
X-Forward-Email-ID: 685eb4079ff32aeea6580347
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <fa35ad90-dbcd-4159-bcb3-41c4ad8d47b3@kwiboo.se>
Date: Fri, 27 Jun 2025 17:08:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: assign up to 3 static Ethernet MAC
 addresses
To: Quentin Schulz <quentin.schulz@cherry.de>, MichaIng <micha@dietpi.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <e76dbe98-2fa3-4d1b-a452-aa88a142c5cc@dietpi.com>
 <2beda42f-68c4-4fc3-8b84-ede6e452c4c7@cherry.de>
 <5aeeab0f-cbaa-4b25-9baf-37e2b0e5e9d1@dietpi.com>
 <7ab1deb6-5ab7-4544-805f-f2e1e139d045@cherry.de>
 <647c2f92-344f-4feb-8979-93b1d6574193@dietpi.com>
 <0c822158-11d7-4a1f-93f8-22043c807bd9@cherry.de>
 <3a38f9b3-e8a1-41dc-b770-0af80b8ebc09@dietpi.com>
 <ed094775-23e6-4fb1-9272-540256d46719@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <ed094775-23e6-4fb1-9272-540256d46719@cherry.de>
Content-Type: text/plain; charset=UTF-8
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

Hi,

On 2025-06-27 16:49, Quentin Schulz wrote:
> Hi Micha,
> 
> On 6/18/25 6:24 PM, MichaIng wrote:
>> Hi Quentin,
>>
>>  > Please keep the ML in Cc.
>>
>> Was too late for me yesterday :).
>>
>>  > We currently have 137 defconfigs for Rockchip boards (git grep -l
>>  > ARCH_ROCKCHIP configs/ | wc -l), so not sure 3 is a reasonable 
>> threshold :)
>>
>> I mean just for us/me, coding efforts and maintaining a patch, it is 
>> easier to do it right there, where it is done right now for ethaddr and 
>> eth1addr already for all Rockchip boards, instead of creating overrides 
>> for 3 particular boards. I hope an additional eth2addr is fine for now, 
>> until we found a better/more generic solution.
>>

I cannot find any rockchip board in U-Boot or Linux that currently use a
ethernet2 alias, have you sent a Linux patch that I have missed?

The addition of eth1addr was done because there are and was in-tree
boards that have use for both ethaddr and eth1addr.

Suggest you send a Linux patch that adds or updates a rockchip dts to
include an ethernet2 alias before this is applied.

> 
> Up to Kever, no strong opinion on this.
> 
> [...]
> 
>>  > Not sure to understand what you want to do here or what's the issue 
>> sorry.
>>  >
>>  > You need also eth*addr for use in U-Boot (if you do PXE, TFTP, ping,
>>  > whatever involving networking) so it makes sense to have them in U-Boot
>>  > DT as well.
>>
>> U-Boot assigns those variables to ethernet aliases on its own device 
>> tree as well? Would be reasonable, but for me this is minor. At least I 
> 
> If DM_SEQ_ALIAS is enabled, I believe so.
> 
>> did not hear from a case where someone was complaining about a random 
>> MAC address for network boot.
>>
> 
> I would imagine people be surprised if the same device operates under 
> two different MAC addresses depending on which SW is running at the 
> moment (U-Boot or Linux for example).
> 
>> What I aim for is U-Boot assigning static MAC addresses to ethernet 
>> aliases defined in/for the kernel device tree, better in a more generic 
>> than specific way, so it does not need to be changed again each time a 
>> new SBC (with new SoC) with multiple onboard Ethernet adapters arrives. 
>> Adding the aliases to the kernel device tree is then a different topic, 
>> not related to U-Boot, which I however aim to achieve upstream as well. 
>> If U-Boot syncs these back, it allows static MAC addresses for related 
>> adapters in U-Boot phase as well, of course.
>>
>>  > U-Boot may point to ethernet1 in kernel for example, in which case MAC
>>  > addresses may all get swapped between U-Boot and kernel. This is
>>  > theoretically possible, not sure how likely it is to happen though.
>>
>> That could happpen already now with the often at least 2 aliases 
>> defined. I wonder whether it can cause issues with PXE boot etc. In the 
>> cases I know, a dedicated dtb is shipped as well, and I am not even sure 
>> whether the network connection remains the same between U-Boot phase and 
>> kernel phase? In any case, as long as any new generic MAC assignment 
> 
> I would assume the kernel to be reconfiguring the network stack while 
> booting anyway, with renegotiation and all, but just a gut feeling, 
> nothing to back this up.
> 
> To sum up, not much against this patch except that it's not ideal to add 
> an environment variable most boards don't have a use for (but probably 
> so is eth1addr :) ), and I think we would benefit from some generic 
> implementation to set random Ethernet MAC addresses based on ethernet 
> aliases in DT.

I fully agree, adding a new environment variable for all boards when
there is currently no upstream use for it does not seem very practical
and such proper solution should probably be worked on.

Regards,
Jonas

> 
> Cheers,
> Quentin

