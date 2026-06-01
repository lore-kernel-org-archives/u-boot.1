Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AAECD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D34184910;
	Mon,  1 Jun 2026 15:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="cclBWmLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CA3084912; Mon,  1 Jun 2026 15:57:35 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BED8B846E6
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETP63sohhmQWCAdLDrHNuUZvdiWZgusCgsyctZClnfnV8X/hKtPFZDsJrEUF5hfhylEwMb3qNUSlYQYJmoZd0dM8PzH7yRVYzhGpIJeQlkDRa1wiRZFEEgqn6mArVSTcM8NaoldEYILH1WYRFaOW9tIqCF0uU5CDz7ah/l+n5zSsCw41scEaNlCFI49W0oLhROxi7vOqCp+TWKX94920uQpH/yXEFVPKMQbNUQuAjS/QQaPCjEISk108lbyHXx9AUh1ObO8ZwMgPSIYgFwjzFICpZkkWTGNCLzjU3jsn34i662jXnOocs0wJ37bgccZRYWPvyRQmDj+jgKOxVOyk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYQgzF4Cy98vlw0IEwpmTXVMzzrdMDoBuLQeCQMfSOQ=;
 b=JBtMmuCdHGcFJiiLepuHTONs0WqJtmHBOFrBg1hoe0qF/c/s8FkYOnFar7lr8d47w3gyRwDFgb/3EUZd5l/zCc45NaWk4xT4Nlsj5Bto3JqBN8F/6pvYSIcBc4iAA35Jngq4KS8DoWdzkbDvZ+epxXoNL82kDIPKKNafC19iMAauTJMDarDO51naqhTnSK+09e+3EPUje8hg8ypZiop8jJ+pm5L6hrPnwW/THZ2e3iBBqC0HYwHC7nPeueXIInqo8FL13Dwz7BrmzHUr8XnW4pEQ75UxEHMeztP8cf9UEyFZ/D8mfFttJ/sSJrTP9b3Y9BqVtCMcml4zWcxU4wRDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYQgzF4Cy98vlw0IEwpmTXVMzzrdMDoBuLQeCQMfSOQ=;
 b=cclBWmLNEsJoWiwwpKX5tAZMlt5exrTi1tWt+NBfgz8GhDHLNAG2JJEkEZq+ZJwQBl82D3q32EtyLZ5H/HDTWHIU4+I2iHc4o51nbl6Qti+2Mq2MzqpMoy2JKOeww2L9GVLk3b0nYz7qyZTkIlvcvtb1COyAyEreNyJiQ1c9DHdap+0z/lPvl30l6Jbs8nkhCuSy6EVuXgRw0eaFJRViQwffm2tEBXsFtnMG0ZIPo5a9h2hzFQZEBzvy55XhaDVNwr8mEGBAJFKVRhl16jJqT3sofDai26oz1oDkEI0yTK/Z2SReDf3cClZ9OJauM+/kbynHpCb3y/fa/Sf+dZaZGA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB7986.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 13:57:30 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 13:57:30 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "aristo.chen@canonical.com" <aristo.chen@canonical.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "vigneshr@ti.com" <vigneshr@ti.com>, "p-bhagat@ti.com" <p-bhagat@ti.com>, 
 "c-vankar@ti.com" <c-vankar@ti.com>, "m-shah@ti.com" <m-shah@ti.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>, "dannenberg@ti.com"
 <dannenberg@ti.com>, "mkorpershoek@kernel.org" <mkorpershoek@kernel.org>,
 "n-francis@ti.com" <n-francis@ti.com>, "s-joshi@ti.com" <s-joshi@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "afd@ti.com" <afd@ti.com>,
 "sparsh-kumar@ti.com" <sparsh-kumar@ti.com>, "semen.protsenko@linaro.org"
 <semen.protsenko@linaro.org>, "b-padhi@ti.com" <b-padhi@ti.com>,
 "glaroque@baylibre.com" <glaroque@baylibre.com>, "anshuld@ti.com"
 <anshuld@ti.com>, "d-gole@ti.com" <d-gole@ti.com>, "w.egorov@phytec.de"
 <w.egorov@phytec.de>, "patrice.chotard@foss.st.com"
 <patrice.chotard@foss.st.com>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "vishalm@ti.com" <vishalm@ti.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "bb@ti.com" <bb@ti.com>,
 "a-limaye@ti.com" <a-limaye@ti.com>
Subject: Re: [PATCH v1 1/4] arm: k3: select tifsstub via
 board_fit_config_name_match
Thread-Topic: [PATCH v1 1/4] arm: k3: select tifsstub via
 board_fit_config_name_match
Thread-Index: AQHc7qXeo5uuoDtPqkOCQg7TV2EnFrYpv92A
Date: Mon, 1 Jun 2026 13:57:29 +0000
Message-ID: <ceb5c957137128e8a003616616755ffdb91b0c42.camel@siemens.com>
References: <20260528132746.719699-1-aristo.chen@canonical.com>
 <20260528132746.719699-2-aristo.chen@canonical.com>
In-Reply-To: <20260528132746.719699-2-aristo.chen@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB7986:EE_
x-ms-office365-filtering-correlation-id: 3ef262f8-4354-40cb-4a1b-08debfe5b8a6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|55112099003|38070700021|6133799003|5023799004|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: ay25xwY6hz/luvMYTf+QlEcyFMZphjXVsAGVL0UhNd27B7OI8X8ApA7KbDF3wfZ3x5mjETpVMH1czKn7IXvZ2MIjKLsXSFAtcbTl0Uzi9oQvecEPv4QY5z0izUpyYe7n4fiGw13ZklM2LEVq0wfCkWDqCpdb5s0sl/BFVS6In9/8KF5x6jxqwCJzkkyWot4HriQZxhluwApcqDmrO3cCK0x5avIM1UG2yfIjT15nwNM8xCpUdG1ONxKc8QrP5YSwcdVMrmjcuLP5EizPwH0V6dfrPae6EQ3E3cmfFWkIebyXrpSbBzEJO4fs0OOMDA7b9TwcQUnRRNa5fF0x2Nb3RcirZT3sMlmEX8B6LHEuIwPYY/BtQa/6wNOwo8QIxcq0xcuukEHlLoS6Ncdk0rVIYgYinvfmJsIyI3BCwR5ennQnzUQCQGQu8ApIROqhIvWeLg5X29ya9dlQW6l06pdeSardM/jNpkV0lZggC3FCQQLm+qK7g1mOKceThB39+dgCNIFIMb4x5coDxXC4PdWjC3hxztDMLSOzkWku25it/eRcu2fWBtbh4YyVheWevZjAcfDBrGqlWDQkIU+cJ1TQdIfaQCKrmXEuEP8ZSNaRphuHyrS8ZRPoQ0Qg4sXh7Xp6OIpk42eN5bsVkWek4842C3pYMQw/yHuZB1B3XaZxIicPgkYyu9xHiB/8E0/eJ6B40XRcfOhEq3i/rI+4o1OdRw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(55112099003)(38070700021)(6133799003)(5023799004)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDlvQWljREFQWnROVEYwejU4SW1jbHpBd2Q3cFBZeldRb1VRdlI3UkZTeFlm?=
 =?utf-8?B?QVU5eFl2K09ubmo5Y0lZNXYrUHlyR2g5Nmt6aUJObm5CZjNkL3hlbXZiZ3lE?=
 =?utf-8?B?aWJYSUwzSFgrOGlFUDV6RFZ4MGIrVXJNUzBJRzRkbWpPb283MUVyYm8yNnI0?=
 =?utf-8?B?UnhaNjM4a29GVG13RmVwS2hjYjhncTErTFBvWkwrZHkzMHVpNjhlbHFVU0xT?=
 =?utf-8?B?bWpiWDF3UTQ5K2kzZXZsNXczMTlHNHQyZXpKeXBqRjA0SkNiUzBnRkN1OEdo?=
 =?utf-8?B?cDZBTzlSNWF3MURuRTJPSzVyMVluc0xyUDd0OHFwQ25UR0owMHFVcWZ2cE8x?=
 =?utf-8?B?TldwaDhwZk13QUNHeTFrRTM3QksyTldrWlA5blczMGt4VFNhdU9mVGV5RVdN?=
 =?utf-8?B?SVhvNWE1UzFKTm9YaVhBQnNuSUdyQ01yM1VueHdRZFU2SmpaWnBOVXdmSmxj?=
 =?utf-8?B?dUs4b1FCWjhzN0FoWm9VQkkyaGRvK0Y4Uk96NTFxNy96Q2VNM2kySklpazFD?=
 =?utf-8?B?ZGdyNTZ2L0NJMXZlQUM4U3AwODRycS9xOUc2WlBRdUxIWlcxMGxyYUVubUNw?=
 =?utf-8?B?V0dCZlNQazVIaXcvdEZPa29HWEdhaHNUTjhpbllwQmdiMnU5MXhXL1gyam4y?=
 =?utf-8?B?RHBmNFQxNXNINTNEcUZsc1JiUFN1TElIbDFtT1ZtaGVzb2t3TURDQmNOcjJk?=
 =?utf-8?B?c1NKQVRqOFJ0SkNCL2w5bzRTUHpNM1JEMkFldGhoa0p4SisrK096eVZSSXBq?=
 =?utf-8?B?U2ZHMmRCT1p0WjVjbG91angxaVFhazFYcVplci84U0Y4UWtBRlYyeDFtUHhp?=
 =?utf-8?B?bUdQUkwwZFI4VUxiYVF5MEg0Ry8yT0pla1hOaFI0OWkrVWc5QlhIVnkyRnFT?=
 =?utf-8?B?VFlJSk1KWGNXazgzVlV3ODJ5VUZ4WForWC9TdVR3bXZocUsxeUlHOXpUelA4?=
 =?utf-8?B?cGlqNXB3YWdLSWUyR1pTaVgrdjcxTUxVODhsdzRla3BodUxPVGtUdmkvOStM?=
 =?utf-8?B?amlwQXBkRnJkQnoyUGs4eU4wajM2Z0tBUzN4N09temVvTU5GVCs2Q3NQb0dN?=
 =?utf-8?B?YVBRMTl3alBlQ21rS00rMlYvRlZpUGtXU0pIaTc0ejMxeHUySFBNVGRQZkFG?=
 =?utf-8?B?azkxM0o5dnVpUlJ2OURudUJqWU9rQjlQZ0dGbFRhZFRkSDJpQW92NC94Y1Ax?=
 =?utf-8?B?djhLVHRWdzNNdzl6WGxIS1hwVEREU3RTTEVPM1ViNXBPeUV5dzhDU0gzR09O?=
 =?utf-8?B?K1FSdEluNmZTZUp5dm54RGVtSDUrN09OSjJRaTZoRlV0cVdHVFlBVmJGQmNm?=
 =?utf-8?B?em5zeUJzZU4xVXc2aXR1VnJJcGxFcVZXWEdNUmxLbU9uUWpBU0oyWEV4UEtL?=
 =?utf-8?B?TEhUV3p5M2RERkdBOWZhbGVKaWthTi9TRG9EMVJXSFZVSlE5Vnc0Z2NyOHVC?=
 =?utf-8?B?YldzbTNPblN4VXllQ0VaajhxTXZEZ2s5RUxYYmtUbzJoK005OFc1ZWh6WmY0?=
 =?utf-8?B?dXVQQmw3Q0tTSWJpNzFSeVdkU1RVWjdUUThucGRPT1A1amdTTEFpVGQ0dXlK?=
 =?utf-8?B?VUZWWWtXMWRCT2JQNjQ1aGJFYjBlK3ZGeTFSUUFPeS95c1FPMXJQUmVaOWM2?=
 =?utf-8?B?NCtqTVg4RjQ3OTJZQmpXT0tDMFJuL2ZFV2p0UkVNYjhtQlNJOEJxV3V0M2Fw?=
 =?utf-8?B?L2FDZGlTbzBpM2xSTWZHZkVJU0JFK2NDNUp2ZVkvWGVoM1NQTGp2T2pGakZ2?=
 =?utf-8?B?RTh4RDdGNU5uQnJJQjN2WFFiazFROWI0WDNiKzVQSy9nMEVWNElIbFlZWUow?=
 =?utf-8?B?MFhQTGpjZjFISjIzSE1haXFPakEvMTFFalYvc0NkOTZQck9jUjh6LzA0NFl0?=
 =?utf-8?B?SWlQbFQ2VTdsM0tFZldTVnEybU9XMjRlckJtN3MweE5KQzloTUJCQWp1WDNV?=
 =?utf-8?B?VDd4Z01NTWNLRVA4dUN5dkxoemxPYmQyWkh4RjV3SUJIaXpNVWxDNnFNcW9o?=
 =?utf-8?B?WVJHWXZaSmpuTjhNYmVES1YrY1AraEFvRFFnaVB2MjZhSG03c1FxRlpvb2VQ?=
 =?utf-8?B?djcyY0x2TE5HSHdMbm42NGhTNFBRVkx6SnRGdGRCVTlEaDZjSEh2U2pkbjlh?=
 =?utf-8?B?OWY1SnpGYnp4bmVzMDhFUHBicy9ZMnNqSkdPMGxJRG4ycFRxcHp6VFU5VnB6?=
 =?utf-8?B?NmVLeWlKRHI0dVMxYjFnR0c1ZG5lNVdOc1VtVko2Q1g2QWpweFd6OGtrNmt5?=
 =?utf-8?B?M1dVYmxWZ0ZZMkFFbFRjK1RTaXZLS2d0Q2FiN0FHb1FDMi9lVXNrS1N3ZHRK?=
 =?utf-8?B?UC92TUEyTU9hWTduQjBZTDdiTnc2VUZPanlnRWRieXU3Wk04WG1BTHBvOEdC?=
 =?utf-8?Q?KyRmZ3LZJd+/QqPI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CC1BB7D1CD4F941A1ECB0CAB091A620@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef262f8-4354-40cb-4a1b-08debfe5b8a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 13:57:29.9031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gsteEoH3ARxh49WAmqOS2qT5elFcSV03x0HNQ37NGp965ACaH4ER/2rEN0O0NKEDpDswcTS4rWTl2Z2cssc46zfvE634cBJriReqblERvMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7986
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

SGkgQXJpc3RvLA0KDQpPbiBUaHUsIDIwMjYtMDUtMjggYXQgMTM6MjcgKzAwMDAsIEFyaXN0byBD
aGVuIHdyb3RlOg0KPiBUSSBLMyBBTTYyeC9BTTYyQXgvQU02MlB4IGJvYXJkcyBjYXJyeSB0d28g
b3IgdGhyZWUgbXV0dWFsbHktZXhjbHVzaXZlDQo+IHRpZnNzdHViIHZhcmlhbnRzIGluIHRoZWly
IHRpc3BsLmJpbiBGSVQgaW1hZ2VzLCBhbGwgYXQgdGhlIHNhbWUgbG9hZA0KPiBhZGRyZXNzLiBU
aGUgZXhpc3RpbmcgYXBwcm9hY2ggbG9hZHMgZXZlcnkgdmFyaWFudCBhbmQgdGhlbiBkaXNjYXJk
cw0KPiB0aGUgd3Jvbmcgb25lcyBhdCBydW50aW1lIHZpYSBhICpwX3NpemUgPSAwIGhhY2sgaW4N
Cj4gYm9hcmRfZml0X2ltYWdlX3Bvc3RfcHJvY2VzcygpLiBTd2l0Y2ggdG8gc2VsZWN0aW5nIHRo
ZSBhcHByb3ByaWF0ZQ0KPiBGSVQgY29uZmlndXJhdGlvbiB1cCBmcm9udCB2aWEgYm9hcmRfZml0
X2NvbmZpZ19uYW1lX21hdGNoKCkgc28gb25seQ0KPiB0aGUgY29ycmVjdCB0aWZzc3R1YiBpcyBs
b2FkZWQgaW4gdGhlIGZpcnN0IHBsYWNlLg0KPiANCj4gYm9hcmRfZml0X2NvbmZpZ19uYW1lX21h
dGNoKCkgaXMgaW52b2tlZCBieSB0aGUgUjUgU1BMIGR1cmluZyBGSVQNCj4gY29uZmlnIHNlbGVj
dGlvbi4gZ2V0X2RldmljZV90eXBlKCkgaXMgYSBzaW1wbGUgcmVnaXN0ZXIgcmVhZCB0aGF0IGlz
DQo+IGF2YWlsYWJsZSBhdCB0aGF0IHBvaW50LCBzbyB0aGUgc2VjdXJpdHkgc3RhdGUgY2FuIGJl
IGRldGVybWluZWQNCj4gZWFybHkuIFRoZSBtYXRjaGluZyBsb2dpYyBpcyBmYWN0b3JlZCBpbnRv
DQo+IGszX2ZpdF9jb25maWdfbWF0Y2hfc2VjdXJpdHlfc3RhdGUoKSBpbiBhcmNoL2FybS9tYWNo
LWszL2NvbW1vbi5jIHNvDQo+IGl0IGNhbiBiZSBzaGFyZWQgYnkgYW55IEszIGJvYXJkIHRoYXQg
d2FudHMgdGhpcyBzY2hlbWUuIEl0IG1hdGNoZXMNCj4gY29uZmlndXJhdGlvbnMgYnkgYSBzdWZm
aXggYXBwZW5kZWQgdG8gdGhlIGRlc2NyaXB0aW9uIHN0cmluZzoNCj4gDQo+ICAgLWhzLXNlICAt
PiAgSFMtU0UgIChLM19ERVZJQ0VfVFlQRV9IU19TRSkNCj4gICAtaHMtZnMgIC0+ICBIUy1GUyAg
KEszX0RFVklDRV9UWVBFX0hTX0ZTKQ0KPiAgIC1ncCAgICAgLT4gIEdQICAgICAoSzNfREVWSUNF
X1RZUEVfR1ApDQo+IA0KPiBDb25maWd1cmF0aW9ucyB3aXRob3V0IGEgc2VjdXJpdHktc3RhdGUg
c3VmZml4IChlLmcuIHUtYm9vdC5pbWcpIGRvDQo+IG5vdCBtYXRjaCBhbmQgZmFsbCB0aHJvdWdo
IHRvIHRoZSBEVFMtc3BlY2lmaWVkIGRlZmF1bHQgY29uZmlnDQo+IG5hdHVyYWxseS4NCj4gDQo+
IEVhY2ggVEkgRVZNIGJvYXJkIGRlZmluZXMgaXRzIGJvYXJkX2ZpdF9jb25maWdfbmFtZV9tYXRj
aCgpIGFzIGEgdGhpbg0KPiB3cmFwcGVyIGFyb3VuZCB0aGUgc2hhcmVkIGhlbHBlcjoNCj4gLSBi
b2FyZC90aS9hbTYyeC9ldm0uYyAgIChBTTYyNSBTSzogaHMtc2UsIGhzLWZzLCBncCkNCj4gLSBi
b2FyZC90aS9hbTYyYXgvZXZtLmMgIChBTTYyQSBTSzogaHMtc2UsIGhzLWZzLCBncCkNCj4gLSBi
b2FyZC90aS9hbTYycHgvZXZtLmMgIChBTTYyUCBTSzogaHMtc2UsIGhzLWZzLCBncCkNCj4gDQo+
IEZJVCBjb25maWd1cmF0aW9ucyBhcmUgc3BsaXQgcGVyIHNlY3VyaXR5IHN0YXRlIGluOg0KPiAt
IGFyY2gvYXJtL2R0cy9rMy1hbTYyNS1zay1iaW5tYW4uZHRzaQ0KPiAgICh0aS1mYWxjb24sIHRp
LXNwbCwgdGktc3BsX3Vuc2lnbmVkOiBjb25mLWhzLXNlL2NvbmYtaHMtZnMvY29uZi1ncCkNCj4g
LSBhcmNoL2FybS9kdHMvazMtYW02MmEtc2stYmlubWFuLmR0c2kNCj4gICAodGktZmFsY29uLCB0
aS1zcGw6IGNvbmYtaHMtc2UvY29uZi1ocy1mczsgbm8gR1AgdmFyaWFudCBvbiBBTTYyQSkNCj4g
LSBhcmNoL2FybS9kdHMvazMtYW02MnAtc2stYmlubWFuLmR0c2kNCj4gICAodGktZmFsY29uLCB0
aS1zcGw6IGNvbmYtaHMtc2UvY29uZi1ocy1mczsgbm8gR1AgdmFyaWFudCBvbiBBTTYyUCkNCj4g
DQo+IFRoZSBydW50aW1lIGZpbHRlciBpbiBib2FyZF9maXRfaW1hZ2VfcG9zdF9wcm9jZXNzKCkg
aXMgaW50ZW50aW9uYWxseQ0KPiBsZWZ0IGluIHBsYWNlLiBJdCBiZWNvbWVzIHJlZHVuZGFudCBv
bmNlIGV2ZXJ5IGJvYXJkIHVzaW5nIHRoZSBBTTYyeA0KPiBmYW1pbHkgZHRzaSBmaWxlcyBtaWdy
YXRlcyB0byBwZXItc3RhdGUgY29uZmlndXJhdGlvbnMuIFRoZSBkdHNpIGZvcg0KPiBwaHl0ZWMg
cGh5Y29yZSBhbmQgdG9yYWRleCB2ZXJkaW4gYm9hcmRzIGlzIHVwZGF0ZWQgYnkgc2VwYXJhdGUN
Cj4gcGF0Y2hlcyBpbiB0aGlzIHNlcmllcywgYW5kIHRoZSBub3ctcmVkdW5kYW50IHJ1bnRpbWUg
ZmlsdGVyIGlzDQo+IHJlbW92ZWQgYnkgdGhlIGZpbmFsIHBhdGNoIGluIHRoZSBzZXJpZXMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBcmlzdG8gQ2hlbiA8YXJpc3RvLmNoZW5AY2Fub25pY2FsLmNv
bT4NCg0KdGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUgYW5kIG1ha2VzIHNlbnNlIHRvIG1lLCBi
dXQgSSBkb24ndCBoYXZlIGENCnNldHVwIHdpdGggVElGUyBzdHVicyB0byB0ZXN0LCB0aGVyZWZv
cmUgb25seQ0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3Zl
cmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+ICBhcmNoL2FybS9kdHMvazMtYW02MjUtc2st
YmlubWFuLmR0c2kgICAgIHwgNjEgKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ICBhcmNoL2Fy
bS9kdHMvazMtYW02MmEtc2stYmlubWFuLmR0c2kgICAgIHwgMjggKysrKysrKy0tLS0NCj4gIGFy
Y2gvYXJtL2R0cy9rMy1hbTYycC1zay1iaW5tYW4uZHRzaSAgICAgfCAyOCArKysrKysrLS0tLQ0K
PiAgYXJjaC9hcm0vbWFjaC1rMy9jb21tb24uYyAgICAgICAgICAgICAgICB8IDI3ICsrKysrKysr
KysrDQo+ICBhcmNoL2FybS9tYWNoLWszL2NvbW1vbi5oICAgICAgICAgICAgICAgIHwgMTAgLS0t
LQ0KPiAgYXJjaC9hcm0vbWFjaC1rMy9pbmNsdWRlL21hY2gvaGFyZHdhcmUuaCB8IDExICsrKysr
DQo+ICBib2FyZC90aS9hbTYyYXgvZXZtLmMgICAgICAgICAgICAgICAgICAgIHwgIDggKysrKw0K
PiAgYm9hcmQvdGkvYW02MnB4L2V2bS5jICAgICAgICAgICAgICAgICAgICB8ICA4ICsrKysNCj4g
IGJvYXJkL3RpL2FtNjJ4L2V2bS5jICAgICAgICAgICAgICAgICAgICAgfCAgOCArKysrDQo+ICA5
IGZpbGVzIGNoYW5nZWQsIDE0NiBpbnNlcnRpb25zKCspLCA0MyBkZWxldGlvbnMoLSkNCj4gDQoN
Ci0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
