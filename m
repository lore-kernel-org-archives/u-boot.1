Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914D7C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 11:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C896F89111;
	Fri, 26 Apr 2024 13:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714131633;
	bh=byDZNyoB/GdO/R1UThf9Je5FtYXjvibE7m00zoSM7jY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m1BrsyGjYsZDNT6PQhuJVo4Xp+oFMl7S6glIn8WlyR+Jx2HEnh+bysoNCJHA97xsT
	 QM1whzSYrtQehZxJfxbJgyevsQHwpL3CINHq1Bpv99Q4H228NMf0z9AdHAYopvU11C
	 aLgjUsF57UOdLC54aVrazh7h5UgbKG9miA4RhHENBVii9iHm8/wmmUooQO449goruN
	 s6qhVoddMKHx3wfwj8qO2R11IPQqEhQnYkw22iztQpp01EzT/AEB5F2M1fxzNljy4Z
	 IJyN1PAuKO8ODQoTB07avWHIqc/oQhlVHKwg0iZH+c7wwinzRHMFF4+zT+9qcSDCET
	 fvjXVbYMFiRFQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 61CBE8903D;
 Fri, 26 Apr 2024 13:40:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714131632;
 bh=byDZNyoB/GdO/R1UThf9Je5FtYXjvibE7m00zoSM7jY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jNacN8RMSI2HuNCjqWvk6oFau/1lsgIKeT8AcRyrP7plEIzWSneU4yiein5bi/bSn
 ow/YY1brlskFgULjs1Ivh2Imie6w77YQuuDwAZc9sTlBoB2vOKny6rdmLQiVwUU/Vl
 6jVGHP1Wudu4FPJox2kvJAII9yZt8sKLT1egzS8aFt0F2IuWWA2lfulh1ADIfQMsWh
 Ns3K31pIe2pf+DtLx3Sn7P3ITFUTDxXjOvuhDk22EkX8JmUUTfdJhFZx3MjI31KUsI
 NoMqcXlz+zbUqdpgpBEj2FymP9d5gV4v4DeW0568xb7qatln95MjPzRB1aZFvneCAm
 2SlZWpR9DgIAA==
Message-ID: <4f3e2fc7-5052-41cd-be7b-ffdb5f75f308@denx.de>
Date: Fri, 26 Apr 2024 13:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] ARM: dts: stm32: Add alternate pinmux for MP13 ADC
 pins
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
References: <20240421231849.194648-1-marex@denx.de>
 <d0f4afdd-752d-4157-a6c0-2132a2fc9696@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <d0f4afdd-752d-4157-a6c0-2132a2fc9696@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/26/24 9:49 AM, Patrice CHOTARD wrote:
> 
> 
> On 4/22/24 01:16, Marek Vasut wrote:
>> Add another mux option for ADC pins, this is used on
>> DH electronics STM32MP13xx DHCOR DHSBC board.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>   arch/arm/dts/stm32mp13-pinctrl.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
>> index 27e0c382678..03ded415390 100644
>> --- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
>> +++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
>> @@ -6,6 +6,12 @@
>>   #include <dt-bindings/pinctrl/stm32-pinfunc.h>
>>   
>>   &pinctrl {
>> +	adc1_pins_a: adc1-pins-0 {
>> +		pins {
>> +			pinmux = <STM32_PINMUX('A', 3, ANALOG)>; /* ADC1 in12 */
>> +		};
>> +	};
>> +
>>   	adc1_usb_cc_pins_a: adc1-usb-cc-pins-0 {
>>   		pins {
>>   			pinmux = <STM32_PINMUX('F', 12, ANALOG)>, /* ADC1 in6 */
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

I'll be sending a V2 with all the pinmux patches squashed into single patch.
