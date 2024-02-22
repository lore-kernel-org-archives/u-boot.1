Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AD7C48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 13:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB62F87CEB;
	Thu, 22 Feb 2024 14:03:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="owHk0crz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5DEE877FB; Thu, 22 Feb 2024 14:03:14 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1567B87CEB
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 14:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7c91=KA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1708606965;
 bh=D5KWU1D17J47yYDRZEncgWKTyUq0LINqVhwHmKHRqmA=;
 b=owHk0crzPSnkKnncF3Mh975hdfj36bnGwC07chW82gdX+jfoTLjOsZ7/Lr0lE506ngjbSLyAT
 gVqMjhbRZPfZpMd+d6rqpyT6AbdedHL3PazucThHLM3A66Xfd19otajoqpa4o9gNHuVh+llQQip
 SSA68Tdn989nved2r30mLWmcQ2aIHYnKFhUYwjkql17vGQoW4TAjnk8oxShDIIDrUVeIVb1up/x
 LoPF/aaHqT7tPiXrXifQ9mveNLTxrnlJT/E9vkgxZkVltnJjJFUPGjQTl9snJlk5tcgpk7DnW1c
 +Q58/SMCgBtFIsVRUge0DvZJiifp6dUm9VWe1gdTv5Kw==
Message-ID: <7074fd44-1bef-40f9-bed9-1b14d85c6fd7@kwiboo.se>
Date: Thu, 22 Feb 2024 14:02:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] rockchip: rk3328: Add support to build bootable
 SPI image
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de
References: <20240217002304.2141064-1-jonas@kwiboo.se>
 <20240217002304.2141064-14-jonas@kwiboo.se>
 <0e9e554f-18c6-4f00-b717-b5c5151b06a5@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <0e9e554f-18c6-4f00-b717-b5c5151b06a5@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65d745f20f5ed48fb02339c3
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

On 2024-02-22 11:18, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 2/17/24 01:22, Jonas Karlman wrote:
>> Similar to RK35xx the BootRom in RK3328 can read all data and look for
>> idbloader at 0x8000, same as it does for SD and eMMC.
>>
>> Use the rksd format and modify the mkimage offset to generate a bootable
>> u-boot-rockchip-spi.bin that can be written to 0x0 of SPI NOR flash.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2:
>> - No change
>> ---
>>   arch/arm/dts/rk3328-u-boot.dtsi        | 11 +++++++++++
>>   arch/arm/mach-rockchip/rk3328/rk3328.c |  1 +
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
>> index a030f1a5e51d..4d43fe2fb51a 100644
>> --- a/arch/arm/dts/rk3328-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
>> @@ -133,3 +133,14 @@
>>   &usb20_otg {
>>   	hnp-srp-disable;
>>   };
>> +
>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>> +&binman {
>> +	simple-bin-spi {
>> +		mkimage {
>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
>> +			offset = <0x8000>;
>> +		};
>> +	};
>> +};
>> +#endif
> 
> Do we have a list of SoCs that need to use rkspi type for booting from 
> SPI flashes? I would much rather have rksd the default in 
> rockchip-u-boot.dtsi instead of having to add it for each and every SoC 
> which is not impacted by this change (which I assume should be now all 
> new SoCs?).

My best guess is that any BROM prior to and including RK3399 use the 2K
per page read code for SPI flash. Any newer SoC seem to have SPI more in
common with MMC, i.e. read full page data and look for boot header at
similar offsets, @ 32KiB.

I have been able to read out the BROM version (last 16 bytes of BROM)
from my RK ARM64 SoCs:

Read 2K per page:
RK3399:  330C 20160118 V100

Read full SPI flash data:
RK3328:  320C 20161117 V100
RK356x:  350A 20210322 V300
RK3588:  350B 20210512 V100

Unsure, guessing it read full SPI flash data:
RK3308B: 330E 20180806 V200

There is also a longer list of BROM versions of older SoCs at [1].

[1] https://github.com/rockchip-linux/u-boot/blob/next-dev/arch/arm/mach-rockchip/chip_info.c

> 
> I could also imagine a Kconfig symbol just for that, one that would NOT 
> appear in menuconfig because it makes no sense to make it selectable (I 
> think this can be achieved without a prompt?), e.g. (not tested):
> """
> config ROCKCHIP_SPI_IMAGE_TYPE
>      string
>      depends on ROCKCHIP_SPI_IMAGE
>      default "rksd"
>      default "rkspi" if ROCKCHIP_RK3399
>      help
>        The type passed to mkimage to generate a TPL+SPL image bootable 
> from SPI flash on Rockchip SoCs.
> """
> 
> and then have
> """
> args = "-n", CONFIG_SYS_SOC, "-T", CONFIG_ROCKCHIP_SPI_IMAGE_TYPE;
> """
> 
> in rockchip-u-boot.dtsi instead?

Agree that we should try to fix this in a different way, still not sure
what the best approach will be.

Another approach I played around with was to modify the mkimage rkspi
format to only apply the 2K padding on affected SoCs [2]. At that time I
used the RK_HEADER_V1/V2 flag, but as seen for RK3328 that cannot be
used to reliably know if the padding is needed or not.

From what I can see in mainline U-Boot only boards with the following
SoCs have ROCKCHIP_SPI_IMAGE enabled:

- RK3288 and RK3399 (2K per page)
- RK356x and RK3588 (full page)

With RK3328 also using full page read the scale have now tipped over so
that we could prefer rksd format over rkspi. Unless anyone would like
to enable it for a board with an older SoC.

I am open for any suggestion on how we should proceed :-)

[2] https://github.com/Kwiboo/u-boot-rockchip/commit/7b42660412493496c379015dc5019c89caf85ddf

> 
> I've missed those changes for other SoCs but did you explain why the SPI 
> image is expected to start at offset 0x8000? We don't have that in 
> rockchip-u-boot.dtsi by default, so offset 0 I assume.

Based on my testing of boot from SPI flash on RK356x booting worked when
I wrote ID block @ 32 KiB offset from start of SPI flash. This was
different to the @ 0 offset used on RK3288 and RK3399.

Most documentation already mentioned that u-boot-rockchip-spi.bin should
be written to start of SPI flash. Adding an offset of 32 KiB so that the
same instruction can be used across SoCs seemed like the best approach.

Regards,
Jonas

> 
> Cheers,
> Quentin

