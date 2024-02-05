Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6700C4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 13:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF927865D0;
	Mon,  5 Feb 2024 14:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RpOUGt8P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 276E486F8E; Mon,  5 Feb 2024 14:05:34 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 814D786308
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 14:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4887=JP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707138321;
 bh=KAXQDt4l6ZS+1BLReCqYsNJvtU7h38pCoxlnDOBAgoA=;
 b=RpOUGt8PctHCWGo29lmR3uMKloDZ9li9IaEcunQLXXTdAcjOqg+r/iBIlgF54u6xfRehT0I8O
 jCL+J42VOR4n/BAL7rhcYTY4ZVEL6TCMJ9TBhoWGVnacV5PMdOYBSSafL2GzNBwzWcEDjRXVZin
 sRGDlvYheQsKxJEp+fAjEzzdtEetQBN2ZPcGb3fPliCn2F1j3RnOqEa+xZOS4yyXSWLlGfSZOka
 UogUaNkdLYnCKbzXR7g9NvXsV+jJMUoXoLFflOXJppwnwbSdpi7p5FwcosuWby69tqw0bW0R0kZ
 22HdB52besoerLlA0ajeDYqDFDmC5+zZAMGPyko78jEA==
Message-ID: <be4737c1-57e0-4648-b583-56fcab91b20f@kwiboo.se>
Date: Mon, 5 Feb 2024 14:05:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: rk35xx: Enable eMMC HS200 mode by default
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>, Weizhao Ouyang
 <o451686892@gmail.com>, u-boot@lists.denx.de
References: <20240204205312.2342868-1-jonas@kwiboo.se>
 <20240204205312.2342868-3-jonas@kwiboo.se>
 <5124b52c-47d7-4232-907d-d09a5065ff1e@theobroma-systems.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <5124b52c-47d7-4232-907d-d09a5065ff1e@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c0dd10a7f28028f81cffdb
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

On 2024-02-05 10:47, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 2/4/24 21:53, Jonas Karlman wrote:
>> Testing has shown that writing to eMMC using a slower mode then HS200
>> typically generate an ERROR on first attempt on RK3588.
>>
>>    # Rescan using MMC legacy mode
>>    => mmc rescan 0
>>
>>    # Write a single block to sector 0x4000 fails with ERROR
>>    => mmc write 20000000 4000 1
>>
>>    # Write a single block to sector 0x4000 now works
>>    => mmc write 20000000 4000 1
>>
>> With the MMC_SPEED_MODE_SET Kconfig option enabled.
>>
>> Writing to eMMC using HS200 mode work more reliably than slower modes on
>> RK35xx boards. Enable MMC_HS200_SUPPORT Kconfig option by default to
>> prefer use of HS200 mode on RK356x and RK3588.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Changes in v2:
>> - Imply MMC_HS200_SUPPORT and SPL_MMC_HS200_SUPPORT in arch Kconfig
>>    instead of adding to each boards defconfig
>> - R-b tags not collected because of above change
>> - Combine changes for rk356x and rk3588 in one patch
>> - Update commit message
>>
>> Link to v1: https://patchwork.ozlabs.org/patch/1891693/
>> ---
>>   arch/arm/mach-rockchip/Kconfig      | 4 ++++
>>   configs/nanopi-r5c-rk3568_defconfig | 2 --
>>   configs/nanopi-r5s-rk3568_defconfig | 2 --
>>   configs/radxa-e25-rk3568_defconfig  | 2 --
>>   4 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>> index 6ff0aa6911e2..946ef5d7023d 100644
>> --- a/arch/arm/mach-rockchip/Kconfig
>> +++ b/arch/arm/mach-rockchip/Kconfig
>> @@ -292,6 +292,8 @@ config ROCKCHIP_RK3568
>>   	imply OF_LIBFDT_OVERLAY
>>   	imply ROCKCHIP_OTP
>>   	imply MISC_INIT_R
>> +	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
> 
> MMC_SDHCI_ROCKCHIP is also required for eMMC on RK3399, which would 
> change the current default, at the very least for Puma RK3399.
> 
> Doing a:
> 
> rg -lU --multiline-dotall 'RK3399.*MMC_HS.*' configs/
> 
> Only returns:
> configs/evb-rk3399_defconfig
> configs/pinebook-pro-rk3399_defconfig
> 
> and there are 29 defconfigs for RK3399-based boards right now, so maybe 
> that's a bit too big of a change?

The imply statements added in this patch should only affect
ROCKCHIP_RK3568 and ROCKCHIP_RK3588, nothing should change for RK3399,
at least not intentionally. 

Regards,
Jonas

> 
> Cheers,
> Quentin

