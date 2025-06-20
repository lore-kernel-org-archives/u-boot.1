Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15B1C7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 03:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF1AF82CBC;
	Fri, 20 Jun 2025 05:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bRoA5Xn0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2984882CDF; Fri, 20 Jun 2025 05:33:57 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10C9082CBB
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 05:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnM8YcYZ8G7uFMc+Pngebzx2bxIc6zYRLQI1TqrxlTC9aAd9J/enmQ4h+qPPpQajVAS0qoc888+jTHGhotTeo/8cz6xkh4sPX6sSAdCR8UVRDriT17H/nTr37Bo39b7YrAW5F2V6zUSK0IH4tLMy4wIKAnrR1jcbqhyB3TACiPbLvVQR1z+cq1+hXGgMGmQCU4TFoBthpZp18kZabItJEc0jZH+8rkddl5V7umZFlGYXLbtS/dgiUjwxKttgOJFI/Y64iUgH6lXvOpP9KZV8cOxTVqtFZPyj+l5/qYxjigf3ziIsvz5huQAguFoN3NR3JkfyfUEwjGJ7dXQyyjbrbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6swbEI8AwU9Z5Hc9CkiuyykVpvNHWjaYWzAkVCdVxQ=;
 b=rE5E6V3ZSI6TdYPpeWbZfJxV1W6fTZU3sIV1avtDN9sRF+J6Bap/WKOcTePIMxbNTami7H8PfRBHVBpuiXKTW1f5ay7CLZWublPP6nmRJB4M/pajZtp4op/+H9Vf0F//4SNSKKhQtRABp59/bvnEcSaUJb/oBfT4JjzA6Qs0lKmlJ/JrHOpq1KHNX/tWG2xg8/ofwdxT07fAMugMr1aQcKjDri0TVlPlhwT6OGtnXPvAwyi1UNiS3pjBtGmNCVLIFvkZJ3HADOxejktftbrbBjJcOEPayLyMGbyU8jqjoh9kAOmj8NfUHYe+FuKBW/rYVWE8QePfO6wnrdaGX7PXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6swbEI8AwU9Z5Hc9CkiuyykVpvNHWjaYWzAkVCdVxQ=;
 b=bRoA5Xn0BdC4hbwibuHY119LmnSh78Xn15c8gO1T8lerNjtGNcOT2agrqCNy+Uwjig02S5PJvM2PizZeMvInJ3Wc0yqJMsee/cNfnr0j+u3/fVCujVk9Dy8iFapiVhgGPsn1nBb3lBwqCSKVZNSoLb38tBGL4PHiqxhOtTEP/7U+oUWDxlVxvsR7mrunx9Wl4vOnPjU/HIsHgWPbKBxSbdLfSz3xgHBgCI3Os2/Dg1jbyXru2TUAAKx5JfazN9G33Zm3zKjj/ho0iUTrfGaRoI+tS48iF4wT4WREc2Diy0E2sElH/wgL3DmY2mfuCLzDA/hU+U7Zf4dkYklalWgACA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10393.eurprd04.prod.outlook.com (2603:10a6:150:1c9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Fri, 20 Jun
 2025 03:33:50 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 03:33:50 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, Stefano
 Babic <sbabic@nabladev.com>, dl-uboot-imx <uboot-imx@nxp.com>, Peng Fan
 <peng.fan@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Enric
 Balletbo i Serra <eballetb@redhat.com>, Ye Li <ye.li@nxp.com>, Jacky Bai
 <ping.bai@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMC84XSAobm8gY292ZXIgc3ViamVjdCk=?=
Thread-Topic: [PATCH 0/8] (no cover subject)
Thread-Index: AQHb4CLYfPPE7ker1Eq3zAxf+JH/irQLPYsAgAAQULA=
Date: Fri, 20 Jun 2025 03:33:49 +0000
Message-ID: <PAXPR04MB9644F6AB9E22A651421A81D3E27CA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
 <CAOMZO5CpcBTKQW4O6qFH4TgvsBBzmud1MQOEtz1i0V3UApz-sQ@mail.gmail.com>
In-Reply-To: <CAOMZO5CpcBTKQW4O6qFH4TgvsBBzmud1MQOEtz1i0V3UApz-sQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GV1PR04MB10393:EE_
x-ms-office365-filtering-correlation-id: 4988c260-fd11-46b0-8559-08ddafab45a6
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cUd4ODVIUVFKbWJkQlFrYW9LYjNWU0w2SHlmclVwblRta1orc0JsZmxQSm5m?=
 =?utf-8?B?eXJKRGZBd01VRlI0ZlU1Nld5YlZkYkVIaFp4eXhBa1F3bzVpcUJzR3U4Z1Bk?=
 =?utf-8?B?V0xGMzlTdHpSZ2o4aUF1TzRTbHJjajRDQWs5Z0dkR3JmUjFLdzY5cmh0c3BS?=
 =?utf-8?B?MkY1V0N4Rmd4UXBiaXFvdmtvUEQrbktaOWFhOEZZcWxTT1ZzeTE5a08zdFBP?=
 =?utf-8?B?Qi9abkRsN3BrUlJZY3JheVMzczF0UEYwWmJRN29iaXdYZnpHa2dmRHRDYWFs?=
 =?utf-8?B?K2Nxd3JIY3JmNG4vejhEQXRsUXhkaXAzL1NOa29EZGI3azJjajYyOHZMTmpU?=
 =?utf-8?B?TmdzNlFJTVNtUzNkQlNhYTdBWEVMTjFRNVYvaXFubktpTkRORVVqOXNXNjJO?=
 =?utf-8?B?dnd5aW85K1pEbXQ4VFhhdmdjVVFVUERtampXaSswU2M0Wno5Z2hhL3hvaWNV?=
 =?utf-8?B?OTJaaTc1VHd0TEpNK0VFbHZNQUg4SWhOMldJbUZaV1VyUHlLd09BT0tKQ2hF?=
 =?utf-8?B?SDRyeEhGdXBZN3laVk9KQ1dZRTlROUE3WFIrT2owOG5IaVJlVjdrNU96TVEz?=
 =?utf-8?B?M3RWM0hxZTZMcCtzUmNVTll6SklUVnFNZmxQcjZIcTlKRUhRM09xVFp2K0NF?=
 =?utf-8?B?bUk0cXZvWVBROWNxL0gxditqd0hrR2lXTmxzZ3kwZFdrdTQybldUcGhheE4w?=
 =?utf-8?B?akR2dEZkcFdWbTV3RWF6TFZJUXJRUjJBa01zUGtPSGZ6Z3BiNFIvNmtnWUFl?=
 =?utf-8?B?NnpBdFlOVHphOUFQUEVBclR3R0R5aEFvVEJBdlA4UlRkRjVDWkRKNjEvLzJy?=
 =?utf-8?B?dmo2YXpLRFAxdHFWUDJSZnR4dGxoZXpyQWpwRmFDbXdDR01IZmlDVWVoWnBG?=
 =?utf-8?B?VERRMHlPWEVBNU01elZoTnRUV0FZbS9CN2tSQjZxdUdCRWlZTGpRRlJ5KzV0?=
 =?utf-8?B?bFdVREtmS3YzMmQ4OHZIVzJZYk8zczkxK2ZZU2dtRWlEbU84bnJRcG5aRXVq?=
 =?utf-8?B?U01xYkRvdlR2Z2dDZTlZWktCOGRZMzJKSTViQS95VXlkSG1wckM4MTY0VlMy?=
 =?utf-8?B?V09hbHFoaWxYUkFDTm1SYjdaR3dqYlVWWkpma2pTTGRTQ0hCcHF1c09nb0Y4?=
 =?utf-8?B?djcrZGtMR1I4cGMrbHdHV2dLeFkxQjFjSXE3UDZrRHlBVlZNd1JVVkNPT3Bu?=
 =?utf-8?B?NGVzM3p4dTlJSUhETk1DbjZ5b21TNjAxVkdWNTc0dkNBMzIrSlNxWldjNFQ0?=
 =?utf-8?B?UGR2V0JjWGR2K2hQOEFpVGFpRWt4Q0JEUlJrZ2ROQnNhcjJaK3U5a2p3WHAv?=
 =?utf-8?B?R1o3OXRwdDVvZUtEeUJ3dlBBQ1FSTTVWVk1xajdXWWh0c0RIRHFCU2RPd3pu?=
 =?utf-8?B?b0ZNNXlXbzlYckVuOTNmeGYvNDJCbHZVZUJKOWZaZzJlbk5jTU0zS3VqalRt?=
 =?utf-8?B?Y2tyRmhpTXNvOEhZelpiWHFUaFFwRFZpOHFtdHE2NzhJY0FVRCtDbXVUSTZR?=
 =?utf-8?B?c2JUU1labDBKazJNMGxKRGJnOElhWktLUTJ3Z1lwc2NzMkJBK213OW9QZXFp?=
 =?utf-8?B?VHJMNnNyMlJzNExlaTAvdUd5ZVFBZlFPMWxVNmJCL2laWHYrU0tpaFFjVFlC?=
 =?utf-8?B?dkZ6bWYwR0RldVZBK0h5Y3NBekRpcTMrei84YkhXWERyUTd2aDhHL2NkRENO?=
 =?utf-8?B?VS93bDljWFdpbFo5V2p4OEprVzRqR0hmcUJkbGwwQmdxNHQ4azkyZCsyOHJo?=
 =?utf-8?B?ak1XTEJYRFpKaGNuQTBxakNhdWRTdVpNY05UYUNGREtWYnhIWlZENkswQktG?=
 =?utf-8?B?YXdvUzJTWkVZTEJpMDhoSURGVVFmdkJrMnh5aU1zbVU2TUp6Q1JwNWx5TWZh?=
 =?utf-8?B?K1Frb2p1TGN4dWNRbTR6VnBjVnI2WnBvRlhZY21kRE5iVUZzdWZkU0I3N3Zz?=
 =?utf-8?B?Mk9MVDZ0MUpSZ0c0S1JuckhHTDhWYVBsbGpxNjMyZ0ZyeGlzdHJMS1ZLMFkv?=
 =?utf-8?Q?P41uB16KCyffDK/+LMVkhPK7gZp2TI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm5hUVpTeGp3VTZyZTFSSS80aXJHQkQwdUw1a0x0NmY4Tm1uM1YyOEV3R3k5?=
 =?utf-8?B?b1ZRcEcrT2JkODJibmVlWWtxbVIweXlRZ20rSzZ6bTlnSEw5eitmQnRZekJN?=
 =?utf-8?B?ampSUDk4d0pySE00cGpSSExoV2ZTb1hVNmlRQ1RCRlVsNlp0ZVJyOVlBVEp2?=
 =?utf-8?B?NFN1UXU5a3RWSXNJenlVVm1yU3pXOVQ0ZDVKbTRUQ25TTERvbERBeHB5TUMw?=
 =?utf-8?B?ME1SYWdlSmVxcjlpcWdXT1RhRTVxN1FkVFJVTVh6SU9sMCt2eXU4MC81Ykl0?=
 =?utf-8?B?U1NKQXdobnpUTncwSDJqZXpOTzUxK3dIWjFVSThleGJjS3Q3bGRNT0JZdjFS?=
 =?utf-8?B?YzFER25CcEVFc2luaFM1TG96Yzk4QWVjQnErQ1VNQlFFejZ6RDBpSXo0dWg2?=
 =?utf-8?B?eWkyV3hFWUFPVGgwQTh6d0YxcWxjTlh6azhzVjZTb3pDZXo2dlYvS3pEK1Jx?=
 =?utf-8?B?a2JIckVVYjI4b2dkZ0xFT1QvVVdDMDBmbXVhNENqc3VIMXdLMXcza2hqbVJK?=
 =?utf-8?B?V1lIb01zNFBWbnlYcXhneFhGNmpzcXVRQjNVM1UvUEMrZVEwS0t1U0FmdWRq?=
 =?utf-8?B?Vkp3Uy9wREF1c0ZGSFhYOWVWK2F5S1FyMmJLN3d1bURuTWp0L1ZzNk9PTXN2?=
 =?utf-8?B?NW9ZZGZmQkYyN0VEQ2RDNmZseEdPVmlPbFlJbDBKUjRGSXhFK2srbUE4UUlY?=
 =?utf-8?B?eFAyU3NOWm1EVElVR01aMWRyTmVnRlp3TWY4WlIxeTh3cXJTNXhhOGtrcnRu?=
 =?utf-8?B?bGVLcVFSWmpmaGtQQ2dJS3NxbU5Nalg4YTA1N1B6OEs5Ry9xT0xoZ0JZS2pW?=
 =?utf-8?B?aHFrcW9MTGdhTXJZdHZWelhTaGtIZnBIKzRKOUtpYlNzUnNmdFhsQnFaN1Vl?=
 =?utf-8?B?RlphZjNIekJWYXA2anU4YkZnSi9vWERQRnRJYUVhdVlTZ0JWVVBHYURlamNY?=
 =?utf-8?B?L3JLRkt5MHRXNHQ0OFMzUEMvQ25QMEpoSy9LZWdIZUFvRE9PZDBBZWdXbTBL?=
 =?utf-8?B?M0lQQXlsUFAxTURCMWdqUnlrQWF2QXIwbmZtVEpmcjBUaWdiTzBHWjY0dGR3?=
 =?utf-8?B?aDdUbFFOOWFMTWZ4RWIwQjB4Q3NqVUtZNEgzSEZIYlIyZ2Fmc2h3WVRuSzZy?=
 =?utf-8?B?WVlmTUg2UUdkVkk1eEczQ05NN1FHVFpZeGZ4TVl2QlZTeDFFeThZK1pnQXVV?=
 =?utf-8?B?VlZ6c0h3bGpXWFJNMldrbytnTDhwc2pkVmp0U3hrcjFBNXM0Zkh0aVNxRlcx?=
 =?utf-8?B?R0lwR3pyZnYrSFhWeFdjZmJiQW51d1dWNmpOM0tIcXdHaVFTUXY3L1hRdmkw?=
 =?utf-8?B?ajVuTm9KWDlJNHJRNGFtaGxyOWh4YWVMTGVhV0xOcVNBSjVlYmhhS3pxV1Zw?=
 =?utf-8?B?Y29pbVVQZ0l2TEtGdmEvbmE2UHUzMnoyTmNMYTgyckl1UXNUVlJvZCtkaGEx?=
 =?utf-8?B?K0RTWklYUkttTGsyNGY1NlMxOEgrQzczb3FlYWk0WUZkeHQrNjdvdlNZYllG?=
 =?utf-8?B?emY2Vmk0NVoxMWVBb3lqMzRjajhkWlJvc0FxYytleG9IampSVm9GMG1aenFs?=
 =?utf-8?B?Zm9aMmloYzdseFdMbXJYd2VTWmlwK0NSNVlsOHpSc0JaTmtnZ29oaU9pSTRK?=
 =?utf-8?B?WW1tNG16b0RoUnJ2eVBiSnovYU1KSjFGWU01bkVxdlJDVHNqdmR3aGowcXJ4?=
 =?utf-8?B?WlV6a0YwSkpSdjlZN1hyMUJJbFk4TmZYUjZoUVJ0L04ydXhjQmhOK3c0ZWtm?=
 =?utf-8?B?enFrVVRucGZFNTNlUkROaUljcy9ra1lzQUNjZXBEYWJPeUhFQ0xUcUd2ZHlX?=
 =?utf-8?B?K1cvVjFHajljQ2s3N0JXcWVrYjVjR2hkZkhXakNreERPdkRGQ0J6TnpQdUFC?=
 =?utf-8?B?TUZOaDhFa1JkQkRTR3lhb0V2ZWJJVTU2KzlqczNwWUZySHVxdmREWEpuc3N0?=
 =?utf-8?B?R1ZCUjd3R3hxVG5BckgxZktWdVgyRVNzN1BQeUtxSWxsbmErTzBQTldISXMy?=
 =?utf-8?B?MVBJeVRFZnBRelZ2ZWExck9Qb3BHZ2lQa0tTWFlJQXgzQVpFZHZkRXA4L0NB?=
 =?utf-8?B?UHEveDhBdGwwQ0dTUUx6ZDBqWDhNREtWemNrVHBHUEcyNzZoVnhobEgxaHg1?=
 =?utf-8?Q?Eafc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4988c260-fd11-46b0-8559-08ddafab45a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 03:33:49.8720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADTkS2mfwZouhdeinMKZABWHOp3R88T1BGmChTOO1JhfxKhFTjO1qiyzaUIptTk33wnRYauDpp4s6qPR51aX5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10393
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
dGV2YW1AZ21haWwuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQ25pyIMjDml6UgOTowMg0K
PiDmlLbku7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPg0KPiDm
ioTpgIE6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBBbGljZSBHdW8gPGFsaWNlLmd1
b0BueHAuY29tPjsNCj4gU3RlZmFubyBCYWJpYyA8c2JhYmljQG5hYmxhZGV2LmNvbT47IGRsLXVi
b290LWlteCA8dWJvb3QtaW14QG54cC5jb20+Ow0KPiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNv
bT47IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBFbnJpYyBCYWxsZXRibyBpIFNlcnJhDQo+IDxlYmFs
bGV0YkByZWRoYXQuY29tPjsgWWUgTGkgPHllLmxpQG54cC5jb20+OyBKYWNreSBCYWkNCj4gPHBp
bmcuYmFpQG54cC5jb20+OyBGcmFuY2VzY28gRG9sY2luaSA8ZnJhbmNlc2NvLmRvbGNpbmlAdG9y
YWRleC5jb20+DQo+IOS4u+mimDogUmU6IFtQQVRDSCAwLzhdIChubyBjb3ZlciBzdWJqZWN0KQ0K
PiANCj4gT24gV2VkLCBKdW4gMTgsIDIwMjUgYXQgNDozMOKAr0FNIEFsaWNlIEd1byAoT1NTKSA8
YWxpY2UuZ3VvQG9zcy5ueHAuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IGlteDogdXBkYXRlIHRo
ZSBidWlsZGluZyBib290bG9hZGVyIGltYWdlIHJlbGF0ZWQgcGFydCBmb3IgaS5NWDhRWFAsDQo+
ID4gaS5NWDhRTSBhbmQgaS5NWDk1IEIwLg0KPiANCj4gVGhpcyB3YXkgaXQgaXMgd3JpdHRlbiBh
Ym92ZSBpdCBsb29rcyBsaWtlIGEgY2xlYW51cCwgYnV0IGlmIEkgdW5kZXJzdGFuZCBjb3JyZWN0
bHksDQo+IHRoZXJlIHdhcyBhIGJ1ZyByZXBvcnQgZnJvbSBFbnJpYywgc28gc2hvdWxkIHRoaXMg
ZW50aXJlIHNlcmllcyB0YXJnZXQgbWFzdGVyIGFzIGENCj4gYnVnIGZpeD8NCg0KSGkgRmFiaW8s
DQoNCldoZW4gY2hlY2tpbmcgdGhlIGJ1ZyBFbnJpYyByZXBvcnRlZCwgSSBmb3VuZCB0aGF0IHRo
ZXJlIHdlcmUgc29tZSBjb2RlIHRoYXQgbmVlZGVkIHRvIGJlIG1vZGlmaWVkIGluIHBhY2tpbmcg
aS5NWDhRWFAvOFFNIGZsYXNoLmJpbi4NClBhdGNoZXMgZm9yIGkuTVg5NSBCMCBhcmUgYmFzZWQg
b24gdGhlbS4gU28sIEkgbWFkZSB0aGlzIHBhdGNoIHNldCBpbmNsdWRpbmcgYSBidWcgZml4IGZv
ciB0aGUgaXNzdWUgRW5yaWMgcmVwb3J0ZWQsIGNsZWFudXAgZm9yIGkuTVg4UVhQDQpNRUsvaS5N
WDhRTSBNRUsvaS5NWDk1IEIwLiBTaG91bGQgSSBzZXBhcmF0ZSB0aGVtPw0KDQo+IEZyYW5jZXNj
byBicm91Z2h0IGEgZ29vZCBwb2ludDogYXJlIG90aGVyIGlteDhxeHAvcW0gYm9hcmRzIGFmZmVj
dGVkPw0KPiBDb3VsZCB5b3UgbWFrZSB0aGUgZml4IHRvIGFsbCBib2FyZHM/DQoNCkkgd2lsbCB0
cnkgdG8gbWFrZSB0aGUgZml4IHRvIGFsbCBib2FyZHMgbGF0ZXIuDQoNCkJlc3QgUmVnYXJkcywN
CkFsaWNlIEd1bw0K
