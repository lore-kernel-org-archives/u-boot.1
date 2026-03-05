Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A589EF33A62
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 13:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6E5B83EDF;
	Thu,  5 Mar 2026 14:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="hJ/paC8Y";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="aO0Nlr0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57DF083F2D; Thu,  5 Mar 2026 14:54:49 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F045781E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 14:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: dc6a412c189a11f1a39cd589f645bc18-20260305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=ljKseAqK2M09s3i2LUTSR8wRMra+w8NmPPzwAEa7ojQ=; 
 b=hJ/paC8YKlZVJHoUpq3+wP5xqVWENngpCKG9mcoZWOVNVRo6CNKO34pxIjfl1Ba1urWHmL2N56CUaHj2Bef8a+Dje9xjhhw+pnvJipnWywR0W3vgRcd38C/ucJtAW/+sRKkIzr8Yf9M7E5rsA90f2lmd2eUuNX4l1JS+CRRfTL4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:c4a927bc-5bfa-41a8-bd49-51fbbf611244, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:947648ea-ef90-4382-9c6f-55f2a0689a6b,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dc6a412c189a11f1a39cd589f645bc18-20260305
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 879895929; Thu, 05 Mar 2026 21:54:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Mar 2026 21:54:41 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Mar 2026 21:54:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b753foNngETBYl3mCHECyNfwVPuu41mOu+RSIAlPrb1NdQiTGVQ1iWufjKdPNbyo6prgQGh0xyQwz52+edn0JQWRWBkqxY7cu0IuMTaJutpy55cpl09rYhlJoFyR35iuc2+XYa5Pyet9hjH4Ctpu/KR/nfQOWBPrD3OkeFISg7/7XctUg4IvuHjv7wJjmluR3ek/ostzcomIbJG2/olgcHSNQqcUqWZ+rFQo9hQu5PGDKbgJVtQK3vSqhNuCPKG5N1G1Pp7yWt3M8Q907YQolaJd5PPpR69oDr3JzSveQPRtil0O2jTknLGijxOEZ+9xuSf1KMMU/gRhgnpeT6hxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljKseAqK2M09s3i2LUTSR8wRMra+w8NmPPzwAEa7ojQ=;
 b=R+WwgxYWiJdDLbhew8NYBuqw00bAOD6FRb2Yi/TLwhS9zH/ULOvqf4Ln6feTo/mMHH1seNvyozPXhgSlUjozFEPC38CgwpUJF1pY1GP7dIHmAeASm59sIatYHubUx1MfE4vLEDyq+AGtatpGyXOOsRLtu8hledPbo5KyxlfmLgUUl6zX+oE7/iEr5Xbt1nrSiH04+VMi4TVErGzywraoNBebMPXanDuJYhplpXmlxm2y03OjOFTg7w6tSzPIdHS9cXSlpFoftZvsJkcx1+TZqMeDsQMfYslpnTcUd7B9xRcRHwhKP0V70ZKQHqoJniy0kAqJh8QXTaXyPASfkZUp+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljKseAqK2M09s3i2LUTSR8wRMra+w8NmPPzwAEa7ojQ=;
 b=aO0Nlr0HfKXI/l5AYJPH6LybnwxECRxPFFQmjUiLL25B81i94bD/5gT/AXnhZEhiD8nC5QitWxhp5WU6GJ1sCUcofAFSUlVHH9Nbx9UJMBL0uq5fosP7AXmAndqrtMiv8WrE7VKZqy/QrMeY8uyDB7KRo5B97DZbs3LWfLIU77M=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KUZPR03MB9734.apcprd03.prod.outlook.com (2603:1096:d10:61::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 13:54:38 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 13:54:38 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "lukma@denx.de" <lukma@denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Ryder Lee <Ryder.Lee@mediatek.com>, 
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?= <Chris-qj.Chen@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 09/14] clk: mediatek: mt8365: convert to struct mtk_parent
Thread-Topic: [PATCH 09/14] clk: mediatek: mt8365: convert to struct mtk_parent
Thread-Index: AQHcqqHpWgDhvp4hsUaQngPScGrAlLWf+fGA
Date: Thu, 5 Mar 2026 13:54:38 +0000
Message-ID: <f462498df79eaf247c9a71a6b40c0e97bbadbddf.camel@mediatek.com>
References: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
 <20260302-clk-mtk-unify-mux-parents-v1-9-32f45085f4d0@baylibre.com>
In-Reply-To: <20260302-clk-mtk-unify-mux-parents-v1-9-32f45085f4d0@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KUZPR03MB9734:EE_
x-ms-office365-filtering-correlation-id: df158b14-b894-46fd-1ad2-08de7abebe3b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: A9DvVmXRXBefkOycxWDfFsAnrbZoOujn0QY+EfPwY0l+CNqkuSTBM/HGIVl90b5iwyboIoAKV+ZNkAVSDPFunZl7pf2XsVZZbXDmkipApIB20s2Lb6aLR4tCAIh9MdjLmkHtBJtWzAKwG5jdRYQyYC9dUvdzJkc0eB7DCdbdERn1Mn64K8usTgR+m73qlf2fH4v528Sz+HedVQkJsMeySFMFqZ8T/WK/n5tQlFLDotdeLEcChG53yZrjJafh9wzY39M1g34kew8sEDALJsMABb97PBIaaffv9LyYBTFgNew6lgtqSOT1ZYiD5sreILn5IxFKBSp5DMz7l6ag3ZUDzSu+Pu5Sj8wTb7zmSOCNZ8K+Ie5Tsrf19VYS7yOqEjHEB7mqGcsHKCTL/D03wF1QP03hHabyezYntITZFM5cJg/XXPVtxWYQo3lVEaVYmEHYLQ0YwvZD+udbq/PYv9C4+S/8GhAXKmAkr67zdv0BRpTMWFHi9HVhg5a6McliP8H5PCAkEmTnvpAho3VzfK4s83wWVHJE0fRNCjD48E4xN6179R6+qKc1ZAK+IX5FjQWXMq+gamquL1gWXcQase1xNJ1UF5FmfAUvJZJmEIi2VeOWpM2E6TJBu4OxGR/GV6Yz+gRkIwjRQMKkf6ZF408qD2R0w8CtuMU/G+xCPHPsF/W5mQsrPotPMJ24GuLfezA8CvPlZXDhqEmRf3QcXHX0FDZGrp7Wh9Rxm4zhQH8escaBiuKI4KS52yZi0bChhKeag3O7yPIMz9JLtO9Rd4sPPmMH/S3tNWxFZ2gkIABW5kEXOujVhNqKJii4FTO0n7VW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cCtYa29XbEJvcitSTkNIemxjUHNIR21FamQ4MGdmazhlcGc2cktsT1RYMFZk?=
 =?utf-8?B?VWorQWh3aS9EbWYrR2lCVUZDdTcwY1Q3WU0rQTlzbWRJY3ovamhKcXI1R0xD?=
 =?utf-8?B?Z3BObDZwSk9EdFhhZGxCNmJmYUdTOVRwWnJuZERyWHE4a0ZHZjVkdkRSK3JR?=
 =?utf-8?B?eDRoUlZGVmF5NU4xNW9jd1hscVFvVTNpYVFZUnUrTUd4dEtRdU1vU2kzTThP?=
 =?utf-8?B?ZUNYOElrNVlhWGpTOGhTSUY1NDFjQktoTFNPNEhaNTFQQndsNmVaQVphM1dI?=
 =?utf-8?B?NTZRN1JHdXFrUm5QNjBuWlNzL3dsbUpYZ1NtUkpZLzJZeWVJTFpDZXRjRGVU?=
 =?utf-8?B?Wm1pRVREQk82YzJ1eUhrQ1pWRVpWSnd2M1VtU2RKbUJ1S0tZWW01OHp5SFl0?=
 =?utf-8?B?SnZRSmYyQm9OM0RQNkZVYU5FejczQUxGQUx0L0drOUx2T3RpVW5ERkVvaU5C?=
 =?utf-8?B?YnVndXV2cGlsbFBhQnlFZjZWZmZOUTNkSE1IVXRjNENFSzRza0owQ1ZWbjIv?=
 =?utf-8?B?aTZmcEZDOGNrbThPYWMzMGZ6Ymc2MjhXbjloeWRPNWxuL1NPampsVlNsUEZ6?=
 =?utf-8?B?eHBpa1FBWGozME90ckVDYjFMQnV6YUFEblE3ajdFZmY3b25EbnFTRm9tV2tu?=
 =?utf-8?B?VUlvM0hLcWVDVk5pbUtaSlVQNnVGS29CRVhaVlB3MEFsaHh1ZTBJOE10ZVo5?=
 =?utf-8?B?d3FjLytiNUFEWitUa3p6TDBQYUVRZG5obHpLK3BPSTMxZEI2Q3hhYjM4UmpZ?=
 =?utf-8?B?aDU2OVZMcUIvTlYwdUx0NFEwN2F3aW1EYmdrSVNOM0dzemg5VTF2aDJybXVC?=
 =?utf-8?B?ZnROQ3dNVyt0SmlUT0dmL0JjV1pLcFdwM1l6MVhSVDUwRUF5UXJXamw2SVZh?=
 =?utf-8?B?Qkp1YlA3aWRlc3JRc1dybkZ4MmZlVHdBODU4QU1Gc0xWMlppQnVObjkzMUdr?=
 =?utf-8?B?MTZVVEhPR1d1c2ZvVVU0V3QvSWo0bzJkK2swRjZkS2taZDlVREs1YkRGTlls?=
 =?utf-8?B?MlhkZjhWbDBWYXVxR0RnSWREcElCSTY1a25aaDJIcEl4S0N4RmswNFpDYTl3?=
 =?utf-8?B?REcxNkJvT3htN0M0OFR1V0h5UWhkTlJ2UTBGUTZUaFFsUW4zT09TK2lTVkN6?=
 =?utf-8?B?TktvaVI2ZGJmdUk3cVU0aFh3Tzh6WGlEMTFFZGlmeXFUVUhhVGpCN0NqM1Bh?=
 =?utf-8?B?SmhPZHRCblROU29HWk84MERwMFAyMndtanF5ZlRCb0FZWjJOYmRlL2RvODYz?=
 =?utf-8?B?WWI5NEtDeCtQb3pjTEJSWjQycVJHVGFCSjBlR01CREJXK0s5M2svSzBTcTlE?=
 =?utf-8?B?emZvSUVnOGxicGZpM3NyRDhzWEhOL0Y5OUVYSEZoRFJPY0FzMzFLRlV1VHNZ?=
 =?utf-8?B?MURhRUJ2THl6aS9jbWNtUTdFTHFHTzhXNWpvVmQ5ZkZRYXlQNXpZcGpIYWlr?=
 =?utf-8?B?VURkVDVoZ1NZMjk1T0JuQkd4MG1LNnN0ODdWbFlVN3MxTnFIVmJVZFhIaWQ5?=
 =?utf-8?B?U1RhVU9aajFTcG5zaENQcDBtZHNBb0ErRFdsUVArcUx1ak9rRzlzbE41S0xT?=
 =?utf-8?B?WjlVYzZubXVXYXpZSmJ2bXdLcTVzWkZkTFhueFVYS0VVanpEWlFySzBhRFU1?=
 =?utf-8?B?ZnpwMHlCeTA5ZVlQbjRXbmF1ZEFsMy94R2lqUjMxMGdUUzNQTzhXN2l3SDNJ?=
 =?utf-8?B?VTBJaHRHclJsU2U4dzdpVkVaMWE0aG9Rb2ZoN3hHK2V0ZVY1cXBQeW5GMFdn?=
 =?utf-8?B?R0JFQ0dQUlFyUXA3U2RxRTQ1ck83QTBOQnN0R2Zpa1lLcVlHTTBxb1o5Nmxx?=
 =?utf-8?B?Um50NEVmSzVPVkFhdmYzMWZNZjFnQ21pUE9jeWdwZDhoOTRkYitqMEFiL1dJ?=
 =?utf-8?B?ejNUMmd6QVNEbmNYZVF2MUt2a05MUHIwaE9Xc1VNcERmV3VKdGt5SHNkbHFO?=
 =?utf-8?B?SlpOVGJtVk1HL0hXNHRaMUU2cHJZVXQrTGI2d3FpY0tQQ2FVOXFaZ3NJV1RW?=
 =?utf-8?B?RFZ0Q2t5OTBTdGZSR3dCS3c3RFhTZE5YWVE4emZQTzFXQ3JXRG5mQ29Wb1Mv?=
 =?utf-8?B?Wkp0R1crM205eStnQ0gzTE1zMVRVU0JjOFNkWFpNTzlzUUIyYm5sbEFZMjMr?=
 =?utf-8?B?TUs4RkFrSW50THNuOGZIcHJuZ1JXOHhNMm1abmxuQXZpOEdyTXVzdGhJUVFB?=
 =?utf-8?B?a0c4MXpGMUxSZnBTeHRUYTFDM3FiVHVlRlplY0lyZzBJdjRpek4wMU9jTjlQ?=
 =?utf-8?B?ai9IWWhyY0JYZFNraW1YWHhqRmJkRVA3cmh1eVJsa2F0UE1WOXpJTFRXUXJ0?=
 =?utf-8?B?cWt4YVNIY29kVlZLYlRydml2bVlyYllCbG9QakFWanpNc1BRYkw4QVFGYWc3?=
 =?utf-8?Q?IZ+4jvx3oTmDe9+4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB831B6EEA74044298AA149897771367@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uDhBIVpioChApsavCLEgh7IX1wahEiNe2hxdbHlDY8b6325sGimuQhdcPQngcPO1707djhdFJPVnqL/HgkEdxBcqfak0dq+igrlKan5Qq0By8uUSw4jCB8YVGo+aT8qT311V8RR2iIGkNLkEpMkcHKwbVhCujVN0dG7931SAr6Stb9mtw9H15h8O/o8gebKN3ZFvTg679ZDcokpboubZTJP7LYU+cYFMWXqggVncw9dgt8r639tVcmWa0eTo31WhQobMYCRrVHVDmPph4o65I8v2lP3uFglC120NqOh0O5ahEM+/0CFxKWL7pHqA/brlV5skK5nJPm/5QMz57s9Qhw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df158b14-b894-46fd-1ad2-08de7abebe3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 13:54:38.6858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUZEqxR+tTkVboFrPOklm4nW+RKhEdMiGoshc0NDRpk2X/0tBxXa2ImSEPkL93ykNKPJAtgMYnIR2zYpFiyj+AVoYMVEgE0uumjdArR8BxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9734
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

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDE4OjAzIC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBDb252ZXJ0IGFsbCBwYXJlbnQgY2xvY2sgYXJyYXlzIHRvIHVzZSBzdHJ1Y3QgbXRrX3BhcmVu
dC4gVGhpcyB3aWxsDQo+IGFsbG93IHVzIHRvIHNpbXBsaWZ5IGNvcmUgY29kZSBsYXRlciBieSBo
YXZpbmcgb25seSBvbmUgcG9zc2libGUgZGF0YQ0KPiB0eXBlIGZvciBtdXggcGFyZW50IGFycmF5
cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJl
LmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODM2NS5jIHwgNTIy
ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gLS0tLS0tLS0tLQ0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAyNjEgaW5zZXJ0aW9ucygrKSwgMjYxIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgzNjUuYw0KPiBiL2RyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdDgzNjUuYw0KPiBpbmRleCAyYjE3MDNlNzIwMy4uNDFkZDI0NzljNWEg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgzNjUuYw0KPiArKysg
Yi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MzY1LmMNCj4gQEAgLTI5OCwzNDcgKzI5OCwz
NDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZml4ZWRfZmFjdG9yDQo+IHRvcF9kaXZzW10g
PSB7DQo+IMKgCVBMTF9GQUNUT1IyKENMS19UT1BfQ0xLMjZNX0Q1MiwgImNsazI2bV9kNTIiLCBD
TEtfWFRBTCwgMSwNCj4gNTIpLA0KDQpbc25pcC4uLl0NCg0KUmV2aWV3ZWQtYnk6IE1hY3BhdWwg
TGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQoNClRoYW5rcywNCk1hY3BhdWwgTGluDQo=
