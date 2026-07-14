Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5E0C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 12:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D8984D0B;
	Tue, 14 Jul 2026 14:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.b="Pf16untt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CB0B84CC9; Tue, 14 Jul 2026 05:05:07 +0200 (CEST)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com
 [185.183.30.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F7F784CC5
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 05:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jacky.Cao@sony.com
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DNmik23017739; Tue, 14 Jul 2026 03:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=p1; bh=hU8PyyN
 hEzMLZ3rTJebK1jPEbUuEcIAYuUbYuXzNQ1c=; b=Pf16unttqdn46Or8nXGFkka
 1fD3yUDhNB58c2oyVjM1hO3sizlu0N39SaOv+21qH0xTV2NC620Nbrl5IucrsfvK
 nV8abx4yzSW7mwuN5POqR35oxAxv0Pve2RzTwtTrzD1HGF2nD8mRA/msLduyMxS+
 ZxoaB3CkobFJsdG/bpNd6zyl8fwqdPLLnUgJy3AaeueMSDEbvlPUhXsWZfQkvfKK
 KC2rNHq11MceQb9B4KW2hlQq6zpIJsZnjRzL1xIpX0J2h7T6YMxzhK847Qs90rFJ
 qfXBVPG1iB25raBjhHFGMklugLFMFTl8zzuNwChkuTSUuoJ/EGgfLECb/MLuuMw=
 =
Received: from os8pr02cu002.outbound.protection.outlook.com
 (mail-japanwestazon11012034.outbound.protection.outlook.com [40.107.75.34])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4fbegg2r59-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 03:04:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAVk/Jh87tIz+VU3lZg//MpAI2/fyiqzylcRufZA09Cw5qLbH2VBmCIPOOodZweHiInR/vlZ7NppVYcYV7A0G/if/5v4a8NJuULUtHdewY1iEl4PAaipjY10UZuIAPEXVWJJ3p1RtmzEzu0DAdsREAk0YK3jLvM1/p8xS/nMoIdOi+g1jA2xS4HI8u1L22eQGSdNpDhN+qOpH3jUBbKyo11FKyypFpemDiQ+xWWjE+1bcF8nDo2Qx5Xc4uPkebYu72gsoNi2hchpgfhk3gpN+UlDNCRFh8tdDcTcNfAzgXoDkb1I6ZXDZvjRHzVdbiorp8RvmkR/fANNm1vAEDGtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU8PyyNhEzMLZ3rTJebK1jPEbUuEcIAYuUbYuXzNQ1c=;
 b=PXBFQ+1NinWKPaSYTNAwlCO7eW5q6izacvnKq4mZL2uiwz2sRoDemWmJNlf4qVvmNoFvxJUudymHLcwV4VkxITtKIS9pjg5kDg2SK7A+RlGJERSU7HDXarE3AV4pFJgI9AqKzb+RvROywlPgOuRs1yTTCNhdNGgfXfC7LOJPieA94eOoD6FyPyJkNJEhv3ACrKkffPqYo1PbKfOHra4ipA4zqKoNgjNsqlp5d2Fwu8jrqVja9gFQytxKkaToq2rt1tbwzAuFAnwMM9JPd9MoL3k0QAi2uEonlTm4wmSXzbr4dTsm+5Op68ho9Gf3y4AMRcMUdexJyCykrR2kZrI05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from KL1PR04MB6734.apcprd04.prod.outlook.com (2603:1096:820:d8::11)
 by OSNPR04MB9376.apcprd04.prod.outlook.com (2603:1096:604:487::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 14 Jul
 2026 03:04:43 +0000
Received: from KL1PR04MB6734.apcprd04.prod.outlook.com
 ([fe80::6812:7cec:2e9c:ad96]) by KL1PR04MB6734.apcprd04.prod.outlook.com
 ([fe80::6812:7cec:2e9c:ad96%2]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 03:04:42 +0000
From: "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>
To: Tom Rini <trini@konsulko.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "nora.schiffer@ew.tq-group.com"
 <nora.schiffer@ew.tq-group.com>, "Steffen.Doster@tq-group.com"
 <Steffen.Doster@tq-group.com>, "alexander.feilke@ew.tq-group.com"
 <alexander.feilke@ew.tq-group.com>, "Max.Merchel@ew.tq-group.com"
 <Max.Merchel@ew.tq-group.com>, "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>
Subject: RE: [PATCH v1] env: Fix compile error for envtools
Thread-Topic: [PATCH v1] env: Fix compile error for envtools
Thread-Index: AQHdEqINARnpMVEBj0S9fvVbX43Nz7ZrP/JwgAD8eVCAAAVtAIAAExaw
Date: Tue, 14 Jul 2026 03:04:42 +0000
Message-ID: <KL1PR04MB6734A43A5179C30DA1F9B9A887F92@KL1PR04MB6734.apcprd04.prod.outlook.com>
References: <20260713083141.2772971-1-Jacky.Cao@sony.com>
 <MRWPR04MB1233021A0AF8D2117DBE5984888FA2@MRWPR04MB12330.eurprd04.prod.outlook.com>
 <KL1PR04MB6734F919E17C467C8B29DBD787F92@KL1PR04MB6734.apcprd04.prod.outlook.com>
 <20260714015324.GZ749385@bill-the-cat>
In-Reply-To: <20260714015324.GZ749385@bill-the-cat>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR04MB6734:EE_|OSNPR04MB9376:EE_
x-ms-office365-filtering-correlation-id: 8fe58688-3126-485d-a9de-08dee154a6af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|3023799007|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: NmMqGixEriPfDzfa8DVMMprXBGlztIS0Fmf6WIWG1AMdfvRAj0Gw/ah0rueAaydvmYZ98zDYmWcIeWUzZvF2oBrittBGY1LYLbgUELHxu9+Ppk3E0IjG19SAvN53EAJGCFN94pLeKVw0Pgl7nsVRFcHZ6bK5Pub8w2xL+ojiUjPXwoDKcY3CjY0V0XciI2CxbZJSiYUFmjEFpx0DAbR4qA0vuRv7Tp1v+ITr9HZ75xoRM/lsfO/RG0WqGWiDzM6r0eJxIp1yVsnHcre1d6+qNuipXyy0e+KMP3phMxmZ58AqPf8hz0US50kEqArGCb170P+fgx5ozwP2DUpRlcxycPih/6UrLfDiGCyhcYS9ZGBgkom0hyDLO05JwcrwMfagymX8G9eXVDjKCrq/m+5O2Fz+LC1bkvdZttfFUjVyqL0DXC2VYfbtJXWL3vEqZbWwtR0RB+m3PkWSlwj1eZ3b0fE2nBxtCAvMwjCiKZjv7H5/tPVTiq/7Qlmgd7doaEvTa3jzH39rdEvs4JWmxRa5j1C4OFc1irVcB4ZbC/RK+4V3ll6ZUyPturkQTAO2J/l+37mb5EFwxUDWBUpShXIjcItUkRQs2u4kRqkq8jpcNqKGgLoeiPBFJDcodEnMrbc5qjd3G6ZVdOQ8pR3ZBM/7doF8zNU5+/1aKgE1i/548DpEFVkrncOAnCiQINDP9T4we3D79DV29Yr6u6WDWH8O4FMNY+rAGdIBS/qiZscKOX0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR04MB6734.apcprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(3023799007)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rYHwLNaRwvXBtLoA6pQ0lsbAeV1naRJ4JQs6+6kA/WyublqAhlU+6TL8GsXU?=
 =?us-ascii?Q?8QYltwZ/mPO8tzjsgrvzohTnBjLguaUIjO2FNvDT2EWcaX8RmBSdZZQJYLsw?=
 =?us-ascii?Q?F8rTH7R4qFtmvfgbIbdlP4QRVHW2xzHfxqDCW8/KlFig+JhWAHlROpNUZjOM?=
 =?us-ascii?Q?M3zlhn9BlBJ74uyhtMbz2ccuVFJsk6Ubo/9onpgyJ4twJX+90QpCY09TPUAH?=
 =?us-ascii?Q?+4cBesyhk+zg694ZWDEstl2uiqfWIa+WjQ8wt+TA2r78ZG78wYrbR/LxSLCz?=
 =?us-ascii?Q?uahUL9k8V4WP6JtbkqQLvsc+1a/vK0OUiVKzNIdKmUUUxIOHwQtoNCrrSYd5?=
 =?us-ascii?Q?yZA+L2hTvj1aPLGzTMgZoBfH1/o6NkUwMvTOUo/nsH31nElfIbnmtuQFThyE?=
 =?us-ascii?Q?1CVjEcvInnTQDF2W3mqIEAnV7qa0OONVc9lNlR6uS63c47iGF+yim9BCUJnS?=
 =?us-ascii?Q?IeOaxsta4tx/NQdYXSYBXRkUiGb3Dfg2oVAj4fddA6PdI8zHUiI2aHvaaeLe?=
 =?us-ascii?Q?xez4RC7/JkyEuIttd31SaoHkxNxfgjj2iPADL+Ms5ou/QUfoOxhOeumUnLRI?=
 =?us-ascii?Q?DyQkhvyDlNBLEZLsmIktdnKOPtQOqI5Qcuwn17jx2nu/80TksPXmT+6Y1Jao?=
 =?us-ascii?Q?XDiqK9zbW4PpnJrHaL8XCXub8PNxcQ2ncpVJFtw6DcthakTKhgaEXkAQHdqm?=
 =?us-ascii?Q?22yaQx5SEZ1aGS3pSrLm6KiDSWFa39qM1dNh+rdGIdpNCrXKbnHSrSuS9rCX?=
 =?us-ascii?Q?IgyZUZUgcBSACxHNnZj3UC4b2Nw0wyC9QK1V7ExNOzS1ANRch+ednH6mKy68?=
 =?us-ascii?Q?0o7JhF3ctA6MDaEoAqxTkeOnvWokSV2W5nQR+eWjtJ3sLBpwPylanujKNU24?=
 =?us-ascii?Q?uj88GrC5RW21ZlEvw2JvaDN/VxYD2wp2MKO9EtKuu01oJDl+uUhupXg7vBi8?=
 =?us-ascii?Q?kA0fQ41ntKJX7i9QKMsOXGtNDVwrkWMSaYgsUWgd8ugfLhywo8TSNkDKMVrw?=
 =?us-ascii?Q?FwSK5voFCvOPmjcQswd7h7hsdNNl6Ejs0v5FqDv1ID+/FJHV7jDwdFl2WmqJ?=
 =?us-ascii?Q?hDCa9sjsZUpZtF4hqdhBGJ/thuo8WqRRKr5CF6sYgauFWZm0/4b+cs3RjlXk?=
 =?us-ascii?Q?JiIjZ9vEf/vvUOfBZ89zvUFkMjM+FGEuWu4aCYj2f0DfgMvrOWZR/ivbT7Oe?=
 =?us-ascii?Q?2wNNEMCChMipX3CS2ryXYCzgZQViEa9faB3z0WZGHEIUU5kJs4dPRCAE+EhM?=
 =?us-ascii?Q?s4uVEt1VIre/fqH6KWZBMWFucqtgmV709Ry/fcGhhWeWz7avDW2Ot7CeItC6?=
 =?us-ascii?Q?QjUcX4gAGL5mDVS7C/i0MuXRtxL40n2GJZN8pxZ0ixmIhz3SocU+QEXMd5wj?=
 =?us-ascii?Q?iA3f90wiBwvg8VdBqhSOkW+Bl6YkihDAINLBkdIxbRdoipYHiYKrzHe1NutN?=
 =?us-ascii?Q?d8T9M7/qWvTDkTAFs/ujhiKyL8r8O8BTW0RGpcOK+MldR3dBINts5ckfCRId?=
 =?us-ascii?Q?SCRALmpd24vIapNOFJ0zCel+FWwcY90wTMSJdgW+7pUiqFUZSXwQ8XIOA8Vd?=
 =?us-ascii?Q?jjGG/id7HjjcpGkbSiMvkuebHkdHbx5K4iFvCML0ifrsG0sJJApUuQmMwgHo?=
 =?us-ascii?Q?WZcrxJHhNAmX2qi7wciblF4eMYGYMcLbiKno6ZaZr9JWzMVAFOj259RY9TY9?=
 =?us-ascii?Q?gcIakQ53/X05H38tT7KD13Rwya66aUE3ghmmqF6q1aZHysOB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q/bRaKJJN8E2KS3W0LI4ReT1VbUSb+mbfLn7PgxHai2clxeQwsHF9TwSqJWrCyNQSnM1QRMKrVQpIMKeCjJZGtnJDxVeyqPkdzTTs+2gprojpEGCZoi/tBvln1L9bxXxvsyLKgGPGBbK1GytbsCvAC5XA8xyh4Ebk5gp3JX/c1s/GfcX34NuyqHbxQ2Hdhtwgu3/W/hcf9VKG7Z1KZjApStohDeNEe55NaVIV7AmSyX2iKeFMUO4/kKYObdAOmsQ9tau8s0l8u6Ad22pU3hhSK8XQWa4hI+NQrEMUK7ioSWuqLFDLLGukd0+ZBFNISWBqHND2WMDJAPiKI1Rl5sl8w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wbZpZI+RuqcUwkyEYFD3PYE0WfJuOE+ZF+FWh5nepTv1NO73ECCIGy8+P2aqS8EwGs5eOr/oFdq8+2SowTgwWH0yUfVYPIxy4zLYXA74RJvii72di+P+Qv5KiSpOOlw2S93TcTuYDFOokLQNMXUE6DApljrbNwmD55QzOx5JWbQgColR9d+z7CllsuEQV+ExtN7eUfRkm6tJdzY9rIZ/t0RYW7kZl+aaZ8EOI0Ng4VpnPMbAa12Hn9uRxf5uddF0AQ50NMu97WkHswS0hzuhs0UUNChS2FfmSKa2EiOF/Omciv834wb4PFoTdzDXJk6z9AgzlXFlxzfa7bBqajjw2dhw7/2seO3Su5US75RDeNqXF9YO+tYjla1m++etTxzkYFvgxxvUJQuPyYRtLki1IU41VsLHfT5qAbpCeWcxzGly2Zp08Tn2T001R9xA2rup+d6UdKDyD84RqZFObg/cg1A5quGNycRFvRXW7NHNZC5P87Wnj17H/V1erHz07AzXd5CjpJlQl27MRl4flwYITi+VS53nZVt8yY0RFAnDxPcH0TdfENNb8f4HNvi3tgtaHODlHkPOLLVxb+2XYnj+xnnFpcfi4KZpOXO5mLmeMHHGEXwjjS3ngUu1+L5UjA/j
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR04MB6734.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe58688-3126-485d-a9de-08dee154a6af
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 03:04:42.2677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z8nmWX+Jy5w6496DCjKdjDn2E+VEVBZqxPNaVak6LIpDDYJS6tpsG4SWZwmc8CSDtC1F3zqNXpbV2YZdtLaKTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR04MB9376
X-Proofpoint-GUID: 6nR064mmwL5TzhTxPPWFwrBp6kYPq1mg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAzMCBTYWx0ZWRfX4+H3H4zflXMA
 SfQnb9+umXMNWiPcchNQuPetIcPtjmscIJslfn3GlRqZU0SCelyIX1PgeoLC9razUiP4CvMUHdq
 6ILmfln8ZFiXMTWuZ15LMCK3AT7zolaXAUBy/6b3IL/gwHnIlc4OR95s4JGMgdzLYMQQytXZtMP
 4UcjgORCFKG9HkAQfqlXJghU6MC5M1oIOnGkaNbxAAASC8zY/i3B96oRHYTL1mzKosvNN1MhDDM
 2tb22m7UO39uboi7dV+q9PjqazeSCFqeBFW3PIzBxvUazLbOQ0AzwUmfY8nfdjaEENx3p/H0Azh
 CP5uS9hEfCJhhxa4AE2AHp2s/BJID8qzh9IHE4JLsXViNYS9FYzocEtsQ6DEeEWRDa02rZv4zbb
 Xkf8mN6+NUUFnkbkvrC/EsQwoI7oUh0NGfW2FJCdKuO6HVHLwRqJyiQ/JVwsFUdzvesFKpAsjmp
 5ALq/deq0Oz8QO907Bw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAzMCBTYWx0ZWRfX5VBRNtsRsswT
 oN/C5FArkcLmqvWJTaiF1Qk8iAKKLf88/9ajRA6ze324qAyUTOLPJN4W5I36h8jk8h+duBEUabi
 wO9eGj5a7dAAmkY6tx9rRjU7xBu5Ddir6sCdyWG3NMrwWF9qtvpG
X-Authority-Analysis: v=2.4 cv=LpSiDHdc c=1 sm=1 tr=0 ts=6a55a750 cx=c_pps
 a=BjOsApdyHS4FXG3HZFVJww==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=M2bq-ooH9SiLYa4vvubY:22
 a=0HgSsbAk5vxDS1aV1eoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 6nR064mmwL5TzhTxPPWFwrBp6kYPq1mg
X-Sony-Outbound-GUID: 6nR064mmwL5TzhTxPPWFwrBp6kYPq1mg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Mailman-Approved-At: Tue, 14 Jul 2026 14:51:05 +0200
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

> > I use master branch of OSS u-boot repo and meet the issue with below
> > commands:
> >
> > make mx6qsabrelite_defconfig
> > make -j8
> > make tools envtools
>=20
> What host distribution are you building on? And, <config.h> *must* come f=
irst
> in the include list, for it to function correctly.

Host OS is Ubuntu 22.04.3 LTS.
Toolchain is Arm GNU Toolchain 11.3.Rel1(arm-none-linux-gnueabihf-).
Also tried Ubuntu 24.04.4 LTS and Arm GNU Toolchain 15.3.Rel1,
the issue still happens.
