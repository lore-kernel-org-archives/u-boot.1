Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C9CC87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 06:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99DB382063;
	Wed, 30 Jul 2025 08:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mT3b7+TY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F22E582063; Wed, 30 Jul 2025 08:09:15 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1013081FEE
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 08:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZK19HaYug4K6+yG5QgJy/AFmZEoG/4zEhfm/nL+ARgC7IZbMrIuD6q2KaFqG4ZZGW7H9KiXVGwO7fdz9CfYqygi5PeebJgTioTt16QP6M5BvIPA2lxTHnngjyDjBG6cPPle/qrBHk83ADyYpmA3Z7Nuizs3V0o59l8ltn2qp5jQ9xqCMQuY8YuWl5CV1MpDmC8onq+tgaZVTry8QadkJg49aifLma4C7a6cTreluBYZIS6YmSuh4m3Hkm2x/U9HJp6IVxwodV89uh7a2VPYfwEuebVj+MdZ8ltom2i0j6ck5orY7hfczMQ4S3skinWFCLVgFUBM9kE4oX9Vclq/Pew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbBrBFYzdV3fWlTqo8wNADKtQGXEQRTh4aBVQZViFv4=;
 b=TWjxtcp2jtyC5b3iBPKjzz3tXzHicyrJK6FUdfNnZ9YPQn++S9515pgDtq9S8H+8IxIhpQmSCQPbh3jK/cWuYZESv0M+grr7bZGLfULchJqI4/jSOB3v2+HX1im8MFsdsWN6NyaCZEawWvLnHXG9lLuwYgujXNtv/l3m2Bqff3Ra1quBhIqYuP3396Wq6LCnAPxj88RkRWI7xM6KUX/+pg1t0wnxpeYV77HfXczYK9Uj8CJaJSq6RWLKh8o0KRThwT0JVi4htumFEAgejDpl67eSEkaipOrZipG2fjHok2TRKEPHGoB4ZAQkHYEj+9J44kS/OxMA+WHDN7HSXbhO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbBrBFYzdV3fWlTqo8wNADKtQGXEQRTh4aBVQZViFv4=;
 b=mT3b7+TYSoFMJqonlwIdRCIigjyq9yDqC6U45eSWEV9iunx9ZbqHxxdSM+uqXnN/IYr+iAMlNUowDBm+n2pB1VTavSO4nNRPFSeRbzjI/7O0IfzeVi9fOK4xMX8mi4RNvFduVbE+nYdO36xfeMn9KidTmjuVNxd7TtPdu9jawAUGYwhp1ukR5zD/h83/gGkhz75JnBpRbwbD4jjqnPvjc49KUfYQTo/c9LGvDT0csS4y+f5lg2WA7wRe/dYAt4ae6TqREN+iZUXsShWo0kgxJTIhs57EMiaUkAnJKh5h6onXVm98BJ8rIs8RJDzL1D2vzh8zvLUauXhEEOKwe9ge+A==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI2PR04MB11026.eurprd04.prod.outlook.com (2603:10a6:800:279::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 06:09:08 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 06:09:08 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>
CC: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>, Ye
 Li <ye.li@nxp.com>, Stefano Babic <sbabic@nabladev.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Alice Guo <alice.guo@nxp.com>, Jacky Bai
 <ping.bai@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMC80XSBpbXg6IGFkZCBpLk1YOTUgYjAgc3Vw?=
 =?utf-8?Q?port?=
Thread-Topic: [PATCH v2 0/4] imx: add i.MX95 b0 support
Thread-Index: AQHb9VNopRnJWXkO/EGKWMdbKsFiUbRH6K6AgACLm4CAAOV9AIAAfvCAgABrn5A=
Date: Wed, 30 Jul 2025 06:09:08 +0000
Message-ID: <PAXPR04MB96443299A51764EE05533DE0E224A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
 <CAJ+vNU2G=CMiHc4mU4fjQEz7zwjvx_EuiWWQo8MBVHGJdmTarA@mail.gmail.com>
 <PAXPR04MB9644BC97420DB4E3D877C2E2E225A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <CAJ+vNU1asw79GMnsTxNevg+xRo-1SQ9j_f+4e-TEy4TPZ+Qt+Q@mail.gmail.com>
 <CAOMZO5BN_kxD=t0n3h=g3XhL1dLMmhgLHf0TtBtaX8ad3M878w@mail.gmail.com>
In-Reply-To: <CAOMZO5BN_kxD=t0n3h=g3XhL1dLMmhgLHf0TtBtaX8ad3M878w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|VI2PR04MB11026:EE_
x-ms-office365-filtering-correlation-id: f9ec9ba4-fcd9-4d79-2586-08ddcf2f9861
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dEw0REx0eWJabkVuc3VlVkswMGhSOTh3dkkzM0JEYXMveHM4c0NpNTJsckhH?=
 =?utf-8?B?Rk41WWZrOTg0Wk04YjJXOXdRSTliQnZSZDM2VE40Zyt4TTlEbU9IbWU0c1dW?=
 =?utf-8?B?S0k2UFRlTkxybnhEN2o5Tk4vNm4raEREVXhjUHZoNGZhcFZRQUp5MmJ4QWpo?=
 =?utf-8?B?R0lBM0xtQVpuakxhS1Azcm9tbU1hUXB1Z0VVeE9FRTU2bHlKc1ExL2FyQmJY?=
 =?utf-8?B?clo0aFhuNDh0T2tuVjlLQTJaSGI0OHNmYVIvd08vUzF4SnlzRTdWVUtOaTUw?=
 =?utf-8?B?blpQanZOQ0pEaUN5RE9mM21OVmxtZTU0NTNCMkM4MXVLalRGWUlmNGRTUlNV?=
 =?utf-8?B?YUx5RzYrZHY1QkZ6WisrRVlGMXZpa1N1NzRCSmVxTUNGWnRVRFJUZmZ4VVlT?=
 =?utf-8?B?VGYyNERQNnM5eXhkTlVJZmJlSXlVZkpqbzBvU0VqdWNWdXhjMVYvZFA0amlT?=
 =?utf-8?B?cVR1V3NQaEsrOUJGUVJQVitvU3ZmUStQNDgvTlk1dnBWTSt1MTk5TUliNkxR?=
 =?utf-8?B?WjcvVm9YUjRyUEoxdnl1RlZHMHlTTEdkYlJXZEw2dlQwZ1lreFBrUUEzd0NP?=
 =?utf-8?B?cFVaNUN1VTZ5NFJxaE9lUXNCZnJkdGFvbklYZzFUVkFOQkRTc2lEMDVyVklN?=
 =?utf-8?B?UlA0VVZQVnlOZUV4Ni83NC9QZytCamdxSnptQklEd1VBV0JXSmZxdzEwVlA3?=
 =?utf-8?B?d3QxZnY4VkVEd0VWblNGaldMU0x6L21MVGE1OWFMV2N0c2tJQlI1QW1rZUUw?=
 =?utf-8?B?UE44Z0owSVRoUTE2TjFNeUlINHh2eE55V1MrTXQvMkxCREUvRVY3OHh1UitX?=
 =?utf-8?B?NUhHTWJnOXkwOFdaZWpMZTYwWlBQUDI3eWU0NUFQVE1XUU41bzFMSHNON05X?=
 =?utf-8?B?aUdnWURqazBudmJHUUQ4S1pFUExMN3ZXYjQ3WDVFNk5RZEhhMGtLWDVXUHhJ?=
 =?utf-8?B?Tm96T0xvbE9KS3FtWUkyNGRuYisrQWI4bWVTbjdDbnR4aVBEei9CcnBUNFdi?=
 =?utf-8?B?c21FeGM3b1NXQ2p4YWx5SlROeWErNGtnb2RZQ2JiZjZpeEpzdHd5S2dPTnRk?=
 =?utf-8?B?RlBXMTFkNXdNemtWUXJRYWhscDFCb0x2NWIvM1dqVy81VUtmTTRjMzduYXJ2?=
 =?utf-8?B?eXFmZm50blBMbmMwZ2h2VFZDUFJsWVJWTWxBYndQOWtTYy83eDU5Z2hkKzZK?=
 =?utf-8?B?MnZaUGdmWFk5OEZHTG93ME01d0t5ZmppRkU2WXIzaitpVngrbDVDVFBoMnln?=
 =?utf-8?B?ZUhCaVRabnd5NGlqVzU2Z1RZWjJMaTNtUlhhNVd0NGpJR1dGY0VMSmJjZjNo?=
 =?utf-8?B?T1hEdEI0czZjc0p4Z2t0VUlyNStKNUpGcFo1MEhoME44ck9RdWk4RFFhZndD?=
 =?utf-8?B?aktPSlViOTA2aG1EMFV0OVZPU2dEbjJMT3FrRC90M2JSNlFISlpCdU56TmFO?=
 =?utf-8?B?ZGVrdmloWFNyTG5VOFV2SndYbTNSVTMzQjduWjZtb2VVSEtXZmlBaUdIb3hw?=
 =?utf-8?B?b2EwOGxOQzRYUDl1WjhyZ05IY0dtNmMvUjg4L0Q4ak1QaGtYbWNiem9FdDVR?=
 =?utf-8?B?aHRiQ1I0VHU3ajJqRjh6dFVyaHFNOTI4S3ZVRHlwVStBOWNQQ2E2aStLTGZ6?=
 =?utf-8?B?U25QenFabjNONSttdFdHV09ISFFMRmh6Mlo5Q2hvRFhqM0VsazJPdUpqNVJ2?=
 =?utf-8?B?VER0bWlzNXVHMXR3MDZLWVNVcWU1R3JFU00vTHRYbytuWVFsdHV4MnZuN2Fl?=
 =?utf-8?B?a0JIVHlWeXdqUEZmSUR6MC8rcU1CUVVoTk5RTGRVMFJQL3VWejhYdUF4UjJI?=
 =?utf-8?B?bGlQaEsvcS9sN2RyQmtFZXNzRXh6eDE3Rll2Zm81SEFXbmZXVzRncjZQVDVF?=
 =?utf-8?B?VWViRmUxZmFUSGhWL0N2N1p4TlF1RnhpRE5GbXJsU0Z4SFFRb0tqcFkxTEdl?=
 =?utf-8?B?bzhTWnlubVd5QnhTRENhMFVMSGNKcmNsRS9iSXlrbGJZbWoxMlNRUlQrUXVy?=
 =?utf-8?B?V1BTZ1puazN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGZyVkg4Y2J1Z25SM3R0NCtGSUU3MEg1Zk9DWE9GVFNITTU1L2Z2dGw0SmpJ?=
 =?utf-8?B?clpic0dEcDdYc3VhdGJLQnJXMmdhMTdhdjlDN2ZiTmdFZXhPL2ZrSGc3MGJF?=
 =?utf-8?B?N29DdHdTa2laY1BFejJGVWFDcmRjVTJsTW92VGJqTHJPVEhKdm9icmYxWUM2?=
 =?utf-8?B?UHZoTWF4WXpobTFNZ2tiT09BVnFCMWlKbEpuY1FFTmhwM2dFK2N6bnhab0w2?=
 =?utf-8?B?T0JreXo2NWVTS21vNFlncEpCaWpXZkdjcUxGUUpvU0FsOUlVUjJaS0REOHhE?=
 =?utf-8?B?bDgwWVBWNDNGVUh1cFlqV1Q1bTZnRFYweC9Fd1Nvay82L2tocDJjbVhNdC95?=
 =?utf-8?B?ZjJGdWZHSll6YjdrdWYvNHdaVFRpcmpLaWwzcjZDcjExOG44YmNVWVZMYWlH?=
 =?utf-8?B?ZExkK2FoOEo2aXVkcHdaellZeXJmdnpURmFzcXBYK3FudVVyN0hmc1FhY3dR?=
 =?utf-8?B?dVBsZlVVWGo4T3ZIcThYRlVEUm9XREw4WldOYWVFOGZ0QVpTUTNxT1NCZEhS?=
 =?utf-8?B?bXBla2s0RW5PckhLSDFkK2NGcTlPUlNaRzFhYUV2dzFFcTBhQXlOVW9sd0ht?=
 =?utf-8?B?bEJDU2VmbldUYWdvOFpaN01FZ1lWdnloUVhpZkRwVzVHSWJoVHlBaDZpVWt1?=
 =?utf-8?B?eVBUNXVyazRzcU40WFdsRFF4N01rWEd6LzcyY25ZQ3A5VzhzRDFnd1lwQUhj?=
 =?utf-8?B?dVE4Yyt3VlIrRUhXWElFR3I2ekkxQ1RGR3lwaVhzUGRTV0V4L0xrSHRGL3BN?=
 =?utf-8?B?cHo1WWd5RzlKZHlLM1FZSTF5U2xabG1HclBiQTZXVUE3YmdvSURnbWYzeFo5?=
 =?utf-8?B?aTJ1QnV6QkpUYldjM2RjQUJTNkE1RTN3UmVSekkyMUVLTjBYMkY5bG5mb0Q3?=
 =?utf-8?B?Y2FrYXdTUkVTZnZuRkt4OUtzZ0Nqei9CYi9pM1AxWVdnNVdKN2hhZ1ZJQXNI?=
 =?utf-8?B?MXUzcTZuR3VXZU5WK0ZNOVU3V054SWgrSkNsdGxDdGRMYVdxSHNFbHA2Zk5I?=
 =?utf-8?B?V29sRm1oUlBHekNBbVlML1RLb3EzWGtSVVA4RUxPTUZsQ0xRSWc3RUF1eEwx?=
 =?utf-8?B?WUFXbXAzcGZ5NDlJTWVtMHVSaXdGYkVLVkVHZGY4ekJqZ29aWWZLZmtoWmNW?=
 =?utf-8?B?Vm40N0dPTjh6bzQ5OFVaRU1MeEtyUlRvS1gzZVRzSlV1bXNZS1drTVhpZkhL?=
 =?utf-8?B?VlpmeThJZmVVRkNBeUQ4eWQ2THFWQUNGQ2dRemJsZWN6QWxPRnVHS0tlUFdz?=
 =?utf-8?B?RFNmWUZZa3JQVG5oTHM0M0R1RE85SnBNUjBWTERhOXBBcGg4Mzl4SytrcW9w?=
 =?utf-8?B?aEh4ZzJyMmczWGNpa0R6ZTIvRXRFaDBwajA3ZEtlZEJZejZSOGRLWUs5dVF2?=
 =?utf-8?B?QnUrWUdDS2psUUdweUc3Z0d4a1NSYWp5aG9DMm1UMTU5V1kzSlhtQW5DNFlU?=
 =?utf-8?B?WFZiUzZaVjRRWXVpaEhHSmcwN2QrVGNhM05XRWY1TkV1MnV1R1FSYzVDb0ZT?=
 =?utf-8?B?dTVIYjFRLzI1MDhVYWkzY0JQRnYybjJuWk5tb3piYTB6ekdPVFp5MFdvRytZ?=
 =?utf-8?B?WU1nNzl1ZDVlUGJFYnpidTB6RTNHYlAxZlJnL1g3WWhrOWYvWUVDcGg4SkE0?=
 =?utf-8?B?QzRSV0tuOEx3OEI2OFdBTERQdzBVZXQ3RDBqWEtIWnd4TWRHaWZBdmU0aXRS?=
 =?utf-8?B?U1MrYlVSK0RQUVZ1bDlmWTAxYlRHK2FnRTFtTnNSM0Y5QkZyYjEwWjhOSUM4?=
 =?utf-8?B?MkpOamx2ZFU3Y2pLeXpWckJYWUozbDE1Ym5kUEdGYTBRa2czNW9EbXJDSS8y?=
 =?utf-8?B?Sm5FWlg3Ky9zTzJvaERVcEhuQ2wvazRjeTV3TlNNSklKTFkwcmg5NzVCZEpC?=
 =?utf-8?B?WngxM3lNM1EwV1I3TnRsVlZYSEVjR0hyZE5oS24wamsweGVjWGtsTUYvblE0?=
 =?utf-8?B?RmdJNll2YWZteGJHamVXWnpwUExQeHdiVm81a3JVZno4ZDhQVjJHKzlhQTZx?=
 =?utf-8?B?aWFwc01LeUlQdHlMWDAxNTdVdkhhcFQ2RGVhb2x4OHQ0TnBxNDNXV3lCY09Y?=
 =?utf-8?B?TDd2d0JmOUh4YlZMcHd4TVQvRkVmUVpNV3BGU1cySzRvOUxPYWU3M3FHSUVv?=
 =?utf-8?Q?TYUo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ec9ba4-fcd9-4d79-2586-08ddcf2f9861
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 06:09:08.3218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YgeCyx1x4l9CZeotD1UVqSlwGUvyYGLN1XP/d1Ukic0vL+KgdVV2W2ftp9qN9VmFRpSnOYxYHIsY+AwFVRSu9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11026
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogRmFiaW8gRXN0ZXZhbSA8ZmVz
dGV2YW1AZ21haWwuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQ35pyIMzDml6UgNzozNw0K
PiDmlLbku7bkuro6IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbQ0KPiDmioTpgIE6IEFsaWNlIEd1byAo
T1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPjsgUGVuZyBGYW4NCj4gPHBlbmcuZmFuQG54cC5j
b20+OyBZZSBMaSA8eWUubGlAbnhwLmNvbT47IFN0ZWZhbm8gQmFiaWMNCj4gPHNiYWJpY0BuYWJs
YWRldi5jb20+OyBkbC11Ym9vdC1pbXggPHVib290LWlteEBueHAuY29tPjsgVG9tIFJpbmkNCj4g
PHRyaW5pQGtvbnN1bGtvLmNvbT47IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBBbGljZSBHdW8gPGFs
aWNlLmd1b0BueHAuY29tPjsNCj4gSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsgRnJhbmNl
c2NvIERvbGNpbmkNCj4gPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPg0KPiDkuLvpopg6
IFJlOiBbUEFUQ0ggdjIgMC80XSBpbXg6IGFkZCBpLk1YOTUgYjAgc3VwcG9ydA0KPiANCj4gT24g
VHVlLCBKdWwgMjksIDIwMjUgYXQgMTowMuKAr1BNIFRpbSBIYXJ2ZXkgPHRoYXJ2ZXlAZ2F0ZXdv
cmtzLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFRoaXMgaXMgdW5hY2NlcHRhYmxlLiBIYWQgSSBrbm93
biB0aGlzIHNlcmllcyB3YXMgZG9pbmcgdGhpcyBJIHdvdWxkDQo+ID4gaGF2ZSBOQUsnZCBpdC4g
VGhlcmUgd2FzIG5vIG1lbnRpb24gaW4gdGhlIGNvbW1pdCBsb2cgdGhhdCB0aGlzIHdvdWxkDQo+
ID4gZHJvcCBzdXBwb3J0IGZvciBBMC4gVGhlcmUgYXJlIG1hbnkgdmVuZG9ycyBsaWtlIG15c2Vs
ZiB3aG8gaGF2ZSBBMA0KPiANCj4gU2FtZSBoZXJlOiBJIGRpZG4ndCBub3RpY2UgdGhhdCB0aGlz
IHNlcmllcyB3b3VsZCByZW1vdmUgQTAgc3VwcG9ydC4NCj4gDQo+ID4gc2lsaWNvbiBldmsncyB0
aGF0IHdpbGwgbGlrZWx5IG5ldmVyIGdldCB1cGdyYWRlZCBhbmQgc2hvdWxkIG5vdA0KPiA+IGJl
Y29tZSBicmlja3MuDQo+ID4NCj4gPiBXZSBuZWVkIHRvIGF0IGxlYXN0IGtub3cgaG93IHRvIGdl
dCBiYWNrIHRvIHdvcmtpbmcgYm9vdCBmaXJtd2FyZSBmb3INCj4gPiBBMC4gSSB3b3VsZCBiZSBm
aW5lIGlmIHRoZXJlIHdhcyBqdXN0IGEgS2NvbmZpZyB0byBzZWxlY3QgQTAuDQo+IA0KPiBZZXMs
IEkgd291bGQgYXBwcmVjaWF0ZSBpdCBpZiBzb21lb25lIGNvdWxkIHNlbmQgcGF0Y2hlcyB0byBy
ZXN0b3JlDQo+IGl0Lk1YOTUgQTAgc3VwcG9ydC4NCg0KSGksDQoNCkkgd2lsbCBzZW5kIHBhdGNo
ZXMgdGhhdCBzdXBwb3J0IGkuTVg5NSBBMC4NCg0KQmVzdCBSZWdhcmRzLA0KQWxpY2UgR3VvDQo=
