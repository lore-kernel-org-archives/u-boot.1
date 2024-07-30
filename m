Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5CAC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 07:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D57D088808;
	Tue, 30 Jul 2024 09:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="dwYsZtzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD0188806; Tue, 30 Jul 2024 09:02:29 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6560B887D4
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 09:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7C6hZZJPql33jN30ISVtncFRdlr2AlrW5awumkftJLnz9lQ+vh1qibaJROB+dDe2X+Im61f6yhubVP9+nDa+agDIZNSkiGGr/62BOc77eweQAW/ZYIXoUKlotyYzQaz0qTxqRURdUSglHREp0WkDnDSB5cKC6QwQ4RbOTP/KCrZihlNR+9IDQyRzc/xRFScP75y3mOEWvKB1fvA3/xmizwO89e7enXi98MaKLU6aSchuqeRRHWNiUcRgyLZQLqyh2WkwlJfE6LEQXMcgYIY8aS58A9nqRnnNUu83QD8/5rs3UtHQ0nBxXTnbn7ZOZNrysEvqogaL1vcq5br2FFGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKmdemhgGw2b47D8Ry0N6OozYGtXdfvGLhTWyjkvQV0=;
 b=mR90PSYhorjmfoYeWHDvmeWkXckekCSRHxOkTDaCWeWBWbKqFl/S9SEpgy9Jr140wD+Ff9GYe1B0tVCS6qE5HT+iZdS2TEtAWZ9OkT0lb6VCYnDwKMVJo1mQcSFiTEfSzrYnCvDpe/14cnkq+fnpQxNfdYAoZKxtV2CoD4EK+BBUfXb1ZWXPFhqk8xzwN/N4TsBNRfnr223fSu8qz36QOmHRGEfjDL65Rgy/XJbFu2bynJFqly5Ts+jE5iMlOb7cpE7XEgQYlvI9koSVUoQGfwCZtNd/gF7Q5gOtNH8rP1Wl0I7UfSYqhqar7YnaoqLoKwB6DWOklH19/tNnYW2tIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKmdemhgGw2b47D8Ry0N6OozYGtXdfvGLhTWyjkvQV0=;
 b=dwYsZtzRvidNSHtnJQXAZKpNgMjzOEuHztr8UVt8KgH3qk98LyFvGIBcY+h3W6rJAy/xmg2IsMWTOUqVbaEiLjhHPuCBbJZTgRB1VH0jQtNfJZmYtEvjmNrfzpTs1gicHWCpANALglM29pUM4jgm/YQa2eHwGiXwt+WbM6HVFyOE3wWdbosU3wrROn/gSsR9nSHNCDhaPujEzvWUHS0xMfmmBGTKTxLA/hKV8+RLNCicz/QaBkGXPhgK4ZsRq2/DxXH6IW8MlzDl8OZaqEf2eeWYtKXtuFdkp1uyv7nRE/22e19nD+hx4wLIyMDubPciHjqCnpSz/dJIrbfcYOiO6Q==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by DB9PR04MB9404.eurprd04.prod.outlook.com (2603:10a6:10:368::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 07:02:25 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 07:02:25 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCHv2] clk: imx8m: register ARM A53 core clock
Thread-Topic: [PATCHv2] clk: imx8m: register ARM A53 core clock
Thread-Index: AQHa30Pexqt2O5+IbECip2K9bcxtxrIJCysAgAAa8iCAAFLTgIAFZBdw
Date: Tue, 30 Jul 2024 07:02:25 +0000
Message-ID: <DB9PR04MB9236BC624D7A304BB4B5178C84B02@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240726102954.14546-1-Zhiqiang.Hou@nxp.com>
 <0a40ee6f-1fa1-469b-ac9a-f7d8b6ca9f40@denx.de>
 <DB9PR04MB9236DE687B0FB9543836F55084B42@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <2abff6ea-7669-4023-b71e-bb9605ffb214@denx.de>
In-Reply-To: <2abff6ea-7669-4023-b71e-bb9605ffb214@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|DB9PR04MB9404:EE_
x-ms-office365-filtering-correlation-id: afc1bf70-b4a9-4e6d-7b6c-08dcb0659110
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K2pKUDl2MXg4OHQ1cWZ5NGFsNGU5MXg3K3FWVUpKSFJhdjVBSExCTkRhT29t?=
 =?utf-8?B?UUs1OTh0NmZDNWV2TUR0UUtRbGwxZ3JENTVNaVJWTXRhT0lNWGZCVGlRSHMr?=
 =?utf-8?B?eHdxQzNrU29FdWZNVEhGQUNmR0cxZU9iaFBWWUJOMHQrd2d4ZTVieEdmUHd1?=
 =?utf-8?B?TEhaRnp2aGJONmtMMTlHYTI3RVh2dzVpUmQxbENIa1J4VU5ndlh6UDFFVzBq?=
 =?utf-8?B?M2VFdXBzUityallJSUQ1NmZwTmlnYUkxeVRWUmRPYlJ3bUVhN0UzcVNKcTNz?=
 =?utf-8?B?K0FQUWFwRHhRWjFJZlJXWjhzS2ZSbHgrcGdvallBUkV4aVFkNDlKM3M3YjBs?=
 =?utf-8?B?UEh6b2xlUzJoTUp3RGdXWjBNcDFPZnVMbnYyektXbkRLUTNtdjZQeVV3SmZN?=
 =?utf-8?B?aFpyQ0N2SVVNVnZvakZBWHFSdHBkMEl4L0hJZjhFUmxhc2ZGTWdTZS9tN29h?=
 =?utf-8?B?NnNpR3pMT1ByNFFSOE1QQ3krNW1KY0xFUHdqcVNnZVpnZkdVOWFycVVTMThK?=
 =?utf-8?B?TXBvNkY2aUFmbjEvTnJIM2NBUU9jL2t3K2RRZEJ2cnp6ZlJ2V0dFWnc1Q2xu?=
 =?utf-8?B?YmdBelNKNGNnZEZoTWRmZm9vdlVQekR5U3Z6YjhkTzNBOGx1ZVRKQmtXQUJm?=
 =?utf-8?B?OTdDSDlydWNlS2dFenFEU1hITzdEK3NtaSswUjI1a3NWVWw2ZDJkbFFTU2g3?=
 =?utf-8?B?cUZ3THROODRNektDZ1JQc2FaVitVUi9EOVdFS0h1TzZ4YmswVndxSklyUDAx?=
 =?utf-8?B?UHBRTFpqUFM4QTY4Q3NRUi9wd1FPMnQ0ZGREb3VXS2s2ZmhlbytSS3pQQktu?=
 =?utf-8?B?b2FlSnhNSllHZXpSTGhYT3R0Y3l3b1VSSE50c1B0aHQxaW1lMEE1RFNBd0R0?=
 =?utf-8?B?YmJjOTFOTGdqa2s3SnNVb0xHZnZqTXRQSUh1emFLYjIwNlkzOEsrNDlTMUE3?=
 =?utf-8?B?enVtT3V5NUd1cVc4emE0cVc2d1diSVc0ZTBIWmJvVEpYaEsycTdqVU9IKzBH?=
 =?utf-8?B?UTJOb1YvOWR3aHBKRVhaS1ZrSTZjekg3dmRUM0g0VnZGRTJ4ZElTRDdpcU5z?=
 =?utf-8?B?RHdXa01CelZUN2FHYXZSaHQ4UzVKcTViYjRidFEzeFhzVWl0WXJCSW9OZG4x?=
 =?utf-8?B?ZlRUYVduRnZBVVNyWnd0cm0wdW56UDQ2UHE1bEhxR0V6YmFtK0tYYzFwVlpS?=
 =?utf-8?B?aDh1SElUY0RnYW9IOEYxSmgrNU5KWGxNamRBampWcjFldk5XWDNNZ1FIYnI5?=
 =?utf-8?B?cUs0b25TZThVeStlM1l5SURBYm5yNmhlU095WExPYTdmRHRWZnBvWkhGdUhS?=
 =?utf-8?B?SzAyekxSSUNEdXpvSklVbERhVjVuSC94dW5uQ1F4K0s5OG1jRUlPSlZjVW5h?=
 =?utf-8?B?US9Hb0M1azM5SlozcFN4d0hKQUZXZHZEcTJLYUJYMTlkWUdNbE5PWG5QSGp2?=
 =?utf-8?B?UTJIdEZDZEw0SFhrWWU2bDBLSm9GRnRTcThEYTEybnpBUndtZU9Oa29yRXZy?=
 =?utf-8?B?b25ETW4vZEJhQTFCU0lHUlJlOVhUVElaQ01id3NiN3JVSEFwQkoreTg0bWk3?=
 =?utf-8?B?MGpCZ0E4ZkRXZ0w0dkJlczQxdUVSVlY1dk5QeHJYSTRjbk92NHdYc0h3RERH?=
 =?utf-8?B?aVJma3ZZUnVGUmppYjA2dUJtRDN4RVJMcjFTRHpZbmlMWW5xM0g2RTZQUDg0?=
 =?utf-8?B?MXNoQUs5bllnQWxYcmtBV1lOek9OdVh0R2N5dlhmT01ZYjFWbXZzakZHanNl?=
 =?utf-8?B?SmFwYmRONW5ueVFyZEFOTXJOOCtpWE40YVNZMzcvTEpQa0F0Z2NTNFp0Y3lo?=
 =?utf-8?B?bUs4Z01HSWx4Vm5sT2RJSEFTL0xwOWZQdXFuNFpTQUwzWktJeGJ0cHFxUFpQ?=
 =?utf-8?B?OWNLaWF3V3VsOXA5ZjV5VmpHYk9MdkYxWHY1WmFvTWZqREE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGJHRlY2NFdKVXdud09zajdQR1BSRkFXOUdaYW03d1pqVzlSM3ozb2lVcndx?=
 =?utf-8?B?ZG1XOVVFeDk0SHVBNjJmZWxTRnE4c1duVXgydXZNKy91U01KcnNKc09OenJG?=
 =?utf-8?B?VWxVZVdJRE8wb1JPUlBuYjhkUUdZd1FUUjZLdWFOeXoybUQrZDFGRXI0bFY5?=
 =?utf-8?B?V3NUZW5hZlVMVmJQUnkvNUFVSTA3U2gzT3hGSW1EWWtmZXlEbWNZbjdrTHlS?=
 =?utf-8?B?Zm9MSDRUNFpKdHlsM3NOdDZkazlmaFRxb1lWSkprOVFGNVAzWk11elJFQzRi?=
 =?utf-8?B?OUFXV2tOYnVOMHdHTk0yUGhobEJxdW8wL2p4eGtyc0VMUUlkMzA0dHNwbUth?=
 =?utf-8?B?d051cG0wZWVsMWpJcXgvQUFhamJlTTAvU2o5cTliK01rSlM2d2Z2dFZOZTRW?=
 =?utf-8?B?bzJRTlU3bWlUc2l2UW80SCtFa1hqZ2N3dEhhckJpbU9UZTBtamNDdGV4T1Av?=
 =?utf-8?B?OXExcmdZRzVnSituL1pHKzBmMzV0Yy9kYnBNenZnN2VNWGNXN0kwemJwMGg5?=
 =?utf-8?B?THRVUXJvQitiaXdqaXZMcEdDTm9hbHJTZmlrRk50QnMxRGhINm1xMzZvMU5O?=
 =?utf-8?B?QzA5YWRSNllJNFUwVjBKQ2thUHdiNlo3Kzl0eCtPdDhwS09ubCtOUG5YVVhZ?=
 =?utf-8?B?MENTMUNvdnl3NDl4TXlSM0hXYks2eGxLa29kbi9QY2pJV0lVSmZMZnVIYXpt?=
 =?utf-8?B?NTU4Yk1XMHovdTV2L043Z1VabC9sOU9BQjFBK0R4SWIwR1krM1kvc2xqcFgv?=
 =?utf-8?B?ejVlMGNZenczZ2pwWFFzYktueHdPN2tjSmdUSi92WTRmMmhlVnlsditSM0lP?=
 =?utf-8?B?cVYxenhpOXBWS2M0VnNTekpaaEZ4QnYyMm5hWStUOEhpWGxCRU5nU3FKbThT?=
 =?utf-8?B?cUhXeFdRRy9rYnRKUjR1OWQ2YjluSytwVlNRTjZzanMzZ1ZCcDlkaWJNNHUw?=
 =?utf-8?B?WURNR1ZOU2hCNXFDNDIxVmV4RExMTnBvZEV1UFYrY0FoWi92ZU9uQ0Y0MzZ3?=
 =?utf-8?B?bHRWVndETUlGOFdhYUN6ZkNQSy84TlBISjMwZ3RxTFZraldWdGwxUi9YM2VF?=
 =?utf-8?B?d0NTSjdxTFRVdTg2SHdYWExsU3lBdFBZQkJMcjM5TEV3RlJlNlE5Mk9FNEZF?=
 =?utf-8?B?L3FObUZmN1NLMjJ0RjVZY2xnZk92MGtnMklkYkJJWmhOMXhndFFFMnIyelp1?=
 =?utf-8?B?YzdtLzdwQmh6VHRPaE1RNW1zZitpYXhtRFBFTEgxSU5GQ3V5U3dFSWxnNWFO?=
 =?utf-8?B?TXRDbjFzbkpFRUpzemcvU0RqY1VVbFBtdytremRuU3FrdFhTblMxRE80Tlh5?=
 =?utf-8?B?QlgzOEJ6cmJUdFIrM2JpNTliQmY4NWh3di9wTDdpNkhzN2tKclVhbGNGQkhu?=
 =?utf-8?B?enR4TkdzZG1WRFhGVHlTWFRGQS9RTys5bS9iOUw0RE40bTV2T2FLL1NuS2tD?=
 =?utf-8?B?bFN3VmVkTXNFY1BEeVJManF3SkdSS1dBRkFTSkkva1BlZEhrbWtic01iU2h5?=
 =?utf-8?B?Q1pidU5pKyt5U3NsOG44VHJKeGw3T0dDeU4yL3NmalptZTJSSUFVMENjVzNH?=
 =?utf-8?B?YkNwYkJWbEl0L2xmSmNZS2tyek1IUXF2SHdYTHpDVTdxcjVDUFRvcDZQZ3dy?=
 =?utf-8?B?RDVQWHZQc3RoazJqeVNHS3pHMFhjc2c1cEg4NzVEWTU4ZFpRdmFMdW9WNjEr?=
 =?utf-8?B?SGhUVGh4YjZDNEp3MU1XV3JBN3E4NW5tZ3FKQ3g0UUpFZzRhRmdEOVR2OXBo?=
 =?utf-8?B?RG9SMnpJSjZKQzRuZjZJVnBKbnVnRDd3Sm42dEk4eE5SejRML1VETFpJNlFa?=
 =?utf-8?B?a0p0K1VuZGlvUVg0am1aZ0dLdndNVFQ0L24wN0MrakhxdmYzQjZSa3FQR3lT?=
 =?utf-8?B?TVhCbXBnWlZBZDZUckp5eGlVK2F6dWlZWmJTR1JsZmw0YmJNcFRuTldFOTNO?=
 =?utf-8?B?ZWVYSjRHdHN2TDVpYXM0WThFNnJQV2taVG5DUHRVcUFnZFhORVVjc2J5bUZV?=
 =?utf-8?B?WnoxbmtVVVRiNENoQWRTZW95VXlNUnpORFpod1ljSXFad0VZc2FGbURTei93?=
 =?utf-8?B?WEZsZjBFaHZWMUZ5aC91NVk1MEtLaHVsMUx6Y0dMSTJMeXJEVzRmR0NEa2Z4?=
 =?utf-8?Q?2RqgZLDw+bASLCGOiSZXTgHHb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc1bf70-b4a9-4e6d-7b6c-08dcb0659110
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 07:02:25.1230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UaHwF6JFQIIPSVsU2LNsLgnGp2wCfWTDvD20ElLov3F3T1heKOGre7MMzAm1SYEh+RgFMDF3vNORRY58frO3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9404
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

SGkgTWFyZWssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsg
VmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKdWx5IDI3LCAyMDI0IDQ6
MzggQU0NCj4gVG86IFouUS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT47IHUtYm9vdEBsaXN0
cy5kZW54LmRlOw0KPiB0cmluaUBrb25zdWxrby5jb207IGx1a21hQGRlbnguZGU7IHNlYW5nYTJA
Z21haWwuY29tOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjJdIGNsazogaW14OG06IHJlZ2lzdGVyIEFSTSBB
NTMgY29yZSBjbG9jaw0KPiANCj4gT24gNy8yNi8yNCA2OjAxIFBNLCBaLlEuIEhvdSB3cm90ZToN
Cj4gPiBIaSBNYXJlaywNCj4gDQo+IEhpLA0KPiANCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPj4gRnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+ID4+IFNlbnQ6
IEZyaWRheSwgSnVseSAyNiwgMjAyNCAxMDowNSBQTQ0KPiA+PiBUbzogWi5RLiBIb3UgPHpoaXFp
YW5nLmhvdUBueHAuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGU7DQo+ID4+IHRyaW5pQGtvbnN1
bGtvLmNvbTsgbHVrbWFAZGVueC5kZTsgc2VhbmdhMkBnbWFpbC5jb207DQo+ID4+IGZlc3RldmFt
QGdtYWlsLmNvbTsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0h2Ml0gY2xrOiBpbXg4bTogcmVnaXN0ZXIgQVJNIEE1MyBjb3JlIGNsb2NrDQo+ID4+
DQo+ID4+IE9uIDcvMjYvMjQgMTI6MjkgUE0sIFpoaXFpYW5nIEhvdSB3cm90ZToNCj4gPj4+IEZy
b206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4+Pg0KPiA+Pj4gUmVn
aXN0ZXIgQVJNIEE1MyBjb3JlIGNsb2NrIGZvciBpLk1YIDhNIE1pbmksIE5hbm8gYW5kIFBsdXMu
DQo+ID4+DQo+ID4+IFdoeSBpcyBNWDhNKFEpIG5vdCBpbmNsdWRlZCBoZXJlID8NCj4gPg0KPiA+
IEkgZG9uJ3Qga25vdyBpTVg4TVEgYW5kIGl0J3Mgbm90IGluIG15IHdvcmsgcGxhbi4NCj4gDQo+
IFVoIC4uLiB3aHkgYXJlIHlvdSBhZGRpbmcgdGhpcyBwYXRjaCBpbiB0aGUgZmlyc3QgcGxhY2Ug
Pw0KPiANCj4gSXMgdGhlcmUgYW55dGhpbmcgKGRyaXZlcj8gYXJjaCBjb2RlPykgd2hpY2ggcmVx
dWlyZXMgdGhlc2UgY2xvY2sgPw0KPiANCj4gTVg4TShRKSBpcyB2ZXJ5IHNpbWlsYXIgdG8gdGhl
IHJlc3Qgb2YgdGhlIE1YOE0gZnJvbSB0aGUgc29mdHdhcmUNCj4gcGVyc3BlY3RpdmUsIGFsc28g
dXAgdG8gcXVhZC1BNTMuDQoNClRoZSBpTVg4TVEgY2xvY2sgZHJpdmVyIGhhcyByZWdpc3RlcmVk
IHRoZSBBNTMgY29yZSBjbG9jay4NCg0KVGhhbmtzLA0KWmhpcWlhbmcNCg0K
