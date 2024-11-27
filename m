Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065ACD6ACC3
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 12:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 515F3897C5;
	Wed, 27 Nov 2024 13:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r/Wf9mTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0E43897CB; Wed, 27 Nov 2024 13:07:49 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39670897C3
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 13:07:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3OLXEIyviVJ4Kx57tzUbea/jE2oBuMJV1zitg2nDgQfADBlRcGfWNxoI3iUlAxNZeVwm3ZHviePo9dvfUW2R31VouEKrLUJVn9lL1KySyZfLDcp+Z00awMiBg8vw5gqkhgRTeUYJqK4TxAZZrgbFOgdtePEhnrNgOiRVDEOK50eLlgJvCRYvcHje3NecpKAYyDu7x3f1l9SvhkLzUly4kztX+iq+0KkAO/5PLBtxECfTHfeNGcyo5XuFMXAtNHV1EoYkSpMIM7EFp3NSFxz8IKAmpbNiDLUEjCl4yg3Y4B1n60wGB5E3JQToGqTXs0NpUXXYk8tKClyFAPS8pXYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t74Sz5b4Y7UjndVlxeoGtDlxMSMRLlBHI57yQsY3fEk=;
 b=KunhFjaTGIyEeDqK6/lv+h5hnhkZxkcJtXwfC6pf8PRJexs+e1waZpnDTV5NYic/ho8VxLlrgpO8SpILXF1wIhOmGILE7RoJrwiqoBu1lFBDSUmZGyvkR/FrUT4jU4FxAx1PZOk22ukX3zH80bxHE0xmBNO68ye70lG1De1W/xdNMyO0kKujegdRbO6mao2/lHv3Ax9NG94oG4lxsguA3ypDc6+mGUw84Ikhf68LGjEWXU29r0h8MLn9G4I2pcpdhK+kRkJ0Fe7zeRv4xIyC+8yyckD42blN34r9RwGI9lTDwbuIax8SGJTyv0ht0HPlYfY27OdSLc1f5kisulKZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t74Sz5b4Y7UjndVlxeoGtDlxMSMRLlBHI57yQsY3fEk=;
 b=r/Wf9mTK0Bj8b4mey9STQ1/3Fah/tUTtK+hieseozTlep4YBn6FucU2N5gzNk+qu3MSGKQG/FnVRCUDBvmeVP0Hj2qd6f5zh4XCDp6qc4vYLc6cqEhmgeI6JqWMpsFWj8qPt6Svh6s3Oj5/5UxLuk8HfjTXgmRW9NSGmAB+HIf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 12:07:43 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 12:07:43 +0000
Message-ID: <a3f79341-5b41-4cd7-9e1a-e745fcb85c17@amd.com>
Date: Wed, 27 Nov 2024 13:07:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] CI: xilinx_versal_virt: disable USB_DWC3
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, u-boot@lists.denx.de
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
 <20241127070631.16412-4-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241127070631.16412-4-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::7) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6d3220-b8ec-4eab-a00d-08dd0edc1901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eW83b2t3WjNIOUtlR0VIa1d1WS85UUFnWCtpcmxWQWdBdTVLUW9YNnBBSEto?=
 =?utf-8?B?T2RqeVpKci9QQjFqRW5wcjVnQlR1TWhkbDBqd0srdE9DNElZQ0lHa3VJVUl5?=
 =?utf-8?B?bnlSVFlTL0xaekU0aWpjTFM0dXdTclBLNGFUQWJMNDdWOGd1NmdyK2FpcG9G?=
 =?utf-8?B?cWRVN3FVdGdLWEpweEJaNzJmNEhyN3cwcnBGL0luYXZBcG9vbjZIYXpNRmt3?=
 =?utf-8?B?bHFlRXBSQTdEaUlMeW42UUV4VElyR2plb3FZbkk5cHVSUDNqR2oxS250VExY?=
 =?utf-8?B?TlpodTdPZXpyMWkrVm11MVFvaGtpeUtPU2ZWU2tJY1BPUG9tZTNMWlNEbXVm?=
 =?utf-8?B?STJIenlVVFd1bnlvbkgxc0gwNEswelBvRFI0aW1aZzNPTlM5cU5kLzdVRkJC?=
 =?utf-8?B?elZGZnV2VkEwR0ZDM2RpKzNTcjJLSVphVXNybHRNN3ZQNkdqdkhtTzJhYkFW?=
 =?utf-8?B?VVNRWHRvN3NrTEZTMHQrSUhTUUpHWFRjUVJtQnV0YnorTlJwRno2MDhWY05B?=
 =?utf-8?B?THpMbHF3NUVtdGxFaDhBMjQvakVUdXhPYkxOalpoMldNMUxITnZCUXRIcDBz?=
 =?utf-8?B?c2pQOThPcWJhVXNTMXVXaTMvQmxUTnhvTXJSd0lINlREamovOXVDRld3T0dZ?=
 =?utf-8?B?TFhhRHRFUGMxU2JVQTlyUm9nMmVMMnozQ2ZCSzB5TWhiWTB0ZzlsK2xJcFIx?=
 =?utf-8?B?N24wSG1IMmxiWE5ZQ1llTVp4RzBOYjc0TnB4Wm52Q3pOTHNjNENRa2pYOVBB?=
 =?utf-8?B?N25xSVFRWmJmenNVVk5VS09ZWWpmbk92ekZTT2FlUlBGbzBaTkp0c2pGSnZl?=
 =?utf-8?B?TklnUnZ1T0xNYkY3SlNWWlgzc0lPSm9SUWQvdWZaL3RKZ2hpQ3Z6dVZ6blZY?=
 =?utf-8?B?d3h5R0lpLzQrN3JSYm84OXZkZ0dYUmp3S211eFhWNUdac2xWTEdzMTFVQVEx?=
 =?utf-8?B?UHFtd05oSEE0SE00b0JFTFlXSnpnTjUyS1piek1SVkZRbmh3VGV5THJkL01j?=
 =?utf-8?B?bDJuRUh5VE56MkpGOHREVzZWQmI1VHRaSjNZMnozM0g4TE9aSXBrRHpQRnlZ?=
 =?utf-8?B?NVlic00xSXZYSk9rWnFudnMwK3NBeVVUdGhTRDEwVWwwdlMzMWtuTTJjcTRP?=
 =?utf-8?B?WVpNRVQxaHBWU2dPRmNMeFVGSC9Ma2J4OTZYc2x1bFpPV0xvV0h4amI5UDIy?=
 =?utf-8?B?NzlYOHNpUmUxMk9xTzF1OThhN0R2K0lvS0ZBUG5XREpRYzBPb3had2JWQ01j?=
 =?utf-8?B?enFVY0s2cUpaZXVKY0dmK0dtRFRRZFhMNjVXSTlHbHFwbGVqSmNsSDdXVXVL?=
 =?utf-8?B?RGFsRDdWQzJGWkxjalZBanY0QjZmS0poTFJCOFl4UlZvQ2xhaFJ1NVhtYnpR?=
 =?utf-8?B?ZlEzY1dFb0xESnVMd1FJUU5IN1BkU0FpaG80YW9pVDJQTldBOTVCNWROcXNw?=
 =?utf-8?B?YmEvNFlPY2sxem1KZHkvak12UW5PNDg1MWJWZ3oxWnNjOExHQWZZN0xoK2Q3?=
 =?utf-8?B?NTU3dlEyOEJ0cGlGZmJkSFFJK1FuaEM4ays4M2ZlRW91MVF4end2UTF5MFds?=
 =?utf-8?B?eDMvMXBWK2VNVnMyMW9PMmxkSk5oNEIvL1psWTNkVFlOdTRhckZhc0Nhd2lH?=
 =?utf-8?B?bDY4QjV2SVpWcVVlNjlib2VWcTBsSGthV1Y0TDBMc3FVOVBZbzFHVjFMM214?=
 =?utf-8?B?QVFCUnN1L1VaUkhjdFBZOHo2a3pTTnYvcVpEZkxMOE5BV1NZa2RVcU1EYUww?=
 =?utf-8?B?Tm9xUzBqZlIrVWJaMlBiZU1VdE05b2dNZjk1bTFkOFFWN1hqM1I3SmhNTm1v?=
 =?utf-8?B?K1Y3Z1RjSXdRR2wvNDNiQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0pZNnlWUmlSZXM2ZDdaZ25rbzd2QkxJK2V6Ky84K21kU2J5UE9qdkNnc3E3?=
 =?utf-8?B?T2NZK2lvc3lDUUhjdEliNDMwUXdSTmZkUzRseWxiT200S0ZTWU1QZytBNUN3?=
 =?utf-8?B?MTAvSCtXbnRLN3A0SElsMzNjK3p0czZRRGU3a1ZGS01KUkJ2TE16dDBvSmwz?=
 =?utf-8?B?bUMzd05pbHJNVjdPRmdyZEw3YjV5Nk9XNVU3NnBhVzdicEY4QXFUdXJJNXhS?=
 =?utf-8?B?Nk5kVHZYdU9yekNZeCt3K01UM2hVMHJZYUYweXRtWXN1SGZjU0dQTXhQQ1Ur?=
 =?utf-8?B?ZUl4U1BBWEJQY2NaVGp5QTZyQWpESmpUQjJJWEtHNXR0dTVQTnQvbVNZNEJ1?=
 =?utf-8?B?SW1pSnJiY3VYbXQ4aUNGZGlwYmlBbTFSOU93RFR6QmxEc1h6WjY3R2Rsc2tN?=
 =?utf-8?B?LzFUVzNkQzRWQVBYRkVqNU9SVlpMYm9LbFM4NzRyc2RlaXRqWHZrSk1BdmY2?=
 =?utf-8?B?VElKbjE0UloyMmhFajVwN1llM0p1REVJOHVFQmxRVXBhMVAwTG4wbTZTa080?=
 =?utf-8?B?bnVUV3FiREZWekxZOFMzZFp0aGIvQWNaVkVrUENhOTFrTEdPUnBxU2UvRmtF?=
 =?utf-8?B?aUJ0ZmFNcW92dDh0UXVNT0ZWUTAwL0lVWnpnaU1xRkpMWXp2MDdtRlJtNFd0?=
 =?utf-8?B?R2ViSnVncTFSaFA3SVFkdnhCM3dsbzlZQlhyM1psc0k1Q0xaUzBiTlVka3Er?=
 =?utf-8?B?RDByK3MxWFVHbStpQU1Kb1VLaU4wS3pUdmRCL0FIc0RNTUlQV3ljQ2xtbEVS?=
 =?utf-8?B?RWhsQUdGSUl0ZGczaGpXV3FWaksyd3BRem9zbEtLTkhqMDRwOU9uRGpzOFRJ?=
 =?utf-8?B?RjRGU0MzWjk5N3kxV1lSdUlwd2ZYY05UaDkyM0VsazVmU1NGbGdzNTQ1RkFH?=
 =?utf-8?B?cjZra0lCek1ndUo4YU1TS0JrQjludmtJWVJnQ1U5eEJQd3ZtUWdJelNYc2E0?=
 =?utf-8?B?bDFyR2dQRTJpY3RqdTBCRG90TFNqd05NQUpENmd4cnAweEtOemgzeVgreWs4?=
 =?utf-8?B?QVpXRy96S21zNTd4QnRNZVFlbEtJdzdvdEJPbkNJSHA1YVk5eVdseUQ4cVNp?=
 =?utf-8?B?Z3RQVmU1R3N3NStoM3hKdHMrNFQyWFlQWldLcGxWRjdtazI1b0Q0djY1NXdx?=
 =?utf-8?B?M1Y4QytLaEpzdWJ1eXNhbHRlZE1Fc2Vxd09IOWNEeUphV0JpMWxuVEpkSHJv?=
 =?utf-8?B?ZHI3VHhjN3dtdncrRXpaVW80Q21xUUtnZjNTcWZ0RUVhRVVTcHFMeUhtdUxZ?=
 =?utf-8?B?SnNTVVIra2t2NGFaYUVMRjNzOGtpakdSSkRmQVgwNnpNWnIxcmR0a0t3OXl1?=
 =?utf-8?B?UnF3dFY2Z1dXMXFrT0JpSU5Mc1pwSHpGWFNDaHFPU3ovbmpkbHlhQXM4Sks0?=
 =?utf-8?B?SFpyWlFNbjBhL1lCbHMvOEh3dEZxTHlTRzk3QkNCU3VUdUNEV1FSWGFpaGdD?=
 =?utf-8?B?Wm5QbHV1VXhVRWR0amVjYmhNU3UvWXBCVXlpZ0x2Vlg2YjZ4K1RsUnh4WHRh?=
 =?utf-8?B?UnV3NkhJYkptaEVPVUFxOGZQQmFKTFU2dkphVnMzcmYyQXNYVkc3eksrS05H?=
 =?utf-8?B?T0w3NExyY2RpUmZudG83RmFrUXpqNjFaSjFZZlBTaDNoSW9JMkxaYUZYMGoy?=
 =?utf-8?B?S0NwTXlEWUJwNE5CMm9oMUh6c1ovTFM0aXpiSWdyVzdnS2RpNGd2UHpHcjFn?=
 =?utf-8?B?UXJJTmVlUDdoUVZrRzBBZkJiV0pZdFFPa05zVDNaV3RBVmpGQjB4TWp1bm11?=
 =?utf-8?B?QVhoQno5dGxib3YxZDJCNWUwT2lDVU1NN1loeUtUT1JmMmdHYmhuVzR3MzY0?=
 =?utf-8?B?cEFKN1J6ak5hdU95MUozTjM5ZlhxL1VHWFB5di9nQUduMnp0dUo5RTFDeUFn?=
 =?utf-8?B?U0pmNkhEdXQyMnUzdG9NVU9KckVFR0hrWldhUFdKbjlqMVo2bGZUMzIwbGdH?=
 =?utf-8?B?SHg0dmxXY25wSFY0ck9DU3FOOEZsSElOMVZBWnJsUlFETklOMWtwbUlJRi9a?=
 =?utf-8?B?RFFiU3RZcEt3YW5JejNhZzVNOEQ0SUNIWUpYWXVDNGpFaGk0QVhiNngwRTRP?=
 =?utf-8?B?L0MrQkVQVmV1dGhTd1l1eEg1RXNKZ09FNEc4Rkp3MFlUUGR0OFYvNjIrMFEy?=
 =?utf-8?Q?sD9kMzV4B4yrb1Ynk9YqC1OYk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6d3220-b8ec-4eab-a00d-08dd0edc1901
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 12:07:43.3998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjhlKFTWW6feu13EyoPSibzTz4Jl+oVsha+mNU7N5se9Ozs4hiHHPrMcUIrts15g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237
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



On 11/27/24 08:06, Heinrich Schuchardt wrote:
> The CI uses the following command to launch xilinx_versal_virt_defconfig:
> 
>      qemu-system-aarch64 -M xlnx-versal-virt \
>      -display none -m 4G -serial mon:stdio \
>      -device loader,file=u-boot,cpu-num=0
> 
> 'usb start' or invoking eth_bootdev_hunt leads to a crash when function
> dwc3_core_init() tries to access a register at offset 0xc704 (DWC3_DCTL)
> relative to the register start address 0xfe20c100.
> 
> Disable CONFIG_USB_DWC3 in the CI until the driver problem is fixed.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	Only disable CONFIG_USB_DWC3 in CI as actual hardware uses it.
> ---
>   .azure-pipelines.yml | 1 +
>   .gitlab-ci.yml       | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 4ecf76eaa0b..bac577ec008 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -511,6 +511,7 @@ stages:
>             TEST_PY_BD: "xilinx_versal_virt"
>             TEST_PY_ID: "--id qemu"
>             TEST_PY_TEST_SPEC: "not sleep"
> +          OVERRIDE: "-a ~CONFIG_USB_DWC3"
>           xtfpga:
>             TEST_PY_BD: "xtfpga"
>             TEST_PY_ID: "--id qemu"
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 2164ad79a72..714284a56df 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -508,6 +508,7 @@ xilinx_versal_virt test.py:
>       TEST_PY_BD: "xilinx_versal_virt"
>       TEST_PY_TEST_SPEC: "not sleep"
>       TEST_PY_ID: "--id qemu"
> +    OVERRIDE: "-a ~CONFIG_USB_DWC3"
>     <<: *buildman_and_testpy_dfn
>   
>   xtfpga test.py:

If it is affecting only qemu CI then it is fine.
If this is related also to other HW lab then I think limitation should be done 
only on that particular qemu instance via u-boot-test-hook repo.

Thanks,
Michal

