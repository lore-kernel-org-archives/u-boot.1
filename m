Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC398C7883E
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 13:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 105BB88CD1;
	Fri, 20 Sep 2024 15:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GHm/zBgj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 408FB88D9C; Fri, 20 Sep 2024 15:32:20 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 671618841E
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNjxyuQkdyLqa0NETHvfxwwiCXp+eyPO2qFTJv0EqfzLCjeAGbUw0Cfj7UY3Mnfy2xZ49Myf3hgaNMl7P3Gms5tgFfLwVCe1iJDX94uHWHdCQxVmPS+xpilssvVLDdJk+bQgDkOWrN+v4wgQFrT9S4/T+oiGZMKK9DXMqqlppN6qvnR2L4BHYYoO1qtGGcHpnpdxW+MVc+LrbSEPEXcT10oDymN2UiHMYqKSxpL8kGTPpMqgfrHSnckX4goZagwjdo3iM3dt2ouo8EDuI5KdLiq8Z9e3/QA4KvEJ3ZuDU4/lKPbVHHbao3npgzgMKKKnI1EbGHo1w+evrRLsPnc9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzOt0ooKcruZyQSwQKXKJdDU0Gj3ZC/VmVbd1twrjJA=;
 b=RkySfla10wTnEE947YvrmIbokHL37fN2Bth2Riqx23oFWfW/QsSJRVpLyleMqVfDd+K3Yv9klq/1kIsOYUcBjTXwcI4sRVXPBFXsG/r3D8rypTvoMGCViplrILa/CBdipLDyDLJa9hdJsTJXwcF6hrks5wzwTt64XHCcja2NJqB57qXpbz53NJ15gW/TnwpTaD7nqHqqJIwq13uVM4mA/ssHbn/UjEOLSE65YmXK7tndhMRREXRh/fvuB2BAyEzdQsobpoQ/DSHOYigNxkZi0P5gBzwPd9JlJViWRR6uLTcY2Czfe2jCsGBzDZ7ARevDquvnUtPtyfzazga2UfMt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzOt0ooKcruZyQSwQKXKJdDU0Gj3ZC/VmVbd1twrjJA=;
 b=GHm/zBgjm9lcgkaOms15UsK/N3eCP9YvK/CLHzcrYGgPhBn5fFaOPZ9hNH4fRSFjJh+3HHI+ah0FQNAOW14P+qaZxXgxQdQlLPvv8Tv3lOmnJHg6xnDAbu42ExS1Pp/qD1GI5VAdwnfdykMr1SgE2tOLlBLDFAzi9ba449J73jg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Fri, 20 Sep
 2024 13:32:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 13:32:07 +0000
Message-ID: <2a0a91fc-ab64-4bea-ac7c-40bc70cf8299@amd.com>
Date: Fri, 20 Sep 2024 15:31:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] arm64: zynqmp: DT schema alignments
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cover.1726219714.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1726219714.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 764fb06c-9ceb-4444-2279-08dcd9789f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmJyM3lzSVFNaElNUm1qdGZmMjlEN1FJQmdsa0J5SUw4SkNUa2NkUFlnaDlR?=
 =?utf-8?B?dGxiMFlRa3YwYnRRYWZrbmtQYUN5Nm9OdTN1RTlPWlN4M1c4cFRFbzg2eGJV?=
 =?utf-8?B?bjYyU1MwaVJyamh1Z0I0L3AybHgyMWUycGQ5R1FOT1JlTXRWVHp6ZEVrQUx1?=
 =?utf-8?B?c1FFaEhUNUFhajlxRjZGTVZ6TXZBU2tYZnNNMDJtY1BpeGtacTRINVYvZjlv?=
 =?utf-8?B?WHp0cSsrQ29laW1XYnZ2MmszTzV3VUowcWRjUXh4UmZ0VFlHRHlkc3F1WkJO?=
 =?utf-8?B?d21ZZ2krdDZJbkIrOFkrM3hjRGpHK21OQ0Voa2I1bUVOMEZXVitZYWl6dnBI?=
 =?utf-8?B?cDJ6RHNDeTlPU0xTQVBOZHluVXpWK1BOems3N0JiTTFobXpUekovTnBXakRo?=
 =?utf-8?B?aytpVE9IQXI2Y24zWk1NelYwUGNzTVNOOFB1VGFpTU1nZFc1MFh6bG1jOVQv?=
 =?utf-8?B?Q013aG1PWFVoS3BZQkJPZ2pLckliZ2xvS2R1VVhVVTlRRTduVW1vNzJGakJT?=
 =?utf-8?B?Z0xqNkNiZGFpeVdjSkNTU2hpREpFSVBDVFo3clBUdndPc0JlWlo0STQrM1pj?=
 =?utf-8?B?QUVQSW9XTmdaZWFHUk1JV1V6NGhJQzFZc2YvdnVyeW82WXM5aUJCYlE4elZa?=
 =?utf-8?B?RzdQRituUVdtZlQxcHliMGhxM2RmVmlSNkdrQkJoajZxSDRiRFVTR04xNGNW?=
 =?utf-8?B?QVVHSCtMZUlvSzVsN3FKajlZTDlnZzdJRHFqWDlwSy9sdU1XQzl1MUhsemhx?=
 =?utf-8?B?bWlSaElNZzlZWHpFRThMRUVnY2NhcmxIMnFaTk5iT29tbnFKN1k0MFMvVmh1?=
 =?utf-8?B?TW9VSStXOUZBWUlaNEJlVFZzcXEyZlIzWkxXcXNNR3hUS1BSSElPNndpNTNi?=
 =?utf-8?B?QVdzQkZpSGVqK3hPUTY1Nk01eStzdHFGUFBmMFh4TURpdFBDYVp6eTVVSzhX?=
 =?utf-8?B?RDdJVlArd1psRS9KMmJEbk1hbWdGYnVZZzU5NDhQY2RmS3lVdVhTa3A1cjBo?=
 =?utf-8?B?WTY3UFkyWG5LbzFJNk1hNXJwdVJJTlpHNzg5ZU1IS2c1RHI2VHV3M2w2VDRB?=
 =?utf-8?B?VXZsUGcxTmE1SlZKSkZlSWc2RFk3eDRMUkM3dlM5TTV4YUdZWmp6RDQ1THZv?=
 =?utf-8?B?OWVHL2lsTDBPOUYzK1pmNkJkYlpRWjA5Zk10SzhjZzMramtmOE9pRGFrb2cy?=
 =?utf-8?B?NWdFVnlLNmU1eEdhd013enF0cEdYTmROZFNUNHpiazFac2dDbXVEUHpaSGsv?=
 =?utf-8?B?eEl4SGVXZTg1Ry8wKzVDOFBTTVFGK1VuZlFtU01UQVJvVkw2YUlKUXZJa0tO?=
 =?utf-8?B?NHM5MFpCZnFyeUJHUDZYZ0RQZTFEVkEwMzFjUE10cXRzR29BdHp0TG5rSjd5?=
 =?utf-8?B?SVNIZHZsdGw3UDRuVjlaZHJnZ1RXTnk3M0tiU1p5UW90QlFzUWt1dC8wWUlq?=
 =?utf-8?B?a3gzWjY1UXRyT2E5K05zY1R1OGJQZmZKTUNOMnZSM1RmVllrbU1GVkFDWUZw?=
 =?utf-8?B?S0s5L1BRN3hGeHZUQzhDR0hYSDV6YWxUTFI5YzN5UUh2TDJzdm1hdEwrNU80?=
 =?utf-8?B?L2ZCbTB4Z255UnFDWFZETnN0N1J4NFhLYWg0Z1RUTDYraDlla1R5cUliYk1M?=
 =?utf-8?B?ZytnVVpybjJib3M0Zk9wTWhacXcxSzRtYitpRWUwdm5tS04vS3BvNDhBYTJ5?=
 =?utf-8?B?WTVXYUd1WVFoaVp6eXBlcWluV0VYeXNvUFE4LzdQYmczNEMwWldzemtkOGNj?=
 =?utf-8?B?NlV1d3hhemRwZ3VDV2oxYnZXNXZ1eHpOaWJDWlM0MlpZV1N1RkpOOGZtWE5W?=
 =?utf-8?B?SmZXTEFVTGVwOWVhdGV2dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHJCNlJ6djVJdjVSSmYrVkxYMEEySVJlcUFhenNYZlhGUHRhSWR4amQybUkx?=
 =?utf-8?B?Ums2SEh1cHlJYzBhMm1iMnhtOCtTRVNTcW85VytPQUNHZ004TlV2OUwwVCtv?=
 =?utf-8?B?Mk9JdVIwUzR2QlN5UEM2ek9wNWRQeDdPZFBzMC9ZNHlNTHowbFprNzlwc21N?=
 =?utf-8?B?MkRyWHZGS05vbHh6bXVwWlZqOHZWdU5xUGFqUGNLS0RxV2lrVTVaN0toQWhZ?=
 =?utf-8?B?SzZUeGdUZm5KdUVoQ1JlUWxlWjhOUHdETEUrTjRadDZBYUdTaGFUaTU5YkdM?=
 =?utf-8?B?M29GRDVhSzd6UGhUanpMT2gybUEyQW1xSkltVi9wL2Zlb3RMb3c4VzhKMUZ3?=
 =?utf-8?B?S0NqRGI2N0ZvT09OcTcyVzdtVDlKTGN1MnI3RVhlYS9DSEMvV3lpM3lGbXFk?=
 =?utf-8?B?czgxcm9KSGgvT01tejBYdzY1RGNOUHA2d1JqWWJBd3NUT0c1SlVkMW5aTDRW?=
 =?utf-8?B?QWs2alFmUmkvT3dyVWN1SGtoUjR4R0VBejV4Zy93aFZzME1pR25wUy93NTdh?=
 =?utf-8?B?Y05FLzZHVUJybWlUV3RDdTNSS1hEN3Z0MjVWS1FpZnhnSzFXRThQSlA1YnpK?=
 =?utf-8?B?OFhuY3VYMWZJeDNUK2c1SkVlM2lSQ2s0STRVRFBGK3RlY1laZVpvOVpZS3ZV?=
 =?utf-8?B?WXdHTXNyRTBlTE9VQmVtMkFNYThMK0QzVWFyKzhHSzVjd3hWMHBCcVdmc3dU?=
 =?utf-8?B?a29KR0NjbmY4NTJNcy81TmpNWTYvd2RrU0ZsU2VuVy9RL0h6T1cvTHcwb0pp?=
 =?utf-8?B?ajFkSWNZd0hDMDBvOVVDN1BUdDNQRWN1Vml4MVc2SjBWK3k0NlgzUlBoV2tG?=
 =?utf-8?B?dDR3TFo2T00vbDMyclBDa3RZdWVseGIvTGlteE5DN3RBZzIzaDY4dnI4MkxS?=
 =?utf-8?B?RDNHbWlWREUwR1lJN29RVWw1WkROQ1dZWEFpZmUva0lJUG1RKzA0R3F3bURC?=
 =?utf-8?B?UTdFS0Uxd1RQSnJ6c1F5M3Q1UzNSNFRlOFFtOTdnTGJZQ3pPTnpTOXFIb3dk?=
 =?utf-8?B?a3I2U3dWdjJBOTRxZ1hIWnl4bGxDSHVudW9WZlN4ZENyNzVHemc4Y3JtdWJ5?=
 =?utf-8?B?TkxRdFBEM3dINWczMWNYQWV1U015ZTF4ZDRISW1aaFRWZHZBMGNOUUFSSFB4?=
 =?utf-8?B?L2NPWnR4Y0p1QUgvaGZOVmxxQjBJQ2YwQUJ4bjh1aFVlRG9Db1lsUTF4WjRh?=
 =?utf-8?B?d2xjaXpSdWM5WVF3OGYxZXg2NGlmNXhWSDB3S2x2dHpKVExGc1FHMGZZOEV1?=
 =?utf-8?B?NXFVOFpxUm5oTUprNDF5MEhlWkxPQzB4aGl4dGR4bnllZCt1eUVmUTZSdURH?=
 =?utf-8?B?bjloZHpMY2tNR1hPaUlROFIyV2JMUVpuSWRmbFZOTENnT0h4RXoweGpXWGcv?=
 =?utf-8?B?WWNyMmFDSElhdmprZTUzaVVJZXZiNzRkMmhFYkNFMGJmb09rMmpWdWxhU3ZZ?=
 =?utf-8?B?WkIrbUNvRlFRS3NKT2tubzVSYVNJcm1aK3V0Zm0zYVAyRzZMQXpsL1BtN3Fh?=
 =?utf-8?B?OG96VGNDUk5EVUd2UlZtVFViS1NxRmlmY2NvalNqOHVzdlpxQUcvV25lSE9i?=
 =?utf-8?B?L1EwVHVBQTVWRlMySVNKaGx6Y0dvUVo4MUw2RDMvWUt2YU5IdXZMeVNLWCtW?=
 =?utf-8?B?aG9CQ3hPWEsvSnpya21mWWlnYjVJSzdUalZsTlV4dnZmYTZXQzc0M2VDcTVu?=
 =?utf-8?B?QnkwSkNtUXZ1SGVMWXNFRGpKejZSTnYraW1iQ25Fek9RSmI3ZmtzeHRvSm1n?=
 =?utf-8?B?MDBxZTZNck5zWGZEU3RnMHhVVFVZaDJJQ1dWOXR4b1NsdVJxcEtYM3phNmVq?=
 =?utf-8?B?UlVIazZEZHlwU2k2TEFOSG5JMmM0eXAxd3ZVcjBDaE9wb0RkT21zQ0JrREVY?=
 =?utf-8?B?aEIxaStvSC9ndTAzaGI4RWFaU3FrVlRXamthR2cvYVlHLzNWT3FqNG1YRi9s?=
 =?utf-8?B?TTR1TGtWNW10bkkzM3FEdFBKOTZPWnlLQ2l3aFR2OG9XM0JlTGNtdC9GaGR4?=
 =?utf-8?B?NnQ0WXl0alF1RUZoblBKRHJ6YWJEeE5IVU8rZzZUaVVQOXlpbUpXdDdyVlha?=
 =?utf-8?B?b3dHLy84b0VVOXh2MHdYZE5ydDUvd0dNRURjcHRBUC9FSlRaTVd0R010VDlS?=
 =?utf-8?Q?ev5EB7K2KKR0qv1isKuWC5maT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764fb06c-9ceb-4444-2279-08dcd9789f93
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:32:07.8772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYjWQUSePjdPo+f8vnFDkvo0+AniasydoQS1uGjc9r1T7GaNMCdIGuhHB0LJCtx7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252
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



On 9/13/24 11:28, Michal Simek wrote:
> Hi,
> 
> I am sending some patches to fix issues reported by dt-schema checking.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (10):
>    arm64: zynqmp: Fix status property for m-a2197 boards
>    arm64: zynqmp: Align gpio hogs with dt-schema
>    xilinx: Fix axi and mmc node names in mini configuration
>    arm64: zynqmp: Fix gpio-line-name size for m-a2197 platforms
>    arm64: zynqmp: Fix comment style around gpio line-names
>    arm64: zynqmp: fix i2c mux bus description for m-a2197 platforms
>    arm64: zynqmp: Align mini-qspi DT with dt-schema
>    arm64: zynqmp: Define phy-mode in zcu1275-revB
>    arm64: zynqmp: Use generic spi@ name in zcu111-revA
>    arm64: zynqmp: Rename ina226-vccint-io-bram-ps nodes
> 
>   arch/arm/dts/versal-mini-emmc0.dts               |  2 +-
>   arch/arm/dts/versal-mini-emmc1.dts               |  2 +-
>   arch/arm/dts/versal-mini-ospi.dtsi               |  2 +-
>   arch/arm/dts/versal-mini-qspi.dtsi               |  2 +-
>   arch/arm/dts/zynq-cse-nand.dts                   |  2 +-
>   arch/arm/dts/zynq-cse-nor.dts                    |  2 +-
>   arch/arm/dts/zynq-cse-qspi.dtsi                  |  2 +-
>   arch/arm/dts/zynqmp-dlc21-revA.dts               |  2 +-
>   arch/arm/dts/zynqmp-g-a2197-00-revA.dts          |  2 +-
>   arch/arm/dts/zynqmp-m-a2197-01-revA.dts          | 16 ++++++++--------
>   arch/arm/dts/zynqmp-m-a2197-02-revA.dts          | 16 ++++++++--------
>   arch/arm/dts/zynqmp-m-a2197-03-revA.dts          | 16 ++++++++--------
>   arch/arm/dts/zynqmp-mini-emmc0.dts               |  4 ++--
>   arch/arm/dts/zynqmp-mini-emmc1.dts               |  4 ++--
>   arch/arm/dts/zynqmp-mini-nand.dts                |  2 +-
>   arch/arm/dts/zynqmp-mini-qspi.dts                | 16 ++++++++--------
>   .../zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso    |  8 ++++----
>   .../zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso    |  8 ++++----
>   .../zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso    |  8 ++++----
>   .../zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso    |  8 ++++----
>   .../zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso    |  8 ++++----
>   arch/arm/dts/zynqmp-p-a2197-00-revA.dts          | 10 +++++-----
>   arch/arm/dts/zynqmp-sc-revB.dts                  |  2 +-
>   arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso   |  8 ++++----
>   arch/arm/dts/zynqmp-zcu111-revA.dts              |  2 +-
>   arch/arm/dts/zynqmp-zcu1275-revB.dts             |  1 +
>   arch/arm/dts/zynqmp-zcu208-revA.dts              |  4 ++--
>   arch/arm/dts/zynqmp-zcu216-revA.dts              |  4 ++--
>   arch/arm/dts/zynqmp-zcu670-revA.dts              |  2 +-
>   arch/arm/dts/zynqmp-zcu670-revB.dts              |  2 +-
>   30 files changed, 84 insertions(+), 83 deletions(-)
> 

Applied.
M
