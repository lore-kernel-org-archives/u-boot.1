Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6B3D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 02:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AFCD83B9B;
	Tue,  9 Dec 2025 03:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Sky2d3VD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCD3D83BC4; Tue,  9 Dec 2025 03:20:28 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA32A83BA1
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 03:20:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oG64Q9lMiyk4LWqp6FwvX55Mxy5u8S1BSMpg1I2KGNS17NECsDyfkCJylc+7kgCXTwktz05x/cDdXupMPsB7pJySiituD5qRU3WIwZFtlAuPGJ+00S+zlbHg2frMhuZ7Tn8XDLYQ+tCKa5vuOOpCTrJiCTPIcqM5cecnbo1e3yjsdyEJyBVcZUXabU2Hw1n99tIO9WlJ2YRFzOSUlDxlny2Xn2F5XmVv5Bn4+w9pzGCIwDi+96MDND7Q922ObPVZX8BBwH9KFhVkt+ULRn87NFSzUbwZdXbsEgQd3ZXC239bdemAezIac8G6UNYgCzMSH9MhKSPpIr25cf3VkPu3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JLBO9vgywwnEMTIzOhUypDjeVWPg/agIy9a5xxyEr0=;
 b=oHWZ/o2CfTW4Hg49hsc91KHka3v4p8Qf/TJjICbFtiHx5Pj4xDRu+isyjdW6FmA9EAWNXmQJ3Nmx+vuXYmD3mzOlXlHgoC9Y9y6WKbqQvrEL0N2lp1Nnp51iDwEkVBAe3/gwo2bk7ZYM+Vjc9GP6wUq5oPFJGRe60HHT4CnkNsIzVxxlFndtyxVSU6dXIM73wk20uCr8TXuNa64RI3ZvbNRJhroK8q7KUwji/vPaGPG/M5UoN+4XTxyXNCSt0N2xbOIipsldOdttbyfJQ3GgOl0KEB3/HTdbUUN5Q6z12gbO1xxD3zLAOoV+IkgVOKxNT1YJr4pElYS9Vpb2xTgXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JLBO9vgywwnEMTIzOhUypDjeVWPg/agIy9a5xxyEr0=;
 b=Sky2d3VDTPSU8h0QaSIeSvZVFMtldifYOtrrf7dNReicqot8kZC5qdmbrI592c6AgYmulKgSxAzgQAb+rXvZiHBbd+nACAy3EvDQt1VjVGOR/lzgv5gDSnp221Z1g6Gew8/V5u9wihVnbYUC8jhLCZnZNdqCTQynsvvTM0HWBOh5QkAc7raOo5QC4wZKHt51DIKM2FlRUReqJNptwYibIt99kDhpQx/ycA2fD21Gz1tf/DQaCmhvCryjR5BHG5SHFiM147Yl23nzlr13bfUfzt1bLtg65iwH1QLhoHgcMJ2e8sqwdI4ryF1uRXdH9Bwd3uN53gXy2iV6fFOkbpGiwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB9PR04MB8331.eurprd04.prod.outlook.com (2603:10a6:10:244::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 02:20:25 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 02:20:24 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 09 Dec 2025 10:19:17 +0800
Subject: [PATCH v3 1/3] imx8ulp_evk: Convert to standard boot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-imx8ulp-v1-1-c58c22834737@nxp.com>
References: <20251209-imx8ulp-v1-0-c58c22834737@nxp.com>
In-Reply-To: <20251209-imx8ulp-v1-0-c58c22834737@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, David Zang <davidzangcs@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, Garrett Giordano <ggiordano@phytec.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Johan Jonker <jbx6244@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB9PR04MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: af603774-5c1b-4812-9163-08de36c982f6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlN2VWp5QkZDV3k3bnhTVld4STBHT0x3c0VMVWoydVpkWncyVVJucVcwY1RH?=
 =?utf-8?B?SkdrQ3BCMDVOb1lqWHpKUEpxRUNkQ0FkUWxBb3RaUWE0TmlqbG9Va05uWENO?=
 =?utf-8?B?cmNyTUNBajh0a2t0NTRVc2NkUWx2aE1YVElCTmlGTDZBSG4rbHhablovRHFQ?=
 =?utf-8?B?SUxiZVlxUGdvcHVNc0pmbUswb3JyTDFjaFg2cjNyTEIvVU5PV0htM2pablhL?=
 =?utf-8?B?WnMvRW1sSGJQSXpzaE5LTGNuNFFSVFM3eVJhQW4zcDNMZndlaUh3c1NQdWNB?=
 =?utf-8?B?Wk92Ymh3OFNhMVZ4NFVFN0dpN2FTcXc3QzVoaXZEbjVUVEE3anM3YXEyNUpE?=
 =?utf-8?B?N2w4SXVCbEFaaUJSRkp0bElrQkdVbXZOYkprdWdHZC9Ccnd3L2RRRkM4YVlx?=
 =?utf-8?B?aVRKeDZ5aTFISVE0c3hRaGpoTGp0NFpuZk1DbDB6V2czdWJsNWlqVUN1TlVy?=
 =?utf-8?B?SmViK0xwZ0VVUkhwNi9tc01WT3ArRFFRakovUE5iMjdWUjVHWDBaT0FCVXd4?=
 =?utf-8?B?YTd2RG1zVVBxd1BQWGxIZHVVVGcrRUluSHBxSXhQazlLZTIxQy8xZ0UyVCtV?=
 =?utf-8?B?VEdNNXFoOFEvVXVvY21uYkZoTmhYQzZuM3l6MVg1OWJpSEhUSW9Fb3lmSXBZ?=
 =?utf-8?B?TXVrNG4vWFkwN0JNMVpqQWJDeWRJUVl4cU5NMkExZ3MwVkVFajEvV3RrRXhB?=
 =?utf-8?B?aFoyV2lkRWdqWlVySHRCSXgrSWR5WHdrREo1QWcwM0dMYnRnS3VWbFlBQTlV?=
 =?utf-8?B?Y0NvZ0hLWkFzKzNIWlNiTm55V3JlYy9jM2QyNFJEN2hPcXFWckRLSnBJQ3NH?=
 =?utf-8?B?c25JYzRiWDV2SFNGcG5Ubkk0Y1pVSFRleDZtdU12NjRtTDJibC9qZGVzQThU?=
 =?utf-8?B?c2RXMnJmUGZHRWxPTVg0b2g0NEF5THVCckVuNnFydHZwSDVpYTVBRDVCRG9s?=
 =?utf-8?B?Q0FhekREZEk4UnBNTktYYkxpajhWdEloUGlMU0V4K1E5T21EOG5MWE93R3Zy?=
 =?utf-8?B?ZDRKOExBMFlsV0x6WkJOMTFGams1YTBMZmFKV2pMaXgwUkhGS3RvcmJnOVMw?=
 =?utf-8?B?YkhwdVFIcnlRWGQ3OWtzNjJEM3UxSkhELzNwUDBqcGFhblJXUVV5MXJXR1pJ?=
 =?utf-8?B?bS9QU0pySi9wQ1dLRGs2aE0yRysrTVBtK3h4UUthZ1phbEpLUXJSZmpXN0xk?=
 =?utf-8?B?anpUbEd3OEs1MW1QWDJTNGI1STlCZ2phMXFpMyt6d3M3d3M3eFhWT2E4REgr?=
 =?utf-8?B?aU5zNmlMUkR4MkJ1NzFYZWcybkZKWldYRlJtSytmQ05lZjMzd1NPVXhwcnlk?=
 =?utf-8?B?eFJnQmxYUHY4TGgrRkdCV0I3R0tsZzgrRm5sUkl2S0RUYkpFeVdOQXpIVmxN?=
 =?utf-8?B?bWZuMlp6Y1U0Miszck1SRVBLazRkVW96bTJPVkIvWWw1aG51bUtHWFU2OUUz?=
 =?utf-8?B?cUlzNVl3bjZzTlFBNHZ6Q0hVYnRKT0phbE9tblh1VjE3R1ZMRk8rc1gvV1Q1?=
 =?utf-8?B?VkUveEdFKzErL2c1L2JsbVpBUUVzYjl6V1VhOVUwWUdEeVpjOFJrYndacW55?=
 =?utf-8?B?ZldZbXh6ZElzTytBaGlYeUg5Z1I1RVJTOUtNMUZkSldUblpUdTYyMXF6QmMr?=
 =?utf-8?B?ZmtlcDAzQWdONXBVOEN5L1dGSTdVQUJuUEdTNmp5WTJQUUozUEtRaGN5OTRG?=
 =?utf-8?B?VGRBZ2VwS2pOeHZpd0pxWDlFbkUrQ2N3OVRtYmZVQjczY1hZb0x6RnNFcWRz?=
 =?utf-8?B?dVRZclVsRkdETHF3dGYxRzhIZmNGaGV6S1k0R3lFWDhlaTdoMlBrdi9FSklV?=
 =?utf-8?B?TGREVVJFNkluVDUxZDIxZm85MkxQenlGZDZ4NXN5Mm11TERrdWFIR3F4U1RU?=
 =?utf-8?B?aXMyZEpIODdseGFndlpSeTg5NWVOSVZUYkpybWtXaW4rcUVzTS9oWFBhalRq?=
 =?utf-8?B?TFpjWmdSTWl0RXRHK1FhVjZ5d1phelNKYkZTMlJUSEVKZGFKMFNkMlpyK2VP?=
 =?utf-8?B?NnhjMGw4V1Jyd2pUMlBJbEZuNlZEWDBiZ1hFRHJFaEltS3FvS1pBSUV2M09F?=
 =?utf-8?Q?+5RIUC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDByRTBKVjZjcWVzZWJ0MldoTG9JUTlIOWl3Q3pXM0kydVk3OWlZcEplQjlt?=
 =?utf-8?B?U2pOZnRXUG1pTXo5b04vM3gwbzRaU1V5TVJIODNPWkw1bFExVWdDMWxIcjNs?=
 =?utf-8?B?OHZDa1VZWEhuM0J3U1BNR2ROdG8xeW02eEo1NXl4VjdoZGVQOWFMd1owZ09X?=
 =?utf-8?B?cGdsbmlDL0czVnA4cURFUG1nZkE2YnByVFhVMUVwZS9WOHRqRDRlNDdSN3Bh?=
 =?utf-8?B?OTNTdzZaQldjdjRCemNIamNCMTRKNjBDNW9yTk5yaXNBU2gzWWxMRHJsQ1lX?=
 =?utf-8?B?Qk5VbCt2VUdsdEhyMEc4YlJJKzY3Lzk2QkVoWDRRZ2p4R2E0ai9iR2kwSUJ2?=
 =?utf-8?B?aFBZdUF5YldXVFFrM01WZDJBYUkwRkNHaVlGTm1LNzc1Qm51T3lEK0FiQVV0?=
 =?utf-8?B?cWp3aExnRlpOeXJPV3lEYitPN3RZZmY0WkMwY1g1VlN4UnREYXErR2hYNjdN?=
 =?utf-8?B?TkJKOGk5UHc1YlZiS1RNMGtSMWtMWHhTOHEzbUJVTXZjTFZZbDRnSlJIT21Y?=
 =?utf-8?B?cnRYSEtPd1IxRTNxQmhtSzJPN25pdWxUVUtDSWUwQ3ppZGRiUFZQOXJrUFg1?=
 =?utf-8?B?L0VQa2NCbk9kK0VtKzQ0WndqZUtXQ09uSzRtSlcraFJvbTRPZkt0dk9LeXZv?=
 =?utf-8?B?TjJZQ2FldDBaSnJIY2VtYmkyZ3pZb1k1N3lCZnd4WGduc0pmWkJRd3hWdnlO?=
 =?utf-8?B?eW1XaFBGSEphKzU1MEFEdVU1bzBEWEVSajd4TWMvbzB5WnNyZGR0Q0o0L2oy?=
 =?utf-8?B?VWd3ODhlODJnQnZZMWtiakpZU2EvNmRVM1hnbGN6OTNZbzdxNVIyNnVYQlo3?=
 =?utf-8?B?NU52d2VybmVDdStnZU5MQjJoeFF3SEgvT3lSTm9uV1dSbUNraEtLYm5JeEMx?=
 =?utf-8?B?eGt0Mk5mSGxqZUFNRVM5WWtnSnBFMTM0U05xMmZjaGc1VkVPdkhxdXhhNnI1?=
 =?utf-8?B?L0toSi9CM3dXMzVLQ1BHL3VuTGVRV3NpVjlXNEV0blFQbWJuaDdmNG9pVWky?=
 =?utf-8?B?YWtzVDZYME1iZWllaHFZUDJLTXdrRXV4THVsUHJWRWtqY2lJcmZlbXozcFBP?=
 =?utf-8?B?ZnpCVEdaZ1RucWNKME1TcFo1Q2NHZjE5azNVSy9SSWpYcnpkWnhhTkE5a3VD?=
 =?utf-8?B?bno0VVA3NE5ySUtNMnlpaHNXUWROWjRnaEUyUjlqVkg1dHR4YWpnZmRwc0s1?=
 =?utf-8?B?ZlpQMXgvTHNzQjdhMGJ5c3NIV3lGWXIwWjB5eW8zMGJjL2RHNEMvVUxPNG5v?=
 =?utf-8?B?YkRPUGxwY01ac28wVE4wSmRUT2pTY0VwMUIvYkFDam5XYngzWUpINGxqRkRD?=
 =?utf-8?B?SFlRcEp0eEh0TTRETzNoQU4yaUZlU2lnOFNHcjkzTTgxZ3o2NkcyUU5zNmJD?=
 =?utf-8?B?S3NhODJDVjFsYXYxL3AyQVplOXVIbzZ4TFV3TzJOa2lpWDFiNFh5a0QwamF2?=
 =?utf-8?B?NHE4U0lrUTVnVmtCdHRHTjYrZnAyWHpVNTlWNFFjMzZRTDFXYTU3Y0Y0S2ZM?=
 =?utf-8?B?ZmFPSVBFTUZMc1pidnZHN1JhTmw1anV6OTBqY21KeUI1aFp1SldybEZBTzB2?=
 =?utf-8?B?NFIxVXIvNWdBejl3ZmV2UjB0bzZrV01seldsbkFGU1Z6R1VuMytzckllcVVB?=
 =?utf-8?B?UUZJZkdJRGp2RWIzZTRLbys4Vk9IaFY3UElmbm45V3o5anpweVVqRDUvbUZ2?=
 =?utf-8?B?YzFhbHp3Vm1rY3JQbzBhRnFkcVozeUliNXlNRlZ2aFlXRWRHQ0VBSnV1TFZ0?=
 =?utf-8?B?NXIyNmZXOTRQZWpOcW1lOGRXSm9UczlJODBweDBzTGVFRzE5WjhxcjlLQ1ZJ?=
 =?utf-8?B?cUVBVE1rWHdvM1YzalhET0gzK3c3Vm01TWlFaVZybW14VlExREIwUnB3VVA3?=
 =?utf-8?B?R2Y1bllLSmxHbGlVNGlsWE5iQldaMWFobzJWWkp0cUJTQWNzRjBWaDN6dTVU?=
 =?utf-8?B?RUpqOWx2b1RTU3JZQTVpVldqL2tPK2pQTDVva2NPTUp0WWhOZUxoYmo5dzJj?=
 =?utf-8?B?K1V5QTEzVGxIR0g5Nk5GVGRxQ1gyR0VzY2UxNUtGR2NEUW03QUIrSVhJYjJQ?=
 =?utf-8?B?c3NkVWR2alNhbysyZ3pSMGVXd0dlbkRodnFFNUZJSTNmQ2l0TkFkRVQwQTlM?=
 =?utf-8?Q?KlybBhDuu6bdBPD77gbkT8PJg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af603774-5c1b-4812-9163-08de36c982f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 02:20:24.9167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKnqq7Ovlvn5RdndW+YwgeVNFcB6Xd/bVXH9bz64F/2ZgEYjjGv233uNMaHfrlmLDFEluDTh7hnuND1ahv/1lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8331
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

From: Alice Guo <alice.guo@nxp.com>

Replace CONFIG_DISTRO_DEFAULTS with CONFIG_BOOTSTD_FULL to enable the
standard boot framework and use standard boot on i.MX8ULP.

Update CONFIG_BOOTCOMMAND to run bootflow scan before falling back to
board-specific bootcmd, and remove legacy distro boot environment from
imx8ulp_evk.h since bootstd now handles boot targets.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 configs/imx8ulp_evk_defconfig |  4 ++--
 include/configs/imx8ulp_evk.h | 10 ----------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index e750b3d9ae0..8617cf32f2b 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -26,9 +26,9 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTDELAY=0
-CONFIG_BOOTCOMMAND="run distro_bootcmd;run bsp_bootcmd"
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx8ulp-evk"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2068
diff --git a/include/configs/imx8ulp_evk.h b/include/configs/imx8ulp_evk.h
index 9308f5234f4..eb006c5d4a5 100644
--- a/include/configs/imx8ulp_evk.h
+++ b/include/configs/imx8ulp_evk.h
@@ -21,18 +21,8 @@
 #define CFG_FEC_MXC_PHYADDR		1
 #endif
 
-#ifdef CONFIG_DISTRO_DEFAULTS
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 0)
-
-#include <config_distro_bootcmd.h>
-#else
-#define BOOTENV
-#endif
-
 /* Initial environment variables */
 #define CFG_EXTRA_ENV_SETTINGS		\
-	BOOTENV \
 	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
 	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
 	"image=Image\0" \

-- 
2.43.0

