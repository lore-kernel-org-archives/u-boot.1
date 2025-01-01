Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C43E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 11:40:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E03C8031D;
	Wed,  1 Jan 2025 12:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TxBHxUAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 172BE80379; Wed,  1 Jan 2025 12:40:38 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE0308021A
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 12:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljLr756TAuDYS83eAvrTQ0ci32Kb2wyixl7w/5w1aY1Tg6mvNQq8PzEKNH6S8KbrzYK59q2TPEZHrEmwdhO5qangyRVayesMfbRdq4SKQK2youNMYwFGLAQ3Jhxs2VtiEOrGFcnj0MlO5cyU40hv6GOLqiZjPQF/gWTlgO19Y8sd8Ia9ilYzUwCdi7Xl1zgOget7hpKMnchl8yPtB1goWZ5JIjH0W7XTN5MNykuaKDNADGKVD3j797unYb7f41jt6EIPX2mMQ3MSprZUvWn9TEeLfxRWaYFnPOMPDmWGNhMVDEBCmNAkThD7UbHwfzcHChxcpu6wYb+cYBuy4dVZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggDiMfbWfBLP6nV9p0LWCg7zAadAZXmjuujVaNueBxQ=;
 b=NqU4k69+4buamA2tAFoNV/bNOdi3UP2XqRC2faFtxVdkSq/j6jyY+ukVnd8v+754JIs2zFO90tFY4ynAF5BCIiscG1+hk3UC24aIwqYTFgSV1ePK93TOUKhMdpvkEiTP2s0AjVXjI3CT1GIpMeUDKj9RVjaB9CsUBlLQ2Oh4cM6HVgeyTzq4tUGdGxuytSMqSez7PQB9ZXeY16OCqjIRCFvjGNuOQHHzu2m4SIvErH9ifUCVD2skrxyPJTJMYyZPl/Rkp3e004IMIgR+Oega1JV1/S3/st1C+aIlodiLOnPUYOXlLH5pOo3DDSbCrv3Zi+D43WAoAJeAFjBZRgqsFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggDiMfbWfBLP6nV9p0LWCg7zAadAZXmjuujVaNueBxQ=;
 b=TxBHxUAF8wKQ7El9jXut1ffcRgz5fUnJjmoahZzL0+F/Fx82aRq5430IYiJlTUZVBe7goD7659QR5ireJXdd0pJbUUbNgUzlq9BIlyqxIWYHKjo3wcmsego/cfj+uVbc/fSR89SHXpxTEH+p+l/xZva9Yut+SzzWOzTSBKNMMWUTN4WNV7tWArj01ZL48zUlTcYXU/68cATzvNux3kl8dds+mbggqY+EyKeXv+CdMAls+uYbz69qoWVoUXAwrq5CIGM98dTmbpA5pV038Cgs2txySXnnEOI3sTZsO5sjEPOikb8/w/DhPF02oZ1VRjDNLApE4PSOekGmWiEWGhBo0g==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB9PR04MB9474.eurprd04.prod.outlook.com (2603:10a6:10:368::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 11:40:28 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Wed, 1 Jan 2025
 11:40:28 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, Simon Glass
 <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio
 Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "marex@denx.de" <marex@denx.de>, Alice Guo <alice.guo@nxp.com>, Ye Li
 <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYyIDE2LzE3XSBpbXg5NV9ldms6?=
 =?utf-8?Q?_add_i.MX95_19x19_EVK_board_basic_support?=
Thread-Topic: [EXT] Re: [PATCH v2 16/17] imx95_evk: add i.MX95 19x19 EVK board
 basic support
Thread-Index: AQHbUoq3EiCr5MsbS0ytjsh9g3+ir7L63NsAgATUM4CAAS/pAIAA5GUw
Date: Wed, 1 Jan 2025 11:40:28 +0000
Message-ID: <PAXPR04MB9644CB1C9572A0BE9B4EFD93E20B2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
 <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
 <CAJ+vNU16T8Chsdy0+tHy7tCcfKfVGVFUr9baTCH7U4X9v6dFRg@mail.gmail.com>
 <PAXPR04MB964402195A6BCEFE58D850BEE20A2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <CAJ+vNU16TYwegj3GkP+mLMj_cYUWgn3hkbsQF0wmS6Yb2VLn2w@mail.gmail.com>
In-Reply-To: <CAJ+vNU16TYwegj3GkP+mLMj_cYUWgn3hkbsQF0wmS6Yb2VLn2w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DB9PR04MB9474:EE_
x-ms-office365-filtering-correlation-id: 23d5f2d9-0ed0-4e91-290f-08dd2a591731
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MDR2OVllRy9Bd0ZJUWVxUnp3WlJQOHVnSVlpd2NLZ0krNzBQTWpROXJ4L2lK?=
 =?utf-8?B?UTFFK3dsMTFvMWd1Z1pEeG93VklKT3VrdVhza2loekxnV1lKdHNTNHJvOFA3?=
 =?utf-8?B?QkZRY3VseUpPc21OeS8wdlBUMEFFWm5Ob2VJdFYrcjE3QVhKMXNUY0ErM1Zr?=
 =?utf-8?B?YU9CVEViSXhRY3NoemppendPazJwRlZVZ1JzbGRtZktDdHVXVytTK0FqQmxi?=
 =?utf-8?B?b3N6ekVJUEl2Q0xNRUV1MGJBM3NIKzJyZjJYbGw5cUV1d2tiZjdyY1VTbzZ4?=
 =?utf-8?B?Qk5LTmVVN1pmN2xJMHBySGtOT2lIMDZiOGFTVS9ITko3czN6dWxGa2F4cDND?=
 =?utf-8?B?d3hKZFZnZWRTMXNVTXRkRUd3QmFyZTlLbHkwTGRWZzJxUU1pb081ZW8wZGxG?=
 =?utf-8?B?ZHF4TkFGY3ZGNzB3cjFYT1lqSlBhSTdGeUtUV1BvTG9DamhXdWgzaGhwOE96?=
 =?utf-8?B?SUVNYjBMRjhyS01mVC9WbzRENkFJQk4xTjFxTS8wdzFRWmRyai9JKzZFdjJK?=
 =?utf-8?B?c091ck1aNnJ0UVJhMmFkS3RYMzAzdXBxY3BTNU1CNmVxS2p0cUNIYXhPbGI1?=
 =?utf-8?B?Qk0remp0dUI4NmtSNDZRRHF5d3JhRFNBWWVtbmpuMklwVlNkd0NJQXU2Rk11?=
 =?utf-8?B?SlBGZVpWV3RlaWhjclpvS2xGNnVJQm5ERUllaWdqbnQ4RUJ6QnE5NytweUVW?=
 =?utf-8?B?QXowTGNRZ295N2J5STNmditVMk9WVmlxYVRvU1o3SWp2ZURqNVozQ1JoVVho?=
 =?utf-8?B?R3NKMGxzV2d5VEx1QXFlTGp5aWZNR1VIN2N4S3FVVDlMTXQwQmd3aFllRkx6?=
 =?utf-8?B?ZGZMWXcwVDBRbCtCaDNrM21QenFTck1xL1QrZXV2b0ptK0tna1Y1NFhQTVhs?=
 =?utf-8?B?NDFyb244dWFDa2t6R2tRRDFvQXBQalZMekxqZDJac0FyMWREQVZnemUrWkx4?=
 =?utf-8?B?bmhIL29lMyt6UXpQSVBLTWpDN1F2OW1tSXMrL1ZQbkRibi83M2VMODJ3Y0dy?=
 =?utf-8?B?WTRlOTNjZU9tMHpianZyZUhHZEdjYjhPNy9Ya0V1UDF0OXVxRmJiWHpxcHVB?=
 =?utf-8?B?VU5sOXJSNGQvbDU1RmdUajZZb21ZbFNYa0NUYnNoMXpqOUllaWU0MG8zL0x3?=
 =?utf-8?B?bTBnVTdPZjhJc1kwQVZ0L012bWFsZFlQU0hFS1FQTDBtSk92OUdMb05ocjBG?=
 =?utf-8?B?bERONXZXZjB4ZlNtVitOQkxHVWx4ZVRnSVl2bXpaaTIvQWxIN3U0a0hqWlNU?=
 =?utf-8?B?SzlROVFqUmZLV1VrbURJOTJoZXN2ZGRUYVArV0ZnOE5UUHlSdXpNQnNudVA1?=
 =?utf-8?B?bFNVbkJqZS9Nd3NZN0JnQkwwR1FCYVRCN3dqdkI4N3ljUkpxOFg5QVNzOFpB?=
 =?utf-8?B?bVp4Rkc0TTdlZGc0OTRSVjhYNGREdHVEZWFmY2Vhekw5SGJjMVZXa0wyL0hB?=
 =?utf-8?B?L3JkUFpqallSZ0V5aG9QZ2RWekZBU1Jaa3pSYjlCUDJGajloUTFESUhIZUpk?=
 =?utf-8?B?bEY3VEQyUTV1MmMzQzdDZ2VOTnVuY1JjK2dVM1k3SUU4UnhUM0NncmMrM3hK?=
 =?utf-8?B?em5NTlB5cW55dGZ0UmhtRkdQaXhQb2ZlYVY0RUIrTDZybUdrd2JDNzNRSEpq?=
 =?utf-8?B?aXZzRThaREJReGxmK2FmekFMdEsyOE83Szd3RlJ6QXpKbHlhVk9oSXUvU25q?=
 =?utf-8?B?VW0wbGZqdC95WkpleThIQjJwci95ZHdTOVlLZW96c0J6VENMRFhOdDRRK3M3?=
 =?utf-8?B?cjRERHZTc1dhc05ra09HMHpnYmFmL1hYTWFFeEMzK0xwWmNWSlJycy8vcFdv?=
 =?utf-8?B?SkdqaU1kSzhicm1kMU9qcWpnbkQ4THVUWitFeUJJbGU4VXV3ck1NbVR1S1hZ?=
 =?utf-8?B?YUExUzdiMHZWc013c1U4WXZNaFB2KzI0aDY4SWtKRmVQS1RJL3hrSGphaXdw?=
 =?utf-8?Q?vsQ5Y/e/NlYeMpnhxqtGi0kRxDBfqOBC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1pYOCtpdFJ5ZUw5WUI2TFhkbGdCUkxrSm1jbWhIYUJCbEkrK0dlaWpGYUFs?=
 =?utf-8?B?akM4UlpmWGpJVisyU1N5SHk2TU1mWlYzb2wvZ1g4MHJXT3VqVHk5eEoyalZ1?=
 =?utf-8?B?LzJ4VUtiMWJUK1FtekQyRGlmUHB6OEZuNE9qcFAvbThoL2JhMUJ6ejRjbVRZ?=
 =?utf-8?B?NzlhWlI1Y3FwVWRUMzhqZGxRZnNuWERic2lyajdBL2Rpc0xsdnlQSlhuamJR?=
 =?utf-8?B?OEFLTEdDWXgxMTZySjVWK3g0S3F1SFM0U1hvSnJjT1VwR0QzVzVIV2o4WVdi?=
 =?utf-8?B?VHQwc2NwOEpVekoxNGl4Vjdua2c4bk5FYVN3QUJKTUtNTXFkR2JFNjRxbk80?=
 =?utf-8?B?QUloeTVCdG9vb1JIeHJsNHEvREQya2pCREhCdkpXWHlSTEdNcXBaV3JyeS8z?=
 =?utf-8?B?cWUvSVRCVWRLMzhnZXF5OEtjWHpCTE9ZenVtQnZndlg2Z2tGRUczOHNXNjdP?=
 =?utf-8?B?SjNCN1N4QzVpYUxzY2xXSkZNN2g2ZE1wNHdHNUdEdHEvNmlwQUtxOUVmcXk1?=
 =?utf-8?B?aFFmM3dqSUVQcTlhTFMrd0x3amE0TGtiODNUNStKa0pFYUdMdWM4aG1oTVNs?=
 =?utf-8?B?a2hHNUVEN0pZVmNiRXcvMGRGQzlzRlJaaCtxL1NnOG85SG5hcWxRVlpXNDk4?=
 =?utf-8?B?V1Z2blArWURhK2dKcmpOR3ZPVzdneXhOY0tDQ1FISWw1OWpKUm1KQVFGYktl?=
 =?utf-8?B?VldQUVpvK1M3aUMyRUh1Q0dxL1VoOWs5bkZaS1owUWtEVHo3c3h3cWlQenox?=
 =?utf-8?B?Z1ZEUElBdzlwWk54OFdWNFNBWkJnb3hYTDUyaTJlcnBTY1M0OTZvYWJRRUJq?=
 =?utf-8?B?UUtndTNia3d3Q2dXbC9SMVQ3bkE2TERIaTdNWU9YOWhNREZua0tZckhwY2JR?=
 =?utf-8?B?eklFZlF3ZXR2aTNOVmZSbVdrSU02bm8zSW9VZ2YrL3JPOHJSUEhYNWdCelRV?=
 =?utf-8?B?cW00dFk0RUJMbGVLY09kWEcwUHUxMGVlVzluS3FiSmlYL25nZVF4ZGR5Vkx3?=
 =?utf-8?B?UjQ1dTh0QlNIdEFHNDBydUJtVGpVMUZubU5YRHJ1RldpRjdlRExLQnRrdVJl?=
 =?utf-8?B?K3pZN2lRUEwzS21kRE50dVZyWDBuTnBpSWh4RWw3QnRyWE4yM0RubzlWajdO?=
 =?utf-8?B?byt2cVpGZzFneGVkTDAySU4vQkZpYVd5TXJlTGh0MU1vZE9vK2cvakdEY2E4?=
 =?utf-8?B?S1cvTGptUXpXOHg4ZURJTG5hbVZxZllFVlpDdWlkVVZDTzZtTHRsWXdvRW1H?=
 =?utf-8?B?a3FWL1lhV2s2cDcvUHJ5TUdvdkVtdTR1eVhDbjJkRjZSaksrTS9WUjI3N3VX?=
 =?utf-8?B?d2ZSNkJnMU9seXhxcXd2ZU5LdksxL09qbGM0STZ2VzhtS3kzeUJjdjJ3TWZH?=
 =?utf-8?B?bWhTcnpPeTNxT2pQR1ZZVXZrUThaakU4WUhaVkRIT1o3cWw2bldBUTVveFh1?=
 =?utf-8?B?c01QSFhQcFNJTDN1SHk0MjVCUmY5TWNMOCtRWkgyMHJ1ZUJlVFNqWkFKSkM1?=
 =?utf-8?B?MmVRVGJ6QXQra1U1S1ZLYWd5NENYMDNiTzJ5WU56SkZ1NWJrT2VSQXlHbEtP?=
 =?utf-8?B?U0VaTlBjKzNaTHBHRDBJUmpqY081TGVSZ1F0dmJ6U0JEZGdiVWZYUmdadXhG?=
 =?utf-8?B?Uk1Xb2hTdWRhcDdmM3U4enB6dVFaU0MraE9SYWlLd0p6Rkt6THZOQ2FsbStK?=
 =?utf-8?B?MWM1SURnazdKenBHUXFnbUJSSEFKcTFFTDBuMkxwNFAraFovYzErMWdkSFF3?=
 =?utf-8?B?NGk5ZFV1R24yOFMwLzVwN1h3T2NwMzk2d0dzZjRFb2IrZ1BYcDJpUjhHMHQw?=
 =?utf-8?B?Yk5FNkhYa3diTHcxZ1VPRHNMN0I0VklMNDlOZWR1WlFtbTNUOUNiQldkNHdT?=
 =?utf-8?B?STQ4N0ZhZWZaY3I3cHMwckZJajI4aSt4ejhtTG1FdHVmYkJNczM3eGltUHdS?=
 =?utf-8?B?M09tVXNCUk1xZ2VCclJ2ZVNuV0NBNHpMS1BORDZ5RnkvNDVkd21wRmluL3pi?=
 =?utf-8?B?S3FESU1Qam5jakEyWXlrUWhUcTFMU2luMTBFNXFuQW1vVGdIVEN5QThSczlq?=
 =?utf-8?B?Q0gvKys1bzRGV0w1ZGxaQjhxdk5Cci8ybmRjNlZValh4WHVTNWl1aWV4bHR6?=
 =?utf-8?Q?mj2k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d5f2d9-0ed0-4e91-290f-08dd2a591731
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2025 11:40:28.6015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p11ZG78rlYyET6M0sHNfX7/RPrt2g+FRQFnJ64utm8NvrpMGfHCUFybA85ODHcxzpg6Wgqq+qIuCTj5tzwUCmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9474
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogVGltIEhhcnZleSA8dGhhcnZl
eUBnYXRld29ya3MuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQx5pyIMeaXpSA0OjMyDQo+
IOaUtuS7tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+OyBTaW1v
biBHbGFzcw0KPiA8c2pnQGNocm9taXVtLm9yZz4NCj4g5oqE6YCBOiBUb20gUmluaSA8dHJpbmlA
a29uc3Vsa28uY29tPjsgU3RlZmFubyBCYWJpYyA8c2JhYmljQGRlbnguZGU+OyBGYWJpbw0KPiBF
c3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBkbC11Ym9vdC1pbXggPHVib290LWlteEBueHAu
Y29tPjsgTHVrYXN6DQo+IE1hamV3c2tpIDxsdWttYUBkZW54LmRlPjsgU2VhbiBBbmRlcnNvbiA8
c2VhbmdhMkBnbWFpbC5jb20+OyBBbHBlcg0KPiBOZWJpIFlhc2FrIDxhbHBlcm5lYml5YXNha0Bn
bWFpbC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZTsNCj4gbWFyZXhAZGVueC5kZTsgQWxpY2Ug
R3VvIDxhbGljZS5ndW9AbnhwLmNvbT47IFllIExpIDx5ZS5saUBueHAuY29tPjsNCj4gUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IOS4u+mimDogUmU6IFtFWFRdIFJlOiBbUEFUQ0ggdjIg
MTYvMTddIGlteDk1X2V2azogYWRkIGkuTVg5NSAxOXgxOSBFVksgYm9hcmQNCj4gYmFzaWMgc3Vw
cG9ydA0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRh
a2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdo
ZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydCB0aGlzDQo+
IGVtYWlsJyBidXR0b24NCj4gDQo+IA0KPiBPbiBNb24sIERlYyAzMCwgMjAyNCBhdCA2OjM04oCv
UE0gQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPiA+
DQo+ID4gPiDkuLvpopg6IFtFWFRdIFJlOiBbUEFUQ0ggdjIgMTYvMTddIGlteDk1X2V2azogYWRk
IGkuTVg5NSAxOXgxOSBFVksgYm9hcmQNCj4gPiA+IGJhc2ljIHN1cHBvcnQNCj4gPiA+ID4NCj4g
PiA+IEkgZ2F2ZSB0aGlzIHNlcmllcyBhIGdvIG9uIHRvcCBvZiA1Y2ZiZjhjMzY0IG9yaWdpbi9u
ZXh0IG9uIGFuIEVWSyBJDQo+ID4gPiBoYXZlIGhlcmUgYW5kIEkgc2F3IG5vIHUtYm9vdCBwcm9w
ZXIgb3V0cHV0IGFmdGVyIHRoZSBBVEYuDQo+ID4gPg0KPiA+ID4gSGVyZSBpcyB3aGF0IEkgc2F3
IG9uIFVBUlQyOg0KPiA+ID4gVS1Cb290IFNQTCAyMDI1LjAxLXJjNS0wMDM5My1nOWIyOTJmN2Qz
NDdmIChEZWMgMjcgMjAyNCAtIDE2OjEyOjIwDQo+ID4gPiAtMDgwMCkgRERSTUlYIGlzIHBvd2Vy
ZWQgVVAgTm9ybWFsIEJvb3QgVHJ5aW5nIHRvIGJvb3QgZnJvbSBNTUMyDQo+ID4gPiBQcmltYXJ5
IHNldCBzZWxlY3RlZCBMb2FkIGltYWdlIGZyb20gTU1DL1NEIDB4ZGVjMDANCj4gPiA+IE5PVElD
RTogIEJMMzE6IHYyLjEwLjAgIChyZWxlYXNlKTpsZi02LjYuNTItMi4yLjANCj4gPiA+IE5PVElD
RTogIEJMMzE6IEJ1aWx0IDogMTY6MDY6MTUsIERlYyAyNyAyMDI0DQo+ID4gPg0KPiA+ID4gVS1C
b290IFNQTCAyMDI1LjAxLXJjNS0wMDM5My1nOWIyOTJmN2QzNDdmIChEZWMgMjcgMjAyNCAtIDE2
OjEyOjIwDQo+ID4gPiAtMDgwMCkgRERSTUlYIGlzIHBvd2VyZWQgVVAgTm9ybWFsIEJvb3QgVHJ5
aW5nIHRvIGJvb3QgZnJvbSBNTUMyDQo+ID4gPiBQcmltYXJ5IHNldCBzZWxlY3RlZCBMb2FkIGlt
YWdlIGZyb20gTU1DL1NEIDB4ZGVjMDANCj4gPiA+IE5PVElDRTogIEJMMzE6IHYyLjEwLjAgIChy
ZWxlYXNlKTpsZi02LjYuNTItMi4yLjANCj4gPiA+IE5PVElDRTogIEJMMzE6IEJ1aWx0IDogMTY6
MDY6MTUsIERlYyAyNyAyMDI0IF5eXiBub3RoaW5nIGFmdGVyIHRoaXMNCj4gPiA+DQo+ID4gPiBB
bnkgdGhvdWdodHMgb24gd2hhdCBpcyB3cm9uZyBoZXJlPw0KPiA+ID4NCj4gPiA+IEJlc3QgUmVn
YXJkcywNCj4gPiA+DQo+ID4gPiBUaW0NCj4gPg0KPiA+IEhpIFRpbSwNCj4gPg0KPiA+IEkgdHJp
ZWQgaXQgb24gbXkgTVg5NSBhbmQgaXQgd29ya3Mgd2VsbCwgc28gSSBub3Qgc3VyZSB3aGF0IGNh
dXNlcyB0aGlzIGlzc3VlIG9uDQo+IHlvdXIgRVZLLg0KPiA+DQo+IA0KPiBIaSBBbGljZSwNCj4g
DQo+IEkgZGlzY292ZXJlZCB3aGF0IGhhcHBlbmVkLiBUaGUgZmlyc3QgbWFrZSBmb3IgdWJvb3Qg
cmVzdWx0ZWQgaW4gYSBiaW5tYW4NCj4gd2FybmluZyAod2hpY2ggc2hvdWxkIGJlIGEgZmFpbHVy
ZSBidXQgaXMgbm90IGZvciBzb21lIHJlYXNvbikgYW5kIHJlc3VsdHMgaW4gYW4NCj4gaW1hZ2Ug
dGhhdCBkb2Vzbid0IGNvbnRhaW4gdWJvb3QgcHJvcGVyOg0KPiBXQVJOSU5HICcuL3UtYm9vdC5i
aW4nIG5vdCBmb3VuZCwgcmVzdWx0aW5nIGJpbmFyeSBtYXkgYmUgbm90LWZ1bmN0aW9uYWwNCj4g
DQo+IFNpbW9uLCBkbyB5b3Uga25vdyB3aHkgdGhpcyB3YXJuaW5nIGRvZXNuJ3QgcmVzdWx0IGlu
IGEgbWFrZSBmYWlsdXJlPw0KPiANCj4gRG9pbmcgYSBzZWNvbmQgbWFrZSB3b3Jrcywgc28gSSB0
aGluayB0aGVyZSBpcyBsaWtlbHkgYSBiaW5tYW4gZGVwZW5kZW5jeSBpc3N1ZQ0KPiBnb2luZyBv
biBoZXJlLiBZb3UgY2FuIHJlLWNyZWF0ZSB0aGUgaXNzdWUgd2l0aCBhIGRpc3RjbGVhbiBhcyBz
aG93biBoZXJlOg0KPiANCg0KSSByZXByb2R1Y2VkIHRoaXMgaXNzdWUgd2l0aCBtYWtlIGRpc3Rj
bGVhbiwgYnV0IG5vdCBldmVyeSB0aW1lLiBJIG5lZWQgdGltZSB0byBjaGVjayBpdC4NCg0KQmVz
dCBSZWdhcmRzLA0KQWxpY2UgR3VvDQoNCg0K
