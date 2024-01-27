Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA37C46CD2
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 11:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA66D86BFA;
	Sat, 27 Jan 2024 12:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LoX7cBK5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AE12875A0; Sat, 27 Jan 2024 12:16:20 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3109C869F7
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 12:16:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0bb9=JF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1706354161;
 bh=CGaaZ8oPwBOjpH4w+CzQQZvpHh3U5qOprROqYBOaPAk=;
 b=LoX7cBK5r+ACktkcBu0Z5s/CLFMADxTAtx+A/YoqMJxbWo58ep0zpUhd/kJRIxnkBIJIJ/DsI
 tGEdicPVGI6mALixPQmwmQdayJ1nYk4/jt2C20jCyZylzvQDKWv67ELyyF7G3NUBWpV/YR3Pn8u
 PjXbB1qaX6KHc6onGnQETYObgvd9O+FkIIPqXQuGXPY6flM5b8JjaqD7QLlxfhX3gmqJSmyXIYF
 gou2Ws0wmCj7H2J5sZsb4lhbzg3ax2DzikD9a4iqD5BwKRcZxD6FuozReH3g2nIqBdSrtfYmE6u
 uc10H9qG1Pw0XRo4i6E5rPf8DcwCViISoYNaqPaMSD3Q==
Message-ID: <e1417a87-15ee-4e1b-9513-c101a02118d4@kwiboo.se>
Date: Sat, 27 Jan 2024 12:15:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>, Simon
 Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom
 Rini <trini@konsulko.com>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andy Yan <andyshrk@163.com>, Tianling Shen <cnsztl@gmail.com>, Akash
 Gajjar <gajjar04akash@gmail.com>, Joshua Riek <jjriek@verizon.net>
References: <20240126232615.6826-1-jonas@kwiboo.se>
 <20240126232615.6826-2-jonas@kwiboo.se>
 <515157a9-8d19-42f9-ae6d-914aaea8a3ba@collabora.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <515157a9-8d19-42f9-ae6d-914aaea8a3ba@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65b4e5f081d7e96d10ccd4d8
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

Hi Eugen,

On 2024-01-27 04:48, Eugen Hristev wrote:
> Hi Jonas,
> 
> 
> On 1/27/24 01:26, Jonas Karlman wrote:
>> Writing to eMMC using DDR52 mode does not work reliably or at all on
>> RK356x and RK3588 boards.
>>
> 
> 
> This is related to the old issue I encountered last year with mmc write?

Yes, I think it is.

I did some testing on RK3566/RK3568/RK3588S/RK3588 boards with different
eMMC modules with following result:

Read seem to work with all enabled modes:
RK3566: MMC legacy, MMC High Speed (26MHz), MMC High Speed (52MHz),
        MMC DDR52 (52MHz) and HS200 (200MHz)
RK3568/RK3588S/RK3588: all above + HS400 (200MHz) and HS400ES (200MHz)

However, write had issues with some of the modes:
MMC DDR52 (52MHz): all RK35xx
HS400/HS400ES: only on RK3568 after changing hs400_txclk_tapnum to 8

HS200 seem to be the most stable write speed that worked on all SoCs.

So, dropping MMC DDR52 (52MHz) and enable use of HS200 (200MHz) seem to
be the best option to get speedy and working read and write eMMC.

Regards,
Jonas

> 
> Thanks,
> Eugen
> 
>> Fix this by removing the mmc-ddr-1_8v prop from sdhci nodes.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi   | 1 -
>>  arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi   | 1 -
>>  arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi | 1 -
>>  arch/arm/dts/rk3566-soquartz-u-boot.dtsi     | 1 -
>>  arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi   | 1 -
>>  arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi   | 1 -
>>  arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi    | 1 -
>>  arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi    | 1 -
>>  arch/arm/dts/rk3568-rock-3a-u-boot.dtsi      | 1 -
>>  arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      | 1 -
>>  arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi   | 1 -
>>  arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi     | 1 -
>>  12 files changed, 12 deletions(-)
>>

[snip]
