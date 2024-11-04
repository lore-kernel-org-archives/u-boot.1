Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C87D132B5
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 12:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54ED588618;
	Mon,  4 Nov 2024 13:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="JWmIRehq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AFA58855C; Mon,  4 Nov 2024 13:39:24 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B505E88618
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 13:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFgD9yNmIcbSn4YIXvh8wzUCOdUmlan0MvJ1BhEJ/BkBwVouyKl8PTcrBG6miv4F6s1bFhmhhJb568NrqbLmdn3dcGzvI7T0c9fQ4VgjKxyC945beExLMB4i+e8uqk71NwTh/M/m9IIKRONPjdw3ttNZJ6/f8lV2s+EKzVwkRD1EKUcMSFtNG0gh2xTIUEpclksTJWQJZkGBPujxb2fvoCmGVcBY6gMG8/7fr5UyZ1y5iQOGoHRLx9KvIbeEKnxwFZG1GP0ry+QGWdt6gm3hKMRbFNPBM8rd2/1s+mMsim9L5vOG/DIE0WSZLbuj0p5QXgJk/9HItaqQ1mUkh7miLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzEh/QvL7ZpeXD2POXa+ykXwopCkepvXfut1w5yiF4w=;
 b=ocZ0gkAvoSCRjhILTpFjtwhlnLip4hvcjoACxksaPJk00B1ifaSG4WCw58UqK9V5y7/PwsaKBG5R9+vbIrU//wH4PzaWaT2ML6qlrP8LDa7XnK3ycxLFqBJUJDjVDsaLUCFAe6gf0Mx1NkpcxpZ4r8NkDAtstrWEZWQswx1BBhhSZcgCZtNGYDSUnax+obScjRoJTnEQBifMxpiSif7jex0e+RzlPkoixj74THHgMuc8q+kJkdAJ89YTQzH9yDwYgidn+XtDxvaNgdb6NbmQk+UEz+YbOZkgd8UM/tLxxjBApcOC4R4VzwHPnqB8bPPjEFVOWm1H2q95Hblwmu53DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzEh/QvL7ZpeXD2POXa+ykXwopCkepvXfut1w5yiF4w=;
 b=JWmIRehquxv19OHusuxJfOpHioh1xKP+MabqngljohAAmvcFNZYlj+LPliuWZVSwc4b1VLyUs/uYURGMY48ossYL+gNLkvRfOKGbMhSSKpMYXnd0MQ9WqLuP7wntaElG/NGesdQTiAx/glGBJ5k8AzY3KkzfYYD7lbPqxBmMS2eCTJ5nZtqB/j+e9xRFoPPbiXJ7sYq3XBj4OahJLQMQBM73cVxFZNa9qxQqruvRbGiwYJo4VXdubthpuozbCd/AZy6Ja/x6xDEwwfQ/YWL0hv8TvQh56ibpjy5dRM05kV9pQxVmCYhHhGDGIKmNGFmqUXJeby70U60r3uTdDmheKw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10898.eurprd04.prod.outlook.com (2603:10a6:150:214::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Mon, 4 Nov
 2024 12:39:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 12:39:20 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Viorel Suman <viorel.suman@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan
 <ranjani.vaidyanathan@nxp.com>
Subject: RE: [PATCH 00/17] (no cover subject)
Thread-Topic: [PATCH 00/17] (no cover subject)
Thread-Index: AQHbH5urN4RhovOdqEOIzMmfBLzS7rKnFviAgAARKxCAAANGgIAAAFsA
Date: Mon, 4 Nov 2024 12:39:19 +0000
Message-ID: <PAXPR04MB8459F3E50519ABEED5C806C688512@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
 <ee6519d5-30cc-485c-b87e-89665066a827@denx.de>
 <PAXPR04MB8459B83D68F7365C5C0B5C2A88512@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <77ef2f17-66b7-4f5c-ab99-4b15f5c1a84d@denx.de>
In-Reply-To: <77ef2f17-66b7-4f5c-ab99-4b15f5c1a84d@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB10898:EE_
x-ms-office365-filtering-correlation-id: f837283c-48b4-4756-65f1-08dcfccdb421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eVNtblJuQVJYSWJNWnBvM3o3Yno2emdoU2xQcFpnS3hSdm14SEsrbEE3Q3JX?=
 =?utf-8?B?aHNCR1lncG0xRjRuYnoxckM4Wkk0VmR0cllDdEdjZHYrZWh0R3JQcml0YVV2?=
 =?utf-8?B?UUVFZUxJQ2hEMGlSQTRQT2pTQTVtRFdDejcxaGNOQWVhYXFXd2pHR3N0UUt6?=
 =?utf-8?B?RnBnb3JrTThQQXR1MEdRbU9Uc1RXcFY3b2tKTUVDN25VNlZ2U3ZLRnRadFh2?=
 =?utf-8?B?WVNQekVGNmJ1cUFERUtHT2YxNURMSnhUT3d6c3NvLytjNkd2d3NFZGRKNG1V?=
 =?utf-8?B?cVQrRXUrbDJWRndDRmZYQWxHV292VkNqVzdSemZPSXV5RlRmTmFzS1B6WVNm?=
 =?utf-8?B?QkI1RThvSnNJR1RXN0oxdHZnVjZvK1M1R21BLzQzSDdHV1l4aWJocVZtNVJz?=
 =?utf-8?B?bXlOMWdjbythcUFYZFdjR3Z3QWJEdXRSQWhvYmZtcnFEa1ZkZm82b3VJb292?=
 =?utf-8?B?Y2tOeDAySDIwWlNVM1hnWmxiTGVkd05Vc0FwM3JKMUxNbUFPUU5DZWxXNnVo?=
 =?utf-8?B?dEFlaWR3c3Vxdnd0SWUrQWE2bWswWGpwUjFoVm1OclJVMUhxdW9ibGJWbVlU?=
 =?utf-8?B?WWtGeERxVSt0cXd4WllHZVNLSDhVYzNVYzFkYlkxZzcvSEVQaFovWFQvUUFr?=
 =?utf-8?B?SFVSS2RvSjBXbDRDdzlYQXQ5akdjTUtVUUxOdWFHK2FVbDVGaTVZZkgyeVV2?=
 =?utf-8?B?Y1ZRMDVOazd5VGNJb1NFdmFpTEFxWDJOK0RoSWs5OENnMUI2NHJhSnhPbHhM?=
 =?utf-8?B?ZkRzb1pZM1BhN3FsQUpROEREdHM1Z3hiZ1p5c1RWdHZxOHk1L0p2SDlJOHNq?=
 =?utf-8?B?cnI0WXRGNlY4MmM4RmN2V3VFWWRtQUh4V1NVS245K3ZNSW9Ia2czNHJ1RVdq?=
 =?utf-8?B?bGxscUxkVE9QVGZKWVd1eDgvRkV3ckhpYW9OQmExUDdFemRMaFNCSlkzVytq?=
 =?utf-8?B?Z05PVHFRQXFhVGlrakM2WUM0Z2hlRFF5eEhEVzNMTVF3cHlDd3dKMWxRWlJK?=
 =?utf-8?B?bUI3ZnA5VXZ5bmhxQVltU3Z2SVJXRy80S1VhcFVSS2hyVFBQNEVJbGNSVXh6?=
 =?utf-8?B?V3ZCdUVlTmJEYllNRHJwejgyZThLNEkycVI1U0U0Wm1iWXFFTiszZTM5M3RF?=
 =?utf-8?B?ZnF6Rjc1R0t5VzJCWTBrZno5Tm9FSWFCdXp2TEZ2MnRSZ3hlQ3RvSHh3Zmd2?=
 =?utf-8?B?djY1M0lmVUh2S3o5Q24wRlR4cWNHdDRrSWtJM3BubHZucWlNanVveGxIcnFw?=
 =?utf-8?B?eExUMURyVmdVWEJDZ2VrR3I4Wm9uVk1ZMys2V1MyamNjbkJqdVE0NmZZdHZG?=
 =?utf-8?B?K1RaREp6eWxBbkpiMzFuUXJSRzZQOVY2ZnMrQUN3OVV2WjREd1NrRG5UOHR5?=
 =?utf-8?B?dXFreWRjbDJRS2poNzRGclNUWkxUNldvYVU0MkRwcnJFUG1jeVF6UG9MZmNJ?=
 =?utf-8?B?TWZpa3pFK0lNTmJwd1AyczBhTnFKcWJFbVZ3cnVaMHRNOThKRGdzd0YvdXJq?=
 =?utf-8?B?Ky9jcGNqSU9XOURkbG8yREtMUzNDVWdRZWRzRXdiY2EvbXIxdjhZc3IxWTJv?=
 =?utf-8?B?VnJVMFU1SWQvNVJvOFBCWVNKbkZ0VklnWk56R1l1dkluZFBneWR1S1NKNGxv?=
 =?utf-8?B?QnVJODlmdHNoZUx0ZnRycEdqeGRDSmkyN21KcE94QytaWnBYaC8vS0VjZHpo?=
 =?utf-8?B?T25nOEZ4YXBIR0cxUWQyd0dOV3Z1ZjR3TzJQblo5alJ1N25oSnNJcHNHeXhW?=
 =?utf-8?B?YlltdnI3OG82d3oyY1JNbVJDSzA2YXU1QmswRkRwTHhxNlZMNTFFZkp3Z3lQ?=
 =?utf-8?Q?Mjkn9B2K7exQqALdsGU2tppH923l4uh6G1zLU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTRUUmNBSWVaZHVTckNuL3FkL2haK2dKUU9kYUtDOVVsbGdYVzBHb2lnOS94?=
 =?utf-8?B?czNCUExiRFkyd3NxbktyQkp4eVZLRHh4aDAxSTlHZVVYeENldUVhQ3hFZlFT?=
 =?utf-8?B?WWtBdElNWFpvK1NiTDZIR0JkTmhMRXh5YmlCZ2pvYXRrTVg5cmJXOHNSc3lW?=
 =?utf-8?B?K0oyVzBVTnhrRmRzQkxQOFF6NVJYT3Z5NFVndWhYTGNMYzFTckdlZ1Y5VjNV?=
 =?utf-8?B?bmhXajV5ajJabjY2SWhnRmI0THpBOExoOEtKcXJ4ZE5DM2FEOFBpZXM1cTJy?=
 =?utf-8?B?djJnQjFzY1RXNWZJZENyb0FodVp4TlUxTGtCdDRBdDNEQzR6d0VrQzNCdFND?=
 =?utf-8?B?aWg3dGZJTXI0MnBhVGJNYnl3bzdmTlZ3RmJaNFNpWXFZeGpzNFBEOUhZWGVF?=
 =?utf-8?B?Y3VFYStwWk1Ja3crK1R0QXZPb0ptcDdxMEFJTzE1Z3VFdWQrdG8zbEQyR1Nl?=
 =?utf-8?B?cnNDeU8vN2VFZkF3NUlXL1F6RElvVGF2M0dqaHpaZms3SGxZZ1lwczV6eDNF?=
 =?utf-8?B?N2N6MWc4NUwxU0tYaVhNaGxLQmZCcG52SUNDenRVRGQrdzM0WVNhUWNFakxO?=
 =?utf-8?B?WTFVQko2dUNvSk9kWWp2N25sZkg1ZkhtbUpWQmU4MmVqT0hKVUJ3QjNMQS9p?=
 =?utf-8?B?M0p6NWE1RHJPU0R1dkx4Mm42a3RhMzJkazJ0RzNQL3BoVitvWU9zZ1BOcCtK?=
 =?utf-8?B?RVpmZzhYcjRhYzdHUGNCVURrMmFOWEk0RjNQdTlwTVZJYnFFU0dxa1BKb1pW?=
 =?utf-8?B?RlBlTWloSkIvQnlvaG1Ka2krV1NSSkpSQmgwcEplTWFhNE5KenRFSnpLYi80?=
 =?utf-8?B?MG1YUDh5Rml0MXV5WThZSUk3OFlmekQ5dGpxRmhWNnpCbHRXOHZ2OTRtZzVR?=
 =?utf-8?B?T1lENGFxNDd0SFhDQ1dVQ3g4bWVvSHVoRXdUWDZaYjYxZStBOHptQThmQ0N2?=
 =?utf-8?B?Wjg3eTZoL2d0V1hmeElWZFoxT3BlcW92NVNRUFlLby9HczZjZk5tbjFVbkFy?=
 =?utf-8?B?Zk9ibkR0ZVBSTFZFaHhONFpMRjNkN200eUx5Vm9XVkMxbVF2NHRhSThGZ2lm?=
 =?utf-8?B?Q2hYdDdOY2M3UUpLVWtCanM4cTFJQmd2d2I5VDRXVE5zOHo3UUdPRmhZK0N1?=
 =?utf-8?B?aVBGSlc1Wk1wUWtoMHM0UkU2bjVMc0lraFJIQTBvakJXVzlLMnlIY0IyWFFm?=
 =?utf-8?B?cEtHcVpWUXI5eUJDdEY5cVFtL200cXZBbTdaM0t4eE5JdnB3Y1lQTXE5dzJl?=
 =?utf-8?B?dSszYkR4TkRzVFRVelF3d1FmNTZvYlhWVlBPb1VUeDRhdnZHb0hhd0VCQlIy?=
 =?utf-8?B?dmdYS3dxMWRYT1RXYkVXY2x4UFZuNlB1VlM3cUdHa2djMS9USStxMHdPNWEx?=
 =?utf-8?B?b3AwWXgvQWJaNk9tejEwU2h4ZmMyNzJqcGQ5U3RNTUxxY2JzR0M2L05tREpF?=
 =?utf-8?B?ZDZwSjFiT1JsMEN5OUhaQ0NqaXR2Z01xd0MxZGVZUllUQ2NOTTNZclFrYUhU?=
 =?utf-8?B?Snh0dkF2M3lwc0RCQkplMG1DdUN5ZmNtWU1jZnhiU0pUOWswaWFSSEZPcm5a?=
 =?utf-8?B?R0dtKzBubHpuc21WMDUzSTgwakgrckFXcUUwM2JDcFFYb2s2QjQxbkZ1aVpK?=
 =?utf-8?B?NTVUUHBFU0tVVzVTOVZiQXcwZkNuMzBROFUxcEczMjl6MHFnVnlHcTNFZ051?=
 =?utf-8?B?Mmw2UWdxMUZaSGFRdnB1VitZR0FXQlU4eEQ5S212RWQ5RnVhTi9sR25ESytC?=
 =?utf-8?B?cThQL0FCSnFWUG1hQmFUUE4veUEramdWeVRaOXk5aklScGpDZGNFb3MvSXgz?=
 =?utf-8?B?b3VkV1dqSTFjaGFaVHJkOXVaM2dpOU9Fd3J5ZEdCWVBvQWJoSWh6MWsrRGVQ?=
 =?utf-8?B?eUNDRjR5Ni8ybXZWTmpNMDkzU25DSFNBQjY2bWZKK0VIT1h4bzJ0RGg2ekll?=
 =?utf-8?B?aGZVQVdtYmY5M0t2akNMdWVFc1RGZDdKakhwN2hoOHYrNVlvS0JUQ294aWxX?=
 =?utf-8?B?NmZlblFxUEhVN2E4Y01ud3FPNlNIN1p3dXhmbWxwMUV5OTNiNmE3MWFGc2tG?=
 =?utf-8?B?Smo3WVZNUlFjdlVlQXVEaVhDdmErSmxJNnFHZE45U0xua09zOEJ5TXorVzAz?=
 =?utf-8?Q?BtLk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f837283c-48b4-4756-65f1-08dcfccdb421
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 12:39:20.0063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LgGR7ezGn37yvse5vRTqUUxSvXG+O9Ll+eyZmPrBAQMMhqp0C5qYY0VyLxTLdsyyc5wMRT46SeSJMFluhOZ4AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10898
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzE3XSAobm8gY292ZXIgc3ViamVjdCkNCj4gDQo+IE9u
IDExLzQvMjQgMToyMCBQTSwgUGVuZyBGYW4gd3JvdGU6DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMDAvMTddIChubyBjb3ZlciBzdWJqZWN0KQ0KPiA+Pg0KPiA+PiBPbiAxMC8xNi8yNCA5OjE3
IEFNLCBBbGljZSBHdW8gd3JvdGU6DQo+ID4+PiBUaGlzIHBhdGNoIHNldCBhZGRzIHRoZSBiYXNp
YyBzdXBwb3J0IG9mIGkuTVg5NSBhbmQgaGFzIGJlZW4NCj4gdGVzdGVkDQo+ID4+IG9uDQo+ID4+
PiBpLk1YOTUgMTl4MTkgRVZLLg0KPiA+PiBJIGhhdmUgYSBzb21ld2hhdCBtb3JlIGdlbmVyaWMg
cXVlc3Rpb24gLS0gY2FuIHdlIHN0YXJ0IFUtQm9vdCBTUEwNCj4gPj4gYW5kIFUtQm9vdCBmaXJz
dCwgYW5kIHN0YXJ0IHRoZSBFTEUvT3BUZWUvLi4uIHdoYXRldmVyIGZpcm13YXJlcw0KPiA+PiBB
RlRFUiBVLUJvb3QgaGFzIHN0YXJ0ZWQsIHNvIHRoZXkgY2FuIGJlIHVwZGF0ZWQganVzdCBsaWtl
IHRoZQ0KPiBrZXJuZWwNCj4gPj4gY2FuIGJlIHVwZGF0ZWQgPw0KPiA+DQo+ID4gRUxFIEZpcm13
YXJlIHBhY2tlZCBpbiBmbGFzaC5iaW4gaXMgdXNlZCBieSBST00sIG91dCBvZiBjb250cm9sIG9m
DQo+ID4gU1BML1UtQm9vdC4NCj4gDQo+IFVzZWQgYnkgUk9NIGhvdyA/IERldGFpbHMgcGxlYXNl
ID8NCg0KRUxFIEZpcm13YXJlIGlzIGZvciBzZWN1cmUgZW5jbGF2ZSB1c2FnZS4gOFVMUC85MyBh
bHNvIGhhcyBpdC4NCkkgY291bGQgbm90IHNoYXJlIG1vcmUgZGV0YWlscy4NCg0KPiANCj4gPiBP
UC1UZWUgaXMgb3B0aW9uYWwsIGJ1dCBpZiBpdCBpcyB0aGVyZSwgaXQgY291bGQgb25seSBiZSBs
b2FkZWQgYnkgU1BMDQo+ID4gYW5kIGtpY2tlZCBieSBBVEYNCj4gV2h5ID8gVS1Cb290IHJ1bm5p
bmcgaW4gRUwzIGNhbiBzdGFydCBPcFRlZSBPUywgc28gd2hhdCBpcyB0aGUNCj4gcHJvYmxlbSA/
DQoNCkFoLiBBcyB3ZSBrbm93IHRoZXJlIGlzIGEgd3JhcHBlciBpbiBBVEYgY29udHJvbGxlZCB3
aXRoIHNwZF9vcHRlZS4NClRlY2huaWNhbGx5IGxldCB1Ym9vdCBpbiBFTDMgdG8ga2ljayBvcHRl
ZSBpcyBmZWFzaWJsZSwgYnV0IEkgYW0gbm90DQpzdXJlIHBlb3BsZSB3b3VsZCBkbyB0aGlzLg0K
DQpSZWdhcmRzLA0KUGVuZy4NCg==
