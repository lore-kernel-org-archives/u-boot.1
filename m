Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF09CE7AF9
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 12:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0C2683F33;
	Fri, 14 Nov 2025 13:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="JGZUy6vJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B7B840AB; Fri, 14 Nov 2025 13:07:33 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9897E83EF5
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 13:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3ycCijHxK2SK+QHjYRwG+DQuG8ld7jApcQCD2hyjrdk/tmHeHdX+QGqa+g7r/VC0kw7xBGBKnhyUXerOghobOSzZWwlc0MlzY2IxKNlpj8rKJxD9uqVrxZjqgIXcv9D1iAG1j3fwf7TYO6UfLz5smZLHIrgbzu6eA2OInNRVHIA21ByII4xqliW90AY8hWXf0LO48/+BHfYnZinZC8aIitS2ASC0OfMNIe7/U29ioQLNGtyYn3ty7hOpjCVNIFonr4xAy1giHWWkqi6w1CFmUhDKWww8yePI26pm5lz/T2xTkh1D55qL0zrp5jLo5H0JpUiP6yWx//oNJNxI48ruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InRIretYstJMM4On4XwuxCZNEYMPnGZkopBOfVOJYmc=;
 b=XPG43np3LkuAoNqgw4t3T8LvY2271deW/6BAzdIPLzV+9cYdB7eax2An9aRSxqkkixsp8aK627GcJDidP7/ItTgEDZW1Ycw+skgfbZCbvCBsiuntlIRY78aLTm+R13NQm/vbH+/zjmasmUfNeazHT/I87kNI3rTY6Law9oNgv9xrKrw6lpgpLydsNbzlgO1PJ/xIwukKrjRCGVY7KYdNKlSnVe9MHpM2vJwPsl641gQwNQTa2WCG78O/pqejTefN73tI26LZxuO59QxNJXqy6p13x0Vb32fH/0pRwf2w12E/q20N8vxrSQkEbGIE8OV1KpR/nnu+bRNW0XYT3o8+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InRIretYstJMM4On4XwuxCZNEYMPnGZkopBOfVOJYmc=;
 b=JGZUy6vJzbA94ZRh2YfU5NWw85/3fiUdHZXJSpENksWHeWAA83uwo4ePZ+52JWCz967w3ecVgNsQN5nMb7l3BVEx3y6AJarPvLEMCRbmnG63L2u1++E6pO/Et4YQMneNzuJQxqVGbycmvidAnImFBcajhnLCSGNrjfmOYBYMSmip+wwUS7HmFmBJbUyOf/I3R5zJ1LlLbpJB7MBxdV1QO1T5m+SKDNymdMTZBfvPnL77suq5/2PQeCML7PMEJ/RK0Bcv16yOzddLsX77XqKEWpRYoXC9oZm4wl1az7MYQ/uSDNtOX0qMbL/hhmtZG3DMOHcLrQwRueLZbfedToXlRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB9588.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2f8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 12:07:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 12:07:29 +0000
Message-ID: <99585fee-dd5d-4f9f-aa88-0ee34fe02181@siemens.com>
Date: Fri, 14 Nov 2025 13:07:28 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] arch: arm: mach-socfpga: Fix non-Agilex targets
Content-Language: en-US
To: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e904f1-7076-4cfc-0458-08de23766256
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDkxeEZVMkhqc3dESWEzdVRzZzNyWHZKSGR6QXd3aWtrRlBDM1krb2pmV1FL?=
 =?utf-8?B?NjNuN2dNSEcxVzN6cnc3dzB1WlA4SWRhaEZ3MWs3Q2VBSWlzQ0REaldTcmsv?=
 =?utf-8?B?c2E0MllCa1BrbUhYa2hqMVhRSnYwRzkzdzZkbTd5VCtnQWVuK3QzdkZtbUMy?=
 =?utf-8?B?c2RSY3JLTTVEMVFWaUpvY2piV29iS2wwVFJOektJcVNMaVN3ZUdweElyRWs4?=
 =?utf-8?B?L3FEelZRTmRlT0kxa3dSWHdUSnkydE9Fci9BYnFlN1ZlZGxVczBJbFNCK1lw?=
 =?utf-8?B?VTlQZ2NJUzNiSjIrTGlhVXQ2MmZkemlzZ1lGM3Awbzg4cFpEY3dmRmtIM2Rp?=
 =?utf-8?B?TWkyaGFPb0tBUitLTUZaSE80T0l3Y29xTUordlFjMVdpd2UzVXhUWE12ZHJD?=
 =?utf-8?B?a0x5YU53eDdBSkJJNnlLYktaUXhzOTJzU2lYTzRxUWhMQVBqK2NjK3lBM2Zz?=
 =?utf-8?B?MXlMQXF6ZmwvSHN5c3FwMGx4d1ViVGJWOTJNaVNwMTRiOUJXd04wSkRJZk8y?=
 =?utf-8?B?NkhlcVdOZWlQWnIxdUtyVVM1clRzZ000M3kvNkU5V3BvZU9ZVkt1NTAxSERa?=
 =?utf-8?B?QlBoWHVtYkJiS2d4RHNScW5XMWJEZDIwQ3p2aEdDaFRHdFNtNnlCMVlZUFBX?=
 =?utf-8?B?V3F3TDNmdEdKOVhoOGxwRWcwS3pBNTZxNkxpL3R2QlhzeFZGYlZJUUpNeXlQ?=
 =?utf-8?B?YzVVQ2prQzA4VEp2NmxWd21Ydk5KUUFBNmJzUHBPcFYydEtYR1U1MWJyd0Fw?=
 =?utf-8?B?aUhkbllVM3RwNFFRYzZqdjR4MjExNm5zVXZaQXJCQU5VUzVpSFJHakpZMGJT?=
 =?utf-8?B?WVplakRiV2dtbjJ5YVZIVWhWVVlqYVJ0bGlpVHF3UGN1d1daS29vS1RwTDJH?=
 =?utf-8?B?MmxVdEZrbWN0R0FXcVlTWXBlbGVucHNISE5KTm1WL1Q4c05xSUdqdHR1d2JG?=
 =?utf-8?B?WFc4NWI5TVVqTTJXMkhya3NiblE5cFBNbmVWaG4vUmprd0trWjlCTnNJRElR?=
 =?utf-8?B?V0h5Y0RRbk1rVmRKRUE1RE8zNURHN1MxQ0RyYi9WbjlpTzM5dVdiUitZbkZn?=
 =?utf-8?B?cGNaRDN1WGh3MTdtOVB0SkoyU3AwdUNtaUd4MlhvbTlpbEZOcGgybENCWGhi?=
 =?utf-8?B?RzhFb0JNTTNOS0lReHN2TkhqN0hndkdzSHpVenQ2QjI3MTFzR3lNb0UvckE5?=
 =?utf-8?B?N3BvOHkyejFMNkZpT0Z1R01RakVrSjJvL2VRanNmejJjSVUxM0VsNDJqcnVx?=
 =?utf-8?B?Q1JMZkJPb1VIMnAxb1owV21MeEhLeHBRVlBOakQ3ZmJlU3BBNnRXSUZwb2dt?=
 =?utf-8?B?cEp3WDBoUlV1K0tzdDhUWnljNFBKdHhvY01lYkRORmVJRXRydDN2TkE0QlJW?=
 =?utf-8?B?WU5LcHFSQUxoOStVZkZBcnk4Yk5tbFlscFk3dUVYOUVsWUkvbE9RY3haMXJj?=
 =?utf-8?B?RGo4TE5NUnhlamc0aWQ2a0VDZllhR2xOWkgva0YrMGEvN0dDYXFCLzFXMmI1?=
 =?utf-8?B?eVovTVgwSmhwMTE5cy9QSG1HRzdyZWthMEIyTjZRcVlybEhoRFFMUUVZSEJV?=
 =?utf-8?B?c1pMZFp1RWJ1bmZqNVhMa1ErNEQvOWFtbHROb0JhZ1pWclRPN3U2ZUFKd3Fr?=
 =?utf-8?B?T3hVeHhzemF0TnBVQm4xSnltWGI4bTMxdm5vakdTVC9TRkh0cHh2eklhS2wv?=
 =?utf-8?B?eUFocjdNc3hOUDFaUXhIcDMvT2Z0bnZmdWExNS82cnBpa3lTQ2dTRUtqNnFz?=
 =?utf-8?B?Y3Q0L04wZlFIRTNHVWFTdEJ1elYwZmQ5QnZ2ZFlzd2gwUVVMMG82ZlY2Q2Ur?=
 =?utf-8?B?U2NyNFMwQk5pclpNSHJrMEEwSjRPdjZpck5SbFkvcEJvcDQ2UmNTRHdraDZQ?=
 =?utf-8?B?d0E0YW8yWGsxU2xLdlcrdHhMTG16TTVTdFB0ZWVXeS80RkcyQVNSSDZ2OG9x?=
 =?utf-8?Q?aLc4gZHG6YJE0JV6gQ14/42X1OtLL6g2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEowK01sSVg5YitUcEswRHVFaEp5MmZZWUlqWVBJeE5na2p0ZWxDY285UVAw?=
 =?utf-8?B?K1JFM2dqQlJ1aTVTTEhaRHR1bGo1VmxIeDBqcVQ3eTFUaXdsempVem45dE5N?=
 =?utf-8?B?YldnSHFxcGt4dk9BT3NrYlUrekdGUmEyUGlrUExYMDhac0FEWmRxbVozaC9G?=
 =?utf-8?B?cElqMVc3VEVpcklucHhOM2sxcjdCdTBXL1BIdlA4d0x3V0VGYy9qcVdDRzRa?=
 =?utf-8?B?dGw2RDNuajRSYklIaktHZjN3a3dDMllrdmZGSE0wRW5zdW5CWUNubDZuai9v?=
 =?utf-8?B?Rld1WG80RXlXT1RmM0ovaDI1a29YanhWR3hIVVRRZnRVMjdPb0JhVUZCa2lH?=
 =?utf-8?B?U0NIQ09WK1FFaGlUZVBHUk9tN0JxVW5Id1ZsU2g4ZEV1dFp5eEZKQ1A5NTRv?=
 =?utf-8?B?ZFpDWU1zMzkwcjZ2aUx3VTZwN3lpRVcwRGpUNXpHazZGU2M1UGlkL1R6bzRI?=
 =?utf-8?B?QzBrOHg5b3dXN1ptakY3Z3RNc3BQckdLYk1nTlNQTWVkQjF4L0xPd01XSGJV?=
 =?utf-8?B?Ylh0RFZtUFc2SmllUGlSNlh3eGJ4T0s1VGFRZitWdnZpelIyaVYvd0QrRlY0?=
 =?utf-8?B?OVFyQ0MrOTVmQUNTRk13NUc3TUpBaFFJbjNyVXdEbXdWYWthb29za2hCdHUr?=
 =?utf-8?B?azU2M1VqMmMrMVpaQTJiR2NpK2hRL2VqalM4RVMrY3EyeHpFYWxLeFlpWmFx?=
 =?utf-8?B?SzhLaFo0ak5xV0hsQlZ2Ums3NXAyVFRqOG9aVDdDdmJyTHZsWXRUNFU4UzB1?=
 =?utf-8?B?QnI2RHN6NHRWQml3LzNrR2dwa3ZsWFRaWHhldmgwck5ZMWZ3QlRCd2pGa3d2?=
 =?utf-8?B?QzhrMEYwRkgvbE1DWnRpVFpCdUtWNlB3TUY0RyszV0JhV2RIUTRmNXJuOStn?=
 =?utf-8?B?UHB1NUN1dHpVTzlxdStFVkxBWmlaNkk3TTlzOEdPQWtXREZQbVkvNUluUHJt?=
 =?utf-8?B?bmpmNjNIbXNRYjhEb2Z4cGtWRzZwTVpVRis5S2grdWZQdldMeWw0UWxZUkt5?=
 =?utf-8?B?bE1UZFpyVUFMLzdZcGVKa0tFZEdBZ1JVTThlUVFMVjVSYURoakJiREV3RU1w?=
 =?utf-8?B?TUZtcWpScUdPK2Zka2VkeWthZ1VqcjRBcXl6TUFvaDQxNS85MHNoSXFtaVBR?=
 =?utf-8?B?by9aTmNwTE1Zdk90cHdBclV4RnpRaHVHZTlianpmVm5mbWVzYldZNmxaakJY?=
 =?utf-8?B?SUQ4SzdyRGZwUFgwUTJnaXgrMXhLVVRtOEhVbjNLa1padUFMYXVIcmp4K0I4?=
 =?utf-8?B?RUdOaEhBK0g3MVZvazdLYWpaTXJ5dlNJWjNpbTNWbFJ3ck41UlNCVUFWV0Ey?=
 =?utf-8?B?ZmNRTmUxOFRZQVhSNGlwRGhEYy90MU9oT1hha1JyL1p5UHZVdTFONlhHSjla?=
 =?utf-8?B?Mys3WTR5dVRKbVAvTm03ZTBxMlFzVjY2VkwzU1piMDVkNmpjaVRlWitTL2JD?=
 =?utf-8?B?VzdKZkxiSFBXT2d5UkV6T0lpYzVDN2g4YWZOemFDaUhXaXhEeWRsYzV6TmJ4?=
 =?utf-8?B?bGNLK2RLYlpXemRnelA0UDhkZXJXSE5TUmtlaVdsQm4vODdkTmlGOXFOenhr?=
 =?utf-8?B?U1VsZ0k0RTNDKytuM2VGam85b2xXR3lYNFhNTW1Pck4wL20wOXQwQ3RaQm1P?=
 =?utf-8?B?cXNhd0ozLzhNWUE5VTlkUjJLTmkranlvOG1OUHJhakk4WlpTZ1A1UzB5RHF0?=
 =?utf-8?B?UjJmbEJZY0IxWGQ5TjBQVWdxTHExRFVldmpCaktxWTFCYTFqckxKbXFSWTUv?=
 =?utf-8?B?UjFZVUdRdTVlaDRjTWlQRXg2LzMybWY1K1JTR2dTbHdxVStJTkFqZGovZ2tU?=
 =?utf-8?B?WWhMRG1QSEMxT1luK2dXeEF4aG9Rc3EvNjdkdXNyUXFMS09DakNKbHc3bGhF?=
 =?utf-8?B?VVYzZUN2Q1hGSmQ2TjdNSGM0T29jbnVtbWxVU1JDazV0WDVGTHJwT2ZrVitt?=
 =?utf-8?B?czJFc2o3UzgzSi9mdnFWV1Y1ZXFoVGROdy8rWEpvdXgrSkVYekk2TnBVVWhR?=
 =?utf-8?B?NG5FOWN6dUxuVFJFbEFqQjNHY1U4c3NvOUxLREJzYnNYRU5nTnZqY0ttY0J1?=
 =?utf-8?B?VE5seXc0K0RTUDNsVmJ3MG1reEVTZmk4algvVDVXYmlQR2lNTGJkd3lNYmZL?=
 =?utf-8?B?dVpybytNcjN2dGxma2R5SFl0T3dNbm1ST3dTandpT3RpK3pJL2VuVFB1L25K?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e904f1-7076-4cfc-0458-08de23766256
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 12:07:29.7965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3k+teDCoRrQ941Tpy/WX+s+LV5G7qsJg2czP/Ii1hM36YbGbaXjWAKVVeSCG3lB5v4gDb2ATlzo7Y9hGxH6WWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9588
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

The Altera system manager device is only provided for the Agilex
targets. All others were left with an uninitialized socfpga_sysmgr_base
after that refactoring, breaking any boot attempts already in SPL.

Tested only on Cyclone5 / DE0-Nano-SoC.

Fixes: 35638172f99a ("arm: socfpga: agilex5: Add new driver model for system manager in Agilex5")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/mach-socfpga/misc.c     | 7 +++++++
 arch/arm/mach-socfpga/spl_a10.c  | 1 +
 arch/arm/mach-socfpga/spl_gen5.c | 1 +
 arch/arm/mach-socfpga/spl_n5x.c  | 1 +
 arch/arm/mach-socfpga/spl_s10.c  | 1 +
 5 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 76747c2196a..f859d54dce4 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -277,6 +277,8 @@ void socfpga_get_managers_addr(void)
 void socfpga_get_sys_mgr_addr(void)
 {
 	int ret;
+#if defined(CONFIG_TARGET_SOCFPGA_AGILEX) || \
+    defined(TARGET_SOCFPGA_AGILEX7M) || defined(TARGET_SOCFPGA_AGILEX5)
 	struct udevice *dev;
 
 	ofnode node = ofnode_get_aliases_node("sysmgr");
@@ -293,6 +295,11 @@ void socfpga_get_sys_mgr_addr(void)
 	} else {
 		socfpga_sysmgr_base = (phys_addr_t)dev_read_addr(dev);
 	}
+#else
+	ret = socfpga_get_base_addr("altr,sys-mgr", &socfpga_sysmgr_base);
+	if (ret)
+		hang();
+#endif
 }
 
 phys_addr_t socfpga_get_rstmgr_addr(void)
diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
index c20376f7f8e..26828077c51 100644
--- a/arch/arm/mach-socfpga/spl_a10.c
+++ b/arch/arm/mach-socfpga/spl_a10.c
@@ -250,6 +250,7 @@ void board_init_f(ulong dummy)
 	if (spl_early_init())
 		hang();
 
+	socfpga_get_sys_mgr_addr();
 	socfpga_get_managers_addr();
 
 	dcache_disable();
diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
index df79cfe0f7f..f1c654e1566 100644
--- a/arch/arm/mach-socfpga/spl_gen5.c
+++ b/arch/arm/mach-socfpga/spl_gen5.c
@@ -72,6 +72,7 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang();
 
+	socfpga_get_sys_mgr_addr();
 	socfpga_get_managers_addr();
 
 	/*
diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index 81283ef7162..ed4e6f38b31 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -31,6 +31,7 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang();
 
+	socfpga_get_sys_mgr_addr();
 	socfpga_get_managers_addr();
 
 	/* Ensure watchdog is paused when debugging is happening */
diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index fa83ff96adc..460a6f88416 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -33,6 +33,7 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang();
 
+	socfpga_get_sys_mgr_addr();
 	socfpga_get_managers_addr();
 
 	/* Ensure watchdog is paused when debugging is happening */
-- 
2.51.0
