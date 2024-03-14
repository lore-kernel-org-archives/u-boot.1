Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210F7C5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 07:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 787A287F5D;
	Thu, 14 Mar 2024 08:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="KDg9AIDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CEF187F5D; Thu, 14 Mar 2024 08:02:27 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F1C887F5E
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 08:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=78b9=KU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1710399731;
 bh=fUWyKRrjBLfofP4wI3vEtQuSFe/90W++3bv/u7MWv4c=;
 b=KDg9AIDOnYvfhfpVvjBta9g6y6i5a9drcM5gprZNBaDfdLRM0FTarkgsk9KyLCNUjXvUvCEs/
 XiuLr8MKqMbU9fRxaKad0H+AZ0wCmS4LGjJicngs2QMDHgCeYgI9lG7ijhcMyzYhhfHoM1dEfIf
 CODTQxBFMYz98/fTWSSTMW+P7yWadsMf2/qDcccH/gJ6/xaOj0BB1sK6EnT1mds6olCtPpPR2Gh
 g2JVLbdyueQJ1//NBBoGhAp5qNk4b4Z3VgevdMRcRjEMxarqAWcEgZ08sx/LUI4EerfMmWAGLvL
 it0p3W6LG+Ctg/mtz3UUWB0ud+yRKzq93IHKpa1nBemQ==
Message-ID: <12bd629d-0326-4b18-8528-11cd728be25b@kwiboo.se>
Date: Thu, 14 Mar 2024 08:02:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add Pine64 PineTab2
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, Nicolas
 Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de
References: <20240204173040.2293613-1-jonas@kwiboo.se>
 <833e0e28-4154-4454-b66c-09271c203f22@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <833e0e28-4154-4454-b66c-09271c203f22@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65f2a0f1ffda568fff1646f3
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

On 2024-03-14 07:50, Kever Yang wrote:
> 
> On 2024/2/5 01:30, Jonas Karlman wrote:
>> The Pine64 PineTab2 is a tablet computer based on the Rockchip RK3566
>> SoC. The table features 4/8 GB LPDDR4 RAM and 64/128 GB eMMC storage.
>>
>> Features tested on a Pine64 PineTab2 8GB v2.0:
>> - SD-card boot
>> - eMMC boot
>> - SPI Flash boot
>> - USB host
>>
>> Device tree is imported from linux maintainer branch v6.9-armsoc/dts64,
>> commit 1b7e19448f8f ("arm64: dts: rockchip: Add devicetree for Pine64
>> PineTab2").
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks, I will send a v2 with small adjustments to bootph flags used in
board u-boot.dtsi and update defconfig to take advantage of the new
ROCKCHIP_COMMON_STACK_ADDR bss and stack addresses.

Regards,
Jonas

> 
> Thanks,
> - Kever
>> ---
>> This patch depend on the series "rockchip: rk35xx: Sync device tree with
>> linux v6.8-rc1" [1].
>>
>> [1] https://patchwork.ozlabs.org/cover/1891669/
>> ---
>>   arch/arm/dts/Makefile                         |   2 +
>>   arch/arm/dts/rk3566-pinetab2-u-boot.dtsi      |  44 +
>>   arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi |   3 +
>>   arch/arm/dts/rk3566-pinetab2-v0.1.dts         |  28 +
>>   arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi |   3 +
>>   arch/arm/dts/rk3566-pinetab2-v2.0.dts         |  48 +
>>   arch/arm/dts/rk3566-pinetab2.dtsi             | 943 ++++++++++++++++++
>>   board/pine64/quartz64_rk3566/MAINTAINERS      |  11 +
>>   configs/pinetab2-rk3566_defconfig             | 119 +++
>>   doc/board/rockchip/rockchip.rst               |   1 +
>>   10 files changed, 1202 insertions(+)
>>   create mode 100644 arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/rk3566-pinetab2-v0.1.dts
>>   create mode 100644 arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/rk3566-pinetab2-v2.0.dts
>>   create mode 100644 arch/arm/dts/rk3566-pinetab2.dtsi
>>   create mode 100644 configs/pinetab2-rk3566_defconfig
>>

[snip]
