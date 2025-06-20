Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EDAC7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 03:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABDE982CBC;
	Fri, 20 Jun 2025 05:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KRy7nwDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E65E882CDF; Fri, 20 Jun 2025 05:38:52 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3542882CBB
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 05:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjmKVOVYJUobYkC04JC1CssBNPq+AfBhSiUMVZsg2SAk4pMIkEyqFcAQWiF1Wf9WoJMNP+BznQNAaGDyx6MYNeoySeCdrIdaOHrqHjDVaiju7DqPjuEZzkuk+htbC/nI8khkVrfqrJgZLcdwo6PAAl6LmqSEq3u2v1AuUA97OOrKgEJCmqGPzUzkqczlDATI449fLWyhxVfLshsfgITyenDr4MXxiOXBlZXYzz1v/8UhxZQr7UQCpFEzFQZ6S7ZrvuWbtjOEuKRqwyUvwE4hVdIZFHio1dZCjqMZtqmp5LD7ojJYDJmee/YpR5XfnbM/yLXNvTStIEpjTq5SK+HdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ7A3DxEGnTQOW+Xnjv9yCbs9mMcUpIdpqvA1lVqqR4=;
 b=jNbEOtJZZBoiZXy3TjDxFsz50EZeq8pFcehTNYRZkHEo2gpRjcJq5/QaPcS4bLqy9N/kEuaX7WX94GdJVaoX7WO/vQsr2nnx3hIimNd21qm4cI9LzFx5qKUIg1tnoABTPoH5HPyN26c9/wOd1Il4AGhMLQy4MfGAVaB8pWpE8SJcvmnFsN7dcspNHRiOkQgKjcktT7FLUxSwv7TzF/LWvmNOIoQX0yoNVG21YHp0NRJpKt4Mx7XR29uGQwTowqbeRZhrc3vUWrlb8V3x3IMkoNTPGPx4nbGGWIJ0qoBhIE54wNPxC1xnz5hBXsztllSnyt9JRGC7Ci1NMYk8e/ETtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ7A3DxEGnTQOW+Xnjv9yCbs9mMcUpIdpqvA1lVqqR4=;
 b=KRy7nwDbunGZAB5gM/mP+ZhhsV/1YJuny6TuLYgkFHzTtaR1WhGO0moPe+QC2qyDACVf7fJd2hApe28IqIbXRztEkX9GGGNwQeWxzR2UJuZwdeUhpg0BAO5LrXf/kdnnwcclRIeYVxqFbHZ6dwxiynxyi1+JJTV6dnljXaTWFRRoshw1C+q54aUN/Q51gktWlTfRpsxAfFBmAoD0IcuFCPvlXOxSICFpbEVA2XjHh78NGv3ovG2AWSoxfLYD2KqjgrCced7WtwCOk/xIasSNDsYqMp0ggTMquTReTIbGhEo4/qFjkf8/mNp9Fn9gLF93iusjx8CzWCopYP+n13ojzw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GVXPR04MB10900.eurprd04.prod.outlook.com (2603:10a6:150:21c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Fri, 20 Jun
 2025 03:38:26 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 03:38:26 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, Stefano
 Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Enric Balletbo i Serra <eballetb@redhat.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYxIDQvOF0gaW14OiBpbXg4cW06IHVwZGF0ZSBwYWNr?=
 =?gb2312?Q?ing_i.MX8QM_MEK_flash.bin?=
Thread-Topic: [PATCH v1 4/8] imx: imx8qm: update packing i.MX8QM MEK flash.bin
Thread-Index: AQHb4CLfFFrHFAXZk0StZYGbZ6F+TbQIjjmAgALZ2cA=
Date: Fri, 20 Jun 2025 03:38:26 +0000
Message-ID: <PAXPR04MB964484CAD329C884492D7867E27CA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
 <20250618-binman-v1-4-373e66c7a51f@oss.nxp.com>
 <20250618080151.GB13226@francesco-nb>
In-Reply-To: <20250618080151.GB13226@francesco-nb>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GVXPR04MB10900:EE_
x-ms-office365-filtering-correlation-id: 4e2dc0e1-628e-4c08-7e01-08ddafabeab5
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?gb2312?B?aW9YenFxL0xoTE1HOVhGb3VsNGIxMDBPT294WE9NM1l3ejM4aXJWUFdTL1VZ?=
 =?gb2312?B?NEpHalcrcDNhUXNQMzl4OEtLQjBYck40WjdpTk9iN0tLQmdXUVdhWnZTZXVS?=
 =?gb2312?B?dU1SUm9CVWE0SUFWMHl3NzNZanFwVnczYVdwcnpIWmM2SVlJRHFSVGNVcmxs?=
 =?gb2312?B?U2JKTUE3YXRwY2Z0V2lOZFVlQTJOay94TmFqTWYxUUVaa1Y0bmZKRDhGMzUv?=
 =?gb2312?B?Zkg1cTZDRjkyeThVZVhyQkhzRkdiMVhKc3I0d3V5UGVqQ0NyRXF1L2pCRWJN?=
 =?gb2312?B?RXJPVkZzaldsWG8xU1IrSTNNbnBVWlcxV3NzRFpYcjVIZlpQazFOM3RGVmJN?=
 =?gb2312?B?MzhJSGNhenJnUWt6cUo3RXQycVlLWndIejRvSWZVVitsRG12M3BjaDFkYkM2?=
 =?gb2312?B?UGNRSXl5MnhKOW9XSTZiWUIrejdFQjlVVHRLTnJLUXVIVzM0WHJFS29GcWVh?=
 =?gb2312?B?a0ZoMW5qcWU4UjI3WCtqcTRlUTl0NXRkaC9EbUllREphL2tTRmo4VXQvZGNT?=
 =?gb2312?B?djYrYXB1NEcrdnVkaFR4NDU4amtTY3ptQ3FZOUJ2UkVSVkpaOTJ5eUF5aUds?=
 =?gb2312?B?MjVkVzBUT0o3aUJNeXQvUjJjNkF0dlBqWndPcXl2YkwrRGVQcEEyVWFvaVRq?=
 =?gb2312?B?NEtSZkdvcU5FQlVtTnhIZTVtV0pTSjJCdUlCMzRNcDI3eTNtbmZHZ0d0ZlJZ?=
 =?gb2312?B?djJXWERwWEMvTlVJUGRLWnl2WGpCcmJGb3VoSkdPMHBoQnVFckdGR3pwcEhJ?=
 =?gb2312?B?M1J4WDZCT0VIRWVOdkhlTTlHci9UdTVtZnkydm9nSlR1YTlobFJQZkttdXk1?=
 =?gb2312?B?N08xVlVacEs5bzJaTlFReHhvWEJ6SnJCMnhRc2taQjFBeVJ4ZEY3OW5XQnlt?=
 =?gb2312?B?MklML0drVmlaTllzQjlMZTNOTGtlUVlucTJEV283cDBKc1hhZlgwcTRKRm53?=
 =?gb2312?B?aVEwT1gwb0pheEpxNWI1WG9Ldk9vZXlQVExZNmJRb0hVazNCbk5OWlRTR0NB?=
 =?gb2312?B?dnBWWHFReVEvZ2Nlc3RscnkyTEdmaXcrNm95NjVWR3ZpYTIyM2RUbzBwY1Rw?=
 =?gb2312?B?R2RBVE5tMGlSbDkvdzFxWVhaQk50bVBhNzluN1ZpakNPUCtCclhoaEVCR3Zr?=
 =?gb2312?B?MTV6cUxJemZTRmk3TTdQRzNnODcyUkF1SmplMnRYM2FCZGZZSEhLa1VzU1Jy?=
 =?gb2312?B?TlViNlVJUWtGQ1NGZCtNTXV3T1llZ1NkUS9xdkZtSVVsYkhzb2treElKVE8v?=
 =?gb2312?B?NDVsd09yZmZLcFAzT0ZuUTl2OTgrS091M3JpTUdybGQ3NSt3L0JWV3lGZGpO?=
 =?gb2312?B?NDVjTjZZa001dFlHWTQxSFVraUVYZFBIVXovZkp5WU5TWlBUOWZxc05zQ3Zm?=
 =?gb2312?B?K2trdEEzK2plUll4SWh4a25BSkdBNlNJclhlZHBXZU9xcy9EdVAzK1VsZ21i?=
 =?gb2312?B?bEtiU1FwV2NsbnNuZmZrWVJ0YmV4dFUrYnF1WkRud0ptVHAvaExSa1EvcW4z?=
 =?gb2312?B?UUZ3TEdxKzVCL2x0d3gvc1hQWTFWRDZpNWlkSkVTUXBRTitTbEZSMFJmM29v?=
 =?gb2312?B?aGx0MnQrSmhFenZRWVZoSTZBYzBHZ0NVQTluZnIxSW9jMVd1d2NyaUhFWWdt?=
 =?gb2312?B?R0VlZ0lKWEVXNitUVEV2SVc4MkI3ZnQrQkh4clE0R1ErRlY4eTZ0VE1RVFZE?=
 =?gb2312?B?cnI0Qk1GOEpseDV5bEFMcFQ0aFpwVmtUZnM1eHpEQnZJcnNpNHlUMkx6R1ZS?=
 =?gb2312?B?Y3dxY1dSVituNUdMczRJMGZhRjJQTld5bi83TzloamI3YnhIbjV1bzRlcG9L?=
 =?gb2312?B?RkJkOC9YeG1uRnNBZWd1bnQ4Y3ROeEtnZUtzY1R6dDVEU21FMlMyVjVMOXdB?=
 =?gb2312?B?M3hDTTZjNUlyRnhIL2ZXd0N5K0NYQWw4ZVZtSG0zSlpkeXN2MXNlZFdRcXJt?=
 =?gb2312?B?YVRGdjN4N244SnowSXZSWStCWlJlWjIvNEJwWkNON20wNGREakZQbHo2N2ZH?=
 =?gb2312?Q?qFpRBrmmTj+Zi5KEDe+SZTw15sNLSI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RDJ4S3ZBM2xQSUpJcUZGREpQZzZvQStZZDZUTG0yTmZYclBlZHk3d2lnK1Ax?=
 =?gb2312?B?RWJUMXNxcFJGTzNpQmNvSjRFSUdhNWZhejBYYS9yM2tIejVxb3FoWTRSMkd2?=
 =?gb2312?B?UjNsR082U0F6MGhWamVibndUcjlvNm9zMU9ZMVpJUHpYWDJKWmUzeUFBazhK?=
 =?gb2312?B?ejZ4TGtCOEpWNHNTNGpNaitOQlBFQ2NFS0N0aHlUKzRCSmE0M0NONkNsd2Za?=
 =?gb2312?B?UldjMkZvL2gwcFJmUVh6OEMvYWNVN1FrRzN6RVJJWnNnRG9jVnpKUno0S0Ft?=
 =?gb2312?B?cVJDaGNqR3lhdkNSODFrTVgvaWRsUURvenBUaUVWb1B2WXZma3RKd0QrQmtS?=
 =?gb2312?B?dUNOZHRPK2ZNUFh2SVExaTFEMjI4Nyt4d25MZUdYRTMyQmIySWRuR2tRaTZK?=
 =?gb2312?B?bTZpUWNGeW95UzZvQVZIdlpHT2RBZlEyTG1NSVZ0Nm5tNDUxNlREM1ZjN3h6?=
 =?gb2312?B?SWFFN0w4MWtkb0hPMlh5dHg2NDZtMUlma2hacVQxMk9wR3BJMW1MTmdBQjRa?=
 =?gb2312?B?aWdPVjJ0QXMzaHR0UEVHa3BpOVFIMDQ2QlYzaGJETVFLY1lDYVFKNjlHYjA2?=
 =?gb2312?B?cUhhVHRBbXQ5dE1DaVYyMy9kMTZMRDNMQTB4N1Y2TDFwU2ZxZmNyamNpVjFC?=
 =?gb2312?B?YUhZZG1GU2JvOU5rTjFwdE9SZVFtdEVFa1dESCtnQWFhMzIvUmVIZWJKRlla?=
 =?gb2312?B?VDRFcHVDRWNUaUk3MEY2R2ZvR3pkbmdySEt1Tmc5ZW96L0VFOWJqWFIxeUdS?=
 =?gb2312?B?ak1PUS9jcEw4Z0xBQnVYQmRyd3FxczEvV3JSejd0b1UrRUR5ZnpMaFFtRkFv?=
 =?gb2312?B?U3k1VURTbytPY25SRnBBa2VwQ3VZOW5abE56eUc1ajlqM2pBZlJ6K0IyazJv?=
 =?gb2312?B?WldZeXVLeTFINnVXNUc4a1k2NEhwNTZLTU8yM05GYXBBL1FFTkg4NlhKeDhJ?=
 =?gb2312?B?UUQrdURBQnYvb1pUZzFzZCtseGR6M2Y0Q3RkN3k0NG82VTMyNXk2YzN6NXFG?=
 =?gb2312?B?T3NPM0JjNTdNcFNTMEhVR1VNTERzSWlyL1FhTGhhMHozRjFiK3hLR3RubkY1?=
 =?gb2312?B?Y2R6R2JSMVFlaE90alZtU3p4bjlxSFVYQ0JIRG5XZUdtcy9xMGZCN3NzS0FL?=
 =?gb2312?B?bXRQU2Jjd2wwbzVyV2cvL0dkMDhrVjEwMEFKUGFITzVYdWRhUk5tcm5yODg3?=
 =?gb2312?B?dDYzRTBkWGlwL1h2RVVHbDZmU3RZSHM5MXlYbnpweGJVM2t5cGJacGFYNjht?=
 =?gb2312?B?SVByeUUxc0JZeEczeFZweUt0VGpMcndmUUVRb3JFWUh3TFdZNEJWZ3cycjB6?=
 =?gb2312?B?SVAzTHlET2RtbUlCa3JBYzQ3K25MdnMwVWFhTjZvOTIvV3lLa0E0QkFFQ3Nr?=
 =?gb2312?B?S3dyY0RYS0JFMnlmUmpJZlIveVc1YkdVTC9aMlhJbUxTMEpaOWNCTWVidEdC?=
 =?gb2312?B?R0xJQWVKVE1nY2NXNFdaRkx4MUlKaTk2eTV5eUw3c3RONzhQU3NZVGtJaVgw?=
 =?gb2312?B?NTg2blpNOWJVdVZrczlFUDZLSXRSaE1YSWF3TzgvbGN2dWpUUTVSZGIzNzRQ?=
 =?gb2312?B?OVdYdy9yZ09vcWJpdkRJclhxRmUxajJDVjJTQkpkNTV0NFBNS0tiUHZGdVI2?=
 =?gb2312?B?YytNUVdQQVZVdTZTTDIxbFV1TXlvdlJBRVpSM09LOGhzWDdMWFFPb05Ra2tN?=
 =?gb2312?B?b3A3bVJLNkw3c3JIQWo0QTFGRkZOWjNZYWpQZVQ4Y21XMjByN1FGYWVkaFU3?=
 =?gb2312?B?SmR6dGE0VTFia0RrR0ZWNUE3V3krMHR4UzJSMFRGejRZVXh6N21FbXRqRzFo?=
 =?gb2312?B?d0tSelR3ekpaYnBtamtCc2hYSDZyYmZ1aFVWZzI5T1BoMTQvSjdXRE11VEFu?=
 =?gb2312?B?UkRGY3pFM0pseExoVVVoQ1FQS3NhZ2F2b0x6Q1gzSFdjMWNQQ2ZEZU5qeDFu?=
 =?gb2312?B?cW9lZ20vM1o0NFhWM0tuUVB0M0VOdUNQdE1zYjdwMVNIU1ZkRHk1K2pkZGcv?=
 =?gb2312?B?VGxMU3JUcWVWYUlGL1lKbEZTeUp5cG15ZkEzUmhQd21Gd0tFdlVIVktxRE94?=
 =?gb2312?B?V3hGSUpPQ0V2clBmNUdpZUdFUFBaaHd6K0QzbGhJQkdhWUQwR01HTVY5dTBD?=
 =?gb2312?Q?b1c5dZz1dATvOmYBkXCpFSZZR?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2dc0e1-628e-4c08-7e01-08ddafabeab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 03:38:26.7947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pScP7NIIZ0dBC2LnnsO0OOQmvP822TQMO2saptTKURJxlMJECU+RJ/JurRWh1WJMjKt5IEYazpefcunl9LA1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10900
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBGcmFuY2VzY28gRG9sY2luaSA8ZnJhbmNl
c2NvQGRvbGNpbmkuaXQ+DQo+ILeiy83KsbzkOiAyMDI1xOo21MIxOMjVIDE2OjAyDQo+IMrVvP7I
yzogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+ILOty806IFRvbSBS
aW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPjsN
Cj4gU3RlZmFubyBCYWJpYyA8c2JhYmljQG5hYmxhZGV2LmNvbT47IEZhYmlvIEVzdGV2YW0gPGZl
c3RldmFtQGdtYWlsLmNvbT47DQo+IGRsLXVib290LWlteCA8dWJvb3QtaW14QG54cC5jb20+OyBQ
ZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47DQo+IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBFbnJp
YyBCYWxsZXRibyBpIFNlcnJhIDxlYmFsbGV0YkByZWRoYXQuY29tPg0KPiDW98ziOiBSZTogW1BB
VENIIHYxIDQvOF0gaW14OiBpbXg4cW06IHVwZGF0ZSBwYWNraW5nIGkuTVg4UU0gTUVLIGZsYXNo
LmJpbg0KPiANCj4gT24gV2VkLCBKdW4gMTgsIDIwMjUgYXQgMDM6MzA6MTdQTSArMDgwMCwgQWxp
Y2UgR3VvIChPU1MpIHdyb3RlOg0KPiA+IEZyb206IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5j
b20+DQo+ID4NCj4gPiBVc2luZyB0aGlzIHBhdGNoLCBhIGJvb3RhYmxlIGZsYXNoLmJpbiBjYW4g
YmUgZ2VuZXJhdGVkLiBJdCBjb250YWlucw0KPiA+IHNlY28gY29udGFpbmVyIGltYWdlLCBzY2Z3
IGltYWdlLCB1LWJvb3Qtc3BsLmJpbiwgYXRmIGFuZCB1LWJvb3QuYmluLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gDQo+IERvIGFsc28g
YXBhbGlzLWlteDggbmVlZHMgdXBkYXRlcz8gT3IgdGhhdCdzIG5vdCB0aGUgY2FzZT8gSWYgeWVz
IGl0IHNob3VsZCBiZQ0KPiBwYXJ0IG9mIHRoaXMgc2VyaWVzLg0KPiANCj4gVGhhbmtzLA0KPiBG
cmFuY2VzY28NCg0KTGV0IG1lIHRyeSB1cGRhdGluZyBwYWNraW5nIGFwYWxpcy1pbXg4IGZsYXNo
LmJpbi4NCg0KQmVzdCBSZWdhcmRzLA0KQWxpY2UgR3VvDQo=
