Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262BDCCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 15:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 636BD83A32;
	Wed,  5 Nov 2025 16:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ArodLS3n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 679B683A5A; Wed,  5 Nov 2025 16:13:43 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BD5283A1B
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 16:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reatmon@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t46p55J9xTiTZq1QOGPzCiLqEQoW/wy9VZdwMOZZyE+OPVg+lWXKwdAiKbDjEA/FTfboEXErN4CNFcpE0bk3aiMGZWd2h9Dp5YgdL2bLicygeqwCaNly3ymf8tYy2Fgw86xUz2OgTzmvBvQSVjx60dA55mO7VdJRuepH0dOTtyS2nUaGs04O5Eb1dg/qxlY348O93B4dNZ4wzEC1Gq34eXiyfBoBpGpg3uD5uEXO/gK5ve7jsduy7Bb9IrbPSGboPe0fvcnKmb5WHkJptop3CE99g7o+b7FUqVTeIUSEH5TQaxIb6O1fsFR6R+GlptbNcGzbFtw4SjNX69gjduxj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp6garrov/JxUQaDSApTV8Ejl8MpWV89hMSMd4QEVl8=;
 b=kEevroM99SajkJ0Q1IkROKqWsUCHRdPNxxfTEIYaRwZqsJmUuy3wAEdz9E6DwlsW7Y2y/YGtq0NIB6YBA6D+kiTy8xqfecjrhEvEhQomRjtIE/OTQ167f2dhpeQhHKzfrUszp9ZkHDeAn1NpMX5/Yj1QhDN9dDlaDJDHeWrC0R958oySevB+F8qySj8vkKfhibLOk+1Sr0mHymUE9sv1ZlILVildAaECexVyPKHbAXBsAOIE0znCDkwOtnyJ8Oa9L0NYPqYJqRPKTSQrjxTC+BMz5Hgw0yzZZPDjUhLz1EqosOuNXEY6M3kxxnNrXZ18o7Y6YRfN9SA7YKJ9JOzkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=disroot.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp6garrov/JxUQaDSApTV8Ejl8MpWV89hMSMd4QEVl8=;
 b=ArodLS3nCbMp735Ww6a4g+Qjcq6Yok7KRxVcHGDyOA6q/zqm3x6mu1eEYmoGvz2jXNsMHoHHI7SDlO4gcxyRKOzegWigvGO6lsfqXatnASB3ya7qseTCcUuCHHUt9dM1T80YOMeIoqF14VwK3VvglOnl2FS4LsDPfifZTd1a3ZI=
Received: from BLAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:32b::26)
 by BLAPR10MB5026.namprd10.prod.outlook.com (2603:10b6:208:322::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 15:13:26 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::37) by BLAPR03CA0021.outlook.office365.com
 (2603:10b6:208:32b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 15:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:13:23 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 09:13:16 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 09:13:16 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 09:13:16 -0600
Received: from [10.249.37.202] ([10.249.37.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5FDFkC3854598;
 Wed, 5 Nov 2025 09:13:16 -0600
Message-ID: <c41d068b-0672-4125-90ff-d68471b4c379@ti.com>
Date: Wed, 5 Nov 2025 09:13:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kconfig: Add support for out-of-tree config fragment and
 defconfig
To: Tom Rini <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>
CC: <ilias.apalodimas@linaro.org>, <bb@ti.com>, <u-boot@lists.denx.de>,
 <u-kumar1@ti.com>, <gehariprasath@ti.com>, <ziyao@disroot.org>
References: <20251105102316.1713954-1-n-francis@ti.com>
 <20251105144205.GM6688@bill-the-cat>
Content-Language: en-US
From: Ryan Eatmon <reatmon@ti.com>
In-Reply-To: <20251105144205.GM6688@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|BLAPR10MB5026:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fef40c1-7845-4785-f64a-08de1c7ddd28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFBMbVd1NmJJYkRLbUxWNFV1dUZTWTlSY09neGoyajg3VitYbFYrSmx3VUs1?=
 =?utf-8?B?eTcxem1RU0ExSzh3TnhJU0ovUFVuSXk4OTB2U1dwUklhdnNlS0tWQXBDVXRW?=
 =?utf-8?B?MGpHZnlSOTE1eFREeFpFWCtVVU5OaThWYmZsU3pKbXVlQVU3dzNqUGJPc3U1?=
 =?utf-8?B?eTJSUGNhRDF1SVE2NTVSNU1WYmc1YW9vaktQUTVaTEpSOHdBOXozZVZOZWg2?=
 =?utf-8?B?TTNrZkc5NFQvZkJNTTl2RVQzMTBFRC9zRzZUUDkyWGtseDFDZEZoQWhhbm1R?=
 =?utf-8?B?N1d1Z2lvYXJwM1d3d1F2bU1qY2lhOHp4bWRqNzBZV1hDQU1xMnA0dTJ0YlVG?=
 =?utf-8?B?QWc3cGdWSlJWRkhJaXcyV2NWNW1DbDhOQVZVNlVxSk1IMmcrREZrRm1jYjNn?=
 =?utf-8?B?N2tyVmdLUVNZeC96MzMrMGlJSVRaNG1Tc2FyTVFTMiszcWZGNXVhVFVqdWlj?=
 =?utf-8?B?UzRXbjdrN1FHUG1NNk9xb0F0SnhCRWFWZ0dUYTd0Y3plQkpRYksxUVFzcnRG?=
 =?utf-8?B?Q0kwUzhWeGRtaHVUekZDdUxVb1NDcGU3c1ZZMk1kcnB4TkY2ZmlISWp4eWEv?=
 =?utf-8?B?MVFoOCtQVjAzZ0hMT2VSMkJIMm1CaDZtbWNTbE5YNjBZMkk1WU82NmRKaVM1?=
 =?utf-8?B?d21tcE9TcjU1Vmc3ZlJqVVZvQ3JEMHYyNTZCc1VmaTBPNTRMam1BaStQVWpn?=
 =?utf-8?B?eTdQS3lKdUtYaUhqd3NKU2U3OUVvVEZabDJreThhT01iTHROZDZXcThpZ25k?=
 =?utf-8?B?K1ZPUFFYR1FSd1FBaWU2VWxCYml6Znk3YWo1cVcyNHk2Y2NMNXo2eGJDVVNM?=
 =?utf-8?B?NmlmclVQbHRnOExWaHZzd0hqNVFDK3NKNXFDWllkay81SE5Gejd4MExWejQ5?=
 =?utf-8?B?N05vT25YR1Y3UEY0OWU4Y1B0S3J0b05lZkJRQWxZWlZTZmNITEdRRENmZGhZ?=
 =?utf-8?B?M1hKNFNDQktrcS9KOXRRK1h0RmoyVHFsV1N6MXg3eUY0VG9ERDdLVFBiS0th?=
 =?utf-8?B?ZzhnRlEyT3dDRjZqdTlnV3FybUF0dHAzZTNhSHB3NklpQTBhU0ZQY3Z2ZWVy?=
 =?utf-8?B?cUsrVGV1Z3EvK0Z5Y1JML2RBZXBIVUJBQkhPdEhtMmxaYnRyTlRnVm11MUFk?=
 =?utf-8?B?aE11dFpNbktiaUFyb3RWcjR0SWYvZGNGWnVjcVdUQzhndFF2QzdPMG5valNE?=
 =?utf-8?B?Yks1c2tSL3lWazZpMEhnaXo5Z2p5VWZXVlo4aDJ4UFJaNmlyeXkyY0NmU3cv?=
 =?utf-8?B?OGFKQjBiNkRYYWdMcTlOUkdOT1hYaEFxVGdUMU00bm5TbGJQbVE4elNkVHgv?=
 =?utf-8?B?NThSaEN1NTd4OVJmeXRPV3o3N3dWbUZ3bTgxTXdRZjA2THVqY1J5TUZOQ2FM?=
 =?utf-8?B?aEVLY2lZdkdLcW9POFVGWVJHUGJmTTQwR2RjLzR2N041MUR2RHNCYTJSTlJx?=
 =?utf-8?B?djkyL0lKeVFTbFJnKytWYUtURExSRU5jZGQ3TmoyT3pWLzFESVp4eTlNanF2?=
 =?utf-8?B?K3c2blhNVUREc29pVTVvUndGZ0JpbnRZUkFzY29PV3p0VU9ZcFhiWHdwTDVV?=
 =?utf-8?B?ei9wdXdXZFppZzd4RC8vWW1SQ08xbXJTMDI3eFM0d3VhQkZQL0VPRzd2cncz?=
 =?utf-8?B?OC9udm9CRC9LSS9GTkh1TnJGNHNNZmpXVWY3UXUwS3ptWGV5alZJM3hNaTkz?=
 =?utf-8?B?MzhqbVpKK0JGTjhlVzdTbnZTdTVtYmsxUlI3OVhsajdkeHc4b1daaXNQUjhM?=
 =?utf-8?B?aWFnSWMzSGFJYUZjSkNLNUVJMTB4aDQ1cmFEWFNWQ0w3NnJ1dG54MHR3dmV0?=
 =?utf-8?B?MWNMeXNzZGtWRmF3c09WL3pPcE03cUhXRDRTdUV0NTVUS01hTzlRUlQzYTVm?=
 =?utf-8?B?WDREbDBBeG95VUhlK2luMVlhVFl4MUtMZlVnWDM4MDN1akN0c1k1LzdMUENa?=
 =?utf-8?B?dGtVMlYxT0hsT3hiTGVIZjVMaC9uVCtGN0dMRExlZ3dFN0V1akp0UE1uOTNE?=
 =?utf-8?B?Yyt3UkpYVmtNUWFIb056UHRzdlJENkZUWnNEWm16aW1VeE92eW9NSC9semU2?=
 =?utf-8?B?NU0rZmREbCtWZDRRc3ZodHpmK1BYK1Z4VUg2YXQxUkZwRFgzcVVwemZ1S2tu?=
 =?utf-8?Q?CIk8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:13:23.8969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fef40c1-7845-4785-f64a-08de1c7ddd28
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5026
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



On 11/5/2025 8:42 AM, Tom Rini wrote:
> On Wed, Nov 05, 2025 at 03:53:16PM +0530, Neha Malcom Francis wrote:
> 
>> Add support for fetching config fragments and defconfigs out-of-tree using
>> CONFIG_FRAGMENT_PATH and CONFIG_DEFCONFIG_PATH respectively.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   scripts/kconfig/Makefile | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> Isn't this what scripts/kconfig/merge_config.sh is for? No, you can't
> just do "make foo_defconfig bar.config" directly, but your tooling that
> knows about outside fragments can merge foo_defconfig with
> /somewhere/bar.config directly.

The problem is the Yocto recipes.  There is a somewhat fixed manner in 
which the recipe is setup and optionally adding steps is way more 
invasive than just adding an option to the make command.


-- 
Ryan Eatmon                reatmon@ti.com
-----------------------------------------
Texas Instruments, Inc.  -  LCPD  -  MGTS
