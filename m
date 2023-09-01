Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE1CCA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 08:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69551846C0;
	Fri,  1 Sep 2023 10:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SSBIDqYU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2784847C8; Fri,  1 Sep 2023 10:14:34 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92ECE84003
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 10:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBkZ9e2xzFVDnex88T0oKfWDVidIKplUu3DrejvTf+OY+jrO0mWNIneHbzSSzsaLV3+Sndw7i36Y4JpvwRjsXsQX4xVY0vj4dTcmtlhpX5E0l8KAX1DGIubKAhgsEHPPPMaUhIbUlEuoBlwh92s+iEeX6fPVByqewdi+OdBgROMYEdZf6lABBEGUZr8LB57EWg+LJYhexA3FLeT5RTEqPHgxdBGj9dOrsmLnYhfp+Y1kKwPvyVRNqsIV7u+g8+NpWj6DhPRW19WVrJSl09e6iu/6M74NVAfyLCZQZ8SALp+5NvUeehy6X4uc0y5uEaT/0MYdDIs0XAPeK8/2hXMOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3ZvvyuYmkT/SFg3JppNCbRMtgbIsnZOtLBzkGG/Yck=;
 b=fEo5hdy0g7XkpdSOH5Rfx7TTIo0j+zcAvq75SvdHa5ZwBO2wVAcqVS/Kld4aHLMDUAgQPzABDR/mMRT4euEOFpdxSh7fLVUIzCQMwV9jP7jqYBHkSak3LyZM9fpAtRxhK9KYpH3F8XsSYWv8U3bz6jXlO6QA/wBiMxnniNqRLbvLDmk/zNNpmcjer6n9I55tmGxGadXQIzqnNWryB1hHvsVicOG6DAGf1B1dWpXFQfJkRUxff1/C88O8+NKs1Psa9A2Axtdwx95wQC+ElPXQgPekdbtguuduL4IRWrjTJbgoxbO7E77Ze/f/PMrLM3kJx+GEclSwXJLGPvYwLXf7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3ZvvyuYmkT/SFg3JppNCbRMtgbIsnZOtLBzkGG/Yck=;
 b=SSBIDqYUvAPg3lls8SrI41VOBfLRW1TEjPDBTp5UdxNFSue9GyAH6jog+e9QOt608YyQOSdh5qS9II8LB1Xbb2Rh/oM4kiCpz4R75LDOW99M6FWax+ZHhwiUQhJjnHlM1Ut5snPJnYm/yYaUU7MOHxRbZNa1Aziu1s2aNoS/Z5U=
Received: from CY5PR15CA0033.namprd15.prod.outlook.com (2603:10b6:930:1b::24)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Fri, 1 Sep
 2023 08:14:26 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:1b:cafe::9f) by CY5PR15CA0033.outlook.office365.com
 (2603:10b6:930:1b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Fri, 1 Sep 2023 08:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Fri, 1 Sep 2023 08:14:26 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 03:14:24 -0500
Message-ID: <77d57e59-42f2-2da0-6cdd-139c049ea401@amd.com>
Date: Fri, 1 Sep 2023 10:14:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] test/py: tpm2: skip tpm2_startup when
 env__tpm_device_test_skip=True
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>
References: <41f932e52bdd206b1b68d5ff313fc29b794a70e7.1693413381.git.michal.simek@amd.com>
 <b48a067e-4143-8cab-3387-e276e900e8f0@amd.com>
 <CAC_iWj+GZCHZkDf8C0v7oeJLwLZZep0jhKYv2at7BJ0gmqCFDw@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <CAC_iWj+GZCHZkDf8C0v7oeJLwLZZep0jhKYv2at7BJ0gmqCFDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: c54d60b1-f2f8-4ce5-3b70-08dbaac374fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqVx/Q4lzirwf7ACHpkDuJa+A8SGJf6HfluCFq9lmmusJEXobS5Oc/DewEQRSZlrgAtlYht+sgeKHDUCziw3xgBipEYN82i2DEPH8nNV6S2nrc6nYmob4NYmPcVLF3TOx+AcW2R3o9BQS6BSaZKWIeSxEIj25yegkzgQCO1V+N1CUn7d9XIwV2ZLz8kICffskEn7ijdd+4UWBcYAAaFRgZzfcqCpVtGT0DQ7AkhJYvhIoYfTu9eVXrZqjYL+iRmL6F56akbH2svAfZhymeADf7yBWOTWRRKAn8Z3zPkn2KxyI7d59beu3Hvhz2UrlA+93MbK+20Qi/htUlkaDp1xYtNrVr6GRFDU7w34Gepi4iwdFWw67er4X9QI8Z+h98zOXA1kv2oZFsuDPm0Pi30hpgm8nBRCyDcs7J2bPpyXe8pIreluZ07vrlIjun1Nvvi9+SRmdH55Vge6RBn/BvzgBO/C3tqo9CgkitUbq8gw4IGUpn/tq94ERuF9zpZ9Dprh5XHzLx90FvMMj19SKuHaXQWy2Vh2VxdCbMXTZgha8nSu46GrMpoqArAskgEPp92rndECbdu23jCcJUHIBUExU3Xi+ipKqF7QfFgbUw3nDKFu6ZWbcGPyN9xBZfq8rxAWaNPkw+U05J5unP6Yauhy9hHrVX1fnCewZbI67Z2IORHMwcy5fLe+qOMihBgMLaI6181kzcXPpT0qYmK3noNDmPLXvsIPQ6jGxM8UakEkyIu0Z1NNIeg/MQPg1T8Qrfe2lLEj4mAfTe01wGrqzOfK6mFWl+PeVAonVVxPE4/QTwcV6uT3aaeFNuTUnt4KMnWVtM53we8TnmEJNx03mStKMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(82740400003)(36756003)(41300700001)(336012)(426003)(26005)(966005)(40460700003)(16526019)(54906003)(356005)(70586007)(70206006)(81166007)(83380400001)(316002)(16576012)(6916009)(478600001)(2906002)(53546011)(5660300002)(86362001)(44832011)(8936002)(31696002)(2616005)(31686004)(36860700001)(8676002)(47076005)(4326008)(101420200003)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 08:14:26.0020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c54d60b1-f2f8-4ce5-3b70-08dbaac374fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
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



On 9/1/23 09:59, Ilias Apalodimas wrote:
> On Fri, 1 Sept 2023 at 10:09, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 8/30/23 18:36, Michal Simek wrote:
>>> All tpm2 tests should be possible to skip when
>>> env__tpm_device_test_skip=True but test_tpm2_startup is missing it.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>>    test/py/tests/test_tpm2.py | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
>>> index fce689cd992d..c2579fa02c58 100644
>>> --- a/test/py/tests/test_tpm2.py
>>> +++ b/test/py/tests/test_tpm2.py
>>> @@ -71,6 +71,9 @@ def test_tpm2_startup(u_boot_console):
>>>
>>>        Initiate the TPM internal state machine.
>>>        """
>>> +    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
>>> +    if skip_test:
>>> +        pytest.skip('skip TPM device test')
>>>        u_boot_console.run_command('tpm2 startup TPM2_SU_CLEAR')
>>>        output = u_boot_console.run_command('echo $?')
>>>        assert output.endswith('0')
>>
>> Applied.
> 
> Uhm? Applied where? I had a few minor fixes I was planning to send to Tom

To my microblaze tree.
https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/commits/20230901

I want to send pull request to Tom soon and need this patch to be able to pass 
CI for enabling TPM for Versal.

Thanks,
Michal
