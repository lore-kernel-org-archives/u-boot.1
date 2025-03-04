Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910C4C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 09:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF4148121A;
	Tue,  4 Mar 2025 10:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kcyFc10V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6FE281253; Tue,  4 Mar 2025 10:04:51 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF4F810ED
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 10:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1APZT7ogoLcni2kWLzjZSHXFXmA8N1JGG9h0w4i3/99ELk4NmlZ02ExAlwWxjfcAXW0yv331SY9FReGXXwsC7pBwvYNcKbeWG+WaA5E/Xa9ds7KNIaMvfFGkB5r/ddsN5pmVThqF9MeZbYmKNxxQ8CHNlRbiu4Z2XX+LXjkV7NujIibnsFk1OOGWObvK+ngFZ+OxRSWUdQ7Ho7B5TFsTl32fNGVRpuQ/W8UwHelNDMhcSXCdS9CDYupk0OZL45ZJHRs55Uh6OmeOJ783nnBU0eM7XjwCRMJUYQ9G/q/H93s5/nogMg0ga4uK+HOBdY9hFGnoGEIGY9ekPTKOrP6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MIK5QnU9rg4xWREPjdKGLPWMM29mjC68cOpkK5rjgM=;
 b=Ow/63jrFxHpC5sM6n3vqSVlbRBH6va0XmH7Ju3BLWxNygzNEbxvhM2U7Krs5TdyHZspTfy3ItTAUwMuL2VqQqvJoqWa5YbXqCfvtOFWeV5lYYqNdrcj1ErzZd3yhg6mG3uzFYilaHSiCw5vecQF/8GWFQGVKNDoNPpeFirXZav6v/+EH6kVONork2ThzxnMPNXCcUpLJXlaBpSpOG8w2rda3o51VpZWSiRUVcGtn5WzptTkc0ke9e1Jmo+Wqw+yQNuApRROjTUGXb5JiLWuHQ8p79N+XSMN58rAy46magISuX5dcbSPfZAPQ0IC0pFoJD06agUsJWFgR5n3mQVAUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MIK5QnU9rg4xWREPjdKGLPWMM29mjC68cOpkK5rjgM=;
 b=kcyFc10VHPE1INA023GMzbEbVVdSsEc4DN+i3ZTvKfJzUHVP2CtYS7xhXOcEbbOzkJURDtDr5WdM4oxhpZmfgZipyPuu7WUARLqvBxSWeYsCRnQAA5+AysmVDAqy9tu9OrqkD6s03VY87C6au7FI5+E4b4RA5f6CwSVImpPJ1tmb2dPlWpBnuH23lX+dSSn6ducAiukq57j450xe58LP6JOfHjhKOb2x7KS9xNPxhh5p/NKW0Fq01e4aSLS1iBGhT3Q4BEKg2opeUq0i0ghqWHsK4VcMIF1ZU1B4G0UZG0lUYnhK+m1xTHoEYgR8OIckSgbp9ngUeXweGGFrJDZwoA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GVXPR04MB9949.eurprd04.prod.outlook.com (2603:10a6:150:112::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 09:04:45 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Tue, 4 Mar 2025
 09:04:45 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtFWFRdIFJlOiBbUEFUQ0ggdjQgMTAvMjBdIHNj?=
 =?utf-8?B?bWlfcHJvdG9jb2xzOiB1cGRhdGUgc3RydWN0IHNjbWlfYmFzZV9kaXNjb3Zl?=
 =?utf-8?B?cl9saXN0X3Byb3RvY29sc19vdXQ=?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHY0IDEwLzIwXSBzY21pX3Byb3Rv?=
 =?utf-8?B?Y29sczogdXBkYXRlIHN0cnVjdCBzY21pX2Jhc2VfZGlzY292ZXJfbGlzdF9w?=
 =?utf-8?Q?rotocols=5Fout?=
Thread-Index: AQHbZ1GM+79Tro6rhEmci0D0VedmurMmDJ+AgDtvWdCAAKhcgIAA1Syg
Date: Tue, 4 Mar 2025 09:04:45 +0000
Message-ID: <PAXPR04MB96448B41A9DFD9898EEE1914E2C82@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-10-93b28a514dea@oss.nxp.com>
 <05ef8aa9-fc2c-44c4-905d-13cf81b35d9b@denx.de>
 <PAXPR04MB9644E421817CBBA159C9907BE2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <d140bd3b-d0d5-4e1b-b4db-f029f102a5d7@denx.de>
In-Reply-To: <d140bd3b-d0d5-4e1b-b4db-f029f102a5d7@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GVXPR04MB9949:EE_
x-ms-office365-filtering-correlation-id: 783d6ca9-e5a2-4d1a-6a42-08dd5afb9bbe
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dy9HUTJhTHpTQ3paVk5wSnNIcytwaXByV0x1eXZEVlZJN2xVeXZEUlZ5ZndF?=
 =?utf-8?B?YStSYndlMEZ2UmNsYnU2RGpjV0ZmbWNBQXNTSVpnZkdJcWpkR21NeUF1RENM?=
 =?utf-8?B?TTdXQWtQREswMUl5czNXblVtL0VjelRpKzBLRVpCYThtTkxkemg0M0RnZXZ1?=
 =?utf-8?B?QnlTSXM5dnpOdUxlc2tZWStQN204SXZodEQ3Rm5OK2JqcXd1aXVuNUVqREth?=
 =?utf-8?B?U0VQNy9YbnNwbWZHODFTYW5pMDNHcnB5ZHBZdjFGT2pHeFdCdHhDVlhzaGdW?=
 =?utf-8?B?VEJURTdsVkl3NHBWSnNTZFJ6RlUyR2hxSk9NdzBCUE5VYUtVc2c4Slp2aWlx?=
 =?utf-8?B?clkxWXlBaFhNeXliSWR4b29EeURSakZNeGt2VlpZWlgxOW9SUDdYNEVseEgz?=
 =?utf-8?B?NmZJYnU0TzFvbTNwMGd4UXRSRUZoOXpkV2R3Z1c2ZU5XaTRPdXdhbDdhTG1h?=
 =?utf-8?B?YmFqTysrV0p4T0lZRTBxU0VUZlpwVXRiWjRrWGU4ejdyUjMvbnJFZk9uVnNy?=
 =?utf-8?B?OWh5UWJ2eE1KNmxhSVZkYmxycjlaQXQyZXhHaWwxV3ZOd2V5eXVnbE1nWTNR?=
 =?utf-8?B?eEpvT0R0RXdTK3Z0YVJveVJSS3hSRmFablJaZjJCM3U0aFZ6UUZEVlhTTFk5?=
 =?utf-8?B?bnJLUjRzaHhsMUMySmpNZFYxZjZvd1NYaGozdGQ4QnhnZkFra0syVU50Sk9C?=
 =?utf-8?B?WEE1b1BxaDZnR0lUM2txbXdBeDc1RGlURlpmYnk5NTk0b0toclZ4VVBXQkcw?=
 =?utf-8?B?ZGlEcVRIUFl6N2I2UG9sbzhNV2Z0OWRqcFZzVVhNM3A5OHZJZllPYTVRdU5P?=
 =?utf-8?B?L0IyRXZsZEVMZlhTMWR2aG5SZGYxSkxocUxnTk1nYzMvbU8wdEJZaWNwYlFL?=
 =?utf-8?B?NmVXL3BpNmhXc3k4ZktqaTRRNHdweS9MZjlTZEVtSG5rNE1tbURheG1OM2li?=
 =?utf-8?B?UHlCeFdlYkVyUWpqckFXKzg1ZGpZSGVhbXZqSHF4Qm5tTVcrSjU2RGpTY0xM?=
 =?utf-8?B?alFUcExrSFYweXRMdDl1SEtGOHlnT0lqcWpvZUVFaFdyVEF4eGhXeVpudTJV?=
 =?utf-8?B?cHo4YzFDYzFhb0l1VG1sV01FTWlUZHdzbmMzTEhuM3R3TUF6cUlSWWNCbDQ0?=
 =?utf-8?B?cmJicnNQeWo0ZTcvTnZGUUdveE5Nb2hVdWVPeEtnR0t0WDd6MmdYNHFCdjFN?=
 =?utf-8?B?QkV1cGNkVUoxNjI4YXgvSXhzWGZtNTRQdjNpNkJMUlFHVE1Qb1gxM0FsaXRq?=
 =?utf-8?B?aU11VEVOL1BIZFJPZ1RFWXZBWEhVV1k4dUtOMXI4OWgxdEFKM0ZYdXhqY2Vz?=
 =?utf-8?B?OUZQSzIzRFV1aGczOXJwaGlkcC9VeEtId01FL2JTRm9PS3czWGJjc1QraFE3?=
 =?utf-8?B?MWNGNXI2cDFiV0ZRa0QyVTVueUFwS2VWbm5zV0FuOUxoak0rQ1lBS0tkRTk0?=
 =?utf-8?B?TmhqNkdzZVZYOWlFOTF6SjIyOGNjaW02NHc4Skpkc21TL1JkNGtIMmJNTEVK?=
 =?utf-8?B?bVdjUFI4VmxtNHRlUWl5VFpYV24yTDNwMkRLcm96K1hWdXJXbGVEeUpNTkJq?=
 =?utf-8?B?am81VzQ0VWdpS0lLM2ptL2NndTFqTzZ6THB6dzVYcjNBalN5eC85NjVNVmpC?=
 =?utf-8?B?eU5ITFRWWUxDcGJzQjRMZG1jSFBaR2JIbEVvQmpJTHQ4bjgvS1RUdlNzanBI?=
 =?utf-8?B?Ry90ckFKSW5rY05ST3R2clNGVW9OYklMamNLSmJYbjlBR2EzOUgwclcrbTJt?=
 =?utf-8?B?ZFVpU3BNQ3pQV0ZMMUNMc0Rucjg2VDJaN2RZYUdQd2w5MXUwR3diU0tQWFpJ?=
 =?utf-8?B?MlVKZTdQNGptMTN1cEVxY0I4UjZLb25qNURHRUduNVVCdXZKUkxLOHBCV3Bk?=
 =?utf-8?B?T3hYaERKOWRJMVRBdE5BZExQMmphWFJCUzBBWWd1Q0JGYWpWSG1qZEoxSm4z?=
 =?utf-8?B?K3Blenp5VjNwWHNNV1Y3bTluOWxsd3M4Q0VIQW1ERk02M1A2OVZob1NaQ2Zh?=
 =?utf-8?B?R3orWmhvbXJnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STB1Q0t0VGVPTWNVeVBYR2VLdDFadkdHclBTZlo5MllJUXVBdEw5VkptRXJ2?=
 =?utf-8?B?OVZnUU9vLzRzOThUTVhWZFNsSi92Y28veGpSOWxrQWE1UWJIbGcrUE5DT28x?=
 =?utf-8?B?dUtUU1pLWWU0S1FBWjk5UHJhaFJTdUVNOWorSzY1Z3RZdzJGOVpZREkxVHFG?=
 =?utf-8?B?VVVnanRjdnAyck9IVHVXMDNWTkppdFJONWZiUDVIM1Y5RDdROVZSa1hVbjhp?=
 =?utf-8?B?ZlNHSXAyUExvWnpoOTN0eXlOeWtCU1pVQzR3NVFVaDhidWc2SUI5enZicW1R?=
 =?utf-8?B?MWo4UmQ5c1BTekJWUnVCdzMyN0dGUE5uWExEbkxjRjB2SWxmdjNkWEdMZFhT?=
 =?utf-8?B?c2hIanh2TGVRZkZ3MnFrWUU5cTk4WkxYaGM1V2NHUDMrZ2pDTmFMRjBFVnNl?=
 =?utf-8?B?MUdvMlpQT25OQStMN3Awd3ZDNmtHSjY5bzhhSVJUKy8wbWpucllaVzJ6cCt1?=
 =?utf-8?B?c3lnQVZjdkhtNlBRWFNxZFF6Q3YvUEE4Q2lBQVIyajV0SkFxV013Wm9DbFE4?=
 =?utf-8?B?ZGZ5NTMxTTAwZGhIOFcvNndvTkZJYjE3SHM4WklEK3lYV0NYS3Arc2VITnZE?=
 =?utf-8?B?Rit6RzhuSmVqN01CRGwrNnFXRktScm1HSko1T0VLU0oyc2ZsaDQ1YVd5MVlu?=
 =?utf-8?B?U3dDd3BKVlFZUG1TWXVWTjc2YTRlQnJxOGtMYnNvUDJqVDBSRmFSNEVWRXBH?=
 =?utf-8?B?QitJb0JTVU13c0dqOFI2NGtCYjR0dDRPN04zbFhYK3lOanFUa0JFNmZ6WU9B?=
 =?utf-8?B?aFUzTHJIYlFmUm5jQWR6R0R6SUtKMTAvem5OeVRydm5QcXJ1Y3RKa3M3WXho?=
 =?utf-8?B?VmVyWjVEMFYzb0dqSWl4eWlHTEI3dVJJRHVZUk1YZExSaXI5SDNiRnhWVHo1?=
 =?utf-8?B?U1c5czZzZEZHL0h2OG0rVHhHOWNEbW1VY1FEZWVYcmtwZjF1Y1p6UU5qWVRQ?=
 =?utf-8?B?QlpNTDRTOEY3eG12a3F0bEo4RGxoeFZzTHgvek4zWGFVdk5LcHQ5eVJJVTBW?=
 =?utf-8?B?ZXlSSjFUdWxJdzRHWWtnVDliZnlaeE9rYXpQRUVIc04zeDBTbTF6d05nelpt?=
 =?utf-8?B?TENWUDZiSWNQWEpWZ0RUVndKTTRjb2tiVlFtT3lGaDNsK0FkSFFwaVNsTEN6?=
 =?utf-8?B?dEhjdlU2SkpRcGluSlQxb1hFNnlnUmtkRkxqTms0dXF1TUhUWUR2MzBoZkIx?=
 =?utf-8?B?bWQzdjB6MHhCMVV2MEFHQldrdVdYdnFqNDZLRjdtVC9jZFBVWWxILzdzN2VE?=
 =?utf-8?B?SjNoMlN1UzFaR1hudXhhU0hqSFVvZGx0Q3dTVnhXbytEbmxJWGQ3ajJqbi9O?=
 =?utf-8?B?WlIyWis1Z0dwQmcxL3BLNnN6TmN6aU10eFpJUEpoQ1JIcytnUC94alYrbjZs?=
 =?utf-8?B?Y2hrSEZocGdlOU5hZjJoSzB2MEZnYnV0Ym9Xcy84bzQwM1BFdHN0a3hsbDdR?=
 =?utf-8?B?UGxPWCt1ci95cVhlRFNTMksxK083RXZ0dXQva2dzcDhMK1owNlZNQWNJY1Vp?=
 =?utf-8?B?OUNhNVRhTmFFdmM4dE5lNENYVDVuMjIxeU9sbWtPWEVFZmgxZEVLOXJORTRs?=
 =?utf-8?B?b01HSzJFak1Jckhid25XeHhGM2lOSEl5Y2xzcEprZHh6ejZBYmg1RjdxWm9B?=
 =?utf-8?B?OUxiLzRkdloyZ3hkaDZoQkdmWU93VmlvMmJYZDlQQUpLMUNhR08ySFZSV0du?=
 =?utf-8?B?QUMzSEI4TFZQbm4wUWN2anVnTnZ4TXMvbkZReUptdVNWMDFDTGpFMk01NTdr?=
 =?utf-8?B?QVhGV0ZFam5SelBYZHNCaE93M3NKdVlhYnRkSVRzUGE0MVBiNHdYSEdxSnls?=
 =?utf-8?B?NHZ6RmNxT3FnU2pRakRSSXVVa0o1dSs2WGQ5UFFGOW0zNXJGU3hjTFN4cVlF?=
 =?utf-8?B?Qjg3Vks0cEtxcGdvNWJWSEFDd28zUFp6L2RUWXpPMUlTdWJnUitzd3pIUmht?=
 =?utf-8?B?aUw0a2swbDQ3VkNFc2tQeWI1WjhaS2VvaFNGMXBwOEVlZ1ZNa1drdW85R2hM?=
 =?utf-8?B?bVF4K3ZWbW9QZjFWSm9kQXZyWWdRQ0dhY0VodzJiK3NqeG9QajVDanFhOHlt?=
 =?utf-8?B?UzU4RkJJdy9IVllFY1lrUUVJOGxpZFAxN2trWVNIRjlvN0pybEhnUVhhVE95?=
 =?utf-8?Q?ncef6+sYU0CH12P2z7w45Fg8n?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783d6ca9-e5a2-4d1a-6a42-08dd5afb9bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 09:04:45.2148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rom75GVnHMLPuqucp86p8aQVnio76pQgTeZ2u6K2qmDOY7N5w2J7Wn9geYLY6+rsIYJJWinNJODH6c4h31Tnlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9949
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIg05pelIDQ6MTkNCj4g5pS25Lu2
5Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IFRvbSBSaW5pDQo+
IDx0cmluaUBrb25zdWxrby5jb20+OyBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT47IEZh
YmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47IGRsLXVib290LWlteCA8dWJvb3Qt
aW14QG54cC5jb20+OyBMdWthc3oNCj4gTWFqZXdza2kgPGx1a21hQGRlbnguZGU+OyBTZWFuIEFu
ZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT47IFNpbW9uDQo+IEdsYXNzIDxzamdAY2hyb21pdW0u
b3JnPjsgQWxwZXIgTmViaSBZYXNhayA8YWxwZXJuZWJpeWFzYWtAZ21haWwuY29tPg0KPiDmioTp
gIE6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyB0aGFydmV5QGdhdGV3b3Jrcy5jb207IEFsaWNlIEd1
bw0KPiA8YWxpY2UuZ3VvQG54cC5jb20+OyBZZSBMaSA8eWUubGlAbnhwLmNvbT4NCj4g5Li76aKY
OiBSZTog5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHY0IDEwLzIwXSBzY21pX3Byb3RvY29sczog
dXBkYXRlIHN0cnVjdA0KPiBzY21pX2Jhc2VfZGlzY292ZXJfbGlzdF9wcm90b2NvbHNfb3V0DQo+
IA0KPiBPbiAzLzMvMjUgMTE6MzcgQU0sIEFsaWNlIEd1byAoT1NTKSB3cm90ZToNCj4gDQo+IEhp
LA0KPiANCj4gPj4+IEBwcm90b2NvbHMgaXMgYW4gYXJyYXkgb2YgcHJvdG9jb2wgaWRlbnRpZmll
cnMgdGhhdCBhcmUgaW1wbGVtZW50ZWQsDQo+ID4+PiBleGNsdWRpbmcgdGhlIEJhc2UgcHJvdG9j
b2wuIFRoZSBudW1iZXIgb2YgZWxlbWVudHMgb2YgQHByb3RvY29scyBpcw0KPiA+Pj4gc3BlY2lm
aWVkIGJ5IGNhbGxlZS1zaWRlLiBDdXJyZW50bHksIHNldCBpdCB0byA0IGlzIGVub3VnaCBmb3Ig
aS5NWDk1Lg0KPiA+PiBDYW4geW91IHBsZWFzZSB0cnkgc29tZXRoaW5nIGxpa2UgdGhpcyBpbnN0
ZWFkID8gVGhhdCBzaG91bGQgYmUNCj4gPj4gZnV0dXJlLXByb29mOg0KPiA+Pg0KPiA+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9zY21pL2Jhc2UuYw0KPiA+PiBiL2RyaXZlcnMvZmly
bXdhcmUvc2NtaS9iYXNlLmMgaW5kZXggZjRlMzk3NGZmNWIuLjkyZDI3OGVkZmFmIDEwMDY0NA0K
PiA+PiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL3NjbWkvYmFzZS5jDQo+ID4+ICsrKyBiL2RyaXZl
cnMvZmlybXdhcmUvc2NtaS9iYXNlLmMNCj4gPj4gQEAgLTI1OCwxNyArMjU4LDE2IEBAIHN0YXRp
YyBpbnQNCj4gPj4gc2NtaV9iYXNlX2Rpc2NvdmVyX2ltcGxfdmVyc2lvbl9pbnQoc3RydWN0IHVk
ZXZpY2UgKmRldiwNCj4gPj4gICAgc3RhdGljIGludCBzY21pX2Jhc2VfZGlzY292ZXJfbGlzdF9w
cm90b2NvbHNfaW50KHN0cnVjdCB1ZGV2aWNlICpkZXYsDQo+ID4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTgNCj4gKipwcm90b2NvbHMpDQo+ID4+
ICAgIHsNCj4gPj4gLSAgICAgICBzdHJ1Y3Qgc2NtaV9iYXNlX2Rpc2NvdmVyX2xpc3RfcHJvdG9j
b2xzX291dCBvdXQ7DQo+ID4+ICsgICAgICAgc3RydWN0IHNjbWlfYmFzZV9kaXNjb3Zlcl9saXN0
X3Byb3RvY29sc19vdXQgKm91dDsNCj4gPj4gICAgICAgICAgaW50IGN1cjsNCj4gPj4gICAgICAg
ICAgc3RydWN0IHNjbWlfbXNnIG1zZyA9IHsNCj4gPj4gICAgICAgICAgICAgICAgICAucHJvdG9j
b2xfaWQgPSBTQ01JX1BST1RPQ09MX0lEX0JBU0UsDQo+ID4+ICAgICAgICAgICAgICAgICAgLm1l
c3NhZ2VfaWQgPQ0KPiBTQ01JX0JBU0VfRElTQ09WRVJfTElTVF9QUk9UT0NPTFMsDQo+ID4+ICAg
ICAgICAgICAgICAgICAgLmluX21zZyA9ICh1OCAqKSZjdXIsDQo+ID4+ICAgICAgICAgICAgICAg
ICAgLmluX21zZ19zeiA9IHNpemVvZihjdXIpLA0KPiA+PiAtICAgICAgICAgICAgICAgLm91dF9t
c2cgPSAodTggKikmb3V0LA0KPiA+PiAtICAgICAgICAgICAgICAgLm91dF9tc2dfc3ogPSBzaXpl
b2Yob3V0KSwNCj4gPg0KPiA+IFRoZSBwb2ludGVyIGFuZCBieXRlIHNpemUgb2YgdGhlIGJ1ZmZl
ciB3aGVyZSB0aGUgcmVzcG9uc2UgbWVzc2FnZSBpcyBzdG9yZWQNCj4gc2hvdWxkIGJlIHByb3Zp
ZGVkIGJlZm9yZSBzZW5kaW5nIGEgQkFTRV9ESVNDT1ZFUl9MSVNUIFBST1RPQ09MUw0KPiBtZXNz
YWdlLg0KPiA+DQo+ID4gVGhlcmUgaXMgYSBtb3JlIHJlYXNvbmFibGUgd2F5LiBOdW1iZXIgb2Yg
cHJvdG9jb2xzIHRoYXQgYXJlIGltcGxlbWVudGVkLA0KPiBleGNsdWRpbmcgdGhlIEJhc2UgcHJv
dG9jb2wsIGNhbiBiZSBvYnRhaW5lZCBieSBzZW5kaW5nIGENCj4gUFJPVE9DT0xfQVRUUklCVVRF
UyBtZXNzYWdlLiBCdXQgbm93IHRoaXMgY29tbWFuZCBpcyBub3Qgc3VwcG9ydGVkIGluDQo+IFUt
Qm9vdC4gSW4gdGhpcyBwYXRjaCwgZWM4NzI3YjdlMSAoImZpcm13YXJlOiBzY21pOiBpbXBsZW1l
bnQgU0NNSSBiYXNlDQo+IHByb3RvY29sIiksICJ1MzIgcHJvdG9jb2xzWzNdOyIgaXMgdXNlZC4g
U28sIEkgdGhpbmsgc2V0dGluZyB0aGUgYXJyYXkgb2YgcGFja2VkDQo+IFNDTUkgcHJvdG9jb2wg
SUQncyB0byBhIGZpeGVkIHNpemUgaXMgYWNjZXB0YWJsZS4NCj4gTkFLLCBsZXQncyBub3QgcGVy
cGV0dWF0ZSB0aGlzIHN1Ym9wdGltYWwgaW1wbGVtZW50YXRpb24sIHBsZWFzZSBpbXBsZW1lbnQN
Cj4gUFJPVE9DT0xfQVRUUklCVVRFUyBpZiB0aGF0J3MgdGhlIHdheSB0byBmaW5kIG91dCB0aGUg
YW1vdW50IG9mIHN1cHBvcnRlZA0KPiBwcm90b2NvbHMgZHluYW1pY2FsbHkuDQoNCk9LLiBXaWxs
IGRvIGl0IGFjY29yZGluZyB0byB5b3VyIGNvbW1lbnQuDQo=
