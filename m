Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76059C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 06:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9601182B20;
	Thu, 12 Jun 2025 08:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sii.pl header.i=@sii.pl header.b="dTwwGsyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE5682B70; Thu, 12 Jun 2025 08:36:09 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2072c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::72c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EFAA82A4B
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 08:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pkochanowski@sii.pl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KryriV7T3wtHQvO9ODdX1HYK6bZpFrJbHvhhKs6nAf/D40WHdZ3hKJG6pgvpF4atvAauZFGE4JBFLowIsx1L9J52pVvJ1+ejRXjqoJRmeprv++d8pqFIvjxNZtwG6SmyoQibdpfeKifJs1dY3n4cjNPH1lmg8h1uEwYfV0R5+g2oI+TOIjTeWGYm9PcU4sI8jxZtQCEiterw577ojO9Lb+G0bzuX4n+XZY1ES9ZUCTDm1kZ30QRLhstD8eZtqjinuXw1z9bEutI9V8nTvEXGkiS1+NKA2vm7NhCwNFKtoF0vgEEX+uMWzLF+ebW+ND1q3Rwa/XLFN+3dSMk0FjGxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oaUipJtBeAb13hiKYYrGcCxydrThIRMvaPyK6txrWg=;
 b=kncH19JcLyd6hNihWGfF5l0I35s78pefDvAKnQQT+MyQVfneN5xJq1gmBtUwSdofHvkDyOwDxgibnu+YHemYMGKqpm1HWhdVdbL5HiwCty9XmmBepVjYFeyAsfm1tK5SXJQKaF6sron3WHCP5xcQ88a7QEv1Ns4TUrfQIMctVbL7zD280s64YoXoB00Fpx8gIaKDKIsLzYavJmO3GDkczRJcsQAUp36w4XnJtk93/EqffdAmUqiNG6yEjdBn9r7CFGjlMl1eqZ7wxHwE3AcaCPeT32t3eQzdOndoP5ClT7uap+ZRAJoqMnjIFtl6nE9k2325dRYi0/raL7VCawXxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sii.pl; dmarc=pass action=none header.from=sii.pl; dkim=pass
 header.d=sii.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sii.pl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oaUipJtBeAb13hiKYYrGcCxydrThIRMvaPyK6txrWg=;
 b=dTwwGsylDiBZyRLpRnFRK1Zb7og/gXsGEtHDMn9SQb3BoKkjVQW/OfAx9TdxpeOHPBEkEQliDt5EWuYDDBisXjJdTh6/XiS2YHkOY+6tEZTYpGKrdv9W1MeQZG1LpFQdCUVEX+jYSB2J06ed72NTHjJdxB9tYImocUVG6sc4wKEO1T1WpzB5dCleJf001uokqRiwHyr+6Fj2eG4J+RpJi6ETYR1ioY/KDBfjPLB3Gts5I/pdhaPcO+num4E28fwSNSGitRT95rKA5aBA991wjLxdLNvYYorUHid6OHq4DaSX4ICJfkYpSwTKoImThk6ljItkTV2hlpr9jezKjpze6A==
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::16)
 by VI0P191MB2447.EURP191.PROD.OUTLOOK.COM (2603:10a6:800:20c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 06:36:04 +0000
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331]) by AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331%3]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 06:36:04 +0000
From: =?utf-8?B?UGF3ZcWCIEtvY2hhbm93c2tp?= <pkochanowski@sii.pl>
To: Horia Geanta <horia.geanta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Priyanka Jain <priyanka.jain@nxp.com>, Gabriel Nesteruk
 <gnesteruk@sii.pl>, Pankaj Gupta <pankaj.gupta@nxp.com>, Varun Sethi
 <V.Sethi@nxp.com>
Subject: RE: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Topic: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Index: AQHbp7vYj/H+qJ2ybk2H3sZmwaA1kLOZjPCAgAAKHaCAAUgJAIAAr1kAgAMDW/CAYOYUUA==
Date: Thu, 12 Jun 2025 06:36:03 +0000
Message-ID: <AM8P191MB1394274354AF865B540EC8AEA274A@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
References: <20250407124714.177059-1-pkochanowski@sii.pl>
 <DB9PR04MB8409F4CF8E38ED3ADAAB1E80E7B52@DB9PR04MB8409.eurprd04.prod.outlook.com>
 <AM8P191MB1394DE8E57990BF74131AA4CA2B52@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
 <DB9PR04MB8409F684D29E823DB780545FE7B42@DB9PR04MB8409.eurprd04.prod.outlook.com>
 <2509286b-a408-4ed4-9923-465eb87376fc@nxp.com>
 <AM8P191MB1394DFD2583712279E899836A2B62@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AM8P191MB1394DFD2583712279E899836A2B62@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sii.pl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8P191MB1394:EE_|VI0P191MB2447:EE_
x-ms-office365-filtering-correlation-id: d69922d9-c0f4-4485-5c0e-08dda97b67c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dXdKVWxybEt1MW9ac1lzNWNEQnFQbTNVNk4vVmpiUlhaMWU3S1lodWVLM0lq?=
 =?utf-8?B?eG9HbHJ3anBPNkU2NjArK2czdEl4bkdOMXJ4VVkyYUwzNG9DaE5teXVlN3or?=
 =?utf-8?B?bHBHWTJoSVl4VFZQOFZwNHB6Qkl2L2NvRFgrTG5YdCtDOUMvZjAyWVJIdlov?=
 =?utf-8?B?am1rSjdpSlpnZ0lhRVd3RXQ4M0hWZytRcDJ6NWRua3dJYUtlYXRYajRGQ2VH?=
 =?utf-8?B?dHR4dnVrRU5lTXMvbURkYUtFQ1M2dTVXYldPRk1SamE1cEJoZjd6NTBFa1hO?=
 =?utf-8?B?UmVyMlJnVU02ZVVmM3p2dUdPLzhWSkxNaGszMVdKcFhvb1JYUGtMSjY2dDkz?=
 =?utf-8?B?WXJFSnlqT0FXV2Jla09XYzB3eEFXNURxQTM1SThobk4yeFJxUFhqRnA1QnZi?=
 =?utf-8?B?WWpYRFpuRlVVbmVkVmxDNWVJU3I1aGpBSXFndngrcTRKUDgxRVhacjFUVzNm?=
 =?utf-8?B?ejc0SmJhdUhYTDJtZ3NTbEtTU1ZNNU5MWi84ejVzc0xON3l5Q0hBZllVVzJk?=
 =?utf-8?B?blI5Ylo4aitpbnBGVVNRYkwxVDd5NzdaN25LZHhoMVltdzlKbFV1QUZ2UCt2?=
 =?utf-8?B?YTgwbHZSV0RiWk0vbkd1UTJtS0pob0l6MXJwbUhzT2V0aElCb0NNMTE5WjBW?=
 =?utf-8?B?Ung1LzlUM3d1aFUybzNocWt2VHcxaEdDWlFxZFpNTjNWRGdtNnBSRjNONWFn?=
 =?utf-8?B?d2JPYXRYTnFLeHJWcG9VN1VRRmp5SUd3dG9YS080US9MVDJscDhLekxud2dm?=
 =?utf-8?B?YUJCNlNDSExrQ1BkMHlmNzRvbzdsNERSWjJUQ2Y3TGt6aEkzVWpQZU9wRWp1?=
 =?utf-8?B?ODV0ZGV0Z1l1OFM5dXhLQW1JMElpZVVMNFlXMTQ5Mm5XRU80b3J2VXIwYldp?=
 =?utf-8?B?L3ZiNEpISnZydXNpWjh1UVhEY2E0Q3Vya3dmOHVncGZWdEtFTGs5VEJ0Q1Vs?=
 =?utf-8?B?dUw4WlJTOGNxUzR4N0c0OW1tMXBtQ1lLL0ZRSkJkekZVUGdCdk5MdXcrNHVF?=
 =?utf-8?B?RnFnV0Uwb3F4VHorSTlFOEZDd1B0NTBaZHJ6bnNZT0dkRitqYlFrOHVNTmFQ?=
 =?utf-8?B?bm9CUXhNc2xGNWY0QWl5c2luSEluNDRhWVVtcVViQ1V2UStPU2hHbWtqVy90?=
 =?utf-8?B?TTRyL21iM05UZktleUFCeXpxajRQQWxPYXpRV2N1dGg0L0c3VTNvY2xkZkRs?=
 =?utf-8?B?bnkzS1pZRmJZcVhDOXZtWGFodUk2Tk5vYjFjY0wxWUtkRlVoQ2lPTFZUdUEr?=
 =?utf-8?B?encxdkxsZ3ZtdHM5Ym0xYVhrM3U2RlEwejNJR2hYVitTRmN4bVFtczNWdDkr?=
 =?utf-8?B?QVhBWkZGcVYxaHgvaWRyb21tL3pibE4vMnpPNWhQdE90YlQrNmlGdzkyTmNo?=
 =?utf-8?B?NHo4UkNPV1lNbFQwNi9OcGFUS0ExQlV2Mm9jYUFvSXBYUG16Rk5BRmtXeTg2?=
 =?utf-8?B?bk5iNzBsQVZGSkkzOHhBRkVMWTlFUW5Nem9wR2lmZDRMSndGWElvR2s1WGYw?=
 =?utf-8?B?aEpoZTh0bmFDbDRZYW85c3o0MzlJbGdFQVBHNk05NW1CSlRUcEVtcllMRHdI?=
 =?utf-8?B?Z2d4b3NSa2xvZ2tHN0ppaWFYaE5IL25PWDF5dWtORDFkd1F3NE5kdnZTUjlF?=
 =?utf-8?B?R2dCYVVaWTBLSnBNbDZROHp6WE45YzlNVnUwRnhQZDg3OUtKZVlvSUQ3U0Rp?=
 =?utf-8?B?dEVyTXNuNExrZ3lFNW1sWmJqQ2svZGw2TGZzdXRBSUZZb1RSWlZaQWJtSDZX?=
 =?utf-8?B?emI0TlBFVWd0VUcyczNFcVlxdXpsbW1lT01wc3M0OFdScTZMQk5HRFlHME90?=
 =?utf-8?B?TTdEdGRZeUtuUUd6aEg5NjhzbzZabmtSWFFpb2x5cXVWN1hKaHRPaEsyZmRs?=
 =?utf-8?B?Qkg3Y1BEQjFQSy8xKzY4Q1hHTWVGaGVsclpoWnc5SFk1cUhwdW12aUQ0anNp?=
 =?utf-8?B?d1FlNGJWVHlSdnJXRlJCRzZhTzgvak5XSGhsYWxwM2hCaHpEcjkwd1lwVzZM?=
 =?utf-8?Q?Flos0BtfMifn7jwcz+RsaZaNVSm/eo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8P191MB1394.EURP191.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWFuR0pNak9HRFdQR25KUEsrLyszOWkrdUZLZkZHUE43cDZwbFM4UHAyekZw?=
 =?utf-8?B?VnNkbE9EeCtIeVduS2luWitSNEltekRGWEFZNFdLZmpQTUtsMkhRMWhuWlN5?=
 =?utf-8?B?c3BYbTlSM2REajJsOXJFSTZnN2Ywc2w1K0tQbjVoOVhyTVppdjJ5MzRQdmNH?=
 =?utf-8?B?U3lnbkhlMTVBVE5LU1R2eEtHVDZvaUV1WjZjKzZmenVnYzhNelpVUUI0VDZ4?=
 =?utf-8?B?aGxmbXkyNGZ1OVFoSTJFdkp1WkRZY0JrbEVqalZEdEhjSnVNZ2trQlNIZ1R2?=
 =?utf-8?B?cEY3SU16OGFrbkhGVjF0aFNlTTBsRHpJbE5KaFRheTFsQnZMYmQrbUdJREs3?=
 =?utf-8?B?YkhxWm11SzdIdHc4UUNZTXBrVWtlVldrMWN5TDhlNG51UVRVY0NaWnlyWjJs?=
 =?utf-8?B?TC9rbTgxcjJLb3EwbHdJTld1L3hhSTF4KzMzbjVuWWpLWm1DRU5FU294U3c1?=
 =?utf-8?B?RE13UXpDbE5LNFBCZHhHSTJYMGFsVkQ0WmhYNWI3V0lKOXFNUUp0VDBDY3Iz?=
 =?utf-8?B?WWhBRFhLYkJzeGN2dlNHTDZtNTJoeE9VNE82d1J5dTRQbjNoa3JrUnM3Qm5C?=
 =?utf-8?B?dm9Sdm5CQ3BwRFJvYXpWdkluM05OK3V1TldtYmZoWXNLNE9OK2pDTE9SMm85?=
 =?utf-8?B?dFd6T2xSdU02dmdRaTl4Z1pHZU9zMUs3d2ROVmdwYWFrOFFEL3l5VW5WSXZM?=
 =?utf-8?B?WE5IdFlCZ21wSmwzVTNXY2Z3RzE3Uy81TnUzUFRvcDM0blVuTkhUOWdTNnFi?=
 =?utf-8?B?WDNtd1ltNUVac1RaNGNZQkkvWk1qdXcrS3hWQUhFaGpEWkxlS0djVjh1U3Zv?=
 =?utf-8?B?bFMvUTM2VEhwR0VtN2hsSmRkeDI0NmE4Ym4rRDg1VHYvWHR3WEw4K0xDQmRl?=
 =?utf-8?B?aURuL1Q3NHZFMEE0MXpCb0R3aXZXMVlncno1NDJHL01YelpBTVRTV3V6NDkw?=
 =?utf-8?B?bXUyY1dTNWxOWFMrRVNZeFJXVWh2QXVPejVJNi9VKzRYUy8zdmU3U3dSKzRa?=
 =?utf-8?B?cXRtQzRiUjJ3c1pLMVVmQUphc2FXZXc1TmQ2R2Q1S0YxeXRGT0xYVEtPdWk2?=
 =?utf-8?B?Sml5RkhCRUQvcDlRaHczOXoydHFmUXpCc09GT052bS9ra0lYbi9DM3Jsb1VF?=
 =?utf-8?B?d3FGQ0tPQTFqTk1UNVlkYUVLK2FwWi9vQzVNNW0wRktlM3pLUFhneWZjMTIz?=
 =?utf-8?B?RUVCZTdMems3dzJ4TC8rL3RqSEYxY3pPL2hLaENsWlV4bXBZK3JZSjlpMVRU?=
 =?utf-8?B?aDVCYk0vTG5BVTVZT3NZNXcvaFE0aU03dFkzZ3dVbEtGeDY4bEU2NlE1L3RZ?=
 =?utf-8?B?bXMxZTZQditiM0ZxRVdWcnNrMlMzUGpmdmZnbmdNaWFUcWJQdzhGZm1Uck1n?=
 =?utf-8?B?NlR1R2pOV2x4S0lzVkg0eGhyWVVQRmI3R1hBL2pxa2VQK0ZraFJuajRoYURH?=
 =?utf-8?B?UHJXbHNtMFlTZ2o3R0I2aW9yUmw4dFZHRTV5NCtPa0RSOEIvcG1mM2VkTGNk?=
 =?utf-8?B?ZGxuK0RZUmxlc0o5a2tYRGhKOVhGQlMyVjlCRVVGS0VnRWJBV0VuQlJFUGlB?=
 =?utf-8?B?QTZ5TkNSdGVUQWs4TEhzU1BFdmtzRmRPcW1vUDRIOFRzb2g1UFA0TTg4WW1D?=
 =?utf-8?B?UHFCSEM3SGZqa1ZBQTlzMHpPUHdqSm5LL3NSU3RtUm5IVG5NamdEMHVYd1dq?=
 =?utf-8?B?bHYySWp1VUppMm9wa05HUnN1RDJsazVoYW1kZWkrRXh1dFV5aU1KVXNBSkQ0?=
 =?utf-8?B?ejlGSjU4eGRIY0ZoZUhEOSswZlVLclR6bFM1amYwd3JKMnZDN3NHRFRyRWhV?=
 =?utf-8?B?SVU1d2oxVFpHbHRBNXVFK3dKRTIydFpqQlNaNlpHUkVEaXR5M2RxRHBtZjR2?=
 =?utf-8?B?K1gyQlE2R2lzQ0NWNzJmN1dXU3hmN2hCZ3VLOTJvUThJUFNyU29Ic2JtemhN?=
 =?utf-8?B?ai9id1FScE96VTBOSkgxY1NZeHRDekhNVkRxUHRza2NXZ2puSjNVdU52bjlp?=
 =?utf-8?B?SE5hTEphYjhwMk5qbi9QemczUllIdi9pc1hZbGRGRDN6Y21yWHdIbUZFcWVn?=
 =?utf-8?B?aTRNWXUwNDV1S21lTjVHZjkydFk2dGhDdEE4ZGVXcWhXQndkU1o1dGJIcDF6?=
 =?utf-8?Q?oLP8qc5634mrfnxAlpDnxhNRb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sii.pl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d69922d9-c0f4-4485-5c0e-08dda97b67c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 06:36:04.2893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9bd6df6-c449-481f-abb5-37bd036beb76
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JNf2Pk+Pgsw7z2ZsgMkF4g4TL9s0rARIeLwDBq9XobIYT/RZQkz8hOob4Zo725iw1m9F495tyon0X+4Rmo4oFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P191MB2447
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

SGkgSG9yaWEgYW5kIEdhdXJhdiwNCg0KSSB3b3VsZCBsaWtlIHRvIGNvbWUgYmFjayB0byB0aGlz
IHRvcGljIGFuZCBjaGVjayBob3cgd2UgY2FuIHByb2NlZWQuDQpJbiBteSBvcGluaW9uIHRoZSBz
aW1wbGUgcGF0Y2ggSSBoYXZlIHNlbnQgYXQgdGhlIGJlZ2lubmluZyBpcyBzb2x2aW5nIGEgcmVh
bCBtZW1vcnkgY29ycnVwdGlvbiBidWcsIHNvIEkgd291bGQgcHJvcG9zZSB0byBtZXJnZSBpdCBh
cyBpcy4NCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBoYXZlIG90aGVyIGlkZWFzIGhvdyB0
byBzb2x2ZSBpdCAocG90ZW50aWFsbHkgd2l0aG91dCBmdWxsIHJld3JpdGUgb2YgdGhlIENBQU0g
ZHJpdmVycykuDQoNCkJSLA0KUGF3ZWwuDQoNCj4gRnJvbTogUGF3ZcWCIEtvY2hhbm93c2tpDQo+
IFNlbnQ6IEZyaWRheSwgQXByaWwgMTEsIDIwMjUgNToxMSBQTQ0KPiANCj4gSGkgSG9yaWEsDQo+
IA0KPiA+IEZyb206IEhvcmlhIEdlYW50YSA8aG9yaWEuZ2VhbnRhQG54cC5jb20+DQo+ID4gU2Vu
dDogV2VkbmVzZGF5LCBBcHJpbCA5LCAyMDI1IDY6NDcgUE0NCj4gPg0KPiA+IE9uIDQvOS8yMDI1
IDk6MTkgQU0sIEdhdXJhdiBKYWluIHdyb3RlOg0KPiA+ID4gSGkgUGF3ZWwNCj4gPiA+DQo+ID4g
Pj4gRnJvbTogUGF3ZcWCIEtvY2hhbm93c2tpIDxwa29jaGFub3dza2lAc2lpLnBsPg0KPiA+ID4+
DQo+ID4gPj4gSGkgR2F1cmF2LA0KPiA+ID4+DQo+ID4gPj4gV2hhdCB3ZSBzZWUgaXMgdGhhdCB0
aGUganJfZW5xdWV1ZSgpIGNhbGxlZCBieSBydW5fZGVzY3JpcHRvcl9qcigpDQo+ID4gPj4gc3dh
cHMgdGhlIGVuZGlhbm5lc3Mgb2YgdGhlIGRlc2NyaXB0b3IgaW4gcGxhY2UgKGJ5IG1vZGlmeWlu
ZyB0aGUNCj4gPiA+PiBkYXRhIHBvaW50ZWQgYnkNCj4gPiA+PiBkZXNjX2FkZCk6DQo+ID4gPj4N
Cj4gPiA+PiAgICAgICAgIC8qIFRoZSBkZXNjcmlwdG9yIG11c3QgYmUgc3VibWl0dGVkIHRvIFNF
QyBibG9jayBhcyBwZXIgZW5kaWFubmVzcw0KPiA+ID4+ICAgICAgICAgICogb2YgdGhlIFNFQyBC
bG9jay4NCj4gPiA+PiAgICAgICAgICAqIFNvLCBpZiB0aGUgZW5kaWFubmVzcyBvZiBDb3JlIGFu
ZCBTRUMgYmxvY2sgaXMgZGlmZmVyZW50LCBlYWNoIHdvcmQNCj4gPiA+PiAgICAgICAgICAqIG9m
IHRoZSBkZXNjcmlwdG9yIHdpbGwgYmUgYnl0ZS1zd2FwcGVkLg0KPiA+ID4+ICAgICAgICAgICov
DQo+ID4gPj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgbGVuZ3RoOyBpKyspIHsNCj4gPiA+PiAg
ICAgICAgICAgICAgICAgZGVzY193b3JkID0gZGVzY19hZGRyW2ldOw0KPiA+ID4+ICAgICAgICAg
ICAgICAgICBzZWNfb3V0MzIoKHVpbnQzMl90ICopJmRlc2NfYWRkcltpXSwgZGVzY193b3JkKTsN
Cj4gPiA+PiAgICAgICAgIH0NCj4gPiA+Pg0KPiA+ID4+IFNvIHRoZSBzZXF1ZW5jZSBsb29rcyBs
aWtlIHRoaXM6DQo+ID4gPj4gMS4gY2FhbV9ybmdfcHJvYmUgc2V0cyBjb3JyZWN0IGRlc2NyaXB0
b3IgaW4gYCBjYWFtX3JuZ19wcml2ICpwcml2YCAyLg0KPiA+ID4+IGNhYW1fcm5nX3JlYWQgaXMg
Y2FsbGVkIHdpdGggMzJCIDMuDQo+ID4gPj4gY2FhbV9ybmdfcmVhZF9vbmUtPnJ1bl9kZXNjcmlw
dG9yX2pyKCkgaXMgY2FsbGVkIHRvIGdlbmVyYXRlIDE2Qg0KPiA+ID4+IHdpdGggYHByaXYtPmRl
c2NgIGNvbnRhaW5pbmcgdmFsaWQgZGVzY3JpcHRvciA0LiBUaGUgZGVzY3JpcHRvciBpcw0KPiA+
ID4+IHN3YXBwZWQgaW4ganJfZW5xdWV1ZSgpIGJlZm9yZSBwYXNzaW5nIGl0IHRvIGpvYiByaW5n
DQo+ID4gPg0KPiA+ID4gSSBzZWUgeW91IGFyZSByaWdodC4gSW4gTGludXgsIGNhYW0gZW5kaWFu
bmVzcyBpcyBoYW5kbGVkIGF0IHRoZQ0KPiA+ID4gdGltZSBvZg0KPiA+IGNyZWF0aW5nIHRoZSBk
ZXNjcmlwdG9yLg0KPiA+ID4gQnV0IEluIFVib290LCBjYWFtIGVuZGlhbm5lc3MgaXMgbm90IGhh
bmRsZWQgYXQgdGhlIHRpbWUgb2YNCj4gPiA+IGRlc2NyaXB0b3INCj4gPiBjcmVhdGlvbi4NCj4g
PiA+DQo+ID4gSU1PIHRoZSBVLUJvb3QgYXBwcm9hY2ggaXMgYnJva2VuLg0KPiA+IFRoZSBoYW5k
bGluZyBvZiBlbmRpYW5uZXNzIG11c3QgYmUgZG9uZSBhdCBjcmVhdGlvbiB0aW1lLCBvbmx5IHRo
ZW4gd2UNCj4gPiBrbm93IGhvdyB0byBpbnRlcnByZXQgdGhlIGRhdGEgYW5kIHBlcmZvcm0gYWRl
cXVhdGUgYnl0ZXN3YXBzLg0KPiA+IFUtQm9vdCBtYWtlcyB0aGUgYXNzdW1wdGlvbiB0aGF0IGV2
ZXJ5dGhpbmcgc2hvdWxkIGJlIDQtYnl0ZSBzd2FwcGVkLA0KPiA+IGJ1dCB0aGVyZSBhcmUgY2Fz
ZXMgd2hlbiB0aGUgc3dhcCBoYXMgdG8gYmUgZG9uZSA4LWJ5dGUgd2lkZSAoZm9yDQo+ID4gZXhh
bXBsZSBhZGRyZXNzIHBvaW50ZXJzIG9yIDgtYnl0ZSBpbW1lZGlhdGUgZGF0YSkuDQo+ID4NCj4g
DQo+IEkgdGhpbmsgeW91IGFyZSByaWdodCwgYWx0aG91Z2ggaXQgbWlnaHQgbm90IGJlIHN0cmlj
dGx5IG5lY2Vzc2FyeSBpbiBVLWJvb3QgYXMNCj4gdGhlcmUgc2VlbXMgdG8gYmUgbm8gY2FzZSB3
aGVyZSB0aGUgOC1ieXRlIGxvbmcgZGF0YSBhcmUgdXNlZC4NCj4gQXMgSSBzZWUgdGhlIGFwcGVu
ZF9wdHIoKSBpcyBhbHJlYWR5IHByZXBhcmVkIGZvciB0aGF0IGFzIHRoZSBgc3RydWN0DQo+IHB0
cl9hZGRyX3RgIGRlZmluaXRpb24gaXMgZGlmZmVyZW50IGJhc2VkIG9uIENBQU0gZW5kaWFubmVz
cyAoc28gd29yZHMgYXJlDQo+IHN3YXBwZWQpLg0KPiBUaGUgb3RoZXIgcGxhY2UgdGhhdCBjb3Vs
ZCBwb3RlbnRpYWxseSBjYXVzZSBhIHByb2JsZW0gaXMgYXBwZW5kX3U2NCgpIGJ1dCBJDQo+IGNh
biBub3QgZmluZCBhbnlwbGFjZSB0aGF0IGl0IGlzIHVzZWQgaW4gYW5kIEkgd291bGQgcHJvcG9z
ZSB0byByZW1vdmUgaXQuDQo+IERvIHlvdSBzZWUgb3RoZXIgcGxhY2VzIHRoYXQgSSBtaXNzZWQ/
DQo+IA0KPiBJIGFsc28gY3Jvc3NjaGVja2VkIHdpdGggVEYtQSByZXBvc2l0b3J5IGFuZCBpdCBp
cyBkb25lIGluIHZlcnkgc2ltaWxhciB3YXkNCj4gdGhlcmUgKHBlciB3b3JkIHN3YXAgb24gdXNh
Z2UgYW5kIG5vdCBvbiBjcmVhdGlvbikuDQo+IA0KPiBCUiwNCj4gUGF3ZWwuDQo+IA0KPiA+ID4g
NS4gVGhlIGxvb3AgaW4NCj4gPiA+PiBjYWFtX3JuZ19yZWFkIGlzIGNhbGxlZCBzZWNvbmQgdGlt
ZSwgdGhpcyB0aW1lIHRoZSBgcHJpdi0+ZGVzY2ANCj4gPiA+PiBjb250YWluIHN3YXBwZWQgZGF0
YS4NCj4gPiA+Pg0KPiA+ID4+IEludGVyZXN0aW5nIHRoaW5nIGlzIHRoYXQgdGhlIGpvYiBzdGls
bCBzdWNjZWVkcyBhbmQgdGhhdCBzb21lIGRhdGENCj4gPiA+PiBhcmUgcHJlc2VudCBpbiB0aGUg
YnVmZmVycywgYnV0IG1heWJlIHN3YXBwZWQgZGVzY3JpcHRvciBjYW4gYWxzbw0KPiA+ID4+IGJl
IGENCj4gPiB2YWxpZCBvbmU/DQo+ID4gPiBJIGFncmVlIHRoYXQgdGhlIGRlc2NyaXB0b3Igc2hv
dWxkIGJlIHJlaW5pdGlhbGl6ZWQgZm9yIGVhY2ggUk5HIGpvYi4NCj4gPiBJIHdvdWxkIGFkdmlz
ZSBhZ2FpbnN0IHRoaXMsIGNvbnNpZGVyaW5nIHdoYXQgSSBzYWlkIGFib3ZlLg0KPiA+IEhhbmRs
aW5nIGVuZGlhbm5lc3Mgc2hvdWxkIGJlIGRvbmUgb25seSBvbmNlLg0KPiA+DQo+ID4gUmVnYXJk
cywNCj4gPiBIb3JpYQ0KDQo=
