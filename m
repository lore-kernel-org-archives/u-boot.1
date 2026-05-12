Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BD3CD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 09:46:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E54C283C51;
	Tue, 12 May 2026 11:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="V3qopbce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F56383EEF; Tue, 12 May 2026 11:45:58 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A92FA83C51
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqSEZC1w5VKoIITzDTrbPRb5ltfbnkVnKOBT9rULp1/lDMm4D4e51+UFG4tNbFRDt3XjDTZsgCiAZ5G+77QamyUZ4wEBxlu5T+niMzb1drgYepBiHXQ5GCzWhasB54CTY2fhpG+giGu2gSnebd7j+gM7H7pz2lmzxjx0kzuhoBiknsTEFnjBRIv+MpbmPe3rpB+VU4hWXt74E3T8MLMdNdgi6NATr7GbKbVaRo7ExjERDOH3dUb6FFtHIhMRtRUSJ1SZ5I9CPrymp9oaL0xnXxck0dbhHTUs7Ppdoi89+/pfw7clUy8h4k6f2TGSJ06vVZvQ+7Y5a2VhI/BMTP2Img==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioMPAMY1kYzfxiSOEDAW8e86TIn1Yp+x0jOtKiA51Uc=;
 b=JSnhCrA8LEtmLk2TQBDnRlDRHBsdZSkw1HTiChWl+LjXZjW6lRYUfRW7Ss4D86TQGrHGAhOOa3ZfLEP6PoVyg5ETVcfIxrhnf/IecRFiEcs4VamkJBYWR+b02/GbgIUDnd9QTSpMZz3f7EQwPTEBh/J3MmvszbLnJ4kn52GSjRMIbnSVzm4K6wn7pB4YU3+XjpPSxxOPVOFu47a2QZ6y0MUzoR4pm9E98JIUgkz2nbOVstxkwiS0x0nq/Z1HfoWmFVTfooxAB6inPBi8vjwwrHuJyXHjTT7UITJmDWDVJPch10taQmRqVBDnT5ldADQ3+s2EaLnjYsEavatC+HpMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=amarulasolutions.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioMPAMY1kYzfxiSOEDAW8e86TIn1Yp+x0jOtKiA51Uc=;
 b=V3qopbce2qJaYPI7iPY6Ny0mj4EiUPXZGU5t/ZBt2J7Ot9C9/31H5JCMXgL07+k+4i/JCG6MG1Ig9Pc9tXC5AD4j+ehTB3jGodsOOpa1M0uruPAVGjuiVQYePAh9HcPrVoXJlXXn+z8ZBQLoLLaz6tWbHO0maVW8a1Bn6K8gBwlwivz/aLAeH1g6GMWZ4Q0h8nHHPuB0WpY7JsZGfx13g7G6R6HUSiJs/uzBaW/QWZe/4TifT4jI5G9QdetySuIvrYMH7BlvKZERa9GApRznz+6QaHlEXaILq/sqwtmw0w4wXA5KL/2r9ppsEn0W9hspZ8+S8FfMGhd0Zgdwe85M/w==
Received: from DUZPR01CA0153.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::6) by AM7PR10MB3746.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:172::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 09:45:50 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::80) by DUZPR01CA0153.outlook.office365.com
 (2603:10a6:10:4bd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 09:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 09:45:49 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 12 May
 2026 11:49:37 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 12 May
 2026 11:45:48 +0200
Message-ID: <e057518f-3f82-49d2-8e2c-7677c1c89e46@foss.st.com>
Date: Tue, 12 May 2026 11:45:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/8] test: cmd: add unit tests for part command
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
CC: <u-boot@lists.denx.de>, <linux-amarula@amarulasolutions.com>, Simon Glass
 <sjg@chromium.org>, Dinesh Maniyam <dinesh.maniyam@altera.com>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Quentin Schulz <quentin.schulz@cherry.de>, "Tom
 Rini" <trini@konsulko.com>
References: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
 <20260430080627.849636-4-dario.binacchi@amarulasolutions.com>
 <5b02ed04-764c-4eee-ba58-0f84ef43446c@foss.st.com>
 <CABGWkvp-5GnhvOO46PoKBOKmh-XsTLbHQx63fMwm70J0NYZ55A@mail.gmail.com>
 <CABGWkvrBZPN4LGia169JdrjhUyN5cSvnMt1hxH=Tx6JZ0NbRTQ@mail.gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CABGWkvrBZPN4LGia169JdrjhUyN5cSvnMt1hxH=Tx6JZ0NbRTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|AM7PR10MB3746:EE_
X-MS-Office365-Filtering-Correlation-Id: d7814bd8-2ee8-4a4b-8a8e-08deb00b4014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|7416014|3023799003|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: mY9FtH4DNh6F3aSch2t1LoEUVv5NUp1pPJbm6PMPc3MvnESW5PXipwNpwrvrp8m9I+sAuHglKslQfyk4YO1bnH3CU8gkVv/+uk5HxA8l7++8cTMZKCHL4aZkqX+TDczGZ8pYuIG3XPWK9In8i8qG4OxsWtiRLQUQA0G5oNAmtZ9YBfPJozs08P/CguwmAw+xgq7VaZswZPuxvFe4XMeHqW+JNueJ7dQzn70TBXFOBN8Eg2olRAK5mEwGRSJwX55d+udSBLlIL+rE7GQOOv+S9s56j+NZAmuiT5nFtxaddYXeTvhHZE562fiOvhMxY3wbbJ8ivPtHAHKDX9oZSOtsR4XfLb8MTZviERdPTH16W7zS/E5ZNkD2eKCvM8ruegqsIiQfZiBZBXUEL82LIZpmwJFyP/CLzHmm38MZQKmOF0nmpEdfh1C+UOxB0Xm1ZApzJcQuQVIOHELGBr62vtR/QpxD1USnYDaaawiJg1unTZ5MRmanC2+LAafRabnni3XHyNhDEi320eJ/JpLKhE+hSa5L7EyCravpaTN6uoJoHFs7iLwjqTkMAKiQhmcj6IeDUOy91+CYvBUu72rE9gWq+OiCUbUsgV/zsY4RPhBR0unZw84poq8Iuq6tqC96j+6yKmRkzTENR2i3iRa+hLHP10iI1nzmirNs2hXPPqMkEW4rCEr52nfH56kgU2A8rJ3z
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(7416014)(3023799003)(11063799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SnaZRaNtDCHKaNTtVJPwy3GcGlOUu7NIjvZ0BTLFjy4+O0efF4uDFzkSu1BKoiwpQ4kjvt4w4pam0hSwKfUs/TUhnqIgUzVhakbRoh9mjBoiNa+uAyrRVTVeqecVsicSwvI0igplo2AwRcMlDl4cbGl/N548NkGlFayijD+S6V1fNLTZqHVMFgzhBw+LuxERbCsvqcWY0HAjgcO/rzZswHMqrZYrh9xXHvMBCvvlbgXu2yNX5xRCDMqXodo4ADWLmXIgOeKC2oReL8Qxpoyg96tpcURkjJQ/NKi5Yibf4Ong8hxCtGWgVK/NV5N3hMsmLt6jtpQKG9RV+Zyd1wKUYAoYoyQSBaGj3jR2UbmvHviqy6xbYy/w2KF9tGGz3z65uglsFfvYxc+FkQOCkbB08r5+3n1hKuPS4/kKNtTQG7mAOSuQMlm6ZzKiIKpIwp6M
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:45:49.8322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7814bd8-2ee8-4a4b-8a8e-08deb00b4014
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3746
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



On 5/12/26 09:08, Dario Binacchi wrote:
> Hi everyone,
> 
> I am resending my previous reply because I received a delivery failure
> notification last week indicating that Patrice's mailbox was full.
> 
> Patrice, did you have a chance to verify if the tests are passing fine now?
> Please let me know if everything looks good or if you need
> 
> me to make any further modifications.
> 
> Thanks and regards
> 
> Dario


Hi Dario

My mailbox has been cleaned ;-), i expected to respin this series for test tomorrow or next week.

Thanks
Patrice
> 
> On Tue, May 5, 2026 at 9:55 AM Dario Binacchi <
> dario.binacchi@amarulasolutions.com> wrote:
> 
>> Hi Patrice,
>>
>> On Tue, May 5, 2026 at 9:26 AM Patrice CHOTARD <
>> patrice.chotard@foss.st.com> wrote:
>>
>>>
>>>
>>> On 4/30/26 10:06, Dario Binacchi wrote:
>>>> Add unit tests for the 'part' command, specifically for the 'number',
>>>> 'start', and 'size' subcommands.
>>>>
>>>> These tests establish a baseline for the current partition lookup
>>>> functionality by name. This foundation will be used by subsequent
>>>> patches to extend the command, ensuring consistent behavior as new
>>>> features are introduced.
>>>>
>>>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>
>>>> ---
>>>>
>>>> Changes in v8:
>>>> - Skip the test in case the CONFIG_MCC is not enabled or the mmc
>>>>   device is not found.
>>>>
>>>> Changes in v6:
>>>> - Add Reviewed-by of Simon Glass to patch 3/8 "test: cmd: add unit
>>>>   tests for part command"
>>>>
>>>> Changes in v4:
>>>> - Place the part command tests in the cmd suite rather than the dm
>>>>   suite.
>>>> - Order the include files according the U-Boot coding style.
>>>>
>>>> Changes in v3:
>>>> - Wrap the lines exceeding 80 columns
>>>> - Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(
>>>>
>>>>  test/cmd/Makefile |   1 +
>>>>  test/cmd/part.c   | 183 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 184 insertions(+)
>>>>  create mode 100644 test/cmd/part.c
>>>>
>>>> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
>>>> index 5f2815b1bb65..8d6932f1176c 100644
>>>> --- a/test/cmd/Makefile
>>>> +++ b/test/cmd/Makefile
>>>> @@ -26,6 +26,7 @@ obj-$(CONFIG_CMD_LOADM) += loadm.o
>>>>  obj-$(CONFIG_CMD_MEMINFO) += meminfo.o
>>>>  obj-$(CONFIG_CMD_MEMORY) += mem_copy.o
>>>>  obj-$(CONFIG_CMD_MEM_SEARCH) += mem_search.o
>>>> +obj-$(CONFIG_CMD_PART) += part.o
>>>>  ifdef CONFIG_CMD_PCI
>>>>  obj-$(CONFIG_CMD_PCI_MPS) += pci_mps.o
>>>>  endif
>>>> diff --git a/test/cmd/part.c b/test/cmd/part.c
>>>> new file mode 100644
>>>> index 000000000000..cac57a1a0e35
>>>> --- /dev/null
>>>> +++ b/test/cmd/part.c
>>>> @@ -0,0 +1,183 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Test for part command
>>>> + *
>>>> + * Copyright (C) 2026 Amarula Solutions
>>>> + * Written by Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>>> + */
>>>> +
>>>> +#include <command.h>
>>>> +#include <dm.h>
>>>> +#include <env.h>
>>>> +#include <part.h>
>>>> +#include <vsprintf.h>
>>>> +#include <dm/test.h>
>>>> +#include <test/cmd.h>
>>>> +#include <test/test.h>
>>>> +#include <test/ut.h>
>>>> +
>>>> +static struct disk_partition gpt_parts[] = {
>>>> +     {
>>>> +             .start = 48,
>>>> +             .size = 1,
>>>> +             .name = "test1",
>>>> +             .uuid = "c5bce7a2-03f0-4d03-9048-01ff23b9d527",
>>>> +     },
>>>> +     {
>>>> +             .start = 49,
>>>> +             .size = 2,
>>>> +             .name = "test2",
>>>> +             .uuid = "9df346e8-2c53-4cd8-b9ac-3af83f9a9b74",
>>>> +     },
>>>> +};
>>>> +
>>>> +static char disk_guid[UUID_STR_LEN + 1] =
>>>> +     "8d60b397-1bb6-4d33-80ee-b1587d24c2f8";
>>>> +
>>>> +static int setup_gpt_partitions(struct unit_test_state *uts,
>>>> +                             unsigned int mmc_dev_num)
>>>> +{
>>>> +     struct blk_desc *mmc_dev_desc;
>>>> +     char dev_str[10];
>>>> +     int i, ret;
>>>> +
>>>> +     if (!CONFIG_IS_ENABLED(MMC))
>>>> +             return -EAGAIN;
>>>
>>> Hi Dario
>>>
>>> Is there any reason to return -EAGAIN ? -ENODEV seems more appropriate ?
>>>
>>
>> In the testing framework, returning -EAGAIN explicitly signals that the
>> test should be skipped*.*
>>
>> As highlighted in the documentation for ut_run_test():
>>
>> *Return: 0 if all tests passed, -EAGAIN if the test should be skipped, -1
>> if any failed*
>>
>>
>> Since the necessary preconditions weren't met for some configuration in
>> our case, I decided to skip.
>>
>> Thanks and regards,
>>
>> Dario
>>
>>
>>> Thanks
>>> Patrice
>>>
>>>> +
>>>> +     snprintf(dev_str, sizeof(dev_str), "%u", mmc_dev_num);
>>>> +
>>>> +     ret = blk_get_device_by_str("mmc", dev_str, &mmc_dev_desc);
>>>> +     if (ret == -ENODEV)
>>>> +             return -EAGAIN;
>>>> +
>>>> +     ut_asserteq(mmc_dev_num, ret);
>>>> +
>>>> +     if (CONFIG_IS_ENABLED(RANDOM_UUID)) {
>>>> +             for (i = 0; i < ARRAY_SIZE(gpt_parts); i++)
>>>> +                     gen_rand_uuid_str(gpt_parts[i].uuid,
>>>> +                                       UUID_STR_FORMAT_STD);
>>>> +
>>>> +             gen_rand_uuid_str(disk_guid, UUID_STR_FORMAT_STD);
>>>> +     }
>>>> +
>>>> +     ut_assertok(gpt_restore(mmc_dev_desc, disk_guid, gpt_parts,
>>>> +                             ARRAY_SIZE(gpt_parts)));
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int cmd_test_part_number(struct unit_test_state *uts)
>>>> +{
>>>> +     unsigned int mmc_dev_num = 2;
>>>> +     char expected[10];
>>>> +     int i, ret;
>>>> +
>>>> +     ret = setup_gpt_partitions(uts, mmc_dev_num);
>>>> +     if (ret == -EAGAIN)
>>>> +             return ret;
>>>> +
>>>> +     ut_assertok(ret);
>>>> +
>>>> +     for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
>>>> +             env_set("partnum", NULL);
>>>> +             ut_assertok(run_commandf("part number mmc %u %s partnum",
>>>> +                                      mmc_dev_num, gpt_parts[i].name));
>>>> +             snprintf(expected, sizeof(expected), "0x%x", i + 1);
>>>> +             ut_asserteq_str(expected, env_get("partnum"));
>>>> +     }
>>>> +
>>>> +     env_set("partnum", NULL);
>>>> +     ut_asserteq(1, run_commandf("part number mmc %u bogus partnum",
>>>> +                                 mmc_dev_num));
>>>> +     ut_assertnull(env_get("partnum"));
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +CMD_TEST(cmd_test_part_number, UTF_CONSOLE);
>>>> +
>>>> +static int cmd_test_part_start(struct unit_test_state *uts)
>>>> +{
>>>> +     unsigned int mmc_dev_num = 2;
>>>> +     char expected[32];
>>>> +     int i, ret;
>>>> +
>>>> +     ret = setup_gpt_partitions(uts, mmc_dev_num);
>>>> +     if (ret == -EAGAIN)
>>>> +             return ret;
>>>> +
>>>> +     ut_assertok(ret);
>>>> +
>>>> +     for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
>>>> +             env_set("partstart", NULL);
>>>> +             ut_assertok(run_commandf("part start mmc %u %d partstart",
>>>> +                                      mmc_dev_num, i + 1));
>>>> +             snprintf(expected, sizeof(expected), "%lx",
>>>> +                      (unsigned long)gpt_parts[i].start);
>>>> +             ut_asserteq_str(expected, env_get("partstart"));
>>>> +     }
>>>> +
>>>> +     env_set("partstart", NULL);
>>>> +     ut_asserteq(1, run_commandf("part start mmc %u 3 partstart",
>>>> +                                 mmc_dev_num));
>>>> +     ut_assertnull(env_get("partstart"));
>>>> +
>>>> +     for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
>>>> +             env_set("partstart", NULL);
>>>> +             ut_assertok(run_commandf("part start mmc %u %s partstart",
>>>> +                                      mmc_dev_num, gpt_parts[i].name));
>>>> +             snprintf(expected, sizeof(expected), "%lx",
>>>> +                      (unsigned long)gpt_parts[i].start);
>>>> +             ut_asserteq_str(expected, env_get("partstart"));
>>>> +     }
>>>> +
>>>> +     env_set("partstart", NULL);
>>>> +     ut_asserteq(1, run_commandf("part start mmc %u bogus partstart",
>>>> +                                 mmc_dev_num));
>>>> +     ut_assertnull(env_get("partstart"));
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +CMD_TEST(cmd_test_part_start, UTF_CONSOLE);
>>>> +
>>>> +static int cmd_test_part_size(struct unit_test_state *uts)
>>>> +{
>>>> +     unsigned int mmc_dev_num = 2;
>>>> +     char expected[32];
>>>> +     int i, ret;
>>>> +
>>>> +     ret = setup_gpt_partitions(uts, mmc_dev_num);
>>>> +     if (ret == -EAGAIN)
>>>> +             return ret;
>>>> +
>>>> +     ut_assertok(ret);
>>>> +
>>>> +     for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
>>>> +             env_set("partsize", NULL);
>>>> +             ut_assertok(run_commandf("part size mmc %u %d partsize",
>>>> +                                      mmc_dev_num, i + 1));
>>>> +             snprintf(expected, sizeof(expected), "%lx",
>>>> +                      (unsigned long)gpt_parts[i].size);
>>>> +             ut_asserteq_str(expected, env_get("partsize"));
>>>> +     }
>>>> +
>>>> +     env_set("partsize", NULL);
>>>> +     ut_asserteq(1, run_commandf("part size mmc %u 3 partsize",
>>>> +                                 mmc_dev_num));
>>>> +     ut_assertnull(env_get("partsize"));
>>>> +
>>>> +     for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
>>>> +             env_set("partsize", NULL);
>>>> +             ut_assertok(run_commandf("part size mmc %u %s partsize",
>>>> +                                      mmc_dev_num, gpt_parts[i].name));
>>>> +             snprintf(expected, sizeof(expected), "%lx",
>>>> +                      (unsigned long)gpt_parts[i].size);
>>>> +             ut_asserteq_str(expected, env_get("partsize"));
>>>> +     }
>>>> +
>>>> +     env_set("partsize", NULL);
>>>> +     ut_asserteq(1, run_commandf("part size mmc %u bogus partsize",
>>>> +                                 mmc_dev_num));
>>>> +     ut_assertnull(env_get("partsize"));
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +CMD_TEST(cmd_test_part_size, UTF_CONSOLE);
>>>
>>>
>>
>> --
>> *Dario Binacchi*
>> Senior Embedded Software Engineer
>> M. +39 328 0625246
>> dario.binacchi@amarulasolutions.com
>> ―――――――――――――――
>> Amarula Solutions SRL
>>  Via Felice Cavallotti 25D, 41012 Carpi, MO, IT
>> info@amarulasolutions.com
>> www.amarulasolutions.com
>>
> 
> 

