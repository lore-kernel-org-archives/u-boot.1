Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AEAD5CC99
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 09:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C189B892FF;
	Fri,  1 Nov 2024 10:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ob/oL74o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0060892F4; Fri,  1 Nov 2024 10:43:26 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7CC1892FD
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 10:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ou+PjCorV5T67Oi3EXlnJxPzlXGR0jO9p5onW9BeeD+PCGJKM0y7T3/QKB325m6MgFA9lrjb2oOtLXEAzOUJq1zQECn8Xi2ACsFsGBFzcpbjlgdHsuUAGwzPj1MfuJYKsLK1plbq3gu4jNRZeS31sb9z6y71YW3AWlLR1ozXvxutRpiAEUZeUG5MR0wqRUFCfJdrYttkL7iXNyYa2KMklWpBlA0UbxsUROAAv+9gm9ry+JOXDbtJs7Oy19hdoTfYyzVZcU/936N1Y6sZBWKBChIoOuLQx9h7bIff50vN/sx/Z4wHOgQtbyUL/O7ynhD3Km0m4CIQxXrKp+BdKV63Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kd3qJoRjQj1kbwjV4/xVI+OvWN+MjVqVBdC6d23E+xY=;
 b=nnjYAAoeNklT0QUvrlCV/bqY7WTYY1Gc0Snwmbqh1Sx2U3Hb0n/mbDTneJOzJ7/XQ8KnhE6mUjOQzhF43eUezLk8eS1F2k6Vq/PfKI/JZ3aB+JcOzq3omGZwXDlkE3PHQDmKHTCe10n4eFPI0PGPWdRt7oQErvDyixhf+hAkNvfGOlvxE1Et9+lv4NoE76MCSc0ArR8ckDFnCAPd2xKMwjMniDy6Wpi3ogxBRJtue8OpBn+KEr9ugmlBcedcviIQb09dM3jYzcPQB2nm98ql1Wdh/5xPm0dEc3Sa6NFmJiMM4kyNTh1nQwbrgWHEpWtjeIQh1KJM792jmr/LU87PlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kd3qJoRjQj1kbwjV4/xVI+OvWN+MjVqVBdC6d23E+xY=;
 b=Ob/oL74oZdXo3y7vIm27/3rgki3CPrWB2Pas1Xe3CM+psnWsyo0n2VO51ZYWbUccSu49t31eA0F85C8AIFZAWU1Z74N9yJjlkHPYQvIjUI8jKuYicznSuacTeBnju/Zcwet9ZfmFy5Oy20yJbzHeRmbCgDBgaO7igY+8fjbAA1Sw42UNdoCyQtTt03pHFYpXqCjLXFa3tHWMb71Y1iYbUw5LcnwCytYRntjNMAi2iktmvlbSj/HfUfDEjcpQ7iyVhvshjb1u643riuvCAKFq/WQULtwWQJl6EQlRkz4lSwENPMOF3q+uaXH4qSwOs0DQfW5vFIjDoWLZQbdCKYqd2A==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI2PR04MB11073.eurprd04.prod.outlook.com (2603:10a6:800:26e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Fri, 1 Nov
 2024 09:43:15 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 09:43:14 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, Marek Vasut
 <marex@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIDE0LzE3XSBpbXg5NV9ldms6IGFk?=
 =?utf-8?Q?d_i.MX95_19x19_EVK_board_basic_support?=
Thread-Topic: [EXT] Re: [PATCH 14/17] imx95_evk: add i.MX95 19x19 EVK board
 basic support
Thread-Index: AQHbH5vK3iyvO4d79USIYwx6Q3HEjLKJP/wAgBkD6eA=
Date: Fri, 1 Nov 2024 09:43:14 +0000
Message-ID: <PAXPR04MB964465837D7E1BB2D85FFED7E2562@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
 <20241016-imx95-v1-14-f640c8f3bc1b@oss.nxp.com>
 <CAOMZO5DY7LeLvp33cnocTuW4UgA7tnmJdeUX1e3Y6wqusahBDQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DY7LeLvp33cnocTuW4UgA7tnmJdeUX1e3Y6wqusahBDQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|VI2PR04MB11073:EE_
x-ms-office365-filtering-correlation-id: 417e77e2-bb46-4b94-edba-08dcfa599b5f
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N0g2S3Zzb3FKR00rcWVyVU44N3REVGl0d0hFNVBUMWJJWkx2M2h4ZXg2RlFB?=
 =?utf-8?B?Q3lQcHRlR1ozKzdrREdRVmJnMUtUaGtDOTErc00vN2pDNE9mOVJ2NkRja0xJ?=
 =?utf-8?B?cEU5bWZSbGR5dXR1MVpqWEZvYVJHNkVwYTRhMWdlQUQ2c05SeUJON2xzNnpL?=
 =?utf-8?B?VzlPVE9aQnl0K0NTanJxSUloT3FJeXBhckV0YndJS2FITkVHRnpnODA4ZFpW?=
 =?utf-8?B?eGFTTWNYT3NIQ0dZWU5hTVJQbzJDblh5bjBEbWVCSmNDM0VKQ2NNLzgxbUJj?=
 =?utf-8?B?ZTBiaytqZWFrK0YxS2JmcmJjN0RlVWsyc2N3Zm9tRlVLL0ZOTk1LRk5PeENE?=
 =?utf-8?B?WTAzdXdyRGtuQWJFSlRVWjViOFE5a2QrWU93UnVaQUsyREJ3dFV0MHFra0FH?=
 =?utf-8?B?T3JnaXdqbGtxSWVZVGJZRUtKYmFsRUV3UHN0dXhRMzF3dERBVWJJYzJ2WjhT?=
 =?utf-8?B?T3h1RkFXZ1JrNmFxbnVRNU5saFZYY0xrQVYzRzJKeEFsSkVYNnpqa2s4ZU81?=
 =?utf-8?B?M2pBakVkQ3BZWDc2anVKcTNPU2VKME1wYnZvNVc2OHN1d1owR1BvZk5aRGpL?=
 =?utf-8?B?L1hiVmJ3K2NhTVIwek0vVDJtVkxBY1VHKzVVeDkrYmllQytMUEJPaWVpbVY0?=
 =?utf-8?B?MUsyVkRCMUZjY2FYb1Q3enRMTTcvMkE3dkk1aTBTc2ZRd3pIZVlrNkwyeWRX?=
 =?utf-8?B?MmRYa2dsWTl3WHprbnlOZnlFWGYwRGZaL0NXNFNzQ0ZLcHlpYm9uZXY0Rk4r?=
 =?utf-8?B?QktUWnVkOTNsQzBaNWZ3aVFjeFR1QUJ6cW5xaTJrZnhsWFFoa3ovWjNLU3Qy?=
 =?utf-8?B?ZFFEUnEyNC9PL3N2anhxL1NIc3VQd284N2JtQmd0dEw4amJHQXBObkVaK0Rh?=
 =?utf-8?B?a09uSGU3TVJFR3Q5QW85UVp5S3Zla09tMWthTks2UjZwd1pYdWF3V280NGpG?=
 =?utf-8?B?cDQyNTZmY3ZWSWxoQmsxd2ZiYmhwaFEvcWFhZEVHOHc1UXdsNG1iUHdyOWc1?=
 =?utf-8?B?R2ViRzZ1dXZ1UzBUMEJDOEhkS1NLNHFXYWhqQ2E2U0pZWlB1SWhrbHZmRjlR?=
 =?utf-8?B?SlR4ZmRzeDB5ck1VNExwc2ZUVEV3Ky94bUNMWEVBOWQ0aXpnUlhQQWxISHJ0?=
 =?utf-8?B?OFZiMHlnWDY1NXRCYnFQaHlFMWQxSEZpMjZMR2NQdmdYdVZxMExKbmNLZnBL?=
 =?utf-8?B?NHJQaEFaVWcvcmVMeTVsTHFrRGNUNm9kN3hRamkyL0hIakhJLzhFSmJLRXhr?=
 =?utf-8?B?VjhyQXQxV2EyQzRydzV6MkcwM01zdlYyN1JiaGJMNFZBeE5KMjBCcmJTbkND?=
 =?utf-8?B?ajRBM0lGRmNoM2V3dC9XS1dRRDN1YjgwVmxYcjVJQWNZcUh5UkorTmU2NCt2?=
 =?utf-8?B?c0lYdDR2SWs1Q3djM2YyZGNnZjAxaGh3ZUN6SGtVc0dKTWczVlJaejVic01I?=
 =?utf-8?B?elB4QWtqeW5pZjVFR29EaTdxWGEveXhZRXZQcXJ0R2FWWDY3RTFEQTE4RWRO?=
 =?utf-8?B?ZFhydXpZMzJmdHU1ZzVpQTE5RUdGZzJCRDhvVml6V011Y2R0bWVlWksveGFW?=
 =?utf-8?B?Z0p2RGlQVUd5R1F3eDVRL3JONW1sSzg5V01maXZkRHdIOExWWmJmSmtWN1JE?=
 =?utf-8?B?MkFwQkF2VXF2dVdZdWl3d1d1dzFJV2xjb3oxOFlrZmJXdldhK1JUa3M0S0hX?=
 =?utf-8?B?ZzBCamJUYWZpdDFIU0ZLTmxxZnZDVUswZDdwRFEvcVZOU0h1QVN2eTBITmNC?=
 =?utf-8?B?TkFLSDlPWkVEV252OUU1T1E5U1dXWFpyYWhrNFdtTGVnK3FMaXhWMFNJRE9h?=
 =?utf-8?Q?W8aHVajuLPN/YxR94DgFVSzOAoDrT/AC0DL9c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3pmWVZ3T2phWXh2L2tvZG5KMHVsNFYvbURaWUxZaDYraGl1eHpjOGZ3UHUv?=
 =?utf-8?B?QTNzank0VEtJeEc3RUMySEhtMFAyRXdGNmkxeHVnOWtuUFB5WFlUVnJ5OXBm?=
 =?utf-8?B?aDJiOUJmL0FkM2FSVi9OWGw0SEkzc0tDQVYvSzNjN3BxZ3ZxZHZRaHBYYVRr?=
 =?utf-8?B?NlFxdXdVSDg4TDJSbjNCb0JnNm9lSzRsakYxZHdBanc2MWxmeXlJNWJyMFFI?=
 =?utf-8?B?YW5CRlpDMXd0dk1TbWMwaVVLUUtMNEMvWEo5dE9NWS9vMTFlandzOU4zWWpX?=
 =?utf-8?B?NVlVejFrRUgwK0xkMTJMczFtU1JGODI5amZTMjdkNGZmbWF4VjUyM2ZXRzhm?=
 =?utf-8?B?SENRUnVMYldSS1NwM05vZ3kvUUFJWnNFN0pHSjBFNENGNW5SNld0LzVRd0ZW?=
 =?utf-8?B?bzRsTXdRQmsrcHJ1bHlFb2lGZ2lrQmREREVHRzNxWnk3cW5VZ1dNNWFDdHVp?=
 =?utf-8?B?eHQrY0dwaERyenQyNTlBY0ZIWjgvSndBK1ZNZmkrcU9LUDVDeTBqUEJwL2x2?=
 =?utf-8?B?eTFvSDMvaW4rcmZhek9CR1RiMlpJbmIyRG56T2p2OXVpOWZzRDV5VWQzZE1V?=
 =?utf-8?B?R25XSFZURkZnUFRKSnFla0EweXJhc0ZiZTlTc2c1ZVlRS0tUQ1RHS2lUckJJ?=
 =?utf-8?B?aTdxNEJBOVBNRlM4eXRQZVlaS0JaVGhjT2U2bW9ZQTM5SEY2WFJZR20xRVkw?=
 =?utf-8?B?WFlva2NPK1h1WDlpK2V4NlluNmRIZlNHM1V4cTc2bEg2SGhGeFY5S1ZQV1VX?=
 =?utf-8?B?ZzdsWHBhZlVSRTM2bmhYNElwODF6dytURXc1SGhLYnBWMHBXUUg4d2VRZWhP?=
 =?utf-8?B?K2w1Q2pyVUw0YmRrd2xKcjRhVlZPaWZqd1E1cENZRXNIV2ZWclE4SFg3TDdW?=
 =?utf-8?B?aWkrOHd2dWF0akkxQW1qbTBiS0ViVnVaSEMxWFZQakZMZDlZbHhBM3hMeWN4?=
 =?utf-8?B?aThkc2N4bVBPWmNEaDFzS2VSbk9heTVOV1ZOMk4vM01YN0hDTEFIaERxU0RQ?=
 =?utf-8?B?NTlsQzlaVzk1eVAyc0tjbEpFK2F0Tk9TRFBMYUpJUTRlWjJlUmo0MHU0MCtX?=
 =?utf-8?B?WkpnNlZHNkhSSjVrY1Uza1hnM0VUeDVZdUhxdmZ3ZlZrQTZPYjFERzMweUUx?=
 =?utf-8?B?YWtyUUxwZU5QanlhdForYTgrWllTckJqUWNKOTJ0cnVDSlR0S1M3Nm9VcTUw?=
 =?utf-8?B?U2VCSkptemlSUjhBSzZOb3ZQdm45cWFlVjZOUVdxek1OZS85aHVldGxtVUZi?=
 =?utf-8?B?VElOeUo0VGh2cEdJdCs2OUl4RUdXVzRQZEdlZTBGRUxJTzl6aEVaVHB6MUJP?=
 =?utf-8?B?Z2FZMlFXTzN6N0N3dERDcld2RFl0Q3c0U1ptRjd2a0Y0UmsxczNiQ1ozR3ZJ?=
 =?utf-8?B?NGxuVHFMYlNXTmlPMjkyRlF6RjIxVlJVcEdYemdCUGJ0TEVrZSs4amE0MHpH?=
 =?utf-8?B?WlNGUnRGbXRJVDFHakRRUlZwTWhxYlpKMVlNWmxVRjFLNTQ1V0NnRFZ1cTJx?=
 =?utf-8?B?TE5MOExGdFMvdCtCeVkza0hHSTBRU3pTRUhEVmxzM283Qk01aHMyMDgvcVcw?=
 =?utf-8?B?RFA2Wnl0NnpOVGhWNUxGWHllUG9XNElsREwweUtvTzR2dzNWcVRtSWxhZXpC?=
 =?utf-8?B?UDFkWmVzZk1lL00rcEJTbWk4TXI1TGZzeGlyNWNJbGNXZ2puRUdqdmZmQXR0?=
 =?utf-8?B?ZXl5K01ycTNqM1BZb01OUzY0ZXh2NHJmUXBpUklDNlZEcS9jck5LMnZjRHdu?=
 =?utf-8?B?c3Nhd3RHRHFwZjc3UG9TdzY3N1FPUE4yTE5VL2tPWGw5OERKQnpveDZpVG5W?=
 =?utf-8?B?djMwczVlOG82MTVnSUk0YTI4Nm1ham12YTVHTW1sRTZWTHE4YzFiSlp1Vk1X?=
 =?utf-8?B?a29qb0djb0pGZDRMWEoxb0s4dzFGUndCUWthTWpiMDBXRmUvb0JFdzl1R2FF?=
 =?utf-8?B?UjdMOHRBZWxyQmRMNkJ2RmNFOEcvZ1RvUTQwZmtjS2syaGtpN1hnM0pYdXNa?=
 =?utf-8?B?aEJQeHB0NWErOXhEUnMvNkhUZVIvSCttWENMRUFTSmJwSVBlVDVrS01uQmpJ?=
 =?utf-8?B?c1NTaVdJRVdHRHhjcHBXeEhuSnFLelc2V05XdnpYbDl5ZjBjbmI5V0sxRlZY?=
 =?utf-8?Q?NVNc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417e77e2-bb46-4b94-edba-08dcfa599b5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 09:43:14.5542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4B56U3mAuAIFa6cn9OFPIAF7YHNs34zxRkgASPKsNcDUbciQ+WXIc6yl4TMbPJdjLRRViuQJ6iRVoFvaPvXcyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11073
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

SGkgRmFiaW8sDQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEZhYmlv
IEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI05bm0MTDm
nIgxNuaXpSAxOTozNg0KPiDmlLbku7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9z
cy5ueHAuY29tPg0KPiDmioTpgIE6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBMdWth
c3ogTWFqZXdza2kgPGx1a21hQGRlbnguZGU+Ow0KPiBTZWFuIEFuZGVyc29uIDxzZWFuZ2EyQGdt
YWlsLmNvbT47IFN0ZWZhbm8gQmFiaWMgPHNiYWJpY0BkZW54LmRlPjsNCj4gTWFyZWsgVmFzdXQg
PG1hcmV4QGRlbnguZGU+OyBkbC11Ym9vdC1pbXggPHVib290LWlteEBueHAuY29tPjsNCj4gdS1i
b290QGxpc3RzLmRlbnguZGU7IFllIExpIDx5ZS5saUBueHAuY29tPjsgQWxpY2UgR3VvIDxhbGlj
ZS5ndW9AbnhwLmNvbT47DQo+IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiDkuLvpopg6
IFtFWFRdIFJlOiBbUEFUQ0ggMTQvMTddIGlteDk1X2V2azogYWRkIGkuTVg5NSAxOXgxOSBFVksg
Ym9hcmQgYmFzaWMNCj4gc3VwcG9ydA0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5h
bCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5p
bmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0
aGUgJ1JlcG9ydCB0aGlzDQo+IGVtYWlsJyBidXR0b24NCj4gDQo+IA0KPiBIaSBBbGljZSwNCj4g
DQo+IE9uIFdlZCwgT2N0IDE2LCAyMDI0IGF0IDQ6MTnigK9BTSBBbGljZSBHdW8gPGFsaWNlLmd1
b0Bvc3MubnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBZZSBMaSA8eWUubGlAbnhwLmNv
bT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBpLk1YOTUgMTl4MTkgRVZLIGJvYXJkIGJhc2lj
IHN1cHBvcnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZZSBMaSA8eWUubGlAbnhwLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+IFJl
dmlld2VkLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gDQo+IEEgTUFJTlRBSU5F
UlMgZmlsZSBpcyBtaXNzaW5nLiBDSSBmbGFncyB0aGlzIGFzIGFuIGVycm9yLg0KPiANCj4gUGxl
YXNlIG1ha2Ugc3VyZSB0byBydW4gdGhlIHNlcmllcyB0aHJvdWdoIENJIGJlZm9yZSBwb3N0aW5n
IHYyLg0KPiANCj4gQSBnZW5lcmFsIHF1ZXN0aW9uOiBob3cgaXMgdGhlIGZsYXNoLmJpbiBnZW5l
cmF0ZWQ/DQo+IA0KPiBJIGRvbid0IHNlZSBiaW5tYW4gc3VwcG9ydCBoZXJlLiBXaHk/DQo+IA0K
PiBXZSBhbHNvIG5lZWQgYSBkb2MvYm9hcmQvbnhwL2lteDk1X2V2ay5ydHMgZmlsZSB0aGF0IGV4
cGxhaW5zIGhvdyB0byBidWlsZCBhbmQNCj4gYm9vdCB0aGUgYm9hcmQsIHRoZSBmaXJtd2FyZSBm
aWxlcyBpdCBuZWVkcywgZXRjLg0KPiANCg0KV2Ugd2lsbCBoYXZlIG5ldyByZXZpc2lvbiBzaWxp
Y29uIHRoYXQgbm90IGNvbXBhdGlibGUgd2l0aCBjdXJyZW50IHNpbGljb24gY29udGFpbmVyIGZv
cm1hdC4gVGhlIGN1cnJlbnQgdmVyc2lvbiB3aWxsIG5vdCBnb2VzIGludG8gbWFzcyBwcm9kdWN0
aW9uLCBzbyBJIHByZWZlciB0byBkZWZlciB0aGUgYmlubWFuIHdvcmsgd2hlbiBuZXcgcmV2aXNp
b24gc2lsaWNvbiBhcnJpdmVzLiBXaXRoIGN1cnJlbnQgcGF0Y2hzZXQsIEkgY291bGQgYWRkIGRv
YyB0byB1c2UgaW14LW1raW1hZ2UgdG8gcGFjayBpbWFnZXMuIFdpdGggbmV3IHJldmlzaW9uIHNp
bGljb25zIHJlYWR5LCB3ZSBjb3VsZCBzd2l0Y2ggdG8gYmlubWFuIGFuZCB1cGRhdGUgZG9jIHRo
ZW4uIElzIHRoaXMgb2sgZm9yIHlvdXI/DQoNCkJlc3QgUmVnYXJkcywNCkFsaWNlIEd1bw0K
