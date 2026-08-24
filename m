Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B8AC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 11:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57CE380D3F;
	Mon, 24 Aug 2026 11:16:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F4eKNdSRLcBk; Mon, 24 Aug 2026 11:16:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787570193;
	bh=ehcz9Es0WiHcThVLzfujBLyRdBtVqGvKCYFm0ceJFgM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HUeV6d+zn7ErETzAdrv0hVh/iktG8Kj+GLCvPgN/XlEnpXg5CFhmLT0p0j+1+KpDt
	 48zi5oxwJLZYLPUfkKrYnYf6jkprlm0aY09WmnXAnHuvD55MT06kqpmrEnhYLFYm5A
	 cRefux+ZSDKodnOZVAi+AX4zNthshf/NRpkX0t5qF6KkMP5aBj4pmyvDvKcb1Cmukd
	 obATj8tneFOugDwIy/Ha/22tgFKsbaDRsfS0x8+JCDH0B/harCWVdO6JSDzDfTOIVE
	 ERlDGzwVwL2xfolD3bjE6EebKZIhxDUynFPmxqy8gb8SFybw/pmhxAz7dlNJevGe/1
	 D3csC+UBqVKew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A14680BBC;
	Mon, 24 Aug 2026 11:16:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EB0693DA
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCED16068B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:16:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AcpTtGJmvA4P for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 11:16:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=38GPSvRW
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F07E60608
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LP6PRdO71RU5K7a6XhmK4YWPWLF6JSTPKWVOtTcBT2xL/H5A1qxtGF5Pb9Uv7vIiqQ1FzSdU9zletj5YzruTl/L/WlpGki1yIAeuD4UX2Cjh9cefIaGEdkfpXxD21BonuJ4EXJOwMAk9l8n5wHqvEjwpZ9eQaYoTqJtCHMcx3Pn2CrSJ6qxcyimhU/JL3F0p5GuR/JdzcMB0L8DQvzhg57kPG0CKP/GpVv3599gL5GXHqDS2uSV3z/jIZUBMn+XWk2d1NJgugjI3YEBsbgRdI78380kxV/RFtY8ORqhpw9TzTczUc+AJNH5ihHtJ7ahGfhFJrpZy0rNBsWyaJ2t4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehcz9Es0WiHcThVLzfujBLyRdBtVqGvKCYFm0ceJFgM=;
 b=RLitF0f4BiNZ9xj3hb9Miwj+LSzEwwo16tWwZSevrTprHitiZEVkGPe4Nf5SoQap4IzLaD/0LZfaGl4mT2jjKAG5ybB0pP0ZhT3vn/aMMyBaVk9ycZnHrST/zPJ0kDNMqMjRD8A7MXrVzxQ1C9D6pKSPBgX7xlj+PRikOMvy1ukhdxb/VktlIW4mDx6kkOO5OTJjiLAsQccwIDF/w0UPgAtlya8nADdbiaCroK2QDFmagaAa2yvwJCHEvq3nqnigeHFipJLTlIEXQRvBhmeDQUtLdoFsDA8FIr9SGiGsLD+m/iyihnBMaeuEzlXS9eBdOyhrWTfZ/ZAl3EkWcWj24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehcz9Es0WiHcThVLzfujBLyRdBtVqGvKCYFm0ceJFgM=;
 b=38GPSvRW9eiNirkKg2o3PwHcK8wMWQ2Y23dS4R9HaVi2FVEe6c1cHkpB14nFws4X3bcppmhdUG2szAsod718R+eMv7HnSs05yVlRxCEWcLRag4k0yUqw6GKpCjG/ilRYzucxlpV7BX8zjyJpZpGANuyf6WYBrpRz5sDFt69B7Sk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 11:16:23 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 11:16:22 +0000
Message-ID: <14ce91df-4a4a-4b29-977e-d8a5837e8242@amd.com>
Date: Mon, 24 Aug 2026 13:16:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Clean up emails from non-existing domains
To: Angelo Dureghello <angelo@kernel-space.org>,
 u-boot@lists.u-boot-project.org, git@amd.com
Cc: Andre Przywara <andre.przywara@arm.com>,
 Aristo Chen <aristo.chen@canonical.com>, Daniel Golle
 <daniel@makrotopia.org>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 "moderated list:ARM STM STM32MP" <uboot-stm32@st-md-mailman.stormreply.com>
References: <08f68cd8c514140071090a846839632f8cae071c.1787560364.git.michal.simek@amd.com>
 <1b9532296bffb1918b90cfe61fb7692ea355d02f.1787560364.git.michal.simek@amd.com>
 <f7c4c39c-f45b-4a02-922f-4d1474c14cc2@kernel-space.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <f7c4c39c-f45b-4a02-922f-4d1474c14cc2@kernel-space.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0097.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::11) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 299f1b4b-fa93-44f4-4d28-08df01d120bd
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ET7HCgDALvTtcnrh3KRiJVPGgQqaKx+RRtXAiPk1NUV9kjH8GXZT1/tMnXgGkOaFco9Hrjsrqd4UXn0yFVyTxNsoV4N8uLSdaCJCSUZZQccvjTF08PwiKKxbyiH2+/z+9g6KXiG8WCL9DoDmo3qkt7unyYNf4HZl2LTo9GY8ZJym0trQGYPRujq3AXOL96q7wLI3spcQZnbsCubl1J80tJn6V4MboA3wPg1qKIOGBbr+hhyaWLFcickcIAoxlG4rVDTFYIYTJRy5GoLPtXuo/93APrcl5HAyPTBaoXYIyCYXep9LNEvNuS4Qf2RulbHq9vfW5lDL+mIsoo0t/K7BNOZ2uyZr2oO9XjuerFuUY/WR04HxCRl0VAek6REIDS1x+GIqLIb9jTOd2AI6lGSkwGKQn3n2TOFhIcpEBimBV+39RBjiBRwge5cmaP/7UiVvoBgfOmrVfZ92/jHL5g0EoUa8y/FOHUoXFbvNLPSRqD2IwIhZJKSklb5nZ9wFaewXf2dPU9APnCG88BMD9uqfd1JBeWIVDu7o0A6kd5q0SysbDvIu66V49BsTBdr6h+SmUUn2PcCiyGt9XINpGl5CdR4IaqU9a3tX/swAuL7CvYxcwkF/lxbnzw1zIDuSAreUQoy2Yze2hiHZEhnrfbIVOmIkvNGInlK3Uw5sH/EI0LM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWVmWmJxWFNPZEZoVG84OWtTODcrc3dtQ05NODArL0IwZUFOQSt3RWJPekFy?=
 =?utf-8?B?OFFBUVV0eVE3QXJ0YytMWUFKYnVFbUJjVXUyL1JORnNjMEVkZnFjcXhaY1k0?=
 =?utf-8?B?RjNRWFNpUnRsM3djM0lxb1hQc0FtRDI3Y0dpVDZuSkZsSnFKUXo4emtyVWU5?=
 =?utf-8?B?MG5PZWxiUDJ6QzdVNXNESDBWS3Q1REY1VUg2OVV6UGtFdXBibmw1Wnc0MXpq?=
 =?utf-8?B?ekhFRGRFWE1Ec01EZ0gxODhWeWNJSnQydXM1RW41ZFMwMUZFMFpGNDgzcVNX?=
 =?utf-8?B?L2ZsVFBSSzdTMS91S24yYi82cVhoNXVDUEJvbHhtck1GbnM2L0Zhb09nSHEx?=
 =?utf-8?B?elVLMUZXTXpza2JMUERhSmduNmdxVThjV085QmlVQ1hnTHBmVXBYOWsxeDN3?=
 =?utf-8?B?WlJyNGNTSU14S2NxY0ZGUmtoekVPU3I1UVFSNmVmbTVSZmJxVWxRQ0EycVVL?=
 =?utf-8?B?N3lITGcyMnYwSjhkcm1VaWhuQnh3dGsvMU5tVFN3WWJtSDVyQysyMUkxRVBw?=
 =?utf-8?B?a3RYcy9pa0YwY0pPcGFjWitYU3ZRekQ3dzdTMG5nalJKOGcwaFBoU1V5dHUw?=
 =?utf-8?B?Z29hbXhFOVl3OE9VNzNLTGRqcXV2djErS0JhYnJNdmRZUnZqV29zb2ZweHFy?=
 =?utf-8?B?MWdzbjR2dHFpL05NVE1vS3dkb0VMNnNuLzROWWgrL245NGxuR0QrMTJDdk8r?=
 =?utf-8?B?WGNtSnJGNHR2WkZDcFQrZnRaVHZXY0hsRE1qc2ZRSUUveWRFb0N5TlJHNURO?=
 =?utf-8?B?amlGdXh1NGNHcmxqSWVxbTVHb3Q4WGp5Nkl4Uy9xSXZKNDBkK0FuNUJGbmJz?=
 =?utf-8?B?Q05oWkZ5WG9JY0VuMS82bng1K3ZwTi9mS2Z6ZHFOZ2dFb2d1VW0wRENhdTRG?=
 =?utf-8?B?UFQxeHRmNTFxdXhtd1g3a2ovb2RVbCtYN3hmMlptU0d0L2dhYjY4cWVKVVE3?=
 =?utf-8?B?UjRheUdyQjdNNW96bTlHU1BxOFpGckIvQm4zS1FuUGtHb0NxVEtLbEttUENM?=
 =?utf-8?B?UTEyY1JyK3VITy9FSXFQOXczdHlHRzRPaU5hVjdzL2NXNExjZmdiSExFVlBE?=
 =?utf-8?B?VFpVWDZCR3ZsRFBqYTdJYU13NFJsR0FvdThjLzJNM2VXYW9OYWpacFFCT3Qr?=
 =?utf-8?B?anhoSDFKdXk4M3g2eE9kZ3pidlNoaVo1SWlwa0NlZExyWGdPQjR2Y0lmTGV5?=
 =?utf-8?B?NWJJU3R5VGUyYWpKUktXc1dmZHVUSnBGVkxiam1vTXk5eVVSeTFOZndzRVpo?=
 =?utf-8?B?WjhpNkJZclNiVXNJMTZYdStiWXMvMkF3dmF0YWl1dTFCNnI4QVlWbDVXbXpM?=
 =?utf-8?B?Qjd6TG1rb3RsNFBJa0FadFo0MVZ6R0tUVEJqSldLT29Pc1U3SlBhME01bnZT?=
 =?utf-8?B?Wmtra09QbHRGaVVaZzc4MFVabHlVd3BDL2V5TEU0NzFGMkhJT2thVzZhMUI0?=
 =?utf-8?B?SUtMU21JWGJJMWV5L2hpTFEzNTQyTng1N2t2dXVnSlN1SlA3RGMyaUlMdnY1?=
 =?utf-8?B?Nmk2c3lWb1REVThJVlhZZWp1aThLNllCVklQb2VDcE9UY3A5Z2l4M1ZrT3Bu?=
 =?utf-8?B?WmF5dVJYRUJVUjVuR0g2K01sYlFXMkZ4NVkya1o0OW1pc1daQUdFQmVUamFG?=
 =?utf-8?B?Uk44b3RzVlNHbm96emlyUjAyc05ZeFE4S2lnQVBlcDhrUHlWSEpmN3hSb29I?=
 =?utf-8?B?WDE5OWVWQzdYUTY1a1lDTGcrUGFJeVBkQkRuQmg5NjVGdG1qVjBMS2NUTWhX?=
 =?utf-8?B?SDNVZ0Z0VGxDN1NhZ2d3N3M2TGZMYUFEK3o0RkJRSmhLVjdoMEkwWGZDRUtm?=
 =?utf-8?B?dzE0ay9mNkpZVlR4dmd4UDRIa2h1NDIwckUwNGlIclgrL2kyb2hFTlo5RTB0?=
 =?utf-8?B?bjUxSWVaVmpUMVlvbkVEcDhjQW9zc2Z4RXFVYUx4dTNXV2FEWGV2cXVLVHZu?=
 =?utf-8?B?dE11Z1hRb0txTHQzMDFZSzM0YWZDaVcwdTR6aGppODZBdkVTbXRQQjVtU0Z6?=
 =?utf-8?B?NDlTY2hETTFuNitKUExZL1NEVW9uMG0vdk95QUczU2hTc1d5eTlGVGxEK3lU?=
 =?utf-8?B?cHZMNjFNNElQcFhNa0JvVlIxT1o3bzdqMTQ5cmdvSDJIMytTYndiL0ZjeXNm?=
 =?utf-8?B?R2pGT3ppb0NuR1UwNEh2bHpycjhrVU1rbkl0VlJFSjk0NncwSWRXZm55OGh2?=
 =?utf-8?B?eHNRaTkxTER6UEhIemNDN2RZZ3F4YWl1akhiVW5rT2ZZbklqMS9iM1ZWcDJC?=
 =?utf-8?B?M2NESDBGZUVhd28xcE9TN05CNGhhcnlhbzJHc0sxQ0ZPUWV1Tk1PN09tY3FK?=
 =?utf-8?B?bDZQRnNza0NDWTBMWXpkWTVzZWV3Z253UnQvY0FiSWJnZUZqaElqQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299f1b4b-fa93-44f4-4d28-08df01d120bd
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 11:16:22.0554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ECRbNkJfSHxgfRa4DP+pYZZ1SiH0EyyG68C5gmKq7yFDMl34twg9UYpzHU3PKOf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 8/24/26 13:10, Angelo Dureghello wrote:
> Hi Michal,
> 
> thanks a lot, i should do it for m68k.
> 
> Acked-by: Angelo Dureghello <angelo@kernel-space.org>

Good that you acked it but don't you want just fix your email address?
Or all of that files/boards are obsolete and pretty much should be removed?

Thanks,
Michal
