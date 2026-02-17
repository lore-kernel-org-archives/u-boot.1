Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9BFE68143
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 08:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 669FD83981;
	Tue, 17 Feb 2026 09:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="obQmQSW5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F20A83C32; Tue, 17 Feb 2026 09:49:03 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 352078063E
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 09:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QK6EbNo56ykHkqnpUi29Kowjvyn6ty7cBJOYH6QyvqlJhs8Ej3j0DX6nTy83juHhy/P1zJAHvpGJLzB0qmsUW8cBqJ4cg7AMsILsTegMGYYP1q+fHmkiW4R7HTaS5BFrUjqEK2c6lQWgC511OP2ee7mTV0n/MpPZZsyhV0/ngH/WZmbiF3g6J+bCGhiKwwvfnXkISw3uQqEMXxTJoQTA5hmHrzt6tWSo2INRd7zGFUKHv0ulUrkI3pYhXjzhLrj9Cwn9uc8jXsAABK6kv5ncCezNbaLTraAtnUgJye9HEF4ZHSHQRquJEr5HxfkzBUICaQBRfm4E0i2y0qgdzl8hXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhAYfJljM07U9YHH9paS2AV0lbJbT1CouG5oR/Hwn3o=;
 b=N2W6D0/Is2Cb3OC2QHpAME7wxpLGS+XIKMO0f7jW1Yrli0MjpOrPstKLhkrq5aE4hcQ8Cn+XSk+3pwyL3sA3VLkpHuslRohlFX57XnXGiAHtvXFt6bx1F9N1RP/zaNPbZgW9p95uj1vcMCmu0X7/tUfRSFO0XRSY7wxW6/zlLhY+tnKbTBV2XXpsREu9fKZsVMTiMHdUTtDh5Nyrn1IZN3Sse5Gzlw5Exig4rcq4y83jiHqqmfPGfHB5BwaI4hHGNTHEEVuiOFItm7Fn8KwCLTKNQK27bg4wAnZRp1EBi5VQDz/uWgz9GHiSfxGhyO74BBWYpbyZHmUe6zwVHXSc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhAYfJljM07U9YHH9paS2AV0lbJbT1CouG5oR/Hwn3o=;
 b=obQmQSW5Dmt8snfHS7abfLaCfi+Yj2Qlbt9BLigSYbjxc5+CRkAIYT7oYs5Dl4Lz+D2w+ZAH4qKp46CvVfmAz4FbvIIvCq4HX/TikrfEDtEYvl8NiFE9rZS9voyGTrDf3OC6RsngquD6Y1WE6k9+Y4P/vhCUzujxQlCFDI4tDYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20)
 by DS2PR12MB9749.namprd12.prod.outlook.com (2603:10b6:8:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 08:48:53 +0000
Received: from PH7PR12MB7380.namprd12.prod.outlook.com
 ([fe80::28ed:346e:a324:acd1]) by PH7PR12MB7380.namprd12.prod.outlook.com
 ([fe80::28ed:346e:a324:acd1%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 08:48:53 +0000
Message-ID: <c1f83783-1af3-47fc-9e2a-4f494bf77efb@amd.com>
Date: Tue, 17 Feb 2026 14:18:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Initialize Xilinx glue registers
To: Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260106221728.738219-1-sean.anderson@linux.dev>
 <8265ad50-83d1-40fa-943d-b6e64d9b7812@amd.com>
 <8dad4173-4b2b-4ba7-8e73-838182570bc1@mailbox.org>
 <ce3b1b60-4c05-4255-9a46-e32751a269a9@linux.dev>
 <0d7fb416-2021-4b8a-a7b3-db72bb2ad05c@amd.com>
Content-Language: en-US
From: "Kumar, Love" <love.kumar@amd.com>
In-Reply-To: <0d7fb416-2021-4b8a-a7b3-db72bb2ad05c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::17) To PH7PR12MB7380.namprd12.prod.outlook.com
 (2603:10b6:510:20f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7380:EE_|DS2PR12MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a2cdfb-5113-4b46-87aa-08de6e0160fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFpNd3IvUG55Mnc1Zjl5dlNIMUxKTEgzSEl6d3lRc2RGckRab3hNaU1xUmlH?=
 =?utf-8?B?bHdhRzM2cUVidzB4OTFsQ0NTZUlFOTh1WlRQK0V0bUZUK3Zlc2trdDdWOXZ5?=
 =?utf-8?B?ekZiM0MzR25ocHJHam9lc1hhdVU0aVNJa3pGS1lZaURsaXJWRktzL3h3YU1O?=
 =?utf-8?B?R0ZkWW9VRTJNYVRCblVTS0JVVHlDeDBDYlVCc0J6TTF2V3pGdjJxT3BxczZR?=
 =?utf-8?B?aGRsNm9LZlNQUXFpOFJNUmZ3cHVOYmFuSnJpcXFscE9LSGZpVXZhajN1Zk9D?=
 =?utf-8?B?Zjk5RTA4Nk9tN2hObGttcUxJZ2lESEl2N0t1TVlhYWJWOVlZVllSOGZoYmlp?=
 =?utf-8?B?OVVuWjNERHBwYnVna3NCRXNSYU40MjlSSml5ZGlaZVVBK1I5SVh3Ti9aalp4?=
 =?utf-8?B?MlhMS3lFb0QzMmY4OVJlMkZ3SWZGeE41eG1nQlY5RUdEaGFxR3ZtZk9sbXhy?=
 =?utf-8?B?QVJaZkxmYUx6Mm9tc09jQmg3VXczRTZaNHM2aHRLV3BmdDBOajdwODRkQnJs?=
 =?utf-8?B?eG85UXozVmdMUURZMzFyU01tYjloWnZzcm93N3phV2Fpd2JqdlE3RjFmcE8v?=
 =?utf-8?B?UzVZYTd0K2lZM0hmemRRMkdPRUFiZUM1clZ1anJwUE8rN0crSUhwMEo3QnF4?=
 =?utf-8?B?dVpqVUdmWFhDZkY3ako0dThNYkNKNHhnSm1ZM25UV0Y2cDhxZGo5QTNLVGFW?=
 =?utf-8?B?RkZ6eEdsWk14M0JGU05ydjZPeHRKNWRROGdHMTVMY1lLdTgxams4K0NmTHlF?=
 =?utf-8?B?dER6RXdQblVqVlBpVmgwRmJDSXVzUUsyblIwaUIzZkh4UGVkUUNEMnpuSDF1?=
 =?utf-8?B?bytCU29NVE9hQmh5MEtIcStNVDZIVUpPNlY1ZUw3M0N0MUVNUG93NGZWdEdE?=
 =?utf-8?B?YmFHb09ZMTNIT3B2azhnL0Z6K0FxdkpEMTRpQUhrM0JsOGR2cTYzSU5iQTZZ?=
 =?utf-8?B?NEcxT0dDb2pJK3ZhUE0yaWh1VHpNZVFaanJWK1JZdk9lRnlEb1BzMlJpOElU?=
 =?utf-8?B?SktiWkVldjZKOXBtbEl2dWNrVkFjNzNuOHkwSGFvOU1Yam12c1JmeExISlpC?=
 =?utf-8?B?Y2h5dVg0Y09VeXZQMFdTYWpxZ1pTbngwVTB4cXhiRlA2YzNRbTlNNjdwVWtI?=
 =?utf-8?B?TmtFQ1ArWGRrMHdTR1NqM2RiVEVxSkZwY0lVQ0Z0blMvdnNGT3V3NzA0ZHJK?=
 =?utf-8?B?dkJGRXJ5ajBSd3NUMWJuTWMxeDByL0VGS2w3TzdVQ2tHSDJiTGNxT3VyTWdO?=
 =?utf-8?B?Rk4vNkRwdy8vRkpKTmdHOUIwMDBMajVmVkdYVUJ3b2lYQ0pXMTc1R2FqQzdE?=
 =?utf-8?B?MDYzTHg5cTB2MGE3Wlg3RTI0cUdaQlpyR1Btb2VKUXhOVEVZYVFrMVg5TVZv?=
 =?utf-8?B?elBrM0o4MzlRdjU5QVpHc2N6L05MWFMvZ1dNelI1SlJ1MUUxOUZYR3cwcFpl?=
 =?utf-8?B?Q0xLVnlmK2NJMXVMRE1jMWtyOGdaT2R6U2ZnS1F3YzdnRWJwRnZza1VFS1VK?=
 =?utf-8?B?UmFkNjV6ejJYMDZXT0JNTzMyODFRYjB0R0FlZzhaN0VucVJkNHlBVnVKcERh?=
 =?utf-8?B?K2poNDF1blJaaEc5V1pGeHh3bzdscEkwMnJmb3pNWktQbUJkTGR1dk5NSnI5?=
 =?utf-8?B?WlB5T2Z6VldBeFQ4YllsbnEyNDFVRjArM1Yyd0VhYllNcVVXd1dvZGtoUDVu?=
 =?utf-8?B?NHpOQ1huZms5RFdpUkI0MXRuQk1jNVBxcUM3eHBmdUt2akE0VUgvUGwyVkg3?=
 =?utf-8?B?SlBmcnNoU0thbDRwdkJ0Wks4RFRsMzBhS3VhUFBUc29zMEIzcnE3dHoyb0VC?=
 =?utf-8?B?UG9rWnBFeEtEd2p5YWpuLy8wc3FmSDhQektBbnJ2WFNmOUR5KzBCS2V6aFhL?=
 =?utf-8?B?M1FYaXppZ2FCMFZnOGZpemZlUi9Sb3FXeWY2VENUajlUYkczUHRZdEp4UTRL?=
 =?utf-8?B?N3JJYVNCcUVCTTl0WUk4Q2I5U1l4S0lJYnNaZ21qUklwU2hLTWMrcFlyMkpC?=
 =?utf-8?B?T2ZKN0tXbllkeEdzeDhZNjMrUGN1bzU5Mnk2MW1uSjRMRUtIOEYzUHFGWi94?=
 =?utf-8?B?d2xRWXY4dFRVWmNKenNvSUZzb0RZdmJMYVhCdkdEQTZocnZNQXZ3UHBIdW04?=
 =?utf-8?Q?QPCEmTsWVvyIUen+p8XvxJiuC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7380.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnErNE41MXhNS3Y2KzVwamNBdmpnK3R2NEhRb0RZZEE2YW5jdERENGRvMjFv?=
 =?utf-8?B?S25qMWhvN0xCSXEzdEIybDE3SU5RbmFPeWRqTFNzZDJSNHhDNWdxNGx3TkUr?=
 =?utf-8?B?QlhsUFVwdkhEK2s5T20rV0xSVmJZVmlFRnNjalV0ai9RUGUvNitGUmMwS1Ri?=
 =?utf-8?B?UHB5aWhVMExnMFBocFhiejBTb284amNEZUV4T0l0cnR6Zkd4djNHYzEwQjY2?=
 =?utf-8?B?bHJJQzVyM1pCZFNiT0dYK1U0NGJ4ZUxUaTgyMW1TSkxZbk9IRVF2RERrUnMr?=
 =?utf-8?B?YlBLMVVDak1xcUJ5MmhjVU1PYnhGaDBtMk9WTHkzSGZLUUFkdjZ5UnU5Q0RD?=
 =?utf-8?B?bkg2c3ZQU1FkaGV0UVFCLytmQi9xeUZTOENmeUNMTTdpeFJIbDBOQVRvY29Y?=
 =?utf-8?B?UU1PMnp5aXdNcFlyTWlWNzk5YWVCYWwzVEJ5OTR6VW4yRFlsYXdjZDhwQk9p?=
 =?utf-8?B?alU4OWFzbUYrK28rWGphZFJHTEZ1U1JNRkdmUW96MXo4U1NWemxsZmhSNmJo?=
 =?utf-8?B?dmJvT0dWYUN4VlljblZOVCt6aEVTaVpjU2s1V29CQVhreEI1TTBxMmFOVzFB?=
 =?utf-8?B?dkVaN01hcWVqRDVHTThZdXJ0MnNvcFJLeFoyQ3JENHdtNUlkM0FJTlYrQStO?=
 =?utf-8?B?bXlrWjJGeDU3SHVjS1RoUTg5bldYcW9PeTZjdlFmUXlXcmhNeDlsL1BOLys4?=
 =?utf-8?B?RFVFeEVGMkR3dXFHcy93OTllaGZVWFpONXpvQVVORUxIdk52cGE0dnZQTjlC?=
 =?utf-8?B?czd6TnBDUHVWZXBvUkVYTkVSSlRuOFA2dTNQT0FZS1lvQzZsTDRxNERuZ3FC?=
 =?utf-8?B?ZEI4YUs0TjZJaVdBQm8wbDhLdVVHVll0bENscXUzb2ZQSUxmMzdEcUFaZXg2?=
 =?utf-8?B?ZDRiQkV3UHExbXhmM2NoOERCQnp5THdLaXZHdzROWTlDSFpIMEJ4WGxGa3ZV?=
 =?utf-8?B?UURqL1BGaTR1Qjdla0tvc0JWMjVhdXBLR3VSVzgyczNxa3VpQ2RMWUdBRmI5?=
 =?utf-8?B?cUtnTDhhQ3hlb3hQaGZYMC9YNjB2NUs2bml0WjFmaG42RnRVWXFPeWtGUlFR?=
 =?utf-8?B?Ty9JSkh4NHJxSENLeHNXV2JwR2pnQmgyVkREdGJVcDBjZXV2UmRpQ1NYR3g2?=
 =?utf-8?B?Zk45dEJGOTN3SHZCNHEvQlJQZGltaHJwNi9jN3V2cklPOWNDUjFKWUJKajBC?=
 =?utf-8?B?SFRhRlZCU0JFeTNrY3REQ2pmbyt3dG1HMDFJSWV5MHJJbmdEc1NXbzdpRHdE?=
 =?utf-8?B?dk5qSTEvbmoyQ01vZnMrY0UvclJDY25wN0NnK1lYZGNIUXo5Y3AxTDFSc013?=
 =?utf-8?B?SnM0VmxoMFRoVzRMRjMwOW9sSTNUZnRuVVIrNVNzOEhvN0xOSUxRcFZCYXRE?=
 =?utf-8?B?WEdtYTdId0xpNDJPdlp1aTJ1RGVvUW9GVkdzZzhBY1UyV2VCZFNpUURsbzZV?=
 =?utf-8?B?M0Q0R0xhQXdzL0JSSnRTVFpsbEpBUVMyOEZSWWhselVFQ3dndHVaLzJEdkc3?=
 =?utf-8?B?WDNxS1pXNkU1eFJyK1JIWFNnaXc5WURQdjc5RHBHRWRTRVRMSk1LRDQ3S0tq?=
 =?utf-8?B?T1ZFYUhNZC9HTWhGVTZtWkNBWlB6NWlFaXo0UXgwVDdPenlzY25hbldWNzFQ?=
 =?utf-8?B?cGxTeEJJcWZKRTQ5MENGV29hendKdHAxV1FWaTRNcnlMTUhkZ082MjgvSU1V?=
 =?utf-8?B?SVFoQVNYeXBCSWo5RmR0NFdXZ2NiYWxaWk1kcVRKalhnZEJOMEYxaWhXeFcz?=
 =?utf-8?B?dnJRN3ZCSWRjZFVVTlc4ckpWTWE5VTdMS1NJdldwRUVJMFJQeXVmS1lqWDNn?=
 =?utf-8?B?a2thWHdCVC9VTkkzdGtnbEJZbFppZVZmM0R4akJucllDNytuVS9ibm50T2Rp?=
 =?utf-8?B?MHIrZGdaSzJzUnZ5NFVzd0tZOUdiZVBtRHlMYjIrYWtzRFc1ck5jcm9WYm0z?=
 =?utf-8?B?RkNBZ1R5NGdoODhHRnQveGVLU2k4aGtibW1hMUF6U2JJSzVFaGdpMUFHNFVq?=
 =?utf-8?B?M0J2MWNNODJ6Z1h1Sit5SFFCY0o4MlhNaVZZNWlxTU05akF3S1RBZjZiaFVW?=
 =?utf-8?B?WGRydWNDWVpkNWdvNlhmV0pCdThPT2tuREdGbTFUMVZ2a0VrNkgvalN1bmpJ?=
 =?utf-8?B?SjUwYVpadDJBa0xWbGZUVVdwTFRrVzJsMDlLV3VkdUw3eWFYUkN3bDBFN1A1?=
 =?utf-8?B?cnVxTkd6WXRmOUIrZ3JJRFBGcndqTXE0TVQ3MGxGdmIwTFNJVnY1TW5jY0tx?=
 =?utf-8?B?TERHR3lUcGREWHZROVd6UkdnQkEwSE1ZT3JjY1NkSEg1VnY1NGwzUExUS2w2?=
 =?utf-8?Q?DbNe5yWQqriQFTB61L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a2cdfb-5113-4b46-87aa-08de6e0160fb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 08:48:53.7529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xi47lFr/O1pcfka2cAdFkjzTKtorT/baefeP3+VhqE3lDi3Yg86BxJUQ0vqwoK/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9749
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

Hi,

On 1/22/2026 6:55 PM, Michal Simek wrote:
> +Love
> 
> On 1/16/26 17:14, Sean Anderson wrote:
>> On 1/16/26 09:07, Marek Vasut wrote:
>>> On 1/16/26 9:19 AM, Michal Simek wrote:
>>>>
>>>>
>>>> On 1/6/26 23:17, Sean Anderson wrote:
>>>>> These registers may have been initialized by SPL/FSBL, but program them
>>>>> in case they have not. If they are left at their default values, the
>>>>> controller will never exit reset.
>>>>>
>>>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Verified it on AMD platforms and not seeing any issue.

Tested-by: Love Kumar <love.kumar@amd.com>

Regards,
Love Kumar

>>>>>
>>>>> ---
>>>>>
>>>>>    drivers/usb/dwc3/dwc3-generic.c | 32 ++++++++++++++++++++++++++------
>>>>>    drivers/usb/dwc3/dwc3-generic.h |  2 ++
>>>>>    2 files changed, 28 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3- generic.c
>>>>> index c09014aec60..ce896db9532 100644
>>>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>>>> @@ -501,6 +501,27 @@ struct dwc3_glue_ops rk_ops = {
>>>>>        .glue_get_ctrl_dev = dwc3_rk_glue_get_ctrl_dev,
>>>>>    };
>>>>> +void dwc3_xlnx_glue_configure(struct udevice *dev, int index,
>>>>> +                  enum usb_dr_mode mode)
>>>>> +{
>>>>> +/* USB glue registers */
>>>>> +#define USB3_FPD_PIPE_CLK    0x7c
>>>>> +#define USB3_FPD_POWER_PRSNT    0x80
>>>>> +    struct dwc3_glue_data *glue = dev_get_plat(dev);
>>>>> +    void *base = map_physmem(glue->regs, 0x10000, MAP_NOCACHE);
>>>>> +
>>>>> +    if (generic_phy_valid(&glue->phy)) {
>>>>> +        writel(0, base + USB3_FPD_PIPE_CLK);
>>>>> +        writel(1, base + USB3_FPD_POWER_PRSNT);
>>>>> +    } else {
>>>>> +        writel(1, base + USB3_FPD_PIPE_CLK);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +struct dwc3_glue_ops xlnx_ops = {
>>>>> +    .glue_configure = dwc3_xlnx_glue_configure,
>>>>> +};
>>>>> +
>>>>>    static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>>>>>    {
>>>>>        const char *name = ofnode_get_name(node);
>>>>> @@ -621,11 +642,10 @@ int dwc3_glue_probe(struct udevice *dev)
>>>>>        struct udevice *child = NULL;
>>>>>        int index = 0;
>>>>>        int ret;
>>>>> -    struct phy phy;
>>>>> -    ret = generic_phy_get_by_name(dev, "usb3-phy", &phy);
>>>>> +    ret = generic_phy_get_by_name(dev, "usb3-phy", &glue->phy);
>>>>>        if (!ret) {
>>>>> -        ret = generic_phy_init(&phy);
>>>>> +        ret = generic_phy_init(&glue->phy);
>>>>>            if (ret)
>>>>>                return ret;
>>>>>        } else if (ret != -ENOENT && ret != -ENODATA) {
>>>>> @@ -643,8 +663,8 @@ int dwc3_glue_probe(struct udevice *dev)
>>>>>        if (ret)
>>>>>            return ret;
>>>>> -    if (generic_phy_valid(&phy)) {
>>>>> -        ret = generic_phy_power_on(&phy);
>>>>> +    if (generic_phy_valid(&glue->phy)) {
>>>>> +        ret = generic_phy_power_on(&glue->phy);
>>>>>            if (ret)
>>>>>                return ret;
>>>>>        }
>>>>> @@ -690,7 +710,7 @@ int dwc3_glue_remove(struct udevice *dev)
>>>>>    }
>>>>>    static const struct udevice_id dwc3_glue_ids[] = {
>>>>> -    { .compatible = "xlnx,zynqmp-dwc3" },
>>>>> +    { .compatible = "xlnx,zynqmp-dwc3", .data = (ulong)&xlnx_ops },
>>>>>        { .compatible = "xlnx,versal-dwc3" },
>>>>>        { .compatible = "ti,keystone-dwc3"},
>>>>>        { .compatible = "ti,dwc3", .data = (ulong)&ti_ops },
>>>>> diff --git a/drivers/usb/dwc3/dwc3-generic.h b/drivers/usb/dwc3/dwc3- generic.h
>>>>> index 40902c8923f..13f6391cae8 100644
>>>>> --- a/drivers/usb/dwc3/dwc3-generic.h
>>>>> +++ b/drivers/usb/dwc3/dwc3-generic.h
>>>>> @@ -10,12 +10,14 @@
>>>>>    #define __DRIVERS_USB_DWC3_GENERIC_H
>>>>>    #include <clk.h>
>>>>> +#include <generic-phy.h>
>>>>>    #include <reset.h>
>>>>>    #include <dwc3-uboot.h>
>>>>>    struct dwc3_glue_data {
>>>>>        struct clk_bulk        clks;
>>>>>        struct reset_ctl_bulk    resets;
>>>>> +    struct phy phy;
>>>>>        fdt_addr_t regs;
>>>>>        fdt_size_t size;
>>>>>    };
>>>>
>>>> I will let Marek to handle this. From my perspective we should take Jerome's patchset to update usb stack and then add this on the top.
>>> Since this fixes a real bug and is isolated to xilinx platform, it would be good if xilinx at least provided feedback on this patch.
>>>
>>> +CC Ilias
>>
>> It's not a bug fix (hence no fixes tag). See [1,2] for details.
>>
>> --Sean
>>
>> [1] https://lore.kernel.org/linux-usb/8f0e04a5-49df-4fe3-9c76-9a1c0bd822a0@linux.dev/
>> [2] https://lore.kernel.org/linux-usb/be8a566a-163f-4d20-b712-67de6f63a6b5@linux.dev/
> 
> Love: Can you please test this patch and provide your tested-by flag if it is working.
> 
> Thanks,
> Michal
> 

