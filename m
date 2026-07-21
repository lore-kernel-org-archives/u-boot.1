Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CA4C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 09:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E252A6081C;
	Tue, 21 Jul 2026 09:09:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eBgwl1WQXdRB; Tue, 21 Jul 2026 09:09:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F32B607FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784624969;
	bh=tb/T2fBhovJ5WrVfBFDhxdWiPW0ZtMd+vjf5tInx66A=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oAczWfiQt2QkYjH8toHpJQXEohKiLA9lz5vA6H6i64opjhY29kVCAUEsE46k/y7Sc
	 rmIFxUev5ltkvXLztodreQWbD+KVrKq2e8OTj8ZzS06m8GwZxLikAG2UMTynjEcXzy
	 ptvGxZCY1Kb54NphlNxUngIZbDrfqqQFZGu/5RulMz30q3mIaVRgSAwzM5pZcql6IF
	 WUL7nCkP3VveSFakhNNbasljg8e0lRhzZBm0gUamw0jDIh8F5oIz9Esk53HpGT9+72
	 Ig965mezatggRmhiMTPicaJE7FJVj4C6COVHjujmk2toWMCVHYWtLiqKQfR/r3bzj2
	 GqDXkP01yxXUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F32B607FF;
	Tue, 21 Jul 2026 09:09:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E5022224
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB4E0607FF
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:09:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eyHM0OycA4sS for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 09:09:27 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B7E23607DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B7E23607DB
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B7E23607DB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:09:26 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADD3C844F6; Tue, 21 Jul 2026 11:09:24 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CA2E803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 11:09:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQxUq8p3WkhzC64427wUm//K5NaPaeDT3SBgMmsM7saMi/Nin0xdWISh9Cn+j9Q9d+1T3YauubL8wJ5CBDcapgme6vQWyJNNJpuIsIsa9A+R0I/wyzj6pCHZVdO2Ql+ijeI+WkXjpPVdw8x4xr+OAOBY8x4I+2U2S4nyPmp9iwJArDOVK1qLEskY1X5plh98Vl7USfgVBPYrZdPbbZVUyBO+bkfujqIQR7tHTBCiH6o2yapvUpcT/OlV+5QJduDdIAA2wP54xyQ8r5G5ESyhgTwvO6+44khHKlFCqSuQf5w/EPJlDkiqtcuGjcHZJSMISrDy25cjibfIh0TcyDDXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb/T2fBhovJ5WrVfBFDhxdWiPW0ZtMd+vjf5tInx66A=;
 b=smVxSRdQWrFZnhPovxl2ZZdm4017l40Tz3FM/TNPIRw0idYuerip9WC4yPuC0MCyKLunQREB7tgECaeu16xY/m7YllFKmA+gUNiIvpXjWJBbuEfllIHVRRYxPHg8oce6GWlKp08e41CsJQ6uvEkjLkVTVZWg8r//AthtqD28IJWq4ickzrawHbvrwZjTRDvG6z3ogNy+fO7wa4reDn89d33Xma03izLv32mxCBIOlIkTvL6EeaLwrcc2QwePwVlbtiA35MtuZqVue9riAgCu42nOJyXC6fpajb4ctzp7sjEOOBBOkuzywGP7lBECQLMgVcl+9e7KtHhmUu8rB+0nTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB8970.eurprd04.prod.outlook.com (2603:10a6:20b:409::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 09:09:20 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 09:09:20 +0000
Message-ID: <4b96b66b-a6a1-4188-a93e-65b81de9cc57@cherry.de>
Date: Tue, 21 Jul 2026 11:09:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] dm: core: Drop redundant CONFIG_TPL_BUILD check
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-3-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260708220540.3368825-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::28) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c4acf1-5602-4261-bea7-08dee707bfe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cPkEviyUWGHF53pD8nJSb1r2mXZc1At/OVyi4sW0RGoKd/hk3mJv4OegEpeDUvy74IGcBgn26lb/aoxHBvUVmbhLFI/QgWzU0g+vze4gjiIep5CNqxW6156sxXHqao+4//8QtW2sfJFJ2sGQtpErj9EVRiAFcI5KwVqFt25y09yANbQEGguOlrkewdpbN+NHn37sxORTASGS7DV7dzeqbbc+8vSeoePOVdL0djhNfK7+9k9dlXtwB7qzz6yWbLAx8KDa4c49ej5109hSTt+lpfakntDdzc2Uh7OXxf5wV7nLH4uKjoiaIbzsqk73ZEjmOBuULAFUM5M64mlmyKyTxdwnZUmBfcFLrWjNpFyANNBlfLJNoeBZWlEMvBfDtifCus0h6zbVKhEJShZUS0AD49iRHpUS8/xayDs6qmvRffii8mKbtvAlU22O08Y8UdBnnnoJyPH5VJdah2ewSj4una9kPt6uq6xGv1wFIm/0huYQFpEq5CrAFSxl6Mo/IHlQQxrM4PBNg0xXJK83A6Zvw4S9QIfBe5MV7AepSCCKen5LmqaPArFuyJ2598bdrxmjtYvRRLeHUV3F2q4merBnTuwiz7cddGbmMzhpoacj28qEyBaArub8dhPWMIe7wnZ3fZ4jMdZCAwgeuqDmu1LFpYHccvAyYAYzvsCVmfzePCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEhtVFFXTmw3VENYbzVBaVdERnBoYldCd3BnNmFrM2VKTW9EQ09BeFBkaFBS?=
 =?utf-8?B?MERjakxUM0ZrK0R0by9UeEVrYWFmVjlwejVOWktTTCtOb1czNGtIRTNZWUd0?=
 =?utf-8?B?VzdkZ0N1M3JEVmpkdDJZQ0g5STY5NlBaNjVzc25WdEQvbkZ0SDlhOTVkRDJx?=
 =?utf-8?B?c1NJaHhsRmlPT1hSWUhVTlZsTlQyZEUrd2dVL1BJU0c2MW5FVEFDUlpxbkZ5?=
 =?utf-8?B?QThYSlIyWEpiSWpoTHdndklSaCs0RXlvRlg4bVJ3UWVBS3B6UEM3ck03aHNk?=
 =?utf-8?B?cjJZWnhxcjFtazNOdE1TVU1QZjBCWVpnNmM5QmpwVkpxeEtGODdPSlUrSGFw?=
 =?utf-8?B?NlZuejBuSVUxb24xUWRQem1GaHJubnluSHVzdGFqWDRvUWxXN2JUVzdXQ2p1?=
 =?utf-8?B?WnEyYTNUUU9MV1cyQ0RwbzZWeGlxRkpnb0FRemJwSzA3UGt0WWNzMDRzUjhZ?=
 =?utf-8?B?Yy9DbVQ1UUEwRmJqQzl2LzdlZUxCT1FJQ3kwb3FQK3VyK0FkRGZVcFVWbHRl?=
 =?utf-8?B?RjhqYnpBQ3Q4bDUvaGtMaktCRGVYbXpLVk1zWEdrekF0UDJkMmNnOTFOVld2?=
 =?utf-8?B?K2RLeG9hV0hKYnJuOUcxcFdIRHB1VnRzZFc4eWRmSkJCNEFmVnJLQzBNbGVs?=
 =?utf-8?B?R1k3UUpCL1F6MmFXZng3bHpyemtOUXV4bmdNVjJzSW50SCtvL21Ja0FKb1hM?=
 =?utf-8?B?cituZzhWODVOeTg0VU83cU5yb25IZ1J3M2dHL29ySElPbVVRSndCYjUxRUtJ?=
 =?utf-8?B?dDZvWWdZZ1I4bHhEQVc1eW52eThidVB5YmdHelNXR3Z0MkZUWm96c3dzUHQ1?=
 =?utf-8?B?Y3FXTENwQkJOM0dSVExrK1BXR0RCa2hMaVhVd3YyN1hYNHlESkpaUzZEOGl4?=
 =?utf-8?B?bldWajVTVkplV1g2Slg2eitZQXdBdWRJZkhuUEcrakgxNjhwOXhEZzI3NHVi?=
 =?utf-8?B?cXpjZzJRY2RzRkk1RnpWNk1yT1JPYXp4QytvNUtqcHV0NEx5WjZFcUFRMm9S?=
 =?utf-8?B?YjZoT2pUdnVaU2JFdjRZZFBrNXBSazdQakN4VWhKWk1acnBOWVZISUQvUEpH?=
 =?utf-8?B?dnVkOFlid1dvdm15UkVlOGhjMk9yVkJyQzdnVHYrREFlbGNQZmduOWlMYitv?=
 =?utf-8?B?MDZDSTJ1YWxaNGhKSUFyQ0JQUlc5NlQvN2ZHWjdrSjIzZ21lc1R4Y2tkaG5a?=
 =?utf-8?B?NS9NUjkzMGU1ZE1tUGczTGpidXZ6RVRPK1lhNWJMTzlJUnJsL21nYzBaOHJq?=
 =?utf-8?B?SFA0T0RvbzJrZmM3MjFYaWQ1TG9FL0FhZmowOEo2djRZUW9IbEVERjl3OVdO?=
 =?utf-8?B?ZHJtSmMwenloTmMrc2J6SjQzNXJxUjh1clVQZm1kY3l6R0JMcGhoamdBWEJy?=
 =?utf-8?B?cVJWTlJWQWxoNEk3NFYyM0J4Mys3VGFOMk9KekowZTFOZFNQQ2VlbUpsV1V1?=
 =?utf-8?B?emNXQ0RWd2czNGlwNFBqTndibUt1MkxiRmxjMkRadHlOd2lVZ0JDSXlOOTll?=
 =?utf-8?B?TEl2TGxuaVcvZ1ljTEp3TDZILzVJRFdYbXFVQkJsZ3NkY2x1RU1udjlPekJ1?=
 =?utf-8?B?ZG5kQUhROVBlTHU2ZTgvLzBEcGlVL29KYzI1SDdUTW45VTV1ZlAxWThsQ0Fa?=
 =?utf-8?B?WXpkNWpVbkZwdFdzNnQrL1NzcUtaSlpTYnFmY3dMRm9UOWFxRmpieHRITXRK?=
 =?utf-8?B?OUV1UEVIY3YzZVFVNWhxTG16K1d1R1pKRU0wRjZjQWFCTnZHL3Z3dmpWVzB6?=
 =?utf-8?B?OC92UWRQV2t4QnVoM2VPRTBBVmNIbjJRVHROaTFicEJRTFp6UTk4OXFVVUFl?=
 =?utf-8?B?VEEyc3c3ck9LWGMxZmsxV1U3QVZqTnN2ZVJ3Q1gxTFJnbEthVVI0UElNbHZn?=
 =?utf-8?B?ZEQrbGZRNm82djBUQms4bDlhVTZHVGQxblc2cktqeUNaYzkzY3BDQlhzZlNH?=
 =?utf-8?B?VFQ4ajVITjZ3Q3ZNRjBXSVR5NDJBRHBjUjM1N2pyVWE4K3BxMFNsREc1WUU0?=
 =?utf-8?B?VHQxaUptdHpnQmJBK0tIYkdwRFAyUjUybDhhRG9DaEJYeEpDOHRFb2xGSDk3?=
 =?utf-8?B?ajBNb1pjSHdrUVJJTVNOYW5nVHJMZ0RhODJ2ZVIxSUhHOFNLZTVOWFdUSDgx?=
 =?utf-8?B?eWRnWFVCNGFuYW9wWmx4Y21oVG84bE1wTk83SGNtOGhkK21id2d5a1NYeDRU?=
 =?utf-8?B?czRJczNGK3FQa05kaUlLWkFEMHV1TUNRdXg3QWdQM2ZhU3hLeURrRk44dWNu?=
 =?utf-8?B?cytTMGswVFIxRFIrWE1aenIxRXdSN3E3ZldMMmNjMG1McjYxK2ZaekZkOEhU?=
 =?utf-8?B?K3ZvdEUxQ3Y0cldIaEc5bHpKS2kzV09RcTRna1kxWXppQWM1MTREQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c4acf1-5602-4261-bea7-08dee707bfe7
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:09:20.5219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skqNGw6cALfX+UvmvfS/DtmE2Tsseavik5hhL7TD6fJ7HWDw1LrZ92geNCuA9AbYaa3jcS4BA01fvSKqzS9yEn4ixAKWFomDUc8Bom1e+Gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8970
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb/T2fBhovJ5WrVfBFDhxdWiPW0ZtMd+vjf5tInx66A=;
 b=ZuzezmPiyAhDnc1ZniJ1qxWUIw4VlFl1ad67qwrYhznJ/1XHgR7XrQilS3LYPlC/aBbaC21r7X/dET16IV+DMaW8wXl37XvOg+3Q2L/wKpBoCGDJePfhXz6G29zlnk9SuePH8R30+ctVoDOMf+tgHePJgCVilfbOr83f70zeNH8=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=ZuzezmPi
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZuzezmPi"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 7/9/26 12:05 AM, Jonas Karlman wrote:
> The XPL_BUILD symbol is set for all xPL phases, i.e. TPL, VPL and SPL.
> Conditional guards that test for both XPL_BUILD and TPL_BUILD symbols
> are therefore redundant.
> 
> Drop the redundant TPL_BUILD symbol check from conditional guards that
> also test for the XPL_BUILD symbol to cleanup from an old SPL to XPL
> symbol rename.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
