Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567C2CA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBB5A81D6A;
	Tue, 19 Aug 2025 09:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="qv7VLCRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5424C8211F; Tue, 19 Aug 2025 09:22:04 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C9B802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=43k19fH9wQnwK2bp4Dj8I+fhQlXyoOCMYSEOIkWT3V0=; b=qv7VLCRtIcznCf8zormee0RCFY
 SHqu5oxdDp+U42j1ZA1Xg13quwTFjU67Qctvvh4FjY+SXvOQygHO8ttjeJDqZ+ITEf2C61Vqi2ljG
 V1HuZ569rZ0/ZuDjxUcDYmXvrS1UdgCZJEw1AJAW1f2YSYVFeDddc0xvEjP49h975Ng8ntE3i063G
 dotUgVuiCPTCK+KIrXqxHZuoYCS46547k/gQXNYAssb01Z+RcIbnSTpxiYy1UpQzbseOpAr4bjtUO
 nOT5A3Y2A9eBsnWGMEionFSiFBN5eU410/B9dZL+kf3c7OLyXrLM+RMajSDGbJrypwpcYi/iVnk2w
 aFcpOLag==;
Received: from [89.212.21.243] (port=44788 helo=[192.168.69.116])
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1uoGfR-005fhC-0W;
 Tue, 19 Aug 2025 09:22:01 +0200
Message-ID: <252daf0f-1c3f-4bf3-9151-e1e4e7302e10@norik.com>
Date: Tue, 19 Aug 2025 09:22:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: phytec: phycore-imx93: Fix EEPROM bus mismatch in
 SPL
To: Wadim Egorov <w.egorov@phytec.de>, Mathieu Othacehe
 <m.othacehe@gmail.com>, Christoph Stoidner <c.stoidner@phytec.de>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20250819053941.908834-1-primoz.fiser@norik.com>
 <b63a3acd-5d8d-4e54-9f53-873cfd26872c@phytec.de>
Content-Language: en-US
From: Primoz Fiser <primoz.fiser@norik.com>
Autocrypt: addr=primoz.fiser@norik.com; keydata=
 xjMEZrROOxYJKwYBBAHaRw8BAQdAADVOb5tiLVTUAC9nu/FUl4gj/+4fDLqbc3mk0Vz8riTN
 JVByaW1veiBGaXNlciA8cHJpbW96LmZpc2VyQG5vcmlrLmNvbT7CiQQTFggAMRYhBK2YFSAH
 ExsBZLCwJGoLbQEHbnBPBQJmtE47AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQagttAQducE+T
 gAD+K4fKlIuvH75fAFwGYG/HT3F9mN64majvqJqvp3gTB9YBAL12gu+cm11m9JMyOyN0l6Os
 jStsQFghPkzBSDWSDN0NzjgEZrROPBIKKwYBBAGXVQEFAQEHQP2xtEOhbgA+rfzvvcFkV1zK
 6ym3/c/OUQObCp50BocdAwEIB8J4BBgWCAAgFiEErZgVIAcTGwFksLAkagttAQducE8FAma0
 TjwCGwwACgkQagttAQducE8ucAD9F1sXtQD4iA7Qu+SwNUAp/9x7Cqr37CSb2p6hbRmPJP8B
 AMYR91JYlFmOJ+ScPhQ8/MgFO+V6pa7K2ebk5xYqsCgA
Organization: Norik systems d.o.o.
In-Reply-To: <b63a3acd-5d8d-4e54-9f53-873cfd26872c@phytec.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Hi Wadim,

On 19. 08. 25 08:25, Wadim Egorov wrote:
> Hi Primoz,
> 
> we just introduced CONFIG_PHYTEC_EEPROM_BUS [1]. Can you check if it is
> relevant for this board?

Yes, I would like us to migrate to CONFIG_PHYTEC_EEPROM_BUS later.

But we need this patch first on i.MX93 to sync SPL and U-Boot proper on
I2C bus ordering.

BR,
Primoz

> 
> [1] https://lists.denx.de/pipermail/u-boot/2025-August/596708.html
> 
> Regards,
> Wadim
> 
> 
> On 8/19/25 8:39 AM, Primoz Fiser wrote:
>> Fix PHYTEC EEPROM bus mismatch between SPL and U-Boot proper by enabling
>> CONFIG_SPL_DM_SEQ_ALIAS=y on phyCORE-i.MX93 boards. This way, both the
>> SPL and U-Boot proper will respect the device-tree aliases for I2C devs
>> and use the same I2C bus number for phytec_eeprom_data_setup() function
>> calls. This makes code less confusing and more robust.
>>
>> Fixes an issue apparent since commit 79f3e77133bd ("Subtree merge tag
>> 'v6.16-dts' of dts repo [1] into dts/upstream") where SPL would spew the
>> following error:
>>
>>    phytec_eeprom_read: i2c EEPROM not found: -110.
>>    phytec_eeprom_data_setup: EEPROM data init failed
>>
>> While later in U-Boot proper, EEPROM would be successfully read out.
>> This happens because Linux device-tree for phyBOARD-Segin-i.MX93 since
>> aforementioned commit enables I2C bus 2 (lpi2c2 is used for audio codec
>> and RTC) which breaks SPL I2C bus number ordering and I2C EEPROM bus is
>> shifted by +1. Now, lets prevent this from happening again by utilizing
>> device-tree aliases also in the SPL.
>>
>> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
>> ---
>>   board/phytec/phycore_imx93/spl.c | 3 +--
>>   configs/imx93-phycore_defconfig  | 1 +
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/
>> phycore_imx93/spl.c
>> index 7b5d38d438f2..beaa536c6007 100644
>> --- a/board/phytec/phycore_imx93/spl.c
>> +++ b/board/phytec/phycore_imx93/spl.c
>> @@ -52,8 +52,7 @@ void spl_dram_init(void)
>>       int ret;
>>       enum phytec_imx93_ddr_eeprom_code ddr_opt =
>> PHYTEC_IMX93_DDR_INVALID;
>>   -    /* NOTE: In SPL lpi2c3 is mapped to bus 0 */
>> -    ret = phytec_eeprom_data_setup(NULL, 0, EEPROM_ADDR);
>> +    ret = phytec_eeprom_data_setup(NULL, 2, EEPROM_ADDR);
>>       if (ret && !IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_FIX))
>>           goto out;
>>   diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-
>> phycore_defconfig
>> index 6210be646723..af149128ed41 100644
>> --- a/configs/imx93-phycore_defconfig
>> +++ b/configs/imx93-phycore_defconfig
>> @@ -92,6 +92,7 @@ CONFIG_USE_ETHPRIME=y
>>   CONFIG_ETHPRIME="eth1"
>>   CONFIG_NET_RANDOM_ETHADDR=y
>>   CONFIG_SPL_DM=y
>> +CONFIG_SPL_DM_SEQ_ALIAS=y
>>   CONFIG_SPL_CLK_IMX93=y
>>   CONFIG_CLK_IMX93=y
>>   CONFIG_DFU_MMC=y
> 

-- 
Primoz Fiser
phone: +386-41-390-545
email: primoz.fiser@norik.com
--
Norik systems d.o.o.
Your embedded software partner
Slovenia, EU
phone: +386-41-540-545
email: info@norik.com

