Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6C3EB48F0
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 10:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F4618367F;
	Thu, 12 Feb 2026 11:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="nabSWzuw";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="a45gY+PE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC37183C4B; Thu, 12 Feb 2026 11:22:08 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2794283015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: a7e1799c07fc11f185319dbc3099e8fb-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=KXdpQLCBo7dnDZeQmzb8rEoZXOK9cqnapR9SlyYMjFs=; 
 b=nabSWzuwpc4S1vU+sxQUOTZpXTuZRCauznzP0OPxNewWjLKtLUKd1rN+1tVbX+m0XHyFP4A1W+duqGPAuyhCn68QMQP4GIHr69dt5/BvQTXTC1KuI9YIxlSrH/1D6rHjwj1iQmBj5vpy/J70QaBJyRFMmHZUkmbSoQtS1VQJrMQ=;
X-CID-CACHE: Type:Local,Time:202602121821+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:fbf58a91-446c-481a-8066-0787216ad149, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:ef37e27a-8c8a-4fc4-88c0-3556e7711556,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a7e1799c07fc11f185319dbc3099e8fb-20260212
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 344338125; Thu, 12 Feb 2026 18:21:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 18:21:54 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 18:21:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtPxhMulp94wBRTze1GgSEEpYFnJwpNX5rhf7tBp03DoUKPxyfmX9Y39B/YHaY/szQNffUNxEHwnAd7ayyYv0kpfwblY5zeMrHVF7pU/vM6VI6sIWzhyBlP7Sq6UIinvTeWS0RiH0GZwmI8gbSYixuLoVItW/JPMKvaE3S0pEI5gpYE9QBllpAUiF8FyRS4eNe5z9m1wPjrgPzuK0gjF9vzQRL1HBd8t0iOM6U8MJ6/4Fpvg9RgYYOgpdF7M+uNzJdKJgR37m3/ahHaOxNTSJ6wouURlBjupH7MPYLKJbfla+HBvVYQkPvZh+NZAiZROIh/9iSJ+6AoEsITxn9h/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXdpQLCBo7dnDZeQmzb8rEoZXOK9cqnapR9SlyYMjFs=;
 b=FTafNcS+9V2uB1yOmbMf5bLWaJRvLRAne0Uk2G5IJLDK3xoPnjWy0Ah6lJPz3thBNs+lcjxfUydB2RsYvJGBMp/1ePvHRWuD/rQu+ZFJb+1mr7yVJx7SOkI1V1Lj3r8a5i07wAc0NrYZYLKM9zh5Osg5QWSxmeVK6i41+p0M7Ukpd5GL7wTP/5s+08jyBlI8+rE0zqM3mC/nyIitfVW6i/PgVAynKBGw4Yu916elQLuWq+3YuwwBSP49FVylehLxX7JmCUt+fou7o66xFPbBTCz/vIFV/6RCd250zU1F1qXf0ChOklOjpGo41MOWCsMRW9zyOr0u9io1AKynKQGiEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXdpQLCBo7dnDZeQmzb8rEoZXOK9cqnapR9SlyYMjFs=;
 b=a45gY+PEvLcKOLC9HEZUjeyUhDa5J7mUqRVbDozreyEq+62yBV2ClgnGjaO0L+sfmJ366/4BmEueorJ266eJF/PRnydAIKHE78Qtur40NMcy8mjOHNB6aI5yXN1KfpRpUoH1ZL5CrZmSxAUJ5TMGefQ1hOXlk8inyiLaLoBq8kk=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KL1PR03MB7406.apcprd03.prod.outlook.com (2603:1096:820:ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Thu, 12 Feb
 2026 10:21:51 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 10:21:50 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>
CC: "hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
 "venkatesh.abbarapu@amd.com" <venkatesh.abbarapu@amd.com>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "michal.simek@amd.com"
 <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>,
 "philipp.tomsich@vrull.eu" <philipp.tomsich@vrull.eu>,
 "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, "sjg@chromium.org" <sjg@chromium.org>, 
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, "bb@ti.com" <bb@ti.com>, "j-mcarthur@ti.com"
 <j-mcarthur@ti.com>
Subject: Re: [PATCH v2 2/3] drivers: ufs: add helper for phy_initialization
 callback
Thread-Topic: [PATCH v2 2/3] drivers: ufs: add helper for phy_initialization
 callback
Thread-Index: AQHcmqm0KI/JUeptUECAFpFhXxhE1rV+3VGA
Date: Thu, 12 Feb 2026 10:21:50 +0000
Message-ID: <8e236b3595e183db32fa074dba050985e9ad3c42.camel@mediatek.com>
References: <20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com>
 <20260210-ufs-ufs_hba_ops-cleanup-v2-2-dd73da21aa92@baylibre.com>
In-Reply-To: <20260210-ufs-ufs_hba_ops-cleanup-v2-2-dd73da21aa92@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KL1PR03MB7406:EE_
x-ms-office365-filtering-correlation-id: 9fb796bb-e531-4f5f-b439-08de6a20895b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dDhQNVVud0QxVWNhbVg0ZFdnNkVzU2V3SmVNcDkyWVh3aFc1eXNia2d6WUor?=
 =?utf-8?B?Z3FKTDVseW9kblhtaDhvRkxZNzN2YXFuaU9EcDAwZWZmS2xYc3A3WWlDZWw2?=
 =?utf-8?B?RjFDNWhJaVBJalJVUkVwcFlwRzljajZvajNEU0sxeTJmWWZROGNrdGRtSzBO?=
 =?utf-8?B?clFjWmlFL1RGdWt1OERwamlmbmxuS0VzWFdGbFJzcEhMRkl2SjNLMHV3eW05?=
 =?utf-8?B?NlE0VjI4MHBEZkpSekZtUHA0Vys4RTRyNzFiY2FOTmFJN0pLV1F4WS92MFAx?=
 =?utf-8?B?MnY3M2hJZlV2RmZoaGdxWDFTN0hKcmhJTlhMcFFJM3pYMTZ1ckhKdGoxaysy?=
 =?utf-8?B?Ykw4dTBudWlyeWxYQVc3dXh0YytoeGNjZk9WMGZBemJWUkN0SmppNFYxT1cw?=
 =?utf-8?B?RWF2MzVwVXQrTlJQejVWZE9ZZW05ZnRzN0JVUnlWVW8wbjdxd2VOUTdWMHRX?=
 =?utf-8?B?OTlxdWJTV0V3MWsxbUEyVFVpTW9GR3V5azR6NDJjLzc1SzdCSCtXWS83L3NQ?=
 =?utf-8?B?WGJVbnpCSHdvWU1MdSs3M2RWNm54VjR3TWJqOWlRbWlKZi9VT05zdGxWeWhw?=
 =?utf-8?B?alB1djR3VXpSbE5sOGpLVDhIK0VIUW4rWjlOK3hnUUljUzRVZ095WmF2RDJz?=
 =?utf-8?B?N1EyTE9CMk1wZ2tyMkJRazNZOWVHZW5KellKWWtnUW42KzZOZzdXa3h2NnBV?=
 =?utf-8?B?RkFMN1lFbDZZYmZWcXVqTnFpVndzaUdFaVZYOHRQR2tqMEFjUnJ5V0dWMnll?=
 =?utf-8?B?WnpRbkViTCtHY3dKdHdBL0JSTVBpRmJNQmxTSTFmaUhaWEtrR1BSZndVWWdO?=
 =?utf-8?B?SnI1SUNrUmxWTVNqQU5hK0RvamF2eHlSelMrbnhKWjRyQkYxS0NlOWRmWXFB?=
 =?utf-8?B?cUFlTm5ZaFFSYUJqOHlySXpDVnppMFhSWU9ZaXVvN2p2ekVxWEcvUmZkeWlm?=
 =?utf-8?B?dDlnb0Rtb3JiSXNmdnZRMEx4SDRPN2tHV1VjSmt0c2NVbDVQUEJKUE5TQ1ZB?=
 =?utf-8?B?czQ2WUR3VGdCYktLSzdrbFdkNkluZ2hMaTRiUndXcnBOSDcwTFhmNWF5MnJo?=
 =?utf-8?B?a1NSUU1Wb0hDR282MEVSLzltVmExMXRFUmw4TjQreXE3bVVIOCt0M0JhQzJ5?=
 =?utf-8?B?WDJoUDVOTWtyYmZoUytMMlQwUnhUMlNNdFdpcjRRTlZzUWdKZDY3OFJka2lE?=
 =?utf-8?B?Z1p2NndnZGlMNEY2clFyMStLWDJCZmNUY2oyNkJ4NmY0bDAwd2YyQmdjUjJo?=
 =?utf-8?B?eVJsTDFXVEJuc2xRNElNZjhnVVNjNlpFdkI4UmZOUGFGSThucjRteDRLKzdZ?=
 =?utf-8?B?a2R6cy9CNnFBcUtJSEE2ME10SzhMR3NvM01aTHVMd3VXeWNKUEVERGZxa1NY?=
 =?utf-8?B?RG1OZUVjOURBY0hWMzQyYlpSR1l6RWFQZWU2SHNFOSsrd29QV2dqb3diLzR6?=
 =?utf-8?B?c1RKZk5VSi8vdE5NL05seWUxR2VzdmxLMHJOYnVZQXVCK1Q4ay9zdlJDQ0pD?=
 =?utf-8?B?Z0N6dmRFY2grbDRJSDRoQ3NHd2dTVVlCUlJ0V2dCTmRNVTh4c2tDZWhCRXpl?=
 =?utf-8?B?ZTNmR1hvN3hrMk8rU05CQ0lzWVREaUNFZDZJWmtWcVpvWGhXMU81b3JXTEVh?=
 =?utf-8?B?U2FhUjZobjdrd3g1UGRLeC9HYmplTGNobGVXRU95Y3NjbmdXWVVRbDdyTzdL?=
 =?utf-8?B?REIxaE40ZktiTE1Gbm5MM0pYT2E1OEQ3b3ZZTTNqc1pENFI2R2tXMHN6bVVI?=
 =?utf-8?B?dUpjZ0V4VC96OGdpK0ZRVHhxRlc0QXRha3VMMU1ncmhqNHk1cUJkLzk0RUlw?=
 =?utf-8?B?cm5GV3NrWmllaUMvNmtVNjBvQXBGZEIyN1ZqNFJmZFJpVmlKM2ZWVXF5SHZQ?=
 =?utf-8?B?M1cyczhTQjlWeXp3YTVOaHp4bExyYXRGSmdaZjErS01Pais4dzEyKy9YdnRk?=
 =?utf-8?B?bGZsOE5ZcDFyVWdFME85cFptQ0RIRFhTRTVFZzQ0d0NtWU5LYlA4U0VkUnpZ?=
 =?utf-8?B?UEVZVW1KSmFVRHBUMGZJL1FyeitWdXJpbVl4Wlp3ZGd1dmg1U0hzcW96aXpv?=
 =?utf-8?B?SmsvQnNIa29hbnk3MmZjcW8waXVvQ05XYWllRWFKM25EMysrKzlpMSs4N3VP?=
 =?utf-8?B?YkZVRDhrVVdISENLZGJZNkd0WXF1TDB0dks2dVRLVWljRHl3SlpXN0RDUDBD?=
 =?utf-8?Q?79gNiiQqEph1nw6qrMEB2M0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2JRQmcvVllNM2F6bWZISnI2VXQ1dngvR2JmbkRIR0c3bDVWbHBwWkp1MkFX?=
 =?utf-8?B?TUlNc3NZYXhJMUtYWkFwRGNHT1hraTFkZ3A2bTY4NnpIY1p6Sm4zZTBSS3ov?=
 =?utf-8?B?MVpUeXh3b3ZDY1FURk8wT0NWZTd3MWgrZW9TeDNmOUZMMFFCWmE4T3Jlbk9M?=
 =?utf-8?B?SThtSTQwQWFJSkpTc1FlN1BzRDdoK2xNUUd6bFk1eFVGelFEaDZPNEc1a0ll?=
 =?utf-8?B?WW1EbGY2SnFIUzhZSlF1cWNNUU1UWHZZd1U2MHBzNkJycko3OFBXVThWOE1J?=
 =?utf-8?B?eVBTcDVBQ084VVdSeWJneThUY1lNVEE3SFJyR0grOGluQklnSklIWU8wUHor?=
 =?utf-8?B?TjJLMTQ1N1N6bEFqdHVGcENQa0czVSt5U2xaSDd6cTNOWEtPcUtIaEJHYlI3?=
 =?utf-8?B?V3ZySUwweEswVnJxR2NYTUpGSGpGV21jVWlLMlZxQWN1MlBrdlVmbEd4cVFY?=
 =?utf-8?B?eFlLSy9uMWczenV2TkJVSTRkL09KejdMVVlxL09WTWROS2ZCUlpadlRXa2xB?=
 =?utf-8?B?YWJQQjJzRkpQNGZ6bFZ6R3NtS25sSExRUnNzMndOdGlGTE9tRTJPL3l3TVJ4?=
 =?utf-8?B?SElwaUVRMi9DZmlwL0x1RTVhNHR3TlVwcG5BQ2NqVjgvZmYzSlhsbUhiUUtR?=
 =?utf-8?B?bSt6VmVzZVhoVzBxQ0F4VXIxc3pYTmFlcHFCd0M3ejFCVDZ1dHYyK0Rla3pZ?=
 =?utf-8?B?L2l0LzNUaE9qZHoxVU1mWE05dWk2YWZEbFdEbzZPdGJ2MmdkZmlSRENCTlNB?=
 =?utf-8?B?RWtUMWFVOWdJanhERWdWN3BYSWJXdktEOEZ1MHpjWHM0ZU82TnY3ZE9DUEE0?=
 =?utf-8?B?aFJiWVFWNXRWTUZ1b0xPbWxLdlE2ZHZCVmNQMXluNC9hbHZ0VklIaEhJcjhC?=
 =?utf-8?B?QnEzNzFsaktYdFRiS0NKd0x0WGpkdEhHMkhYNE5lRmhyc05CNmI2VHNwVFU2?=
 =?utf-8?B?bkxSREh4cHI3Tlk5L0hMdjZUOHM3bVlRMDRUTFVmT3YvNC9wMndZbGh3NWls?=
 =?utf-8?B?cTNsSVA3V2lNUWpFSUZBSUJNcnE3a2NoZm1wTWtraXpWZmptdDhKWHhnNTJR?=
 =?utf-8?B?VGFhOTBmenBWS0Z3QnczVDlGQkd2OGljSG55WDZwV0U5THZ2L05YSkRFb2ti?=
 =?utf-8?B?R1NkN3dKNTlKcy9oNWQrQ1BFazVyUEg5WVIwc2xwTUJucWtGL1o0a3N5OHdM?=
 =?utf-8?B?ZmlnYTRBUU9peGwwV1picGJObDNJck1wMlJSNkhhQ0wxMERxOGRVV3ovZHlm?=
 =?utf-8?B?cFJmNjJMYlZ5ZE1JdTVnNDVoVkxRQ1NsTEt6RTh0VnMzMGlMK0o1dkRnbHB2?=
 =?utf-8?B?ZUJCUUpjTFNsUGlkQWVyNFlFc3NwU1hFMmxHK2VZOS91WlFDWXh1UGNKN205?=
 =?utf-8?B?NDZrWHJ1d2JycEtDYnFNM0RxN05sTzBPVkJkUDFmTmVRWnoxOGptVmxTMVZw?=
 =?utf-8?B?RlBXalByaHo0T0svL1dVTk1scjJ1dU1hWGwzZWxpd2RQSGlrK0FpeVk1ZVVp?=
 =?utf-8?B?MlZzOG1EVklLY3ZBWnlCc0hvdlVCQit0NmJkVkhDdUJNNUxDMUhKOFhvQ1dV?=
 =?utf-8?B?b1hpZkw5aVdDckhVNmZmQTJnMmd0RHBqY0g4RUcyb0dIQVlnSWFBSG9hZUEx?=
 =?utf-8?B?YklzQllhd0ZEd2hNd2cyOXJPQXVUck5QV1Z3OHcvZmVNUVRKZlUwVDhYbVpv?=
 =?utf-8?B?cVhGVC9abVdmWFA4MnpGK0dGVXljVzU3V0ZpWkt0VHJ5TGk5Mkt5QTVrekpy?=
 =?utf-8?B?WUlGL2QrRzlYM2Myam1BUUxhdmIyMk5CNnFielN5UzR3WFRnbVBPbjlJcUlu?=
 =?utf-8?B?K3B3Tm4yUjJoSDNXM2NZZFF4N0NZcHh2d0JKZXk0VHJhQlhOcUZwS3k2MzRM?=
 =?utf-8?B?L1h2RVp1RVhCQzlRclF2L0ZZRmNKcUFoNGhYdVQyU1gxRElKbmxMRnlCRVFI?=
 =?utf-8?B?bkFpTm5UelB0YnI0WG0reTRzWXVCSmUvVGJZdjIzTmVMaGNVdnhrSHJ1RVVw?=
 =?utf-8?B?WTBVbWxEUkhtcW1WS1I2VnJYVm5la1kxSGFsRmxPZHpYUFpTSXBuRUdMSGY0?=
 =?utf-8?B?cGhKK0hVVmg2RjV4d29JSXVJRGNJcjcxMzVwaWY4N0huZWxWNldxZzYwTElU?=
 =?utf-8?B?ejhVVHpibW9iNEJZOFJSMWtKNGJRT2RWWnZhL3ZtVlo3R2hON3lzRmJ1NUls?=
 =?utf-8?B?WkRuL1MrRHJsT0VXN0x4UWJpd1FNY2QrdEFNSkVGVEk3ZW1WVWZZR05BS3Vh?=
 =?utf-8?B?OGJVc1MyRHAxSVVEazVteElIMkRUUGtJRDI5c2RhMUczSytaQmticllTYXBt?=
 =?utf-8?B?Mm1SN1VtUU92blpnTUlJSDlxOVkxUGhzQjVCN2xmK1FtTWY1ZS96Tzh6eEVK?=
 =?utf-8?Q?u9mLkgLXo6tjC0Vw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35ADEE750E6BE64B8FF8801D789ED660@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb796bb-e531-4f5f-b439-08de6a20895b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 10:21:50.9155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7k1aZzKC+nKn2bV6RXiKmz4AIZ77Pci8akFaZTo+NjElfYZhR4ymYr9yW+m9wHFcYRzAYFsrsOOgsE9BhHGZ6QU96dL0nNFj6VtdpTXigA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7406
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

T24gVHVlLCAyMDI2LTAyLTEwIGF0IDE3OjIyICswMTAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gSW50cm9kdWNlIHVmc2hjZF9vcHNfcGh5X2luaXRpYWxpemF0aW9uKCkgYXMgYSBoZWxwZXIg
Zm9yIGludm9raW5nDQo+IHRoZQ0KPiBwaHlfaW5pdGlhbGl6YXRpb24gY2FsbGJhY2sgZnJvbSB1
ZnNfaGJhX29wcy4NCj4gDQo+IFRoaXMgbWlycm9ycyB0aGUgZXhpc3RpbmcgaGVscGVyIHBhdHRl
cm4gdXNlZCBmb3Igb3RoZXIgdWZzX2hiYV9vcHMNCj4gY2FsbGJhY2tzIGFuZCBrZWVwcyB0aGUg
Y2FsbCBzaXRlcyBjb25zaXN0ZW50IGFuZCBlYXNpZXIgdG8gbWFpbnRhaW4uDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKdWxpZW4gU3RlcGhhbiA8anN0ZXBoYW5AYmF5bGlicmUuY29tPg0KPiAtLS0N
Cj4gwqBkcml2ZXJzL3Vmcy91ZnMtcm9ja2NoaXAuYyB8IDEwICsrKystLS0tLS0NCj4gwqBkcml2
ZXJzL3Vmcy91ZnMuaMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOCArKysrKysrKw0KPiDCoDIgZmls
ZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3Vmcy91ZnMtcm9ja2NoaXAuYyBiL2RyaXZlcnMvdWZzL3Vmcy1yb2Nr
Y2hpcC5jDQo+IGluZGV4IDAzODQyNDQzODdkLi5jYWQ3NTNkNTk5MCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91ZnMvdWZzLXJvY2tjaGlwLmMNCj4gKysrIGIvZHJpdmVycy91ZnMvdWZzLXJvY2tj
aGlwLmMNCj4gQEAgLTMwLDEyICszMCwxMCBAQCBzdGF0aWMgaW50IHVmc19yb2NrY2hpcF9oY2Vf
ZW5hYmxlX25vdGlmeShzdHJ1Y3QNCj4gdWZzX2hiYSAqaGJhLA0KPiDCoAl1ZnNoY2RfZG1lX3Jl
c2V0KGhiYSk7DQo+IMKgCXVmc2hjZF9kbWVfZW5hYmxlKGhiYSk7DQo+IMKgDQo+IC0JaWYgKGhi
YS0+b3BzLT5waHlfaW5pdGlhbGl6YXRpb24pIHsNCj4gLQkJZXJyID0gaGJhLT5vcHMtPnBoeV9p
bml0aWFsaXphdGlvbihoYmEpOw0KPiAtCQlpZiAoZXJyKQ0KPiAtCQkJZGV2X2VycihoYmEtPmRl
diwNCj4gLQkJCQkiUGh5IGluaXQgZmFpbGVkICglZClcbiIsIGVycik7DQo+IC0JfQ0KPiArCXJl
dCA9IHVmc2hjZF9vcHNfcGh5X2luaXRpYWxpemF0aW9uKGhiYSk7DQo+ICsJaWYgKGVycikNCj4g
KwkJZGV2X2VycihoYmEtPmRldiwNCj4gKwkJCSJQaHkgaW5pdCBmYWlsZWQgKCVkKVxuIiwgZXJy
KTsNCj4gwqANCj4gwqAJcmV0dXJuIGVycjsNCj4gwqB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3Vmcy91ZnMuaCBiL2RyaXZlcnMvdWZzL3Vmcy5oDQo+IGluZGV4IGJjODM5YTQzNzA0Li43NDEy
NWIxYWIzMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91ZnMvdWZzLmgNCj4gKysrIGIvZHJpdmVy
cy91ZnMvdWZzLmgNCj4gQEAgLTc1Niw2ICs3NTYsMTQgQEAgc3RhdGljIGlubGluZSBpbnQNCj4g
dWZzaGNkX29wc19saW5rX3N0YXJ0dXBfbm90aWZ5KHN0cnVjdCB1ZnNfaGJhICpoYmEsDQo+IMKg
CXJldHVybiAwOw0KPiDCoH0NCj4gwqANCj4gK3N0YXRpYyBpbmxpbmUgaW50IHVmc2hjZF9vcHNf
cGh5X2luaXRpYWxpemF0aW9uKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQo+ICt7DQo+ICsJaWYgKGhi
YS0+b3BzICYmIGhiYS0+b3BzLT5waHlfaW5pdGlhbGl6YXRpb24pDQo+ICsJCXJldHVybiBoYmEt
Pm9wcy0+cGh5X2luaXRpYWxpemF0aW9uKGhiYSk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30N
Cj4gKw0KPiDCoHN0YXRpYyBpbmxpbmUgaW50IHVmc2hjZF92b3BzX2RldmljZV9yZXNldChzdHJ1
Y3QgdWZzX2hiYSAqaGJhKQ0KPiDCoHsNCj4gwqAJaWYgKGhiYS0+b3BzICYmIGhiYS0+b3BzLT5k
ZXZpY2VfcmVzZXQpDQo+IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGlu
QG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0KTWFjcGF1bCBMaW4NCg==
