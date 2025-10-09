Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D148ECCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 12:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC390844F0;
	Thu,  9 Oct 2025 14:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="VccV1ZEw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09437844D8; Thu,  9 Oct 2025 12:23:46 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABCC3844EC
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 12:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzQlXXx8JaUoou0UBFSdaLfLwkYWs671tt/CHQ5HqFiut25qxV1gkG+LYHMXkiCShoTxK2KGJ6BJ9B121+UEET3nGnKFg2uVBZtkwP8Y5JFJF3PYQVWD6IvYCFVG2H4yhCraHHMc8kCcD4IPSqW8QCqFUXaGUumYbbPt7BVRsrPnvjfQFbIxyhoZPPxvGqzg1H19wOVQKt11cuNK2v8kaR+GZSVOBGxz1LEEnxYQnY0jfNJrz/xaseCyHzrfBIwxt7BDenxynbEueHeZJCFM3qMPpxoI3/pkUzsfA/RzQ/3Zi9pSSDP9DAR/jLT2bSHDs9MDhptLxuF5kQKEhiVeEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiPPGJtI/wG/4yNfeawKGblSFeNa6c6elszUcolQJC8=;
 b=d+YoqHzboo06CUX3yL0n2kwZk5UX2qiWLwlxWeac3xG/aKRHUsJxngc6ZrR302ZDYLutKeAA5cUD9W7nU+Ok/eYjGI2NpqlI57+z7gEpWs6Ma0oj6/bjl0svhvb3HvLNwL8Lm5yeoPePraJLhg3IWmnxT2P3h9T+3c/VW8VS93jUTzhk5dZMfKVRkc23Ppb+aur7o4WqTDmY8clAP/LJggQDi5STEorzs/15gtrMxBgZUTAN9ziwAiOY5/OihBjMZHAkAb/sa1GWIye+jEb/QEkbab1vu/XMHQJ2UeQmPivLq5drYmIXbrerFNpitjdU8iRl4MArRmh4oSV0CvbPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiPPGJtI/wG/4yNfeawKGblSFeNa6c6elszUcolQJC8=;
 b=VccV1ZEwn568qS1qkhBp5IBn0GItTMYGdaetLrq75qa6Giu+xWkm+/lPoZM0UvBngTyXQCh3e0pyT/uJMRuqXJew6TDBHmXOYwcEemU1MfSTUhib16TV/z2WsBw/Dx/vXoPENTMl7l+P6wOvQG1roc+T+RQWjDLbmjMmu+4D5vXjBHupKBOOPc0FtKhZDhVRC86w8cB6J/ZufLwzvSSEly+fz9+8D0v2xpnG9JqOSpAThEi1dSLkpeI0Ei67O5+om/akYE3DTrjxCQC9mXQRKzoxipIP7VfnoMbctEJc2uwbMJNOn41p0Wlgfeux8efzEaIzrCe4kEy6AUJhNrGztQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB9PR04MB11625.eurprd04.prod.outlook.com (2603:10a6:10:607::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 10:23:41 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 10:23:41 +0000
From: Alice Guo <alice.guo@nxp.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Adrian Alonso
 <adrian.alonso@nxp.com>, Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marex@denx.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?gb2312?B?u9i4tDogW0VYVF0gUmU6IFtQQVRDSCA1LzZdIHVzYjogZHdjMzogZ2FkZ2V0?=
 =?gb2312?B?OiBBZGQgZGVsYXkgYWZ0ZXIgc29mdHdhcmUgd3JpdGVzIERDVEwgaW4gZHdj?=
 =?gb2312?B?M19nYWRnZXRfcnVuX3N0b3AoKQ==?=
Thread-Topic: [EXT] Re: [PATCH 5/6] usb: dwc3: gadget: Add delay after
 software writes DCTL in dwc3_gadget_run_stop()
Thread-Index: AQHcAHq7JAHAYgHUyUKTzLuOcoRaxLSqOkGAgA/SLEA=
Date: Thu, 9 Oct 2025 10:23:41 +0000
Message-ID: <PAXPR04MB9644C517B05B65870296995FE2EEA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
 <20250720-imx95-v1-5-759619b47b1f@oss.nxp.com> <87a52dk5mo.fsf@kernel.org>
In-Reply-To: <87a52dk5mo.fsf@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DB9PR04MB11625:EE_
x-ms-office365-filtering-correlation-id: 8270f87d-5106-4153-fac3-08de071deb3c
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|7053199007|38070700021|13003099007|921020;
x-microsoft-antispam-message-info: =?gb2312?B?bEJzTlRUWmtuZXhuYnVWNWU3cUhqWG4rdU5uaGpzdThnSFh2LzJucWN4bnRi?=
 =?gb2312?B?N3BLMGpCbmFYQ0M2aVE2VUdXcjUySE5rbzltdzhaZDRtaE1kellhbnFDQlZr?=
 =?gb2312?B?Z3FvTEVmb010WTQzTlV1ZmVXTVhBb0tkY05GR2pwcHZ5Y21TczczZGkvWWx1?=
 =?gb2312?B?aDdOSVNWRit5MGpLK0NOdUtZVmpaRG01OHJTOWNnNi9aanlraUswdnhmUTE5?=
 =?gb2312?B?bGZPZmxNNld0TDF3YXU4YlpTMEtLeGh6T3AxOElZaktYM1Zha2RKZUM0WnFC?=
 =?gb2312?B?UFJRc0NCZDExOU5ydURwdEU1M3JHbEVlbERXei94dlNYcWlvY3FOQmJQTGZy?=
 =?gb2312?B?Vzl1M1JCekROUnBlT29NbnArWjJRMGh3Wk9GOTBtTmdneHZMeDNLRGZCclU3?=
 =?gb2312?B?S2xXMFdqVlVxSEJ4K1RyV0hVNStibXhwbGN2VkRoQzViUDdpYzV5dHpGVy9N?=
 =?gb2312?B?cHcxTi8rOEJUQnJJUTFOaDdNa25mRUxPajhhczZrVHI5aGpLOGlCYlhubVlY?=
 =?gb2312?B?aGx0MWpLbS8zaWIzd0V3VXc4ekFOVlJiNWh5VTFlK3IvQ0F2azE3Rk51QXZw?=
 =?gb2312?B?b2hGZGkzN2Z4cXBjQXNQeERIVTBVT0xuT0d3aXYxOEpSME90TXJuVFNkb2tY?=
 =?gb2312?B?Q21oMkx3YnBnK3ZGcEtjRXlHWUNaZ05xSTdLcTZMV2V6UENiem5jVGdLVHV0?=
 =?gb2312?B?R1RnUDJOaEMrekNnVjJ1dUo4UTRGMExqWCtacmpzZ2JnNitxSWNhSE9uY0Jj?=
 =?gb2312?B?Z1ZlcE43NzkxTGJRUkdBNFVUaU85S3RmcDFsaHA3WVhlMnpJZEZMcDlPWHUw?=
 =?gb2312?B?bTEvUHY0NDZKZDcrZ1NTcGdIVml5OXV0WStkVnVUM0hyUm40ZEdmVUhBM1Zx?=
 =?gb2312?B?d3pKbUMxN1BBTGVCK2w2ODVMYUx1a3FqdDAwS0VyMlJBbjJyQmhlSnRBRHhN?=
 =?gb2312?B?bnQ4QWxKQmdvenhKNjNBQWRsMitSL05GSDlkRUhMejNRWHZZd2pwSTJtNXd6?=
 =?gb2312?B?cjNsYVR1a2VTT2xJSkhlcnRqRWZRUDc5SG80Zis5NTdKMytHemo4ckVJZEEy?=
 =?gb2312?B?MFJYT3c4TnpqbXhyNjNBdkNONG5leGpCamxqdXVYb21KRW1xZ0tDQkxMVkZX?=
 =?gb2312?B?NzlqczN1QmlybXRCNWFWKzJjK0tCamE4Q2pIeXplY00wWUhuMytIM2pCSUgy?=
 =?gb2312?B?K25IU2VYVURJdnJ4TzlKSitQTzVMSkNkNDQzU1lRKzhEWk1La0Q4bGRvSE4z?=
 =?gb2312?B?bWtRRjNOOTN4YWN4TjZjR3lKcTY4cTBuK0x6Tm53TTlrc05ZeW00Y0RjM3Rw?=
 =?gb2312?B?cFp0WjkxWmh5dHV3Z3ZYVk52ZFRVMkR6eTNHeXk5RkoycEZZdVNmSG5oOFJS?=
 =?gb2312?B?MGdrZnlqZ21tNUVMS1pZYXVqOVdRV0QxZkFKQk1oS3Bjd2FjOE5BeUNOcEN5?=
 =?gb2312?B?dHhuY0VscVpJUGp3enBZN0M5ZXpncjdKUGNFQmZBRXR4Z09hTi9xQ2ZtOG54?=
 =?gb2312?B?S1gyK1RLUjZWcUFmblBGK2JkYm5wQ1dxZDhjOUQ2M2NUUnArNTlaQUY3ZXMr?=
 =?gb2312?B?S2hqK29NUzhsN1diQTZvcnBFZERSSk9DWE1qeFEwdURpNTJHUXU0NlZlY0Ux?=
 =?gb2312?B?aWdtN0Y2ZlRHNno0SnhQY2ozV0c3ZUpEYndLZm0za1NEa2dETURKaGlJWGZz?=
 =?gb2312?B?UEpFMkxsODU5V2tKYllJNTNhYmNlcW1lc2tZdWJjTlZhRFdSdXNqNWJRczhi?=
 =?gb2312?B?SHVoNmdOWWJNaHMvWjhHeUh3d3phbXl1ZU9wemx6Mi81K3hueDRPamZ0b1Bt?=
 =?gb2312?B?anludkJndXpUdlhtQWhMZVgrSTdDRE9DTjI2WXByVUU5MlZlU3J6OVEvRFVO?=
 =?gb2312?B?c1ZIUGZ0NDlqeXRZZUp3U3NTM0Q1M25mclVGTTdnZU9TdDVGWGdla1RlaTZs?=
 =?gb2312?B?dk5ncURMN2lDNW5QTTA2b3drRm12ckJPRFBuS0RQckJqcVBYMFdxQXdRVVU5?=
 =?gb2312?B?cUlncXRUMG9nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(7053199007)(38070700021)(13003099007)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?a1YzV0FVWi9QVG4yYmlUeUZiTFRoQ2twREJWYStIV3dhVUltWjB0SWs3VHh6?=
 =?gb2312?B?U3BRck9MVzZLUzJlQUxZM0x3M0JJVEw2SGhlUDZIL05ZUFFMaFgrdmJ2emJP?=
 =?gb2312?B?ZGFDODA5ODRoSjk3ZUo4Qm9rRFM0S2wzT1NSajU3RlBFck9CT3R3NDNxbEZB?=
 =?gb2312?B?KzZqdUwzeGR5Rm54YXBkQUhrOUx5YU14TzY0K1Rqa1g5akVBU0F2SDRKZzZC?=
 =?gb2312?B?a05ERzNHa2tsUzdHQUUxL3JNVSs5ckR0OXdHQjhPZmdmQmxIZ2s1NVA1bWxT?=
 =?gb2312?B?eEJUK3ZlSU5Tdk9nM25tL3FMRXFQdHIxc0p5V3JQM1Ewd2o4YkQyc3dLT0lW?=
 =?gb2312?B?ZzBscXdLS0xseExXY0duYmt3NUcydmlRUy9veUxpbXl4SVVwWjIzOTlFRFlO?=
 =?gb2312?B?RUNBM3J2eFJZd1JiSTV0akVNZlNQSTRzb3FzZUcwSG9iTiswbjNobGVLb2Jl?=
 =?gb2312?B?dUFGcG8zWVduWlEwaElKU2J3U0xicEprajV5bGtwQ0s0bkxOUmxBcG9mOC9v?=
 =?gb2312?B?aGt2bGxzT1VqS05sWkh2eGVmd1VXd055aTA3ZjlQRTloS0NORGpvM0ZDTTVj?=
 =?gb2312?B?eFlrRnBiUmNXZUxyWk5sWTlYZUtYUWx4VDkyK0J0am1sUmtaa1lmZzF1VGdn?=
 =?gb2312?B?MGd1STJQV09BekxGVDIyc0Eva0Q3QWJRbHVYUWZYS1k5bk1neE4vK1ByZ1RR?=
 =?gb2312?B?dDhUeGZtNDNGdUtxZy9qU0taZ250TTB3bzJTZFVmb24zYWQzVlVzRE5Ick1y?=
 =?gb2312?B?eDE1dTdLMll4blQ4YjRZWlU2ZWtjbWlRZnRjalNUREx3enZqV3ZTeVBxdDlh?=
 =?gb2312?B?bFNmRkNXb2ZoT2dUdHRXMWdPQ0Y0ZE9iUlFEcTVGU3ZQZG1mTWxnUEpDM0dx?=
 =?gb2312?B?VmUvVjUxYW5GTWhuTHNZRlBUVjFEWWVRQ2QyY1RPbThoaHFUOURWbUNmZ0pE?=
 =?gb2312?B?cDlVMXhRWnhOdjhxU0VVZmFiQUNDK1VOQXZMRWxtRk1nOG95TGEvUFBRZXMy?=
 =?gb2312?B?bStSbjZlYTdGbC9rSkFTL0QzV3h3WVY3RFF0YmZTY2RPZUNNODBIMXJHRG1N?=
 =?gb2312?B?L3hJMy9DNnJScEJDaFpOdGhzWjZQazBOVWtoeC8xZnUwTm9ITlVsYmJwa2gr?=
 =?gb2312?B?Nzh5cDk4b2Z1dy9IZkNaQWhlSWRaRG5URk9TZUJsaDlJTTBtSEp5Z3FNWjNB?=
 =?gb2312?B?dmNNRkJqcXNFNm1uRnZoaTEyU3dFMlpMYnQ1OE5pUGtTOHVMU0xEQXluemRO?=
 =?gb2312?B?SkRVYWZxQTl2RzFvTjVOYlpmdk43c3drSHVXTmpSbXZwbGlKdmlQbEZPc2Mv?=
 =?gb2312?B?bXBZc2Z1R2xnaHJlejROVnd5eXFWclh4T0toYktKUzIweE9oWWNVQVNLaTNU?=
 =?gb2312?B?bGdKRmR5N216Y1BGN0NNa0d3aE5seHBFdlF1c0ZMSDM0M3hGUm1na09DLzJi?=
 =?gb2312?B?N0FpRHROUGo5NEMyN0x5T3M2eDZ0T1BkVzFKcUYzNWoya1hYVzR4NGY2UTU0?=
 =?gb2312?B?YTNydzBVOHBDaTBTOUJuMWtHMzJyRi9wUEcvcEJ0WGtkRXlxSCsrVlJ2dVRK?=
 =?gb2312?B?K0cvYmhzK2tYcWNPVHcwTFNZbVN2Z0JDNksyOWVDVHpCMlAvM3QvOW9RM3NF?=
 =?gb2312?B?RHhvV3JEMnVDdUVqZ0JQSlNYVWQvOUpHOXZyRlM0UHhMOUIyYXp4WjAycTBk?=
 =?gb2312?B?TzgzQkx5dElHUkhnaC9yK0k0N284a05TZ0haekV2SmIwT1d0b3U0czNBcnp3?=
 =?gb2312?B?SDhORzBHajh0bDBlVStxL3B3QmdUblhkYUlFVWszVUhZY3FXdURobjlhRzVm?=
 =?gb2312?B?SnQvRWMxRXpMN1RxL3NwejVXV1ZTOVMwUWZadVBYTmxvTG5ZMEdqUklLdFJw?=
 =?gb2312?B?bEE0dkRXdHg2V25pTXJVeUcxQ3VVKzNwUThTUHlXbGtJZkJqbldnTHAwVHJY?=
 =?gb2312?B?ZXhkbWNzbmhvRERSTk9ZeWZnNFFIVHF3ZUhVbjJHSitqeVBVbDhKWjFHa3l5?=
 =?gb2312?B?K2RkaHR1eHlJNHFucFYxMTZ6SjdGdWc1OUdZVVhPWGpRZHlvNW5nSFduNGdM?=
 =?gb2312?B?K2tNUERTWXNITmtVbHJWK0k1N0FuWU0yQ1lwSnZ5RjlkeUtQZnlqbXp3Y2Rz?=
 =?gb2312?Q?McV4=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8270f87d-5106-4153-fac3-08de071deb3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 10:23:41.5156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zJkrBLKcjWa2hyWPStHx6K/NfaxrW5LG9LoX4h+smaUzyiU2jIfrzVoHHW2Y4Bwnb6iVTT5cp7egOyOArl/HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11625
X-Mailman-Approved-At: Thu, 09 Oct 2025 14:58:33 +0200
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBNYXR0aWpzIEtvcnBlcnNob2VrIDxta29y
cGVyc2hvZWtAa2VybmVsLm9yZz4NCj4gt6LLzcqxvOQ6IDIwMjXE6jnUwjI5yNUgMTY6NDcNCj4g
ytW8/sjLOiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IFN0ZWZhbm8g
QmFiaWMNCj4gPHNiYWJpY0BuYWJsYWRldi5jb20+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBn
bWFpbC5jb20+OyBkbC11Ym9vdC1pbXgNCj4gPHVib290LWlteEBueHAuY29tPjsgVG9tIFJpbmkg
PHRyaW5pQGtvbnN1bGtvLmNvbT47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPjsgVHJv
eSBLaXNreSA8dHJveS5raXNreUBib3VuZGFyeWRldmljZXMuY29tPjsgQWRyaWFuDQo+IEFsb25z
byA8YWRyaWFuLmFsb25zb0BueHAuY29tPjsgTHVrYXN6IE1hamV3c2tpIDxsdWttYUBkZW54LmRl
PjsgTWF0dGlqcw0KPiBLb3JwZXJzaG9layA8bWtvcnBlcnNob2VrQGtlcm5lbC5vcmc+OyBNYXJl
ayBWYXN1dCA8bWFyZXhAZGVueC5kZT47DQo+IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgQWxpY2Ug
R3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gs63LzTogdS1ib290QGxpc3RzLmRlbnguZGUNCj4g
1vfM4jogW0VYVF0gUmU6IFtQQVRDSCA1LzZdIHVzYjogZHdjMzogZ2FkZ2V0OiBBZGQgZGVsYXkg
YWZ0ZXIgc29mdHdhcmUgd3JpdGVzDQo+IERDVEwgaW4gZHdjM19nYWRnZXRfcnVuX3N0b3AoKQ0K
Pg0KPiBbU29tZSBwZW9wbGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBn
ZXQgZW1haWwgZnJvbQ0KPiBta29ycGVyc2hvZWtAa2VybmVsLm9yZy4gTGVhcm4gd2h5IHRoaXMg
aXMgaW1wb3J0YW50IGF0DQo+IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlm
aWNhdGlvbiBdDQo+DQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFz
ZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRz
LiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQgdGhp
cw0KPiBlbWFpbCcgYnV0dG9uDQo+DQo+DQo+IEhpIEFsaWNlLA0KPg0KPiBUaGFuayB5b3UgZm9y
IHRoZSBwYXRjaC4NCj4NCj4gT24gU3VuLCBKdWwgMjAsIDIwMjUgYXQgMDY6MTMsICJBbGljZSBH
dW8gKE9TUykiIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPg0KPiA+IEZyb206
IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4NCj4gPiBXaGVuIHVzaW5nIE5YUCBV
VVUgdG8gZG93bmxvYWQgZmxhc2guYmluIHRvIGkuTVg5NSAxOXgxOSBldmsgYm9hcmQsIGl0DQo+
ID4gd2lsbCBnZXQgc3R1Y2sgaW4gYSBsb29wIGF0IHNkcF9pbml0KCkgd2l0aG91dCB0aGlzIGNo
YW5nZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5j
b20+DQo+DQo+IEkgc2VlIHRoYXQgYSBzaW1pbGFyIGNoYW5nZSBleGlzdCBpbiB0aGUgTGludXgg
a2VybmVsOg0KPiBodHRwczovL2xvcmUua2Vybi8NCj4gZWwub3JnJTJGYWxsJTJGMjAyMjA5MDEx
OTM2MjUuODcyNy00LXF1aWNfd2NoZW5nJTQwcXVpY2luYy5jb20lMkYmZGENCj4gdGE9MDUlN0Mw
MiU3Q2FsaWNlLmd1byU0MG54cC5jb20lN0NkZTc0YzUyNTBmMDI0ZmE0YzllYzA4ZGRmZjM0YzBh
DQo+IGQlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4OTQ3
MzI0MjExNTg5Mw0KPiAzMyU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tp
T25SeWRXVXNJbFlpT2lJd0xqQXUNCj4gTURBd01DSXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lU
V0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDDQo+ICU3QyZzZGF0YT04QW80dE9tY01T
S0h0b25paVZUd1A0MEp3ZzU0bHozNDJLUDBKSFVLd0E4JTNEJnJlc2Vydg0KPiBlZD0wDQo+DQo+
IFBsZWFzZSBtZW50aW9uIHRoaXMgY2hhbmdlIGluIHRoZSBjb21taXQgbWVzc2FnZSBmb3IgdjIu
DQo+IFNlZSB0aGUgZm9sbG93aW5nIGV4YW1wbGU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuLw0KPiBl
bC5vcmclMkZhbGwlMkYyMDI1MDExMC1kd2MyLWRldi12NC03LTk4N2Y0ZmQ2ZjhiMiU0MHBpZ21v
cmFsLnRlY2glMkYmDQo+IGRhdGE9MDUlN0MwMiU3Q2FsaWNlLmd1byU0MG54cC5jb20lN0NkZTc0
YzUyNTBmMDI0ZmE0YzllYzA4ZGRmZjM0Yw0KPiAwYWQlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5
OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4OTQ3MzI0MjExNjINCj4gNjQxNiU3Q1Vua25vd24lN0NU
V0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQQ0KPiB1TURBd01D
SXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdD
JTcNCj4gQyU3QyZzZGF0YT1NdFhxU3VlTkFaNkdmaU94ZG50JTJCSDZJVVdhYkwzSkRlMDFtOElL
SnBNeTAlM0Qmcg0KPiBlc2VydmVkPTANCj4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiA+IGluZGV4IDJiMDExMTNkNTRjLi42YjJiMjVjN2FhNSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+IEBAIC0xNDIzLDYgKzE0MjMsNyBAQCBzdGF0aWMgaW50
IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKHN0cnVjdCBkd2MzICpkd2MsDQo+IGludCBpc19vbiwgaW50
IHN1c3BlbmQpDQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gICAgICAgZHdjM193cml0ZWwoZHdjLT5y
ZWdzLCBEV0MzX0RDVEwsIHJlZyk7DQo+ID4gKyAgICAgbWRlbGF5KDIpOw0KPg0KPiBDYW4geW91
IGVsYWJvcmF0ZSBvbiB3aHkgMW1zIGlzIG5vdCBlbm91Z2g/DQo+DQpIaSBNYXR0aWpzLA0KDQpU
aGlzIHBhdGNoIEkgc3VibWl0dGVkIHdhcyBpbmRlZWQgaW5zcGlyZWQgYnkgdGhlIGNoYW5nZSB5
b3UgbWVudGlvbmVkIGluIHRoZSBMaW51eCBrZXJuZWwuIFRoZSBtZGVsYXkoMikgdmFsdWUgd2Fz
IGRldGVybWluZWQgZW1waXJpY2FsbHkgZHVyaW5nIHRlc3Rpbmcgb24gb3VyIGRldmVsb3BtZW50
IGJvYXJkLg0KDQpIb3dldmVyLCBhZnRlciBhIGRlZXBlciB1bmRlcnN0YW5kaW5nIG9mIHRoZSBk
cml2ZXIsIEkgYmVsaWV2ZSB0aGUgcmVhbCByb290IGNhdXNlIGlzIHRoYXQgdGhlIFVTQjMgUEhZ
IHdhcyBub3QgcHJvcGVybHkgaW5pdGlhbGl6ZWQuIFdoZW4gRFdDMyBpcyBjb25maWd1cmVkIHRv
IERXQzNfRFNUU19TVVBFUlNQRUVEIGluIGR3YzNfZ2FkZ2V0X3N0YXJ0KCksIGVudW1lcmF0aW9u
IGZhaWxzIGJlY2F1c2UgdGhlIFBIWSBpcyBub3QgcmVhZHkgYW5kIGNhbm5vdCBjb21wbGV0ZSB0
aGUgZWxlY3RyaWNhbCBhbmQgcHJvdG9jb2wtbGV2ZWwgaGFuZHNoYWtlIHJlcXVpcmVkIGJ5IFVT
QiAzLjAuIFRoZSBkZWxheSBhY3RzIGFzIGEgd29ya2Fyb3VuZCB0byBjb21wZW5zYXRlIGZvciB0
aGUgbWlzc2luZyBoYXJkd2FyZSBpbml0aWFsaXphdGlvbiBvciB0aW1pbmcgaXNzdWVzLiBPbmNl
IHRoZSBQSFkgZHJpdmVyIChwaHktaW14OG1xLXVzYi5jKSBpcyBhZGRlZCBhbmQgcHJvcGVybHkg
aW5pdGlhbGl6ZXMgdGhlIFVTQjMgUEhZLCB0aGUgZGVsYXkgaXMgbm8gbG9uZ2VyIG5lZWRlZC4N
Cg0KVGhlIHVwZGF0ZWQgY2hhbmdlcyBhcmUgaW5jbHVkZWQgaW4gdGhlIHBhdGNoc2V0IHRpdGxl
ZCAiRW5hYmxlIFVTQiBhbmQgRU5FVEMgb24gaS5NWDk0MyBFVksiLCBzcGVjaWZpY2FsbHkgaW4g
cGF0Y2ggNiBhbmQgcGF0Y2ggNzoNCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVj
dC91Ym9vdC9wYXRjaC8yMDI1MDkyMy11c2JuZXRjLXYxLTYtNTA3Y2RkYmU3MjE0QG9zcy5ueHAu
Y29tLw0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L3BhdGNoLzIw
MjUwOTIzLXVzYm5ldGMtdjEtNy01MDdjZGRiZTcyMTRAb3NzLm54cC5jb20vDQoNClRoYW5rcyBm
b3IgdGhlIGZlZWRiYWNrIQ0KDQpCZXN0IHJlZ2FyZHMsDQpBbGljZSBHdW8NCg==
