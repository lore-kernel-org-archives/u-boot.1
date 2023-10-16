Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64915CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF61C86CE3;
	Mon, 16 Oct 2023 16:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697467294;
	bh=+9GLWYcAioCrJT+1TSf3sr55xKV4LqK3OJjp9hI2PX4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X3/eQ7x3m4MohxOy3A6RWyll8YqrHy7np9LWlBLdTLtoc5HUr4ZkHQrDlu+4xvpex
	 08Evfs60bReKseEnF5abnS4BZuQ+icyyxPIsb+Al2ASCZXycd/JBBb0gEVM4RKn40M
	 pMcpjF7+42UiWT1pCU+yJRsSsE1mH43gvI/1orzRNGsMZ5uKFMeOUAOjswkfgvXzb7
	 WrinM6CWKrfy0xwgKmnHP26RCTshMsTRBIikJ5txGpA90zxQ56eMeD8iItIOWMlW9E
	 R4fG68yWmLP6yZAs6+2X9Ly/lAX76mh2bzpoP2UQBFnf2iOjq4NjGyUN1Q9wtgZ/nn
	 ikKAFQD1BrDCg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A272186D56; Mon, 16 Oct 2023 16:41:33 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D51CA86B71
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4S8KYj63r2z9slp;
 Mon, 16 Oct 2023 16:41:29 +0200 (CEST)
Message-ID: <83bd3e70-8201-43d4-b575-8dbcb5ef4270@denx.de>
Date: Mon, 16 Oct 2023 16:41:29 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] ARM64: dts: marvell: cn9310: Use appropriate label
 for spi1 pins
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20230820233113.575818-1-judge.packham@gmail.com>
 <a39373fd-3488-5d36-dc9e-0ed9145e3983@denx.de>
In-Reply-To: <a39373fd-3488-5d36-dc9e-0ed9145e3983@denx.de>
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

On 8/24/23 13:29, Stefan Roese wrote:
> On 8/21/23 01:31, Chris Packham wrote:
>> The CN9130-DB uses the SPI1 interface but had the pinctrl node labelled
>> as "cp0_spi0_pins". Use the label "cp0_spi1_pins" and update the node
>> name to "cp0-spi-pins-1" to avoid confusion with the pinctrl options for
>> SPI0.
>>
>> Signed-off-by: Chris Packham <judge.packham@gmail.com>
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
>>   arch/arm/dts/cn9130-db.dtsi | 2 +-
>>   arch/arm/dts/cn9130.dtsi    | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/dts/cn9130-db.dtsi b/arch/arm/dts/cn9130-db.dtsi
>> index 1b28732ee752..4b21ff46d507 100644
>> --- a/arch/arm/dts/cn9130-db.dtsi
>> +++ b/arch/arm/dts/cn9130-db.dtsi
>> @@ -183,7 +183,7 @@
>>   /* U55 */
>>   &cp0_spi1 {
>>       pinctrl-names = "default";
>> -    pinctrl-0 = <&cp0_spi0_pins>;
>> +    pinctrl-0 = <&cp0_spi1_pins>;
>>       reg = <0x700680 0x50>,        /* control */
>>             <0x2000000 0x1000000>,    /* CS0 */
>>             <0 0xffffffff>,        /* CS1 */
>> diff --git a/arch/arm/dts/cn9130.dtsi b/arch/arm/dts/cn9130.dtsi
>> index 68b767a70639..efcb2e906b91 100644
>> --- a/arch/arm/dts/cn9130.dtsi
>> +++ b/arch/arm/dts/cn9130.dtsi
>> @@ -66,7 +66,7 @@
>>           marvell,pins = < 56 57 58 59 60 61 >;
>>           marvell,function = <14>;
>>       };
>> -    cp0_spi0_pins: cp0-spi-pins-0 {
>> +    cp0_spi1_pins: cp0-spi-pins-1 {
>>           marvell,pins = < 13 14 15 16 >;
>>           marvell,function = <3>;
>>       };
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
