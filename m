Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE90D74969
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 09:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5EC580077;
	Fri, 19 Dec 2025 10:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="VTe/k4Tt";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kZ0wf5M4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA16780433; Fri, 19 Dec 2025 10:06:38 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F3508003E
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 10:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: fe6c51f6dcb911f0b33aeb1e7f16c2b6-20251219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=52OO0NEB7WxJwYx9Ogb8rpBgLQiNH1rU44bq6tVGex0=; 
 b=VTe/k4TtdNFs8Wv0uPNFhKskF04M1IvEHi7xc1lF7Ow/a9WHjXS3T21ikn636OQJhMsuu0UtK0VjKhYInZSnS272owGwgAM6t4sej/Apd+ztVRwScXPZ6b1ClorwZFnTwVSBkL7SgpbOQkHYqLw/5iE+/zZXxcIT6x9myQaEZWU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6, REQID:cc3dc3ad-591d-4b0a-965d-7dfd5b15456b, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:a9d874c, CLOUDID:96c59fc6-8a73-4871-aac2-7b886d064f36,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fe6c51f6dcb911f0b33aeb1e7f16c2b6-20251219
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1851979789; Fri, 19 Dec 2025 17:06:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 19 Dec 2025 17:06:23 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 19 Dec 2025 17:06:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmsMJ1LCKximKHq2yDqE5a3ZkM9ETj/5bns1zBkgSfSELTS0l81cArZ/GJ8xCmU/ES3+2W7mqB0W9rT/8kpXmCfhTUqiC5XlwYY4p9gt5iKbYmAa3oWxTZNRtsevnG1a6rlkXEEOCwTcBU7Javou5OoFv+/8iNBlECtfEaxrrzejSvGj0XXV8LUb1IM8akTt7KMsLcGj0vmeblLqBfMXERR7JCW80/767m9b4n5264O0Pr8fK/dmxDuTLaveTcOaIyS+VX9Gf0GM2iDDwuBCOgPC9CjpKcJsuXjzYV2iAlTPkPsYYDq11W/MFdpwKWV7v3VVU+stow+3td8JqmFgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRwQtXy3e/2VcV5EUo+bRXLX+N15w4wattLASdBbgkg=;
 b=BzM5ZKsuxgAvN0LZ2CaHEBanQmZSI130sCos03PgBbLh1eyHj2HYP9/6ZYor03NSeKC+O4uc6fcV02bKwZQIWTeLseF0QB7sjFPP8OEIZxOxhs84nY+hCumS3GGg6buIN1uwgzqwmlO8Nm/eHaZS6uNV0hMgPfCC75f54nY1t+s7Axf4pMguD9pKM2AyIU65toAsY1xWnhWJX0GaPg4J2ENIsGqm/p136Al7p9cd1rFWAcPaYIETXi072peVZE8e2mPT0eT+4o4hOac4FyAl0psnM6jVYkVdE6jnNyIoLP3zHDlzp+9GmWtfqsv6Ly3BO+w3oHfnyOY8V0+sgOOdug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRwQtXy3e/2VcV5EUo+bRXLX+N15w4wattLASdBbgkg=;
 b=kZ0wf5M4110KVsdvBA4GLrkz1jJpCWgR3dv2UaDZjso+vI8GwW0zJPRTeKfMDRJFwYqoH6rUGshKi01O3bUpwW/UI+Y3U9vkAKC35CDzARjtlcUeKCN/yD5s8u09iT82TR4lzYJ4W7ClRNy0B48Cje1y2KasgQtPqMb16OVy05A=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEZPR03MB8636.apcprd03.prod.outlook.com (2603:1096:101:232::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 09:06:20 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 09:06:20 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "lukma@denx.de" <lukma@denx.de>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Ryder Lee <Ryder.Lee@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>
Subject: Re: [PATCH 1/9] mt8365_evk_defconfig: enable clk command
Thread-Topic: [PATCH 1/9] mt8365_evk_defconfig: enable clk command
Thread-Index: AQHccHYfhm0eAhqtMUWha9R8hDcc5LUorI2A
Date: Fri, 19 Dec 2025 09:06:20 +0000
Message-ID: <f0dce2aaf02e144e022fe5f77b9c47bfdc9220cc.camel@mediatek.com>
References: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
 <20251218-clk-mtk-mt8365-fixes-v1-1-4f8ff0de3268@baylibre.com>
In-Reply-To: <20251218-clk-mtk-mt8365-fixes-v1-1-4f8ff0de3268@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEZPR03MB8636:EE_
x-ms-office365-filtering-correlation-id: adc54443-5f67-452b-227c-08de3edde02f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?T1EyNGFXd05lMnBqVm13bEd2bWthRlZKc2FtTk94YlNIQTRDZVYrMGN5S1kz?=
 =?utf-8?B?OG9iRkZKSkdudHAydy9oU0tEVDVHdXFkakllYVVUNUVRSHpxM2Qvc1JsbVRX?=
 =?utf-8?B?WDJRQmlXZGdiSnF3U2EzUDBLRWd0b29yTHNaV0NGSFIwa3oxNmlmdm83ZVpU?=
 =?utf-8?B?SnNlaGFpK1hkRGdPd3ZjTEFwT2R6S0d4T0srQW01eWJOVXlJZGFiWDZQa0pP?=
 =?utf-8?B?TVBHVndza1ZhVks1RHlZeHAzWDcxMUJQQjJKSVA3WkgzMVI2OWRieFpFSFBL?=
 =?utf-8?B?L2g0d0FLY2ZzOW9VWGo3Tjhhak0zekdXNDh4emtQSVFtOG5LNmlYV2owWU5a?=
 =?utf-8?B?ZjhJQWVBamlScHhiZjBEanZOSmdObkZma2tsY2F5YlVwUEVhVk12bnBrR0RB?=
 =?utf-8?B?cThFWE92a1lwTVBkRFJlR0lrRUZyZnJCcW1Cek5HQmVxWnIxUXYrdGRjUHNQ?=
 =?utf-8?B?YTlmU0V4MnI4UjN6emxZQ2tvaGR6MU9sYlJIZU5IbXdtSHl4NndzU1ZEa3dq?=
 =?utf-8?B?bkVkR1J6aFY0S3FYTzZmS2NWeEE1YkdLc1k0Y1BpbzNkN1dHZjhaKzZaaVlw?=
 =?utf-8?B?L04ycWhoeDNobGVNQmRZOW5kZmhNcnpZMmZLWlh5N1NFNFhVSzlCeDh0VFNQ?=
 =?utf-8?B?b2RDMm1ON05obFJYUWsxV1paZWlNVUw4VXNnaWV4QUFnS0ErVVlzcGVJNG0v?=
 =?utf-8?B?Q1FUSzFKcS9nLzU0TnNvVXJDdlNGcEo5Y0R3c0xQa3NjRjJ3ZXljZUNMUlRW?=
 =?utf-8?B?S0ZrUUNOUHpkek9LaW9ZMDhqNktVMXQ5L0pCK0daSjJsWXZ6MTdJcGFQTmF5?=
 =?utf-8?B?aWlEZ0YxWkxCNFdQbW95cmw2NXR0NDhIYVBQUWxkaDQyQ0g1RW5BQjNiRkYw?=
 =?utf-8?B?MTNtZGozQ1JuZCszWmtRZ0hQUjVRN2MyRnUvOHdtSnE2eTlTVG9NMUo5R3JV?=
 =?utf-8?B?aWNxSXJ1amY5ZWRTWUxOOUFCbU1wMW1kYkwxbjdMb1hjdkh4MnNDQk82dmxV?=
 =?utf-8?B?R1BOTkRmK1NYMFI2Q3pGcUFNSG1NY0dyUk5LTUdXN1FtaGhjUG1kTUkwcU5y?=
 =?utf-8?B?UEJsODhYOWY5QkNZcTdXalR4TjJkZ0F2S1hyTkRXUW84ckJPWWpBTjVNUlZu?=
 =?utf-8?B?eUFCNGZTckdiRXd1VldsTExRck5Fc053a2lqNXRqdGlkaGRCQ1RHL3A1QmNV?=
 =?utf-8?B?K3prR3l4UlZvdnJHZTliYmpnNzdvcXVJWWNBNkJrdStNSTNYUnVFczRVRjht?=
 =?utf-8?B?bzM0VWEwN3BaSmxQYStBVVMrcFI1bVc4SG5JdzZGM3VTMmRBaVp2dlFoSllM?=
 =?utf-8?B?Y2UwQ2l2MTBIYkFMOUk3aVUvNExSRlNIWVF2MXJxVWxMSWJ2SjU2eDJMUDZE?=
 =?utf-8?B?djJoVTFnaDZtcHkrZmUwMXo5UGdoRWFDOThtSjA3TlMzVi93ZUk3Q29CS3R1?=
 =?utf-8?B?bzdmSE5lWUVHaWhNbG1mbGNyd2RaUUZDL21WcDFYZFArdVZ1dWVHK2JTeklO?=
 =?utf-8?B?N0tSd1BhSmxlMHRpSjk5V0RXcFZmaVFmRnNNZVgwbXBTY3IvQ1NHS2UrUk1F?=
 =?utf-8?B?RE0zdHpwcndBSWJUSTlmRUl5c0xkYVBYSnNRcHU4dXUyYXozc1VBNTN0NnRw?=
 =?utf-8?B?dFlWWHArWk5hMGVZQWhHZ1B4NUhiSUsxWlhUNXpiZ2J0d3ZVMCs3cWNJbjc1?=
 =?utf-8?B?Y2xRWXg4NUFPeU04b2R5Sm1hMzNwb3FoQUJWQXRSK0ZOblVNOVlINzVHdzJ3?=
 =?utf-8?B?S0NHekxQZXFCd01QaTZjcUt3Tm5XbFpqUG1VQklySFZuUzdsamNqRDdZYlRF?=
 =?utf-8?B?bmxadGUrWmdUcmJqMGhBeUszajlyRk8rTTVJWkVSdFdVUEcrc3V3eU9BYzdY?=
 =?utf-8?B?eWRldjdia1VTRkpUUXBxalg5TVFoTkZhOGVuUjJrTS90ZjJkYk5rSHAyL0lB?=
 =?utf-8?B?UjcvZ1RJWGlJV0pMMlcwYzJwUzc2TFBOZ08xRGJYd2UzR3d6d2hzRUd6RC9l?=
 =?utf-8?B?WTZRNkFVVnlhL2xpMGE1ai9CenlvS0o2Mm9DeUJOQTFZeVdpeEtLK0lleGVq?=
 =?utf-8?Q?pp6Jpk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3daQVppS2xWM3I3bFJPcmI3MXNUTXhOQkl2Vm1HUWlBMERqNC8vQ282Ykdq?=
 =?utf-8?B?M0JHVWYycjdpUndBcHlFSE9vODMralFFUGhpdS9hT3pjTUxYVjNzb3dqRTc2?=
 =?utf-8?B?QjArMnIrSEp1TTJPRi9jSkpBbHM5K3ZXWXBHNWhKRy9DQ0NjYnJxVTNOUlJF?=
 =?utf-8?B?ZUR3M3BtYnJkbGpPMWhlbVpXMnJBdlhBa0t0R3NOaEw0c0VsQjA4ZCtxOWto?=
 =?utf-8?B?ckFjMmo2Wnd3U1RCbms1QUV2UG80ZXJZMFlVRlBxQWRUZTBrZ2JuWlFHT3ZH?=
 =?utf-8?B?ZmZacDJ1SHdmTGUycDgxLzhucWljY3Brb0VMYWpVa3F6QTB5SEpHUEphd1BL?=
 =?utf-8?B?ajEvcHpSOHJEOWllMEtvUE9yZW5UaFpONldwOGVxU2R0WmpxMldXUDU1OFlt?=
 =?utf-8?B?bHVOV2ZIZVhJWGpRNnBMNldqYkdobm1aTzBCaGU3M1loWEwvM2Z5Z1FNZGVn?=
 =?utf-8?B?MjRzWjk4T3duVXZNQnBHelF1TVpoNmY0TVJGUmx5UWY2Tm5xUkh3N1RyR093?=
 =?utf-8?B?SWFLK1JtSkk2TitBOHNzOXdmM01iMWV1MVZ1VWMwQmE5ZVordzdHUndQTmc4?=
 =?utf-8?B?WVlHNlk2aWdhSDZmY0lLWTZaVzhxSmVDUzFreU91eE83aDVseG9BZnEzbmdo?=
 =?utf-8?B?Nm9saGxTYzJMTytWMVo0TmNCNHNET3lJU2l1MHR3NmFzenZ5TFNJV2RteXg5?=
 =?utf-8?B?TncwdnRWckpHS0R4SXBwWVYvR2VHY1VCbjd4eHVQektQK1VQUS9kblp0MTVN?=
 =?utf-8?B?K1BMMFNtOEs1c093NjZIa3JZZjNVWUtTb3FmY3YyR1NNWTRCbmQvVXY2Zk5q?=
 =?utf-8?B?MTJjdUpjNVl1MUtiMkE3ZUpWL29YUlBmYmtmd2Y3V1dDUHd2SkFTeXNhM3Jq?=
 =?utf-8?B?UDNQOTQ3dDJoZzFDYXM3b3hweENRak1DWWdzK3IwQ3BtS0QvamY4NWZnWEl0?=
 =?utf-8?B?dmx4aHRjUWVmWFhEeGsyN2g1ZC9UMzFvYWp4cnZqWVcvZXYwejBZWkp5NUEy?=
 =?utf-8?B?di95ZFpCVkhaWTN4aHVUWWRsbC95cFJGY0hqc1dtT0NkVDhFZ0F1RE12MlN5?=
 =?utf-8?B?S1BZbUw0UDZXdWVnUWZOeVpqSUhHQUVFamhqUk5pQUJBMTlxRC9VYklXQVBO?=
 =?utf-8?B?MTlOZUcxcmlEcVc0N2V0QTR2WFVPY3ROdFVURG1XSnkwUFNyb1pSS3N5Z24r?=
 =?utf-8?B?TlZOL0h2RFFqZEMxUUkzWWlIaWo3dW5TWEF4cGtQNjEybmVEMlc3bG1lcU9M?=
 =?utf-8?B?QWpwWUVBQUMxc1JibDRRcGt4OU42ZWxzZUhrZ3RweGxhMlBKU2tQb0xsZmpF?=
 =?utf-8?B?Zjh5dUZyT1RFcC9UTTZ3bUV3NWtGYTRrWGxwazFleHNFVm84aWp5cEJMN21B?=
 =?utf-8?B?QmVtSWRnN0xOL1ZTeTVORDVISEFvN0JzM2xLTWh0QlpGa3N3TzNrQjJzb1lq?=
 =?utf-8?B?S0dEQnpJcGNDWlNSaWlSVXBIazdmV0lleXA0c3NvRC9XQlR2b1UxYmxlL1J2?=
 =?utf-8?B?aXNZY3kvaC9OZW1oaWRyb0ZLeXVERDNvWkNHM0VWbUtENlpNZXYxMVZWQ3RV?=
 =?utf-8?B?OWorVUhpMDI3eEtIUmtWRXMvOGdqa2N6dkVIcTZpMTBjU0FmdWdER05WTktz?=
 =?utf-8?B?NXQxdEZPM0Rjd3dDdEQwT3FhU0owVE5lbStBK0JaSUV3NUx6WFhiTGNvdHkw?=
 =?utf-8?B?bjhwWFRzK2U1RzhwMWpGMEdYV2VjMk1OZ0I0TlJ1QnFlZzNjZnBTQVN5YTht?=
 =?utf-8?B?amN4SmQrWDhwT1N2bFlLRHlHWmNaU25XV21lRWhMQmVreDhDRWdHNG9jbTly?=
 =?utf-8?B?aW9WTUs3dlMvRHBldXJ4NkJ1Rm1iMFRxQ0JQa2lQejhiblBFZGYvcno5L2JG?=
 =?utf-8?B?ejVpZG5oL3g0U1ZId3ljbVlhYlF2eXozNjkzSXUxK1laM1VRNmlSd3BQYURF?=
 =?utf-8?B?cWxodERxTDJORHpIQWpjVFYvMXJpNG5ZTXVOS1Jmd1V6RG82R3BhK3QwWTc1?=
 =?utf-8?B?MEs4dzd0Ymc1TWtRbmtGL1JkUHBEQUxUeWpINTBwS3JCTHhPQzMwKzlYMUg5?=
 =?utf-8?B?N3QvSUlSZkVCYlpLRnE3M3pjMGZLWW5KT0JHTEZEcWdPR085QnZnVE5mVlhV?=
 =?utf-8?B?VHh4cDIzR0kwNkxTbzE2K0F0dkxQL203cGQ2OTFiOGYzODJzUVdqdU13TE5Q?=
 =?utf-8?B?U0VLdGF4RzVyT2Q4RFgyM0tVdThyckxtTHgydVRRRUphSTdxTEVSdk90ck5k?=
 =?utf-8?B?WG1iZ2pwaHg0WGFOQkdyMGZoc3ZCdjdJb3B1Z0U2RVlsUkVwK2ZFZGIvZVQr?=
 =?utf-8?B?SWtNN0pnN0p2anJlWHZqY1J4dXBRc21weW90eVgrZ0ZWTmN2dEZlR2VlN3ly?=
 =?utf-8?Q?q1i7y91qN2BoM+oM=3D?=
Content-ID: <DC48CA01F1B01B47BBFD07312DA9A4EE@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc54443-5f67-452b-227c-08de3edde02f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 09:06:20.2741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZxye4GXh8sBaYPRieNmMtWtoiXs9brXmce5QpHyaqPRcutY2YEzekutT532hwFM6wfiYoqbC20HPXdCPNT37V6j+5BtR8xlOU/OKlRGnTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8636
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

T24gVGh1LCAyMDI1LTEyLTE4IGF0IDE3OjIzIC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBFbmFibGUgQ09ORklHX0NNRF9DTEsgaW4gdGhlIG10ODM2NV9l
dmtfZGVmY29uZmlnIHRvIGFsbG93IHVzaW5nIHRoZQ0KPiBjbGsgZHVtcCBjb21tYW5kIGZvciBk
ZWJ1Z2dpbmcgY2xvY2sgY29uZmlndXJhdGlvbnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZp
ZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiDCoGNvbmZpZ3MvbXQ4
MzY1X2V2a19kZWZjb25maWcgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9jb25maWdzL210ODM2NV9ldmtfZGVmY29uZmlnDQo+IGIv
Y29uZmlncy9tdDgzNjVfZXZrX2RlZmNvbmZpZw0KPiBpbmRleCA3YjQxMTQ1M2UwMC4uYTlmN2Ey
NGJjYmEgMTAwNjQ0DQo+IC0tLSBhL2NvbmZpZ3MvbXQ4MzY1X2V2a19kZWZjb25maWcNCj4gKysr
IGIvY29uZmlncy9tdDgzNjVfZXZrX2RlZmNvbmZpZw0KPiBAQCAtMTEsNiArMTEsNyBAQCBDT05G
SUdfU1lTX0xPQURfQUREUj0weDRjMDAwMDAwDQo+IMKgQ09ORklHX0lERU5UX1NUUklORz0iIG10
ODM2NS1ldmsiDQo+IMKgQ09ORklHX0RFRkFVTFRfRkRUX0ZJTEU9Im10ODM2NS1ldmsiDQo+IMKg
IyBDT05GSUdfQk9BUkRfSU5JVCBpcyBub3Qgc2V0DQo+ICtDT05GSUdfQ01EX0NMSz15DQo+IMKg
Q09ORklHX09GX1VQU1RSRUFNPXkNCj4gwqBDT05GSUdfQ0xLPXkNCj4gwqBDT05GSUdfTU1DX01U
Sz15DQo+IA0KPiAtLQ0KPiAyLjQzLjANCj4gDQoNClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8
bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KDQpOb3RlOiBJIGRpZG4ndCBjaGVjayBpZiB0aGUg
b3JkZXIgb2YgdGhpcyBpdGVtcyBmb2xsb3dzDQp0aGUgcmVzdWx0IG9mICdtYWtlIHNhdmVkZWZj
b25maWcnLg0KDQpCZXN0IHJlZ2FyZHMsDQpNYWNwYXVsIExpbg0K
