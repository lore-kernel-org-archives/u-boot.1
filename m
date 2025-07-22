Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559FCC83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 02:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE22083771;
	Tue, 22 Jul 2025 04:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="g/11iphV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF51837FC; Tue, 22 Jul 2025 04:05:40 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A54C830EA
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 04:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjh1HVXvh4NvlPLwDCfGYOWBn7mVMdQBcBQJzxGW55JJHWJTgWI+lyQXkDtxGwy/4BrSVc+UcYZvI4rnJim8OK80vlztcrScvhpTpK2OtTumUuqC/M4k+co/H83A0G5NsbimElFyDD1pG1Xbd25S6NY3+/eaWuT0JkPpoI34BF0bAetO7ijatCbx3BA3K0yXKZZTRFDoR0oEs3OwCNboOGxuyij8jXGArOpCyIxrEtHZLDzRvGbV3gk2t/UKjXN2xodNm6wbwHPXvX9DJoXzCgntvsi4v6dkeiHoxAEg0KXVQ6MZr9ouQqoMiu0ryI41ru4M6QlYBnJ98cixY4ARiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNmUBbyRXkuRMzsaQOyn8QFfOHZ6LKBSOxrp8cV2K20=;
 b=unHfT557i6yr4E4xnhmhurhFw01UnSvkh1bEBHlif2l8UnZy4n+lSePfpQMgyQfsahgh+zR8rkb4Mw5BvJ83aSoQoucEYejywob38pkZ3kcgncOVJ49eSZYADGVGzQQigqXcBb05rX6GK9FDdFhDkvEdXwVce1q9Hur/rp3J8Q+tBOvXtitz9xQtpo4IiruG1Pnrqxo9Oqgch0+wiK9L9Wx6K9ePtr4MSHIbAUEFP/XCzl8yylPxVRC3eSklVZBdRDyevK7Pp61KMcOLDYoSR6rsIdTNsBC99cQY6rGdrEwp48kL8JjWzObB0SAFWDIVM7R4jXMMgFHrY2K1slL8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNmUBbyRXkuRMzsaQOyn8QFfOHZ6LKBSOxrp8cV2K20=;
 b=g/11iphVfOJ/WnVht5Ir8bo5bubx+Kp8QefczKvMfglmpBWcJcofOw0d196MZ6IGsBdWGkGX2Xu/yD5vPuwYgg/BSUFzYtfWvwHNtrXmc2/Dt5dFEPp+TPcYOgiKRKr6VFYzf+8kUaC7MIf+jrjlIbxl/qPhClFlvAguMrbgV/9CSllTX9Y4nV7Gma5IijxzciBsvHIosfy8SY0nM0391hk4E/93e74qeUWFKnw5oGHHaHL12S9P8IrMhvjCON+TvDy1xqJX7Rn666+AiTMErHsY62ah6NiJffXKUHBaQew36Zo8sPdYcf2XZa8aXd9VzAZ78fjmaAHp6GL/spudZQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS4PR04MB9507.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 02:05:35 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 02:05:35 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, Marek Vasut
 <marex@denx.de>, Fabio Estevam <festevam@denx.de>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>, Peng Fan
 <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>, Ye Li
 <ye.li@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSB1c2I6IGVoY2ktbXg2OiBBZGQgaS5NWDk1IE9U?=
 =?gb2312?Q?G_support?=
Thread-Topic: [PATCH v2] usb: ehci-mx6: Add i.MX95 OTG support
Thread-Index: AQHb+mmboueep/thMUmd/uP1HivNDLQ9ZUoQ
Date: Tue, 22 Jul 2025 02:05:34 +0000
Message-ID: <PAXPR04MB9644278A8F8DD45ABF851855E25CA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250721180205.2696763-1-tharvey@gateworks.com>
In-Reply-To: <20250721180205.2696763-1-tharvey@gateworks.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AS4PR04MB9507:EE_
x-ms-office365-filtering-correlation-id: 67887944-e949-47cc-2fd7-08ddc8c43ee1
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?gb2312?B?L0FPNFJDUHJPQmFqY3l1bUdhYjB1SEJEd0dTVm9RMEl3a1ZKMTBqN1FjSmh1?=
 =?gb2312?B?MTNPT1BYT0M5N3M2WXNlbTB6b21RRFpyNGVod3B5NEYrYTY3OTVPRCtCSnlW?=
 =?gb2312?B?QjFZaWY3bmJRQ0FkTFBGMm1neWZiQ1pqcTRXdzNYQVprSDdmLys4VDkzc2Z1?=
 =?gb2312?B?aUVtd3lQWEplZzdEWGJMejhNL0pWQS8zNWQ1VXNBcWJoWkdWTlJ5UE53SjRi?=
 =?gb2312?B?OWd6emJjTWRqYk0rbjN1TDRXeWRva1NJNjJ5aVJWM0lGcnBMRThkTDBPUmx5?=
 =?gb2312?B?YmpQcUR6ekp0TmNzQ3I3UFhIdnZOZ1IxQnlwM3ZvRVk1MG9UOWZEMTRUTEt1?=
 =?gb2312?B?TDBRalR5RWxNR09SMEt0cHEwTXlROTlsek5JQzF0dk1hcHZXb3BNUWxPNVB5?=
 =?gb2312?B?bGcraEtVY013dEJ6RzZ0Qm9ENWpxeUFxMFd0ZjVnWW5SaWRSbEdVK2NuUVVW?=
 =?gb2312?B?dWYveW1NYTcwRnUyMmsxTUZZZFl4OTJMUFI5YmVuUXFxZGpkRXB2QUJ3am44?=
 =?gb2312?B?dTEvSU5LcHdpRk9NdG9DQWlRd1BYV0V2Si9uRDk5UFhScThTbnVLZ1dJQWJ5?=
 =?gb2312?B?aHUxYWVGaUltdytZQ0hVWitJODZ2SnduZXRra0w5Ym1tOUNCOVRBbFQxTjVQ?=
 =?gb2312?B?RGYxMlpQUUdWTmlIZTVOT1JBeFU1NmgvQmgrdnFPazVJYzg1bHhObUFpOXp0?=
 =?gb2312?B?Q3VHYlNNZXczL2czWjdzVTAvTjVtRjdzbjV0cDlRUzhKaEhpNHczcXE5UjBL?=
 =?gb2312?B?UGg1VTA2V3NCR0F2YmZzVHVZVklsQ2t0bFc0VExyY1oxMk1aTW1zSFViK3B2?=
 =?gb2312?B?RlVuWGZPaFIxZjZsYTExd2Eyc2RFSDFYMmovNjlPbFZ3MWx6dXBpeVlTTVY0?=
 =?gb2312?B?QWFZaTAvbEtzNTgrWnpWUndUekRicjdhdUdVUnJhYjkwcmpvRnhQdTdVb3RI?=
 =?gb2312?B?MkRCL1RzaDVOYzY2dERsaVkxUG5VcHNpWm1sY2VuRzdmR0loUDNqUGVrOUto?=
 =?gb2312?B?d1dNZzB6ajIwWkphYzAwQnRpL3ZhcVBWL3BPTkhZdnMzMm8yQ3dtZnduV3R1?=
 =?gb2312?B?cjJYekw4UjJxQVlBT0U5VzF0TWV5alAzRWZ3S1ptNEtDQlBNRzd6b2U4NzZZ?=
 =?gb2312?B?ZGN5VGRBVTdzU1lheEpxZ0J4VTQ1bzFqU2JPK0QzU1MyYk1yR0Y1ZTFTZFEr?=
 =?gb2312?B?K0tpUlZVV3o5VFZsckNpeHNueFplaStJd3lGMy9iMHI2dmpWalAvdXUvNHov?=
 =?gb2312?B?K0h4bWRnWjIrbVVXUmZsakdOWURTakkwazRELzZrUGVjWEhmbDVid0JQZjNv?=
 =?gb2312?B?QUptNGwwSzM4REt3VXJaTzBWOEFaZHR3MkFxTlk4R2lZNFcxK2FaL05nbVB2?=
 =?gb2312?B?Qnk0MjVmWlZOczZhOVI2Y04zYnVYb2k0YWVIaE5KYS9WWVpZM1ozbGo2RHhP?=
 =?gb2312?B?Uk1OWVFmdUU3UjEwV2RKRTZyWERyVForMXdBbkxQR2YycndWN09GNUQ1TitD?=
 =?gb2312?B?aTRBdUJreFFUNE82ZHJ0Q09RQlJhL3hpU1lvWlFHTTJ0ZkQvZHNCMnpGUlls?=
 =?gb2312?B?dGIyb2kwNVczNDg5cWo3TVZvY2V2ZVJ5VVd6aGhydU9zTnl6NTdHT3FnOGVR?=
 =?gb2312?B?Ty81RFBjdU9lZlJvOVpITVpvT0VCemQvNGhIemxidmJQOXpMS3NpSmhrQ3ZR?=
 =?gb2312?B?R3lFeGVJNzl3WGM3ZHBRUTNRNnV3MVZSUkgwUU5TK2QrVkpBZGRKazgxdW0r?=
 =?gb2312?B?WU9aOFhPL1FNR0FZRStKL2VmQVZhZGMrSXFZWXczdVFTRkd3WFdyVEhDOS9R?=
 =?gb2312?B?ZUdKRlhjU3A4K3NpOXpWSWh2M0JIdnhoSG1nejN2Ujl3bHVtMW5hcytna0VG?=
 =?gb2312?B?bHZPYUZBeE40a3d6dGpoV2tsWVhjM0hRejFxQlNyZ2pEV1NkdlB1Nkw5SzNt?=
 =?gb2312?B?OEw0Sy9nRmZmc0FnbUM3c2ZOV2pFUS83M2JqcnMxYkY5WmRvMHJLdDI5RzZF?=
 =?gb2312?B?c3VGQjZTV2FRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VWxHSmh3aHJjOC90OThuQUVuY1N4MkpLc1F5UXd1TERYK3g0NXhHeXNXT1Nu?=
 =?gb2312?B?SzdGby84MlpuQS9vcDFLUVJPMWI4R2xKcDVFQVA5VjRYbkdXdGphbi83Slp3?=
 =?gb2312?B?WWlLZWp6QTB0V3k0T09hbUxKS3lYRVJKQnB3d2xBZGdVOGJpMkQrVytHK2RJ?=
 =?gb2312?B?NnFEL0wrOHJqYlQ5ZXVtaE1yV3dMWVJwRGZkS0U0ay8zZ3dqaEtWU1hobGtM?=
 =?gb2312?B?cGNqSnIyWTRQRENTVm5LS0dULzkwenZLTGdzT3lOT2hyYVdFTEx3ZVhUQzVq?=
 =?gb2312?B?RlBMdGxNMjZuWWlBVWFVSFFudjhoS2N3TWYzZmFtUTcxR1k3REU0UWhYRUtw?=
 =?gb2312?B?RU5qcGd6aUV5UldWYVJ6Nkp2aDA5djdYNlhMQkxaU0sxNWdJWkNzQ1NEMWY5?=
 =?gb2312?B?Qk5CTmZxRWNwc1ZNbWVYcUdzSVgxZnUzb3hLSHJrTDZtQ0JLMThwNjZpOHBV?=
 =?gb2312?B?Q1FFS2xZTHBmaUNHVjJGRC9hc0dVMnRIYkhqSGJuMEtSL01mbkFrUlZlVXg1?=
 =?gb2312?B?WW9vY2tESUFVeEt3UHFhd2FEM0VBaFByUGhFL3NVTHFCM1kyTHJtb1VmN2Y0?=
 =?gb2312?B?clJidXdyK2o2KzYrZVFsQmx0YlBQNVJTSkl1Qmt0Sk81ZElJLzNPV3hydDdn?=
 =?gb2312?B?cmR1cHRiVVI0UWJhVDhtTi9vZVIyRURuZ25GSDladktzM0xUaG5NVlo1QVM0?=
 =?gb2312?B?ZTNlZlFHNlpnRDdvQVJ1QklLS2lYanNsd001TVBsRGttbmZ4T21lQXVJT296?=
 =?gb2312?B?bzBEeDlwUlJ3UDdoakNkci96SEpDQlNKR005dmZ1YmVOSy9tazllZldCbUxn?=
 =?gb2312?B?bXRSV1cyMzlqRHpLYWFuM2QxcURPdlpLTWpLaGtRWDJ6QlhCVzlWM1N0akwy?=
 =?gb2312?B?QWxob1Q0b3ZiVVdhME5VL3JJUlJ4YTNsT2FMam96SnVWVGswVC9lK0tZUXI3?=
 =?gb2312?B?U3d1VGN0SEp2RWxRRFhBcnBNbWZualZSUnpzbzNDazNuRXBaVnlRWDlsS1Qw?=
 =?gb2312?B?cnlPcXM2THk5SjB0UmVkbHR3VEJvRmdKM2tvbTVEb2RYLzVmcW9MUWRxaEtx?=
 =?gb2312?B?VjZKZnRwUFN3QjJBZW9TaTlZNStsU3hoSkl3c0E4bjJpZkkzSTk4S09KQVgx?=
 =?gb2312?B?RkhMcjNONkREMnVLa2JOMm9nWGQ0VlBrZnZYQUdjNUFldm1pZWhYRjc5L1N1?=
 =?gb2312?B?allBaWtEVnZpb0dsOUpHTVk4dDk0UUx4K0VOMlBjY1liQXhuOSt2akg5LzVu?=
 =?gb2312?B?WFo4UFBZN2krV0MvVm9xZUcydjA4UEE1VGRZU2JXdmZUeG02N2ZMbzdHbWtX?=
 =?gb2312?B?U0xDd0Y5MWdSWm1hUGVKNVZFOWdxTEsrdEhnVkZNUmphWHRlNFE1Z0ZkL3ZD?=
 =?gb2312?B?cnk4THppMEtYd2F2UXJza01ZUC9YL2g1V0UyWmViUk8rcEJjNmJtelg4ZFBs?=
 =?gb2312?B?cktlTkp3MGNTMjNHZTdmZVJaVm1EVEtqZVVyUWsxT2FWWUM3cmFoUnRSaDZh?=
 =?gb2312?B?azRMZHlmbnp2V3lzU2k4Zzd1WmloZ0VhZXZnTm9IS3lBbDYydkhWam95dXVY?=
 =?gb2312?B?OC9RYmZrRkozbXJhL1VUS0U2SlR4UkdtaGZzR0FodWRHMjZuQy9yMVlvMi9Z?=
 =?gb2312?B?VSt0SlZPTFY1aEhhUSsydStjSFpFYU9WV09LNlIyZU52YXpPYit0c0tmTS9C?=
 =?gb2312?B?L2dMTkoyTTJjdHRGT0E3YTdaaDdZTHNrNitJTjRvUU02QWYyRmdGK0RvVHMy?=
 =?gb2312?B?OG5TM0M2QXV3UDd5bjVFMVE3TnBYUWNBT3RQTTd2OStrbmtkT2FWb0VYaGV0?=
 =?gb2312?B?MDZwalNjVXlFL2R3aEVQbWJCQkM3S3ZBOWE3ZzUrVm9FRzgwYXk0YzBSQ2tW?=
 =?gb2312?B?TU5SUDFrNFFOVUxsTXkyS3UzYitWZWVpWVdSN0hMSUpFNUlzUmpwd2tIUEdo?=
 =?gb2312?B?STJhZDlDN2E2aXIwV05DajZnYmZ5NitjNUpEVVdUbzY4K0MwbkNEay9OT2tJ?=
 =?gb2312?B?NHJxdUZMWVNXam5XRUt4Y3hNY3BXQnVDczNYSWZJVUtQdjNXWkkvWmprNXBS?=
 =?gb2312?B?R1ovYVk1QnFIczF6TUVxcHVyeGNyOFR3R2dBNE9ybnRTMlQ4Wm5MLzBTd1pT?=
 =?gb2312?Q?s9hI=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67887944-e949-47cc-2fd7-08ddc8c43ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 02:05:34.9956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8v5su/QIatAA4Uwwar2FmJfClbw2oaMriVS3kE8CWOuhhQtm1y9Ck4sk/8X629QU58TupCf93yo+Oey0lQPNqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9507
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

UmV2aWV3ZWQtYnk6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQoNCkJlc3QgUmVnYXJk
cywNCkFsaWNlIEd1bw0KDQo+IC0tLS0t08q8/tStvP4tLS0tLQ0KPiC3orz+yMs6IFRpbSBIYXJ2
ZXkgPHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbT4NCj4gt6LLzcqxvOQ6IDIwMjXE6jfUwjIyyNUgMjow
Mg0KPiDK1bz+yMs6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPjsgRmFiaW8gRXN0ZXZhbSA8
ZmVzdGV2YW1AZGVueC5kZT47DQo+IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAu
Y29tPjsgZGwtdWJvb3QtaW14IDx1Ym9vdC1pbXhAbnhwLmNvbT47DQo+IFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPjsgU3RlZmFubyBCYWJpYyA8c2JhYmljQG5hYmxhZGV2LmNvbT47IFllIExp
DQo+IDx5ZS5saUBueHAuY29tPg0KPiCzrcvNOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgdGhhcnZl
eUBnYXRld29ya3MuY29tDQo+INb3zOI6IFtQQVRDSCB2Ml0gdXNiOiBlaGNpLW14NjogQWRkIGku
TVg5NSBPVEcgc3VwcG9ydA0KPiANCj4gV2hlbiB0aGUgdXNiIG5vZGUgaXMgZGVmaW5lZCBkcl9t
b2RlPSJvdGciIGVoY2lfdXNiX3BoeV9tb2RlKCkgaXMgY2FsbGVkIHRvDQo+IGRldGVybWluZSB0
aGUgbW9kZSBmcm9tIHN0YXR1cyByZWdpc3RlcnMuDQo+IA0KPiBUaGUgSU1YOTVSTSBkb2VzIG5v
dCBjdXJyZW50bHkgZGVmaW5lIHRoZSBVU0JOQyBTVEFUVVMgcmVnaXN0ZXIgYnV0IGl0IGlzDQo+
IGFzc3VtZWQgdG8gYmUgYW4gb21pc3Npb24gYXMgdGhlIGZpcnN0IHRocmVlIHJlZ2lzdGVycyBh
cmUgZGVmaW5lZC4NCj4gSXQgaGFzIGJlZW4gZXhwaXJpbWVudGFsbHkgdmVyaWZpZWQgdGhhdCB0
aGUgVVNCTkNfUEhZX1NUQVRVUyByZWdpc3RlciBhdA0KPiBvZmZzZXQgMHgyM0MgYml0NCAoVVNC
TkNfUEhZU1RBVFVTX0lEX0RJRykgcmVhZHMgMCB3aGVuIFVTQl9JRCBpcyBHTkQNCj4gYW5kIDEg
d2hlbiBmbG9hdGluZy4NCj4gDQo+IFVzZSBpc19pbXg5KCkgYXMgdGhpcyBkcml2ZXIgd29ya3Mg
Zm9yIGkuTVg5MSwgaS5NWDkzIGFuZCBpLk1YOTUgYW5kIGFsbCBvZiB0aGVzZQ0KPiBkZXRlcm1p
bmUgdGhlIHJvbGUgYmFzZWQgb24gdGhlIFVTQk5DX1BIWV9TVEFUVVMgcmVnaXN0ZXIuDQo+IA0K
PiBGaXhlczogODAxYjVmYWZkMzVkICIodXNiOiBlaGNpLW14NjogQWRkIGkuTVg5NSBzdXBwb3J0
IikNCj4gU2lnbmVkLW9mZi1ieTogVGltIEhhcnZleSA8dGhhcnZleUBnYXRld29ya3MuY29tPg0K
PiAtLS0NCj4gdjI6IHVzZSBpc19pbXg5IGFzIHN1Z2dlc3RlZCBieSBBbGljZSBhbmQgdXBkYXRl
IGNvbW1pdCBsb2cNCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9ob3N0L2VoY2ktbXg2LmMgfCAyICst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktbXg2LmMgYi9kcml2ZXJzL3VzYi9o
b3N0L2VoY2ktbXg2LmMgaW5kZXgNCj4gYTg3NDhjZWY3YWQuLjI1OTA3ZjIyNjEyIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktbXg2LmMNCj4gKysrIGIvZHJpdmVycy91c2Iv
aG9zdC9laGNpLW14Ni5jDQo+IEBAIC01MzcsNyArNTM3LDcgQEAgc3RhdGljIGludCBlaGNpX3Vz
Yl9waHlfbW9kZShzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPiAgCQkJcGxhdC0+aW5pdF90eXBlID0g
VVNCX0lOSVRfREVWSUNFOw0KPiAgCQllbHNlDQo+ICAJCQlwbGF0LT5pbml0X3R5cGUgPSBVU0Jf
SU5JVF9IT1NUOw0KPiAtCX0gZWxzZSBpZiAoaXNfbXg3KCkgfHwgaXNfaW14OG1tKCkgfHwgaXNf
aW14OG1uKCkgfHwgaXNfaW14OTMoKSkgew0KPiArCX0gZWxzZSBpZiAoaXNfbXg3KCkgfHwgaXNf
aW14OG1tKCkgfHwgaXNfaW14OG1uKCkgfHwgaXNfaW14OSgpKSB7DQo+ICAJCXBoeV9zdGF0dXMg
PSAodm9pZCBfX2lvbWVtICopKGFkZHIgKw0KPiAgCQkJCQkgICAgICBVU0JOQ19QSFlfU1RBVFVT
X09GRlNFVCk7DQo+ICAJCXZhbCA9IHJlYWRsKHBoeV9zdGF0dXMpOw0KPiAtLQ0KPiAyLjM0LjEN
Cg0K
