Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996C8FEEF49
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 14:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BDAA83A41;
	Tue,  7 Apr 2026 16:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="mnHTOFqU";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vhVpFeZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D8D58404A; Tue,  7 Apr 2026 16:38:11 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEF5180433
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 16:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 6100198a328f11f1ae70033691e9ac7d-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=w2kjdPPjp6WOK59hYB4sBJpjtGvPqICKbtobZ+90V0w=; 
 b=mnHTOFqUmf4R83jCPLK+SjPuPIxPk4YzLzy0HadhC6vDzILJ4jAEE/J+1B8cc+ToqQ2gCTMynTFmVY6nzsxZRF4QPrO2KkDyNlP1reKoRlGNDkPkfBwlp19Z7n7l5Q/PNDdzB4pDsk6PY2/AJxFTqVtaMmocTlO7zL7HtYdl8JQ=;
X-CID-CACHE: Type:Local,Time:202604072238+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:d020c366-a684-4690-83d7-a55cd3e1d8d7, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:27aaa894-f8ef-4ca8-bea0-143568f9ca1d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6100198a328f11f1ae70033691e9ac7d-20260407
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1523785046; Tue, 07 Apr 2026 22:38:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 22:38:00 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 22:38:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4DwPOFGomiTBLZExsu7cT+VTHgAUOM8h9NiTVSMl9YR6mgIfksLrGZY4lhXm5RJWW+b7sFcqXxQrVQdoje/NoK60+RP0tPTBjI6ZoEhlx3LC2CpUoVo9zzUzlmCY5//1j7P3UPpvTUc1bnbXqXejrl0/dQvPWNaAjI2pxEwZbenFCPpwcJIMrVqZbex2+P20G32HOOvEOudayDz9elWgrTohHo0fCO5IyDuU+hzHeyldhMOjJbUyrMXKHH9SEao7FTl1VvNYHnLRM2iAuDeIwbmlmikJoUwxcrrdFxAQ9lja0ofGcgYYek6KVEmiIVwWQLlAMVRuRzV9b9pt5JhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2kjdPPjp6WOK59hYB4sBJpjtGvPqICKbtobZ+90V0w=;
 b=C9ZTbyCvMJipD6P8KtpOOmuL+j0PbzRzRs+Sq7U/nU9HoM5RC5EDvEjkHAV8HK/+dpkyI9lipHa/FgI1SvVKXXz70XoYBIxZZUhdzigf5ypjkk3Cr62MT1onAPwvEmm1oo2eLFyau9ZWIhbhDHwyo/PFfheMP/MwqkRxsvzlYl5EKTaZX4vxdIo7qp3RAfemyHC+hoesdN4PiO//Cv4oev/3+dQ3PlH4WgXd2c6ccA61dfCHgRy2s9B80igxeIfOT7UxX6CJDv/ayIKVOcHXuWapjCDz1Eorhi1dQwa7RImpPjTz9hoVu+Pgky1FLsvO8jX6J1ysh5IBCJxVamIPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2kjdPPjp6WOK59hYB4sBJpjtGvPqICKbtobZ+90V0w=;
 b=vhVpFeZhiOQsykhPDyhjY+FXcGl+Dp+I89KxXfOQSrjWXAeO+4LvtxMUUMGZQFTLIc4hRGrH8CC3nT+eeobevVJnrDT8kTOQ5FpPyqF8u47Kktn0El9r5BYSqFhytiRY2uFRjN6i2MBedpOdimnYgR81xbdwZUxgqjlaTG9y3t4=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYUPR03MB7180.apcprd03.prod.outlook.com (2603:1096:400:355::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 14:37:55 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 14:37:55 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "trini@konsulko.com" <trini@konsulko.com>, "David
 Lechner" <dlechner@baylibre.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?SmlsbCBDaGFuZyAo5by15paH5r2UKQ==?=
 <Jill.Chang@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>, =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>
Subject: Re: [PATCH v2 1/4] pinctrl: mediatek: add handling for RSEL register
Thread-Topic: [PATCH v2 1/4] pinctrl: mediatek: add handling for RSEL register
Thread-Index: AQHcwF6e1ld8xV145Eyt8NLEUAOIvLXTt38A
Date: Tue, 7 Apr 2026 14:37:55 +0000
Message-ID: <b41f2e1d8f426dc348c15e491f783e2ce704c1b6.camel@mediatek.com>
References: <20260330-pinctrl-mtk-fix-mt8189-v2-0-05a737ec623d@baylibre.com>
 <20260330-pinctrl-mtk-fix-mt8189-v2-1-05a737ec623d@baylibre.com>
In-Reply-To: <20260330-pinctrl-mtk-fix-mt8189-v2-1-05a737ec623d@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYUPR03MB7180:EE_
x-ms-office365-filtering-correlation-id: e31bd090-6715-4c2b-3659-08de94b341c4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: HaVJqHNHotAfT5we2042ibJ2+3mExOYJpOyaJ2PMdhisuq9kANxBO2DiHBBBezS3JGT70tplBtLQe8DwfOpriHt45/CMjnZ7yONvvQq5tnxCbCW/i8HkogCR09MHaB3wvVSMIBArqSct5zBEB7IvfcgmCv69U2U5q+MwMRduUUNKSJ7lqZaCEetJEXce7f6LxovnkAVnK2+ydI2QoaC46FGF7Kr8IvrORGLlT+WCO4pvl4T+Y2VWItyaGR7b+Fg6w8bNTm+W2kcVKdfuVOeT4ETerwYvTyiXO+fn9qXr1kSSGgi7L11JvbOy+NDeUNm8cH3j4/MXttLRERWYDW4a+Iu38jaWMfR5QNjV9q0Tb/Wx1yIaXw5/RGEaEQkfEKRx375pNtcfcXRnoWwPxMMCrzn4dVI6BawRwz6RqR9YE0/DXLlZ4HIkaoHtBNhzHBpS3y7vpojLm5ojQb6MebJjah4fubyI3Wjy67y7qabP4jtoW3CUzRagsGK7s0Hpi7KgCeHB5KRMQYRERnv6x9C+gJOSoXtcALdKLIvyUhTgykt3+3WiGPpULhidPTdOCTMP+NcuqZKxTY+6nPkKvGxszIRmIJOMYGlk/a1ciDoJlhThuX5aGnB6/pTf18O0F6J+6jQ4A2syTW9Tu0XKttHa5sI/UeezDkNHFbmpxWhn/gC7zZWo8b3WBwYdWfaA53EFDVAPXd/3JopfYk89m8eWpIIUcz7/50lo/WRTH7ibehwznp7l7tRLnsSls0mOaJqrdND/idK2KhfERILqmJyALzTVaRDJlu27deWGSfIg4q0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGw2WFIwZVV4RUdHTFBMZytRWEk2U0JJL2dWaVQyL3pvem8zVC81VVkxdVlM?=
 =?utf-8?B?bXZVRGVzd29KMEZ2bC9PL0k1VUJIZXUxOFllSEthTUltTjcrZmJhR2Q0T2Nj?=
 =?utf-8?B?SXVxaG1PTWgrS0YrY014WmRFbGFHT1NteXorV1dXRHFSSzhSWjhFNWxCc1RN?=
 =?utf-8?B?N2JxSTZnWVRHcXFSeFBQZm54QW1SRUs0MWVpRXpZZE82Q3l3Q1ljdmRlY3VD?=
 =?utf-8?B?TFVYajl6elZXenl0WTB5WUhmbHpCNkNaZVJpVWxNVzZJK2J5VzduSkNwWHNZ?=
 =?utf-8?B?SE1YODJ5bUFmZnRqRitoZ0JOZlVBb2NTYVdkS29IdjFiY0gybHo2YXR6eHpB?=
 =?utf-8?B?MDE4UzNNeCtsc3pZNE8rVVBSc3FFaXR2V0FiUXV0NDF3d0txS3dPSW5mbFNy?=
 =?utf-8?B?ZWNtbHhrVy94RVNjWEFjZmNyN0kramd1QUtKa0VOYUxDS21yVFBLYlBSa3Zp?=
 =?utf-8?B?NWNiWWw0VWFWeUpBSktkb1hXYmVTR0RyV1VtZ1lQd1pxMHdWdHduK0dtRXV5?=
 =?utf-8?B?MERrOEpSanpMWkp6UGRkRURPQlZHb1ZwR0tVSTVuOGJMc1c2d2tRMFU5RnhU?=
 =?utf-8?B?dWxaNUdhZzBpRzJBWjBjOEpWMk5sZjdJYXduUmNUc0cybHdzSDkvRkYwZE1F?=
 =?utf-8?B?SWswWFNkcEtONG0wSk5aR1JmbDVycVZRWGZFMm91OXp1akhESmc3b0ZyTDBq?=
 =?utf-8?B?Y0xFYkwwQkdHS2UzczNTeTlBMzNxbW1OVitnUkNhVVlUYTRISzJXelJHRUx0?=
 =?utf-8?B?U3BSNGJ1ak1RdzBZcFJCd3cyY3BlaFNJVFZJQlZuN1o4VUt3cmR5UlJiZUxk?=
 =?utf-8?B?N2lqdkZZMWIrelh1eDJmakhqd1VQQjl4QVZQTjcwRlFoekR5K1ZEa3R1ZHFJ?=
 =?utf-8?B?VllrdnpENDJjTjI1b1kxdzdYTVJLTkNRQ2pEZDNTMko1eVliQ3kzdWNzdHRl?=
 =?utf-8?B?SThqcVc0aWlaRFNkOXVSNGZ2VThxd01peDUzOU5IYlh4NDZrdm9oNlRTYkJC?=
 =?utf-8?B?THRpMEpIeG1sais2V0YxT1oxRlpuNFlCeDBiRytzMTQ0WHlaSjUxRVE3Z1FT?=
 =?utf-8?B?THEzc3BQQjZmQlBhbjc3VHU5MXcySHV4aFpKMTNvS1NLSDYwbTM5MU1WTzVF?=
 =?utf-8?B?UlMyYmpqd0RMRFBWT3VDYlRtT3htNkJhampsZ3FRV29WL3gveEVtVzdacW9X?=
 =?utf-8?B?cFVCSmV5dm1IcHVRNWNYaGFGTmdlMG5jNkRnTHArM1pMNlZ4TUM4RFBYcEIr?=
 =?utf-8?B?UG41MVJwdEhkKzFraGZ2QnNwRVpUcHpiZzNTSFFYV2hrbS9CRzl4RXBvTzRV?=
 =?utf-8?B?V1F1ZWJ6aVR4TG5wdlRXMjR1aDNNV095NldaNWF4OTA1K0lubVVhN2FweHRq?=
 =?utf-8?B?ZVpWM2xIc1dkeWpsVzNxRi9OckxJNDFzUDdBR0U0NzJoKzAzNGV3ZUsvYk94?=
 =?utf-8?B?QzExUlRDVjBmakdPeU16dWJicW5HdkdLSEVYbUppV205dTlqQUhFbXNJWm94?=
 =?utf-8?B?Rml3RlgyYnZmelRzQkd2bDJMRU9nNjhWVW5MdEpNR0p3cjZiNmo5bWtRS0JE?=
 =?utf-8?B?djdQYW9NczIxMWVzQlRobnJycEtEVk1PaUE5OEcwajgwVFlhRytYdVVsK3FJ?=
 =?utf-8?B?WUUxbi9BWG9PajFjS2tjRHNYRlcxMC9KWXFRZHliZURkbEJCOXV4OG5CZjZW?=
 =?utf-8?B?cU5oNWNySnNJSFVrNXFDcTFtRVFhbGpTdTJFeUhJQ0JIekROZzl3TTlzcEVL?=
 =?utf-8?B?Q2RrLytrWUZXR1FXY0dMaVBTZk8ydktNWC9LT2t1azZQZjhGWkF1aXBJSlRX?=
 =?utf-8?B?ZFFwTWZLTnQ3UERiR2ZRN1d1cDRpaXJEVjRDMG1HZ29ZTzQzK2Z3ZWlFK1Nu?=
 =?utf-8?B?RGJXa3l4UmJFTnBqQmZSMUJOSDNjbGpmbFVGenFHVC9RUXNnT3RIQWlzNm9M?=
 =?utf-8?B?VDk1ajVYK2dvYWFaQU5GcWwvdEluQnRWQThsekhLZzliRm5hUUM1R0VHY1Ra?=
 =?utf-8?B?bVcxczVWUnVTM0ZieFBZVTd6R2ltbGQ1dnhMVkYybmkySEVFNDlnOCswTFAz?=
 =?utf-8?B?ZHhoUytsVXZkMDIxSjBSRlBKOTFKTWp6Smk5MW56MFp6ZmRnMTZxei9XcGU1?=
 =?utf-8?B?QlRmMzFBa1ZWdkZmcFBlNDQ5YXBJeElNRy9JMjZiNXh0YmdqZnBXREV4R0pQ?=
 =?utf-8?B?S1ZzQnljSDdpWm1jWklsTWxUYjkrU1lESFFhNVJraW1sZXN6bkdXYmdJSnNo?=
 =?utf-8?B?QzBacEdCOFZDcHJrUGNkTk1paUdMWmRTd1BnZFdqZ0lLQXY0SFpUeDQxdE9v?=
 =?utf-8?B?eEVZYzBpZ1U5QVdpUXpPZjVNUVZ3cTVzbWxtK0VNRXZibE1leXM5Sk04OFFY?=
 =?utf-8?Q?0D2GgKX1GQ1MHGhQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF33232332ED1841ACBDD2587C25AC1D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kWoGO47lJCDFpezVcLPyReGuzif3rFJL3Gwfrh3bd/L+19zePbDpovgWDNAqrGnZK0x1uO9cJTXhhLih3eRUlU6rHgMNE+SCofTz26LPUtIcQ18tfbMSgS7ivVWQphXCnlqLlGkByUgHoQEm3Cpuf84GuYdo4f0iOkZs12xI3Piiy5FFeWpar3HD/W3zA+0WyrCzbeikMNIwBiyqCSZQbkf4DkVqzqYTCWSM2qTXQxWMWuE0yACIUHKtehEBJ/gy5BkgCNycDwrGtGhUvqrUfs8Ntik1Urz5wVa1jc8PCiHUEGX3SOpxYCV9wq1oCsyj1acirP+K7GTJn6z69QPXPw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31bd090-6715-4c2b-3659-08de94b341c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 14:37:55.6463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7D3V7qfKtj2E6/f5oAQWPQq+lgPq2C7M+COhl2bFmmaTGXxWIjsp8it6laIVRjBeYUZSTyQU+ZaCZhWFw6Y83pAEj8PIBgE/rZgbymwxNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7180
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

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDExOjAwIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBBZGQgYSBuZXcgUElOQ1RSTF9QSU5fUkVHX1JTRUwgcmVnaXN0ZXIgdHlwZSBhbmQgYSBuZXcg
ZnVuY3Rpb24NCj4gbXRrX3BpbmNvbmZfYmlhc19zZXRfcHVfcGRfcnNlbCgpIHRvIGhhbmRsZSBz
ZXR0aW5nIGl0Lg0KPiANCj4gU29tZSBNZWRpYVRlayBTb0NzIGhhdmUgYSBwaW4gY29uZmlndXJh
dGlvbiByZWdpc3RlciBjYWxsZWQgUlNFTCB0aGF0DQo+IHNldHMgdGhlIHJlc2lzdGFuY2UgdmFs
dWUgZm9yIGJpYXMgcHVsbHVwL3B1bGxkb3duLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQg
TGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL3BpbmN0
cmwvbWVkaWF0ZWsvcGluY3RybC1tdGstY29tbW9uLmMgfCAxNCArKysrKysrKysrKysrKw0KPiDC
oGRyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1jb21tb24uaCB8wqAgMyArKysN
Cj4gwqAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdGstY29tbW9uLmMNCj4gYi9kcml2
ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdGstY29tbW9uLmMNCj4gaW5kZXggZDE1MmUy
MTY2MzQuLjEwMjhiOGE5M2Y1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0
ZWsvcGluY3RybC1tdGstY29tbW9uLmMNCj4gKysrIGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVr
L3BpbmN0cmwtbXRrLWNvbW1vbi5jDQo+IEBAIC00NTAsNiArNDUwLDIwIEBAIGludCBtdGtfcGlu
Y29uZl9iaWFzX3NldF9wdXBkX3IxX3IwKHN0cnVjdA0KPiB1ZGV2aWNlICpkZXYsIHUzMiBwaW4s
IGJvb2wgZGlzYWJsZSwNCj4gwqAJcmV0dXJuIDA7DQo+IMKgfQ0KPiDCoA0KPiAraW50IG10a19w
aW5jb25mX2JpYXNfc2V0X3B1X3BkX3JzZWwoc3RydWN0IHVkZXZpY2UgKmRldiwgdTMyIHBpbiwN
Cj4gYm9vbCBkaXNhYmxlLA0KPiArCQkJCcKgwqDCoCBib29sIHB1bGx1cCwgdTMyIHZhbCkNCj4g
K3sNCj4gKwlpbnQgZXJyOw0KPiArDQo+ICsJLyogdmFsIGlzIGV4cGVjdGVkIHRvIGJlIG9uZSBv
ZiBNVEtfUFVMTF9TRVRfUlNFTF9YWFggKi8NCj4gKw0KPiArCWVyciA9IG10a19waW5jb25mX2Jp
YXNfc2V0X3B1X3BkKGRldiwgcGluLCBkaXNhYmxlLCBwdWxsdXAsDQo+IHZhbCk7DQo+ICsJaWYg
KGVycikNCj4gKwkJcmV0dXJuIGVycjsNCj4gKw0KPiArCXJldHVybiBtdGtfaHdfc2V0X3ZhbHVl
KGRldiwgcGluLCBQSU5DVFJMX1BJTl9SRUdfUlNFTCwgdmFsDQo+ICYgMHg3KTsNCj4gK30NCj4g
Kw0KPiDCoGludCBtdGtfcGluY29uZl9iaWFzX3NldChzdHJ1Y3QgdWRldmljZSAqZGV2LCB1MzIg
cGluLCB1MzIgYXJnLCB1MzINCj4gdmFsKQ0KPiDCoHsNCj4gwqAJaW50IGVycjsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1jb21tb24uaA0KPiBi
L2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1jb21tb24uaA0KPiBpbmRleCA1
OGYxMzYxMzYzMy4uMTIxNWZiNzA5NGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGluY3RybC9t
ZWRpYXRlay9waW5jdHJsLW10ay1jb21tb24uaA0KPiArKysgYi9kcml2ZXJzL3BpbmN0cmwvbWVk
aWF0ZWsvcGluY3RybC1tdGstY29tbW9uLmgNCj4gQEAgLTY3LDYgKzY3LDcgQEAgZW51bSB7DQo+
IMKgCVBJTkNUUkxfUElOX1JFR19QVVBELA0KPiDCoAlQSU5DVFJMX1BJTl9SRUdfUjAsDQo+IMKg
CVBJTkNUUkxfUElOX1JFR19SMSwNCj4gKwlQSU5DVFJMX1BJTl9SRUdfUlNFTCwNCj4gwqAJUElO
Q1RSTF9QSU5fUkVHX01BWCwNCj4gwqB9Ow0KPiDCoA0KPiBAQCAtMjUzLDYgKzI1NCw4IEBAIGlu
dCBtdGtfcGluY29uZl9iaWFzX3NldF9wdWxsZW5fcHVsbHNlbChzdHJ1Y3QNCj4gdWRldmljZSAq
ZGV2LCB1MzIgcGluLA0KPiDCoAkJCQkJYm9vbCBkaXNhYmxlLCBib29sIHB1bGx1cCwNCj4gdTMy
IHZhbCk7DQo+IMKgaW50IG10a19waW5jb25mX2JpYXNfc2V0X3B1cGRfcjFfcjAoc3RydWN0IHVk
ZXZpY2UgKmRldiwgdTMyIHBpbiwNCj4gYm9vbCBkaXNhYmxlLA0KPiDCoAkJCQnCoMKgwqAgYm9v
bCBwdWxsdXAsIHUzMiB2YWwpOw0KPiAraW50IG10a19waW5jb25mX2JpYXNfc2V0X3B1X3BkX3Jz
ZWwoc3RydWN0IHVkZXZpY2UgKmRldiwgdTMyIHBpbiwNCj4gYm9vbCBkaXNhYmxlLA0KPiArCQkJ
CcKgwqDCoCBib29sIHB1bGx1cCwgdTMyIHZhbCk7DQo+IMKgaW50IG10a19waW5jb25mX2JpYXNf
c2V0X3YwKHN0cnVjdCB1ZGV2aWNlICpkZXYsIHUzMiBwaW4sIGJvb2wNCj4gZGlzYWJsZSwNCj4g
wqAJCQnCoMKgwqAgYm9vbCBwdWxsdXAsIHUzMiB2YWwpOw0KPiDCoGludCBtdGtfcGluY29uZl9i
aWFzX3NldF92MShzdHJ1Y3QgdWRldmljZSAqZGV2LCB1MzIgcGluLCBib29sDQo+IGRpc2FibGUs
DQo+IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNv
bT4NCg0KVGhhbmtzIQ0KTWFjcGF1bCBMaW4NCg==
