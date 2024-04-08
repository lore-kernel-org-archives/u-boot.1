Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBD8CD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 20:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98696880F4;
	Mon,  8 Apr 2024 22:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="miH1ZjUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96427880F5; Mon,  8 Apr 2024 22:00:59 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03DB387FBF
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 22:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d79=LO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1712606422;
 bh=2H/5/PUdR49hbIZoDiX2fBa8XwxsWzGzxRSElk5SgwQ=;
 b=miH1ZjUZbPAEU77rG3u5/k5J1r12lztzBmRTPHpLxCDimNXNgsTfk6WA5vi08pas590xqeSEN
 16tFLWeBu35v77/rtxz9slGqUX1BjDQFuoBxuuCTyN33HyjCwh+XDa/6yIeCItQSvttVy64sTlY
 kqihOs0FANwlYwdSrg2yt0WZz22dMu+rolpXDIkm8p7MN9EQYi6Ltn9Wd0bSIF0MjsLAGRO2sqz
 jQNvOtTd+eVaRg/KnOo0JusRvUAtwcDU6eIjiHC+DqArCut2tq63znsBqnZFAOBNcRPycyRQAFf
 nbPv3kVhjayb1XVCOmb8LDgGkJO/TL4wMr55FjZ5XJGA==
Message-ID: <32b23471-fcec-4b2b-baea-39488b772eb2@kwiboo.se>
Date: Mon, 8 Apr 2024 21:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] rockchip: rk3308: Sync DT with linux v6.8 and
 update defconfigs
To: Tom Rini <trini@konsulko.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Andy Yan
 <andy.yan@rock-chips.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408193848.GA6531@bill-the-cat>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240408193848.GA6531@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66144bd49ad98c55d9e4ddc2
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

Hi Tom,

On 2024-04-08 21:38, Tom Rini wrote:
> On Mon, Apr 08, 2024 at 06:13:57PM +0000, Jonas Karlman wrote:
>> This series adds support for new clocks used in linux v6.8 device trees,
>> enables use of FIT signature check for checksum validation and fixes
>> loading FIT from SD-card when loading FIT from eMMC fails.
>>
>> It should be possible to move RK3308 boards to use OF_UPSTREAM in a
>> future series after this has been applied.
>>
>> I have runtime tested this series on a Radxa ROCK Pi S v1.3 having a
>> RK3308B SoC. Following was tested and now working after this: SD-card,
>> eMMC (SD NAND), Ethernet, USB host and USB gadget (RockUSB and UMS).
>>
>> Changes in v2:
>> - Add clocks and resets props to otp node
>> - Add bootph-some-ram to emmc and sdmmc pinctrl nodes
>> - Sort bootph-all prop after compatible and reg props
>> - Fix rk3308-evb debug uart
>> - New patch to move cru and grf include files to arch-rockchip
> 
> Sorry if I missed the answer in v1, but why aren't we switching to
> OF_UPSTREAM here, which is also on v6.8 currently? Thanks.
> 

I would like to keep the switch to OF_UPSTREAM in a separate series
because of reviewability, some of the device tree files has not been
updated since v5.5-rc1, also I would like to have the option of
cherry-picking these patches to e.g. a 2024.04 branch.

What is the expected update cadence on OF_UPSTREAM, will there be an
update to v6.9 before v2024.07 or will U-Boot be one version behind
linux at release time?

Regards,
Jonas

