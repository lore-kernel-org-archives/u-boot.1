Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A317CC04FFE
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 00:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB8F2880F1;
	Wed, 15 May 2024 02:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytec.com header.i=@phytec.com header.b="LSwFDD3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31749882FA; Tue, 14 May 2024 18:26:54 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 590EB882DF
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 18:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jma@phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOoWsDjnaybUWqTaPWL08hwBlYYNy+AOXWYmr091zHntWeQc4jMl7bFhPso6VYaFBwut2UtJoL78094ujG5GlMEQIXoPlKlskD7LklvLO7rte8yduzY7u4NYc23iwCE+6nnZ0voVejZVBnlHCvwEDLRhRTJTuWR5v6ujm9OnXY/yi93vCT7xCcmCkuJmSW8m2Vlidp74dCsZPy/7O/m0hIgDZU7qaPw1t8iTTw9hoHOg3zgia+5w2UsdtjRfHzIs48EsInqzRbB/CAbPt9FUNqGC1wK9N0bhK580euhMuBMZYHiWWK3JtMXvVblscvxB5HK0od1Y8bX81dLa00U+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QU1WkD+zXvh8YuZtpcR5Ok12XVfpzqgMwUyw0fFHiZ4=;
 b=eB9rU89Jsf9LxUGRAGhELhDyJvMN/jeQTGEz6f44e6XNYWeDB8KO6biufiTjiOWYuVFGW61AbuUdHTvUYrVuwqPUifJBwWQ2f0+kj1O7Y1ovNb+wDy2soXa5ov0qomGnoRuHnLj3EUk/4pAUynLAKos8PS1rw5aglU+NUb8iY9VpuC0DlkK6StnefX7j7TQJRA/Qsz+c03Rjq52yiGFSoAEonVguD2j6rCtXeJN3YCsUCK8h1oiXoqkggk3lR1S90qIv7kj70FXhzkICjayV9BDVu8IXUD3Bw8nfwjgoCpMdTbk1r2xIsVaC+i2aVIlzrwtVxEIX3SaCSh24JJ78KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QU1WkD+zXvh8YuZtpcR5Ok12XVfpzqgMwUyw0fFHiZ4=;
 b=LSwFDD3J65Ue55Eny5Ue/rlT69AYgMWigsbAyejpPtoLCtd0T9MOpsJh8krvwzikPRA0odIQKhBEwgpnMvUj4UVl/evrQOJ6FMEwfZcDMwhGwf0RK2ogyE/FFt0T3vUC6LkwkYArXRt5r48g5AcPWy/w4giYSUfHIFMXQw7xh9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from CH3PR22MB4407.namprd22.prod.outlook.com (2603:10b6:610:167::14)
 by SJ0PR22MB3829.namprd22.prod.outlook.com (2603:10b6:a03:4d4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 16:26:45 +0000
Received: from CH3PR22MB4407.namprd22.prod.outlook.com
 ([fe80::a87a:b781:ffdd:3256]) by CH3PR22MB4407.namprd22.prod.outlook.com
 ([fe80::a87a:b781:ffdd:3256%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 16:26:45 +0000
Message-ID: <e488fd10-d4cd-4b38-9b11-f6693c9070f8@phytec.com>
Date: Tue, 14 May 2024 09:26:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] *** phyCORE-AM62x: DDR detection / Inject DDR timing
 deltas ***
To: Wadim Egorov <w.egorov@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
Cc: trini@konsulko.com, nm@ti.com, bb@ti.com, y.moog@phytec.de,
 t.remmet@phytec.de, d.schultz@phytec.de, festevam@gmail.com,
 mkorpershoek@baylibre.com, joao.goncalves@toradex.com, n-jain1@ti.com,
 michael@amarulasolutions.com, d-gole@ti.com, sjg@chromium.org,
 clamor95@gmail.com, m-chawdhry@ti.com, afd@ti.com
References: <20240507151757.1202825-1-w.egorov@phytec.de>
Content-Language: en-US
From: John Ma <jma@phytec.com>
In-Reply-To: <20240507151757.1202825-1-w.egorov@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0306.namprd03.prod.outlook.com
 (2603:10b6:303:dd::11) To CH3PR22MB4407.namprd22.prod.outlook.com
 (2603:10b6:610:167::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR22MB4407:EE_|SJ0PR22MB3829:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7c126c-0cf9-45a7-e73a-08dc7432a51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1A4dEJpZkJsOVVYUUpvbGNUNHEvcEU3dGQ5WndvOWZ3TG5WQzk5Nk04aVph?=
 =?utf-8?B?aWF6TllLL2dHK01CbnpPNWdtQ3Jobm5ud0pOWitHaTc1QTJ3SFU0VUhrK1pl?=
 =?utf-8?B?bHdzVGZZUy9VVXQ4M3RwSTAwWmV3Sno1czlkV2pDUGFldkVEVnBBWnQwY2dt?=
 =?utf-8?B?NXVQUU9qQ2VWY2VYcWtLNTllMVlVNXhZR3dtU0Zaa0hRZU9BRHo0SHBjTk1G?=
 =?utf-8?B?ZkFNNFJ4WFQ4TEQ0T3h3RDNGcHdSeE9wMUY2anBvVzh1N2JtM25tQlJzMktp?=
 =?utf-8?B?MVlTUlU1NUFlTVhvYml2Q2JZc3ZwdUorOUlCaVZvcVE2S3BFR2MzN0RONkdv?=
 =?utf-8?B?SnMrUUhzVEpVQ0lVa291YnFkQWtOd3l1N1orblprSFU1L045dklNdWxzZzA3?=
 =?utf-8?B?L25GUU1VWmRyZkE1VXgwcElZNEkyTWhpdUl6bEF1cVZaQVhES3VRZTRUWitG?=
 =?utf-8?B?UUxsb254RldYK04rcDhjMDdVeEJzeEtUQU5XQWt0VW83ZUtLUnRCV01ORXd0?=
 =?utf-8?B?S3FiTVZnTm45dzV3NkwxL0NBNWhwZTZIYkNwdk43dG9lQ1lGVVdUVnUrNW1Y?=
 =?utf-8?B?NnhDaWhzK2FKeXg4SyswUm4rdTc1WjVjZ2ZRcG9SWVJMOHovU1RNVGpCSENB?=
 =?utf-8?B?eWRyQWV6eTNLdy9Ebk4rejJyMEFlQVBxOEJDZjBBVDVEKzMzRFY3RHZPOWQ0?=
 =?utf-8?B?eVdVeXRxbko0czBmRWR6MTVwU084QThWNXN4bitDWCtTbHhmdE9IeG1PVkJp?=
 =?utf-8?B?RnJINkgzYWpKRVVGKzd4dWFLNnpBd1QyM2VkMS9DeUFsU2FpSXI2UWo3U09i?=
 =?utf-8?B?S3M1WTNrZFJLdDk2TlJVTW1Zc3J1RFFxNC83aTlUMFFDMUNhREdhd1dZbEFw?=
 =?utf-8?B?U0x2eTVtR09yZXdzdWx0NkpBVHVTSDczTE8zZDFEdUI1M0tCMy95TWoxWlpR?=
 =?utf-8?B?Z3IralhHd2hVcjAvYklTbXFiSFEvVkI4UDlNaXBFZ2JIYTBQRG04blJaZDZR?=
 =?utf-8?B?dDBGSEhnWXdVenk2YnJBaHJoRlFNcUpSRnVlZ3FKMnplV2k3ODNvVXVrVCs3?=
 =?utf-8?B?V3NSdUhCeUh6bVY4blNzZ3ozYnIyTHc1NEF1cHM2eUFTSWpFdjRRN1FTbnAx?=
 =?utf-8?B?RVluaGV0bnpTTUJOejhMd0VQUWpCV0VOeGpGZ3o2ck50RE5vdnppb1k1bzkx?=
 =?utf-8?B?OFBIeXFmOVVuZStReUh6ZTZuVHdVUEZTdUhoU3pZSURtTzlIRFhHbjFodXo0?=
 =?utf-8?B?bE8zb0F6Y1Q5NjhabUtJZ1NNOWtqZ2lKQkVxZlIxNEEyVFFZYzlFMGxVR3Nq?=
 =?utf-8?B?WE1IbTlGbEZZZGVwNzl6K3ZWS1hOOW1IM0RUazRETkVEYVBpcjBsWE1mdUtK?=
 =?utf-8?B?bHpCT2twOVpzM2FLSFJ2VmdvakNqK2ZROE1MR3MwMU96Z0QveHo4eE5CODFw?=
 =?utf-8?B?aG1TenZjczgvY0cvVlRLWm5Sa2lGN29MSTFHSU9kb0dpVUxZTnVLWWZlRUNF?=
 =?utf-8?B?WmJab1FoN2lrQVJwcTlpT013cko0a0M5NEtxTENNL3JtTTVnTUdaaWFqd0M1?=
 =?utf-8?B?QThzOUc0NCtBZFRuSGVOQlZLdkd3aHpqUGZSOWl6eXFVeXhENzJ0QmVOTGU5?=
 =?utf-8?Q?CxgRmaXdm6/en11T2L0NNpzFTtlLDsVE7wNx4/WDdtlc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR22MB4407.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHFmbnhSM3JHKzNwNnhCTTNTNHZTclFNS1hjVGpFRXVaOEUzdngrM0EvbTN4?=
 =?utf-8?B?MGUwd1dnemZYZkQ5cDBKUDUzbGZOQll3cXhMNFJjeWlORmhkUU90ZWJWRFov?=
 =?utf-8?B?NUxHVGtXNUwvdVplcERpTk05UCtHeEZWQmtrV3A5RjRJTmw4eUZtelN3Mk5w?=
 =?utf-8?B?aCtwS3JqSWlqUWlCK2xzM1RSTTFIS2JNaCs3TVNnZFhEcE55SzhFZ010M0tO?=
 =?utf-8?B?VXk2WEdxek1WalZ6MzUrUERZQnBWMWx1TEpncS9hamlCa2tzb1liL1hGOTdD?=
 =?utf-8?B?RHN3U0JyM1JaaWlPcFM5c1FjSStieXo2R0NncWR0T0pBVUVBMGhyS2hORENE?=
 =?utf-8?B?eTNtVWFyQk1PNXY0ZlpJUkdyNE9WYldyckJPd3BMK1djbU9lRHI4Z3lFRmYy?=
 =?utf-8?B?ZXhkNHFxMlhIWXRJU2E5UmxWSmVRSXZva0tHd1A5ck5vU3I1YlBjWWh1SEZk?=
 =?utf-8?B?MGI4Rk9YLzhhZWlqSjNOUks3d1M2SUhFT1QxZGpIUEhzcDVTU0dBbWtLS3N5?=
 =?utf-8?B?YlJRRnVOZnpGcFRHZzVkQ0xYU3FrbFh0eisxdUtkWFNzdnAyRG1TamRVelZq?=
 =?utf-8?B?SU5UWFZhUWxiRGVsVVpzVDY1L3RVY3VPaEIrclFYL0dBcE56VDZoWUQyU1lC?=
 =?utf-8?B?QlNRM21rc29kSjBhajZ4elhnVmVRWTZWUXlwOEZBS3J0NFFSbkZ2a2VBYWx5?=
 =?utf-8?B?L3RJbGZvVVR0bkhEMFhNZFNra2tHS2ROaVUzZjBCMlhYNlpUZ0RnL0tXTVg4?=
 =?utf-8?B?MlVFdUdPWUdOZExXOVpwbEJIMWNjS1h1RXh5VUEzamdVZ1FSaGVEbFZ4SENq?=
 =?utf-8?B?aUp0TmlSR1lyZE8vMTdvK05MdGZuRDl3QzlpV0YrTWZZUkF6S1JDM1U4T01D?=
 =?utf-8?B?N1crZjNmeGwyNGJCTzg3cVR3dXFiczdkTXU0WS9EQ2NvYmlCb0lESzFhaDVM?=
 =?utf-8?B?dGYwMnd5ZVZXNzRQL3lPWkhHeDVadW5kS0RPaG9oc0pBRjkzUkYwSzlVeU51?=
 =?utf-8?B?VzNNc01JQ1Z3Smlra1BPYVdla2p3SmNTSUxzREI0RVM5bU53ZnZpcHQyUWI3?=
 =?utf-8?B?d3JnR1RZUHNYU1lxRmVvUTE1VUFEM3pRWDBUTzB3cGdoRjkraEdxY0NOUDdU?=
 =?utf-8?B?OUd1SGxmVmVZcXRyM2U4a25nTEdPM2tiaXV0eVdFSUxwQklRTllyYXhLeWp6?=
 =?utf-8?B?ZG83cEVldmlJK0VSL1prVUQ2MnVxeTlEREVBLzVMOVROQUYxQWhIVlRCcXN4?=
 =?utf-8?B?NVdzcnFrd0xPNzhhRTFEc1pMcmNZSU9hajQ3QXdJTldrclJhL1dReEdiNGZo?=
 =?utf-8?B?bjc0emVVcVhBdU83WllKdk5GZVp5MVRta3hVcnBZVHhkMGM2YlBaUWRaY1Fj?=
 =?utf-8?B?QXVkc0Q2REl0WnA1UFRzYmpqR2psU1BrTlNjZDBIU2tGMkN0UFppMGI2QWoz?=
 =?utf-8?B?Qzg2TnRnTTFDRys3QW54SzIzWTNURjhVdGUwUnVkSzI4amUxUWhFYkFEL2U4?=
 =?utf-8?B?SzJ4UTRXVEVtaEVNbW1xdGwrMzl2Y3MwZlMwbGVIMnBxK1IwT0tWb003eVFD?=
 =?utf-8?B?TmdDRUJ0UGNpMklObmRObjFObUV4ZXA4YUpLVzN4eUZZOHoyMDk1S2FkTG1G?=
 =?utf-8?B?WlVoYUMvbFNUOS9QczBpQUlqTThRcWFzOVdXeExaQzVpSkUyTmpKcWFLZ2Jl?=
 =?utf-8?B?bC94bHUveHdaVlk4Ykl2WGZpdW5qQXZRZUpUdjNPdExGMW1TVWxPWlExYkVh?=
 =?utf-8?B?QzJGU21RK1h3UVZjNmQ2Vm1hajk5T0lDYVRJY1NvcUFzNmFub2lqcTIvWjBy?=
 =?utf-8?B?b080N1R0SWFTMUZkSDJGNjZ0VFNLcW9VazQvTmt5YVo5MXlGallYbW9Wenpx?=
 =?utf-8?B?Qm0vdnNDOWFwbFA3Z0twQzJQZk5YTStuSXBnUUdadERlbmU1RnpYcVJQdENn?=
 =?utf-8?B?RTl2UjRXdndYYWdFeVEwSnZXNGFkZnhvMnluYTlXdFlyUTgvUTBhWFJUb0xl?=
 =?utf-8?B?azdZVncyUnpGRlJ0T01PakR4MmFrclBMSWhvS0U3RHl5QS9md2JTeWpoRTZJ?=
 =?utf-8?B?am4zK3FZRHg5UXU0dmcxVlpDWXJMc0o5SUhkZk1HSi9tOXJaaGVSTEhoL3FI?=
 =?utf-8?Q?KUFI=3D?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7c126c-0cf9-45a7-e73a-08dc7432a51d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR22MB4407.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 16:26:44.9017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rUjIiWXnWeeKrB4SYCrxD/0qyVwpBZuuiETzYoooKYVdn9mrMeTB14O+hY1tNQP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR22MB3829
X-Mailman-Approved-At: Wed, 15 May 2024 02:28:00 +0200
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

Tested-by: John Ma <jma@phytec.com>

On 5/7/24 08:17, Wadim Egorov wrote:
> PHYTEC stores details about the hardware in an EEPROM on the SoM. We can
> utilize this information and chose the proper DDR timings accordingly.
>
> Due to the limited SRAM memory on the AM62x, the concept was to store
> only the DDR timings deltas and not their full set, see Patch 4 & 5.
>
> The last patch adds support for a 1 GB and 4 GB RAM variant of the
> phyCORE-AM62x.
>
> Patch 4 & 5 are based on
> https://patchwork.ozlabs.org/project/uboot/list/?series=404273
>
> Wadim Egorov (5):
>    board: phytec: Make AM6 SoM detection depend on I2C
>    board: phytec: Fix function definitions in AM6x SOM detection
>    arm: mach-k3: am625: Call do_board_detect() before DDR probing
>    board: phytec: common: Introduce a method to inject DDR timings deltas
>    board: phytec: am62x: Add support for 1 & 4 GB RAM variants
>
>   arch/arm/mach-k3/am625_init.c                 |   2 +
>   board/phytec/common/Kconfig                   |   2 +
>   board/phytec/common/am6_som_detection.c       |  18 +-
>   board/phytec/common/am6_som_detection.h       |   8 +
>   board/phytec/common/k3/Makefile               |   1 +
>   board/phytec/common/k3/k3_ddrss_patch.c       |  68 ++++++
>   board/phytec/common/k3/k3_ddrss_patch.h       |  28 +++
>   board/phytec/phycore_am62x/MAINTAINERS        |   1 +
>   board/phytec/phycore_am62x/phycore-am62x.c    | 152 ++++++++++++-
>   board/phytec/phycore_am62x/phycore-ddr-data.h | 206 ++++++++++++++++++
>   configs/phycore_am62x_a53_defconfig           |   4 +
>   configs/phycore_am62x_r5_defconfig            |   4 +
>   12 files changed, 483 insertions(+), 11 deletions(-)
>   create mode 100644 board/phytec/common/k3/k3_ddrss_patch.c
>   create mode 100644 board/phytec/common/k3/k3_ddrss_patch.h
>   create mode 100644 board/phytec/phycore_am62x/phycore-ddr-data.h
>
