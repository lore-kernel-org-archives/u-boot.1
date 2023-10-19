Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEA5CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 12:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B30787045;
	Thu, 19 Oct 2023 14:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="f2zJ72qP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28ED88704A; Thu, 19 Oct 2023 14:42:48 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9DBD86F9A
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 14:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF66AC000A;
 Thu, 19 Oct 2023 12:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1697719365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fq4+PexogCzzsSdGjjnkBPK4F1Ta9W7eRuSmuNHSNY4=;
 b=f2zJ72qPG8tjEUTmrm0j0Xh/jIeYEs61DgiLE5/LWKPO0QdfnNkyUhn5avehkk82DJoz3y
 82mEbyS8LsfuwV0Zo9idw7erAZtOD6u8bS4cYoLw+jovOlKj11tZ9YgmklxXu/o6omFRuW
 aWLDvF75ElYQ4FvN+7xPQfYfldZ9s0yfKzW7rX/N16jKi8eE3cvH1rZTiyDx5crFYr2MT6
 4w1WPDKr64Kcc0uTGJXklUcfXLvoP8y7iO/gGNXYmrE0GTVrRMmGRbEREVi/R5jC2jqyzX
 81G4SxEwbezDCwEHqU0IHrTcMZiOBVIigYBPSqZpC2OxUM59epR25cVmgZqsGA==
Message-ID: <311c04dc-8bd5-4300-b496-6dc41403481e@bootlin.com>
Date: Thu, 19 Oct 2023 14:42:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] DO NOT MERGE: arm: dts: k3-j7200-r5-common: Add pmic
 node for esm
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com,
 Gowtham Tammana <g-tammana@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>
References: <20231016141135.325698-1-thomas.richard@bootlin.com>
 <20231016141135.325698-2-thomas.richard@bootlin.com>
 <20231016162915.53tpyquivwltekdr@anagram>
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20231016162915.53tpyquivwltekdr@anagram>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com
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

On 10/16/23 18:29, Nishanth Menon wrote:
> On 16:11-20231016, Thomas Richard wrote:
>> From: Gowtham Tammana <g-tammana@ti.com>
>>
>> Add pmic tps659413 node needed for ESM error event handling.
>>
>> Signed-off-by: Gowtham Tammana <g-tammana@ti.com>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> ---
>>
>>  arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 17 ++++++++++++++---
>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>> index e62f9218e8..2bf0d5e3c0 100644
>> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>> @@ -249,13 +249,24 @@
>>  
>>  &wkup_i2c0 {
>>  	bootph-pre-ram;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&wkup_i2c0_pins_default>;
>> +	clock-frequency = <400000>;
>> +
>> +	tps659413: tps659413@48 {
>> +		compatible = "ti,tps659413";
>> +		reg = <0x48>;
>> +		bootph-pre-ram;
>> +
>> +		regulators_a: regulators {
>> +			bootph-pre-ram;
>> +		};
>> +	};
>> +
>>  	lp876441: lp876441@4c {
>>  		compatible = "ti,lp876441";
>>  		reg = <0x4c>;
>>  		bootph-pre-ram;
>> -		pinctrl-names = "default";
>> -		pinctrl-0 = <&wkup_i2c0_pins_default>;
>> -		clock-frequency = <400000>;
>>  
>>  		regulators: regulators {
>>  			bootph-pre-ram;
>> -- 
>> 2.39.2
>>
> 
> Please send these changes upstream linux kernel.

Hi Nishanth,

I found this series
(https://lore.kernel.org/all/20230810-tps6594-v6-0-2b2e2399e2ef@ti.com/)
which includes a patch to create the two pmic nodes for j7200 target.
It matches exactly my needs.

I found it was merged in TI linux kernel
https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi?h=ti-linux-6.1.y&id=0b3a445305b24aafba567909dac75961a0e8908c)


But referring to your answer
(https://lore.kernel.org/all/169164472311.19570.17843597381384613605.b4-ty@ti.com/)
this series will not be merged upstream as is.

Should I send a single patch to declare pmics only for J7200 ?
Could I just send a minimal definition of the pmics, or should I send a
full definition (including regulators) ?

Regards,

Thomas


