Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB96E71088
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 15:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E33186429;
	Thu, 21 Sep 2023 17:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695309369;
	bh=AVaykbtxJ3vljB/qdyOLFHPDmhgiG8pPQ62or8susPI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jk1liICuzcxtgY+SKfsLDA8w6psde56w3kFGE5WS0ZmxUGENUf1ySBsaWycRQAkfJ
	 FN1qowZo1rs7/KGNHB+FnsULR1Bs1Yfy6YxNL6ugNLlJ2JNrF6rauZOfN35S72GFOJ
	 FhMwwx79WS7+4ZOvCFBKzsgs9PP1pWRht9JoAuvFmVvZs/JxWoUxbv/Rv+jia6ASEg
	 tZOlmrBpcC359KcqJsIoBZgJ6naO7RLoPVhFX+oJXcmj/U90Rrx1Y3YpyCg0359/2v
	 JXDRYyhuk8BrMQbumPZE2xS1/63XazyYWCnm4KG3pwFOQZ1dB8CDhMY9n1EjPPz+xQ
	 ciAl4iE1+HRLQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F66F867D2; Thu, 21 Sep 2023 17:16:08 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A6B86377
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 17:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4RrzW72WVwz9sSl;
 Thu, 21 Sep 2023 17:16:03 +0200 (CEST)
Message-ID: <84b0485a-5175-8bee-474f-b713f16c00dd@denx.de>
Date: Thu, 21 Sep 2023 17:16:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: versal: Add SelectMAP boot mode identification
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, "Polak, Leszek" <LPolak@arri.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <DU0PR07MB8419EB5D613237A44374949DC8FAA@DU0PR07MB8419.eurprd07.prod.outlook.com>
 <5f2b9d87-7427-4a6f-9a67-017ae78cb51d@amd.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <5f2b9d87-7427-4a6f-9a67-017ae78cb51d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/21/23 13:14, Michal Simek wrote:
> 
> 
> On 9/19/23 14:47, Polak, Leszek wrote:
>> Add missing SelectMAP bootmode for proper identification during boot.
>>
>> The SelectMAP configuration interface provides an 8-bit, 16-bit or
>> 32-bit bidirectional data bus interface to the Versal FPGA
>> configuration logic that can be used for both configuration and
>> readback.
>>
>> A connected microcontoller to the SelectMAP interface can load boot
>> image with bitstream, TF-A (ARM Trusted Firmware) and U-Boot.
>>
>> This commit adds the missing identification of the SelectMAP mode.
>>
>> Signed-off-by: Leszek Polak <lpolak@arri.de>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: Stefan Roese <sr@denx.de>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

>> ---
>>   arch/arm/mach-versal-net/include/mach/hardware.h | 1 +
>>   arch/arm/mach-versal/include/mach/hardware.h     | 1 +
>>   board/xilinx/versal-net/board.c                  | 4 ++++
>>   board/xilinx/versal/board.c                      | 5 +++++
>>   4 files changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/mach-versal-net/include/mach/hardware.h 
>> b/arch/arm/mach-versal-net/include/mach/hardware.h
>> index 9bddb8b00723..767cdd368682 100644
>> --- a/arch/arm/mach-versal-net/include/mach/hardware.h
>> +++ b/arch/arm/mach-versal-net/include/mach/hardware.h
>> @@ -66,6 +66,7 @@ struct crp_regs {
>>   #define EMMC_MODE    0x00000006
>>   #define USB_MODE    0x00000007
>>   #define OSPI_MODE    0x00000008
>> +#define SELECTMAP_MODE    0x0000000A
>>   #define SD1_LSHFT_MODE    0x0000000E /* SD1 Level shifter */
>>   #define JTAG_MODE    0x00000000
>>   #define BOOT_MODE_USE_ALT    0x100
>> diff --git a/arch/arm/mach-versal/include/mach/hardware.h 
>> b/arch/arm/mach-versal/include/mach/hardware.h
>> index 000af974e867..9d1c2f0dcfc1 100644
>> --- a/arch/arm/mach-versal/include/mach/hardware.h
>> +++ b/arch/arm/mach-versal/include/mach/hardware.h
>> @@ -82,6 +82,7 @@ struct crp_regs {
>>   #define EMMC_MODE    0x00000006
>>   #define USB_MODE    0x00000007
>>   #define OSPI_MODE    0x00000008
>> +#define SELECTMAP_MODE    0x0000000A
>>   #define SD1_LSHFT_MODE    0x0000000E /* SD1 Level shifter */
>>   #define JTAG_MODE    0x00000000
>>   #define BOOT_MODE_USE_ALT    0x100
>> diff --git a/board/xilinx/versal-net/board.c 
>> b/board/xilinx/versal-net/board.c
>> index f0d2224b332e..992e0df73b30 100644
>> --- a/board/xilinx/versal-net/board.c
>> +++ b/board/xilinx/versal-net/board.c
>> @@ -287,6 +287,10 @@ int board_late_init(void)
>>           mode = "mmc";
>>           bootseq = dev_seq(dev);
>>           break;
>> +    case SELECTMAP_MODE:
>> +        puts("SELECTMAP_MODE\n");
>> +        mode = "selectmap";
> 
> We are not defining distro boot for selectmap that's why boot_targets 
> don't need to be extended. That's why please remove this line.
> 
>> +        break;
>>       default:
>>           mode = "";
>>           printf("Invalid Boot Mode:0x%x\n", bootmode);
>> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
>> index 60bf37d3c90f..b619dbc73c80 100644
>> --- a/board/xilinx/versal/board.c
>> +++ b/board/xilinx/versal/board.c
>> @@ -213,6 +213,10 @@ int board_late_init(void)
>>           mode = "mmc";
>>           bootseq = dev_seq(dev);
>>           break;
>> +    case SELECTMAP_MODE:
>> +        puts("SELECTMAP_MODE\n");
>> +        mode = "selectmap";
> 
> The same here.
> 
>> +        break;
>>       default:
>>           mode = "";
>>           printf("Invalid Boot Mode:0x%x\n", bootmode);
>> @@ -298,6 +302,7 @@ enum env_location env_get_location(enum 
>> env_operation op, int prio)
>>               return ENVL_SPI_FLASH;
>>           return ENVL_NOWHERE;
>>       case JTAG_MODE:
>> +    case SELECTMAP_MODE:
>>       default:
>>           return ENVL_NOWHERE;
>>       }
>> -- 
>> 2.42.0
> 
> The rest looks good to me.
> 
> Thanks,
> Michal

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
