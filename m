Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A76C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 14:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2227682CBB;
	Thu, 19 Jun 2025 16:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cern.ch header.i=@cern.ch header.b="Sv5cZi1f";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="Sv5cZi1f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD38E82CBB; Thu, 19 Jun 2025 16:48:59 +0200 (CEST)
Received: from ZR1P278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c213::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A28C782D06
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 16:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pieter.van.trappen@cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lB9LNe8ZG3KRvEjVimC7jfCFDgdxl/ik9Bww9BsT13yBuEHe6ad7WZdTgs80aLcFcduBwOutUkXVFvfRYQB5XD0VHV4N7vQCGgl1sXsl6mcfjInflLQkbRtKmiwKgzo60qbYvdOK4vN/ChrMLa5/bNm3dEChhpDyc04CondV375Z8bSLKafjn1dx/QKRfsVc9Baft1iNeV/+Fjk3XVINuR90la/L6uNxZEJED/SoI2Ya83q6UCxU7RU4Vhtl/m1eD/VnVjyCPnDAPsE++9ACxUPQrFWyYj3mkn+RIkvtxnfnuyH0eJ5UFhaL8FvRukXJnWAf9gVG8bNWySFBUDSrRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjysNVbCPWMMGtcYDvCLV+uK2PSpnj12fEuq2YlOtdc=;
 b=Qe8yeS++UVPU7js7FS3GXODSUhDtU6C0zbgn25/eyMnbZ1qPvhr/dVTmOw6PpPEAPiHdAQ6xkLK9lHC9knHGUVg8OcqGoLDcQpfIziaDf7QWttmfVhE0Dazr46NE6GKV3gju1UeCuPzXgQmjbj1LoYSR70b61jvECc/B+wzCUrENitduLgLq5HINPxsn54GV2tzR9RxtNFbxg379Tjm39qfjsy4pgYqsiU1wxuel9+RjFhHpRNgWH84ZX5Fo8GZvT7fn6W+85ab8OS0FppkqchvaEh5qBWF1zdCp3+oHZsRtSr9HU2+DUv6t9rhpSzV7o4KRwKfiPrSW+rECN7OooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=amd.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjysNVbCPWMMGtcYDvCLV+uK2PSpnj12fEuq2YlOtdc=;
 b=Sv5cZi1fKUOF1Fn8yrvTA2dolWcd2CkwccmuVWD56F7zM07MiHvfqD+sCNSvrRUQLJdMcABScoBC1FNnVo+l36JmB4FfVNbLBbgfjI9TDaUhu4ARlR2FQGbyZRQwnAMAmaCjfGgAyu1ONpMHkHc8d9WKJz3YA48njluBIdKUV28=
Received: from DUZPR01CA0071.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::16) by ZR1P278MB1522.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:9b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Thu, 19 Jun
 2025 14:48:55 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:3c2:cafe::3a) by DUZPR01CA0071.outlook.office365.com
 (2603:10a6:10:3c2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.35 via Frontend Transport; Thu,
 19 Jun 2025 14:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Thu, 19 Jun 2025 14:48:55 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com; dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch
 header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=Sv5cZi1f
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17010001.outbound.protection.outlook.com
 [40.93.85.1])
 by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id 3FC63FC36C;
 Thu, 19 Jun 2025 16:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjysNVbCPWMMGtcYDvCLV+uK2PSpnj12fEuq2YlOtdc=;
 b=Sv5cZi1fKUOF1Fn8yrvTA2dolWcd2CkwccmuVWD56F7zM07MiHvfqD+sCNSvrRUQLJdMcABScoBC1FNnVo+l36JmB4FfVNbLBbgfjI9TDaUhu4ARlR2FQGbyZRQwnAMAmaCjfGgAyu1ONpMHkHc8d9WKJz3YA48njluBIdKUV28=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::14)
 by ZR3P278MB1425.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.32; Thu, 19 Jun
 2025 14:48:53 +0000
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8]) by ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8%7]) with mapi id 15.20.8857.021; Thu, 19 Jun 2025
 14:48:53 +0000
Message-ID: <32303ded-121a-4c93-8120-f68d0d713c8a@cern.ch>
Date: Thu, 19 Jun 2025 16:48:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Improve user feedback in case of FPGA bitstream load
 failure
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, vtpieter@gmail.com,
 u-boot@lists.denx.de
References: <20250617092333.335908-1-vtpieter@gmail.com>
 <eb9be150-5298-4929-94e2-ace2f095eb84@amd.com>
 <20250618135728.GA6521@bill-the-cat>
 <ef7de176-5beb-4a7f-9663-a2757b85b86c@cern.ch>
 <20250618161622.GG6521@bill-the-cat>
 <405c6a76-d2f2-4842-9d0c-b74888834c78@cern.ch>
 <20250619143641.GP6521@bill-the-cat>
Content-Language: en-US
From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
In-Reply-To: <20250619143641.GP6521@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::7) To ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:4f::14)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: ZR0P278MB0759:EE_|ZR3P278MB1425:EE_|DB3PEPF0000885D:EE_|ZR1P278MB1522:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7f36b9-3108-4340-74e4-08ddaf406a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?d1pTRnRDYlUwVVFMbzNtSWNVc1l3Vnh0ZG1qMXhVcjZnOXlld2w3QWVadEFs?=
 =?utf-8?B?QytJbWljUXkyMXhyWWdLV0hxZm5zS0thS2pTTzZzNWFQNlV0bm5jeTMyNlk1?=
 =?utf-8?B?c1ZtZlpsYXF1ZGZVVDNkdVAwbis0a0t6d2UwNnZsY2h6SEcvcmJPaU1kSVk2?=
 =?utf-8?B?VVN1L0RLM3RNMTBhMk5LMjZRdWllRjFhRUdIL2ZtWFJWRGk1ckU1dTdENHRH?=
 =?utf-8?B?Z3BZYlAzY0hYRVRsOU1OWEFIczFhaTRNb1B6NXVacUpoeERZMmE0ZWtQOEZ6?=
 =?utf-8?B?ZkxHNnJ6L1ZjR2pCMFJ3T0RIODYvblNnektpdWYxTk9sVllORVU4R21wWGJC?=
 =?utf-8?B?R1BzKzMrNmswcEEvQ1hlaWIrd0xHUjdqeHJqNWtGamZuY010cjBrSlErT0lF?=
 =?utf-8?B?MWZVSzRYL0FRLzl4dXl1TlVuSG81L2Z4dGFvbXdsRzBvMXFBQmFQS2JOUUwz?=
 =?utf-8?B?K3NMSUVIRDB4dU5uaTJidk00cVhjQWVjaW1LaDRNMURjcG9WVXppdW15Zmh1?=
 =?utf-8?B?azhrUHphREJUTVM1WHVqbXpObDA4ZUpMeDZjenNaenFUcWpNTXFMR0N1Y3N3?=
 =?utf-8?B?K1JsUnVJMkE1eGltcjliSFN5c1RoUVNBK1FrdzgyNzFDYnluYzRSdWlJdUFD?=
 =?utf-8?B?QXJTSjUrWkhtZzFINm1SQ0xaZ3A2cmxMTDV3Nnp6NWNTdGFHeVBqVmhLcm0x?=
 =?utf-8?B?N3lGRnhWTTdFNkZ2K0syTU1DZFlrclMxVHl1bS94WmZuVXF6alo5MURCVUlH?=
 =?utf-8?B?dy9XK1FIendsWXhIZUN6Rm1VT3Bma01nTjNxMWJkVGhtUmNLMFFTVWo1MEhk?=
 =?utf-8?B?bUNoMlh4VGFGcE1mbm5ETFNXbjNLWEZ3NHRSQUxVSy9aY2VXNWJUK3I1NldO?=
 =?utf-8?B?M2JQYnBPZzdzeE42Qkg2UkFoR0RMTzJHSzhocERYRlIyanpTUGJHM2VJVnE3?=
 =?utf-8?B?QWdoYVhnaThFMUpKdkFQeHpCU2ZkSWVxNW9lOEl5dm1waWZtdWpxT1lrZWhj?=
 =?utf-8?B?cXZ3M0JzQ1lEUXRHa0cyNy9MSCtzQ3pONjhlZENPUVdkQVFWenNiYTBrbUdO?=
 =?utf-8?B?QmhXMDd3RFFaL3Iyd2FkeWh6U1ZhejNWY2FvcGxOcU10VWJGYXAyd2RtWVRK?=
 =?utf-8?B?NGxDRUJPb3hYb3RvSEdXcGdNdzRBQW9TcEZFYk55b29jQ1dqQnJ1dnJlUnUr?=
 =?utf-8?B?OWdXekE3c01IOFdwWXJoOTRNOS8rYXdxcWhrcGdGN2NTZjVmOHVEUENITE9C?=
 =?utf-8?B?ajk2dlVvZmFwMzdGeEEwMVcyQjFYQzcrUFp1TlFnd3NxanJmRllRLzhRaW5v?=
 =?utf-8?B?YzcwMmRIUkpzRVpXRDl5UWY1bHgyRHdnWDMrY0dvM2FXcjd2VVBYR2hNbnRD?=
 =?utf-8?B?TVpHRkUxL3hib1A5Q2s2ZHpnaXBZbk1oNDRiTHY4NXovS1VYREUydXNWRm8y?=
 =?utf-8?B?Y2lDdnluSEY3b2ZSdUt3QU5SY2Q0eUp6ZGYxMjEzSlk0RDI5TDJvNk1rSEgx?=
 =?utf-8?B?NFFmd2dqWHRzNitvcy9tVHltTXJtamFSLytNcjhqMlgwbCtVZkx6RHhENDJ3?=
 =?utf-8?B?UFBhZWlnYUtJcUQzYk5RK1J4dGZkdWYyOEdzUU9QNTFiZEl2Z1Zydlp2VWdZ?=
 =?utf-8?B?azdZNTh2N0FWWnNZcU1MdzZkVVpTUU1Yc1k0SnVJMmtjS2t2WXJRekVqd3FD?=
 =?utf-8?B?ckhiVkdHSDhvV2VKamhKTkVZNC9JYjBIMDg4RldFNGxtb3g4K3hRSTZEVDlS?=
 =?utf-8?B?TXlHYlJhSG1WeUJKcGVjdGl2OUtSSE80ZEVlanVNRTNteS9QcEgxZXp4eGFO?=
 =?utf-8?B?VUFKcU84WkxFRWVrak9Hd0NTRFc2UmJLRFlhMkNDVUQ3YkJTRnJvRGNNWDgv?=
 =?utf-8?B?RUxXaEMzTlQ4S2I4cm0wV3ZxWU5vMDF0ZnBSdnVWRjQ1bWlGUVgwbnF2N1RL?=
 =?utf-8?Q?ZNaGWVqAWZo=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1425
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0b83ff49-ff4b-4485-29fb-08ddaf40691f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|14060799003|35042699022|82310400026|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0lGcUhHaGxKREQ5S05JZTdVdDBFVkFQS282ZGdaaWh5MEdwMWNKNTJQR0Jn?=
 =?utf-8?B?K0dLdHM2ZTFCYVR0M1VOMHJKV1piUUY1dTBlbWcwcWlVNllVNkU3OW9vbTlz?=
 =?utf-8?B?VTk4VWlqWis2MWlGQ1RKRjBjcmRLb25WVUg0SnN2aS9pWmM5d0plcTlSVmFM?=
 =?utf-8?B?aUJWeVZqQVRqY2xLa3dObEtGeUR1cDNBbTRGc3RtNFJnRXNrcVNQRzNYa09D?=
 =?utf-8?B?ZTU0dDN1UFUyMHNIdlFJdCtpSUxVR1NaSlBRbVpHQm93cE1zdDFFRE9kRjNp?=
 =?utf-8?B?YStYNzJlOEZLSjJ3UW5UVGcwbmhsb3pONTNpNFk0YS9CbWtEL0JLc3NtZUhO?=
 =?utf-8?B?NjJITjlJcGNHRGRUelQvRUk0NHpxUGdDZWNqb0lFenFJbjVxeVZicDdETDJX?=
 =?utf-8?B?SVFjRE1RcTltN1NMajZGNVdKWTNndnJWSE01cE5rZjFneFZvQ1NIY1hkZG9Z?=
 =?utf-8?B?YnlWbExxSDlvaTl0VE1WNFRBR2VKdys1eHdkSGhyd1dQMUZlc0tnOTBBSFR1?=
 =?utf-8?B?aTd4VHEraTY3MEtIOFNkcDZmNkhTTGNXd3h3M09SeC9XR01abHlWTXdRTXc0?=
 =?utf-8?B?SnEzK0txSnhJdFFEU1hELy9MMGx2YzVjcnNzWUYwNkdWeVB5OVlXZ0xUN2JK?=
 =?utf-8?B?b2hEZlFTd3N1Rjk4L21ISlhnWEFkNGF1ZlJ2Mkh0cUY4dlgra1o4QzQxcHRv?=
 =?utf-8?B?R0ZLVlN1Q1ppaDRRMS9Hd2tUUUtHTVFJdDRlZWlxbEZhM0t2TWprMmphUU9v?=
 =?utf-8?B?QVVtK2YzNXZoK01ua0crcFVIV081elpUOTFLN1F0NENuQzBUV2tIeUZKUEhI?=
 =?utf-8?B?NVBvanZ2akNHSlRESTFXcUg2L1FoZ3IyRUxRNkJLbTg1MzBQVWJGUDA1NytB?=
 =?utf-8?B?cU5SMytmbXRvSU9TTkNvWHFvTEkwdE43OTliTjVaVTl6bHNZWC81dStnOEt0?=
 =?utf-8?B?UHkxSWd6VXZmUzl6b3RSQ1VQRVVBQ2xIR3ViWkdiOW9jbWlyTFB6ZHE5L3pJ?=
 =?utf-8?B?eUdIeDdMV05jRHpsM2svaDhyZmFMN0Y5UFlCZzYxbHZqUGJ2K3lUcWhTMUdI?=
 =?utf-8?B?aEsvZElvVUY0Z2dyZllWa1BmaHdtdG9xOHFSdGpnc1dmUzVjUWJNOHRleG9n?=
 =?utf-8?B?SE9VVSttUUtiYUtKZlVSdzFmUnFDSldmaVZRdTBLMmdXeFcwTTRxTElRaXFV?=
 =?utf-8?B?ZlhVSFh6cnFIVTQ5dk5ZOGdHOVpxVy9hOUJrQnU2WkJDTnIzL2lFQmp5QTV2?=
 =?utf-8?B?dlNwQVBxRGNtQzROaklIL1VwS2pTK0FUaWdPMmtYTUhGOFRmd1QwU2RmUGda?=
 =?utf-8?B?b01xNE4zSFBFdnFFVklJMWhmUjBDNlJuMTlxUENvRmFZOUFpdi9tS0JSb3JP?=
 =?utf-8?B?bXFwNmpHcFFTNld4V1daTmhZR2RtZytyR253QUI5bVNFMVlFUjJUdTI0a0dV?=
 =?utf-8?B?YjFiOUt4a1hmWkdyblcyZDF0TlJlUXBwSld5bG1EazlYcWQ4a0lSd2czNUh3?=
 =?utf-8?B?UEtyMjJQNmFmcXVnam8zTzRqWmpEcmFxdS9vYzBEcW9ZVEJsYVRnUFRIaTVH?=
 =?utf-8?B?bzlPZW9PVCtFRXhodGJTRVkwZ2pPcTUyUDlMb1JCWkh0MWxEQXlHaC9UbTQ1?=
 =?utf-8?B?Q3ZqTUM4ellYUlNRRUl1Tk9WempHbGhEMWJ2NHFmcnNybEJ6ZFZna2s0Qmhm?=
 =?utf-8?B?Z2lJMzdLbDlWTGpyNGkwbjE3Vk9mc1R3QVFFeURVS0RVSkZORzJJN3p5VVND?=
 =?utf-8?B?bmlOK0dNWVRZdFMvL0E4SHEySTJmNkxrdzNjWGNPUTZEd0UwRVVuYmZyNHhx?=
 =?utf-8?B?KzB1eTl6YjJGQW53SFBGamxXendDMEEvUFlNYmhYZkZ4VHdVVmRpa3NrR1Iz?=
 =?utf-8?B?aEgySlFXVEhmcHV2MTZuQXA2Ym0wU05Od2hOeFNsV2UweU9qUkZPS1pZek9a?=
 =?utf-8?B?ajc2eVU0aHg4TWczdXdKNmFQTDZIMEh3UFdBWWNXMWZHd2cyYWluZmlFOUZ1?=
 =?utf-8?B?em5IN0N3MXNqand2a2g3OXNONkZWUFQxV1crdWdKY3JLZ1V4a0dmdElJN242?=
 =?utf-8?Q?whMs3+?=
X-Forefront-Antispam-Report: CIP:51.103.219.121; CTRY:CH; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mx1.crn.activeguard.cloud; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(14060799003)(35042699022)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 14:48:55.2830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7f36b9-3108-4340-74e4-08ddaf406a62
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19; Ip=[51.103.219.121];
 Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1522
X-Mailman-Approved-At: Thu, 19 Jun 2025 16:58:16 +0200
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

On 6/19/25 16:36, Tom Rini wrote:
> On Wed, Jun 18, 2025 at 09:30:24PM +0200, Pieter Van Trappen wrote:
>> On 6/18/25 18:16, Tom Rini wrote:
>>> On Wed, Jun 18, 2025 at 05:44:29PM +0200, Pieter Van Trappen wrote:
>>>> On 18/06/2025 15:57, Tom Rini wrote:
>>>>> On Wed, Jun 18, 2025 at 09:15:54AM +0200, Michal Simek wrote:
>>>>>>
>>>>>>
>>>>>> On 6/17/25 11:23, vtpieter@gmail.com wrote:
>>>>>>> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
>>>>>>> -		debug("fpga: incorrect parameters passed\n");
>>>>>>> +		puts("fpga: incorrect parameters passed\n");
>>>>>>
>>>>>> I think all of these should be moved to log_err that you should be able to
>>>>>> control verbosity.
>>>>>>
>>>>>> Tom: I think this is where you want to go right?
>>>>>
>>>>> Sounds right, thanks.
>>>>>
>>>>
>>>> Right I will amend accordingly in a v2.
>>>>
>>>> I'm trying to compile now that it's more than some tweaks and I notice many
>>>> (fixable) errors in the drivers/fpga files such as missing time.h includes,
>>>> spotted by gcc 14.2 (x86_64). I'm on the next branch.
>>>>
>>>> Is this due to my gcc being too recent or is something else going on? I
>>>> don't mind patching these in case that's welcomed; let me know.
>>>
>>> Just further changes on the next branch which your changes are exposing
>>> I guess, separate patches for them would be much appreciated, thanks!
>>>
>>
>> Thanks but that's not the case; I switched to the latest `next` HEAD which
>> is your commit ce2a7fcb and I get the same error, see below (one of many).
>> Maybe due to my config in which I enabled all FPGA-related configs? Is is
>> there a `allyesconfig` pipeline somewhere? Sorry I'm new to u-boot
>> development and I don't think patchwork is running pipelines. I'm further
>> investigating, I'm probably doing something wrong although the gcc errors
>> are correct AFAIK.
> 
> Yes, it's related to changing the configs and no we don't have an
> allyesconfig option in the pipeline. It's still somewhere on the TODO
> list as there's a lot of issues to sort out there.

OK I understand now; just wanted to make sure I'm not doing work that 
doesn't serve any purpose. I happily contribute by activating all 
FPGA-related configs and fix these compilers errors which seems rather 
straight-forward.

That'll take more time than initially anticipated; I'm hoping to submit 
patches next week.

Cheers, Pieter
