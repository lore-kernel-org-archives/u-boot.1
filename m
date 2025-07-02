Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F614C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97CC88206E;
	Wed,  2 Jul 2025 09:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M5jPTA9A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C17A882103; Wed,  2 Jul 2025 09:41:51 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEE8481FEE
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NunnDUKYyHQN4B/muBDCvMjxyiAuQ7c7IBkWW6aVp/uvgbodMyGAWQYmsMTNHk1+rDQ/xhdbMlz1duhTPCChm5OKeHQTJu/hb/HtYafQW43ICwvDxrxDBL4wbHyZsZoyEePrs4ZBBB3bciuqdhnrWM8xdg1VnKY+NwmH6AN3TmnKmT4ClbU+TuIlujicFQw5MNpEFpik5u6qu5cXJyLgQeSFSF4c1W8nI5jkWxr6C9gZ0ErXKYc7EYrwXc2m21/prxqkBFOBNyefzMh3Zk2UMN2AyqghVFgVyqsOsbPLZ2vgRKIVfjyW09JdhIOYYlpsAG8kqfv+V/PXdU/clo2Piw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xh8K/YoaiqP8jc1AlaPoMYIGZ/8PU1Q+yJ1ueMzbxyo=;
 b=p9hKYOxnzWSrJT1RpdSzDVXs3rsHBFxAzA/hvXND2s6YVMcR2TbfTf3NGwtdmbtYMYPxwQI4ogYuZyRw5Dfm+ws8jHt7+aNqablkVWP2NL4LPJaZDkpNJ3O2TxMf8W6BZRW1RX9EMZEYx5OVP7L56XsRsjSrhK/hjmZKOv0KYAtQ1r+ZO4ryiqyz/tWPcFxezhm1avJp1yCqjMVmg+hjUYqifGJ/0YNoZn7bA6fF+1ZkbXKGriLQZ/ZJ3j2TqoUB6q7rouUSGqNIh+nu7kHFtzjpZQY7nvb5mLSUS4IbF1zJbIiHRQx0Qv+uyMMdY64KiT3qlnBloZ7a78TnaDUCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh8K/YoaiqP8jc1AlaPoMYIGZ/8PU1Q+yJ1ueMzbxyo=;
 b=M5jPTA9AvRupw3dUtrG6ycb55gsYBJx4woqnSiM1V2G21U6i6P3iPi950GIEAT9HnGK3bdEfXOF8MteINMd0IilIiLO6bHBw/cdWij2+fDjF0GyYfAuAxPqI8nLlbFBdO2YihAsKj52SkG96DiT+iNYLE9ZO9Sxv+EBSKSv57nE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 07:41:46 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 07:41:46 +0000
Message-ID: <9e853685-9364-41d5-82c4-d30bf92172ef@amd.com>
Date: Wed, 2 Jul 2025 09:41:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: zynqmp: Enable rng-seed generation
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, git@xilinx.com, Anshul Dalal <anshuld@ti.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>,
 Srinivas Goud <srinivas.goud@amd.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <8c1f0b439062476c609d8d30247041556c0b69f6.1751438036.git.michal.simek@amd.com>
 <CAC_iWj+abLHTd736=LxQ7-q1TnVuCJBcVY++cqG4KWuJP=r3ag@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWj+abLHTd736=LxQ7-q1TnVuCJBcVY++cqG4KWuJP=r3ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::36) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: f39c2fe5-5c1c-40c2-a98d-08ddb93be5ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODFiZjZTMys3UExTaE9KOHBLUUNwcTJuUitucmlOc0tIVGNnMVU0NkxWb2tm?=
 =?utf-8?B?WENxaGluVExBZndBNVA4MUtISFdHaTJha0Y2ZzR1SXBhMml0Yk1GQVBYWmY3?=
 =?utf-8?B?a3pHVWxWWVBtY2pVV3BuOWd1MzFuUEZBN21xdjViM202TDNGYkRvQWRWb21K?=
 =?utf-8?B?QVdiTk01SW9seng3NUVydWY3YWZjaC9FRWVxU3M1cmZTYm43TXgxUktkY2Q1?=
 =?utf-8?B?ZlAyMXpYNDVrRGpRdUNkWHVjV3FGR29MeHA2eWhBMlg3TTZWY3NqWjkrK2Vy?=
 =?utf-8?B?Y1VTVHZIRlBVbThIRW5KbnM1MGlxaDBqZFZ1MjZUa3pza2VMa1picXFmTDA2?=
 =?utf-8?B?cTUrbGplck9EY051QmZyRmY4M3QwMXlFQlRNdWxzeFJIR1pLM044L09iN1Vz?=
 =?utf-8?B?Vm5LU0RjdlpRMFE1MHVES1ZNREJhaDhyMVplc1hBSkE3YStqYkVKNGcvUVM5?=
 =?utf-8?B?dU5oUDhkTWFQN1hNWnBFT3I2SzdJMDBYdWM5dkdWNjNCUWVlQk8vMmpsdlZj?=
 =?utf-8?B?ekJwWGVyOGpLOGd3U0VxUzBLaFpzM3pzZVN6Y1BOWENYRHVVbkRoUHFrNHdn?=
 =?utf-8?B?K0NHcUlnYkhnQ1AvM1Q4TS9yaTBjQ1g4OUh6TXJnSGRaMFpEUkJSaGR4dGlI?=
 =?utf-8?B?ZG93clFkeFdzamRsVmJnRitsZ2gxajVYTHgzdU5QVlFQaXR1dUtNNFo4MVha?=
 =?utf-8?B?S0wrQmZHNGpkUkZGMmN6WStSeXRoMm5vemlvVjNBVlRXem94NFFSQXpWMlBN?=
 =?utf-8?B?YWJBQi83K0g5eVMyNTNUck9TWXpkTEtDUFRlNmk0d3MrTjhzSGV6TG9sM0Rt?=
 =?utf-8?B?TTFDcnJ6b1UxWEtESFRxR0NTS0Y1dDJkekgyUFFINVlNRWNvaSs3K0swU3hG?=
 =?utf-8?B?TDNRV2RsOTRTdndXWFR1SXNZZWh6dEdpc0xaS0Fzekp1MGwvMzI5UEwwanZF?=
 =?utf-8?B?cnBWUjFITkU0S0wwQ0pwVGhadngxdkIyRDZRR3A2UlJPckhabjFodmg3UDYv?=
 =?utf-8?B?VFY5b1JnVVR2Z3piTXJMcExUMlU1TzRTaUhxUlowaC9tdi9UUHMwTExJVGc1?=
 =?utf-8?B?VzRKOGdNVGR5Z1loLzhwZzdUR0I0NEFKdTBtSHlHYmFKM09vUGxTeU9IdkRZ?=
 =?utf-8?B?R01PUkFFSzZQcXZoR0YxcHFMZUgwWUNhK1lLdlNTQjFhSlNHK041MHlLWGtU?=
 =?utf-8?B?blJyLzNLbGwzOUM3MStjZFl4eDZXdEJmejZqOHgrSjJrUk5DY3IxOStQdUdE?=
 =?utf-8?B?UWV4blQ0QzVQT2ZPUU5IcWZ3WVJieXNRMTNuRzFDSjlWQVUrNExDcWh2RG5K?=
 =?utf-8?B?aERrbThZNWdjSE1UZ0lqNW1ST0Zxa0ZNRjFUejJyVU93SElsY3h6ZmdZZjFx?=
 =?utf-8?B?M3dja2YxajlJQ3VxcGFQd1I1QkhUdEp2alIxbEJ3YWpRWlZxMzlsNDcwVkNT?=
 =?utf-8?B?SjZVTUlySEgrOTNqNTBTc2U0M0NNRXE1SWVRTi9BUTAvak93NGl4UmRKY0tV?=
 =?utf-8?B?eWFqQ1UwK05BU29FSjMzV1RVcHZzemxzSlBsRXRPc2hsdmhQSUNJNCtIY1lD?=
 =?utf-8?B?eEdHb1YrUjlaaDFrZ2ZsWTdCRyt5Tng5OUZQc2VlWVg4YUYrMkJhK2pXOWlU?=
 =?utf-8?B?cENuYjhiMTI0WUhRaExPdzVZNE5UQTU5STRtYzVZVGlXaVBOZWplcDJrcHpE?=
 =?utf-8?B?dHJHeUVkQ3E0a1N3UyswWlBrMGQyL3Y0akl4VTZ5Szk1d1VHYW5qNEk5a1pz?=
 =?utf-8?B?eVdrTEdRS2N5TUE5U05VYXZKMCt1aDZLN2pVa09tZlM2UXF3V1FvaktncGkz?=
 =?utf-8?B?dzZLNk4rMGZnbkNyOGtxTGpFc08vcmhBekp5VWlVaTF6UjhnY2JNdU9oNzJt?=
 =?utf-8?B?ODRycTI4NkVrRHQ4elFXYnRLT2d1M2RWVkNtaER6RmUybzBBS05BQXNPQXhS?=
 =?utf-8?Q?xvUDQe4n4Qg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3ExQ0l3MjkwamdUb21tcXBkT1BXckphLzhuc0l0czgrNWlkV2txZnhraGVn?=
 =?utf-8?B?SmJUdElUOGxOZ201UndjQUNCZGszU2NpNXNMVlY2NHNUeEkvdjBqd1JheGU5?=
 =?utf-8?B?Nm4zeFZESWZSd2dOdUtxUFNZcE12ZzdwNG5LRC9XUHpzcmVJYVlxSjlsQlhh?=
 =?utf-8?B?WS9xYXhMK3BtYUpYREY3SG95ZkJvWGk2ZlNGY1FFMmc0eWlJK21pVmJsQlI4?=
 =?utf-8?B?a3llTGE3WFkvOC8yYWdEU211VmtpWmN1NmF6cGozeTlsZTFmd3J4MnlFblA5?=
 =?utf-8?B?N3NoeGVxbTk0MmVHMWtqdFdXMFpsaUdpVVBCYiszQ0I1dDBYb1RsNHBONGVm?=
 =?utf-8?B?SWlWWEYzSW1tMjJyN3Q0Wndadnp1ci8xRVA3czRscTF2Tmx0eE5XRzZXTXgy?=
 =?utf-8?B?aitvV0EwWDlZQjEyaWd5a2MyUE8xMjhaOVRjTzdKWW85c0pZQjNiMEtLbWJz?=
 =?utf-8?B?K2VjTUI4cGxCTVZIYTBDWWR2LzdYbmk5N3hWSS85TlZ5NUZFaytQeTZ1cmZ5?=
 =?utf-8?B?QnVWOUtBZDNpNlk1Q2RuYjRiTXRiTUd6SjJvT0pXUkJsTzhrM3ZvRlBUdE5I?=
 =?utf-8?B?T1NTQXVvck5hZ1hTdXBYSHd1UXNKWW9FUE9hWUhUVC9UWDZKYWk1cE12SDNt?=
 =?utf-8?B?MDJFeEozc3N0dzRZNkhzYTVza21sNEFQYzIwNE1vMUNkTjl2NXhobmNTZ3ZT?=
 =?utf-8?B?c3VXcW4yeGthdXhCMDlKY3lRMWVidjNPZzBnaVY4UlV5Wk1SVFRYUGNjTFVN?=
 =?utf-8?B?TFNmcXR4R0hsNFU2ZWhkQVNQamgrdDhXK1NJdzU4Z0YrSjhNV2hUS1FqL0tF?=
 =?utf-8?B?QmxOVGtWYXdMYSs0ZGpUNklaMzlWZ29xREJGZy83NHJ6Wlc3YlJISERva0dT?=
 =?utf-8?B?OC9nZVIwQlc3SXl0LzhqU0xHbHRSWCthRjNweEpjaURwbGNTZlZXNUlYWnBP?=
 =?utf-8?B?eGtpZXR5bmFkMERCNnFXQllBWUlMbnl5M3RDbjlyenNONWNiRm1UTUZJQ1c2?=
 =?utf-8?B?ems2NjhFVzVHWjk0aFBYMGRhR2pvQUFIK0RQK3NaREZybmw4R2FNWklDejBY?=
 =?utf-8?B?am5ZbG9HL2NGZFlHWmtLYXRvNTVMN3Rkb2x2d01ESDFZWmJpNndaRXc3NlFY?=
 =?utf-8?B?dzBEeWt5NmN2VDFYTjloZXV0ZmxTTjFtTjYydHcxYUx5dlMyQUlYdlNpaFBj?=
 =?utf-8?B?SklvM1dtSTRGajArVGEzY2l5UTB3cnQrNmdOcnZGSS9GZU1qZFloU283Wmlm?=
 =?utf-8?B?OGh1M1FvSkUrSGlESHptS3lwMDdkcHh0NHdWYW1Bak5aTUxDdy80TjlRMEh4?=
 =?utf-8?B?SU5kakJBd1R3VkVsV3FFUndzZFhrTWdXL2J0akFzQmd5TVg3cmlzeTdnWlhS?=
 =?utf-8?B?aCs5YlhEejB2aVEzYVF3aWQrT1V6bnU5dG1zU2tDSis0NitVVlFoMXkyMUtY?=
 =?utf-8?B?blFrMStkcEI4RWZHOFVoaDJMTEFjYlVBRE5qNlZhUC9SN1NJaFZCbXFNK0kz?=
 =?utf-8?B?ZExqTlV2UFM5Zm01K0pZdXZBazRLN0VOZ3RtVnNyV1pLQWJ2TGoyS0Fmazk5?=
 =?utf-8?B?UHBONkUzZ2VtWXh4dFN1NXpkellOeG4xR1c0Wk9IQ0V2K1J3MDVVTDA1OC91?=
 =?utf-8?B?cmU3Vk1ZNVFkN0pYSmxsdHNSRzFjMTlkUlBPZ3F4Rmp5bXRGU0U4U3p2UEpX?=
 =?utf-8?B?bkpLZmtKeit4WVBPUnQvcDZmVFJSOFY1Z1FpS2hJcTZucncvRzJ5M0YvQUVh?=
 =?utf-8?B?a1JlbTQyRUJNdUV4N3NiUUlrd3Y5Z3l5dnFLdTdJN1ZHZnhLTVNHVEc2bzdG?=
 =?utf-8?B?NmZib04yNE8rSUtVRVk0WUxEWm1LdlZuTndxU1BMN0FPeUtRQ0NaWElFcndp?=
 =?utf-8?B?YVlZT0NLNElndjdESzVheXROVU1CM2FMT1N3U015eEZlcWJJUkp6ZU1UVG9Z?=
 =?utf-8?B?c1lRNmtPKy9ZS3VuNEI2ay9GaHpJeGlPY3hsQ3hWejZ3RG5za3crNjFrMkhC?=
 =?utf-8?B?MDRBeURjSnBJRjVJbHdreGdXZTBFRno1SkNDV0xISXNEdWNMTWRQcVNVSTk3?=
 =?utf-8?B?dFZ1d3owY1RaaCtoNXhRUGZlU1ZqUE1CazR5MzlwWTdXRjVnUUhhUTRBb3RX?=
 =?utf-8?Q?T6d7Ci42oOTMH157hd8o9eUmq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39c2fe5-5c1c-40c2-a98d-08ddb93be5ae
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 07:41:46.6689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnpoTLUWQis+x4H0I3nATpHT+4zXcaWfPte1jE4hctTGG1h8+lDQH68sdVLKXII1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
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



On 7/2/25 08:38, Ilias Apalodimas wrote:
> Hi Michal
> 
> On Wed, 2 Jul 2025 at 09:34, Michal Simek <michal.simek@amd.com> wrote:
>>
>> SOM has TPM with RNG in it that's why enable rng-seed generation.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Changes in v2:
>> - Free alloc area in case of error
>>
>>   board/xilinx/common/board.c          | 34 +++++++++++++++++++++++++++-
>>   configs/xilinx_zynqmp_kria_defconfig |  1 +
>>   2 files changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
>> index 8ffe74299016..f258675d7772 100644
>> --- a/board/xilinx/common/board.c
>> +++ b/board/xilinx/common/board.c
>> @@ -1,7 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0+
>>   /*
>>    * (C) Copyright 2014 - 2022, Xilinx, Inc.
>> - * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>> + * (C) Copyright 2022 - 2025, Advanced Micro Devices, Inc.
>>    *
>>    * Michal Simek <michal.simek@amd.com>
>>    */
>> @@ -712,3 +712,35 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>>   }
>>
>>   #endif
>> +
>> +#if IS_ENABLED(CONFIG_BOARD_RNG_SEED)
>> +/* Use hardware rng to seed Linux random. */
>> +__weak int board_rng_seed(struct abuf *buf)
>> +{
>> +       struct udevice *dev;
>> +       ulong len = 64;
>> +       u64 *data;
>> +
>> +       data = malloc(len);
>> +       if (!data) {
>> +               printf("Out of memory\n");
>> +               return -ENOMEM;
>> +       }
> 
> Why don't you move the allocation just before abuf expects it?
> You can get rid of the free() in case of failures

Good idea. Let me send v3.

M

