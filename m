Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B4FC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 14:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7BEB86E35;
	Thu, 25 Jul 2024 16:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Pne3tMSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC71A87E23; Thu, 25 Jul 2024 16:28:05 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EAF086464
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyIPWii73xCghZOWilK8kzxhdrfLAFbfMY6oS8iJJz94/2Co6M7GQCvUBFxxWIbJ0qGDBl77Zf1wEa+9hhKjQV+SrVy6UTV5hlx0aSYRn3r/m61wGngnrMPXiR7v/oF6XZAaGH3hXTtl3XHgmd8JeYzcGu2XxIoRrVad8EME1TZlMXQlczxsHgQQ+2n+5i1AGKmJzYgJ+kfF45jCpdxJzUAyKFyDjpnK9z2jRz/JqHwUWCsSeL4/Tpx/bQ/fucQ1uYrZnC3+z8JZEEAPATbPkaYSWMIbjI6hjE1M2Vkm+LUCIT25qRCWQ2s5kDhvBcRpkbSEVi43z0Olv6dCRKAmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzHneKAIVV1Qsg2hRQTnmK2i7dssycjWIvnN1ANrdRg=;
 b=FJMJNENLlyEa7+Qkq/DPGb35DyDHiFkCa/dJP7Y6fal89HffxWT9NI6Nan58Hr257NKVsaDbYQt9JUZK7U3v8PWzJMlkjlgJYM2ef+sOOUccXEY+RyFktptTGJYx7x5ZoS5G/van7gveg0/b02pnb8VhDfOgeFbxQwqehqX9wBjaiP1mXTCI0nIwNMkxtIbjNUTAdeLnqY36IMIcalbAzKB/xiIajk6fEqbpnq25cs4LBzXgwcGfKMrhXNQCJAC6a0RgFgJkHuitqlxrq4fZywoIxQ5ifTPqijOaIWxHYLlDRNt2Beg1It55bYl5aX1IXYR3EiABqErJdhzuF2MP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzHneKAIVV1Qsg2hRQTnmK2i7dssycjWIvnN1ANrdRg=;
 b=Pne3tMScvU0Dcci7jLqGhFoe0gc/rKO2IGQnNv/ViEywKd+HSKDk0wWx5H9DI86ATjW1cZfwhr0YJyiCkps4OVVbDXYR3k1uICL18zE06YPrRHwnfJdsFiP1iYY/STDbK3VQ1/tpUtrx8DgYBOyKKuMghkCI8id3F/VkHSc/QF0lMjWnAGjot1daDGfA1PwZcCrTiD27I+Y7aIcYi9WpotUZqrzanas7UwnP4HfF4hoXIjIFz8t/QpNgifSve7+/IXka87G8ObzgcwdjMztxKeLDW30axFtc0Gm5z3lQdpDjf4RYcP1arIMEprV7dPdIVHS03E14cWlQVK4GL0PY4A==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 14:28:02 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 14:28:02 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH] clk: imx8m: register ARM A55 core clock
Thread-Topic: [PATCH] clk: imx8m: register ARM A55 core clock
Thread-Index: AQHa3mrpWJ/EwB9JakWVRIOSSNesG7IHdxeAgAAJMsA=
Date: Thu, 25 Jul 2024 14:28:02 +0000
Message-ID: <DB9PR04MB9236E383582DD2182007E75784AB2@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240725083655.24486-1-Zhiqiang.Hou@nxp.com>
 <a0665028-3051-4e9d-aaef-5d32349cd648@denx.de>
In-Reply-To: <a0665028-3051-4e9d-aaef-5d32349cd648@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|PAWPR04MB10055:EE_
x-ms-office365-filtering-correlation-id: 15c0c857-07bb-42fb-3240-08dcacb5fd84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OUg5bFF3OEpTL2lqbnJueHVYUitVZHBxSld0Q0N2a0VpYVQxc21YTGhhbUlK?=
 =?utf-8?B?WlpYVjdweStId3psQ2xWL0VndzdEd3BoVWJTRzBWd1plcWZESlgycFducVlW?=
 =?utf-8?B?UXMxd3FDWDFkL0lXN1VDZXprZSsvcExRMUxQSFo1WmVQQldaa1IwdngxbVZS?=
 =?utf-8?B?cDYzOGx1ajVhR1VVZEZNanRvZVVwZVd2dXBiUUk1Z1I4d09ScnBYOEFWRkJL?=
 =?utf-8?B?eVAyRURTTkxITS9IQm1rMmorQkF0c2UzYXF0TjZ1RGttMzFQTzZtMzBTRWVn?=
 =?utf-8?B?YjNsMWRZWWw0eGU2cVJwOUY0SEV3d2FBaERacUFPdEc2SFpOb3B3MGRMeVJP?=
 =?utf-8?B?cHVwK0pMZFY3TmgwaWw0QlNVeFB2SmJzTlFkUUZ6YnZuY3pvWDJJNWJjVnJn?=
 =?utf-8?B?QS9BTWdDYzRpNnAyK3V5R3o2V3FVNTQ5SWlrU3NxNzBkaThQOE9yODhtYytP?=
 =?utf-8?B?eHc2SlJ4UmR5dGl6KzhvcVFFUnBiZEFKSXRNbU5ncEZsSHlzdlJpcHFkSUVv?=
 =?utf-8?B?MFpZNHJSVmZDemZiOHBHQW9oK2NXL25WZHZGTVoyeGY3NWwzeGtVSXBDeTVy?=
 =?utf-8?B?TWRsZ2pUd3VkUlpwSDRORnBuQlptdTJnc2pyKzhKdk1SeU9FeSsyMTlDaUpN?=
 =?utf-8?B?ZVUzQndYaGV6K0tQdlN2ZkhsYmNTQllDMjNVdFF3WDVOWGw3V05JN0grdmdM?=
 =?utf-8?B?dnlQelNyb0NmZ3pzRWROOGRTVEU3MkV0aGRsNnYwY0hDYVFCUnhVK0U4Yk8r?=
 =?utf-8?B?UzErY0JDQmorZEZoTFNySlF3eGVidUZmNjJOR29sR3JiREtGM1F1QmIyRVRz?=
 =?utf-8?B?SW5ZanVZNDljSzhrcmJERnRWeFlxOUR6Wk1LZGt2c2xOMjU4Z3NHWlFxMEdM?=
 =?utf-8?B?R1JhR0RWNDJ0YXcxMXZpYm5LMWxiTmh1WTZ0VDc3Slh6NU9hUEFwNDhyTkor?=
 =?utf-8?B?c3lCV2haWlY3YjZGZFAxemthMUJFaUkyeXF5UGdacVZmeWdKQlJUYTczTHhD?=
 =?utf-8?B?RkRsR0MxSllhdTBJS0w3SHlhaEFTSHBJOXVSTzhYWTdSMVBaMHdWbXlNZ1RW?=
 =?utf-8?B?dUZ1c3Z0cmJKYjltcFRVazlTZXlvWWZBRXkyajF5OEFNSzZhNjNjT3RDWUdt?=
 =?utf-8?B?UzVPVXRjZHNlTi9ySE5Gb3pWb3I5ODRQUEUxRHhDVUY1NXNyUmNlK2FvR0pm?=
 =?utf-8?B?SGUvcEUvNHQzckFUajVURXRRVlBqQkh3NnNUcE9qNXJzUXRzMS9YMmxJbzFl?=
 =?utf-8?B?OXoyN01INGJkbDdYT0dYS3oxc0dlMUhZREdxZTFRQ0dHY1lhZXFhM2c1cGV5?=
 =?utf-8?B?NkZZWmh1U0E1d1o5d2o4U0RTWVYyVGJmRVJ4VStOQU41YTlsZmlndkxYY24r?=
 =?utf-8?B?NWlXRjZxUFlMZys1RzFzQnBVVDVjd0NhenE1TEpaMFVUdG8xS0cwaTZuRlM2?=
 =?utf-8?B?VU1oaWtMdWRIUGN4K3J2MWlNbTZ5RkhOcXhVUEZyMUNUaDZEa2hkdWo1cExX?=
 =?utf-8?B?aFRpUWk5UWVDN1IreGNTMUxHZnY0LzhUdkRveThNWTBkdDl3cnBhY0RPTERM?=
 =?utf-8?B?QXVRaWFWV2NuVmw3SGsxc3ErbDh4U2RhdnlRM1lQUzRzUjNlbjM2eTVqYm1m?=
 =?utf-8?B?dnc1aWtOWXlrZGF3N3RPVU1iV3NQWWJKZ2hQQldUNVRPSXBGMVMwOGFsdmxW?=
 =?utf-8?B?OUlKTHhwU3lSTHJwNTA2ZU4wTnZOZWJ4N2h4b1lsWHViQW5rU0xTemFMY2hl?=
 =?utf-8?B?TGFKYSt1eDNqVW4wd1QvTVJoeVdXcjVxV1hQQ1NlOFgrazR1eXVZUEdvcGwy?=
 =?utf-8?B?OXExQUhVcDBZZnZsRHA4UjBGUnp0cUpqWmlQU2xDNTJ3SjhzWUk0bmZYMGsz?=
 =?utf-8?B?TlRsd2MwMTBnb05YZ2oxZG1xNnVoeGtjdjB3RWM1Ry91T0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dS90SytZSGF1YkdqNCtoUUdtOTRZUVUrb3plNFJ5RkxucmtndkZ3dWxJWlpZ?=
 =?utf-8?B?MmE3OWVyaFZDZXE3S3NRNkJqZWxhblEwWS90Z1ZLVWQ2ckdUM3h1a0J5SFhj?=
 =?utf-8?B?YXYzM2kyQ2x6NHBJNHJHMjUxNENyUDBGQlBkbERjVkNWYzJnSEx6ZW9IQXNH?=
 =?utf-8?B?OUZyMFlrZTNFZ1RTY0pad3QwdWtYZDd3MzJoWExtYmNxNTlLQjFFb0dRL3BH?=
 =?utf-8?B?QUZlLzFxQ1lTa09wb2NHY0ZDVmV2RklnYVNlMG01SG81UGpyeFNOMmMrRWJl?=
 =?utf-8?B?VjRacmdIKzBETTFlM1EvYjlTb2x6ZHpSOFdzSFBXS1NOa0FlTTRNeE5VU2Fa?=
 =?utf-8?B?V1pwVzFoc2Z6Y1AxbHpSLzR1c1FSRDNnWCtodGR3NGZ1WTlqaTIrcTVlbEdK?=
 =?utf-8?B?QUs5Nk9uckZiMFNwcFA5QjZTOUZMRjBDdHAvbVgySkJMU1UzVnJUTXZnd1ZZ?=
 =?utf-8?B?enZ4LzZaTFFqUTlFbDRYWDBkdFh0SlZaUFBwbWxKMkZnWlEvc3VWWTNwcHY0?=
 =?utf-8?B?cENqYWlCZk5NMlpqWDRIKzN6aWNwU2xYZlUraCs4YVlNN1gyeWVHNjdqbkxi?=
 =?utf-8?B?aEMxczlnTjA0TGJWUm9xZHArM2s3RGdnbUw1aHF2anFHSnRYUlVRSFhDSzVC?=
 =?utf-8?B?dW8raFo0M0pKSjVEWmJYRnR0Tm9MSTVKci96QVFOMkhlWjVPMGMxMG1zUWtx?=
 =?utf-8?B?QTZidG5CaFZRcG8xdlFMaGo4eC9ycmxXQTlySGRLTkZRVE16OTVibjRDOGFw?=
 =?utf-8?B?dllrT09kVEt3ZXBEMUZXa3A2aUhVZDNzUXJtWnFUSll5QXNYQWNMVjlPUzcv?=
 =?utf-8?B?RTJpMy9sSmN6akxTRWoxVjV5Rk5tUEg0S21rcnZISVh0djBsTzdTMXJSLzE2?=
 =?utf-8?B?YUI2d2EzK3F2eG1UQldPSHVBcFA5WUZXTGp4bzF1WmtLRlJnQlpUeW9ueUdv?=
 =?utf-8?B?M2FheHdJZGlWTzgrSzl3TkduYmJpYk9hTFNSRlBVekt2OCtXVjBoOHRPTzZP?=
 =?utf-8?B?Tk4rUk1mb0ZZb3ozL3NaOFFia0l6djU2eEsvcnVXZG9vYWtldVdCckF3bkM1?=
 =?utf-8?B?TFNEblJZQVc4MjZRMjh0UEtkdW1MTG1yNG1QaytDU3ZQblVLK3RxOXJjZ3Yw?=
 =?utf-8?B?WGFyY3dVVUx2UHc3UTcwRDlWOHRLaW16S0NqSS9XZGVoUXZrRHhIa3FKdXdI?=
 =?utf-8?B?WmZMNlBTTnJZdDRPUTVGdldIUDBKZWZYbUo4NW1hd3doa3p1MFJEY095aUZ3?=
 =?utf-8?B?NGxNb2psK1EwU0tqaUVKMTNZNUl4MnFJb3VOaDVWMkJ2eU5ycFB3VTFQSEho?=
 =?utf-8?B?djAxc0E3dlZibExEdU5ZRGdzK204dDBtaGdZVmUvLzY4eU1saitlZmEyK2Mz?=
 =?utf-8?B?VXByazJ6V1BjeGhWU0VSRS9nbkhuelZ3NWRUNURxMHFNNzBqU282Z1B0RVcy?=
 =?utf-8?B?ZHByZjMyTWgzL010aUY4SEFmQkRUekZ6OTdubHBlaXdBZU10T0lMc2hqeGN1?=
 =?utf-8?B?ZnhYTm9ZVzJ2em5DMWVNL0dMRzdPb1VvZVlwTmJRMFZLM0NTbmZtTGpMNUMy?=
 =?utf-8?B?NEd6N016MVhSbEl3MHNrWi9BaGNaS0prelcyS1VCdUladDM4Z1JIUUlHME1u?=
 =?utf-8?B?enlseXFpVW9DZHRNcmM0MzN4RDBQTGo5ZmkrVEJwdWcvT3JQa2hBNGRacGtU?=
 =?utf-8?B?WC9QYURGN2E3NCtkNGl5V3l6TFZDQ1RKbGsxYzhpWk1ObGdUWHFEU0ltTGx2?=
 =?utf-8?B?U0o0TmtXekZ5VXZJR1dnSXY4eEpNQVc1cEVqVndJSjNFelZRbE1mTVZFWmF3?=
 =?utf-8?B?K3ZDYVN2dHREeVpWZkFYQW1PeUhzRTVpV252V2VQY2hTck5XNzZFRURTMCtX?=
 =?utf-8?B?OWY5cHNNbEN5UkFoRlhqd0g0OUFiWUo5ajNwZmNxQ2ljcVhMNzNtMFZzWHIx?=
 =?utf-8?B?T0tmV01KNWYyZjBKbStPK05nclQzcWZvbnZLaG11UFFPNGdsdjdPdEt3MWZT?=
 =?utf-8?B?N2taTlV4aGNYTTZ1WkUxYlJVUUlLUHIzcVFzeUZsL3h0T3c1Rmp5M0tjT1Zu?=
 =?utf-8?B?R01JUmI2b0ora0RmVmxIYXplTWpaUHE2biszejYyWTZqSXgvdnVKRllEWHN3?=
 =?utf-8?Q?qQjnAeURSawRQ1CdWqjHk/84s?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c0c857-07bb-42fb-3240-08dcacb5fd84
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 14:28:02.1566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Ny9SR1fhQX4Uyd4RluxCVmpbv0kV4h6E/h7IYdVVrwu84HLsWGoZ2oRxU3wIzye5apPVlRMvSuGL3jRPFzgKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055
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
VmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDI1LCAyMDI0IDk6
NTMgUE0NCj4gVG86IFouUS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT47IHUtYm9vdEBsaXN0
cy5kZW54LmRlOw0KPiB0cmluaUBrb25zdWxrby5jb207IGx1a21hQGRlbnguZGU7IHNlYW5nYTJA
Z21haWwuY29tOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IGlteDhtOiByZWdpc3RlciBBUk0gQTU1
IGNvcmUgY2xvY2sNCj4gDQo+IE9uIDcvMjUvMjQgMTA6MzYgQU0sIFpoaXFpYW5nIEhvdSB3cm90
ZToNCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+
ID4gUmVnaXN0ZXIgQVJNIEE1NSBjb3JlIGNsb2NrIGZvciBpLk1YIDhNIE1pbmksIE5hbm8gYW5k
IFBsdXMuDQo+IA0KPiBBbGwgdGhvc2UgU29DcyBhcmUgQTUzICwgd2hpY2ggbWF0Y2hlcyB0aGUg
cGF0Y2gsIG5vdCB0aGUgY29tbWl0IGRlc2NyaXB0aW9uLg0KPiBQbGVhc2UgZml4IHRoZSBjb21t
aXQgZGVzY3JpcHRpb24uDQoNClllcywgd2lsbCBmaXguIFRoYW5rcyENCg0KWmhpcWlhbmcNCg==
