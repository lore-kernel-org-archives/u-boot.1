Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE24CA0EFA
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 11:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 976A782E37;
	Sat, 23 Aug 2025 13:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="H8Ih8BHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B93783013; Sat, 23 Aug 2025 13:30:46 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D5F382BA7
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 13:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgyKh716BNFN+lQnre9uyHktCq1uRHnM87XEQTr+kBwYHwPTuq14257iWBLMjZefOJym+cw66zztCYN/Sw6+3KMYi9YJSAO8mQAN5QQQYcCw3dJ2+Whvagsm0wdqOondF7AheWtJcAbq1iOdkp2xahKKwZ6xMlSzdrNeAFLW/RwR5FOEFfNPnmJjfszW2BGEBEJ7p31chVF5iRfeVadjCRFsyGN+x6MWceCX5A4OlHoG5SYmPUt0AJRqyELNIehn5yQn6DS8DSVnm3uW0opPpRzky7Y0gpbo4Acvz1d6t4i7+SwJZPsDWBS7LiNYIds/Hdnq0mOKf6mhd8QrlvRECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N8oStb2ohPr3qinO+g+3GW9CTuapvDTqrDvMQDtK1k=;
 b=E4A2I834+WyAQSkhyGYCCnZYsFnN1z7H9CfIr0qVHKyCeBI0jqHPEapBeJcwdQtIowbATYymziiKzoyXWkrkzGtdz3KRpjd8DFo7aabAoDgVknSfrZ54NRPSuLMZ1DAzUqmBRzObhmUM61Z+TBUbOdiQX6BalB5A8TRU04+p24kfp2r7FxXhp/kzmwHrTaI10LA4KPF2qnT3UDA64/KlC7ssMn2U9u2u9tW+rKMPC5xksrdIt2Jj7Qae++IkI3FoICzK/FMlyEjD6bvNVCVC/VMSXVYriQtrdMs5JkmphkmuHvo++jfw9U4j7TgNkUkMCTq+VvhOdQlpAl02duMJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N8oStb2ohPr3qinO+g+3GW9CTuapvDTqrDvMQDtK1k=;
 b=H8Ih8BHTHXwKIgKkOFRRugc1fk7hzNuWuGhDxFqyM7iU0a0o5AKt3gNhsQnl4dVLXouduCWLrDuIy4037a5s6FDw4Xh1VVANd87tRFce7RcLlkVKpcXFIfSYCKWxZMOgDN1jKOVFhvbPiBYW64x6Z1z1a9Sx4fI2voHSHem+rjGe2QMaYu6oVsZKzeZdjjN9ycpiLuaAO9dnfXXfwuza3qsLo7jvZfe5FK5Z4u9yaxVVEBmW10ivNUgPv6lk6/Ehx/P52Kv/4PCestuSfXXFGUZDctBGeVVzZJoNk3LI1iK50MXynkoOF4qtpV3spUzAjzPM8AAD7fyCJfZN0ShZ1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sat, 23 Aug
 2025 11:30:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.017; Sat, 23 Aug 2025
 11:30:42 +0000
Message-ID: <ea8ba903-2066-4fd6-86b9-58ad944c7f27@siemens.com>
Date: Sat, 23 Aug 2025 13:30:41 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] tools: Wait for logo generation before stripping
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: e9208ea3-0658-4310-07fd-08dde2387e89
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTBiTHdBdCtxblBQSFRMbHNwbkhEcXd2ZmNUMkVYRmJiUWFlUEdsZVF1RHVC?=
 =?utf-8?B?Z1lJY1RRMTBrVU01QWhHUktFbjhxTW5oNVdieWxaYWZQVi90MDQ0Y29WM3N1?=
 =?utf-8?B?eVpEbmZLTm42d3M5Ym5BVmtYZlQvSHpsRUwzc0xFQXAzSjVVNy84WFhrNXdn?=
 =?utf-8?B?b1hFVWpPK1JxeWQ3d0U1Zkw1SzFRM2tvNU5WSFBqbi96cWszaXVFaWFhTkx2?=
 =?utf-8?B?cVJDYk9CSXQ2Vnp3akt2NUl3bjRRaVppVTAzeHBNODRDektoaHIzRVN3NXBC?=
 =?utf-8?B?MGNGcExRWHNtZTVaQ3NtSEtwbWhBV09ab1FOVk1XT1VnZDJCYzZrc1BJZmZK?=
 =?utf-8?B?d1pRTExpbEk0RklJVmNzcnRjQ25ud04vSlAzYWk5WTBadTMwMW1keHRTQXZI?=
 =?utf-8?B?WnlMam5hMEN0bm5KSVhSZVJVL0ZlUFlCbmhOT1ZEWXNLMkFXK0lxM1grOEZH?=
 =?utf-8?B?ZGZ4a0RKbGdYZ25EQ3huQ1dMMXFuekczQmhSUHhpOTZtUVZyaVdsRE5PTlRP?=
 =?utf-8?B?WERWSFFGb3Z4c2hwM25WWjRnSUFUcDJxQ1ZGYkR4SjViTTcvQ1FGODVQSjlG?=
 =?utf-8?B?UW9YaTY3TjJ0eFUzQ25DSzJIUnFMUzk3VisyU1JaanNzemwvYk5VK0ozQUV5?=
 =?utf-8?B?MU1acGtPTmpZNE1yR2c3Z2tiZERPVWVnY0Nub29DYnZkdEs1M3ArUHJ5VjNF?=
 =?utf-8?B?ZHZ4QW5pL2tUbjZoMTA5WTZZVXV5T3l6RlRNMXNxRGpudTZESkk0Y2IyYkNu?=
 =?utf-8?B?QWE3NFlWVE4reDNVeDdnNFg1eTZSbFVTRWFmMkZkK0x3YndJT1diYTcyZ1RR?=
 =?utf-8?B?UHpGOFU1MitSR2xsT2lGbDZONXlvL2Q5YUxyYjNJcUhWbnVoT0lJNTBrcGU5?=
 =?utf-8?B?QS9zazd1ak9pZWl6cEdrSHAvTlJlazVua0c0Q2kxczR1bnpOaTllYk52WStJ?=
 =?utf-8?B?d01qK2RrWWs3VGV2YXVpczlNc2FVQ0c1eEFjRXM4TWlrYlJObnVjNm1YTzZI?=
 =?utf-8?B?ZVFSdXdBZCtyWGZJLzZTOVU4c0RSYjlRekFHa3VpWjF5LzVFRU5tTktWcFlN?=
 =?utf-8?B?dU45a3pBTHJzTSs0a0dmZUlNbSsyZVo4L24xWDZMM05oS3FQYytRMnNkdDhi?=
 =?utf-8?B?M3Q0RzJqMXJVSFlKTERWZjlPUXk2VlEvcTRlTXFvQmFmUWs4Nmw4bWZxa3l1?=
 =?utf-8?B?T253TkNHMWNJVHJwT0diNloxTFd3bG9zaDZta1FwNVp1UDJCTjNkUWxzRG0r?=
 =?utf-8?B?emM3KzE0MmF5SUNJbEpJTHZ5N2hHWHNvMjlBVHNNOXg5KzNVUElBMk85cmd0?=
 =?utf-8?B?bTBNTlhwai9CYUViTUJyNGozZzUyWjJUbnJYYkFST1JUamRTOGZUWWtWK3Aw?=
 =?utf-8?B?RFR1cFdSN1hETGYzNWovNHQwMUc2MEJLOVlJdER3Vm9ZRTR5a1phUEVpbjRh?=
 =?utf-8?B?RmxUbllvbmVIaFROV1Q5QVQ3VHJRTElNaGFGRk1IbE5wU1dWNG43aHU0cHY4?=
 =?utf-8?B?VGNxU09uOGRkcDVjVGwxenp4T21uVkgzcVEyY0hGZ1libWx2dEFWemRwcjZq?=
 =?utf-8?B?cUdSekFaV3lGSFNGd0ZrbE5BZGhpWXdBMHJ6QTNTem9TU3BDSXJGQWZHSTlu?=
 =?utf-8?B?N1REeUpoRjJVMFk1S0FxWDVCcjVWdE94d05RQldaY0g4NE1ndDd3YW53dmJJ?=
 =?utf-8?B?bTFKWDhuOG1zSW1rVm9RemtFYnVVa2I1UGppb3o0aSs0Tm1HdnhFTjFLVEZL?=
 =?utf-8?B?SkVMM0FPcmY4S2hHNXY3bTJFZWMvdGVNMFhWM0pMMkJycjNheC9PWE5Ha09j?=
 =?utf-8?B?c0hXMjVxemxCeERPczhLMkRwQ0xvcFVvbW56S09FbmFqVmxPZ3dZZkVMS1J1?=
 =?utf-8?B?cnM0Q05mS2c5RTFsS1hiL3d5Qmo3dnF3SVlJRldHTlcyZTVCZDQzeG5vUnRs?=
 =?utf-8?Q?/1bGW3LkHuI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUdIVThpWDI4bDlucm9xU1hqY3c1enBtYWQ5amNvWEliTFIxMUdwdDBhK0kr?=
 =?utf-8?B?cFEyWDN5T08zSjVaTExLODlRd3Q4S2dFV2hMbmJZZmUxT2xSMUhrd1pmK3h0?=
 =?utf-8?B?T0IrNEVuT2tob3ovakMySHNBMm5WRkJ1MEZNc2tlZ0U1c3prUHBNdy9XbUcy?=
 =?utf-8?B?NklRRG44Zi9lanhVMGo2akpiYzkzYm1PVHo2YzFtVkpxSzNUL3ExTyt4ZlBa?=
 =?utf-8?B?WGxtdHd4d2gyMjhudzVMdmhMQlhYSjVLb3VBNEFhMnpHbVRxRzlEbG9sRHM4?=
 =?utf-8?B?NklQSkRUTEg0b2JRNDNKQTVqQ0lVZldZQXBtOUtReHdON1NlWDl0NFdsVkU0?=
 =?utf-8?B?RC9acHp0Z2VGOGF6VEdCLy9nam1iN1Z0VmZZOC9pKy9XS1Q0NGdZcC80bVZ2?=
 =?utf-8?B?ajJhWnhxbzNHdVF4czlBeEloMEJ2N2diM21ueGwveXJYa2UxWUdENFQ0eWxo?=
 =?utf-8?B?bXNoVm1jcXA5QjRldXBZYlJJWkFkZGNlUkpUc3VqQUxaTWVTVklLU1Y2TVpN?=
 =?utf-8?B?VlRSOWhoeEUraHA0RUd6Rzc0dnZ3ZGhzM0E5VktrSTVlb0QwRzFDVEdLY0NO?=
 =?utf-8?B?aFVvWlYxOVphZUJ1Ym80ZHo0WlFpeGp4M1Q1Z2F1Mk0vYm90WjJGYlpIdkJi?=
 =?utf-8?B?NjA0N1pwMkNSZW1iTm5SUmN5blVoTjhxeCtwRVhwazcxVFdWNklnamZmVmxw?=
 =?utf-8?B?cXhKK2FSRmN5dkVRTENyUHcrVjJ4ZHZwdHQ5QXdnVzg2eHdnSUZXMHRhNVIx?=
 =?utf-8?B?OFk4b1NwSUdUcW1LK1o4V05wcW1RK2VqVEk0V1MrbkVUUUI5UFdJK2ZOenNB?=
 =?utf-8?B?cER0cUh0NENrdWtRVUNncHcxUkN2blF5aHFJZ1RGZHRNdEpubEg1cFFlRVRR?=
 =?utf-8?B?RDFJdlZaNGVKUHhUQ3pwQlM2YW9oc1lqcXREZnlaVXpkR0E4ZVRkYXhSRVFa?=
 =?utf-8?B?VUllc1VPeFovQmRlTnlJTlQ2ZW9LZE1EemJxd2tVYjRkZjBnTTZQQnY5NGpU?=
 =?utf-8?B?bENGUlhnVml2V2hXTnVOYzdIYlh4bDl5TkNSY2VHT2NybWhNQmpUR29Jb25J?=
 =?utf-8?B?TS9jNU45eWdKUlB5bHdrUEN5N1JGSGtoU1lJWmY1SkRXa0FpMXBoR21zRERC?=
 =?utf-8?B?b3hqWDY5OVROWUU0SFIxVER3L2RUSW5zOFVVLzQ5Zmp2OFpsMEhDdThqYmxC?=
 =?utf-8?B?bGpSZ2JXL2lrYmM2WExIdVk0OXJYK054M0VwRmwwdUlFbXFHbHdnelVlVXR1?=
 =?utf-8?B?UlJ5c0RIMlZ1YlhGc29iSTdrc2xTL1JobUwrRG5MZTlmOUQxS1Bjc3hCcUNP?=
 =?utf-8?B?eHZnMjFGUlFiUkZrdXE3TXhxb0orL1hyNWZVZ0JFNDhETGxneGNmcmNwZHZI?=
 =?utf-8?B?REJCSXJGamZtOEJTdTUxM3RyU1M1NWQ4YVRXZDRnbjFYSnNPeDJ5VlJaRXYy?=
 =?utf-8?B?cGp2YjVlNUJVMFB4dWRWVW9QZHcrSXBCQ2NCY1MrQlYwWGFwN1NVeUtSOU9T?=
 =?utf-8?B?MnRvanhQSHFTSjlLUkNpb1FRamtjMXlFNFl3NmpJb21xc1lBb21UaEVHK0Zt?=
 =?utf-8?B?eW84RUdUZmwraWphNE5uMnEya3oyb3BHQmphbVNCaFJaV1kyRy84b0FaVXFu?=
 =?utf-8?B?aE5DUXpFMW9SVDJwdDlxOUljYS9TNzhDZGtwMW5FTTZYbEtRM0VtM2lKRHZI?=
 =?utf-8?B?MHcyQzBCYzNMaThMUWw2OVZBeWxyREo3ZTJjdDJHTnJPKytpNHQvT20zUTht?=
 =?utf-8?B?a2ZUU1k2SUtVVFNzdXZGa1N4Y2tCV1BoQjdDWmZRMTB2clNyUUMvZE9TaG1q?=
 =?utf-8?B?eUt3d0NXRDBDT3VQWlhXeFNpY2RRb0txRklGQXZNMXNnZldSNitGaTVzQ3hT?=
 =?utf-8?B?cjFiU2s3NDdjS0NFVFZEL3d5VFJRM2U5aWtkVWU2aUo2dnUvNmVLTXE0enYx?=
 =?utf-8?B?V0xzVisrL1dlVXl3VXl2aTdnVExWT05xZ1U1allSdUMrMTNjZVhFZHZFZkZ0?=
 =?utf-8?B?TzZldVk1R3dCTDRNYmxGSUZiVVdCdUhtYVNOZWF0U2JUckp4MVhJNTQ5eC9u?=
 =?utf-8?B?Q3YyWDBlaW5FRmZMaFpmc1RNOTBmdkI3bjZteXZxR3ZuVGtPUEJZbDFCbDdu?=
 =?utf-8?Q?GoeTa9LBXyHtkyilUucsFnwF+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9208ea3-0658-4310-07fd-08dde2387e89
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 11:30:42.6624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bClqoNZx+bbVOUUAunRrLTFiEqofOixxtlrmuV5r4GAWAWwTWwETCu8cR7e5dG2k/86PoL9uHe/VbbT7cNFn9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5815
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

From: Jan Kiszka <jan.kiszka@siemens.com>

We otherwise risk that strip will fail because the bmp_logo binary is in
use during a multi-job build.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Also feels a bit strange that the logo data is generated when one asks 
for building tools. As long as that is the case, we need such an 
ordering.

 tools/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/Makefile b/tools/Makefile
index 02297e8c93a..9b8a89e66e6 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -356,7 +356,7 @@ override HOSTCFLAGS = $(CFLAGS)
 
 quiet_cmd_crosstools_strip = STRIP   $^
       cmd_crosstools_strip = $(STRIP) $^; touch $@
-$(obj)/.strip: $(call objectify,$(filter $(always),$(hostprogs-y)))
+$(obj)/.strip: $(call objectify,$(filter $(always),$(hostprogs-y))) $(LOGO-y)
 	$(call cmd,crosstools_strip)
 
 always += .strip
-- 
2.43.0
