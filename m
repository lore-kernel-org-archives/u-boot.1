Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2B6F33A65
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 13:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4010783F61;
	Thu,  5 Mar 2026 14:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="dRpPiHVI";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="UDL5PcKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D48A83F75; Thu,  5 Mar 2026 14:57:35 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D9A83EDF
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 14:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 3c5f91f4189b11f1a39cd589f645bc18-20260305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=+lBUeBimJ2mCX3iIIe7y/VLZsNlpSuvvJmjItpGgDlI=; 
 b=dRpPiHVI/ISa27w6b7MCyXZBB/J0VutF2nv5po4Urja2i4t3iXdUxM1zzsQPw1pUjjW69T2musrSkqL+Z6b50Xheh9vS0/+IIpYLdclr0lnFkce6eLeCSYkVWNA/jlNkxSnmRtPp5xLvY5iR9VbMZFZnIpAM8t17OW4p+Iv+97Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:fd6db484-289b-4615-9e19-affc0c783662, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:9e598f7b-8c8a-4fc4-88c0-3556e7711556,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3c5f91f4189b11f1a39cd589f645bc18-20260305
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1771643298; Thu, 05 Mar 2026 21:57:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Mar 2026 21:57:22 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Mar 2026 21:57:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJLop0lFhMhVAY/tSC27UiBeXedr/BkaUGNGm8Rpk8TV2pvbtNP4BIn/RgWnIoTUD1fD0NM6rTNHC9+aHxHU/IaoZb4LR9MXHmQ9sGMJkEgoqeuTiP82yftxpID2TzE7SmNRXugf0MYyTbjVjmNCsJKXEocf7/Y2YZI2NsBs5k3/DIkEF7K0CmDs3hBm+dTHEyGxbo82H2zOCGDnrqGaoYsyJPMABYkJIfZQOTYsfp2dEuSPWoNj/YQnt/vka8hJO2XKnkcS0Q4uFkqlUBrVaYdiqravdxNNjAUCb1YsWOgOeaQORDLEO8Z7CqE+XbM81ReSy+pyqFgdX80hyjJQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lBUeBimJ2mCX3iIIe7y/VLZsNlpSuvvJmjItpGgDlI=;
 b=a9JHmI609no3OXui05jQHqQyvrUjUWN17y7E4gHmV82nrt4LjkTvldBuqQ8QXf8aAZJg3FkBWIuN4QeG5T+IURNseKfwwW3b40Y/CED/oeoNEii1yUa0yJIj1YA0pvL1F06Vk3klf+VC6jjdvcZGObi5VBFPU0tgqRx4Hl9MVlkCRAuRRApBKGmrx/r4kUHkgHjtlNPIvw0jl5P1IpikgM4jsZbEtzin5qGMfxVmPJKCt1z/cByLlpGt2sBxroKVxNi26OG6YsEER/dW00cVqnC8dlKVkY1uxKkcGQb7Qm1ejEC/o1ITXxwGyQ3vFpUOYThU83FqWCSG+ba3Rmk4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lBUeBimJ2mCX3iIIe7y/VLZsNlpSuvvJmjItpGgDlI=;
 b=UDL5PcKyRipQfl/t91kefnVDt+B2HJoEMCr+m8lW/+akN/p5uEmae+AAZ2Fym2b54Qaz25n52xvXJZAO6we/4fSMXmkbJ6wOs1lcCimK1fcC6T5yah0isyMDNbFYnwZDusw3WZAFqEuj2S2VsURgtvv8YiHAf2Ze4pKweY6ZMsk=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KUZPR03MB9734.apcprd03.prod.outlook.com (2603:1096:d10:61::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 13:57:20 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 13:57:19 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "lukma@denx.de" <lukma@denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Ryder Lee <Ryder.Lee@mediatek.com>, 
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?= <Chris-qj.Chen@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 07/14] clk: mediatek: mt8188: convert to struct mtk_parent
Thread-Topic: [PATCH 07/14] clk: mediatek: mt8188: convert to struct mtk_parent
Thread-Index: AQHcqqG4meF2eGUrjk+ESmSdDFbi07Wf+rOA
Date: Thu, 5 Mar 2026 13:57:19 +0000
Message-ID: <70a9f303dc5b64d724a6745723663d75c855d86e.camel@mediatek.com>
References: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
 <20260302-clk-mtk-unify-mux-parents-v1-7-32f45085f4d0@baylibre.com>
In-Reply-To: <20260302-clk-mtk-unify-mux-parents-v1-7-32f45085f4d0@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KUZPR03MB9734:EE_
x-ms-office365-filtering-correlation-id: c39f8bc7-3cd6-4b85-7216-08de7abf1e47
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: n+RolK/JnPgeqzhTSbKvU4L4nkvxPCSrvtWx3ekZkYPOGm8d14ltJuDpARGpFvjZKqUJVBt93LUbDbzCpR0BWmDiWHKQQw6lf/E/RWVPRhrDnFr8mBGA1P8pn94xqX9p0EgUTt8JyuNaJTHsM4CRtWlbXCToMvohEIvHLIg5qD5HCic9O8WZTDXebDScXWy57HFBVdU4KL+NMls0ubCHL75gNE+li3bEU4XRFmgzLilgbXudMO0aE+huOinwBNNjJ+ktc3cZSzblCa/Ls8cSrgS/qFKl7mkvw866nHIiOi0HHBUeYYinMERPjh6EnfxKNZwkztPh/XKPDeCnb1UuXyo6CsU0R8qlwbBnuyMGc6pyHSg0E8eQ13rjBWI5jPu0EJA+N9q08moWDlXKsDOG9Hs1U08drC+MNGHMzJu0D0FD1h7wsrt02kn+1/JM5l+jo1QKm7QsAINtXu6sYDLUg9dHpdl11YKAfMpXAsgA3JlSNSPkAMO13BuGWTCP0mSWh3bjpute3RN8kENCpUBnIprTEqLp1Ul8hgBzSyZt/Btaskbmrzu1cHtMU8HCf/uWjKYR7ZeqNA7U4dhweTGMKTtHsKWLVeGHC653gsE2aoN94GN3vNzd0Q7nSS6hzP6D0a+rgkB5u/SMoIVjQ8iMgVANR9SM8Ujp3c3apHlOKo5GTRqxZ3yCqSzzyAZeAIdvvN80E4nOeRNQK9nn99Z+F6IX74jQPl8A0DoeTMCFQ+zk/wkP/QVvt/tlK2/E0Hiee0hJkB7lqrH8DqqXJOtYs0PLTWAjOuwdhY3yN3qPiuJPek3cV7QRgpVPIbTTAXV/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vjl0RFkwbmRTUlB4Skd3WHpuT1F5T0xRMlVFSTQ4eU9iVWZpYVBadnZTTWUw?=
 =?utf-8?B?QjNLbVJaY1hBdytHUTRoVFNpakpYU0hJbkJ5ZlQwZWRqNVhBdEJXZ2Q5R1FW?=
 =?utf-8?B?L2tTYitvajFHNlNuYXlBTUYrY0xrS1FqUlFMN0VZLzRuUnFubjg3NXVOSmt4?=
 =?utf-8?B?R1B6RVZqdEMyUWJQRlg2TkJteElFQnExcDQ0am9zMm1zcEphbUk5NHJXQk5x?=
 =?utf-8?B?MXNBREpEdWZsOXBiRWd1Wnh6ejVhVlFxby9FSDFhKzIzYnpsNUlaVStHMms0?=
 =?utf-8?B?NHdVV0FxbytoUjJuQ1dlK1ZaNjZZNWZsL0t4WXlCSCtVQlF5ZmF4aWdjR21E?=
 =?utf-8?B?WEt1TlJlMXhzNnZVdHpWaU4xc2VXejFLTUxXcEd3MElCVVgzTUx0NWlJQWZy?=
 =?utf-8?B?aHhjUEJXendoMVBvcldrS1ZrMU1KVUpEWkVIbUpZUE1JVTB0MTVEQkxSeUgx?=
 =?utf-8?B?ejgwQU9sZmlLd1BJRjgxeWEyMFN0T2NlMFV4SkhPMkxJeW51NXJHd0UvSERr?=
 =?utf-8?B?a3VjTG9nUDZsK210NE5idE1rRjdha0UweEVpZk0rY01vUFFYV3FiUGR6ZlJD?=
 =?utf-8?B?d0hjVmtUWVMyYnMxVGc1Q0pQamdUM3RQeE9RdzdoVEhOcTRzc1dEYTBEcXI0?=
 =?utf-8?B?OHVIaTZCcUhpMDlxODZtK001OHRsRWpVZFNIYXMyT0pLOEVQU1ZaZkNwTTE4?=
 =?utf-8?B?VDFnWU5XOCtXMDRFejNlUUxxQzhjQnhWK1FYWHZtUm1qcGw2ZHhOZHMrL3JY?=
 =?utf-8?B?bmxTeS9qNmwydUE2elJMU2R6TUpzdWo3WEpNYWZaMUgrc2g1TkY3bTJ0em9z?=
 =?utf-8?B?YndPSWZqOTNSWkVnQXEzakxCWGhlNGVMTWY4S1ZWOXZKRWZ1S3RRa2xRM3Rh?=
 =?utf-8?B?ZFdkazdqaXFlSUQ1UjJjYnlXUEU5WjhQdzhvS0ozV05scktIVjAxQ25PcklG?=
 =?utf-8?B?UmRDR2hqSGtYNDhsNFg2d2pRWkhUZW5hM0RES1kwVm9kZHRWVThRUEhqVllC?=
 =?utf-8?B?bThWejVqR1VEWHRmOUp1cFdoQS82L2M1aERkTnVMazVrVXlTMWlScG9ycGtU?=
 =?utf-8?B?ZXJlR1dSNW42dkVNTWNiQ1VrWFNUNUFDc1c2eUFLbmM2a05PTXdrY0Q1ZkRv?=
 =?utf-8?B?NDFQRGM3ZzBzRnZraXp6SVpib0cvaGVidFQxWUNrNUNZWXpaY2dMeUt5bC9G?=
 =?utf-8?B?RGxFYTdxZjlJVEE2L2huZUZ4SjhRMW9abytVTkcrdm9ueUJPaTZwU0w5RGJE?=
 =?utf-8?B?aUtFVEZMdlRnVjNNZXhaUXBQSmpGY2RXMzMrM2d6MGtZSlAySjdUaFV6TjI2?=
 =?utf-8?B?dE9NRU9WNmUydVF4Z3JJTnVlK1RJNnhETFg5Q3dnQmpvMy96bFduT05nLzMr?=
 =?utf-8?B?WTZJOGFPM0d0aHlVWnZKM3JUR084VEM2WXlrQnJwcDhSZElJYklOTi9jYjNQ?=
 =?utf-8?B?STNjTEF3ZVphbnpWZ2l5KzR4bFpnUnJpaUVkekY5UFdWV1J3Tk5KelpNaWdT?=
 =?utf-8?B?NXYzdkFsZXZKa2hnMlhGT2JudkVJNkxpeHhQR1lna0RTMTJ3SURvWEtZdGVv?=
 =?utf-8?B?cndlL2tvTkFlNmpEMTZqQlJ3NjI5cjBpYUZOK3ovVFdoTXpwMjU2TDFkako3?=
 =?utf-8?B?cHJvZnorb0IvaEZQZ1ZoTkRxbWQ5Z0F6TkdiQmZJSXJFSkd0ekZ3TDBaUUMx?=
 =?utf-8?B?enBBZStkVWtxL24zTlViT1BDL3FCQTkwSzF0RXdGRThac2Y3bEVjbzZ0N0Vn?=
 =?utf-8?B?bkpVdGw4NVV4SlBOVThNRDFqdXkvZERtZk4yQ3laVDV5dXN0MTZhQ29jeHl5?=
 =?utf-8?B?NjBDRnA1OVZDZnYrMm5ueWVldWlOc0pFVDhWYXI2WU16VDBOS0luQXFsbkxU?=
 =?utf-8?B?QUFpTEpxanc1Y0lMcVlUZWNIcUlleUlMaFE1ODZacG10NWpTNTJTSEJTK2lP?=
 =?utf-8?B?SGJKN3dkczZqakptQVA0Unkwa3U3SUdTZlQzQkw5Vkx3RnM5aFdsV0FYSENS?=
 =?utf-8?B?aVJ0dEJYK0c0QzdScjMwdkNnLzBiSGhFVi95YkpROFpqNTcwUURRbTdaUFVV?=
 =?utf-8?B?Q1V5L0p2dWsyKzM5dUFNQWttT25DRjE3QmtDQmhyc2szZGJsd0xyUWZrOUd4?=
 =?utf-8?B?V1VqUUtIQmZSaE94QUh2NHJJVlNndmlQM09mZEtiaDFFd0JFbmNNMURYb0pn?=
 =?utf-8?B?TGlvNmw0MkZaNmJmeWNGcldvU3REMEpPM2kvVFI2ekhSNlIxbzVBcGgvU2xI?=
 =?utf-8?B?enJrc3cwQ0Nqbkt6ZkszRDhmRW04U2lhWGYzeTNWeXlsNnVmQ3U2T3VhV2pR?=
 =?utf-8?B?akgrSTJJWjRpOWpiMVU0WnczUFI3QWhkV3p1Nks1VWk3cXdPOFF5eHJxYWVL?=
 =?utf-8?Q?7xmGvGuZ7atFwbs4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <388C38CA04F32C48945CF7A08CF7A43C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PZGhPebqo4ov7XgA2eWodD023g08EUD4hlhzhygDo62NRfI5ljlXMVWSo1+sbX/mMM6te+Ahrxg1Fy99o2gQ6QeeKOSgnnOz7DhdOTrWc/DK3Wgz7mUXm+sE73jfmzPyd6XeUVgT8vwpbikCdm6i1/pwdEqKDJoxBmz5H+oz3im0UrcY8fKFYDf2Opm32PB84ejOgKGq4NNaH+HRynyK9iwtvhCog73+Dqr42JuRwbeqI2PMmWLcJCeWncZ3r1EN37HEgXO8G93Ap6ah/XpgQjps6EB9YuMLMo8Qgv7zEwKRjA7+zx/wTp07MD/yRRggmZQqlHWLud71a0K4KM1dfA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39f8bc7-3cd6-4b85-7216-08de7abf1e47
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 13:57:19.7901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Ui4eDtj0xo8+vjEF2bW0ZeKrC/dcXwn3JTGVRHkxvdLE2Ixx8312KzaBO8XpmKA9SpoH6TjjXQEheP39ix+onHPcDegHs4HD2r8PwKssUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9734
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

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDE4OjAzIC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBDb252ZXJ0IGFsbCBwYXJlbnQgY2xvY2sgYXJyYXlzIHRvIHVzZSBzdHJ1Y3QgbXRrX3BhcmVu
dC4gVGhpcyB3aWxsDQo+IGFsbG93IHVzIHRvIHNpbXBsaWZ5IGNvcmUgY29kZSBsYXRlciBieSBo
YXZpbmcgb25seSBvbmUgcG9zc2libGUgZGF0YQ0KPiB0eXBlIGZvciBtdXggcGFyZW50IGFycmF5
cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJl
LmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4OC5jIHwgMTcw
NCArKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gLS0tLS0tLS0tLQ0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCA4NTIgaW5zZXJ0aW9ucygrKSwgODUyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxODguYw0KPiBiL2RyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdDgxODguYw0KPiBpbmRleCA5ZDFkYTIzZDA2Ni4uMjI3NjRlNzQ0ZjYg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxODguYw0KPiArKysg
Yi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTg4LmMNCj4gQEAgLTE5MCwzNzUgKzE5MCwz
NzUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZml4ZWRfZmFjdG9yDQo+IHRvcF9maXhlZF9k
aXZzW10gPSB7DQo+IMKgCUZBQ1RPUjEoQ0xLX1RPUF9VTFBPU0MxX0QxNiwgQ0xLX1RPUF9VTFBP
U0MxLCAxLCAxNiksDQo+IMKgfTsNCg0KW3NuaXAuLi5dDQoNClJldmlld2VkLWJ5OiBNYWNwYXVs
IExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MsDQpNYWNwYXVsIExpbg0K
DQo=
