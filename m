Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA67FC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 10:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B8288363C;
	Wed,  9 Apr 2025 12:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="n8tYAjgg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A4278364E; Wed,  9 Apr 2025 12:57:14 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 476D483622
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 12:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvzQtP0IJEnU6Dgr4kKKKCsh5LdNFqIRN1MBxq406JFAY6vfAedFoWeLqL9OwZ7O6U/BpwFI0+QwZFkBjUpVlIpKbMGk4Zq9BZccIwJhytcucgVuMG5R3vyVIzbmE+tezekk64GtX68Jf+REHS7TIo4ET2lPOCfrk303dMUr46lVScwY5hdRjjivINAvKLF7IROei63PJW5RVy9quR3SXIpc4dqTfPW5Gf5nmUuwdwysUgoW3cYTT7BqU/UtEwSQa4JV4imTclZ1H6L9wj0T08xTJ9O/Ux2XoP3m9n9R2v9XRh+zS2RUtujn3SOePCL44uNDIGXX6gby5P58OCvRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnzC5RwbFSiDXWxpTQiwBm30vePZJvmAhu79ueIJ3ZU=;
 b=J6WvaZNi92GWxsITNn7NXRaCO/eSl1G2K/8x8EpbVPF28B+RSyBtNO9jICZpz04p9gamtk0aoVX+2+4mbL52doH4x+Mi6FOsPFFW/Yzz8kqEGdbrYMJYW/kcskxz8ot4/mBmiLWpQH3vlMMKoOkHkP1hQXH2zPidsfuU/9sEYKWLJK+NcnfLZQjSLfsLH7gEEqG/96ELfBEJNFKZ3FddVBqDh8EFcvg8ppoE0J7trj4konnu2kl/u52zMA8YLVP3bevpZ5bsBlHbjD8nSb3ENNyKerYuntXGG/91m8ObuwyhCFTwsXZ+ifoftH9XYVFHICYntJCov8DvRN3ZLz44KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnzC5RwbFSiDXWxpTQiwBm30vePZJvmAhu79ueIJ3ZU=;
 b=n8tYAjggToQB/Q6M/u+yK+G9wWpo5cyhOziz60kimSzeYNs9rm7lMBjhnyT063+2M2gQankafvcVlE7ZQNcm7+PGtB2w4E2pBLQcKnqn5HtKErimD1llGnfuM5IeBqJVeJp81WX5NAVVHfipC1DXeSu8sDlyjgDZ1eDRJheGRGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9369.eurprd04.prod.outlook.com (2603:10a6:10:358::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 10:57:09 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 10:57:08 +0000
Message-ID: <01e8a4b3-a77c-42ca-a4de-e744755a2b89@cherry.de>
Date: Wed, 9 Apr 2025 12:57:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] rockchip: binman: Use the skip-at-start prop in
 simple-bin image
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-9-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250329150626.2879942-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9369:EE_
X-MS-Office365-Filtering-Correlation-Id: 920376c9-a947-42ea-25c8-08dd7755458f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFRjV29jNFBVbURMSFBwejgyTEpsM24wMmlPaVF3SzQwcEhJcTJhUnl2WHE3?=
 =?utf-8?B?S2drOTVIRFdTclJkWjFKTUhQYk4va1hTTkNGMnExS1hSWTlrMXRpeDVQb05V?=
 =?utf-8?B?TlFpZ2NoQjJhYm13ZmREQ0l0bUVWVTBXcDlPRjJaY3JEZTh1dml5N0RlcGsz?=
 =?utf-8?B?eHF2a1I0QzM5ZUlKR1p3Ry9YbHk5VGN0WkVYWjlNdmFoOERZa01QRFpIcENQ?=
 =?utf-8?B?ZUM1U1FueXpCNGZmS0NOMlhnZ2R4SWlPRUJXVnlmWmdDdHAwYURKSGxEVk0w?=
 =?utf-8?B?dUI4MmxtRTJLZzBkQWhROFBtUEYrb1RTMExGSEVWa3pIL0Y0dTQ3blpqbFBs?=
 =?utf-8?B?b0pIdFYvNVJtSk96R0tHTW5CdVJiZDRibE91bGxlbmZDcDdjcjZiRDF4Z2pY?=
 =?utf-8?B?OUpzbDRuWGdoc3EwTks0Q3QrYjBQOVIreFFmYzV4SXRKRGxHcmo4OVVONThT?=
 =?utf-8?B?LzRTa2VySTYyU0w0alJvTG10OW1oZjFQN3lsdU5vcDNxUnU2V04zTFRkLzRK?=
 =?utf-8?B?aWJOODhoQ0dZN1cvNWtTTzEwczh2b240RXFsSnVIeXoyVEk4eUlad3J2M0lT?=
 =?utf-8?B?RHBhWEptUXJ0M1hTNnF5dmlrYlF0aFdJRVNKZTVwREZpS2lwbEx2OFpkRmc0?=
 =?utf-8?B?d0dxVVV0WkVuVy80OG1QM2llaTN4UVBOK0tWRjRyWm1JOTgxOWNOZkx2dWNW?=
 =?utf-8?B?WVlVcmpJQVl5dWFqOVorUnN0ZWN2cXNNWk00K2k0N00zRVRXNXFoM1NZMXRr?=
 =?utf-8?B?UVcwTGI5UlNpZmVqZWxmY1FCN0lzN3FROVJ2aUZQKzBMb2N5WlNTWC9SK1Ft?=
 =?utf-8?B?cCtKbFFZOFk3N0xyRHNkS3h5YWpieEdFYnppSHNyWDlHb29US3l2cy9zZmM2?=
 =?utf-8?B?WXdueFJ0TFdNMnFHeENIenRaWmdhT0ZvYlVIWFN4dG5wRThoYlpydjBsTkZJ?=
 =?utf-8?B?SHdJUit4bDdGZVhubmhaU3luR1RjUGlxMUdOWmZxVTBqbUJIVnJUZ2xZN2Zv?=
 =?utf-8?B?eDBZTnZYNTRtbDJqZE9KNTBKd0dkQll2eExLVE9OL0Z6eWZBbU03M0lNVllx?=
 =?utf-8?B?TVBPRlMweVVBZ3prRWNiWjNTam1xQzRzUzJaQy9ySnpLK2RZQUREb1JzYTZG?=
 =?utf-8?B?WHlhWU9DZE9hcjVNdGJoY3A2dDdzaWVqUnQ5VHh5QXV1SlhsMXFMLzZtQWxy?=
 =?utf-8?B?VUtHMzBqTUVjanR2bnBCRVl3dFk5NVFVQ1lMWlFFeEdpSXVLRkhhQkt6NU92?=
 =?utf-8?B?YUZlWHdpQk1yL1NSSGphS0Z4WXVSRFdqOGxBem8zQjRKQW5EVUlBREN0VDNM?=
 =?utf-8?B?K1plemRMVlIyTlFtNU1OUjhDQVNXblV1RXpnTXRoN1RBeWRRNlVuOU1LT1hT?=
 =?utf-8?B?Z0dxNGV2NjQ1WEpRQy9WM2xKQi9TWkR2Z25LRmtBeVhybGxCcUlHSmlWK1Vl?=
 =?utf-8?B?OXVBdHdTNEx4V3JvQTV6T09zYk92aU1PK2lGaXBNR2VXSEN4L01OU2tTUG9o?=
 =?utf-8?B?N25BMGJmMkFORDFKNVhSMnJQUXRmT3dmR3VDenY3eFFNcmNMbCtrRGRtdGNv?=
 =?utf-8?B?b1dBQWs5dlFXRktWYTFmT090cXduSmdPQ0huY3J5L2t3Z2Foajh4bFhHWDlL?=
 =?utf-8?B?Wk1PbWpSbkhDQXd0ZkNXSWZIVld1MHkrdW0rVWJBaHcxMDRkY3J1ZEU1c2t6?=
 =?utf-8?B?ZHJhSUkycEgranpkUkh0VGIySGgvYUlQYjZaUUlESjd3eUVXQm03U3drWE1O?=
 =?utf-8?B?emFseiswZHRxekFESnRGb2s5UkFHK0grT0IyaU5qQitsSStYcmE4aks5UFRr?=
 =?utf-8?B?c3NyN3pNZGlta2JScHFjVFJQZnk3RTVucWs3UEJ2bENrem5zQ3k0NkxsR1pl?=
 =?utf-8?Q?22/It965kYD1D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1UycWJnNjR2UlNnN0Y5amlCZ3ZHdDhUdTBTR1JhWGRlTkU0R3BqbmtiNHVP?=
 =?utf-8?B?eERHd1JwZEk4bGtBcVdHUDNVOE4yeVQ2SU1tc3did3ZYcUIzM0I5KzZZcnpt?=
 =?utf-8?B?YVNIMUdocUV4a3VmYytkQjNrOC9YQ2t1WTN0ekUvWkMzaDh0eUE5LzlFYVVa?=
 =?utf-8?B?VEFkdkFORDB1RHlWMXk2L2tyeVBnREpSU1VIYWk2cG01azFaTUxJR1NzczBt?=
 =?utf-8?B?cThDemh0aERtOExuUEdDeHRqMkNiaitVU3prdmFUcFhsVTl3aGdWUm9yem1M?=
 =?utf-8?B?UGJ3U3hraWwwRkpLUXFaM2IyWHQzYUlrR25LUTRRMEdCSTlPWGZ5ejV1WFlF?=
 =?utf-8?B?TnNBRjNZTzZGODFPcVRWS3NYVjV5aWRYUGFWSm9HVjFoZG54OTNwY0V5dzJE?=
 =?utf-8?B?c2JQWkVnNVNQZVBDb2hnMk8vMC9RYnZCb2tJdENLa3NYYVNrYWFUakI1OGNq?=
 =?utf-8?B?V0xFUlFXY256eDNPeFhtMmpRNGwrOXByTnd5amcyRnhVaUJCVW51VjBSTnE1?=
 =?utf-8?B?RGdKb0N2U2pMdVc0YmJQbXhFYVJIN1VqVW54R3Z1SldiTlVWa2x4R05STTB6?=
 =?utf-8?B?SzNGSjJaSmVoNm5NaXdHQ3p4bWs0NC9tcjJaUjhXSjNJTlQwdTNsNUZRWWda?=
 =?utf-8?B?ai9meTNJSFlzN2RPR0hqdXo2elB0cG84UlpMT1ZNZXVrOEpxRXRUMlhUcXhR?=
 =?utf-8?B?NGlkSUVDL1JtUk1ieksrcU5RejlMamNFSlhUbzBmNElTYTdxUVdiaTlXZnBG?=
 =?utf-8?B?TjV1dmx0eUJ1WDRzYlFCYkRZVExBZ2NpUmpwOEY5VGtldXAxaVZ5Zk9WRi8w?=
 =?utf-8?B?OTVkeGhPNVRWbGVXejhnZ1MvRlByMXNvMFE1NlVjUWYyUVVacGNpMVUwRjZL?=
 =?utf-8?B?MFVacjQ2MDlEclNOWm1kckZJdGM5WHhNWmNKOERDZnBWT0x5eHdWMWJEcUdr?=
 =?utf-8?B?OGliMHZNQzRHT3N3c2FHTDF2L1NuVUczQnZUemFjVFMvWlJPbG0yVEgwbDNr?=
 =?utf-8?B?TVVTM25tYmpqS2kyZXZOaEI4eWo3TDhPWDl3dU9JbjZDdjBVR1VWT3daYXkz?=
 =?utf-8?B?SmJ3TmtUcFI4MTI1STZjaVp4bXZUdWRVaitNMll1cU1HVWNIUWxhNC8vMy9n?=
 =?utf-8?B?bDBMbkRoY0w5UE10NkZiSnNHT2ZVUXNtRjg0Z3prL3NUSUdHT2Qzczh5eC93?=
 =?utf-8?B?K2lvSU9wMks2RFJubXMrYXVQdlFKTlBPU0ZwaHdFbjBiUURKME54VmNxQUJR?=
 =?utf-8?B?cUNaM3Z5Ni9zdDQwelpsczZHVVRtWUxYbzh4eVN1Q1dZTXR5ZWlDanBzYlNV?=
 =?utf-8?B?bnNCc1FrTFJQekpJNEdpUlRQWk5MamFhUnpyRVorMEZtdnlPNlVTVTMxRGJX?=
 =?utf-8?B?U1lzS1NrdThTN2RVTTJaYlphQmdJZUxhOVN0R1BDVGpKa0prZjZkdk92R09p?=
 =?utf-8?B?cGcwTUF3OUdjcmNSQTJ3NmJTeDlMdThxS2ovb0ZOU1BzN0dQZXE4cUlZOW5n?=
 =?utf-8?B?R21wZkt4MTlRRkdWdTAyaFpNS3BJb0dqTTNsMDFheHMxSE9scTh2Mk9RSGNY?=
 =?utf-8?B?L0tOM0hSQlNINURLdWRucm01MmlYdURxVzJBUmdMOXZBQlFHaXBWOCs1b0tN?=
 =?utf-8?B?QjJkaTFud0cvYzBhdkZ2VWV5S3lNODBsWUVUeFNjQjROeTVaWnRscEZiUGRs?=
 =?utf-8?B?S1dkZVJwQi9vVFhpcEJjUkEwU1ZSQlJFZFd1TTFyTm8xTmhQU0ZRQ2Jhb1FF?=
 =?utf-8?B?Q25qM05qemVUYlpjdWpwczZTZGlJamFDbUhSdVZmODdHR3Zrc0l2RTF4MHFF?=
 =?utf-8?B?WEN0UncrZmVUK0JzNmFqUFE4c0hyd0syK3BJazhCMFZyMUNOUm1ZK1ZxOEZl?=
 =?utf-8?B?c2FKS1pWUWQ3ZDlxcnE2YXZGbEUwTDlZUXoybWRGYjVnNFNvbXAzQkkzYnln?=
 =?utf-8?B?dHd4ZXp2YXNvSVc0cWRqa0VqS2hXeFN1aHR1SVlIUU1oZ1ZSaFU1TGNNbDMz?=
 =?utf-8?B?TG4wbVJURnUySkl0SFRKang2cEg4ZTMzSnlEbEVqWHFIT3NrK2dEa29zZ244?=
 =?utf-8?B?d2ltenA0aHZJeVhNczhpZUhLK3R1RWF5bDZjaHBEeXNZeW1iWENVTll0b1li?=
 =?utf-8?B?cEMxOFcrbTdmTU9JTU1DSlR1WU5vQzVTeHZhMUlZN0ZjZEcvcHBxSlErdVBM?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 920376c9-a947-42ea-25c8-08dd7755458f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 10:57:08.7027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgrXAQezrQ5SJffWYXzCpr6/qisBcyFyuPGrdsbYWB/chNmASvlmApbq7QAA76umidgctVqyiQSwTv7trzLUSYeqsruVxBl0yVuubCCbWdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9369
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

Hi Jonas, Simon,

On 3/29/25 4:06 PM, Jonas Karlman wrote:
> From: Simon Glass <sjg@chromium.org>
> 
> The simple-bin image is normally written to MMC media at block 64, which
> is a 32K offset from start of storage media.
> 
> Set the skip-at-start property to 0x8000 (32 KiB) so that fdtmap and
> other embedded binman symbols in the output binary is referencing image
> offsets correctly.
> 

Shouldn't we have this commit BEFORE we add the `fdtmap` node since we 
know it's wrong before this commit?

> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v4:
> - Drop defconfig changes
> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
> 
> Changes in v2:
> - Move this patch to the end of the series
> - Drop 0x8000 offset for SPI
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index fb38b7b80c43..65b81bf58626 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -154,6 +154,7 @@
>   	simple-bin {
>   		filename = "u-boot-rockchip.bin";
>   		pad-byte = <0xff>;
> +		skip-at-start = <0x8000>;
>   
>   		mkimage {
>   			filename = "idbloader.img";
> @@ -178,7 +179,7 @@
>   #else
>   		u-boot-img {
>   #endif
> -			offset = <CONFIG_SPL_PAD_TO>;
> +			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;

This is confusing. The documentation states:

"""
offset:
     This sets the offset of an entry within the image or section containing
     it.
"""

My understanding is that it should be relative to the beginning of the 
image but this now needs the knowledge of where it will be stored on the 
MMC device (via the value in skip-at-start).

Why is skip-at-start automatically deducted from offset?

Cheers,
Quentin
