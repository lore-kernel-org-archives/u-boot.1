Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5F9D6CFDC
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 06:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD68C83B21;
	Fri, 23 Jan 2026 07:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="FFD96zKE";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="h4fnk0Ap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD41283B32; Fri, 23 Jan 2026 07:35:44 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CDC083B21
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 07:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: b9a5c44ef82511f085319dbc3099e8fb-20260123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=LIPqf8dGd1W+h3m4LS28SXJnbtMut/WAIYYsINN7+y4=; 
 b=FFD96zKEc6y1gix9lL22mVgMTot+L5EPlkwmQo+m3xLvmOCCgJdxF/k0xNpOdUPAjeqVFjW61zvdEtsHvoZhz1yqzVdaPnX76YrmqR5IUJY7jP7pruZssefzwgnZuRMNlwS9RK6lt/OijhkgX5Oly4Rg7mRoHYetThWzbbIGMGA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:06e0faa7-bc1c-4c2c-9ad7-1167e3d23871, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:980f775a-a957-4259-bcca-d3af718d7034,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b9a5c44ef82511f085319dbc3099e8fb-20260123
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1532939034; Fri, 23 Jan 2026 14:35:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 23 Jan 2026 14:35:34 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 23 Jan 2026 14:35:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euxlNWnzRrs/qOYP3JIIPnG7z0l075SBsONICIlibIqWiGzwDfR7oxaNWixoXLr57r+F3iCbAl0b2EB6Eyy26LBstg2gP5dgh4a2rKZEGWdzNAP9WK2slYS0wE96k0MSeFOqMdxuVPPuNSgCvGCtP+PDoTRg0Dt0NCAft/MQw2UUYFElHh5Ee+fxAZtF0qiS2M+8KFh2N+Sz4ugS0vb4GalTodgsy/n1gMZbHMynaHMQeQJgZ1hxPqxFijPoOz2p+OoRKz8BcqtF5GqAAkL/FgBjjoifQ7C05++i/5Wmr8hwpQnkB2VnjNNaTA+V2Q18rjCldfXNuqxRpEdCdkm5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIPqf8dGd1W+h3m4LS28SXJnbtMut/WAIYYsINN7+y4=;
 b=ZsmQ3sJqunj8hEKvJlTJ6Gns6vM65xTcaxje8yFfSYo2bdP7v3zhvIGlL6S33sL40F4jBNn+gfHFnHk2ntnd3mJTiOeT5nrNUWykJj78PCZ7Q8rUoU3t0bzvFYw+HQ8W2kXeSvyvOPqf8UxtZlzcD4iTYPWuQ7koZzO1P/9uKlOIumiIjnUmqqMLdJugP+Od8daNY/Sa1kZgeWcuZegSN0ymiaDNzmx86tNl98HEdVxCVpSIfrDWFuFcfY9yOzwqhPXndSIe9U1dvLAPZH2/jSZ7RfcP7nCdQ5LCut1FSK7Sft4DGW+W+dV/Pq9KXcPdcqT+eZhy3X8E5ioLUKgpUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIPqf8dGd1W+h3m4LS28SXJnbtMut/WAIYYsINN7+y4=;
 b=h4fnk0Apd7bjgMhlREpP6UXdfWFxKGeaOHed23f1IdGANBXbDx5MV9i7iv/gJTKvxel9y6Hml3V47icdORETQ0bIX+J6dwMNQGfbWPFKFm95Hgj9MhAXbaZXb6V0qN3A0gfWTgoVlpEsD8ahhRKgIax72N84RLcccw9cEWKT54o=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYZPR03MB7481.apcprd03.prod.outlook.com (2603:1096:400:421::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 06:35:31 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%3]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 06:35:31 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Vitor Sato Eschholz
 <vsatoes@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>, =?utf-8?B?U2h1LXl1biBXdSAo5ZCz5oGV5piAKQ==?=
 <Shu-yun.Wu@mediatek.com>
Subject: Re: [PATCH v2 1/2] pinctrl: mediatek: Add pinctrl driver for MT8188
 SoC
Thread-Topic: [PATCH v2 1/2] pinctrl: mediatek: Add pinctrl driver for MT8188
 SoC
Thread-Index: AQHci72uGqcRgchLKk+y7ztzWLq3dbVfSCcA
Date: Fri, 23 Jan 2026 06:35:31 +0000
Message-ID: <47835f062432e0bc654616b693403f47ae567d14.camel@mediatek.com>
References: <20260122-add-mt8188-pinctrl-support-v2-0-324b4c8f2b64@baylibre.com>
 <20260122-add-mt8188-pinctrl-support-v2-1-324b4c8f2b64@baylibre.com>
In-Reply-To: <20260122-add-mt8188-pinctrl-support-v2-1-324b4c8f2b64@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYZPR03MB7481:EE_
x-ms-office365-filtering-correlation-id: bb680003-63d8-4439-d45c-08de5a499b4b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SkhmWUN2NnhjOWtEdWlDbjZraGQ2bzNYV2FvRVZzVnQ2YUQ5eDgySVBZZmJ6?=
 =?utf-8?B?VllxdG1sUDJhT0VWTE1kYzV6dWthbzlteE9WM01mcjl6UUpXNng5MlA4UFBH?=
 =?utf-8?B?VkVZWWRXcGxrWS82MFVHbFdRU3JZeXhxM043NXo3aDQrRnYwamJSN1lCdEhj?=
 =?utf-8?B?d2lPeitWcTZLcmR0TjlvWUZvd0Q5S3A1cWMyVDA3Z1AzeC9SR3VHdk9rbWph?=
 =?utf-8?B?Yk45MU9oVlBLVFM3YktORzNlb3Q3UEJWN2Y4bnNqMFVJOGprT29yL2Z1RzVO?=
 =?utf-8?B?Tk0vUlhCVnEwZDloL2RvcWxzS0E0VnpWSkRlcXQzS25SZUdNZjRGVkwzTHBo?=
 =?utf-8?B?SzcyT3ZHMmR0dFNDaGo1TzQxbWNOc203bXR6RWZ1eEJaVEZlL2FaeGJQNDlx?=
 =?utf-8?B?M2FrenIzZ3VKekIwODAvY05MQ3JQdnVmTU9pdFhkbWpUT2tPNUk4bURtU3l1?=
 =?utf-8?B?NDdyVmZoL21pYmhQMHF2RlozTkpKSUpLMkxpaVBSZ1FjYnBnK3Q4aVBlSnJm?=
 =?utf-8?B?azVGcU1WQXBZQzZmRm9EaENmbVM1dEpRcC9jZG43TUZzbTFmQ3JLRlpScHVN?=
 =?utf-8?B?WC94d2o1Qkg1dFhtSjJsNXB4N252VVBPMExjZzZXZkJ0Y0JTZENkZU9tTm0w?=
 =?utf-8?B?QVp2cTA1M0h5NGNvZStkbDd3aEhJZVhxcUY0UVVPV0RxR21ubEV2OEVJRXhU?=
 =?utf-8?B?UEFFMGppTFpwaGR0dUgya2tJUEVnNDhmUmxvOXdFRUNpSGVOekVUQlluQ1VR?=
 =?utf-8?B?RzB5d1RWMDVBQm51MUxDTTdiOFBWZzg1UGdLellWdCtqNzdKc3Q1dHo2U21Q?=
 =?utf-8?B?MDNCdkJ4Z3pKenhWd3dGcEJvL2MzL0wwTDhFWG9WdHhkT25aV0Ryd2lqZDhZ?=
 =?utf-8?B?Wkd0K0lGMGxmeHA4cnJXVmtLUGVjRFZQRnArOUY5amFSQ2ovell0Q1NzTnll?=
 =?utf-8?B?bVhOYmJyb0lkR2srei96dWsyQ3RHOTVQcUYwamdXbGVXTTg5MEh3cG1hZExB?=
 =?utf-8?B?a1J5cUwzOUlrSENwTWxCbDZQL3EwSHVlb3JBdUQ3MkEvU2puc1c2cWZaQVNV?=
 =?utf-8?B?emN0MFZRSmI2YXFucVBZZ2YzaWZOVmFQeXZ2VmhnWkRtMlpzYzZ5VmNOcTIr?=
 =?utf-8?B?dlpuU0hhMjNPWEdCWkJSanZBcjFKVVhCNENlVitLaTNjTWJHQXZwSG9YbGhD?=
 =?utf-8?B?NDl6cXlFemdFaExKNUxUUE9GL2pyZlZvZzNCMXRPa2pueUN5NTlXRHZtRGk1?=
 =?utf-8?B?UFlSWlNjRnB3akVFTjdhMHdvN0JnTGNKdVdVR0YwMTlIS2o5UkE5Z1hvSUVx?=
 =?utf-8?B?aFVlaHBRZFJDcXZybjVlMWlEb3puZ3BCU29STFBPL0s4aVhvVnlkcU9wNUIx?=
 =?utf-8?B?b3JNKzhqTWFrWkVmS1ZXeGRyQ3d3ampyRCtadU1rNkRxOFVDa2dYY09Od3hv?=
 =?utf-8?B?SE1hN3RaSWdtK240SUdmemVlUVR4RTY2VzFSd0RqeXpaaE8zOE5wZVBhWmoy?=
 =?utf-8?B?NElUVjg4Y0UwdDRhVFlsQjF6Q3ZvQ2FNSHlXV203azhlU2lIcStjQ3lUbGIv?=
 =?utf-8?B?OUJlZktrZDRUQS9yK0NPTTI5UFM2TWpvdmtJZ0hBUkZUSzltdTI1cDBVZ3RC?=
 =?utf-8?B?YzNhMk9XZGZmeXYyeC82bGxUM0JDTWt0Zkord2JnT1g2bFRxRHduQzlDWTlp?=
 =?utf-8?B?WXBjRnUwNkhIamJOazBFeDhQZUk2bzNacWx0Zmk5ZndKd014aXVabTVHdXhp?=
 =?utf-8?B?Mnp1OFVFTzhMRzhiSWdFV0J4TGxhUmE3Zmc2WGZvUGxyUDAyS0dYUlF3YXdK?=
 =?utf-8?B?Z0NwcWxsamcwWmhJLzVMQVVDTUlvZWJkcHRDV1NnZk9NcWYrcHR3bFRJSlNh?=
 =?utf-8?B?aEZlbHpSa0xJOGhBMHhzY05NZWswYWxoWTFrSWhUYS92SVJUOFk0VkdYMmlU?=
 =?utf-8?B?eUhRUElacWwxTUNEOVhNV0lIbHRub2dvSXVybnRpUU9RRTFPbVRZaGgvTDUr?=
 =?utf-8?B?YTJ4WUFKcHk1RmVMUllLLzNXeXUrTlNlck9RcDlmbVpuOXNYYWdiOU94ZWpW?=
 =?utf-8?B?K0xwV1k3SzBPNk5CRlErRU1Jb29iVEV5c2x6eHp0aDQycXFQclduVFhRZE1z?=
 =?utf-8?B?MW5jOTUrcStMY2c4S0xyRXV3S0NzT3ZmcVNPaWU2TXZKdStLL2pUYjQ5UjhK?=
 =?utf-8?Q?aOqr3knwinj5mLB20RZO+vg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEc0UkhxSGpBUzZLaHVBV2t0K1VjT1luT1pzdVVzOFFiTEpDUzFIdUt3L2RG?=
 =?utf-8?B?L25PQkVEWjdrUXMzWGlrQURVOEpzY3JLK0NxdExUUVJmZkZLV05MaERDYjhv?=
 =?utf-8?B?VVNaNW83YlJqREJyZVU2ZE1iTWVISElCMTFiVmtBWDh1KzFTZDlmb3ZZN2Zv?=
 =?utf-8?B?TUxsbytDeTM3ZE9rS25WN3FzUmJLNnNEYkJqSVlFTGlSYStRTW4zMlIrR0pD?=
 =?utf-8?B?YkROQk1rRzFiNkE3c0p6eWpCVmhBNXNnVzZHcnluZDNyVTZRVWJkYjZTVmpC?=
 =?utf-8?B?WlgvdTA1S1oxOFVwZGJzQWRTd09Jc3JMVFlNRTNmQ3lLcDBCUTB3MHh2TFRK?=
 =?utf-8?B?eEdkczlOWmM3NnFmbkpkNUpTbVhYTFdkVy80d0M1Um53THFTN1RpYm9SeWFh?=
 =?utf-8?B?a0ZHTGo1MG5FL3Btb3p5YlNuZWwwVWF4clRCN3Q0SktTdVlvYmcwb2ZjdS90?=
 =?utf-8?B?MEFtWGlhdjVwNzJva0FzT0RSZVF5S1UrT1pVMmZkTnFqT3J3Yjhwc2g0bTVC?=
 =?utf-8?B?RWxhK2J5M1BWa0dzQVNUV08rbStOQXZ2YUFaUFUyVjlUdzkrNkExd05nTzVY?=
 =?utf-8?B?SUYxczI4R3JUdTEwWXVRUjF3N3I1RjBKelhpekkwMnVOMlgrYmd6a0VGemsz?=
 =?utf-8?B?cU1RRFplWmJEKzNqRGVDbnJqZm9qazUzSG1zOW5saVFWQW5ldXR1WC94dlJ1?=
 =?utf-8?B?TU9WaXVjckRNVlJtOFl6L0lTV0RFZTd0NWcwV1FmNEZWOFZGMzJmVTNKNXps?=
 =?utf-8?B?dEM2b0JVSEhrbnVDY1NBSXhuVndaWm1lSmI1UXFJSmhWZUQvT1hYbFBXb3d6?=
 =?utf-8?B?WU9JY1pOTW0rSGVMQVNudG5IWGJLOXVDVXBlRW1QamVjempLN3dYdVJYcW5Z?=
 =?utf-8?B?cDBCMmVvTGpXcFVlMTdwSStNdzZzNXFIaWNYUWRucFl0MWs0VFFnY05yYmY5?=
 =?utf-8?B?WmswbUE0bmpPQ3RCNkVab3FJVk1OcXp0T28zOGhhVDV1V1ZKZUVSM0xnLytJ?=
 =?utf-8?B?eWpSTlgzaHFvZVZzMk1vVGhISUtQOEpYZFVHc3Boa2FRM1B1bkZFRSsxZzRj?=
 =?utf-8?B?OGRxOG0xQTg1d0V0WklDK1MvL0QxcnlkQUJNTklPdzZBem4rZjNTeEUyTWVP?=
 =?utf-8?B?WEdMSE1DZmRiaUZIbXM4MU9JTncvWFBNZDI3aDFhKzZVUjRxUjNXS0U4Vnlp?=
 =?utf-8?B?Yy91V0pQcy9qeFNWVzJnQUlZUHRVbVNqREZiOFhJOFZVTVBlbnk1QVZrWXJZ?=
 =?utf-8?B?REkvbEZJQWNERWZkQ1ZSVGpJK3lIS1AyMUpTdDc4bVY4Tmkwa01DZWQ0S1Rq?=
 =?utf-8?B?M200U0pFaHBEbVR6YjZRV1VPR0h1Ulc5WitETWZjWGhQWFlySUJCYnZXYUhK?=
 =?utf-8?B?Nm1qNFczUlJhM0JTbUtyTkZJdWYxRTJyMjZQbGhBZG1PSEZURy83cklhVlpx?=
 =?utf-8?B?Y2x1Z2Z4OHNhajhiZkY2eGkvNk8wWE4vRmVGcnhqeExOLzE4OVk2MEMxSW9B?=
 =?utf-8?B?eXF5QUJqdTduZk9BL1BzdkF0d0hoOFBNM1hpTVJSK0hrNkVpSWw2RGlRT1Bm?=
 =?utf-8?B?cTJLellrVTk1c0d4cXBTK3hLNjc2VzJLSEo0UFRydFo0dWRmRW5UM3RmeTZ4?=
 =?utf-8?B?VHcvd01FQ25QSUorbndzd055VUlUNmZnTDNaMmM4NXBlMWJtOFpEM2dKUW1Q?=
 =?utf-8?B?OEZwNVc1aFpPbU45MUFaZlJvd3UzMUhhZ29ncGRCNElSSURYMjB5ZC9uS1Iy?=
 =?utf-8?B?a0pLZGp4WGJBU3NwUXVmUlFvNEc5dHZnQUZmaFgwbmJIM1FROU05enlwRkhv?=
 =?utf-8?B?Y2dUT28ycjAzTWs5bmpkd0h1eXc1MU01cDhoYmR5U0dEM1VzbmltQXk1WHFh?=
 =?utf-8?B?akVNaFUxQThMaGJaR2kzcDNnY1VnamJDWDg3N0lqclVaR2EvenVvT2pITEhY?=
 =?utf-8?B?cHcvQnZFZ3MyU3FsU2hkRzkvTlJueWRScngwaHp5bk9YOEpZOGNpdS9UbTNr?=
 =?utf-8?B?T25Ib0gyb1FFSCt3bTdYYks5NVRCVkhmdnpUWkZJbGhMZEpiVGZudEN0WTNl?=
 =?utf-8?B?ZWw5SWUzZUtwMHd0M05IdGplY3JuWEw0RHlCQW92OEhocWRFK0NEREhPK0FF?=
 =?utf-8?B?V0RoNjRJRmhFL09wdm9Rcjl3Tzdwbkc2eVhrYTZCUExkZE5zWXlLcU5Lb0tr?=
 =?utf-8?B?U1lYQm9ISU1nTWVTN1hPRkxBaVhMdFpXOWR6SWVSUUMrdVBNYVFOalFqcURa?=
 =?utf-8?B?SjhlVHd4RERucE1XVHRGVjVvWjJENGZTdVh0eE5TK1dpM25sdGUvOHdIRXpN?=
 =?utf-8?B?c0JXckNuMnN3bmZpcE9EcVZTazU4YVFCTWw5azY2Q0U2MVY4SmN0UDMvNXBZ?=
 =?utf-8?Q?/KZcbEx5Sx9U/ZC4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D78BD115AC422F448F8C9DE13586F46F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb680003-63d8-4439-d45c-08de5a499b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 06:35:31.7146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WAMLh+ne8E/lqy0su7abQGooMMlQV8/817/KmCzDsQLJAwBc65lnL+4qQvxJhClSyGG2aQ7sl4q2qAgzTBT7U2qfgWCgkOnrgjRCOfjKsMo=
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

T24gVGh1LCAyMDI2LTAxLTIyIGF0IDE3OjM4ICswMTAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gRnJvbTogQ2hyaXMtUUogQ2hlbiA8Y2hyaXMtcWouY2hlbkBtZWRpYXRlay5jb20+DQo+IA0K
PiBBZGQgcGluY3RybCBkcml2ZXIgZm9yIG10ODE4OC4gVGhlIGRyaXZlciBpcyBiYXNlZCBvbiB0
aGUga2VybmVsDQo+IGRyaXZlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzLVFKIENoZW4g
PGNocmlzLXFqLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKaWxsLld1IDxz
aHUteXVuLnd1QG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVml0b3IgU2F0byBFc2No
aG9seiA8dnNhdG9lc0BiYXlsaWJyZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBTdGVw
aGFuIDxqc3RlcGhhbkBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvcGluY3RybC9t
ZWRpYXRlay9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqAgNCArDQo+IMKgZHJpdmVy
cy9waW5jdHJsL21lZGlhdGVrL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDEgKw0K
PiDCoGRyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ODE4OC5jIHwgMTM0NA0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMTM0OSBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL21lZGlhdGVr
L0tjb25maWcNCj4gYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvS2NvbmZpZw0KPiBpbmRleCBl
ZDRiMDJiZTBkZC4uOGE1ODhkMTdjNGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGluY3RybC9t
ZWRpYXRlay9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9LY29uZmln
DQo+IEBAIC0zNCw2ICszNCwxMCBAQCBjb25maWcgUElOQ1RSTF9NVDc5ODgNCj4gwqAJYm9vbCAi
TVQ3OTg4IFNvQyBwaW5jdHJsIGRyaXZlciINCj4gwqAJc2VsZWN0IFBJTkNUUkxfTVRLDQo+IMKg
DQo+ICtjb25maWcgUElOQ1RSTF9NVDgxODgNCj4gKwlib29sICJNVDgxODggU29DIHBpbmN0cmwg
ZHJpdmVyIg0KPiArCXNlbGVjdCBQSU5DVFJMX01USw0KPiArDQo+IMKgY29uZmlnIFBJTkNUUkxf
TVQ4MzY1DQo+IMKgCWJvb2wgIk1UODM2NSBTb0MgcGluY3RybCBkcml2ZXIiDQo+IMKgCXNlbGVj
dCBQSU5DVFJMX01USw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL01h
a2VmaWxlDQo+IGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL01ha2VmaWxlDQo+IGluZGV4IDU2
NTI3OTE1N2Y5Li5iOTExNmMwNzNlYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waW5jdHJsL21l
ZGlhdGVrL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9NYWtlZmls
ZQ0KPiBAQCAtMTAsNiArMTAsNyBAQCBvYmotJChDT05GSUdfUElOQ1RSTF9NVDc5ODEpICs9IHBp
bmN0cmwtbXQ3OTgxLm8NCj4gwqBvYmotJChDT05GSUdfUElOQ1RSTF9NVDc5ODYpICs9IHBpbmN0
cmwtbXQ3OTg2Lm8NCj4gwqBvYmotJChDT05GSUdfUElOQ1RSTF9NVDc5ODcpICs9IHBpbmN0cmwt
bXQ3OTg3Lm8NCj4gwqBvYmotJChDT05GSUdfUElOQ1RSTF9NVDc5ODgpICs9IHBpbmN0cmwtbXQ3
OTg4Lm8NCj4gK29iai0kKENPTkZJR19QSU5DVFJMX01UODE4OCkgKz0gcGluY3RybC1tdDgxODgu
bw0KPiDCoG9iai0kKENPTkZJR19QSU5DVFJMX01UODM2NSkgKz0gcGluY3RybC1tdDgzNjUubw0K
PiDCoG9iai0kKENPTkZJR19QSU5DVFJMX01UODUxMikgKz0gcGluY3RybC1tdDg1MTIubw0KPiDC
oG9iai0kKENPTkZJR19QSU5DVFJMX01UODUxNikgKz0gcGluY3RybC1tdDg1MTYubw0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXQ4MTg4LmMNCj4gYi9k
cml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdDgxODguYw0KPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMC4uMzg2ZDRkNGE5MjINCj4gLS0tIC9kZXYvbnVs
bA0KPiArKysgYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdDgxODguYw0KPiBA
QCAtMCwwICsxLDEzNDQgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
DQo+ICsvKg0KPiArICogVGhlIE1UODE4OCBkcml2ZXIgYmFzZWQgb24gTGludXggZ2VuZXJpYyBw
aW5jdHJsIGJpbmRpbmcuDQo+ICsgKg0KPiArICogQ29weXJpZ2h0IChDKSAyMDI2IE1lZGlhVGVr
IEluYy4NCj4gKyAqIEF1dGhvcjogQ2hyaXMgQ2hlbiA8Y2hyaXMtcWouY2hlbkBtZWRpYXRlay5j
b20+DQo+ICsgKsKgwqDCoMKgwqDCoMKgwqAgVml0b3IgU2F0byBFc2NoaG9seiA8dnNhdG9lc0Bi
YXlsaWJyZS5jb20+DQo+ICsgKi8NCg0KW3NuaXAuLi5dDQoNClJldmlld2VkLWJ5OiBNYWNwYXVs
IExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MNCk1hY3BhdWwgTGluDQoN
Cg==
