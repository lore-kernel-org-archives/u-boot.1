Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A214C87FD2
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 07:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490D683A97;
	Thu,  7 Aug 2025 09:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="q2R8aEzQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CB083AD5; Thu,  7 Aug 2025 09:55:48 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 639B183A92
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsWpWhdsDdekCN+1qykPILGKQ63C0DQ8eCMuj2vYnfis12+jUO3LjVlLaaEcFzgwbdAj1fqdsIzFl6ryWG2k9LAmSTiYPkreikoTI5M3mUmPdlc5q449Eofgk68KpB9HJcUe4nI+OSStTwu+yc/ubPb1nP8HmfpBxhXaTZps0OSsRHWixZukH0W2qSxFR4zGqpVt0yjGXdG3hP8+OzaRoKw6V5d2i2gDGnzjpmStzmWlCiGbTGIbK8jo1Mwu/v5dDUI5j9Ec95dgCZeY91ejXw5iOX4F2+Z2pZbGeUk5GtIFGeaSS46Z1WM21ndXo08cYuY5hDhJf82a3ShmwU8LIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Qgc+3++KPaVyedgOLF0PJ8djGdNq//WRJAEyqQxssc=;
 b=UToTL+xBJNUC+wK/Bzk4K0GGrdzFsaCmvifZWiX+oJ+F1ymD92iRXci08duQXorRRmK3DQY2Vv4k4j9k89rLUCvTLOLb8+25Hyr83QN63Uc6dam4r82jGUxp0Aqd920o/O+7QPXYMUu3Yo7aceykfRBwlV8IBuyey6hlqkMz5cjIYDW525GUUqwEd07EsY6DQfD8BPpXJnjFZyzfysCzGv8ASFg+ksaKFziYXM/g0PbIVy3kTAm7YZv7Naj+4v7ZbX5VqnObu3CHA1t9GjcBHjaZWkNoqMAYT4Hg6t/ZL/K57k1Vy2n/8G5WvREfVips0bBE1YvWB1DxgRj2J/qeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Qgc+3++KPaVyedgOLF0PJ8djGdNq//WRJAEyqQxssc=;
 b=q2R8aEzQ2jflWA4NV9Lrtw6imQh70fj2osNSOmDPsZX940oMwwe9fA5nNkvhxv9uYzUD0Kfy1GAbyWEBWHxb2nG2lHKoFYoiikSR0Ojpam3yNbdfxAG/DOqivu3d/OixGPvS/0fzXb2ewvlPeSuOBlRGTpdgngN7up8pgR98eAwn1qrJYWJADdlOFJOBlXJsaG7894L5rZV0lsOdNVpHJAQj8qUwfghW6jYmxCOctH89X0l3bFQyhazI6dSc+SdelwcWJywLYLZJ14Ugd5CGYA8QEXv9VNxSVKC/47hSVKpnRmJ2d5t2dM5TIDPT/akPDfzP02Q3utqTfzjbYzv5wg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB6782.eurprd04.prod.outlook.com (2603:10a6:803:139::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 07:55:41 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9009.016; Thu, 7 Aug 2025
 07:55:40 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYyIDIvMl0gaW14OTVfZXZrOiBS?=
 =?utf-8?Q?estore_support_for_i.MX95_A0_silicon?=
Thread-Topic: [EXT] Re: [PATCH v2 2/2] imx95_evk: Restore support for i.MX95
 A0 silicon
Thread-Index: AQHcBs9YZc7HSW8W10KVylF3WErsALRWXLMAgAB0vOA=
Date: Thu, 7 Aug 2025 07:55:40 +0000
Message-ID: <PAXPR04MB96444AED728A48996B3B0C27E22CA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250728-imx95b0-v1-0-5cdae3764d21@oss.nxp.com>
 <20250728-imx95b0-v1-2-5cdae3764d21@oss.nxp.com>
 <CAJ+vNU2GGaXhqmoJQwh=NPA9QwjdXBqGuRA96CmaZt4iybhucw@mail.gmail.com>
In-Reply-To: <CAJ+vNU2GGaXhqmoJQwh=NPA9QwjdXBqGuRA96CmaZt4iybhucw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|VI1PR04MB6782:EE_
x-ms-office365-filtering-correlation-id: 658694e4-8989-4b99-7430-08ddd587cdb8
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?a3RZdzE0NDJadzdMa1FieDZ1aVViTkUvMVNFVmI0YWlpczdRWkE3K2w3aEZU?=
 =?utf-8?B?NzFkTENCcFpqbVZJVWlRQVcwdERMRzRIUTc2REFIbVN1MytzT0V5TzhENzBw?=
 =?utf-8?B?TmU4K3pacE96MGQwY1BGQTNWT2s1SWVRWmNDS0dIcFFZSURiK1BoSEZtT2xQ?=
 =?utf-8?B?V3RBZjdpekR5VkJweExhK1AxVUNDMm9iYU9GaXRhWThyUG1sbStwYlFxNDRo?=
 =?utf-8?B?Z1pmTGlpVFlSbTdjVkFXODY2NUlZMGx6TnJZMjZVSkVCK1g0bm5yQ0FBd2hC?=
 =?utf-8?B?S3YxMHJyb2tERGNWcjFJQUZRRU43c0M0eUdQZWczU3AxdzZqbk9USHB3a2Vo?=
 =?utf-8?B?ck8yQ2ppSE1ob1JwS0U0b0dKTENHZGgzbkg4cE5Oemh4Rk93NTF5YjBqRmNz?=
 =?utf-8?B?cWFncGYxYUJQMDNYL2FqclpNR01nalVuMkhlNGI3MFNQOWtsTEVveE1CMlVB?=
 =?utf-8?B?YTRna1FtVHdpYmk0SlFOWEhzQ0tKdFRoSFRzSFB2WldXM3RpQ0ZsWkpIaU8v?=
 =?utf-8?B?bGxUUmtuWTdwVllrcXlEQ05MbGJ4YUtBOGk0R09xOXIxdXJMcGhCdVNKbkk2?=
 =?utf-8?B?NmVHUFFyUFVYWDBaU2syZm4zb3FlRnpzUThFd2gzWXBoS3NqSm1QSGVtT1ZC?=
 =?utf-8?B?YWJKblk4VXFSdVFuTUN6VDVkUmtTVDE5U2VNZmI2YkJNb1hnbnBUUEI0djI0?=
 =?utf-8?B?Wi9hckZjZjdWWk9vR3h2aHY4MlRoWHFQQ2cxK3NNNGpUL2pPTFptcmRpQng2?=
 =?utf-8?B?eTU5Rm1pL3RxZnB6V2pmdXZ6cmFsam9kWUtPb0VaV3VXcWZwWW1rdHd6NFRp?=
 =?utf-8?B?VUI2TWVaNjlHMnpSZE83cVBhRk10TFptdnBWVmZaNlpGUlN0Y2M4NE1oZzli?=
 =?utf-8?B?blFIZnYwOUxtV1hHV0dHL1RxdjgwUTV4NVRhSXpsck1mSUV5NER0cnNBZjg4?=
 =?utf-8?B?bnZWWXY3RnkwcnlMRU5XcGZISjlDZFVvU2hsMk5oL003aWVvakhlbTF5bTNj?=
 =?utf-8?B?aWFpc1Q4eXlCSEhpbU9hZGhuek04Qzg0eUVNeVFZdHVGWE9PQ2luTWpIWTdx?=
 =?utf-8?B?alY3czRpTE4wZFQyWUo1R3orY0NOQ3hTemt3VDBhQXZlNlpBbzNVcThlSGh3?=
 =?utf-8?B?RU1MbTVWcE9PRjMvLzZhWWRSNkxFUzgwY1RCeUpoNGpHWERPdzFEdkR5Y0lh?=
 =?utf-8?B?aDBnSnIzelpCaDc4UjNhRmtwNDcvc2FTaGV1S0Y2MDh5VCtHOWVSWUU3OVpk?=
 =?utf-8?B?SEhFcW83TnJkTUNnZnBnc3R2MjZ1OTR3RlRLWDJGU1NjZTZuVzhMVGRmR3VN?=
 =?utf-8?B?anZpUmhKdmpMQ09HOS9ZUm5nTnBPVnRKVGV2RmQwRjVHR3A5MmxHQXRyZXlk?=
 =?utf-8?B?eDgycExmUjZ0UE51ekVQbDc3alBOeVVoTDIwNGppNjU5Nng0Z3FkZ0lRNGxw?=
 =?utf-8?B?YUU0d1FHUjVHUTl2MkRBdm1EQXBnd2poSFpHbC9PU0ZGVkJ1aVcwVW9RUEVH?=
 =?utf-8?B?ZXdwUUJCR0Zxdi82Y0FNU3RzV0RLTFJZTm5PRUxIcTh1bmpZZ3htMHQybEtv?=
 =?utf-8?B?c1dYY1E1cmllZmtBcjFxS2RSVUk5M0dQVnpiZG5sS2VYRTRCREoxMWtJR1FW?=
 =?utf-8?B?SllFRG1paG1PZGdlQlpUZ01tZFJ2TVFhWUd4MFJiWTR3U2ZwaHpiem5oQ2RO?=
 =?utf-8?B?dndIYlhWSVA4YUdPWFV4cTlPS1JrQzQ1YnZLL3grWFA4VThzU2RNRTNQamFv?=
 =?utf-8?B?SzE4YmM0azRzQWoyQXF4eldySUcxVGg1NFB2cWlYWVVlTGtxd29vUXNPWkN4?=
 =?utf-8?B?R3hjN2owbTlHRm12STFvL2VmUEttVzE3V3NUWmZ2WEg3U1BEcVFiOWJKMzR5?=
 =?utf-8?B?QnBBMzI1VHA2UTZWOEFkZDZzalFmVDF0OFVlSE1TeVUwR3JKZitCYXR0YVQ1?=
 =?utf-8?Q?Irni4R4dLxY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW1nVkp2cmthNmNNUitUVW1VcXg1V2lqVUh5SS9GdVNpbGdEK1J2VXVlYW0z?=
 =?utf-8?B?RGtnNGMwZmZIdWZhMWpqeERaZXhTbk42alAxNUtpc2FYTi9xdmh3c29XRmpr?=
 =?utf-8?B?d2N2WTNZNW1MYVNWZGRwV3p4YWlpNXBxWmc5OXZkVkxmVHlsV2RuUHErZGVX?=
 =?utf-8?B?QytlNmdqUUx5SU5EMEVEa1Q3UnhuSHJWYUg5YnIzbUNRV05uRXllTHd2cHJr?=
 =?utf-8?B?MGZZVHBEZWVlTnFLbHFkZnRGaklLVndnVGtGUXV1OXdzdW9kNjg3R3ZHZmZM?=
 =?utf-8?B?NUx6K1h5R0hQcGh5YStmbXMrakV4ZUJybEx2akYvaWIwbTFsMFI1aXU1T3Nw?=
 =?utf-8?B?UCtMSTNPZWZBSGVFMmJmNk81M2lUeW9PYjFJdU1FWFZ2My9OK3kyZ3Y2TUJ3?=
 =?utf-8?B?RjJPQ3V4WEplNkhORzk0dEhpS29RR044Rm1LZ3kwTU03SXJ6SkU2UUw5MHU0?=
 =?utf-8?B?TnlvRVpqZ2NjWm9LUkxlT3I2cUUyT053dmE4cHlveWxOTUwveHVNSmluc0Vr?=
 =?utf-8?B?bHpMSko0aTA5MlJrNVNudmFaUFNweVZIRzhHY0RaV3poTlJOYVNReHBCbXVS?=
 =?utf-8?B?Q2llSkM1eTZrZ1dVZ0EwSUZhRFRJMTVFd2tncTVhVGptamM0N055UFNQSUtT?=
 =?utf-8?B?SGVaNE81ZC8vTTV2dFFIZVRJNG1VTzlQdWVyaDBQNElWeU9FL1JpWkZwNTdF?=
 =?utf-8?B?QXVRdlA0V2V3SFlVWU9EYzU4NUVEbTlpYk1hQlN5WGowZDN6SHlMRHN0UXhi?=
 =?utf-8?B?ZHpBVXdOVG4zTXd0djNFRzFwNlQybHZZODFBNzBMZ0ZvbFpMdmhSdm9PQnpE?=
 =?utf-8?B?NmliVW95aHhTUmoycXpBUzM2WHlKZ2xWcVVKbUl6b09QQ0VPeUZHcDBPU0c4?=
 =?utf-8?B?eFkvbFlmSnA5Tmg4N254QTNTcjg2Q2VaTWRodGRlcEtWZk01emVlbVZtQy9V?=
 =?utf-8?B?QzFuOXRVWUF4M3ZuVytxZnhuUjlOQkhrYTRWQ0ljSWtDSTFpSkQ5L3VqUW1K?=
 =?utf-8?B?aUQrbExYRnZvTnJ4T2ZqSVdIaUFrcDlmMGZqQlRkbUxIOHBNVm40Q1ZNd3Rv?=
 =?utf-8?B?SVhrMmwxZHZTRnh6MlpidVVFY3NtOHIrUUR6WjNmdUQ5Yk9JdlRaMGx4SEs0?=
 =?utf-8?B?UGZUemhyaWxGb1ZOb0oxa3I1S2Q1T2NHWXJsdmN1Nm1DMjBRV0NQZW84REdX?=
 =?utf-8?B?cXhnQlRIcVIwaW1KM25rS0UwM2hQNW1HRzRtdGRGNGplRHRWb1E4QXRkemkz?=
 =?utf-8?B?aTZoWE0vcUxkanZnSno3RUhINUxXWElhNi9OU3B3ZFFwbE5DckJmV2cwMHQ4?=
 =?utf-8?B?eXVQbHRlSWVoeE5rZmNaRGpaMG1uSEIwdW9oeFhub2FnazJMeHdlZ1krZGpu?=
 =?utf-8?B?am1BTlhFODlqMWNGbEFIV3pxWUlybll4NVRjekx5aEZQK0tOUG03ZXRPeFVY?=
 =?utf-8?B?ajNTYVRMTWgyOCtncmx1WDBFeENMd1lNcE5Zc0lJUlliN2t2UmZOU1czeUNq?=
 =?utf-8?B?VHkveE80enEzYnorVW9ucDNPcWVzMTV1QWNkM3V5dTErOVdtajRIUjdsL2x3?=
 =?utf-8?B?ak1vbDJVbmNNRE1jREZSUU5JWGtYaFNKQVhCU2Q1UGZkTXFSK3dxekVsbVVJ?=
 =?utf-8?B?WE9UeDFjQjBFSmY1cUlQM01JUUZwbDEvSnM3WEJWdFI3ZGNBUHZua0J5L1M2?=
 =?utf-8?B?eXM5cGlzY2Jxa1BodVJwNFZobHhOQTRSY09qSFpmQlMzUFhQdmRQVStrdW04?=
 =?utf-8?B?S1ZXaFl6M3dTM2hpSS9UQ3RiN2d6TFZsOFUzUm1rSkNxZUMrb0NKeTkzVnZr?=
 =?utf-8?B?cVpxVDJoUExvQ1FIaVVyaE1rOUU3UzVNaUtTOEFhbzdmR1N6VStpa2ltczlr?=
 =?utf-8?B?cURab2tZVjltRHhHRUNvRmZva3JXaFRER0hOOUFWWUx0bmZURldEcDh6YXY1?=
 =?utf-8?B?Z1lJTmhRQm9VcUlKNVNGaEFlcXBrbjB5UURNdGFzNmg0VXpVdnhrcCtpRVcz?=
 =?utf-8?B?aFlkd0Jod3Bvckl3Tk5mS0NaNXgzRjI4dFlmN3F6T0N3aEZXNmJsYVlUK2hR?=
 =?utf-8?B?c0RMejlyU01YRE1RclNGT2dmUVBseEtoV2RSVzZZMGY1TERLQkwwWVl4RkpH?=
 =?utf-8?Q?hQzg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658694e4-8989-4b99-7430-08ddd587cdb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 07:55:40.4681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1FgGW2FlR+8iLcGbTRpBaMNRyNXOYBQIHcxXGW0UNpz4ArKrWW30FnHlQiL0HVv36G2ajXK/4nMGWinKOwBCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6782
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogVGltIEhhcnZleSA8dGhhcnZl
eUBnYXRld29ya3MuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQ45pyIN+aXpSA4OjUwDQo+
IOaUtuS7tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+IOaK
hOmAgTogTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0QG1haWxib3gub3JnPjsgVG9tIFJpbmkNCj4g
PHRyaW5pQGtvbnN1bGtvLmNvbT47IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPjsgQWxw
ZXIgTmViaSBZYXNhaw0KPiA8YWxwZXJuZWJpeWFzYWtAZ21haWwuY29tPjsgU3RlZmFubyBCYWJp
YyA8c2JhYmljQG5hYmxhZGV2LmNvbT47IEZhYmlvDQo+IEVzdGV2YW0gPGZlc3RldmFtQGdtYWls
LmNvbT47IGRsLXVib290LWlteCA8dWJvb3QtaW14QG54cC5jb20+OyBBbGljZQ0KPiBHdW8gPGFs
aWNlLmd1b0BueHAuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGUNCj4g5Li76aKYOiBbRVhUXSBS
ZTogW1BBVENIIHYyIDIvMl0gaW14OTVfZXZrOiBSZXN0b3JlIHN1cHBvcnQgZm9yIGkuTVg5NSBB
MCBzaWxpY29uDQo+DQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFz
ZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRz
LiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQgdGhp
cw0KPiBlbWFpbCcgYnV0dG9uDQo+DQo+DQo+IE9uIFdlZCwgQXVnIDYsIDIwMjUgYXQgNTo0MOKA
r0FNIEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPg0KPiB3cm90ZToNCj4g
Pg0KPiA+IEZyb206IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4NCj4gPiBUaGlz
IHBhdGNoIGlzIHVzZWQgdG8gcmVzdG9yZSBzdXBwb3J0IGZvciBpLk1YOTUgQTAgc2lsaWNvbi4g
VG8gYXZvaWQNCj4gPiBkdXBsaWNhdGluZyBkZWZjb25maWcsIGlteDk1LmNvbmZpZyBpcyBhZGRl
ZCBhbmQgY2FuIGJlIHNoYXJlZCBiZXR3ZWVuDQo+ID4gaW14OTVfYTBfMTl4MTlfZXZrX2RlZmNv
bmZpZyBhbmQgaW14OTVfMTl4MTlfZXZrX2RlZmNvbmZpZy4NCj4gPg0KPiA+IGNvbnRhaW5lci5j
ZmcgYW5kIGlteGltYWdlLmNmZyBhcmUgdXNlZCB0byBjcmVhdGVkIC5jZmdvdXQgZmlsZXMgdGhh
dA0KPiA+IGFyZSBiZSBwYXNzZWQgdG8gbWtpbWFnZSB3aXRoIC1uIHRvIGJ1aWxkIGZsYXNoLmJp
bi4gTm93IHRoZXkgaGF2ZQ0KPiA+IGJlZW4gZGVsZXRlZCBhbmQgcmVwbGFjZWQgYnkgYWRkaW5n
IHRoZWlyIGNvbnRlbnQgdG8gdGhlIHByb3BlcnR5DQo+ID4gY2ZnLWNvbnRlbnQgb2Ygbm9kZSB3
aGljaCB0eXBlIGlzIG54cC1jb25maWcgdW5kZXIgYmlubWFuIG5vZGUuDQo+ID4NCj4gPiBGaXhl
czogOTkzNjcyNGFhOWIgKCJpbXg5NV9ldms6IEFkZCBpLk1YOTUgQjAgc3VwcG9ydCIpDQo+ID4N
Cj4gPiBAQCAtMjEsNiArMjEsMTYgQEAgR2V0IGFoYWItY29udGFpbmVyLmltZw0KPiA+DQo+ID4g
IE5vdGU6IHNyY3RyZWUgaXMgVS1Cb290IHNvdXJjZSBkaXJlY3RvcnkNCj4gPg0KPiA+ICtpLk1Y
OTUgQTAgc2lsaWNvbiB2ZXJzaW9uDQo+ID4gKw0KPiA+ICsuLiBjb2RlLWJsb2NrOjogYmFzaA0K
PiA+ICsNCj4gPiArICAgJCB3Z2V0DQo+IGh0dHBzOi8vd3d3Lm54cC8NCj4gLmNvbSUyRmxnZmls
ZXMlMkZOTUclMkZNQUQlMkZZT0NUTyUyRmZpcm13YXJlLWVsZS1pbXgtMS4zLjAtMTc5NDVmDQo+
IGMuYmluJmRhdGE9MDUlN0MwMiU3Q2FsaWNlLmd1byU0MG54cC5jb20lN0NjZTc2ODBiZjE0MDE0
MjU2MTlkMDA4DQo+IGRkZDU0YzUzNDYlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYz
NSU3QzAlN0MwJTdDNjM4OTAxMg0KPiA0NTk4MTA4MTkyMCU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFkNCj4gaU9pSXdMakF1TURBd01DSXNJbEFpT2lK
WGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MNCj4gMCU3QyU3QyU3
QyZzZGF0YT1CN2FLeUElMkYwTXoxQkVrNG8xSHJIU2xmRCUyQk9Va1hOU1MlMkI2dU5DDQo+IHpL
NVlrVSUzRCZyZXNlcnZlZD0wDQo+ID4gKyAgICQgc2ggZmlybXdhcmUtZWxlLWlteC0xLjMuMC0x
Nzk0NWZjLmJpbiAtLWF1dG8tYWNjZXB0DQo+ID4gKyAgICQgY3AgZmlybXdhcmUtZWxlLWlteC0x
LjMuMC0xNzk0NWZjL214OTVhMC1haGFiLWNvbnRhaW5lci5pbWcNCj4gPiArICQoc3JjdHJlZSkN
Cj4gPiArDQo+DQo+IElzIHRoZXJlIGEgcmVhc29uIHlvdSBhcmUgdXNpbmcgYSBkaWZmZXJlbnQg
dmVyc2lvbiBvZiB0aGUgY29udGFpbmVyIGhlcmU/IEkgZmluZA0KPiB0aGUgbXg5NWEwLWFoYWIt
Y29udGFpbmVyLmltZyBmcm9tIGZpcm13YXJlLWVsZS1pbXgtMi4wLjItODkxNjFhOC5iaW4NCj4g
YXBwZWFycyB0byB3b3JrIGZpbmUuIEVpdGhlciB3YXk6DQo+DQo+IFRlc3RlZC1CeTogVGltIEhh
cnZleSA8dGhhcnZleUBnYXRld29ya3MuY29tPiAjIGlteDk1LTE5eDE5LWV2ayAockEwKQ0KPg0K
DQpCb3RoIGNhbiBiZSB1c2VkLiBJIG1pc3NlZCB0aGVzZSBsaW5lcywgd2hpY2ggcmVzdWx0ZWQg
aW4gbm8gdXBkYXRlIGhlcmUuDQoNCkJlc3QgUmVnYXJkcywNCkFsaWNlIEd1bw0K
