Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE919C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 14:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 120AB80657;
	Wed, 15 Jan 2025 15:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="iT+ny58v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF14C806D4; Wed, 15 Jan 2025 15:25:47 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60BD880269
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 15:25:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3110841290=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FAZPJv014673;
 Wed, 15 Jan 2025 15:25:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 DErNDaLA7+kxwcuF+wildycZPInHFCogGqtd2VR2Qv8=; b=iT+ny58vrKtLEz5I
 UDqt6eCaqBOgguq7etFCak21R4tgWeL0YX5Zjm1nIHEkCnS2KCvI+/DKjaDEHy1E
 GF4Trw0HhCqkDC/+Nk/Cu9M4RE8DlG41itRmHg1/iNlSh5Eg0Ntrr1XPEhVDSaLF
 iLXUFhfQfbtdKo8+eSfwiA4MpCceoeLPKLX+hHGrNdNVJdWSqnMBjprHmMWENgaZ
 SV+5+yYEeGGj7PRkBCzNSc5opiJ7zTU+bB0djYd/eVK+CEEFZo8iG0bm81viQGdG
 4VUc0yhCozHH0pU9mOmKWIF0Wsbf73wD9zdWsarbrDnNzth3HE3o6kcEi4ukdLvd
 aTH+/g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4466tjt9g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 15:25:43 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5100940045;
 Wed, 15 Jan 2025 15:24:49 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 88AD225F501;
 Wed, 15 Jan 2025 15:24:35 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 15 Jan
 2025 15:24:35 +0100
Message-ID: <62ed68c3-a029-4bf9-8918-39d5aa5d8b6b@foss.st.com>
Date: Wed, 15 Jan 2025 15:24:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dtc: "syntax error" linked to &{label/subnode} syntax
To: Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
References: <8b798c6e-60a3-4ef3-8ce6-a747e072807a@foss.st.com>
 <CAFLszTj3O64xvA9buAfMf2RRRjwF5SjoOje+_1pWCT3QgV4Akg@mail.gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CAFLszTj3O64xvA9buAfMf2RRRjwF5SjoOje+_1pWCT3QgV4Akg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_05,2025-01-15_02,2024-11-22_01
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



On 1/15/25 14:19, Simon Glass wrote:
> Hi Patrice,
> 
> On Wed, 15 Jan 2025 at 03:19, Patrice CHOTARD
> <patrice.chotard@foss.st.com> wrote:
>>
>> Hi
>>
>> I am currently converting STM32MP platforms to OF_UPSTREAM.
>> As we use same binary for several boards, flags CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
>> and CONFIG_OF_UPSTREAM_VENDOR="st" are set.
>>
>> So all dts/upstream/src/arm/st/* dts files are compiled.
>>
>> I am facing an issue with dts/upstream/src/arm/st/stm32mp151a-prtt1* and
>> dts/upstream/src/arm/st/stm32mp15*-mec*.* files.
>>
>> To be more precise, these files are using a syntax which follows this
>> format &{label/subnode} to override some nodes.
>>
>> This leads to DTC error:
>>
>>  AR      drivers/usb/gadget/built-in.o
>>   LD      u-boot
>>   OBJCOPY u-boot.srec
>>   OBJCOPY u-boot-nodtb.bin
>>   SYM     u-boot.sym
>>   DTC     dts/upstream/src/arm/st/stm32mp157c-dhcom-picoitx.dtb
>>   DTC     dts/upstream/src/arm/st/stm32h750i-art-pi.dtb
>>   DTC     dts/upstream/src/arm/st/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dtb
>>   DTC     dts/upstream/src/arm/st/stm32mp157a-iot-box.dtb
>>   DTC     dts/upstream/src/arm/st/stm32746g-eval.dtb
>>   DTC     dts/upstream/src/arm/st/stm32mp151c-mecio1r0.dtb
>>   DTC     dts/upstream/src/arm/st/stm32mp157a-dhcor-avenger96.dtb
>>   DTC     dts/upstream/src/arm/st/ste-nomadik-s8815.dtb
>> Error: ../dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi:338.1-2 syntax error
>> FATAL ERROR: Unable to parse input tree
>>
>>
>> At line 338 in dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi we got :
>>
>> &{qspi_bk1_pins_a/pins} {
>>         pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
>>                  <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
>>                  <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
>>                  <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
>>         /delete-property/ bias-disable;
>>         bias-pull-up;
>> };
>>
>> If i update it as following , the DTC compilation is OK :
>>
>> &qspi_bk1_pins_a {
>>         pins {
>>                 pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
>>                          <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
>>                          <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
>>                          <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
>>                 /delete-property/ bias-disable;
>>                 bias-pull-up;
>>         };
>> };
>>
>> On kernel side, the DTC compilation is ok, but not on U-Boot side. I am not able to understand the difference.
>>
> 
> Could it be that the kernel dtc is newer?

I have tested with dtc Version: DTC 1.7.0-gbcd02b52 which is the same dtc version than kernel tag next-20250114

I also submited my branch on U-Boot CI, and i got the same issue, see https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/24185

Issue reproduced with DT file dts/upstream/src/arm/st/stm32mp151a-prtt1l.dtsi:72.1-2 syntax error

Thansk
Patrice

> 
> You could try DTC=`which dtc` if you already have that in your system.
> 
> Regards,
> Simon
