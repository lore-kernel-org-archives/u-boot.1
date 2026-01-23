Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB5CD6CFDE
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 06:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4440083B64;
	Fri, 23 Jan 2026 07:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="MOheMo9R";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MLcyn+Kj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E147983B0B; Fri, 23 Jan 2026 07:35:44 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F5F983AC5
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 07:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: ba0f79d4f82511f0b7fc4fdb8733b2bc-20260123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=7lEuJv4oVSxBsm72rxoTrz+CunmLvjPM0PlSBNMdoAY=; 
 b=MOheMo9RbUmHAa6/A6P07MNzrJlOQHtMS7EvyP0q/ciXPyZM26EXArTx+pOa9CGK09nkD3TwvG++VhRC3YVCcmPAtzlEgTh+Yy74tuW3P9luYQZSp/w3HzQM32DNliyoW4KFF5DWa9Fu0Ae8tU4d1EMRNL35hgNIjb2DOCKubpU=;
X-CID-CACHE: Type:Local,Time:202601231356+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:1e1d7047-8407-4a01-96c4-6e8a2fcdd636, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:46c1d8e8-ef90-4382-9c6f-55f2a0689a6b,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ba0f79d4f82511f0b7fc4fdb8733b2bc-20260123
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2022167249; Fri, 23 Jan 2026 14:35:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 23 Jan 2026 14:35:35 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 23 Jan 2026 14:35:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbYlG7gcZlwUnrUAMAhclDXb+c40t1EDbutiSAGgu42PfF6Zroh6GV3xbpG9U5JhkNRcGneIVRqkVAJ671GeJtdgGOYMyQ5fqXDr1EK34Cc720P8AYN+0XKJSCN/sLxFdtsvLMDo5aNI89McBKlwI2rBGIR1PSJri7o2BJkSxaEiFNLJK5FPC7+H3Hacw/1fIbTDKIAmoN//jQG8aX+Q5vhih2gEZrWdldMOsWeeY0fmgHMnro79zkcz5AX3ehveoNreBUnUWay3pGxJzf55xOboB6OD0jk9Fy9IcD7/wGoiwz8iU+lIjLt945+xTSyCVSz27qfVhbi4k9QMHN+KLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lEuJv4oVSxBsm72rxoTrz+CunmLvjPM0PlSBNMdoAY=;
 b=ZJrzWhms073TNTD/tK9gPa2MoHCgm/s4xjOTqAnEV1b+g1l32G2BIEIpfc47bx3sGMszXIFtHZvljv5F/qhl5EZzwklXewC47yDp899Dsk9hrG7K0ebHUJfSXBLI3h2jdMHpTjQ24M13STY30S2CD+k0uWcPdtpSRnghmqn7bWq//dpcZU/LTK2Bo+d6zHQnawUqVfnsk5Ins88WaAfFg9QYYpO18TO9b5N8Ps79ZjSX471V5uM3z7FF+Y4WE7t6g+/y71iROv/uEdV17EpmOfPqBlsxjW5tDgnC8Rt1nheFQWUuejtvbgci7avY8qjwa6Up2txUWcDHiitr5EV64A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lEuJv4oVSxBsm72rxoTrz+CunmLvjPM0PlSBNMdoAY=;
 b=MLcyn+KjX0rSrITtUI/7fbvmRcR8UJoR8j339gvjeuNwn0+nJBZkJpIaVHrpjzqtFKTcR6Aq5L8N9J73EtewsgiqYTCDkBx+59vxkTcXVm6wEn0OFiyKjNjF6Lc70dQWEotgKsOso9oEjI9V/cwpacJFKHEiZzST7tD1T9sp37g=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYZPR03MB7481.apcprd03.prod.outlook.com (2603:1096:400:421::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 06:35:33 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%3]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 06:35:32 +0000
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
Subject: Re: [PATCH 1/2] pinctrl: mediatek: Add pinctrl driver for MT8188 SoC
Thread-Topic: [PATCH 1/2] pinctrl: mediatek: Add pinctrl driver for MT8188 SoC
Thread-Index: AQHchssjXLIsF53fY06HXA3CF2H4KrVfTHEAgAAHFYA=
Date: Fri, 23 Jan 2026 06:35:32 +0000
Message-ID: <e9484a7b2b7680aa709a7ee3ca28c26cba39c94d.camel@mediatek.com>
References: <20260116-add-mt8188-pinctrl-support-v1-0-fdf3b9227c71@baylibre.com>
 <20260116-add-mt8188-pinctrl-support-v1-1-fdf3b9227c71@baylibre.com>
 <ac7fe0d340567d07bd71b3990bd6e78d856a611e.camel@mediatek.com>
In-Reply-To: <ac7fe0d340567d07bd71b3990bd6e78d856a611e.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYZPR03MB7481:EE_
x-ms-office365-filtering-correlation-id: 81815cb8-d84d-41cf-b8c0-08de5a499bf2
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WS8vdkVuRjJxa2hrTmZBZStFZURKUWtJM1V4MFIwUlczMlhCRGc2Q2xKL0cx?=
 =?utf-8?B?RWVHNHBjTTJ6QlArbFVZWDd6N1FsTHhlbWRHZk14eTRBaEdXMFphWGlaT1Av?=
 =?utf-8?B?cmlRUGljRkVmaWNQM1lRdUpOM1lwd0VTS2sxT1M4ZmwvTmw1bXgwWGt2NUJW?=
 =?utf-8?B?QmpmdytJK3pmS0IzMnhyVXdEQnYxa2JoODNpeERoWnZaS3RlMVYxWUJlZEVu?=
 =?utf-8?B?ZG4vK0RSTERYWHFlWVpvVk1Oa085eEhtekhzQXhibWJzRlV4UXFqQWdLRGhJ?=
 =?utf-8?B?NnM0dHhYcVcxVkk0c2xSN0EwNDdGN2doTnd6MmViMXd6QjUrWU9yQzdHY2FQ?=
 =?utf-8?B?b1dMKzk0SXhQbWJTNUtjckc1TjVTbnBlbnVOMndqTWpYZEgyQ3l6K0ZhMUtM?=
 =?utf-8?B?SkVXV1dRRHQxWEY3eUtEem9VQVB3K1ZYRGVYRnRKMnhXbjNVK2JVK2xyWU9j?=
 =?utf-8?B?RXFHd0dMMVBMNFJTdmwvcFN0WVExSjEvQlBxdGRtYVpOc0xCc213OW0xMHd3?=
 =?utf-8?B?THVIVTY2Z1RaZnNsNjduOWwyWng0UnFHWHlDQktpZTdwdzVpclNHNzBPd2Zq?=
 =?utf-8?B?ZnplcFpqOWFHRUxmMjF4b0pLR1J3TDl3T2cvcVYraVU0eFIxSG0wY3h6RFNP?=
 =?utf-8?B?cjM5U3ZHVDZvNTVoSGUxVkMvVk9GRGNJZDJoWVlyK1BHMGJhOVNkeVdSSWwz?=
 =?utf-8?B?SGlVRXFmbTdaV2g4VnlSSWNLdzlXOWl0R05peFI5cVNHckN6UFQyb0RYSUhW?=
 =?utf-8?B?TGxBd2xQMklkWitLN2I4Zi9DQit2NUQwM0pBWVlXUG03MTRPNGFoMkpRVDcw?=
 =?utf-8?B?ZzVTUVUyRkp4ZXhLNW9TbDRKWmlKZ3REb2cydmZMMHllNHdhejIrZVhVVjE5?=
 =?utf-8?B?TWVqaUt0Z05TT2tlMVcrbW5PZi83a0Q5NGIxU21iaHpmNS9kZm1oSnVSRXBP?=
 =?utf-8?B?czFLNWFvT0ZoRkR0UGF0eDJJaFVWdVJRVGc4WFRmRDhHQS8yaXd5blRhTTYz?=
 =?utf-8?B?MUhhOGxMOXZidVBRK1E0K2tBc0tsUkFwMFE3Qy9vSnhnMWUzNmEvYlFnZjFK?=
 =?utf-8?B?YVBXVXh4cGtscit3aHQ5emV3VVpER0VkR1kxazdtTDFkQnV6VGtJa0tpMm9h?=
 =?utf-8?B?TEZScUVRUmllWDFhdE9qZFdrUWpSU3lGYm10a3RBQmc2ZHdxS3FKNU5tV1Bk?=
 =?utf-8?B?Uks0Vlk2THcwTEtGb2FDOUk5TG1WK0tLRUxQMkZCeEFZdDJCdjRtYXJMd0pW?=
 =?utf-8?B?S0NGRTQ0RER3a2RGOTJDc2RQY0k2RlNIVGJpWjB5VFVzUUZrM0VmRThhdENB?=
 =?utf-8?B?VktQM2VNdUtZRVVENXdNVldyTWoxTHVwWXBNd2lMb1Zvcm81amoxSU9XYnk1?=
 =?utf-8?B?RlpucWwvU29MUVdXQ0xqSVR1ZndtSDQ5bnllL0grK1B2cGFUemxpNU5rMkly?=
 =?utf-8?B?aUs0K1p5Y3JMaExZdGdEWjU3cmkyckN6RjhmSmtUVUY0VFYxVnVVenBIVnpO?=
 =?utf-8?B?NjB1d2ZMWlJkUXYxbUFwRFBhOXA0eGt0VnplMVh5dFhZaHQ1c1h4RTJ3cHpo?=
 =?utf-8?B?V1hDVXJPMlNjemI2ZUJZR09YbXlFYkhsbmtJNjFFaFliNFhHaWo5a3BtSFJJ?=
 =?utf-8?B?MDZmelMzd1FocHpPaCtSaXNYSVJXNjRYSVh6cnNwRUJUMDdDM2xJaGtoM240?=
 =?utf-8?B?QlorUURVRjVDZmJxeVZCSS9lU0FkTk4yVUpEZ2o0QnlXajNoelNzbDhqbHk5?=
 =?utf-8?B?VkRoU1QxK0M4aXEvYW1jM1pmWkNURGNwK211dXMxVlliZURIbDI0UVBOVmU0?=
 =?utf-8?B?eHE0WGljUFFTcE5KOVFvbG9Id0FVNkYwQy95djBKWHRqSTNmUzJ1QWZxcEdN?=
 =?utf-8?B?UU1RWEZHWk9YM3psRThvU0dzUGVlVGRhWS9BSHB5VXZtOFBFNHFMQkx5bjhT?=
 =?utf-8?B?UVFSZmZDZlhDSWFaOXhqTUMyMHMvd1ZsSXFPVW9hQ1FkN3BHOWllcDk2aGti?=
 =?utf-8?B?WUpFQW43RFA2UHNqY2owN2orNWRvZ2RoNnl4V2ppalZ0V2NRaTE5ZWZZWlJj?=
 =?utf-8?B?YTZDSmhsT1RwOWM0U3RPVUtBbk9EKzNSRDFYK01ESVZqQVZGdUI0K1p1ZlJ4?=
 =?utf-8?B?M1Y0NHE5QVBFYmFSeHlLZ1NCTFU3UVZLT3RxdkF0clVDc2taV2xad1BEWnhw?=
 =?utf-8?Q?hND53YUmUtfKdNh6PyS8y8A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clVaYXlLZjlsUkRHM29aSEpsNnR4Ni9KVzFaZTFUcG9rWDIrZkk0UTB6bmRD?=
 =?utf-8?B?TFZYbnlHUnFMeFN6b1RNNVVoOURCOEdYc1NJSmZvNllZN2FvSmhZOWtncTE4?=
 =?utf-8?B?WEdnQXI4ckhlbk5wVm1mVkpPSDNBckp4VjliaU92MTU2UEJKcUFrYlFmMEFF?=
 =?utf-8?B?OVU1NSsrb2t1TlNKWW8rcE0zdVcxY3p6L21kRjJ0OURnR3ZoRU9nYVlRYWdy?=
 =?utf-8?B?Y05VcUtZWVlPcEtZdXhCMmlmNkEzbCtIQTZCbnptbVdWWlhUR0tSaUdtand4?=
 =?utf-8?B?TW1GYi80UGJqdkJOdHBnUVNBc2VwVitFcEtNTTVBKy8waXhHemJlZzZQUFNw?=
 =?utf-8?B?VUhsYUh4WGNQaFNtUGg1MUpFQTNxN2twRGxLT2lrN05BdS9QNE14Y2t6bEU0?=
 =?utf-8?B?WWJrOG9FNEpPeUl6enU2MzUwVkZNWElxbEhhY3ZMSmk3c3VQR0plUnR0T09L?=
 =?utf-8?B?Q0pnYzBSQzVSR1BEUkY3aXpIcHFaK2VMZUJiMitXN08vNzRPdkt2Zzl1RE8v?=
 =?utf-8?B?Vlc1UzB4b01mcW93VXcwaUUreFIwQ3haaFNwWU9Ka3BrNDdjS2tjOFFRSXFx?=
 =?utf-8?B?d2VUcWJZTUNtemZ1clBRa21wV3J1VUJjeWU4S2JaK1dpMEFYR01zcHRTOWZu?=
 =?utf-8?B?NGNQRndNTW55eE54S1R5dm9qSGtHRHNXK1AyaUw1ZVF0L2h5Y1dMSW01cGdN?=
 =?utf-8?B?a0hIMGdSd2FVeXJaOCt5MHZTSFBsWDVFM2tTRytoVEVqMVB3bXNNK0JEYXNw?=
 =?utf-8?B?R1NLT1VVMzh1amp4MXpTL3JGRzBTV0E2WkhjWXpsZ1hmUFRSYWpCelVleDU0?=
 =?utf-8?B?YlVCdG5qYnYzYTg5d3p3VHhQeUxHZmwwVkMvSkVqOGduSWlUb1p0ME1Ub3A1?=
 =?utf-8?B?ZDdpQ1c4UGU2WnlOckFlZlF5ZG02WWd6MUpGdzRBTEh2YXVCUmpnOEtZRUZm?=
 =?utf-8?B?V2pCZjFZY2ZTbEVUUDNQcEN2NGhweGxBQ3Ryckt4RkRKYTlqWWtodVFLSC9Q?=
 =?utf-8?B?bS9sUjdQeEhmTGF4Wm1oSmFUK1EzN3BFS1lvdmF3eDdZQTRUdHRURWI5Ylpo?=
 =?utf-8?B?TTQzUSt3NGRiVGVxa0U5blFvcE5pYkd3bmV5STc3Z1dBb1RNbTdsazRlYm41?=
 =?utf-8?B?anJXcXZYNC9NTnBtTnpMakROQXJ3K2o4c1FnM1N3eU1YUVJEUDlUcUpZQ2VW?=
 =?utf-8?B?bE1kY1c1S3hwZjBKZFBTZGpHRlhTSFlxd0oraTA2d1NuU2ZEMk1uNGQ1bGE5?=
 =?utf-8?B?V2ZiOWxRejUyam9KWUVqUTAzdUwyQnhwNWN5QUtmZVdNaFZPSTdXNE8rWGtx?=
 =?utf-8?B?QzcwajNhN3RXTVhIdW1NMEFNQW1Dcm9CWVlVUk9VKzNFZWdSYUo1RXRnL2JG?=
 =?utf-8?B?ZGtsZlBiVG5YS2EzaWxScnZMU3diUnV1RGdRaHpWZ1dwa3VFV1Y1STZYbG5a?=
 =?utf-8?B?R2pzN1l2cDlCaTNUUWh4b0V0eVMzdzl0M1hIMVFWYjFMckZma0IyckVtNElB?=
 =?utf-8?B?UUFERTdPUTRvcUJtNnNUdTNnbXVhVDZNQllxa0xWUUszSlYrcnc1ZncyVjFy?=
 =?utf-8?B?TTJhWk4yMEs1N2JabVJIY0syMmk2MFNGc3hXeDlhK25oQjJNVE4zWEcvZEQv?=
 =?utf-8?B?Z2FRNWhuTHlKY3h2T1RvOVBqcFpscm91NGxIWkJYcURmNDBTeXhoNnk1SGxM?=
 =?utf-8?B?Q3lvc3VoajVtU1NQdU4xTE83d2UwTHZETCs1S1lMUHMzMDd4T0dVRlVIekhV?=
 =?utf-8?B?cjF3SjlTcnBhbTFWc3ozUUV0WmdYMElVMk1vbHlOa3FsV005YTMyTjFwc3FY?=
 =?utf-8?B?dGdtdFEzU3drOEhKdVlhTDNDaDN5VWU5TDQySTArTC9QRDZ3TGRZVFdMK1Fj?=
 =?utf-8?B?VGtMSk9IRlNtWTRZNHZmTUNHd0lwWHA3SUdkeEhHVFd6V2ZPNEdNRUZWMEw0?=
 =?utf-8?B?SERIZmZnRU0xSHBkaU9TSFZaYkJqZElVeTdyUGw2dUcwNytoN1ZmYXVFQnJs?=
 =?utf-8?B?dkdXOElJTUx2MWM3NzFUeldCWmZ5Sm1kZ1YySTU1ZjM1OWVmWFlFb2l3b0o4?=
 =?utf-8?B?aTQ0U291K1BhZlBtK1JhcURXdHJ3S2ZadUJ0V01PdFUyV2hOaTZ0S1ZPWi84?=
 =?utf-8?B?bC9ZNkRvemk4cVhmTUpIaVZIckc2ZkdKVmRkeFN2V1MycEk2a1VkNklpK1lM?=
 =?utf-8?B?aFM3TjlRSEwyNGNWQU1mM1RWcHhMWEdSV09ReWhIMllZVWhjcSsxYUcvVmtx?=
 =?utf-8?B?bGVtQXFGV1R5ZWd4eWJlR0RYVTFURyt2UHN1ZzArWFBlTllUOU8yTjcrK1Ar?=
 =?utf-8?B?RlprR1lKc3dLWTR3QjJsNzlaUDNnYjE1R3YyQ014VUl1ZGVuRFZqb216aXU4?=
 =?utf-8?Q?gbWXYKIElou0ojl0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F45C5C470B64AC4E89C535B7B9D8870F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81815cb8-d84d-41cf-b8c0-08de5a499bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 06:35:32.8380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ouVU6cpzxACXX8Ppnjyo6fkpA4CIPPatKEKs9KhwtRXnR1ffTM90DMuxzWwy0Expr01yqzIZ8brSHiPR7tQYhgTqTedVoVd1zlWkk8HtSCc=
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

T24gRnJpLCAyMDI2LTAxLTIzIGF0IDEzOjU2ICswODAwLCBNYWNwYXVsIExpbiB3cm90ZToNCj4g
T24gRnJpLCAyMDI2LTAxLTE2IGF0IDEwOjMyICswMTAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gPiBGcm9tOiBDaHJpcy1RSiBDaGVuIDxjaHJpcy1xai5jaGVuQG1lZGlhdGVrLmNvbT4NCj4g
PiANCj4gPiBBZGQgcGluY3RybCBkcml2ZXIgZm9yIG10ODE4OC4gVGhlIGRyaXZlciBpcyBiYXNl
ZCBvbiB0aGUga2VybmVsDQo+ID4gZHJpdmVyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENo
cmlzLVFKIENoZW4gPGNocmlzLXFqLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEppbGwuV3UgPHNodS15dW4ud3VAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFZpdG9yIFNhdG8gRXNjaGhvbHogPHZzYXRvZXNAYmF5bGlicmUuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBiYXlsaWJyZS5jb20+DQo+ID4gLS0tDQo+
ID4gwqBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoMKgIDQgKw0KPiA+IMKgZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL01ha2VmaWxlwqDCoMKg
wqDCoMKgwqDCoCB8wqDCoMKgIDEgKw0KPiA+IMKgZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3Bp
bmN0cmwtbXQ4MTg4LmMgfCAxMzQ0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiDCoDMgZmlsZXMgY2hhbmdlZCwgMTM0OSBpbnNlcnRpb25zKCspDQo+ID4gDQoNCltzbmlw
Li4uXQ0KDQo+ID4gKy8qIE1UODE4OCBoYXZlIG11bHRpcGxlIGJhc2VzIHRvIHByb2dyYW0gcGlu
IGNvbmZpZ3VyYXRpb24gbGlzdGVkDQo+ID4gYXMNCj4gPiB0aGUgYmVsb3c6DQo+ID4gKyAqIGlv
Y2ZnWzBdOjB4MTAwMDUwMDAsIGlvY2ZnWzFdOjB4MTFjMDAwMDAsIGlvY2ZnWzJdOjB4MTFlMTAw
MDAsDQo+ID4gKyAqIGlvY2ZnWzNdOjB4MTFlMjAwMDAsIGlvY2ZnWzRdOjB4MTFlYTAwMDANCj4g
PiArICogZW51bSBiYXNlIGNvdWxkIGJlIHVzZWQgdG8gaW5kaWNhdGUgd2hhdCBiYXNlIHRoZSBw
aW4gc2hvdWxkIGJlDQo+ID4gbWFwcGVkIGludG8uDQo+ID4gKyAqLw0KPiANCj4gW3NuaXAuLi5d
DQo+IA0KPiBSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNv
bT4NCj4gDQo+IFRoYW5rcw0KPiBNYWNwYXVsIExpbg0KPiANCg0KSXQgd2FzIHRvbyBiYWQgbXkg
T3V0bG9vayBkYXRhYmFzZSB3YXMgbm90IHN5bmMgd2l0aCBteSBldm9sdXRpb24NCmRhdGFiYXNl
LiBIZW5jZSBJJ3ZlIHJlcGxpZWQgd2l0aCBhIG9sZCB2ZXJzaW9uIG9mIHRoZSBwYXRjaCBzZXQu
DQpVcGRhdGVkIHJldmlld2VkLWJ5IHRhZyBpbiB2MiB2ZXJzaW9uLg0KSSdtIHNvcnJ5IGZvciB0
aGUgY29uZnVzaW5nIHJlcGx5Lg0KDQpCZXN0IHJlZ2FyZHMsDQpNYWNwYXVsIExpbg0K
