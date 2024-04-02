Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5507C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 11:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27365880B2;
	Tue,  2 Apr 2024 13:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="SUqYFYxy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 945A288101; Tue,  2 Apr 2024 13:52:11 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 162DB87ED8
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 13:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0765=LH=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1712058718;
 bh=kM9N21mCyKxgAGOxivU/T3TcIvwYLdldgAaedcVeQas=;
 b=SUqYFYxyqsnFw4A3aBTdc93fsxaOkO9BH/e0j9fMR38j1X6jsNF0k0ThfVhJ8asq2/XMA8Wlv
 s8N5LCqZ+quIjau6SQSzYeYNUgOqHrvdr7tTptQkHqczYaTLJCdu0MsRxWtSjYlCtuvCeHhfq6h
 sRH0DVQa1ChmjSwsY9++COI+1lx1/xUV8+mRxytbyWJNdWst19MAR9WnFKOoui1qLE2Ba2IhINj
 j2iBuiPnJdxjCNst1xJOL19YFvO7NdVoGCFMp+QfqpxpDt/TjfJorljWng8dPdinh4tYPoTLCtY
 0af71riD9PPFDejY6ujsHnrcRbOUJ+xq0mZ79bQkoYCw==
Message-ID: <7447ee5b-5199-4a54-8c6e-8a88d8efa4d4@kwiboo.se>
Date: Tue, 2 Apr 2024 13:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] rockchip: rk3588-toybrick: Add missing Kconfig
 options
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Elon Zhang <zhangzj@rock-chips.com>, Weizhao Ouyang
 <weizhao.ouyang@arm.com>, u-boot@lists.denx.de
References: <20240329190224.3613471-1-jonas@kwiboo.se>
 <20240329190224.3613471-16-jonas@kwiboo.se>
 <ed5576a3-24cb-4c6c-958c-66c63d43ed69@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <ed5576a3-24cb-4c6c-958c-66c63d43ed69@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 660bf15c0244bbe498a4c8cd
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

On 2024-04-02 12:28, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 3/29/24 20:01, Jonas Karlman wrote:
>> Add .dtb-file entry to Makefile and enable Kconfig options required to
>> configure pinctrl in SPL. Also add missing PHY_ROCKCHIP_NANENG_COMBOPHY.
>>
>> Fixes: 9fdd9a546986 ("board: rockchip: add Rockchip Toybrick TB-RK3588X board")
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/dts/Makefile             | 1 +
>>   configs/toybrick-rk3588_defconfig | 5 ++++-
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>> index f49b7e5d251f..3e0bad8306b5 100644
>> --- a/arch/arm/dts/Makefile
>> +++ b/arch/arm/dts/Makefile
>> @@ -207,6 +207,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
>>   	rk3588-quartzpro64.dtb \
>>   	rk3588s-rock-5a.dtb \
>>   	rk3588-rock-5b.dtb \
>> +	rk3588-toybrick-x0.dts \
> 
> Should be .dtb here I guess :)

Hehe, my bad, will fix in v2 :-)

Regards,
Jonas

> 
> Cheers,
> Quentin

