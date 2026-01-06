Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9BBCDC196
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 13:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECAE783F54;
	Tue,  6 Jan 2026 14:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=metanoia-comm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=metanoiacomm.onmicrosoft.com header.i=@metanoiacomm.onmicrosoft.com header.b="CKv3i34t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E314C83EDF; Tue,  6 Jan 2026 06:18:04 +0100 (CET)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DEBF83A57
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 06:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=metanoia-comm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jun.chang@metanoia-comm.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIoBsyxPgLSBiiGKIAfMfM32vrqKc8sv64hwmAkuWlYC6QseLdWVKMFGBjeSAZMbi57IqXEQM7n4CUuWTVH7wBL/m0A1XbdXx315r/0RoqyNvbYA9L1nZb/TZwklw+6090iKVXPvjTn9uCuvkeu3QZneNBs9D9eFLu93T3vGLc8GTrH+DzRE9/TDqUiX43vdEaaCnj+9vbY7Ka1H7MHDXCb8Oq2iBieHr06Erapdf3Je4LrKEWvM1cpAL9C2KcnzbygVg4ZT6gOLt4bJolAJZXKx6juWhySXsj/0jIVSGBF4pnVMh/Vw2VfxZ/YbEX5y9jgqjLwd78hfQHK2+j7F8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BpG2YuER23sEB9+OAHEOLjSsCK6HjuV8ZoVb3eHXOs=;
 b=upc4JoHuBUifTKnAy3NE2w38n61GEYod1PcbGBXf0D1CO/G2QEF3y/3aErOfi1eRTteYatoYkKy//rWezub3zzgYkX+z0NlPfO6LQukoAPbCruVmC2azVbJvyldYqOh5+ZjFlI4JKgv2TX4pbHiYw/vP7H1T/X9jrNs7Sl9NsQSqrjYUunDuub6aslkIHQlUdKfJrc+5m+nV5EtmkB6N0ayRzOEWWBPzao3LYxaDqWpQky1uHKVdDurQTKG44iLgfdRvznCJdy04tS1sK7YfqnwuhhLfjYdxaz469ndil52j3Xy2NtnRVvUQ6xVrLnk8tIOK4Jndop+hUvqfD5Wg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=metanoia-comm.com; dmarc=pass action=none
 header.from=metanoia-comm.com; dkim=pass header.d=metanoia-comm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=metanoiacomm.onmicrosoft.com; s=selector1-metanoiacomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BpG2YuER23sEB9+OAHEOLjSsCK6HjuV8ZoVb3eHXOs=;
 b=CKv3i34t5IIhf5fY4BX31NdigLoPBHSBLuMtBn5kjUqSE8AlM1QWa4r6GVDPbnf4sHO3sPVC+yD2KpKaqixkUTeG9lPkSkQoBd5VxOGkJZ+kbvYFtDPwAZl3S98wZt7fm9skIdF4n/Q+0bAcH0q26wo1iq8AedXvsszQOG4iAPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=metanoia-comm.com;
Received: from TYSPR06MB7207.apcprd06.prod.outlook.com (2603:1096:405:8f::6)
 by SEYPR06MB8089.apcprd06.prod.outlook.com (2603:1096:101:2d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 05:17:58 +0000
Received: from TYSPR06MB7207.apcprd06.prod.outlook.com
 ([fe80::94f8:90c4:2339:9639]) by TYSPR06MB7207.apcprd06.prod.outlook.com
 ([fe80::94f8:90c4:2339:9639%2]) with mapi id 15.20.9478.005; Tue, 6 Jan 2026
 05:17:58 +0000
Message-ID: <1da0a28e-1d25-4424-92d7-f032cc0aec8f@metanoia-comm.com>
Date: Tue, 6 Jan 2026 13:17:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] board: mt5824: Add initial support for Metanoia
 MT5824 EVB
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
References: <20251230030328.215240-1-jun.chang@metanoia-comm.com>
 <20251230030328.215240-2-jun.chang@metanoia-comm.com>
 <20251230153115.GR710860@bill-the-cat>
 <e4a70eae-37fd-4648-bb17-66975c6d09af@metanoia-comm.com>
 <20251231143404.GX710860@bill-the-cat>
 <c3d448db-54ce-482a-9d34-47395e415881@metanoia-comm.com>
 <20260105141546.GJ6124@bill-the-cat>
Content-Language: en-US
From: Jun Chang <jun.chang@metanoia-comm.com>
In-Reply-To: <20260105141546.GJ6124@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0017.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::9)
 To TYSPR06MB7207.apcprd06.prod.outlook.com
 (2603:1096:405:8f::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB7207:EE_|SEYPR06MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: fa34800a-369d-4dfd-1f47-08de4ce2f468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXMvdkwzOVBZdU9tY2crYy94akJCYUE3VGFTQU8wcnB3UC9uNUpsdXZ0UnNv?=
 =?utf-8?B?YmpDa2NnS3BuSWw4cy8zbFIvQm5NNVNRK1p4T0lxRGsyUVlsL2s2aExvSnI5?=
 =?utf-8?B?OWNIeUxQcUNFdThDKys0TjZoWGw5TDl5dXpqUDI1N09BNzBpTHI0ZGFLUjBl?=
 =?utf-8?B?L2QwNEt1VVBLKytDSURlMy9HV0hFUFdDSHh0aUVLQU5yRlJ3b2pBamZIZFN4?=
 =?utf-8?B?QkFXU3JPb2tzOW1NUnY4RTFLamFWVytlWVNMSXBEL3l1WnZ5a3ZuL3dFd2xQ?=
 =?utf-8?B?ZllzV3dCQmc0eWJBV3ZPMG55clRKeGc0SFQ1aktkYjhvbmwvZk1LT0V1N0tx?=
 =?utf-8?B?djRDekNhSmN3aEJiRmR2NlcvTHRHbStwanhZVG9ocWoxai94RWRZSkVrSzhx?=
 =?utf-8?B?MVIyM2VOWGc2L25GM0RrdzlpMzBSNW00SGFQV2tXWWo2eEgwRGVCRE9ZbTk5?=
 =?utf-8?B?VmlMRDlaZXlaRnE4OVl2MVhROVJFZE5LWDJoWExCaE5BV2JRVWpvdkFEbnAz?=
 =?utf-8?B?QUswdk80NXpOcjVVN0IwSXdDU1VsMkJjeXR2aXY3ZEJBcko4WXYvYm9LWGts?=
 =?utf-8?B?ckxWVllwcS9LUzRscnViSUFOK1YwNTZOWkJrRzltSzlzbTFQbG9IOG0rNUZG?=
 =?utf-8?B?WlJqRVVWY0QwRGtnejZFbHNPejZQbnYva3FBZEJ2Z1VVWHVEa3BXdXRkczg1?=
 =?utf-8?B?dEcreXVQbDV2d1VoUXdhNGh5YmNJa3ZWbXFBOC9HODh2SW5QTjRBRkFiUDNt?=
 =?utf-8?B?NlhhZHpLdG0xbWIydkdoVmdGV2x0VWQxUXpKZjA3OStqdnNYV2YwdnNmcExN?=
 =?utf-8?B?ckV6ZjdXMndGaWM3OU11ZURTckFienBMQWFkTnJ3NXpnYzZlTFE3OGIyb2tK?=
 =?utf-8?B?K3JaWWRtY1VMZ3lWcmFSMjhpMGlCdGJBbitQWlFKQmN3bDdHcEpxQkxWWUhP?=
 =?utf-8?B?eXY1OXY4aCsxOFVUWUZmT1Joa0Y2UEMzVW4wakp3eTJ5aUQ1UzB6L09UNVV2?=
 =?utf-8?B?Uk0ydlpzTGgzenQwcG9wSWZLR1VPcTJaNklRZHpVTS9IdUFLczdtWloxdGw2?=
 =?utf-8?B?WlhIWWx4dVN1QXlQVlUrTGxhM3piVEYrbzR2dStTVVhIWnNPYlB5T2tZQ2g0?=
 =?utf-8?B?aW5SQXI0c3R3aXBxWTllOEM3WjN5clhIc3FOSE5heEF6aXVJN2gyUlI1WmF3?=
 =?utf-8?B?Y2xORS9CdUczNlhhUHRqbkNqU3ZObkpza2M0bkJzOExLcytTRVZ6QW5hajJ2?=
 =?utf-8?B?aVZzRWdJbVRYR1VDMThzcjk5SXVxUWtnK2duWmZoa3RzM2oxTkRNTmliQ0RY?=
 =?utf-8?B?STlEM0Q5cDMwbFpiditsSk4wVWx5VmRNcGtoMXFjN1RkRE9qakRmek0zSnZr?=
 =?utf-8?B?V2cwTXkvb3pBMXdDRm92ZWp4MkdlZmJod25mNGZpcUc4YXJZN3grcjJ4NlJB?=
 =?utf-8?B?MWhkc2pUL0Z6K25Yb2FIN3RxZk1pNnB3bEFrTDdvekJ6aGpSYStZM1UrOXB4?=
 =?utf-8?B?UnRUdlZtWHRReEdIOEtlVXVpY0U1dm44RHd0SC9YbmJ3K1lmdDNUM0hNSkVh?=
 =?utf-8?B?Y2pycWRWUXgwRkVxUGZqNjM5WVZjWStBaWFzR1BHYUdzR1NFNlFjMUtMeS9I?=
 =?utf-8?B?YUR5SFZEMTFIY1dXZG5XZFJJTnZIUDFzOHZ2dks5WmNuNmYyenpGUGxBem9M?=
 =?utf-8?B?SG9GZzVRUlllN0U5K3labnRUNFdYN3B4VXVudmZvb3hsb3pZNko5OHROUDl3?=
 =?utf-8?B?RWJ4M0F2R2ZkZEN2c09VMko4SHd0TGVCalpUSXVXRWhhU0VvMVZYQUpiQzho?=
 =?utf-8?B?VkFiSlFtNGJmZkhkeHE3TFVFbGRoQU8wRTkyNVpON052cjV5Z045U1NPV2Zi?=
 =?utf-8?B?UnVxN2h4Y0lBakU1UDZVaE1QalZCcStSOUQrVkpSRDRoMkVJd3dibEtDNklK?=
 =?utf-8?Q?7LcZHgi9qnMlC/1PulIbvHgK//A9OQPB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYSPR06MB7207.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGtuMjVzRzFJaGNYejBPdWZWdVBBd3o4Ni9IZnZENHpiQ3N3MVFUbVdGem9Y?=
 =?utf-8?B?RksybHptLzhqcXJmZlBSNVZkd2xLK2V5TUN3OGFqSlZoNzJHcWRRSE02QjNm?=
 =?utf-8?B?cjI5QmNHeU4vWUR6ZEFzNisrYTlEaUlseHRsVWE4ek5rOUR2RHdFc1VHL0l1?=
 =?utf-8?B?VFpJWkc2Z2FLNk4ybDU5TFpNRkppSG9BL1lSSjJIWFplWG83amRDVnJNUXZT?=
 =?utf-8?B?R0FVZlFjMjlobjRsNXp0WGtoSHlHb3VKSTVqTjZ1d3Y1c1V3RlZkVWlJTkVO?=
 =?utf-8?B?WCtUdmJuZTdnZ1UrWlQ3SGNkMjU1OFRhZHVNQjdpT0RqNmdSd3htV1hmWHpM?=
 =?utf-8?B?N2NRSkh1UFVQdE5LZ3ppdU9LbTF5UUpxL0dSampRMVMvOEhZTzlEWE9lWlpj?=
 =?utf-8?B?S0hHNlJXQTFwV25lVE9WQ0k0QjJNdmt4ZWtJQlhiRjZPSThlUkYrUDVORWhC?=
 =?utf-8?B?RHlOeTQ4WlpRWkxudWdkSmQ0WGh5bjB1MUxjbks1cDY0bkxybVBEOFJBTDYw?=
 =?utf-8?B?NjcyM2FaanJSTTh4UGY5REZXWkFpRC81NU1FejI5dHgrMWxEbzFESTU5TEdV?=
 =?utf-8?B?NEI5TzFHL3paNGYzWldMbk1jZW05NklmdWpydEtWN0pIQUhlQ21jcGQxTFFZ?=
 =?utf-8?B?ZktMeGZIdWpCdWU0UTJpRmtGbG5FaDc0TUNkR3JkYmgyYlpkVlk1elRyVi9v?=
 =?utf-8?B?OUwxQUYwVTJVTnlibEcrenJUQVBJTDV0SW9sK1AybHNRS2M5cmpZUFhmRWlk?=
 =?utf-8?B?SkVMcnZjMFdFTUdZVm50QWsyQnI5Z2xMYkxPZDRMdjRWRld0QnVNd2h1NTNl?=
 =?utf-8?B?TFN1SjNibHJNUk5wRTdkUDh0TE5idWsyR01mdlRENEd2N0YvdFFPdFVzcEJl?=
 =?utf-8?B?VEdNekg5U1hvMHMzc0RhUDloYmFzUEFDTkhhZHRTRVdMYzVjRy9EZVNjeVQx?=
 =?utf-8?B?d1JtL2Q1NlBLUS96cWRxbWNRZ2VBTFJxbG9UcXhGWC9hZHBxNHZJd1E3Y3BK?=
 =?utf-8?B?TXdpcE1vMGRPakZvR24zOXVEK0hTTDZVUG90ZDBTS1RTQ0kwaU9xM3Q3MUlU?=
 =?utf-8?B?MktMdjFYUTZ0YldxYnVZbml3NkJZZmY1TVN5OC80Wk84R3RxSGZJL3ExN2Vi?=
 =?utf-8?B?ZmFrb1lpU2VRdUo4K1FpVWFWQ3JTY09aK2xaSCtkNnRVV0pOcHBwUE1jTDU4?=
 =?utf-8?B?QXQwQmFSd1lmUVhaVWQ1SDdla05EQWhudkluTDg0d3ZhWlYxRE1PemdCampS?=
 =?utf-8?B?OC84K0dQMHdBYTVRQjJTTkQxbEhvVlViVkN6M21QbDh2UXFkcXkzQTBYalhV?=
 =?utf-8?B?RVpDR3F3TTBiY20zWWkrNU94OG5CVFZodWd1QW45Q1Z3MEpxcFF4UCtaN2hP?=
 =?utf-8?B?MUZmalBoSkJmMkJLZzBza21YcXFVc01JbnZwY2pUeWVGMnJRMGV3NkZ1bHl1?=
 =?utf-8?B?SFJoSDE1VFNaMUJTRTBNSWNlWjdPMldadFdsTXdJR0xHVmNZcm0wMUxRK2dt?=
 =?utf-8?B?dWFoaW5ndHhLN1JPV2ZuRFo3QTNwbXNsM2pTVEdwQTZLVHNMSHQ3RWhoOFFU?=
 =?utf-8?B?UXREcHkwQWRIaXdxYW1ZWk1WYmRaZDlOQVFQTHpidjdxcmhRUVhOTk9Dc01q?=
 =?utf-8?B?QzlmdDRHOG5iZVdTQnNhOTN1MEtXYkh2bGFqSWxZSmVpcVc4MldGSTU3WUhq?=
 =?utf-8?B?Q3kwTG1yVElZTm1aR3JXdHpBVXNwN3BEcjNESlVQeEEzUUswYWtlUEs5dEth?=
 =?utf-8?B?a2daUWtRUjFDS1k1cDNkTlB0N1B6d081c0d5QmtENHBYZ0Uzc3hPdC8zZmMv?=
 =?utf-8?B?eUR4UXdwWWg3Zldwbm5xTFNwbzhUTjdHbjdtbDB4TnYranZBblVUaUhlQ1VO?=
 =?utf-8?B?RHcxd0pmUHlubXV6MDQyVlphb0JROWZEYlRmZlNsNDFIbmlOK1ZEb096NFds?=
 =?utf-8?B?eWFIMVNqbHA3aUZsdU1oZnVndkpDaXNFNlpkVnhwNUI2cUR5RTk4aFZ0WEta?=
 =?utf-8?B?S2ZWWmJMMzBlTlVaalpYUjBVbGlqanIvQnhkY3p3ZERCbmdDd1FhQjRGY0FQ?=
 =?utf-8?B?NldveUs5cFhIdEhLS08vME5EU2ZoQnJPRUgyMmF3ZTdvaVRVakhNa1JHeVZE?=
 =?utf-8?B?MVBaNVYxQXFsSXdsTkxNejN1ZlpyMGxiZGc1ZmtWWmliZk1RSmorUmNWaWc3?=
 =?utf-8?B?NkJmVnBxakh1NThXVmZTVlk4TjBUWVptV1pGVE9xZ3Ztd09Td0ZnVWpqK1px?=
 =?utf-8?B?UlY3aXZ4TFNnWk1yOFJvZmZ5SGh2R3RTUU9VeWt0elpWTXlPUGJ2cnZTeWNK?=
 =?utf-8?B?Vm54dm5XME5QKzBIb3NjYkU0bzlYQVhnL2o4d251OENoMnFYSWVwV2NBWlFl?=
 =?utf-8?Q?nfgznTUdHNlaQ8Jk=3D?=
X-OriginatorOrg: metanoia-comm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa34800a-369d-4dfd-1f47-08de4ce2f468
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7207.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 05:17:58.1548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31a25295-9a4d-4cf7-b9ce-e250507bb0c3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4ihpnGsDtP/u+TRtf3Sc9xmcmyhtAtCW33V+ATMH9D87kw6Ung4h/4D0RfhZUF9zzBti4kwzq1SvUIZSgX5sqYzB+ZJRooVPH3wq9nnuow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8089
X-Mailman-Approved-At: Tue, 06 Jan 2026 14:02:03 +0100
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

On 1/5/2026 10:15 PM, Tom Rini wrote:
> On Mon, Jan 05, 2026 at 07:39:44PM +0800, Jun Chang wrote:
>> On 12/31/2025 10:34 PM, Tom Rini wrote:
>>> On Wed, Dec 31, 2025 at 02:32:45PM +0800, Jun Chang wrote:
>>>> On 12/30/2025 11:31 PM, Tom Rini wrote:
>>>>> On Tue, Dec 30, 2025 at 11:03:28AM +0800, Jun Chang wrote:
>>>>>
>>>>>> - Add RISC-V target for MT5824
>>>>>> - Add board defconfig and DTS for MT5824 EVB
>>>>>> - Add SPL and U-Boot board support for MT5824 EVB
>>>>>> - Add DDR init for MT5824 EVB
>>>>>>
>>>>>> Signed-off-by: Jun Chang <jun.chang@metanoia-comm.com>
>>>>>> ---
>>>>>>  arch/riscv/Kconfig                    |   4 +
>>>>>>  arch/riscv/dts/mt5824-evb.dts         | 232 +++++++++++++++++
>>>>>
>>>>> What is the status on upstreaming this device tree?
>>>>
>>>> The device tree is able to boot to U-Boot with shell prompt by the JTAG.
>>>
>>> Since I wasn't clear enough, I meant the status on getting this in the
>>> linux kernel tree so that OF_UPSTREAM can be enabled and we use the copy
>>> found under dts/upstream/src/riscv instead.
>>>
>>
>> Thanks for the clarification.
>>
>> The device tree for Linux kernel is not yet submitted to the upstream.
>> We would like to go with the U-Boot first.
> 
> It will need to be migrated over to OF_UPSTREAM and really should not
> just say in U-Boot only. Have you at least started the process
> internally and for example run "make CHECK_DTBS=1" in the kernel on this
> to catch obvious problems?
> 

We will send a full functional and verified device tree to the U-Boot in the next patch.
When our device tree patch be accepted by Linux kernel, it will be migrated over to OF_UPSTREAM.
