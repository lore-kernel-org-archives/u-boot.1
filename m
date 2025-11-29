Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F3BD116EA
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 04:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13338835B3;
	Sat, 29 Nov 2025 05:27:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HwCHLYYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A70FC835C6; Sat, 29 Nov 2025 05:26:59 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CB80832AD
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 05:26:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2nxqwmU5fqhP878Uil+yFw7ssgpHscmfwAzA6J7KhxXP0dxrdLue0icYuAvW0xvbnKCl8vs76JexcXlA1VIw5J/yZHzKIT2NqTnr1ztZjymld+xgo//PxCm0LPf82KDFm+P096OlDq2tyVxmLYs3z89d830wxdXNNVWq55XcDexmwOgl1IeE227sCp8MEv3CzJ9/CBScypfjrgFoY6dhXvEoqilR+UtB4esCJtMHxMIZ7Ki3pGOnmfqIGDCfL1p6e436wwdlPebU9jChAKB5Gdr/ID3kfzFaVB4AWTyPkah9P5DGuLW06giRfs5Plyr5ddf/r/Aij6pymkWiiCncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZakFhx7UVtozb/lrAN+zOVXDK8UjAJR5F8eVGfI/GfM=;
 b=wxs1flFwgY4/4jpwNvr7ZEJghpWAtnwyk5BG0+Ut481XPpYmq54zMK4bPysMWrUnce42tSUC2VgWi4Alwzq4Gok/IrELmw29/bC1Zy6AKf9jIuoVh41DJ13rbL6xu8DHTEW5LO14NSuuWdpS2DlqtEtaQxqrLcnntSMf66XZdsnXrZR41VWO29CCGVjsTPze35PH1ijU2iurmuV/iVfxbnJtht3mbN7yqSN2CrtKpVOw0LJ73gnUB76kgpz1tcMN2vCf+xuoYoT6ylP0QDD/XNmUJehBGrUAOdmN/cASgpEAe0JqMff6cp030pbXgNgtw29zYufDdoBI87fkHTgJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZakFhx7UVtozb/lrAN+zOVXDK8UjAJR5F8eVGfI/GfM=;
 b=HwCHLYYZ8knx8cngNosbqLPx4yanH20Cf5E2pfrKOAiKUWQl9nB3b4fNeJPibeJ9CrRJbSJBq4rKVMg5GcC0/vo/ttw1X1geKMDe7zz+c6HHl2rzaJmegC294yj3uj/r3DWZb+77aeS/916j4Y9k1NeTD7Nn5ccP3KQa3Ajavio=
Received: from SA1PR05CA0001.namprd05.prod.outlook.com (2603:10b6:806:2d2::6)
 by PH0PR10MB5594.namprd10.prod.outlook.com (2603:10b6:510:f6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 04:26:54 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::20) by SA1PR05CA0001.outlook.office365.com
 (2603:10b6:806:2d2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.6 via Frontend Transport; Sat,
 29 Nov 2025 04:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sat, 29 Nov 2025 04:26:53 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 22:26:50 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 22:26:50 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 28 Nov 2025 22:26:50 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AT4Qi9O1277572;
 Fri, 28 Nov 2025 22:26:45 -0600
Message-ID: <15b87b7c-ad6d-464c-8654-f8b31cae525c@ti.com>
Date: Sat, 29 Nov 2025 09:56:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: spl: Enable Instruction cache after relocation in
 board_init_r
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Prasanth Mantena <p-mantena@ti.com>, Tom Rini <trini@konsulko.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>
References: <20250317064507.1702120-1-p-mantena@ti.com>
 <20250317151318.GR2640854@bill-the-cat>
 <20250325053420.4wuenxmlnqsojuyt@prasanth-server>
 <n57czo3z2lzyarh22y7oien3b6vgyum5lt5z7xe2p3rrcktxpp@qmdmk65aagng>
 <4684aa54-db50-47de-a565-e529bde793d3@ti.com>
 <hkcauyeizj56liomndagywfj54u3qpm2i3ameo5oyt2ja2mnrq@kluwp7dalbma>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <hkcauyeizj56liomndagywfj54u3qpm2i3ameo5oyt2ja2mnrq@kluwp7dalbma>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|PH0PR10MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: ad98b36b-aebe-4b60-1a5b-08de2eff8643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cm1HdDhFcVdtaEFGcUVIVnZyZDNLMmRjdWE2WnJkU3VDWW0xOTJnQUN1d1RP?=
 =?utf-8?B?MUV0SUU4dTdRSkw0NWxjdWdWUDFYaG1Qc1RBaG11VXFaOE4wT0RPMUtPbVRa?=
 =?utf-8?B?TTVRRERRS0RzTUVMNWNJbGJ0SEN3TjJ6SVA0NExId3ArcVBOM3FzNTBFNDRL?=
 =?utf-8?B?TGMwSm5PSUU5RENuTUdwTVVBVUVadjZxZk05Z1BZRUVRUS9XOUFSUkcyOEpO?=
 =?utf-8?B?RkFTREd2QUg5bVJpejVmTWtleDQ0R2dOMFA3RmRtTGlRckFqNUI4NmRzdndu?=
 =?utf-8?B?R2dVQVlsZnZvZG83cnhWRGF4Y0FSSjVyQnlFbXpDV3dIdDg3clZ0d2tvc3R0?=
 =?utf-8?B?ZjhXWVJDRVUxMnNINGNUcVM5bEVPTUViRzlUMDZCU0tkMTllUnRoV0xqais1?=
 =?utf-8?B?VWxUR1YvQ1h3aGk3dG04UFRlK0VCV1IyZXZLOWVOcS9oOVNDTXEwWEpGYUc4?=
 =?utf-8?B?STBqY0dRYUVJYmNMdCtiNGU1VHpZcGhadkE3MTZzYkwzVTFkMzBjSkc3MXBs?=
 =?utf-8?B?N3ozVitDUGFOeGxqR0JZbkFEOTMwSmJJbjlJUVlDOWxJbWZ4K0dQRU1GbXJa?=
 =?utf-8?B?bVJGdWRsdERka1J1RWVkbXFhVDdPNnMwQ1VaWFgwcHhtZjlIaUlwVDY2Sks3?=
 =?utf-8?B?RlRzUzdkajNtbFl2bHRiMHJMSDBCQmo4SXJDMnVKdEpjWUdaV1B3N091Q2xG?=
 =?utf-8?B?cFNaYmE2a3IvUm1nRmhSakh1aDBEMW00aTd3VC9rLy8rZ29Ya3BCUG5zMHhq?=
 =?utf-8?B?b0RSRTVPdXlxOXlDT0twWnZ4QkYzR3ZUb3dEelpqR2lUYWRrN0FZZFpJb2hn?=
 =?utf-8?B?VDZuR1h4M2VESEI2cEFxdFhoNHljQWUzeCt3dEhiOFhFUE9wU2NGODRQSUtz?=
 =?utf-8?B?K0ZsZ09kT3J3OTdzdVlNUjlTUGVWZ05zMk1EelFxV0puYndsMEZyam5aWWd3?=
 =?utf-8?B?R3ZwYlY2TG9XQStGeWRRc3Q3bGQxOUhjTUlhM0tVMU5uc25CTk9xZDZFanMz?=
 =?utf-8?B?NXU3dFgyd0lqR3ZBcThXVkgvRzBrcHpGWGM4SmRBTktMNHZNcEZzbWNEWTF5?=
 =?utf-8?B?Z1lTTDJ5Tit5dGxoQjBHSnBJbyswRml0VGVVQjNjMEFBeFNNR01hTmJsMmZo?=
 =?utf-8?B?SjVBblN0U2tKejN5djQvQUJKRzlla1JKSjFpK002MHNnZXJtUHVqS1kwd0I2?=
 =?utf-8?B?Mk15UEZGWlc0WS9mSG5TSlVQNmJQZWpyd3N4VlBPTHNiU1pHMU5yZGxKZ2ZR?=
 =?utf-8?B?TU8vdWdSb0RpUzQ2M1JZL200RkVseGl1Q1BCMURrMUtWTmpZMnJSRkUzUCtk?=
 =?utf-8?B?TDZVaGQxSFk0TFdlSlhENURBbUdZSmRGUVk2NzVTWkM2aVRMMXI3Wkk4cGs1?=
 =?utf-8?B?a0Z0QUNsbVp2bXBZRm11eDgzSk1QWG5UbmxjdGdCU2dETm9sUzVteVRkSmVE?=
 =?utf-8?B?V1p3dHZVMmp1Q3hvWkczOWF1Vk1Fd2d3Unp4bEZXaGlkU2thWXZkWkJEOHJ4?=
 =?utf-8?B?Qy9ZUWRzNGdnblZlVmMydmFkdTVkOWtOVGVnbytVbVhoVEdzeGdYbHRYVWVm?=
 =?utf-8?B?WE5mRXhtWUJNeWhiT2l6cmlsNHh3Sk9xOTBxTUxQYjdpRVcvSFN0RHlpTU05?=
 =?utf-8?B?MEpjV3NSZzFiV05UUTQ5cGQwNS95QjBGZWpoNGJIWm5KNHRhZDduVnNJVzNC?=
 =?utf-8?B?VDVKejB3Z2lGV1RlUmEveEJOMk5NclZ1dVN3d1lkUFVlWWhpTFJuLzdFOTht?=
 =?utf-8?B?ZjJMOElOQ2poUXhjRHVxZFZsYjhkeVJ2K1FPYUpMMExGZThRWGV2QnY5cDd0?=
 =?utf-8?B?elh2NHpZUS80L1Azb3pHVXNMSnl3SUV0R0h6S2dNNEZ0bGtZZDFpU3ZuMU9r?=
 =?utf-8?B?NDNWSDJSVk9DV3hKQ2lzQjdxL2oxQ29WMS9zQ1g3NytrZjhLbmxGeWZQSDFz?=
 =?utf-8?B?QzlYZWhnMFZvSk9BanQ1eElNTlpBeFFSR3ljSm54REdrOG1LZ2d4WDhDSXVv?=
 =?utf-8?B?ZGlSSGhLSGNTMk01RThRZzgrOFgya0kzRy93ZlNmRW5mUFFqdVlLd1hnZ3l4?=
 =?utf-8?B?V0FYODU0ZUxVaS9IMy9BTUVwS3hVNFVLeGMrMlRxZUxHVkhyMis4bFVQbUxk?=
 =?utf-8?Q?pb68=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 04:26:53.6936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad98b36b-aebe-4b60-1a5b-08de2eff8643
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5594
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


On 11/29/2025 12:54 AM, Ernest Van Hoecke wrote:
> On Wed, Nov 26, 2025 at 06:34:15PM +0530, Kumar, Udit wrote:
>> Thanks Ernest for reviving this patch ,
>>
>> Changes in arch/arm/mach-k3/common.c seems good to me.
>>
>> but common/spl/spl.c can not pushed in generic way, I can think of few
>> platforms running SPL w/o caches on.
>>
> Hi Udit,
>
> Thanks for your prompt reply and input. I have now tested this patch but
> with the enable_caches in common/spl/spl.c dropped, and everything looks
> great to me. I will continue running the tests over the weekend, but can
> confirm that this change seems unnecessary to fix the issue we saw with
> sporadic boot failures.

Thanks again Ernest,

Ideally, I prefer to revert commit sha 52a86e69e20.

Adding more TI folks for any objection on reverting sha 52a86e69e20

>
> A v2 that only touches mach-k3/common.c would be suitable. If you
> prefer, I have a patch ready that we can send. I don't believe much

Unfortunately, only change in mach-k3/common.c will not be enough to fix 
the issue.

we need to clean-caches at board_init_r stage, and which is common code.


> functionality is lost by simply dropping the spl.c line, platforms can
> enable caches themselves as they want.
>
> Kind regards,
> Ernest
