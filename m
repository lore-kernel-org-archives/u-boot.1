Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A8FC54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D048D86BFA;
	Wed,  6 Mar 2024 14:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OR3lI2Pn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 497B686BDB; Wed,  6 Mar 2024 14:49:56 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 633AD87653
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 426Dnjqi007164;
 Wed, 6 Mar 2024 07:49:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709732985;
 bh=433j8dDf02mgOOTLdlf6Fz7eMgX3oJ4yylOcfkGOE2I=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=OR3lI2PnPgVTU2AbK9MxNYN0OcsGIjEYGa5jwgX4VHtuL+S0CGsmOxkTakN52A9q5
 J018LS8VETG3W5nvkPtPXlm1lYVWMBSRvF7zqebFhDFzicC41r3NrK5SojY2J7RxLM
 zto4rdPJj+FM2gaAgZhIFJWwhzxoGTDKazjULi1E=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 426Dnj1D009031
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Mar 2024 07:49:45 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 07:49:45 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 07:49:45 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 426Dni3a028558;
 Wed, 6 Mar 2024 07:49:45 -0600
Message-ID: <1441c976-1533-4b4b-b09f-88e9a8fd3944@ti.com>
Date: Wed, 6 Mar 2024 07:49:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm: mach-k3: Add config option for setting OP-TEE
 address
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20240214163009.983034-1-afd@ti.com>
 <20240214163009.983034-3-afd@ti.com>
 <20240228062113.bozx3di2daub4z7f@uda0497581>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240228062113.bozx3di2daub4z7f@uda0497581>
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

On 2/28/24 12:21 AM, Manorit Chawdhry wrote:
> Hi Andrew,
> 
> On 10:30-20240214, Andrew Davis wrote:
>> Much like we have for ATF, OP-TEE has a standard address that we load
>> it too and run it from. Add a Kconfig item for this to remove some
>> hard-coding and allow this address to be more easily changed.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi     | 4 ++--
>>   arch/arm/dts/k3-am65-iot2050-boot-image.dtsi     | 4 ++--
>>   arch/arm/dts/k3-binman.dtsi                      | 8 ++++----
>>   arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi | 4 ++--
>>   arch/arm/mach-k3/Kconfig                         | 7 +++++++
>>   5 files changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
>> index a723caa5805..cca0f44b7d8 100644
>> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
>> @@ -105,8 +105,8 @@
>>   					arch = "arm64";
>>   					compression = "none";
>>   					os = "tee";
>> -					load = <0x9e800000>;
>> -					entry = <0x9e800000>;
>> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>>   					tee-os {
>>   						filename = "tee-raw.bin";
>>   					};
>> diff --git a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
>> index 64318d09cf0..3a6db91e132 100644
>> --- a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
>> +++ b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
>> @@ -51,8 +51,8 @@
>>   					arch = "arm64";
>>   					compression = "none";
>>   					os = "tee";
>> -					load = <0x9e800000>;
>> -					entry = <0x9e800000>;
>> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>>   					tee-os {
>>   					};
>>   				};
>> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
>> index 758c8bf6ea1..621653e9471 100644
>> --- a/arch/arm/dts/k3-binman.dtsi
>> +++ b/arch/arm/dts/k3-binman.dtsi
>> @@ -286,8 +286,8 @@
>>   					arch = "arm64";
>>   					compression = "none";
>>   					os = "tee";
>> -					load = <0x9e800000>;
>> -					entry = <0x9e800000>;
>> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>>   					ti-secure {
>>   						content = <&tee>;
>>   						keyfile = "custMpk.pem";
>> @@ -356,8 +356,8 @@
>>   					arch = "arm64";
>>   					compression = "none";
>>   					os = "tee";
>> -					load = <0x9e800000>;
>> -					entry = <0x9e800000>;
>> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>>   					tee-os {
>>   						filename = "tee-raw.bin";
>>   					};
>> diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
>> index 017a5a722e0..ca99fa0e690 100644
>> --- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
>> @@ -250,8 +250,8 @@
>>   					arch = "arm64";
>>   					compression = "none";
>>   					os = "tee";
>> -					load = <0x9e800000>;
>> -					entry = <0x9e800000>;
>> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>>   					tee-os {
>>   						filename = "tee-raw.bin";
>>   					};
>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
>> index 0bd3f9fa12d..55bb874d9aa 100644
>> --- a/arch/arm/mach-k3/Kconfig
>> +++ b/arch/arm/mach-k3/Kconfig
>> @@ -129,6 +129,13 @@ config K3_ATF_LOAD_ADDR
>>   	  The load address for the ATF image. This value is used to build the
>>   	  FIT image header that places ATF in memory where it will run.
>>   
>> +config K3_OPTEE_LOAD_ADDR
>> +	hex "Load address of OPTEE image"
>> +	default 0x9e800000
>> +	help
>> +	  The load address for the OPTEE image. This value defaults to 0x9e800000
>> +	  if not provided in the board defconfig file.
>> +
> 
> Wondering if we should call out updating the firewall configurations as
> well as a part of this so people don't end up with random failures..
> 

Might be even better to build the firewall config based on this
new kconfig symbol. I can look into that at some later point.

Andrew

> Regards,
> Manorit
> 
>>   config K3_DM_FW
>>   	bool "Separate DM firmware image"
>>   	depends on CPU_V7R && (SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_AM625 || SOC_K3_AM62A7) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
>> -- 
>> 2.39.2
>>
