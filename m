Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860A4CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 181258488B;
	Fri,  8 May 2026 14:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=airoha.com header.i=@airoha.com header.b="YZ9L8rNd";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QK3f1RBo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F22F884AD9; Fri,  8 May 2026 07:14:07 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28E0584AD4
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 07:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=airoha.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tommy.shih@airoha.com
X-UUID: b5e693284a9c11f1a4e839cc21f16abe-20260508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=airoha.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=xknTiDuiuYyyZ8bsoZVeMOJQQ9rj/EI/moHz2jEcymo=; 
 b=YZ9L8rNdGc5QuqxhyqWL9ya9Ks44BM7g4eNAG1jiJpDLcXPQXaQUGhmchYx9RGlXxScQkVz71u51gTwqA7Jq1Nv4ioUahfgI8p/PHovTBT6c9G1iSHkwcghQsQ40D3vz2pvDQbPXYRmN1wiiSgrgEAU+/bx7/zeYLbJ+3z7LVcw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:433c79ce-5eb6-4165-8b64-cae546526528, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:f0fe4845-8360-4d24-8500-9b9380fa4b0d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898|915,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,Q
 S:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
 RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b5e693284a9c11f1a4e839cc21f16abe-20260508
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <tommy.shih@airoha.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1054027425; Fri, 08 May 2026 13:13:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 8 May 2026 13:13:53 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 8 May 2026 13:13:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSVWByfbCL53EXr/myMFT0B+ml6JiLdOv8PH7KNCUFLK0utVM/X94nvCaDPFavx4fgTEcQHvZph01SuBtjSCR8CCAzu41qgtsxa2gGE6qsNjutXdRgqMXL4QDIrkj5fxvsQQHp++ROIr529fN3k0ENvEiD/tgbgWi0Gi+f1Mg9spTwsHLAgpyhN5bIQvTLRM8GpHFer0DpWaKVw2GSicQj5DHSk5GcBDS0R8vOYByzrL5zwQ/28KjHNkaT3MiGCAflHm1vzQEpet9zn3LkipP7UEI1eAzGZuM07Q6jtFxq3LqgrLdrS4yipb7Vce1AM+ciiLt/a/LZUKqharHkNdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xknTiDuiuYyyZ8bsoZVeMOJQQ9rj/EI/moHz2jEcymo=;
 b=VxpGDcOVq1UU+wqOeEj6G877pDCaOpIudgyKxxhTM0VoZqj0CZqIsSDrMURrSGwSciEJQcpnneQQ1UJQQFXGZ+BoHChie6CxCiiA0LkkYPtbfJKwok4TrgRYh8DnsmgUj1+Lm0waylOkE7sI8budiQ5vjOgC0x2otCDYtLdnPmgkz3V+H/pYuhC5LzbwJ1WL3ikdnUgsWrQ2zKRa26u6tBsp3fno/IWuh+psbh7j35XXL/f+FLMFezPW4qsYDLDKLs5iv8QyXyUaJmKpflyP3U6ZMNhDuZ6SqsEvVNYxnqAsz5UJzJcQcwoN6vqmb5/0kpHUP+ZGD0SE4606q6jiUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=airoha.com; dmarc=pass action=none header.from=airoha.com;
 dkim=pass header.d=airoha.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xknTiDuiuYyyZ8bsoZVeMOJQQ9rj/EI/moHz2jEcymo=;
 b=QK3f1RBoj0THfXiPc18gAg+Er+p0+QBgrrGwLi8ZS5FJVD2iakHPzdiwoXjX+LEabR/43ZDCX+5gwQv/sDah4wLnqdTiWvX10QONh8+a2K76RgGUi6XPW3xn+LuNM8OZ9dEc9ilXXBIOo32uW/XQCLz2j4Vyru1l8nrKaJxFguI=
Received: from SEYPR03MB7816.apcprd03.prod.outlook.com (2603:1096:101:166::7)
 by KL1PR03MB8475.apcprd03.prod.outlook.com (2603:1096:820:138::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.10; Fri, 8 May 2026
 05:13:50 +0000
Received: from SEYPR03MB7816.apcprd03.prod.outlook.com
 ([fe80::84bd:8c8:6669:c784]) by SEYPR03MB7816.apcprd03.prod.outlook.com
 ([fe80::84bd:8c8:6669:c784%4]) with mapi id 15.21.0025.008; Fri, 8 May 2026
 05:13:50 +0000
From: =?utf-8?B?VG9tbXkgU2hpaCAo5pa95piT5bu3KQ==?= <tommy.shih@airoha.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Julien Stephan
 <jstephan@baylibre.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, "Jerome
 Forissier" <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Robert Marko
 <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>, Yao Zi
 <me@ziyao.cc>, Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Lucien.Jheng
 <lucienzx159@gmail.com>, =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 =?utf-8?B?WWFucWluZyBXYW5nICjnjovnh5XmuIUp?= <ot_yanqing.wang@mediatek.com>,
 Beiyan Yun <root@infi.wang>, Ryder Lee <Ryder.Lee@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, David Lechner
 <dlechner@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, "Kory
 Maincent" <kory.maincent@bootlin.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, "Raymond
 Mao" <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, Stefan Roese
 <stefan.roese@mailbox.org>, Philip Molloy <philip.molloy@analog.com>,
 =?utf-8?B?RmFueWkgWmhhbmcgKOW8oOmAuOW4hik=?= <Fanyi.Zhang@mediatek.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Heiko Stuebner <heiko@sntech.de>, "Samuel
 Holland" <samuel.holland@sifive.com>, Christophe Roullier
 <christophe.roullier@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>, =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?=
 <Macpaul.Lin@mediatek.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
 <SkyLake.Huang@mediatek.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 =?utf-8?B?S2V2aW4tS1cgSHVhbmcgKOm7g+alt+aWhyk=?= <kevin-kw.huang@airoha.com>, 
 Peter Robinson <pbrobinson@gmail.com>
Subject: RE: [PATCH v4 2/9] MAINTAINERS: add maintainer entry for air_en8811
 driver
Thread-Topic: [PATCH v4 2/9] MAINTAINERS: add maintainer entry for air_en8811
 driver
Thread-Index: AQHc1+B1ihT6lal6qUG93LC1nLUVJLYCZH4AgAE8+TA=
Date: Fri, 8 May 2026 05:13:50 +0000
Message-ID: <SEYPR03MB78166D03CB3AE95B9D11953AFF3D2@SEYPR03MB7816.apcprd03.prod.outlook.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
 <20260429-add-ethernet-support-for-genio-520-720-v4-2-be54e17239b7@baylibre.com>
 <5b9d85fe-b5a6-4cd5-8d32-bd5e210aa557@cherry.de>
In-Reply-To: <5b9d85fe-b5a6-4cd5-8d32-bd5e210aa557@cherry.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=airoha.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7816:EE_|KL1PR03MB8475:EE_
x-ms-office365-filtering-correlation-id: b657aa42-d212-4c25-9ea6-08deacc0972f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: swQepbovBYTXWKesfAucsUFayNnISL2zM6DwRE1srRgmQKN0C+1LExMaldM0HCcFrM+yZ/b9WZgFU/K3+t+kCTPxGl/PowwSXevseB7WDsD1YBUnt4dnUnXhS1GGPr6GYa89HPQqS22sH1e4otnL4+cLA8zfkz0jGlQbTLVE6Kj7SMgKpBFuiiudmE2z/7COjZngqI510XYEO2bPQTMjn3ZZB6TlJlBYaoLZwxfKNyhBrOz7Mg7m9l1eww27wpjfNvKMx5swpsCUje4j/8bPcBIV8exisAYqL3JzwCEKU5LRW8UdrZR4993AqmMKkp9K6A6iJ4Ixjwwm3xr0jtaA+uOH20qw0ZPa6Qa+JgNFQGbWAKdm4kmphT28oh8La8gwOi5HakUB/+90YSyz9cbmCNib+d2BIboy/Np4mtcrrl22hddvTFBsz/M8W8HPPuozNXwAouy6EE74wRKZwu8l6tSrRxsHvO+8yhhu1MCzyTewsYyxHwovPRwXAo/WwHRYOMPwEqxfJLCEJviRemQbG5z0Hp1XWUj4Upweo0TAg73lz4dwbuvpx6d/3o7skKVjvaoWZ1T3YpHFsfZJa/2oZ2cYUpeSgxr/5N/g2drg23Du4hepYpvLP68n/JS+5hWLJXQkYKaEO0RFLdthPdZHqtjlqjky8VqhCG9Jgxzu3NQHEb9lQ68qn8IYIsTO/V4CbKhy2MmY/yYke7Hjzw67m+pHlzoKA/WjAImGyOg6+NAocCaxqqUx5i0h2wb2sadq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB7816.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3hQME5uY1lUakdxUlc4bjE5Zzc5WU9oVDlzM1pEOGFhOU85a3YxWWFERkRX?=
 =?utf-8?B?RFI1eTQ2UGpURG9EaW9rTEl5aWlnQ2NmcGRBOUdxYksvZTBuYlQ2NVB0Y2p4?=
 =?utf-8?B?UjdFaGJPdm9TZXFmZXBRQ1RPak1Ga1EwQzZZK2EvdHhPRzl6STlsRkNwcm91?=
 =?utf-8?B?VFBoOTdEQWZaeEJqdWhQbXVEWFVvM0lTTndLd3N0dUFMNDZyMnU4YU45dHNi?=
 =?utf-8?B?d2JkdTRsVDJUcGJFYnJtM1BybEJvdTVMTjExVzJWRExhZ1RpbTZOeVkvRURE?=
 =?utf-8?B?YjRlZ2lRUEZtTTVzUk4xSVpBNllTY3c2dnFvVHlzWHE1bGFjRzc1R29qRkl1?=
 =?utf-8?B?cUwvYjN6ZUU2dDc0S2VGWXJHbm5QUmxpQnN5SkFBaVZuVXRITXhZc2N5cS9M?=
 =?utf-8?B?dmUwT0VmSmdXVDU3OE9mRExRMVdvZThlTlBUbVQ4RlFLYUozRDI4Y0x2SENl?=
 =?utf-8?B?SXNYNlVWZTN4VHRzU21sSDlTd0srUmtMMHFrZktrQTBCTk8rdVVCV0NqQzBP?=
 =?utf-8?B?b21HcmxQK3dlTG44eU8zbUVjWUxJS0oxZEw4Q1Z1NllqMi9FRFFYVWRNeVBt?=
 =?utf-8?B?bDBCMGtDWFFkOEVjMTFBam9kTGRHRXNaY3hSdXMvRi9SOUVZbHpIYUJpRjBK?=
 =?utf-8?B?LzNQOXZXMVMzc3FFWG9yZFBlbmRTZ1RMQ0g3QkdEemJtbFpEdld1eHExR1lB?=
 =?utf-8?B?ZmgyU2diN2tuMzVSQ281STRtZFozZThCaDR4Q2M0OGVPWWtMMVdubUtNaVFG?=
 =?utf-8?B?bGtiWDJ3ZjlYUXgyZ2NveG83Z3RQMTB3V1RqZE0vSzQyMDgwbVBkQ1lmblVD?=
 =?utf-8?B?bXlQSXVXNUdOdm1jNEZQTWFXL1Uyb0FBYVNZbWRVUzlDMEFXL0FoK0pQeGww?=
 =?utf-8?B?OXMwWWxEVEZVUVhJMGZKN09zU05objN5YXFsVXB4Rmh5SzBDTGlHdTJ3VnpK?=
 =?utf-8?B?RzlKQ1RrdUtENldDQWI0TFZnRnRiRkpBNktnRDdPR080WEUwckU3VkR4MVZC?=
 =?utf-8?B?M2VaVllKdmF0OWs2cjhCcTBoV3ZEeHNEcXZOek1rMHFhcWh4VXF3MWk5Rk9W?=
 =?utf-8?B?NzMydjkwNkxRREQrazFmYm01Yk1ibjdvTURJdkpOQnJabnp3UFY5Q21EOEtW?=
 =?utf-8?B?ME1DVUJqT0htN2xDV1BaU1FaUmdneGkzN1h2dlVlckdEc0xQdzZiTm90RmJT?=
 =?utf-8?B?b0Fyd2NpQnc3VFRlQ0kxM0paT2FZRzZCaytsTzIvc1QzYmFzc2hFdEs0OTZM?=
 =?utf-8?B?UGxYVi84c0NZelY0b05uMnF6bDN4NWtudlRJTmNGTlAzT3NFcnRMeVFVMzFm?=
 =?utf-8?B?OEtSSnZxWUsrZUdObWVEenBOYjVpYm14eWRlcWNMbHJYdnZkRk8reSs4bTBM?=
 =?utf-8?B?Z3hpNmxKeTc2M1pXejV5ZGxxMXMwS1Y2cWpnUjdMeHdnaFJteWg0YkFKNER5?=
 =?utf-8?B?K0NIQjlhd0VjSHVMclFzVUIxMFB6TloxUzBQRk93WGh5S2Fwak5hVW9FaUZ5?=
 =?utf-8?B?anhiY1huTEhtNE81b3JKc3BuVlJLcXoyYVFCK2xmdFRudGtqRUp5dk5ta3lB?=
 =?utf-8?B?ODU0QUhEMVJ4VmNSSVkyYW92UGxsWXpiY1oySEtDUXhVSFpObzlMQ0hYZ2RR?=
 =?utf-8?B?Mks3eHlMU1UzM0ZxYnpySThxNWFLNVh3Q3JGcSsvR3E4TW9ieEZsWVN1NXpB?=
 =?utf-8?B?a1RIRGk0LzdsOW92bzMvU2RVTlZ4S25jME1rZGZLeHZTOFo5Y2VpbU1UczZ0?=
 =?utf-8?B?cVF3ZmVOTnphU0FnekNQZXNuYjVsSXpJWUE5RC9GdHBkVjgrVU04eUNIOTBJ?=
 =?utf-8?B?dThVaDYrNzU2Y1RZd2dpTWFBM25YcXJUamdveVBLdEZ6SjJTYnIxSHFiRU8x?=
 =?utf-8?B?WkFFZXB1NDV2ZjZJc2tvUzBINnI4Umlxd0ZxOVdZaHpUUHMzYmdZT2lQZVQy?=
 =?utf-8?B?a1NCNEVDU09ralVTRVpxK1BqeFZOd3FrelQ4L1B6WWxxMm8zYjB0dE5aZXhO?=
 =?utf-8?B?YTFleTBhMllIUjRnanBmTDJySEtya254UG9vT2lMOVhMR0Z2VXphS0ttZy9H?=
 =?utf-8?B?eTJMSDFoNmJYSlJHZ0R5T3EzZWoxVysyYjhmV0tnSkhTZGltRElNZ00zc3JV?=
 =?utf-8?B?bko3K0xXUXdRMzNCVHJINnZUenQ3bUxoSVRLMXNvMHZNclJKSVIrNVJHbGxp?=
 =?utf-8?B?VDJENGd1UUtyOE5QTXplbGtGd3VGTHg4UWFYc2FUeDNoMnhMZWVPb0hDY3Mw?=
 =?utf-8?B?bXpweTJyTzNFSTZ4eU45dWNoK1dDOHVDenVONnFpQVVjaHJacElRUnM5S2l5?=
 =?utf-8?Q?m2WVq9mhm3DJGi7+7b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: H2Sksawom3Eb5cs4/G9wj6cjkMNap5IoCBa+MCarU3b4967JoeZcBjuiG4Rpq+8MEfKRhUX8U2fLMERFxvCldkzJGljB17e/K9MkYWnpBx6NpbipThYg7NfzrcDAOPH2wTm2GYlojpHzEDiHyXDxVktcl3J7gtbLwkXuCzi8W0AhFdENGkIsAq3bj3zeosiqbD7JBf2kehwYMRzPdzekwbslY3O+ZEowKQxh2r3x2H9HfxLeqA61Ezu0avFpWJTe42H3NInoSEOdoCbNvg4cjZeK6NoQtz+8F4Z2ajkR65tgCy4hgYuxyPuxEkKomhkG0bw3ZKzeVv17zv/ky5BPog==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7816.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b657aa42-d212-4c25-9ea6-08deacc0972f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 05:13:50.2914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZFoFzauKmw7Qfdz4zc4XEklxuL2+qucyt5/ZGgdT1RfLr7uJX/6jHpnHQ3pzR6SsggyehzUVgJcFO5KtnO2XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8475
X-Mailman-Approved-At: Fri, 08 May 2026 14:28:05 +0200
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

SGkgUXVlbnRpbiwNCg0KSSBhbSBmaW5lIHdpdGggdGhpcy4NClJldmlld2VkLWJ5OiBUb21teS5T
aGloIDx0b21teS5zaGloQGFpcm9oYS5jb20+DQoNClRoYW5rcy4NCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IFF1ZW50aW4gU2NodWx6IDxxdWVudGluLnNjaHVsekBjaGVycnku
ZGU+IA0KU2VudDogVGh1cnNkYXksIE1heSA3LCAyMDI2IDY6MTMgUE0NClRvOiBKdWxpZW4gU3Rl
cGhhbiA8anN0ZXBoYW5AYmF5bGlicmUuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGUNCkNjOiBH
U1NfTVRLX1Vib290X3Vwc3RyZWFtIDxHU1NfTVRLX1Vib290X3Vwc3RyZWFtQG1lZGlhdGVrLmNv
bT47IEplcm9tZSBGb3Jpc3NpZXIgPGplcm9tZS5mb3Jpc3NpZXJAYXJtLmNvbT47IFRvbSBSaW5p
IDx0cmluaUBrb25zdWxrby5jb20+OyBDaHJpc3RpYW4gTWFyYW5naSA8YW5zdWVsc210aEBnbWFp
bC5jb20+OyBSb2JlcnQgTWFya28gPHJvYmVydC5tYXJrb0BzYXJ0dXJhLmhyPjsgU2ltb24gR2xh
c3MgPHNqZ0BjaHJvbWl1bS5vcmc+OyBZYW8gWmkgPG1lQHppeWFvLmNjPjsgTWlraGFpbCBLc2hl
dmV0c2tpeSA8bWlraGFpbC5rc2hldmV0c2tpeUBpb3BzeXMuZXU+OyBNYXJlayBWYXN1dCA8bWFy
ZWsudmFzdXQrcmVuZXNhc0BtYWlsYm94Lm9yZz47IEx1Y2llbi5KaGVuZyA8bHVjaWVuengxNTlA
Z21haWwuY29tPjsgV2VpamllIEdhbyAo6auY5oOf5p2wKSA8V2VpamllLkdhb0BtZWRpYXRlay5j
b20+OyBSb21haW4gR2FudG9pcyA8cm9tYWluLmdhbnRvaXNAYm9vdGxpbi5jb20+OyBTaWRkaGFy
dGggVmFkYXBhbGxpIDxzLXZhZGFwYWxsaUB0aS5jb20+OyBZYW5xaW5nIFdhbmcgKOeOi+eHlea4
hSkgPG90X3lhbnFpbmcud2FuZ0BtZWRpYXRlay5jb20+OyBCZWl5YW4gWXVuIDxyb290QGluZmku
d2FuZz47IFJ5ZGVyIExlZSA8UnlkZXIuTGVlQG1lZGlhdGVrLmNvbT47IENodW5mZW5nIFl1biAo
5LqR5pil5bOwKSA8Q2h1bmZlbmcuWXVuQG1lZGlhdGVrLmNvbT47IElnb3IgQmVsd29uIDxpZ29y
LmJlbHdvbkBtZW50YWxseXNhbmVtYWlubGluZXJzLm9yZz47IERhdmlkIExlY2huZXIgPGRsZWNo
bmVyQGJheWxpYnJlLmNvbT47IE5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8u
b3JnPjsgS29yeSBNYWluY2VudCA8a29yeS5tYWluY2VudEBib290bGluLmNvbT47IElsaWFzIEFw
YWxvZGltYXMgPGlsaWFzLmFwYWxvZGltYXNAbGluYXJvLm9yZz47IEt1YW4tV2VpIENoaXUgPHZp
c2l0b3Jja3dAZ21haWwuY29tPjsgUmF5bW9uZCBNYW8gPHJheW1vbmQubWFvQHJpc2NzdGFyLmNv
bT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsgU3RlZmFuIFJvZXNlIDxzdGVmYW4ucm9l
c2VAbWFpbGJveC5vcmc+OyBQaGlsaXAgTW9sbG95IDxwaGlsaXAubW9sbG95QGFuYWxvZy5jb20+
OyBGYW55aSBaaGFuZyAo5byg6YC45biGKSA8RmFueWkuWmhhbmdAbWVkaWF0ZWsuY29tPjsgSm9u
YXMgS2FybG1hbiA8am9uYXNAa3dpYm9vLnNlPjsgS2V2ZXIgWWFuZyA8a2V2ZXIueWFuZ0Byb2Nr
LWNoaXBzLmNvbT47IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1dEBtYWlsYm94Lm9yZz47IFBhdHJp
Y2sgRGVsYXVuYXkgPHBhdHJpY2suZGVsYXVuYXlAZm9zcy5zdC5jb20+OyBIZWlrbyBTdHVlYm5l
ciA8aGVpa29Ac250ZWNoLmRlPjsgU2FtdWVsIEhvbGxhbmQgPHNhbXVlbC5ob2xsYW5kQHNpZml2
ZS5jb20+OyBDaHJpc3RvcGhlIFJvdWxsaWVyIDxjaHJpc3RvcGhlLnJvdWxsaWVyQGZvc3Muc3Qu
Y29tPjsgUGF0cmljZSBDaG90YXJkIDxwYXRyaWNlLmNob3RhcmRAZm9zcy5zdC5jb20+OyBDaHJp
cy1xaiBDaGVuICjpmbPlpYfpgLIpIDxDaHJpcy1xai5DaGVuQG1lZGlhdGVrLmNvbT47IE1hY3Bh
dWwgTGluICjmnpfmmbrmlowpIDxNYWNwYXVsLkxpbkBtZWRpYXRlay5jb20+OyBTYW0gUHJvdHNl
bmtvIDxzZW1lbi5wcm90c2Vua29AbGluYXJvLm9yZz47IE1pY2hhZWwgVHJpbWFyY2hpIDxtaWNo
YWVsQGFtYXJ1bGFzb2x1dGlvbnMuY29tPjsgU2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKSA8U2t5
TGFrZS5IdWFuZ0BtZWRpYXRlay5jb20+OyBMZW8gWXUtQ2hpIExpYW5nIDx5Y2xpYW5nQGFuZGVz
dGVjaC5jb20+OyBUb21teSBTaGloICjmlr3mmJPlu7cpIDx0b21teS5zaGloQGFpcm9oYS5jb20+
OyBLZXZpbi1LVyBIdWFuZyAo6buD5qW35paHKSA8a2V2aW4ta3cuaHVhbmdAYWlyb2hhLmNvbT47
IFBldGVyIFJvYmluc29uIDxwYnJvYmluc29uQGdtYWlsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjQgMi85XSBNQUlOVEFJTkVSUzogYWRkIG1haW50YWluZXIgZW50cnkgZm9yIGFpcl9lbjg4
MTEgZHJpdmVyDQoNCg0KRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCg0KDQpIaSBKdWxpZW4sDQoNCk9uIDQvMjkvMjYgMzo1OCBQTSwgSnVs
aWVuIFN0ZXBoYW4gd3JvdGU6DQo+IEFkZCBhIG5ldyBlbnRyeSBmb3IgZHJpdmVycy9uZXQvcGh5
L2Fpcm9oYS9haXJfZW44ODExLmMgIGRyaXZlci4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSnVsaWVu
IFN0ZXBoYW4gPGpzdGVwaGFuQGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+ICAgTUFJTlRBSU5FUlMg
fCA1ICsrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUyBpbmRleCBjZTRlOWQ1ODAzNy4uMTA1
NTkwZmZhZDAgDQo+IDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiArKysgYi9NQUlOVEFJ
TkVSUw0KPiBAQCAtNTgsNiArNTgsMTEgQEAgRjogY21kL2FjcGkuYw0KPiAgIEY6ICBpbmNsdWRl
L2FjcGkvDQo+ICAgRjogIGxpYi9hY3BpLw0KPg0KPiArQUlST0hBIFBIWQ0KPiArTTogICBUb21t
eSBTaGloIDx0b21teS5zaGloQGFpcm9oYS5jb20+DQo+ICtTOiAgIE1haW50YWluZWQNCj4gK0Y6
ICAgZHJpdmVycy9uZXQvcGh5L2Fpcm9oYS9haXJfZW44ODExLmMNCj4gKw0KDQpZb3UncmUgbGlz
dGluZyBzb21lb25lIGVsc2UgYXMgbWFpbnRhaW5lciBhbmQgY2xhaW1pbmcgaXQncyBtYWludGFp
bmVkLCB0aGlzIGlzIHF1aXRlIHVudXN1YWwuIEBUb21teSwgY2FuIHlvdSBwbGVhc2UgbGV0IHVz
IGtub3cgaWYgdGhpcyBpcyBmaW5lIHdpdGggeW91LCBieSBlLmcuIGFkZGluZyBhIFJldmlld2Vk
LWJ5IGFzIGFuc3dlciB0byB0aGlzIHBhdGNoPw0KDQpDaGVlcnMsDQpRdWVudGluDQo=
