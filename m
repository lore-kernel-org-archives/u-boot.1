Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58160FEFB6E
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 16:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C5283D1A;
	Fri, 27 Feb 2026 17:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HHw9nh8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD0083E76; Fri, 27 Feb 2026 17:40:15 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7797583CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 17:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlJY4uXg48qM0a2QbruCaEwquBk9Sbb2kxkuREoiev81V+EOTaMfavHT3bhTKi6xPGgD0VRDlwNhiJUhrJqvSz7+hLXkktr4mJCJIKaV9oyTVNjHxtiiopbIJBQB49G4k5Q2w5CsdvEyn6HkOh6PYnPw67kNbDnlPVrLYRt+4Zm5yNjDf1udDN2MHMbMyyumuXUVGjsV0LmXYRCpR6MVc5ycMiEFNZSlzn/tFU/hnt9jFAdavdtVSkhLE0S4/6Qn7kzZ2L2SUUhxKX2gnPzoMQhoVgRhxr+3/S0MB5Ztsn3iep3F5hku92OzZfdafajg4a3qAPdeO9Zj9Qhg8JArgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UABKnOArNyqjCxWq5fMuwH8jEl2VpvRdwZMz0sh53M=;
 b=tERbHQM34HSctut9rXz8oEQpmFSjWcokPoJzoFxtL1IByhSrLmGLZgOmILFvYmb2aM0+z92HSUFK3lu6PmHMtETmRkfjhUtrgN+iBcXibqywwVIVEZw4zwI3AlWUNWCLqckjNygR7Z56+OyuWoXUVNRXY2lpTTLyBFh+XNa6fALFk3wLiYVxFct74iredV9ubwyUEosc7YW4ihaC4UhWtKlQAlOFXM0Z8dyXK0M8MXEelJ7VHv/ZOWindLX6MT/4RK9lhjIGhyPDglrWtdI5G7xVNcwB6Xp4gpBt+I9iP0nmrgTO7HZrXZm+Z0LWiXxwv7pjBW1yVUl/+9r5RQp54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UABKnOArNyqjCxWq5fMuwH8jEl2VpvRdwZMz0sh53M=;
 b=HHw9nh8LBWLsaercoMf5RWYmdMo0xWBpAxWuaZJSt7EUNOTDmg7d5YSObaDegz6vbKwQyVbtRUdrszLno5Z7AeYcrLrAVpEKHQjLYoEMnIjY2Yh2WfpECDLIj7IkZ/tpEgeCUcYPDK0GEcPtdmb4FLN2X7C0HsiFsRa4VtJQl0k=
Received: from PH7P220CA0072.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::31)
 by IA0PR10MB7668.namprd10.prod.outlook.com (2603:10b6:208:492::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 16:40:07 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::42) by PH7P220CA0072.outlook.office365.com
 (2603:10b6:510:32c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Fri,
 27 Feb 2026 16:40:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:40:03 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 10:39:53 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 10:39:52 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 10:39:52 -0600
Received: from [10.249.139.123] ([10.249.139.123])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RGdkrj358921;
 Fri, 27 Feb 2026 10:39:47 -0600
Message-ID: <5e5e1b59-45de-423e-8b76-b75220597333@ti.com>
Date: Fri, 27 Feb 2026 22:09:46 +0530
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
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260227162355.GT1593142@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA0PR10MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ddf1d4-bb71-4e65-8eae-08de761edb7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: FUCbU5scDo9TaqjiL0LxkbArz+9m/b0XnJREGHWzQJEYJUEm2JRtXLXc3bGC96p5LB38kwH7b+p8lN0dh6e9InegDkR6eXaSHqoGgFf0twuwPVt3goKclJ+s+7KLDCXonBdT+LcE6tmG0FNrS7ip8ImBNIJdOhHjfDx7xBuzwp5TkSyqktWEGZ/gHYw+Rv+GuBYaTnZHVp7M5J3IzAjcYO9W2kIhpfs7sruvD0FVEdNsU2zGFDwMORXNkA8+abmlvTSEgFdwRyBs1RjsBnJZjq2wsKoNX9ueLxS5i62YkQ09mnPrGIKvXOYRCW8+lLKqvnwMWQ/TR2LSaRc+17MxvOJjpxiFlaYs1Lr3Q9emlGd9gNxWdWvT3FPXKJ46CWFfvD7awLxvDzntac8xssr5/umeowpJpEcKGbqmLBC89zMDdQiCvgepMY4J7DRmcDxPWYrG5nttHK25/cz4pn4ONr+FXgTu1Dgyk2KTfUtG2OMTMSOTWSZq1CT4HRKfa59A+sJNVuTdoOBQ9FhdKLU3LmsnNSIt4xN8C62Syi3nltk0k0rYr1T55t5P9P6LW4kfJSzUHp/85jHMBizIGv+fzIIam/Bx7iraE883ifDvZJL9EG/mIVs+9BDQ7bHng7d9ZsJ8VnyMErY3oZM/4ci4ilggVgy8+WId+ROzEEs3zSO22gbm4FLK64Xp2juATbuXolrpqh190Bxwc7KGuB+Ovw16VujhwQhsgwrDV4tAXQbGAdat/mJNGnlG/eMTldj6BrXrmwL6WY8N6QW6fAc9Sg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZZNYOymuNIW30GlMX+rn/tmLYrS0NW0PTZPp8zFEaYB4JOWiHc9orBN6cPTXgbjnD0RyaiKddsLDNh2Z7jDBDdwvuzl0czMxaDxAKH4BWAlNEqq2pktPAxgvtu3uVQeZCyPjIo3ygT4fW1ek0xvtLtEmdgBbCZNOLahO2AffEPBEfrFoZ5QjfI2gnU2x3qWYitm6+7QVDdMzcUc2tCrX41r2jwZtZ2fNja/bSsNmzz7cRQGmXJJllIt98F3wUuEg95yWjfhe5QQpjPJ1w3njlIc1gpt0qHKDL9rKzQejHKgcaug6/HsGxS/mjscr13vQnyav0GptJBLs2QmBX3g+W1VW1Q8gGaMd9bPJUX2MX0+s/uSCpqbiZmBI5nK24fEvmFTuIRGGc2fmbyaQWk6tOlhYvTYeG6DWnaiA4nRXoDfC3qXZFqY4BBKkMgnjuF3Y
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:40:03.5908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ddf1d4-bb71-4e65-8eae-08de761edb7e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7668
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

On 27/02/26 9:53 PM, Tom Rini wrote:
> On Fri, Feb 27, 2026 at 08:33:19PM +0530, Siddharth Vadapalli wrote:
>> On 27/02/26 8:05 PM, Tom Rini wrote:
>>> On Fri, Feb 27, 2026 at 05:28:28PM +0530, Siddharth Vadapalli wrote:
>>>> Hello,
>>>>
>>>> This series is based on commit
>>>> 437ea9f8be5 Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-lab
>>>> of the master branch of U-Boot.
>>>>
>>>> Since Linux device-tree has switched to 64-bit Address space for the
>>>> PCIe Controllers on TI SoCs, currently, U-Boot needs to support the
>>>> same. This series adds support for 64-bit addressing for PCIe along with
>>>> enabling Root-Complex mode of operation for AM69 and J784S4 SoCs.
>>>
>>> At what tag did the device trees change? Thanks.
>> The DT sync with Linux by the following commit dated 30th July 2025 changed
>> the PCIe Controller from 32-bit Address Windows to 64-bit Address Windows:
>> https://github.com/u-boot/u-boot/commit/ecec23fc9a9f0eb48b761722c492cbbd4bb2e546
> 
> OK, so we should add a fixed tag then? (please just reply with the
> correct one, b4 will grab it). Thanks.
> 


Fixes: ecec23fc9a9f ("Squashed 'dts/upstream/' changes from fe2d6c49bb4e..d08867ef8f12")
