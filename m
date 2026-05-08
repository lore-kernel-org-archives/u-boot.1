Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFD1CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 04:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9365084C18;
	Fri,  8 May 2026 06:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=airoha.com header.i=@airoha.com header.b="AKpqeTNA";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DXy1vCc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 687D984B02; Fri,  8 May 2026 06:01:44 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B3684ADD
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 06:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=airoha.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kevin-kw.huang@airoha.com
X-UUID: 995b01304a9211f1a4e839cc21f16abe-20260508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=airoha.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=6tgI1qb/r/TsMvtD6Dup9lmz1Y9fzNRb190o0TNkNHw=; 
 b=AKpqeTNAuLEHMk+9OEI0LZ7q5vWtOt04AmUUA5jjjYced+mlrERvf1uN4fiKMidEtr+SltwGs80Vd0ZKopFtu/llllM1ES4c/mE1iWMjITFvvu7Cy6aUMrztC99suZJPeytDpCi5z/6atUASVNWp7eFUscYtU2+6gAZzyqy2uic=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:68654a90-b03d-415f-ab5e-ac2320320d14, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:f8e91e71-3b7f-4b26-b2f9-40f0deecb36d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898|915,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,Q
 S:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
 RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 995b01304a9211f1a4e839cc21f16abe-20260508
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <kevin-kw.huang@airoha.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 483071625; Fri, 08 May 2026 12:01:32 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 8 May 2026 12:01:31 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 8 May 2026 12:01:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H87TjqY19yGL4pgWy21UNHm/7d9aWAUFwUKTmcydQ86FlSCpk8PwtPEKUEBwLQz+wfKwKn/e+tmsDuc/9wEdvugqjh/tBBINwidWD3LJ23Ww/EnBzEG/KMvkxelRIGQkawM48Y0D+44vcrCvqGkwyBAgfm/vqyEEPK80/wdm2vF3//ABS9oEvRpIc7VmX3WBg4Wi/qGDtEf52IvKjep4aqntGHwh9HcN7nn8SP3LDbHsG50/UqJr+vWXrgFDMTQvho7+j2QdJq7+sqQdhO4L+/CvLmVwyXaZKdMTeeS66RmhEpoHdvS/HY3TfSM9ZQF9baLH4MGbJEOBsh0oWs5CAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tgI1qb/r/TsMvtD6Dup9lmz1Y9fzNRb190o0TNkNHw=;
 b=maqMM6QINcxD38WTvnBY0L0N5LZhzw1eXu2+Z1OLYmkBEMbUHlVXGesJ1mV4tpScEU5AYglC+P0XJcdYGV0gEsHWBrCicxApp2e0Gp/JtYkyXwyhNMEaXvLuoDzdn/k5BzqxmRYUwMExIlc0SnYYmXHqowvIyEU9jJ1NNvTIx/2y5GVXcHbHLe0qSgSAzBZaAfxLHV+x+UdhmnlQrE4rwpCAIE8ve2legUNpwF7BTn5+V49r8ZNbAyUYOD1hZ8+YHZwf8j5wAuJe2iHojPYH/EnN9m8faYE4iO8EYojSlfavxusfFHsEdnEZNSsmhx3yX7/ppTXetQn8l5n+59KrKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=airoha.com; dmarc=pass action=none header.from=airoha.com;
 dkim=pass header.d=airoha.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tgI1qb/r/TsMvtD6Dup9lmz1Y9fzNRb190o0TNkNHw=;
 b=DXy1vCc0HKM6ug6TZtBUUPP5lNLD0E9CyeEWO2p2IdnPOyegRQ4iZ4a65AoUtlKc8gAjdgacgDLboicgCx0NZfvXv3hw0TPB7t/mFiZXbhKX4cHmkvqrHX47oj8o8ogUOlVUPKDC7QydY1zvXrJaYCGqOTcE0CQsYFIEBpssDkg=
Received: from TYUPR03MB7230.apcprd03.prod.outlook.com (2603:1096:400:356::9)
 by SEYPR03MB8497.apcprd03.prod.outlook.com (2603:1096:101:20b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 04:01:25 +0000
Received: from TYUPR03MB7230.apcprd03.prod.outlook.com
 ([fe80::956f:cd8d:e75e:2995]) by TYUPR03MB7230.apcprd03.prod.outlook.com
 ([fe80::956f:cd8d:e75e:2995%6]) with mapi id 15.20.9891.015; Fri, 8 May 2026
 04:01:25 +0000
From: =?utf-8?B?S2V2aW4tS1cgSHVhbmcgKOm7g+alt+aWhyk=?=
 <kevin-kw.huang@airoha.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Julien Stephan
 <jstephan@baylibre.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, "Jerome
 Forissier" <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Robert Marko
 <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>, Yao Zi
 <me@ziyao.cc>, Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Lucien.Jheng
 <lucienzx159@gmail.com>, =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 =?utf-8?B?WWFucWluZyBXYW5nICjnjovnh5XmuIUp?= <ot_yanqing.wang@mediatek.com>,
 Beiyan Yun <root@infi.wang>, Ryder Lee <Ryder.Lee@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, David Lechner
 <dlechner@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, "Kory
 Maincent" <kory.maincent@bootlin.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, "Raymond
 Mao" <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, Stefan Roese
 <stefan.roese@mailbox.org>, Philip Molloy <philip.molloy@analog.com>,
 =?utf-8?B?RmFueWkgWmhhbmcgKOW8oOmAuOW4hik=?= <Fanyi.Zhang@mediatek.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Heiko Stuebner <heiko@sntech.de>, "Samuel
 Holland" <samuel.holland@sifive.com>, Christophe Roullier
 <christophe.roullier@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>, =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?=
 <Macpaul.Lin@mediatek.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
 <SkyLake.Huang@mediatek.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 =?utf-8?B?VG9tbXkgU2hpaCAo5pa95piT5bu3KQ==?= <tommy.shih@airoha.com>, "Peter
 Robinson" <pbrobinson@gmail.com>
Subject: RE: [PATCH v4 6/9] net: phy: Add airoha AN8801 ethernet phy driver
Thread-Topic: [PATCH v4 6/9] net: phy: Add airoha AN8801 ethernet phy driver
Thread-Index: AQHc1+B3Bh/iX8r0QkS9AQANgZ0xO7YCZwcAgAEl9QA=
Date: Fri, 8 May 2026 04:01:24 +0000
Message-ID: <TYUPR03MB72300B26EE2CA74F215859C0BC3D2@TYUPR03MB7230.apcprd03.prod.outlook.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
 <20260429-add-ethernet-support-for-genio-520-720-v4-6-be54e17239b7@baylibre.com>
 <a76f72ff-a520-4ff7-87e2-48454ddb4842@cherry.de>
In-Reply-To: <a76f72ff-a520-4ff7-87e2-48454ddb4842@cherry.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=airoha.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR03MB7230:EE_|SEYPR03MB8497:EE_
x-ms-office365-filtering-correlation-id: 447aee3c-9928-46fd-c7df-08deacb67923
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 3CMmy69YZroxf0VZbGNvPYA7mtdg67YCV9mhX3/Ywc/Ju8/Y8cT0uJ17PwQQHKs6jBLvQvWHTiCGZH/oWYIzi3NQws1UrpaIJnN3Ahk5CEvcwI/2cnf4VgeJg/uHIsyeJCtSisiplDFPEYiFr9nmr1ptp1+4LWSeFc2iTv6LA7zNca4FDTuZOnAsDTe1lG4QLYqkEwIHSbpmAcdV4AQCAc1CPugVNo6pKJfTxGh0p2oZbs25ohANF0kbaBNPFnIggIq2YFPGszD5U7Mn1ZgaTS4CeR3PIspUV5Yl3XcVJA05tL9nBueHO63vYFuONWpKQHCaK3vEKV0TF+we8xZGwi8o/+mEnovFfRuKNlNF0+F03rqmcsdZ7KKbpDmO5e6xR5mj0PpKJJrd4fmbC447shDi7sjA4Wurjr3mh60e2c805LEV8RpskeZe6OrbPMKz9qmOAXpzwSsoXYPGnNzmFNZBFo+j69i31GAfO6GFbYsNhiGRbMXzcNKYtsgH+kr0DTsY2juMdahdDfuMg3e+Ium85a7BBToo/maWCR87EPSfU0y3/5NFb3wE5Om2mJALl+dgRvoeAIG6OwcruHeQUuoVwBqHfEPKmdRNJqM5hqf/4KvOP+b/JEQBikQkxxniioA69OqPymLleD6wB2GrUfgClTUiC9V8rcBs5fU7woN0WHYkJ6qcaH8AiWm4rDGCiAKtEl0Ze6TjxB7Bg+eBLffuIkemRnlaV6t5c0Ok008uVPu6R1bj+DF1cIbRQ8d5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYUPR03MB7230.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFFLdEtDL0ZvOFMydU1jZUVPNCtndENJeURwZUg1SG0rYzlyN0RSRWVRdFAx?=
 =?utf-8?B?dFZ3MzhyUUYxbTUxeXg2MFArUHR3VzcrNUZJZU5PZzlFTTJHZGpYTDJEOFJX?=
 =?utf-8?B?ellrSk1oM2R3dDdUTFVjV0Z0RzNLK0pFN3duUG0wWmNsSEVRVXE5MEdpM29F?=
 =?utf-8?B?TU01ODJWSkE5Z3lmUEpPWXBWSGhmVEdCelVCbkZlNDQyWU5veEpjUUVBd3lP?=
 =?utf-8?B?bTB3Zm5ZSTFLWnV1RmFoMyt6cSs5N1ZtUXA0Qm45di9MYmorVDVCWlA0VnZ4?=
 =?utf-8?B?VVF0VUZFSThzczh0aEJuYUxmZzZLaVdWTmRRYWxnRTIxU1NHOWRyaUxXcXh0?=
 =?utf-8?B?a1hNYTB3K2tYenBjbVlzSGhuVmNUQnIzSlgvQTVYV3VvUjlMcG04VFV4UUc0?=
 =?utf-8?B?WHdseEprWThRa2hFTU52N1RTYW5udG8xMzRveHRLcGxXR1ZCWVF3bkRubzIz?=
 =?utf-8?B?TWdDM2FsVDhiRnpaQWppMTFBWWd1eEZCYythUCtQaHlLWmVDa3NaTFlWUG1W?=
 =?utf-8?B?SnVaNC9WTVdCZG9yazRnSHpLY2R5RkZMNkQyMlczL296NDhaTWMzeWFDbkZY?=
 =?utf-8?B?bFBuNSt1MkIwRGc0d3lsZzJoS05LaDRrdysrdG04UWdNMVVGMlJpL0w2VkRi?=
 =?utf-8?B?a1lpRC9PWlNCRDlZVWEvaXlQQmx6ell3VDJZdjFra2drdjZTYVhLNDNoaXoy?=
 =?utf-8?B?NDZSL0lLMGNrQ0lOZnl0RWpVK0d5QUpocXYwdXlISlBIWkNIWHdSVzFwTkJO?=
 =?utf-8?B?RkRQY0xQRVpaaTliWUg3MW1zM3Z4azlrcy9lazYzdjZvcDEyaTNBYXhQVm1i?=
 =?utf-8?B?cGxYemRFMVFjN1ZRa3Z0b21WaTNwb0ptL2psVzZJQmxPTHYzblIwU2l5R09z?=
 =?utf-8?B?cFdPMmJqSG56NkI2YUtnTUkzQ2UvOFdseXZJWUVyVHIrRXh3SWFxM3hXNmpY?=
 =?utf-8?B?REIxeDVNTUhtN3VTZGd3bml2S3U2N2lKRHlwcHBiWTg1QVNoSmhsaE5jRTk3?=
 =?utf-8?B?WGlTdlk2cTdOb2ZCVWJobk4wdXRxUGZtKytvL1QrWmE3aTNtU241VEFSL3B4?=
 =?utf-8?B?U00zRW5jZVV3M0VjN3ZKNUhvdDluSFFxS3plTmk5cURKQTcxTjgzckZtVmhh?=
 =?utf-8?B?dUZSMjExN21Ja2R0elp2VGFlVW5TTy8xVzYrY1hQTVdOcjlyZlR5NGREV3JF?=
 =?utf-8?B?a2FtVjBkamZJRFptR0xVTFBtTWYyNGNqQjlKOGcwVXJhLzBZZ3VPRXVCVVor?=
 =?utf-8?B?d2tlcHdGOTFxQWorbnJXbE1kZWRaanBGckgza1IvZGZsMStjL3NiTCtmNWNI?=
 =?utf-8?B?WUU2ZXJzbTFoMzJnVkt5Vzc2NlBpaXNvWUZnSkNHN2V6STlrWmVLWlZ5YUdo?=
 =?utf-8?B?UWVxbDVtZEdWUHVOd2IxcDFLcFQvNFlZWDlpRk9jSnBhUmpVdmhNYmxBbXQ4?=
 =?utf-8?B?ZVdpSVh0Mml6Q3NQanc1WGN2endGQmFwYmxlVGFUdjlTQWJKQ2V0czFjM3pn?=
 =?utf-8?B?cnN4N3EwOWZKeW02S0ZRMGxMQmtpNUVWOFJ5akFlSEdRYkJ6UVZoNVpsazBE?=
 =?utf-8?B?dGxqSE1MaTFJVlBIODA2UGcvNjhBd1IrS2FHSFNOUjVnOFcyMVVWc1l4MTdF?=
 =?utf-8?B?TVNKbVZUSERwRzJZdkJVbWp3VkNxT3U5c2lqKzNjMDRubnFXaTkyWGhqMEJx?=
 =?utf-8?B?dnNaTngvcEVzWk5ZR0xvbVA0bEdaTmlWRTB4WENPL1JFT2RzelFMRE8rTnFz?=
 =?utf-8?B?YUIxUCsraTJ6NEkvZ2s3dVNQSkpZZDFEbHZjOXB3TTh3bmdyNHVGeWNxZ0Jj?=
 =?utf-8?B?YWtBT2FlK1BucDdWSzBVSlp5V2Z6enIwK1NsblRwdzlsTGg5SytxeTVUaWdQ?=
 =?utf-8?B?d2ladDNZbVhmWVlLUWtydXlsSWxUbGlPT2ZZekhvb0VBLzFhb3ZEcy92NkdV?=
 =?utf-8?B?RDMxbjhQRXB5V1JiOUFCR1JoZFM2SXYwbHFsOTcxTGV6MjBweW5mU29jT2xP?=
 =?utf-8?B?YURrczMvV3dZV3QzSGNpN2JjN1hXZ3hoaGdSeC9QRjY4Nm90L1RPbk5KMnBI?=
 =?utf-8?B?UU1tMjlmN2RVdzNWMHoxWTVXS3E0N2s2SW5HYVZwaWlCUWY2UXlLQytBcWlm?=
 =?utf-8?B?Y0l4M212VFY0RHBLNitYdW1aWUhlQk4rWngybHhMQXFLNFB6RUt2cW9KYzlw?=
 =?utf-8?B?NCs1N0p5aCtoQVArUnlsS0I2bTVEd1Q2VDRheUdCclNBOUZGTERrWEJmYnBz?=
 =?utf-8?B?ZTQ5TFozclNXUDdrVXI0SjIvUUNoOVZBNGlPYm9UYUdZWDI3MW0ybVFwSFlp?=
 =?utf-8?B?eDRZWnF3SzJPem1DVWRqcnhqNXp2blR1dEJpMnVtY04rQ0M1K3ZzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GyQg5mVmllHKkQdDsCDIYCwwCuILZoyyI2NKFgqCOJBn8bYT6CdZTgpxlpeuBvbf7s0LNDG/BDkqx1dC4pM2fwVmIxw2IlUGaXEG1GmmWRAbyPb5zjWJYlN3zgXBJphTj2f6qltywj734tvvsOjAgOrKNdFKB36i3+xMpwWc1bynRcsEnQ4jVEhs/TwJx9Azmtb1OJcbtU7KO1LDD6RP94e1YsmtbetEmJgR8/mo5Xg2CxUrNTsso2tid4DmvUUXUtM/cNBnkb43JOZnmdr1c4H9cAMAxtNlb0IYz5BVH5gjQ/UoXcPh8m689z9APtV40MMRN7E4YYDkJ4/9JMe/lQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7230.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447aee3c-9928-46fd-c7df-08deacb67923
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 04:01:24.9504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSFHeAD4uF1jXlOA4YnLLNsLzAxajXzmXIwQa2FsQXvXVcQMNfS9mGzDWRJy4H3PXOcQCmZKpN2FXmzguOqNNuCXgzl0WRqF4/k8KYefmq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8497
X-Mailman-Approved-At: Fri, 08 May 2026 06:08:16 +0200
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

SGkgUXVlbnRpbiwNCg0KVGhhbmtzIGZvciB0aGUgbm90ZS4NCkkgaGF2ZSByZXZpZXdlZCB0aGUg
Y29udGVudCBhbmQgY29uZmlybSB0aGF0IEkgYWdyZWUgdG8gYXNzdW1lIG1haW50YWluZXJzaGlw
IG9mIGFsbCBmaWxlcyB1bmRlciBkcml2ZXJzL25ldC9waHkvYWlyb2hhLg0KDQpSZXZpZXdlZC1i
eTogS2V2aW4tS1cgSHVhbmcgPCBrZXZpbi1rdy5odWFuZ0BhaXJvaGEuY29tID4NCg0KQ2hlZXJz
LA0KS2V2aW4NCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBRdWVudGluIFNjaHVs
eiA8cXVlbnRpbi5zY2h1bHpAY2hlcnJ5LmRlPiANClNlbnQ6IFRodXJzZGF5LCBNYXkgNywgMjAy
NiA2OjIyIFBNDQpUbzogSnVsaWVuIFN0ZXBoYW4gPGpzdGVwaGFuQGJheWxpYnJlLmNvbT47IHUt
Ym9vdEBsaXN0cy5kZW54LmRlDQpDYzogR1NTX01US19VYm9vdF91cHN0cmVhbSA8R1NTX01US19V
Ym9vdF91cHN0cmVhbUBtZWRpYXRlay5jb20+OyBKZXJvbWUgRm9yaXNzaWVyIDxqZXJvbWUuZm9y
aXNzaWVyQGFybS5jb20+OyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsgQ2hyaXN0aWFu
IE1hcmFuZ2kgPGFuc3VlbHNtdGhAZ21haWwuY29tPjsgUm9iZXJ0IE1hcmtvIDxyb2JlcnQubWFy
a29Ac2FydHVyYS5ocj47IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPjsgWWFvIFppIDxt
ZUB6aXlhby5jYz47IE1pa2hhaWwgS3NoZXZldHNraXkgPG1pa2hhaWwua3NoZXZldHNraXlAaW9w
c3lzLmV1PjsgTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+OyBM
dWNpZW4uSmhlbmcgPGx1Y2llbnp4MTU5QGdtYWlsLmNvbT47IFdlaWppZSBHYW8gKOmrmOaDn+ad
sCkgPFdlaWppZS5HYW9AbWVkaWF0ZWsuY29tPjsgUm9tYWluIEdhbnRvaXMgPHJvbWFpbi5nYW50
b2lzQGJvb3RsaW4uY29tPjsgU2lkZGhhcnRoIFZhZGFwYWxsaSA8cy12YWRhcGFsbGlAdGkuY29t
PjsgWWFucWluZyBXYW5nICjnjovnh5XmuIUpIDxvdF95YW5xaW5nLndhbmdAbWVkaWF0ZWsuY29t
PjsgQmVpeWFuIFl1biA8cm9vdEBpbmZpLndhbmc+OyBSeWRlciBMZWUgPFJ5ZGVyLkxlZUBtZWRp
YXRlay5jb20+OyBDaHVuZmVuZyBZdW4gKOS6keaYpeWzsCkgPENodW5mZW5nLll1bkBtZWRpYXRl
ay5jb20+OyBJZ29yIEJlbHdvbiA8aWdvci5iZWx3b25AbWVudGFsbHlzYW5lbWFpbmxpbmVycy5v
cmc+OyBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+OyBOZWlsIEFybXN0cm9u
ZyA8bmVpbC5hcm1zdHJvbmdAbGluYXJvLm9yZz47IEtvcnkgTWFpbmNlbnQgPGtvcnkubWFpbmNl
bnRAYm9vdGxpbi5jb20+OyBJbGlhcyBBcGFsb2RpbWFzIDxpbGlhcy5hcGFsb2RpbWFzQGxpbmFy
by5vcmc+OyBLdWFuLVdlaSBDaGl1IDx2aXNpdG9yY2t3QGdtYWlsLmNvbT47IFJheW1vbmQgTWFv
IDxyYXltb25kLm1hb0ByaXNjc3Rhci5jb20+OyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47
IFN0ZWZhbiBSb2VzZSA8c3RlZmFuLnJvZXNlQG1haWxib3gub3JnPjsgUGhpbGlwIE1vbGxveSA8
cGhpbGlwLm1vbGxveUBhbmFsb2cuY29tPjsgRmFueWkgWmhhbmcgKOW8oOmAuOW4hikgPEZhbnlp
LlpoYW5nQG1lZGlhdGVrLmNvbT47IEpvbmFzIEthcmxtYW4gPGpvbmFzQGt3aWJvby5zZT47IEtl
dmVyIFlhbmcgPGtldmVyLnlhbmdAcm9jay1jaGlwcy5jb20+OyBNYXJlayBWYXN1dCA8bWFyZWsu
dmFzdXRAbWFpbGJveC5vcmc+OyBQYXRyaWNrIERlbGF1bmF5IDxwYXRyaWNrLmRlbGF1bmF5QGZv
c3Muc3QuY29tPjsgSGVpa28gU3R1ZWJuZXIgPGhlaWtvQHNudGVjaC5kZT47IFNhbXVlbCBIb2xs
YW5kIDxzYW11ZWwuaG9sbGFuZEBzaWZpdmUuY29tPjsgQ2hyaXN0b3BoZSBSb3VsbGllciA8Y2hy
aXN0b3BoZS5yb3VsbGllckBmb3NzLnN0LmNvbT47IFBhdHJpY2UgQ2hvdGFyZCA8cGF0cmljZS5j
aG90YXJkQGZvc3Muc3QuY29tPjsgQ2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKSA8Q2hyaXMtcWou
Q2hlbkBtZWRpYXRlay5jb20+OyBNYWNwYXVsIExpbiAo5p6X5pm65paMKSA8TWFjcGF1bC5MaW5A
bWVkaWF0ZWsuY29tPjsgU2FtIFByb3RzZW5rbyA8c2VtZW4ucHJvdHNlbmtvQGxpbmFyby5vcmc+
OyBNaWNoYWVsIFRyaW1hcmNoaSA8bWljaGFlbEBhbWFydWxhc29sdXRpb25zLmNvbT47IFNreUxh
a2UgSHVhbmcgKOm7g+WVn+a+pCkgPFNreUxha2UuSHVhbmdAbWVkaWF0ZWsuY29tPjsgTGVvIFl1
LUNoaSBMaWFuZyA8eWNsaWFuZ0BhbmRlc3RlY2guY29tPjsgVG9tbXkgU2hpaCAo5pa95piT5bu3
KSA8dG9tbXkuc2hpaEBhaXJvaGEuY29tPjsgS2V2aW4tS1cgSHVhbmcgKOm7g+alt+aWhykgPGtl
dmluLWt3Lmh1YW5nQGFpcm9oYS5jb20+OyBQZXRlciBSb2JpbnNvbiA8cGJyb2JpbnNvbkBnbWFp
bC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHY0IDYvOV0gbmV0OiBwaHk6IEFkZCBhaXJvaGEg
QU44ODAxIGV0aGVybmV0IHBoeSBkcml2ZXINCg0KDQpFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJp
ZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KDQoNCkhpIEp1bGllbiwNCg0KT24gNC8y
OS8yNiAzOjU4IFBNLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToNCj4gQWRkIEFpcm9oYSBBTjg4MDEg
RXRoZXJuZXQgUEhZIGRyaXZlciAoYWlyX2FuODgwMS5jKS4NCj4gSW1wbGVtZW50IENMMjIvQ0w0
NSBNRElPIGFjY2VzcywgTEVEIGNvbnRyb2wsIGFuZCBSR01JSSBkZWxheSANCj4gY29uZmlndXJh
dGlvbi4gUHJvdmlkZSBwcm9iZSwgaW5pdGlhbGl6YXRpb24sIExFRCBzZXR1cCwgYW5kIHN0YXR1
cyANCj4gaGFuZGxpbmcuIEV4cG9zZSBEVFMgcHJvcGVydGllcyBmb3IgY2xvY2sgZGVsYXlzLiBS
ZWdpc3RlciBkcml2ZXIgd2l0aCANCj4gUEhZIGZyYW1ld29yayBhbmQgdHJpZ2dlciBvbiBzdGFy
dHVwLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5xaW5nIFdhbmcgPG90X3lhbnFpbmcud2FuZ0Bt
ZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBi
YXlsaWJyZS5jb20+DQo+IC0tLQ0KPiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAxICsNCj4gICBkcml2ZXJzL25ldC9waHkvYWlyb2hhL0tjb25maWcgICAgICB8ICAg
NyArDQo+ICAgZHJpdmVycy9uZXQvcGh5L2Fpcm9oYS9NYWtlZmlsZSAgICAgfCAgIDEgKw0KPiAg
IGRyaXZlcnMvbmV0L3BoeS9haXJvaGEvYWlyX2FuODgwMS5jIHwgNTk0ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgNjAzIGluc2VydGlv
bnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMgaW5kZXgg
NzM1ZWNjMzYyMTAuLjE2NTk5NGNkNzJmIA0KPiAxMDA2NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMN
Cj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTYwLDYgKzYwLDcgQEAgRjogIGxpYi9hY3BpLw0K
Pg0KPiAgIEFJUk9IQSBQSFkNCj4gICBNOiAgVG9tbXkgU2hpaCA8dG9tbXkuc2hpaEBhaXJvaGEu
Y29tPg0KPiArTTogICBLZXZpbi1LVyBIdWFuZyA8a2V2aW4ta3cuaHVhbmdAYWlyb2hhLmNvbT4N
Cg0KV2UgbmVlZCBLZXZpbi1LVyBIdWFuZyB0byBwdWJsaWNseSBnaXZlIHRoZWlyIGFja25vd2xl
ZGdtZW50IHRoZXkgd2FudCB0byBhc3N1bWUgbWFpbnRhaW5lcnNoaXAuDQoNCkBLZXZpbi1LVyBI
dWFuZywgY2FuIHlvdSByZXBseSBoZXJlIHdpdGggeW91ciBSZXZpZXdlZC1ieSBmb3IgZXhhbXBs
ZSB0byBzaG93IHlvdSBhZ3JlZSB3aXRoIGFzc3VtaW5nIG1haW50YWluZXJzaGlwIG9mIGFsbCBm
aWxlcyB1bmRlciBkcml2ZXJzL25ldC9waHkvYWlyb2hhPw0KDQpDaGVlcnMsDQpRdWVudGluDQo=
