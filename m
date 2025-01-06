Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7318E77197
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 01:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A186803DC;
	Mon,  6 Jan 2025 02:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="CI/+4Z3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 377ED8056D; Mon,  6 Jan 2025 02:14:16 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE4D9801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 02:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAeSTn+nkh6c1orZKh/viGfawxaNPXLLumumdYrjHN6bvaRtFH6zooZGZ0mvBuKADzqFV31tE3iGzrGmWlhQ+LpwE5BEeSJjcAuTrhjbuCI6ME/xy/6dy0pYW3gXjzztPJ4FSCSvyI3AXch4sqyq+XmYkMcu0ULMQmHQp1AX99kHf9wFoC5rLqUs+qiwUkthhJyf9m6t330lzo9mAXUqnpZLnXvNUmwp+04l8nc0cQyBuZVGP7QQvRi7im93vUg3BbId2LvTOYUxNajCxy4MYbaPsQNRtHy8hOTNdL4Kg5P1xcgJdwwMGsSp/p21LR2/a8jeT+zrmwQiN0wo4LjIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ep64VONUykjpVo7ddXxl6DRbMfVn8UpQZgjhwYKJec=;
 b=bJiXPn/JEqQLVptbGdDaf3lTXPhxQrTtkl/2vKVOzDEcXouDPpbijzOI8nHQ6WdzDTWyCJ1Pxm2WSFkbotp+J89SHQLSGTFAiWvboZUijEnivfvdJFhI+Ot7bcGf4d7SKhx1aJm19f4oSiTDjGsr4VPZqTHzI4tcckmh3815er6pJxyY/OWFOqvg4+Atklgb9oK+ofRWO5BAxYhp2PbytyH5LJmZlZ5aMJGFcciz6sGxq48ktCV3YGENedGgM7IhYWkD2/a8TGtPunaveGYlleUrWnc7op6SAhQNEF+XcWUm94LOkdbl/lWbmaseGqqC/4htbFZoSRO9MG4ccLYUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ep64VONUykjpVo7ddXxl6DRbMfVn8UpQZgjhwYKJec=;
 b=CI/+4Z3R925c6lPSRczUv3GHEJUlPJmJcU9sg0Ypup1MDOQBN1XL17knVIFMVAMF9WtFhm7Ndmfmo39fJS31tzjSgZjScMnLnyj5Q+PFnH04wVcciOHSkEO2xWGBrNQcgpdUuialFuvexsyyoztEZ7kKsG0C0ggn7niOvMt+eRth3Xj2zz545faUCk4CpJHi5BlOWUi5nBXS1H/hd4aGzAg9oKnzbg/7rBCJfSAQw+vCm5UwlBsHZHk2D2omisd/mzV/gFtQ9olGc+BVjamc+9QKBg+n75yIh3LKpnCjwOS1hTvfKYl6KerPOKSUNH82W/wPouuqYhh+50LYtIPH4Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10791.eurprd04.prod.outlook.com (2603:10a6:10:580::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 01:14:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 01:14:07 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Simon Glass <sjg@chromium.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1 EVK/QSB and
 i.MX8M EVK
Thread-Topic: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1 EVK/QSB and
 i.MX8M EVK
Thread-Index: AQHbXld6xCBQC4CEyE6YAZmNM/UFurMHAamAgAH3jID///dggIAAAZTg
Date: Mon, 6 Jan 2025 01:14:07 +0000
Message-ID: <PAXPR04MB8459B6A69CA0713B0B51058988102@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
 <CAFLszTi_px3qRGvpcC5WKLw+r5BqqQciOP-Vg1LEN+rt9876wQ@mail.gmail.com>
 <20250106013311.GA8414@localhost.localdomain>
 <CAFLszTi2ya3V4SDfpZxLzzyAdyM9KN0MGuZPnK2XeO8wRNw69w@mail.gmail.com>
In-Reply-To: <CAFLszTi2ya3V4SDfpZxLzzyAdyM9KN0MGuZPnK2XeO8wRNw69w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU4PR04MB10791:EE_
x-ms-office365-filtering-correlation-id: a0d4541a-e376-4d36-807f-08dd2def6b5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R08wd3AraldVeE0rdXIwNDUxVVIyd2VFUzJJUGdYR3l4RG1iLzFBcDZwaERN?=
 =?utf-8?B?T2pFdDJwT3VIZk92UThKTlpIbG5QWEQ1NDFZdFh1aDVZSWc0ZnRmbWtyM0Fh?=
 =?utf-8?B?alo3ZjhaSm52Q2k1ODgrQ1pqRTlNbmxSZzB3NjY4a1U2V3Z1WXllSkVZK1JZ?=
 =?utf-8?B?S1g4a3JFaTJ1dm1IbnVHYkUvcGF1NGszcWdRWS9oZ0pkSWZQMkNpSXBMOUhT?=
 =?utf-8?B?YUlDZFJsWHVaM0RPT2VPTkxKWTdXV3Vpb3oydzJJS1JPNTNKR0ZIYkIwY2Y5?=
 =?utf-8?B?Vk9CTUFtbVJYVGhyUGkrUXIvYlZDWFhhOGJNckFRcmR5UkhtZHp6MXNCc0hm?=
 =?utf-8?B?aUFhR0VwUWJUWUlpY2x6bkpoR09kbnVNVlFMdEdwQjM0Z3BjdTB2SVJKdjNi?=
 =?utf-8?B?Qkcvb3hkcjNhZHM0RlpZOHVRMmdRV21vVTJMQVlmRlZYWGpEVHVMQnRna1Rh?=
 =?utf-8?B?d250SHZnQU4wTEdXKzNNYlp2MWl6T1oyaEpVaE9wc3NxcmwxalA0SUhBRUZX?=
 =?utf-8?B?dDdqZkppREFpUWZVS0o3R3JMR1VXRitFWWRXM1ZMM3lZOUlBeUliSDF2cWlp?=
 =?utf-8?B?QnJQSThiWGppaTRQcmxkNC9OSFZTS0xWRnp3dWZVeWpkcG1zd09pdERFcUZz?=
 =?utf-8?B?WlZmcGx5dC9BQkRpdkdBa05lL0RySWYwRzRqd0E5ZWhOendzSGZzL1Y2ekpS?=
 =?utf-8?B?WnNvZTN3RG5jNmRQc1RTcldUcXVHNEphQVlOZkZQVk5CUi9pN3pPcVplZUd2?=
 =?utf-8?B?YnZ5ZVI5b3M2S3oyd1BEQXJtQkN4REtLWjVjSG91K1pWS1VKRUJFdDFGWGo3?=
 =?utf-8?B?VXNQQnJmUkhQVDRuSXprbmJyOW1BZmFiZ1JNdENWUjNnZExBeWY0SWRhSW40?=
 =?utf-8?B?UG9ISXpSeFNXTG83MlhzWm5OeG5CUEw3M0JKZ3Bzcml1V3RWS050YjhDWEcv?=
 =?utf-8?B?cWNNV2ZjRFZXQkxhb0xKQ2VOdmtRSWhuNWZ6Rms5Q2JVVGVMWjdmOXlqT05a?=
 =?utf-8?B?WGJablArMG55d05BYzZadVk1a0JhOC9ZWDYxemtpRnA3Y3dPT3lOMEYyejVx?=
 =?utf-8?B?TUJKSW1EQVlLek9MTFFJbUl6dFR6a2FYV20xdjZYaWtoOGhXa3ZjRGRBUTBH?=
 =?utf-8?B?b0RNaFRJa1ZSMzlRRHdvYlZzZXgrZlJHVmlreFVnQzZwN05uWVYvQ3plYkJH?=
 =?utf-8?B?Sk1uWGQ2ZVlOQzlIYXdDalZyVzNMOWJPZWZZNGdJRHkza3doL1FRbWRlN2lK?=
 =?utf-8?B?STQzdVZLS3FGZUx6YzRUamRrZWtFSEdHMVlhUUswWlpyeC8rNlZ0Y2MrL0Rj?=
 =?utf-8?B?cit6TzJzTjNqVkg0UE5wK3pVL0M4STUySThuS3gyWExxbmJJeXliNW5Na1Mx?=
 =?utf-8?B?TVBaVkFGUTdBeTBxc2JpckpYQTBUZXd5eWxrN1hSaExFRytxQ25nQlV4aWxS?=
 =?utf-8?B?Mll2bzlqOEVUeVA3a1hOeUJ5NU9BZmt1MnhLUWVacVFTd1JvOG1Xblc0RHY5?=
 =?utf-8?B?TUZYL0FCM1J6NW1wN2E0Z1hjRlorQzg0a28vWjZHT0g5M3dWQVk3WlJESWdM?=
 =?utf-8?B?RXIxdytWc2VNRDFDd0ZBTkRUdms0NkFrQzEvTEdzdzBnYUJhR2RudkF6YjhE?=
 =?utf-8?B?M241YXV0RStuSjRPemJoQ1BpTFBmNmpWTHFNSGJOT2ZUQjAraG9yZXcwZGVQ?=
 =?utf-8?B?RXRFZmQwaGJEOTVSbDBQaGlEM3JNT1FaUjlldExGRHMzL0JZMno0WWZXTUhr?=
 =?utf-8?B?cUorVUd6T3ZITTVxbHFxRmdUbnhpaXk0RlFCYmxvYy9KbzNuUENFYjVvRkRt?=
 =?utf-8?B?STIrNHhIclkrOVQzRmFvUzc1K3Z6aTNTOVZEUUhqcDhWS2JEa0pmcnNPYVJQ?=
 =?utf-8?B?N1pRVDFYeWZBZ0xWYlo2RXpEbFhpd1JSZjIvU3NJbGJzZTBnNXR3VG4xc2lu?=
 =?utf-8?Q?IqXMJoX8XnoHqdUoCPeJjGuT6tEYKzT3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VldoRU5pbGRVR0pGaVlMclpKT3ltNlpKTDE3MlpxSXA1VzdVUVRMTmp6N1ZS?=
 =?utf-8?B?YzVlQzZtN3U3THdybUV0eDROTmJ5WGx6am5HdERjbVNBZGRrRGF5TW5OZW5X?=
 =?utf-8?B?WjV4YXZPdzJsTUlPdC9MczgwKzlyYWZ6cDhubzQ2Ri9GNXhkRHJIR2tVT2o3?=
 =?utf-8?B?VjAzYXZIMFlsekJqT2l1N3lOTnBIN1lvZUdkNm8wQlpOTG9qd0NiMGE4MHJN?=
 =?utf-8?B?RVBmNUJVbzVjVEhPRHRaU1NEclQ0bXIrajhSalBnbGczbWFZOUg5WkQrcHhO?=
 =?utf-8?B?bW5VRUtKbk5YaUJMVVRoS1hUdG5TN0w1WmVZWTZzb3h1NHRzSG45bVVTN1Nn?=
 =?utf-8?B?OC9ycGg3WjI1TzF0QkxXWkJ2Mm9ZbHd3bWkxVTlSTlI3bjJxd2VLOEtOV2Q5?=
 =?utf-8?B?RzR4OURMbFhjN0w5b05BQTB3cXRvWFdUb1BheTNKa2JHZTRUemNKTXVNeDdM?=
 =?utf-8?B?bmNkN2t3ZGJhS2c4UVFBaU9qNVpVamY2dXUzOStxNTJOQ1B5VitqRXRWeVZV?=
 =?utf-8?B?eUQwRUZwdzBrWGdna2RlRUMvVGxYOHJESVBJekxmUjJoNzljVVE2ZDArMnBh?=
 =?utf-8?B?bElVOGRGNXRqdWJVMWZDSXFNYy9wb1dUZmFUWHJwSDR5Um5qRG5FdTRMQ2xv?=
 =?utf-8?B?d3dTWmtESHR2TVFpZFEyeFFUNWVFajZwUUZHSWZtVHgyN0RyeHg2Rms0RVNy?=
 =?utf-8?B?TzlDczRwYWhFZ0JHUVlMUmxDdk1FVUVVaDRDakJPVVlTMkY2VHdqQW1PWHV0?=
 =?utf-8?B?dVFYNnV1OXM3YWoyV3NzT0R2dW1MRE5hSkpBNEszdGZwc3RUYzBKSytZV2ll?=
 =?utf-8?B?UEo5bjJpZVdoWmxyQ2lkL3FFeVE0eStQVFF4ZzF0TDR0QlQ5T0o2ZkpmT3ky?=
 =?utf-8?B?VVBTK1BJSmR2NGZtbmRVN0ZHa3NNRUZib1lqdzYwOUk3VHFXblV6eFUvRGU0?=
 =?utf-8?B?dkI2TDBybDZuUnpKdXd2Z2w1K2Y0M1ppdjc0L3ZwUVR1ZzhnVVdIYys2Mndo?=
 =?utf-8?B?TUYxVzRkblVXQzdZdE9tSEZ4cWR3SkpUd01jZXYxYjdzVXl4aDdUaHRDWkxa?=
 =?utf-8?B?TWtHM253WGE4VWJMYkJ0dllZUWdETEI5NXl0UmFyU3k3WWdRanZMZEliV2Fa?=
 =?utf-8?B?NDJpS0lYMUhzYUt2NVpLdDk2VU9LRUJqcUVzdTdNU0ZFd05SRlNGamYrcE8y?=
 =?utf-8?B?dGs2aEZ0SUtlL3lwZHNQVE1UQThiU1dGS05SSlJ4RjJsR0xHbUszOFBNTUdF?=
 =?utf-8?B?OG54N1BDRStKbTZNN1BBMmhFY1cxa1BZU1dpNEFMRWxaSWpqeDdpcGxCMTBv?=
 =?utf-8?B?K0pXVmlmNTZVTHhBTzRHZkc4MC9qMXZ4b3ZGYkxzMU1kYU1NUnpMeVcraENi?=
 =?utf-8?B?anZQcy9RYnBaUGF3MFp1dGRNLzFsb2dxUTgxS0VRNDEyNnBJbGpJU21FTExy?=
 =?utf-8?B?QTQzclZFZ0RYeHZrcTdyZTVlU2luUUpqelliMGdyVVREazg3MmQ4WXJBYnVW?=
 =?utf-8?B?WlpYMEZxbVRIMGRqRTVUUytWNXhwdHR5S1BGRXZQMHJQNFUyOXdjZ2JOOEdt?=
 =?utf-8?B?cXFMYlJKTUlJT2hwSUJ5c0tpT0czQ1k2TjdIRGRwTG1BWXF1L3UrdFgrRTBZ?=
 =?utf-8?B?VjFTNEVQMjR0VlpOc0psSmxzSXhvb3V6anp6TkJXL2dVQmI1OWZVeEhPODEw?=
 =?utf-8?B?S2E0VGQrUWU4bEt1bE96OGZFUmFWcHNDay9zdElhNEhqM040YmF6MUVTYWF3?=
 =?utf-8?B?b2FHdWRlaGdtOVNYT2xGbG5JMVZlbmlnUDJhYXZBcjh4SGNRTU9qT3l5ZEJ4?=
 =?utf-8?B?WmRsSk9xdi8xVDB4VkZtU21xMU54TDl3VEtLRlVidzhFK2dLaksraGlYQjln?=
 =?utf-8?B?czlKb3VMWTd2akNKM1NZMUZ0Mk1RblEzajBMVVlHV2c3R2thK3gyMHdoV0x2?=
 =?utf-8?B?VGZyUkg4OUo2ZkJ0NWR3dmt4MlZFRnNyQURhMUJBRHZicnZTalcxSUl0N2Fr?=
 =?utf-8?B?dkw2RGk3QUpUNGFZdzdnMTFiYmRQUGI4OEZNeG12bjZPblR3Q3Z1RGJmZjkw?=
 =?utf-8?B?S0JVRDNCL3N3TmlJRHIxUFkwTFJ0M3hpTWx5UnV0VlIxbWdQYlJLR0JJTmNh?=
 =?utf-8?Q?ZmT0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d4541a-e376-4d36-807f-08dd2def6b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 01:14:07.7985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2EcDJQVHOQgHEj7vQiNK2VAKenTVSnjtr9OVX8M6BB2FoHDiQYfrdqiwgX1cl3RbYKQj/+8J+1+Jnso4mPmLtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10791
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzEyXSBpbXg5OiBzd2l0Y2ggdG8gYm9vdHN0ZCBmb3Ig
aS5NWDkzLzENCj4gRVZLL1FTQiBhbmQgaS5NWDhNIEVWSw0KPiANCj4gSGkgUGVuZywNCj4gDQo+
IE9uIFN1biwgNSBKYW4gMjAyNSBhdCAxNzoyNywgUGVuZyBGYW4gPHBlbmcuZmFuQG9zcy5ueHAu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIFNpbW9uLA0KPiA+DQo+ID4gT24gU3VuLCBKYW4gMDUs
IDIwMjUgYXQgMDg6MzA6NTVBTSArMTMwMCwgU2ltb24gR2xhc3Mgd3JvdGU6DQo+ID4gPkhpIFBl
bmcsDQo+ID4gPg0KPiA+ID5PbiBTYXQsIDQgSmFuIDIwMjUgYXQgMTY6MTksIFBlbmcgRmFuIChP
U1MpDQo+IDxwZW5nLmZhbkBvc3MubnhwLmNvbT4gd3JvdGU6DQo+ID4gPj4NCj4gPiA+PiBTd2l0
Y2ggdG8gYm9vdHN0ZCBmb3IgTlhQIGkuTVg5LzhNIGJvYXJkcyB3aXRoIGEgYnNwX2Jvb3RjbWQN
Cj4gYXMgZmFsbGJhY2suDQo+ID4gPj4NCj4gPiBbLi4uXQ0KPiA+ID4+DQo+ID4gPg0KPiA+ID5U
aGlzIGFsc28gc3dpdGNoZXMgdG8gYSB0ZXh0IGVudmlyb25tZW50LCBncmVhdCENCj4gPiA+DQo+
ID4gPkZvciBic3BfYm9vdGNtZCBpcyBpdCBwb3NzaWJsZSB0byBjcmVhdGUgYSBib290bWV0aCBm
b3IgeW91ciB1c2UNCj4gY2FzZT8NCj4gPiA+SWYgeW91IHdvdWxkIGxpa2UgdG8gdGFrZSBhIGxv
b2sgKHNlcGFyYXRlIGZyb20gdGhpcyBzZXJpZXMpLCBJIGNvdWxkDQo+ID4gPmhlbHAgd2l0aCBh
bnkgaXNzdWVzIHRoYXQgY29tZSB1cC4NCj4gPg0KPiA+IEkganVzdCBnaXZlIGEgcXVpY2sgbG9v
ayBvZiBib290bWV0aCwgc2VlbXMgbmVlZHMgZXh0bGludXggb3INCj4gPiBib290c2NyaXB0IChi
b290LnNjcikuIEJ1dCBib3RoIGFyZSB1c2VkIG9uIE5YUCBpLk1YIHJlbGVhc2UgYXMgb2YNCj4g
PiBub3cuIEluIE5YUCByZWxlYXNlcywgd2UgcHV0IGFsbCBzY3JpcHQgaW4gdGhlIFUtQm9vdCBF
TlYuDQo+ID4NCj4gPiBEbyB5b3UgaGF2ZSBzdWdnZXN0aW9ucyBob3cgdG8gbW92ZSB0byBzdXBw
b3J0IGJvb3RtZXRoLg0KPiANCj4gSSdtIG5vdCBlbnRpcmVseSBzdXJlIHdoYXQgeW91IGFyZSB0
cnlpbmcgdG8gZG8gd2l0aCB0aGUgYm9vdGNtZCwgDQoNCldpdGggYSBzaW5nbGUgdS1ib290LCB3
ZSB3YW50IHRvIHN1cHBvcnQgRmVkb3JhL1NVU0UvZXRjIGFuZCBOWFANCllvY3RvIHJlbGVhc2Vz
Lg0KDQpTbyBhZGQgYSBic3BfYm9vdGNtZCBhcyBmYWxsYmFjayB0byBydW4gTlhQIFlvY3RvIHJl
bGVhc2VzLg0KTlhQIFlvY3RvIHJlbGVhc2VzIG5vdCBoYXZlIGV4dGxpbnV4LmNmZywgbm9yIGJv
b3Quc2NyLCB3ZSBqdXN0DQpoYXZlIHNpbXBsZSB1Ym9vdCBodXNoIGNvbW1hbmQgaW4gYm9vdGNt
ZCwgc2ltcGxpZWQgc2F5aW5nOg0KcnVuIGxvYWRpbWFnZTsgcnVuIGxvYWRmZHQ7IHJ1biBtbWNh
cmdzOyBib290aSAke2xvYWRhZGRyfSAtICR7ZmR0YWRkcn0NCg0KPiB5b3UgY291bGQgd3JpdGUg
eW91ciBvd24gYm9vdG1ldGgsIGUuZy4gdXNpbmcgY29tbW9uIGNvZGUgZnJvbSB0aGUNCj4gb3Ro
ZXJzLiBGb3IgZXhhbXBsZSwgYm9vdG1ldGhfc2NyaXB0LmMgc2hvd3MgaG93IHRvIHJ1biBhIHNj
cmlwdCBhbmQNCj4gYm9vdG1ldGhfZXh0bGludXguYyBzaG93cyBob3cgdG8gcnVuIGFuIGV4dGxp
bnV4IGZpbGUuIFlvdSBjb3VsZCB0aGVuDQo+IGNyZWF0ZSBDIGNvZGUgdG8gcGVyZm9ybSB5b3Vy
ICdic3AnIGZ1bmN0aW9uLCBlLmcuIGEgbmV3DQo+IGJvb3RtZXRoX2JzcC5jLg0KDQpJIHdpbGwg
Z2l2ZSBhIGxvb2ssIGJ1dCB0aGlzIHNlZW1zIHdlIG5lZWQgcHV0IHRoZSAicnVuIGxvYWRpbWFn
ZSBhbmQgZXRjIg0KaW4gZHRiIGFuZCBuZWVkcyBib290bWV0aF9pbXguYyB0byBzdXBwb3J0IGl0
Lg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBTaW1vbm4NCg==
