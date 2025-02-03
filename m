Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09B5C02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 07:25:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2EE1802EF;
	Mon,  3 Feb 2025 08:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="6g02rc65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28785802EF; Mon,  3 Feb 2025 08:25:06 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2506A801DE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 08:25:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4129180648=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5136KkYd005201;
 Mon, 3 Feb 2025 08:25:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 oT6vR3xllszCW5kFO7qZCOPDlYTrxSs7Iec+5SAPFp8=; b=6g02rc657EidV3hY
 gHRcAUbO5wWqx8GbZuP2/PgrrZe34+quEUTEjb4jdTxV3rb6BA2draKHk5du3+gU
 uXwYU1w+8KRF9zYNav7sRD/RTcvK73GHKhddAUbq28TdWWuGv5ikehTcZcdEm1Ks
 U6P9xp0bPumHARsQJXPMq7dMEJ09SplE342M0o/d6+JBk2MWoAlniWMDXCaY4FbB
 xG66zCuHM2kpOrd5QU1uNZnfxDjafaoX9wsW8f/sK2iEO9AyOLpNqfW3iKBs94Mt
 59M3V9EZJF77sYKkhLziTTICsWKQVD0p3l/Gaunarqyn5BZ8UnhUj43wjftnpKF0
 1aPvRA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44hyemjvqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2025 08:24:59 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 98C9F40047;
 Mon,  3 Feb 2025 08:24:10 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 030FE28E4A8;
 Mon,  3 Feb 2025 08:23:59 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 08:23:58 +0100
Message-ID: <1fedad9f-8283-487b-91ae-fb734aa15aea@foss.st.com>
Date: Mon, 3 Feb 2025 08:23:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dtc: "syntax error" linked to &{label/subnode} syntax
To: Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
References: <8b798c6e-60a3-4ef3-8ce6-a747e072807a@foss.st.com>
 <CAFLszTj3O64xvA9buAfMf2RRRjwF5SjoOje+_1pWCT3QgV4Akg@mail.gmail.com>
 <62ed68c3-a029-4bf9-8918-39d5aa5d8b6b@foss.st.com>
 <95ab524e-c532-4eb5-a65f-a1d1c1b190a2@foss.st.com>
 <20250115144428.GZ3476@bill-the-cat>
 <329ceffc-c5b6-4f3e-81dd-03b1d4b7b9a7@foss.st.com>
 <20250128140456.GJ1233568@bill-the-cat>
 <20250128150426.GP1233568@bill-the-cat>
 <20250129220127.GW1233568@bill-the-cat>
 <2858f505-d64d-4583-bca2-30f9a83a9ef6@foss.st.com>
 <20250131160140.GQ1233568@bill-the-cat>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250131160140.GQ1233568@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_03,2025-01-31_02,2024-11-22_01
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



On 1/31/25 17:01, Tom Rini wrote:
> On Fri, Jan 31, 2025 at 03:41:37PM +0100, Patrice CHOTARD wrote:
>>
>>
>> On 1/29/25 23:01, Tom Rini wrote:
>>> On Tue, Jan 28, 2025 at 09:04:26AM -0600, Tom Rini wrote:
>>>> On Tue, Jan 28, 2025 at 08:04:56AM -0600, Tom Rini wrote:
>>>>> On Tue, Jan 28, 2025 at 08:47:37AM +0100, Patrice CHOTARD wrote:
>>>>>>
>>>>>>
>>>>>> On 1/15/25 15:44, Tom Rini wrote:
>>>>>>> On Wed, Jan 15, 2025 at 03:39:20PM +0100, Patrice CHOTARD wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 1/15/25 15:24, Patrice CHOTARD wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 1/15/25 14:19, Simon Glass wrote:
>>>>>>>>>> Hi Patrice,
>>>>>>>>>>
>>>>>>>>>> On Wed, 15 Jan 2025 at 03:19, Patrice CHOTARD
>>>>>>>>>> <patrice.chotard@foss.st.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Hi
>>>>>>>>>>>
>>>>>>>>>>> I am currently converting STM32MP platforms to OF_UPSTREAM.
>>>>>>>>>>> As we use same binary for several boards, flags CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
>>>>>>>>>>> and CONFIG_OF_UPSTREAM_VENDOR="st" are set.
>>>>>>>>>>>
>>>>>>>>>>> So all dts/upstream/src/arm/st/* dts files are compiled.
>>>>>>>>>>>
>>>>>>>>>>> I am facing an issue with dts/upstream/src/arm/st/stm32mp151a-prtt1* and
>>>>>>>>>>> dts/upstream/src/arm/st/stm32mp15*-mec*.* files.
>>>>>>>>>>>
>>>>>>>>>>> To be more precise, these files are using a syntax which follows this
>>>>>>>>>>> format &{label/subnode} to override some nodes.
>>>>>>>>>>>
>>>>>>>>>>> This leads to DTC error:
>>>>>>>>>>>
>>>>>>>>>>>  AR      drivers/usb/gadget/built-in.o
>>>>>>>>>>>   LD      u-boot
>>>>>>>>>>>   OBJCOPY u-boot.srec
>>>>>>>>>>>   OBJCOPY u-boot-nodtb.bin
>>>>>>>>>>>   SYM     u-boot.sym
>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32mp157c-dhcom-picoitx.dtb
>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32h750i-art-pi.dtb
>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dtb
>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-iot-box.dtb
>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32746g-eval.dtb
>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32mp151c-mecio1r0.dtb
>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-dhcor-avenger96.dtb
>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/ste-nomadik-s8815.dtb
>>>>>>>>>>> Error: ../dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi:338.1-2 syntax error
>>>>>>>>>>> FATAL ERROR: Unable to parse input tree
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> At line 338 in dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi we got :
>>>>>>>>>>>
>>>>>>>>>>> &{qspi_bk1_pins_a/pins} {
>>>>>>>>>>>         pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
>>>>>>>>>>>                  <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
>>>>>>>>>>>                  <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
>>>>>>>>>>>                  <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
>>>>>>>>>>>         /delete-property/ bias-disable;
>>>>>>>>>>>         bias-pull-up;
>>>>>>>>>>> };
>>>>>>>>>>>
>>>>>>>>>>> If i update it as following , the DTC compilation is OK :
>>>>>>>>>>>
>>>>>>>>>>> &qspi_bk1_pins_a {
>>>>>>>>>>>         pins {
>>>>>>>>>>>                 pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
>>>>>>>>>>>                          <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
>>>>>>>>>>>                          <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
>>>>>>>>>>>                          <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
>>>>>>>>>>>                 /delete-property/ bias-disable;
>>>>>>>>>>>                 bias-pull-up;
>>>>>>>>>>>         };
>>>>>>>>>>> };
>>>>>>>>>>>
>>>>>>>>>>> On kernel side, the DTC compilation is ok, but not on U-Boot side. I am not able to understand the difference.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Could it be that the kernel dtc is newer?
>>>>>>>>>
>>>>>>>>> I have tested with dtc Version: DTC 1.7.0-gbcd02b52 which is the same dtc version than kernel tag next-20250114
>>>>>>>>
>>>>>>>> I mean, it's ok with newer version of dtc : DTC 1.7.0-gbcd02b52.
>>>>>>>
>>>>>>> Ah, so, sigh, we need to update DTC. I stopped my last upgrade there
>>>>>>> because other changes it made grew the binary size for everyone and
>>>>>>> didn't get back to it. I guess another attempt is in order.
>>>>>>>
>>>>>>
>>>>>> Hi Tom
>>>>>>
>>>>>> Do you know when you will be able to provide a DTC update in master or next branch ?
>>>>>
>>>>> Unfortunately trying to update resync-dtc-v1.6.0-31-gcbca977ea121-v5 to
>>>>> be on top of current (the first step to moving to 1.7.0 or 1.7.1)
>>>>> produced some test failures that don't exist when using the host dtc.
>>>>> Can you confirm if dtc 1.7.0 is new enough for this syntax? We might
>>>>> just need to change to building pylibfdt and not dtc as well (as having
>>>>> pylibfdt come via system python or pipx is differently tricky it seems).
>>>>
>>>> The pipeline is at
>>>> https://source.denx.de/u-boot/u-boot/-/pipelines/24243 and that's just
>>>> the v5 branch currently under WIP/ rebased to then-current master.
>>>
>>> To push this as far as I can at least, there's now also
>>> WIP/resync-dtc-v1.7.1-v1 which brings us to dtc-1.7.1 (good!) but also
>>> some silent failure to boot on a least one of the TI K3 platforms I
>>> have, and some other failures in CI too.
>>>
>> Hi Tom
>>
>> I rebase my "STM32 OF_UPSTREAM" series on top of your branch WIP/resync-dtc-v1.7.1-v1,
>> that fixes the issue i described in my initial mail.
>>
>> Thanks for this update
> 
> Well, please note that branch is a problem. I have no idea why some
> tests, and then some platforms fail. I also don't have the time to look
> in to it. I posted this so that at least the groundwork is done for
> someone else with motivation / need to finish fixing things.
> 

OK i will try to have a look at it.

Thanks
Patrice
