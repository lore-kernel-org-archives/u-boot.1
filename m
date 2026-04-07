Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1564BFEEF31
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 12:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8275A83F98;
	Tue,  7 Apr 2026 14:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="cWYOJFAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 011428404A; Tue,  7 Apr 2026 09:16:15 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79D678352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 09:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jg6C6WsFh2dBuyszw5dOzlbceXpSLc90xL8syP4/Baa04FFn64BUyXkFsfpOzDqGT4lgynlF3bKyUAI1sq9rrLoggp4KuVfA0YdB/dTg6D3FZzTzgzYvm6TUS4MNjMFyAshgVQn/rpeIv1goQp9HvPFgmV+DThRIbiTV18Y4S/4w1abysK9rYFdRDL2clHX2XM+TWcxBBeO96CFYHqqNqCkJ9GmzfjGSSeryfztlLjPNQVR4+t4IsRQvDA5Nj7PMc3+Tq1RY9ZY2io65KmPcz4q3HK5C4YjEMnzuCcFpAqwSYExlSC1zae/ksodH0kkEJn0RCsbeWH5iEqkRaUMjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtQKE/bv5giTYfDuNVVXU7LJCA3OqpneFq5XOUQvaRg=;
 b=apu3dCgxBd1GbqUdjr6drc34FLhAatMj+005ZBAhd42bSQ6Qfi9i4EocgP2u0MU4vd2aPrYiNRQFBHXfHgFjHj6+z0eUuKxcDkTo3mDj08ApRgFGXsoTkHBSVQpEgcOxNk21BjCVtvMXHq6ygvqk1vn90fthbPjNYGKJJqjgl0w1Ej+kEmXi11RcrepdaRzpfqNnMxUDppSWDdIdGXH88yGJma5nuj4XoIIhxR33WHsAZzEglwOOF9S+DdRqSUJWuj/LA8uota+POwPcvotoF52L+tr/O1qgJ4dK3RnGCVssJK0EDArwZ/mF08ebGMOFOZxBHQoQg6zNO8GslqRO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtQKE/bv5giTYfDuNVVXU7LJCA3OqpneFq5XOUQvaRg=;
 b=cWYOJFAjyE1VAoKkXCJZ75QM+TAPUNU10pxnC2GCdnulOyV5Fmu3to563DZjyY1iLcbBwhO7CsVbJ98AqU+RvZ1TXW1v7nvGC/YAgweoQnxHrwiQVLIQWGBDc3rNzAUgCphp6CJIwFax4JBF6HeVgmJ54P7/JSPkKwPcW0KSMWwdaDWBMCR+88e6FT+0qFlA1oEOF/VpEuNjWwPv+Evn9MfMsa+C0hixKY+qAMWI9kj3QJ+4P2L6gBcIH+iJK2M+vO8hUmtFqYXITWQmEnzNQM0VyR/v3/lNNvBKXibH5/M6D2evV7KrlRQSNaMcNtvMI+BQcJFKu6GK+teavVKq6A==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GVXPR04MB10562.eurprd04.prod.outlook.com (2603:10a6:150:214::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 07:16:08 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 07:16:08 +0000
From: Alice Guo <alice.guo@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: Marek Vasut <marex@nabladev.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Ye Li <ye.li@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, dl-uboot-imx <uboot-imx@nxp.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 =?utf-8?B?VGhvbWFzIFNjaMOkZmVy?= <thomas.schaefer@kontron.com>, Michael Walle
 <mwalle@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Robert Marko <robert.marko@sartura.hr>, Yao
 Zi <me@ziyao.cc>, Heiko Thiery <heiko.thiery@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, Jacky Bai
 <ping.bai@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, Stefano
 Babic <sbabic@nabladev.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYxIDMvM10gaW14OTUyX2V2azog?=
 =?utf-8?Q?Enable_ENETC0?=
Thread-Topic: [EXT] Re: [PATCH v1 3/3] imx952_evk: Enable ENETC0
Thread-Index: AQHcw1lNt752bKqjN0OAqMkCMIGdcbXOyH4AgARoqaA=
Date: Tue, 7 Apr 2026 07:16:07 +0000
Message-ID: <PAXPR04MB9644FCCC862BC4144D23F74FE25AA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20260403-enetc-v1-0-e42ae28ae3fe@nxp.com>
 <20260403-enetc-v1-3-e42ae28ae3fe@nxp.com>
 <CAOMZO5A_Tg4XOYvUekNH8a-t+_0nL7WU8fM1W1LK3QcQDHTsjQ@mail.gmail.com>
In-Reply-To: <CAOMZO5A_Tg4XOYvUekNH8a-t+_0nL7WU8fM1W1LK3QcQDHTsjQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GVXPR04MB10562:EE_
x-ms-office365-filtering-correlation-id: e4ccf153-200c-4d56-f05f-08de947589ee
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|19092799006|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Z+EVT3JzfK2enNfXMcQpa3rChUowgizNQBgCN1H9YzmFN53GmCzwa178r811Hy6yR+KtW2J1NlEPqsKKxQ+ZmIrXGEYV/JhhlO2FFxd7Pb6CjYDJkYUo9RnxRuEkB5azgwKirDFi8qLfh/FVoSMShy5+Y1IXtA4hQ3xBBlmT69WK7ftXfdrD1i8cuyZ0eNuTJCaB4XQxWnOqyczSt3VZJ7l9YMo+Yzaoe9yaqVvIEf92b8gSzgie8WOg38EwKqUpaNFbsbsoAjSMvnCK685R2O/89uq/zbfEE498ii0c4y5ib/Op006pBMEewkUTFeHmGL4J5yXOx5zjaDUl1GpMoKuwx3FYCfYeCZ6aitVwFMGsOsWLvPCTxyWLtEYbVMrinuZ/I/jxUG/ldw4PpFax8QLP/T+QVeAMKZTqF6dGxqIo2JIE9usaqAPL+iDuHIifFCgGvPPT5CethIE1XF/THu41lto+nTtum9AH25YgMwBnofc7O4vggRWqnmH86Jt1LS3UgIcSR8S4VpqQPPtQzz7/NJ6PhOfLQArHWQUzBpsq+7+6M+IL3yEKmXO+KWExXV6Qtkq/bj5igl6XJS/iifk3GGkwc4JdKDD8RhDQjc9DJvw6ckpvajPU2mqyinHuHzpFnfDb1R6fbaR2XqfDE9XuCmm3vdqZuDRdW9p0tLZYGAOg94Rs6cjB74V5oKW+5Yzqg92Dtgwc2F0zyl7EjwG6CI9C7LjxvVQKmAEqTU94rDLYm9vX3KhYm3PHJWv1LwQim1VO8VSysTStwNyYXsWAa0xhaaZVIguEdzWX8oY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHp4TGdPRGFUZ09Bei9ETnBkZTdCNUxZUlJYSzZMOHNWTndRWGQ0dHU2aWYx?=
 =?utf-8?B?NzRuSm9TVjBXN2JLSFl0T2M4TkhZaEZsQkJDQklpcitRa0tVRWY1NE1sYTYz?=
 =?utf-8?B?N3RjZk5jWW1mNldWMVk4T0ZDY3hYbWEyVEdIbWxFMlYyYW40S3lFZXhGdWZX?=
 =?utf-8?B?SGl0RWFvd2k1bDVnWmZkbHhKNGQ4TDN0cE83WXpTZVdiRUdBUjl6alZiWk1t?=
 =?utf-8?B?Y0w5SndXVVE0c092cVZYR0xxNEJobC8zYy9kaU5HNTl3NVJvWFkwSFc3Q0U5?=
 =?utf-8?B?b1kreTMzWlNOZytzWFF1VkI4YlhJQkc0RGVteWpSZmxBSzd5SmR1cHZoRUZN?=
 =?utf-8?B?eml6TXpwL2FCQmRFVGdySzN4UkNxWDhoQU9BRjU3TGtnWlRhY0xESitUR2R4?=
 =?utf-8?B?QUJ0cmtlUmlaMitMWmRxUXE1Y1Npdi92aFM2dm9lczN4ZGxPOXZGc3ZLZXJn?=
 =?utf-8?B?Z0hhd2s1T1puRitDeXBqMU82YzgreWFlckg3d2NGdmIxamNqbVRxeUhZS0k0?=
 =?utf-8?B?QlNES0ZCVHNzN2ZHOEJBME1ZeHB3elkvOTJaQUp3L3NzekxSOGtkdlBuZzRE?=
 =?utf-8?B?ODJ5aXBMMGVYUnh1ZVM1ZFdwK2RndXRKYktvSWxQcGxQRGdyaGw3Wlk1aWs2?=
 =?utf-8?B?OFpyYkgvWUdGS2wrVzd4YVAzWEowNVJWRE9xMEh1M0RYU3d5Q0F0NkxLSFpK?=
 =?utf-8?B?M2hhOHlNa0hxczFXQk5VRUgrSXArSjg4WTBhL2o2dGdYUEpTRjZwUVU4Um5O?=
 =?utf-8?B?TXQ4M2l2NUd5TmVLNk5hSjBNZTNBSDFmL3pGampCUXVxR3lRbXVsVWNHM21p?=
 =?utf-8?B?ZndNVU1vNlRKbVJkSUNlS3RRdFNJcFBoVTc3cEFJVDBoREJjNVpoOGZac1JW?=
 =?utf-8?B?bXAzVytuOWlSL3BkQTllZG40YThVOXg5S2UwWmcvdmk1R0hzZ2tmQ0NtbUFC?=
 =?utf-8?B?UW54amNFZ28veVNNZVAyNmsrTEVJaWc1cGowbTNEanRQclp5d1g1UWprV3d1?=
 =?utf-8?B?TEdjZDZHK0J2ZGg4bDZvTVh0R3UvMHJJWlFKUXVjdkRCNk9uSG5tMXBnbkFQ?=
 =?utf-8?B?TU01MVREUXUzNTA4emMvWHF4VllJcUhxcGNMZ1N0UWt4Wnk3SENhL1MvY0Qy?=
 =?utf-8?B?U1hiN1VnUHNGSElCOEdvUmdLc1VxVWplQVZrMGNLd0xnamh1L2tJZE1ZN1p5?=
 =?utf-8?B?dDZQMzR2RWFxKzFHNThUYTlUZDZjQzBLcXVtSmtYb05QR2o0TExuUkMrZ3JQ?=
 =?utf-8?B?WStReUVZQThFWkVJK252Z1h4VUtjVzFSNFBvMDJIQnQzcHp6YXdHMlNDUDZL?=
 =?utf-8?B?ZDYzOG9DNEtsRlcvV2dtOStIMGx3bDJCM0EzZkxQUFVKTDlmaWN0ZkNDWm9C?=
 =?utf-8?B?Y09UcE1XMzFnZ0pWOXFJamd2WEtJMG5WaitjczBSZ0ZXTEJtek5QNWlmYm1Q?=
 =?utf-8?B?aFk2SkpHRmVmRDVRMjJGZjhONDhUQkhUeXZOcGc3STZkTENsMXUyQlFxSk1J?=
 =?utf-8?B?clc1My9XUmpSSGd0aTBvMXV4cDBBMitPSzJSK2lVdnBzVkROeFhEbUNuUHBF?=
 =?utf-8?B?eUpSTTZ4OU44ak5QTjBsUEhuUWFyUkliSTc1eTY1TkQrRXVOUEJsbFFSVHBq?=
 =?utf-8?B?SVVyMHVGcytyUFNmS21HaWJGQytvYVJuUHR1UGFlUnVITUFFTFhIT3VIeUdD?=
 =?utf-8?B?V2RQQ3NjYjJWTVJwMVVBbzhEMU9CVjhaeTFqemF2Wi9RSng5NjZDSTdybHM3?=
 =?utf-8?B?ampNNGlSSG1xNm53MzZTRmc1TGpxK3Z0ZWZvaVM0azdDa29kdnhhR3RCN3d3?=
 =?utf-8?B?OXhJQTlGcytENVlRYk9XWFZGN29Oci9BYWVrQWVvM2FFeHFxSStoYUVpbVZp?=
 =?utf-8?B?UkZpdUtBbkRvaWNVN01Hcit2dnlCMW9rUEVhYzQ0VmNpbS9PMGF4dTFEZDJp?=
 =?utf-8?B?TTBDWTY0L3hyVExGV0xoVDVreTRxSlRDeE5EZkM4Z3JwRkFjbHZ1U2JLeUZs?=
 =?utf-8?B?MFJjQ0JXbjU1WUV3eUkwOFZDM25KV3hFZlRtWmpMb2w2THhPTDltTXF4ZlJz?=
 =?utf-8?B?WVVtZmZCVFcvSjVMKyt5ZEJJZ3dHTDM5L2Z0eXA3WVlYOXVDdDhlM3Awem1l?=
 =?utf-8?B?ODIrQStCUDRmYWZXSEZtb2dJTnRDMW5adS9VY2tPMjdQaDlocE5jbmNyUStM?=
 =?utf-8?B?L0grMVBvTnplSEQzT0NJNDNOUmFzVFFsUzJlYWxrdTFkNG9tczVONEtWS3dv?=
 =?utf-8?B?b0pkNm9hUmFoc2dseDRGUkthUmVBbDhiYS9INWRCRjJvcG13S3VnZkN1eEFz?=
 =?utf-8?Q?yDPZQ8vlDmSKrmn+4J?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ccf153-200c-4d56-f05f-08de947589ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 07:16:07.9030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fh6DYoBu4TLgk3MKYUZHZmF+SLBKkegUM5OH9PmJBDfxzr46KXclPcLQS2tcO82KzHcMA05B8f1buWe+Bk0eqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10562
X-Mailman-Approved-At: Tue, 07 Apr 2026 14:51:19 +0200
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
dGV2YW1AZ21haWwuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjblubQ05pyINOaXpSAxOTozOQ0K
PiDmlLbku7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPg0KPiDm
ioTpgIE6IE1hcmVrIFZhc3V0IDxtYXJleEBuYWJsYWRldi5jb20+OyB0aGFydmV5QGdhdGV3b3Jr
cy5jb207IFllIExpDQo+IDx5ZS5saUBueHAuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGU7IGRs
LXVib290LWlteCA8dWJvb3QtaW14QG54cC5jb20+Ow0KPiBKZXJvbWUgRm9yaXNzaWVyIDxqZXJv
bWUuZm9yaXNzaWVyQGFybS5jb20+OyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsNCj4g
VGhvbWFzIFNjaMOkZmVyIDx0aG9tYXMuc2NoYWVmZXJAa29udHJvbi5jb20+OyBNaWNoYWVsIFdh
bGxlDQo+IDxtd2FsbGVAa2VybmVsLm9yZz47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhw
LmNvbT47IENocmlzdGlhbg0KPiBNYXJhbmdpIDxhbnN1ZWxzbXRoQGdtYWlsLmNvbT47IFNpbW9u
IEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPjsNCj4gUXVlbnRpbiBTY2h1bHogPHF1ZW50aW4uc2No
dWx6QGNoZXJyeS5kZT47IE1pa2hhaWwgS3NoZXZldHNraXkNCj4gPG1pa2hhaWwua3NoZXZldHNr
aXlAaW9wc3lzLmV1PjsgUm9iZXJ0IE1hcmtvIDxyb2JlcnQubWFya29Ac2FydHVyYS5ocj47DQo+
IFlhbyBaaSA8bWVAeml5YW8uY2M+OyBIZWlrbyBUaGllcnkgPGhlaWtvLnRoaWVyeUBnbWFpbC5j
b20+OyBNYXJlayBWYXN1dA0KPiA8bWFyZWsudmFzdXQrcmVuZXNhc0BtYWlsYm94Lm9yZz47IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsgSmFja3kNCj4gQmFpIDxwaW5nLmJhaUBueHAuY29t
PjsgQW5kcmV3IEdvb2Rib2R5IDxhbmRyZXcuZ29vZGJvZHlAbGluYXJvLm9yZz47DQo+IFN0ZWZh
bm8gQmFiaWMgPHNiYWJpY0BuYWJsYWRldi5jb20+OyBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAu
Y29tPg0KPiDkuLvpopg6IFtFWFRdIFJlOiBbUEFUQ0ggdjEgMy8zXSBpbXg5NTJfZXZrOiBFbmFi
bGUgRU5FVEMwDQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVh
c2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50
cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0IHRo
aXMNCj4gZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IE9uIEZyaSwgQXByIDMsIDIwMjYgYXQgODow
MuKAr0FNIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogQWxp
Y2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gPg0KPiA+IEVuYWJsZSBFTkVUQzAgZnVuY3Rp
b25hbGl0eSBvbiB0aGUgaS5NWDk1MiBFVksgYm9hcmQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybS9k
dHMvaW14OTUyLWV2ay11LWJvb3QuZHRzaSB8ICA5NA0KPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgYXJjaC9hcm0vZHRzL2lteDk1Mi11LWJvb3QuZHRzaSAgICAgfCAx
MDANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IA0KPiBQbGVhc2Ug
ZXhwbGFpbiBpbiB0aGUgY29tbWl0IGxvZyB3aHkgeW91IGFyZSBhZGRpbmcgdGhlc2Ugbm9kZXMg
dG8gdGhlDQo+IHUtYm9vdC5kdHNpIGZpbGVzLg0KPiANCj4gSGF2ZSB0aGV5IGFscmVhZHkgYmVl
biBzdWJtaXR0ZWQgdG8gTGludXg/IEhhdmUgdGhleSBsYW5kZWQgaW4gbGludXgtbmV4dD8NCj4g
DQo+IFBsZWFzZSBzaG93IHRoZSBmdWxsIHBpY3R1cmUgaGVyZS4NCg0KSGkgRmFiaW8sDQoNCkVO
RVRDIGRldmljZSB0cmVlIG5vZGVzIGhhdmUgbm90IHlldCBiZWVuIHN1Ym1pdHRlZCB0byB0aGUg
TGludXguIFRoZXkgYXJlIG5vdCBwcmVzZW50IGluIGxpbnV4LW5leHQgb3IgZGV2aWNldHJlZS1y
ZWJhc2luZy4gRG8gSSBuZWVkIHRvIHJlc3VibWl0IHRoZSBwYXRjaCB0byBVLUJvb3QgYWZ0ZXIg
dGhlc2Ugbm9kZXMgYXJlIGluY2x1ZGVkIGluIGxpbnV4LW5leHQ/DQoNCkJlc3QgcmVnYXJkcywN
CkFsaWNlIEd1bw0KDQo=
