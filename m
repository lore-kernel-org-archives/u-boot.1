Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6332FC43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 01:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7DCF84CBF;
	Tue, 14 Jul 2026 03:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.b="sj3Kz7Y3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 888A084CA1; Tue, 14 Jul 2026 03:36:09 +0200 (CEST)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com
 [185.132.183.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB5E184B51
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 03:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jacky.Cao@sony.com
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DNoBop2980721; Tue, 14 Jul 2026 01:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=p1; bh=gkhXtbI
 cM/FQ7Oy/TkMX4oXCvar3wGqpXkLMP0yinuQ=; b=sj3Kz7Y3Xl8z3zwUMP34Knt
 8zGVtc0K2/5F2Lo8ACSG6X0HgOCWMNbCg+A1V7KpPRDK/i6rTIVXFysN7stsxIPB
 JoXZ8lCiXNSKXvv8vfvvl4utoGk//MnOMPxTgEWCGpJLPGHIWolLhRkkx8l72CX1
 Pn+dD+3Uwd4etTa4kytHOE+xIgozrzbdM92W+qBOm79jMMp29s8kn4rpi/Gm1nZI
 2piG/9rU1Q2SdzZQd4LP2LHkQL9dk6E11mcrjh+S/KVsp2J1wlXZvoa7/09C8kc1
 wEUdoXB5G/z0R9O1DYV4jNsO8Af5kOOvBxK0OSsqje/xTDziLW5iWuvsMICtlJQ=
 =
Received: from tydpr03cu002.outbound.protection.outlook.com
 (mail-japaneastazon11013000.outbound.protection.outlook.com [52.101.127.0])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4fbf0gjvfg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 01:35:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMfeKgMr0dTMx78/G7u6lWWYyatgMqRdqs07XVKm/GafVRgOZKU+wuXwD1zZJ447ofRaP1555w/6bbBScA3yuNiIqYRlMdeyQcLIZDzHMLlBB2HLUCzkq8B2ujzv/6OdRElqGLgogPIcmBqrOM/7GsAwYxIV5LifPQhJ5Wrrits7yIyi6+GqurAL/u2Vszp28W5lT8EdjMZeIbYY9XmcXm/QcNl5F96XIlNWjDC5OMWnfGgNiXAP6uyAgiArmeybIlzR7Wc6v2bdv4V2yKGbGNWkU9vGXiw/Sf8BELZicQKBJ3JVix+PtqIe4xd7XsoVBRcAMmrWvEL883iru4SDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkhXtbIcM/FQ7Oy/TkMX4oXCvar3wGqpXkLMP0yinuQ=;
 b=PDbR1b68/yTyEXz5JToPtYQLFjyv/tBSubvrf8mbPxM4ZRQ825qWzzkfKPl05BA81RZXrl13QsUj23B4gsrhel4zd5BCvpmCG64GjgDmKAsfA+xTeJ64N2u+BmNrV2qev2UOo6/uSMHQnfCysGdqYw8K2OEZnmd1ABhhXufcDPFP5meBEKsA913o3JecTigvS8pjyzhKANb+Lj7YPi2K1S2WaPHAIwoQNE0Ejmnm3SCEupQR56+JqlG+19FoALTFKBo6gy+9t7pgc7d3oZt64VRe4tN3wqPYYokSDbBk18/iZFY/5fmkmE+o42Crve4RoF4ljkaaH/rO3KX8kOF0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from KL1PR04MB6734.apcprd04.prod.outlook.com (2603:1096:820:d8::11)
 by OS8PR04MB8353.apcprd04.prod.outlook.com (2603:1096:604:2b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 01:35:42 +0000
Received: from KL1PR04MB6734.apcprd04.prod.outlook.com
 ([fe80::6812:7cec:2e9c:ad96]) by KL1PR04MB6734.apcprd04.prod.outlook.com
 ([fe80::6812:7cec:2e9c:ad96%2]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 01:35:42 +0000
From: "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "nora.schiffer@ew.tq-group.com"
 <nora.schiffer@ew.tq-group.com>, "Steffen.Doster@tq-group.com"
 <Steffen.Doster@tq-group.com>, "alexander.feilke@ew.tq-group.com"
 <alexander.feilke@ew.tq-group.com>, "Max.Merchel@ew.tq-group.com"
 <Max.Merchel@ew.tq-group.com>, "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>
Subject: RE: [PATCH v1] env: Fix compile error for envtools
Thread-Topic: [PATCH v1] env: Fix compile error for envtools
Thread-Index: AQHdEqINARnpMVEBj0S9fvVbX43Nz7ZrP/JwgAD8eVA=
Date: Tue, 14 Jul 2026 01:35:42 +0000
Message-ID: <KL1PR04MB6734F919E17C467C8B29DBD787F92@KL1PR04MB6734.apcprd04.prod.outlook.com>
References: <20260713083141.2772971-1-Jacky.Cao@sony.com>
 <MRWPR04MB1233021A0AF8D2117DBE5984888FA2@MRWPR04MB12330.eurprd04.prod.outlook.com>
In-Reply-To: <MRWPR04MB1233021A0AF8D2117DBE5984888FA2@MRWPR04MB12330.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR04MB6734:EE_|OS8PR04MB8353:EE_
x-ms-office365-filtering-correlation-id: 6ffc7958-8c14-4d78-5d1b-08dee14837fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|4143699003|56012099006|11063799006|3023799007|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: npfPyocK9hIDf6AAo+MRK1EO6k0RR1TY7DeEhPRrOBP0o8NY8gNlFyfcLEKUB6IHRC3OCXMnOSD3TyJAg1N3bhn3LTIxsiVS9bvXmK/MQm6Rk5/z5syI6NLDk5yuigFjuRIw7LPTRgyh7vMRkj37dRLrEXOrOXoJeWA/UjUvC/Usk4FHSkwPqmi4qRPOfqChuqpGXkW1+L2ppCw5bNgco9u4GMVaUxILwyH5XvmYwAK3lAre9ZQzJvgwuQyVDf7iQpj+oYQiKw9uGx5epA5hJRK6TsY4gGXWmGCnO+4MBBm8+Aq9Ho4+3/NCRGR7tuEEfPW+YVfEB+Pk0a1Gi3qoXBd2MadpnE3h+6EqnjFf76GSc882TpbwC2BwGSsFlpFNRm8vG6HgIXLI4yHtZuWsjMma0EW1ZykNKmBwvGUCc/HnhMvqOSa52JthOun0pcqivwF7D9J8LJ2y07G1vIzIqj5h6ecBHTvH8U1i6Grh1gKy1ywu08+zIVT3Afd7LylBkrecYjBLgUkBcSS/WHQC2jZk+rWBe9GlrKJ2Be9SL3l47NFKYhzR/ydBkvIwbnSgbR+ZoDzdQpd1lENw8vKdRNbWPOmp2aRzNwCXDXGDTQmSmfnoO+a8CPb0Mule23gkghsoIiPson9MJ58uJ5U7dAKhh4qqtAT02cg7EvtkpATLOBdcALG7YvTbMtaXW9znkF4x6teX7lTzfyBCLLF2j1sXCsHISy+s5a60z6zJzVA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR04MB6734.apcprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(3023799007)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHdpZXdGRHdHVUNwdVFST0VtYkdjTlh0QlJoVkt2YW0weUR2ekNkNEpUVnlM?=
 =?utf-8?B?MW1vbGhPQU9XSU8zQXppSlppS0FoNWttSFdtM3pEVVUrVUJqM1p4K0xUWUpP?=
 =?utf-8?B?bS9kUG55d3pFSVhzdXBGNG4yNkQ1MGZIZWhSNXhXeEo1YlFoMUcrWmh5ZDBk?=
 =?utf-8?B?TXlJbkt2VDZ5dEdqLzcxeGdNMldXSG1IS256ZHpjd29TekpFTkNjS0RVTFYr?=
 =?utf-8?B?TFpMbm9JbE5Nayt0aERpSDJneStZRW0xeC9BcGJRd0l4cGtWdlpEME9aNXZL?=
 =?utf-8?B?d0x1QkVBRFVUaHRmeXNqYzhpYk5uMUEvbmJySGNZZWJrbmhUUTlqNUJlR0t6?=
 =?utf-8?B?c0pHczlaa0luWEVNcGlubXR0TEo3dmQrU3QrSEIrdkFMb0dqY2syekdiemlp?=
 =?utf-8?B?bjcwZEp5K29CN3RDSWZNeU1qaTFXM1pCNkpuM0s2WnNndG1Rc2pzU3c5czND?=
 =?utf-8?B?TnNwNFZzOUR5NGdIYlFaUmJhcmNFb2VtU29URHJNdGJMYk5rdVQ3SjlGL3Fy?=
 =?utf-8?B?VE43ZFlicjI5dzhnaGhRYnZGMHVVcWwyRlp5bHhWaVVmQklHYjg4SElXL0c5?=
 =?utf-8?B?djZwWmg1WElNY0hmMmNHQ2J5RnI1aHhHY0orWU5QS29MaFVDWW51bWFHSWsr?=
 =?utf-8?B?NWZsUUw5WXk4SkxUTVNBZDU5d2s4a0MxVitJRDFMOU52ZUdwaDVjT0J0dzk1?=
 =?utf-8?B?YWJqU01KNjBtenlkbUsxcHo1d1lWK2xoaXY5SFFKelBUalV4OGtoaXNLdGVB?=
 =?utf-8?B?ME43dTd2ZCtWUThTWWVXYWthQ1FQRmxtMmlXL25wREJNWUV0dERkUWVlT2xi?=
 =?utf-8?B?dys2a1NnRUZJQ08rNUpvbUs5c3NmcWpMeWthdURzLzRSbWJkZk1zVnUwaHJl?=
 =?utf-8?B?Y0h6N3NSb1dNZnBReXRLSE4xWlZzQjJneHc0NHViWDN3anU1bnYxNHdEVTFY?=
 =?utf-8?B?WXhHR21zYVQyV3lzZ0Z3cWNJcFJJdllxajNIYzRTMERBZXZtZkhNd2kyUlIw?=
 =?utf-8?B?Z2VEbmFiNzFHTzJoQjVQeVpBRXR6Q2l1dkpjbm1rSmUyMFhCS0tHaHJIQlJM?=
 =?utf-8?B?TXJPR3ZwMTNMb3pIaXV6YzV3SzdCWmhrUk5GS2RFYVU1S3hHQmpUdVNxZTdP?=
 =?utf-8?B?bngvM3NyRk9hVGZDQ0Y1dXp1bFd6Q3FJVllzVGhrNTNYMTEyc0hIRVBuU2lW?=
 =?utf-8?B?cUMvRkQ4S3NpT0VKR2RzbElTUk10WFc5Y09USHV4dUNFSEdUWVE1V3JwWS9h?=
 =?utf-8?B?VXJmR2g2RWYyS2FrTzJrVTZ2K21TR3lIWGd1Q1NsNC9VeTlLcTI1anQvK1dE?=
 =?utf-8?B?MGM2NXNQNjMxaHhRUlYwWWxmaVVaeWpnRnJ4U2pvMmFqeDhXYWhLQUREMS8w?=
 =?utf-8?B?dEFEWXovRm8xR1hNL2o5WTliVkNQTGZaWjRkMTkyV25mNFFZQUd4U1dGbnJ5?=
 =?utf-8?B?bHl4cmJudVozUklVekNyTmlNK1JBbFF2QlQ3VEVPL2ZyZitNbnFRS3Nqb0cz?=
 =?utf-8?B?LzF0TmcxN3l3cEtJa29teDdRN2JYSGdqRHVuSko0aGtNWVlvaW5uWW5wUXlU?=
 =?utf-8?B?RW5wUGN0NUV4SGJsdHhLYVJ5cHpUV0dFa25LQjRmNC9qZmNWeW9ZTHVFUGVt?=
 =?utf-8?B?ajhqNFBQVVFJZ284QTY1ZGRHYmtyOGRFVlpYcDkvK2ErWGl5NjE2QVVSa2M2?=
 =?utf-8?B?bWtMTzk4U3RkTjlTaDVjUkduVG9HOFIwWHI1MnFMY05ySDYrLzhWZkFlR3Bj?=
 =?utf-8?B?ZFNXUXVNRWVXdlpOaFhna3d0ZW5IUU4vVTdoTGxZUkdBTlZoRFFWQThtbXZW?=
 =?utf-8?B?akFrQWZza29JVnBOcGdlZnNHTXhlUXdYVVBGUEJjMXZwU0VxcWFHaVBUZWNW?=
 =?utf-8?B?S2lwWmlraGRlaEVBTEpTQW9VUmVKRVZScWk1TzN0SzFKb2g4dU8zWVVGd293?=
 =?utf-8?B?ZjcvZ1lLb2JGNzhiYnF4N3ZkejJXeDkxNEMxMms0OUVZN2h1ZlIrVU5pOTJa?=
 =?utf-8?B?QndGLzBrVkFYQnVkWnpjMnpDcUJWaGNBQnNrMm9taWJ2Tkx5dHFGMUlzdDVB?=
 =?utf-8?B?YWtVd0RJWXlCSzBvQkNTOHRoNVlJWldkS1h3amdpTkI5OTR3VzZDeXFSQm85?=
 =?utf-8?B?ZkJNbzUzVTdZZlhqL2ZPLzNwMVVrTTdCejkyUVRuZVZIbXB0SlY0d0VzWGVN?=
 =?utf-8?B?QmkxWjRhbzBMZDVhUFRldjk5c1RwdDgwS1hSTGdBQkg3RC9abitUa0pUMWt6?=
 =?utf-8?B?ODJDVTFpQ2pzSDQzdWlQMnlsZUZmVk4vRHVKaHJaNUM0NHJmZWpyR0dsVzlD?=
 =?utf-8?Q?i0fc0cf+ziH//JkS8r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Wipg4Jfuxt8dNVJ+CTgEEFd7NQ1dniEaPnKPbBljHmMS9X30KM9O4n/HRmcO76gWJzzLpmPdL0XaVr3oaKmWZSR6e0YamcKPCmadMZxlVd3pflzAw0B2nejn5qzGbWDqV+HQWZiG4vw7FZnYJZPx9mLrhOvN9sxD4T1p376PCG9zqp2q67ZF3jg8xj0oXE4vmn1Yu7Mrk1UIk3UWcEzBeBTeBxVBamrx74/S0RJUaL0sy6jVJql0XV5PIluZPpFFK1WFQEBkARpRL8Rp0QI2xuQkpFbkt8SjCPSSH5rmfv9prH8/eZfD5u+oISDFRZ/aRasj+iF0IYKoNc3r0r07sA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5dnUj+H5oAkn/4W4oWg+q36/jQn7A99Sc4qEnkNSQgtj+ddLyidMleZtH9+Y+g6IHLeqPGyFfiXw1n/1EWnCSqRWAMyo4NIm8ONDEgd6AgCPM7rfzAr3P050p+X1GFSafs2VzCcgIKYF/2gezN+/7MAL5ov83h3kv1X3B5m2dkkVfx7eOul1V9YxQX/lp23M6cxJ+7BX3LW1DS604tTdT2QO8qbYKdBnqE2NEDvUfYX8+ZIwO7DcDBbxy6Nw6ahB/i1F3wsDLatvLmLVLtN0C6XgesuxDJEYgEXysRy+Dj6Tqa+u61GkxzExHeepnD4QMKWugMNYohhwlRUjsNisaZV9b7QiXfmYaOJ1Tkekjjre7p7GappHOABhxPhIgGHFi3uew3MR/BnpnKKn0d602ib37UWwPWMdbqpZ+FjMAhWFvY5HZNCLGOEhS/lUeMx4pz1oKIrdbN0Rn/Ev7hs8tXCa/woX7UKOdhrH4sxXhBgjhR4FIWHyn9zXK69b4hsAG/12wq2f+M8JZHiwkJYIbzTjiCkiPldyVFYHxC0Mk7yac80Dl8JBwY9PcvwjXPx0fD/YKfRT3WFut9CTwc8e3VZsBCFLV3XI8YMVzu+QSuw0R0UPHDh72Z/TtGOGvZNE
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR04MB6734.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffc7958-8c14-4d78-5d1b-08dee14837fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 01:35:42.6156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2Vp6ZW3eBQvCHhDgd0oIOTa2xXQksAsJUjP1vB3ZRKbDNYsrgLTS0xCmMfP7hvZdBvNe40S0Bgi47+QKNyXWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR04MB8353
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAxMyBTYWx0ZWRfXw67j8P6PYHJr
 U21n40c5vUhpnZ1ix3w0JHFsZQpLFzfBnYLC59pbhRb0sg40QLNshiuiM/pCtXDvfIuBFFTL4PN
 ZE75PRbhFfT5nGBhxpHjmMwb05NbgG8kavsHtFdIdBjtWgpaQfrlGdwYRnqTzHud2zU/QKYrhGV
 R1ctlXURaSm/BIpQ4BZSKzmJGJBysxR3R3q81T9L3lVb6E7kXEfrEkWF7QV2JbAv9egSgmr6cQv
 620Zau7N6EcGvtAuwcZvFqPUS/hPh68fu8RpTdPEL1jYXiuSgd0c9sxvDptOMqgutC5XomYhu0x
 DRuTyw0sjK9Ymv9xkBG29OLcXneltJIxftCt0lBXN1Uhs+QCSIQijK4lPxqzsXbiPjmGE3CfdmG
 ratKEVEEDgAgQib6/i4TNjBkrCqDJIhv0FzItoGEL5mu3N9Fl1s82RmaI+NikhxKIZpXoaWZCvb
 1Rmx2/oiXByqmqKtE2A==
X-Proofpoint-ORIG-GUID: bT61D7VmkHC7UH-sg1dPFfhWEVNR5hJQ
X-Proofpoint-GUID: bT61D7VmkHC7UH-sg1dPFfhWEVNR5hJQ
X-Authority-Analysis: v=2.4 cv=DKy/JSNb c=1 sm=1 tr=0 ts=6a559279 cx=c_pps
 a=2f4GpZrjudwefLsJDHAgyg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=jHItnBwsj8f3cr25iGAb:22
 a=DaPTzHuCIAu_CI-N5vwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAxMyBTYWx0ZWRfX+dy0LA9ZVeiv
 3O9inD7ETzZwIhnC32qxXcy8bOz8uL4qSGbx9Rr4AOzFfDRBOF/jOgb+e8NJOZPo6sb7oj1EluN
 /poLH/wc7U7PJqxtlxW9OJ3FaPzTel8nG6bbsc552XA6NccqH2US
X-Sony-Outbound-GUID: bT61D7VmkHC7UH-sg1dPFfhWEVNR5hJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Mailman-Approved-At: Tue, 14 Jul 2026 03:53:38 +0200
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

Pj4gRm9sbG93aW5nIGVycm9yIGhhcHBlbnMgd2hlbiBidWlsZCBlbnZ0b29scyBmb3IgbXg2cXNh
YnJlbGl0ZS4NCj4+IA0KPj4gJCBtYWtlIHRvb2xzIGVudnRvb2xzDQo+PiAgIFVQRCAgICAgaW5j
bHVkZS9nZW5lcmF0ZWQvdGltZXN0YW1wX2F1dG9nZW5lcmF0ZWQuaA0KPj4gICBIT1NUQ0MgIHRv
b2xzL3ByaW50aW5pdGlhbGVudg0KPj4gICBHRU5FTlYgIHUtYm9vdC1pbml0aWFsLWVudg0KPj4g
ICBDT1BZICAgIHRvb2xzL3ZlcnNpb24uaA0KPj4gICBIT1NUQ0MgIHRvb2xzL2Vudi9jcmMzMi5v
DQo+PiAgIEhPU1RDQyAgdG9vbHMvZW52L2N0eXBlLm8NCj4+ICAgSE9TVENDICB0b29scy9lbnYv
ZW52X2F0dHIubw0KPj4gICBIT1NUQ0MgIHRvb2xzL2Vudi9lbnZfZmxhZ3Mubw0KPj4gSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIC4vYXJjaC9hcm0vaW5jbHVkZS9hc20vbWFjaC1pbXgvcmVncy1sY2Rp
Zi5oOjE2LA0KPj4gICAgICAgICAgICAgICAgICBmcm9tIC4vYXJjaC9hcm0vaW5jbHVkZS9hc20v
YXJjaC9pbXgtcmVncy5oOjM3MSwNCj4+ICAgICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRlL2Nv
bmZpZ3MvbXg2X2NvbW1vbi5oOjIxLA0KPj4gICAgICAgICAgICAgICAgICBmcm9tIGluY2x1ZGUv
Y29uZmlncy9uaXRyb2dlbjZ4Lmg6MTMsDQo+PiAgICAgICAgICAgICAgICAgIGZyb20gaW5jbHVk
ZS9jb25maWcuaDozLA0KPj4gICAgICAgICAgICAgICAgICBmcm9tIGluY2x1ZGUvZW52Lmg6MTIs
DQo+PiAgICAgICAgICAgICAgICAgIGZyb20gdG9vbHMvZW52Ly4uLy4uL2Vudi9mbGFncy5jOjcs
DQo+PiAgICAgICAgICAgICAgICAgIGZyb20gdG9vbHMvZW52L2Vudl9mbGFncy5jOjE6DQo+PiAu
L2FyY2gvYXJtL2luY2x1ZGUvYXNtL21hY2gtaW14L3JlZ3MtY29tbW9uLmg6NTE6OTogZXJyb3I6
DQo+PiB1bmtub3duIHR5cGUgbmFtZSAndWludDhfdCcNCj4NCj4iI2luY2x1ZGUgPGxpbnV4L3R5
cGVzLmg+IiB3YXMgYWxyZWFkeSBpbg0KPmFyY2gvYXJtL2luY2x1ZGUvYXNtL21hY2gtaW14L3Jl
Z3MtY29tbW9uLmgNCj4NCj5BcmUgdSB1c2luZyBhbiBvbGQgdHJlZT8NCg0KSSB1c2UgbWFzdGVy
IGJyYW5jaCBvZiBPU1MgdS1ib290IHJlcG8gYW5kIG1lZXQgdGhlIGlzc3VlIHdpdGgNCmJlbG93
IGNvbW1hbmRzOg0KDQptYWtlIG14NnFzYWJyZWxpdGVfZGVmY29uZmlnDQptYWtlIC1qOA0KbWFr
ZSB0b29scyBlbnZ0b29scw0K
