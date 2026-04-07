Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19FCFEEF41
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 13:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 171ED841BC;
	Tue,  7 Apr 2026 15:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="UEEt5M90";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="KlN/z+Ch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E650D841C2; Tue,  7 Apr 2026 15:16:30 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D3B9841A2
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 15:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: f8201830328311f19a16598d5ca7f8ec-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=mQRXaUMEg8I+eCLi5OYKoXmwy+xCe3ybvnWEYxfVBak=; 
 b=UEEt5M90yRC/LDmITm7bxz/sby5t202jMwXgg10+or+BTRbyydnUEmQroFpBl7BgxVrPJFx6UYoTZPk+bFtx0Wdkvb323zrOm5rDIa9sZWz7xmYnZTmqi85mT2Sh/zXFh34nwa9Ii9gJKUZGAI9+zPVn0ZxdpwvVN9S36zGniDg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:a6d41a6d-9243-42a6-b84f-a4e387b4829d, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:a7ab9524-cb5c-4236-a89a-9a7fb20c9bc4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f8201830328311f19a16598d5ca7f8ec-20260407
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 17937937; Tue, 07 Apr 2026 21:16:21 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 21:16:19 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 21:16:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTgHeDLOQsJI4T5xEyeCm+OeJNLsyzyhL3w97M0xo4RoxA/Zs6RaoVpbQ4V/vu8Yi9V9yfYpMgQYlSfhEuzPFKhoTg1v4E5wey2FrgerAOy3ix+RrLG5EnTOU9Kq5gBWZNiaW1e6/Lase2cUZX1nxozbIhQfrMm0+iCcmDj9CRm1eZJk76DEBH4W7OTOQRAIjN1lvdSPhCT3mR7KPwPqKCKx911EOAJ6d0b2OL2VQz5UYZiSTk7yj4i9+UPh1CJNsvqZAMEA6P+3K3agWhCivXaOhuHbcwQQImf46lsTS3Dc+KxL3+OXS/5Kn4tmvnyqbD58iW8F5bXJjD+/iYqZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQRXaUMEg8I+eCLi5OYKoXmwy+xCe3ybvnWEYxfVBak=;
 b=CfpcxycGJzRbiJmHAsLh4ow6T8N7BglGU735ZWgcGxv1nE//vu+nJmdRYPKkwaEF6atzRoMTMYPkshbiH1j9NKAXtfAy8ZrdujgKs2xg1pWDPsANrRzIwpojWdkppu3iaTrqZXRdG6bL3oUkXeR2MUes64jsnQf6XSh0DW2lV2Rm0sFUbkFfnX5zC4bbI7SueNTRiVnSGiQB8e+6AddG0P4HPnHNPplf4uqu5uyVZVk9GyG014KGZ24Nl0HFCsickt3ComnaFG/vLQ+2jW9ipyrgVGe6IM+cFdmNlWjkMF+KcOTsPB6oHIQxprJRkNmn8XlZkTqOwqYLJEzLEE9qOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQRXaUMEg8I+eCLi5OYKoXmwy+xCe3ybvnWEYxfVBak=;
 b=KlN/z+ChEA8FGhEnRrwioGX4fXQSHdMW7cAdeFHWWTfmKFnGRcXWLGeyF6d0XCHtN935xHouk4ad9dnCjaEWvyYh8vPFR1AEmlI8OXRHUjU0BrPT4rknAZM3OpEbDHtfB4/uPQfpehMsg88B7KojOipd4LHOTB8iNuHpk8YI22Y=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KL1PR03MB7150.apcprd03.prod.outlook.com (2603:1096:820:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 7 Apr
 2026 13:16:16 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 13:16:15 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 Ryder Lee <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "trini@konsulko.com"
 <trini@konsulko.com>, =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
 <Chunfeng.Yun@mediatek.com>, "bhupesh.linux@gmail.com"
 <bhupesh.linux@gmail.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, "lukma@denx.de" <lukma@denx.de>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>
Subject: Re: [PATCH 2/6] ufs: mediatek: clean up zero terminator
Thread-Topic: [PATCH 2/6] ufs: mediatek: clean up zero terminator
Thread-Index: AQHcwIX3986TKTFVPk+K/0a/x+waDLXToF8A
Date: Tue, 7 Apr 2026 13:16:15 +0000
Message-ID: <5e9d47646e7a87a7592b63824aefcca5dd51894f.camel@mediatek.com>
References: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
 <20260330-mtk-genio-720-ufs-v1-2-3bad8362ed70@baylibre.com>
In-Reply-To: <20260330-mtk-genio-720-ufs-v1-2-3bad8362ed70@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KL1PR03MB7150:EE_
x-ms-office365-filtering-correlation-id: 810633a2-a895-4a91-c8a4-08de94a7d8e4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: DLyh/c5elqy7ZVEmnmXqh0xLglc71CVMMzp6TYHY2umtVLaVbDhRVF3hwZ+ftLav1fPzJSmzLLUDpljqFG7JEL0H23cgZXRd+ELpa14i3ep4hSt4NAcvJBAqlLhGyFAIjF2ccD4Eb03z1ehzTvX9D4Gxa5fKf4HepVLISLkLQSboHwkEOjMsVwCU3R09CQ6WhyZWBHTWa09fz4bOgSgaLxFnQMqhGD3BvR37o/M3+JrmkMDBDEV56PsW+aKcFNBZFEn9c0o/9De2WcMwnLbOM/cLXqjUeSZR/QY/8Rcl9U/erS5psn0pNtVrjMu6phx+ff+iVKt9m4xwniXDha2+3mPRnQMyaUuPG8Ls84aZIMDqwxlndeJ/+VxEWIn8hSbU0xhn7VUMDNNCrAmFEcM6In5gsBi861XmPqtzMe06jvkA6dWhtCeSzqfh9DndvJKURQlMge1i6M0AulTrYSETbu9iW4FUoopmsJb+FGWayj60npylDzPi2w5BFT3Y7NY6GT9hU1vB56wGkh11KQzH+VceXfEgCEp90KR1NPMP492Q3gNWQpgBNMQAyQi4X1bYbhQIX3j7tC5c44i56RKwdLVdjUnwAx8lZECj1gI4cSu9TCB6STI5piG2vkdJjR9WZU7l8Xg1SZIOfzFZs7d0Zvob0FQV6qzdXQ11o0z4iNUR5jCIkaD0FDRhD4T99hLmOuRtYKcpEOmwk97aD8aUzOSwLSis3xxzo6mVw2ReqkcyhFmu9aGhyBBkuk00HJKC4ysj6Kw+4qgtTwiqwp+wMrbGlFDrPIAA2n9m+D+8LY5P4dV1dez65HuLSBIeePML
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE5rT2cvRHk1OU1YaUpVby9qajFmdmhtdGw1MEtHb2Z4a3lhWmlEVFJhRFlm?=
 =?utf-8?B?Rjg1djdzUHMxQURNV0NiRkE4YzAyc1QyUDBwTjFZUWpBbTJ2VXljY1huaFFJ?=
 =?utf-8?B?TnpzVzhRTGljblkzakVGZUFEcnY3cTROaDRJcVoxdUxiUXRMUHpKNlJDVmtm?=
 =?utf-8?B?N3RrTXBmSWFuSGNJaERxV1gwS3FMRDd5VmRTTGwxV3dDTEZ2azZrWTZBaXRF?=
 =?utf-8?B?d0RmdURBc0tjL2JtaEcxNUVpL29uaVJuRG1JYUpXbXBTNm8zMk9iMjkyR1Vy?=
 =?utf-8?B?UU1acHUvaGNHYWEyWUpwOFl5ME0wbUFKMnF1dGd3M2MrdVhRZnY2U3J5RVpQ?=
 =?utf-8?B?MnV2YlVEeGJkR29mYzBsTm9sbU1kY3F4QUsrZ25tVVRGUDJzdis1a3ZPQURa?=
 =?utf-8?B?eENqTk9xVnI1RVZDMm1JNlRuY1VwaWYxSHQvZjNuM3RhaCtZTE42Uk1VL21F?=
 =?utf-8?B?TmVoclRrRW1TRU1rTmpEOEw4b28yTzQ2b3NFZmkwUWsxelFYOFlyU2FtOURh?=
 =?utf-8?B?WmEzd2xheENBaGVaa1Nud00za0FzZmY4K1VSWCtlL3NzU0pVU2dIZFJxU2ow?=
 =?utf-8?B?aXZVNitvV0JyQTd6MGVpMXpiV3ZuTmhES2FwL0wzMkphUExHbmhwUCs1RXNo?=
 =?utf-8?B?TytaN3BNWmZDblNvRVhIOFNLLzlFQ2J5VzA2MENiMHpIMXdjNVFwSXhvUndM?=
 =?utf-8?B?MzluZWx1T0lDL1M1WlJhUnl5SVJDck5pemZpUGF1WXhzZEI0QTc0cUcvcC96?=
 =?utf-8?B?K2swWWFPQTZPUFVWV1ZwVnRKS2dsL2pNMVlJZWpMMFJiM0JJMmgwajJGTThR?=
 =?utf-8?B?aTFEL0FOOXNrZE1BbWtvbnE3TW1ybE9DUitQSjR0VWxqYkpodEFtMDZ5UmxG?=
 =?utf-8?B?eUFxb0srcDNEVTJEZENxUzJZcEZGUWVNdzlkV1Bva2hvU0UwWW1ScjRqNFJt?=
 =?utf-8?B?K2crcFEvc0I1Y3ZHSkk5aVBibjRXa1VoRSt3ZVJtOVpNQjJXVk5yYWtERXVR?=
 =?utf-8?B?am5BRGtSeHV3ak5NbmM5U2dlUm5URHdWK3hPcjhQb3dVNU5ub3UwcDZaOGN0?=
 =?utf-8?B?U1BwN0ppNXgwWmVJai9mMUJKYzdybmxEYkQxVHVScGZtbk9FVzBMSWlLM1hl?=
 =?utf-8?B?QmVmM2l6NWt3ME8vUm9ZOWhHSkxkUzFRaWg3WW9XMWVNdUJOR05ENm1yWHpD?=
 =?utf-8?B?MjUydUpkZkZWWEs1ZEk3UjU5bGx6cmxPbnVWM1h1UVkyQWdIdi9BbUhWbE0v?=
 =?utf-8?B?OHNpMXVNVkd2SFovWkNKV1AzQWxLaEh4Z3ZFbXhHVnpHN1NtRjlnZjYwOGZV?=
 =?utf-8?B?N1NIZzFmdFJKdGNjVTAyY3A3US8yZkdnRnlJRUdzeDB1UjFaK1M2TDg2bmxZ?=
 =?utf-8?B?ODFiTUpmRlR6ZlBjNFRuV21pVkhEeFVVS0VKblU0d0t1RzU4dmFlaTFhZ2Ex?=
 =?utf-8?B?OWk0ZjZqQkE3dXJRZHRxbkxFdU5YMytNcjF0Mm8vbGFibmdPaTF2elBKQ1Vr?=
 =?utf-8?B?VVpFWkFpRmN2ekwwWHRYWXp4bFphaHFDd1I5b0svMnc2SUZQYmZNVkdWSVNv?=
 =?utf-8?B?aVZnQ3k5dE5YcTdxZ2tGckNTbENoUi9GTjlKbHhROEhEQUFweC9FZVBJVzB3?=
 =?utf-8?B?ajZwdFUvYWJKUjRjOVpHYS9DSzhWRVlaWWRGOUVXTE5CczgzcEVhY3JaQWVo?=
 =?utf-8?B?VXpPSTlFVUk1dlkwdDloZW5JNDBhL0ZvaTM3RndPUDRzVlh1Vnk0UmlWZ2NN?=
 =?utf-8?B?WWVtOEE3NlZwZTlmQnlMdWdaQ0JPWnRVdjE0eXVrTXNKbm11TkZwUWR2QzdM?=
 =?utf-8?B?Zk5CZmZDSmQ5NlljNmtyZ2hFRFRHa3ZLSW9HZXVFOG9wQ2MzVGhXbEdzcjUz?=
 =?utf-8?B?c0p0dG1KYnJuL0ZuOVRCWkdNcjNyRUpBQzMxUDQ5QzdSSTFyMXNtQTFzV01K?=
 =?utf-8?B?S1cvV0tsdkpvTnQzbFlmUVh4c2p2L1dXN2dDQWxjRXlMWXlDOVAvR3RLU0tm?=
 =?utf-8?B?WTRXeFpPcHB0Y2RPVDE1WEJicnZSWjlaNnN1R0hzSEdsNFF0ZDRXckRiWHA0?=
 =?utf-8?B?Wm04aEZSWVZXbytlZHZEYWIzQVhHNnBxdlpmK0ZuZnJnUUIxenQyL2JqNnQw?=
 =?utf-8?B?dncyUTBGREEvWGFVMHhFaVZYNEd0MVI2cHJHK0Rsd2hwendOWkdaWTBzUnk0?=
 =?utf-8?B?TW1RTkdHbS9PUGhUWmZMSHR2MHp2SzlRZG9HSHJreDJBUkMxRHBCYi9QTk52?=
 =?utf-8?B?VWNzeTB0dU5GalR5L3dEdmhkYWV4RUdrSGY2MGJBdTJ2ZFhRNUdxZ0hNckxm?=
 =?utf-8?B?QUJPc3pOajJBbVg0YVFzQmlGcU1WUFMrVjBHNjQzUitYbU5kM0FxbURsaGY1?=
 =?utf-8?Q?cbp9QA3hGdxyQ3ZU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <787BCD93F490094DB15972E6665DF29C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eQFqEHDd+QzCh2il3rGi3PZoWlEzkh+RsufxFIyRlgsOvIJ02h94EUzYxG+JImw6t9tdKQIkDkTswW2yxEDPsDLS7QQbWU0sX5wPlFFEpESrsvM3xO3N8mCoPxKruLAE7+vlOiGqGQ6f+uOmnXv2jqLBsmG3gqastBpSsRa2+65uXZb9saPrAv6IajHt/Ti1/O+VIifXuR/OBd6CPpOqjpQQxp0eqdzMxBttWISBgabw5dVQQXxh0qFtGasqavglFz7zsKVLRtEXyt5GFLhjhi5IFw3Cwg1LBKpHHKEqNaX1OBUVFVBtbDynjhyC1l340xrFSKhcXNpXtSteut2Bhw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810633a2-a895-4a91-c8a4-08de94a7d8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 13:16:15.2392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1cyh9pbVcN4xJi7U0Caaf8NduCNW/a+HcvAsANv386ngo6KPZnxMxCsOLI7xSahpTUJWdZ6FU+zoFQR6wr8uynloM4B61DeYb+GzYvpoQLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7150
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

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE1OjQyIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBSZW1vdmUgc3B1cmlvdXMgYmxhbmsgbGluZSBhbmQgdHJhaWxpbmcgY29tbWEgb2YgdGhlIHpl
cm8gdGVybWluYXRvcg0KPiBhdA0KPiB0aGUgZW5kIG9mIHRoZSBkZXZpY2V0cmVlIGNvbXBhdGli
bGUgbGlzdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJh
eWxpYnJlLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy91ZnMvdWZzLW1lZGlhdGVrLmMgfCAzICst
LQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vmcy91ZnMtbWVkaWF0ZWsuYyBiL2RyaXZlcnMvdWZz
L3Vmcy1tZWRpYXRlay5jDQo+IGluZGV4IDJjZjY1YTMxODVjLi4yNjg2MjdkNTg2MyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91ZnMvdWZzLW1lZGlhdGVrLmMNCj4gKysrIGIvZHJpdmVycy91ZnMv
dWZzLW1lZGlhdGVrLmMNCj4gQEAgLTM5Nyw4ICszOTcsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHVkZXZpY2VfaWQgdWZzX210a19pZHNbXSA9IHsNCj4gwqAJeyAuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDY4NzgtdWZzaGNpIiB9LA0KPiDCoAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODE4My11ZnNoY2kiIH0sDQo+IMKgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXVm
c2hjaSIgfSwNCj4gLQ0KPiAtCXt9LA0KPiArCXsgfQ0KPiDCoH07DQo+IMKgDQo+IMKgVV9CT09U
X0RSSVZFUihtZWRpYXRla191ZnNoY2kpID0gew0KPiANCg0KUmV2aWV3ZWQtYnk6IE1hY3BhdWwg
TGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQoNClRoYW5rcyENCk1hY3BhdWwgTGluDQo=
