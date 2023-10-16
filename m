Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03727CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5568586BA4;
	Mon, 16 Oct 2023 16:41:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697467310;
	bh=lNFQvUL/0XBLzwsCsosLc8Q9muepfHWyMjygzWTV3Eg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OJgnhmxAk3oXm83kwvxzZfSAmX5+Ov44iqnKt8vTmtGHw120r1RF5JMbf4AIn81/3
	 JwNzujVKNfNYCB4HckOR6yC8THoI69yC+CVqRyiYfD2F0O0nVUQBOYg2U4hq+h8gA+
	 hcmGkLQcV5LpypPCUAFy9zram4u4QeaCHrI7btg+ciep2Tvlm2ACBRXm85BXe6Sws9
	 dBemgo8umkhn4JoYu2c8oJm5asOcyrh3XBm65t74SmzubJNwseoUc8yW8p8HIR6OEm
	 IXy+YzCXTFxzh0kLrbHktJcve8HHgVqWCybBNsZBysvSMxWG6ArLUmHzyHnEXw1pli
	 SFzYxkqelXkNw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6638786BA4; Mon, 16 Oct 2023 16:41:49 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9694086B71
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4S8KZ13tgtz9sb7;
 Mon, 16 Oct 2023 16:41:45 +0200 (CEST)
Message-ID: <27c9940c-ca33-412f-bb3d-0bca5e84ec50@denx.de>
Date: Mon, 16 Oct 2023 16:41:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] ARM64: dts: marvell: cn9310-crb: Remove duplicate
 pinctrl
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20230820233113.575818-1-judge.packham@gmail.com>
 <20230820233113.575818-2-judge.packham@gmail.com>
 <86f392b4-b549-9891-f272-73706543c5c0@denx.de>
In-Reply-To: <86f392b4-b549-9891-f272-73706543c5c0@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4S8KZ13tgtz9sb7
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

On 8/24/23 13:30, Stefan Roese wrote:
> On 8/21/23 01:31, Chris Packham wrote:
>> The cn9130.dtsi defines a pinctrl node for SPI1 (until recently it was
>> mislabeled as spi0). Use this instead of having a duplicate definition
>> with a different label.
>>
>> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> 
> Reviewed-by: Stefan Roese <sr@denx.de>

Applied to u-boot-marvell/master

Thanks,
Stefan


> Thanks,
> Stefan
> 
>> ---
>>
>>   arch/arm/dts/cn9130-crb.dtsi | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/dts/cn9130-crb.dtsi b/arch/arm/dts/cn9130-crb.dtsi
>> index b229725184a9..7dd36cae282b 100644
>> --- a/arch/arm/dts/cn9130-crb.dtsi
>> +++ b/arch/arm/dts/cn9130-crb.dtsi
>> @@ -125,11 +125,6 @@
>>           marvell,function = <0>;
>>       };
>> -    cp0_spi1_pins_crb: cp0-spi-pins-crb {
>> -        marvell,pins = < 13 14 15 16 >;
>> -        marvell,function = <3>;
>> -    };
>> -
>>       cp0_smi_pins_crb: cp0-smi-pins-crb {
>>           marvell,pins = < 40 41 >;
>>           marvell,function = <8>;
>> @@ -170,7 +165,7 @@
>>   &cp0_spi1 {
>>       pinctrl-names = "default";
>> -    pinctrl-0 = <&cp0_spi1_pins_crb>;
>> +    pinctrl-0 = <&cp0_spi1_pins>;
>>       reg = <0x700680 0x50>,        /* control */
>>             <0x2000000 0x1000000>,    /* CS0 */
>>             <0 0xffffffff>,        /* CS1 */
> 
> Viele Grüße,
> Stefan Roese
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
