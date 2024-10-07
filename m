Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A87CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 07:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC3C88D5D;
	Mon,  7 Oct 2024 09:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zmdfQNhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C6288D5B; Mon,  7 Oct 2024 09:31:45 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE4B8885B3
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 09:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIE37fam6EupB1qMhD198sksu9TGamBB/Cv+A9xHTYIppZZlncZN5KUmfRJdvussZMliUatj5U6M7o0L7v55F0Q9rJPl9LtMV+u4uTUOAqIM/rVrdN3KNB2R5/NloqJRpeHr28Pb/07yHYbTasLlQBmLDI/+ALoNLcbS5eTWk2Yx4I4szM5FOZAYYsH9Ugp5ncPoi2OXsnHHF6ee0L+szf9iBj/gdJYEwoXIt1AIeJdJCK7X/O1hhCa9RVf/Ys6pqduX1hx2/NUmFE57OD9nxiYtN//CmMXU4vw7BYQ+NIwXjh/bhfcHj9ho+GDcS04Unjx8702NRosJF+rByeFa4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDTwUI03NV5FI9oi/V6gcRAx6r3CltCbxKDsySjBVTI=;
 b=E5kmCvmrTx5W2q0XYupVkh2pcOnDcIUMAvqY1TgGkMrQ0mxrRhRXCgqbPa0611hzFHPhKnoBzPcNjSlsaYxh0SNd8bhBopA66gwIsebf/zuRkUiU2vVYm0bHaR/DDoxJlPBVBxdAHvY/2Ygu20Py8JAXy6pQpktSShmLTamGoGQKCf9GzmSuXe4uhHmmg98m+PQjuOZJYYiqsSWLM1EFuZ/QIOgTeeo5lzYwF7HSH0z1e38vL3LHDz0Wt7LOWHNZKHhSv7eerLRcbm2PBET99LQtzh7UItBkNxQ8BTAwezBM42dJf8rFHffquVKZdykZ8Cl/WbUNQUM9AwJqgrq+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDTwUI03NV5FI9oi/V6gcRAx6r3CltCbxKDsySjBVTI=;
 b=zmdfQNhXYdxYQ8xhlel5wS5hWS7sCdxZlfpqW49sIH5IOmnqcNSO705xLRcyEm9Wr6lEV9Ge23v2EFnciF3tvgWoOrrnPtnlGqdk70q8oQhcuCZEAwsR+MAiVb92k1FbrrREIZIqVZHRipanwun2DBg9nuw6wMBwO4aQfZEVnlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 07:31:39 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 07:31:38 +0000
Message-ID: <556590c3-5279-4cc9-801f-299d01c4fee2@amd.com>
Date: Mon, 7 Oct 2024 09:31:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] arm64: zynqmp: Update zynqmp tcminit mode
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de,
 git@amd.com
Cc: venkatesh.abbarapu@amd.com, Prasad.Kummari@amd.com
References: <20240930043814.530181-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240930043814.530181-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0036.eurprd02.prod.outlook.com
 (2603:10a6:803:14::49) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae5e7ae-0e61-478a-2af7-08dce6a2149b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlJuRG8yVlBGOHVEb3U4ZGlqZTFFTCtiQVVHeVBEdjJGVFJHV0FGSVF2cWor?=
 =?utf-8?B?c2NwTWQwcUNkOE9QNXFTNUtFZUx5TmRBaGZiWC83WXBxWUVrQ0RPUmpLNWJE?=
 =?utf-8?B?Qzk3K1k1SWE0eHMzbHlRQmNLZUVRZDZra3Q5d016QXhCTm05RThKRFdlcDV2?=
 =?utf-8?B?OTl3UGhwVERzWDZ0bXlwU1NQalVkSnRWMVJidXRUb05FWmQzaDRVZFQ4L0NM?=
 =?utf-8?B?Z0N3b0hoWTZyQk1KWnQxS2hDU2t2Q2NSNEljd3A5L0JveXJUbWFWa1lkWUY2?=
 =?utf-8?B?TWZxWm1VUFhNVkpTTkg0Q3NESTRrVHZnazNvcTJBa2N6Vnp1VWZLVjlVWkEx?=
 =?utf-8?B?WGl0S01heSsxNkFnNjJQWUdzN1lyUGVTTkNEakRqelFpUGxpQlRXeGtkUENR?=
 =?utf-8?B?OXJEWFFESWdzdjhTVkJTMms5aWpqWGxnK3ovdHdHekwxUkZpejA5YmJieXAy?=
 =?utf-8?B?Q28vcHdYUTlXMWQwM3VrTUQrVzdocDU3UllpVDdsQW9EQk9WbXFwU21Zamty?=
 =?utf-8?B?bE83b2NuS3dTUjhKdkl4cE45enk3cHRHb2JleUpTaTZYVXpWVG8wRzE1Y2I0?=
 =?utf-8?B?T211MVZLSDFteWMwREpVUUxsQVpzZHFvTStSYzRIaWwwZk12aWdPZnJ1cUQv?=
 =?utf-8?B?a2pPWmNCUTg1NS9ZQUhob1IvUzR0Vi9rNXhFV0xUd3g4cUNlRjlkaGVXMElq?=
 =?utf-8?B?MUFOVnhzbCtjSzhuMnN2cVVNZVM5SmEwclFnMzBzVlA3NU01WWtHZGNXcllJ?=
 =?utf-8?B?cU41a3hHb2ZOZWNRaFo2eGFkUCt3ZmtycHdhUzRGZUdDa2s2U05xZmtDVWpV?=
 =?utf-8?B?NEhhYmxwVjhhVGUwR2haSzVOaFBVVUtkejVxTml6bCtDbGIwa2tkQXBOWXJY?=
 =?utf-8?B?dUltb1pGelpCTVhQOEJkVFZWVG9rUTE5cVdNTWJLMVdkaHI2ZUNTb0Z6VW0r?=
 =?utf-8?B?S1dwREhXTDdTUUU0bmMvcGlvNnRreXlQSHlOQ3loaWZRY0JTOVEvOG96ZFd2?=
 =?utf-8?B?VVFPRG5xQ1Q2U0FrSmV3ekdNUFhwTmZFMHRVTlBObW5wVzVEYnZ1TDZGZTJi?=
 =?utf-8?B?QXVxOXBCdW1DUTVRQWkrQndzczVsUmJKQjZKVnBGMTV3RTFKUGxZblFkWVlW?=
 =?utf-8?B?TUZUTXZjL3N0bWpIc3c4UjJtZDRzRjVLKzJsTzY1VEpOU2MrSUFucDJhQzU3?=
 =?utf-8?B?ZDVteEcrZUJIcXNhbXVER1JkSk03ODhJMks5WnFtUFA5RHh6d3lUbTBGZ3BH?=
 =?utf-8?B?bk5FZlRITlJ6MGNPdEZOdCsxN0YwdHh1dkdWWEw2RUwyZ251SEE0UEZmMXRk?=
 =?utf-8?B?OHZTc1BUaDRuUzJwSUdHQ3ZURWF6dUJXTTRhakdIczRwMXV5MkQ4aFVYNlFs?=
 =?utf-8?B?RjAzSGgyTkplYmNoRDNURzlZdkY0YjluK0JQMWxIeUFnakZKMUF2M05BZW1G?=
 =?utf-8?B?c0lrZm95WkVRNXByUjBHaEQyZmg2YUl0MnQzZFFwN3dtazh6MU5wNVIwNmh3?=
 =?utf-8?B?V2pVVS8wMEEwSXc2c0JDZkRRblh0WC8wa2NsSm11SEVLNzg2OTY1aHZFczVp?=
 =?utf-8?B?RFViUlp2QTBRSExBZURZK3JFMlVDczk0ajJnaUNMZ2taQktmdG9NTTNYL0JI?=
 =?utf-8?B?M25idjBzcDEyTGloNXd5OS93b0NLUjJOMWNTbis2SmJhbXFsWDV3YzN3RDU5?=
 =?utf-8?B?VDlkYm1zUFFaRGwzbE54dmhTMEhqMk10M3drS3p2MXRGSVAxalVhQkJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU9UZldRSTQyMHhiZHNpdjhRMzBjNFdiTUJmSzdzaTlpbVVoMzBHZDQ2OFly?=
 =?utf-8?B?TjB2RU5zQks1Vk5GZkFQVXpBNkswb0pOZ0FQcHYzZkN3QllraGZKOTJSRjFU?=
 =?utf-8?B?c3ZXYnhBUHRCZkZaQnRZYUtLM25IR2VhcnNiVG1SVkE1WWNxSnFpa1FsejNi?=
 =?utf-8?B?QXVDRXZsZ0g1bVo1TnlFZW1hVXZlOFB4YjBjS04yNkpyU05QajhjczF2WmU1?=
 =?utf-8?B?dDY1MGZPTDdzMko3STh5VENZUFNUblBBT20wYkJHNDR2UUlZbXNZTThselUy?=
 =?utf-8?B?bEdLZGhDTE1aOUFWRWJ1bXlJUE5HQU01S2lrclMwTzArTkJaZXRUQkxqN3Ir?=
 =?utf-8?B?WWt0M0RObk5ucUxlaTBkQ1RWMktxbktMbkpZMGFGZEZNb2R0NHlzWCtEZjVO?=
 =?utf-8?B?QzJYaFdMaGlnUUEyODQxU2x6ZEZCRW12QjFRNndRdzh2NGRaSzFqL1lQSjFz?=
 =?utf-8?B?UGZIMUtpU3Q0TkFYTHlXSURWL1JlbnVUcUFnUTIrQk9tZERBYTJOcSs5QkxX?=
 =?utf-8?B?RE1zSXFLamxDdXhGTC9iN1FBSmNxN01iT29VaXNqMUQ0aDZIUkpjQytGRUJx?=
 =?utf-8?B?VVJ5ankrRlFVYldaemlTTlN6WTliSDRCaitXb1hnUEdvRzVyeERxTVFEaGpJ?=
 =?utf-8?B?OFVUbzlBSVF0UVUrVkJMMzRXY2R5cjB0THMvZzRja21SdUNBWlk4M2cxL3dv?=
 =?utf-8?B?d0pGNlZmSDlRTmcwR2NYelJlazZIRHE5VlJLQmtrbUo0ZWxiMXhnS2hTSmZM?=
 =?utf-8?B?Sy9yQ2V3SlNzUVRVbThrYVlNSkNaVWRJeXltQTY4OTBkUjZoNUx6Q0kwckFl?=
 =?utf-8?B?am1jdlY4QVRqRENKVEhuQzM4V0tKQnljeXY4a0twOTQwdlZkY3JFV3d5V0R4?=
 =?utf-8?B?bVBoMFg5eW1BTUFSbFhXNTlheVJWOXFGcWdZMlJNMFBHRVBldmFqeGdSVllt?=
 =?utf-8?B?VVo0T1Q5Q0czV2xjM2FSdFYvSDJCcjM2UHdFYUI5Y2NoQ0hqN01yZnBBM1Zy?=
 =?utf-8?B?MEg3L3RYdlVTeUVqZVd5eXdLc1dGbThOeU5IOUVEWnd2UTlIeWRram1QZUp1?=
 =?utf-8?B?K3JhdTRoTHh3UExIcElTaXVKSjEwQmQ1dFFMUkVFQmt4Q2hhL2JVcWtRZWxN?=
 =?utf-8?B?clE4Ulg1cU5sQVZpUDRVS1JxMEVpa1laTDZJYWZuR2tyTDUrN0I3Z29mVElw?=
 =?utf-8?B?RHlwZDc2STM3SnozcWxBajhFaDU1QVVHN2xIWHg3Vi83VkhkK0RlSEd2Y1hH?=
 =?utf-8?B?bitKVDIzdU1iNXluaUU1M0YwdGRPbGNLaUY2cTNFNnJmYmJ3RXJpK1Awektk?=
 =?utf-8?B?RTBlSVhIQ0dEdGkxa3owakRsd1NNUXlJc05UekI3dndMK09PRWJVRGJFSjJw?=
 =?utf-8?B?VEF2VG4vOVhpWkxVbkMwQnNvZmp3Z1RNRFBZdjRLb2k1Ny9mTm1ua1QvR1Z2?=
 =?utf-8?B?N0Q0QkMwMjh0NzlQcTVZemFXT1BjQ3U3MTE0VlJsbld4NFZ4ZlY0cTJMYmsr?=
 =?utf-8?B?RHpzczRnZUVJSXg5ZC9ScEt3STAwNUNxV0NobFFadTVLbC9aZlcxZHJZMFpi?=
 =?utf-8?B?dmtHbUdmMFBFYjZ1UEQwSUMxZWliZmhaY0hsQm5pWTd2SDRsOGVYN01qQjND?=
 =?utf-8?B?dm94SklEQTJKOXdvUFYrQjllTlNGQ3pHL3RPc1dEbzZqMnE5YVFqVlFyV21Y?=
 =?utf-8?B?bmxkRTNWNjU0NDBiSGxyNE9WVkhTOGo5eUpFZGVQeXRmc0lOd1F0bVVoTzZn?=
 =?utf-8?B?SGZ4MUZNTHJRU2xoYUNxOGtHcXhlN2R6czV0MFZHWHNoQ0VFSE1TSjZ0b1U2?=
 =?utf-8?B?VnViQmJKQithMzREWkRaRWNpM01jczJZUUJLVVBqYVdKdFdseEhGZDRHbS9Y?=
 =?utf-8?B?WXdqU0Nncm1KeFBJNk9mYWJKR2xuUFlpZHhQa3pBZ3FtbmgxcE1kbUhFdm9p?=
 =?utf-8?B?aFBIbHRRUHhEY0xUV0FxNHhmV05DTGxwZSs3WFMrc3hlTUtmWVdmRTlUR3Jx?=
 =?utf-8?B?Qm0zTlNOMDRDNWV5YmE5REhsVWNpT3l5T3RMdEQvRUwrY3NiT1JQTURVZVpk?=
 =?utf-8?B?c0FZSi85dGtaaE43WEFISFZuZEg0Z0U4YlRoUHpEWmc2d29EbW54WWh5OTFk?=
 =?utf-8?Q?P2IQ/Jep/QwhRjI6d4zouvlcN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae5e7ae-0e61-478a-2af7-08dce6a2149b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 07:31:38.6821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfwNT16v2fp72wrqsP58L34QaZmvHXkVuWVfg7dk7MUO8LyD9UrqCme/afzs6Xwn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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



On 9/30/24 06:38, Padmarao Begari wrote:
> When cpu is enabled, the zynqmp tcminit throws an error message
> when switching from r5-mode "split" to "lockstep". When cpu is
> disabled, the zynqmp tcminit switch from r5-mode "split" to
> "lockstep". The mode value is assigned based on string compare
> for "lockstep", "0" or "split", "1".
> 
> Changes in v2:
> - Update commit message of patch2
> 
> Padmarao Begari (2):
>    arm64: zynqmp: Print an error for split to lock mode switch
>    arm64: zynqmp: Fix tcminit mode value based on argv
> 
>   arch/arm/mach-zynqmp/cpu.c                    | 16 ++++++++++---
>   arch/arm/mach-zynqmp/include/mach/sys_proto.h |  1 +
>   arch/arm/mach-zynqmp/mp.c                     | 24 +++++++++++++++++++
>   arch/arm/mach-zynqmp/zynqmp.c                 | 16 ++++++-------
>   4 files changed, 45 insertions(+), 12 deletions(-)
> 

Applied.
M
