Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B162D2E015
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 06:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70AEC8924B;
	Wed, 23 Oct 2024 08:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JbF3T8rK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D561B89092; Wed, 23 Oct 2024 08:00:56 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD99890AE
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 08:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ldm7UjkEzIiwtFQFxJlW/DTb0xuWDVFv+DDzjUyfSlei7FL/dxA9Iq63yxb4Bvcgg9LfJwAmZe0NrDQe1vUOUqH9XrDwxDl/sDzZe66Hw+FPp8QuBQWwXpdVzc0535520+dAMwqofggsyGAwAKs8WG1fXBufa6/xYY0K5Gx085TvF2z6VArLq4PjVzORwvS95d7nOKRgNZLtlQlAC6MG9voqk7Ryj84cSO5h6U8hWGBIbVwqvlc2a/brKgK7nWYNkhQ3WYqutVBrWqQhQuz3B/yaTwJx1Qp4WXodKQKdjd/K1lBqYHJxEfNevjVDdldx7h6wkG9jszSK5A9TE9PkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIPe7jZ9BaLq5SN5uF8nlzZut+oYKBY9WO4/0plxIvA=;
 b=P0cAMvZued5HR9y2ktIed9fAlSBzs02IA8rk6gPXHmqARwNBeI1UQixKroR4XMhsA2JgvupUP/MeCu7UxvdKgrCtFZfj+zkrwNcPH6b0G0eb58yCIP+gNwTd80Ytw5GaK9+okgWIAsgUVk2PBax3+UqdH1cugsBq5305d/WHVIeqXEvZQeZ+ncSs+fFxuFPghZICIYZP5n1ZYiQyi+nDl0VYQcCAlVGlM4ssn7nEZyma8YzKoyxRRzk5Q8K3kurRe5aVw59Hv9eX2QW4RE8Mpl63bHopfBbxXC7Z7eP9Cl0L+DpzSvaZ31XcFainpE9vB//RIz3u2DQ8BdlU8qX3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIPe7jZ9BaLq5SN5uF8nlzZut+oYKBY9WO4/0plxIvA=;
 b=JbF3T8rKBep9RQFVIuowEJzZDAG5EFXI6pzyMDTEKu7LFacYjRawxTkVi78G0DCcd52hzizpwJaV5s8Pv9xikvmQjKD6G5VIlaqslF9FVU1gl2Q/mf8SNNfYQXvdo2KKBcL/NVNxRS7JJOR2HKw5UdWnhxbV0ZFWJgtBJHlBEk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 06:00:43 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 06:00:43 +0000
Message-ID: <a2c94f3e-6933-4eed-ba56-c42cddafc4c1@amd.com>
Date: Wed, 23 Oct 2024 08:00:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] amd: Disable LMB, BOOTM, MTD and EFI loader for mini
 configurations
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <6a263cf5f6b7c7f8e0bfc11649887f2760385d0e.1728286203.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <6a263cf5f6b7c7f8e0bfc11649887f2760385d0e.1728286203.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0033.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::46) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 7939955b-606c-42cc-d41f-08dcf32807da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzhaSFJEUnlNZXUwRVJmeXZjT0lnelZmNmZ0a0UxdEx3MTNBcWl2RTVYaHBy?=
 =?utf-8?B?cXFBU1RmcjhMTlc3VG4yQllJaWt2bkxCNS9KeWRIUnJwZGpOOGM0eWJzbm85?=
 =?utf-8?B?cGxEdkxxQlVKdHBZSGxLYTg5ZFdwSktmYTNSTTlDTjdTWVpSQUhwRW5xL0VF?=
 =?utf-8?B?SVVHaXIwZE9waU91OW1YRnpsMWU3ZW5Kait6V3BxMXlkRURVWWkwdGcwNFNV?=
 =?utf-8?B?MUJPNFlQQ0pRUVdMNExiOHJVYjRkeGxpMWROaDFGaEhwejVsWnFlNjJzdEFo?=
 =?utf-8?B?WUwwcU1rKzRoY3krZnFPNENBUS80U0ZMb1k3azZkQ1Q1Z0R1elpha29hVTh5?=
 =?utf-8?B?TDJCRXlYTm5ka3p1dHhIQzdqNktIS2RmVzRlM213clI4NUZBMTRJVW55Niti?=
 =?utf-8?B?a3VnU2dKTXk0RllBRXB2UXZRYjRKVVZxbjJibGZMZXBYTnpuMUllYzBoUmE0?=
 =?utf-8?B?eEFYU1R5ZGJCVlNhSG4wMHU3VUtobDF2d3A2dWVXWHpNd2tuY3Z3MCtQcHBH?=
 =?utf-8?B?NURwakx5KzQrWnBtUzM3dmNQRzdReGhtT3Vtek9VVUlVTDEzV3BJQVdLa1g3?=
 =?utf-8?B?WGVMYkRsOCtnODcydmpCbWIxaGgxRzhISm54YlFpNjM4UnJDblNweHdueWlQ?=
 =?utf-8?B?NzFBbFBaWmFSRFlMdXQyV2Z0bTBuV3N2Y0lhRHV6MHhIL1JPSjhpaXNpdTc1?=
 =?utf-8?B?Z0dFQmJpcXBWYUVSUU43TU44VGRTSUtlZU5wTHhlNTNPeVlpek9Ib2FEb3h0?=
 =?utf-8?B?bm9sRlMzQm8yZ045bHNOZnl1SDdYUmdrcER4RVBvRDV4ZEVHYzA2WS9xUjhK?=
 =?utf-8?B?YlAvSW1vT1NMZG8vVTdmNU5UbnEveFZPT0pnellxYXdZNVFJeFJVZ29sRjRt?=
 =?utf-8?B?R1hMZ21XaXdYdWhXQlMrRnorTC9jWFZuNUZzaC9oY3lhVXhmRVplbkhVejVS?=
 =?utf-8?B?QitWM2U5dFBiRGFvMVl4Z2luSDBzbWNlUW5ObmQ3QmlUcGExRkg2aHdNS0da?=
 =?utf-8?B?dkF1c3B4VTgyRHNlcXFzaUkyaUoySGlkazhkeWFJZTlsdTBZTEtIdWhtMUht?=
 =?utf-8?B?Z0w0WmdQTUhEaWlmd3dCMWtmMGpiblRKQUJNeWI1ODJqbGtPVkpVMWZWWmNu?=
 =?utf-8?B?N3JoV25YdGtXamxPVmlHYzFGS2EwQXY1ZXhMb1pBNG9tWWZDeFJjRE1ZZ0J1?=
 =?utf-8?B?TmVOcWY5SjQyeUNwSlZEVEtoK3p1aEpXYU1lbHBkRjlaeXBxOC9JaUNUYk1z?=
 =?utf-8?B?Q1lPMDJuM3lzQS8zM1A2Um9LK3dKdmdtbFIrSlFLQy9NU1BRTGlkMWNnNmRi?=
 =?utf-8?B?Wk1JTlN4ZXhjZGVVK3BzSnpkWGJNMXhlaUtDN1Z0alZzRnVuRm8wZDBGeHd4?=
 =?utf-8?B?SGF4c2pvcldNb3htdXN4UHZ3RXJ4VS9FeHlCMVgrOEQ1ZjJxZ2o1Tkwwc0F3?=
 =?utf-8?B?UHFQWG9Dd0lzUCtjWHY2SEdObFdJZkVGbHZuVk1GSHV3QTQ3VlZxRmkyREpB?=
 =?utf-8?B?TmN6MkN5YzVsdk1oS215aHFQc3ZjbHNnbms5dTJyaU1SZkxFU2w1Q1kvSkdn?=
 =?utf-8?B?RkphUng3VHQrNkM2QVovMDUrS1JQSmtsblpjaXlFRW41aWFrNGtQU1diSVZV?=
 =?utf-8?B?V1NzL0t4dnR0N1VucWNFV3Q0YkpweUlHVXBLdHpsTkx5c1VSOGc0bUc5SjZk?=
 =?utf-8?B?NVNIRFlVdDJpWm0yZTZHdDc1dU5pRjAvNVdCMk42TnRaMnIzOUp5NG9KVEF2?=
 =?utf-8?Q?2Tabo9HdWfmhIYdqpg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWZ5WXQ2K05GRGdvSEdaVTQvWjBNaUYxK0cvd0dFUytJdjRCRkdJSDdoZ2F6?=
 =?utf-8?B?YytMMWhqTWVlVHQzaUl1cld3V1dIL2dBNXpnME5jRE9KSSt1bTVPT2grdmNO?=
 =?utf-8?B?NFppMFdxNExKaU1jeTlEcm5WSFJHdjFDSlFPdEVCN2J3MFBmUzJ6bk5TVk5S?=
 =?utf-8?B?b1dFclR6anEzWnkyWkhEaU4ydkNRYm41T0RaS2VtZVNnQyt4c2pqVzNKSC9P?=
 =?utf-8?B?YlRmazR5YUIybHpLR2wrcldrUHhiU0lGZHNSNU1IdUpieUV1SFU5MjFycTB1?=
 =?utf-8?B?YU03WmoybFZTblk1Mmg1MjhtdTNGaGlYRzl0SCs1RXltU2hVYVVzMURBcEx0?=
 =?utf-8?B?OW9qRndFWkFhMjM3UUdUZFJqQkdEcEd1Vk9TOXBXcW1GVGpvMExZNDJncHJB?=
 =?utf-8?B?c0hFMWpua0kyMVdmV0xsWkRLdGdyUFF5Yi9UMmYvNW5rWVZIV0NVZmQ1ODhH?=
 =?utf-8?B?cXZzREw2V3RqRExqcGVNaDZSdU5jMHcySmxqZ1NxaGE0eVZ3c2tJYVI2ZVpR?=
 =?utf-8?B?MnJMRGZiTDIxMXdMS2ZxUExrQWJZZGZRU0VLd1lEcUtFVUZLUGdUVnJmOVps?=
 =?utf-8?B?WktKQzZWWDBwRnRLcWpodmRTbGtYT2lPZ0JnZWhTNk5yS1UxOHg4L3YwUUlv?=
 =?utf-8?B?N1ZMbFpjZ05WTUpIQ3kzNFlIclc1WURCUSszQnNHeUhNeGRtdTlObnlRTmpQ?=
 =?utf-8?B?YjR2dlVoS2tmTXZUUzlaZFF4K2ZiN3dDMjVTMkxKTzN0dXk0QmpwZEk1NHNa?=
 =?utf-8?B?R0xDM0xVK1ovN2IydERVMmpCOUZ0MEFCKzJVTWdlaVU3Nlh5dzdWdkJCaEJo?=
 =?utf-8?B?YjB3UDl1RkdCRm03bWQ1dkRGR01GTmpPV2dzaFlqbVJ5SCtYaDZVdzh0Vzdl?=
 =?utf-8?B?VTJNMXFRVS9KakRxdmphc3R5SXljME5WVXltaUtEOHJEK1FvSHpzdFVmOGpz?=
 =?utf-8?B?L3p1UURBSmZXTHhRcmNOdG90cm5PbWJWaG1GZktlYU1PbXFJN1RNL3NuQURk?=
 =?utf-8?B?eFR0WnJLM0owVHNYM2o0eHRtN0pJK2hldDRzdWs3a2p5WUVUM0syV3lzaHg0?=
 =?utf-8?B?cVlaZmdrQ0VGRGdhcDQ0Ti9mVUlKVitUdDlBbHJTWkl3ditXdEZTTzIzU0Ft?=
 =?utf-8?B?S0pMeTNzVmFPT09zQm1NYWM2K1ZSZTU2cXIzUHpwZWRFSnQzOHpKaG1peTRX?=
 =?utf-8?B?VkJiU0w2eHQ1N1lhYzVaT1dxZTNHMmFCSUsvMXlwTk9QS2tid05UWVlobDNJ?=
 =?utf-8?B?cW41dXdlQ29VV0hHc2FpVGtUMmR0YmlQdUQwZEJqbkFCT0RyalhaUVpzakdt?=
 =?utf-8?B?UnZOVUc4aGRWUUJMc0NtSlloZG9zVnFGNDhtSTlKVVpoNzhvbkhEa2pzNjBn?=
 =?utf-8?B?LzRmZDJMK3hlTUxNcnIxWTNJTkR1b3pTZDQ4OGNnTnFCQ3hEeHZpakY1ZzVJ?=
 =?utf-8?B?a3NLb25iYlVWeThWanhZdmtQbWZzMHZWYWpCQkFhK1FnVG1MblZmYk81NUlT?=
 =?utf-8?B?ZEUrRXVtYjdlWnEzRlI0WHVjbkZuUmpLQTVjTk53K0tSSmJiVkxsbzdZTWNw?=
 =?utf-8?B?OHc5Nkh0NGVweWNUMUZIeUhoUlM3OTEwak9aMVcwcFhKdS9GZ2hsQmNUVWNP?=
 =?utf-8?B?cUlMcGRlRVVQNUNlMlRNbWdRVSttcWYrWjJVV1lSa3NRRWJtdGlaOUZqSHVm?=
 =?utf-8?B?c3hDbkhGckdDVGVLQUFUVDAwbnUrNkJLYURUcEt1TWhwWkhqSTB2STcxajN5?=
 =?utf-8?B?ODFoY3ErRHl5WCt5S2JSckdjWnE1bklUWTlpSXdLQjkyT3dYeDBnMHhnZmxX?=
 =?utf-8?B?UlhxbVpOZFJhQ2tWTUxTYVV4NkFhTUdNa1hXUlkzejJCV3B6SkIyWkVETnow?=
 =?utf-8?B?cXFhdk1zZnpMdUcyczNlb2k4bHFnMFhlZDZVaFk3RXVwQ3UxblVQWmtYWGpw?=
 =?utf-8?B?SW4rWW9oMHE2Nk1XeGFWS3FzRDE0T1J5NW1EVGR6RnY0aDRsdThwSFNQYU51?=
 =?utf-8?B?Mlo3MUJSKzc1YlExZDJCaWhOUnNtNUhkejd5cnRlWHhGaWx2L1BqOVRXdnFW?=
 =?utf-8?B?QzZGYnRIOG5rZlhWRWZQY29WZTJVSU1WUjJIL0J4VzB2Z2pSWU9XS3JLY05p?=
 =?utf-8?Q?/LmxlDE6C7BnAP2q2JoEdM9vP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7939955b-606c-42cc-d41f-08dcf32807da
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 06:00:43.8283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFQe897JRXnDFVfPurWBetiBlY9zPCreHxKSjw5RSiNYfxjC9yDH/jUaa/H2gl+N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234
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



On 10/7/24 09:30, Michal Simek wrote:
> Mini configurations don't need these features that's why disable them.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Get back MTD for amd_versal2_mini_ospi_defconfig because of missing
>    spi_mem_dtr_supports_op and spi_mem_default_supports_op
> 
>   configs/amd_versal2_mini_defconfig      | 3 +++
>   configs/amd_versal2_mini_ospi_defconfig | 3 +++
>   configs/amd_versal2_mini_qspi_defconfig | 4 +++-
>   3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/amd_versal2_mini_defconfig b/configs/amd_versal2_mini_defconfig
> index 0dd2305bfb2d..f2444308fb97 100644
> --- a/configs/amd_versal2_mini_defconfig
> +++ b/configs/amd_versal2_mini_defconfig
> @@ -22,6 +22,7 @@ CONFIG_SYS_MEMTEST_START=0x00000000
>   CONFIG_SYS_MEMTEST_END=0x00001000
>   # CONFIG_EXPERT is not set
>   CONFIG_REMAKE_ELF=y
> +# CONFIG_EFI_LOADER is not set
>   # CONFIG_LEGACY_IMAGE_FORMAT is not set
>   # CONFIG_AUTOBOOT is not set
>   # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
> @@ -35,6 +36,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
>   CONFIG_SYS_PROMPT="versal2> "
>   # CONFIG_CMD_CONSOLE is not set
>   # CONFIG_CMD_BOOTD is not set
> +# CONFIG_CMD_BOOTM is not set
>   # CONFIG_CMD_BOOTI is not set
>   # CONFIG_CMD_ELF is not set
>   # CONFIG_CMD_FDT is not set
> @@ -75,3 +77,4 @@ CONFIG_DEBUG_UART_SKIP_INIT=y
>   CONFIG_ARM_DCC=y
>   CONFIG_PL01X_SERIAL=y
>   # CONFIG_GZIP is not set
> +# CONFIG_LMB is not set
> diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
> index 2242960392f5..4ae5ae19b84c 100644
> --- a/configs/amd_versal2_mini_ospi_defconfig
> +++ b/configs/amd_versal2_mini_ospi_defconfig
> @@ -20,6 +20,7 @@ CONFIG_SYS_LOAD_ADDR=0xBBF80000
>   CONFIG_DEBUG_UART=y
>   # CONFIG_EXPERT is not set
>   CONFIG_REMAKE_ELF=y
> +# CONFIG_EFI_LOADER is not set
>   # CONFIG_LEGACY_IMAGE_FORMAT is not set
>   # CONFIG_AUTOBOOT is not set
>   # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
> @@ -33,6 +34,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
>   CONFIG_SYS_PROMPT="versal2> "
>   # CONFIG_CMD_CONSOLE is not set
>   # CONFIG_CMD_BOOTD is not set
> +# CONFIG_CMD_BOOTM is not set
>   # CONFIG_CMD_BOOTI is not set
>   # CONFIG_CMD_ELF is not set
>   # CONFIG_CMD_FDT is not set
> @@ -82,3 +84,4 @@ CONFIG_HAS_CQSPI_REF_CLK=y
>   CONFIG_CQSPI_REF_CLK=200000000
>   CONFIG_CADENCE_OSPI_VERSAL=y
>   # CONFIG_GZIP is not set
> +# CONFIG_LMB is not set
> diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
> index 3360c1546a20..b1d966a56c68 100644
> --- a/configs/amd_versal2_mini_qspi_defconfig
> +++ b/configs/amd_versal2_mini_qspi_defconfig
> @@ -20,6 +20,7 @@ CONFIG_SYS_LOAD_ADDR=0xBBF80000
>   CONFIG_DEBUG_UART=y
>   # CONFIG_EXPERT is not set
>   CONFIG_REMAKE_ELF=y
> +# CONFIG_EFI_LOADER is not set
>   # CONFIG_LEGACY_IMAGE_FORMAT is not set
>   # CONFIG_AUTOBOOT is not set
>   # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
> @@ -33,6 +34,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
>   CONFIG_SYS_PROMPT="versal2> "
>   # CONFIG_CMD_CONSOLE is not set
>   # CONFIG_CMD_BOOTD is not set
> +# CONFIG_CMD_BOOTM is not set
>   # CONFIG_CMD_BOOTI is not set
>   # CONFIG_CMD_ELF is not set
>   # CONFIG_CMD_FDT is not set
> @@ -62,7 +64,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   # CONFIG_I2C is not set
>   # CONFIG_INPUT is not set
>   # CONFIG_MMC is not set
> -CONFIG_MTD=y
>   CONFIG_DM_SPI_FLASH=y
>   # CONFIG_SPI_FLASH_LOCK is not set
>   CONFIG_SPI_FLASH_STMICRO=y
> @@ -77,3 +78,4 @@ CONFIG_SPI=y
>   CONFIG_DM_SPI=y
>   CONFIG_ZYNQMP_GQSPI=y
>   # CONFIG_GZIP is not set
> +# CONFIG_LMB is not set

Applied.
M
