Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE76ACAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 14:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 602798344E;
	Fri, 19 Sep 2025 16:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="POPzj/GH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B02068329F; Fri, 19 Sep 2025 16:16:21 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18AFE8319C
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 16:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wv/7jyDqfBNH0Sbkdf9TvmxDfFv/nVPrz3GdYpQCP3aEwDXWymdrsfo4JqmYUjUP6SY0SdFrwioAjSZV7QsSIO9MjyshbJIS3HDi7hAq5aEc1xNTEaQ9/gB9CmxAuaBvP7qCziOBHmFVN0GqqY7QKzNeKnF9CO8F+u8AuRP/XERJwcVMxxknW7VULvdGG40QwY8HVM6O13k0tHsOlE7VPyZP0ycQZC9PKross3yVv1gWSO11JMxhRwfmX4u6pPUld2LARBtSgJHmZ0OB7qchz+VomdSkQfb//M9rmISNhJb+xdyruRUAzLNQIEtjI7BfgQNuOq77vpNhw6mlvt35qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ6U8NXOvePbLKrsWMW2m8EJzGn46a5H1sHdJU0AVO0=;
 b=pbPFNSzNG4UhMejnNqPyD/TZtJR5PR5iuHxXcDwqkzL7El8U8D/yynZqpErMn+jHcx31mRJrxr0TKKxBvAwc0+R+8fT5+0XLEyeXPz6859U1xs0UE23VkExWZTl8K1p2bt2Rd+4Z8M0BqV2edoVcNpxSlmdYLSkiPGNYwf7XVA6d0RLAh15vR/xfocPx/mF9YWCzzF7IvfxWOjZyeCQdpmeOjXv5rEOwGCTdzJXGqcnrO1EiyhipcsVy+vV3HHlmfefqnS2wJrjqVmwEcSooQqU9nhor46a5/IKVW1qnPaWJ25xRG+QIpHJ8uy/mI31JSt5cUZqbOuJwZjpnIvVJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=konsulko.com smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ6U8NXOvePbLKrsWMW2m8EJzGn46a5H1sHdJU0AVO0=;
 b=POPzj/GH1wMdBDlChGRPWuPcqvkyDMZWuMatqPxc/InXF4lmOnZx00p7QaC2UNNjgLpYhCCLBN5xJS0g6h5pLUaGBzucapZ3U1O364MEe5KpBv9TCDsASapUVhliXFYsv442b3RePGEbOdRrA4tYZZAFhx0y8rNHVYqgiCGMdt2NDF8z9hn33ZrIGltpDumLAxnP1SdhMGXvdjBgZlhWZhbYU46AuKIqPvU15WQWlZifbQnhLF9e8is2wUNm3fpurBbKE6q6uwu0Ou6A3Cz6UQ+RDtCIsbwY8a/aD/T/MghN0EBnyFGc80VMsxRPHsPsv/VFt+4NS+lW16rPQDD1qg==
Received: from AS4P190CA0014.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::18)
 by DB4PR05MB10486.eurprd05.prod.outlook.com (2603:10a6:10:3ce::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 14:16:17 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:20b:5de:cafe::d) by AS4P190CA0014.outlook.office365.com
 (2603:10a6:20b:5de::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 14:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 14:16:17 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.65) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Fri, 19 Sep 2025 14:16:16 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com (2603:10a6:6:4a::24) by
 DB9PR05MB7706.eurprd05.prod.outlook.com (2603:10a6:10:21d::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.16; Fri, 19 Sep 2025 14:16:14 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53]) by DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 14:16:14 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>, Kory Maincent
 <kory.maincent@bootlin.com>, "sjg@chromium.org" <sjg@chromium.org>
Subject: RE: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC functions
Thread-Topic: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC
 functions
Thread-Index: AQHcINmJWmfe7YqAm0qbuGfL+fh/urSZsiOAgACHF5CAAGODAIAAAIig
Date: Fri, 19 Sep 2025 14:16:14 +0000
Message-ID: <DB6PR05MB4551C51511978A6DF29228188311A@DB6PR05MB4551.eurprd05.prod.outlook.com>
References: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250919001117.GA974973@bill-the-cat>
 <DB6PR05MB455171F726E8D6E540141BAE8311A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250919141058.GT124814@bill-the-cat>
In-Reply-To: <20250919141058.GT124814@bill-the-cat>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: DB6PR05MB4551:EE_|DB9PR05MB7706:EE_|AM2PEPF0001C70F:EE_|DB4PR05MB10486:EE_
X-MS-Office365-Filtering-Correlation-Id: a1199aad-61f0-49fe-ed5a-08ddf7871951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Q01TWmNwcEJJMnB0VGNqL2psNm9CbEFNTjVUc1RtSnlPWEZObmlhL1A2VE1i?=
 =?utf-8?B?S2ptZkRScFJyMy9wOGtDWGZnKzZJNW8rTEtHL2E0bDQ0dGlaRm5vNUpXRjRW?=
 =?utf-8?B?d0JwOGc1eGF1SUNWZk1CYzhHQ2dNSjgybmh1d0gzRy9PMkozQXQyNHA5dldC?=
 =?utf-8?B?YyttY1QzUXRTcnNiRDIvaTgvdW80OWRGSkNFTStGT1k3bGFRTm4vMFVkNkZs?=
 =?utf-8?B?ci9SQzhuNC9ZcmVRTkRUZWZoMHlXUTkwaEMyU2RFdVQ3VG56WjMvcWhzdk5L?=
 =?utf-8?B?c1MxSmxIUWVDbWtYSUhhVEVxQTRIOUNySXBzNTlVaTBhcHV2eVRRQktVUFlV?=
 =?utf-8?B?RWNzSy8yZEdqVFhKaFZNSXN4VGRpNFBac2hLdC9uUk9rSlZVb2RmQVAyb0V5?=
 =?utf-8?B?R0EyQmk5OWJJQy8vVHNDZGtrU3hCQm05RnFpWTUzMTZUTS9LZmN3MHo2RWZU?=
 =?utf-8?B?NVhxUlNPeGVPMFlQK3A5R1BwY2dnandNbXdQbHZqV2hBSUc5R1VHNi9Tb1JK?=
 =?utf-8?B?ci9hR2E0UHN0bHZmNW01a2FxdDNlbGN5d2gwalF4KyszNUJVRjE2T2NyVVpy?=
 =?utf-8?B?OXdjMGZOVHRaaWphTWZ3Zkpxak90S1lHcXYwazVzNDVEUEdKK0lwQ0M3dk84?=
 =?utf-8?B?RmpQeVgrT3FzWFZXTmdpUjdRRksvdUVneHJtb0czQ3Y3RnhPTSs2QkV3cjVN?=
 =?utf-8?B?WFMzUTJGL09waHVuRFdEYXltQVVtSzJGUzc0VCtyVlNuOWJBUXNacm9MQnFC?=
 =?utf-8?B?SjdKZUVQUTg0ZFowTTFBbk9OeUZwR3N4STRRMDdFTy93d1NHUTNIOXBMWHZl?=
 =?utf-8?B?WDJnNnFUc3RmOFU1dXFKSXJKbGdtUEdVTWxJTS93eUJQWVU1MzhZM3B0elVm?=
 =?utf-8?B?T3h5eHN1MzRYMlVONzdGU1FYU2JJRHpKRnJFSVNCaXgxaWhYcmZpMzF2alJJ?=
 =?utf-8?B?ckFpZ0RlbkVCZ3EzZm51YVkxRk1PbDZCYThtaHRTYSt4K1BodDhFVE5LYVVL?=
 =?utf-8?B?eTFNMEZyeUNQdURhc0dmNW1USHBicUdRZHpEZkFkeEwrYVA1MUd4UjBkaEdN?=
 =?utf-8?B?RS9lSS9FcXJlanBYcmVPTkJkZmhFRW1mSmVjaXRaRXEzSzZ5ZE43R0tzU1NL?=
 =?utf-8?B?M3AzYmtYVmR0NmttNVNvWjVUeUJpNjVuZFhod0ZsZi9IQlIyS2FsRTZOMWth?=
 =?utf-8?B?NXdUVURiUXNDVnZ1dWdIVUU2cVJZalYvcUxHbk4xTGMwR1MrK3g0RGw4dVpL?=
 =?utf-8?B?WXE1TnZyMkRUZVkxdkR0a2ZWWFcwOVlsTGhkVWhFK2k2YW02MU40Y2UrMEwv?=
 =?utf-8?B?eFo5YVVaRjVIendWVXJwaHdVd3BOc0dtcmJvWGwzSHY0akRzWDVVeTVFVExi?=
 =?utf-8?B?VE0vbDRMU1pydWFoUXBrUDg1SmlJMlN2NVNJRmhPUmFxVWdkM1NrWUZsVjBr?=
 =?utf-8?B?TktneGh3MkN2aVVMV2oxWHhlYnB4V3lxeThDTVZzNmJhUW5vKzFxbExIakZH?=
 =?utf-8?B?K08vaUNycmNiUEJBeTdBcUtFaldON0tkWWhldVI1ZzlNdCtQbnpQa3o0RXMw?=
 =?utf-8?B?MmFMbVI3VkFRV0kycTBhRFZaTklYZ0FYM3NrcFBoekxDNUNSM3FkZnljZndo?=
 =?utf-8?B?cVhyQjVpc0dPNTdnSG80L2p1Z2lGUVkvdXZ0UlZwQWhqL1NkZTBPVjRiTGs1?=
 =?utf-8?B?cmlIbVJpU0hmYmxFR1UycW1KM1FrKzVZVHlZRTBXelFBcGVYVi9DbnJvYlVF?=
 =?utf-8?B?QTFWM2hreXpXWW5VRFpRRnBlZEpRYkZFRThhQ3hlcm9LNXREMER2OWVEMFEz?=
 =?utf-8?B?N1lYMHhBMHp2WFBGU2ljKzNFTzk5dmk4dkRIUE9vTEZiVzFMV05FSENjMGVq?=
 =?utf-8?B?Q1lrMDRlQnAwTTVhSlh6cDlpVS9qTnJodDl6SnpFWjh6ejl4VTBPT0JsbzFN?=
 =?utf-8?B?cWJ6TExuS3RjTEVZRUhBQndtRDIyNzZBMWRkWVpqT1VZUjR1NXl0eVBaaUk2?=
 =?utf-8?B?cmRNbTRiNU1BPT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR05MB4551.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB7706
X-CodeTwo-MessageID: 7069fa7d-9f81-4b54-9640-177b08b58d3d.20250919141616@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5c353cbb-d5bd-4dba-e562-08ddf7871787
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|376014|82310400026|36860700013|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mm9YWmFqNnBaaVQyeVZ4UDJGMHhFSnJVQ2JMOHM4Y3REdjRBZjJya2I1bFFh?=
 =?utf-8?B?UDFDUmZpQ2NkUS9LRlVYanlxYmxoKzhNSEY0bEt4TFN3cW1LZ2hxajhlK3RT?=
 =?utf-8?B?Wm5TcjZpRUNYOEZRVE9DYlJjTFI0V3Y1V0lRbGtCQkliRFVuL2t3VThTVHM0?=
 =?utf-8?B?OEdsb2Frc24yWVYzOE9xVGdqejhXOHYzblU2Zi9mMlRIWWpvTEJ6L0ZncDhB?=
 =?utf-8?B?QllGRkh1ZWJSR2NpMjBIMUtqa2hyNlFRUWUxb1g4U2hYUDNvRk1QaklIdUdm?=
 =?utf-8?B?ejc0NDVoQ3M1QUtSbDNwMGROZjBCcVV6ckxZVXRhbkFSY2FEZDRsdUpOMzRn?=
 =?utf-8?B?cUdhWDRtNmJJOTJBTm1za0dXK0hNazhLTlJhelNvMWY4OXlBM0tQRnVqOTAv?=
 =?utf-8?B?UmVCVUMwVEJNdEF5MFkwTDcyOGdUTHFHTGVpSkt2bStRQTMzYm1oWXhIR1Zi?=
 =?utf-8?B?WUgzTW5uNWNhUE9GQzBWNDU0ZC9HVFNyeFVmYzVLU0hnSURaZzlNdkZYR2Ez?=
 =?utf-8?B?UE0yeVJyVUc2RGVzeEc3MjJWcGdHSWFHY3plVllvTldFcUNISUFwTXpJbG1F?=
 =?utf-8?B?dVVocjhPWnc3ZUpaNGNwVjFGTXp6L2E2UVVmTks0ZzZNZmxBSUxoK2VOYTI5?=
 =?utf-8?B?cXJBZy9waExLMVM5UG1RRWdFT2VsdmN2cksxZmFLN1kyZFRyNUlyUTNtRjFv?=
 =?utf-8?B?R0I2eEdPTWxDSnJDRDJqQ0lNMGZZUWpzYnVVRDV4WVByOXpLVlkzNDZ4TkFG?=
 =?utf-8?B?RXVYRWxSdXRIQ1hEakZjOSsxWFVXbk5kK3p2QlJONVc5VG5Vdk5xTmVMS2lv?=
 =?utf-8?B?THd0b3lzT1NGNVluUlB6TEVvUUpxUW9ScXVkWkNjT1I4aGRUT25MSWtjYmhv?=
 =?utf-8?B?UmlEdXFWbGE5Ui9NSDR3dFpoZEtEeExCK0hIaWdWbUloT1hTd2lUeGVzZVo3?=
 =?utf-8?B?OVVUREFaU2JXem5nTnl0S3JrZ3JET2FrQlRhdUpNTjJUYzk5cDk5N1NHeVdh?=
 =?utf-8?B?UTRWS0E0VDdhNHRrT1lrRlcxNVBRbU53OEZ0WUI1bUNMTCs1Qk1FMXpCeTl1?=
 =?utf-8?B?S01jaXA5eS9NM3lvUExrN0FHODdYR0pmSmtrVnEwbUxMa3NSSklaR3g1Szhj?=
 =?utf-8?B?SHdmRllUWElCWFlrSjlpbk10ZzI2cWIxNTkwOS80cWIrTEtCVUZmTlNpQkxD?=
 =?utf-8?B?M1VjdkR6dnlYQkQ0MU1ESHRTSUtoQU5mcGdqMDhlQkZsV0RxbGRCU1NnVm9O?=
 =?utf-8?B?a1F6U3Z0ZjNqekFqKzdLZVJOTG1tZitJWVdlcHhsQmNXWUFVdDhTY1hQQ2Jp?=
 =?utf-8?B?Q0tNQ0FzSk9ZMHhGaERyOEkzVWEzZDNhUFg3YnlVNWhyMVlPVUtSVnRQbDhF?=
 =?utf-8?B?OVZQOUJ4SWVsS2Rxd0lhemxZblBVTDNybzFucmU1aWUwdmltNnAvRkRZTDRw?=
 =?utf-8?B?REw1dnFrVGR5Nmp4Nk5jYm1Sc0RsdXRIRFdwNUtXMy9LR3IrLzNrVW9OUElB?=
 =?utf-8?B?ckhCdy9ReTBReWlxL3BrWmFSWUM3VFJJTnVhaXpSZDFRQmhuOXJwWnZCR1p4?=
 =?utf-8?B?cEdNakYwM1grRHJBRlo3b2FWZDBsVkJEL0toRG43RWU5dDFNOWN5Qmd1T0Vs?=
 =?utf-8?B?NlU4Z1g4c2JtTlh4QkRwbmFaWjAwYU1hQzVhVys2WmNxTnRPRFd6TFdrSVVl?=
 =?utf-8?B?WURqUnNSWndxVWZDemI5UnJPTkIzM3lraHlMTHdGS0VQRlRWOVV5YjR2Uito?=
 =?utf-8?B?WjBYUVRMQ2NjZmNZamdlSSt2cDdpMjIwSmxxb2J6eUR2SUQ5c0RITnlmd0lD?=
 =?utf-8?B?UDNrNXlBTFhXVnlQcmJvVUdYOWNxbEF0OUxBYzQ3RS8vNmowY1hCb1dhN1lI?=
 =?utf-8?B?bkhGZzE5djRrRDM0cDhLaXp4YXYvRGlYeHViU3JDVFJYOGxqQ3RNa2ljdllI?=
 =?utf-8?B?Y1IvUFQ3M2xqYUtHcHQwbnpHMGUrRERwQlJ6dEdPV2hSR3Mrd25jL0dUdTJt?=
 =?utf-8?B?REpwajdWTnVkazNybEpCMU9rMXV2SnlLemtXQjB6WjlXVCsxVzQwZFEweVdo?=
 =?utf-8?Q?/+hAfR?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(376014)(82310400026)(36860700013)(35042699022)(7053199007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 14:16:17.3688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1199aad-61f0-49fe-ed5a-08ddf7871951
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR05MB10486
X-Mailman-Approved-At: Fri, 19 Sep 2025 16:47:28 +0200
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

PiBGcm9tOiBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPg0KPiBPbiBGcmksIFNlcCAxOSwg
MjAyNSBhdCAwODoxNToyOEFNICswMDAwLCBNYWFydGVuIEJyb2NrIHdyb3RlOg0KPiA+ID4gRnJv
bTogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4NCj4gPiA+IE9uIE1vbiwgU2VwIDA4LCAy
MDI1IGF0IDA0OjA1OjA0UE0gKzAwMDAsIE1hYXJ0ZW4gQnJvY2sgd3JvdGU6DQo+ID4gPg0KPiA+
ID4gPiBXaGVuIFBNSUMgZHJpdmVycyBhcmUgZGlzYWJsZWQgdGhlaXIgZnVuY3Rpb25zIHNob3Vs
ZCBub3QgYmUgY2FsbGVkLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYWFydGVu
IEJyb2NrIDxtYWFydGVuLmJyb2NrQHN0dGxzLm5sPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4NCj4g
PiA+ID4gIGJvYXJkL3RpL2FtMzM1eC9ib2FyZC5jIHwgOCArKysrKysrLQ0KPiA+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPg0KPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvYm9hcmQvdGkvYW0zMzV4L2JvYXJkLmMgYi9ib2FyZC90aS9hbTMz
NXgvYm9hcmQuYw0KPiA+ID4gPiBpbmRleCAyYjdhYjY4ZTgzYy4uMjg0YzMxY2MzMjkgMTAwNjQ0
DQo+ID4gPiA+IC0tLSBhL2JvYXJkL3RpL2FtMzM1eC9ib2FyZC5jDQo+ID4gPiA+ICsrKyBiL2Jv
YXJkL3RpL2FtMzM1eC9ib2FyZC5jDQo+ID4gPiA+IEBAIC0yODMsNyArMjgzLDcgQEAgY29uc3Qg
c3RydWN0IGRwbGxfcGFyYW1zDQo+ICpnZXRfZHBsbF9kZHJfcGFyYW1zKHZvaWQpDQo+ID4gPiA+
DQo+ID4gPiA+ICBzdGF0aWMgdTggYm9uZV9ub3RfY29ubmVjdGVkX3RvX2FjX3Bvd2VyKHZvaWQp
DQo+ID4gPiA+ICB7DQo+ID4gPiA+IC0JaWYgKGJvYXJkX2lzX2JvbmUoKSkgew0KPiA+ID4gPiAr
CWlmIChDT05GSUdfSVNfRU5BQkxFRChQTUlDX1RQUzY1MjE3KSAmJiBib2FyZF9pc19ib25lKCkp
IHsNCj4gPiA+ID4gIAkJdWNoYXIgcG1pY19zdGF0dXNfcmVnOw0KPiA+ID4gPiAgCQlpZiAodHBz
NjUyMTdfcmVnX3JlYWQoVFBTNjUyMTdfU1RBVFVTLA0KPiA+ID4gPiAgCQkJCSAgICAgICZwbWlj
X3N0YXR1c19yZWcpKQ0KPiA+ID4NCj4gPiA+IFRoZSBwcm9ibGVtIGlzIHRoYXQgaGVyZSBhbmQg
ZWxzZXdoZXJlIHdlIGRvbid0IGhhdmUgU1BMX3h4eCBzeW1ib2xzIGFuZA0KPiA+ID4gc28gd2Un
cmUgdHVybmluZyBvZmYgdGhlc2UgY2FsbHMgaW4gU1BMIG5vdyBvbiB0aGUgcGxhdGZvcm1zIHdo
aWNoIHdvdWxkDQo+ID4gPiBiZSBjYWxsaW5nIHRoZW0uDQo+ID4NCj4gPiBUaGF0IHdvdWxkIGJl
IHJlYWxseSBvZGQuIFRoZSBmdW5jdGlvbiB0cHM2NTIxN19yZWdfcmVhZCgpIGlzIG5vdCBkZWZp
bmVkIHdoZW4NCj4gQ09ORklHX1BNSUNfVFBTNjUyMTcgaXMgbm90IGRlZmluZWQuIFNvIGhvdyBj
b3VsZCB0aGVzZSBjYWxscyB3b3JrIHRoZW4/IEZvcg0KPiBtZSBpdCBsZWFkcyB0byBhIGJ1aWxk
IGZhaWx1cmUuIE9yIGRpZCBJIHVzZSBhbiBpbmNvcnJlY3QgbWFjcm8gd2l0aA0KPiBDT05GSUdf
SVNfRU5BQkxFRCB0byBzb2x2ZSB0aGlzPw0KPiANCj4gVGhlIHN5bWJvbCB3aWxsIGJlIGRlZmlu
ZWQgaW4gYm90aCBTUEwgYW5kIGZ1bGwgVS1Cb290IGJ1aWxkcyBidXQNCj4gQ09ORklHX0lTX0VO
QUJMRUQoWCkgb25seSBjaGVja3MgZm9yIENPTkZJR18kKFBIQVNFXylYIGJlaW5nIGVuYWJsZWQu
IFNvDQo+IHRoZSBpc3N1ZSBpcyB0aGF0IENPTkZJR19QTUlDX1RQUzY1MjE3IGlzIGRlZmluZSBi
dXQNCj4gQ09ORklHX1NQTF9QTUlDX1RQUzY1MjE3IGRvZXNuJ3QgZXhpc3QgYW5kIGlzbid0IGRl
ZmluZWQuIFRoZQ0KPiBJU19FTkFCTEVEKENPTkZJR19YKSBtYWNybyBpcyB3aGF0IGNoZWNrcyBm
b3IgQ09ORklHX1ggYmVpbmcgZGVmaW5lZCwNCj4gcmVnYXJkbGVzcyBvZiBwaGFzZSBvZiB0aGUg
YnVpbGQuIEl0J3MgdGhlIENPTkZJR19GT09fTU9EVUxFIHByb2JsZW0gdGhlDQo+IGxpbnV4IGtl
cm5lbCBoYXMsIGV4Y2VwdCBvdXIgbW9kaWZpZXIgaXMgaW4gdGhlIG1pZGRsZSwgbm90IHRoZSBl
bmQgb2YNCj4gdGhlIG5hbWUuDQoNCk9rLCBJIHdpbGwgY2hhbmdlIGl0IHRvIHVzZSBJU19FTkFC
TEVEKENPTkZJR19QTUlDX1RQUzY1MjE3KSB0aGVuIGFuZCByZXNlbmQuDQpUaGFua3MgZm9yIGxv
b2tpbmcgYXQgaXQgYW5kIHBvaW50aW5nIG1lIGluIHRoZSByaWdodCBkaXJlY3Rpb24uDQoNCktp
bmQgUmVnYXJkcywNCk1hYXJ0ZW4gQnJvY2sNCg0K
