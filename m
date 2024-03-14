Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF07EC5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 07:36:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BCB787F71;
	Thu, 14 Mar 2024 08:36:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="a7+e7rSx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F6887F74; Thu, 14 Mar 2024 08:36:10 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2842287F49
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 08:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=78b9=KU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1710401757;
 bh=Nz/DcjovapfZq99yMK09Ed5Zu8Ps829Y90cqfd9xMBE=;
 b=a7+e7rSxG11FB5DEmRkyeBDc0cyra+HKK8eBaElS8qwiGWn6Wq7fqjTq5SZKH7uxVFvpLVGps
 O81L5bBOK4LrhqEftIYIK2LpP4xeTuSEM3bNkHHxR81iF/YCuoET3hDxE5XqR6nvt8KerI7g0BJ
 iQFX0/d3+F3iybGJtKm6vKmxyTbRTKnzo6dsbUGUrQji/lqxXCwaV3Gmt2iiQi48cQY8fbVCrEz
 tqm5AGIG1308zuzOMfAKBh89XwhBmvaIPBYPuIfJTRTiNHE9Ue6CRri4KToglOYJTz2VnZ8Nsli
 SSloSbR4bg82VbtHkv8zDWj+ru3QRAauSqF4Jg9ws/1g==
Message-ID: <62432725-f2f0-4e88-899a-07ef2c86178a@kwiboo.se>
Date: Thu, 14 Mar 2024 08:35:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: Add minimal generic RK3588S/RK3588 board
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240131220854.117650-1-jonas@kwiboo.se>
 <6d21147e-d420-47f4-acf2-131b0df89279@rock-chips.com>
 <58c4d615-d546-4544-a3d8-36879b66e129@kwiboo.se>
 <1853e819-67d1-4966-a4b8-8ba054fc5145@rock-chips.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <1853e819-67d1-4966-a4b8-8ba054fc5145@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65f2a8da6f69af875f287ad0
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

Hi Kever,

On 2024-03-14 08:33, Kever Yang wrote:
> Hi Jonas,
> 
> On 2024/3/14 15:04, Jonas Karlman wrote:
>> Hi Kever,
>>
>> On 2024-03-14 07:58, Kever Yang wrote:
>>> On 2024/2/1 06:08, Jonas Karlman wrote:
>>>> Add a minimal generic RK3588S/RK3588 board that only have eMMC and SDMMC
>>>> enabled. This defconfig can be used to boot from eMMC or SD-card on most
>>>> RK3588S/RK3588 boards that follow reference board design.
>>>>
>>>> Also fix the alphabetical order of RK3588 boards listed in Makefile and
>>>> documentation.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> Since rk356x already have a generic board, rk3588 can also have one.
>>>
>>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>> Thanks, I will send a v2 with an updated defconfig to take advantage of
>> the new ROCKCHIP_COMMON_STACK_ADDR bss and stack addresses.
> 
> I have fix this and also other new boards defconfig, so you don't need 
> to do this.

Great, thanks!

Regards,
Jonas

> 
> 
> Thanks,
> 
> - Kever
> 
>>
>> Regards,
>> Jonas
>>
>>> Thanks,
>>> - Kever
>>>
>>>> ---
>>>> This patch depend on the series "rockchip: rk35xx: Sync device tree
>>>> with linux v6.8-rc1" [1].
>>>>
>>>> [1] https://patchwork.ozlabs.org/cover/1891669/
>>>> ---
>>>>    arch/arm/dts/Makefile                   |  5 +-
>>>>    arch/arm/dts/rk3588-generic-u-boot.dtsi |  3 ++
>>>>    arch/arm/dts/rk3588-generic.dts         | 44 ++++++++++++++++
>>>>    board/rockchip/evb_rk3588/MAINTAINERS   |  7 +++
>>>>    configs/generic-rk3588_defconfig        | 68 +++++++++++++++++++++++++
>>>>    doc/board/rockchip/rockchip.rst         |  3 +-
>>>>    6 files changed, 127 insertions(+), 3 deletions(-)
>>>>    create mode 100644 arch/arm/dts/rk3588-generic-u-boot.dtsi
>>>>    create mode 100644 arch/arm/dts/rk3588-generic.dts
>>>>    create mode 100644 configs/generic-rk3588_defconfig
>>>>
>> [snip]

