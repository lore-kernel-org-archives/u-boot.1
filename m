Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114D4CCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 04:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EBE683642;
	Mon,  3 Nov 2025 05:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="UMvXLTbP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CAA8836D1; Mon,  3 Nov 2025 05:22:15 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DA9C8331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 05:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1762143696;
 bh=8+vdquLgXxJN6ULxDNsopSOWf3tNTLVNrjZjgZQc0WE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UMvXLTbPAguHRc7bPLKsm6QM1tZU8a+gND3Ht1joK5Dr1sL8ENM8/EB+seNwOxCt3
 HUILHPvmsF+tU+YABSdADBKGiYxpvCVs8cGxQOhFWPxPe7HjZJaWc67P6REdBPWpNH
 ZvLYGdomb3h7n+thhGfBRgN3cLWEdKSvXyIlOJUsRVANvPhjPOP2PYL4Tso8ZeiS8y
 swTgl7lm24abJJIhF8fLEM21Dd0nCWBBS7xPdUnjC2Z+fQynWZOTQPdMBO6pKHhBuV
 +KbkUvcsVpf7o1/AuLAwGNVl4OVGEORI+RPZFG0ao/4yqxy5uIPVA6DGrZs7iVs+ZJ
 hhRIQv0lmJ6+A==
Received: from [192.168.2.54] (unknown [98.97.27.75]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 73415B221314;
 Mon,  3 Nov 2025 05:21:35 +0100 (CET)
Message-ID: <38311b15-c3e9-4b75-bd80-fc4b372301e6@freeshell.de>
Date: Sun, 2 Nov 2025 20:21:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] ram: starfive: drop references to 16GB memory size
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
References: <20251030062354.35413-1-e@freeshell.de>
 <20251030062354.35413-2-e@freeshell.de>
 <2f1605c2-c23c-41cf-b9e2-78c29d5475dd@gmx.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <2f1605c2-c23c-41cf-b9e2-78c29d5475dd@gmx.de>
Content-Type: text/plain; charset=UTF-8
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



On 10/30/25 00:53, Heinrich Schuchardt wrote:
> On 10/30/25 07:23, E Shattow wrote:
>> 16GB memory size is not addressable on StarFive JH-7110 SoC because the
>> DRAM uncached alias begins at +8GB offset from start of DRAM. The logic
>> for 16GB memory size is a fall-through to the default for an unknown
>> size.
>> Let's drop this unnecessary 16GB memory size and rely on the case
>> default.
>>
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>>   drivers/ram/starfive/ddrcsr_boot.c  | 3 ---
>>   drivers/ram/starfive/ddrphy_start.c | 1 -
>>   drivers/ram/starfive/starfive_ddr.c | 1 -
>>   drivers/ram/starfive/starfive_ddr.h | 1 -
>>   4 files changed, 6 deletions(-)
>>
>> diff --git a/drivers/ram/starfive/ddrcsr_boot.c b/drivers/ram/
>> starfive/ddrcsr_boot.c
>> index 6764b3ed5cc..ece6f5aae94 100644
>> --- a/drivers/ram/starfive/ddrcsr_boot.c
>> +++ b/drivers/ram/starfive/ddrcsr_boot.c
>> @@ -231,7 +231,6 @@ void ddrcsr_boot(u32 *csrreg, u32 *secreg, u32
>> *phyreg, enum ddr_size_t size)
>>           mask = REG8G;
>>           break;
>>   -    case DDR_SIZE_16G:
>>       default:
>>           return;
>>       };
>> @@ -260,7 +259,6 @@ void ddrcsr_boot(u32 *csrreg, u32 *secreg, u32
>> *phyreg, enum ddr_size_t size)
>>           out_le32(csrreg + REGOFFSET(0x10), 0x3c);
>>           break;
>>   -    case DDR_SIZE_16G:
>>       default:
>>           break;
>>       };
>> @@ -286,7 +284,6 @@ void ddrcsr_boot(u32 *csrreg, u32 *secreg, u32
>> *phyreg, enum ddr_size_t size)
>>           break;
>>         case DDR_SIZE_2G:
> 
> Why don't we drop the line above? It is just falling through to default.
> 
> Best regards
> 
> Heinrich
> 

I hesitate to remove reachable code that is more readable and easily
searchable, without a technical document published to refer to about how
to initialize DDR memory. Here is code-as-documentation and the
verbosity is helpful.

>> -    case DDR_SIZE_16G:
>>       default:
>>           break;
>>       };
>> diff --git a/drivers/ram/starfive/ddrphy_start.c b/drivers/ram/
>> starfive/ddrphy_start.c
>> index efe3f8a181a..f26bc9ccaad 100644
>> --- a/drivers/ram/starfive/ddrphy_start.c
>> +++ b/drivers/ram/starfive/ddrphy_start.c
>> @@ -267,7 +267,6 @@ void ddr_phy_start(u32 *phyreg, enum ddr_size_t size)
>>           mask = REG8G;
>>           break;
>>   -    case DDR_SIZE_16G:
>>       default:
>>           return;
>>       };
>> diff --git a/drivers/ram/starfive/starfive_ddr.c b/drivers/ram/
>> starfive/starfive_ddr.c
>> index b31ed3bcf61..9e902f03ee9 100644
>> --- a/drivers/ram/starfive/starfive_ddr.c
>> +++ b/drivers/ram/starfive/starfive_ddr.c
>> @@ -47,7 +47,6 @@ static int starfive_ddr_setup(struct udevice *dev,
>> struct starfive_ddr_priv *pri
>>           size = DDR_SIZE_8G;
>>           break;
>>   -    case 0x400000000:
>>       default:
>>           pr_err("unsupport size %lx\n", priv->info.size);
>>           return -EINVAL;
>> diff --git a/drivers/ram/starfive/starfive_ddr.h b/drivers/ram/
>> starfive/starfive_ddr.h
>> index c29d26b510c..3ab0b0e8fa6 100644
>> --- a/drivers/ram/starfive/starfive_ddr.h
>> +++ b/drivers/ram/starfive/starfive_ddr.h
>> @@ -48,7 +48,6 @@ enum ddr_size_t {
>>       DDR_SIZE_2G,
>>       DDR_SIZE_4G,
>>       DDR_SIZE_8G,
>> -    DDR_SIZE_16G,
>>   };
>>     void ddr_phy_train(u32 *phyreg);
> 
-E
