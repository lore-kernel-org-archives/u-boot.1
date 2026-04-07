Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA88FEEF56
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 14:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1DED83F98;
	Tue,  7 Apr 2026 16:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="BrMh4zjj";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="lzPt3VZY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7609840BE; Tue,  7 Apr 2026 16:46:10 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D174283A41
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 16:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 7fb938e2329011f1ae70033691e9ac7d-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=e7u1Hz4VmctZHd+cVWcXJ4KL1PbkVPxrZod9Bp4qgLU=; 
 b=BrMh4zjjKRJmjY2vKakZVN9o4BlsDGim1UArxday0pTWXRvJT7NQadNaMr425q8SlGSb3kn+L/Q2rppWBo/hbCskCEnGIyniYksiLFyHj0x2j7WmQWPVqKDCe7YeC3WvNbTehNNq0xAqzb1y3CJGmBi1L8S/2tFcHzl8Eu38qXw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:8a7cc1c6-edfc-44bc-bcf2-be00bd1d66c5, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:4eb5a894-f8ef-4ca8-bea0-143568f9ca1d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7fb938e2329011f1ae70033691e9ac7d-20260407
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 433399359; Tue, 07 Apr 2026 22:46:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 22:46:01 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 22:46:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwpxMtZLweWbwXDClOwcSf6waZnMNz9AKB+wmLdU2rbI19N80vrEheCWkiA3JUlESFwtPiQrGTyA6qPVA/7gGg6ZrbTYwz2o5msz1tjQlwNiRA3Fd8aCEyHBXaJwA2VPZdEmKwx04Hl2GOs1zAgUdQZcw8NxE3YgmtDmKUMklewt6tp6WrLYSNUqR/IcK64p6ndgqfPxVfOhuLQHI4pA0e9rwpaNicmvvwAOg9tZHgM0kNsTmM7pnkk51EA3I0siT7ZcCLXnZWTvWZv9CQ1Prg0GLv+FoXximDS57IS5KyUHyHszgWYSQUZMOn4npxh+YDPmSrUqpJQJoWaFdr6pCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7u1Hz4VmctZHd+cVWcXJ4KL1PbkVPxrZod9Bp4qgLU=;
 b=x9otq48KcXHcFWdZoi8ri0FxObd7ANjit2AhDszIcJ2Hqfg9T2C1HabWigh3jorAgxby0Cy1z+qgYSpI/MMnaLuT21OaffzeeeBeNtdK3/AeO1bq3M/OMjPUR2w6F4eBnzC/aJ8ANkWu+L+pqlygk8glX7uWOl5nkg+rBjwVDe1qI2qZVHP3FdrIm1QQFQ1CsB/UmA39avNbCSdx9Ws8XHNxrwCB/YH8wH6Ps6jdFhJP3/7ejUZiFIHPOcBtYeroVv5syqIN1Cj37E9apEq+yw5RyR+I1BJYcm39cO6ItBF1BNZp7jgUeWYBN1svLDCPUmZzclfaXh4r+EhLcZu+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7u1Hz4VmctZHd+cVWcXJ4KL1PbkVPxrZod9Bp4qgLU=;
 b=lzPt3VZYu6QyM2JqXn4fjcPAQsjdsFgm2ronccKy59sMne0Vsq/u/3+YYeUdttuglKxLLviUCNyargK82aVwPe+WaknV0nnJvebkDIWLaFenac6I7zW4wzBHDqD3Dx4CZpXd2DhJFKler2zzo8gug4EBpf2/rWAMlgub/Uxm4eU=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEZPR03MB6892.apcprd03.prod.outlook.com (2603:1096:101:a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Tue, 7 Apr
 2026 14:45:58 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 14:45:58 +0000
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
Subject: Re: [PATCH v2 4/4] pinctrl: mediatek: mtk8189: set get_pinconf
 functions
Thread-Topic: [PATCH v2 4/4] pinctrl: mediatek: mtk8189: set get_pinconf
 functions
Thread-Index: AQHcwF6lv31DZRe0iUKaqbPs3hCytrXTub+A
Date: Tue, 7 Apr 2026 14:45:58 +0000
Message-ID: <252045e0443f3ca279319a3260eea06d6049bc16.camel@mediatek.com>
References: <20260330-pinctrl-mtk-fix-mt8189-v2-0-05a737ec623d@baylibre.com>
 <20260330-pinctrl-mtk-fix-mt8189-v2-4-05a737ec623d@baylibre.com>
In-Reply-To: <20260330-pinctrl-mtk-fix-mt8189-v2-4-05a737ec623d@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEZPR03MB6892:EE_
x-ms-office365-filtering-correlation-id: 3f93a625-016d-4cf6-0d52-08de94b46190
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: uAom5vi5PRKUofUjkMYCvB7XHRg5AR+dRMOh0uUREHOFqmKNj85esBF7P3G6jygTFYhRccvt5Jqwz3q/HFCXKfagECqyQOluDs5hLWKWVtgIY3M1ZJClkRIlp68ObTyg+qFb8gw51kaiJR4uxOHgBMGPRVLlMIXtuH3IDAnlx8eiuJDgtfIldKuPimlMoRx0Itj2aUn+0KBq0U3x3POJbOmWLfCpxAis+JkVBrjtHYsXef5spCSvDypOy3Kv7kTNVYzRi6ucs208gpS9AnXl0YygXB4Ocu9lRriNuxMLxUVQGF82kxSAhKO7qabSufnotfHhndr2k+4iQOnyUWS3mRn6CwTFF8OsMWkt3NMPnOPqWp75tNz0revH/LwuQT0nddN/UAma8NYPk+nT6xHrVNmtgO6EjecU840vwK/zChj/47aZFkQkWZhtVNs5lL4R8BYffCAyqsplscnVBA8EGjWfvXsVUjbp7Uyq+L4oHAPcIws5wGruzck72oTUnPJudz0xBZgRHC3KxA1CU6em96oXdC3oDq+L+PajsCy5ckK/i5b3aTVe1wKAZoBYdd4npjEbhtjIrGz8TlrPQCeLPnyiRgQyrM8Sps+wMPi4hBvzNXYKmvXY9sqw/vPVgxhg02nuzBYkzxDm7UycK964pumxudU2jo4D52jkfYw9/MiuW/iuZKieAqU9XVhe+Pm/LNfaiwXpH+QG0F76CwyZILnJyEuZ43a7Sp9QZM+ONN9cgqkZAoRJHqIHPtIP7pt3nBSQHWQeT/DBHTNT8ZeWA0RX+x8nC8PjtvL/Ne0YPDo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm0wRHhKZlhZSGg3cnBGNnBuUkk1UWdONFZCa3pyLzc1aXVkbzB6bEV5dzdQ?=
 =?utf-8?B?Q2NtczhSbXhWa2xmSTZpd2lzZ0xEdkgwZ0I3WXl1cDVhekVZOVVjT0MwSkpp?=
 =?utf-8?B?OElGV1lLM3pPYnpHMmd6MS9Xd0tFbVdnKzhEZ3dlWVorMHdyTEZlaDNTM2Fw?=
 =?utf-8?B?aDBmU0hLZlZQaVk3bVhwaW5scCsxa2hlZE0xN2srUk9SenRZNlFVM3pDUXRG?=
 =?utf-8?B?TlY2V2hxbmhDQlFUTjlyVXluSUJ2UmxiQmY3dks1cDVWd1cvYjlJQk1pM2dW?=
 =?utf-8?B?ejBMaTlKbXlSeDF6Q3k5aFdPc2JCZjFOQTJhbm5rT3BEZFloenp1Q2wySVBn?=
 =?utf-8?B?M3BnT2VNTWdTVkhPbFBXc050cTVoOTZyRndJRmdkcnVlellHYzM1Tkl2RUJG?=
 =?utf-8?B?WVNCMUdyc1BFRGNEaTEwSWIvU1k1RHkvbndkY3VyY3VJK0EzUUZ4b3NaRGcr?=
 =?utf-8?B?UDUzZklKNk5HUGQ1OG50b3JTZlA3ZSsvak10YjQ1ekNTdUJtejZBOWtVaTNK?=
 =?utf-8?B?NllyRUFPSXRzVFRBb1plZGhDeTFSQkdwN3JGS3VTZndEUG5xcmNhSC9mQkhl?=
 =?utf-8?B?TS9aZVNXQUdmZlZFb2hDd1MvU2FMckZldlpMQlVlRVloeEdKYVk1RlpHYkZB?=
 =?utf-8?B?K3NONkVoS2RUUWNhTXpEZGVrMlhsTnlDSnhoQXJSd2doVU1qQ1dySnpJT2c2?=
 =?utf-8?B?ME5OUWV5M1FBc2xMV0dvVkN4bjZ3SDBPVlNjYS84UEV5Qkc4WEVMd2pJNzhm?=
 =?utf-8?B?NTlmbGhlZUJZQjVRdmoyeFBkRjFuR25qZ29JN3ZhdGRXNkRGVXFpaUVOcFBh?=
 =?utf-8?B?Z3dTYWdMN3pMUTNCbEFjaDZkdlYrdm1vbmRvbEZ3MEJpblhFZSt5Z1lDUVZQ?=
 =?utf-8?B?dDRabytuY2ZXQVlDd2kvV3E1Y0ZmcTdzQUFhZDNDNElES3l4cUFsQWozYW9n?=
 =?utf-8?B?MVhPQ0cvakE5L3JIMkhlUWtpR21PU0hoMDRyYnh5WEplM2xWL3Qwb0VpbDFN?=
 =?utf-8?B?dGsvODZVY01ITlhkbElsdWFtUVNzUUhtc0I5RVlKa25SZ3NpTHpYc1V0MnNq?=
 =?utf-8?B?RzV6djZIOStxNUhqSzZKSFBVazJUUExRbXh0QVFkU2YycTZ0YWN4dDBYaTFT?=
 =?utf-8?B?ZUw1cEJWb2pqOTNwMjBXeXBzUFlzdGkwSFdZNkFCRHgvMnBnV3RCQUd2RTNa?=
 =?utf-8?B?RGdrZ3BaQkFXN1dnNVFHcVFXT3Q3UVRJQlhBZ2p5S0h6ZkFsc0RySEg0Y2xH?=
 =?utf-8?B?SWMrODdSdlRINk9PS0NmMGQ3aTVydDZMSGM2VWovbFFMbm1LbEZVRDJ2aDR5?=
 =?utf-8?B?UzE3UHI4ZEdBQkVuUmpocjFoK09WYWNqUHV1UkhlZHhJdEVXdGNEeVJWUzBG?=
 =?utf-8?B?WWthbW5kRjB6NlBYdyswVzNDamx0ZjBNUHdoeEtOeWFqbmMxSzJmaFhRWFh6?=
 =?utf-8?B?TG5Ncm5mWVZMQXRUSFdzRVNOZUVFWENSK3U0enF6eUFBbTBVNHV0R0JvL1dZ?=
 =?utf-8?B?UzRMWEU0WXV5aXBrellJYlZSaE15dS90VURHdUdIdmRQbTE0YXZlVWVjOEwr?=
 =?utf-8?B?aDRwQ3pLNUJZQnprSzVvZW5iaHMvY2dQNVFKdEtjd2xYemlhNG5JOUQrbHFP?=
 =?utf-8?B?Z3RLcHJ2OHkwNkNvSXRua2xkZ09JZlhuczZJU1VLQzh5UXd4RjRiWFJ3S3NT?=
 =?utf-8?B?a1NRNHRxVGlTWWZ6Qi85V1dFdWpXVmlYajNTUjVZQUV3ZndoYTVrYjFFYXcz?=
 =?utf-8?B?RVJZUzdFZkhEcmJmcnN3VWNSZUZqZXhYZnBZYlJOVmFKTnJNa1JRYlNwSkYr?=
 =?utf-8?B?MXpZL2dxMVR0L0ZWajhtMWFxbFNnaFNvcHBZV242d2tVVWNPRm5UcEZQTWRE?=
 =?utf-8?B?ZUlYUG0wYVVTZytlRWU4dXBwSnNSQnpCNUgvL2lxV0xseWpMWjgvSGxkOGVD?=
 =?utf-8?B?LzVockhGSi9ucFdBTEYzVEw1dllpVllCd2Z6OFdDL3hHaU5BYmJweVVoT21B?=
 =?utf-8?B?d2FvOVR5ZzJUUGtCbzFyK05vYVRNMkRpMkhvWjZzR0dkSXVSQ1RGMEdqcEtz?=
 =?utf-8?B?ZE1BZ2VhbE1TL0VJall0WCsxUlFFeDZPVnROMDlWZ3JmRFRMVWFiamZRcmxu?=
 =?utf-8?B?QllhYlpCK2hUN2FUQkxGS3NaTURiTW10MCt5aW9jMmovVFZFb05aMWtoVkh0?=
 =?utf-8?B?cWR1ZEF4WCtqdXV0L0pMZFFSOTJyeDVJTm1qa2VBYmNSc2ZsNzAvODZLNm9M?=
 =?utf-8?B?K3RkV2x4Ukc3c0RITGc3anlCdVdRQmYvNUdrMFFPek9zd2hTelJHSStDMjhr?=
 =?utf-8?B?U3R3OFJmVUpmS2RjWVFpQ0doLzJJUy9KWnpteVNVOWxQSzhhWHUxTUw2M1BW?=
 =?utf-8?Q?gyCn9R/2ibO7QbKc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D84E3ACF0D6814296B2FAA108F41C85@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uzC9W63491I/ikttGd43v9cO8maHalORpW4q0Zz/k2N4tudqYWH6RBhEQ7hJ4V/1PQGGVt9zIfmunLdJZLvks+DRo0OZIGiQeEG1OBxxFOB6B8RHA6olVrnfGwyq2pZxcHc2zOCZy6E0WvfrIHMgkHUvN/y8Mh0sIyV2csnEDoGupY3gz0lY9aylynjXFkm31VT6/R/M7odQgzmAdmZFDbEJ56ZdMobm6R0TN2aPClyHRIs1goAdx4gF2iYZG5unE8L6Zz+GShLHD0SM8WEAgvwttMuEA0uhES3ikTM45Qd8KYiTcgBw2kPSeD8sPExG78uUmd5ThdNG7vwBFb9jqg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f93a625-016d-4cf6-0d52-08de94b46190
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 14:45:58.4987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjGcDyDqnGBkPvumESC8RlE3uArfX/9fCniXdmtQu1IrzDMtiZtHnDvsxbZeUcCDV0rRqE6JZIQx77JhPp6PEPLMw1CKCRkz7Qi5NMG8rzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6892
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
PiBTZXQgdGhlIGdldF9waW5jb25mIGZ1bmN0aW9ucyBmb3IgdGhlIG10ODE4OSBwaW5jdHJsIGRy
aXZlci4gVGhpcw0KPiB3aWxsDQo+IGFwcGVuZCBwaW5jb25mIGJpYXMgaW5mbyB0byB0aGUgb3V0
cHV0IG9mIHRoZSBwaW5tdXggc3RhdHVzIGNvbW1hbmQuDQo+IFRoaXMgaXMgdXNlZnVsIGZvciBk
ZWJ1Z2dpbmcgcGluIGNvbmZpZ3VyYXRpb24gaXNzdWVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
RGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJz
L3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdDgxODkuYyB8IDMgKysrDQo+IMKgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGluY3Ry
bC9tZWRpYXRlay9waW5jdHJsLW10ODE4OS5jDQo+IGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVr
L3BpbmN0cmwtbXQ4MTg5LmMNCj4gaW5kZXggOWJjYWJlMDMxNTEuLmIwMTUzM2VkODBiIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdDgxODkuYw0KPiAr
KysgYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdDgxODkuYw0KPiBAQCAtMTI3
MywxOCArMTI3MywyMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb190eXBlX2Rlc2MNCj4g
bXQ4MTg5X2lvX3R5cGVfZGVzY1tdID0gew0KPiDCoAkJLmJpYXNfc2V0ID0gbXRrX3BpbmNvbmZf
Ymlhc19zZXRfcHVfcGQsDQo+IMKgCQkuZHJpdmVfc2V0ID0gbXRrX3BpbmNvbmZfZHJpdmVfc2V0
X3YxLA0KPiDCoAkJLmlucHV0X2VuYWJsZSA9IG10a19waW5jb25mX2lucHV0X2VuYWJsZV92MSwN
Cj4gKwkJLmdldF9waW5jb25mID0gbXRrX3BpbmNvbmZfZ2V0X3B1X3BkLA0KPiDCoAl9LA0KPiDC
oAlbSU9fVFlQRV9HUlAxXSA9IHsNCj4gwqAJCS5uYW1lID0gIk1TREMiLA0KPiDCoAkJLmJpYXNf
c2V0ID0gbXRrX3BpbmNvbmZfYmlhc19zZXRfcHVwZF9yMV9yMCwNCj4gwqAJCS5kcml2ZV9zZXQg
PSBtdGtfcGluY29uZl9kcml2ZV9zZXRfdjEsDQo+IMKgCQkuaW5wdXRfZW5hYmxlID0gbXRrX3Bp
bmNvbmZfaW5wdXRfZW5hYmxlX3YxLA0KPiArCQkuZ2V0X3BpbmNvbmYgPSBtdGtfcGluY29uZl9n
ZXRfcHVwZF9yMV9yMCwNCj4gwqAJfSwNCj4gwqAJW0lPX1RZUEVfR1JQMl0gPSB7DQo+IMKgCQku
bmFtZSA9ICJJMkMiLA0KPiDCoAkJLmJpYXNfc2V0ID0gbXRrX3BpbmNvbmZfYmlhc19zZXRfcHVf
cGRfcnNlbCwNCj4gwqAJCS5kcml2ZV9zZXQgPSBtdGtfcGluY29uZl9kcml2ZV9zZXRfdjEsDQo+
IMKgCQkuaW5wdXRfZW5hYmxlID0gbXRrX3BpbmNvbmZfaW5wdXRfZW5hYmxlX3YxLA0KPiArCQku
Z2V0X3BpbmNvbmYgPSBtdGtfcGluY29uZl9nZXRfcHVfcGRfcnNlbCwNCj4gwqAJfSwNCj4gwqB9
Ow0KPiDCoA0KPiANCg0KUmV2aWV3ZWQtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRp
YXRlay5jb20+DQoNClRoYW5rcyENCk1hY3BhdWwgTGluDQo=
