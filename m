Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C71FEFB6E
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 16:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D846883D1A;
	Fri, 27 Feb 2026 17:50:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k9TRR3DT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA3DD83E96; Fri, 27 Feb 2026 17:50:21 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D968483CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 17:50:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ilk2qRKq/g7mBA30xEeSo2wZ8DEl727ynQh/Z032RUBUFOqzlgHri2MguVo4d/PaK6U1NmB0O7QXdBvHuMb9RivB6FQVHXWibAoI/VYshfe923JhFGaAiKYe//y+SIPRDty7WcGURYR2cN3sLpH1eeIBH7cQOoC5LdHO314iJ+zjNctt2mPw5QWW6sTuboHAZ7zMw+NVHSjYyzHwr/BDRN+/tbil2Fyzzhm6ozkcvYSPBdSFXXDVWYciUG75eVewl24Z3nPWL75wIfWMFRCNaYZSK5Ju71Vq1u54v6f24+1X6dN7x94LXVhvKiex3H8wAeOAI9o+gTfqAo0Gj8rgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3ugJgF+vY0IKja2pFDt3gqjLYvDtM346aY2JJQnVAg=;
 b=o6vx8kVIudn/HC3afY1MKncmxcFpX/SZbmQWLPMpB3PNt1vG5citQjg0Qnz1Uzcx6uTzCiv+xqHryh4hRrkBDZqBn/2wobFDvmksKlBNvPE7UqDoSR/RVt08nNTSM9VLKzzxIDB0Ww1MP08qwwsldJmJAfgIj58Zi4gwXN4ecMYwDCaApoPUlASbOYJt4znrKeeqjeVKnJvMe80BWxNj54+gZb50lCkBF8FLFdQTp8UXw6oj9qeBnmYppchOndRSP8mQpeevdSm7sMimQIo2nuk3rwUVZfFPvsYxH0Dlre1ImjPVEg6dFqulRXZDaE8W6fJNGwxjkGfOY2PKME0O7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3ugJgF+vY0IKja2pFDt3gqjLYvDtM346aY2JJQnVAg=;
 b=k9TRR3DT67C4Q/sY37Hxl6wMxUhXiZsGyVT3Y9bF34tHbSEnW1QdS0LxBc+U9lgTVLpe8c56Goi+EffsTLe1bhiG/tsW3PqygPh0D/0oHUtYwp5A+mxHsM3ka8aMbgD5WL81aa3eFTJatPaHRvABXFtoePTqwKz+GpwEW7tlnls=
Received: from SJ0PR05CA0132.namprd05.prod.outlook.com (2603:10b6:a03:33d::17)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 16:50:13 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::40) by SJ0PR05CA0132.outlook.office365.com
 (2603:10b6:a03:33d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Fri,
 27 Feb 2026 16:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:50:12 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 10:50:11 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 10:50:11 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 10:50:11 -0600
Received: from [10.249.139.123] ([10.249.139.123])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RGo50U371471;
 Fri, 27 Feb 2026 10:50:06 -0600
Message-ID: <e6aa4fca-77fc-4fe5-98b0-dfe2d9ef9c9e@ti.com>
Date: Fri, 27 Feb 2026 22:20:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] 64-bit PCIe for AM64, AM69, J7200, J722S and J784S4
To: Tom Rini <trini@konsulko.com>
CC: <vigneshr@ti.com>, <anshuld@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, 
 <bb@ti.com>, <jm@ti.com>, <s-k6@ti.com>, <afd@ti.com>, <u-kumar1@ti.com>, 
 <marek.vasut+renesas@mailbox.org>, <a-dutta@ti.com>,
 <neil.armstrong@linaro.org>, <semen.protsenko@linaro.org>,
 <peng.fan@nxp.com>, <george.mccollister@konsulko.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
References: <20260227115841.333073-1-s-vadapalli@ti.com>
 <20260227143509.GQ1593142@bill-the-cat>
 <0980b08b-ef08-4ae5-8656-4b6c211a1680@ti.com>
 <20260227162355.GT1593142@bill-the-cat>
 <5e5e1b59-45de-423e-8b76-b75220597333@ti.com>
 <20260227164416.GU1593142@bill-the-cat>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260227164416.GU1593142@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: e7071dfc-7975-45eb-e1c7-08de76204672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|34020700016|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: 12KKGXgKsX1p9ghE3b2p+V68fMA4j/ZpPBrodMNkS/KRaFU7XMtDXZNPhD7WcKQjHM8i503YMOzXJW2Ob56PmjUgZ2lBd3EO2WRJpu2QpMbs9sBJ0A870p5VQ1eCDPMRuR1YXlFOmfsu8kM3OKFGj2kWwrD8gr3JHnOO9glH3nKlSre0Pqf+y8/ALoButDSB3Vxy6m39ac7U1KI8VOa3QP4nhfQ7BCngJhZRFmy9XhAqdnI3EeL1R5GZusyjQMmHySFy8tCHIxq7TRqA9dabV9hhXFjub+7wVwZp7eRKGqVuvpisfr6VO/9gIqENPC9911vS8UN/62k4NZy0afDZsOJC7KY6MxlBhZPuulfGaEFwwQv/R4adhwBK0FJp8wxZ7xqYYXUiaG8TMjPR+SYxIJRi43ULhZp3n4H8zTtW+jawfvxrR7l7V480xbgVq6u30OcNXzYhfDQntnqwKd+VwEWNbErSaKkBX3nFDjz5VOqIqgtfTFXdN1WQ1rhHx+aDeTT1WjR+oVmcWUVGFkkE2uJt7V6lzhFm6eOFxwduEZ0z5h08eFCGrFuriPcoRJVgp+jiXu93jD0An3BIJagQs1RF5uCwtmsWZ4RyUj6cXCMaTsuGHEmGG8Q90fxf/8TyTPPMhcv0IZ0AhjwHgoeeqNrjvypvgBFgr+DtAAL4wcBLmjR7gy0WXoGTmcK+k6dwj9CN/NszF4+y4rRquJjV+cJJADK8+TnpU85iw+ILeJYEM+gXq0rJdt9ksiOWtgXTrwaiQHtjlwaZscQUcVGzNA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(34020700016)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 06P0GsJfW8OwCn61YBgHLg3PeK7Z71u3bG0HyLZDpyxpyjRjHwMKVjAJAl4nKnV6tQrHNDHR2FGrE4l5Ly8Gw8lcrbkMrRgZyKncSdrqMZSePT2+jQIeLQd26P/VdHUwmo3yHRh/v7HMwidTBsiyBcwwHZKe5EbMoCu+18VsnlEEEjpOzpaV4wWsN+YnzOrWhhUjWu999PLRh8WqYwA6Ro1nDJl85aG7ptt8YL/KN2H6jFy5lPFJSpQFsjx3aSYfOtnvZRY1rgrBHP+DsD2vobQLV7FfQqlRggeky9kODh9p5iFs+lS2e6fVHdLHeJxSC9jdIFdJBcJKh/BQi7kqKowz1pzytBlkrYZBR8NL23XOrBLbHBOKIG8d81lsQG8oN6lLeaUwbBiCy1spss4P24J8zgMexyN10xLnncvxn32J7ExLTNhdVEM7hWc4apGq
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:50:12.4867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7071dfc-7975-45eb-e1c7-08de76204672
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
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

On 27/02/26 10:14 PM, Tom Rini wrote:
> On Fri, Feb 27, 2026 at 10:09:46PM +0530, Siddharth Vadapalli wrote:
>> On 27/02/26 9:53 PM, Tom Rini wrote:
>>> On Fri, Feb 27, 2026 at 08:33:19PM +0530, Siddharth Vadapalli wrote:
>>>> On 27/02/26 8:05 PM, Tom Rini wrote:
>>>>> On Fri, Feb 27, 2026 at 05:28:28PM +0530, Siddharth Vadapalli wrote:
>>>>>> Hello,
>>>>>>
>>>>>> This series is based on commit
>>>>>> 437ea9f8be5 Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-lab
>>>>>> of the master branch of U-Boot.
>>>>>>
>>>>>> Since Linux device-tree has switched to 64-bit Address space for the
>>>>>> PCIe Controllers on TI SoCs, currently, U-Boot needs to support the
>>>>>> same. This series adds support for 64-bit addressing for PCIe along with
>>>>>> enabling Root-Complex mode of operation for AM69 and J784S4 SoCs.
>>>>>
>>>>> At what tag did the device trees change? Thanks.
>>>> The DT sync with Linux by the following commit dated 30th July 2025 changed
>>>> the PCIe Controller from 32-bit Address Windows to 64-bit Address Windows:
>>>> https://github.com/u-boot/u-boot/commit/ecec23fc9a9f0eb48b761722c492cbbd4bb2e546
>>>
>>> OK, so we should add a fixed tag then? (please just reply with the
>>> correct one, b4 will grab it). Thanks.
>>>
>>
>>
>> Fixes: ecec23fc9a9f ("Squashed 'dts/upstream/' changes from fe2d6c49bb4e..d08867ef8f12")
> Fixes: 79f3e77133bd ("Subtree merge tag 'v6.16-dts' of dts repo [1] into dts/upstream")
> 
> Would be what to use here (git is fun and can't "describe" ecec23fc9a9f
> because it's a subtree commit I guess). I'll correct when applying,
> thanks.
> 

Thank you for pointing it out. I will take care to mention the correct 
commit for subtrees in the future and also include the Fixes tag.

Regards,
Siddharth.
