Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83543D58E47
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 03:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0CD883EC6;
	Mon,  2 Mar 2026 04:40:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="bwXbHVSu";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tF8xs8f+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D090883F14; Mon,  2 Mar 2026 04:40:33 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6391083D17
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 04:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 8ccf02c815e911f1bcd7499a721e883d-20260302
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=W7RFJ2aK+p1OxC1arAbX7w64yGbEgvvhNNq9kEHOVQQ=; 
 b=bwXbHVSu5ACuGGcJiUaoO0bW+pX6IQlVtR0DxNvD6LjigDnAQXKvft1fKlPXdMQFmC9ebYOy89V7rz4drUWvfFnb0xIthMOCTjBendp8V8a2V7jDZXWpOY5FSaZoK9wtGk8myNrfV6XAXi2P8wd5XCw5VcZY7mZcesn9VdIe8zY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:7e72759f-8edc-45f9-95e9-d49227b1396e, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:32a020ea-ef90-4382-9c6f-55f2a0689a6b,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8ccf02c815e911f1bcd7499a721e883d-20260302
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 509383840; Mon, 02 Mar 2026 11:40:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 2 Mar 2026 11:40:24 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 2 Mar 2026 11:40:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKvCyjWekFgddf6sK+7sMTP3XE7FmGufeG+SzgB/yUrGWexNXpWF6QmXmsNrLfW91R8Erxt/u32pcjKEwMAT8OtMgSjjfwdh4/sCcfF6vAzI4Ze+sC7hHrQPAbnSzSDqz2SNp4D+AgYLXlUQx7PTpKbg6oCgEvB4/+aIF9Cr6VmMpwTpDjF7R3VxhC/a9sx4nk14Nz/5+h/HpMjI8e3EeUGOhNa7+BfxNX1lfc3KhhgGH0abn40FUwwsslNVKd6STZrT2+MGf1hPWMS9kKHHhcJf92UMHXTNIx/GlqX7SlS17DlUE8GlyYZZr64CHczZCvSHPr6wZPAvSZhVxFky2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7RFJ2aK+p1OxC1arAbX7w64yGbEgvvhNNq9kEHOVQQ=;
 b=wit9xbjK4GM4aHe9nqOe53/+7jqcrPTSukiqfLPjwzZTspwCd7Q660+MnOR5m63ffqFjme4cwsoqKXPTO9mLLJ9sdEgAOcrYd3rlihaYEwi2VKs0jarweS3O8VmsX6YTnc4T0+yWAhIAoYI0aW57HtalnZQrK1B2cKen6Mb7kA56pdyYl/aPy4ur99s8qSGwvwI0gty2WTpkvXAUmF3rl2URO059ZejNinWQhFD9C5aL2GLk+gr2ZPJkiMrrkkaHaoNmJjvxLJ3X5/z+ql7yCW6GVAdR/tOATKDfB0RjBujIr0myE1P3i2uUj9qzOjOEai4F2xr+S8+3kzDJ1/Q4Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7RFJ2aK+p1OxC1arAbX7w64yGbEgvvhNNq9kEHOVQQ=;
 b=tF8xs8f+sEuqQG11VVbNcE0Wtm/6KTIMF0uiTu6VCydQIjOnmVLk5DgvHJjAsKnax4jtAFiP9rAQxUUWwtvrmuo8a6QRnUnkQ+zsDuaorAMcAiKTVv/Rvog9Ogfo9w7ejM5vzl9DQJSRoQ1tpsAL55l3NFxLvXsMxba7ehWO9hU=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEYPR03MB7216.apcprd03.prod.outlook.com (2603:1096:101:da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 03:40:20 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 03:40:20 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>, =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>
CC: David Lechner <dlechner@baylibre.com>, "mkorpershoek@kernel.org"
 <mkorpershoek@kernel.org>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
 <Chunfeng.Yun@mediatek.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "Ryder Lee" <Ryder.Lee@mediatek.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>, Julien Masson <jmasson@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "semen.protsenko@linaro.org" <semen.protsenko@linaro.org>
Subject: Re: [PATCH v2 1/2] arm: mediatek: MT8195 fix mem_map
Thread-Topic: [PATCH v2 1/2] arm: mediatek: MT8195 fix mem_map
Thread-Index: AQHcoYcd7d/8dOlBB0Kziv/jrFW5L7WaqYaA
Date: Mon, 2 Mar 2026 03:40:20 +0000
Message-ID: <42289ecca3d457cb02f5ebe963ab00b9ad5bdffd.camel@mediatek.com>
References: <20260219-add-mt8395-evk-v2-0-18b190d91cb6@baylibre.com>
 <20260219-add-mt8395-evk-v2-1-18b190d91cb6@baylibre.com>
In-Reply-To: <20260219-add-mt8395-evk-v2-1-18b190d91cb6@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEYPR03MB7216:EE_
x-ms-office365-filtering-correlation-id: 00766262-f28d-44a0-c278-08de780d6dcb
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: xR8MhhBsG7C3dGfsTZzgkYRNLhx702ZR5Q7zjFey/9wbUDjSfzYYjbXbCWB9DOxOZvN8P0gv0D9J1F7EguknYIMGPFZaaqMf6AyF4pFs+aA/BQP7bTrwkJxyoZhkCftEcN0YbNE2ObsWa8H9ckCiIQNUHt1N1o76L2Bbt0eC7WITkLm56dN478QvJs9vwIwGn55g5P6YJKvtPxTXN1h8j/4b4T5Hgqpt3gM/xwwFwTpvkMeA2vivVlCah6jWaI0LfIQhiKwQXL5BZ2KAlSkECskfZUhtaF7iwfovb8j1REW8mPow2r/SjZm/h/NS2Ro5WdN55ScYuG7LV/Hg40XvoGnOw2ItW2WuFTCZIxK5YBAKVZ6jh5ln3ukiPtDdnc3XI4rc6jXochxIYEbXYc8MKhcSCxGU8Rn1Jy/R0CGVWLiLQEx71D+aX56NymUwH/aDZNKeTFkyIROxvOhIs0AHAZO9rGso1++rFlngNqiQdz+0ELOY2y60PxJUrvdhXqfc6jeIcG/io3MdMiGVPESv8oJuhEjNmmXrGByfi2QZ4i4TugpDspiyxSRP3Jli3ARtjfzGPMyLht7KEASXCUf9IIjxUTz4BUYKZH1T+XJJOQF1SzMCfh/zcdKZAKpgCQqrYbF+PoGVSDoBozpT1nm/tSE8kOkZfMe8jSSCJvcuiD6T+DK7KTvSlOlhYIkDBSZq8WzoQQhcSfUJxiJEXnFP4H0tboDdxj6KpF4saytFUI/TqXhPJwxf/mv/vPGjLsaWaV0SLGA+tD2kp0tfcrp7KaW3eMBHnd4QBibvGADLYnU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHNBdmcrWWowL2lQcE1CeXhEeTRkVHJTa1V1SHRPb2Q5N256M2lkMHFzcWNQ?=
 =?utf-8?B?Y3ZiZ2d3NmpWdnI5WmYyeGFMbWU3eHVlOU85a3VuTlJYeWlMSG9LQytJU3Fa?=
 =?utf-8?B?NTFQMjIyM1U2dGVTVmE5Qk1JYzE3OFhyUENzdlAydEtkeWxIUTVFQkltK3Ix?=
 =?utf-8?B?aitoTnRrMG9kTXBrdCtrbjd1S1REbjljak1Nc3I4ZjlLd3BSRE42L0N3dnAw?=
 =?utf-8?B?YmVEYkFvM2JHMUk3dTdoQ0t5cDBiaEgzbE1IUkdRT1R4QzlFdlRaUHplaFEy?=
 =?utf-8?B?YnBSSk5jTnFGaDlldlN5SVVpQm9FYlZoWkFoTFBBUHppVHdwOXducUs2dXVD?=
 =?utf-8?B?QUtuRXA2RVVkTllKeUFlYjRNcVduWlhMbXdweWlNZUU4SHVHaU1CdTRZamYy?=
 =?utf-8?B?NlBwUGdRelZJVVJ2YzVheGNiTTMwakZTRUVxKzlkNUc5dnpyc3RRNzYyNnY1?=
 =?utf-8?B?c0lmNTFNQi9iQUVBSDRzUG1Dd1AydGg3OHVBOUNoWU83U3dPRUlRMWJuSUlt?=
 =?utf-8?B?ZmtZQXlEZm1ua3BZaVVoTGttNTVHTFRWMlBlcVZNczQ2ZUcyWXEyNUR5QVZh?=
 =?utf-8?B?SmZQM1hrb0RzSEs4VkxNRXI3dVRneDdRY3o3NFZkZUpMUThMSkFPMFFRQjlB?=
 =?utf-8?B?bFAyYUV6VEhBNm1KQzFaNmxUQTFCaEp2S0pJVWVRWWtWU0JqangwRUtsRnR6?=
 =?utf-8?B?R05yRkZvZy9VajFnYVZBcTgxeUc3d2ljelU5am9sU2hPYnZPb3Q3WjRudjdQ?=
 =?utf-8?B?cW8vdytkZmRNRTZoMkJ3aTR0SUVwSi85VVZpcC9kV0pIUzBiOU90T05aTGFN?=
 =?utf-8?B?cHZld2VWQmxaNGVhcGoxVzVJaU5lWGk1em9YTHlhdGIxK3pRVlRQRDBSaUxZ?=
 =?utf-8?B?MjdRSStqenAyZm5xR0d4KytWakIvSGVvTWsxcFdVQ0RzNTRmSURMZFZNUFJ0?=
 =?utf-8?B?NWlJdWdCL2JtZjRObkJycUpQajZmTUJHVGdyTWNLSGZMV0ZuZnFTbFNGOW1B?=
 =?utf-8?B?N05XalNmUVdhNG5xV1Y1d2o0M0MvUHdyZUcvNzMrcFJBU3FNUVNrNHE3WFN1?=
 =?utf-8?B?VWNNVEdZK0FjdDNtb2x0eStCZ2dKUDYxZ3o4VFJ5Nm5VK1RFU0N6bG9qRDdm?=
 =?utf-8?B?cm54cHVPSklpNWUvMTVTWS9mLzNYbWF6VlZUTlBvQ0M4d2NzOHJKQnk2UXdy?=
 =?utf-8?B?aG9Wb1lWRThUZmhLWFdQMUxlWnNoamNjOXlGUkx2NWtoSGszazR5T2tKTXZ6?=
 =?utf-8?B?ajM4NHVaai91Njl3Mi9qdVcwdWI5NHlqa29aTXZWTzNZYWFvRGFBek9meXd3?=
 =?utf-8?B?TWZDc3VJTnhXbE5laElBaEJ0R25kWWJCeHd4dDRUbUJVc2pTcXBmM1lXaTdt?=
 =?utf-8?B?MFFWSXJEMmFqb2tXVVdTK3hKY2d5aWtGTjlIcDRMbTh4NGxWaGluNXEzOEhT?=
 =?utf-8?B?WU1UMDFlMFUwdzc0aEU2T2s4aEloMXk3djBzVzg5UVBBbkdZN0JiYmd1UnZK?=
 =?utf-8?B?RW80Vi80WUhGeXppR054d1ZERFRROHRzTTZzQkJPNHp2NG11Wm1rRnRXTUdD?=
 =?utf-8?B?Q2ExczNLT0FkbW05NWM4WmZxM25naXpMbVQwSmo2bXQrTWllZDdHTVltdmlK?=
 =?utf-8?B?TnIvRC83a3pheHJjVlluUHdIQktZMVpKVUt4STU3TjFvU1d5ZVQ3R1FGZExs?=
 =?utf-8?B?TTJsSFBGQnBlbDJoanBmNVoxNDd1bWNOWnEwZTlpcDRKQUMzRVZzaUh4ZmNk?=
 =?utf-8?B?ZFBXNlZNdFMrYTVnNWtMK1Zwa3JFN1kxT3JLeWxqM0pyanlqd1NJOVVYditm?=
 =?utf-8?B?empxZ2lYZlk3aWNId2JRSW5oQU9tSm9lb09Ed3Nzc0tkWWs0cUdtaEM2b1c4?=
 =?utf-8?B?N1hRK2UwVGNpQW5PdGlxWWtzN011cVhCdi93YjhhY0FBQm9pbzFDV3VJaTFV?=
 =?utf-8?B?UmlDWlFIdlZPaFFKZFp6VU9zVTFCTHpDdjF5Qnd3a0RCYTVtcXNSNU54WGR6?=
 =?utf-8?B?bEg4dHhQRHRRdjJqN3lDMDRtZXg2RU9kWk9EUCtUVDlDWHhCajFQYzRwVjR5?=
 =?utf-8?B?c2JPYXJtc0cyT0s2Qk1sTlJWMFU1UjZEVkNpRUNxL2c3TmsvVFJ4UkxjSXp4?=
 =?utf-8?B?SE50NSt6M05QQ29tNTlaSDU0eVJZOGx5bWQySnpSQWY0L2JtbkphZXJZZVdj?=
 =?utf-8?B?ZUZXdUl6SDhpeGlPY24zVDNuTHJ5RzloTlJqL3dRbEpvVHVRN0JGeTA0Qisw?=
 =?utf-8?B?MXdtU0NLSkMvK05SdVpnQy9pZnBWUTFOckxCTUxXZm5ibUpSME4wcENOTzhq?=
 =?utf-8?B?NzY4cm9QeTZBV3gxUzNXYytJV2Y1dlFwRHlNb3RpbUhaU2FUZ09lY1MvdUwz?=
 =?utf-8?Q?VJn7+dfVhjvpbY04=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31F2ED68CD302B4E91E1FB349A0F69B4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c5hipUcMrYwye1y3X5ORmNbhXXbP2b1FMBn2Z5tKMvizVziOLyWmv7Xe3E86oGwHFe2I3WxPvWjs2qUGDDPKbkBmwIHUf1Zb74IuOGnCSUho5ZQ0t4HalSh7KY5hfwVTWHihOll38u2DCFQgXslOkga1EgRUkjYNYT6Wu4Xd2ivXQC400gUX0gBJJVKXDflKsP4pfWRJPB/HHC55TOamHS8YoPHE1Uk6TrGFmQ+li03aKbe763aQzvMC4jlxlEUlSZFbehzKuR55Ttk+gEwtFexnzZE8ecWe52WIkHJYeZpE6DcxU4Dcta1iyoZglNysI0PSGezjxV29sr0sWrKxmQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00766262-f28d-44a0-c278-08de780d6dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 03:40:20.5070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qjlP1vUAM4gsQQ12jEoP2kFQyEtQ9N7jYLKbVH1bkH89U5G1vbYVt3uk/7O31amr/HN01mil+gG2MSsGMaFgih4mfRWhvCxIOYJlQrCNmgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7216
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

T24gVGh1LCAyMDI2LTAyLTE5IGF0IDExOjAzICswMTAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gQ29tbWl0IDI1MTdlMmI1MjRlOCAoImFybTogbWVkaWF0ZWs6IGFkZCBzdXBwb3J0IGZvciBN
ZWRpYVRlayBNVDgxOTUNCj4gU29DIikgd2FzIG1lcmdlZCBhZnRlciBjb21taXQgMjRmZmJiMmFh
MTdlICgiYXJtOiBtZWRpYXRlazoNCj4gY29uc29saWRhdGUNCj4gQVJNdjggbWVtb3J5IG1hcHMi
KSBidXQgd2FzIG5vdCByZWJhc2VkIG9uIHRvcCBvZiBpdCwgc28gbWVtX21hcCBpcw0KPiBkZWZp
bmVkIHR3aWNlLiBGaXggaXQuDQo+IA0KPiBGaXhlczogMjUxN2UyYjUyNGU4ICgiYXJtOiBtZWRp
YXRlazogYWRkIHN1cHBvcnQgZm9yIE1lZGlhVGVrIE1UODE5NQ0KPiBTb0MiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBKdWxpZW4gU3RlcGhhbiA8anN0ZXBoYW5AYmF5bGlicmUuY29tPg0KPiAtLS0NCj4g
wqBhcmNoL2FybS9tYWNoLW1lZGlhdGVrL0tjb25maWfCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4g
wqBhcmNoL2FybS9tYWNoLW1lZGlhdGVrL210ODE5NS9pbml0LmMgfCAyMSAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW1lZGlhdGVrL0tjb25maWcg
Yi9hcmNoL2FybS9tYWNoLQ0KPiBtZWRpYXRlay9LY29uZmlnDQo+IGluZGV4IDhkYTRiYTVjZWFi
Li42NzFhNmNiMWNhZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9LY29u
ZmlnDQo+ICsrKyBiL2FyY2gvYXJtL21hY2gtbWVkaWF0ZWsvS2NvbmZpZw0KPiBAQCAtMTQ5LDcg
KzE0OSw3IEBAIGNvbmZpZyBNVEtfTUVNX01BUF9ERFJfQkFTRV9QSFkNCj4gwqANCj4gwqBjb25m
aWcgTVRLX01FTV9NQVBfRERSX1NJWkUNCj4gwqAJaGV4ICJERFIgLnNpemUgaW4gbWVtX21hcCIN
Cj4gLQlkZWZhdWx0IDB4MjAwMDAwMDAwIGlmIFRBUkdFVF9NVDc5ODcgfHwgVEFSR0VUX01UNzk4
OCB8fA0KPiBUQVJHRVRfTVQ4MTg4DQo+ICsJZGVmYXVsdCAweDIwMDAwMDAwMCBpZiBUQVJHRVRf
TVQ3OTg3IHx8IFRBUkdFVF9NVDc5ODggfHwNCj4gVEFSR0VUX01UODE4OCB8fCBUQVJHRVRfTVQ4
MTk1DQo+IMKgCWRlZmF1bHQgMHhjMDAwMDAwMCBpZiBUQVJHRVRfTVQ4MzY1DQo+IMKgCWRlZmF1
bHQgMHg4MDAwMDAwMCBpZiBUQVJHRVRfTVQ3OTgxIHx8IFRBUkdFVF9NVDc5ODYgfHwNCj4gVEFS
R0VUX01UODE4Mw0KPiDCoAlkZWZhdWx0IDB4NDAwMDAwMDAgaWYgVEFSR0VUX01UNzYyMiB8fCBU
QVJHRVRfTVQ4NTEyDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW1lZGlhdGVrL210ODE5
NS9pbml0LmMgYi9hcmNoL2FybS9tYWNoLQ0KPiBtZWRpYXRlay9tdDgxOTUvaW5pdC5jDQo+IGlu
ZGV4IGMzOTk1NTBiOGZjLi4wZjY4YzU4OWU5YSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFj
aC1tZWRpYXRlay9tdDgxOTUvaW5pdC5jDQo+ICsrKyBiL2FyY2gvYXJtL21hY2gtbWVkaWF0ZWsv
bXQ4MTk1L2luaXQuYw0KPiBAQCAtNjgsMjQgKzY4LDMgQEAgaW50IHByaW50X2NwdWluZm8odm9p
ZCkNCj4gwqAJcHJpbnRmKCJDUFU6wqDCoCBNZWRpYVRlayBNVDgxOTVcbiIpOw0KPiDCoAlyZXR1
cm4gMDsNCj4gwqB9DQo+IC0NCj4gLXN0YXRpYyBzdHJ1Y3QgbW1fcmVnaW9uIG10ODE5NV9tZW1f
bWFwW10gPSB7DQo+IC0Jew0KPiAtCQkvKiBERFIgKi8NCj4gLQkJLnZpcnQgPSAweDQwMDAwMDAw
VUwsDQo+IC0JCS5waHlzID0gMHg0MDAwMDAwMFVMLA0KPiAtCQkuc2l6ZSA9IDB4MjAwMDAwMDAw
VUwsDQo+IC0JCS5hdHRycyA9IFBURV9CTE9DS19NRU1UWVBFKE1UX05PUk1BTCkgfA0KPiBQVEVf
QkxPQ0tfT1VURVJfU0hBUkUsDQo+IC0JfSwgew0KPiAtCQkudmlydCA9IDB4MDAwMDAwMDBVTCwN
Cj4gLQkJLnBoeXMgPSAweDAwMDAwMDAwVUwsDQo+IC0JCS5zaXplID0gMHgyMDAwMDAwMFVMLA0K
PiAtCQkuYXR0cnMgPSBQVEVfQkxPQ0tfTUVNVFlQRShNVF9ERVZJQ0VfTkdOUk5FKSB8DQo+IC0J
CQkgUFRFX0JMT0NLX05PTl9TSEFSRSB8DQo+IC0JCQkgUFRFX0JMT0NLX1BYTiB8IFBURV9CTE9D
S19VWE4NCj4gLQl9LCB7DQo+IC0JCTAsDQo+IC0JfQ0KPiAtfTsNCj4gLQ0KPiAtc3RydWN0IG1t
X3JlZ2lvbiAqbWVtX21hcCA9IG10ODE5NV9tZW1fbWFwOw0KPiANCg0KUmV2aWV3ZWQtYnk6IE1h
Y3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQoNClRoYW5rcyENCk1hY3BhdWwg
TGluDQo=
