Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24BDC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 04:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4240E88005;
	Mon, 22 Jul 2024 06:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="h/TBuK4o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D80928811C; Mon, 22 Jul 2024 06:49:37 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97FDD87FCD
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 06:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evP4X7duv5tKFkOhKuknq7FZvNV05tEkdfFT4hrtN5Q0jd0xJGHJRpjSgcRDATb0yayzdJIHOJ4y7rd/0WTwZzcC6JfZZ2378dnBCdB+HRbDbWOFnZHGj/8lRhOBFXHg3V9gNmGdUArptj5d50EOSOvl/qY6L8vYOeTUp202etNvKAkbXkm03rOqEpiQ3ZA2rLJCrwyTDmvkVdfC4UZfxqgyF+hgMEE+FMsBDdC9C7kC7AMXZ1ogqz3AuL6OiKo9nGRHojWNZePszKDbU6W9khcnFn15VhxzOs6ZgEALIxwBEiAAV9G9BbJ2qvTC9F1dV2iajUEHLPFlnsVe5QCTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1N9VWZgaUDxcYOOuPwB3FhcQ/cUpR6hnOfWapmZzvE=;
 b=TCA8CnssVlJDhIYZFcctltFbfY7xMO7H0B48wDvMvNelywnzsiefjoMDwt4xe7RJPChtHLIkrMWfnsJnz+iUohILm1LnCOEf2s3UdFulQJu6SCaMGZYGirftp2tv3XiWsv1mbaq49GBjUt6jA/qq1bP+s80qzNvprU3pNrB44mRGHynlJM+e6iY4OMO0oZYz4bwcoUAdDOOSWPWrnG50isvD7dIyBQ4lsNJRy2ROpRhtpJ93c1rN1MI5JbvMG6pnWtblFMyOX1yvRgUZx3MJdm09RIUfXT6ktfYSzboIVOBCFNml6rwRXFDQSKzL6OY31vhv6FJ/YD+IpAVHsFaOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1N9VWZgaUDxcYOOuPwB3FhcQ/cUpR6hnOfWapmZzvE=;
 b=h/TBuK4o998P6lzIlow/+jCoE2em+Tiher+C3L2CQ+Ar+8Hp6hR9ozyN5SeKnvE4a28WoLKr56FqDHl4srmSA89w2d3COZxvYtGFE8rjnI8V1ibHuems7C3guQySsrxEz+vFJtt8wXS3S4W4tTi9E5ePdVjbq7+NKauXblBtAtE=
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by PAXPR04MB8974.eurprd04.prod.outlook.com (2603:10a6:102:20d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 04:49:34 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 04:49:34 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sbabic@denx.de"
 <sbabic@denx.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>, Peng Fan
 <peng.fan@nxp.com>, Tao Yang <Tao.Yang1@nxp.com>
Subject: RE: [PATCHv1 1/3] mp: imx9: add cpu command support
Thread-Topic: [PATCHv1 1/3] mp: imx9: add cpu command support
Thread-Index: AQHa2c61VdaMy049jEmcHciFmSKdsLH+JoqAgAQHmYA=
Date: Mon, 22 Jul 2024 04:49:34 +0000
Message-ID: <DB9PR04MB9236828736AB8D24F8B2547F84A82@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240719114850.28134-1-Zhiqiang.Hou@nxp.com>
 <20240719114850.28134-2-Zhiqiang.Hou@nxp.com>
 <CAFLszTgmhnQBO4LtXfY_COuVWPA1TANQwGASDCpf5bm2OFd5xg@mail.gmail.com>
In-Reply-To: <CAFLszTgmhnQBO4LtXfY_COuVWPA1TANQwGASDCpf5bm2OFd5xg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|PAXPR04MB8974:EE_
x-ms-office365-filtering-correlation-id: f465cc43-b999-40cd-aec5-08dcaa09aeab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SXpydDdERGFDNXBNVzdOWXltOFVoZXg4Si9aUTVqRlN2K3p3bTI2L2ZjdEd2?=
 =?utf-8?B?M3hrVlJqTDFvYWZZeTNXLzhJSlQ4L3Q4ZUw4aGRYSUpOWFB4QmU0OUtGUjB6?=
 =?utf-8?B?UUk5bGw5TU1qR3gydUtjdENGdzA4T0pnaG5nVlllZ20xcjk1alVTbDFOL3hJ?=
 =?utf-8?B?UnBIOUFCYVNwbUppeXUyNE1ZU2RTVmZIOTN1QVRNNnN2UnBSQ2hwellKZGxD?=
 =?utf-8?B?Snl0YXFkVW5HNVcwdHB0NldaUWdOTHBycjg0WThUWHRGUkY1cW40bzcvWkph?=
 =?utf-8?B?S0hVNHY4SjRJUUlkV0pzaGJhaWoxT3o4SFllaUZQS3Zac2l3ZEthWldjQU0x?=
 =?utf-8?B?Sko5UllaV29pdzVyWmZRUmFPd2Z5ZWZwNUhRYjJqWlhLQTY4Wkw3Q09KL0Qr?=
 =?utf-8?B?VUZHbjZNWW1Kazd2RVF5NWFxMzZ6YXhySXJTY1MzdGpMN0I1VHZielY1a1ha?=
 =?utf-8?B?Q1N1cmZWMDhpbzdXS0NmTnNvMUdzL3VGSmkrMEdSVWZUcGtxeS9NVngyeU1P?=
 =?utf-8?B?MEwzZEc5ZGtndnBiaHZqTHNpSE9DQW9mSnFoTFlKSVpzVUxRaWUyaEdFand3?=
 =?utf-8?B?a2hENVJkTHhQOTVpdjV0MEEvOFZkMURqV1hoZXZncU1KLzkrc00zTXQ4Qmpx?=
 =?utf-8?B?alZvTEVGUTNMS2hBUTlQOFUzTVdaS20yLzlNL0pkQnJPbW5CQTFsNENxTWR2?=
 =?utf-8?B?ZDhaN3BtZlp5NUR2cDBHbnM1TkhrWkNrUXE4OFRXZy9ub2VuWEozOEZ2Z1Z6?=
 =?utf-8?B?a21FMTVzSGRTWlhmSXBhV2IvcWlaT1k3WiswTXZaRDVlTVZuKzBWeHFlV2FP?=
 =?utf-8?B?UlBKbUhkWGR0dHl3VVFJS0ttdnNFNkZseDltemVMTkh3K1Y3TGd5UEwvN1lS?=
 =?utf-8?B?MHdueUZDWlBrNkxhRkJiY1dOWVA1UC9mQjd5OE1YNWtCcHdoRHNuY3NwdWhL?=
 =?utf-8?B?SEdQM3g5ZythcU9sSWxtZUNjdnU4cnI0RVhwYkNxRTNCYUw0dkZTcWNCZ3lE?=
 =?utf-8?B?a2dMMFUxVHFWU3RKM0hZcXNGY05hNWVZY1Z4S3JkREJRblk5ZjVtbVNLMERU?=
 =?utf-8?B?YmpVZHlBTXpQVllzUFdvbnFwSHcyclVXWFJ6MEgwaTZtOTFkWTFqdnZBQzNK?=
 =?utf-8?B?TTR3bDZjKytUU0VWV0Z0MWhsR0dtT0s3ZS9NdEFoYXdJOGROZ2hUbytTaFNv?=
 =?utf-8?B?VWgrQ2tqWTNpZmg1SzVlZFBUSW81YTlWZDVhbFhSMUU5THk4S2pnMkt6Vk1u?=
 =?utf-8?B?bXRMN3k0bEtNemtyay9ram8vSkZqYk9Fa05UQzJOeC9JejZ6RGl3TzBta2VJ?=
 =?utf-8?B?SGhHak1yQ25PYzlNWDJseW9IRy82eGpxdGo0NWtLdVBHWDAyN0hJd3NTUGti?=
 =?utf-8?B?aUpKcGdVRzVMSFVBaFl2TE1Ya1BRRk1FUFdIc0w3L2JNZUE2YkRwUlI1YmYy?=
 =?utf-8?B?TGFLajFKYXlHQW9URUttSXFuTGhMM0xaK3ZWeHY4a0wxVVJ6ZVlad2RxTEpX?=
 =?utf-8?B?eWN4R0R1aWdYdzhMZFZRL1FMWTI4Wm9yNWR5Yi9kbk5abE9IUFYxYlNJMkRM?=
 =?utf-8?B?T1phUzJJOWpjSTNGYjN4aFdPWDExaHZTcXpRSDVhWHdoS1RuR0VCTG5uVUpJ?=
 =?utf-8?B?OGVEQnFIZDdoWXdqQmNldXZMNnJKcGdoQVRaTjV0OEdPT0Z0NTFpMVVGNitI?=
 =?utf-8?B?SnNPeTF1VksvRHJQTFhTVnJEcUVYblUwUGY5TW90aThNV0RnNjhvQlRqQm8x?=
 =?utf-8?B?V3VickpzdEJIczJIKy9OcTJ4SFJyTW5hN0lmSnZmZ25ZUGFMcDJ3OVMxUk1s?=
 =?utf-8?B?R3l1NzlwbUlUaTBMMzdXL1BKUmdnSWZBTFJLRVMwd1RFOWRIQlFjcGRQN3Nl?=
 =?utf-8?B?cEIrVWF2ME5uVlpOaWwvWStkbHBhazhzQ2xOSHcvbzg2V1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEg3MFpkQjFWR004RlNHNkhQZzBJazFOQ2tTWVdhZHgyZHd4bGpXZmxxQVU4?=
 =?utf-8?B?czBNWmE4RmN4elR4VFVVaFplMjgva3ZwRHRLTWtKTjRTT0NpZ1VER0RmUHlx?=
 =?utf-8?B?Y09LQU1vWmtPMlBCdnZJYXdmNVNCQW8vUjFNeEdxbys2djF3Y1R0VXNrcUlJ?=
 =?utf-8?B?R1lvbVF4RUlkUjJXakhkU2xrbDE2UUVWTUUvdmdQYWZTb2NQMVNKYkhlMWNN?=
 =?utf-8?B?Y2MyYy9jUWdYWGNHaTIxa2NxMjFvUG80QWl4eUhQdVdMKzFKWk8wS2xadlA3?=
 =?utf-8?B?NzNlTWdRaWVaeW5MOWxGeVd4VlNlR3JReXplb05Qb3FwaTNBbWY5dzA2N0E0?=
 =?utf-8?B?MmJwOW00NEF5U1dMTWdkOGpSazdBTWMzeXNKZEdqWE8zQmxkcUYrcVNPK0dN?=
 =?utf-8?B?U2c1UkZRLy9jNURxdUMzOGh1bzhUUkpKMk9SclgyZGxnNW56YmpUbWtRQ0VZ?=
 =?utf-8?B?RGcvaHg2Mk1POEJNVGIvei9qMnBUU01zRy8vc2hnY01KU1NUemRqaHY5S1Ez?=
 =?utf-8?B?WE5NNU5RZ05TQ0M2VS9TVTcyQmJjaUhVUExWOUszZDk4R2RMaVdIcUVXa1VY?=
 =?utf-8?B?V0FseTcrNWpIL0kyakZCRG9laUhreDg2bTM2MUJ4YVljc082WmFjWEY2VDBi?=
 =?utf-8?B?QW1EVTVLejhpTm5GYnZTcFBuZS9yVm1kUUE5OUtydkdQcGJHemNpOHAzVkdI?=
 =?utf-8?B?OUtXcDRET2k2RXpIbUhud2FTaDhGeHdVcVFaYVRMKzlzRWRsM3poUHF0T0Jl?=
 =?utf-8?B?c1pVRVE1NGhNRzNMdXJtS3h3bnkrRG5OREI1WmhEb2Z3K0dKaFBGZ3MxTmRN?=
 =?utf-8?B?cTQ1UDhVcE5IZ2x3elQ0a1FvajdJeXpEbFNxY3J0VDVlWWZIeVJjVVZPVEdi?=
 =?utf-8?B?UGM5em5OamEveFlRYmEweUJxTjFnanhYQTg4WlZCait3Y2lBRjFPaGlWZFN5?=
 =?utf-8?B?QUp5Z2pGamVjb2xJS0RpZnlBd0NTL1ltdkoyeE95SXlHeFlpU3djbUxrbFVD?=
 =?utf-8?B?WEIxVU1aT1pPRWFzb2NiamNXTTJTWGtzZkFNZnB0MnRzNmh6ZHJLY3hCS00z?=
 =?utf-8?B?Q2phOHpCWXBqM1hUUzc0L0RqN3UxTDlUNUFYUElXZTZtaG16ZHQyZVJYdk4x?=
 =?utf-8?B?OVlhUlduRk5uRFBXeGk0VTM5NWlvWSs5K081KzBYaUlzRktiNkV1MGN0ZTF0?=
 =?utf-8?B?dGJCa2Y3RW5vYkZZajE4bDBsSXdHUkQ5SWpYOXVuVVV5NGFuVExwNW9qYWNy?=
 =?utf-8?B?S2VyVXBIUnFSMTF3a3o1SkZ5bGsvYVFsRzF0V21OcHp6aktrWG9pR3NBc3k5?=
 =?utf-8?B?cTFWUzdwbFhnWW5mZlRQdnk1eFdYOHY4bnQrOHp0TTJFWW9PLzJ4aTN4Mnpa?=
 =?utf-8?B?dmtidG9CcEhranVXV2xTcE0zUlJ0M2xjQkxMY1JGS25sS2hmd085M2pkdWFI?=
 =?utf-8?B?RVhlRnFJWDJtSDkvbjRoNVU5ZFpMYU5JU1NGbGN0eG5GYngweDdiMjZPazhZ?=
 =?utf-8?B?eVZBN2laeU54NE5RZVNLMndocU1GbmEyUVdLZXp5TFBYdEt2akc3OFFmSDR1?=
 =?utf-8?B?WlVEeWV5OWZVOFNJZUhYcXI3aTF2WVUwVVhJUDNtVTAwcGhjUy9OQnFsOTh6?=
 =?utf-8?B?UFJzcENzVDAyQkRUNEEvQzIvSHkxNkZvakF2UHZETHNyZHhud2E4cFoyYkZ5?=
 =?utf-8?B?QStnQXNUdm1GYkpaZU82ZWUzTHlKeC80Y3Y1WGloTTZvL1EyTDFHUzYvY3lB?=
 =?utf-8?B?L1MzTXpwMnBEVjFjNDJvTUFrRWF3dFBLblVReHNjQmJzNmtSUm9GZ0NmTFpJ?=
 =?utf-8?B?UWUxMFBmSXNOVWdiYkk3aTZCeDUxUHZyYmJtVVRaM0Nxd2pYaGN4NjlUZEpi?=
 =?utf-8?B?cU50L1duZFNPQUVRQzZhTGNLakdkMDgyS3hmSDc0Q2xXLy9NN3Jpaml4YWhP?=
 =?utf-8?B?R2I3bzRsclZjUC9BYThodFlXVnVPdS9rVFpVWXEvZXI0T2Z2Z0dPYWY4Z2pj?=
 =?utf-8?B?QkhtbGhhRUJZcGtDOGtrcDBmT1c4TjVneEdFbHMwN000ZG45UTBRYmVndU84?=
 =?utf-8?B?Skc2RU5MZ1UvRW8vY0FPNU9IekRMb0IvMUNHQStGVzR6S05lakJwNDhxTVB4?=
 =?utf-8?Q?ZtVB8iUp/Qd2/qhBA4gZmiSSu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f465cc43-b999-40cd-aec5-08dcaa09aeab
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 04:49:34.1456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m85443mPi6M2yaAi59kIchj9DjSqCs6UmEZ1SmgJ8bGM6QGprERyaH1MBuOxevkDq7v/1E+pY/cix+1B/1HECQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8974
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

SGkgU2ltb24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24g
R2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAxOSwgMjAyNCAx
MTowNSBQTQ0KPiBUbzogWi5RLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzogdS1i
b290QGxpc3RzLmRlbnguZGU7IHNiYWJpY0BkZW54LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+
IGRsLXVib290LWlteCA8dWJvb3QtaW14QG54cC5jb20+OyB0cmluaUBrb25zdWxrby5jb207IFBl
bmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPjsgVGFvIFlhbmcgPFRhby5ZYW5nMUBueHAuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjEgMS8zXSBtcDogaW14OTogYWRkIGNwdSBjb21tYW5k
IHN1cHBvcnQNCj4gDQo+IEhpIFpoaXFpYW5nLA0KPiANCj4gT24gRnJpLCAxOSBKdWwgMjAyNCBh
dCAxMjoyOCwgWmhpcWlhbmcgSG91IDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiBGcm9tOiBUYW8gWWFuZyA8VGFvLllhbmcxQG54cC5jb20+DQo+ID4NCj4gPiBJbXBsZW1l
bnQgdGhlIGNwdSBjb21tYW5kIHRvIGtpY2sgY3B1IGNvcmUgdG8gcnVuIGJhcmVtYXRlbCBvciBS
VE9TDQo+ID4gYXBwbGljYXRpb25zLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFvIFlhbmcg
PFRhby5ZYW5nMUBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8Wmhp
cWlhbmcuSG91QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL21hY2gtaW14L2lteDkv
TWFrZWZpbGUgfCAgNCArLQ0KPiA+ICBhcmNoL2FybS9tYWNoLWlteC9pbXg5L21wLmMgICAgIHwg
ODENCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hh
bmdlZCwgODQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKSAgY3JlYXRlIG1vZGUgMTAwNjQ0
DQo+ID4gYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9tcC5jDQo+IA0KPiBUaGlzIHNlZW1zIHRvIGJl
IGFkZGluZyBtb3JlIGNvZGUgdG8gYSBkZXByZWNhdGVkIEFQSS4gSXQgc2hvdWxkIHVzZQ0KPiBV
Q0xBU1NfQ1BVIGFuZCBkcml2ZXIgbW9kZWwuIFNlZSB0aGUgY29tbWVudCBhdCB0aGUgdG9wIG9m
IGNwdV9mdW5jLmgNCg0KVGhhbmtzIGZvciB0aGUgZ3VpZGUhIEkgc2F3IHRoZSBjbWQvY3B1LmMg
cHJvdmlkZWQgYSBuZXcgJ2NwdScgY29tbWFuZCBiYXNlZCBvbiBVQ0xBU1NfQ1BVLCBJJ2xsIGFk
ZCBhICdyZWxlYXNlJyBzdWJjb21tYW5kLg0KDQpUaGFua3MsDQpaaGlxaWFuZw0K
