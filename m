Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCB5C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 13:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A87168398C;
	Fri, 25 Jul 2025 15:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iyOnlqbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF5A83993; Fri, 25 Jul 2025 15:34:34 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D974C83980
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 15:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NddeMY7zstxOqjkN0amxzrIcK3uZY5nk65S8FYrxNLpBjlCDMciA78QAmRTMMq0YaTcRiLEEAOl7W6AvfoOpr32uo3RyvmsioO9BScmuqaL9KjpFByrgQ6v++Ox1fWxE+Plw+OLt4R0DMdOo7Eguq8Y487u86AOwUeDIj6qOatpo0GSFDm6Gk3ma7l5wTBI5DZEdsNqJ8R7KN/9Kzonmmj2Ir1Q/TZHhc8jhhyVSFO87CUK+PN4n6T4yQQ2ZGUqwe8efc7XYzbnbcVMEriPCynZRvCPgLzHqQHdnbYeBp5jKDcYRhqV1Ln0GnjS6D2W6xOrVX6cPZU6+dw3aCTuE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5FStVoI9wE0LYsyYTqtz4FubFLIsYfbDzZs3uBKYvo=;
 b=q7abXAEJZdZxjg2CBizkyBc/smtuLSTWC7cn6XiY5i/kNpC5jY8EbvTl1eemq2gYos1uudfYOIkr596WcaV1oWuwewbYdULQMEVBGgPO15bSwRpuZ53G0UWgXIVsrMvtmVgAI3xbGkcnDPcHZ+Ygcu+/TW+A0llShKXZxosennoRyP4UAVv2UVFVEzO63eQ5sBdGnbhWfMnsizgbDlPNY9FpO9uDO5dO8SLxQ6UwoL/RK9vkLZQiSW21ZSGkaD+NvVtfrdrmzYgRmNOLL864ioNJHjuVZFzPuX6TYz7v+qpMfnB/zMBFA13+1cZi7u8ovCb3BU4i9+5FzV7hD7vDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5FStVoI9wE0LYsyYTqtz4FubFLIsYfbDzZs3uBKYvo=;
 b=iyOnlqbqO4drj7EXEXaPP3UvYJWDfY8edwiZyjcK/Q7yVYbCRX1y2Yfbv4iSOl80RjwFktX4sc1vJtQJnjSbR9Xebfxs2lrRqVa+ngRMYBKagFhvlBuGduqO8NICjq6Gk68yuFkhYGDLIB5msb2wx4F2KrGTpZgtpmLfS+DOxk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 13:34:27 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 13:34:27 +0000
Message-ID: <372ffe6c-0359-4ccb-8450-6e28b83682d7@amd.com>
Date: Fri, 25 Jul 2025 15:34:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250725132645.GA1807455@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250725132645.GA1807455@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0066.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: ed572750-c138-4549-d3af-08ddcb7ff9f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmdTRGpyS283RGl4eWdvMy9wRUF3ZUZTR1BkNllJRmRoMmg0UFJEREtDT1lC?=
 =?utf-8?B?cXlTR1g0NEpVV0RqRXFmc0MrcGZrUnFVOGRRM1EzbnlBQzk4ekRWZHg0cVdF?=
 =?utf-8?B?ZERUQ0l1YnhlNENQWXVMOGJlRnQ1TnRqSnJNd2xVZ2g0Q3RRKy9SelI2SWxl?=
 =?utf-8?B?NUpQR0xQNW1HMDlINmQvREdXUmhZWFI4Y2V4Z1dGZFdIWUVRdzl4Lzk5Z1dv?=
 =?utf-8?B?c2dYaEdPcE5aeTBGcFFmWnJnK3gyWEhyT2puNzZLdWtZY2xuSXVHREhBWUlB?=
 =?utf-8?B?L3VjWmZGREI1RFRXSjBBQlpEL1NuRmxDd1dxSGtyYjJHV0lxb3luSldCOCtx?=
 =?utf-8?B?Z0lpUDdrR09ISFdOdzVWeEQvdXhZSFZ2cmUyRG9VaGNhenhqcTFhVW1rblBR?=
 =?utf-8?B?WWJBb0s1c3BacHVrYkhqMGdDN0VERUVWZHl1MU5hdmlhek55TXIwSk9wZzdN?=
 =?utf-8?B?M2VkUkpmSUN1dmFoRlRod0tIdTV4OFZrWDE1MjB2VXBRakMvYXF1bE9MbG9X?=
 =?utf-8?B?MTdVL2NqYzUvTVFvb1EzVmZqeG0rSWxZT0VncVd2c3pXS3M0L0h2b3NIRkhh?=
 =?utf-8?B?elRMUUxqWHU1Nlp4cys4TU9Zb1ZoaDE2Nk5UK1d3emZISGpCTWtPRWppNlpr?=
 =?utf-8?B?VkJQSlJTTVZMbGhKVWcrWU1Wd2FrMGZmSlEyT201bEtSd3hQMTRpMFdrRUxq?=
 =?utf-8?B?V1RUOFZkZWxJWm1ZN1FFeFdlL3FMbmRhU2UrZVJYY3dQRkR0U0lSajZYMEpz?=
 =?utf-8?B?K3V2ejRQRzFrT01QWHV4YmVFOFRQdVhWcWY3TStYYzJqZUZ3UkpKY3B6VVBw?=
 =?utf-8?B?Y21zYXE0ZGV2T25WYXZGTzhaNmNTa1VMeURWc0ZBcHlsTXZ6UzUvOWVtR0p5?=
 =?utf-8?B?OFBwWWZjeDBydFZrbHdMekVXRGhyS2dzekpSb0tvZWJhT1dzQytBTDhtTUoz?=
 =?utf-8?B?bSs0M0Z4VFRSaW9GMFZ5RDRTV0ZuaEFNazJNT1lwUGxZVzRUNDVraTVLUXR1?=
 =?utf-8?B?MWxRa0RxL1Evbnkzc1Zha1JMMHBONUoxeUc3d3cvTldLalhQWkNrZGJiMDBs?=
 =?utf-8?B?MDNQQ0ZEN1dkRS9TVkRKeFNteGY4ZU1ENlRhRURVM0lkeFRlbnhXNkxiVDhm?=
 =?utf-8?B?YUVCNm1wUi9jamZHU3E3aXlWRGRJRWkxNkk2S0c5UmR5cnlsZExrNWE4a1pL?=
 =?utf-8?B?RjIxT3prc3ltYUh0b1F1WnovSktEV2tyZFk4QTU0eXlVZk42bEJOblJqWDlk?=
 =?utf-8?B?R1FvZUJhNDlweVZwZWZvWjVaOXJDOWtvaDhJV0VLYzdwelJmSnVsMlQyOFpu?=
 =?utf-8?B?cFFCSmR0SDZnZVlBcjhvaWN6aExpZ09NUkdURjdtNUJJalgrSjV4Wmc1MktN?=
 =?utf-8?B?NkVsWE4wUkR6NDBYTmlDbDB4NEJFMG5vbmxkT1ZxMnNIUnpoUFRTVGx0RTJN?=
 =?utf-8?B?REM1NUlJNXc1dFRjVWl6c3NScjZhbHFRQUJaeTRqaXdBUm05RGZ3c3ZIUlVR?=
 =?utf-8?B?VElDVVpKNCsyd1QrbmFHWi9EbFJBRGU0ZHluOFFmME5qTVorMnU0QmMrSVR5?=
 =?utf-8?B?M3VUYnU1ZU0zd2xUallTZ0Y1Sm5uZFFvL0hseDRIUStvVEFOQXJDdjV4VXFB?=
 =?utf-8?B?d0FpM2xJeFA5QTlFalhlSXNoWndiVUV6bTdZVmR2STlkellZdEpIME40QXBz?=
 =?utf-8?B?UlRZSlJTWmJNZ1dQd2dpUVlpdzdnNkRDeDArc2I0MVgxc2NHYTRXeDcyYnVu?=
 =?utf-8?B?Y0R6VVY4ak55d1ZKb2h5elZaMEpxa3pjUWZiTU9acE9XNjJnVTBTbzlWY0cw?=
 =?utf-8?B?dEx6MEF4WDRUWHU4ZjNxOW0wOG5kdFFPU21mS1p1cUhCdlVsRWkrRmhKRHhH?=
 =?utf-8?B?Wm9nU2VlWngvRXlXSTh4QncwMjB2TTFFUUhMZ1VFc3JQR25lc0pmZnFGeE12?=
 =?utf-8?Q?+sNbUq0oMn4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWIvMTNPZEZJLzE2WWtWUUpZY0xqZ2QyNG1TTDJSY3BQcjR1TERHUmFBUGRJ?=
 =?utf-8?B?MWJSUFJyZTBWZFp4SGFJM0ZBQXprd0FIZHdJdTR3Y3FPUVFhVzUxcXdWczJh?=
 =?utf-8?B?MFZPQy9xMzJVMnFhRHhLNTdQWDV3WkZtT0dldk1FMnExeGhSWm12ck8wd0tv?=
 =?utf-8?B?cVdkMTlxUkNIUERGK2xnY3F0dWVHNFJ4TFI0Tm9kQ1ZZWkpmSXlxTDVPUGE2?=
 =?utf-8?B?dEt1MVZNRDJ5b3Bvd0QySDYvNFB2NkNtNGQrMWhMcnE1VDROUnplZEpiSU0r?=
 =?utf-8?B?bklndzd2c0xWdkZRS3VBbnljYzA0S3U3ZzJKaHNCcDhrT0x1SkpVemJvNkxw?=
 =?utf-8?B?cDhNc3lYbXIrWEhpKzVraTVIbDBKVllhazFFTzZNL3UxWkVCbGtFd2w5NHBr?=
 =?utf-8?B?NGNaR1AyQ0ZOMDRwV1FMd3ZSeU9MV0I5OFYreUVWZkFObmlHWkJnUHN5ZWhJ?=
 =?utf-8?B?Q1JFcGpKUFpSNzdBTUhvQjFPUndyTmplU3MwRmNlQ3hvR3dUaWRmRkQzeU5K?=
 =?utf-8?B?SVBjMis1aEszUDBUanV2S01BM2xhZTZVeHhwUC8rR08yYkF4ajFKT3VBQ1Vh?=
 =?utf-8?B?NkdYRWJDcWZtUWwzN3p2QUJPZnRTYWh4MnR3WUVlZ3ppSXlNclp2ajd4MHVE?=
 =?utf-8?B?SEZ2eEJ5K1oxcWc1eHFLTnBqb1FtMi9OaXZtSGVPVTRVQ2grT0kxWVgwY0Vq?=
 =?utf-8?B?VzU0Mll4RFhHZ0pnZ3JBSUpMbFZjczlCbSt5eUhHVkVIRkUxRmZGSWFoT0Ny?=
 =?utf-8?B?eVBJN0NGOUM4dlR2OUNSY2Y2RUMzTmYyblM3RVpranBKamp4cW9jTFArUjVz?=
 =?utf-8?B?MHZvSDM5Z2ZaY2pkSVIzUjdFaDdxTmNMM2J5Qjc4SnZOdElKV3pzTW14Wkcr?=
 =?utf-8?B?VCt2N1ZSWjZXcElJV0theVQ2Rk9WdlZ5bjNSTElIdEhIM2hWczk2Q21DaE90?=
 =?utf-8?B?YWI1THhMZE9lRHVRR3lXMVVUbjB1VmpoM09XOWpZb2t5aXF4NER5L3BBODVi?=
 =?utf-8?B?NzJGdStxV2tybVBGMWpNdFVuTWJSS2VFUjFId211aXRCMTBqNXBWUXhMMWpT?=
 =?utf-8?B?S2ZkUjZUU0lQeUtjM045bWMyM090ZjdjWWh6c3p1MXZzbzBvLzRkV3JKbFM4?=
 =?utf-8?B?RWNTUlp3YnZPRkZkUWUzK29tTzZYQ0dnVVZuVGFrYWpWbUhwWStxN0pVY3B6?=
 =?utf-8?B?azhmK3ZBTzhGOTRLMHIrRE1oQlY0N0EzU2lSNW5Tb0dSZGtQNys5aFk4SlpR?=
 =?utf-8?B?cUZHaGJaTWFMVERlNzZoZjdVY2pldkp1SUNxZkpmY2ZSa011VWdjUnp1OW44?=
 =?utf-8?B?Rndnd0wvaG1lNG5RUzRJQWpRRUNKUlc5NXYxMlhsK0cwazRhREdvTVp4d1Ax?=
 =?utf-8?B?MUJ6ZWV4VHB4cEZ0VFN0VEN5UVVKUXl2WkU1RGdXRWMzRjBHRVZrd0ZBeldx?=
 =?utf-8?B?U2Zka0V1VU12UW9xeWh3MmhibEJYS1NKaUxtMkVWQnBUODdTc1pCaXhOL09G?=
 =?utf-8?B?akFKc0RCd0ZLZHRaN3JPaUZjQVdPUU1QS3hFcExKaklnYXNUak1HSWxoSUNt?=
 =?utf-8?B?NGMyd0wxcU1yYTZNQUNFWWUrUWl0VlRKOVVsMkw2UjNJa09GMm4vT0cwRWND?=
 =?utf-8?B?UEUxdG02a2RQYlMwL0tDdUJQTDRsd3pGVEVMLzUrTXIzNHFROFhCTEY2ZVp0?=
 =?utf-8?B?REVBd3VRMUxYdCtzQlZHRXl6WlVlTVIyWjBkd0kva2x6ZVllU21DdUJ4NmFo?=
 =?utf-8?B?bFRmVFN0b0NwcUdaN253WW1iZytDS0dHV1BoZWFEVFh3MXJUSVFjbGRWRElY?=
 =?utf-8?B?RXdWK3ltTGZBbkp2d3pPakhBam9hMVU5N0cwa2dxTG5UdW5uMDhtdE1yS1dn?=
 =?utf-8?B?Y25GdUJJMDg2UkRqb2NRQmViTGVZNWg1Y011YXVqUWFJSGZpdnVreldDK1Nm?=
 =?utf-8?B?U0t3Mjc0VjJ6czhmUmtpK0VOdldQSURrdUR2a2VwSzZuekczZXZuU2t1YnpY?=
 =?utf-8?B?bmpjSzduWFAvbUJsNjNJS0lvTDZTN0pSaldyQndpN0kxMDJrbUREMzRvT3dy?=
 =?utf-8?B?dmZ1Wi9OWDJGVGFndkN4MkVNZWRqeVBUMFRlMlVudDloZmplUXdoclFxQVlP?=
 =?utf-8?Q?oMpwjBTQ3RrtdNvIyd5IMZ8XO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed572750-c138-4549-d3af-08ddcb7ff9f5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 13:34:27.2998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2mjoWe8OeMqEn1YBInV2D0BY9AtoYz8xo7lYZSc0sIhlVXNAWpH5dLFTNSKNYa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147
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

On 7/25/25 15:26, Tom Rini wrote:
> Here's the latest report. These aren't new issues as much as they are
> Coverity now looking at FPGA code issues.

I have sent
https://lore.kernel.org/all/cover.1753442748.git.michal.simek@amd.com/

to address some of them.

Thanks,
Michal


