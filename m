Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6B1C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 13:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 046E780FEC;
	Wed, 16 Apr 2025 15:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744809552;
	bh=iA7Ee5yGdvV20EUtPk4OJqLkrI2U/Hc5xF7+JwWeFcE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TUAMDqp786XeMnlOiEf2utCRZidyUSIutWjsBwFRWAuhEpGsjy+liaw+6GAS50O9G
	 7CoKD6/NRUlKwlO7tE4/B9d1kClTxQkinJoz8XIrEOL++R7eBsZUYigCy+E/nFaaTR
	 ueRCjZ67jJ6bpRWNxPhACi4PTDGkpDe32gOzoXhzmA8qQ7U7wKRzAEelLRgHGg6eET
	 v9mgIxV57HNU1bVwyDFxE78nSBjH2PdsDVL+d/FlnRQfV1zUhQ7WNeWlMVyRS2XAbk
	 S3jFZNKZzYxbTzDQXvymMPeGH0FDlu2imwSztomokSwNRdnTxnYDaIt16kEFl6WY4U
	 P76rtA8idF4Sg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE41B82B5B; Wed, 16 Apr 2025 15:19:10 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C066280F03
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 15:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Zd1nk3lyqz9sq3;
 Wed, 16 Apr 2025 15:19:06 +0200 (CEST)
Message-ID: <2352916b-0b35-470a-bf68-d1d069b0aca0@denx.de>
Date: Wed, 16 Apr 2025 15:19:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] configs: mvebu_espressobin_ultra-88f3720_defconfig:
 disable SATA
From: Stefan Roese <sr@denx.de>
To: Benjamin Schneider <bschnei@gmail.com>
Cc: Benjamin Schneider <ben@bens.haus>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 u-boot@lists.denx.de
References: <20250228192240.129406-1-ben@bens.haus>
 <9d9d3196-2e59-45bd-b388-72b75ee645e5@denx.de>
Content-Language: en-US
In-Reply-To: <9d9d3196-2e59-45bd-b388-72b75ee645e5@denx.de>
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

On 20.03.25 07:55, Stefan Roese wrote:
> On 28.02.25 20:22, Benjamin Schneider wrote:
>> This device uses the SCSI subsystem to interface with SATA devices.
>> Trying to use the sata command results in an unhandled exception.
>> This has the side effect of also causing bootflow scan to raise
>> an unhandled exception when it attempts to probe the SATA
>> subsystem. Disabling the sata command fixes this issue and does
>> not remove support for any boot devices.
>>
>> Signed-off-by: Benjamin Schneider <ben@bens.haus>
> 
> Reviewed-by: Stefan Roese <sr@denx.de>

Applied to u-boot-marvell/master

Thanks,
Stefan

> 
> Thanks,
> Stefan
> 
>> ---
>>
>>   configs/mvebu_espressobin_ultra-88f3720_defconfig | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/configs/mvebu_espressobin_ultra-88f3720_defconfig b/ 
>> configs/mvebu_espressobin_ultra-88f3720_defconfig
>> index 6f1a66f5f1..1cbeee8fcb 100644
>> --- a/configs/mvebu_espressobin_ultra-88f3720_defconfig
>> +++ b/configs/mvebu_espressobin_ultra-88f3720_defconfig
>> @@ -34,7 +34,6 @@ CONFIG_CMD_I2C=y
>>   CONFIG_CMD_MMC=y
>>   CONFIG_CMD_MTD=y
>>   CONFIG_CMD_PCI=y
>> -CONFIG_CMD_SATA=y
>>   CONFIG_CMD_SPI=y
>>   CONFIG_CMD_USB=y
>>   CONFIG_CMD_WDT=y
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

