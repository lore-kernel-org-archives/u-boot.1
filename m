Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABDFCCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 18:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98BFA82E34;
	Mon, 20 Oct 2025 20:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BkfpT6XI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1285831D5; Mon, 20 Oct 2025 20:03:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DABA82C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 20:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5603=46=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1760983430;
 bh=HUpn2SujKRmifsfqrAJsEQuQTPIoAqC7eMTIb8re6a0=;
 b=BkfpT6XIwB22Hzm48pxq32TGlHBBzjMnocB4MxT5jTa8HM+82k0jqZvA9xdzAD4GWONLhPbu1
 0bfT4AP3fTa2BzzuZuKUG6vHZHqSHLR/7f8ggZI2HH93wPqMNx/a5aZipeWUyuLPi9CtJvzfz/G
 x95Arvmfwd+K6rG1YzKVmv8haxvpRYj4344rG/HXeKQSOTMdeyfxLuUd4HqymdBR85QF8xSGMct
 uVADCOx24cPGgpwlaQAQm9Bf9ALZ9Y4L6MTy1j78FfBkkOe/ZJ8LtWVGFVYKPd9Uh1hDW2MhlwX
 L4ldJXNdmp7/ZxJqh4U4lQwRCdtbaJZgYUJK3xadUGtA==
X-Forward-Email-ID: 68f6798044a3ee206d949112
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.3.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5522697b-fb56-4735-a1e5-7b8654438cd7@kwiboo.se>
Date: Mon, 20 Oct 2025 20:03:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: rockchip: Add FriendlyElec NanoPi Zero2
To: Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <ziyao@disroot.org>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <20251019052607.61702-1-ziyao@disroot.org>
 <20251019052607.61702-3-ziyao@disroot.org>
 <55af1d20-4dd0-4b77-8cab-035921c405a0@kwiboo.se>
 <1eb9da8c-4eaa-4aa6-b13b-4790e4d0bc04@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <1eb9da8c-4eaa-4aa6-b13b-4790e4d0bc04@cherry.de>
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

Hi Quentin,

On 10/20/2025 7:02 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 10/19/25 12:52 PM, Jonas Karlman wrote:
>> Hi Yao Zi,
>>
>> On 10/19/2025 7:26 AM, Yao Zi wrote:
> [...]
>>> +CONFIG_DM_REGULATOR_GPIO=y
>>> +CONFIG_PWM_ROCKCHIP=y
>>> +CONFIG_BAUDRATE=1500000
>>> +CONFIG_DEBUG_UART_SHIFT=2
>>> +CONFIG_SYS_NS16550_MEM32=y
>>
>> Please add following to prepare for future USB support:
>>
> 
> I don't like this. Whatever is enabled in the defconfig, I'm expecting 
> it to work when I'm testing, so I would rather suggest to postpone this 
> to when it actually works?

The required driver support for USB 2.0 landed in v2025.07 and USB 3.0
in v2025.10. It is now only the DT nodes (on Linux ML) that is missing
to make USB work for this and other RK3528 boards.

> 
> In the end, I don't own the device nor do I plan to, so whatever floats 
> your boat :)

USB has been working as it should for this and the other rk3528 boards
with my rk3528 branch [1] for the past 5-7 months, so I would very much
prefer to enable these Kconfig options now and just have wait for a
future DT pick or sync to make USB finally work in upstream.

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528

Regards,
Jonas

> 
> Cheers,
> Quentin

