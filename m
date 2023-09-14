Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F2DEEAA4E
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 14:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2431E86A14;
	Thu, 14 Sep 2023 16:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ETvP306R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4640187069; Thu, 14 Sep 2023 16:58:22 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA34864EC
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 16:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f//n6bwa7Fz7KCLbpfYolmmI4D1dLDRutuq/acjJ0XzLBp7Aw5WpM1nxpTiL5g2OkjhmkMe+DYQ3J7sX4gRn6QPvUFoUHCGe0UnIt3+/ILZ/Uebc9+6SoMx3uUTb6zeobCoHZpBsM22AVhANVwfBj1uRxa/BEE7oJZ2brKn0WqMklPeeEdyZ6UH4qYjTWKVsKJLoUtUBeYWyYjwd92BwFN3n4w46wMbY/NWSg5zpZ59Ca9Vyf9IZF2zvLs9BwFKF15DGhXCYaTjz4kM5TzcFz9/a4sj5u+3OxoG7VAQkQDVotAJV+LuO9pf23GmRU+SvstSl/ji15M3m14JT3vBFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUVg9m/m3Vj8Op0a3f8b5AK2+ZXF4jg49XCR72ghPSo=;
 b=Et42K51RLr657U4rSwp+qbuqMzK3vFf5+FLaKkYm1dzQ9/qgRzeOEQ4bqXfZwdU7mRSoGdT25p3TKuJ+2EGWpD6z8DKqqEkLPnnZnMtPNs80CDWKIzLdxBBbj+hjxSxQrUe0jxymNMAXlZmnFL/eWvQXPrsO1U+/85toC0kOLXfCB6S9UCOj3XCSWNb6PynKI+ysWK0iiexBf/A1XIBxWs8a16N8D1pr5PD7gvhF7LYgsfYVoL8mSbh44E5+r9cmHiKx7ZMCJFBfbg2+Xn+uyLF8EheeUeti/nacleruWRNMCFgbLAK7Tl9zJG4Nx+ZDwh3mh+oj1FzCIBihfjuf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUVg9m/m3Vj8Op0a3f8b5AK2+ZXF4jg49XCR72ghPSo=;
 b=ETvP306Rll0iHkTXNVrvQU/Ai4luJrFFm3S9cAY4ify3vIGXK3J5TQLSxsN1tbPS0/zQM3yX8GcXTCUUm9yXyLOAuWnHry9M6hirufnxktXly92ctYmwGnaIFPjQRWX89UiTIa0cRJasOwHkF2/EObvk24NwS/nG+js5pkJNM7M=
Received: from BL0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:91::19)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 14:58:16 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::41) by BL0PR05CA0009.outlook.office365.com
 (2603:10b6:208:91::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.17 via Frontend
 Transport; Thu, 14 Sep 2023 14:58:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 14:58:16 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 09:58:13 -0500
Message-ID: <8304411c-ab8c-4ff4-998e-e4033aa84698@amd.com>
Date: Thu, 14 Sep 2023 16:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] trace: Fix alignment logic in flyrecord header
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <git@xilinx.com>, Tom Rini <trini@konsulko.com>
References: <cover.1694435541.git.michal.simek@amd.com>
 <ffe462a5a535018833443821880becf3bb366564.1694435541.git.michal.simek@amd.com>
 <CAPnjgZ2dPj2RJh5vXQQ_6AkauPDzG65TdqYMz16RPXqVmYEuOw@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAPnjgZ2dPj2RJh5vXQQ_6AkauPDzG65TdqYMz16RPXqVmYEuOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc43e51-d61e-4674-66b6-08dbb53306af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQUEkr8oc8noXBX/idergqoDBVTUNyJtIhz0ounJxsfzDeH0/IE3ceNPjZamGw9WkdnxWQVijUTkFYRaFiv0xBSlvpL0FrEnm6ywCJk8bgNouPmSPTg6IabUrJ5arLn8EHPLpwvXuvpfSznZ+WS0gqN65rItjnEZmTXCVwWwbdyr9gYGcGx9HoJ2bGGhMMkj/T8k/yp6vD4bh7/1xR6UqxBbZc3N8BxjUyyHpCmFcVVZHW6xY+Fcw/5iMww7If8PHj+7CIRDUXJtx6yPuEUHfyUWkMDHhiQj4izFFVem3kk2T4V2jpJrm6zW5TWRwnRHQRhFd5mDIZRHZmQGLj2gVoh3x8vTV+DgkmECpwn+lP3M09AIZQOz5uYRfnWNCKkw8ATi9AqxWy3Bww2h1DjLRP+ILkJmEO5MNGZK+scavSk54lf/DQoChVWgG0FxtjgTinm8jUDWMv2qamcooFenKFKWJ1QSCGpRyI32bllrxSfNwBdLHZj0QiC38UmB8qBGy1zyEUvHYEGHx3aLXe7BZKxGatrKTLDEJgd+4kV7h8ceh1IcXbK+lSJtYwAUx2JCxul33xMqH/pP2QBbzKSCXBpJsSneHLWVEmIL+j37Gtl0Yi56zEjIhMZQtSsDZDE3EN3DDIS9oAIMZyeca/3uzSaCsEcy9pb3KwQCqgANK34kG0EP1stTfWotEzV3yIvWRLBbZonEhbKCTfrJBefrU3lyKPH3Awnwabg4WYD0dWFsMf8gxKAd08Wq/Q2ZHUeO/bf27tazNAFxqXW2hmJn6+JM2XV1vUP7J8ylOa2gFZxpX20vTmcDHRo5Ta9q6OdI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(1800799009)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(5660300002)(70206006)(31686004)(81166007)(356005)(53546011)(83380400001)(2906002)(47076005)(86362001)(82740400003)(36756003)(40480700001)(336012)(2616005)(36860700001)(426003)(4326008)(16526019)(26005)(8676002)(478600001)(16576012)(70586007)(44832011)(40460700003)(31696002)(8936002)(41300700001)(316002)(54906003)(6916009)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:58:16.2862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc43e51-d61e-4674-66b6-08dbb53306af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306
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



On 9/12/23 21:26, Simon Glass wrote:
> Hi Michal,
> 
> On Mon, 11 Sept 2023 at 06:32, Michal Simek <michal.simek@amd.com> wrote:
>>
>> Current alignment which is using 16 bytes is not correct in connection to
>> trace_clocks description and it's length.
>> That's why use start_addr variable and record proper size based on used
>> entries.
>>
>> Fixes: be16fc81b2ed ("trace: Update proftool to use new binary format").
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   tools/proftool.c | 31 +++++++++++++++++++++++++++++--
>>   1 file changed, 29 insertions(+), 2 deletions(-)
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> See my comment below
> 
>> diff --git a/tools/proftool.c b/tools/proftool.c
>> index 7c95a94482fc..f79128169e68 100644
>> --- a/tools/proftool.c
>> +++ b/tools/proftool.c
>> @@ -1493,19 +1493,43 @@ static int write_pages(struct twriter *tw, enum out_format_t out_format,
>>   static int write_flyrecord(struct twriter *tw, enum out_format_t out_format,
>>                             int *missing_countp, int *skip_countp)
>>   {
>> -       unsigned long long start, len;
>> +       unsigned long long start, start_addr, len;
>>          int ret;
>>          FILE *fout = tw->fout;
>>          char str[200];
>>
>> +       /* Record start pointer */
>> +       start_addr = tw->ptr;
> 
> I'd prefer start_ofs since it is not an address, is it?

make sense.

> 
>> +       debug("Start of flyrecord header at: 0x%llx\n", start_addr);
>> +
>>          tw->ptr += fprintf(fout, "flyrecord%c", 0);
>>
>> +       /* flyrecord\0 - allocated 10 bytes */
>> +       start_addr += 10;
>> +
>> +       /*
>> +        * 8 bytes that are a 64-bit word containing the offset into the file
>> +        * that holds the data for the CPU.
>> +        *
>> +        * 8 bytes that are a 64-bit word containing the size of the CPU
>> +        * data at that offset.
>> +        */
>> +       start_addr += 16;
>> +
>>          snprintf(str, sizeof(str),
>>                   "[local] global counter uptime perf mono mono_raw boot x86-tsc\n");
>>          len = strlen(str);
>>
>> +       /* trace clock length - 8 bytes */
>> +       start_addr += 8;
>> +       /* trace clock data */
>> +       start_addr += len;
>> +
>> +       debug("Calculated flyrecord header end at: 0x%llx, trace clock len: 0x%llx\n",
>> +             start_addr, len);
>> +
>>          /* trace data */
>> -       start = ALIGN(tw->ptr + 16, TRACE_PAGE_SIZE);
>> +       start = ALIGN(start_addr, TRACE_PAGE_SIZE);
> 
> Would it be possible to store the old tw->ptr value at the top of this
> function (e.g. in tw_base) and calculate start using (tw->ptr -
> tw_base)? It seems that there are two parallel trackers here.

I didn't actual dig into that reasons why tw->ptr are used with all that tputq 
logics around.

I was thinking to use minus but because there is trace_clock description on this 
line you are not able to use tw->ptr because it is also changed below. It means 
I decided to do calculation ahead with calculating all bytes which will be 
described here.

Thanks,
Michal
