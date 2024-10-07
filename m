Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70F3CFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 10:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 660D7889FC;
	Mon,  7 Oct 2024 12:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q8p/m+Ou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FA2B88AB9; Mon,  7 Oct 2024 12:02:43 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B815388363
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 12:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoJwEn2bIhOkuGaoytuovJlLS1CHYMJsC61Zfton5gfOl9suCLllQGGipgOuSYenju/EFM6j3WUx0OZlQfhjKnEXRvR01VNxUMBa8qRWTHgU4sizoxVK8SxXBlVxplw89Hh2lnzNBt3U+eYRVVFp4b8C5My8JDNeP17XZmtaw/iYTvBCT4A24WZSP5PB/aXV+iydMlHsHe/yse4Tuo67mHppCpT7sr1HnBS+j1kCPJpGqpATpMNSGu484OkQUkrVfDHfkJAhXYf3chmgfHL3NV4tJLpkbvTgFCj6UnlZ8abl5XQiWdnwvQddubQpSAyrhF/EHcFvSboW5e8DL79p3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9av9bzvH6Om6c2Nxf1YY3TpeLuUawemTEY4lQRXveOw=;
 b=LB1k1pNvlYOf7OUxJSDZ9x1734wy6Cl6i1OB7KVY6oUDKya4SDPzBWbhlEWQoiBRr3j5nTO02nThRML3ZC4GcDERLz/qni5ziNPljEcZKPEh2KTgu011bH0yQvTdI1dhOobyzGEpgGELGCI7Vh7LQlzgHID8stNL5pvjelc415r0vzvGj0EUn+yQjIMQrs/iT/V60H/kHEZxw/fxWHYPQpjYbE3rVZBWR469VkK1EzlY4RWXPxdjh+ITYFfJnwdx+onkQlcRlpS+k+PjFTv5SdQRLrBs42KdRl53Iv1JV2+2iUaX9eustdLSUASluB/Gw+V+tRStnB5gHcg5ANR/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9av9bzvH6Om6c2Nxf1YY3TpeLuUawemTEY4lQRXveOw=;
 b=Q8p/m+Ou4fULfZLI93ufqFqsXlGBmxjJD3WP31Oma9rOqKDLiB+9o1cCR+o006gpSEP6InK654S91VbXvP8+v5+Hjcc7HMXPM33txlKBgloxtrXdzAcLoN/qldSyI5PdH7shMDKfeF2B73B+ALhfPF8+ZF17hX1iWpgh2Ve6oKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 10:02:36 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 10:02:28 +0000
Message-ID: <c14b081a-c063-4b8c-af2c-ac00d29dbdaa@amd.com>
Date: Mon, 7 Oct 2024 12:02:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xilinx: common: fix script address for Microblaze
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, venkatesh.abbarapu@amd.com, Prasad.Kummari@amd.com
References: <20241001082537.830286-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241001082537.830286-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0051.eurprd03.prod.outlook.com
 (2603:10a6:803:118::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe412d7-69e4-4a25-67cc-08dce6b726e5
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnpYS3gzMDRpZXpRM05IcFRJL3ZhcWdYWU9OZFZ5MWdZdFZENXE0S3JnSWY2?=
 =?utf-8?B?SVRvaTk3Y293aGxncE9tVHVJM1U2SGY4NkxqTUc1cFFnK1RlK1JMNDI5aWdu?=
 =?utf-8?B?TmFkK3BvdTdvN2N1WXE2Q1NTT0s5RDI4U3VzaTNSR1dkdmpXQkpEQkMzeisx?=
 =?utf-8?B?cEl6bHFvSmFCK05TVXl5UGNmWHc3cWlFZU44YkdaKy8ydXNiK0NEejhKak9G?=
 =?utf-8?B?QnBza0RSQjJtNHNvRG9XNzE1cFVuZFhMV2ZSemt3a0RvSVRxOXQyTTN2RnBG?=
 =?utf-8?B?V3JRRzRsLzdpTENnTDNYMEZxNmhhRFVxTkRqU1ZUVm9xbW13bmNReGRISXdN?=
 =?utf-8?B?dnF4dzBjTDIvWjN5dzFSdDhpei9raURYSkV1M1QyTTBpUkpKTVIyTjRJeTgw?=
 =?utf-8?B?K083QlMybnZRSVBUblZUN25WWXVFNmkvOVRaV1FUSVhJTjRRWFRMeno5ZEFX?=
 =?utf-8?B?Y0gxQmhvcGVkN0RXYWd6cy95djJVOFBpQk1iME1IUE1nUDU0QXJoSFU0cmNu?=
 =?utf-8?B?anVsMnFlQUxqc0JmVUVNaVVEbzRBMmw5UUZXUVpMblI3YmFGaDc2Ulo1MFpo?=
 =?utf-8?B?NkRJblB3RWJMQ0o2KzlHWHJmWVdjclovYnJmOEFiMVo2cUxCZGRzRlVQejNO?=
 =?utf-8?B?K0ZOb2phMnJEMWNwQWl0OEhjK0hicGxXb2lrN3FDUVZnbDNxcExHcEdxRWV1?=
 =?utf-8?B?Z3JzdlhKWEdaOFlsa29uMmorbW5OV2tIMWQzcE53Z1JCNW9RdHlLSU5uM2po?=
 =?utf-8?B?eG5sWGVzZ3ZMZmNxV2wxVzdvb3FFOTdIWkJ0clRCdFJIVzVCWEd5OUdDdSt6?=
 =?utf-8?B?amp1QVVndHdsN1M2UkVEZkVhdld0R3RVVmxSVmlYZW91dEJUbkF6bnRrVmJh?=
 =?utf-8?B?SWpoMG1nV25jK2pkdVJlbklHM2oza2M0ZElvTUR4VzJWc1dkMmZ6RVc5YlIv?=
 =?utf-8?B?TlkwYXU1aFlqMmtKT0ZHNVFmK2dRNVRUcUZaYzBPZ2V3U3dDZys2ME5VbERo?=
 =?utf-8?B?MmFNK1YyaGxpMXB1eGxiV1pVZURVOUhBS0l6aUN0ZG1VZjhOdDl3blJ1RFBn?=
 =?utf-8?B?amRVajNGK09jVEwrVDI0NUwvT3FuKzIvWVUrUExjU3Mzb3RtaGxCZkY5V09v?=
 =?utf-8?B?M2VhWlZmaG94Z2ZIL292ZEZsSXBjL1M4NDVrQno4VnpQWXVDbmQxczlmaEhQ?=
 =?utf-8?B?eVZ1ODNFUkNRUEZWU1M4NHJPQXRDc0Q0KzAxQmNHRmlwSlkvTnhrcjdobHph?=
 =?utf-8?B?a2lncDl1V3QrdUJhSnpFWkNnYkdwMzZ5K0dZYkhGYTVsbmFoUTJLYzdvbU53?=
 =?utf-8?B?VU41dmhMaHJYci9FeDVpWDhmTVZXeUo5QnMwckZLNzdNbzhNQlY0ekRlVkl4?=
 =?utf-8?B?bE05N2doUTdzWWJMWUZaWjR2NmJZdXZ0N0NHTStHQ0RzTmtkSGZpc0Y5WkFw?=
 =?utf-8?B?ZVltR3JwQkZubk5OSFE2S2VUcFFMWkdzMll0NFNlVUxzZVk5S2NmaC9QUFRx?=
 =?utf-8?B?Z0REWE5PSUNsQ3V1TWFSVlhFTGVWaU01M0dNc082ZjV2SjQ1RXJJUEpQa3lG?=
 =?utf-8?B?V3ExYkxKMDkvRFhFOWtEQmlHRDZTZEQvMGJyTTcvQTdKNTBESVFNY0tGZ1Jl?=
 =?utf-8?B?cGtsZEdQemtwdTJJYmwyTytMWHNoejlPRDM5bEhnY0QvSG9FUmJ6UXZBSnNZ?=
 =?utf-8?B?T2FwZHZzZHROZnA3TmR0eUprdVgxcjlpTlNSWW1NZXNFMWlSUGlLL0VRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M05iaWNwa214c2dUMHg0SlpYK1VzUnh3b25lanFGNElnMFBiaC80ZmlvbGpz?=
 =?utf-8?B?SWIzUkxOU3JtQmVvWnB6STloK0dwVkxJbE0rc3lIN1dHOWpyWTZYQzErVFQy?=
 =?utf-8?B?YnZBby9LRitZZGk5UGEwVzB5TWpQcGhUZ2JRblFTbFFUazU3eGMwQUgwcDJp?=
 =?utf-8?B?QWtlVFdORWpyK3EzNUEwdjB4ZVZzSmF1RUlPSlFHUnQxL00zbThiZFFldUty?=
 =?utf-8?B?UVRrbXJaZkFwV0xIR2xUNHUxYmN5K2p4WVRVU2NCanYvSWdXTlhjUDlrVFJa?=
 =?utf-8?B?b3YxMjJKSTJtRTZvMDNwMVNhcXBOR2orTEttVHh5M25wVUhyN2hqb0h2MUtE?=
 =?utf-8?B?S2tCNStkSmMrM0xtQldSZHpBdERrZkttc0RqMFUxb28vRThqcDZZVEJzZFFp?=
 =?utf-8?B?YVowT2VQMVZxWW4vS25QVmE2ZzY3ejMvaEIyTFIwejNmRTNCcnluN3BtV0I4?=
 =?utf-8?B?MVlxMUI4VlFGbUM1RXlDeXBaOHZueEZWRmp2eDBYQVRRTjBYcEo1cUE5V3pI?=
 =?utf-8?B?TFM4dE5yaldRZmtKZTdRaUdlLzNMaXZldVRPREZwT2psSlVmeHB0N1R4Vmt0?=
 =?utf-8?B?YktQejNYZ2lyU0NYY0tCNTY1c0dRZ2lpMXlCNE8rQmEzSGVDcFZ3b1p4d0Er?=
 =?utf-8?B?VjJPdkpLS0xqMHM0VisxckhqZ2t1aG12aUk3QWdmOTlKNHRkWTM3Slk0R1VU?=
 =?utf-8?B?RlBlcW5nS0x0YTE4TmtXRmh5NitERGpncktuSS9UbWZMQmFYNndPcGl4Mkg3?=
 =?utf-8?B?VDJtN3hTVU9GUU5FZUdRazhCR3JyWnRGVjhIcXdtRzVoMTA5d2RjNzliTDNm?=
 =?utf-8?B?TkRNMWNQZEFzNUNIWk9qc091b29EUXFhVk8xZC9nL2xrMERxOEI2QXRWbjIx?=
 =?utf-8?B?ZHRod1diMkpKOGdIY1RqWWtHN0RKTkZVdEhoamtwSlIzeHRmMU5TdFN6OFlk?=
 =?utf-8?B?bDJUVk9kV1A0dFhOR25OMHhOSVFEN3V2djF0NGY3aExYclg2aW8zTDhzOXE4?=
 =?utf-8?B?Q21JRTBrckthZ1dtQU5qb2ljOGtsWUM3UFJCMUtONE43R0lPOU55L0JIWTJo?=
 =?utf-8?B?RWpqUkxqQU5ac1hDNlU0STNwNGo3WklwSExHbVlEaEY0dTFXYzRzakJYSEJZ?=
 =?utf-8?B?YmtXUTkxeUFrZzJGbGszeGp3RSt5V21CTmhSaDU1U08veVhweVljUDc3WHE5?=
 =?utf-8?B?YzBQNEJyQ1d2WGhmSHpUcnlaYmRXTlJIUkRyQXNtcGl5RGIxN0xmSnEyQWNr?=
 =?utf-8?B?cGQzbFJUbFM3em5XWFpwa3F0QXhPSDZFNjliM3dDekRFc1dMREozallIUnZQ?=
 =?utf-8?B?bG5vUWx4U05CdksweUdXOEp3NC9TTHF4YXJEa2R0R0FEVGp0WSttbWNYS2g3?=
 =?utf-8?B?b2pOMHQ3aEJ4c2NQVFErUG5OMUhBU2dDZWp0OGpkcHhKRWdZaXA2OEdDaHBS?=
 =?utf-8?B?Ylh0VnRiSkxINHp0U3UzTlVQS2pmRnM1QlNYYnVITnZFRFY2WVQxYm12UlhK?=
 =?utf-8?B?eEloU04vbi9pYjBiMURqK2I5c0hvWGxQRjNJY2xadzJpYVdWbWwwVjlTeGRI?=
 =?utf-8?B?V1oyU1JmQ0pMWStnVVBRWUxBWGZXWDFpUEZMRzIwYjZ5ZnAzZDdnNS9xSldV?=
 =?utf-8?B?WlVuTnU2Vml1dDhsWWJBMTFwUzhXUUdCZVJRbTNJdWFSdlYyMmdXV285bFFh?=
 =?utf-8?B?WTlyVGVVZ3FzbENVVzZCZFhoZmtyWkwxYmtrbVUrMjg4bG5LbmpYWUI1WXVX?=
 =?utf-8?B?WHZveGJHRzdZUlMzRVJPRGg1RklESUhCaDkzaEJFMzY5eDUzRktJUFhjbFRz?=
 =?utf-8?B?S0JBV0JLdlRjR3hYaVFnaWJ5SjVRUWRyVFI0cVJuTytFUzJpSmtNT1RGZWJL?=
 =?utf-8?B?SDZsWndxd0NhNGc4NnBWeWxKZ1hlT0JMMnowNWpNeWpTcWRaQytzUEo1UHBL?=
 =?utf-8?B?WGV5T3JPT09XTUdJK2NLRkJteHV2R05RUTMrcm5SVVpVMzNUa2hOeTRoVXNm?=
 =?utf-8?B?cEU4Y0xVUWRpN2ZOQ3BKY1Q1VjdxK1RET2tmb1RwWEdoZnh0cU42eVozWEhJ?=
 =?utf-8?B?dTdycWZkckl5bUdXclA2Mkh6aE1WR3lTLzNLOHVLZkZ4TDFtSTJ0dU9hbFA1?=
 =?utf-8?Q?2E+O40EsW3X47g2PM+2W2tHmi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe412d7-69e4-4a25-67cc-08dce6b726e5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 10:02:28.8198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Al51NOktVJtlXYj2bFJ/YQwwnQVnVXUn9kVU1tUKsVyt8LgljzT3j7Kn3rGntQNd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
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



On 10/1/24 10:25, Padmarao Begari wrote:
> Fix the issue introduced by commit 067e0294806e
> ("board: xilinx: Remove conditional check for Microblaze").
> The scriptaddr should be physical location not really offset
> from start of DDR. When U-Boot is not found boot.scr script
> address in device tree, then it is assigned  based on script
> address  and ram base address for Microblaze and i.e exceeding
> DDR memory. To fix this, the script address is assigned
> initially with offset instead of address. Later it is added
> with ram base address and gets the physical address.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
> Changes in v2:
> - Update commit subject line
> - Update commit message
> - Change only for scriptaddr
> ---
>   board/xilinx/microblaze-generic/microblaze-generic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/microblaze-generic/microblaze-generic.c b/board/xilinx/microblaze-generic/microblaze-generic.c
> index 2b035d5358..696484a012 100644
> --- a/board/xilinx/microblaze-generic/microblaze-generic.c
> +++ b/board/xilinx/microblaze-generic/microblaze-generic.c
> @@ -57,7 +57,7 @@ int board_late_init(void)
>   	max_size = gd->start_addr_sp - CONFIG_STACK_SIZE;
>   	max_size = round_down(max_size, SZ_16M);
>   
> -	status |= env_set_hex("scriptaddr", max_size + SZ_2M);
> +	status |= env_set_hex("scriptaddr", (max_size - gd->ram_base) + SZ_2M);
>   
>   	status |= env_set_hex("pxefile_addr_r", max_size + SZ_1M);
>   

Applied.
M
