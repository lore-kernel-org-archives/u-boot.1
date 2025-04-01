Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DC3C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 08:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B329081F4D;
	Tue,  1 Apr 2025 10:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Jr4E5E/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E4ED81F7B; Tue,  1 Apr 2025 10:17:51 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4377F81F0D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 10:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZ8lNZjt8OZHZJCClYv4nVytN1NgmFE/nmPhW6FKFHvT/8oz421QQoM9fzk/ky3K8aQ7VhtwqqcrFzPAoYVU0m9Htv2LkG9IYKkSBbEyuDey95iFo6GtueFJ9wPswTTe3/hli6Uw7mbKhYuYxaMP8TQDPUsODU53P8ay9L+VN8QYUcoZZ4CCU5+/DKlekqtPGqCj9OKJi4lbjyiBWchf/yJEs5WIp+21rLAgja4vbW9e9mN0IKUY1Xc9ACmF6OwTWLekl1S8gQx0LmTMuYc29UBZrXcuXNjNoRS/qNbdzec4steexCMq4g2wVB4fJqApakyVyOcewlWjOM5HHRA82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UX1zc70dw517/iQ346W5IBjnUYp81trZOEFFhHu/Ei8=;
 b=rmy65e38snkpl0SPFKgrerOI5jB7TKNXoFCoRX8vCUDygYzg2ApEvMWlw0hzSscg2/Uc9BVO3W8Re7m7ZsjdZTLycqDlHXeHgVFrLZEwk9OVo6Pr4783n6j5qHqM2A1+vt8uptIoOj8wWoto5eaK6KAFxSeLRNLLV8XkriQCfLZBwY4o3uEEmFWD9nbCKATBcDy/884mH3UQpJmJ0E5zaDJqYvMpcjxMJXSwVz5xuz78g8yhBI2AN1COTPy8C7YZanN0nbtTRVBEeDZLw875oDz1MzO46GDrG2XBRZ45d1JSIDiSPFJcu4rYl1PbRGv0D1Gcny3jDWhsqVwMiZB99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX1zc70dw517/iQ346W5IBjnUYp81trZOEFFhHu/Ei8=;
 b=Jr4E5E/lip04QCYdPv0aHBPqZ/fGMGPJqX2D1bDa2Te3nymy8FvaV6hxnp+S1YPGas9I9y2HACzxOGvCmi7uREnJX2dpOp342V+adcvIrjVSkUkYd/dnDs09IYMD74pgtjRx74eOF0KwZSjdN8KT/zmL2YgtNr2019xz88rD+eQP1YYuIGZFJdrk3JWzNx4WlwHdX0It+o9DXvxCcm0tS9ericeiM+U/m+EOTicr2sinIIq1G2aD4IqzUOjPtwqO0NritWNpcWdURCU3vAMmvjo+FjjE95ImzwSwyhe7wh2uWT82RTuEcuJV98l40cR+lYqropTL0S5KPk3za3NpYg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7918.eurprd04.prod.outlook.com (2603:10a6:102:c7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 08:17:46 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 08:17:46 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo
 <alice.guo@nxp.com>, =?utf-8?B?TG90aGFyIFdhw59tYW5u?=
 <LW@KARO-electronics.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ranjani Vaidyanathan
 <ranjani.vaidyanathan@nxp.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjggMDIvMTldIHBpbmN0cmw6IG54cDogYWRkIGEg?=
 =?utf-8?B?cGluIGNvbnRyb2xsZXIgZHJpdmVyIGJhc2VkIG9uIFNDTUkgcGluIGNvbnRy?=
 =?utf-8?Q?ol_protocol?=
Thread-Topic: [PATCH v8 02/19] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
Thread-Index: AQHbmjEZPZpAH2ZEOUK/fGtZCzozwLN+Uy8AgBA07aA=
Date: Tue, 1 Apr 2025 08:17:45 +0000
Message-ID: <PAXPR04MB96448CF1457963922EB0DA72E2AC2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-2-f2c8ba815f89@oss.nxp.com>
 <a180b7e6-6978-4814-97ff-05e34223938f@denx.de>
In-Reply-To: <a180b7e6-6978-4814-97ff-05e34223938f@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PA4PR04MB7918:EE_
x-ms-office365-filtering-correlation-id: b524800b-acaf-4ca3-d365-08dd70f5aeec
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?amFXazhUYk9aVG1yUG5JYzZoYzIzd3NzaGtBN3REQ1NYSUJaa3liYzhkWHJa?=
 =?utf-8?B?dzFuTWRPT2R2NEFVcVIxMnRCZW9QaWdiQjg1cEhreG8rMnBWTDE3SWpZZEYz?=
 =?utf-8?B?YlNuYnZEZjAyU3hEaXMreTJKUzFhR0lUM1hGcFIxQytKcW8vSGxVVkwybzlx?=
 =?utf-8?B?anYzN21qRHV0eEZ1MlFRWEZLajFUbjl3T0ErcjR2V2hDaGJBL3BFa2J6di9x?=
 =?utf-8?B?dk9IcHU2UVUxMEZBS09FdmdNVzNEMlovWWZqZUdjTTZDS0diV3dKNUNtZ01w?=
 =?utf-8?B?MUk0ZThKZER0K3B0NGhBenBNU29VUVdpM3lvQzVjREVucmNhWkQzVkpDb0pl?=
 =?utf-8?B?dncwWlpWSXlnZUpYUkpyVHloajJBcm0rVnYyVDNXTjI0YlhTTmprSGFtYWEy?=
 =?utf-8?B?dDNTUnU4Q2xCbVR3QUZnQ3ZHdXp5YWtUZUJxcml5R1VkaWV5S0F4RW1wNzJk?=
 =?utf-8?B?ZERod3orNFBNWE1MTHcwTkJJbUduWU1xWEpuUWtUKzBKT1pIMDVMc2s2ZkFW?=
 =?utf-8?B?d3B6T1RzVWo2Ym9oTXFkMGhnbnpKRVE2aW5XN0w3djc0MHRGaTd3TGRsTCtm?=
 =?utf-8?B?TFlmbFZwcEVrZ28xaElUMlg4YVV5YmRabzRsSXZoelRJSHExRDExeFl3QzNs?=
 =?utf-8?B?ZGlHQXhWeFBuL1pOajNkZUNldTd5TDdmSGpIWWxGcER5STY3cnNZeTRoY0c2?=
 =?utf-8?B?Q0tQYWhRNUpSSXVDa2hieHpvNE9paW1INmxBamFCRkZZQjBESjV1Yk9UcC95?=
 =?utf-8?B?cGpDTjVnOS9RQktnZ0k3dUNiYUZyYVptVk1WbDF5ajV0anpxVFRUR21meXZP?=
 =?utf-8?B?RkJLd3hiZlhKL29EdmV5bVMrbDY0V3RrT1hEVDFwZ1BzSS9xb3QzeS9kMndW?=
 =?utf-8?B?eFhqMGw4ci9RWk5vQmJsOE9uZloxTDZ3cmtiZ0c2V2FVWTRNUUIvUTYwV2cx?=
 =?utf-8?B?NzlhYU9jUFdSV3VWSFR4ODVFZFUyTGZYZGliekxISHZMa093VUVEdUw1OGF0?=
 =?utf-8?B?bmJpbEhINy9qczY4ekVzSS9DUldybFB6b1BCQkxYN2hZU3k5WlUrb1VqTkMz?=
 =?utf-8?B?WC9ueXZXUU1GRk92TW12cDhIZ1d3ZnI4ckZ3TnErdmtyS1VKOFpSNUxYNERK?=
 =?utf-8?B?cnNJODMveVlUZU1XaUNPcGJGZzBVVmxHYzRzb0xlVjRhYTVMMjVXYThnZEEr?=
 =?utf-8?B?Mll4Q2lQZUM3TEw4cU55S2h3WExoVW1hZlcrOUlzNzZ5clFVZGl4cnI2SmVY?=
 =?utf-8?B?dWdtblJ2TE1rWEcyRUZWODRESG40TDNkWVFqNVZReVE3REx2S1BlTGVjUCtl?=
 =?utf-8?B?SkEzbVJxK3Q4cnk4QW9lSFRIRW4zVjQvZE1tcmlGUTVnRFgyZ3BGTEgvOFhs?=
 =?utf-8?B?RGhlM29VeHVpdUg5eGJVa2djQXhNN0xEdXVMQWhPUzIwMkMrczVHdURkWkZX?=
 =?utf-8?B?a2p3WjBoYVZDUDZFUGduU0E1TndGRmErdC9ybG5CTFJmQSt4ZTB3QzBmamJV?=
 =?utf-8?B?YTBseEwxWEFPdlM1UWdVelpKZUM4anJJQlJ4aFc1N2s4aHRlbHN4ZE94NHNw?=
 =?utf-8?B?N3czbUQ3eUtsTG5SS3RWVDBrWno2MHAxbEV1TFhOYnlKeHE0OVhwWjlYTHNO?=
 =?utf-8?B?WnlxWjQrVU04cFRPWFp2WEFlZ1JhcDhFQS95SW9yTzVCdHBzQWQyM2Izb0k2?=
 =?utf-8?B?ZmRidEJ1UkVDREpvNldWUjA5Q01SOHhpN1h6MW96V01ESGZjbURBdnlEemNt?=
 =?utf-8?B?NXpzS3BOc01Ed2JVTHpwWUhMWEFGMlR0dnA5akduSnVsV0p4eEhVSklNVmto?=
 =?utf-8?B?TUcrVjY1d1lLTkpUcVNPUEtEalhnckJmdXRoaTRUdnZtVGdKQnJiVmo5dENh?=
 =?utf-8?B?VDhZSjlkdUtmZCsvcTYwTXJTREZlaFpEYXBlOUF3LzZiMDNiRVgrMks0WThw?=
 =?utf-8?B?SDdGbSttWmx2N1FwVmJua0ppZ1NzcHVQb0E3NmRwQjBlVjlMY0RyL01GLzBJ?=
 =?utf-8?B?WHBiSjRjalpnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk9Cb1h6VGhvOVdOcFd0YWY2dm8rdG1vVkFqU3ZyRnZwbjdKNVpFSXhTREFD?=
 =?utf-8?B?UUl3alJweUlnRDk0ZUpXYks1VkZaRERGdWE5RFB5TkF0V2dYQmQrbjllWDMv?=
 =?utf-8?B?Y29tRjhRZGl6cmdvdTZBSEFqeDVOWER6ZlF1WHh3cWZEYXVOOTRYTk0rTUp5?=
 =?utf-8?B?T20vRzV2Z1h1Q05wTDloVHJkajZ2Q1dFUmNDV3pJZ0tnN1hZYWtTaDZGTVpF?=
 =?utf-8?B?U2F0YnRXeEo3cjk4TVYyK3dTNktWWEFpMnpoU25VY1lCMDI2YWJzZGMvOXg5?=
 =?utf-8?B?YWRqbXh2QVNKNUYrZFZDUkp1ZGV1OElQNW5WSWNJY3h4SlJCZWZocHdheHEv?=
 =?utf-8?B?OUgyUkFWdnZZZU5BYWMvMXQ4bWtxY0c0K2lhOHpSOUpkQUd2L3JkYk9jTU1Q?=
 =?utf-8?B?VTFKYTc1WjNGOFBRblpKVVhJOUlibnJBVUROR0o4UXpsUCtjQ2V2M2VxaDNW?=
 =?utf-8?B?cy9HRTNFWjZBc0toYXBHQkZGMmdDNVFGcGdIOTFhejU4STBFNU9RZkxNWWl6?=
 =?utf-8?B?ZkdCbExlNDY0MitTK2lzUlpIZ2xhVm15aXlHc0wzd3lTUitXTkYzNjZqZTRH?=
 =?utf-8?B?YTlpNXY3Uk5yOHhwQjRBQnlHYkdBSkxVZnJwQXVqenhaTmo3ZHU1eWpwQSta?=
 =?utf-8?B?OEZtWlNVS0UzalRvSyszRlJVYWt0SHNrRVMwY3hOMk1RRUJ2Qmt5NW5TRGRZ?=
 =?utf-8?B?b21qOWg3Q3gyQnhpVmQwVm5WSjhvMWxEMUJqSmxtQmtCRUVKQlVCOGcrZEN5?=
 =?utf-8?B?eU5LV0lnQ2hVOVE3RHZwZzFPQy9kN1hIbFNCUU1ScUZBOTBEZEM3T0NOdDRI?=
 =?utf-8?B?OWZCQmp5dUVEcm1sQ0VmWGZ3ejJ4SGJMQ01iWlVFZDQzNWpOWSt1TTBGa1Nw?=
 =?utf-8?B?UkVJZW9CZy9QcDZvb21ZaVBFMVJLOHlMYkFSbjJhcGFWRURyTXRmSmhaOWlG?=
 =?utf-8?B?NGUrYTA5MHVIQWVEaXhhK1I2NE5DS0RwWVZwa2VuWXVQbDUyL3NzN2lPZXVt?=
 =?utf-8?B?cTk4STYvekJDOWRmYi8rSlpHd3VyQTJwUTcxcStpeUJwZnI0ZThKTEFyRWdp?=
 =?utf-8?B?SGdGZDA1NERNV25lSGtPR2RHYkNoVXZRTUdBMVFlZ1NOOU9VWmR6VWZxdE5w?=
 =?utf-8?B?N2syZzJ3SDZZdnkzZ0k5c1VCMjNZN0QzU08rMU9VNzVNZFFWZVNmY3EwZWxt?=
 =?utf-8?B?YWFHeTBuWlp4dTB4UWFwQWdMNTRuNzh3QStxRVBhL1JnZHpFWUN1aTZaaW9q?=
 =?utf-8?B?NUtkUDhsZjhVOU5HQnhPS0lmTEpTam50TUVtaUpnVHhkVVZEckJyV1ZRb0dM?=
 =?utf-8?B?Zzd3REgrWGlMTDdtL3RTWkZLR0dzYkhHZ1dLaE5CRFVobUM3YlorMHBlT3ps?=
 =?utf-8?B?d2VIUkRzTkZGTzdqbk1DbkJVOTN6QUpud3FVWkxOdnpOdkpOZGhyaXQ2T3VB?=
 =?utf-8?B?TEUzQ0xrUHFJTUxSaWR4SzZheUl4c1dlcFBndUZISWZXNnVEY3daSXpZWVNM?=
 =?utf-8?B?bFpuSE8yaVdUVVgzWjZXY1QwOXN3elN4dWJsUGdiSlVJcmZPY1JzVXJSQTEx?=
 =?utf-8?B?T1FpT3ZHMUZMMjBNQkZUZFBqNzZBMTh3RE9NN1A3Uy9zY2VmNkxHY2QrM2ZS?=
 =?utf-8?B?SVhyVEszTGo1THJwUzNvZmgyaURKWHJIMlZldHM2bFAvNHhhRjNVeWRqTm9l?=
 =?utf-8?B?R04wRXZtU3pObkROUHBNdUc1SEtmdnpJOEVLaU1iWjhWMFVjTVJKbXgzakFp?=
 =?utf-8?B?SVdTTEVOQWpXdFFXamY4QXVxemUwRXZzRnBiWlIzS2N5NHQ2blVjTld0eEhI?=
 =?utf-8?B?aDJZUUZEWGllcy9xV3NnNkZMMytJYk5IUUFiRmU2QWdza0ZqR3QvNlRRbTVC?=
 =?utf-8?B?alUrUnI0c2ZPenR5MmNyMWJZeml1eUpyczhoR3dhVk9PcE1DMlN6RkQxUjhk?=
 =?utf-8?B?aGRYQkg5MFk1QXZJOWs4b3ovS0diSmlCNDJ6ZW5ITFJBd2VPb3V2OG1XVS9E?=
 =?utf-8?B?TytXM2VhUEtzV3haaFhRR1VvaG92cjFqcXFudEh5amFCUkwwRjZxRm5sNEFz?=
 =?utf-8?B?em9MV3JBeUlUYXZ3ZTR0aEx4bUo4RjdMWFlvZldKb0dHdHRpL3ZiaGtPWE53?=
 =?utf-8?Q?r5n8AHfifRpvur0Iuj9jt0Meb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b524800b-acaf-4ca3-d365-08dd70f5aeec
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 08:17:46.0114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPc4yjzQXA0HbxIZI4GW5Cbu4WKvYnsIJT3mO0LP+963DdaS8nxfnKtAN+5T9NCy5olHtu83l/20Q2tp0nLZBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7918
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
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIgyMuaXpSA4OjQ2DQo+IOaUtuS7
tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+OyBUb20gUmluaQ0K
PiA8dHJpbmlAa29uc3Vsa28uY29tPjsgTHVrYXN6IE1hamV3c2tpIDxsdWttYUBkZW54LmRlPjsg
U2VhbiBBbmRlcnNvbg0KPiA8c2VhbmdhMkBnbWFpbC5jb20+OyBTaW1vbiBHbGFzcyA8c2pnQGNo
cm9taXVtLm9yZz47IFN0ZWZhbm8gQmFiaWMNCj4gPHNiYWJpY0BkZW54LmRlPjsgRmFiaW8gRXN0
ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgZGwtdWJvb3QtaW14DQo+IDx1Ym9vdC1pbXhAbnhw
LmNvbT47IEFscGVyIE5lYmkgWWFzYWsgPGFscGVybmViaXlhc2FrQGdtYWlsLmNvbT47IEFsaWNl
DQo+IEd1byA8YWxpY2UuZ3VvQG54cC5jb20+OyBMb3RoYXIgV2HDn21hbm4gPExXQEtBUk8tZWxl
Y3Ryb25pY3MuZGU+DQo+IOaKhOmAgTogdS1ib290QGxpc3RzLmRlbnguZGU7IFJhbmphbmkgVmFp
ZHlhbmF0aGFuDQo+IDxyYW5qYW5pLnZhaWR5YW5hdGhhbkBueHAuY29tPjsgUGVuZyBGYW4gPHBl
bmcuZmFuQG54cC5jb20+OyBZZSBMaQ0KPiA8eWUubGlAbnhwLmNvbT4NCj4g5Li76aKYOiBSZTog
W1BBVENIIHY4IDAyLzE5XSBwaW5jdHJsOiBueHA6IGFkZCBhIHBpbiBjb250cm9sbGVyIGRyaXZl
ciBiYXNlZCBvbg0KPiBTQ01JIHBpbiBjb250cm9sIHByb3RvY29sDQo+IA0KPiBPbiAzLzIxLzI1
IDg6MTUgQU0sIEFsaWNlIEd1byAoT1NTKSB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPiA+ICtz
dGF0aWMgaW50IGlteF9zY21pX3BpbmN0cmxfcHJvYmUoc3RydWN0IHVkZXZpY2UgKmRldikgew0K
PiA+ICsJc3RydWN0IGlteF9zY21pX3BpbmN0cmxfcHJpdiAqcHJpdiA9IGRldl9nZXRfcHJpdihk
ZXYpOw0KPiA+ICsNCj4gPiArCXByaXYtPmRhaXN5X29mZnNldCA9IGlzX2lteDkzKCkgPyBEQUlT
WV9PRkZTRVRfSU1YOTMgOg0KPiA+ICtEQUlTWV9PRkZTRVRfSU1YOTU7DQo+ID4gKw0KPiA+ICsJ
cmV0dXJuIGRldm1fc2NtaV9vZl9nZXRfY2hhbm5lbChkZXYpOyB9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgaW50IGlteF9zY21pX3BpbmN0cmxfYmluZChzdHJ1Y3QgdWRldmljZSAqZGV2KSB7DQo+ID4g
KwlpZiAoSVNfRU5BQkxFRChDT05GSUdfSU1YOTUpKQ0KPiA+ICsJCXJldHVybiAwOw0KPiANCj4g
V2h5IGRvZXMgdGhpcyBkcml2ZXIgc3VwcG9ydCBpTVg5MyAsIGJ1dCBpdCBpcyBleHBsaWNpdGx5
IG5vdCBnb2luZyB0byBiaW5kIG9uDQo+IGlNWDkzID8NCg0KVGhpcyBpcyBteSBtaXN0YWtlLiBX
aWxsIGNsZWFuIHVwIHRoZSByZWxldmFudCBjb2RlLg0KDQo+IA0KPiBJbiBjYXNlIHRoZSBNWDkz
IHN1cHBvcnQgaXMgZ29pbmcgdG8gYmUgYWRkZWQsIHlvdSBwcm9iYWJseSBuZWVkIHNvbWV0aGlu
Zw0KPiBsaWtlOg0KPiANCj4gaWYgKElTX0VOQUJMRUQoQ09ORklHX0lNWDk1KSAmJiBpc19pbXg5
NSgpKQ0KPiAgICByZXR1cm4gMDsNCj4gDQo+IEJlY2F1c2UgSVNfRU5BQkxFRChDT05GSUdfSU1Y
OTUpIGRvZXMgbm90IGF1dG9tYXRpY2FsbHkgaW1wbHkgdGhhdCB0aGlzDQo+IGNvZGUgaXMgc3Rh
cnRlZCBvbiBNWDk1ICwgdGhhdCBpcyB3aGVuIGlzX2lteDk1KCkgY29tZXMgaW50byBwbGF5IGFu
ZCBkb2VzDQo+IHJ1bnRpbWUgY2hlY2sgZm9yIE1YOTUgLg0KPiANCj4gPiArCXJldHVybiAtRU5P
REVWOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtVX0JPT1RfRFJJVkVSKHNjbWlfcGluY3RybF9pbXgp
ID0gew0KPiA+ICsJLm5hbWUgPSAic2NtaV9waW5jdHJsX2lteCIsDQo+ID4gKwkuaWQgPSBVQ0xB
U1NfUElOQ1RSTCwNCj4gPiArCS5iaW5kID0gaW14X3NjbWlfcGluY3RybF9iaW5kLA0KPiA+ICsJ
LnByb2JlID0gaW14X3NjbWlfcGluY3RybF9wcm9iZSwNCj4gPiArCS5wcml2X2F1dG8gPSBzaXpl
b2Yoc3RydWN0IGlteF9zY21pX3BpbmN0cmxfcHJpdiksDQo+ID4gKwkub3BzID0gJmlteF9zY21p
X3BpbmN0cmxfb3BzLA0KPiA+ICsJLmZsYWdzID0gRE1fRkxBR19QUkVfUkVMT0MsDQo+ID4gK307
DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvc2NtaV9wcm90b2NvbHMuaCBiL2luY2x1ZGUvc2Nt
aV9wcm90b2NvbHMuaCBpbmRleA0KPiA+IDdhYmIyYTZmMzZiLi4yNzllYmJhZDQ0MCAxMDA2NDQN
Cj4gPiAtLS0gYS9pbmNsdWRlL3NjbWlfcHJvdG9jb2xzLmgNCj4gPiArKysgYi9pbmNsdWRlL3Nj
bWlfcHJvdG9jb2xzLmgNCj4gPiBAQCAtMjQsNiArMjQsNyBAQCBlbnVtIHNjbWlfc3RkX3Byb3Rv
Y29sIHsNCj4gPiAgIAlTQ01JX1BST1RPQ09MX0lEX1NFTlNPUiA9IDB4MTUsDQo+ID4gICAJU0NN
SV9QUk9UT0NPTF9JRF9SRVNFVF9ET01BSU4gPSAweDE2LA0KPiA+ICAgCVNDTUlfUFJPVE9DT0xf
SURfVk9MVEFHRV9ET01BSU4gPSAweDE3LA0KPiA+ICsJU0NNSV9QUk9UT0NPTF9JRF9QSU5DVFJM
ID0gMHgxOSwNCj4gSWYgdGhpcyBpcyB0aGUgSU1YIHNwZWNpZmljIHBpbmN0cmwgcHJvdG9jb2ws
IHBsZWFzZSBtYWtlIHN1cmUgdG8gbmFtZSBpdA0KPiBhY2NvcmRpbmdseSAsIFNDTUlfUFJPVE9D
T0xfSURfUElOQ1RSTF9JTVggb3Igc29tZXRoaW5nIC4NCg==
