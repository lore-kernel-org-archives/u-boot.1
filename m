Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B39CDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 13:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C28C8708F;
	Thu, 19 Oct 2023 15:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="IaVTt/OF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5007D86FEA; Thu, 19 Oct 2023 15:29:45 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACCA486FEA
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 15:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JDMjch021704; Thu, 19 Oct 2023 13:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eJdqDG2FWx7SFclWhVUgOIYuXGtJOoeJYEhOMtjhX8Q=;
 b=IaVTt/OF5FmJpUfDNAKlD+n7G55g57GeyaGqY6H4oXld+CnUNPB4UbA/Th1J4LeOw7+n
 /vYF3pcrsAR8QbfYEb9aPNetQGFDHyooaBdsrJtg1TWvaF0nN4jUMM7A31hhIWvSX7zM
 RyDvdR7qTTIdkRbMbw4EroeIyk/SUICIRFoitsGCSRlB+O0WpSq0zbQg7xq/7Nf2SgHJ
 I+BlwgMtImHZAwpU3YSziJPOzXzrcarQmOEQ1oS1Wi2w7ZpfwFZOUZtfmuJuWX5kQg91
 Iysu2Ew1MbCimXR65qc1m3tTG4qdXZ3+UCG7m55kpI+Mh9zKV85/bfMXe2i+N8QVYpL/ fA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu59nr9c2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 13:29:38 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JDOZ7o028312;
 Thu, 19 Oct 2023 13:29:37 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu59nr9ay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 13:29:37 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JCic5J019700; Thu, 19 Oct 2023 13:29:36 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr8120jbx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 13:29:36 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39JDTZej3867186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 13:29:35 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C9F65805D;
 Thu, 19 Oct 2023 13:29:35 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41F7058057;
 Thu, 19 Oct 2023 13:29:35 +0000 (GMT)
Received: from [9.61.89.2] (unknown [9.61.89.2])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Oct 2023 13:29:35 +0000 (GMT)
Message-ID: <3845000c-9f55-c3a7-f506-89e647cc9296@linux.ibm.com>
Date: Thu, 19 Oct 2023 08:29:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v12 5/8] test: Add sandbox TPM boot measurement
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de
References: <20231012144551.679551-1-eajames@linux.ibm.com>
 <20231012144551.679551-6-eajames@linux.ibm.com>
 <CAC_iWjKB-GkvDELoo083gpuPd32qZJDwHvPzepzHsF7hPioxMQ@mail.gmail.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CAC_iWjKB-GkvDELoo083gpuPd32qZJDwHvPzepzHsF7hPioxMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O1cGE2baHBQl2U-pHeTijFIHoxUo2i0s
X-Proofpoint-GUID: 5nCklZJPv3xolOV5DnqJZmOOilSI11vS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_12,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190116
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


On 10/13/23 12:22, Ilias Apalodimas wrote:
> Hi Eddie,
>
> This doesn't apply on -master, can you please rebase?


Ugh I thought you wanted -next... I can rebase again.


>
> Thanks
> /Ilias
>
> On Thu, 12 Oct 2023 at 16:49, Eddie James <eajames@linux.ibm.com> wrote:
>> Use the sandbox TPM driver to measure some boot images in a unit
>> test case.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>> Changes since v5:
>>   - Only compile in the measurement u-boot command when
>>     CONFIG_MEASURED_BOOT is enabled.
>>
>>   arch/sandbox/dts/sandbox.dtsi | 13 +++++++
>>   arch/sandbox/dts/test.dts     | 13 +++++++
>>   configs/sandbox_defconfig     |  1 +
>>   include/test/suites.h         |  1 +
>>   test/boot/Makefile            |  1 +
>>   test/boot/measurement.c       | 66 +++++++++++++++++++++++++++++++++++
>>   test/cmd_ut.c                 |  4 +++
>>   7 files changed, 99 insertions(+)
>>   create mode 100644 test/boot/measurement.c
>>
>> diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
>> index ff7e5584c5..241f397ba6 100644
>> --- a/arch/sandbox/dts/sandbox.dtsi
>> +++ b/arch/sandbox/dts/sandbox.dtsi
>> @@ -4,11 +4,23 @@
>>    * and sandbox64 builds.
>>    */
>>
>> +#include <config.h>
>>   #include <dt-bindings/input/input.h>
>>
>>   #define USB_CLASS_HUB                  9
>>
>>   / {
>> +       reserved-memory {
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               ranges;
>> +
>> +               event_log: tcg_event_log {
>> +                       no-map;
>> +                       reg = <(CFG_SYS_SDRAM_SIZE - 0x2000) 0x2000>;
>> +               };
>> +       };
>> +
>>          binman {
>>          };
>>
>> @@ -342,6 +354,7 @@
>>
>>          tpm2 {
>>                  compatible = "sandbox,tpm2";
>> +               memory-region = <&event_log>;
>>          };
>>
>>          triangle {
>> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
>> index 9a863ea732..bb2ddd9bf2 100644
>> --- a/arch/sandbox/dts/test.dts
>> +++ b/arch/sandbox/dts/test.dts
>> @@ -9,6 +9,7 @@
>>
>>   /dts-v1/;
>>
>> +#include <config.h>
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/gpio/sandbox-gpio.h>
>>   #include <dt-bindings/input/input.h>
>> @@ -68,6 +69,17 @@
>>                  osd0 = "/osd";
>>          };
>>
>> +       reserved-memory {
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               ranges;
>> +
>> +               event_log: tcg_event_log {
>> +                       no-map;
>> +                       reg = <(CFG_SYS_SDRAM_SIZE - 0x2000) 0x2000>;
>> +               };
>> +       };
>> +
>>          binman: binman {
>>          };
>>
>> @@ -1422,6 +1434,7 @@
>>
>>          tpm2 {
>>                  compatible = "sandbox,tpm2";
>> +               memory-region = <&event_log>;
>>          };
>>
>>          tpm {
>> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
>> index d667cb9ae4..12c387a77e 100644
>> --- a/configs/sandbox_defconfig
>> +++ b/configs/sandbox_defconfig
>> @@ -349,3 +349,4 @@ CONFIG_UNIT_TEST=y
>>   CONFIG_UT_TIME=y
>>   CONFIG_UT_DM=y
>>   CONFIG_ARM_FFA_TRANSPORT=y
>> +CONFIG_MEASURED_BOOT=y
>> diff --git a/include/test/suites.h b/include/test/suites.h
>> index 1c7dc65966..48ed549c13 100644
>> --- a/include/test/suites.h
>> +++ b/include/test/suites.h
>> @@ -45,6 +45,7 @@ int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>>   int do_ut_lib(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>>   int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>>   int do_ut_log(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
>> +int do_ut_measurement(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
>>   int do_ut_mem(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>>   int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>>   int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
>> diff --git a/test/boot/Makefile b/test/boot/Makefile
>> index 52947580ae..068522cb9e 100644
>> --- a/test/boot/Makefile
>> +++ b/test/boot/Makefile
>> @@ -4,6 +4,7 @@
>>
>>   obj-$(CONFIG_BOOTSTD) += bootdev.o bootstd_common.o bootflow.o bootmeth.o
>>   obj-$(CONFIG_FIT) += image.o
>> +obj-$(CONFIG_MEASURED_BOOT) += measurement.o
>>
>>   obj-$(CONFIG_EXPO) += expo.o
>>   obj-$(CONFIG_CEDIT) += cedit.o
>> diff --git a/test/boot/measurement.c b/test/boot/measurement.c
>> new file mode 100644
>> index 0000000000..9db2ed324c
>> --- /dev/null
>> +++ b/test/boot/measurement.c
>> @@ -0,0 +1,66 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Test for measured boot functions
>> + *
>> + * Copyright 2023 IBM Corp.
>> + * Written by Eddie James <eajames@linux.ibm.com>
>> + */
>> +
>> +#include <common.h>
>> +#include <bootm.h>
>> +#include <malloc.h>
>> +#include <test/suites.h>
>> +#include <test/test.h>
>> +#include <test/ut.h>
>> +#include <asm/io.h>
>> +
>> +#define MEASUREMENT_TEST(_name, _flags)        \
>> +       UNIT_TEST(_name, _flags, measurement_test)
>> +
>> +static int measure(struct unit_test_state *uts)
>> +{
>> +       struct bootm_headers images;
>> +       const size_t size = 1024;
>> +       u8 *kernel;
>> +       u8 *initrd;
>> +       size_t i;
>> +
>> +       kernel = malloc(size);
>> +       initrd = malloc(size);
>> +
>> +       images.os.image_start = map_to_sysmem(kernel);
>> +       images.os.image_len = size;
>> +
>> +       images.rd_start = map_to_sysmem(initrd);
>> +       images.rd_end = images.rd_start + size;
>> +
>> +       images.ft_addr = malloc(size);
>> +       images.ft_len = size;
>> +
>> +       env_set("bootargs", "measurement testing");
>> +
>> +       for (i = 0; i < size; ++i) {
>> +               kernel[i] = 0xf0 | (i & 0xf);
>> +               initrd[i] = (i & 0xf0) | 0xf;
>> +               images.ft_addr[i] = i & 0xff;
>> +       }
>> +
>> +       ut_assertok(bootm_measure(&images));
>> +
>> +       free(images.ft_addr);
>> +       free(initrd);
>> +       free(kernel);
>> +
>> +       return 0;
>> +}
>> +MEASUREMENT_TEST(measure, 0);
>> +
>> +int do_ut_measurement(struct cmd_tbl *cmdtp, int flag, int argc,
>> +                     char *const argv[])
>> +{
>> +       struct unit_test *tests = UNIT_TEST_SUITE_START(measurement_test);
>> +       const int n_ents = UNIT_TEST_SUITE_COUNT(measurement_test);
>> +
>> +       return cmd_ut_category("measurement", "measurement_test_", tests,
>> +                              n_ents, argc, argv);
>> +}
>> diff --git a/test/cmd_ut.c b/test/cmd_ut.c
>> index 0f56409e80..e87adcb71e 100644
>> --- a/test/cmd_ut.c
>> +++ b/test/cmd_ut.c
>> @@ -99,6 +99,10 @@ static struct cmd_tbl cmd_ut_sub[] = {
>>   #if CONFIG_IS_ENABLED(UT_UNICODE) && !defined(API_BUILD)
>>          U_BOOT_CMD_MKENT(unicode, CONFIG_SYS_MAXARGS, 1, do_ut_unicode, "", ""),
>>   #endif
>> +#ifdef CONFIG_MEASURED_BOOT
>> +       U_BOOT_CMD_MKENT(measurement, CONFIG_SYS_MAXARGS, 1, do_ut_measurement,
>> +                        "", ""),
>> +#endif
>>   #ifdef CONFIG_SANDBOX
>>          U_BOOT_CMD_MKENT(compression, CONFIG_SYS_MAXARGS, 1, do_ut_compression,
>>                           "", ""),
>> --
>> 2.39.3
>>
