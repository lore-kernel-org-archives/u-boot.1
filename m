Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AAEC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 07:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E4E8809A5;
	Thu, 24 Apr 2025 09:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="C92TfA84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5B2F809D4; Thu, 24 Apr 2025 09:24:22 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 583ED8070C
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 09:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrWWAyWaCGx3dkv3MA2ZJzZgIKc2AJCUYKPDBf+CSU1tXMA+rmemGlvgRHsFHdgu/LjjIzKT4KWIxQ/RGrY4cJQmv7D20J3UVwO/voDGL5sAAwVCFdojwp4Gjpi30J8Iib1aBsu7UfGVZakU35cgJXhbiZeC3oX/tENx1c+aaLEG0CeEDk2yCqYdcVCAA/J5xdgNDYyW89ScqlG2+MIWqhqFNIO4SWfH36QPCRff484SPJmA/t7qQz7Qnw9AS8iGAe+NYnQGHQUT1VwEVzXokfh8eRcahPqTah82JpvyFAUE5Hg02a3MS1wsuAJ/qNqlyNwy712YluOJ4n1eSGR+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pspVIGiCt1OF+gbXZHt6fiEfwQA66TnMGXdJAQBZd10=;
 b=w40aqjvoimkrrIYwQW8Ugu8b80ZlK3jFl6XXAKGYj7QUveSABI9JQuEJ9zKXSwcw2mc/cj9gdIlRmn9vln5W+5kQXrSjPXxpfEtuU6d957Per9DIPtRu51aQPJqSb7C4r0foain7lu0AP1yaUN3chw268J8XH71kZ1lVVFhSXzgSwxOzNPh8WgVRpTmD9B/mxBJTi2KkzxWAkx3l3l1x0UwEIwAuYMydFrY3OmVTsPk0ycQ3aFYb0x19qYa2FVfYqeigoawZnp0OcJTS+Fy20k1BonVCxS+/BSiQf5MdXPwUjHRM/j89DWnlNgon8yFexzikYiMtWXeOODzIaWpJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pspVIGiCt1OF+gbXZHt6fiEfwQA66TnMGXdJAQBZd10=;
 b=C92TfA84opGFUewIlvv2TqYksfS0EppR6T1BfY2KeFZFr/wwHJ9fr3JhS9k04oFwFO1CLKAIy4FQXPnZ2LB41CRisTCCmskULi4wQ/1/yEbCnX72JTJw2GrFnDZSXH/Xdca69Ns7kiXWTYsFiTq/QbrD7rPymlY2mDAaPBYHQUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8995.eurprd04.prod.outlook.com (2603:10a6:20b:42e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 07:24:18 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 07:24:18 +0000
Message-ID: <08c0575f-1a55-487f-825b-4246553e6b86@cherry.de>
Date: Thu, 24 Apr 2025 09:24:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Wiznet w5500 support
To: "Verdun, Jean-Marie" <verdun@hpe.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <DM4PR84MB1976607AFF39ADF74D9AAF7BD6BB2@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
 <3f221717-b5a2-472c-888c-cc8f777cde40@cherry.de>
 <DM4PR84MB1976A520AABEBD2B1C243683D6BA2@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DM4PR84MB1976A520AABEBD2B1C243683D6BA2@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 9916e8ac-fef3-4098-f78e-08dd830105f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjlOOFcxUmwwbUNFbENnS3dDTU1LVlpVSjBFT0lVY1dIZ0hIV0Z6b0FhVysy?=
 =?utf-8?B?a0xPaU9DeEU2YnZIYkxSbUhISG9PLzdScGlmZ1VFZktFVmtFNGRSdnhZOW9Z?=
 =?utf-8?B?dVVSejlkSyttbld5K2pyUytUemxQNGQvZFphWVdIOEUvREFQb3pMbUxCOUd0?=
 =?utf-8?B?YS9TSUxzWWhmcVRoVjN3L1piNXJreHNGRjBEWmdsNnNwejVDRUNRSnluVlJQ?=
 =?utf-8?B?bktxQnBUOHhBTlQ0aWwzZ0hGSzVndXVqN3R2WEdsUGNUUURSc0Rkam5zL0hQ?=
 =?utf-8?B?L2txanY2ekZCNkdaU2l1NE9BQllDbGFwaXNpOHZGSjhBc2NoMjhKa05pbnBZ?=
 =?utf-8?B?dGpxT2tjVUNpTDNlMlQ5QmU2U3V6cEpWek9RWHhyaFJUc3Y4RGdHQWhzR2V3?=
 =?utf-8?B?WnVmWHZjUlMxbTAvOGN1OVByNzNMVHZJSFd5VGpKS2dkdTlKUTU0ZHhjYmhC?=
 =?utf-8?B?UWdKcUZtTFNQVVI2VS9MaklZY2s0SHhxVHI1Tm0rMlhFODk2cFFDcGpFZEdW?=
 =?utf-8?B?aS9SRkdOYWJsbGtDeGFhWUdYNjRrVXh2MXkzczJaVU51OFNTRGYxbXA1ZjlR?=
 =?utf-8?B?TGQvT3ZPWDZSR1hXQ3Z2YWpmejNLNWJ4TWh1bW0vbmlVZFNpc3lwaDR5NDZM?=
 =?utf-8?B?MGk4akJ2b0tyV3ZVVUZJZlI0UTBtQ3BZZnFETmo0SWdYOVE2RS9uR0J0SmNu?=
 =?utf-8?B?czdBQjdvcW1zb3c5dHRJc2FCVUdySmFxQVA1MC9QVlFlMU4raHVkc1psS0ZC?=
 =?utf-8?B?OFg4VEpLaXBJSkpuWkdMYldsbmQvSXppOWVjYXRRanl3SGttWG5ITXdicUV5?=
 =?utf-8?B?NEVsS24vUTRrUjBxc20yMlBMS1VlbGFEZzNqUHpQT0kydjI5TCtOa3pyWGNN?=
 =?utf-8?B?bGZPTkNwODl2Rm44MC9qdHorb3dDVmwrZUorQUFSUHlnbnF0bXo3by9veXNQ?=
 =?utf-8?B?TWdOZjd0MDlFWkVCMVRrWHh4RHdUNHFLbGMwci9kN014UVJESnl6T1liaTk1?=
 =?utf-8?B?a3RpK2xKZURKYkRwSEROZlEraHFjSDA2Q01qTlFrNzRlUHJFSU1lRnJEZU9y?=
 =?utf-8?B?WnlTMnBsb0dpQmhQTUlKc3MwY0dFWnpWZHhGN0hMd2xqaXVkM2xGSjRGQlF0?=
 =?utf-8?B?MTZ2SjNzRjZSZ1NXVVZsa1NxT2w0T0xhTkd5V3hybVVYY2ttSzRITUxwaWRJ?=
 =?utf-8?B?ck14RjBONGdMS1NUUXk1TmE5RVYrSGo3MnR5YUovb1hzSVQxTTlkdERMN1cw?=
 =?utf-8?B?OFExWGtQRGd4OGoxempXM1JqMSt6YWhZOGJzdEtFK0NyczErbWNXakh4THRV?=
 =?utf-8?B?Y2R4bUhiSENZbVdmKzJ3VERxUnZqT0NKQnNRUXlzQkN2ZDJOaVlzSVBPbFM5?=
 =?utf-8?B?SDIvQ1BTU0RCdUVSbTR4R1loRVVpRHhWTThEbVQwYzg2azd1M3BXUFA3RjVI?=
 =?utf-8?B?SndQSzFHY3lYUEN6NUVYTmovUlZEaG9sd0VQUXpnaWJmVkJSN2lhb1FITWJL?=
 =?utf-8?B?dkM2WjJRYWhEU0x1NVk0aWd3NjV2c1k0bDM0UmhORStUSkRTTDJLWENPcno5?=
 =?utf-8?B?bzZjYWhBU0FobktqN00rWkJ0OXZXd042bERpVFA2QmFMck1Dc0tyT1l0dGFL?=
 =?utf-8?B?bzkwOEg5WEUrRmViVExzOVV6aERuT0NSOVpBL3dLSVluY0VGZXN2dHNVRHpD?=
 =?utf-8?B?RTI0NW5RdG9yVXI0ZXM2UXN5clFUVTN4UlVTcEdPditMSVRqcWt1a3VmUm9H?=
 =?utf-8?B?elpvU3pSTUhBSXlHZTBsdTlSYkpOeXE2SmpiMDVKc1c4MTVyODFCYlhiNXZr?=
 =?utf-8?Q?iCAswDqvRoCrLR8I4w9dV0wfSkZVwcwmd1LBI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2ZVay9WQnFuUnBsOUxqbVdvK0tpbElyMDNvQ3N5RHo3ZThyeFRxNkl1ZTRX?=
 =?utf-8?B?L0tVcVNGbnhoaFlWS2pSVTZDNDllZUY4N0srNG16Sm1IaG15TU9tMHRoNXd0?=
 =?utf-8?B?aVFvTEsxSmVOcTMzVDdoTFJBci84VFhBd1RFWUxYbmV6dkthUm5vNEpNZi91?=
 =?utf-8?B?a2lxSnEyaTNlQTRWaS8xSzRhSjN3MUREMU5RdkVrY2RrMEd0ekthOE00NXJL?=
 =?utf-8?B?ZGRxdVRlQkl6Ty80bnRwcGdRWUtCNFJjT2t2anF5aVhyTndjRmNHTG9MR1pF?=
 =?utf-8?B?NThsSEpOR2dxdUtLcUxpcnB2djZqSEttbk04TGlXWWNJVmJzVWIwemYrckEv?=
 =?utf-8?B?WllXMWcvYitsbHlFSC9TZitPWWF1RzR1Y3VHWFNjQUMwdkJuQ2dXKzNhN3Rm?=
 =?utf-8?B?NlZqV1djdEwydmxqZnJldndscjQxVmdwdVFtdEhuNnI1QVJ3SlJ2NHBHcm56?=
 =?utf-8?B?VWNTMXk3aHB3WHBRcEk4cUJHOUJENTJxdXdlV1ppUVpyNUVlQ3NBYWJEeW5N?=
 =?utf-8?B?NmdZdm43bDFDWlM3RTNNNVcyb2tiVWd2eFNWSVpIOTh5a2s2L2trTmRLNmpS?=
 =?utf-8?B?M1RiQnhjVUFjRjFySWlIaS9pQlF4WU1SY0N6K2VZT3MvbWIycy9XVms3K0JB?=
 =?utf-8?B?UkFBV1BlYTBiTjVncWtqaW9QanJQRExaa3JZNjQ5UENodmZoUzUvb3NPTXBm?=
 =?utf-8?B?ZkkxR0pFRUprZFhCdE8wd2tObWVHYSsydUlLcjFKMXF3bzdQS1RzdmJHYjhr?=
 =?utf-8?B?NFVtLzFqdW50TXM4WjNWNnFaOVBoYkhVaHd4QzBDOUZ5dTFMUWlhTTBEVkdR?=
 =?utf-8?B?NUN0MERoRTFRdy9zeFJKc2kvZjh6aEhrY2tZVFRsS0trV1NVUW9FUUUwVHRV?=
 =?utf-8?B?ZFRpc3N6Y3c5UVM4bS9pQ01HdDdObjJ4VFBRb2FyV28rVTBXd3dhOUFaekxK?=
 =?utf-8?B?Y2Q3cFRKQmljc0tpZmFSK1VOak1IUFhMcVpYTXpYdmozamZ2U3V1VG9KUWor?=
 =?utf-8?B?SkRaQS9ZMkJVVlZRb3llTHo2cTBPQ3NzUGg4MDFZWFJ2M2JIczZSNnlqTGVs?=
 =?utf-8?B?dmNGSjdDdFR5dEpTN3Y3ZDhCenVXT0RyMlBmZjVYRDVYdzNqV0hGanVFTjM5?=
 =?utf-8?B?bDJXejV6SklNaXBFZElFRVVnclA1OXRsSDNGSHM2bXBra1RkV3VKYXFxZTZx?=
 =?utf-8?B?RVFaUVpoMzdmZEtsV2FmZ2RQeHJnZ0JHWlExaXlYcXBZMlh0RENCclVtNmxW?=
 =?utf-8?B?dUJXUVZtMVdUenY0cUJqbHRiZXJYbzNrc09hMUdHM05iR0lxOWxUU0ZrTnZJ?=
 =?utf-8?B?KzRKYk1qYVlkdjFzUDhZMWNOcVg1ZW9RT3NZbGc0bWMvdU5meGRkYk9zcmpS?=
 =?utf-8?B?NXBXUFlsM0NCSVJuZUNSSndpM0szeUYrVWtGY1RsZFFOdnQ5ZkwzeWdwOEdu?=
 =?utf-8?B?azZ3NG82UVVLL1NQMmZuYWlOLzM3V095TGViVE40SVJRdmV4V0wxVE9RenFX?=
 =?utf-8?B?SjhOM3VBYmF4LzVSOWh0UlRqWUJJbkc0QTBFbVFuczFhb3VZMlpuNDFqakUy?=
 =?utf-8?B?dG1BdnB6VUhldEZBdWFKZVJPUGM0b1RpbXFvM1J1U0RjczVXalRKb1d0MXFl?=
 =?utf-8?B?NUNLbWZsRnVpQlV4Vng0bFl3akJzRitiOHBGWmZZY0xTeEJzTk9NSUdMYzVw?=
 =?utf-8?B?Zm9RclkxR2JodmgvanJsRTB3UUJNS3h5cmI5NS9uV3JHL3RGV2FycTgwcGhX?=
 =?utf-8?B?WDNIa3BwTE9sMUhPblk5YklaRzAvbVZsNjI5bUIrVjFlak5aOHJtdzczMWQ2?=
 =?utf-8?B?MStESHFyWGdrL3BPTW45a2dHTHZoYng1ZnVMY0tvbDlQamNDN3Z2bVpSWGlI?=
 =?utf-8?B?eTFaLzVwemdtRC9HY1NYTitlMjU2Z2V4N0t0bW5GMHZReCt6Tm96R24vOWtt?=
 =?utf-8?B?aisvTFRNNzVNY3JFRDJEdVZYV3lRZzJQM2RrT21mUmZBcGtmcFdPVDFVaTEw?=
 =?utf-8?B?elY2VnRRQ1NaalNNaVdGeDBqcHBGOXdCN0pvQ2JNaGdHNE9FdDdqb3ZqVnVq?=
 =?utf-8?B?anlSWmNBaHdRREtSOTM4ZW5MaWR6NVFKUTJIYlRKcG5GRzZyamprY0ZwNW5K?=
 =?utf-8?B?SGJNa21rQ1BNUEdJWmMrVy9xY2N3aHRSL0R5NjBGRXNFZU9meU5sTlF1M1pU?=
 =?utf-8?B?MWxycEc4OVJTTm9VclFpcitzRkE2WkxQaC9wWi91Y0ZvbWtkNE9abUlvNnI2?=
 =?utf-8?B?a2hJcy9VUS81UysxZkJCMEIva1d3PT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9916e8ac-fef3-4098-f78e-08dd830105f2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:24:17.9322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgD3AkpyuvyHgaS1BW/ehxPx2Nu7BoCh3yOatjT5N8r7ojTxQidr9w5xwPmNCe0hW5FPw+2McCap6mxPUm0HhAFPcSrLKnbHc9NKe0Fo6Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8995
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

Hi Jean-Marie,

On 4/23/25 4:37 PM, Verdun, Jean-Marie wrote:
> You don't often get email from verdun@hpe.com. Learn why this is important<https://aka.ms/LearnAboutSenderIdentification>
> Hi Quentin,
> 
> I was looking for example like the one in pmic. I will refactor my code to take it into consideration. That is my first driver that I submit to u-boot.
> 
> The linux kernel has a spi side
> 
> https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/wiznet/w5100-spi.c
> 

Yeah, it's just to support the SPI way of accessing the registers for 
the w5100 driver which seems to be "normally" MMIO.

The non -spi driver is still sufficient for MMIO IPs (Intellectual 
Property), likely the ones in an SoC/MCU and accessible via simple 
writel/readl to an address. You can see that because the driver has a 
platform_driver struct which is usually for drivers outside of the 
well-known busses like I2C, SPI, etc..

The -spi driver is registering an spi_driver struct, which is for 
devices on an SPI bus. It does call w5100_probe() from the non-spi 
driver after setting the w5100_ops and a few other things properly.

> And the device tree setup is a little bit confusing. Roughly you call the net driver from a DTS node which is a spi slave, and the net driver is probing the spi side which is not attached to any DTS node. I tried to do the same approach with u-boot but did 

Why is not attached to any DTS node? There's an of_device_id table in 
the spi driver, so it'll match against those compatibles wherever 
required and probe a device for w5100_spi_driver.

Can you provide us with an attempt you made at doing the DTS without the 
phandles? Maybe there's some misunderstanding somewhere on how to do 
this (or a mistake in the driver, there doesn't seem to be upstream DT 
users of that driver :/).

struggle a lot at doing it, as it seems that u-boot needs to have a 
device tree node attached to each driver to get it activated.
> 
> I will try to get as close as the linux kernel do.
> 
> The good news is that it seems that I do not have any push back to get that feature onboarded inside u-boot.
> 

 From us, there's seldom push back when it comes to individual drivers, 
same for the kernel. It's usually only when changing the core, subsystem 
or APIs that things take more time, discussions and compromises.

> The code I wrote is really a quick and dirty implementation as to run a demo next week to the OCP Summit in Dublin. I will now make it compliant with code styling and everything needed to get it accepted. I will just need your help, patience and resilience to guide me.
> 
> For the moment the only code check, I am doing is through the compiler which doesn’t report any warning. I will add other code checks from the linux kernel moving forward
> 

Please have a look at 
https://docs.u-boot.org/en/latest/develop/index.html, I'm sure there's 
going to be something of interest to you there. Specifically coding 
style and sending patches? Note that U-Boot also supports sending 
patches via b4, 
https://b4.docs.kernel.org/en/latest/contributor/overview.html.

Please consider updating the binding in the kernel tree to a YAML one so 
that both projects benefit from it :)

Cheers,
Quentin
