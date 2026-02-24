Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2DCEFB80E
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 07:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EE9183642;
	Tue, 24 Feb 2026 08:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="teVdDEFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1776083BC9; Tue, 24 Feb 2026 08:11:42 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B69F82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 08:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0UJSb1uC7JHjkHXPzFDQO/T9yHwhSBuMvXVkBP5TGFZk2s0/HOPi0WGN74VXA9aNgXic2Tjn9wc3L1VAYxD8cXl1ooHPo2ewdHVz4+V/aXR/YNncXGmKJkPWjDxVaOXDRZz+hn88PA49Y+CuPcnvifurNYkOwu1KDf3RuHlEt0IgsopDMe+ocHF2q8/QPK9NK52ON5Jl6tQYvucdrq2ZhsiVtF3tQQJCemMiGHReq7sfJcbr+h+OtIEa/7ytBnWUa7AxlfetCjVLKRTZHxVT4AhC0pWSsQ5BtmApouueKEJ5o9QZEmuSeesZXxgYwLkvSg7pnsf+cwTbFX874N9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9FUmi5u6WorDYB0XpxerCs6ykMG7COPG9PL1gk1q5Q=;
 b=Se6yJnreBfSvrAk2m2ntgaBlgAwUwmwBE+M9pzR/Me1Tujjin1YvgSwzpm5wpv6ug8c2ZNuZ3b8IybUkHezHquR1d9jvG1xE3FwanJKZ1S8YeeSk5pnNYMfe+vNllUgOmFnEmNrcWDPfH1gW2GDAiTAHEC0QB5OZSynqMj6+7axYM5Gl4O47+kFNkdTLyDQkyqTR7KeVOjcwfktYqq57AUx+uogp4I1XTngtzVQk87OsayvXVT6WjYdTr3eBKQjqvMV2p5Mpc/3Ove3c0idRNrBBH00oLBJnGaKsCZoAAWzEAOF6FBIOJLdA0vtGkmbgS6FjSpXarJ7CmF9IisJpFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9FUmi5u6WorDYB0XpxerCs6ykMG7COPG9PL1gk1q5Q=;
 b=teVdDEFXCOJiaTd5M4naIUqBGMBcXqta2+8p3sLsquGpdrP/KrsKj5MTZiz2v0ZNRPI7StMCpTwnHM9ZLyekMDpt9lAI/PEY4YyIh8EFP7SSvQl21PhI2nQSvItgbS3R4vWQDGJ8NijTA+dgJHWfarxk/l3cKevfZYmDHfBkDJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 07:11:33 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 07:11:33 +0000
Message-ID: <7a90c0b7-b548-4129-ba4a-935104fada6f@amd.com>
Date: Tue, 24 Feb 2026 08:11:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: Disable UTP command timeout in slow mode
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@amd.com,
 Padmarao Begari <padmarao.begari@amd.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>
References: <e6deb9086afab9d2bdd53db8ecbc7db93af5204d.1764169598.git.michal.simek@amd.com>
 <176555459951.1592278.10213529530179974819.b4-ty@linaro.org>
 <CAHTX3d+kSNa98KSMk0Sg7kKq5Dj-NXayVJgcCOSU-DptaxeNSg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAHTX3d+kSNa98KSMk0Sg7kKq5Dj-NXayVJgcCOSU-DptaxeNSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0184.eurprd09.prod.outlook.com
 (2603:10a6:800:120::38) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: b3fd01de-7d4d-4dee-123e-08de7373f08e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXR5d1RjRDZXQkFqc2VUZjRKZVNiS3ZRU0VNWkdNNTdVMkJLZ0N6Uk8wNlJC?=
 =?utf-8?B?aS85cFE1MzdZb0xLOGp2NFVRdmx0dGF0N29Pb1U2YXVXV2JmbjIwaHhVMm5O?=
 =?utf-8?B?aURsY20rdCtZZGFBamQyOVcxdm9QM2QzOUV6TlVRdDEwZjJZdWRZYktpaUlZ?=
 =?utf-8?B?RzJTdVZmcmIrMnZjVFZMalBrV0RzcXBYOWRSeWtQeWhZU2hTT1JUQUVMSW5T?=
 =?utf-8?B?Yll4UW53M2Z6MEErRWwwUmtBSjVWNjdVKzV1ODU4RGQ1eHU4UkozbGptTVMv?=
 =?utf-8?B?ZmN2eXB2VE44VE5sRThVWWVwN0tMUzc0TkpreHlPdE4ramlYTExGU1dlVUZq?=
 =?utf-8?B?WmI3YU0xdTZEY0ZoRDdCa25QMy93NFFKcDZTelBhNkNTOUVhYTRERXlVa1BH?=
 =?utf-8?B?T041ekNnc1hPUjlNcWNSQTN0NU1PeVhSMVFpTEZHRGowcU83cElDQm1YN0dG?=
 =?utf-8?B?Zkp6dk9oTHFOeVVWbks2ZUNCbVlMTytHSVp0U0orbTBIYVNpdjN1czAxbjR0?=
 =?utf-8?B?VytaVmI3WjdUbDJKVVV4RElhaHc5ak93K0NRTUpoNkZGaWovMFhaMjFuMW9W?=
 =?utf-8?B?OGFhM3N5aU85Vm82V1lIK1RvVzJTNmlyb3l1OVBOOUQ0Vjc1NlhoaXE0VHdW?=
 =?utf-8?B?Y1B5dDJHd2FOVTFvOXdBNlFqTmhtVTd4L251WndOb2t6UFJFcFZTNTBtYnVj?=
 =?utf-8?B?MzVwOTN3Y3JWSXFOT0FJVDVWZStGVUZsSUEvZnRrL3NqOGhsYzE2WlVrUDRQ?=
 =?utf-8?B?TVZmSXFVUzFqbkdsRCtBN05SNVZTUytrbmVnM2pOU0hjdmFlMEY0Z1VwS0Z1?=
 =?utf-8?B?UUJYQ1hsTFlnbWNDam1yZUhzek5LR0wzM2F4K1VPVWZvYU12VUFDTXBYdnBP?=
 =?utf-8?B?NWtuOXZyY1VsWU02QXh1b3lKNkZkSExZemVJdllVSjFzOU1LRWxmblVHaWQx?=
 =?utf-8?B?eFl1ODNCVEMwNTh3amtDY1U0K2F5RHhQNXhSLzdWU3FjQjYyQ1NvczdKL0Vu?=
 =?utf-8?B?eDhxMFcyUmlXdGFTQVNLRHBjN1VCQ0ZIcVdzeWdrakgrZHhlTy8xVDNyb2ZC?=
 =?utf-8?B?Kzd1RStrSWZHdDc0b2pMeWtFb1c2aXAwU09tcGNHSXhoV3FwcFhZYktkNUN2?=
 =?utf-8?B?ZG9GZEFSbnZMMkJHU25tSzF4TWcrTnh2VGF2LzVtTXpyQkd1QU1VY1NSTHFG?=
 =?utf-8?B?UDIyNUxtUEprd3FhaFZ0YzRnQVdTd3RWV2VVeXQyN0xNTlNnVXZxSEo3b2M4?=
 =?utf-8?B?d20wa1p5QklTSUtVVWxObkpzWUplcW5GRUw3em9jRHQ3NDEwbjh2QldkMkwx?=
 =?utf-8?B?MEM1Rlg1cG1ubGIray9LZWluK0N1OWhBdFNjT205cDh6RE5lcTdZTnZpemox?=
 =?utf-8?B?WmpvMXE5eDQxM0YwaCt1UW5hZUxPeWlwVkp2N2lPK2pHSWtvVDlPWVpMS0dW?=
 =?utf-8?B?Y0lpUlphSkwvWU1sOERBN0hHV0Y2Uk9qU2xCV1pETTRUa1hORlVyWUc1SmtL?=
 =?utf-8?B?OERnVmdPZ2hnM3NSM3c1ZDRWT1k4ekZjZEtvOEMwOXBxRHk4TDk3dFJXbmhS?=
 =?utf-8?B?TEluZXoxRmx6SkhKR1lIbndXRGtuSkFHM3cvZDBvWEtRNTdmS0J3UmphMC84?=
 =?utf-8?B?Y2ZBU0lyeFg2S1h0RmFsWURoYjFmSjdoazBvVzB4MHNiS21CVGt5QUdXU3cz?=
 =?utf-8?B?aUR0VG1POWpyVkczdXEwblg2aUxZNFp6M1A0cGNtSldJbFFWRG9yYk5kaUtL?=
 =?utf-8?B?M08yU2dud1BmdEJXaGJtVFllbkF5Ym4yUTdmRTY5UFhFUGZpTzBDUTJQNGJQ?=
 =?utf-8?B?NDFHSVhJb2JyQWI2Q0J2UC95eEl4T0ZXTjZMTzBDY2VzM2hIWGViOGxYMzlO?=
 =?utf-8?B?c1JQZVRDWE1jYk1USjhMSzRJd0hCSTYzQkw2aDZhaXNzMWJtY1BNSlUwSENV?=
 =?utf-8?B?OHMrN0hLMVMxQmxhdm1Sc0pzazNnbFV2QytibjJmSDBMeldwaFliUE1SRGZ4?=
 =?utf-8?Q?BSJjPYLv+9rGNFMFWWidZLriy9ikno=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3VUQ1NYUnFYejg5enFUVHVDMCtQZDlWUXpXUTA1RjN1NFBvSUlLd0c1T1A3?=
 =?utf-8?B?NnZCYlB2RjN3LzdZTjR3azRPOUNPMnNkMnU1N2F0OW5KOWkyMHhmeE9VUGRJ?=
 =?utf-8?B?aGxhL3I0NUZwTk5hWXZkSU13Y25BSUorVEpadWpWbnNGbnJPcm1Xc2xVQXhM?=
 =?utf-8?B?RGtPOVRKMEY1VzdzTU9lT3dzeDR5WGxGd3JFSC96aE5uL3FrUXp5dW9Gb3RI?=
 =?utf-8?B?T0ZDcStnZytwcTZ6UHZzWjBwVkFma1FYMnZjb3ZUYyt1Q1Z1V1dKenlvZllX?=
 =?utf-8?B?RzR2UWhKY2VDY0NxUy8zVmN6TGdMZUdvVC8rWDJsNVB1V3B1L2Fka3dGam1t?=
 =?utf-8?B?S1oyakl6NlRGdTYzSXNMNlpQWUFoQjBXbWZFRmx4ZG5nc3pnVFk5b2NCYmhT?=
 =?utf-8?B?RkFWVmdDdUt3eHJXUE9oMDJtOU9hWXcwS3E1Tk94S2RHTm4zMHF3dE03SGlh?=
 =?utf-8?B?cDkrdzBFNGYrckY2bkZLUTRjTkxPWHRXSjVaalZ6WkpPZmErSGIvemtMYlkv?=
 =?utf-8?B?UHVleitzeHFNdkhtYkIvT045NE9SR0JhdjdZMGUwUUlYQ1NLcDBTMkp6eFJU?=
 =?utf-8?B?Zm40TUxBU1VXN3dmeE9teVQ4TzY5ZEsrSU9yRUx2OXc2cm01dmpkZm1rbjNu?=
 =?utf-8?B?YnBjM0tTNFlUZHZvdkNvcDg5QXg3dWhNUHQzQVdrOGdQTStubzhhNmcvS1lS?=
 =?utf-8?B?dkhjbndlZG1SdTlmSjB1VW1MOUhtMGIzVHRNczB5RkVwMkJyc0JyNU9sYTEw?=
 =?utf-8?B?bDJmdDZ3SDVjbXk1NTNjWFduaFczSVhueEVsN0RoRXBZdXhiRmNhMTdNMFVY?=
 =?utf-8?B?dFBHTEFvbS9mNHBGRVBkMXcxUXlPRnlxWlI2RVNvSjJMOUJDU1JsN0c4cmc5?=
 =?utf-8?B?VGZCeUN5QTJqL0lsdVg1SDlIYVFnM2VGWDBNSE5IcHV2cGMvYmFYTG90QXQx?=
 =?utf-8?B?YTFhYlV1Nk0wVGNJVGJkQWgrNnBzRXlKTXQ3WnlDTjhOekRuUzJxZitIWkRF?=
 =?utf-8?B?RURRMUlFK3h3amY0c3YvQ3lOOTBubjgxSnUxOUZXTXdsL3V2YUFDZEU2WWlp?=
 =?utf-8?B?WWRKajhOT21EbnA2bFM1UzdOUzJNZENyejYvWjV3K01FbDUrUE8vSFVIN0Fx?=
 =?utf-8?B?cHhFMFIzSjFJeSs5TXMxd2dKenUxbVpqaVROMXNtd3pLSzl2OU94dFNoWS96?=
 =?utf-8?B?T05BSUdBMEErYUgvbU5SWi9oTGNBalQ4N09mTE1XMXZ5ZnYrVG9HbHZodExR?=
 =?utf-8?B?dTZjcXZMb1FhK29nenhHbjg5ZjY3S2lCejd4QUdXTnkzd0tqWWxtY05RQS9C?=
 =?utf-8?B?Yi9WUFNvY0VwUUtpOWhCaWdSOGNQckcrUFEwcTF0SkNOSVovRjRzQ1B2OTBH?=
 =?utf-8?B?K0hFRFgvZHRrellEZ1dyMGordVdJbElETHpGTDNQMnE0dUtTeWZrTElMbE5K?=
 =?utf-8?B?UFlTMXA0ekZseXFaclFJKzhNa084TzJmV3ZCaHV2Uk5kcFl1WlVOckhjdi82?=
 =?utf-8?B?anRpM0xnYjhTaGMyWitPcEZ2Mi9CTnBvMGFTZDhIMEJLVlBtRXdxaEtpRDJa?=
 =?utf-8?B?LzZDVnFyeFNUcUVQeVpEdis0a2p0Q1hCRllrd0dVZzQ4N2lleGozSXdsN3FG?=
 =?utf-8?B?Q1VjR3Z2M3lla0IvSDNzWnZ4UHYzUGxlM3RUMzdxMUxiRmxGTmdONnIvay9E?=
 =?utf-8?B?V0N0WlNpOG40RXllbE5SNGNSTjN3bjlYaWJ4cHpaK1d5ZGx1T0V2WlNBamhL?=
 =?utf-8?B?RzgwRzdhNlZaWmFZS2NGUnFzM0hMOGp0bFN6OHVUOG1PVDVyenYvdGwrMGFY?=
 =?utf-8?B?bDJ3QUZWNmRrYnRKSEg4OG1RclBJdjdrSldETDRCV1FTaXZhUEFMQ2JKNDFT?=
 =?utf-8?B?UFJGaVJtc2haNU1OcmkyZDI2Y2JLMkdtcTNoNEhoOWtWbHFhY3RxdzFoQ0hT?=
 =?utf-8?B?RkFGbVRBdkxYYldUeGpsT1kyTnVxdjhTL0FXZENCcFlZQXFyRUV1Wm9wODdY?=
 =?utf-8?B?RC9aazdzd0hFc3hwOStVZ2diWVFsMGpFQ3JVYk0xRGdjVnlFdkdPV1NFeXVN?=
 =?utf-8?B?YjhBZzYyOWIxQ0l3SHJaYlhDZzh1bUgzdStkQXR1aXo2WDhvb2VsOHZEUUZG?=
 =?utf-8?B?eldGc0Z1UEZFQU5jdXk4Z1Ryck5QVUdrL3ArdUwyR1hPMGV6NDhJeUtJcVFq?=
 =?utf-8?B?RDFSSlRsaGlFSjF1L0M1SDJpc1lLcTVSN2FsNzRTZGhvV1loaU92cmV2ZXFG?=
 =?utf-8?B?RmlMRGtteExTcGpTdW9MN1N3em42OHZiVkZLYXN5Uk0xOVVQVTh5a25GVUZm?=
 =?utf-8?B?bXpYMmwwQ2ZZeUc2eTZTM1lNR3JkMXhtN0dOUlZmeWN2cHJWSkhmdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fd01de-7d4d-4dee-123e-08de7373f08e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 07:11:33.0542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/HvjzfFR5lu7qtsRBYwK8wL2fHWwvv6zqlVa2lfC7SyeEZhKixTMpu95RWM+fZy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
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

Hi Tom,

On 2/16/26 09:03, Michal Simek wrote:
> Hi Neil,
> 
> pá 12. 12. 2025 v 16:50 odesílatel Neil Armstrong
> <neil.armstrong@linaro.org> napsal:
>>
>> Hi,
>>
>> On Wed, 26 Nov 2025 16:06:41 +0100, Michal Simek wrote:
>>> When the UFS controller is operating in slow (PWM) mode,
>>> the driver is disabled the timeout for UTP send commands.
>>> In high-speed mode, the timeout remains enabled to
>>> detect stalled or failed transfers. This change ensures reliable
>>> operation in slow mode, where command completion may take longer
>>> and timeouts are not required.
>>>
>>> [...]
>>
>> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)
>>
>> [1/1] ufs: Disable UTP command timeout in slow mode
>>        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/868ec1f0cb77ecd6cd8ab1d40feb38e238c6f1d2
>>
> 
> Are you going to send a pull request to Tom to get this to the next branch?

Can you please take this to v2026.04 release? I didn't get any reply from Neil 
on this one.

Thanks,
Michal
