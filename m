Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C485EB48FC
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 11:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 087FA83D6C;
	Thu, 12 Feb 2026 12:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="slNWoXcm";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="sFC/tqrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B47283D71; Thu, 12 Feb 2026 12:02:20 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D579883A47
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 12:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 47e1b6f0080211f1b7fc4fdb8733b2bc-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=5fRqL83cudgfsKSR7v/sr72J0gcUczYyjTk1A4XLr9w=; 
 b=slNWoXcmnsTejzlxa5qszFLhoW1xVc+AhTLkyrb+c5AJNB0JzplloZTo5+9SBesDxiezf/RtFrU9L6XmES5qB1vsQcbbWMuqjb7EvP24JhG64kIAzawcegvr8qLsA8Ushqf+gsx3VZ31mer8KDnzIf9LQNBdtffnY4FJKr0beWg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:7a482034-cad5-429a-a4e4-1a3ff825ae87, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:a9f99ff0-16bd-4243-b4ca-b08ca08ab1d8,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 47e1b6f0080211f1b7fc4fdb8733b2bc-20260212
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 320456959; Thu, 12 Feb 2026 19:02:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 19:02:10 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 19:02:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iz+1QE6JolF26cOeTjl1g+004a+RmxMKHCE+4vBI0a6wZKAIQqChxq7MjIZ6MIm/hTPDOSP+h5DRPEI8lO6FFn2PDkjjste0bcGTdFwHoN/eTBL0OgVHhUNs9Yq/PwQ0X+mU6qAcNFtSfBXGGT2XeWwGZzr1PoOTP17XQ4O7HtnK8aRmJAcD+sPkLy0DA30Vmzu1Ro5yHv7wFgsr4vKum4MVOrU6orFOvyteyjraHHSAslWcDNEXnsY/4ZkgFbUkpwaZgw/vCDpu74Y5M3QJ5kF3dEkMQAEgL1UFlMcseGfvFshLAyF4ampghqu46OfbiPkqknHRmZhoXZ0goazAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fRqL83cudgfsKSR7v/sr72J0gcUczYyjTk1A4XLr9w=;
 b=gGwjlLG9K+vbzZnCNDHeSO2KsZV4HKEn5M7DHboKBQFOm0Y+/G4Mx4DJuFCO5G6Mz40CH2FbEf/sRkK7pby3DgLf8N+5VwbhwM0eZeAgTdE098kby4X6IqVGv+ni5mro9wj/EQm4gfJTU2YxCfEVcRLLcBnb7DUyQBZkZ+SN04bn6ELoIwC0uYtg1kAlRp9go0wiTp4DO3kJyJzVgr+E1646oMnQNvRdjLfW89xNWcIeqtFM4UlRK9pVUXRspzNhKUltjZUoOFK3TTeyVvTuQtD7LfL2WmrWRKgL+hNlC0XucBDFd9tMzeq2CUgJy14f8x0c4FRfK33HfEvKo+VggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fRqL83cudgfsKSR7v/sr72J0gcUczYyjTk1A4XLr9w=;
 b=sFC/tqrnOWPRmMWY8eADPi4e6dBZZp3fyeaLw3Gd2ZgIvzWu+CBkL5uqDxxG5u5vgWtJI4cTqhvXfizShdF9iMC0eRzbk+odZ9D2jiMiUVpBw7fdUtd8e8CZOjadJLLkOr39RJFXgzLrk8pCROsLp9HkvRvKpT4DPq6cOVjS1U0=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYSPR03MB7739.apcprd03.prod.outlook.com (2603:1096:400:42e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 11:02:07 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 11:02:07 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH v2 4/7] arm: mediatek: make mtk_pll_early_init() static
Thread-Topic: [PATCH v2 4/7] arm: mediatek: make mtk_pll_early_init() static
Thread-Index: AQHcmedhXofItqpvv0KXlB+be4Ja97V+5taA
Date: Thu, 12 Feb 2026 11:02:07 +0000
Message-ID: <7cf9c451c7c66fe16036df89dda1f3c60b14ae22.camel@mediatek.com>
References: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
 <20260209-mtk-mach-clean-up-duplicates-v2-4-e3b22282c74d@baylibre.com>
In-Reply-To: <20260209-mtk-mach-clean-up-duplicates-v2-4-e3b22282c74d@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYSPR03MB7739:EE_
x-ms-office365-filtering-correlation-id: 439e1ec3-4a83-42e4-be7f-08de6a262996
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bkhmcHZrcmV1YmM1ZTdnMThtZHo4b0ExdWdYa1pNaW1mSm9hWFFuOUxFRzNV?=
 =?utf-8?B?VUNpU0V0K0lhVXFLUGJ2M1RMT1dOeHNzN1RESHlsem1qaWk2Ly9sWVhOckMx?=
 =?utf-8?B?UjNENFhSV0RJNFRIM0Qza2dNNytoS3NIYXV6NFpvYklxeS9ibzhvV2NEeVRz?=
 =?utf-8?B?NXh6ZXVRa1JKRGRieGlnQzcrWFB0Q0hLcFJLc0svYzcyMER3R2gzVkxWZmJ4?=
 =?utf-8?B?cFZkaDFYZUlzdi9sZzhmdityY1IyalpNWjdDcVpUcURHNVl6MXExMUd0Qkxh?=
 =?utf-8?B?Q2ZIdklnaHlseVd5dDBjU2JnUzIreHc0WjRzZUh3V281K2dFUUNncFBIeXh3?=
 =?utf-8?B?VTRWV3R2ZHpiL0xmOC83bmdrMVBLWmMvbDE2SytwREgrWUk5UHVmWjlKbDNJ?=
 =?utf-8?B?ZmFIQ2tydnkzcER1bHh6SFR5VG04MEV5Yzg1MUtrNmJRN3htOXg4a3BhUzBC?=
 =?utf-8?B?NlJmQVdWTCtKWjZhMG1XbTI2TnRiQXFiMDJUSWtiZTB2MnFmNkx1aXJqb0VZ?=
 =?utf-8?B?cnlBeGNzRWxCWnhjSmNOUURkczZPcGdUZCszbk1PdWxBbTAxTmhZd2ZoZXk5?=
 =?utf-8?B?Y29ONFprbUFoNjNrNTRvTFFNYmNOS2J1VldsL01JL2JGYkZDZEU1S05zYTZa?=
 =?utf-8?B?aHVPRWhTOEtKdFVCZlBWck9aVE1peW1GT0F4UFpsOE00S1VUT0YrMzRmU3VK?=
 =?utf-8?B?ejVvVC95NzJmRDNLRnFLRkVXbGNWbTFCQVNSTTRXNTlQTnAzRy9MVEo1TUV5?=
 =?utf-8?B?UVh6ZlJLbFdOc0JBZVFpVndJUDRtR29QcFByR0xZbnRSdEJMU1I1cDFnbGFz?=
 =?utf-8?B?ZHlKeTFhQlBwblgvdzdMOU9rZ1Fpenc2NG5BaGlST29HcHJ5ODJHU0dIbWs0?=
 =?utf-8?B?S3l3WVNEQlhCMk43Wmc1TXdURU56Q0VobFJ4Q09aZS80TG5TcXZBR0Z3SnJZ?=
 =?utf-8?B?bURPLzhQbE1PeXJienl1RWw4WEIwa2h6RXFNWERxa2Q2dlNwY1lMbSttWUhH?=
 =?utf-8?B?Z0JCTmVuN3IrMlpVSjdjVFZQK2NlWVhFb0hpenFGNjVXeTd0dG00SCs0T0N3?=
 =?utf-8?B?eGcvVkhtU2FDbXZRWDM0aExhcHl0NUhpMEVPUEVDcWpSOGJGak40dC91Z3RJ?=
 =?utf-8?B?SG1BMDB3VU5aMGtmc2RjNnByd3pTc2FENVMvTVdTS1hMRkNSbWhCT0dvRTRI?=
 =?utf-8?B?R0FtNXFJM3pKNlBpNlFJcC9EQ2JxZWdwRVpnY3BoOFg4NWpSM2pGZGZhTjJs?=
 =?utf-8?B?c3AyTmxTSU9OTjJCRnYrWWFWR1ZaMm15ODdDKzZIb2xadVNTSlF0bEFOb2hI?=
 =?utf-8?B?TGlibVFWSjJhK1Izb1VNNURsVldLSno3UUxBUE5NTURKYXhVU3plNXVBcW5U?=
 =?utf-8?B?S1kzWkUyQ3AvS2xsM2QxWUJDUE5kS2pZTFg4Kyt4ZzNHVVdqNlQxQmNzWmNR?=
 =?utf-8?B?Qk9CODFtZFVlYW5lV096elB6QXJ3bm9ITHgwUkdDRno4YWlwZDFYQllDVTc0?=
 =?utf-8?B?eGFxdlNzS21aSzFZalRXN2QrUXhsNlJCakd3UDg5WkNEWTlmTXFkNkJaajlH?=
 =?utf-8?B?bjI5OFVGM2RqKzNtYlY2cVMwR2syRmo3WDVkQjFQU1NDSjhRVUI2L3AzWnhB?=
 =?utf-8?B?YUR5bCs1d3ROWUI0cEE5bGtHSkViVEN3TXBuR2NCb3dDWCtJZEhWS1VQT0Zs?=
 =?utf-8?B?TDdxR1hJbHVMNDV5TCs5TERLem5ORGFhbGNZUjUvc3Nadjc2Y1NvRnp4bFdJ?=
 =?utf-8?B?ZW1RbWxlNXZkZEVRTVV4VDNsck5zT0w2QjdITzhsR3JKeklzVCtPV3dsOTVT?=
 =?utf-8?B?MHBXMExUSVo4cGhZQWFqOU5FRXpJcVBXTFFVYjVPWC9TYngzWWFIZ2loRGNy?=
 =?utf-8?B?R3p6cGlIaURuRDlvM2ViOTdrYXAycEhNcDc4cHVjdTRRK0dZaktzMy9aRzRl?=
 =?utf-8?B?VWg4TUg0VXkwVkxCS0tZMWNnUGRVVk0yU1VuTk9tYitIeEtoSUd6U0dEdk5O?=
 =?utf-8?B?eXNENDBwRElqUFJNZ1diOVFRQzc0WkZCd3IvK29BRmRyQUw4KzFEMitIcytq?=
 =?utf-8?B?OGhOdDVkY2FLdWlEbzNPT1Z3Yk9DUzZQRWRKQmMwSGx1RENqT0RtVnZQRkZN?=
 =?utf-8?B?d1JGL1VjTEhxWkxSamh0aUl0cVd3ZzR2VGg3M3JadWF2RE1YR0YvVTVsNnAz?=
 =?utf-8?Q?tF3Nt9zlzSgj+m+ZkkCxBtQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L29xb2ZseHFFb0RMTjRkRHhaT1JWK3dlVUlrR0VJcno1enc0ckJDdlhPTnFv?=
 =?utf-8?B?ZG9hMmcwdGtLZWhBSzd2RXAxalYxaGhEb3NQVnlhWG5DQU9PcjJBNDlDTE05?=
 =?utf-8?B?OEk3WUdaaWZzcEt3SFY1N2QyT0N4UVlZL1NodzE4UUwraFNPdDhGenVGQ2hU?=
 =?utf-8?B?eEg5YUk2VlZrMjNJaFdvUWU0czNXL1lqRHczYjNuZXVGbERmT3JWT1hCUFBz?=
 =?utf-8?B?NldDVXg4VkhOeCtnamRoUnRmcXZLUGxxNFRYS3FuWWtQWXNhdWg0a0tXMTVa?=
 =?utf-8?B?UnR4RnJJdm5URGYrRFU2Y3dGUi82NkUraFFGaTlKdzhaU0tmWTRPMDg4am5D?=
 =?utf-8?B?MkFmRlh2b0tNSmlPM0RWdVR0T3pIeGxkekkvYmZZbC9HWERUOFdCcjVXZVVk?=
 =?utf-8?B?ZUliTnFwaTFwemlzVkcycWR0alVxWEpTNWc0QVlMQ3pIQTY4NjBvVGRibVU1?=
 =?utf-8?B?OTFNbWdWTUFOeGxSOEI2ZHZTTkh6SDY5M2tkYytMRDBoemlaazE2MDhhWWtC?=
 =?utf-8?B?YkY0MVJqeEF4L0g0eUM3SHZJY2paL1czUTZDaUUrUFYxdUprNlpmNUNraGFt?=
 =?utf-8?B?VkZGOTloVVV5aElwdkhZOEI0bVFiYkVRVzdXemdWYUw0RjJWb1lsL2NheXRE?=
 =?utf-8?B?K0p5M0szVUdGbHNpbFY3RWorcTFjZE50NWdFZUZJODNpQnFNVmhKN0RacVhF?=
 =?utf-8?B?VXpBWWFaK3ZBKzhtM0FTL1haUmt3TXlzMVVEeWJZWWF3Q0JLQzNKOVh6YVJm?=
 =?utf-8?B?Y1hEOFlpM1lkaXJJWGRMTVhLOFB0d3duaHQwc1VzZm9TSjVNOFBmSHRMT3k1?=
 =?utf-8?B?SjgvZzcrWjdqaHJBcU5WRXB1QUl1N1VNa3NCd2REaXlNUTgwaHo3NVQ1bEVC?=
 =?utf-8?B?MGVmcURiK0E1OEJKbHBhT1p1Y1V3d2Z6cmQ0R3lJaG1wRGdRUFN2ZWxmem0w?=
 =?utf-8?B?WHhhMnZ2WGZJZkk2eU1iOWxyVGxXcUpDZnNoRTZ5Z0JIK3BKOUMraVdZN3M2?=
 =?utf-8?B?RkRyQ0VzMWhuWGVzaWswL2x3NEJhMXQ5cGRESG9SckJ2bGN1aEdXQ1cxYmpw?=
 =?utf-8?B?WnVtenk3ZnYxaWRnRTBEK1dhK28xTEZVbzFUWkltRkw2cWU2TFJIVmlrMDlq?=
 =?utf-8?B?MmF2M28rR2dEUzFxdExTTlRhNzFEUVJCUHhjUVpncTJTVEo1UlJDbGN5QlR6?=
 =?utf-8?B?YjVXbFhLT0dEbXRxMjQ4YlFGdnc4dGxib3NVMlZEUm9vc0pCVE1tcHlrY1kv?=
 =?utf-8?B?K3JPZGE5SkZVcGx1VU5neUkzSXJzbVlVZVUrQWxkSWYwdS9raDdpOENFNjJM?=
 =?utf-8?B?KzN0dXNTMklYbEVMVVA0N2t0dFFSczJUYjZGNWowa2hGZkVvRVhWSTVpeG1Q?=
 =?utf-8?B?ZTE1ZkxBR1JNa1VMRFlDRUJLK0wyUFdudjlMRXpYbFQySWg0OXRWRUhOOU1W?=
 =?utf-8?B?YUhaQ04zRGNLQWRIU0h5ZTlxdnFBSlVzVFkrMHNKSWcxQXY2cjhwMW14WnRW?=
 =?utf-8?B?SFJmYWY2R0RYMDlPM1QrSDltckU3dktYRVdsWVEyWHJkSmpIeG8vYjFGdlkr?=
 =?utf-8?B?S0hKbGNWSHNHdUIwZGg1VzhwSUNwNExYUnIwRVVxMG1NVUYxRTFlTDdwSldV?=
 =?utf-8?B?S1N5YkQyM3VDbFZ2K1owWCtVWDZaK2tFMFpJWEZ5ajRKUkx2UWFjYXFiQzJT?=
 =?utf-8?B?a2hLL3pVODlERjJaUzZCMmhZaGtTWnZDQkNrSUdoMjdEL0p3V25URjBoWmdQ?=
 =?utf-8?B?WXNiaTRJRC9TZWVzck1XMU9GTDdkOXh4Z1hIcDlweGZqQk5qYjNibUNyVjR0?=
 =?utf-8?B?OEVRYXlSekNTa2EzajNsTXF4NHcvRk5TeEs2Y1dmVk5mQzRKRWs0TE4rNUlK?=
 =?utf-8?B?QVBLUWVRT05YZytMWnVSYWtoRmdmaHoxQkZKSi9WZFZyOUkyc2Z5dU0yS2Jj?=
 =?utf-8?B?Z2ZIREVudFZGd1hxV2tjblV0ZFk4VFZjdW5BbDVvQjk3ZWlkQmUxUG0vdkhY?=
 =?utf-8?B?dWQvdlYwbXAvdUI1eHVtVWZXdFZ4KzlQZ0l2d0owajVFZHpVYzgyK3Vzejd0?=
 =?utf-8?B?c3BEdk16Y093RjZFV0huMThLM29BYUJ4UDBKY0pCdkdSRXR3YkxqY2xzUXpW?=
 =?utf-8?B?TytLaXVqMnBMZFE3NUdhMFg3TFJvanlvU2plTEtlSmd6NnVxSDFlOHVlQUtG?=
 =?utf-8?B?ZktZSUxaekRubTBrTWUwZjByeUhCS1Y4cFA0M1MyODdnUDA2cDZGTVRGOWx4?=
 =?utf-8?B?elRpTGp4akJuUkVlUUgwNWUvclpSVURoa2M0UmZLdmlzWCtrY0lycU5Wekdm?=
 =?utf-8?B?Q3V1TkNkUzJhcTQzNUFRaE9Gb2tKWVBDbUZEL1lTTGd4NUhyV3N1RjZ5a25a?=
 =?utf-8?Q?h1kR9pTtIQpKw2Uw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B874260CF1045B408DD04C5067C4C313@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439e1ec3-4a83-42e4-be7f-08de6a262996
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 11:02:07.1894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +QlymnYQVJJhymksJHHZGF9YVl9U3b5cP3snMz23NRceidDJJC5tYn5pp13awqjGMrdbchJ+hqNRdEHNK1reB64oz8dI5sfc7ExnQGFtoVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7739
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

T24gTW9uLCAyMDI2LTAyLTA5IGF0IDEwOjM5IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBNYWtlIHRoZSBtdGtfcGxsX2Vhcmx5X2luaXQoKSBmdW5jdGlvbiBzdGF0aWMgaW4gc2V2ZXJh
bCBmaWxlcy4gSXQgaXMNCj4gb25seSB1c2VkIHdpdGhpbiB0aG9zZSBmaWxlcywgc28gdGhlcmUg
aXMgbm8gbmVlZCB0byBoYXZlIGl0IGluIHRoZQ0KPiBnbG9iYWwgbmFtZXNwYWNlLg0KPiAtLS0N
Cj4gwqBhcmNoL2FybS9tYWNoLW1lZGlhdGVrL210NzYyOS9pbml0LmMgfCAyICstDQo+IMKgYXJj
aC9hcm0vbWFjaC1tZWRpYXRlay9tdDg1MTYvaW5pdC5jIHwgMiArLQ0KPiDCoDIgZmlsZXMgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCg0KW3NuaXAuLi5dDQoN
ClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KDQpU
aGFua3MhDQpNYWNwYXVsIExpbg0K
