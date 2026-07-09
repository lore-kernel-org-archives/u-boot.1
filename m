Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131CBC44506
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 10:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D9F084A51;
	Thu,  9 Jul 2026 12:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="i9MrMVNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD1884AB8; Thu,  9 Jul 2026 12:16:20 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44E5084994
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 12:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKX5eUWTX8z/EcNRDYboeRlEYEcykuEzcuuOKg3xhrOXFh5vwyezEVCQFHDpbjQSYH9+exBqWvNK7ABUFeIyKvlc5SCkJWRyTqAdEt3nRFOUrtWAScKnIHkFe/O0eb1LsTFOgviiVJeg7ec6Vn5BjVQfg2Mi/GVWxliZH3myEDXWiEeBRU9bQpJfmzjLiAU/aj44vj4ylPxN2KskiHJe6G/4IBVfilO9DqHdPtYGr6jGRJguPUw/VBNp4PT7saSecT9mf67SAQsLVy2CXa3x/4m+iLYPGpToA4yQB67DGx5LQyEeqkRMVbs06UZuz78bHId2BOU7UiJ8/5LmH+7mTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cs+Ifi2Y5nk13EqmduIGlVAscaz03S/TYMIc/Wvg0Ho=;
 b=SODsgwRoZ6GnfQ4D4DTAd3efgw8LZW192RuG2wH51n5s4D+WztLtBMiLPj6FPCZw85Wol+QiEQQfaTSSpswXW6IOC4wkGumuYNfJ9SKB1EElJE7edbggsLMOeI4592hrRO0XRTOsHDUHGzlKIWSiCM77Ynfeukb6s4FuwK6PAhoewa+3f0RaKeWqjLJg/JKxR3i5/+wdAoUoRDhIQNxfA0cFufdNp2KvJ6c/gZO2H1QccG24RcRzyqN12DYEcklbqrlZmnGSpFaFX1Sb2PjhFBcWrXlty+BBl2tkKtAD2rD628G7yDUxMZtwT+AqpTI93lNSmPT6EIB/RVLn03GU4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs+Ifi2Y5nk13EqmduIGlVAscaz03S/TYMIc/Wvg0Ho=;
 b=i9MrMVNe2dMvjZeXfmK6KREffn8w0xNU7N+2gMSuhJs77jPYYb9kDn2mqZb3hVTVByvfA6IME+jzrC4d/QzweXGDZiK0ZB/2G8QNEnr7K8AYaSQDLzqfY9zAsJT36yFh8vk6Aj9fnz2GaGbuqk7wyq05dliiPwP6V03MsqiRpZ4xL0HWx9lVaeL+TBDozZwclGYvr+u1ruOTk7vSIHuN10p5XGVYi6TklVXsP/78M4A7ZofNvxt7El5tjWzGDFVEUMYMKFV8IvyyeGdNXOfhqZ2147opqJnoLoRj2HficrhFfPkQzGNll0Au7P0LrWgUJFsnqIfqTSmFuQByRCnKLQ==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by PH0PR03MB6333.namprd03.prod.outlook.com (2603:10b6:510:be::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 10:16:13 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 10:16:13 +0000
From: "NG, BOON KHAI" <boon.khai.ng@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, U-boot Openlist
 <u-boot@lists.denx.de>
CC: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, Marek Vasut
 <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 "MANIYAM, DINESH" <dinesh.maniyam@altera.com>, "LOK, CHEN HUEI"
 <chen.huei.lok@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1 1/2] arch: arm: dts: socfpga: Update L4_SYS Security
 Control Register size
Thread-Topic: [PATCH v1 1/2] arch: arm: dts: socfpga: Update L4_SYS Security
 Control Register size
Thread-Index: AQHcpgXmeuZ6QVQBDkyFk8cpPDZEHLXdBI8AgIjFOMc=
Date: Thu, 9 Jul 2026 10:16:12 +0000
Message-ID: <SA3PR03MB7187C199CEC4DA3890DDF6EAB4FE2@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20260225032149.1342-1-boon.khai.ng@altera.com>
 <LV8PR03MB81371042B7281984F15D61BDA7242@LV8PR03MB8137.namprd03.prod.outlook.com>
In-Reply-To: <LV8PR03MB81371042B7281984F15D61BDA7242@LV8PR03MB8137.namprd03.prod.outlook.com>
Accept-Language: en-MY, en-US
Content-Language: en-MY
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Enabled=True;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SiteId=fbd72e03-d4a5-4110-adce-614d51f2077a;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SetDate=2026-07-09T10:16:11.553Z;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Name=Confidential;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_ContentBits=1;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|PH0PR03MB6333:EE_
x-ms-office365-filtering-correlation-id: a0de19c4-0115-4456-7cbf-08dedda31aa6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|55112099003|38070700021|18002099003|22082099003|6133799003|56012099006|5023799004|11063799006|4143699003;
x-microsoft-antispam-message-info: tm/ziiEypvQrjtm1QPUMyTOyWlXnxfH7HZ0zZ2Gv1CPgroz5hkESs3KQhY00CSbrHP7Rdrzs2t3Zp4hr7sWcfSN72FpCVkgUudc8obNB22DbZGCS56vI2m5pYpfsUKItgPf+upjm37JRxuhr/ejmDMd066v6gP2KEbS/PVBMc1v5SGdd0FzTt8Eu9Xz9usIooH2caKz/1Xt0GwFqhVNZFs4qufZPVFzC4t7c4BrqunTKw9Sa/2KiNAHDT/HXf5jZFHKAMFWMOI1dLVHXrPH/OKreTh5mKOzB0Ji4Ksx4SEUOKXMTkcdgjE5r64XPePbu7VWmnLEa0JxMUAz+wnuUieHClkUnawypMm9thukywdHSDJA9U27pvWwXsh7bB1wnwDZo1FkbDSKb2cP+lcU1dfghqK6DkycC9Yx03zJdxZ92I3pfThLmUeDy5kIbZlZDqRMl9Ppi6RjSqXUaMPbpSad2xFBKH7GJbOQAMwWvkvynabipmJDgvS+YuzmLYSoWRcIkU1FglHSHjxPrVAX7oG0VTZrP7gT8jFkkdn/nkNmDFwQSBqK3yFrgGHUmWZaIKS9BXS/Rw2ziwDEq86pdRy63qhaonRY0QnJcl0zJNtNgTDafqGfxYvwFdM461cn2feSdbYlazJ/WKuvWnd9ri9j+vHizAFFU6ukZTz0avCQPoLsJ/nUHBmayCIJGM/E50NiKbjsp4hFsWEl28U0hFAkoqCkaGc30ry1ocDSw8GU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(55112099003)(38070700021)(18002099003)(22082099003)(6133799003)(56012099006)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?sVgawGbCxsaOQDpqviPQ5m/yhWOEv9f1UBPENglctW448n0sdsgX5gt4?=
 =?Windows-1252?Q?p6wCM3yE62iH7lE7m0+OcxwSFrGHnnXXAx41lty5tTCMaHex7Au+DIY8?=
 =?Windows-1252?Q?Fhz8oczi1JnsPu1sO07p8jzigfvh0lAU2GiBgyPP9Pv7FbI0ZgfLyN8W?=
 =?Windows-1252?Q?MO17fX0hPo5IDtiXxPiAr7pqLMqKXOgQK3tL1Sqa2uN0axbHVBQN9F2F?=
 =?Windows-1252?Q?tUxxeBIR1nSu0uVg31Mhf/2B9wm2NU7BM8z2G6xHJpIijze3FJ2KEHGx?=
 =?Windows-1252?Q?OHyVL5JCmJ4KwUbeh9/G7OOOk186qeJgsA1aqUZjJG5nVousdAoqvRgW?=
 =?Windows-1252?Q?mbhbmSha16SPrHqG+ZjS0nl3y0acwzr0tdV0fWI0ER/C9bl4s7gWNVvh?=
 =?Windows-1252?Q?Mgl3KzkChTq/IofCHc5hyyul3ILcBrss2Roz3qcF0O+oYhVAq+Pm3T36?=
 =?Windows-1252?Q?PXjn/ZM5FiSBZt0V69j38Ye77GjDrdxS6cPCGBZh8skvoHwSlQ/DPbX/?=
 =?Windows-1252?Q?EvsUhxBquhVJjVWoCVe6jHFjVM/zlwqLXavGhcfvEEiHzqeTh0RKIlVR?=
 =?Windows-1252?Q?3mN84RWj/jkdVLWSItZxE+ALRYoCHlJqzijLVchsNlmYNmDcAvjVSBC4?=
 =?Windows-1252?Q?+P9wLquJi3OqH6ZperzBS7fyhMBQlTl1wA8Y914CPheKIqDml/Q/LAOo?=
 =?Windows-1252?Q?ZythDsRx5FZbA5dAdzQLWF4mNfPde0wZiQ7g/c6V5jnnZ82G6eiGrXK8?=
 =?Windows-1252?Q?ddFl1jqLy8TsZN78hR0DF3DUU03+9PmB5wF89W7apdr394LChzdYT8M7?=
 =?Windows-1252?Q?PjYiaUCgiE4hEj9fcRlBuZcXR+S2EGDdoD3tDfRgAmvGY1aP2OD0Kb+r?=
 =?Windows-1252?Q?mX4wWEY7j0vgKHa/mG2GktCO5Wna5pdVLpMVvbo8ViXKKGDTQCgaJHRs?=
 =?Windows-1252?Q?eWg9LXHxjt4yTgk57esQCeW5sVdb3ZSQPwv2I0cZLb7T4rL6EaZjz8nl?=
 =?Windows-1252?Q?430tRm9YkswF5eP/krecUlvF3fH6c9aySvIduE5t//aS2tWq9oKGtDIn?=
 =?Windows-1252?Q?9zhZturj8iJiEAVoquon8qxhFvM+k9Io14Jx0TzjnVR1EsL6L17XM2mB?=
 =?Windows-1252?Q?+Mlha3UgY/rwXaD4lDLCt3ohI4gFCkLelbnB41QJBAseoxSO3rbm0okw?=
 =?Windows-1252?Q?ndgMhKVGek3w4Z75hQmMiARJRQdTtUkb8Y8eOmGRxtZRipRKaK1D8IVn?=
 =?Windows-1252?Q?TEnx2APNfqoEYmHOxViKP37U4k8b2ggTOwcUZ+7eQKH4lVoK8pc86i9h?=
 =?Windows-1252?Q?IxMHVOyFh14dfDW1YCBwJx9aYbW7Gc8/HOzipT733a+XqgwM+eXS0uCo?=
 =?Windows-1252?Q?5NtgdgGwx5TBwwhDCsw1ihFBX2/8x7K2pFwrpqq8x0Es0tgu1WOZjTNN?=
 =?Windows-1252?Q?wZWt9FU+SQ6rh9Ca6KR+hPUNeccAkU5br6lYYoocxBjXrWcJSo85gEs+?=
 =?Windows-1252?Q?qLIGkh5NGSNjGepoEO4KloYSWGXAvkc4J6Lxok57IYID6Gbo+y8UH/cU?=
 =?Windows-1252?Q?MmjhIzOMSoOJ3YVC6UJduiquZSQmSjNScdHkrMviFe7rzL2h0ywDbjbx?=
 =?Windows-1252?Q?MdyTMb+ZYmQ0d8Tq2C95ME41gMSLojjl2KXxIqhartlpqc4pvl09KzYd?=
 =?Windows-1252?Q?SRVJzuPhYXq0X+ph+5c7VGJc1B6RNOZ3mBja9Fpiw0lmI7qW70MEaSMd?=
 =?Windows-1252?Q?gJRsfToh2rVDTNEA/WZt2c0lEBWpQgL49yDwVjqz1RxppHALViU+mTuo?=
 =?Windows-1252?Q?uthDif7WsUtHog/6ez/nFZdxJbtKJOjplO8tY2c9c5B1B6PQyNyHdRhv?=
 =?Windows-1252?Q?MQxKb02tYiACKA=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0de19c4-0115-4456-7cbf-08dedda31aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 10:16:12.9229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcCi/goC5I+cHabUaqDaG1W1g2LSQTrDlEFxmrJQ2IseVn7OcOwOvihxp3bV23UwVVVRDflEW7f/bAVizjA98w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6333
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

Hi Tien Fong,=0A=
=0A=
> Instance decodes 0x100; reserved offsets are RAZ/WI=94 (or equivalent wor=
ding).=0A=
> If TRM does not guarantee benign behavior for reserved offsets, I=92d NAK=
 0x100=0A=
> and request to keep 0x4 until there=92s a concrete need to program additi=
onal=0A=
> offsets.=A0 Please check if only 0xFFD21400 is valid and accessing other =
offsets=0A=
> may bus fault / return unpredictable / hit other logic?=0A=
> =0A=
=0A=
The 0x100 comes directly from the documentation here:=0A=
https://www.intel.com/content/www/us/en/programmable/hps/=0A=
stratix-10/index.html#miv1505407144600.html=0A=
=0A=
0xFFD21400=960xFFD214FF (256 B) owned entirely by this one=0A=
firewall instance (next block is at 0xFFD22000), so reg size =0A=
0x100 matches the hardware decode window.=0A=
=0A=
On the safety concern: the intel,socfpga-dtreg driver=0A=
never accesses reserved offsets. reg[1] is used only as a=0A=
bounds check (blk_sz < offset + 4); the driver only=0A=
reads/writes offsets listed in intel,offset-settings=0A=
here just offset 0x0. So 0x4 vs 0x100 makes no=0A=
behavioral difference for this node; nothing=0A=
in 0x004=960x0FF is ever touched.=0A=
=0A=
Regards,=0A=
Boon Khai=
