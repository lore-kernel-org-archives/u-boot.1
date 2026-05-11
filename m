Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6621ACD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA07883DC9;
	Mon, 11 May 2026 14:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ihHaw2OJ";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="KrdEwWC9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B6B84715; Mon, 11 May 2026 09:17:37 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62A20846C1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 09:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 7723c13c4d0911f1b96f91537e34a508-20260511
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=9YvDPtV7elqIetDr27hM7huk2sSsWzdNlEvf1whGJws=; 
 b=ihHaw2OJRYzsSe14prVZcEHwDF18caAdWmRhbEmsMBc6MbwcuT1IEVK+3F04+JpAMD2q42m1UgwIqLikcs5DEffCgIWaEmRnpb38EswVupnO4VXUEAzFDaso76i42JR60Jt2OSb8o20xIobDLigozsX4tFMWAxdoSCRwzTJ74bw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:9b7ce8f4-7ce4-4495-afde-d514b5f0690d, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:69fe2dbf-65a8-4b41-ac18-3671578a914d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7723c13c4d0911f1b96f91537e34a508-20260511
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 925641384; Mon, 11 May 2026 15:17:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 11 May 2026 15:17:27 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 11 May 2026 15:17:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPspHWRNph3ePBZvbS7XQ9l+CiPdhs4dM1Z45Ci09cSvCBgeE2vP1p7FiXJnNPvEN5K9eYdeYUYS2AJodqegbftEYS09p5s97FyOuFOoe6yiyFPCOidYoa5ijT+IpfBMiPHvxLN9+AP3lSfZ6zk+oPSylk4BChGma3GtAypCtcXLUoIA5rvpAYTjHuKkWNJ4IqtbfALIQveIXWfJHTcXPZIhrSMg9nldYO+Uv9ns90bnzjTbHI4AkXvmgTaINBC0l8VrGdqJPSupLYIaTAbhabvwtY4TPDpfU8aZdloCBxf8z1bwZGCciinKCeDDm2NN8UOPTfn19EI84MyZTstzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YvDPtV7elqIetDr27hM7huk2sSsWzdNlEvf1whGJws=;
 b=jaTjqobLv9jMdHvFnjLyFn5HiauPcCMJeXDNyClbsBHOm4aT5p6/PAyl1ohHIN0gBsx4kNOSUdmTmvRja2j3dKZYDeLikZBjYZcM5xJmmB/8OfKy2VTAZJZ0SgJNLBAJlBG43FB3v9yn080EPt0kRT2u7rs9uRKYe3r2RdJhm5bAzCU0MaUBTg3dMtDEXP07FajJfbej9JHNiPqNdp3WVccZK1E6SnrWQftkHV0+IlalpCM0AjfEplcjHKRfONEwQOs+vb/kVUAog64e+0RTQDiYwIyrHV9Q9kefJ/G1NQbhUTuQ+JoFK7OrUXFjU5YRawL+d8ckAZ/5gGdant2otA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YvDPtV7elqIetDr27hM7huk2sSsWzdNlEvf1whGJws=;
 b=KrdEwWC9ZBfnqNADG3FwLIE1okxM/HTLC/NBnQe5xxZE8fkxYScY1R/xvZWRZrBqgt2KSSBF2KfGCNqIWoS+Cus6W3ydWPl1iik9S0Uj1rPByEbekg7kF6s3+8qzljj9+GRMZ/xn8IZ21eHPwZUz0IDn/e35uehXZpO/1cTNcZc=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYZPR03MB8410.apcprd03.prod.outlook.com (2603:1096:405:76::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.15; Mon, 11 May
 2026 07:17:22 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.21.0025.012; Mon, 11 May 2026
 07:17:22 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?TGFycnkgTGkgKOadjuejiik=?=
 <Larry.Li@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>, =?utf-8?B?QmlhbyBIdWFuZyAo6buE5b2qKQ==?=
 <Biao.Huang@mediatek.com>
CC: "philip.molloy@analog.com" <philip.molloy@analog.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "s-vadapalli@ti.com"
 <s-vadapalli@ti.com>, "jerome.forissier@arm.com" <jerome.forissier@arm.com>,
 "romain.gantois@bootlin.com" <romain.gantois@bootlin.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>,
 =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
 <SkyLake.Huang@mediatek.com>, "stefan.roese@mailbox.org"
 <stefan.roese@mailbox.org>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "heiko@sntech.de" <heiko@sntech.de>,
 "ycliang@andestech.com" <ycliang@andestech.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "pbrobinson@gmail.com" <pbrobinson@gmail.com>, "semen.protsenko@linaro.org"
 <semen.protsenko@linaro.org>, "mikhail.kshevetskiy@iopsys.eu"
 <mikhail.kshevetskiy@iopsys.eu>, "me@ziyao.cc" <me@ziyao.cc>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>,
 "raymond.mao@riscstar.com" <raymond.mao@riscstar.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>,
 =?utf-8?B?S2V2aW4tS1cgSHVhbmcgKOm7g+alt+aWhyk=?= <kevin-kw.huang@airoha.com>, 
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "peng.fan@nxp.com" <peng.fan@nxp.com>, "root@infi.wang"
 <root@infi.wang>, "visitorckw@gmail.com" <visitorckw@gmail.com>,
 "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
 "samuel.holland@sifive.com" <samuel.holland@sifive.com>,
 =?utf-8?B?VG9tbXkgU2hpaCAo5pa95piT5bu3KQ==?= <tommy.shih@airoha.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "lucienzx159@gmail.com" <lucienzx159@gmail.com>,
 "patrick.delaunay@foss.st.com" <patrick.delaunay@foss.st.com>,
 =?utf-8?B?WWFucWluZyBXYW5nICjnjovnh5XmuIUp?= <ot_yanqing.wang@mediatek.com>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "christophe.roullier@foss.st.com" <christophe.roullier@foss.st.com>,
 "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "kory.maincent@bootlin.com"
 <kory.maincent@bootlin.com>, David Lechner <dlechner@baylibre.com>,
 "jonas@kwiboo.se" <jonas@kwiboo.se>,
 =?utf-8?B?RmFueWkgWmhhbmcgKOW8oOmAuOW4hik=?= <Fanyi.Zhang@mediatek.com>
Subject: Re: [PATCH v4 9/9] configs: mt8189: Enable ethernet support
Thread-Topic: [PATCH v4 9/9] configs: mt8189: Enable ethernet support
Thread-Index: AQHc1+CHGDt+7+607Emrc/iqrxEuarYIfKmA
Date: Mon, 11 May 2026 07:17:21 +0000
Message-ID: <cbc10d24b7da9f76b95db3ea80a18d79f3adb9c8.camel@mediatek.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
 <20260429-add-ethernet-support-for-genio-520-720-v4-9-be54e17239b7@baylibre.com>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-9-be54e17239b7@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYZPR03MB8410:EE_
x-ms-office365-filtering-correlation-id: 74da481e-0976-46cc-876c-08deaf2d5835
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: svF73Fdolron0F4DiluZiFmwc6x/ZEMlN/aNhDjKx/GjkKztZQu+CWGG6DgoT3J2lmGhK7wsjPqY4YrgVzDu63v6qI3Xv7yETP++xHKfmpn7jsCZweo0kTs3fB8ceGwLtPUQXjE3tqnd/X/htwtpEMQB1y6oq4fn4nXQgHH9rwn4Rrfmxqs9CQD14T8FvZJfGB7tViwkVMRc3VZ3ZsaiWztAnBkFDDyG4vXecwoLeNiVUgVlqATgUJZI1vmsjdXH/tmzwP/dU3W0YZBQwxC5UZ7iYMiN6iTOK8WK+v2cCz4WbM0kt8P2Ot0fiUyqu6fjTygp8QE7haf5OzHD2rRaIn5QEAUvWB7mJSqhzzK4V0bpW2sROs+TMaTq4fb8/CEnOqak8RkahRqMNeQxhqB8iwNwpXlnUeTVCVGC33RaCuaLxsj27UYytiRWVpd3/NNeSiY+TcAA7vp8pSKoKG7D+q3X9S82QM6+JaILXOWkBSRntxhvJcwIPXCMu8paMwvdz2kdzO4oEjtp70v9vtCBhGFVxJxSTXc6Zb9I9ibvCbCq5ZBC7d0r8djAwfTMNhIyNi/HtwAWGk4cOt0L9j2IX+0NhFzalkipg2KrVdpOkHNWhvJaPqZ33EK53Ej5rjrWiGWXRfFEZktZsVagISvZNZj84a97KBZ3LM4D0jhb+nm7rks9ipMuUwSmVG42e4erE6IMRnS8dCvzvayJ1imHdtIyA8X6mGkc4Xzti/gzhvvs/Vmgg1Gq05krfdKglJ20
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWh1WXFVNDhlZmNjVmJIejhqaUpWakh2OWovckdLZFBDaXVoSS8vQWcreEtC?=
 =?utf-8?B?dE9vdk1TT3ZDaFNKSGFGRUl0MDZqa0lBZ0VPSEpCd2JUWTJYY2ZyNmkrZUxp?=
 =?utf-8?B?TGVPR3RKT1VnaXVQODRsNmdOTTE3dHZCUlByQjhxUTREa29XdHlBMmR6dUpP?=
 =?utf-8?B?dGJZUzdmMkU2bURpM25aUWRYbElzS3JGTjU1L1lYRStyeGlEMmh6ZncwR2JP?=
 =?utf-8?B?Tk5xSmFzSjAwVUZqOHAwdWRQQ1lvSndKRFZpV092OTNncXhUSzBQT2R6TWl2?=
 =?utf-8?B?aXZYck0yS3lpUzdJSFBYVVVDUlhkNU1MRzFDdVhEb0JFTUdRcUt1VWlNYnY3?=
 =?utf-8?B?U1VDZktBTVo1OS9QVDRwenJXdzhWeGxGbzRCb05XR0xQeC9hQmc2VGpncDRL?=
 =?utf-8?B?Y2cwbWdTR1RZRitUend6R095MzJ6Z09Qd0pEaEd1MGZqNTBzM3BCV0xDQ2lp?=
 =?utf-8?B?NnVBNE1Bb1JtTXRwNFhVMndxYkNGNmhGaDdwcFM0K0J6aTdIcytZYUpydnVG?=
 =?utf-8?B?emZJWDRDUWpSY3Z0R0Z5UTNCeEVSNVlhNnVIZG4xU0x5UjNvWEdzbUowMmFh?=
 =?utf-8?B?TnkwOUpucEx1aXRTMGJTdkhHTmhuT2lKVzdYVmcrU05BK3E2dXJudnV4S1ky?=
 =?utf-8?B?V24ybVN2d1M5V3B2b28vYmtIeFY5dmhvMmdybDloVW9UT2d1SEJLc1ozaGdk?=
 =?utf-8?B?TEttZ0VBWWZRenBKNDBlQkR3Y0RwYUROcnA1bFRzSXN5YktHckV5Q0FBSDNU?=
 =?utf-8?B?Sk1sa2E2SWtVbWoxNTJ0T1RoTUxrVVJJdmpEN0ZBQVpXQTN4aTR3ZXhxMGZO?=
 =?utf-8?B?S1pENFJMWUhBL2l6dWx0a1VIcGt2RzJsYURFRTJLM3JjQit6MjFwNVlwU2Fj?=
 =?utf-8?B?Y1ZPVjFHeWpMaWNYYktrV1dxZVFDVThMR2NkMXJaMnhrUlc4cHNFR1JZTk5r?=
 =?utf-8?B?blcrUmlqY1FQdTdjUGxBQ3lFYUlGemNXWUdBUndySGgwZThFY3I4VGlWSWVP?=
 =?utf-8?B?a2NyU0VFOUtkS0NHc3hVK1Y2SEsvaHdGakMwYmp3NEI5eVhSZlc0ajdQdTZa?=
 =?utf-8?B?TXFkWmNCVVFzY2Y0S0xFVUd5bXVHT1FrTnp4NWFyVFNHRDVYNjR1YWR4b3hw?=
 =?utf-8?B?VzRwcDdxRFlKZUUyeVZJK3lwQ2grb2FuLzVWbGNvSHlhWkgxdmQyQlBRdC9x?=
 =?utf-8?B?TEdIU0Q3c2N1dXNOWWFRTjd6Y1JzMUlTSUtMVWNYdmNBNkIxYTdiaFNpMnVo?=
 =?utf-8?B?Q1J6MXY1djR4VGtRV3pGR3J0VloxSlY1VkhIWjRtNEgyQWM2bFdTdXdzQlFn?=
 =?utf-8?B?UDYxU085SGZaNmJIalJGdHpZbzkwb2U4aWRuaWF1clgvOGxlcXV6elAvcTg5?=
 =?utf-8?B?TG9ncWpmUStaWDJ1NzFOSjhqK2Q5MFVCM1BKbUJSbFI1MHJ5Mi9SbHh2Y2Zo?=
 =?utf-8?B?MVgwY0pVRXQxWkJHYWNWdXZvdTBZZFFwMmxMZWs0RWlkU1FzMlVtRThuc2RM?=
 =?utf-8?B?UExlYnJxYVB5NFd3Kys3V1UvaTRLTks3TFV0WmVTa1VtaHF2TEprRnExU3JU?=
 =?utf-8?B?Vno4c1FYNVBKVjgyeW41YTlIK1E3cmVvTlVNWlhRZlhhS3NOekZmMHJLV253?=
 =?utf-8?B?S3hNSkVSYTFtbnc2RWVnSUJOZlBJdlhVQmlHZzZOWWxVaDA5Q1dnZVdXZkQr?=
 =?utf-8?B?V3BWVUFHbUZuL2ZvQjUxOUphaVNvOGJYTE4xM1BndlNKOEpYOWh1RzJLNTZM?=
 =?utf-8?B?aGUxanNpSThGRVZicGswTXpLNitsekI1eXE4c1Yra1pCYk5TbU9icS94aU1C?=
 =?utf-8?B?UytPQmlNMitOZWFmSVhFVHFjZGVLK2FKOWtyeDhFVHIvNDY2dHJrWmR3TkNX?=
 =?utf-8?B?cU9UUk1qT1pQQW96SHN1ODdaSGx5TzdwNDFJbm44TUxHdGw0VTM4c0p4NnZw?=
 =?utf-8?B?emEyaFlDc0dLbUpNN0Nud1R5MG1neXhabGcwTFZqUVEwc2dINjVFSFFwOTdy?=
 =?utf-8?B?aXgxa1ZMS0JDU05HZ0JlTDloS1FsSVdLTmQxYmMrZkZ2ZVFPQjh5SGtaY3F4?=
 =?utf-8?B?b2lUcnR2TTNjMjRkWVhNYjNScnl3Y0V0VVE1U0RMZER6MEVCYncvc0lQa2ZO?=
 =?utf-8?B?eDl0NHJQeFJOVU9HK04yQ25WU2lmMm9Eb1g4bmd5aW1RN2hjVXM1Ri9qcHJh?=
 =?utf-8?B?VXN3SnlyZUxTcXlnc3ppR3RTejZqWlVGODFDNmJnL2RlU1FVTlkyZzhJSURU?=
 =?utf-8?B?OThLRndWN0xGZWxxYTVVNTlMZ1FzbDVHT1Evb1VuN3R0ekRvOERMakpmbHhv?=
 =?utf-8?B?K2NvRFc3SjduZ1BiUTNpakh3Zko3Q0ZyQytnTnZBOWUxTmM4K3QvN0NMalNh?=
 =?utf-8?Q?0nw4DgauMF0y9r9I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B8B7ADBCBE30A4AA31E760BDA78C36A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fbFtUFOgcWe3NN6iM9ek4d/Ydrmlq4OudnLgwP419OF3KDta0MzrLy+ieCIx9YdLJ7qidpBJ911hx/ofZchbEaUY6i7KHdavZznkkdToW8xEzoCV1hRuMFFc1lg/riMkTctBxLMNg1jSORZzspSkqup31aGj0gaJXBUZ2D4oXyEGRq6CrGAMjKsRZq1HU2i09I6n4fAQiEiwAwZ8bM5FVPmD2jtqN38QsscuyVE2856tOPBNjCshIQGkYRe3veYJTUho0zsB87/IzCIeD6h5gnyhZK8kh6Mp0sMOfB03wZQKIskcRy0cnY8leAFniCxUjjgO7aF6USxBTqnPaHhnVg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74da481e-0976-46cc-876c-08deaf2d5835
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 07:17:22.1034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwseuN5Zoy19E6Y5piRMGnO4yjYkbLFCJJJ03mwze6BlpRmDgYcxanulfmTfUT83cL19jwkwyxz+D1XSpSM7O3KY7uuOSZnibQYQS5gk7oA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8410
X-MTK: N
X-Mailman-Approved-At: Mon, 11 May 2026 14:51:08 +0200
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

T24gV2VkLCAyMDI2LTA0LTI5IGF0IDE1OjU5ICswMjAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gRW5hYmxlIGNvbmZpZ3MgbmVlZGVkIHRvIHN1cHBvcnQgZXRoZXJuZXQgb24gTVQ4MTg5LWJh
c2VkIGJvYXJkcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhh
bkBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiDCoGNvbmZpZ3MvbXQ4MTg5LmNvbmZpZyB8IDUgKysr
KysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvY29uZmlncy9tdDgxODkuY29uZmlnIGIvY29uZmlncy9tdDgxODkuY29uZmlnDQo+IGluZGV4
IGVjZjhjNWY0YjRiLi5mODZiYjUwYmI1YyAxMDA2NDQNCj4gLS0tIGEvY29uZmlncy9tdDgxODku
Y29uZmlnDQo+ICsrKyBiL2NvbmZpZ3MvbXQ4MTg5LmNvbmZpZw0KPiBAQCAtMjMsNiArMjMsMTEg
QEAgQ09ORklHX0NMSz15DQo+IMKgIyBDT05GSUdfTU1DX1FVSVJLUyBpcyBub3Qgc2V0DQo+IMKg
Q09ORklHX01NQ19IUzIwMF9TVVBQT1JUPXkNCj4gwqBDT05GSUdfTU1DX01USz15DQo+ICtDT05G
SUdfRFdDX0VUSF9RT1M9eQ0KPiArQ09ORklHX0RXQ19FVEhfUU9TX01USz15DQo+ICtDT05GSUdf
UEhZX0FJUk9IQT15DQo+ICtDT05GSUdfUEhZX0FJUk9IQV9BTjg4MDE9eQ0KPiArQ09ORklHX1BI
WV9FVEhFUk5FVF9JRD15DQo+IMKgQ09ORklHX1BIWT15DQo+IMKgQ09ORklHX1BIWV9NVEtfVFBI
WT15DQo+IMKgQ09ORklHX1BIWV9NVEtfWFNQSFk9eQ0KPiANCg0KUmV2aWV3ZWQtYnk6IE1hY3Bh
dWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQoNClRoYW5rcyENCk1hY3BhdWwgTGlu
DQo=
