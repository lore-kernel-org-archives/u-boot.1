Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01588D6CFDC
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 06:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DC1B839DF;
	Fri, 23 Jan 2026 07:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="iYPZOFPh";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="u5wB6eOO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EDC783B03; Fri, 23 Jan 2026 07:35:28 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F45839D5
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 07:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: af386282f82511f0b7fc4fdb8733b2bc-20260123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=z36HLt4RmXO3+RjW/7Q2MIelfhT9M8Uyps62Taty/tY=; 
 b=iYPZOFPhp6ypAUYueBWLw1TpRRXqI4RTZbmIfRkLgBYXhdWGO/6MweY9EKph2d1WA8p/VRIee0eYf0rPEti22KU0eRDAUz/LhXeijaYbIemJPYX1EbvhO/nYbWzZEzieAW6U9BP6D1dpxLeNmsB91XJqqSOL6L84OExMnueMw2s=;
X-CID-CACHE: Type:Local,Time:202601231435+08,HitQuantity:3
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:2f0242e8-1fe5-4735-8498-786788e033fc, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:eb3dd9e8-ef90-4382-9c6f-55f2a0689a6b,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: af386282f82511f0b7fc4fdb8733b2bc-20260123
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2046925983; Fri, 23 Jan 2026 14:35:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 23 Jan 2026 14:35:17 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 23 Jan 2026 14:35:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paEHQMfeVBqWFpKepFh2zIpYo0GUBTS/nUX3otlC/0vDN+5T7Sj1oLMVAL4qlNQuuUyRI2Kf9nRx0zL4qxFUkAq1p9UYP8jc1LJ3FdnbZ0oAGEayecOjnTe8QIuS3rD96ABmoCqY5jVSRT6iPFSNnstsVr55LvwF76A6VWNl+b0hSS/AKFZO12RNQxeMILPDr9PZRntC0JE7JlS5ffCeoRQH4Dop6jhK2Z3KU0DoKBT0LfpAkVhTIQrpC8mPriFh8OJuyQ5KEVGWZfC5TFq8SL2mUG1hmfN0ZWqj3vWLRqd3zkZXRgFE00XwgJs6RHUh47naixWe3t5/n72k+lzKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z36HLt4RmXO3+RjW/7Q2MIelfhT9M8Uyps62Taty/tY=;
 b=DFRP9ju1S2FE8KhSOKuQWy9WEh2oVbIm5VlJANOO6hTmWt7tGVvohN+7ds3EJ8dw0uWlG8XeKJSjMMTsMtFkipMdWUNL3lRjU40f2yXy1Rh5QFLQFCfKiO02Jk012qLeDKJHL70i/8MphcgbbNuyFzOnQMk7VE/afEv2k4Eo73G7EdT2tDvVYyhJ9B8CsyyUj1NOGHG5QAn7mSz7Qm4OBnuZTP2a9KeAKY5wkwBZy717qnVary+NDYEsVjribmxrcin+tYPM9MfhHf2TkWo2LlTEB21K2qPIUVOOdPFpB4iCB26CL4g2Jd5mkm7S7We0fAntse/3SN6fv6VMZKKSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z36HLt4RmXO3+RjW/7Q2MIelfhT9M8Uyps62Taty/tY=;
 b=u5wB6eOOee5q8oTDREnA7ZAytma6zOr1/f+IsbzTfhQpx2Z+0SyEHGRa+pWN5AJrF3TQpciE8SoOyq0/TnMf6Gfs5f/7V3pjpPK2dDDoj+7IOLFbVWVVNjGORbQQXn8A0BNgNuk7A7S7BUxIOmAIJt9AD7jX70YqeT6AqTa+mmo=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYZPR03MB7481.apcprd03.prod.outlook.com (2603:1096:400:421::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 06:35:12 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%3]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 06:35:12 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?SHQgTGluICjmnpfngJrlrpcp?= <Ht.Lin@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>
Subject: Re: [PATCH 1/3] mmc: mtk-sd: use GENMASK and FIELD macros
Thread-Topic: [PATCH 1/3] mmc: mtk-sd: use GENMASK and FIELD macros
Thread-Index: AQHciyyfYvveFxL100G/xAO4dLoB0rVfTn+A
Date: Fri, 23 Jan 2026 06:35:11 +0000
Message-ID: <d9b2c06d51b4d25112162cb194f527748393c268.camel@mediatek.com>
References: <20260121-mmc-mtk-dma-support-v1-0-3764b487c087@baylibre.com>
 <20260121-mmc-mtk-dma-support-v1-1-3764b487c087@baylibre.com>
In-Reply-To: <20260121-mmc-mtk-dma-support-v1-1-3764b487c087@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYZPR03MB7481:EE_
x-ms-office365-filtering-correlation-id: d4faa962-c98c-4814-2880-08de5a498f7a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?UkpsZFBtcjQxdU1HSzRqbVNYSXhLaUZjYXFHL0NPeDBwakViL1N0TUFIQ1RY?=
 =?utf-8?B?dmZFajZUNWJHRkZrOVVLcUVrdC94Z2NyVWsrNnhuaUQ1Y3Y0Zkl2K0J1d3U2?=
 =?utf-8?B?QjdCL2dYcHphT3c4aTljb0xMNENaK0c4Z1pTeVAzQ2dIL1NramtZVTBIdlNt?=
 =?utf-8?B?T1VqNTFOTHhndDlvT1g3Ti9sQVk4SWNDT2s5Uzk0L0ZxUEVxVXNRbHp3OVE4?=
 =?utf-8?B?TnltVXE0bHFUR3hZR3pEOGF3aklNVjJPUlJZNzIyQ3FiZENvL28zZkszRHh4?=
 =?utf-8?B?enE3UmxQQVBVWFBjUWZpY0dmSHp5MFBONGxrNUNDRWlCZXhwVnZoeGNRckhB?=
 =?utf-8?B?TXhRYi9vUStZUXJodUNYZ3h0YVQ4RGtGYXlLRXRFeVphSFlpNHBjSmxkUElG?=
 =?utf-8?B?Sy85MDVzemFKZ1pxc3JqcWEyMkFQZUgxZk9RNXNPNWhvbjEzaXFEQ21yQXFS?=
 =?utf-8?B?eWMwcDhlUG9XQmlrTzRiSVFJS0pYdm9GSXBQUFBqT1FBdXFLYjNDcG9Zb0I3?=
 =?utf-8?B?Nkd3c1cwQUwwaXBVTW9Ra3JOeERhbmlhT0ZBVTA4RzRsRU1pT2svVUJ0NE5T?=
 =?utf-8?B?aDE0LytuNHlNdUh6Z2hoQWh1TU1MNHo5TklXSVlnOEp2M0l3TE9tcVhYcHh4?=
 =?utf-8?B?SnoyL25LRnhnSFdhOG1hbWVqYU9CaUFUWG9rQXlJWml4OEZPR1UxWVpvNDhL?=
 =?utf-8?B?cGVpOGFJQkhDMGR3OG1KMFNhYlRMY2IrMWpvZHNCVzFuaDF6eFFiMEJTL05i?=
 =?utf-8?B?RnczYTlVc2RHWU5yYVg1TmZuditxM1NhdGJ2djB4cGxlVEV6RVB0WHl0bXc5?=
 =?utf-8?B?TEsxeWVVNXhtRndqV1BiR2JNL05rOXB2UEgvZ0VKOGVEVmpCZnUyYm5WNUR5?=
 =?utf-8?B?eXFWdTA2T0FlTEFuWGcxK3RnemJWKzNpb3hhQUMvR3pkNU5xSUVzU2lqUHJa?=
 =?utf-8?B?MTQ5T3ZBcTFCSFZFS3kxbUVSaGRiY2RSQTR5QlhLaThRZTMzL3pqY3FLZG5z?=
 =?utf-8?B?Ni9TUFpzRDBmNXJGNGw0VTl0TnhPT3JyTVFyRUNRMk1iWFlQOTdmVG9meTdu?=
 =?utf-8?B?WXh1SzIwa001MlNXYVJKbkFaaXFEdHhpVlJ6a1B6RXQrblV3TjlDVjBYeUxH?=
 =?utf-8?B?MWpnc25xdFIxei9PbWdqZmdWbiswUFNQVzZHNXNHdlE2MlBzUU44K3gyNDlM?=
 =?utf-8?B?dGVOQ0ExQUFxNUhjaE9rUkZNZUJ3OU11bkNXQ0VIbVlhQVkzUUJPY29vT25j?=
 =?utf-8?B?cEJRdDNCMjMvM2lPZW5Yb1pYUjdDMThndlZWWHpUTG5RUWI2cnpuYklBNklE?=
 =?utf-8?B?djAvWUNHemM2ZXdTbTZpMm9oRTd1VGx4QWxEY0lMcEh4aDRHaTVSbnNLSFBV?=
 =?utf-8?B?N3Q4TTFwYWhsd1psWjFISzFKbG0rVDdXb2psY2ZLb1Y1STZITExTK2tpc3lL?=
 =?utf-8?B?eFNSK3NNc2RHQk5Jb1FiZHUxMExPTXJsb1dBYTFiclV2eHVPSTVJdmVZQU80?=
 =?utf-8?B?YTZUVUI3S2lkeTJWNTFQOFpIZElmM1JUN3FqSDVlcHhIM3YvdkwxQVdUb2Zi?=
 =?utf-8?B?KytnQ3BjaHZaOERVOXFpZTYwMHdrWmFIejN2MTZhMHBqUEVpS1dzRnJpZlVN?=
 =?utf-8?B?d1pkY1kxdVdwUGpRMWlIdmhuYzFHTmRhNSt4UXZJdzJkTnpsdHI4bllzNmJ3?=
 =?utf-8?B?WXJ1RDdZcXZNTVd6eDhEcnRWZFpucDZjTVUwM0toZXZBeU0yRjAzSDF1RXNO?=
 =?utf-8?B?amdtOUZONzhqUzFYMEVHUHhBZFF0K3VpOWZvRTVYVE45Zi8rMFFvajhxb0o2?=
 =?utf-8?B?Zy90Q3VTd2pnTzhhU25ocHZPMTdmc29qekdhcW1BUzkrOFF1elNBWU0vaUo1?=
 =?utf-8?B?S3JrcThId2M1emRrUlpzR3p3Z0pJb3hEK0s2b0JXSzhPMkVDTFJqTkhCa1hz?=
 =?utf-8?B?V1dzbDUvYk44U1ZSZHN5OVI5VGJFR1J6TTg4SVZUcXpDTFo1T1RZL3VWYWlC?=
 =?utf-8?B?V1ZxQTE0K3YzVW4zWnpIK0YwZ3R3QVpHeGhZZlJEZkJ0NFkxakM1bjlHVG9X?=
 =?utf-8?B?Ly9zUHlWMnBhaGtBNDhXbU9YQndTaDlYRGhjelJJdWdRVGxNUDFFZmNZaGlD?=
 =?utf-8?B?TGUyMjAxb3JKQ1lZQUp3Rm5yNFdnMEtmR2dEU0FHY3hnWjhpT3RLbldWTjhv?=
 =?utf-8?Q?QZFwd2H5dnv5rXvYmtY1k/jDo557oU+V8RC7en87nFZX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEtoQ2RVYnpZWWc2MmJwSXd2SGNSaFlmaGx2d0QzdXV3MlhtRjk1eEViQlVC?=
 =?utf-8?B?WmZjQXNiWHdKbUtEeTZkektvbll0cnpHeUtpeHNDTENjOEJyclVEUCtQcVNj?=
 =?utf-8?B?eTdwaHlSVFd5VXk0dFdjTW1oZVlqSThlUkRqQTRmRjY2UURoS3FtbHZHTUcz?=
 =?utf-8?B?bGVXYzA2c3J2b1dscnRNa3JId0JtWDJhRC9INmhSbXFtWER6Y0cwcEdMd3Bj?=
 =?utf-8?B?enJnUjdMdW55OXNOa0laL2c5VGtkdnZPVDFCQmpNTllIMUZlaU9UL3pQL0dp?=
 =?utf-8?B?TWc4WFQ0SXlES1JwUUlsYTRRaUVJZ2lCNWEwbHd6NFN2c21IQnpvOENHRnll?=
 =?utf-8?B?eWh1aHRhSWNSby9SenFYY2ovaVpBYVdpN2hTZlM0L2VqcGVPdEFjY0lQNktJ?=
 =?utf-8?B?YWVRODRCSmYrUjV4K3FnWXNBZTJPWkxPanpTSmVieWZLd3JDTWV4ZDFOdlA5?=
 =?utf-8?B?ZEQ5VFEyMXZNNjdsSEgwbGJ2RzRFUHE5RzJ2T2RlNFQwRG10SWd6TXdSSUsw?=
 =?utf-8?B?ZlZGVnR5MVl5dW5pV2JCa1JpQ3grSEc5MGNFaUM0NnhVdnp2VUUzTDV3UUdl?=
 =?utf-8?B?TmRJdmxRc0JkTTc3bXZHMzBqajBMQW5UMEJxSGdYM3RCOUZJNVg4cXMzLzFR?=
 =?utf-8?B?NldEYVJ6SlFPUnU2QkR0TzltYXVPUzVtQ1NGYzJSeHZkcWdmK0hwQW1ac2Q2?=
 =?utf-8?B?b3Y5THo0V1RXTk15eE1TZ2M5eW5NbXVtdEpTOGl4bzB6b1BrRTk3eGZqdlBa?=
 =?utf-8?B?M1ZYQ0lDYmJnV21XK1F5NkZybkpWankvc1BOaExqQzR0YnF3VWJQTzlML2Zw?=
 =?utf-8?B?SEZnbG9nZFhSNC9ZaEU5K2hZdjd5K1hPZXJqTW5Yc240ZGFSR29vbXFub0R5?=
 =?utf-8?B?S2R1bDR6clFLWC9YaWlJdlhvbGY3elgzeVFzM0pJaDI4bkZxK1IzWGpFdzQ4?=
 =?utf-8?B?RXA1QS9aSTZ0a01FSG5Dc24vT0dwbEtDS3ppSzl6bTlHdWVxUjFaWHl6ME5o?=
 =?utf-8?B?OGd3NDV1Mk0vblN3bzR6TkptaEJaV25JL3ZrY1dSaWxWTmRYMGpQWkg5ckZH?=
 =?utf-8?B?aENWTTVrTUtack1iejFsUVUyeXBDenkwSFU4N0hwK1ZWb3htdGI1dVByZ3BX?=
 =?utf-8?B?TFJLMFpiRUo1T3FIbk5CRmJzUU9GdzFBcGpNRjdocFgzdDc2dm01UFhGWG04?=
 =?utf-8?B?S0hBVTdRM290V3ZOS2NNRkYxWEhnK3VVMW92SGl1UDAvc0NhVVdPUy9zWWpo?=
 =?utf-8?B?VE5xZHI3c21YTXpjT2t6Y2FuREM5RUNCUXZrS3lHa1VhRW9DdUxQZGxtVjdB?=
 =?utf-8?B?eVRaZjh4SWdsRHhSbTk1WnBwMDN1bW9kRDk4Q0Nmd1lEZEdVZStYTUlNUGhr?=
 =?utf-8?B?b0ZSSWp2UG4vQzFKRUt6dHlwWWdMVDVjS09nWU5Mc0RTc2phR2I4TWxvYlVX?=
 =?utf-8?B?Y2U3Si9vdDQxbkFaV1d0MkhCM216ZDU5QnFsR1lHMUlHQ2dFbGhOT0NoYlFr?=
 =?utf-8?B?dCtwdzBxMy9ibC9Gb011ZUlmSWloOE90L0s1MC8xN0t2VlhGOEV4SU1KT0di?=
 =?utf-8?B?YkpBWHBxcDhYUzNORENQT0d4QXBxSUVkcUtVdFhHcERYK0JEeVdtYUFmZnlq?=
 =?utf-8?B?RkVXYnFkZHhnREprL0NKYXZHclJHOXpQaU8rZyt2VUdJcjErUzNpRGpDM1FB?=
 =?utf-8?B?N3JJeDhhb0tWTFBPWHFNZWJxU1VGUkpIRXRjVzVCWVhUKzloNFE5aTlEMElD?=
 =?utf-8?B?UWE5UVNGMkNGWG4zb01MSGJiQUg2akNHUEhDZXlIQXNJM3RRMGtFNUVjbFhS?=
 =?utf-8?B?R1RldURoMmFDWENiQXpmU1hkSjNMY2NTTEVxT08yZFpSMFNzTWtMUXlld1Nl?=
 =?utf-8?B?YUJPRmtzaERXcVJad2k5K1hPTzVjWUsvMC9xM251STNpemJPanFiUjhpR0pI?=
 =?utf-8?B?cTkxSHdmbXFWc2dYN1EwUWxVTGhvY2lUUkZObGIzVEY3eUNJcnFyN0xjdCtV?=
 =?utf-8?B?cnhPamNmYmIvQVpTcWJpeWM0WS8vOTlsNDIvaS9xd1hJa2xtcWlOcHltM3Fz?=
 =?utf-8?B?Mk1oOTljWFRybHA0RHhQQmZqaXNGQVRDSkJSUXpFZkJXSG5hOWJPNG9WSWVX?=
 =?utf-8?B?WmoyRnJnRDF3eHdkd0JiNy9oK2NGSXlUSy91NExVUkptU0FBOS8zUGt0OXA1?=
 =?utf-8?B?T0lUQWV2ZFdzamxCUzBia2NZV0dJamxZWFQ2TGxtMFRpSHEyRTE2NXRTUkl0?=
 =?utf-8?B?SE5RQlNFazFNYXlqcXpSMG5FSlFuNzJkbmNvY0tXWVp0MDMwRHc0d2hjSXFU?=
 =?utf-8?B?STlhQnFvY3k1cnl3ZzVzc3orTE5PdkNCaVNBT3dJYlgwYlNaOU5GMHhwVkpy?=
 =?utf-8?Q?xTdlbNKKhFhW8Po4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57881F51E1E99B4FAC24E0D24691C500@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4faa962-c98c-4814-2880-08de5a498f7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 06:35:11.9403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqXHHZsFvkuZ7z8U0YlXtbpqaPd/1RThYGdxVqhtUCF9sMBH8CgavkuLGctIDaiWe3XKS3giOoiikdYSxbyT4sae2svRwOIGqTFdUiK8UT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7481
X-MTK: N
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

T24gV2VkLCAyMDI2LTAxLTIxIGF0IDE2OjM2IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBSZXBsYWNlIHNlcGFyYXRlIG1hc2sgYW5kIHNoaWZ0IGRlZmluaXRpb25zIHdpdGggR0VOTUFT
SyBhbmQgRklFTERfKg0KPiBtYWNyb3MgZm9yIGJldHRlciByZWFkYWJpbGl0eSBhbmQgbWFpbnRh
aW5hYmlsaXR5Lg0KPiANCj4gQWxsIG1hY3JvcyBlbmRpbmcgaW4gX00gaGF2ZSB0aGUgc3VmZml4
IGRyb3BwZWQuIFRoZSB2YWx1ZSByZW1haW5zDQo+IHRoZQ0KPiBzYW1lIGJ1dCBpcyBub3cgZ2Vu
ZXJhdGVkIHdpdGggR0VOTUFTSy4gQWxsIG1hY3JvcyBlbmRpbmcgaW4gX1MgYXJlDQo+IHJlbW92
ZWQgYW5kIHRoZWlyIHVzZXMgcmVwbGFjZWQgd2l0aCBGSUVMRF9QUkVQIGFuZCBGSUVMRF9HRVQg
bWFjcm9zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5
bGlicmUuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL21tYy9tdGstc2QuYyB8IDM1NyArKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtLS0tLS0tLS0tDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDE1MSBpbnNlcnRpb25zKCspLCAyMDYgZGVsZXRpb25zKC0pDQo+IA0KDQpb
c25pcF0NCg0KUmV2aWV3ZWQtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5j
b20+DQoNClRoYW5rcw0KTWFjcGF1bCBMaW4NCg==
