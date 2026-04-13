Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75643EBFD1C
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 08:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 135AE836AC;
	Mon, 13 Apr 2026 10:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="N94LC9C2";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="wO5eHNjD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65E56840D8; Mon, 13 Apr 2026 10:59:11 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C92B68352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 10:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 03b1c1f2371711f19a16598d5ca7f8ec-20260413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=bD1VfmYTYmKytqZ8Jrq4vsBnx1wQlye+Pm/uSnt4QLQ=; 
 b=N94LC9C2ylO1nS3b52SVDmmrlWoqBWz8jJmNIonUpBmLyCs5WbvZtQP89/CNWk9vFI3JEHSRM4N2tF80R97HgxpDeGGwB2rUsACnqNNqJJisJbEbtJxDJfK344PUIDRTSPnxARNSaEVmAKvKf0MSDnQHNMWDDhdT/whcoz2XV+w=;
X-CID-CACHE: Type:Local,Time:202604131659+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:732cb101-00ff-4708-a473-158d3016a405, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:e8425c8f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 03b1c1f2371711f19a16598d5ca7f8ec-20260413
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2106332153; Mon, 13 Apr 2026 16:59:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 13 Apr 2026 16:59:00 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 13 Apr 2026 16:59:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJUOMcfjKKqFvOH4cM2HcuJW8YJs9hwrqowqtzJjW2sSK08YgncCxVDEPb1LG/N35o4PxcHuASlqSqFPgawz+AXUY8JD3HeoGda6+HLzby0c3HZ+zdIfAMYFBMoA4UiYJvetayfeRtuk6t5JfHyhGVJhn8J4Bqj3FLyhFSODUv1CnQ+gz7M6ftEhKKptkLYTYDW0ElhSAE2vjGtgndNZVV8HnaYtL1p8MYz0UlNuerQ+knudUXPM6SSZV9ESzuCT2c4J6AT0SX0IMehGpZNO6UWxd9axW0cQQNH0TnH/scN7ptcjxdAeSQi1XAPkdQW8YgU6LyF0cc9hN7b/I+pPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD1VfmYTYmKytqZ8Jrq4vsBnx1wQlye+Pm/uSnt4QLQ=;
 b=ngJQqf6CvQkOR1OHSP9uaaopfj/BLc1ix4Q/Hf3N+HUtybX7CAFWKnyHlFd+fXkYMlJQq8O6hwaaumW3KhY9qsu+aj1hkXcOU7YGOJ2KroNoJJ7YCZmQ+pHq0CkhMreK3x4b/OLQd4ECdkoTQPbJjCP8qhdYIyxWmcOdVuNX0hi8Xu/PDRyMezMJZiucTT7b45tpEquswkBFECf61Vj4dxlSyBiFLusx951JeLYToOPfmiHCaksfEPGIhX6KkgHBQp2Q6EWnoV2yYKuJaqmKl9+WYb5ZqLw3VN9M9aywfa7NtFZsrQ5Ycu1NZ7RSeSq0mSP36FKIsaBjqU8QpIzdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD1VfmYTYmKytqZ8Jrq4vsBnx1wQlye+Pm/uSnt4QLQ=;
 b=wO5eHNjD8jNwFq/hM5f+q4LiEdXwOwvIT9BMrs5iegtrLlplgGR4apcBlY22ex+zAkd6eztGuIlEFkuekl5pVxsndolBVVjSKfPFV8/1HepaQAI6/nBZEgmD9nXftK6/htvqYZIpgAEToDAdjn4Raplzi3r2z2BNJmdXhVh3xG8=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by JH0PR03MB7981.apcprd03.prod.outlook.com (2603:1096:990:31::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:58:57 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:58:57 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?SmlsbCBDaGFuZyAo5by15paH5r2UKQ==?=
 <Jill.Chang@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>, =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>, =?utf-8?B?S2V2aW4gU2hlbiAo5rKI5a6P5r6kKQ==?=
 <Kevin.Shen@mediatek.com>
Subject: Re: [PATCH 3/3] power: pmic: mtk-pwrap: drop PWRAP_SLV_CAP_DUALIO on
 mt6359
Thread-Topic: [PATCH 3/3] power: pmic: mtk-pwrap: drop PWRAP_SLV_CAP_DUALIO on
 mt6359
Thread-Index: AQHcvhycOg4WZHjlb02XJwlb4pfI+7Xcy0sA
Date: Mon, 13 Apr 2026 08:58:57 +0000
Message-ID: <972d488c7b65869a65674c082e5fe09eae746783.camel@mediatek.com>
References: <20260327-mtk-pmic-fixes-v1-0-ef874ca82409@baylibre.com>
 <20260327-mtk-pmic-fixes-v1-3-ef874ca82409@baylibre.com>
In-Reply-To: <20260327-mtk-pmic-fixes-v1-3-ef874ca82409@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|JH0PR03MB7981:EE_
x-ms-office365-filtering-correlation-id: b41d5db2-cf8d-4a05-3169-08de993ae5c6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: /o1tNTVxnX5VLNTuNF/dbALgjQaR+QP5p5mzqR34Z/fX9k3MpqXy4C9vJ+xKc1IKwllRfCWLH+KCDfuAOu4GeJKAYeEdFURnh0Gr6lWjyBM1OshwHVNycKRHPWEJJuU90GIQFicrmMKpub1wJAfRo+qd/MG7zzN+oco4s5Hwd01IdOaPQHe2JR6Cx5eI5zWrjCTDV3Dh6zQgPeeWkqRg2bc9aZaQ8xbWn7CiOWraNI4yUM4LRyykkwf3N4i/KPzru1AnLJKPaO6rljKT+LN16IJ+xP/Z2Bm+pKuKtjalwXRpTRMxxXv4TbrO+PVL4nvtm0UnfT11jthLptNB85w9mN+iUB9iX89tBP5JyDDn8FZ9rm0odk2gyfP3oWAPKEZaeunfzuYbeCGfs8C6J7CJyLYGZTgMgvNpUXNGlS4XhVOV5nXmK8odYcyEPrzncKCtH1IAF1+0JeinPi5Od1aOIpCh4ybNUTT13PqJa8Nd4l+loHARBS46N/upct8qqwyHjGuNxfPcfRxAZgdZorqOsG0R8XvjTIaz+LdmGKN7KpiP2quGwgmYkFMqpOXmAdd3rKqAl2w8weH8E8vCw+4bDXdw+JqKLwdxYYRK4SgDoDINAwJWcB+IDGaRUCXFAvlbirgSr9EevePeZSZBxIihobeghpJaQNfeNW4+PGm989YPHkYj6ikolieFwMFn6LYRI5tkvIx2SP7LeW/fZ5jZByiXsy5RKrP4LFuEToq9IM0ssWrcllGL4M/DH0ZvjCue+VvO5LP3pTs0zu7peVkc0vAIfTuIRAMC2U9FmmwkSzQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHluUG5BVG1lTG9uYW1haVBFUWxLcHN4TzA3eTJDd2hsYnFyTDdHaW1Zd2FC?=
 =?utf-8?B?VmVDQk16UTJYNSt3WnpKb1ZBaHA5ZkdZK0pKQW1MVm5SbC9IV0FVenF5UzZq?=
 =?utf-8?B?UWMrN0pDOXBBNVozZ2g5TmJtbnVkSFlDOXdKNi9VcTI4d1RUQ0RYNEl4TGtN?=
 =?utf-8?B?MTFHNi9ORmcwU0JrMVE2eXhNUG5PTFhLTmtWYlJhVGJYMEJvTk8wdWxBbnZK?=
 =?utf-8?B?WVkzYjhmUXVoUXFuM2pyLzJITzgxamNsNTFSVUhWRXZJZWdVNDJ1dzBKTnZs?=
 =?utf-8?B?d3l5bU0xMFRUU2x5a2xjRmdxL0Q0SXFVMUNEWmZnamdZVXZwbzlvbG5VRXFl?=
 =?utf-8?B?V2VrMGJrd29nWkNRVS9SeTI1UWFIWjJOcThaTTNGTFhDOTdXZXVibythZHBJ?=
 =?utf-8?B?RlFVSGwzU0VKQmJOSzU4cXBZMkVkNnRuem0wdkdhdE4reVYzK05GZjNUSVo4?=
 =?utf-8?B?bUdEbmdYblh6cXZhYkRHdEI0cGs0RkRlWk1SRWJERHRGYUIzMWRrdkNmVGZC?=
 =?utf-8?B?RGxmZUYvM0ZmR3QydURNWlZnMk9NN2dTT01WTFR0OUpsT2dsd3BCNEIvOG1i?=
 =?utf-8?B?aENDbW1TblJQMEIzaGNnaTMwdExJRXdDbXI0emdTck1OYlRRcEJUY2hmWVhR?=
 =?utf-8?B?V1dYL2tFTFV3Z1lHR1pHckV0dFJrMjZzbW5ISVJiRFQrR2c1UW9uNmRkdGxV?=
 =?utf-8?B?TlNFTWFPb1lrMUNxRnMvRVZEKzgzRXFObk0weExsL3h2MERLS0t0VzVycWtw?=
 =?utf-8?B?dnQxTEFrOXpOMWs0SlBTdXVuYzR4Tk9rM3pYYWVza1dGdEdGcG4xaXNvWldF?=
 =?utf-8?B?UFkxZFpaNHA2eW8ycjdRdkZ0SDVVVmhFalloMkVURklNQmlmSHhrRlRHaXBX?=
 =?utf-8?B?Q3F4SU5jUDIyNVJMeEpvSDhPbWN3RDVROVlGSkQ2YkFRZG5qVkdUVFF2ckhG?=
 =?utf-8?B?MmdveUF5Szd0aTZBTithNmdVbHdaMm4rcEhDK05TSXEzRCtJa2E1Zmk5SlVq?=
 =?utf-8?B?RzUrajA2RTM5b1poYkwyN2MwekhvMkZlL1dRdHVOQTl1YWJHaDQ4VEFkcGlM?=
 =?utf-8?B?d0puVmp5Ri95NkpLZkhoM21aejdDb0hIcTJMUkFVK3EyRURqOXlIb3QzNFpW?=
 =?utf-8?B?ZXk0WVBjS3FkVEt2aGNWVDRuMVZtekZmWW1TR1hlRlM0b01NelpYRklIOWFn?=
 =?utf-8?B?YkJZTUMvZXZkUC9STHZpY2hQSlUweXRmQXpFZkc4Z3BvM0t2UHFIOGRFdDhE?=
 =?utf-8?B?dTZDemUxVzI4cFhxZk5IRDE3VEVBNnBpdnB5MUN3aGJFakIramNoTERTQ2Mw?=
 =?utf-8?B?Ym1GbWo3TzZwamRBdVlNNGVhZXBucUhDUjBKQTBjRjRvemdmY3NPbWlMeEFW?=
 =?utf-8?B?MTRoRWRkMnVFQjlYeTRkNWljNnBWanBsRytCOEhIcGdUOTRneDFpZUkrQVh1?=
 =?utf-8?B?djZhSEM4VEpMSEZKNVUxcnVIWmlJcmdZMUw1cFhVdDJJcG1IZFFFbnZhOWhR?=
 =?utf-8?B?TytnaDFwSFVJcTJUa3RrM2U3VFlHeFBXOWU5NzRFeXdPQXJ4SXNpYTlSWlZ0?=
 =?utf-8?B?K0VhbnlHMjAvVTVxaGJISUJmQ2loQkpFNWlZUkNDdUp0VnB4VE5XQjhBRDUz?=
 =?utf-8?B?Z01GNEJaaWYyMFZXaWMrdTJoelppdVN2cDJPQWRVOFlwTzdiZXNiQkhPR2hC?=
 =?utf-8?B?SlNYYVE1M1RaMm51TXZLcGp0ZVAySGQ1M2xuZUpPUTQ0aW4wVzlOR21zU3NH?=
 =?utf-8?B?cjlXa0s5MFdiVHFLcWxiYit3aWJpN0Y3dm5HdjdDUTd2ZFJNTS8yQVVSdlZt?=
 =?utf-8?B?cXkvSjhwem9sRkJucXpSZWUvT1JFc1FtZ3hUTXUrT3ZucnpZOVNZb3VmMnRO?=
 =?utf-8?B?WXVRay9aOXl3SExoSnRHS1RqOVhlSFVaTDRWNFNHOWgvRXFDd3NKV1hUMmJO?=
 =?utf-8?B?NCtiaHlFWktwSG5jTWVCYzZZZjFsWTZzc0cyR1FOTWpySUROSkRBbFpXRXB1?=
 =?utf-8?B?YVl2Q2dqNzJoZ01JRXN1ZitrSit1ckdIMkJzNWFxMVFWbVJtMUY0UHRrNzVa?=
 =?utf-8?B?K2NHR3p4S2VwSUR2cUpyMmdoNFd1MnQzbE5JMW4rNEg4YXR6NFhuYlh2aUwx?=
 =?utf-8?B?M29pVUdEYStKUWF0aXNVb3JTRjdmellzWmRlb2tjZ0lmVFgrNnYySk9wRlA4?=
 =?utf-8?B?QVFtdXQ1MXNzeThXWk53TldzK0lFUmxKSkdRRitJeHpOK09DRUtRYzgxQU11?=
 =?utf-8?B?UDNVQUsvUEc0bE1KQlFLbXZ0c1p1RGlPL2t4TGhRVGRVdXdiUjE0dUlXZVg3?=
 =?utf-8?B?T2xWWkF1T0ZkUE5ETHJncm5NOG5vblI4cHBCNW5nTDZWai9kVVpMY2hmb1Fj?=
 =?utf-8?Q?auXEp/SEluHIZHHM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1866C29E082654BAEE2CCA410E5CDB1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Dah8ZfNXWfNtAn8a2VoE69T56m3wgFve0ztZ+8cht/yyd4YqAHVETKs6IWN5fSBqyfSM2vIYLrAkl/Iu7vfEoQRgs3r2OsiwokX5hslKXY/+PmMbb+BxcR7LrD88KY9wLx1y0Yj1t9EVwmQegL5vKT4qO7OSUUzkubmlOMjMRCoKFo7f9pSdfSBdErZmwHAbgMkUh2a0wwugQ9FbYz4aM5sugijej17Z97++N7FQf7y3TrdyS6Y5vyVAX8k0ZGpKxPQXv8qk9xwTtO+yHF+dyRxChV/dCADpUBP4RVN64NBeLIpnfoYPeMZ/CXE6ZgkCOE4w5yOQPNLQU53PUBDhaw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41d5db2-cf8d-4a05-3169-08de993ae5c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 08:58:57.4832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1sC/I+4+46McDatZIeLW36WI7UJ6haScoBXzFP9EVKiG8QgApdPZ25c5kWITTJRWg+m9QgiOp19u5XNn4U3FUNRRJAMw5I1VY/fVbs9/+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7981
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

T24gRnJpLCAyMDI2LTAzLTI3IGF0IDE0OjAzIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBEcm9wIHRoZSBQV1JBUF9TTFZfQ0FQX0RVQUxJTyBmbGFnIGZyb20gdGhlIG10NjM1OSBQTUlD
IGRlZmluaXRpb24uDQo+IFRoZQ0KPiBtdDYzNTlwIHZhcmlhbnQgb2YgdGhlIFBNSUMgZG9lcyBz
dXBwb3J0IGR1YWwgSS9PLg0KPiANCj4gUHJpb3IgdG8gdGhpcyBjaGFuZ2UsIHRoZSBkcml2ZXIg
d291bGQgYXR0ZW1wdCB0byB3cml0ZSB0byB0aGUNCj4gUFdSQVBfREVXX0RJT19FTiByZWdpc3Rl
ciwgd2hpY2ggd2FzIG5vdCBkZWZpbmVkLCBzbyB3b3VsZCB3cml0ZQ0KPiByZWdpc3RlciAwIChE
T05FMikuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXls
aWJyZS5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvcG93ZXIvcG1pYy9tdGstcHdyYXAuYyB8IDIg
Ky0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2VyL3BtaWMvbXRrLXB3cmFwLmMgYi9kcml2ZXJz
L3Bvd2VyL3BtaWMvbXRrLQ0KPiBwd3JhcC5jDQo+IGluZGV4IGQ4NDk4NjQ2OTIxLi42YTJjOTA0
NGI5ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wb3dlci9wbWljL210ay1wd3JhcC5jDQo+ICsr
KyBiL2RyaXZlcnMvcG93ZXIvcG1pYy9tdGstcHdyYXAuYw0KPiBAQCAtNjY1LDcgKzY2NSw3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHdyYXBfc2x2X3R5cGUgcG1pY19tdDYzNTcgPQ0KPiB7DQo+
IMKgDQo+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBwd3JhcF9zbHZfdHlwZSBwbWljX210NjM1OSA9
IHsNCj4gwqAJLmRld19yZWdzID0gbXQ2MzU5X3JlZ3MsDQo+IC0JLmNhcHMgPSBQV1JBUF9TTFZf
Q0FQX0RVQUxJTywNCj4gKwkuY2FwcyA9IDAsDQo+IMKgfTsNCj4gwqANCj4gwqBzdGF0aWMgY29u
c3Qgc3RydWN0IHVkZXZpY2VfaWQgbXRrX3BtaWNfaWRzW10gPSB7DQo+IA0KPiANClJldmlld2Vk
LWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MhDQpN
YWNwYXVsIExpbg0K
