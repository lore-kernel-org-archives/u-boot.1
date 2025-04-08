Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8C8C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 08:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 853B582CD5;
	Tue,  8 Apr 2025 10:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WeP0Nd2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8343F82CD6; Tue,  8 Apr 2025 10:04:55 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFA5F82CC9
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 10:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTHZC72f9h/oQvR+LTbt0Vd8u55mrkJfGz+KrHDLoyV4RlR94Y7qPz9kcMfU7LJGFKDAApkGH8wTBHOh0/ZN7UYj5KE0Pl22PxQ/EgLgnTi/UVfKBCetJ9zFVu9li5ZXyxUtHN2EnS6NfpDtKbNl+7AyONC61WuxAvaMAHwexFS1ICnsW7YiHZIrZoI2CqvPY2pqwVtBFKLy6Vy9lUMaXYYddTocWbgo55R2VxIoYAIMM7cLirTz7Keaeon+6/sHojcJK45/KMxCQpO0TMqTJDol+ruJnn3CVzt/CbBmQHNv3S6KKJCb7eGFcOMvQMJCpnZCyCWxhrsGR5mCdpPy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPHYgDyRaIlux7Mm1nzcM7LnYNWPsBLbUP3Kw4UTkSo=;
 b=iuKeOWvfawkzlYiQUcoEXPY1v9xsZPgXTGFwxIJlUo2OVFoB5G1XRXVFNq7NYtvyLqsLqla3I8ba+B0YdtBjlq4pyiorvOJPTJfrZKdrX6SLLQWQjMVZwVn0WV81OWVmlcMU7TLkCzfLpVSM5VwFx+fmf2mnCUN+8UuaFFDEXvfzUcUNr8MKhoMTG3c4bMWgROohXBb2DqbRQfitA3jkO3r9d4r663pcbHU8d22KW3mDJzGUwIr/wZfSZhVPNi/fQWjnCbK7qDseaVMfv/rvzhIybK+kpGcfNd2pLz8Fd/b6XL/MXHRV+uIvNiwvnsCurZQPUXZAGj3xcSLKfYtk9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPHYgDyRaIlux7Mm1nzcM7LnYNWPsBLbUP3Kw4UTkSo=;
 b=WeP0Nd2hOeBQElKWEZPm2yy4HQoItZ+pzmGnpbR7onpnB2T5UlPL3WEZxHzTtOl2IK/bpWwj2UGmg2YTfBPrK3woOH8RKNxIu/nWNGqiEqFtqPNIoBuf0QLseSgYPM3mPJq/hWbaeDHc1GZyYFjSoqEtauGaW8LyllmsLJjpREbgXdFJ199hNvkYMLiY4UYasXY4Zcs2/ox7gAa0FhCSRFMQNDnhigWG80YeGF5I89ckTgejJ8bNhNJyABTvpAq3vImKaBK4fH+jC4m148/QJ9M5eyj3o9hd8+8pcw8fSzBDINanpO/xd8kkmbTF60FvmK+cUACIQaFlw0TKgRJv0A==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB8525.eurprd04.prod.outlook.com (2603:10a6:102:210::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 08:04:51 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 08:04:50 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "Gres, Anton" <Anton.Gres@ifm.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: "LW@KARO-electronics.de" <LW@KARO-electronics.de>, Alice Guo
 <alice.guo@nxp.com>, "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "lukma@denx.de" <lukma@denx.de>,
 "marex@denx.de" <marex@denx.de>, "sbabic@denx.de" <sbabic@denx.de>,
 "seanga2@gmail.com" <seanga2@gmail.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "trini@konsulko.com" <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjggMTcvMTldIGRvYzogaW14OiBhZGQgZG9jdW1l?=
 =?utf-8?Q?nt_for_i.MX95_Image_Container_Format?=
Thread-Topic: [PATCH v8 17/19] doc: imx: add document for i.MX95 Image
 Container Format
Thread-Index: AQHbqFVfrTjBvWobkUqWZ5SUqPgFC7OZaGrQ
Date: Tue, 8 Apr 2025 08:04:50 +0000
Message-ID: <PAXPR04MB9644A93480D756075F39EB50E2B52@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <AM0P189MB0818D6DA0527C56748BF28E180B52@AM0P189MB0818.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <AM0P189MB0818D6DA0527C56748BF28E180B52@AM0P189MB0818.EURP189.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PAXPR04MB8525:EE_
x-ms-office365-filtering-correlation-id: 89a9e827-7c65-4f22-6c37-08dd7674097f
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?R3JlUVpXT3FQVkR5bC9mUDA0clluZTZxYmhpNytOd2FhdGJvY2x0dm9idzZt?=
 =?utf-8?B?dTFPSW5NV1doTWZWVFBxdFBVRmloSGgzZlpNRG1IQ2RVMXU3QU5IWi9QUExQ?=
 =?utf-8?B?YWIzc0xvc3R3eHhtcVpycTAxaytTZll6U2lCeEFhcFBFQ0s2V2xuU0g1Mm1h?=
 =?utf-8?B?UzVmR0krZEI0Y2lCd1ZiTWNsZHpGNE9hS2dESHo1dVNoSXowendQQzBQWlNt?=
 =?utf-8?B?dFptazJmUTRMb2FrdFlnTHJuM0FzUTNpcFdMYUJPS2lwaEdLNmUyVGtBMTV6?=
 =?utf-8?B?bnJFV296RnVJWHNudTI0Q1Q4Z290eFlkTmwyMWdUNWJ2K0dFZEJMb2tFRElC?=
 =?utf-8?B?RitMOGVVenR1VVVITVFNSUJScnpqbk9RamxZYkJhUjFPcUJQN3dET09VVEo5?=
 =?utf-8?B?TkxQOTRxaUJLOUtJd0NNOE96TGlZa2FWbjdSbGVWOStzZnVwM0tXblNnMXcr?=
 =?utf-8?B?ajNnRzVKbS9iQTZod3RQZnBZeUNkTlZKcnAyb3NZR0sxemJxNk90YmVlcmpW?=
 =?utf-8?B?Szh0WGhzSWM1NU9wYytnYkw1SDRaOUloN1hHd0hGTm1ZdGpHWVZHVWdQbTVF?=
 =?utf-8?B?T1R3dDk1UWVtNFQ5eVgvSVA1a3ExZlVNMW51K3FQZ1crYXpZMWFLNlNOWkNj?=
 =?utf-8?B?bnRwSHFZMmxKdS9FSFdXSXZtRnVXeVE1MHdlWUZGZWcrUXp2RlMyLzdLWkl4?=
 =?utf-8?B?SDBlSUhCREVMMVNlb2E5U3gwNnNFZnNOck9rYUtnRnpHcS94MzYvMVZtQk8y?=
 =?utf-8?B?VW5LbDg1VG1abG9LNmN0SjByUmhRYjY3aDFWbHQva2VkZlRxU1pwVUZGNnNr?=
 =?utf-8?B?ZlpidXozeGhRSFJOaTRhQTZTdUM1YWpQV29OL2xQSlBPVW9SR2piS1RWd2oy?=
 =?utf-8?B?NXRxMzNlNFJ1dys1enF3R1JuU3JBK1B5U0c1OWc0ZVl2NVc5TVpYcFo3ZitJ?=
 =?utf-8?B?ZXVQQ2FMSUs3ZUl0eWUydEs0ZXdUcmpMZ090a1RQRjNBNUk5Z0M2MmphSjQw?=
 =?utf-8?B?cTNTNzZXRHFhNk9jL25PbUkwRWdYaUQ4NzIwenUxN21pL2lRMFNmLzI4L1Vl?=
 =?utf-8?B?TnJtRUh3VE1IeVloVUxsVmVoeEZocFpzRUt5MWdxdlhQZTBsWGw0RzFJSEE3?=
 =?utf-8?B?MGZlbjhFcXVlVTUrN0NvNTFqd2JuZlZlT0JFMWJLL01TWHIxcmZYSDMxRVFE?=
 =?utf-8?B?NEhvcmlhMGZ6SXlNL2lFMXhlU0VGZHJtZ0xTY3dRNEJONG9QUEZUejlLYWRZ?=
 =?utf-8?B?R3lqV3JTRFBVRGFZdnV5RTVaNVl1L3g1RlUzVWVQWTVMRTBwazBrRDBIQ2R0?=
 =?utf-8?B?aktUeEd2RmR5WUltU2lwVXJHQ1BKUGQ1ZkQwSGExM0ZuM2w1UUtYd1FhKzd1?=
 =?utf-8?B?cG9nRHBuaDNHVWdBS3lka3NyNS9TYUZYTi9TbVFLdFkrRXIrS2xwNGlkTUlI?=
 =?utf-8?B?NEgxRmltekJDMDRhcWRCa0dvZnZteE8rREwxSitDRDdSVHZFL2ZNZG5QV1NU?=
 =?utf-8?B?dWpnUUhZeG5nNlpHMTl1QS9nMStzRit6YUgyRkhJR0NRTWoyajl2dGtFUU41?=
 =?utf-8?B?ZHhRTnhKT2NKb3ZmMlRqdlBjZG1MNnFhZW9WV1Fmb2xtUTg2bEtMMXhhRjNh?=
 =?utf-8?B?MTdOM2oxMDN3ekJyTmM3ZEhkVnBYcGo3N0huRm1TaTNPZDVPK3FkN29kLzlF?=
 =?utf-8?B?cDlaeFNkYTRkeGdsZTduMG4zeVVNSEZxaTdlOVlKT0F4dUtFdEQyRksyK3VQ?=
 =?utf-8?B?NHlIRXphUW4yaXUwcmV1NTBMYm0wbmVUOGNNQVUxNTdHelY2MmlwWVI2Y1RS?=
 =?utf-8?B?U014L3htc29mM2N1YTdTMUUxYkhhalViSHRoVHJWQWZxaE16VTF5Ri9mUkZy?=
 =?utf-8?B?b05LYS83THQxMXdWK2RVWjNCMGlJRzlEalBSTWRVR3dVYXpCSThVOG5IVlo1?=
 =?utf-8?Q?8jDD6aoKjMsTsVrhcucPeh6buuucH1t8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmxhWEkwMzhQMUV1MmVQQUpDQml2dnk5L0xrQURONnBvaDkxSHNEWTJJVFlk?=
 =?utf-8?B?RVNnM2tqYXlBbFVlWmJ2MkhScG80UUw1WFlTS2I4K0JjeUJZYlYxYnRTYXVM?=
 =?utf-8?B?azRxTU9XOGZ1WHdNbjlqcHZXNGJSM3MrMWJwdGw0VkFQZTRFM0xrbHhkVDhp?=
 =?utf-8?B?UExRVS90RlhxNGtQZzh4ZmFxclRFaitsNFBobkZ2eDdwYWtmSXJWeitaL0RL?=
 =?utf-8?B?dW5ldm10eTVkVWJWVGcvQUl2U1YwWlZGNExXVDArQVMrTHJVek9lWDBwOHVs?=
 =?utf-8?B?SjRtTTZaaVVJdStFNkRBdGVvNVhQbnF3dGRONUlQWllpdTV3akhUbEJYT1lE?=
 =?utf-8?B?dUZhQ2FiZksxUjFjbHVOaHF5bVJoUUtlQnBZRS9EcUhKaWVnT1Y4R204c0w2?=
 =?utf-8?B?NStFVGs5ZDM5aENuYnJDckxtOTdwVjB5RElmWTVFcCtuekQ5U2xocnhRc2VM?=
 =?utf-8?B?b2xvOTJQRU11YWpIWDRwclVLdmFxTFdzRlNFWUZuSm1XSlB5K2dGczJQZDJ5?=
 =?utf-8?B?UWJHRjB1bC9LWmlCdGxGd000OUU4WUZCRzJxVHRUejk5L3ZWUEgreGgzWlFZ?=
 =?utf-8?B?NDBoQU9lVTFhR25hcXhpeDhKZUc4ZWVSdmtpT0kxa0ZCOWp2MHBHRXFObURu?=
 =?utf-8?B?d0FsU011QW42TkJKWFgwcVN5VktHOWhGdEJkZUxFUk5TS1F4c1FBbmVjSDJv?=
 =?utf-8?B?ZjVYSE1mVDlOcFY2MzJ1NURGNGVKR3lWUkZZQzdrQ3pTSWlkZ21vS2FWdVVE?=
 =?utf-8?B?SXhXS3FBQXRKTFZFTUxWZHlUM2ttUG8wUU5zeW12cFFaSnBkTW43aE1IYkYv?=
 =?utf-8?B?T1pkRWtjWW5GUHNnOEc1a0xOK3RxaHE1bDU2TkVjcDc0ZG9hdjNML2RmWmZ1?=
 =?utf-8?B?MFMwWGVBN3ppNTRNSXFkajNSRFhHdjdFM3lSeFhLZ2lSNmF4ZlVxVEg0Tjkx?=
 =?utf-8?B?WG0xSW00ejhmUVJYVEx2RStuaVd5YjJheGlpMzNQQ3RPWHk5VHl3SisxVVJ4?=
 =?utf-8?B?Q1Q5ek1HWE5ac1ZaYTM3aGMrYncxMWNyRVltUjZsek5YOHVkTkdrcHlROVdX?=
 =?utf-8?B?eStZaWlVd1VZdGhHT2d0cUUyLzEzSHpwZmpCZDRoYmhINEFQc0NDTXFMSmwv?=
 =?utf-8?B?TlVFVXZkcDNSNmxmNm1JUVhkNGZzWFhmaEl4ODc0WFZxRFR1ZE5PMUUyQjhV?=
 =?utf-8?B?VUt5RWxvZFlFb0NMR3J4cFdROVU3RmxNZHFvSTdVWHEya1JleTRaR2lvNGdF?=
 =?utf-8?B?M1BuY3FkRldQSnlKYkdyMC85emJ3MFdkdnliYU85dzhheE5IQkJOeGtkUVh3?=
 =?utf-8?B?NE91Ui9EbTRIYTl2Zk0yUE9DSnpVdUE1TEpyRzlHWERtb0d6RFNsWUl1SFpS?=
 =?utf-8?B?Vlk0KzFZODdkc3YvT3Zta3hZM24wMkZ1eWRyRXlwMGc1ZXovazBrTzMrME1j?=
 =?utf-8?B?M3BXUCtkQytibEt5Y3pmTW9KaFJOMHA0cmdNbkhpZDIxcWtQbnRNWEFxT2tv?=
 =?utf-8?B?TnBXNk5WVlVaWlFFNDk5b1Y1K1lDajVmRW1uRVJFdEIyRVdLaHptZW05cG5a?=
 =?utf-8?B?WkRFQjNpWkErWTBoaXlpK0hDeHdpUFVBMmZ5Q1JoakRaNkMrVVpzK3JjbjBV?=
 =?utf-8?B?aE9sRnFtNDMvcmNkVFhoamFZZmt6Yzk4THk0NTRjVS9LcjQzTDNiTEp4bHFs?=
 =?utf-8?B?UllSWE83VHRjZTBDSUVETm9ubWFDU1dtcTNTWUJlNmF6V09MaUEvZVo5cnND?=
 =?utf-8?B?ZktVS3RkNzNiakpEVjRIYmJwQU1NUyt0WkJxVDFrSkMwdGRJVE9QTEErZGVS?=
 =?utf-8?B?YWwzVDZuR0pYVlRHdDdLb0J1OE9DM3VlSmkwOEM3UXRCaTZUTEJlaDN0SEV6?=
 =?utf-8?B?Mld3WGs3eFFwZFlsbHZyTkUyUkFzZ0FabFM3RlZBYWNNaDZvVmcvZUxZUmlr?=
 =?utf-8?B?Z0VVYjIvUUVLWGc3R2hTekw1UnlZSHpPTWxvTDNXcnl4RTRXSTR6ajZLVlo0?=
 =?utf-8?B?MG5tMUIzU1QxSnpCTGU3aHpLYVQ1OGhhTE12NUJoc2tBZ2pJWC9tWEpyQUVR?=
 =?utf-8?B?K1NaQ1lOQ0twNFZPR1lnVW9BK3hnbXFCVkpzKzhkT1huNTVhaG1UOVhKbHgr?=
 =?utf-8?Q?F/DA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a9e827-7c65-4f22-6c37-08dd7674097f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 08:04:50.3746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBTegzOGfuUwJvbq2j+FKX0FfYqydmLv/6U3tLmhUI19CNzjcS3OZUsID3jqCmVzuyX12v6a2zadjpt64zevGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8525
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogR3JlcywgQW50b24gPEFudG9u
LkdyZXNAaWZtLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI15bm0NOaciDjml6UgMTU6MjkNCj4g
5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4g5oqE
6YCBOiBMV0BLQVJPLWVsZWN0cm9uaWNzLmRlOyBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29t
PjsNCj4gYWxwZXJuZWJpeWFzYWtAZ21haWwuY29tOyBmZXN0ZXZhbUBnbWFpbC5jb207IGx1a21h
QGRlbnguZGU7DQo+IG1hcmV4QGRlbnguZGU7IHNiYWJpY0BkZW54LmRlOyBzZWFuZ2EyQGdtYWls
LmNvbTsgc2pnQGNocm9taXVtLm9yZzsNCj4gdHJpbmlAa29uc3Vsa28uY29tOyB1LWJvb3RAbGlz
dHMuZGVueC5kZTsgZGwtdWJvb3QtaW14IDx1Ym9vdC1pbXhAbnhwLmNvbT4NCj4g5Li76aKYOiBS
ZTogW1BBVENIIHY4IDE3LzE5XSBkb2M6IGlteDogYWRkIGRvY3VtZW50IGZvciBpLk1YOTUgSW1h
Z2UNCj4gQ29udGFpbmVyIEZvcm1hdA0KPiANCj4gW1NpZSBlcmhhbHRlbiBuaWNodCBow6R1Zmln
IEUtTWFpbHMgdm9uIGFudG9uLmdyZXNAaWZtLmNvbS4gV2VpdGVyZQ0KPiBJbmZvcm1hdGlvbmVu
LCB3YXJ1bSBkaWVzIHdpY2h0aWcgaXN0LCBmaW5kZW4gU2llIHVudGVyDQo+IGh0dHBzOi8vYWth
Lm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBbLi4uXQ0KPiANCj4g
PiArRmlndXJlIDE6DQo+ID4gKy0tLS0tLS0tLS0tLS0tLS0tLS0gKy0tLS0tLS0tLS0tLS0tKy0t
LS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKw0KPiA+ICsgICAgICAg
ICAgXiAgICAgICAgIHxUYWcgICAgICAgICAgIHxMZW5ndGggICAgICAgIHxMZW5ndGgNCj4gfFZl
cnNpb24gICAgICAgfA0KPiA+ICsgICAgICAgICAgfCAgICAgICAgICstLS0tLS0tLS0tLS0tLSst
LS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSsNCj4gPiArICAgICAg
ICAgIHwgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgRmxhZ3MNCj4gfA0KPiA+
ICsgICAgICAgICAgfCAgICAgICAgICstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSstLS0t
LS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSsNCj4gPiArICAgICAgICAgIHwgICAgICAgICB8IyBv
ZiBJbWFnZXMgICB8RnVzZSB2ZXJzaW9uICB8U1cgdmVyc2lvbg0KPiB8DQo+ID4gK0ltYWdlICAg
ICB8ICAgICAgICAgKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0t
Ky0tLS0tLS0tLS0tLS0tKw0KPiA+ICtDb25hdGluZXIgfCAgICAgICAgIHxSZXNlcnZlZCAgICAg
ICAgICAgICAgICAgICAgIHxTaWduYXR1cmUNCj4gQmxvY2sgT2Zmc2V0ICAgICAgIHwNCj4gDQo+
IFRoaXMgc2hvdWxkIHByb2JhYmx5IGJlIEltYWdlIENvbnRhaW5lcj8NCg0KWWVzLiBXaWxsIG1v
ZGlmeSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IFJlZ2FyZHMsDQpBbGljZSBHdW8N
Cg0KPiANCj4gPiArSGVhZGVyICAgIHwgLS0tLS0tLSArLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0t
LS0tLS0rLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0rDQo+ID4gKyAgICAgICAgICB8ICAg
ICAgIF4gfEltYWdlMDogT2Zmc2V0LCBTaXplLCBMb2FkQWRkciwgRW50cnlQb2ludCwgRmxhZ3Ms
DQo+IEhhc2gsIElWfA0KPiA+ICsgICAgICAgICAgfCAgICAgICB8ICstLS0tLS0tLS0tLS0tLSst
LS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSsNCj4gPiArICAgICAg
ICAgIHwgSW1hZ2UgfCB8SW1hZ2UxOiBPZmZzZXQsIFNpemUsIExvYWRBZGRyLCBFbnRyeVBvaW50
LCBGbGFncywNCj4gSGFzaCwgSVZ8DQo+ID4gKyAgICAgICAgICB8IEFycmF5IHwgKy0tLS0tLS0t
LS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKw0KPiA+
ICsgICAgICAgICAgfCAgICAgICB8IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uDQo+
IHwNCj4gPiArICAgICAgICAgIHwgICAgICAgfCArLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
LS0rLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0rDQo+ID4gKyAgICAgICAgICB2ICAgICAg
IHYgfEltYWdlTjogT2Zmc2V0LCBTaXplLCBMb2FkQWRkciwgRW50cnlQb2ludCwgRmxhZ3MsDQo+
IEhhc2gsIElWfA0KPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tICstLS0tLS0tLS0tLS0tLSstLS0t
LS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLg0KPiB8DQo+ID4gKyAg
ICAgICAgLS0tLS0tLS0tLS0gKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0t
LS0tLS0tKy0tLS0tLS0tLS0tLS0tKyA8LS0NCj4gU2lnbk9mZnNldA0KPiA+ICsgICAgICAgICAg
ICAgICAgICBeIHxUYWcgICAgICAgICAgIHxMZW5ndGggICAgICAgIHxMZW5ndGgNCj4gfFZlcnNp
b24gICAgICAgfA0KPiA+ICsgICAgICAgICAgICAgICAgICB8ICstLS0tLS0tLS0tLS0tLSstLS0t
LS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSsNCj4gPiArICAgICAgICAg
ICAgICAgICAgfCB8U1JLIHRhYmxlIG9mZnNldCAgICAgICAgICAgICB8Q2VydGlmaWNhdGUNCj4g
T2Zmc2V0ICAgICAgICAgICB8DQo+ID4gKyAgICAgICAgICAgICAgICAgIHwgKy0tLS0tLS0tLS0t
LS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKw0KPiA+ICsg
ICAgICAgICAgICAgICAgICB8IHxCbG9iIE9mZnNldCAgICAgICAgICAgICAgICAgIHxTaWduYXR1
cmUNCj4gT2Zmc2V0ICAgICAgICAgICAgIHwNCj4gPiArICAgICAgICAgICAgICAgICAgfCArLS0t
LS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0r
DQo+ID4gKyAgICAgICAgU2lnbmF0dXJlIHwgfCAgICAgICAgICAgICAgICAgICAgICAgICBTUksg
VGFibGUNCj4gfA0KPiA+ICsgICAgICAgIEJsb2NrICAgICB8ICstLS0tLS0tLS0tLS0tLSstLS0t
LS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSsNCj4gPiArICAgICAgICAg
ICAgICAgICAgfCB8ICAgICAgICAgICAgICAgICAgICAgICAgIFNpZ25hdHVyZQ0KPiB8DQo+ID4g
KyAgICAgICAgICAgICAgICAgIHwgKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0t
LS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKw0KPiA+ICsgICAgICAgICAgICAgICAgICB8IHwgICAg
ICAgICAgICAgICAgICAgQ2VydGlmaWNhdGUgKG9wdGlvbmFsKQ0KPiB8DQo+ID4gKyAgICAgICAg
ICAgICAgICAgIHwgKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0t
Ky0tLS0tLS0tLS0tLS0tKw0KPiA+ICsgICAgICAgICAgICAgICAgICB2IHwgICAgICAgICAgICAg
ICAgICAgICAgQmxvYiAob3B0aW9uYWwpDQo+IHwNCj4gPiArICAgICAgICAtLS0tLS0tLS0tLSAr
LS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
LS0rDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAuLi4NCj4gfA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICstLS0tLS0tLS0tLS0tLSstLS0t
LS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSsNCj4gPC0tIEltYWdlME9m
ZnNldA0KPiA+ICsgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICBJbWFnZTANCj4gfA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICstLS0tLS0tLS0tLS0tLSst
LS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLg0KPiB8DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0t
LS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKw0KPiA8LS0gSW1hZ2VOT2Zmc2V0DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIEltYWdlTg0KPiB8DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0t
LS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKw0KPiA+ICsgICAgICAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uDQo+IHwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICArLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0rLS0tLS0t
LS0tLS0tLS0rDQo+ID4gKw0KPiA+ICtpLk1YOTUgTG93IFBvd2VyIEJvb3QgSW1hZ2UgU2V0cyBM
YXlvdXQNCj4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4g
Kw0KPiA+ICsgICAgSW1hZ2UgY29udGFpbmVyIHNldHMgYXJlIGhhbmRsZWQgYnkgTTMzIFJPTS4N
Cj4gPiArDQo+ID4gKyAgICAtLS0tLS0tLS0tLS0tLS0gKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0t
LS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKw0KPiA+ICsgICAgICAgICAgICAg
ICAgICBeIHwgICAgICAgICAgICAgICAgICAgIDFzdCBDb250YWluZXIgSGVhZGVyDQo+IHwNCj4g
PiArICAgICAgICAgICAgICAgICAgfCArLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0rLS0t
LS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0rDQo+ID4gKyAgICBFTEUgKyAgICAgICAgIHwgfCAg
ICAgICAgICAgICAgICAgUGFkZGluZyBmb3IgMUtCIGFsaWdubWVudA0KPiB8DQo+ID4gKyAgICBP
RU0gICAgICAgICAgIHwgKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0t
LS0tKy0tLS0tLS0tLS0tLS0tKw0KPiA+ICsgICAgQ29uYXRpbmVyICAgICB8IHwgICAgICAgICAg
ICAgICAgICAgIDJuZCBDb250YWluZXIgSGVhZGVyDQo+IHwNCj4gDQo+IEhlcmUgYWdhaW4NCj4g
DQo+ID4gKyAgICBTZXQgICAgICAgICAgIHwgKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0t
Ky0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKw0KPiA+ICsgICAgSGVhZGVyICAgICAgICB8
IHwgICAgICAgICAgICAgICAgIFBhZGRpbmcgZm9yIDFLQiBhbGlnbm1lbnQNCj4gfA0KPiA+ICsg
ICAgICAgICAgICAgICAgICB8ICstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSstLS0tLS0t
LS0tLS0tLSstLS0tLS0tLS0tLS0tLSsNCj4gPiArICAgICAgICAgICAgICAgICAgfCB8ICAgICAg
ICAgICAgICAgICAgICAzcmQgQ29udGFpbmVyIEhlYWRlcg0KPiB8DQo+ID4gKyAgICAgICAgICAg
ICAgICAgIHwgKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0t
LS0tLS0tLS0tLS0tKw0KPiA+ICsgICAgICAgICAgICAgICAgICB2IHwgICAgICAgICAgICAgICAg
IFBhZGRpbmcgZm9yIDFLQiBhbGlnbm1lbnQNCj4gfA0KPiA+ICsgICAgLS0tLS0tLS0tLS0tLS0t
ICstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0t
LS0tLSsNCg==
