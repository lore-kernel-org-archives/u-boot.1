Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABADCD6E4C
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 07:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FF418466E;
	Mon,  1 Jun 2026 09:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fsr09ryi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE936846A7; Mon,  1 Jun 2026 09:44:59 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1849840ED
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 09:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 429651A3795;
 Mon,  1 Jun 2026 07:44:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 144CF602AB;
 Mon,  1 Jun 2026 07:44:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 28DFD10888CB3; 
 Mon,  1 Jun 2026 09:44:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780299896; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=NlHYBNZfz9K5BN+9oScGd8zhl9L5XZBsgBCxEMXw4WA=;
 b=fsr09ryiboSHksbCw51yUTA73Vtenu7DacIel5k9THcJ/5umaNCxRZuCQZGdjb3vflfyRG
 vtBUMUBGNYg5OnBXQDl7t2hDY3Wsq/eUJnuVBOVaTKPLNsjZqDduVXb/FSivDL/Onr9vOC
 uWyZJNnBemr0cXVuGhZrIF7FeihtsUoPJzCEdvxiJbOOy6B7AksaEr7j3lCJ9JoaQkJiQs
 I6YOTxCAe+bGEeKJ6rG9a3Cjc3+89QAAZ05WHNZCDo6YuDg+RNdb42wPknvKxbnIvQ0WAG
 joeOcahOsLw7+Ef8eLNvNodYwrr5+kVcyV8CPzM2um54SDumOgZjfIakvS4WiQ==
Message-ID: <f500b4c0-063d-4743-bd14-4c917a3ee900@bootlin.com>
Date: Mon, 1 Jun 2026 09:44:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/20] arm: dts: k3-j7200: Extend firewall for ATF region
 to TIFS
To: Andrew Davis <afd@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar
 <u-kumar1@ti.com>, Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-21-richard.genoud@bootlin.com>
 <af7ef143-2bfb-424c-b1cf-a49fc02f9192@ti.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <af7ef143-2bfb-424c-b1cf-a49fc02f9192@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Le 30/04/2026 à 19:28, Andrew Davis a écrit :
> On 4/30/26 3:44 AM, Richard Genoud (TI) wrote:
>> From: Prasanth Babu Mantena <p-mantena@ti.com>
>>
>> Extend the access to SRAM region of ATF to TIFS as well. This is
>> needed for TIFS for encryption and decryption of ATF as a part of
>> low power mode sequence. TIFS encrypts the ATF while entering into
>> low power mode and decrypts it back while resuming back.
>> So, giving permissions for TIFS to access this region.
>>
>> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
>> ---
>>   arch/arm/dts/k3-binman.dtsi       | 18 ++++++++++++++++--
>>   arch/arm/dts/k3-j7200-binman.dtsi |  4 ++--
>>   arch/arm/dts/k3-security.h        |  1 +
>>   3 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
>> index 0fd93f9536a2..4ffd8ec9e1c1 100644
>> --- a/arch/arm/dts/k3-binman.dtsi
>> +++ b/arch/arm/dts/k3-binman.dtsi
>> @@ -479,7 +479,21 @@
>>           start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
>>           end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;
>>       };
>> -    firewall_armv8_optee_fg: template-8 {
>> +    firewall_armv8_atf_tifs_fg: template-8 {
>> +        control = <(FWCTRL_EN | FWCTRL_LOCK |
>> +                    FWCTRL_CACHE)>;
>> +        permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
>> +                        FWPERM_SECURE_PRIV_RWCD |
>> +                        FWPERM_SECURE_USER_RWCD)>,
>> +                    <((FWPRIVID_TIFS << FWPRIVID_SHIFT) |
>> +                        FWPERM_SECURE_PRIV_RWCD |
>> +                        FWPERM_SECURE_USER_RWCD |
>> +                        FWPERM_NON_SECURE_PRIV_RWCD |
>> +                        FWPERM_NON_SECURE_USER_RWCD)>;
>> +        start_address = <0x0 0x70000000>;
> 
> Should this be using CONFIG_K3_ATF_LOAD_ADDR like the other templates?
Yes definitely.

> 
> Might be easier to just update the existing `firewall_armv8_atf_fg`
> template to also always allow TIFS. TIFS is the security root and
> if it really wanted to it could just update firewalls to let itself
> in, not like anything is really protected from TIFS to begin with.
> (if we are not locking the firewalls that is)
Indeed, I'll change that.

Thanks!

> 
> Andrew
> 
>> +        end_address = <0x0 0x7001ffff>;
>> +    };
>> +    firewall_armv8_optee_fg: template-9 {
>>           control = <(FWCTRL_EN | FWCTRL_LOCK |
>>                       FWCTRL_CACHE)>;
>>           permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
>> @@ -489,7 +503,7 @@
>>           end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + 0x17fffff)>;
>>       };
>> -    ti_falcon_template: template-9 {
>> +    ti_falcon_template: template-10 {
>>           filename = "tifalcon.bin";
>>           pad-byte = <0xff>;
>> diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3- 
>> j7200-binman.dtsi
>> index c2b86339d593..68ce4aa0ff12 100644
>> --- a/arch/arm/dts/k3-j7200-binman.dtsi
>> +++ b/arch/arm/dts/k3-j7200-binman.dtsi
>> @@ -259,7 +259,7 @@
>>                           firewall-4760-1 {
>>                               /* nb_slv0__mem0 Foreground Firewall */
>> -                            insert-template = <&firewall_armv8_atf_fg>;
>> +                            insert-template = 
>> <&firewall_armv8_atf_tifs_fg>;
>>                               id = <4760>;
>>                               region = <1>;
>>                           };
>> @@ -272,7 +272,7 @@
>>                           firewall-4761-1 {
>>                               /* nb_slv1__mem0 Foreground Firewall */
>> -                            insert-template = <&firewall_armv8_atf_fg>;
>> +                            insert-template = 
>> <&firewall_armv8_atf_tifs_fg>;
>>                               id = <4761>;
>>                               region = <1>;
>>                           };
>> diff --git a/arch/arm/dts/k3-security.h b/arch/arm/dts/k3-security.h
>> index 33609caa8fb5..3e066bca6ad7 100644
>> --- a/arch/arm/dts/k3-security.h
>> +++ b/arch/arm/dts/k3-security.h
>> @@ -7,6 +7,7 @@
>>   #define DTS_ARM64_TI_K3_FIREWALL_H
>>   #define FWPRIVID_ALL    0xc3
>> +#define FWPRIVID_TIFS   0xca
>>   #define FWPRIVID_ARMV8  1
>>   #define FWPRIVID_SHIFT  16
> 

