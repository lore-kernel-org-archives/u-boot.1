Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA58CA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 21:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAC0B83045;
	Mon, 11 Aug 2025 23:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ou9k50f0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C00283214; Mon, 11 Aug 2025 23:41:18 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9EA783013
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 23:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cf87=2Y=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1754948474;
 bh=BPQ9IbmaLFVRnAu/gMKr293tZsNbipx1gV1oGQO280Y=;
 b=ou9k50f08J/kMxk4qOGNl/ESxjJJWKE9OMFTiNuwQcSocmTIKvulX0TJRpisE6gpwY/RRdxVA
 dw2hceQBOeskWdwUGkJ1/EAdaz808GQrsnQ0qnuSum9wrd9ga1vTcMFlX4BpoyVsfNm8hBnOquU
 tjw8pBJv3jg38DgTmNTOdQ1YO/hWCbvVnA5N7HqNmgOPLzOlcjR1geAb/tih4Dg+hllG3Hzvm6a
 RkCYdmMUU9JI4tz/C6tT8XMI0UJ3cvET+ttAxkVS/6825ljnAVW45JrccJC2ZlmyyI87nSuAqOp
 DhS7iiQgQisjRNi1HZeKLAVZ7xyEQL7VUWajZcszpTfA==
X-Forward-Email-ID: 689a636fde615f3104e075a6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6fd0723e-7998-4299-88b3-865531ef8584@kwiboo.se>
Date: Mon, 11 Aug 2025 23:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] board: rockchip: Add Radxa ROCK 4D
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250801210619.2618622-1-jonas@kwiboo.se>
 <20250801210619.2618622-5-jonas@kwiboo.se>
 <c681a45f-05e9-4390-950a-861bb762d2a9@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <c681a45f-05e9-4390-950a-861bb762d2a9@cherry.de>
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

On 8/11/2025 11:51 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/1/25 11:06 PM, Jonas Karlman wrote:
>> The Radxa ROCK 4D is a compact single-board computer (SBC) featuring
>> numerous top-tier functions, features, and expansion options.
>>
>> Equipped with the Rockchip RK3576 or RK3576J SoC, the ROCK 4D boasts an
>> octa-core CPU (4x Cortex-A72 + 4x Cortex-A53), Mali-G52 GPU, and a
>> powerful 6 TOPS NPU, making it ideal for AI and multimedia tasks.
>>
>> Features tested on a Radxa ROCK 4D v1.112:
>> - SPI Flash boot
>> - Ethernet
>>
>> ROCK 4D boards with SPI Flash is configured to boot from FSPI0->UFS->USB,
>> or directly from USB when the MASKROM button is pressed, booting
>> directly from SD-card is not possible on these boards.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2: Add comment about the reset-gpios prop rename
>> ---
>>   arch/arm/dts/rk3576-rock-4d-u-boot.dtsi   | 19 +++++++
>>   arch/arm/mach-rockchip/rk3576/MAINTAINERS |  6 ++
>>   configs/rock-4d-rk3576_defconfig          | 68 +++++++++++++++++++++++
>>   doc/board/rockchip/rockchip.rst           |  1 +
>>   4 files changed, 94 insertions(+)
>>   create mode 100644 arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
>>   create mode 100644 configs/rock-4d-rk3576_defconfig
>>
>> diff --git a/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi b/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..2e882c3cf786
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
>> @@ -0,0 +1,19 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +#include "rk3576-u-boot.dtsi"
>> +
>> +/* U-Boot only look for the reset-gpios prop, rename the prop until the Linux
>> + * commit cd803da7c033 ("arm64: dts: rockchip: fix PHY handling for ROCK 4D")
>> + * lands in dts/upstream to ensure Ethernet can work in U-Boot.
>> + */
> 
> This commit landed in v6.17-rc1. I assume it's just a matter of 
> hours/days before it reaches devicetree-rebasing git repo so that you 
> can simply cherry-pick it into U-Boot with tools/update-subtree.sh :)

Correct, v6.17-rc1-dts has now been pushed to devicetree-rebasing so I
will pick the DT fix for v3. May also have to add a clk patch for v3 due
to use of an U-Boot unsupported clock-id in mentioned DT fix.

Regards,
Jonas 

> 
> Cheers,
> Quentin

