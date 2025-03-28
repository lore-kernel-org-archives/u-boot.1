Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C75C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1D158144A;
	Fri, 28 Mar 2025 17:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="mngjoj5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB05C81951; Fri, 28 Mar 2025 17:50:35 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21223810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6182c41fd1=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52SEZIBH015778;
 Fri, 28 Mar 2025 17:50:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 LZdfmwmHGBVgr5HCA0J9Cee8doV7XVt6rf8LTT6yWWY=; b=mngjoj5LISoombTl
 Pd5qWJIyz8oIBY+rsMy56Hqm9cYHbXKyc/G1GREd/1s9d8EmQkAmLNhLnoBoEG6A
 N16awaaH5Lf6SzJep4ldSuJOxYiLQ4uaZ1DuOPiGE31hs15U1WfruumeHHqkgsHJ
 u5RuLeOuNFV5TFLCKe2uOWqJeaQTBHFbpF1P+r+yzEyvFaLmkxTHEFzPEZQW/NKB
 x5xtSrjsmX+XbRBKzxEuV+IVxAG2iO9oLC5v7fP4TKyrwuBnGWrv72cmvqSQK3WM
 dEPv8hLkdOuCRMPxm1fu6coAoesRIfPXWT23Tk6dqfaLLLN4rEhtJK7RWR/9US/Z
 p0Hcmw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45nq0b2j3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Mar 2025 17:50:28 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CA23940075;
 Fri, 28 Mar 2025 17:49:24 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 67D9993B824;
 Fri, 28 Mar 2025 17:42:43 +0100 (CET)
Received: from [10.252.14.194] (10.252.14.194) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 17:42:42 +0100
Message-ID: <40f9804d-0887-40a2-81cf-6df8ddeb49da@foss.st.com>
Date: Fri, 28 Mar 2025 17:42:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dtc: "syntax error" linked to &{label/subnode} syntax
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>
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
 <1fedad9f-8283-487b-91ae-fb734aa15aea@foss.st.com>
 <81da40dc-73dd-4297-a2b0-316b4160b1f2@foss.st.com>
Content-Language: en-US
In-Reply-To: <81da40dc-73dd-4297-a2b0-316b4160b1f2@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.14.194]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_08,2025-03-27_02,2024-11-22_01
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



On 2/24/25 15:58, Patrice CHOTARD wrote:
> 
> 
> On 2/3/25 08:23, Patrice CHOTARD wrote:
>>
>>
>> On 1/31/25 17:01, Tom Rini wrote:
>>> On Fri, Jan 31, 2025 at 03:41:37PM +0100, Patrice CHOTARD wrote:
>>>>
>>>>
>>>> On 1/29/25 23:01, Tom Rini wrote:
>>>>> On Tue, Jan 28, 2025 at 09:04:26AM -0600, Tom Rini wrote:
>>>>>> On Tue, Jan 28, 2025 at 08:04:56AM -0600, Tom Rini wrote:
>>>>>>> On Tue, Jan 28, 2025 at 08:47:37AM +0100, Patrice CHOTARD wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 1/15/25 15:44, Tom Rini wrote:
>>>>>>>>> On Wed, Jan 15, 2025 at 03:39:20PM +0100, Patrice CHOTARD wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 1/15/25 15:24, Patrice CHOTARD wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 1/15/25 14:19, Simon Glass wrote:
>>>>>>>>>>>> Hi Patrice,
>>>>>>>>>>>>
>>>>>>>>>>>> On Wed, 15 Jan 2025 at 03:19, Patrice CHOTARD
>>>>>>>>>>>> <patrice.chotard@foss.st.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Hi
>>>>>>>>>>>>>
>>>>>>>>>>>>> I am currently converting STM32MP platforms to OF_UPSTREAM.
>>>>>>>>>>>>> As we use same binary for several boards, flags CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
>>>>>>>>>>>>> and CONFIG_OF_UPSTREAM_VENDOR="st" are set.
>>>>>>>>>>>>>
>>>>>>>>>>>>> So all dts/upstream/src/arm/st/* dts files are compiled.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I am facing an issue with dts/upstream/src/arm/st/stm32mp151a-prtt1* and
>>>>>>>>>>>>> dts/upstream/src/arm/st/stm32mp15*-mec*.* files.
>>>>>>>>>>>>>
>>>>>>>>>>>>> To be more precise, these files are using a syntax which follows this
>>>>>>>>>>>>> format &{label/subnode} to override some nodes.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This leads to DTC error:
>>>>>>>>>>>>>
>>>>>>>>>>>>>  AR      drivers/usb/gadget/built-in.o
>>>>>>>>>>>>>   LD      u-boot
>>>>>>>>>>>>>   OBJCOPY u-boot.srec
>>>>>>>>>>>>>   OBJCOPY u-boot-nodtb.bin
>>>>>>>>>>>>>   SYM     u-boot.sym
>>>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32mp157c-dhcom-picoitx.dtb
>>>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32h750i-art-pi.dtb
>>>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dtb
>>>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-iot-box.dtb
>>>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32746g-eval.dtb
>>>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32mp151c-mecio1r0.dtb
>>>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-dhcor-avenger96.dtb
>>>>>>>>>>>>>   DTC     dts/upstream/src/arm/st/ste-nomadik-s8815.dtb
>>>>>>>>>>>>> Error: ../dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi:338.1-2 syntax error
>>>>>>>>>>>>> FATAL ERROR: Unable to parse input tree
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> At line 338 in dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi we got :
>>>>>>>>>>>>>
>>>>>>>>>>>>> &{qspi_bk1_pins_a/pins} {
>>>>>>>>>>>>>         pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
>>>>>>>>>>>>>                  <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
>>>>>>>>>>>>>                  <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
>>>>>>>>>>>>>                  <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
>>>>>>>>>>>>>         /delete-property/ bias-disable;
>>>>>>>>>>>>>         bias-pull-up;
>>>>>>>>>>>>> };
>>>>>>>>>>>>>
>>>>>>>>>>>>> If i update it as following , the DTC compilation is OK :
>>>>>>>>>>>>>
>>>>>>>>>>>>> &qspi_bk1_pins_a {
>>>>>>>>>>>>>         pins {
>>>>>>>>>>>>>                 pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
>>>>>>>>>>>>>                          <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
>>>>>>>>>>>>>                          <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
>>>>>>>>>>>>>                          <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
>>>>>>>>>>>>>                 /delete-property/ bias-disable;
>>>>>>>>>>>>>                 bias-pull-up;
>>>>>>>>>>>>>         };
>>>>>>>>>>>>> };
>>>>>>>>>>>>>
>>>>>>>>>>>>> On kernel side, the DTC compilation is ok, but not on U-Boot side. I am not able to understand the difference.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Could it be that the kernel dtc is newer?
>>>>>>>>>>>
>>>>>>>>>>> I have tested with dtc Version: DTC 1.7.0-gbcd02b52 which is the same dtc version than kernel tag next-20250114
>>>>>>>>>>
>>>>>>>>>> I mean, it's ok with newer version of dtc : DTC 1.7.0-gbcd02b52.
>>>>>>>>>
>>>>>>>>> Ah, so, sigh, we need to update DTC. I stopped my last upgrade there
>>>>>>>>> because other changes it made grew the binary size for everyone and
>>>>>>>>> didn't get back to it. I guess another attempt is in order.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi Tom
>>>>>>>>
>>>>>>>> Do you know when you will be able to provide a DTC update in master or next branch ?
>>>>>>>
>>>>>>> Unfortunately trying to update resync-dtc-v1.6.0-31-gcbca977ea121-v5 to
>>>>>>> be on top of current (the first step to moving to 1.7.0 or 1.7.1)
>>>>>>> produced some test failures that don't exist when using the host dtc.
>>>>>>> Can you confirm if dtc 1.7.0 is new enough for this syntax? We might
>>>>>>> just need to change to building pylibfdt and not dtc as well (as having
>>>>>>> pylibfdt come via system python or pipx is differently tricky it seems).
>>>>>>
>>>>>> The pipeline is at
>>>>>> https://source.denx.de/u-boot/u-boot/-/pipelines/24243 and that's just
>>>>>> the v5 branch currently under WIP/ rebased to then-current master.
>>>>>
>>>>> To push this as far as I can at least, there's now also
>>>>> WIP/resync-dtc-v1.7.1-v1 which brings us to dtc-1.7.1 (good!) but also
>>>>> some silent failure to boot on a least one of the TI K3 platforms I
>>>>> have, and some other failures in CI too.
>>>>>
>>>> Hi Tom
>>>>
>>>> I rebase my "STM32 OF_UPSTREAM" series on top of your branch WIP/resync-dtc-v1.7.1-v1,
>>>> that fixes the issue i described in my initial mail.
>>>>
>>>> Thanks for this update
>>>
>>> Well, please note that branch is a problem. I have no idea why some
>>> tests, and then some platforms fail. I also don't have the time to look
>>> in to it. I posted this so that at least the groundwork is done for
>>> someone else with motivation / need to finish fixing things.
>>>
>>
>> OK i will try to have a look at it.
> 
> Hi
> 
> I found that most of the issue are due to these 2 following DTC patches : 
> 
> 5e735860c478 libfdt: Check for 8-byte address alignment in fdt_ro_probe_()
> b07b62ee3342 libfdt: Add FDT alignment check to fdt_check_header()
> 
> If i reverted these 2 patches, there are 4 tests which are still remaining fail:
> (see CI tests : https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/24800)
>   _ "sandbox test.py" and "sandbox with clang test.py"
> 
> 	=> test/py/tests/test_sandbox_opts.py => fixed see commit 8a8aa1e30b02 "fixup! sandbox: Update dts files again"
> 
>   _ "sandbox_noinst test.py" and "sandbox_noinst with LOAD_FIT_FULL test.py"
> 
> 	test/py/tests/test_spl.py::test_spl[ut_dm_dm_test_of_plat_clk] - OSErr...
> 	test/py/tests/test_spl.py::test_spl[ut_dm_dm_test_of_plat_dev] - OSErr...
> 	test/py/tests/test_spl.py::test_spl[ut_dm_dm_test_of_plat_gpio] - OSEr...
> 	test/py/tests/test_spl.py::test_spl[ut_dm_dm_test_of_plat_parent] - OS...
> 	test/py/tests/test_spl.py::test_spl[ut_dm_dm_test_of_plat_phandle] - O...
> 	test/py/tests/test_spl.py::test_spl[ut_spl_test_spl_test_blk_FIT_EXTERNAL]
> 	test/py/tests/test_spl.py::test_spl[ut_spl_test_spl_test_blk_FIT_INTERNAL]
> 	test/py/tests/test_spl.py::test_spl[ut_spl_test_spl_test_mmc_FIT_EXTERNAL]
> 	test/py/tests/test_spl.py::test_spl[ut_spl_test_spl_test_mmc_FIT_INTERNAL]
> 	test/py/tests/test_spl.py::test_spl[ut_spl_test_spl_test_nand_FIT_INTERNAL]
> 	test/py/tests/test_spl.py::test_spl[ut_spl_test_spl_test_net_FIT_EXTERNAL]
> 	test/py/tests/test_spl.py::test_spl[ut_spl_test_spl_test_net_FIT_INTERNAL]
> 	test/py/tests/test_spl.py::test_spl[ut_spl_test_spl_test_nor_FIT_INTERNAL]
> 	test/py/tests/test_spl.py::test_spl[ut_spl_test_spl_test_spi_FIT_INTERNAL]
> 
>         I didn't start to look at these tests.
> 
> 
> So i checked which tests are impacted by the 2 above DTC patches on "sandbox test.py" :
> 
> 1) fix arch/sandbox/dts/sandbox.dtsi which generate warnings and made buildman fail 
>    => commit 8a8aa1e30b02 "fixup! sandbox: Update dts files again"
> 
> 2) ./test/py/tests/test_extension.py 
>    => commit 27c909792ef4 ("fix test_extension.py")
> 
> 3) ./test/py/tests/test_vboot.py : 
>    => First analysis: If FIT embeds a DTB, currently nothing ensure that this embedded DTB is
>      located at an offset 8 bytes aligned from the FIT beginning during the FIT generation.
>    
> 4) ./test/py/tests/test_android/test_abootimg.py: 
>    => same issue as FIT generation, reading the way to generate boot.img or vendor_boot.img 
>       at the beginning of test_abootimg.py, the 2 embbed DTBs must be all located at an offset
>       8 bytes aligned from the start of the image.
> 
>       I didn't find a way to ensure that both embedded DTBs are 8 bytes aligned with mkbootimg.
> 
> PS: the 2 fixes mentioned are available on STM32_U-boot_custodian tree.
>     
> I will continue to investigate, but if someone can help it would be great ;-)


Hi Tom, Simon

I have spent some time to investigate on the above issues due to DTC 1.7.1 migration.
I have fixed some "visible" failure highlighted by U-Boot CI Build.

Most of issue are linked to the constraints to have DT header aligned to 8 bytes.
To ensure that DT header is always 8 bytes aligned imposes update in a lot of part of U-Boot
and honestly it's touchy.

The more i digged, the more i discovered impact in a lot of components of U-Boot's tools 
(mkimage, binman) or the way binaries are generated (Makefile ..). 

So i will not go further. Instead i will simply backport some DTC patches needed to solve the inital issue
i saw, that means adding label relative path references to DTC.

See submitted patch : https://patchwork.ozlabs.org/project/uboot/patch/20250328163115.642347-1-patrice.chotard@foss.st.com/

I applied this patch over WIP/27Mar2025-next, run CI-Build with no regression: 
https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/25384

Thanks
Patrice



> 
> Thanks
> Patrice
>>
>> Thanks
>> Patrice
