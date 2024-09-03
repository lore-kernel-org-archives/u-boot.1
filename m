Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B8ECD342E
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 13:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F0388606;
	Tue,  3 Sep 2024 15:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pKo02kw7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A6E688B9F; Tue,  3 Sep 2024 15:46:56 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7024F88297
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 15:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydYs76gVjMal0Ox9HqF1FdPwLtZ4QFn8Ty5yL6wuAI6+9HFrBtceMxrZM46UhLOWfzvsawVUE4uuhEM4tU5c2RCmdlN62uBBhRdD/i9urbuYGwfdqNLW7xVVbkMDskIGyQXw8lbqMYU3gaKdiJ06qWujpZyO/81Fhorq7v5lE8VsfSmtQu4Figc2nhO8uD3/tCNS3CgIAlQhm/6d5rnRtVEeN0BGNkTkK8yvbMRd74p8T+2vK1Eya/GDdvmtU7JyZs9bBSdaRYMDvDc4vS99Ki/lVZX6gyOqNab/YLvrEaNJpIWtjS3GGTuQByvDhFRog0LVPrKetShUjTKq6pRFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHtx6HfgrE4J4/q7JLwV26PwVes/Vd26/ooMB1IssMI=;
 b=R0MttH0ucNKB6p/fMwf0jdcb3aF1giFvNYic3c736A0JeQbedt9amwItHaP0aY5/KieslgB5t/BLwH14j/YHiyre482H4hJHo81+FENs2SdkUY9RucjfgHqkqv8XNyT4m+fUZHM6bsqjSTj2+KifLdgOSPAJoIPGNUvcDabLCfRAwt2X5nUMQPFF6ES+eQUGsD5/kwUD/OHLgmztHgEMc5pFwp5f+6LLyH9imP9RdgUFHEtNh/NlclKBPBBAiEZmxDS4zOEyEBonTz+Y1EZVuNDqQh9O6Qqlk+mvEbd0GFfzaRn1Yr4jbLxj0C0ECDHtrWBS0i7mU8dDIeXT+CyRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHtx6HfgrE4J4/q7JLwV26PwVes/Vd26/ooMB1IssMI=;
 b=pKo02kw7Pk2J1mEpfpimVbXj0A5omGmNXWjTYbEvnw3cJl1LLXGeR+BHJQx4Q3/Ub7odPMkSKub1bQtNq5pAT51p/AIzDpcZ0k14FnQ/vDsu+qMBnPcv12AQpI4ChvSp9BKwkMXfYc7mHpbkkpOZwn2/Dx6KSnPB5OIAcgdEq4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 13:46:49 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 13:46:49 +0000
Message-ID: <21922315-5b50-4fab-abb6-4b19d59083f1@amd.com>
Date: Tue, 3 Sep 2024 15:46:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/9] spi-nor: Add parallel and stacked memories support
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, trini@konsulko.com, git@amd.com
References: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:806:d0::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 98781428-8200-4f51-b7b3-08dccc1edc19
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UU1yTzdPVjE2YnJlQzdoQi9id2lXdCszV0hRa1ZVV0thQzhrOEFTbnZKT2hO?=
 =?utf-8?B?VC9SczVyRGkwaXltVGNEdkNEVlFKVlc2ak5YWWZTUHFQUExsNXVGREd4emh6?=
 =?utf-8?B?Sjd4Wk1oS1pPZmoyZFdlalJUcGZiQVFLR0ExSnVMd0ZOVDFSay9XMnVrb2hU?=
 =?utf-8?B?UXV6aXpKWldsS0dNZEFrUTBiTEFGTWV4bVRYaFZsdzFmelZPNE96OExaQlFK?=
 =?utf-8?B?ajd5YitjelBKUGJXMG5DK2tlQkRJekg2ZERCREF1dFVSanA0dnlFOEJwWEpp?=
 =?utf-8?B?WWYzMk1VcUZEM1RxTjZFalhUN1dxL3VndlUzVHRPUGhzMDg3eUZRRVNxNk9y?=
 =?utf-8?B?RXFUTGtaOEtWaEZXcEUvUno3RDdhdEYvdmUwRHd5ZDdtVE83UVRYYm50Q0RR?=
 =?utf-8?B?YVcvaUxYdFFrK052ODhvYnRFRGRUait0T3BuL2d6QWdxbnVTa2grVnVianRX?=
 =?utf-8?B?blVSeUp5VUVlbHNZYXRDVXJxMjh6NmE2Nk52MVA4MWorN2kzOGJiUmozdXdv?=
 =?utf-8?B?V1FyYVdWZVl5S1hVOUhlaG10R25BN1d6Zjl0dHc5TjNtTXgvTGRWbW55T3Rm?=
 =?utf-8?B?dUpSVE1QTlV3bjZuNFJLcTdoVStnZ0I1elE0TGhLOEpySEdMZ1JRVFBxdW5p?=
 =?utf-8?B?MDJWN09KQnpKUHk4WE5hR2RzeTZTU0JrNkFkd3NVV3c3TDlXWFptalpzNTg0?=
 =?utf-8?B?dThxNDF5T2orZndkNGNTTm5HL1VYWUZsZ2lZVzVaQ1djQ09pL3MzM0l3TlhH?=
 =?utf-8?B?Q1hKb01qWjNtUkxHelQwa3RtV2xyczZyVkZpS205cmJvRVEycjBreDUvZFo1?=
 =?utf-8?B?T3MwZzdrdktvekhOSFh3K1VUNjZCc0lwRXE1SUpLdUovZkxpS05iQXFQL2VD?=
 =?utf-8?B?WFlQVnFHREhVWis5QTJTMytKTHpGL1Z0aUp0VDgvQWphQWVNRndBeHY5TGxM?=
 =?utf-8?B?TGFVd3V1c0RVV2VnWkViYUNleXVTSjBxNjlzWUpKL2VyakNHaXhZRy8rcmo4?=
 =?utf-8?B?cFUxZ0VqbjBNV2tCcFp3UmtxMGFqNE9HK1NvNE9MV2ljaG8yNlQrVHQyVTFQ?=
 =?utf-8?B?bU5MbUJDbjZBNUx2V3o4SlVYaGhNUzFuL1RXOEJSVTBROHAxYWtCaFZ2R2gr?=
 =?utf-8?B?eThZVWIvYmtZS0JGamJlbkVuRnJYaklGQ3dQTkpuUkRQVTI3NFVldWZxT1Ji?=
 =?utf-8?B?Z1Vvbm1NNlY2ZFZiQzB6ZEZxKzNoTnJLZ0dpNWJtOUNXNTZvNGhhVGRtV1R3?=
 =?utf-8?B?T2NBdHd6UmlmdG5hbjRYUjYyZ1ZzQklPWFV4ZnNBQTNiVWFYSEYxWXlvZlFu?=
 =?utf-8?B?RE5zWGtoaDBDUlFabHlJeDFldjRYdlhRMW8zZTJRZ2g1R0h4ZmJRdXVPakFp?=
 =?utf-8?B?RlljRUxYZXhsSVZIM3c1bVJjemNFOE5GdmpnQzhxT3RaREZ6TmVnMGxsSWZE?=
 =?utf-8?B?eE9GK0JBaG9wZjdlWS9uYU0vSGw2UnVsL3RObEloNXQvN2Q1cytzcjRMS2Jx?=
 =?utf-8?B?Um1KVXRvU2FpcnZkL1ZUakI3Y1lWNi83OVk5OEh5ZVNrUkpET3BXTDA5WnU4?=
 =?utf-8?B?aENJRFAwTENtazhxUnBVcEdvdG9FOE0yQkJVZlRYQmZoaHpBaFpKWkZabXdq?=
 =?utf-8?B?RFJjajhpS0xFT1Y0NktSREk5dTR0WmFRaDdXaVA4THFRdlBHT3hsUU00aFM5?=
 =?utf-8?B?RGFxanVQMk1TSWlRbkVZT1E4a2lNc0Ezb0FhTUFYdnRjRit6VWFCN0t5UDY3?=
 =?utf-8?Q?r0DFMu1FB7UqvdEPwM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlB0ejlJMjkvd01FSzNLNFp0am8rSEZycEhyNDVDVVl6azJJUEJKNDlWUUhx?=
 =?utf-8?B?MW01OWFER3grVGFQZHF1bFJnWjVmL2krc3Nsa0ZaY25SNGNxVUJJNmY2Y2dO?=
 =?utf-8?B?ckV4VEVXRHF2a3p5RGRNaXEwVmk2a3FZbmpHbHhIUUVFb2dZbmg5TmVvSGV5?=
 =?utf-8?B?SjZ1dWdqb2JsdEtNOVNIWXZUZnhDd3diVXUyMDlNQ3ZCVW1VMmZtdEVEaGFt?=
 =?utf-8?B?c1Z0L0NMZHFjdmV0M2dnOHJvRWRoak9kSjZ5NzdHc1BlNXlkRjhiemIvRmV2?=
 =?utf-8?B?ZUtVd2ozUkR6bVo3OUM0bWYrZ1RDNW9CRXdwNXJ4dTlLVzJPK1FrZndkbnlo?=
 =?utf-8?B?Y2h2YjN4TWNZZllyN05sTlFmQ3F0eE1iM2d2ckNwc0k5elZYVE1JY2hoNVZE?=
 =?utf-8?B?OW8zeVFOY2dyVlhGYUtndW1sakR1ZVJRZWNwbXRSSlZEOWdsblhMdHZpSUhQ?=
 =?utf-8?B?a2dJNmY2UjZyUlg2M216QWlHQkFjQUQ0UEI5dnl3djNkd2xrRHhwaWVOdFVq?=
 =?utf-8?B?cERVQ3dhcGxLdXIxRzEyeG12YkUrNlA4ek4vWUNYTUh1Nzkyd3VGY0pueGQ0?=
 =?utf-8?B?TU8xbXh2c2R1V0hDMFUxcHBQRlpGK2tiTGtBWkUwL0JPSTF6MFVPOEprNHJz?=
 =?utf-8?B?dlE2TG1JRkhqTm50ZTNoOFdBRE5nTm92cTQ0dUQ5L1V3MGNqTFptcUJjQkU0?=
 =?utf-8?B?WmVVRzVjTTd0N2h6UVRCeGlyTXV5L3VVcFI2SWpVRFBEdjdQOHRheTlXVldW?=
 =?utf-8?B?dmt2aEtHM0ZacWpKQ3h2dnVRNUtiOVBMN3E5VTAvaFlTSkdZZmlUOENpNkQw?=
 =?utf-8?B?d200NHlvcDYreW1xS3FKaVFyenp2OXg4Wkg4RlU0OE9ad3Vta2ZLQ2NwNi8z?=
 =?utf-8?B?aWVra1Z1cys2cThkSHdHdzgrOStzNlVTem5xOGZQbVplRk9tSFFSZVRYbDdR?=
 =?utf-8?B?cUNFSnJWMy9tNTZsYzFCajlVSCtWcnhVK1YraDhYOWE3b0ZzckZpc2pIbU52?=
 =?utf-8?B?N1FZVC9Jd2xxeFE4Y2N2NnNYU3UxK1dUc01SdmdCUkZSQkJhdTJHY2FaazJ6?=
 =?utf-8?B?K0VUMjNYQ0l1dGdpNlBoaVhNbUdyNXZsMHo1aU5HTlkxYjhxRHovb3RFRzho?=
 =?utf-8?B?RnNUWWlPd0ZqY3ZvVEkwMTVVQU03Sk5peXB2Wm5Qamp2aXFFQ0Y0cWhJRnFX?=
 =?utf-8?B?Syt0djRrZkdFVEMxYS9nS1UxNURCM0tWbjA1VUZmZm5ncmNKYkxKL054Vlk4?=
 =?utf-8?B?R2ZVdzhkc0x2RDA0OTNrUUlJblZzK3hlRmZtU2gzT1NrdmhhOXU4V3NHMVlu?=
 =?utf-8?B?Z04zZ2g0NGJJR2tHbFdQWURocDNMMnNQSmJwckRhMTR1NElrQ3pyV3NLNlBF?=
 =?utf-8?B?WVFuSGNwZzQ1c3hvVUY4bWdHZ01YbVJEN3RTSGlMTTc1aDRLVzBYemoxVGdZ?=
 =?utf-8?B?bXUxc2o5dmJTZW1aaW9haWxlNXlwUzRlTU9LYzdoY1hFTlRvMjl4MmozRHd4?=
 =?utf-8?B?OFVwRGtKdjFtV050aUNzYTdSekQzd3NzMWljK3I0SzdNd0s2MFdTbFVoR0ZS?=
 =?utf-8?B?QXlPT0VndUJCV01uU1dlbzg1bmM1aHVEbmZxTzlqNjBaNjd4WUozNTRPeUwr?=
 =?utf-8?B?enRVMGxVSDJXMzRxeUs4N3ZDeFFpeU1vUHNySFc4MHBvTi9nUUJEbVhWc0l4?=
 =?utf-8?B?YkdLUkJjMHQ3dVJVSGtmd1Uya1MrSTZ1NjEvTWZ5cEtkTHBuMmVtMUZodjE4?=
 =?utf-8?B?Vm1XT3o5endCSXRGT2pCSFFGbW82aU5MQ3VHK09ONStlNkZ1b3JJMWYvaktK?=
 =?utf-8?B?NC91cklSOVVrbXM2N0xrcEp3NllHSUxkRE0yWW5ublVEYkRCVjlBdnI0d3du?=
 =?utf-8?B?Y0xVSkUvUEJjWCtsMzhZdExXc2ZheGRZaWd6Szl6QjI5dXBwcDNEcEVLYmhy?=
 =?utf-8?B?VDU3OXdYTEpEaXc3SG1MYTF3YUdpNy9kTWZVNFNlRU9BRW42QzQyTFpXR2ox?=
 =?utf-8?B?QzBsRkljdVNmdWx0a09tVnZYN0QvalZHZUlrT1MvL3EwdHh6L3UxbVc3RXhP?=
 =?utf-8?B?WDR4NkFxeTBBT2dRYnVzajlORG1yVnVVRnBVZDNmc25qdXlCRU5mei9UTmIw?=
 =?utf-8?Q?+nR8EenpfcT7VAFIpEssn3ixX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98781428-8200-4f51-b7b3-08dccc1edc19
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 13:46:49.4155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UqJTo7nbKUSrGhry9CDBqdGJSqH1JtDghp/dcCypmBBq6Uu3fhhPVNVM+8SizC4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
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



On 9/2/24 12:26, Venkatesh Yadav Abbarapu wrote:
> This series adds support for Xilinx qspi parallel and
> stacked memeories.
> 
> In parallel mode, the current implementation assumes that a maximum
> of two flashes are connected. The QSPI controller splits the data
> evenly between both the flashes so, both the flashes that are connected
> in parallel mode should be identical.
> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
> nor->flags.
> 
> In stacked mode the current implementation assumes that a maximum of two
> flashes are connected and both the flashes are of same make but can differ
> in sizes. So, except the sizes all other flash parameters of both the flashes
> are identical.
> 
> Spi-nor will pass on the appropriate flash select flag to low level driver,
> and it will select pass all the data to that particular flash.
> 
> Write operation in parallel mode are performed in page size * 2 chunks as
> each write operation results in writing both the flashes. For doubling the
> address space each operation is performed at addr/2 flash offset, where addr
> is the address specified by the user.
> 
> Similarly for read and erase operations it will read from both flashes, so
> size and offset are divided by 2 and send to flash.
> 
> Changes in v2:
> - Fixed the compilation issues.
> Changes in v3:
> - Fixed the CI issues.
> Changes in v4:
> - Removed the dio,dummy_bytes variables from zynq_qspi driver.
> - Fix the compilation issue by including the DM_SPI config.
> Changes in v5:
> - Fixed the issue reported by buildman.
> Changes in v6:
> - Fixed the issues reported while running the sandbox test cases.
> Changes in v7:
> - Fixed the issues reported while running these da850evm_defconfig,
>    imx28_xea_defconfig configs.
> - Fixed the issue when DM_SPI config is disabled.
> - Fixed the issue while running the sandbox_noinst_defconfig with spl
>    ./spl/u-boot-spl -d arch/sandbox/dts/test.dtb
>     jedec_spi_nor spi.bin@0: has no valid 'reg' property (-12)
>     jedec_spi_nor spi.bin@1: has no valid 'reg' property (-12)
>     ### ERROR ### Please RESET the board ### Changes in v8:
> - Fixed the compilation issue with imx28_xea_defconfig.
> - Fixed the SPL size issue with the axm and taurus defconfigs.
> - Rebased the patches on top of next branch.
> Changes in v9:
> - Updated the commit log why SPL_FIT is being enabled.
> Changes in v10:
> - Added the new config SPI_ADVANCE to fix the issue while enabling imx28_xea_defconfig.
> Changes in v11:
> - Removed the unused variable, corrected the type of variable and replaced memcpy with memmove.
> Changes in v12:
> - Fixed the compilation issue with mx6sabresd defconfig, as the binary size got exceeded.
> 
> Ashok Reddy Soma (2):
>    mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
>    mtd: spi-nor: Add parallel and stacked memories support in read_bar
>      and write_bar
> 
> Venkatesh Yadav Abbarapu (7):
>    mtd: spi-nor: Add parallel and stacked memories support
>    spi: spi-uclass: Read chipselect and restrict capabilities
>    spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
>    spi: zynq_qspi: Add parallel memories support in QSPI driver
>    spi: Add the spi advance options for non SPL
>    config: xea: Enable the SPI_ADVANCE config option
>    config: mx6sabresd: Default don't enable the flash lock
> 
>   configs/imx28_xea_defconfig    |   1 +
>   configs/mx6sabresd_defconfig   |   1 +
>   drivers/mtd/spi/sandbox.c      |   2 +-
>   drivers/mtd/spi/spi-nor-core.c | 400 ++++++++++++++++++++++++++++-----
>   drivers/spi/Kconfig            |   8 +
>   drivers/spi/altera_spi.c       |   4 +-
>   drivers/spi/atcspi200_spi.c    |   2 +-
>   drivers/spi/ath79_spi.c        |   2 +-
>   drivers/spi/atmel_spi.c        |   6 +-
>   drivers/spi/bcm63xx_hsspi.c    |  42 ++--
>   drivers/spi/bcm63xx_spi.c      |   6 +-
>   drivers/spi/bcmbca_hsspi.c     |  34 +--
>   drivers/spi/cf_spi.c           |   6 +-
>   drivers/spi/davinci_spi.c      |   8 +-
>   drivers/spi/fsl_dspi.c         |  18 +-
>   drivers/spi/fsl_espi.c         |   4 +-
>   drivers/spi/fsl_qspi.c         |   4 +-
>   drivers/spi/gxp_spi.c          |   2 +-
>   drivers/spi/mpc8xx_spi.c       |   4 +-
>   drivers/spi/mpc8xxx_spi.c      |  10 +-
>   drivers/spi/mscc_bb_spi.c      |   4 +-
>   drivers/spi/mxc_spi.c          |   6 +-
>   drivers/spi/npcm_fiu_spi.c     |  14 +-
>   drivers/spi/nxp_fspi.c         |   2 +-
>   drivers/spi/octeon_spi.c       |   2 +-
>   drivers/spi/omap3_spi.c        |   4 +-
>   drivers/spi/pic32_spi.c        |   2 +-
>   drivers/spi/rk_spi.c           |   4 +-
>   drivers/spi/rockchip_sfc.c     |   2 +-
>   drivers/spi/spi-aspeed-smc.c   |  28 +--
>   drivers/spi/spi-mxic.c         |   6 +-
>   drivers/spi/spi-qup.c          |   4 +-
>   drivers/spi/spi-sifive.c       |   6 +-
>   drivers/spi/spi-sn-f-ospi.c    |   2 +-
>   drivers/spi/spi-sunxi.c        |   6 +-
>   drivers/spi/spi-synquacer.c    |   4 +-
>   drivers/spi/spi-uclass.c       |  34 ++-
>   drivers/spi/stm32_qspi.c       |   2 +-
>   drivers/spi/stm32_spi.c        |   4 +-
>   drivers/spi/ti_qspi.c          |  14 +-
>   drivers/spi/xilinx_spi.c       |   6 +-
>   drivers/spi/zynq_qspi.c        | 121 ++++++++--
>   drivers/spi/zynq_spi.c         |   6 +-
>   drivers/spi/zynqmp_gqspi.c     | 141 ++++++++++--
>   include/linux/mtd/spi-nor.h    |  12 +
>   include/spi.h                  |  23 +-
>   lib/acpi/acpi_device.c         |   2 +-
>   47 files changed, 794 insertions(+), 231 deletions(-)
> 

First of all this series is passing gitlab CI. You can look at
https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines/22221

Second I have run buildman over imx28 and there is issue with bisecting.
I think you should fix it to make tree bisectable.

Summary of 10 commits for 2 boards (2 threads, 6 jobs per thread)
01: Merge tag 'v2024.10-rc4' into next
02: config: mx6sabresd: Default don't enable the flash lock
03: mtd: spi-nor: Add parallel and stacked memories support
        arm: (for 2/2 boards) all +1455.0 bss +4.0 rodata +35.0 text +1416.0
             imx28_xea      : all +1455 bss +4 rodata +35 text +1416
             imx28_xea_sb   : all +1455 bss +4 rodata +35 text +1416
04: mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
        arm: (for 2/2 boards) all +124.0 text +124.0
             imx28_xea_sb   : all +128 text +128
             imx28_xea      : all +120 text +120
05: mtd: spi-nor: Add parallel and stacked memories support in read_bar and 
write_bar
06: spi: spi-uclass: Read chipselect and restrict capabilities
        arm:  +   imx28_xea
+drivers/core/ofnode.o: In function `ofnode_get_property':
+build/../drivers/core/ofnode.c:1191: undefined reference to `fdt_getprop'
+make[2]: *** [../scripts/Makefile.spl:532: spl/u-boot-spl] Error 1
+make[1]: *** [Makefile:2097: spl/u-boot-spl] Error 2
+make: *** [Makefile:177: sub-make] Error 2
        arm: (for 2/2 boards) all +301.0 bss -4.0 rodata +85.0 text +220.0
             imx28_xea      : all +305 bss -4 rodata +85 text +224
             imx28_xea_sb   : all +297 bss -4 rodata +85 text +216
07: spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
08: spi: zynq_qspi: Add parallel memories support in QSPI driver
09: spi: Add the spi advance options for non SPL
        arm:     imx28_xea
-drivers/core/ofnode.o: In function `ofnode_get_property':
-build/../drivers/core/ofnode.c:1191: undefined reference to `fdt_getprop'
-make[2]: *** [../scripts/Makefile.spl:532: spl/u-boot-spl] Error 1
-make[1]: *** [Makefile:2097: spl/u-boot-spl] Error 2
-make: *** [Makefile:177: sub-make] Error 2
10: config: xea: Enable the SPI_ADVANCE config option
        arm: (for 2/2 boards) all -72.0 bss +2.0 rodata -22.0 text -52.0
             imx28_xea      : all -144 bss +4 rodata -44 text -104

M
