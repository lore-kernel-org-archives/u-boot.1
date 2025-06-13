Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E17C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 13:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36D2982CA0;
	Fri, 13 Jun 2025 15:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D8IOdxB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D7EC82CA8; Fri, 13 Jun 2025 15:11:24 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDE4382C30
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLRD5zU+gmsjay9QEDxoP3tO3q7dF1qDD7n6yW4FxztCv6lkj7DtWYkOzWMfi7dxfZ/me/c5N6BSrKzXs2TCJEDV/sNe3K/yBVO8RZ5ImVudNWqM7ULuC+XVtTUMF6lX/ZYN3s8q+F/NUwHfl7vkvF7JIaKcADNZrp/orpnoMXrQEpovfofw7vU1Gyp5wV5iuo5tj0j7CqLqhJaFo1rEb3shl8bsg6m0LOOtXrvK6X6qUasc/0EIXhbL6UDFhVQr9eTO6O/qOSzcazUHUyvnPLH4W+yJaKliuNYXj9S8edTJa+VEg+/mMOztQ60f+M8QMqXouDo+o+1JC6OOxRbyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MqMPG3GpRrd0S3SapZo3lJ95dVwp1tO6vtflg9ZkJ0=;
 b=j0N/H3wR0oba7P2TjgDM0dU32Iepy7Bh0s5GfXYl77fMjTy7Qy+QfKQb/tfA2sVF+WmDZx43DWxAMWWsfRTnJYMvhw7SA5+DAgRB0B8VQcKnyGDR/a8acD5xjpP1RX6KBzNM6vcM2vhNyNPSeE7o57C58qb+4IuoNsk21nLEOehY2Jvai1FZH0nLpaJ+f12PTTc2MCPF5ILN2CYg7LjvFOHkii+lkawUfbGunvRbQEL3066CX1kx7/dgY+45MQWZBTV2xb9DMY2uUSOlrRjp4+fnzbJxSG/cTIljZWwJ9g45S8/+FIusqfc/bbxhch9EFnDeH4YYKwQDVfz41WZDLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MqMPG3GpRrd0S3SapZo3lJ95dVwp1tO6vtflg9ZkJ0=;
 b=D8IOdxB4W0bfCJENfumwvSLj7mTLiDlRVv4mn7dym44AEVKbH8E4w4ygXZKk3On0IaVOH8cYSscxz5BJlSDhGclSVQIbqvUMxvsmdOsjUu/+jCLP8zAXnN+nTeZ9ucvbOJPYgYRoA9z1EdttyJGlLpLRnc9Ton4OFRFLmAlmTI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 13:11:18 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 13:11:18 +0000
Message-ID: <0b358bbe-1d86-422e-a817-a61aec84eef2@amd.com>
Date: Fri, 13 Jun 2025 15:11:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tools: zynqmp: add build script and documentation for
 ZynqMP KV260
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Neal Frager <neal.frager@amd.com>
Cc: U-Boot mailing list <u-boot@lists.denx.de>
References: <20250612153311.2379944-1-jerome.forissier@linaro.org>
 <20250612164939.GO1382132@bill-the-cat>
 <b806f55f-da5a-4373-a6c2-15b1cab93da3@linaro.org>
 <eefb84b0-f995-446a-b885-8de9e0b2f295@amd.com>
 <a63dd90d-8c31-44d0-88da-228df3e36b32@linaro.org>
 <6d3e7ea1-9ae4-4f5f-a25f-968e7a15e89f@amd.com>
 <f42bf2a0-5114-45c6-9d7b-02bac8a4dc0d@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <f42bf2a0-5114-45c6-9d7b-02bac8a4dc0d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0007.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf53faa-1f67-48c5-185c-08ddaa7bc89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|13003099007|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjVPckk5dCs5YWFxMVlnK0REUHRtRDk1Q0VpdkUxaSt6UmZVMnhSdkJRSWha?=
 =?utf-8?B?Tmo5TTBIbXFyZGtWM0kwWml3VmpWNXgyYzhmOEpxSkhhTjRIenJqcGRBTnk4?=
 =?utf-8?B?LzhKM2UrMGx0d29GTHVlYkJyOHJlTWFTYmgxcU1Ed3IzK0Y2ZUJ3ckd4T1lM?=
 =?utf-8?B?MzlzTzc5SUhubzZFaDNRMDVKQVVGbWVLdjV3ZktsUzltb1JtM3lORFBrRTMv?=
 =?utf-8?B?Y3BJWkZOVkVyZFRkUkgxL2ZLRlN2bEJiQ3grdTZhUzVEY1pDbmx2Z2d2QnFn?=
 =?utf-8?B?Q1o2dzEvWDY1aHdDSzNPdGowU29rQzRTUThXWUk0enlDczBNelIwbkU5b3hH?=
 =?utf-8?B?ZEJ0M3JZcjRCUDh3dytiWUVyandFa09seVBFQ1IvcFJySFp5Nkd0clUvT3BT?=
 =?utf-8?B?WkRBbWhnU3VPcWRESFc1TFliVkZ3Y0ZuQTBKTVVQL3VmMXBqQWNnelRqMEFO?=
 =?utf-8?B?UnJxODZoNmF3UTZLVEhBSExFL2RKKzVUenJReENpNHNtSURNT0ZkclliQytW?=
 =?utf-8?B?cjBQRW5nekNSbTNxZnJ2T0g0dzV2YjdBV0pnU2s5M201azZ5TW12aDVFOVJj?=
 =?utf-8?B?MUlDQ09JMUtXa3lyeHArZ1dmeVJDdUFUSUhTbzhqSSt3eVptYTBVVjBPVTJQ?=
 =?utf-8?B?YmMraVJZd0g1dlRubjFQUzY4emJuT29xeWxQL29USFlKUjRIWGFZZEJHcGk2?=
 =?utf-8?B?V0VMbzRQbGdvcldLZk5VU2ZNWjZSeXMrRzNpbVp4MnVKODVYV2JWTWJacUVy?=
 =?utf-8?B?cGV1N2FjMlRZeEY3UWcxVFh6RjZkUElSdlBNeS90RGlkU293anlLZDRZK242?=
 =?utf-8?B?elhhSkVlcDMwbEQvZWUrNGJuZnRvOTBCd3FuMC92Z0NzOUN6WnFtUyt0VmtY?=
 =?utf-8?B?N0JJRkkveW9SeWl0aVlHTmM4OGQwYzhhWG0vWEdlRGxZNHJMQVp0eGpOS1A3?=
 =?utf-8?B?MGdZNkdzZlVSUmZnMXRZR2tCYzhwR1BVdEFqcW1DR3FDSUEzbEhPb2lrMVdV?=
 =?utf-8?B?SEZNSG1wOWtlYm5uU01aL0lwRGVGOVdka2dlOHQ2cjhKYUdxcEYvWkhPaTBy?=
 =?utf-8?B?M0tMSXdwdVA0ZkJ0bUhkN21UdmZEdjl1ZVUvd1FUQXR1dDYxQjNveHZ6N3BY?=
 =?utf-8?B?OW9yNGpjMUU5d084cFFzV2JlS2lScC9XdHluSTNWRjlwKzdNT09pKzhwZXZz?=
 =?utf-8?B?Nk9KVEVLOEpCU2ZBblFIVVQ2RER4blhrZjRpTmhtbGU0VXdsTGNWV1FKenU5?=
 =?utf-8?B?dTVvWkJ6SUtrK3J1bE9hNm1ScmNLWXhrb3lhRStDanRTNHVNRk5FRjJVaXVY?=
 =?utf-8?B?bUU4MkhyMEMwUDFXMTRXMVQyb3lPV1hIWEFGeENFTGZRN0IrVnJNTjZJZXBS?=
 =?utf-8?B?S3F2am8rdndaUGpZRVRTZkNCY0N5Z0cvV3F2aTNkVHk1V3FvOWZyWTNabGpw?=
 =?utf-8?B?VGdwU1RWVENFeVFTMGdWWDZ4ZGZ1MFJMVFZVcUtSbFpnSmVGZ3pQVm5tc3ov?=
 =?utf-8?B?L0pRZUQzbjkzTWtac3VqNVhDVVA2Rm42S0RWUys2WTNVWGVMWEdsODlRTHN6?=
 =?utf-8?B?dWhNekRzMXQvZUJYQTBKbHpwT2NSYWJiSXF0T2RwR1FxUmRMdlZrbkZtRFB4?=
 =?utf-8?B?OElGQW9wUWxsck5xUTRjZEhDQlRHTUZ6bWoxS1VENUVNY0JISUpweTc0dXZr?=
 =?utf-8?B?dk55ZzZyUkhlbUE2Nm44UzZ3d2dmZkd5S1BKU05YYktjN0Q5U3lCbTdpSDQ4?=
 =?utf-8?B?WjRONThtT1lUdDZKMUhIRDIwMXV2QndkZjRzMUQ4QUYvWUhWMm81cUpnMkV4?=
 =?utf-8?B?V3hyOCtPM3NiQVpqeWlNdjdxRUtmaCtTMDJNMHo4WHhuYXNVaysvMUltUW1l?=
 =?utf-8?B?QXhhU3ZUL2dPNG8xK052Vks3U3hzdTY2M0JZRE51Qngxc0ZIWGExSkNvdlRx?=
 =?utf-8?Q?ynj8EgijpQI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THB3MGhRS1ZWazBsbmx1akFNdHlGdndRQ2hRaVJodHNtOTJ4MEowdCtYdXlV?=
 =?utf-8?B?OUFpNmluaFNVcFI4TTZwK2g1RzFERm9JTUtkeVVjeko2dFRoNmtFdytINjJP?=
 =?utf-8?B?SFBTYmJ5SkVnYlgzSExic3lnUmFPWnFMUHdiR2hnbDlYR1NZalRoanRHZnpi?=
 =?utf-8?B?cW42RjBFWGg2SHVFUDRMdENUUDNvTU5zUUYzZlBlSUVVRkJmWU1ZUE15Nm9r?=
 =?utf-8?B?UUErTDBxWmFCVW5jY05EekZwVFNIdlIvQ2grRTNTRnJFUmVRY1BRczhncGZY?=
 =?utf-8?B?NmZVZ2ZPUW1xd0lveFhJVEFqajhPQkVRenB4ekJoKzVzNjlyaVpjK3VETEZ3?=
 =?utf-8?B?b01MTS92UGxxR3lDOVo1c1loS2RpYzBLd055TGJicjNyRE56UUFvVFdxeDBw?=
 =?utf-8?B?bHl1SVkwaGNGRUwwWWxmdVNITHFBTlNQZnZJQlpWV01kaUF0Wk43UXRaSmdM?=
 =?utf-8?B?b0FSTVZGQU5PMmg3dllpZlVQYVFVZVJPdGtRY2hyT2Noc0lRYnNrU0dpSk9x?=
 =?utf-8?B?aVJxcUpMRU5HZllBT3dsWm1xcE5ZdVNKSEFBZkdsSWswYk9Nd25aUzNPUks2?=
 =?utf-8?B?c2JQR2NXZUMrVkNwT1hNRE9HNzNEeFR6RjNuK3JQK0VoRmdQTHk4Ync1NWZh?=
 =?utf-8?B?RFJVZ05vMVZmd3AwWStGMUdXVktkYy9PZmV4dk13NzBicDNDcHdyRnlkRVRs?=
 =?utf-8?B?MHpIaDk1MDJ1WTNncUYrNlNzc25Jc0xrMkNxT3JuZ2I3Tzc0dzVid1RZTXc3?=
 =?utf-8?B?K3d3UURFYWtvOUIxRk1JU2EyVTlVTS9RQlZ5bjgyNlBpT3lpMGpwL0ltREJH?=
 =?utf-8?B?M3c4SzFLS056UWNONUdEZ0dpU1psQ2xzNE0wQWw3UzluaXhCQlhYd3d0OTBs?=
 =?utf-8?B?NGtFYkZWV1F2c0xvMFozS3lpVnJMTVoycy9nYzNHVjVhNWxHRjdRL2M1ZnZq?=
 =?utf-8?B?M21NTlJIUGV1dElUekEwZXdodlFzeWUzTFd1VmQ4WkxHODFzYSs1T2Z0MmJo?=
 =?utf-8?B?MkF0Y2tLbllHUmpYc1l3d3RnYzhIY09XVU1VU1d1cHpNcnNVLzNKT0x0RGlT?=
 =?utf-8?B?V25WZzRiSThNVjdCcU9pcE5tbXpuK05QNEJubGZoWTBOQVdlNGdPVjRKZVNV?=
 =?utf-8?B?MG9vcE9xSWdOSzhRZzVGL3kxekNZTTVjQWQzcWJ5MUZzUFlVUTNld3Z3Y2Za?=
 =?utf-8?B?MW5nc1BpeHZJaTZQT1lHTlB5eEF6VzZYOGUvaGg4S2pDbjZZT2dqTm5NdEYw?=
 =?utf-8?B?b3JmeXNYc21manhLQzUwOTFCV21jRkpYK0R0clZFZ2VCSVRtc0s2bVdyS1VG?=
 =?utf-8?B?bzRBT2JjeXVaYUhyVXlmSFpmNlN0RTNvUVlIR3RyNzJSMG5QSXdCNDNReXly?=
 =?utf-8?B?dkcrdDhYRFhqTnRrR0Jhb2ZRYkw2WWlId1EvL0hrUXljRXpQQmRDeHFFa0x2?=
 =?utf-8?B?aEhmTGNyaU43aE5pL0pyZVNldUZQNEJlY1A3SmVGajI1K2RUMnVXa2U1eVRX?=
 =?utf-8?B?bFJibXdKRHA2ZGhXSXBERzVqZXVpVkx1MFNsYmxwN2pKdHcxbG9HaTl2SUoz?=
 =?utf-8?B?aUVOUFNYbDJUWTdCZDhDY1hLbkJaMlJMaTI4ZkRWaW14eTI0QjBnNHFGR2Vy?=
 =?utf-8?B?alZmeEVHYmJjeERuQmdLSVZRVGdzTktaemZFYkp2VW9URExRQUNaYjE5c0Fw?=
 =?utf-8?B?alRKTVVkSlFGMTltWnZGRm8wN3BEaENpTGUyQklsZGJmYVNiYjBZZVp6Q2VN?=
 =?utf-8?B?Y0sxT0I2WnVXZ2pYV2hKYWVZNWl2eDhlWXBwaWpIaERGY05YajRPT0U1Qk5s?=
 =?utf-8?B?RDJmSEtqYlpoR1pnZ3NKOFA4bTZnUXhyb3QxdUtCVmhTdms4WmpJZVBCY2VY?=
 =?utf-8?B?TjQ0Uk8rVXNyRlprOEtCYmRWMERJUGJiVFFKQlVHd1Q0dStZOStrWlVoODNC?=
 =?utf-8?B?OVFORUFiRmJkNnpPcWw4Q3hiQ1BlZ29STmRUVVNoVldCNUhzTUoxT24yUnZU?=
 =?utf-8?B?NGlXcEhpMXR6eEthYktpNHVLMnFuRnZDYm9NWklHL0MwMlkvOHkyVytkbGxR?=
 =?utf-8?B?ZXNIVVJIVDBhRW1jOEhoa3Qvb3pLd3lHK092elBtNUhsY2J6VU5qMHMwQWYz?=
 =?utf-8?Q?yMpv5bmRa3cSeBazTr37FcuzG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf53faa-1f67-48c5-185c-08ddaa7bc89c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 13:11:18.4017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyK09QsqgHg9LU4QcKrvPyybEoXpfEIHvpyLd+/75tyxS+haKkBb6SrvHuiuCPLX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867
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



On 6/13/25 15:07, Jerome Forissier wrote:
> 
> 
> On 6/13/25 14:50, Michal Simek wrote:
>>
>>
>> On 6/13/25 14:30, Jerome Forissier wrote:
>>> Hi Michal,
>>>
>>> On 6/13/25 09:59, Michal Simek wrote:
>>>>
>>>>
>>>> On 6/13/25 09:38, Jerome Forissier wrote:
>>>>>
>>>>>
>>>>> On 6/12/25 18:49, Tom Rini wrote:
>>>>>> On Thu, Jun 12, 2025 at 05:32:41PM +0200, Jerome Forissier wrote:
>>>>>>
>>>>>>> Add a script to help build a functional U-Boot binary for the ZynqMP
>>>>>>> Kria KV260. Also add some documentation.
>>>>>>>
>>>>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>>>>> ---
>>>>>>>
>>>>>>>     doc/board/xilinx/index.rst        |  1 +
>>>>>>>     doc/board/xilinx/zynqmp-kv260.rst | 27 +++++++++
>>>>>>>     tools/zynqmp_kv260_build.sh       | 43 ++++++++++++++
>>>>>>>     tools/zynqmp_pmufw_elf_convert.py | 96 +++++++++++++++++++++++++++++++
>>>>>>>     4 files changed, 167 insertions(+)
>>>>>>>     create mode 100644 doc/board/xilinx/zynqmp-kv260.rst
>>>>>>>     create mode 100755 tools/zynqmp_kv260_build.sh
>>>>>>>     create mode 100755 tools/zynqmp_pmufw_elf_convert.py
>>>>>>
>>>>>> Helper build scripts don't belong in the tools directory. If they're
>>>>>> super helpful, I don't object to adding them to
>>>>>> u-boot-extras/contrib/<you>/ directory.
>>>>>
>>>>> OK
>>>>>
>>>>>> But there's a number of
>>>>>> documented examples already on checkout and build TF-A then do ... for
>>>>>> your platform.
>>>>>
>>>>> There is doc/board/xilinx/zynqmp.rst which deals with quite few ZynqMP
>>>>> boards but not the KV260. In addition, it has a number of shortcomings:
>>>>> - It mentions pmu.bin but does not say where to get if from
>>>>> - It doesn't say how to build TF-A (bl31.bin), some very specific build
>>>>> options are needed.
>>>>> - I consider that detailed build instructions belong in things called
>>>>> scripts or Makefiles, that were invented long ago exactly for that
>>>>> purpose :) IMO the documentation should tell the bare minimum and ideally
>>>>> be unnecessary.
>>>>>
>>>>> I am not particularly proud of the fact that I spent more than a whole
>>>>> day trying to get U-Boot master to boot on my KV260, and without the help
>>>>> of Michal, no doubt I would still be trying... So, how about I submit the
>>>>> zynqmp_kv260_build.sh script to the u-boot-extras/contrib/<me>/ directory
>>>>> and just point to it in doc/board/xilinx/zynqmp.rst?
>>>>
>>>> no issue from my side.
>>>
>>> OK so here you go:
>>>
>>>   From a429f6563fc5f1433a2df8eabe6a42a98864701b Mon Sep 17 00:00:00 2001
>>> From: Jerome Forissier <jerome.forissier@linaro.org>
>>> Date: Fri, 13 Jun 2025 13:39:10 +0200
>>> Subject: [PATCH] contrib/jforissier: add zynqmp_kv260_build.sh
>>>
>>> Add a build script for the AMD/Xilinx ZynqMP Kria KV260 board.
>>>
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>> ---
>>>    contrib/jforissier/zynqmp_kv260_build.sh | 42 ++++++++++++++++++++++++
>>>    1 file changed, 42 insertions(+)
>>>    create mode 100755 contrib/jforissier/zynqmp_kv260_build.sh
>>>
>>> diff --git a/contrib/jforissier/zynqmp_kv260_build.sh b/contrib/jforissier/zynqmp_kv260_build.sh
>>> new file mode 100755
>>> index 0000000..967c946
>>> --- /dev/null
>>> +++ b/contrib/jforissier/zynqmp_kv260_build.sh
>>> @@ -0,0 +1,42 @@
>>> +#!/bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0+
>>> +#
>>> +# Copyright (C) 2025 Linaro Ltd.
>>> +
>>> +set -ex
>>> +
>>> +if [ "$1" == "-c" ]; then
>>> +  # Clean: remove downloaded/converted files
>>> +  rm -f bl31.elf bl31.bin pmufw.elf pmufw.bin zynqmp_fsbl.elf pmu_obj.bin
>>> +  exit 0
>>> +fi
>>> +[ -e bl31.bin ] || {
>>> +  wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/xlnx_rel_v2025.1/kv260-kria/bl31.elf
>>
>> I would create one variable to keep xlnx_rel_v2025.1 string that you can change one location to get new versions.
> 
> OK
> 
>>
>>> +  aarch64-linux-gnu-objcopy -O binary bl31.elf bl31.bin
>>> +  BL31_LOAD_ADDR=$(aarch64-linux-gnu-readelf -l bl31.elf | awk '/Entry point/ { print $3 }')
>>
>> here you have bug. Your script works fine on the first run.
>>
>> You can try this
>> ./zynqmp_kv260_build.sh
>> make mrproper
>> ./zynqmp_kv260_build.sh
>>
>> and look at
>> CONFIG_BL31_LOAD_ADDR
>>
>> you are all the time getting default Kconfig address which is wrong.
> 
> I've moved the BL31_LOAD_ADDR assignment to the block that appends to
> the .config. I have also split things out a bit more. Here is the new
> version:
> 
> 
>  From d7b8c46f2b4d60080d33ea481bf23df5a4b510be Mon Sep 17 00:00:00 2001
> From: Jerome Forissier <jerome.forissier@linaro.org>
> Date: Fri, 13 Jun 2025 13:39:10 +0200
> Subject: [PATCH] contrib/jforissier: add zynqmp_kv260_build.sh
> 
> Add a build script for the AMD/Xilinx ZynqMP Kria KV260 board.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   contrib/jforissier/zynqmp_kv260_build.sh | 37 ++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>   create mode 100755 contrib/jforissier/zynqmp_kv260_build.sh
> 
> diff --git a/contrib/jforissier/zynqmp_kv260_build.sh b/contrib/jforissier/zynqmp_kv260_build.sh
> new file mode 100755
> index 0000000..83daf73
> --- /dev/null
> +++ b/contrib/jforissier/zynqmp_kv260_build.sh
> @@ -0,0 +1,37 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2025 Linaro Ltd.
> +
> +set -ex
> +
> +if [ "$1" == "-c" ]; then
> +  # Clean: remove downloaded/converted files
> +  rm -f bl31.elf bl31.bin pmufw.elf pmufw.bin zynqmp_fsbl.elf pmu_obj.bin
> +  exit 0
> +fi
> +XLNX_REL=xlnx_rel_v2025.1
> +[ -e bl31.elf ] || wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/${XLNX_REL}/kv260-kria/bl31.elf
> +[ -e bl31.bin ] || aarch64-linux-gnu-objcopy -O binary bl31.elf bl31.bin
> +[ -e pmufw.elf ] || wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/${XLNX_REL}/kv260-kria/pmufw.elf
> +[ -e pmufw.bin ] || llvm-objcopy -O binary pmufw.elf pmufw.bin
> +[ -e zynqmp_fsbl.elf ] || wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/${XLNX_REL}/kv260-kria/zynqmp_fsbl.elf
> +[ -e pmu_obj.bin ] || aarch64-linux-gnu-objcopy --dump-section .sys_cfg_data=pmu_obj.bin zynqmp_fsbl.elf
> +[ -e .config ] || {
> +  BL31_LOAD_ADDR=$(aarch64-linux-gnu-readelf -l bl31.elf | awk '/Entry point/ { print $3 }')
> +  make xilinx_zynqmp_kria_defconfig
> +  cat << EOF >> .config
> +CONFIG_PMUFW_INIT_FILE="pmufw.bin"
> +CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE="pmu_obj.bin"
> +CONFIG_BL31_LOAD_ADDR=${BL31_LOAD_ADDR}
> +CONFIG_BL32_LOAD_ADDR=0
> +EOF
> +}
> +export BL31=bl31.bin
> +export BL32=
> +export TEE=
> +export CROSS_COMPILE=aarch64-linux-gnu-
> +make -j$(nproc) BINMAN_ALLOW_MISSING=1
> +set +x
> +echo Build was successful:
> +ls -l qspi.bin

That make sense.

Thanks,
Michal
