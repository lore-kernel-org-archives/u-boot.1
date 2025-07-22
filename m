Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D925C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 08:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 901AD83314;
	Tue, 22 Jul 2025 10:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="we9YV4lW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BFF18331B; Tue, 22 Jul 2025 10:33:01 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0393A832C8
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 10:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSBGfJJp13ovcYtS8ncZL/kkRnKZyTWlbQLTXhKvRG9UJa2jb6pEtm5144sxmHA5AuTLvlK7Vtt7FLIgtpOld2X13uKvdwHr6dyXzhYeF5QabGOxoaKlKKlCm3ZUNjlcyCFGt4eoGxNxThwA0wpgniMGwrHy4O4Vug2X7vEjPIkSlGSoIyAr+xX8IvyTzGjzbClHL/ur6a4v6ucYprbP/nlb1ssyjAdwkgo5yaK/lXXTVLmOvaK4+MGjWwrDaeGww6Wo4EYPuwddkEDh854KM4daiiJ4RzqWqDQdTJX8R/Zg5RTMDbAPqgdZaJXW5EiupH4beVwqs0OmUVPFGoWvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Dj3jmOwVAW+rupl1wJHe3AizGMRFy4fRrI0ty0+FBY=;
 b=AAFX7G28TXWLHy2NOcDo59qxXnJxaCzIrdQ1ue5h3aCIOiqsBcYPICdwRiwdiAWXG1KHVZtUSV3aqxdRyOSH2J6Qc9puxxYlbpiCYKQDeTCqVE1u96fcjG+VgXjbkMu4QH2EbNDfVqC2v0g7ElJG7SJnQhOsgVl4g62PexZDckktIzOXMoxXBxDOp845yT0HyW9E9Z6t+XptXEviW+EePFt/REPViQfFapDrDdpOQD/HvA4zeB3UpFNErvSFDwoPlSiKURTfBXwHyR5vJAURhE2C+3A4b2OICkhfcKFonwWHsaqhXXpagXZ8hniSA+xLmMefC5RPj8El0ca7nEF5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Dj3jmOwVAW+rupl1wJHe3AizGMRFy4fRrI0ty0+FBY=;
 b=we9YV4lWWnNgQKvMDFpOzREtBx4nISXvNDl3Sk5MKh9QwsxMNpEyKROZPHlBTHvu3cKOrYh0ompizW3YdDKYbURObWeZLT20Hhl8DDpsgh5NlNYkg14J/h2JHl21NLqXMiZsAtLRe5TMXMPKYhU9+rtlG40DGG70GQ0m3cXzGexrZpe0mxcEhmu7UMj5ROl3aW8OftjB1JZvgnQaxZVGUh3sFnBE7WAcJu+19idwqIOsnTRBeowlsCJXJtzMv+dDbjMxZq2P0t9a53Ll978dSAMGRMLFXZFAXEVqrwte+7lxT1CP19Dlk2CuLYUn8v9wviwvd4tntBYIsN9utgmnag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU4PR10MB8855.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 08:32:57 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 08:32:57 +0000
Message-ID: <952009a5-9483-4729-bf33-ba83c48b8835@kontron.de>
Date: Tue, 22 Jul 2025 10:32:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] imx: power-domain: Enable refcounting on imx8mp
From: Frieder Schrempf <frieder.schrempf@kontron.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Samuel Holland <samuel.holland@sifive.com>,
 Neha Malcom Francis <n-francis@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@denx.de>
References: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
 <20250425-ge-ian-display-support-v1-2-8a7a0fe75023@bootlin.com>
 <0a2c9ba5-a0fa-4cd7-9e29-0874cf085f2c@kontron.de>
 <ef633109-6f01-4d45-8d72-1f04a9051629@kontron.de>
Content-Language: en-US, de-DE
In-Reply-To: <ef633109-6f01-4d45-8d72-1f04a9051629@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::13) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU4PR10MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b92d97-15ed-47c2-0b08-08ddc8fa5bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1ZHRGtRRWJaLzNNcTRoYjRLT3NhYnBUb0NrVHR4T1l5MGM5V1JsMmdoQVJO?=
 =?utf-8?B?SDdKR3lvOVBGMkJOZDFCYjRYM3laV3RPOTJpTlFqM1o1WTM3WEdSajRLbTBE?=
 =?utf-8?B?MWhiUGhRa1dwL2wxSndnVyt0NVZSOU1OUFNqbnFyeUpVZlI2YkVyNHRNQkNR?=
 =?utf-8?B?K052NlhoUXE0ZzhDSUIyZU1WcjFGMm4wdWZmSHIxOFlpQzZnWnp6MzNvalkx?=
 =?utf-8?B?WFlKTGE1Wm1PS1h2NFNqRW1FcC9DWmd5N3NqUW1OZThQbkduOWg0TzEydHpD?=
 =?utf-8?B?MFVUWGQyVFh6QWlEZURkV2FjZFhqVUZOZ08rbWJ5czE0RG1TbTJ4RlVOZ0ds?=
 =?utf-8?B?K29zeDh6aVRIOENydzNFaVFEUjZtaXA4QjlBMjgwS3FNR2ZKZ2ZnTm93aVBE?=
 =?utf-8?B?LytPT0FhNWZRRnFUbmxmd3dIL1JYSmRQeVhKbUZlUlRnTUllTUNEOWpLaE04?=
 =?utf-8?B?RE5wUkp3S2tnREZJVG45MjVMbTR4ZWFDYTVZdnRLdi9Nc0tCcFZ4M0E1Wng4?=
 =?utf-8?B?dHpYOXlzeEZvekN5YlNDeFRDVEVnNE1Bd0N1QU5Eb3NtR2Fra2xxNXhZSkVK?=
 =?utf-8?B?bTdCWWtvNGk4cm40cDYzL1BOcm1zSHN5cUhrazc4RXI4UksrZXNJUXY1clE1?=
 =?utf-8?B?U0VxZ3hndGZFRTh1M1RXendlUit6M3V5NUo2elBYL1YvRytDTFlqYzZKc01i?=
 =?utf-8?B?RlhLdWZDazZRU0thVUJvRlk0d2JZOHUwcjl3NENpVStkSmE4cnNzUFhqT1Vy?=
 =?utf-8?B?amRtK2kwRWFBN2tmWnZSOFFkRTEyaDFycjJtaENMVTFPMWZLNVUxR1B2cHAz?=
 =?utf-8?B?VW90SkRFcFNDQ1hpUUJjZ3E4bnd6Q2ZOa01OYUlmajZFSU1NSVZkNnNlTU1k?=
 =?utf-8?B?NDlBMm9wREZOQ014TVhFSGRueTRhOVgrMW5HeDRWT1hYK2FNY2ZuZGlsTVJR?=
 =?utf-8?B?bHE2QzdiUjdhVHdaK3VNOGEzajZpVXM0UHBPYmdZYTlUSWl5V0JGSHBOT1lF?=
 =?utf-8?B?aEtYQkF3ams5ayswdnNDTFlXOXZnMTljVWlpNWY3YzdBRWFkSDExd3FmL3ZY?=
 =?utf-8?B?cHlLYmM1MUZFTGVPOGVGKzR5Tk5DTElSeXJraGo3Y3NvMnJVaGVWRlE0STdt?=
 =?utf-8?B?UVkzTCt1ZGkxVk5veE5YM1RuK0J0S3FkanNjY2tkNFVhcEZqQXg4S1NYZVZm?=
 =?utf-8?B?Uk1GQ0hUdDRpN1hNYy82Y0YweWQ5cW0vTnBOQzZSRlpuRUd4dGgzYVhFQTRT?=
 =?utf-8?B?eXNXdGN0VmFVQnBJdElRaTNhNmZmK1NLem5UQWFTempsUjgvQ05jTG1LbG5u?=
 =?utf-8?B?aW0xQ0dyWUdFOXJ2S3FZUklBT29FV3ZaWGgrWTQwSnZod2Exdmx6VlJzMXpr?=
 =?utf-8?B?cThZWmcyQ0VneDhUdnArTDFmRGpYUE91eGNYUzZKRndJNnk5dDU1cTRDRjdW?=
 =?utf-8?B?bnUybTNMNmRaTExXT3BPb3dLVWZIVUFpcDk0dU1qc0xXa3pOQ3JrRmxxbVcx?=
 =?utf-8?B?NFdqNStIZDVFNXE4OE9yR3J5M1FkRldBR2JVVUplTVEvNGVualc5Y3pLUUsy?=
 =?utf-8?B?THE0azBUWDZrTmFtRkhoWlUzd2ducHMrOTV0VkMzUXJtVjk2K3lnMVpNb3ZM?=
 =?utf-8?B?YitXUWtIbzlheU1ybmt2Nlo0VUlYb1lONEs3UXlROU9MZ1FKSjdRL3VaSGY2?=
 =?utf-8?B?cVViZnRyNEpxVG84cnZKcXlEMnlCcWJTZTZ4ODhQL1RPVG1FUFV0eHMzRDVu?=
 =?utf-8?B?d1F1NlZZbWIydXdpdEZDMmF2amxLelhIYjZ6dHF2VWgxckpMMUVvYXp0QUdp?=
 =?utf-8?B?VXpNbW9JZjR2bjlnWnc5M1R6V0wwRUEvZUZOMFo0L05pSHRaWG1FQ2dmckxN?=
 =?utf-8?B?aGttUnhHaGQwM0RaM1B5dmdPWFc1eXg1NE9QdTUxRzlHaGRLUzVieFFHaDZh?=
 =?utf-8?Q?GpWbpDqA8rE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzFLQ3prSHB1TkVQMG4vdjJ3Z25MRzRHby9YeCswVWtxVkdBWGVRbXF5YldX?=
 =?utf-8?B?ZnFxbUtWTXIvRUNkQkhMckZ6NkdwSFREN0g0RFhqaWRNTmtkUWIvNlBCS2NX?=
 =?utf-8?B?ZjErZ1hZbGRncXBxdnF1b29JYTN3aEFmMUdxWVZabXRWS0k5ZW5LQ3d2YnVv?=
 =?utf-8?B?V091OXNzUEVVZHN3K3Z1U2xHWXlrQmRTMGhQeDA1cXZ3dVZMRkhSTnpmNE9V?=
 =?utf-8?B?aUNCV1p1ZXQwMVBiN1ZDS2FJTzVtdVplc29icTlveFBnWlZQZFJzUXRjNURM?=
 =?utf-8?B?SGhNZVRiMEc4OU9ZVDBjWmJaQmhJWGc3VUFLM1VtNHEzZEpWVk9UbEx1TzR5?=
 =?utf-8?B?S0JaVE1TUFIzMkJTN3p3Z0xGOEpjcFk3S2VqOE5HcTBFUkNqekxidnk1WEU3?=
 =?utf-8?B?SEVpVEdhazllWXJnZmVJRzVUMUlkUGV5RU5QV0wrRDNucGFLdGtXMXdUOGlD?=
 =?utf-8?B?U0FWNWRsOUNtM3RyTElUdFBWRkE1a1o2YWZhQ2FYL3R6emhKbjlTSGsvWTlT?=
 =?utf-8?B?MDVhNVJlT01kR3JnUmpNckZBa0wvcFJDYkx1ZWNoOTJPSWFsOHZvRVRBWkJn?=
 =?utf-8?B?N3NQTW1paEF0RnljRERvdk13a2RpT3FtcVY5UzlhTUkrZVJVeXVpaFRhdGxX?=
 =?utf-8?B?ZHduUkhyOGw3bGhMMXpxTXpHZkpOL1NpR2tyNENUaVJhbkVxeTUxeUlrbHph?=
 =?utf-8?B?YkViV0k2YnRmdlRKNGcwN3M0bTI1dkhJQUtIeTlqR2dydThQVHlKcTF2R25Z?=
 =?utf-8?B?VFJpSEp1L1AxNHZmUVhFSzVDT0tPREV5VlZHdXBDMk5kZzBhWFVnUTA5T0M5?=
 =?utf-8?B?WnhaMGYzNXFsamo1UmY0WTV5OXJidllqL3NZUlpaSzRHTlY0NjJpQmpKSmRv?=
 =?utf-8?B?ais2b1JNQm91NEk5L1ByTDV5c09mdnJwdVZrWk85dHp2N2FVUWFoamNjUVFy?=
 =?utf-8?B?RkNsMTBKNnBxNFNBSlRhN0pXWEIyT29INWRXUTVjWFpMaUt2V3lVNFNRUDRG?=
 =?utf-8?B?bGlCRlU2dHZhS0xscDJORmlLMnhqY21Kb05ZM0VYNllRbzJiY3Y1VndXbDNL?=
 =?utf-8?B?a29ldmNqYW5mZ2l6b0pjYmhWNnNYbUVjUkJTVUJVVmhqQmNXMFVpUnlxZEZF?=
 =?utf-8?B?akY4RnlSNkVOajFUTDJWVHhmd2tmYW1iRXcvQXovVTdraHQ0MzlRcDJTUUtO?=
 =?utf-8?B?U1lrNkNtZnFrdnlENUJZdDJJS3NoRUlUMzdEdDNTSG5RNklKYXdQU0RpMGM3?=
 =?utf-8?B?K0xDNTJtVjJPWXdQZWlHamgvV1BFeUR5RUZzTlEzTE9LTUZ4WHJVNDR2VC9F?=
 =?utf-8?B?T0dXajJaUU5MNVZaSmk5dzVMOCswYUpZaHI0TWJYdFY5KzlSVGd0d3BOQWdQ?=
 =?utf-8?B?MEV2Q01scFk5K29GSFFyc0FoS2lYV01LdXdZdFkwMUhoYzhvS2Z0ajBtUW1E?=
 =?utf-8?B?S2hhelV1VTRUYjR5YmdtQW9CTWgrYnZBK2xuTHBWUEtIQ1NmT01nbEd6Tmta?=
 =?utf-8?B?NHMwZXFCdjI1SExWSjV4NEZvNUxtelpHSExnS1AvTVkrU2VuRVJXMzF5bVZC?=
 =?utf-8?B?VnlvbkN3RUpsNmNGbGdkVU5pc2NGMzZ2TU9KY0hjUEFIN2d6aTAvRC9yRXND?=
 =?utf-8?B?YXhpTGtva0U1YlhSME56Y1dkMlVJZnpPZlhDY3RvcDU4WUNSVkhYbWtYem1M?=
 =?utf-8?B?NnF1aisyKzg4b3Rac1crcyttK0xTQlFEeVJISmpUVUpxMnpGMVFCN0xnTmZI?=
 =?utf-8?B?UnFFVE9QbkZBaFVhQWxDQlI1aklMYzFFSXp5ZmxRb3AzNTFSU1ZhdFRLL3VP?=
 =?utf-8?B?S29sWjJIdGFMVlZ4UE5EazJDazNhdVRia2puOEV6L0tMemRhZ0VQc1Z4SUpY?=
 =?utf-8?B?RENGb05UTjdSTmFkdjc3TEpNaWJ2TmR1c1I3cHFhaExtS0t1Wkp5Ny9VMzBq?=
 =?utf-8?B?RkdRQnlxdkJpRm1hUkRLREkzYmxTU1FoY2JaZFBYa0RYc1QzK2ZSeXRZbWc4?=
 =?utf-8?B?NkJIZk03UHRNMEthbXFVeTB5cks1U3p6YkUrb05ZczRBbHRPc1YrbE9menlL?=
 =?utf-8?B?RlAzWFAxcWZLV28wZ3Y5VnFlZ0dCSnlyWTRGUWdvdjRmQ2N0Uk92UVFuNGY3?=
 =?utf-8?B?aUg3WHNOQ2llZ2VjcG1DTWJsVWlrYjFFM05YdG9Pb0VUSnN4amE0Zm5JMEdw?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b92d97-15ed-47c2-0b08-08ddc8fa5bee
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 08:32:56.9333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUT7k2G3m8WjRJK26jcIZ4aIE5UVsT0sfRIORmTumzJUt/t69F7p66Wwh2dy2TmZn5pvYFRTDHSJmLKkBQa2bQ2HcphsTBUfuVoc3zBzZr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8855
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

Am 22.07.25 um 09:26 schrieb Frieder Schrempf:
> Am 21.07.25 um 18:01 schrieb Frieder Schrempf:
>> Hi Miquel,
>>
>> Am 25.04.25 um 08:49 schrieb Miquel Raynal:
>>> Prevent enabling/disabling multiple times the same power domain to avoid
>>> breakages due to the same power domains being referenced several times
>>> by different device nodes.
>>>
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>
>> I've stumbled upon some issue that seems to be related to this patch. I
>> saw you already had to bother with other breakages of existing
>> boards/platforms in the previous implementation. Unfortunately it looks
>> like this still causes some kind of regression in my case.
>>
>> I'm working with an i.MX8MM board (kontron-sl-mx8mm_defconfig) and I see
>> a crash as soon as I do "usb start" and then "usb stop" (log for the
>> latter see below).
>>
>> As soon as I revert this patch everything starts to work fine again. Do
>> you have any suggestions? The power-domains involved here are pgc_otg1
>> and pgc_hsiomix defined in imx8mm.dtsi.
>>
>> Thanks
>> Frieder
>>
>>
>> => usb stop
>> stopping USB..
>> Sending event 6/(unknown) to spy 'efi_disk del'
>> Sending event 6/(unknown) to spy 'efi_disk del'
>> Looking for power-domain@0
>> Looking for power-domain@0
>>       - checking gpc@303a0000
>>       - checking power-domain@0
>>    - result for power-domain@0: power-domain@0 (ret=0)
>>    - result for power-domain@0: power-domain@0 (ret=0)
>> "Synchronous Abort" handler, esr 0x96000005, far 0x4ebacdc50
>> elr: 0000000040249c94 lr : 0000000040249c6c (reloc)
>> elr: 00000000fff4ec94 lr : 00000000fff4ec6c
>> x0 : 0000000000000001 x1 : 00000000fbf22750
>> x2 : 00000003efbab500 x3 : 00000000fffcdfb0
>> x4 : 0000000000000020 x5 : 0000000000000020
>> x6 : 00000000fbeea10f x7 : 00000000fbeea3d7
>> x8 : 00000000fffffffe x9 : 00000000fbeea1ec
>> x10: 00000000fbeea280 x11: 00000000ffffffd8
>> x12: 00000000fbeeb1b0 x13: 00000000fbeeb1b0
>> x14: 0000000000000002 x15: 0000000000000000
>> x16: 00000000fff4edc4 x17: 0000000000000000
>> x18: 00000000fbef4db0 x19: 00000004ebacdc50
>> x20: 00000000fbeeace8 x21: 00000000fbf21ad0
>> x22: 0000000000000000 x23: 0000000000000001
>> x24: 0000000000000000 x25: 00000000fbf28f10
>> x26: 0000000000000000 x27: 00000000fbf2ad40
>> x28: 00000000fbf2ada0 x29: 00000000fbeeac70
>>
>> Code: f9400693 d37ef662 ab130833 54000140 (b8626820)
>> Resetting CPU ...
>>
>>
> 
> FWIW, here is another log with only the debug output from
> power-domain-uclass.c:
> 
> => usb start
> starting USB...
> power_domain_get_by_index(dev=00000000fbefacd0,
> power_domain=00000000fbeead28)
> power_domain_get_by_index(dev=00000000fbef7450,
> power_domain=00000000fbef74f0)
> power_domain_get_by_index: dev_read_phandle_with_args failed: -2
> power_domain_get_by_index(dev=00000000fbef7560,
> power_domain=00000000fbef7600)
> power_domain_get_by_index: dev_read_phandle_with_args failed: -2
> Enable power domain power-domain@0.0: 0 -> 1 (todo)
> power_domain_get_by_index(dev=00000000fbef58b0,
> power_domain=00000000fbeeabf8)
> power_domain_get_by_index(dev=00000000fbef7780,
> power_domain=00000000fbef7820)
> power_domain_get_by_index: dev_read_phandle_with_args failed: -2
> Enable power domain power-domain@2.0: 0 -> 1 (todo)
> power_domain_get_by_index(dev=00000000fbf239d0,
> power_domain=00000000fbeea288)
> Enable power domain power-domain@0.0: 1 -> 2 (EALREADY)
> Bus usb@32e40000: 1 USB Device(s) found
> => <INTERRUPT>
> => usb stop
> stopping USB..
> power_domain_get_by_index(dev=00000000fbf239d0,
> power_domain=00000000fbeeac88)
> "Synchronous Abort" handler, esr 0x96000005, far 0x4ebaceb90

This should do the trick:
https://patchwork.ozlabs.org/project/uboot/patch/20250722083119.64084-1-frieder@fris.de/
