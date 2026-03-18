Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAB3103E185
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D633383BC8;
	Wed, 18 Mar 2026 15:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="BmdY+DxX";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dv7lBVVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCDDF83FC5; Wed, 18 Mar 2026 15:01:40 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 695BC83A41
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 15:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: f5fe555022d211f1a02d4725871ece0b-20260318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=3nWgs1eRcAr3YHq6cMA8niuQPDPQqoNd7ei1jUtO8ig=; 
 b=BmdY+DxX0ChsZyO1Ai67pD8tOIxxEsTLC11Zwm3Qy9cYykQJPwZWjPMuSrOa8N4MqscT9olmVg1Vvq9RMOHp27KpM4osEypNtI5DZFU+26UOEiAqTrRoiYJOq8nwhzbGzjncSXVLVCntx60/KBPD7IHqgXZjhdX7FJCVG4Zcy5c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:178f6aa6-0f4b-43fb-96e4-a609e31f7c0c, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:51ebf193-f8ef-4ca8-bea0-143568f9ca1d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f5fe555022d211f1a02d4725871ece0b-20260318
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 599941865; Wed, 18 Mar 2026 22:01:29 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 18 Mar 2026 22:01:27 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 18 Mar 2026 22:01:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfwhTShBTKzFEWE4+naKkvX4ex8V/8WkCCLRkfeQIb5/lLCeyHWMA3ToEicA9eBd7cFhMyfCDeNdxAVhWbJ+kyl4cQLDxIEsMMwti996kX1gc4nOXEXBxMTUcbtU+fvV8kfoV0OWuFdNCfb1or8MTahda/ANni7Ysx2OP2wMnLWDHyQ2hf1gxRAjY0X9Vy9j/yoQP3bc8Vf5PicW1cstMw6UBOmRaRVY+00KDYASaaJ+lhTu2N7W0bw06EqEWKOIYFA+oJe8FCgz/hpG/txY2eqt8AgGnfis5Uc9QzEYl9oRwPgS1+9Rl7SNuFeJnjUkjEiXiZgrTLy9YPl/4e7w1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nWgs1eRcAr3YHq6cMA8niuQPDPQqoNd7ei1jUtO8ig=;
 b=Gqaa5oCGN5j1c7CQNffmr1bRGmhNWD1PPd9fW+mkglofIdrurxQ4fJOA20SKn+pGbHDd1GoJT3Gfs81qz2kml0F3lQ14ppJ2+3roR6qnngA8w0IJ9WdxtXB29hub8JdaiH9fMOcQPqfePsOnYt0BRmfO6DgzIyZ1995xV/s/oNnbMu4fXjZ5UkRz0CadNi2Dy4t7ak/8irjPgJcS97jsHbrkaw9l3xW/28rQrR6I5mSLSzkbjZCBWnKR56h6PVEpjpczUKZ6KNRtVslLnqnJg+xFIB689gORuMeU7bLDut+YJfDbiSXacQSJPZfxHJ9MvBd5d/f5Ip9LCEmU/smYPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nWgs1eRcAr3YHq6cMA8niuQPDPQqoNd7ei1jUtO8ig=;
 b=dv7lBVVzEPFiu0ddSNdThd7YLR14FchH46ZTzTq3sEIhVaB8W9x3FFoYzL8l/zl0cpUwH+WNMZ66B2MNfmcAG1irjGeCQt+XGWGsHKTcla3hR8tRmPOiiU4uUWwYlUbSgNAZzh4UmdOpR6KwrwMTz/Z/DRYCVt8mm7lN0ED+cTM=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYUPR03MB7161.apcprd03.prod.outlook.com (2603:1096:400:355::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:01:23 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 14:01:22 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>
CC: =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>, "jh80.chung@samsung.com"
 <jh80.chung@samsung.com>, "mkorpershoek@kernel.org"
 <mkorpershoek@kernel.org>, "peng.fan@nxp.com" <peng.fan@nxp.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Julien Masson
 <jmasson@baylibre.com>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>,
 "semen.protsenko@linaro.org" <semen.protsenko@linaro.org>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>, "David
 Lechner" <dlechner@baylibre.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, Ryder Lee <Ryder.Lee@mediatek.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>
Subject: Re: [PATCH 02/11] power: pmic: mtk-pwrap: use tabs for alignment
Thread-Topic: [PATCH 02/11] power: pmic: mtk-pwrap: use tabs for alignment
Thread-Index: AQHcthnLawSd4dN250Wi9GUi82yLLrW0UzKA
Date: Wed, 18 Mar 2026 14:01:22 +0000
Message-ID: <76d1495ae75a34f6351369c975ff865604ce8779.camel@mediatek.com>
References: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
 <20260317-mt8195-add-ufs-support-v1-2-7d731ec438ae@baylibre.com>
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-2-7d731ec438ae@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYUPR03MB7161:EE_
x-ms-office365-filtering-correlation-id: b428c71f-da9d-4c27-f345-08de84f6d674
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: ySVlrrJmqTcQN0j3TLyGahXXKwm/HDOAyUkb/wHZTWmMZaUOAURR9x4ePv1XzzzDojAd3uCj0Q6wH8HPaANtjGZwgYaHYsmJjo+IHecHG+B6LPbZq6pj7JVTHW2IVxIxKJvGwoQRUN5htAv/Vfs63fSsq9IFFzeGUiFRYwcR0Cpyr8gpzBmXfKD0dmlR/Wus6qjgvi6D0m38Ff0Ami2eKEWiSirLEXFCr8y19emi9F6gCGvoyZm+rk5kkAhVvSxhVRuZaBJhu9BcC9lG2+dNfoKRXk7NsP9Ps04GcSYmCx+3EX0QplMPwqiOCGV2cvsbvP1jiypu0n0YNtAWmeN3q5jZgQnQZ1QrenOzUPv9QrYuxfiADiyK/OuPznsFVEnNABxGrAJmmc+FuxDp+hQ8FlpX97HaML2zcbkfwB/unq8viyOyj2PX47zVTBJDQHwk3HoZW1yGLHqxyKiPajWWE86HJiWNqSkmna79pnhdXA3CU3y7HkH1usJgcSMEe/7jljsnDcSRpihEm3S5sLfeiIIQaHwDvBYcj8t9SdAHOQb/vssH8QEmKJFwmtIKWSFpSdYJxWnb1PlJm+SReodVfrn9FmQrGThpY28TM45ciHCbE3SmCIJ3c6R2zc6xTDOWfFM0CqKgk9M1C6fbIdP/lqufjuf9uoqsvoWF+Yk5UgnkfpII47XgBSnVaU0RXdmCOXBPyCOA+bAuLyMBy96Qv6CcCh+E0krlgr/SFrMR5mWZJyHUIF1KVgsg6PZBoiiwJFf42ENtPsWUgSjcWQ822ke/iyrMG8ZuIBifx5fFlIQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sno5ZmtvWWtDU2JJb0FWc2taajFqMzM5T1IrdGt4K1E4WlFRUEJVVHhSeVVZ?=
 =?utf-8?B?dzQ4bmNtSmFpN0hhT3RudUNWbnZkQzZmTDd6MnpEemt2Zit3eE5sdXZjNFB4?=
 =?utf-8?B?bW5LWkI3bko3T1k2T1FxcmZWUWNWY2hLblBnYWIzdWNBMlZrdHVHblVpTEhk?=
 =?utf-8?B?ek5BOFcyR3g1TmEvOWcrNU05WElxY09qQi8zVHpHamFMaDhrYndkSkFlbXlh?=
 =?utf-8?B?ZHg1bnhDNVF4MVJJa0VsZUQ4NE5IOU5oN1NLSE1xeXY2cWhSWkNCYjlERkNu?=
 =?utf-8?B?eHJ0TTV1bmFFSGtCODg2YU5uc0VxMEQrLzhLWnA4M2ZNOUlmR2IyNjI2R3Iz?=
 =?utf-8?B?RFduMHpWbWkrcmlKMFhuWS8ycEJqWVBkTWVVT1V2RFRqamxZbUMwbDYxVUxB?=
 =?utf-8?B?eFlHVks2eFZTQkxUM1hvTXEweHA4aS84dklhaDlqbUZkaFN1M04rdThBN0dZ?=
 =?utf-8?B?WXRPOXRMZXIzZThIcFcxOVYzY29BWXhMN2VRaVRJVlFsdnhIQzA1b0JITjhP?=
 =?utf-8?B?NnlqR0FYNUp6STB6Y2NxeGhVVURTOHFqdjVZZlFyNVkrNzQzZEc3amhCQitj?=
 =?utf-8?B?Y0VpZWdWS29yTE9CTE5HcHBwWjJ4N0ZTNldZeWVKSXdUVEd6UmRlV254OUNZ?=
 =?utf-8?B?RnN3R2tLRURCQk9MNlFqTytnbXBZZllIWjIrbENKYVlUMmlka1FMdmkwWERy?=
 =?utf-8?B?RUF6M25VTWk0NG12aFJaekRydSszWW8wMkkyVFA2WC9zbXpSbDdNdUF5Qy9J?=
 =?utf-8?B?d1VXNE1sNTl5UXMrU2t0dDg3SUxSQThLKzN0RFJ3MFJIanlWUWlqTCtVVy9R?=
 =?utf-8?B?UVVyTTgvaDFFUzhzR2d1ZzdwUDFCNzZsd0pyd0tFdkJISENybndhaUxEZzlS?=
 =?utf-8?B?UGthUGx0MWZFeWVoZERLOGQ1dWN6TTRIVnAyQStITm1LY0t6SUZnRHRmQXg1?=
 =?utf-8?B?Y0ZZSmYxR2ZBR3hvMHZ6aktROXdqR203VHFTWnRyQ0Z2aXIwNWJCZ0FGLzJI?=
 =?utf-8?B?bXFZM3dqbGxIZ1lOM09QekVNdC9IVk4rRHRkZG9hdllmQ0UrMWsxazJmTGV0?=
 =?utf-8?B?dU8xcXVKaGdGaFdkNUwrUGw5QmlaVzN1TGVhQjBFTGR0aDNGRUg3cExlOUJr?=
 =?utf-8?B?aWloMUtmbjhkcGpIRUptdnBCWkZPMExySUROSkdWZUZmSC9nZE1DZnlpaENy?=
 =?utf-8?B?TmErMzZPOU85OW1uaElqY09WekxVMy90c3daZkorbE5sa3l4RXZEY1l6Z2pT?=
 =?utf-8?B?WVdGSkdpeUU1R3ZQK2tEdC83eHFjOE5kR2NVbVVwY3pnUDFSMnUrUGE2VHhB?=
 =?utf-8?B?L0hqbDhWS01meGg1cEdyODY3aE9UbE5qQ0tUMGhuc2pJQmUxdXV5Sm9nUENJ?=
 =?utf-8?B?SHBpbGlzUEZURGwrRjJiWFdJcUZQVE4vR3g3K2xSMld1cm80VUMweCtCc0E1?=
 =?utf-8?B?UTlnQ3NjdTZJaHdIUHozcnM4cTVJamxhUjlvc094aDIwRjJKZ2xrd3pTcjM1?=
 =?utf-8?B?UVFDQ3h6VW1KcjBNc2k5Wjk4YktITlZaSi9oT25uaEtMQ1dRZjQvdlIzaitl?=
 =?utf-8?B?UGN1R0ZFcFhWdHZmM3hSZHVxUll5YTgzMEhmUlJHZS96T242cmM0MFdEQ0Iz?=
 =?utf-8?B?MW1sN1J2SkM1T1MrdXJzdUFkNjlvNngxZlNWUFlyZFI1UHRNdVdHVmhCdTRp?=
 =?utf-8?B?TTE4MTZzaWRHOFFLWGJMYnhZRVQ5dnNiT2kvOHZ5T3NDZWZUZFlRcDZBMEhC?=
 =?utf-8?B?MWJtSTEvd3dQYlNwOG11SzJaeG9BdkJuaTJVanNHdTBkTUtwQUNjakJvSDlY?=
 =?utf-8?B?bXBVVDBSVzFpY1hwZ2xWWnBUbC9QQnhrbHVITjVDdFZ6MDVyT2JoZzF5ZnJ5?=
 =?utf-8?B?WFVtRUlhb1dFMnNYVkVGVGk1aDVYT0tva1pmZndmbWVMMDRhMDJyWUVsSzhl?=
 =?utf-8?B?OXJUc3NLd1pPUFNXbEFkNEZsdmwrZDJmdzFJeWFPeWJ6bGRzVWxpRHZtNUtG?=
 =?utf-8?B?MXhwU09ZTXFBa1cveDNRTGUyZlNDQmN6dkdSYU56K2JkUlBuNGpRTG41cW1m?=
 =?utf-8?B?eGEyMkJaRVZHMGNPQ2wxd2J6UHVGOVNtclNDbGorRHJ1NUIwU0NRaGtNTDRv?=
 =?utf-8?B?UUE4L2N3Wlp4eHBhRUc1a0EySzh3ZVFQYWpXUWY4UEpLYms0MHFaRm1YeUVV?=
 =?utf-8?B?cU1XKzhMLzlxcExsRmk5eGJzSGpuTHVUVnp1c1VQc1RicUhqd3pReGRmNXdz?=
 =?utf-8?B?NmhwdmJzWXg2VlozR0xCTUkrQ0FCRWxQZ3E3ZURsRzhyOExKQjBPMHNoZU1j?=
 =?utf-8?B?L3Zqa0xyRzhVSXhJbVNIVjRZeDR5bjBuUlUzeitFdk1XWFNIYytGRU1SWC9o?=
 =?utf-8?Q?3RqL6Nk3e8VfTcp8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0188F3B339DE4F45935F892D1D27A45E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WLzCjx3p4UX/vATTuJ2ywiC5zEdAJ+v7V6LGQ0d8Wx0+hDP6uafFkEAm026AlNJsu62SWk3dA2c8yRe0C5xiuAzuu06kmcUch4AmtsKPJu2/Tj7EMp1Ix8yhOOLvKyrTs5T8lgeUJUboG+9ajGJl8snUFA+9RGN4yh1HUVhs7k7FPzugrcgN6GM1KPIrMENDaC4qMFjFFk9T8kDLr4I7TPYFklpDow3sBFz/zjN2EjFq9xeH4QlzMaydyxw/bjmuovu6J9UDmDdd8aSxnkzEWNJP5osuAo80pc8bhefgA3cbAX7lmFQ2298yPWcXAHnwUicqiYGahWy4JNKjBqS1Hg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b428c71f-da9d-4c27-f345-08de84f6d674
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 14:01:22.7487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqrB6sJ+EU4zqvSI6p1qycDNXtg6E6Xj2cABBQb1fnNeQ8yuzLPf6LHWE06HJWTX9V7VX/Y9FQ106ffX4weHzf/uzSandiHtXiRlexFbIcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7161
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

T24gVHVlLCAyMDI2LTAzLTE3IGF0IDE1OjI0ICswMTAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gRml4IG10ODE4OF9yZWdzIGRlZmluaXRpb24gdG8gdXNlIHRhYnMgaW5zdGVhZCBvZiBzcGFj
ZXMgZm9yDQo+IGFsaWdubWVudCB0byBiZSBjb25zaXN0ZW50IHdpdGggb3RoZXIgZGVmaW5pdGlv
bnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKdWxpZW4gU3RlcGhhbiA8anN0ZXBoYW5AYmF5bGli
cmUuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL3Bvd2VyL3BtaWMvbXRrLXB3cmFwLmMgfCAyOCAr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2Vy
dGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93
ZXIvcG1pYy9tdGstcHdyYXAuYyBiL2RyaXZlcnMvcG93ZXIvcG1pYy9tdGstDQo+IHB3cmFwLmMN
Cj4gaW5kZXggOGZmNjQ1OGE1ZjIuLjQ0NmI3OGZiMGVlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3Bvd2VyL3BtaWMvbXRrLXB3cmFwLmMNCj4gKysrIGIvZHJpdmVycy9wb3dlci9wbWljL210ay1w
d3JhcC5jDQo+IEBAIC0yNDksMjAgKzI0OSwyMCBAQCBlbnVtIHB3cmFwX3JlZ3Mgew0KPiDCoH07
DQo+IMKgDQo+IMKgc3RhdGljIGludCBtdDgxODhfcmVnc1tdID0gew0KPiAtCVtQV1JBUF9JTklU
X0RPTkUyXSA9wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDAsDQo+IC0JW1BXUkFQX1NUQVVQRF9D
VFJMXSA9wqDCoMKgwqDCoMKgwqDCoMKgwqAgMHg0QywNCj4gLQlbUFdSQVBfVElNRVJfRU5dID3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDNFNCwNCj4gLQlbUFdSQVBfSU5UX0VOXSA9wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4NDIwLA0KPiAtCVtQV1JBUF9JTlRfRkxHXSA9
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDQyOCwNCj4gLQlbUFdSQVBfSU5UX0NMUl0g
PcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHg0MkMsDQo+IC0JW1BXUkFQX0lOVDFfRU5d
ID3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4NDUwLA0KPiAtCVtQV1JBUF9JTlQxX0ZM
R10gPcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4NDU4LA0KPiAtCVtQV1JBUF9JTlQxX0NM
Ul0gPcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4NDVDLA0KPiAtCVtQV1JBUF9XQUNTMl9D
TURdID3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHg4ODAsDQo+IC0JW1BXUkFQX1NXSU5GXzJf
V0RBVEFfMzFfMF0gPcKgwqDCoCAweDg4NCwNCj4gLQlbUFdSQVBfU1dJTkZfMl9SREFUQV8zMV8w
XSA9wqDCoMKgIDB4ODk0LA0KPiAtCVtQV1JBUF9XQUNTMl9WTERDTFJdID3CoMKgwqDCoMKgwqDC
oMKgwqAgMHg4QTQsDQo+IC0JW1BXUkFQX1dBQ1MyX1JEQVRBXSA9wqDCoMKgwqDCoMKgwqDCoMKg
wqAgMHg4QTgsDQo+ICsJW1BXUkFQX0lOSVRfRE9ORTJdID0JCTB4MCwNCj4gKwlbUFdSQVBfU1RB
VVBEX0NUUkxdID0JCTB4NEMsDQo+ICsJW1BXUkFQX1RJTUVSX0VOXSA9CQkweDNFNCwNCj4gKwlb
UFdSQVBfSU5UX0VOXSA9CQkweDQyMCwNCj4gKwlbUFdSQVBfSU5UX0ZMR10gPQkJMHg0MjgsDQo+
ICsJW1BXUkFQX0lOVF9DTFJdID0JCTB4NDJDLA0KPiArCVtQV1JBUF9JTlQxX0VOXSA9CQkweDQ1
MCwNCj4gKwlbUFdSQVBfSU5UMV9GTEddID0JCTB4NDU4LA0KPiArCVtQV1JBUF9JTlQxX0NMUl0g
PQkJMHg0NUMsDQo+ICsJW1BXUkFQX1dBQ1MyX0NNRF0gPQkJMHg4ODAsDQo+ICsJW1BXUkFQX1NX
SU5GXzJfV0RBVEFfMzFfMF0gPQkweDg4NCwNCj4gKwlbUFdSQVBfU1dJTkZfMl9SREFUQV8zMV8w
XSA9CTB4ODk0LA0KPiArCVtQV1JBUF9XQUNTMl9WTERDTFJdID0JCTB4OEE0LA0KPiArCVtQV1JB
UF9XQUNTMl9SREFUQV0gPQkJMHg4QTgsDQo+IMKgfTsNCj4gwqANCj4gwqBzdGF0aWMgaW50IG10
ODE4OV9yZWdzW10gPSB7DQo+IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwu
bGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzDQpNYWNwYXVsIExpbg0K
