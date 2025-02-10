Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E75C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 12:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30FE7805C2;
	Mon, 10 Feb 2025 13:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1fsoQc/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF4E6807D6; Mon, 10 Feb 2025 13:40:47 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EAE38043C
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 13:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xa7UFKG4BW/UwqkysoyXR4rE50YR1NxlkMpCjZf9nRQBjsRgicJirEww3g3CPc6Er+NUDbZiq+szbZ6KeDsU335lb3E9kA5hLQJbUe+qqezU3imi97uAgkO7rpuQHe7oMvVrulclDeFfrS+InO7yOBhe25/tIIarocXejF5x2RIJ0co/7hd2gq5J0J2NG1l7upj7f1w+Oy3GmIBpMV8eWXjZjC3mW1sxX2rke8xYjHqOhNprQ6sjeRuu9CnX//kAz57aiIcHUvbJc7Vb/r4uM+R2/oBR3Q3JBJ+NkG6Ll7h1ZNXT8cJLl59qw70lK7Yj89MXJhAIJ0TpGzf9i2OcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/UIWeeUfBzveK0lKx6Igv/Vx2NilZ/O244Us5yWgIc=;
 b=WE73pDuzyaHqPevBJdnEPsKp7BF2X+AyoXu2HVWmiT2q4K5PvdgayGazqIrqymK/CbCoHC/UXHDQhNFYfBmNdRqx3mag5+4T06LNC6PvfT1WagEDrDLAQPUYWfsoimkJRwyMvLY9mOB7tWBn6x5tD8qX/dq4sYWMbueXeErIZ8LXVJLxaJIyJZlSQRI7dIUSgB9b3aclp9g34IyNpTQJRZtzxzhCyCNuOPK0UUqYCnWi9qMH4G0bDvjzZx5EM+f46GkT4Jtay20CoOFByr+8g9suCjB4eiF+g4RpudmbXbE1j5tIdo5mrSIc8OWZYaQH8QsomHoMq+1xBLb7OQbYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/UIWeeUfBzveK0lKx6Igv/Vx2NilZ/O244Us5yWgIc=;
 b=1fsoQc/3zGDmdcYwM2XhgqYOSRnVQdoHaUDVKZ+dEGnv8WuDNfjaarw2mue7aPHlpXv2CtsXXINUnsu6PxSBWd75NkMUPPqxgDB/B7/yUMf9YLRFl4yyDDQlD9wGty5ScbvDoT0teucsmL1WoMzbCIrgKYz7H8zIvw3a1ggJHVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 12:40:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 12:40:42 +0000
Message-ID: <7eec57ad-a50a-456c-ab6f-fa2c349b524b@amd.com>
Date: Mon, 10 Feb 2025 13:40:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] efi_firmware: set EFI capsule dfu_alt_info env
 explicitly
To: Jonathan Humphreys <j-humphreys@ti.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Udit Kumar <u-kumar1@ti.com>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Daniel Schultz <d.schultz@phytec.de>, Viacheslav Bocharov <adeep@lexina.in>,
 Neil Armstrong <neil.armstrong@linaro.org>, Aashvij Shenai
 <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Tom Rini <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com
Cc: u-boot@lists.denx.de
References: <20250206154719.3032322-1-j-humphreys@ti.com>
 <20250206154719.3032322-2-j-humphreys@ti.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250206154719.3032322-2-j-humphreys@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: cb20c36f-9a1b-49e0-db9f-08dd49d02185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rk9CQ0R1L1hjMFJuVmFQWHY0VjJhYkx3TmhHSjZjU1VVWkNxR09OVjZJNlRa?=
 =?utf-8?B?UmtvWDRKTms3QU1mUGdiUlpCbDJKNGhFUkpqZElWQnhiZ1VYazZUNmFsdlcy?=
 =?utf-8?B?UlFlVDZJSlpQTmRRb21GUmR3cUxBT2dzMk5sZDl2MkFSb2lsZFhXb0FZQldi?=
 =?utf-8?B?WklJbkE3Y1BGc1RFdll5Q3Z3UnZMMWpNL2NMZTZwOHp1NGxOUGtOSXAyVWlu?=
 =?utf-8?B?eVJ2YnQxcnFxVlNzU3hxR1VzdjAxWno5d3piTjdpcUFPUmhmQVloSlI4YTQ5?=
 =?utf-8?B?TmZhNXJITngvZTE2TEFsUC9oTDlwVUYyMDFnb1g2bzNwUzNXd01DdWJxeWRP?=
 =?utf-8?B?cXBNU1J0T2hmbFBIUkphMzRiSjB1RTFBNm9acXNkanYyVG53L3RVeEFoTlVP?=
 =?utf-8?B?eWRQdUFuYVcxMGt1ZDNwYjBBVGtuZTdLN1dDL1p1WDJreEkxNG5HbURJKzVV?=
 =?utf-8?B?VXY4L3AwUEVKZEM3a2lPczg5ZW16KzVteUlGNW9VOG9ySGc5NVkrMjBiMkt5?=
 =?utf-8?B?SmtLSG5qRjM2L0ZtYnBDL0hJc2NlSFMxc1BUNWVsUE1jRWVmTWdHaVhJbHky?=
 =?utf-8?B?SGNPdFJqMXJJTXJGUFJDUzlRYi9qQUU5cVFnTHlxL2I1VElTVXBYNzJQRzBI?=
 =?utf-8?B?ZFRnVS9RWFpWN3VwNzBKcnZ6UTZITWpPOGdJMFl0d3psa1hIOVlSMkJROG41?=
 =?utf-8?B?UWpTM0xvMmhjcVJXMFJDTXJBQVVkR09wZGZCT3JJTDRYbWFJMDVmdktDWHpQ?=
 =?utf-8?B?dnR5VVBkZHVrQ0tqY21wK3ovMG9hMDZwbU1Uc29aMm9ndktBbFR2K3ZaVEQz?=
 =?utf-8?B?bFBZQlVDd25SalljV0N4N0hJRUdJc0puWjBhNGdFdjhIM3VmT0tlNlJoOWNj?=
 =?utf-8?B?SXMyZXFWSDdmOEZkZGFrSlcxV0R5UW52ZkZqcE9IUTI4TjB5a3NQNUZ2N09J?=
 =?utf-8?B?dDNveVI1SXNZRDFRa0M5UTdMQUJ6Q1dVR1lhYWREVEozQlVEcVVORnNuSi9E?=
 =?utf-8?B?R3I1VlZDdktyU25PVkZhQTJlK01hRDNBVmVRVzBONmZtSndjL1lPY0MwQXZG?=
 =?utf-8?B?OVJkRnN2QUhjMWN1VHZmbXloRjhWZDBncUQwSFRncElqVTJLeXhTdjBjRmVT?=
 =?utf-8?B?dzBGY1kvLzhZcFVvZ1VaYjlWMnFBTkRNZnJza0NPK0ZCVms0ZkJaRmFzeE9G?=
 =?utf-8?B?U0NnL1VubldLeHVycUtxVFJvMlNmdlRPWU9wQWtGUEtyc2ZDNEFOb0hlZFJj?=
 =?utf-8?B?ZEtITmt2YmMwd3hrRktJSXFIZnJ1SFZjbmM2OTMydDcrY0Nvd0o5UzZsM3NO?=
 =?utf-8?B?cUtFcEtBbGdHVjZuSzNzdi9PUXJ2SWhXWEJjb2NZMkZlWmpQcjBUU2hnRXNI?=
 =?utf-8?B?dDFOWEVXeU1mK1YyS3FMYlFkdUdjckRnUEl0YlkwREhwUElMeGI0a2Z6UklV?=
 =?utf-8?B?NzBZYzJhdzZxTnBZL1c3bGlhbnV1WFdRRWRwcnhDWUwzMy96dmZRcEduZ0py?=
 =?utf-8?B?aGNDSW9JVFY5eU84VncxR0prc1lqTmd2Y3dPOHFpcVFjemF2ejhEUE9lMFE4?=
 =?utf-8?B?UlVRVTRERjVBQWFNWnNiUXNzNnE0VEJQZlFoMldGQVkrYWJXajF3akM4a1VD?=
 =?utf-8?B?YzFzVVJiRDVXOUxGdVNLeVgrNnRtMzZuREFyc0ZXMVc2dldBS1Z2YXBEQW9i?=
 =?utf-8?B?MmFOT1YxOWZXbE9vazVvWDY1RHRLK201SFNIZFdiNHJ1TVowNkl4S2lpaS9R?=
 =?utf-8?B?UGRycDIyZ25DZzFLcVArYTJZQ2xQT3VFTjNDbDVCTklpL0VIUE5EejNhQXRs?=
 =?utf-8?B?OG55WHF1cWZpZVVXRDJJTWJ5bDhUaVljMGFvbjB6WGJyc1h0elhqWTFUTEEr?=
 =?utf-8?B?U0k1enc5RGd2ZzdtOEtUSTJRNWpIMGRUVkMvWjhwTStWbmZHS0pMbXZjSXpL?=
 =?utf-8?Q?DnPnZwUCs+g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djNTZXc5NUVjUE5nWTJyUm5pcWUzRS9LOHFXUWpaOTdndWkvd3BJYzZEUEky?=
 =?utf-8?B?amVaZVRkV3J2RkRhRlN5bmNJNU1UbER3RkpLSW9ia1hqN2hDQ25vNkt6U2Ns?=
 =?utf-8?B?ZkZvdCtsZlZnSTdSWFpZODlBNjJKaDI3d2VtOXk1NHFyZGR6cm9aNStnZXVN?=
 =?utf-8?B?QWUyMEdPMHVrZWtwaWduSlNUUG0waW01TzkxQlQxVnB2V2hxbEdjeGZ0dWNl?=
 =?utf-8?B?QVFISUNYbmhiM08zSGd1bkNsMnJTVmIvaVBITmQ4RmtwK2UxV3lHd0xXWi9u?=
 =?utf-8?B?VzlHeDR5cnhyaG9haGJrYXlzeWxOTGxtYUxFUXg5M2N1bmMySjkzVDUrQW9s?=
 =?utf-8?B?MFhnL1VoODl4R1VVYWdDS3NUS3paTVJ3Rk5zdnAyaEEyR2Y1UDJFR2IvV3Ba?=
 =?utf-8?B?V2wrMEF5UytJaUpiNGNvUy9PNHIyMzdSUWlIdzhlZnNwaTUrTVBoM01Dcmdj?=
 =?utf-8?B?RU9EcHBjdkRvbTNwb21BK29kOFBGNG5PMSt5Rm1mZTg5QWUrUWx0WkpCclla?=
 =?utf-8?B?WHVFb2hUUkR3RjhEUlcrb001dnNUaXlTZ1JHbzE5bG9hWVZTWEFGNjYyaS9Q?=
 =?utf-8?B?bTJBNUpmdlVJWlZ4N3c0WVhKdFRYcnNiL2RRckJRdGlUSzFOWCtLOGV4ZklZ?=
 =?utf-8?B?QXRmNGpDajZ2QldhZzNjWGNMREtwZWI0SjdxRngrUGUrY3R3WkpRV3NWSW5S?=
 =?utf-8?B?N1dUMTI0OGR0VUhET3EvWU9JRmVlR0hnVGhoL3lmZmxFOG5ZNU9Wc1ZmUU01?=
 =?utf-8?B?dDE4SkdhTUV2VzVZeXdwbDFNUnl2cU9pRGp4azczc09FZ0c4VU4rQTZiTUJZ?=
 =?utf-8?B?d2F0a2hNYjllTDBhTEdCNkRzK3RMeGVrKzcrR1dlN0hGcVN6UUFhejl4VFpH?=
 =?utf-8?B?TDFXVUhtWGo5RzlHNjJOY05Xc01sVnJWbzU5bVIxWkdxeHpyaUd5ZFBwdHFy?=
 =?utf-8?B?RmVEd1V3QlFETzZzRGhsYkVPMzhrZWNvZmtNaUVDTG9HUExmQjd1ZllINW1l?=
 =?utf-8?B?T0lZR2U3UmQwNEFaOWE5bTdTcll2eFVjM2xuWTFrNGJZbE5zTTlCSFZZV1Np?=
 =?utf-8?B?Z3RsbVBSa1ZIY3VacnI3WThkcm11ZDE0UDJLSGx6M2pOTmozTC8yV2xkVzNO?=
 =?utf-8?B?dVJBU3R2WjF5U081ZmlmU2MyN1FyZUh1WFJjUTBEOElQbW9TQ2xmZXRZQXlI?=
 =?utf-8?B?Q2RIUGNNb05kUzBkTXJBZmlWTVlDdVZVNjJGUmxVMXBVSXZTRG00TnpIYjdS?=
 =?utf-8?B?elUwbkpLczl0dVBYRU5oMDFvV254bnY1dTBncHZRZlRUVkpoNmNUYkN1ekFs?=
 =?utf-8?B?d0FQY1ViK2ZBYlgwR0hqeEY2bk13RFM5WU5Vc2w4TmF6dm5pRmF0Z1ZyajZz?=
 =?utf-8?B?TEVZcndoYzR0a1JtTXgwamIvS21SWjlsWkFTK0RGallsYkxuNUtwSGtqSEhq?=
 =?utf-8?B?c0hjM2ZQdjZRSXczaWtyR1JUTHNlQ0pRTzZ3bktsOExkZkQvb3NjMm1Ldk1j?=
 =?utf-8?B?VHNiZEk1RnRLL1hrV1RqcjVLeWJTQmVLYjBBWjdRbXNmWTFVNTFtNkppMlhR?=
 =?utf-8?B?TGhNWjUzbDNxRXZSWG1WSWl1RzV3THRmQ2wvNGxoWVZsQTM4TFhkRnJlNGZT?=
 =?utf-8?B?VEpJbVBOeVl5Sm9Ib2U0VkxCNllhVkxjbmkwc1B2emdXc2JTQ2FNRzNoSERp?=
 =?utf-8?B?MmVUaUVyOVl3bTM5dUpqcGsvUDZ1cWNVZVRVVW1JWGxqd054RysyVmlkR1Qy?=
 =?utf-8?B?NVRJMkFrZXhLNXRZNG9uMnZEemZVMzBpSk5MMDh0dTIwalNBZCtUYWpBUENu?=
 =?utf-8?B?a3FyeXFvQUdVVG92WDV1VDFtWTFaOWFNSmlKYjd1QWVtOEZIRUtqMWhnQ0Y0?=
 =?utf-8?B?NG1PRW8zRUgvSGI2Qmkvd282dWVkWDc4U3JBRWpPRjkzS2FnZmhoZU4vUkZp?=
 =?utf-8?B?RWtoY0UzSU9yOFF5V2U5Q3QwWnllTEp2S1Z1MGF5VGZpeDloUGhWWldQbi9C?=
 =?utf-8?B?L241anVRdVF0MWJscFdIYzdjUXVWa2V0c1VaYUR3RE1rWWlYeHVvbThlZk5I?=
 =?utf-8?B?aFU1NnJJVDAweWcxellxcCt0TEd5R3FNQmYzWXRLTkNEQ1pUYnBGdmtMRGM2?=
 =?utf-8?Q?an7WTzoW4mbmmff+k0MUUg0Qh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb20c36f-9a1b-49e0-db9f-08dd49d02185
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 12:40:42.4003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /woKnrH8TNlAmsdrB6Ep+6+/Hu0YzitMd8DRMEibfsKJMr3FS4WjqPDO0J6yYnJb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
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



On 2/6/25 16:47, Jonathan Humphreys wrote:
> The current implementation of EFI capsule update uses set_dfu_alt_info() to
> set the dfu_alt_info environment variable with the settings it requires.
> However, set_dfu_alt_info() is doing this for all DFU operations, even
> those unrelated to capsule update.
> 
> Thus other uses of DFU, such as DFU boot which sets its own value for the
> dfu_alt_info environment variable, will have that setting overwritten with
> the capsule update setting. Similarly, any user defined value for the
> dfu_alt_info environment variable would get overwritten when any DFU
> operation was performed, including simply performing a "dfu 0 list"
> command.
> 
> The solution is stop using the set_dfu_alt_info() mechanism to set the
> dfu_alt_info environment variable and instead explicitly set it to the
> capsule update's setting just before performing the capsule update's DFU
> operation, and then restore the environment variable back to its original
> value.
> 
> This patch implements the explicit setting and restoring of the
> dfu_alt_info environment variable as part of the EFI capsule update
> operation.
> 
> The fix is fully implemented in a subsequent patch that removes the capsule
> update dfu_alt_info support in set_dfu_alt_info().
> 
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>   lib/efi_loader/efi_firmware.c | 39 ++++++++++++++++++++++++++++++++---
>   1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 5a754c9cd03..1a1cf3b55e1 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -649,8 +649,10 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>   	efi_status_t (*progress)(efi_uintn_t completion),
>   	u16 **abort_reason)
>   {
> +	int ret;
>   	efi_status_t status;
>   	struct fmp_state state = { 0 };
> +	char *orig_dfu_env;
>   
>   	EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
>   		  image_size, vendor_code, progress, abort_reason);
> @@ -663,7 +665,22 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>   	if (status != EFI_SUCCESS)
>   		return EFI_EXIT(status);
>   
> -	if (fit_update(image))
> +	orig_dfu_env = strdup(env_get("dfu_alt_info"));
> +	if (env_set("dfu_alt_info", update_info.dfu_string)) {

This pretty much breaks all xilinx platforms because we actually are not 
configuring dfu_string.

I have sent RFC. If you can squash it to your patch that would be the best.
Pretty much the part of it should be in 1/2 and the part in 2/2.

M


