Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911F6CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21AA384661;
	Mon, 11 May 2026 14:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="P1wSKLDU";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fYY2v3t8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 070528485A; Mon, 11 May 2026 12:34:16 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26FBC83E76
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 12:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: ef96d9ea4d2411f1b96f91537e34a508-20260511
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=qqHcbGbBnVenk02Owjp4B2hAlgAe4lw2XdyrMvZOnzo=; 
 b=P1wSKLDUbbZNWqSWlxJJr35L86Og1j5A2q9izVJ+TLnGEiWR6kkzqKD2g7rwlFAeL2Fb5j1rjKlmmEMoCrcbyagYLTYohd5leZ4VbjHZdF+li/1AuxncKMMrxBM1PUgS9LFnsI9nYDD3LNoMii9m3RQvuBTBYIFF1+uFTzZDaaE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:c0d1ba8a-643c-47fc-b923-1c89d372e805, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:e7bc4371-3b7f-4b26-b2f9-40f0deecb36d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS
 :nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
 C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ef96d9ea4d2411f1b96f91537e34a508-20260511
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 780001826; Mon, 11 May 2026 18:34:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 11 May 2026 18:34:04 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 11 May 2026 18:34:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdJxRaxFxiDl12fQiWmbyW0lSZ/Nx2DvHdVPbFHBKXe15J4LDBpQPd62qc3f3rja0pi3gJqVyKCXsXFEkJdDw/hNhFBM7AZCVzqtGegcJ4EP2CRj6x6q1N3MPqfXwgdJyjfen3TfKnPcZuBHDFw4tVFr3w/CkyJ/KU1Qpr+Px05VCthF9L28/tFF5sDfTyraBarHsPtjRU86JdTvZBnLNTxIvngR1aA/ATsH1WqD1fFN2RRv9i9tA9UmpbWG+OBeJopE7Upk1FA7S/DCRAB2A+RHgGpylBnB4OcedfpW8I7LQMDiORbjW0ZWdWo/wKJVKPkb2/Hy9SWUI/kZam6Oog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqHcbGbBnVenk02Owjp4B2hAlgAe4lw2XdyrMvZOnzo=;
 b=B3vLK1By/u5bG2QYaFikdIzMmLQCaPASDdA0i7FhD4VFtCpBg5yqGop8ibuGhdPFFC/G55ixgF0c8tniPVGSUPBj8UgqKMHiZ8ZJgC3/2S7bxLtWO8+Ud1xwXv2hCGzr1z4mtqUQkrBaGjb1F41RamAMVpz2e9lkmiqkMO4pwG1ExdbOi05GbTduaOBEXZZG58/Kq31avmst5Cjw0LbOss5JXScTF3zElQwtAxl6jY5iIWmyXVzZh0PFz9N/ivPDs0ULZmVAwMb0KxLjnnKYvTSixZcNpXQYWv+lz5koYBtFUQSFFeGzfhYlhsSFEZMP+I4AX6JG5NKFqVxj4LQZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqHcbGbBnVenk02Owjp4B2hAlgAe4lw2XdyrMvZOnzo=;
 b=fYY2v3t8V19Q6bIbsYIMt4glYHEVzCgNKc++SpOtPllEiO9w0U58z6BG0bpPejokfKERomklOwXYNxc8HYoqHLiNpoNAOSqRUwSNUy0RCXkjYBHmyVHNwFB210GGR4+dhzxIME3ot82552dXK6+hL8Ok53JPhkqhGVUNJObwalg=
Received: from JH0PR03MB7806.apcprd03.prod.outlook.com (2603:1096:990:2c::12)
 by JH0PR03MB7342.apcprd03.prod.outlook.com (2603:1096:990:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.14; Mon, 11 May
 2026 10:34:01 +0000
Received: from JH0PR03MB7806.apcprd03.prod.outlook.com
 ([fe80::b4fc:5d2a:5560:19d5]) by JH0PR03MB7806.apcprd03.prod.outlook.com
 ([fe80::b4fc:5d2a:5560:19d5%3]) with mapi id 15.21.0025.012; Mon, 11 May 2026
 10:34:01 +0000
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
Subject: Re: [PATCH v4 8/9] arm: dts: mt8189: Add ethernet support for Genio
 520/720 boards
Thread-Topic: [PATCH v4 8/9] arm: dts: mt8189: Add ethernet support for Genio
 520/720 boards
Thread-Index: AQHc1+B5OKy77P/g4E2DeUV376the7YIs44A
Date: Mon, 11 May 2026 10:34:00 +0000
Message-ID: <3732e96adefffc662840bb139329c21f7234e6c9.camel@mediatek.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
 <20260429-add-ethernet-support-for-genio-520-720-v4-8-be54e17239b7@baylibre.com>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-8-be54e17239b7@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7806:EE_|JH0PR03MB7342:EE_
x-ms-office365-filtering-correlation-id: 0798711b-3be0-49b1-584f-08deaf48d0fe
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|18002099003|22082099003|56012099003|3023799003;
x-microsoft-antispam-message-info: 7ebujZ6q0+nP1rDdl7nd80sVLHwhQeRmMrFcqRj3f4VnmBRqwHGWsc2a7nxjROHWDUlq7cIdsXFHtiU+Fe+x+N7ZwLT+N6y2C1pgxlr6hulu74TF+2Bx5Z4bO3Bhh14mNM81EHqQpklH/NP0ZoODm1K9q+tM70G4e328wK9dOAFG4Py+dGklouiJ6sQmyQMHIrbplZb1EKztp6MYs8ss/j2Irpn/yCwDlblddRiadg3GqWbXFV41msE/kFTjGPvh1MiguxHuYrjEGZ5TrNE88Y2vdzYT2zVyiwlIQNOREbpd1K1xq4g+Wn45bEWHcxTimBDkNeBpiqarug7NBz93/lSiz7fu3q2pvaRogE+zmgK+926w6eipnErc57L9cPqLUp8UwVIYJLZzZZiPZlC8qpAmBV+uD8ypSDsEbW6tcn1PGO4hLH5QPYa2ge4rO5ipqsWCw+Z+LL0u3p4MZB3u5EKtmyFZatOMogy88MpeGYuRKIWoFMgXcPeQvUCd7IN3XDzKNu+OmQTQZ89uWOWXRvz+y6sZ4KyK0W5qyJwz2BdGX1sxl/LA8h34zbJuOukT88LhYkRo3nPtBNK3Uw6fjIqqhwDWcVCcB5rR3zO/F8XuT48DJvfugQ2w3vWdE+izRuPek5iHlvLCE/RUfAlAWvJSxm1byf2qRkTN7cqVwsty7/jdhLJ4i/k/lt8iurtw/s+OstwxeCqHh171j3UDzDWDfg5IrvLnXjpXCRZJxnbUZNqiWu2pjD/uPks77K3W
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:JH0PR03MB7806.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlNkSUUxaFV6ME01N2ZBWGg2cmozZWNsejlwQmpwQnliSUUydDE5K0M1NTVo?=
 =?utf-8?B?bnlrbTlscCtYdjh0R2ZQaCtCbXdhVXJqS3B1UEt3ZFpBd1hzM1BjYjg5RTNI?=
 =?utf-8?B?a1FYWkdvdmJqY2FjdXp5OHp6b0F2YklvNnQ1VkxpeC9DM1RmdUdzQ2JyeDMw?=
 =?utf-8?B?a05uMG5lMHhtZVJBWkZzems0THk4N3llSVZIaTV6SFFOdXZCbDUxeHJ5bHcr?=
 =?utf-8?B?YlNXb2ltdXlZSUpoU2hPdmpTcUplZWV1Yy9rVWNtTFkvR0kwb1dhZ1BsUDhL?=
 =?utf-8?B?a0pkVnJOMWRYclN1OG1uM0pFV0ROTTl3STRNV1RIeVZ2V2FMV0hudXdHb21K?=
 =?utf-8?B?RVNpcDhzSUtxQUJYbHcwaHVBWjFXOGRheUJOODlqN1lSdkhGanRtcnFSSWVN?=
 =?utf-8?B?S2NzYUd0SFd5NENGUks5RVBrd1dFYStvZUh0WTNiN2tERGhuRzR4RVhPMDll?=
 =?utf-8?B?bGRDSnNMYjRkdEFrUGttSnBCNHVIc0tkbU5ScEFGWFd6RHYranc2YmlTY1kr?=
 =?utf-8?B?cFVkMThUbUQ2a2dwR0Rub3VtNEpubUZreEE0S0VUb1FIZDVJcmFMYVpkamFu?=
 =?utf-8?B?ZHNFZmo4bThYQnFZTzh1d0lPV3ZtV1lJL0w1K0pxSE9RQVFXWVhWQlJHdHdD?=
 =?utf-8?B?OTU0K1hneTJ3VExnT0FhRHVWc0w4RzVuSWVhbU5HU1FQbW1BOExUYndLOVdv?=
 =?utf-8?B?UWtjeHZBaGg2d21mQ3A2aHJmVWlEYkl2SDk0WmJtQ1M5YWtSdzQrU0FWZnha?=
 =?utf-8?B?WDhUc2g0bjRsNGIrcU5NcmdqYlo3TmtkVlIxY1J4cUp5R3A0ZXZRcU4yUEVV?=
 =?utf-8?B?YXozRGdkL2krN0w5WDJEc1hrOWc4NHRqZ2VWdGRtanA5TGY0NVRDZFlVWlFU?=
 =?utf-8?B?OWo0MjR2K2FXY2JSVWM3d0pZNWNuUGtpS2YrcVJLZlQyMVc0NXArbXlVZmN1?=
 =?utf-8?B?WTdzeTdRdUo5anJZMGgwSTkvaVhWaUtyUlNvMjBKeWlpMm5mSldOMHZnOEF1?=
 =?utf-8?B?Q0RPWGxKNzhjbkJjY0xWVGFLUTA5ZzJKTlA0ZFJhZHhEV1VsbFRBTVVXZW1R?=
 =?utf-8?B?MEF0Z21UTXFveTVXY05QdkQxSlllRWQ1VUxsaFU3akxmYng3SHdqQnZzaXoz?=
 =?utf-8?B?a2ljbHkxbW4vcTRVcWRGeUN0anRxaTM3a0s5M1ovQ2tIUEZIZ3Y1OXNTYTVV?=
 =?utf-8?B?QzVwOVkrZkVGaE1yazh4VjA1a3JGTHczNllQWEtOVmdXa3Uyd2ttRTBpVXli?=
 =?utf-8?B?cjhhaE80UG5qeGdLbCtMVVhuYnAxMGF1VmNHK0xhRHpRZFNOUnNFY0pkeEds?=
 =?utf-8?B?SlcrajZ0M2JKeGh1dFNqTWNHaWx6K0h1dnhLSzdDMXJ5cndpTUE0RzdJOTh3?=
 =?utf-8?B?aDh5SjV1eGxvcG5lRlZrcGpzQXpWZGxTN0NuVnM4U0h5TVltbkZONGZXYTZR?=
 =?utf-8?B?RU0yMUhUaHJCOFdXaUMwV3VLS2lxc0wrbEVHekVSNXhxU09PaWNjNWxrVDVu?=
 =?utf-8?B?SEw1UzIzTjA1ZUJ6K1E2UUhXMWg1NmZnVS9NUXcxcjN0NDVuTnVNNXlZQVRk?=
 =?utf-8?B?S01ZbVZodjZtbzBzb2VRSWplQU81RkRXQzBWWUx1NlZvM2p2bnlBOStkdjNk?=
 =?utf-8?B?UE9URWhDS042bDYyaXVCSmVNME1aQUllYzVZVVNRTVJRQ29yVGdmamRxaWJQ?=
 =?utf-8?B?SjE2U3kyYlFJTmxubHE2S1ZmRGxmUDZQK0ROQ0JyVHplLzI0bHhmNU1VWWRV?=
 =?utf-8?B?SXZ3OXJTTVhOQWRtOTRTMmxnQVZqd2pUa3FBcFE0MkExL1o5eEQ2MDRBQ2Ev?=
 =?utf-8?B?Smp3Umw0RXIvOWNoUE1DeVhSdlFCNGcvOWs5TFJFRkpyby9EK0FVRFg3TVBW?=
 =?utf-8?B?dlBHWndEeGZ6NDF4WitUMjBINDVZZlBVcUdUS1NJOXU0K0N3MHJTRDBVZ2hW?=
 =?utf-8?B?Yno3SHpXd0o1aVJBenJuMVNQampvZjRFMk9hMVhMYmFDR3NXY0V4eFFzYlkx?=
 =?utf-8?B?c1hHb1RXcVozTmxBVXlsZjVrbWMyT3ZONmFlNy9ZNnpmbEl4cGlxbERTTzRq?=
 =?utf-8?B?WXFuaEJQbDM5d1AvYkdtbUtxMTRUN0ZLYWQzSFQwMlU5NDIyWmN4aUR4cmxY?=
 =?utf-8?B?VEM4ZnpkdmFPT2hFRjhyRnBVdGFqeW54aHlBczZCam1YZ0d4bFpENSsrRkNs?=
 =?utf-8?B?L0FvOGZlWlpxMHBHVmJQMEtjemU2WTJodzJwb2FyREI0MXF1MXZ6Wm5ydGJt?=
 =?utf-8?B?TUZuSVJzZndrbTV0SjZCTXFGdEF5c0M0SEZFNzJzRUFLb2Flc0RwaE9aQm52?=
 =?utf-8?B?WWJFRzkyWW9jNmhtaG5WR2lRMXgzN3hwU0psdEFLQ1BjL2JGZTNTa1lQTEYy?=
 =?utf-8?Q?XqU4AOoibjiZOM0s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27389DF143732A4BB48049ED0DC9CE5C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lgXzf7XGY7iwSE+5XZ64GDcKCmw/dbJbNuiXGMDIys8FQ1gy8Y4hC75eT/znPheiFbhDbD2sLXxWACntpZCZpET376SoPx0fHBRDF1muJCH4X87QDzEyYwqVe/DA3BRBMHX6vDV0ZxRWIDNpZfCSRh+lGprbDIciMZSZz5rvQL1Zuitpbkm1GXn82hSdVofc8Ymo/2+bH5Prz1rhd3X0UPiLg8LDexy3k0Widwn3i63TtLOVwsN2Qh87Ngo/U3+VCCK32DqfGYSnu6clGf1+KvnyR8fPlh43kL9JsQJ64P/Wm6oVn6WX6Iznu4yDeYuddugTFzbkL1RFk3N/XhbRqA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7806.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0798711b-3be0-49b1-584f-08deaf48d0fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 10:34:01.0790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wfcm1OR7Kp9TkdktjMJpD/5BxsIONWec5KlEm+U8EI09TKV3PrsigtDpHcmYgy9WwWIG5GALnKnRtsAJWsxlhfUdVzi4F3FITf5AVw0wQVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7342
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
Cj4gQWRkIEV0aGVybmV0IHN1cHBvcnQgZm9yIE1lZGlhVGVrIE1UODE4OS1iYXNlZCBHZW5pbyA1
MjAgYW5kIEdlbmlvDQo+IDcyMA0KPiBkZXZlbG9wbWVudCBib2FyZHMuDQo+IA0KPiBUaGUgZXRo
ZXJuZXQgaW50ZXJmYWNlIGlzIGRpc2FibGVkIGJ5IGRlZmF1bHQgaW4gdGhlIFNvQyBkdHNpIGFu
ZA0KPiBlbmFibGVkIGluIHRoZSBib2FyZC1zcGVjaWZpYyBjb25maWd1cmF0aW9uIHdpdGggcHJv
cGVyIFBIWSBzZXR0aW5ncy4NCj4gDQo+IFRoZSBldGhlcm5ldCByZWxhdGVkIG5vZGVzIGFyZSBu
b3QgcGFydCBvZiBjdXJyZW50IGR0IHN1Ym1pc3Npb24gb24NCj4gdGhlDQo+IGtlcm5lbCBbMV0g
YW5kIGNvbWUgZnJvbSBkb3duc3RyZWFtIHUtYm9vdC4gV2hlbiBzd2l0Y2hpbmcgdG8NCj4gT0Zf
VVBTVFJFQU0gd2Ugc2hvdWxkIGFkZCB0aGVtIGJhY2suDQo+IA0KPiBbMV06DQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MTIwMy1hZGQtbWVkaWF0ZWstZ2VuaW8tNTIwLTcyMC1l
dmstdjEtMy1kZjc5NGIyYTMwYWVAY29sbGFib3JhLmNvbS8NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiDCoGFyY2gv
YXJtL2R0cy9tdDgxODkuZHRzacKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNzcNCj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqBhcmNoL2FybS9kdHMvbXQ4MzcxLWdl
bmlvLWNvbW1vbi5kdHNpIHwgODMNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDE2MCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vZHRzL210ODE4OS5kdHNpIGIvYXJjaC9hcm0vZHRzL210ODE4OS5kdHNp
DQo+IGluZGV4IGU1NTA3NDVhYzVkLi5kNGVlMjY4YTI5OCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cm0vZHRzL210ODE4OS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2R0cy9tdDgxODkuZHRzaQ0KPiBA
QCAtMzY0LDYgKzM2NCw4MyBAQA0KPiDCoAkJCSNyZXNldC1jZWxscyA9IDwxPjsNCj4gwqAJCX07
DQo+IMKgDQo+ICsJCWV0aDogZXRoZXJuZXRAMTEwMWEwMDAgew0KPiArCQkJY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxODktZ21hYyIsDQo+ICJzbnBzLGR3bWFjLTUuMTBhIjsNCj4gKwkJCXJl
ZyA9IDwwIDB4MTEwMWEwMDAgMCAweDQwMDA+Ow0KPiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDQ3NQ0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIIDA+Ow0KPiArCQkJaW50ZXJydXB0LW5hbWVzID0g
Im1hY2lycSI7DQo+ICsJCQljbG9jay1uYW1lcyA9ICJtYWNfbWFpbiIsDQo+ICsJCQkJwqDCoMKg
wqDCoCAicHRwX3JlZiI7DQo+ICsJCQljbG9ja3MgPSA8JnRvcGNrZ2VuX2Nsaw0KPiBDTEtfVE9Q
X0VUSF8yNTBNX1NFTD4sDQo+ICsJCQkJIDwmdG9wY2tnZW5fY2xrDQo+IENMS19UT1BfRVRIXzYy
UDRNX1BUUF9TRUw+Ow0KPiArCQkJYXNzaWduZWQtY2xvY2tzID0gPCZ0b3Bja2dlbl9jbGsNCj4g
Q0xLX1RPUF9FVEhfMjUwTV9TRUw+LA0KPiArCQkJCQnCoCA8JnRvcGNrZ2VuX2Nsaw0KPiBDTEtf
VE9QX0VUSF82MlA0TV9QVFBfU0VMPiwNCj4gKwkJCQkJwqAgPCZ0b3Bja2dlbl9jbGsNCj4gQ0xL
X1RPUF9FVEhfNTBNX1JNSUlfU0VMPjsNCj4gKwkJCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8
JnRvcGNrZ2VuX2Nsaw0KPiBDTEtfVE9QX0VUSFBMTF9EMj4sDQo+ICsJCQkJCQkgPCZ0b3Bja2dl
bl9jbGsNCj4gQ0xLX1RPUF9FVEhQTExfRDg+LA0KPiArCQkJCQkJIDwmdG9wY2tnZW5fY2xrDQo+
IENMS19UT1BfRVRIUExMX0QxMD47DQo+ICsJCQltZWRpYXRlayxwZXJpY2ZnID0gPCZwZXJpY2Zn
X2FvX2Nsaz47DQo+ICsJCQlzbnBzLGF4aS1jb25maWcgPSA8JnN0bW1hY19heGlfc2V0dXA+Ow0K
PiArCQkJc25wcyxtdGwtcngtY29uZmlnID0gPCZtdGxfcnhfc2V0dXA+Ow0KPiArCQkJc25wcyxt
dGwtdHgtY29uZmlnID0gPCZtdGxfdHhfc2V0dXA+Ow0KPiArCQkJc25wcyx0eHBibCA9IDwxNj47
DQo+ICsJCQlzbnBzLHJ4cGJsID0gPDE2PjsNCj4gKwkJCWNsay1jc3IgPSA8ND47DQo+ICsJCQlz
dGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArDQo+ICsJCQlzdG1tYWNfYXhpX3NldHVwOiBzdG1tYWMt
YXhpLWNvbmZpZyB7DQo+ICsJCQkJc25wcyx3ci1vc3ItbG10ID0gPDB4Nz47DQo+ICsJCQkJc25w
cyxyZC1vc3ItbG10ID0gPDB4Nz47DQo+ICsJCQkJc25wcyxibGVuID0gPDAgMCAwIDAgMTYgOCA0
PjsNCj4gKwkJCX07DQo+ICsNCj4gKwkJCW10bF9yeF9zZXR1cDogcngtcXVldWVzLWNvbmZpZyB7
DQo+ICsJCQkJc25wcyxyeC1xdWV1ZXMtdG8tdXNlID0gPDQ+Ow0KPiArCQkJCXNucHMscngtc2No
ZWQtc3A7DQo+ICsJCQkJcXVldWUwIHsNCj4gKwkJCQkJc25wcyxkY2ItYWxnb3JpdGhtOw0KPiAr
CQkJCQlzbnBzLG1hcC10by1kbWEtY2hhbm5lbCA9DQo+IDwweDA+Ow0KPiArCQkJCX07DQo+ICsJ
CQkJcXVldWUxIHsNCj4gKwkJCQkJc25wcyxkY2ItYWxnb3JpdGhtOw0KPiArCQkJCQlzbnBzLG1h
cC10by1kbWEtY2hhbm5lbCA9DQo+IDwweDA+Ow0KPiArCQkJCX07DQo+ICsJCQkJcXVldWUyIHsN
Cj4gKwkJCQkJc25wcyxkY2ItYWxnb3JpdGhtOw0KPiArCQkJCQlzbnBzLG1hcC10by1kbWEtY2hh
bm5lbCA9DQo+IDwweDA+Ow0KPiArCQkJCX07DQo+ICsJCQkJcXVldWUzIHsNCj4gKwkJCQkJc25w
cyxkY2ItYWxnb3JpdGhtOw0KPiArCQkJCQlzbnBzLG1hcC10by1kbWEtY2hhbm5lbCA9DQo+IDww
eDA+Ow0KPiArCQkJCX07DQo+ICsJCQl9Ow0KPiArDQo+ICsJCQltdGxfdHhfc2V0dXA6IHR4LXF1
ZXVlcy1jb25maWcgew0KPiArCQkJCXNucHMsdHgtcXVldWVzLXRvLXVzZSA9IDw0PjsNCj4gKwkJ
CQlzbnBzLHR4LXNjaGVkLXdycjsNCj4gKwkJCQlxdWV1ZTAgew0KPiArCQkJCQlzbnBzLHdlaWdo
dCA9IDwweDEwPjsNCj4gKwkJCQkJc25wcyxkY2ItYWxnb3JpdGhtOw0KPiArCQkJCQlzbnBzLHBy
aW9yaXR5ID0gPDB4MD47DQo+ICsJCQkJfTsNCj4gKwkJCQlxdWV1ZTEgew0KPiArCQkJCQlzbnBz
LHdlaWdodCA9IDwweDExPjsNCj4gKwkJCQkJc25wcyxkY2ItYWxnb3JpdGhtOw0KPiArCQkJCQlz
bnBzLHByaW9yaXR5ID0gPDB4MT47DQo+ICsJCQkJfTsNCj4gKwkJCQlxdWV1ZTIgew0KPiArCQkJ
CQlzbnBzLHdlaWdodCA9IDwweDEyPjsNCj4gKwkJCQkJc25wcyxkY2ItYWxnb3JpdGhtOw0KPiAr
CQkJCQlzbnBzLHByaW9yaXR5ID0gPDB4Mj47DQo+ICsJCQkJfTsNCj4gKwkJCQlxdWV1ZTMgew0K
PiArCQkJCQlzbnBzLHdlaWdodCA9IDwweDEzPjsNCj4gKwkJCQkJc25wcyxkY2ItYWxnb3JpdGht
Ow0KPiArCQkJCQlzbnBzLHByaW9yaXR5ID0gPDB4Mz47DQo+ICsJCQkJfTsNCj4gKwkJCX07DQo+
ICsJCX07DQo+ICsNCj4gwqAJCXRvcGNrZ2VuX2NsazogY2xvY2stY29udHJvbGxlckAxMDAwMDAw
MCB7DQo+IMKgCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODktdG9wY2tnZW4iLA0KPiAi
c3lzY29uIjsNCj4gwqAJCQlyZWcgPSA8MCAweDEwMDAwMDAwIDAgMHgxMDAwPjsNCj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL2R0cy9tdDgzNzEtZ2VuaW8tY29tbW9uLmR0c2kNCj4gYi9hcmNoL2Fy
bS9kdHMvbXQ4MzcxLWdlbmlvLWNvbW1vbi5kdHNpDQo+IGluZGV4IDA0NmU5ZDU3NzUyLi4xMzc2
YTRjMzc4YyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vZHRzL210ODM3MS1nZW5pby1jb21tb24u
ZHRzaQ0KPiArKysgYi9hcmNoL2FybS9kdHMvbXQ4MzcxLWdlbmlvLWNvbW1vbi5kdHNpDQo+IEBA
IC0yODEsNiArMjgxLDY4IEBADQo+IMKgCQkJYmlhcy1wdWxsLXVwOw0KPiDCoAkJfTsNCj4gwqAJ
fTsNCj4gKw0KPiArCWV0aF9kZWZhdWx0X3BpbnM6IGV0aC1kZWZhdWx0LXBpbnMgew0KPiArCQl0
eGQtcGlucyB7DQo+ICsJCQlwaW5tdXggPSA8UElOTVVYX0dQSU8xMTlfX0ZVTkNfR0JFX1RYRDM+
LA0KPiArCQkJCSA8UElOTVVYX0dQSU8xMjBfX0ZVTkNfR0JFX1RYRDI+LA0KPiArCQkJCSA8UElO
TVVYX0dQSU8xMjFfX0ZVTkNfR0JFX1RYRDE+LA0KPiArCQkJCSA8UElOTVVYX0dQSU8xMjJfX0ZV
TkNfR0JFX1RYRDA+Ow0KPiArCQkJZHJpdmUtc3RyZW5ndGggPSA8TVRLX0RSSVZFXzhtQT47DQo+
ICsJCX07DQo+ICsJCWNjLXBpbnMgew0KPiArCQkJcGlubXV4ID0gPFBJTk1VWF9HUElPMTI3X19G
VU5DX0dCRV9UWEM+LA0KPiArCQkJCSA8UElOTVVYX0dQSU8xMzBfX0ZVTkNfR0JFX1RYRU4+LA0K
PiArCQkJCSA8UElOTVVYX0dQSU8xMjlfX0ZVTkNfR0JFX1JYRFY+LA0KPiArCQkJCSA8UElOTVVY
X0dQSU8xMjhfX0ZVTkNfR0JFX1JYQz47DQo+ICsJCQlkcml2ZS1zdHJlbmd0aCA9IDxNVEtfRFJJ
VkVfOG1BPjsNCj4gKwkJfTsNCj4gKwkJcnhkLXBpbnMgew0KPiArCQkJcGlubXV4ID0gPFBJTk1V
WF9HUElPMTIzX19GVU5DX0dCRV9SWEQzPiwNCj4gKwkJCQkgPFBJTk1VWF9HUElPMTI0X19GVU5D
X0dCRV9SWEQyPiwNCj4gKwkJCQkgPFBJTk1VWF9HUElPMTI1X19GVU5DX0dCRV9SWEQxPiwNCj4g
KwkJCQkgPFBJTk1VWF9HUElPMTI2X19GVU5DX0dCRV9SWEQwPjsNCj4gKwkJCWRyaXZlLXN0cmVu
Z3RoID0gPE1US19EUklWRV84bUE+Ow0KPiArCQl9Ow0KPiArCQltZGlvLXBpbnMgew0KPiArCQkJ
cGlubXV4ID0gPFBJTk1VWF9HUElPMTMxX19GVU5DX0dCRV9NREM+LA0KPiArCQkJCSA8UElOTVVY
X0dQSU8xMzJfX0ZVTkNfR0JFX01ESU8+Ow0KPiArCQkJZHJpdmUtc3RyZW5ndGggPSA8TVRLX0RS
SVZFXzhtQT47DQo+ICsJCQlpbnB1dC1lbmFibGU7DQo+ICsJCX07DQo+ICsJCXBvd2VyLXBpbnMg
ew0KPiArCQkJcGlubXV4ID0gPFBJTk1VWF9HUElPMTMzX19GVU5DX0dQSU8xMzM+LA0KPiArCQkJ
CSA8UElOTVVYX0dQSU8xMzRfX0ZVTkNfR1BJTzEzND47DQo+ICsJCQlvdXRwdXQtaGlnaDsNCj4g
KwkJfTsNCj4gKwl9Ow0KPiArDQo+ICsJZXRoX3NsZWVwX3BpbnM6IGV0aC1zbGVlcC1waW5zIHsN
Cj4gKwkJdHhkLXBpbnMgew0KPiArCQkJcGlubXV4ID0gPFBJTk1VWF9HUElPMTE5X19GVU5DX0dQ
SU8xMTk+LA0KPiArCQkJCSA8UElOTVVYX0dQSU8xMjBfX0ZVTkNfR1BJTzEyMD4sDQo+ICsJCQkJ
IDxQSU5NVVhfR1BJTzEyMV9fRlVOQ19HUElPMTIxPiwNCj4gKwkJCQkgPFBJTk1VWF9HUElPMTIy
X19GVU5DX0dQSU8xMjI+Ow0KPiArCQl9Ow0KPiArCQljYy1waW5zIHsNCj4gKwkJCXBpbm11eCA9
IDxQSU5NVVhfR1BJTzEyN19fRlVOQ19HUElPMTI3PiwNCj4gKwkJCQkgPFBJTk1VWF9HUElPMTMw
X19GVU5DX0dQSU8xMzA+LA0KPiArCQkJCSA8UElOTVVYX0dQSU8xMjlfX0ZVTkNfR1BJTzEyOT4s
DQo+ICsJCQkJIDxQSU5NVVhfR1BJTzEyOF9fRlVOQ19HUElPMTI4PjsNCj4gKwkJfTsNCj4gKwkJ
cnhkLXBpbnMgew0KPiArCQkJcGlubXV4ID0gPFBJTk1VWF9HUElPMTIzX19GVU5DX0dQSU8xMjM+
LA0KPiArCQkJCSA8UElOTVVYX0dQSU8xMjRfX0ZVTkNfR1BJTzEyND4sDQo+ICsJCQkJIDxQSU5N
VVhfR1BJTzEyNV9fRlVOQ19HUElPMTI1PiwNCj4gKwkJCQkgPFBJTk1VWF9HUElPMTI2X19GVU5D
X0dQSU8xMjY+Ow0KPiArCQl9Ow0KPiArCQltZGlvLXBpbnMgew0KPiArCQkJcGlubXV4ID0gPFBJ
Tk1VWF9HUElPMTMxX19GVU5DX0dQSU8xMzE+LA0KPiArCQkJCSA8UElOTVVYX0dQSU8xMzJfX0ZV
TkNfR1BJTzEzMj47DQo+ICsJCQlpbnB1dC1kaXNhYmxlOw0KPiArCQkJYmlhcy1kaXNhYmxlOw0K
PiArCQl9Ow0KPiArCX07DQo+IMKgfTsNCj4gwqANCj4gwqAmcG1pYyB7DQo+IEBAIC0zMTEsMyAr
MzczLDI0IEBADQo+IMKgCXZidXMtc3VwcGx5ID0gPCZ1c2JfcDRfdmJ1cz47DQo+IMKgCXN0YXR1
cyA9ICJva2F5IjsNCj4gwqB9Ow0KPiArDQo+ICsmZXRoIHsNCj4gKwkvKg0KPiArCSAqIFRYIGNs
b2NrIGlzIHByb3ZpZGVkIGJ5IE1BQw0KPiArCSAqLw0KPiArCXBoeS1tb2RlID0gInJnbWlpLXJ4
aWQiOw0KPiArCXBoeS1oYW5kbGUgPSA8JnBoeT47DQo+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZh
dWx0IiwgInNsZWVwIjsNCj4gKwlwaW5jdHJsLTAgPSA8JmV0aF9kZWZhdWx0X3BpbnM+Ow0KPiAr
CXBpbmN0cmwtMSA9IDwmZXRoX3NsZWVwX3BpbnM+Ow0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4g
KwltZGlvIHsNCj4gKwkJY29tcGF0aWJsZSA9ICJzbnBzLGR3bWFjLW1kaW8iOw0KPiArCQkjYWRk
cmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJI3NpemUtY2VsbHMgPSA8MD47DQo+ICsJCXBoeTogcGh5
QDAgew0KPiArCQkJY29tcGF0aWJsZSA9ICJldGhlcm5ldC1waHktaWRjMGZmLjA0MjEiOw0KPiAr
CQkJcmVnID0gPDA+Ow0KPiArCQl9Ow0KPiArCX07DQo+ICt9Ow0KPiANCg0KUmV2aWV3ZWQtYnk6
IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQoNClRoYW5rcw0KTWFjcGF1
bCBMaW4NCg==
