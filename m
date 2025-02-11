Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC84EC0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 03:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D3D806FE;
	Tue, 11 Feb 2025 04:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="re0q2Dzb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 536C3805E7; Tue, 11 Feb 2025 04:47:30 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20705.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::705])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B89E806FE
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 04:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLbvNkDeG+8BUlCF0HfCu9NHT2jsHzHb+lO+LsN2fLCm8xrmJSeUKtysRqkKNDp7cTZP1O8n9m8LGtccvFtOIN+eDvU24YDpOe0B4p9NWC6yi4bjCZ8j4+bvhCKj17isIZqbEwT7+E9w0wB+Chd7Vzqxzori4AnDP5a/2hmO7QBEEdzgAQCAVMrj417yrZotAPw+UcANm99q5iHhdG8PmFjM1uxgViul7QIFEfTJE0nd9yzVMiEfD2gVZJpjVg3D7t65HXvKH6oIEUBUf0xvAZolIOzuqOv5JWuGGoaiuUpe5AdIBWFHUoQsHeq6TMLoDqLWT2FowUSVZtPpXmrzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5U+LkifXle/4fdId1sus/cq481bjWcTrxbOG5sHNL2Q=;
 b=jGI5JHgJ5Bjn1iuWO5+HGIyqckNhAKdaTMPfivW+f47673ivo+QHqUP3CfPH3hXqE3YplrADf0+paTD7SHzcmnJlgthPxjXr4G4Oaafi8uCrF7wb1wzMcL88Gbv94Vu9PAfsSIHIW9UhUInjfqvz/kxzMWCRm3nYHnYrHnZTSf0noWCMiJCFEgcxUy8wa440Ow6bfum5TXusAXhHqRj5V7ZDesZ9w8TezPhIwzfKQPBTxrHAOQehAI4hyNINJbIJjA8SCubEn97Hw9aHBGneKI2/2s9d9zcxMqDqNyLksmHSHvUGf//+obtFmhAgj/c6b//8zGYiHI/Dn9ugInl8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5U+LkifXle/4fdId1sus/cq481bjWcTrxbOG5sHNL2Q=;
 b=re0q2Dzbf/E0p6efDR3e1rhCCWLtC2c6iQbf8wW74vlFBH4VSbkoGQczFIQqVx0GRNmbrubZuxQ3QWryiaD3/aYIYt1BsMM0Ci7uWJRQ2kCHo9OOSSe5z9Z/fxksUbhyD/qWS+3eiOfVR1Z9MgzPHMrk+ZU61YfJXG3oTNJVKwX6hlL0pomVjEdRiiXMdvcAw0G4FjXa6IutEtz6rGuKTJwmvza9gpN4hiywWCwV1Prrllm69YU6UAaGXNNgiWLQqbl10IuHT/c04WYsibEb0p6JlzmmoG/blQpJZl+rgOugUcwPfUCzxv5PW2BL3jxnq0oGEmMuOtWz8djz55BQDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DB9P195MB1779.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:39b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 11 Feb
 2025 03:47:26 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 03:47:26 +0000
Message-ID: <85e5bddf-28b0-4608-b34d-197a880bc799@phytec.de>
Date: Tue, 11 Feb 2025 10:47:21 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] board: Phytec: phycore_am64x: Increase size for Image
 in SPI
To: Daniel Schultz <d.schultz@phytec.de>, trini@konsulko.com,
 u-boot@lists.denx.de
Cc: upstream@lists.phytec.de
References: <20250210152548.1263498-1-d.schultz@phytec.de>
 <20250210152548.1263498-3-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250210152548.1263498-3-d.schultz@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:820:c::17) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DB9P195MB1779:EE_
X-MS-Office365-Filtering-Correlation-Id: 2146f829-1fc3-4b6c-a2e3-08dd4a4ecce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zkl6MTZUNkprSnloa3U3WE9ucFBqYVExRHg0Vk1MRUw5UWtaUDJpdkdueXNJ?=
 =?utf-8?B?V3h5WFFsTWE3aEhaZEI1RFRIaHg1aGdwREpDbm11Vy8yWnFRWm5ocmw2djNK?=
 =?utf-8?B?R3libDExaUJXQkh2Wkx5bEZqb0ZyQ0lhdXUzbGxPcFRqckp4d21wbE42RHln?=
 =?utf-8?B?YXIvajVyMHRpN2Z1azRvS2RpV0NDUDg3T0V3NjhYOHVWQWk1SzNtV1RPOUNQ?=
 =?utf-8?B?Y3laNEpVeFJpYXhRS0VDNVFFUVpHamdjK3N6RytuaG1wTVZQNUVGSUxCTXpC?=
 =?utf-8?B?SllCM1IxVlZVSUdjSXVlUGlCV3NRWWZJNzZPK0NCL2FEdXR1enlhRUl1cFlt?=
 =?utf-8?B?OGlaZ3gzQ05EOGowRG85NEMycTF6ZlZpY0QvQ3FrT3ZJclhqRDhYcFE3M2dH?=
 =?utf-8?B?aFl1UHpzbWdqNDBwaGpyZjBHY2NYQWdBRVhpQ2V6WmMxZFJtMnIzNUdWdFVo?=
 =?utf-8?B?LzdiSGR5RzFPTDBwRndscGZ0YTUwekhIVWo0YUtuQWpzdjhSYys2Qnc0SzZF?=
 =?utf-8?B?V1pLVXkydlp5ZkQ3OW83NHdrMGJ2Qk1RNUdOVjNvWWUrYkg0ZStUYmtEMVlI?=
 =?utf-8?B?d2Eyd29kalZYZS8xQkpLT2IzeU9jQWVlc1VmV0VhYTBCNEpQNGVCclRDMVdE?=
 =?utf-8?B?YmR2ZjFnSWNia2VDSEIvWTBLYkhUcktvdkpPSnZxMWN2R2lBQkg1aGd5Z1F3?=
 =?utf-8?B?UkRucUdjY3UwYngzaDhkcnRjTkRkMlRjMVVkQzN5Q1JBejhaOGYxczJ0b2hQ?=
 =?utf-8?B?aUs2VGNaOUZlWStlakMwQm5Sdmx0MWRQM3Z4clNwRkJ3bDd2RUljR0FwQU5M?=
 =?utf-8?B?WW9uaWZnWUxmKzNQaUo4RmttaGNUNVIxUlhKenVQaGxkRURMOW10eHBnek9x?=
 =?utf-8?B?aG5vOEdCMjJob0wwTTJmVmNHcVhXaStwdzhqNldnUUpvQ1orUlk2dlZ0KzNK?=
 =?utf-8?B?RTBhMFh4WlEvSk04aksrNDdnQUo4eFcwemhVTktvalRUaXdwYlZnWmxuakUv?=
 =?utf-8?B?QU5ubTBNOWlVVDc3TFNFMlZGRGptbzZrQ25hU0s5UUdmbkpNVzA3ZWFTaWhY?=
 =?utf-8?B?VzhIS0dFS0N1MThyUFhhMEZyMWZJK3NyMjJZaWtBVTZWYXBCZWFGMEl6R28y?=
 =?utf-8?B?endFSGhwL1pRS1RodG8rVVpWZ1FCNXJhT1hISmtFUy9IWjJvMlovOGZPamw4?=
 =?utf-8?B?LzV3b1RMSVNEM2doMmpJbGhJbXZHd3psQVRFY2NocXh5U2VpUFdOSGhHZmhz?=
 =?utf-8?B?VzkzcVJmOWU2c3Y5anVJUjN6bG1nT0RQellWamZvcnRnaFVvOFF3TDhRL2Fn?=
 =?utf-8?B?VkE4YklyZG83eHg0Y0ZCWFBrVWFKUmc0NHNPNzNMSmR5S2tSTitoVXZaa0Fu?=
 =?utf-8?B?cUdaVE9vTS9VRUMyb09rTHNVL096eU5WelBOOFQ0YjA2SGMvK2JQN0M0dkJh?=
 =?utf-8?B?UHFHUUxKSmFOTnE3Z0JnMmlsbGlBMW02cWR3RVpPNXpmQWFFWEpzcmNRVjh6?=
 =?utf-8?B?NkRFclFLNnBoeXpqdUF5VG16Y0lLbVA3Z01mbHYzckFFUUhWd1VSUDdkMHFE?=
 =?utf-8?B?TVlxMG5HQWFabi91VWFkclJoNUNKVHJJcFBreHdzK1BVcVN4eWxjQi9XaEE5?=
 =?utf-8?B?Rkd3VzlFWDhRVzhadm5YSGpENEpGcWgzVVlXL3dHWG4yUWZ0UXdJWjNod0hQ?=
 =?utf-8?B?MTZicEE4TDJFc2lXZVd1Nmt4V1JCdWtrWUFTQ2RrMmZraVU2cXRWczJ5WWNB?=
 =?utf-8?B?QkdibTRoTFcvMXM2NXVYL3FIc3ZyWHdodnBLZThNZkZVcS8xNVZqTHI3WTZO?=
 =?utf-8?B?d1E4a081Z1FWbEZ2ajFJNU12L1hVcGJxNHVYY1U1MUFWYkx5YmIxNk5ZMkZQ?=
 =?utf-8?Q?9hTWwh5UxErN7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zy9yZmNOa3AwQzJjTVk0RWw2VUplZmRxN0FONjNtWnIyR0ZMUFkvOVB0UG1F?=
 =?utf-8?B?ZXpXT1o3R3VZalV1SVR6TWtsS0puTmlEYmszUmVLQkZCQmRTY2Z6K3BrRk1s?=
 =?utf-8?B?ZXFSbjNCUHV5eFNnbE5BZ1l4WWYzbFlGR29tT0xCVGY2N0YxTTMybzl3MEZj?=
 =?utf-8?B?TVR0dXZsZUQ2cE01MEt3Uk5LUWxSUStWUEJEZVNNYnZXekFrNEF1ZzRPNTBr?=
 =?utf-8?B?ZjRLU0xVUDgzNE4zRUc4M2JuZlVkY1FIQjRYWmFxSUxzaGNhQ3g5N20xWThT?=
 =?utf-8?B?U1NOU2tiUUErU014bzd1MUtMNkhIM1NJZTJuc29PbE5IKzllQWhRbG50OUZw?=
 =?utf-8?B?TEIyQWFyblNiUExqVW1BSm85VkxpV1Q2N1JMSktaT3RlYVBMNUg0bWVYREZP?=
 =?utf-8?B?OUVYTGlDTUVWMSsyV1I3bUhaenRRUGhxcVBQWTk5aEJNcVpVSkZSSFJRbk9O?=
 =?utf-8?B?c2ZZWWg3VzJRQnE0OFBUM0VudTYrbmtHNDNQdTc1NXl0MUNXcWFlZmh5RFkv?=
 =?utf-8?B?UUYrd0YvTVdXYkN3bmdLb0crWnhYN056dlRLS21KVS9CMHptUG9yaWpxSmlm?=
 =?utf-8?B?c1NaZFpxOU5YNE5aSXNBZUVXNHpQUmpTVnpuV2JVWTY5alAwY0c2RzZ4OXJF?=
 =?utf-8?B?dndtdndtWFVYV3NJTzlJcVZ4YjZuYUp2Z2YxS05rN0NzZytLb2RsYzJLQTJI?=
 =?utf-8?B?U1BLOFhTMHExN0FpNVdVNGYxckJ2RmpBdlpHRmFneVVLZHJsTWoyYjVnejVC?=
 =?utf-8?B?R1dOMVhWTVlCOEtrSGx1WGkzN3hlOTNqdUNnRjY0Q3RDdjZzcFVCdjJndnBZ?=
 =?utf-8?B?WWlTemJqeEhuc2xUOU5lbi9rVGJDd0pYOEJPcXdCY0NkeC9mZytXL1FzM1Fj?=
 =?utf-8?B?MnJxWDR5ZnlFMHIvQUNGVVVtc0FzUXdFbnpYMXMxR0NBbERzaDFkelFzZi9H?=
 =?utf-8?B?em5xUmkzbm9NZTdIQUJYWTlUZkhXcExXK2JLS3F6VU1KOXZRU0RHVW90S1Ft?=
 =?utf-8?B?MndrUVJlUjlKazgycTgwOVRBMWNjUW0xaXBWdXdIeXdwREVBakFGZ3RDMnVi?=
 =?utf-8?B?ckwxVCtmaWZWeGpTdVRLUTg3WVZlaHh5K0p1a3M2eldjbnpocm91UlAzYXZk?=
 =?utf-8?B?a0tNK1QzOXdrVTdqNHJGZGFDV3lTTHVoYzNKanFGNkhGTDJpcXJ4c09MaHdy?=
 =?utf-8?B?dDhjYnhSZXpKdnV1N0w3YkRiVWVyRDIvUEdMYUFFQ3Q1MDQyajNqS2VGQnFh?=
 =?utf-8?B?cmYrMkcwOEZvYTJxeUZXQkwwLzJud1lvdkxqSy9JWnV2SUdYRnF4MnZsL1B5?=
 =?utf-8?B?MnRBTy9kTGFITC9PN3VFbWhJbmZkTVE4MHlhY3ZudFdNN3p4di9wUFJibGFn?=
 =?utf-8?B?Y0p6Q2h0aE52dk92cDlQUzZWSVhNNFVxM2Uxc3lCaHJsb25Rck5Oc2FFQXMw?=
 =?utf-8?B?ZTBZQlhmVVJiMTF5cVZLZ3lZUU92RkYvUHVYSXN1TG9BRlZadXJIN25hNTJ6?=
 =?utf-8?B?aVBaYnZlcWoxUUVBSjByYzcyWlF2c0pBb01rWS8wWnZ1R1dwcW4vTS9iSVlY?=
 =?utf-8?B?SmZLYm1qSFFwUytLSUNEU002c3RpWjkvSlNPLzk2eFBQUTUwUk1JZXJWeE1Q?=
 =?utf-8?B?MHc0Zy9rbjJaY2s0dXh3UFh1Y05IQUtML2xUeUs0QTdHbXdmOEE2YWlnbEtV?=
 =?utf-8?B?Tm55YWpHYWZ5THpRanlnZU9PYTViNnA2N1Q2UnV0Ym9heE1HL05SN25KcnNs?=
 =?utf-8?B?VjlYeXF1Q2dRdjhYRWw1cWI0OVkzbEpqNDAyWkpCdWttOGpHR09LM3JwS2xR?=
 =?utf-8?B?SUlYblBIRmFCZzh0alR0cjh3TGZ5UXh2SGt0VWdOaXRiU1VnS2l5eC9NMWRM?=
 =?utf-8?B?SzhQWU12cmRlS3FnejYwaEFyVWpVbVloQzE4eDZvNHQ2L1FKRmNuR29aWjRz?=
 =?utf-8?B?c0loc0JYYTE3WnlkRDRVNWs0a0RNMGxBMmhRUXIxU1lTRnBMc1phWHVZTWt0?=
 =?utf-8?B?aEQxN09QT05XbTNTS0RoYm95enAxMVB3NzNqb2JiR1AvalZGTUhmOGw0ajJJ?=
 =?utf-8?B?UitzdmRxK3F2UGFsM3FkZHlWSmZRbDRHdnRBeEtSZkpYY0dZRmluVXovMyt4?=
 =?utf-8?Q?s7MX4VnNmNBNk0TTJZgE83MjP?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2146f829-1fc3-4b6c-a2e3-08dd4a4ecce8
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 03:47:26.5135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5U7+iFKPqKUbJS6K7d9v/nzibwrjR4Hh50CRJwe7fnvZAQPhwUTZ69DDVH24xjvTy2wgQG5nw2VqVV8Zpas7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1779
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

Am 10.02.25 um 22:25 schrieb Daniel Schultz:
> Increase the maximum Image size from 23 MB to 26 MB by moving the
> initramfs start address up. This gives us a bigger ranger to
> provide kernel images which are not stripped down too much.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   board/phytec/phycore_am64x/phycore_am64x.env | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/phytec/phycore_am64x/phycore_am64x.env b/board/phytec/phycore_am64x/phycore_am64x.env
> index 3032b518e0b..d69dfe75674 100644
> --- a/board/phytec/phycore_am64x/phycore_am64x.env
> +++ b/board/phytec/phycore_am64x/phycore_am64x.env
> @@ -21,4 +21,4 @@ get_cmd=tftp
>   
>   spi_fdt_addr=0x700000
>   spi_image_addr=0x800000
> -spi_ramdisk_addr=0x1e00000
> +spi_ramdisk_addr=0x2200000

