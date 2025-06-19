Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DA3C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 16:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE3F182CD5;
	Thu, 19 Jun 2025 18:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="yingEDgu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C81E82D66; Thu, 19 Jun 2025 18:41:59 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2C2C82CBB
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 18:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQGpeyVJcbUAIuZPlXxO0bKhVhiL/WKKdDpiFD5Cn+fY+KcwvJ9pRaCZhCJGKhrRn2aHUEs0xE309BaJEojtQWA4JUZXck7V021mw3Hs6AGQHcxZnwlP7/5LsSoTnYZwlP+TTe3k74NSFIcMRnKsv+VHvMa1urYtGlHltupK27WfXZFLhbidu4tjwnPij+FAsCuWLzWuLj9NCk1WLSt1Mp5wpO8G8M1XWfhqnxOEcno6Zd99F3/ALE/CcGHshaBJLBoHPsQgF67QdQtS6Vk0EETqF3W8XDiecN/H4uemVjzPOEmC1U1FLMnH9PWy7W38ftKe6y+XbzjpI20nXnPtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otj5WzZi1008NPp2DXzWdM0Eqw6ECykI+Goo5ktwvuM=;
 b=YjS+44e3a19GMgKAYhsZNVZGeryDG90X5H0PSERAxmwbdHpXE9qJ3jll/TPBj3W9NGQ99GQyU92RF6/W4POpDOXNYXYaqJ2ZuJE0zhvLWTNUKwP5iOESEiiM/eZ1LqBC9PqWzHwaMkNgOX5IxRmWeljErhTgteSv7tzl/sXZXC+VUPyq9XS1vquG0FIH5HnVIwvg6XY/XkhpDuWNGEN68BLVOwOaRtBtksRo9ts/zZNP4Go3MdERguzhWaM9pYgydfqxQzrGiGZuBj0NcR28wI4N20l6odf5/VvI176WkG9UEypHBOLPvbgF7aaKi5QNtpHbFl9EjnYLhhJW8c9Hjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otj5WzZi1008NPp2DXzWdM0Eqw6ECykI+Goo5ktwvuM=;
 b=yingEDguEzC99J/Ar5yKfvMa34nsk2Ol/2EzYNTYG8dg3xLVWoWHUSooW9msjfCrE4ilbWGA4aXwt95BIZW/Mk2U9UjGDcJq07J41DlNTBVPT8c12ahYtBouYCYwOb28P2wx3aECz1FuNCpQNxtKrjF+fBjVw+gPHr9+BaUdYi895L8bF3KcSZbVfQbr5r81nrtxTbRzAhOCBoDZ9LOBLyoKMbDxBNUxBBrXaX0G8xEdgNucWDR190K1aRITT7OUjYclYH55rkCFv+bZS3oxmtr86Es48+S3udeA4C3MQBogL5auglD6w3n/vkVIAXd8W3lBQdRxgJI9IDEHKDjgtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6432.eurprd08.prod.outlook.com (2603:10a6:102:154::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 16:41:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8835.023; Thu, 19 Jun 2025
 16:41:56 +0000
Message-ID: <a09b08b8-2eb1-4449-8cf3-d5d6131ee459@iopsys.eu>
Date: Thu, 19 Jun 2025 19:41:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drivers/spi/airoha_snfi_spi: dual/quad wires
 modes, dma
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250608113243.810552-1-mikhail.kshevetskiy@iopsys.eu>
 <20250611151043.1259441-1-mikhail.kshevetskiy@iopsys.eu>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20250611151043.1259441-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aff5fbe-134a-4412-75d9-08ddaf503428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHY4WW9CTXIvVUNSTEJNOURHaERaQUlCWjVWZnAwWFlDSlh6aGxwQUgxUHY2?=
 =?utf-8?B?TFh2K3Uyb2VYdGJnMmhUTTR3cGkrcllWemM3SHQ3ZEdHcnZtcHVtT1o0bkZN?=
 =?utf-8?B?aWpaTzg5Snp4YUluZHlJK2g1YWwybVdjL1I4WDIyRUhneTdsaXEraFlkazIr?=
 =?utf-8?B?ZWM5K0QzVzg0aUJRS010MHZhWFFWcmkxUG5yOW1Zc1JUbWxMV24xOGxOUFQz?=
 =?utf-8?B?d2F1R2hzNERGZWRadFRGbTY4R3RXTjJlbmpITC9zcm9WRmtpQmJ1NjdQYVFz?=
 =?utf-8?B?ZiszRXBkRlZERDZGTEYrb2owMnN1V2JoZzYwUmY2amZRVG5Zb3VoME1aQ25J?=
 =?utf-8?B?ZW9jYkdTODkwRFkxeFJBKzVHRFpQVW1Ca1lFKytDUzFKRnNDSGhaVm14VGVs?=
 =?utf-8?B?OGdlb3lVejJ0OE5vVFR2VWp4dE95Z3VTMDdOQVYyQzZCa21ZajJNMzlBRm1i?=
 =?utf-8?B?bWhMdnlCb3pVZE5TNTRrU2xpS1N2eVcwNit4RWw4bmNES0pJTWIweHNBbWtF?=
 =?utf-8?B?UXVxWTJGMmlpcnJCYjRlYjFRb0U4MWlVdnZPaElUcFpEZlk4a05VeGVEcHlL?=
 =?utf-8?B?MTIrR3IyRmVNZVNPV21CcmwvbnJHTUcxTmovOGxWVStpdm9CdW5tbDZTa1Rs?=
 =?utf-8?B?ZGpoa0dEc1NVbm9kQkZaK2p1eVJNUlVBckRRSGVkSkkxWTA2R2M4eFdHellN?=
 =?utf-8?B?eTgxV1pNUnJtZUxVUmFOZXRObHBRNUwzaVBoSzBnNnR5cUJPQ2llMy8wSC9I?=
 =?utf-8?B?Y2gyT0UxTERrNmhxUmx4OG4vV3hwUVFROWFUQktFb216aDB0cytIRUxzOWtw?=
 =?utf-8?B?S1V3bnMwd3BLcWJoZU9VV1JWOGZvMjNNS3Qxc3hMZlYzaXNQU1Q4T2FPTFpI?=
 =?utf-8?B?L0ZFZWowc3l4MWNaRHpKOFBpdTRmaisydEkrbnJMUDlJU1djc0JJL2ZROVlv?=
 =?utf-8?B?RTJFNkVWM1NrbzNCNWVvNjF3c1NDNHc4eWhXRy9Bd29lZ3BpRkpmNGEvRm1O?=
 =?utf-8?B?MVlkQjFLQkM1TkQxdEk2cGlmODdFZElnamovVzhkMThtc01tUUJUTjdiSXpk?=
 =?utf-8?B?UFJITi9kYkl6RFlvT2hoajlmZzcvMTBuQ1hlZXlmTWZVZ3V0TlJHRTRXazY0?=
 =?utf-8?B?RWZRT0NrYVRrNStiY3R3QnFYQzNMMmlTdXRsMU5rTGFNM21hYmFvVUFrR1c4?=
 =?utf-8?B?MTdsM1FtaFplS0VwK3U3MlJWN2JrcDZSOXEvcEFCVWNSMjJKMzR4MEpnTWs4?=
 =?utf-8?B?T2xHeVpJNmZzcWdueDMrQ3hPU0VVRXNXOXpyQmxXVFVzNDhjSnZqUDV5U1lB?=
 =?utf-8?B?Q2xNSGs3REJwbTZJYlNhU2dIWVl6MHhVUFBnUmEzbkxHbVh4bjB3WDdqdGpK?=
 =?utf-8?B?VGRYTUh4VDVVMlBDajVCU2VzMTRCdFpTd1JybmpnVUNWckJRZFlmZnE3MHhE?=
 =?utf-8?B?OEpVT2JjWE44Z29RQUo2RkFpVDRHQkVibU9FQkY5eFdUMHJJRnlsM2syd2Vl?=
 =?utf-8?B?QnFwNzU1TEtiR1JKK1crY0ZlcS9YSDlRSUxzRDBoMkpBSFN4VEpKbXFIVTZx?=
 =?utf-8?B?TFRhc2FLbjZxYldXcmcyRWFmcE9oN09kVTYwanAvWDd5ZzQ5czBHSDlZNURN?=
 =?utf-8?B?YzdzenpQMjNFOUlicW9ScGxmTTJZa3k0SHRRUmtOcXNuNEQwM29lZ1YvbnEz?=
 =?utf-8?B?Qm9yZ05yVldRajFvU0lUM21XMngzdHk2a3NRdG1Ib0xKdmtTK01yTDZkNXJq?=
 =?utf-8?B?NCtmOElyNmhBdGhUa2xUSmdDRTZadG0zYzRKdERQNyswUDVlejdsdStRZWxh?=
 =?utf-8?B?SXdvZzRkb3hnN09uMlZEeUJHK00xZnhlcVJvSktsSG9GRkdTVUZaWXpKeTNk?=
 =?utf-8?B?eDNPT1ZQK2pwY3J0OFpiaW04RWFITG1QVXd5T0tFVmVTMHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0ZsVSs1R0VQMlcvL1dGMnVxbWpWMjk3RHN1WUF2VmMzWUtFVGRuSTNQTjd0?=
 =?utf-8?B?RFBqTUZ2UWk1d2pvSDdHT1NEV1VXQXJ5TXFMYmxBMUdJZ0ZzdmZ6OTNhdlVD?=
 =?utf-8?B?aXhaZzV0ZVFyUmpoNjl6bkZuSmNWaGd4VTN5QjI5bjdPN2t4Wk9haDRkLzl4?=
 =?utf-8?B?VmsvM3RuNE5VWEwyMHdQV0RwU0JCMDNKck1PQURyM2NiWFdUZUFBU3hLTE9Q?=
 =?utf-8?B?akIvR3dBa245c0NqcTQvMTMzWTJBV0xqR0dsMWNGUjFOWWE5eVR1Q21GWGJZ?=
 =?utf-8?B?cXdVSVdsaXRZMWw3S0FhL0pJUFRTTjhBcjllblJ2YnpiKyswZkpiYzU2c04z?=
 =?utf-8?B?QWhEOU5NNWNVTnpUWG9nMHB3dXdkUDMreVBLRmlTSDZlWC9KNFNIa2E2cHpP?=
 =?utf-8?B?cTkyN3pubEVISHQ3ZDdVOTdxcHdxeDJDQ0JGWGxGRDhyM3B5Qmo0VUhOQmlh?=
 =?utf-8?B?S25IUzlPRFlPL3lJbDhvaDZ2UUhSbldsNk0vRTd4bWtOWGRxWURTNFIzb0h5?=
 =?utf-8?B?c3FOL3VtSFFFMzdzYXVMVXhBVjIySGNqaHdCRzRXcFk1NDkxcy8wSjZpbUxi?=
 =?utf-8?B?OTViR1Jqa05ya2kzY05TeGdKeVlrbEYrbzJlQktPQ3pTN1MzOUlpcVZoSjNF?=
 =?utf-8?B?ajYxUG05RUUyQldVS0J3S2FYUE9pYUxKVDRUejZxL2dubk1RdDVUODNYMzI5?=
 =?utf-8?B?RkpHYXpBTDIyNjVoWnY1UXA5cGJkdWJsc2k4YlNpNFZ6cFMwTmJHV2s0NW9l?=
 =?utf-8?B?SDNlcjBSaGpnWXRjclc1dG5obTdGTUNiZjNSY3QySm9MQ2lGZEdnSjdCWDNN?=
 =?utf-8?B?QnpGN2FvLy9ZMldDdWI3NUJ4NmR0NW5lMXprWG5Yb01EblR4RDhnb25mcTdR?=
 =?utf-8?B?UzB4OFJNV3Q2UWFqSXNQOU1NMmF4a2FNYlphQk16WmJBNWFzaGFwMTk3YnhG?=
 =?utf-8?B?SnJDVGFpRkptN2lZekZWSVljYTZZa1JtZkx4dVg3QXBwOVhhMW15QlVmNk5M?=
 =?utf-8?B?ck5QNzVocHhlY2VscjFHZ20xM0cveHgrdDM1eXBweEtObzFjQWFRSFRZblRy?=
 =?utf-8?B?cG55TTF6aXo4SmRJdEx0UENiTGhOV1M1ZGhuc0ZjRFUvREgzVHMwNTB4aXpt?=
 =?utf-8?B?eWxqOVpGZnFoVFBWc0ZYbkkyK2s2MS9yVWV1Mkw2d05uTGNlMnBycG1oY29C?=
 =?utf-8?B?a3RmanovWXRRWWYxdkxoUWlBOHlKWGV3TUJtTUhFTUk3LzJWL2JBdkp1Wkdm?=
 =?utf-8?B?Qk0ycFJlUklsN205Y0VSeXNUWUF6d2VTQnI3VzBCMWgxN3VTTTgwM0g1UGdh?=
 =?utf-8?B?RkcySE56U1lBOGdBZ3lEbmRPeDZibXhSdWtvVGYyamtxV1lycmJQVVNMU21K?=
 =?utf-8?B?WmlMNzR2aHdWWm9jK0FVWmRZS3lraStKQmZYSUovS3hkQThlZUpBa1FPUStw?=
 =?utf-8?B?VDBscVFmNU5ubk1OUHJBV0UrZUszT3VvSVYrQ1NtaHBoYlJuUkcxOXF4MXdQ?=
 =?utf-8?B?SEcvdGx0SlY1ZVI0MVZWMHdjN2V1ZzB5a0tiNHRVT2p4aHNENkFpNXY4eGIz?=
 =?utf-8?B?VmlRU3V2U0R1NnQvVXlyU0pxRU8rMjJtWFhSQTViQ3phNC9oZ0Uxeno5NW5P?=
 =?utf-8?B?SnQxUFppeHh2N1hKOHhOMkNjV3dDZzlpR0FmUXkvanVUZWZ5UnhJUWZhWmRi?=
 =?utf-8?B?T2J2ekVPZytpV2dleVhXeEwyQmI3RjY5VTQrSHpKZTZaZDZyVjBoY2FWeFJR?=
 =?utf-8?B?N0kvTHNEcUJzdGtjSkFkdHV2cXA5N0FETngvd2NKdWtHN1h1MmtTL3dUTEoz?=
 =?utf-8?B?aGhHWlJCRmlkYWNTaDFqeWoxNEMzQWJzZjEvbERzQW1yakJhS0lSWmREV3dr?=
 =?utf-8?B?QVpldHFwbnZQMFUxcWJkRk1qR0xJb3FQckI2Q1R0djRKWnBVakYvU2haYnlm?=
 =?utf-8?B?U1ZCOHk0eUpWUVRFZy9pVjQyOEMxa1F0dE5kN1NjdGhxMjZNMkNqeVRoVG54?=
 =?utf-8?B?QksxbFRVcEV4V3F0TUk3cFdnSHF1YUpXS3Q3ejRNUGZHOGhPaFJmUkxYekV2?=
 =?utf-8?B?VjRQTm1zcmViMXV2aVVKMmRCQy9YVkJzaktScit4SHlHV2NmMUJmNE16ZnU0?=
 =?utf-8?B?Wk1UMFovVWpXejV3L2xUNmMvNXVTeWg5N0FQTmVhc3ExL2JOY0JvZUVBeTlL?=
 =?utf-8?Q?0r3JZ6u2YpebkAHoqPqqDA4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aff5fbe-134a-4412-75d9-08ddaf503428
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 16:41:56.5648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Celxc3+OQtsgkZeuf0m+J61o4YFUdaKPhqV14TTmJWIg6f2JtkuP19yJbCRsTt6z85I9eeF33Y8+MjDcVY2rCowQcgMXQtit5dZFyebHG4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6432
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

Christian, is there any news?

On 11.06.2025 18:10, Mikhail Kshevetskiy wrote:
> This patch series adds
>  * Support of 2-wire and 4-wire spi modes. It speeds up flash read/write
>    by 2 (or 4) times on the corresponding hardware.
>  * Support of DMA for spi-nand cache reading/writing/updating. It speeds
>    up flash read/write very much.
>
> Only 2-wire mode has been tested so far. It works fine with en7523/an7581
> chips.
>
> UBI attaching
> -------------
> before: 17 sec
> after:  2.5 sec
>
> reading of 0x1000000 bytes
> --------------------------
> before: 17 sec
> after: 2 sec
>
> Changes v2:
>  * dma support was added
>
> Mikhail Kshevetskiy (3):
>   drivers/spi/airoha_snfi_spi: remove unnecessary operation
>     adjust_op_size
>   drivers/spi/airoha_snfi_spi: add support of dual/quad wires spi modes
>   drivers/spi/airoha_snfi_spi: add dma support
>
>  drivers/spi/airoha_snfi_spi.c | 634 ++++++++++++++++++++++++++++++++--
>  1 file changed, 596 insertions(+), 38 deletions(-)
>
