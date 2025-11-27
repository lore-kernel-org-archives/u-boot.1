Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937A5D11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 09:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07C3F8432D;
	Thu, 27 Nov 2025 10:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=SocionextGlobal.onmicrosoft.com header.i=@SocionextGlobal.onmicrosoft.com header.b="PioEFIHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A41EE84347; Thu, 27 Nov 2025 10:17:51 +0100 (CET)
Received: from ps83.spcmail.jp (ps83.spcmail.jp [35.75.198.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE9E8431E
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 10:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kojima.masahisa@socionext.com
Received: from ip-10-10-28-85.ap-northeast-1.compute.internal (localhost
 [127.0.0.1])
 by ncs81.cs.local (8.18.1/8.17.2) with SMTP id 5AR9HkLj1362525;
 Thu, 27 Nov 2025 18:17:46 +0900
Received: from ip-10-10-32-82.ap-northeast-1.compute.internal (localhost
 [127.0.0.1])
 by nmg83.cs.local (Postfix) with SMTP id 4dH9nQ18NKzMpqqp;
 Thu, 27 Nov 2025 18:17:46 +0900 (JST)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011041.outbound.protection.outlook.com [40.107.74.41])
 by npr81.cs.local (Postfix) with ESMTPS id 4dH9nB1yQzz3jcDV;
 Thu, 27 Nov 2025 18:17:34 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gd7h/Rc0DfayHHSLYolTxvC/CUdgUtqJgY61wL/3xE8IP5db+8JuCZXOZYDoaYoW1dG74WKdysMSjQelLef905hcK6Pi6oEOq3Kl4lOc9ANbnNmB+syQ03ZsbyrDEqsOf/3YbTYkoC1+M4H4D5KYFJdBJcnmTS2guPUpIQWgKwxGpruTRHkPgq4QFJ1zGDljQChJsk21NVBH+TSXaGgk9rt09yRygcTAYV4a3B0KPmTH40uTr6BGLyCCbiJeVEvEc5C0YRG8qVjklsfeHfFOT8vBrjLXu2QZr/g2PwtpTSr2AOX0JS1NLc1Xk/NFlq/lLXWH22lJ/O3HBns/4nsZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpfuufaVCDR5JtGVwSgGRNVKoNXoiaUkLvJIYF5tYpE=;
 b=l10j7suHOFVPZ5s9wY5TGlNioXIjHWKYdV41XMo9okotJMAFkzK9FvT2ZnRfJReDr+3X0sFLM2GRFxqqsdvBBRVQ1m4f92asnVv1tLlrKEgYyksHNib1uusxNATeAQgCujxXL4J+YtHSPu8GZ14dBAdE/ntcFpI6YPaxuFndqH1HEoBZct1kZrI1srSLPP6/VFSNK5uHv/Upk8Ex3YbJU/O5VkvmXTwnupzLvDNZP6VWbx1KoS50fUUA+C5DXL3MgtwaVw+hcczDa1+iD33DmVorxBDqSODxOcO1JvOnUGTB3S/8FTJ4DWiPbWXTAwn90Y0Z8TmSV4wHI8ZYaRj0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=socionext.com; dmarc=pass action=none
 header.from=socionext.com; dkim=pass header.d=socionext.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SocionextGlobal.onmicrosoft.com;
 s=selector1-SocionextGlobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpfuufaVCDR5JtGVwSgGRNVKoNXoiaUkLvJIYF5tYpE=;
 b=PioEFIHsmudb48UWLVkY48l/nkMFdmnxC0zUfg7GvtzPGyNbSM5JldwQc7Fm+C40JVI1pQ3N66fE/AyfT0cjFBmTNa/a5y8AZR1wa6vO4j5nZ+qGGMrqBZaz7tLGUvmtpKJtMnKLTL/JNCj+C2Q96NA9gDinh48VqLGD2nF+tP0=
Received: from TYCP286MB2472.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::8)
 by OS3P286MB3307.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 09:17:32 +0000
Received: from TYCP286MB2472.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e544:c921:e0d9:5b4d]) by TYCP286MB2472.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e544:c921:e0d9:5b4d%3]) with mapi id 15.20.9320.013; Thu, 27 Nov 2025
 09:17:32 +0000
From: <kojima.masahisa@socionext.com>
Subject: RE: [PATCH] bootm: fix boot failure from compressed image for
 IH_OS_EFI
Thread-Topic: [PATCH] bootm: fix boot failure from compressed image for
 IH_OS_EFI
Thread-Index: AQHcWsKjUhHjG3Yy9EagI2hYvVJ5vbUGRpUQ
Date: Thu, 27 Nov 2025 09:17:32 +0000
Message-ID: <TYCP286MB24729B7890D0BA9B6B77FCF3E3DFA@TYCP286MB2472.JPNP286.PROD.OUTLOOK.COM>
References: <20251120233851.2726487-1-kojima.masahisa@socionext.com>
 <b60d74a5-8085-4c6a-ad90-bf59dc41e37f@gmx.de>
In-Reply-To: <b60d74a5-8085-4c6a-ad90-bf59dc41e37f@gmx.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ccmail7: Relayed
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=socionext.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCP286MB2472:EE_|OS3P286MB3307:EE_
x-ms-office365-filtering-correlation-id: d40d819b-afe2-4b76-06c7-08de2d95cbb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|1580799027|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WjFLMFpNc2lHeGFNeURZS3dnQ0RTanZxSzRQRVA1eDR1U0E1QkcxMzVNTklo?=
 =?utf-8?B?dkRzaXRySExDdDVHdkpMMmN2bFE1VHpmVlBCR2RQSmxpN1Y1VHovSWhzTjFL?=
 =?utf-8?B?dFhISDFaTzVHTFJKWWJRTzNCbUdmTlpGQ3JoZldZWTc5MmMvbjU4S0lRZGZi?=
 =?utf-8?B?SUdCWHJVNFhLNEF4bFZRU3dWRjgzNkw1b3FVWDYyaVViVC85bDM4ZVl6OU0r?=
 =?utf-8?B?aDg4bXhTM2ZCL0NSbXBud080alBEWUFGTGg4MXNvY0EvNWN6amk0OWU5U0du?=
 =?utf-8?B?MlNacENwYUFYNFhMSndoWGU5a2tyUDhMYk1QWG9EU3kzMURrN1JnblJiY1p4?=
 =?utf-8?B?cEhUMXlveWZMaDJBdjdsS3ZLSENYRmIwbU1sdStMMk5Sd0JwS1lPY3FGaDZW?=
 =?utf-8?B?aUFVcy9raUZiQlppZHZFWlpXaVMxRy8xUjh1R213VlM2NS9ZZGtyRWhxSlpF?=
 =?utf-8?B?M1dQY0Zpc1RweGZsNDdoMzlESE1NTTJWR3FBbUhWY2diWG5peHdTMWcvZGVZ?=
 =?utf-8?B?VDY1OE5RRXluckFxYmNmS0JxZGE1cE1IT0dwTkhiWEJqdUhJZ0YxZFRDc0d4?=
 =?utf-8?B?NWh2cFBuRUo1bExwUUprNEhOL3V3ck1WazFESVphZWdNcFlsZ2NGT3REdEhZ?=
 =?utf-8?B?eGN6a0w5Q0w1cS9VZ2M0YVBFWHZSOVdqS1BMM3FxSzR4R3FCOW1RdXdqd0pr?=
 =?utf-8?B?eDBkT2xmay8vNll0V2cza0phWVF2WWZrSml3bHQ0aG9ia0RDNzN5UkdJblBO?=
 =?utf-8?B?VzE1RzdxSWgybVQyOHhxNHJUSDZacDJWVTUweThsOXNzTFhFRUdwUkFpVVJZ?=
 =?utf-8?B?dEVIOVlTeHFudGxtdml5dFlBMHR4ZzlNaEtTQ1pJa1M1VkppTE1yOHpUOXhY?=
 =?utf-8?B?OHlOU3l3aVd0cTNBYlJmSHRFUlY1YjhBUjBZdnFvNXpxNHdDOGg0bklFOFM5?=
 =?utf-8?B?Y3VyenQyOGt1bXJmTUp2alA3Q3luM2RJUHRNVlFHUm5aQzZydk90RXB2dUtK?=
 =?utf-8?B?S1RaWTdyclVCc212Z0tsWm9mbmNjbWE0emNNN0J6ZEIrUHFJdTBUa203Yldm?=
 =?utf-8?B?NklVMzM1OXFGeU94Rk8zU1pyNUFzT1I4dTUwL2ZoeGdITVVYWFJyMllUblpk?=
 =?utf-8?B?WTZLaUdPMUJ5YmtDZ2UrSHhVVmMyUkZPTlBiMW5TQXVidnE1U05HSkh5UmtT?=
 =?utf-8?B?ck1BRXlEalBBaWZGR2dxeVdpYWFIY2VZb1JvYnhodHR3S05kTWk0Nm9HSDRt?=
 =?utf-8?B?NmtqMHEyc1lPSmpqeGhCZlVtMU5YMjU5dit6L3lBQWpBWVFxYVNFUS93MllR?=
 =?utf-8?B?VHBQRStjTllhUVhaeWtuUmIzaW8vL25JbWhLa0FOMjFqWFRKQm85bWpVKzcx?=
 =?utf-8?B?SUR3Y3k2YWUwVHltQ1pkZVA4WURwTXdFeC9JRkZjVE94Sm1WUy9ZRDNkL0p0?=
 =?utf-8?B?QWo4Q1ZqWWdIeDd0NDlFTlYyWmpIL2NJRlJ4aXdIcTJ4K2hKZHpsZDFkNm5y?=
 =?utf-8?B?aERwY2t6aDdBVE5DTGdKczJ5M0FMTGNNV0s0VjBZVDRjcEp2T1dpUUMwUnZo?=
 =?utf-8?B?Z0hMTlVxY2lKMThjQThWSzJTM0w4cmNSZmh0Q3ZlQ0UwZXpXTnYwTGFRejQ0?=
 =?utf-8?B?VDM0M3E5eHU4ZXF2S1VzUG51WGxoVzB0VVhNdXJTWUhXRjFON244TSs1R09o?=
 =?utf-8?B?MVBNRjIyazUweG9yak43S3dsSVpic1JiVjVKaVZhVVYxMVQ1emsrMDBjZmVC?=
 =?utf-8?B?Q2dIRk1jK0tsR0NockdibnVhM1E3SGROR1lFV1BQTXAwT3pPbVY0clR1L1Fa?=
 =?utf-8?B?V294LzZYbzh6ZWdzamlnaE85V3V0a2FUMlB6eXBuWlFiRUorT3hPbU9LMzF2?=
 =?utf-8?B?bHhMUXh3VWl4R1piSjFNR0ViOU1yeWJMRi94SEhMU3Y4OXpWcTVybmxvMjNq?=
 =?utf-8?B?aS9SdWFWZVRjRVJlUElXaUtIczkwSmdnYWpocWVlL2t5NE0zV1dsMlo5QzQr?=
 =?utf-8?B?V05RNlZpSmFKYnJPZzk5Y2pKL0tHbnJGUDBaODNQYjNmMCtFaGgzZ3B5UkJI?=
 =?utf-8?B?dTRpVGk1UHM0NG1wR0svdWllUXc3a0t0bEl5bU13V0s4YitrclVxVkZUUzBB?=
 =?utf-8?Q?933g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCP286MB2472.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3NmOW5Kb1pjV1JYRDJVTHczWEFzSDA3dTA3cHhvdnIyUFNubnk0T0c4c1dQ?=
 =?utf-8?B?UWQzUXg3QUxEU2pkZWFwNk1CM042MFNYaGlPeVlIaExkNmFwaHAySTVDMVUy?=
 =?utf-8?B?RzJzS29IcHlqRnFjbVp2TnM5TEt4NDkyYXVjSVB1cVNsbS9zc1lWcmR3aW9X?=
 =?utf-8?B?OWljMWRoVTlMQmdTekJjdXNWTGtNR1NuREVMVUV2TmI0eHJFT3hCcWhVN0xs?=
 =?utf-8?B?Z2wzMFU2cGowWEFseVpwL1FMYXFXQ2s2S2o5OUVTT040U0FiWktRcjdkVVVG?=
 =?utf-8?B?MitaNmVqU0orL1dENTAvWEd5WUY5YUJ2bmExbVg0V29OdE9PSnZqRFBPZGs5?=
 =?utf-8?B?RU1xYk5JemtIUFpRMVZYUTBqQ1pmVTFIanV5dlRMaE51dkZCK0xodVFoM0Fn?=
 =?utf-8?B?M3k4VWEvdGZGdk5MR0VVS2NQOTVMSWJtVDVFekppR1U0c3BrV2JLM3Y0Zlp2?=
 =?utf-8?B?QWhLcWxFcTl3SmVtVWtHVHlncG4xZnFZd2ZpNzMzSkVTR1BHQXpBbkp4cWI4?=
 =?utf-8?B?SHppbDVndmQxNTVVeno2bVJrMUd4MDBrenEreWF3MUlnUjNoekx3ZGI4VDQr?=
 =?utf-8?B?eEtLUkpqRTZpM3FmenF1N0xYd05HYm1tdGZ1eXJVRmtRUGJvMEVTdHI4L2tD?=
 =?utf-8?B?U2psZlY4T1c0ODh4K2c5bS9qdWtYRThnUDNBSmVzbFN4UHJHb0JLU09MVFI1?=
 =?utf-8?B?SHRUZnR6bGE1dlhXYWlYM05pNldnWkZoNS9ibVJGRW5iVzVYYjVyU2FHTW5O?=
 =?utf-8?B?amQyd0R0em0wak93bmU0czQzL2I3U291eWFQd29zdEkvaWFNMndqNkk0c1B5?=
 =?utf-8?B?NFZVa1JlUW5kcWk1MGxMd1VtWTRCaWxCUEdKTjFhK2p4TXBZbXdRQzIxNm02?=
 =?utf-8?B?cTdSV3hjZCtXRTQ0ZnlOdjVzWU1PNVlYWFp1bmhkc3NGL1lVdm5PZitmK0dS?=
 =?utf-8?B?K2Y0M29mNWU3VHM0VHJHaUxJK09kK3N3MWpLN3I1c2cwcGRLbEtJZW5oWlBw?=
 =?utf-8?B?M3FIRnczalFPanF6cVNZdkxxVTEzbG5PS0NRTXQ3ZlNKMUpBZmZ5UkNqSmdI?=
 =?utf-8?B?Mll0TjFBSlRQS01jZktlMGNwWDAzeUFqNzJOTVlOdTRWVkFCSENBclJia2dn?=
 =?utf-8?B?WWdUMHZiVXErOENoSkkyT1ZaWGw0cVQvb0VuQzN5cEVCN3o1dXFPNitrd01H?=
 =?utf-8?B?QjFvS25QazB6c0ZYdWZtSWZINUpTSG1jQWtKU3g1eWdxamRHdGhUb2Z0My9s?=
 =?utf-8?B?RDdDQlUwMjhsYTF6QWU0L2VmUmpIaGdpMDhxV0g3alNIMHg5aXFvbnBqMERW?=
 =?utf-8?B?N1hRdCtpTVhBalNyOHlGUXdIaU5MMldyK1dKWWFxemNjSnFIMzVWU0VCRi9F?=
 =?utf-8?B?VHpVWkVBMzlBeHpuVmIwWkU3cWNSOWZWeXFtTXVFN1JOb2Y0U1JtaWJTNlVt?=
 =?utf-8?B?YmY4SnBEMkh6MWtOMDJVWDZjdExRQjZwRGNhc1l0aXdrdGlCeUhUb3hvQmJZ?=
 =?utf-8?B?QUI0Q2RSZEFrUlNnUmh3d3VUNS9hZlJONE45SHBaQWJnNVIwVnZ4SUh1Qy9R?=
 =?utf-8?B?YVFxZ05xSHRnaWNveU1LNXdTOVdpQzdXU20wV1Z0bFFtSXoyUjR1WE01Q2w0?=
 =?utf-8?B?Y0FuZm5GMlo3V0ttdERzR1AwVVM5V2Iyd0QxZnRRR1QzMG05NWZkRjlvWGR1?=
 =?utf-8?B?MVdxOUhGMWxKcHJ4SXg0dTFqeUFDS2crcjNsVEJ0eDVVWFFsUG1yUVhrZXJl?=
 =?utf-8?B?c0JyZzN2a2JPSDdPY3NhS3FINndIa1htQjJkNzFFeUNRdFhmZWNsdFhNUXBU?=
 =?utf-8?B?eXlrOGtBNmM1UnVEMVp0T3JBL2NzL2ljRXplQWMxNThkU1FSc1R1MkFDc3Ft?=
 =?utf-8?B?OGVTNEJzdTJZMzk3Sk51UXpSWXFVaDk4bW5PMDJqeW5RWG1ZRVM1RWplVVRM?=
 =?utf-8?B?TlhhWjNYMGtETmNneVduQkFjUGxmTldCZjZIdm4xcXNheThNZWZ1TFJPUTBX?=
 =?utf-8?B?M0phUUVOMnlSeGl5Rm1MRXVBdFJRVXJ2Z2xjZFF1U3J2WnlGRmsrWmNvSVBU?=
 =?utf-8?B?enZuSzZ1K2pBcjk2UWQxMHg1UnBCWGxwRmtlL3BSeHZ4Z1dsWFlEZzlkcVBo?=
 =?utf-8?B?M1RUbXdUMG5sNmpnMllEQVlhZWR2dlVpbHN3aDNaQTZDZGZvL0tMQzRid3B2?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ceP4gzIjwDcrWUt/Sx8vaIUX1hMeoZzcjh/1l5DP9ZSdegq9gQv28JBPb4BuTHARnGtBCxEUeiraXra5t630GCCSlfiUFlGyUC/nkVELqnzq1LjsyjzZK3gNT4yHThSQwj7bMKSBGKQ5njSo/bQiEs4fotHkU0t9DRBJYevSSD28XL8Gx/KbhEjgRjbXK4EScUKk5hBz+8sZwxCNExbOkdTDXsRq/ZnL0PZbRXVUG6QOUb51dZnSnIBgCTeE8QRg+3kT+dPae3Prk4Icfxf8UXJfoVjHWkPnfjBo9EvqHMteX2WWhp8Hc3k35SWBFxyKchxkcnm30/eAemVBID6IvVW+llG0XcsCW5XHRzxDWKhVACBbzObn1wWwmpalT9l5u5szXWiOOQH4/xpXU8+dNwp35x/1RigmI3zKGk5ZIojxUv+eU5in8VGIVgSC4Qhrvv92H0LLAkW+0PxCJvCWnH5S4PK76oCNzhgwTjqas/itYhbMIGw9nzMdhhyljW644b7hKdWB7VyqSgyvc9gIWzxNeStWgTf56+ijbU4uBhyl3FNw8ZMCE8x24MNNYE3pEMSOF22l64bgf/sCz+QngrDLLtAsG/Dm/GCNJi2fWdgbjkhhm0PbB9jsjXsr2l9O8qs7+Ij5wYgnRhNxLn5Y6J2HWJA4OMdy5CM6vgrteG81v4Y4h0XqtEt9iJtoQ+C1J2xRe1kdez4AA3DEUOQFjHoPhhAGu6KUeGeQpz8tz/bnq2fySq0HEb1lNAidHyV/
X-OriginatorOrg: socionext.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2472.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d40d819b-afe2-4b76-06c7-08de2d95cbb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2025 09:17:32.3850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33c08a51-ea9e-46de-8669-aff1f467d3fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fqlI9yk8dgn3hucyZQwWOb3w4qJ02lYW6O+lCxmhvOtA5LJf2XYMMGrViSptc72oqF+akopgntxleC2+kvImHT4v1t+vZPjHUpLLO8Go/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3307
X-CC-Mail-RelayStamp: CC/Mail Relayed
X-CC-Mail-RelayStamp: CC/Mail EncServer Relayed
To: <xypron.glpk@gmx.de>
Cc: <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <hayashi.kunihiko@socionext.com>, <morimoto.masashi@socionext.com>,
 <u-boot@lists.denx.de>
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

SGkgSGVpbnJpY2gsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVp
bnJpY2ggU2NodWNoYXJkdCA8eHlwcm9uLmdscGtAZ214LmRlPg0KPiBTZW50OiBGcmlkYXksIE5v
dmVtYmVyIDIxLCAyMDI1IDU6NDEgUE0NCj4gVG86IEtvamltYSwgTWFzYWhpc2Ev5bCP5bO2IOmb
heS5hSA8a29qaW1hLm1hc2FoaXNhQHNvY2lvbmV4dC5jb20+DQo+IENjOiBJbGlhcyBBcGFsb2Rp
bWFzIDxpbGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+OyBTaW1vbiBHbGFzcw0KPiA8c2pnQGNo
cm9taXVtLm9yZz47IEhheWFzaGksIEt1bmloaWtvL+aelyDpgqblvaYNCj4gPGhheWFzaGkua3Vu
aWhpa29Ac29jaW9uZXh0LmNvbT47IE1vcmltb3RvLCBNYXNhc2hpL+ajruacrCDnnJ/lj7INCj4g
PG1vcmltb3RvLm1hc2FzaGlAc29jaW9uZXh0LmNvbT47IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGJvb3RtOiBmaXggYm9vdCBmYWlsdXJlIGZyb20gY29tcHJl
c3NlZCBpbWFnZSBmb3INCj4gSUhfT1NfRUZJDQo+IA0KPiBPbiAxMS8yMS8yNSAwMDozOCwgTWFz
YWhpc2EgS29qaW1hIHdyb3RlOg0KPiA+IFRoZSBib290bSBjb21tYW5kIGNhbiBoYW5kbGUgdGhl
IGNvbXByZXNzZWQgaW1hZ2UsIGJ1dCBjdXJyZW50DQo+ID4gY29kZSBmYWlscyB0byBib290IGZy
b20gaXQuDQo+ID4NCj4gPiAgICAgICMjIExvYWRpbmcga2VybmVsIChhbnkpIGZyb20gRklUIElt
YWdlIGF0IGE4MDAwMDAwIC4uLg0KPiA+ICAgICAgPHNuaXA+DQo+ID4gICAgICAgICAgIENvbXBy
ZXNzaW9uOiAgZ3ppcCBjb21wcmVzc2VkDQo+ID4gICAgICAgICAgIERhdGEgU3RhcnQ6ICAgMHhh
ODAwMDBkNA0KPiA+ICAgICAgICAgICBEYXRhIFNpemU6ICAgIDEwMTE0NTIwIEJ5dGVzID0gOS42
IE1pQg0KPiA+ICAgICAgICAgICBBcmNoaXRlY3R1cmU6IEFBcmNoNjQNCj4gPiAgICAgICAgICAg
T1M6ICAgICAgICAgICBFRkkgRmlybXdhcmUNCj4gPiAgICAgICAgICAgTG9hZCBBZGRyZXNzOiAw
eDkwMDAwMDAwDQo+ID4NCj4gPiAgICAgIDxzbmlwPg0KPiA+ICAgICAgICAgVW5jb21wcmVzc2lu
ZyBLZXJuZWwgSW1hZ2UgdG8gOTAwMDAwMDANCj4gPiAgICAgICMjIFRyYW5zZmVycmluZyBjb250
cm9sIHRvIEVGSSAoYXQgYWRkcmVzcyBhODAwMDBkNCkgLi4uDQo+ID4gICAgICBCb290aW5nIDxO
VUxMPg0KPiA+ICAgICAgTm90IGEgUEUtQ09GRiBmaWxlDQo+ID4gICAgICBMb2FkaW5nIGltYWdl
IGZhaWxlZA0KPiA+DQo+ID4gVG8gdGFrZSBjYXJlIG9mIHRoZSBjb21wcmVzc2VkIGltYWdlLCB0
aGUgbG9hZCBhZGRyZXNzIG5lZWRzDQo+ID4gdG8gYmUgcGFzc2VkIGluc3RlYWQgb2YgdGhlIG9y
aWdpbmFsIGNvbXByZXNzZWQgaW1hZ2UgYWRkcmVzcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IE1hc2FoaXNhIEtvamltYSA8a29qaW1hLm1hc2FoaXNhQHNvY2lvbmV4dC5jb20+DQo+IA0KPiBI
ZWxsbyBNYXNhaGlzYSwNCj4gDQo+IFRoYW5rIHlvdSBmb3IgZGl2aW5nIGludG8gdGhpcyBwcm9i
bGVtLg0KPiANCj4gSW4gdGVzdC9weS90ZXN0cy90ZXN0X2VmaV9maXQucHkgd2UgYXJlIHRlc3Rp
bmcgb24gdGhlIHNhbmRib3ggd2l0aCBhbmQNCj4gd2l0aG91dCBjb21wcmVzc2lvbi4gV2h5IHdv
dWxkIHRoZSBwcm9ibGVtIG5vdCBzaG93IHVwIGluIHRoZSB0ZXN0Pw0KPiANCj4gNTM5ICAgICAg
ICAgIyBSdW4gdGVzdHMNCj4gNTQwICAgICAgICAgIyAtIGZkdCBPRkYsIGluaXRyZCBPRkYsIGd6
aXAgT0ZGDQo+IDU0MSAgICAgICAgIGxhdW5jaF9lZmkoRmFsc2UsIEZhbHNlLCBGYWxzZSkNCj4g
NTQyICAgICAgICAgIyAtIGZkdCBPTiwgaW5pdHJkIE9GRiwgZ3ppcCBPRkYNCj4gNTQzICAgICAg
ICAgbGF1bmNoX2VmaShUcnVlLCBGYWxzZSwgRmFsc2UpDQo+IDU0NCAgICAgICAgICMgLSBmZHQg
T0ZGLCBpbml0cmQgT04sIGd6aXAgT0ZGDQo+IDU0NSAgICAgICAgIGxhdW5jaF9lZmkoRmFsc2Us
IFRydWUsIEZhbHNlKQ0KPiA1NDYNCj4gNTQ3ICAgICAgICAgaWYgaXNfc2FuZGJveDoNCj4gNTQ4
ICAgICAgICAgICAgICMgLSBmZHQgT0ZGLCBpbml0cmQgT0ZGLCBnemlwIE9ODQo+IDU0OSAgICAg
ICAgICAgICBsYXVuY2hfZWZpKEZhbHNlLCBGYWxzZSwgVHJ1ZSkNCj4gNTUwICAgICAgICAgICAg
ICMgLSBmZHQgT04sIGluaXRyZCBPRkYsIGd6aXAgT04NCj4gNTUxICAgICAgICAgICAgIGxhdW5j
aF9lZmkoVHJ1ZSwgRmFsc2UsIFRydWUpDQo+IDU1MiAgICAgICAgICAgICAjIC0gZmR0IE9GRiwg
aW5pdHJkIE9OLCBnemlwIE9ODQo+IDU1MyAgICAgICAgICAgICBsYXVuY2hfZWZpKEZhbHNlLCBU
cnVlLCBUcnVlKQ0KPiANCj4gVGhlIHRlc3Qgc2hvdWxkIGJlIGNvcnJlY3RlZCB0byBzaG93IHlv
dSBpc3N1ZS4NCg0KQXBvbG9naWVzIGZvciB0aGUgZGVsYXllZCByZXNwb25zZS4gSSdsbCBsb29r
IGludG8gdGhpcyBmdXJ0aGVyLg0KDQpUaGFua3MsDQpNYXNhaGlzYSBLb2ppbWENCg0KPiANCj4g
QmVzdCByZWdhcmRzDQo+IA0KPiBIZWlucmljaA0KPiANCj4gPiAtLS0NCj4gPiAgIGJvb3QvYm9v
dG1fb3MuYyB8IDQgKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ib290L2Jvb3RtX29zLmMgYi9i
b290L2Jvb3RtX29zLmMNCj4gPiBpbmRleCA4OGY3YzE4Mzg2Ny4uYWUyMGI1NTVmNWMgMTAwNjQ0
DQo+ID4gLS0tIGEvYm9vdC9ib290bV9vcy5jDQo+ID4gKysrIGIvYm9vdC9ib290bV9vcy5jDQo+
ID4gQEAgLTUwOSwxMSArNTA5LDExIEBAIHN0YXRpYyBpbnQgZG9fYm9vdG1fZWZpKGludCBmbGFn
LCBzdHJ1Y3QgYm9vdG1faW5mbw0KPiAqYm1pKQ0KPiA+ICAgCS8qIFdlIGV4cGVjdCB0byByZXR1
cm4gKi8NCj4gPiAgIAlpbWFnZXMtPm9zLnR5cGUgPSBJSF9UWVBFX1NUQU5EQUxPTkU7DQo+ID4N
Cj4gPiAtCWltYWdlX2J1ZiA9IG1hcF9zeXNtZW0oaW1hZ2VzLT5vcy5pbWFnZV9zdGFydCwNCj4g
aW1hZ2VzLT5vcy5pbWFnZV9sZW4pOw0KPiA+ICsJaW1hZ2VfYnVmID0gbWFwX3N5c21lbShpbWFn
ZXMtPm9zLmxvYWQsDQo+IGltYWdlcy0+b3MuaW1hZ2VfbGVuKTsNCj4gPg0KPiA+ICAgCS8qIFJ1
biBFRkkgaW1hZ2UgKi8NCj4gPiAgIAlwcmludGYoIiMjIFRyYW5zZmVycmluZyBjb250cm9sIHRv
IEVGSSAoYXQgYWRkcmVzcyAlMDhseCkgLi4uXG4iLA0KPiA+IC0JICAgICAgIGltYWdlcy0+b3Mu
aW1hZ2Vfc3RhcnQpOw0KPiA+ICsJICAgICAgIGltYWdlcy0+b3MubG9hZCk7DQo+ID4gICAJYm9v
dHN0YWdlX21hcmsoQk9PVFNUQUdFX0lEX1JVTl9PUyk7DQo+ID4NCj4gPiAgIAlyZXQgPSBlZmlf
YmluYXJ5X3J1bihpbWFnZV9idWYsIGltYWdlcy0+b3MuaW1hZ2VfbGVuLA0KDQo=



