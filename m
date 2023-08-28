Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C694C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 10:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA472805C8;
	Mon, 28 Aug 2023 12:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bVfngE5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D18186454; Mon, 28 Aug 2023 12:44:34 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C164680282
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 12:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNHbTqgY2za/7xS0PQY1z1puW/r1S6bj6hrbvxIypaDPT0F77Ldppl5iszeVNf5yMfgfyj++4eyJrCbwor4jvaY73ZhrS/Vo4qcFMzxtR3MyFWwgsYMvraoA8HRuaFsi7UcQK2fZrcyPJsGAmB1BT2TGxxIu2Dc8QJ6o0DjLA0mdsCNcS2NZ/rwa6ejRciSNON101mYZAGv+e7Puha4JxQ023g3NzKPJ6ubykn0T1B+aGnGgwjbIQ/iuwDGoUFfhKJVKq0ni1gQc7Ii5ksQH/oCvWUsk6IO23Q+IMatHX1INFEJqytpkA419E244IUFlxbpkOrZXTe1Ox0HKQoXKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRa3LdZQh3qxN14BkBUUr04r3Cr+NK4pkZxaIUGPpR8=;
 b=X3EU07Emrhc8Q2EL4/VndqipqY9ZrzsRGVPbi5xaFDERFMj07NDwTDB7rIdXRkW5oaPv9cWbLWURbwXka/lw9yjAKQYTECsFiaZvzlrbot112zGmfe8fc4um+3qJqfIZ1LM3p/tF7jEQug8WEX28pdVt51/dfYGw2zZuvZEQI8Bq/tiTjlV0HbbyRIk48InJdzdoLjuC5buYRG8mC4K4Vpu3YzBKQGnQDe4D8hMuNAQVvh/1NMq1s91oExo6Ko19sbbHeQKLtWMWKCKa/FwUIJ1Pye0nTSIugIwWxtsxMj8p3xxiEFC1SE1l0WIH3tVeVhupuLML+zbJ9wBjYmQhrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=samsung.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRa3LdZQh3qxN14BkBUUr04r3Cr+NK4pkZxaIUGPpR8=;
 b=bVfngE5aL6XwaU7TSOxaMHrnDXsl7lYFUsPwaLGGcPw1ZiGQ0co0eeHjdvLPhpJDDn0VzGlZsFNOmJr00e8804UM73G/pQZAqxVnwJnc6AUyYXxcytbNPn2pXukskW2lplUpqVvt4GRk5SghbAVgNOXt2ede3b/0kB94XwOdZAI=
Received: from MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::35)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 10:44:26 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::d2) by MW4P220CA0030.outlook.office365.com
 (2603:10b6:303:115::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Mon, 28 Aug 2023 10:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 10:44:25 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 05:44:24 -0500
Message-ID: <cddca0ca-ced8-78bf-0d87-15d896e88b5f@amd.com>
Date: Mon, 28 Aug 2023 12:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] fpga: define dummy fpga_load function for debug build
Content-Language: en-US
To: Chanho Park <chanho61.park@samsung.com>, 'Eugen Hristev'
 <eugen.hristev@collabora.com>, <u-boot@lists.denx.de>
CC: 'Simon Glass' <sjg@chromium.org>
References: <CGME20230816065448epcas2p3bf66892f15a6dc8e082a5f296b307bec@epcas2p3.samsung.com>
 <20230816065437.836392-1-chanho61.park@samsung.com>
 <c0e49c05-a5f8-2759-33b5-946bf2283b34@amd.com>
 <000001d9d945$95ebf520$c1c3df60$@samsung.com>
 <7d288a5d-2d8e-39fa-2b18-327452a4cdbd@collabora.com>
 <000001d9d996$73b90f50$5b2b2df0$@samsung.com>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <000001d9d996$73b90f50$5b2b2df0$@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8610a8-ae9f-4551-c887-08dba7b3bfc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 32wRrH9Mvikw/SYFpNKEi59J1cVIRjXUzo3I6PC+KXbBRkVcbuyTJIGj0aOQGBxYMHWdCCpx/Q9F7fD0bXpYvGuvgQSYvu7EQ3G3pXQ9MtSkyuyYKZeQUv/pjmsfPfS4Ee3Un464/WSGhCmskA2r25vRHEjjpHl+GwyeiYThQyIi5bt9gNYUJnKvejODhOWI1DEbVm722mu3IP2zuIGG8RMkCNPNh0gX4FOPKUHfhy4Bslxt/RyFJjknGqnuqRDdOx5vzmzEfYSgzk3Eerw95GmsEeZivCWVIglgciXkSjfy+n1wcEKVXJTDs3ZPCwHYTlf7Kq6hBHpbq2WipllpcsqaLkXQZl6qTnXb/uvoVE162j4lYni2lyfeSU2fxNPKWPIcljh3VKfkxSE66BXh9OZcvoE3zDFuJ54XyI6QpRqR6klT90dD3MbpwSuK3EcAwv8six7ZQLSfS7K9oKpsW2wRbVGgrBsrTDGhKyp7m2hYvF+b/RAzbN5MjL0rAhRbbI5fEv+91+H5zBZc4DfbbHjet53trKAVqnqbXCIlhNW9GYQub8597+OWjUf4o93wzTuhLiiLuyiafELZ2WlPU+LhJdOuUPALgqeXpm0kDUMisjIYlYAzpnvQ+NJQ0WEakLEgQoFAx5nMbDsmIOP+HoIfjnrsifvOW8XHepnZm7RG6ai98Y0RQ1DJsBfCe0/7vEQnOyo8pJB/WoX83vNcDlpqL4mB/vjAzYnv3YMgHyt/kjjDVKpRRrozIx92eJ4EWPAIcVgtmRdUWObFvDhbct6D+1njA3TaSz4docj6at4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(31686004)(5660300002)(70586007)(40480700001)(40460700003)(31696002)(36756003)(47076005)(81166007)(86362001)(356005)(82740400003)(36860700001)(110136005)(426003)(41300700001)(53546011)(336012)(16526019)(26005)(83380400001)(478600001)(2906002)(966005)(2616005)(8936002)(44832011)(4326008)(8676002)(16576012)(70206006)(316002)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 10:44:25.9717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8610a8-ae9f-4551-c887-08dba7b3bfc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
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

Hi,

On 8/28/23 12:00, Chanho Park wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Eugen Hristev <eugen.hristev@collabora.com>
>> Sent: Monday, August 28, 2023 5:47 PM
>> To: Chanho Park <chanho61.park@samsung.com>; 'Michal Simek'
>> <michal.simek@amd.com>; u-boot@lists.denx.de
>> Cc: Simon Glass <sjg@chromium.org>
>> Subject: Re: [PATCH] fpga: define dummy fpga_load function for debug build
>>
>> On 8/28/23 03:21, Chanho Park wrote:
>>> Hi,
>>>
>>>> -----Original Message-----
>>>> From: Michal Simek <michal.simek@amd.com>
>>>> Sent: Friday, August 25, 2023 4:23 PM
>>>> To: Chanho Park <chanho61.park@samsung.com>; u-boot@lists.denx.de
>>>> Subject: Re: [PATCH] fpga: define dummy fpga_load function for debug
>>>> build
>>>>
>>>> Hi,
>>>>
>>>> On 8/16/23 08:54, Chanho Park wrote:
>>>>> This fixes below build error when CC_OPTIMIZE_FOR_DEBUG is enabled
>>>>> and CONFIG_SPL_FPGA is not enabled.
>>>>>
>>>>> ../common/spl/spl_fit.c:591: undefined reference to `fpga_load'
>>>>> collect2: error: ld returned 1 exit status
>>>>>
>>>>> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
>>>>> ---
>>>>>     include/fpga.h | 8 ++++++++
>>>>>     1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/include/fpga.h b/include/fpga.h index
>>>>> ed688cc0fa3b..44f2755a3f10 100644
>>>>> --- a/include/fpga.h
>>>>> +++ b/include/fpga.h
>>>>> @@ -60,8 +60,16 @@ int fpga_add(fpga_type devtype, void *desc);
>>>>>     int fpga_count(void);
>>>>>     const fpga_desc *const fpga_get_desc(int devnum);
>>>>>     int fpga_is_partial_data(int devnum, size_t img_len);
>>>>> +#if CONFIG_IS_ENABLED(FPGA)
>>>>>     int fpga_load(int devnum, const void *buf, size_t bsize,
>>>>>     	      bitstream_type bstype, int flags);
>>>>> +#else
>>>>> +static inline int fpga_load(int devnum, const void *buf, size_t bsize,
>>>>> +	      bitstream_type bstype, int flags) {
>>>>> +	return FPGA_FAIL;
>>>>> +}
>>>>> +#endif
>>>>>     int fpga_fsload(int devnum, const void *buf, size_t size,
>>>>>     		fpga_fs_info *fpga_fsinfo);
>>>>>     int fpga_loads(int devnum, const void *buf, size_t size,
>>>>
>>>> There is another patch targeting the same code.
>>>> Please take a look at
>>>> https://lore.kernel.org/r/20230808102227.34233-1-
>>>> eugen.hristev@collabora.com
>>>
>>> I wasn't aware that there was an attempt to fix the issue. If I knew it,
>> I would reply the patch...
>>>
>>>>
>>>> and work together to come up with the patch which covers both cases.
>>>
>>> Yes. I also tried to make the patch with CONFIG_CC_OPTIMIZE_FOR_DEBUG
>> guard but I couldn't find any codes that uses the guard.
>>> And I was also worried about the CC_OPTIMIZE_FOR_DEBUG's behavior. It
>> could be related with the optimization level of the compiler.
>>> That's why I put the guard with #if CONFIG_IS_ENABLED(FPGA).
>>>
>>> Best Regards,
>>> Chanho Park
>>>
>>
>>
>> Hi Chanho,
>>
>> Simon suggested to use CONFIG_CC_OPTIMIZE_FOR_DEBUG in this case here:
>>
>> https://protect2.fireeye.com/v1/url?k=a911b2cb-c86a1843-a9103984-
>> 74fe4860018a-146c33e2b586dc8a&q=1&e=e288ab48-75e8-400b-91c9-
>> e8bd95520918&u=https%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fuboot%2Fpatc
>> h%2F20230619102839.277902-1-eugen.hristev%40collabora.com%2F
>>
>> As I told Michal, basically your patch and my patch do the same thing.
>> I suggested him to pick the one that he thinks it's best. (or even suggest
>> another way)
> 
> I agree. Either way, I'm fine with it.

ok. I prefer Eugen patch and Chanho please send your tag against that patch.
And let me comment Eugen one.

Thanks,
Michal

