Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EAEC072A2
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 05:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB7DD87582;
	Wed, 22 Nov 2023 06:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HkbB6j0A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8952487574; Wed, 22 Nov 2023 06:52:21 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DD768725C
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 06:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AM5qBZw004439;
 Tue, 21 Nov 2023 23:52:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700632331;
 bh=ZKd+IrVlMjBDpdkajOcr7bnfc/uyrHNNQeRCGXxDevs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=HkbB6j0A8eoz8niWB0ySEM2yzw7ylBJ/JDDeqJPLpxy8hGvQysWfhjskbwCXtpZmJ
 YQbbzp4DHYPtnukYwmd24iWma6X3XOItSSZzK3U4Sidzf+oriJQnBWNFJ/j4KcHhPJ
 a1HDx03vX33l56LwDRYY7c4487jVPhRMWY0VkCNU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AM5qBWI088363
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 21 Nov 2023 23:52:11 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 Nov 2023 23:52:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 Nov 2023 23:52:11 -0600
Received: from [172.24.227.36] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AM5q7XJ112976;
 Tue, 21 Nov 2023 23:52:08 -0600
Message-ID: <d57ffe06-4f4a-4fa7-89ad-4527769a3389@ti.com>
Date: Wed, 22 Nov 2023 11:22:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: k3-*-binman: Move to using templated FITs
Content-Language: en-US
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: <sjg@chromium.org>, <marcel.ziswiler@toradex.com>, <u-boot@lists.denx.de>, 
 <vigneshr@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, <kamlesh@ti.com>,
 <afd@ti.com>, <mkorpershoek@baylibre.com>
References: <20231115101024.3441093-1-n-francis@ti.com>
 <20231115101024.3441093-3-n-francis@ti.com>
 <20231122052045.2hdlhvag6lz3t3pk@uda0497581>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231122052045.2hdlhvag6lz3t3pk@uda0497581>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Manorit

On 22/11/23 10:50, Manorit Chawdhry wrote:
> Hi Neha,
> 
> On 15:40-20231115, Neha Malcom Francis wrote:
>> Reduce redundancy in code by using templates to generate the A72 boot
>> binaries (tispl.bin and u-boot.img) as well as R5 boot binary sysfw.itb
>> (for legacy boot following devices J721E and AM65x).
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   arch/arm/dts/k3-am625-sk-binman.dtsi          | 157 +--------
>>   .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 155 +-------
>>   arch/arm/dts/k3-am62a-sk-binman.dtsi          | 158 +--------
>>   arch/arm/dts/k3-am64x-binman.dtsi             | 151 +-------
>>   arch/arm/dts/k3-am65x-binman.dtsi             | 273 +-------------
>>   arch/arm/dts/k3-j7200-binman.dtsi             | 159 +--------
>>   arch/arm/dts/k3-j721e-binman.dtsi             | 332 +-----------------
>>   arch/arm/dts/k3-j721s2-binman.dtsi            | 157 +--------
>>   8 files changed, 54 insertions(+), 1488 deletions(-)
>>
>> diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
>> index 41277bf4bf..b7b5368886 100644
>> --- a/arch/arm/dts/k3-am625-sk-binman.dtsi
>> +++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
>> @@ -141,10 +141,7 @@
>>   
>>   #ifdef CONFIG_TARGET_AM625_A53_EVM
>>   
>> -#define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
>>   #define SPL_AM625_SK_DTB "spl/dts/k3-am625-sk.dtb"
>> -
>> -#define UBOOT_NODTB "u-boot-nodtb.bin"
>>   #define AM625_SK_DTB "u-boot.dtb"
>>   
>>   &binman {
>> @@ -155,55 +152,11 @@
>>   		};
>>   	};
>>   	ti-spl {
>> -		filename = "tispl.bin";
>> -		pad-byte = <0xff>;
>> +		insert-template = <&ti_spl_template>;
>>   
>>   		fit {
>> -			description = "Configuration to load ATF and SPL";
>> -			#address-cells = <1>;
>> -
>>   			images {
>> -
>> -				atf {
>> -					description = "ARM Trusted Firmware";
>> -					type = "firmware";
>> -					arch = "arm64";
>> -					compression = "none";
>> -					os = "arm-trusted-firmware";
>> -					load = <CONFIG_K3_ATF_LOAD_ADDR>;
>> -					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
>> -					ti-secure {
>> -						content = <&atf>;
>> -						keyfile = "custMpk.pem";
>> -					};
> 
> For ATF/OP-TEE Firewalling, can you keep these nodes intact? Just keep
> the ti-secure inside atf and tee nodes similar to how you have done that
> for DM as all the ATF/OPTEE nodes in the tispl.bin would be different
> for devices w.r.t certifications but we can still use templates for
> other common stuff.
> 

I believe you will still be able to process firewalling by adding the extra 
parameters in the board binman DTSI file. The reason for retaining DM was 
different. For example, for J721E:

diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 5ddb474e3a..647b5dc629 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -146,6 +146,27 @@

  		fit {
  			images {
+				atf {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-257-0 {
+						/* cpu_0_cpu_0_msmc Background Firewall */
+							id = <257>;
+							region = <0>;
+							control = <(FWCTRL_EN | FWCTRL_LOCK |
+										FWCTRL_BG | FWCTRL_CACHE)>;
+							permissions = <((FWPRIVID_ALL << FWPRIVID_SHIFT) |
+											FWPERM_SECURE_PRIV_RWCD |
+											FWPERM_SECURE_USER_RWCD |
+											FWPERM_NON_SECURE_PRIV_RWCD |
+											FWPERM_NON_SECURE_USER_RWCD)>;
+							start_address = <0x0 0x0>;
+							end_address = <0xff 0xffffffff>;
+						};
+					};
+				};
+
  				dm {
  					ti-secure {
  						content = <&dm>;


I have only checked whether this builds fine without any errors. If you could 
check whether the intended functionality also works, we should be good.

> With this change,
> 
> Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
> 
> Regards,
> Manorit
>> -					atf: atf-bl31 {
>> -					};
>> -				};
>> -

[...]

-- 
Thanking You
Neha Malcom Francis
