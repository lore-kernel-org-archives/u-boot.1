Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F29CA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 05:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 467D380FA1;
	Wed, 20 Aug 2025 07:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NOK0GHZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A59D8211F; Wed, 20 Aug 2025 07:15:10 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13051809A5
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 07:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQJ0DffE8I8m6jnqhkH/6SB8QIRVwiU19igoGA3PKvP19nw6MMsgVAMgFv0cDlrH2d1wZ9wmh0hUoo2NvRDQed+hHkkLsuYQclGJpsavQesNutUJIZtpSaFhKd6isekXsP1nqsUlkDGulH3KWavfY+8OBne1c02oQwwC8rm6KhNDpNTZLj08xrw3InINnJTub6gc2P9bGfSO6T14dd4VuLxkun/BWLQ2C/ZELVBv3e8zVPbXkyA3sWe+zAiJdaWCHGOOMiSsr1urMakGGj/gsgRzdxeM896XhqXZ2RMV8zj6h4Vt8D6XwXSokdH+5+E4RIPuzsOjLE2PvvCmtPkdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McgPGmDyVFtdj3iI3LB4AYE+4JnTtl6YWVJmisjcrn0=;
 b=TFlkJ6imuZ742nmHHKbmdQjy9LrXUhG6ePOHCVRdAf8Zf7BDb6jwfrwGznt56a3DJh+Hfsg75mzLy+REr3+LoBQclv2rJfQnT2M//+nxxgaJfi7WrM6JyPWPWJCI06TazISPhESEkKNHZgutJBW8H79WzkO1RPz8nFdUEnbWxtdUavz9zYIle4CuKtoKXOO5OfPKoRykS/ONTLpz3WyodxieIDsS9s505bWzlL6b7Hd8JfRH8qUvPRr2aPhuuUZ0FQ3PBm5KfVCCD9A/y679O4KHAvtUOzCIx7oDr5+TXizd6ppH22Lw9C6la3LNUpuIZ062R9CGl7W9l6waAVK91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McgPGmDyVFtdj3iI3LB4AYE+4JnTtl6YWVJmisjcrn0=;
 b=NOK0GHZTHIj78wlAey2eVWGW/WbIHiWJpPgzEVGzkG+nCZqIvwnv16OXZpnGuDLiWSGEYqOvlfCEa8zl3JDo1bA0t+Tn9ohFPEfDokCqr58C4J8MgNB+Ik2hoS/ghRigs+8A8uQIqN/9IQToPxRqS5zWvTWq8rS7ZyJkW5jglbw=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 05:15:02 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 05:15:02 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Raymond Mao <raymond.mao@linaro.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Liviu Dudau
 <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Harrison Mutai <harrison.mutai@arm.com>, Jerome
 Forissier <jerome.forissier@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v3 0/6] Add support for DT overlays handoff
Thread-Topic: [PATCH v3 0/6] Add support for DT overlays handoff
Thread-Index: AQHb9+6Sbmu1wV/1TUqYurGlx3wsVLRrL9OA
Date: Wed, 20 Aug 2025 05:15:02 +0000
Message-ID: <SA1PR12MB86977E312AB3965DFB8D2DD79833A@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
In-Reply-To: <20250718141621.3147633-1-raymond.mao@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: raymond.mao@linaro.org
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-20T05:04:01.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|PH7PR12MB6467:EE_
x-ms-office365-filtering-correlation-id: d49b4bfb-ad2b-4cf6-92e8-08dddfa8842d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018|4053099003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?g23WPcTtqQutXjc58HjkWDIdyUxJm83d8JvmjTKsmmp7jLum+wP0QtW+CJ9w?=
 =?us-ascii?Q?jip9x72XV2TR1SpVM74+e2GwoHH0TEZv8dCkTaNuL/k/ouXyACd2fu19U+Km?=
 =?us-ascii?Q?Dtr05ltlUcGU/AwGVJN5G+JekMlwaqn5pl0QFba3yBthI/jGUGo3HVBG/Zcf?=
 =?us-ascii?Q?LdsTapnQF3iwkczSRupTa4C6AISXgdOW06yO7q5VrT+4YrOAvwauvAE2feYq?=
 =?us-ascii?Q?x7yZOKC99hlWNQSgGG7x7uftCalNiHc2YnLGh9owZjqCgLpU43UGx9l4Jc9R?=
 =?us-ascii?Q?u8vTFvdop6WnwZOoMzho4pxgmD41eKEgSZ/BeO6rtiqBgcPz0HFNd3jVxuio?=
 =?us-ascii?Q?4usPe8hchcDrSNtB4ffLQBh7kPJxf7atusXH6lYJfJkXsE3MtVqElVrSOKOb?=
 =?us-ascii?Q?9qSHB/s+9/Ln7+g20FXxo3GBHPCT92CbooNSZcZqzF7Z/9PLE2MBduPtafUw?=
 =?us-ascii?Q?0BZz1IZFP30vLrY7H8nQUCbsw/xSIN3cbNgiYzNqYCI5pXljG+rQSmn1F8CB?=
 =?us-ascii?Q?yrxGAlGHZ/6wgbBL859Tc8j97kr5Zrr9HzTOXEq5rtUBKiYN+d+j9bcUb2HZ?=
 =?us-ascii?Q?z5dQVMqgmnfYncdh7VZ2f7/j3kv7B+VpOfKvMFZsBewz1n8K3mVb5K1F+GMi?=
 =?us-ascii?Q?ifW2UsOTvofNJ2r5ehI8Kz4RGfVuvV/DwDQ0d9EDnLASXN5tZxCbd7BojYou?=
 =?us-ascii?Q?iumfXbsyyfCy8lZG2ltnHAzM+ezv3i9OzbYGKd4BlKghvHqGDiXu9wJKNepB?=
 =?us-ascii?Q?nwOoE32Ky6lw8jTUMB2reHuUNHoR1Vo8sfGjbLpMKUXoU3s+ZQHdVMAXUK5u?=
 =?us-ascii?Q?GuHDZYwGgUoHhYkNmgInYMA/L6lQs0OOLgMIqs1AK4JPG5yt1F4sKC4l6wLa?=
 =?us-ascii?Q?pk/9GLRqCTu6GtxzJ8xhMJmqZz2lnjbwwgFUYuA5W/eTBSf7FtpRjaZNfpK9?=
 =?us-ascii?Q?GP/dv4ihmpEF/L/YYafRcEilTznNcspZL0SNkYIZtbrM8itVD5vuy2zGdWN7?=
 =?us-ascii?Q?VoXhXXv5M0ZkKyfTRmnDLRsU1qSyHCV9WulFZR/5aEKkOelwbCPdP+UURdas?=
 =?us-ascii?Q?WWOt/0p2EfRF+mvNs59KAAITtN73KkMKyN4/kyOkZYGEJ4/momaBrW8sRqU/?=
 =?us-ascii?Q?B8dbB2cTNfAt1ieTKv9zprEAzRyk8CKKd4ngj27dGojcuZUcwUCG3kvrtUmk?=
 =?us-ascii?Q?3fcpW2e+TmBfnqad9jXJYrfO/E27crTd1FgQf1nooeicQZUNTDefB+CiG68r?=
 =?us-ascii?Q?IQQFs3E0almyeOu6T/HAjBugcxYHJku2yjgxiE+hUdo1QksKxmbwLzlaOddW?=
 =?us-ascii?Q?ll4J/+pSVMS9zL0zacVXgptSCq12MiF5lz9hhiYgRSrOh57NvD2Wc4/VoYh5?=
 =?us-ascii?Q?yqxcbYrlkw6zMmfLjXSzPqQIhwjaUaqclZU51pVMzwKAmcvYN64yjmz7DIWy?=
 =?us-ascii?Q?FwgdvxIF0BZukfqKaFEy68g19dGjKXAX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(4053099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ElToJEQVwt7Z+Jtf8+2wM7vpgt6m3qIMRw/XJgytsJU6SiT4M4KXSA/Qp+M0?=
 =?us-ascii?Q?7GPuA+7AQTIUz6+u54+3OwjL1c2QPbW6z2Yw7A7NfOq1eVNNzQCVrEnhdLod?=
 =?us-ascii?Q?jDCGfU3K+9VjlvY/l0lp8afOxgbsyTqgHb8LNApcdrLAyQQTiWO7KBSiko4h?=
 =?us-ascii?Q?86kGv3CNuJ9/liQKbPt2YwmjyqhJzvterQ6UyUmlhoUvjwFeaP34FZGnJ+b1?=
 =?us-ascii?Q?obNoWu8sWE1wGafhAS4lkXyOzx13kNy90E2khDzLmQcrnPMOQOZkWWIvdhzv?=
 =?us-ascii?Q?+h76O8aPKGyqvMQr5G13ixJAnfQVLNapPYi7A2rGQefB1quZ3gHMYamIMpn+?=
 =?us-ascii?Q?/laexmQs8/G+cqTh+G5j0D4nNvBc+KtS2M07FrrESbmadXA54oG2q0OSxdhv?=
 =?us-ascii?Q?9qZinLI5Slk4x4xLcqPs6ccsBcbD2OsG5E19yfCxtbDGgOtVDebSsgnsdfQJ?=
 =?us-ascii?Q?QqfUFKmp44FoqQciO930NEBmR2qeXDw7MUx1VIdag/4dppLFJMBL8uHN8xQn?=
 =?us-ascii?Q?WAlAosE13q2iZIoypP+dTmfFdWPjM8HTWfbgIpYqWLeg8i5OUUeVuop8t7MJ?=
 =?us-ascii?Q?MMlczIbrsYVg/WKVAZwuLRul7H6xN5WnSkHgrjpbApfG90ebRB+D7ruI4SaX?=
 =?us-ascii?Q?iFpqmTqBXenKgGYYyItw3mz3C5pSJLwV/ZRK2MP5h0iiV4KLiJKZlCvnYV+t?=
 =?us-ascii?Q?Xr4XzEzCePjmlam8htqZlHD+mxfMM7ph3eTlG34wi+YrJNsguTNDXJkN5KKw?=
 =?us-ascii?Q?PLjmphZtmBP03dzeGR35Jr5TNrb4EozHw4J3zTOxNx7jKxbc9aA5B74weHFa?=
 =?us-ascii?Q?N9L0JpwbEAq7nSW4b6QbdW5Eqff2NuVybCcx72WF94Qb9Q9cTMkIObxsYeMO?=
 =?us-ascii?Q?MnyuroGNtkzqKzZ/zPkpd227o4mlD6BxyQWfZsnYXq38eT3s2hUi9Kulu4FF?=
 =?us-ascii?Q?zoLELcHg1fidPlNRbe6P0Xss3gYGbNGGE+mbB7as+Ns6rYAPN49nWYcqPsbJ?=
 =?us-ascii?Q?ZORQWMjbekW76++iz7kpPUMbKikPC0AAWRF8qWztnECOYZT1DyRLM+Mhq342?=
 =?us-ascii?Q?jb1KyvcAW43xK7226vUYRORxmuYg9ACqhJ+zzP3qFH7cCDeNM96BB+aYBl6J?=
 =?us-ascii?Q?BO5bX+CbhPFo5JsdN5HAE2LTXClVh1WG1o7F0yRxFG8eIcJ5CncSbApsqNQ1?=
 =?us-ascii?Q?c5uLj0KRpJZiJLO7sTGa/VUKClLip5ludo6IC/+wxYoofSdljTxfx4Cmgy5M?=
 =?us-ascii?Q?HO0irEEeYJDUfrirccJII2J1RfESjt2yf3V+L50LxcDiPueVpS4JoMGkq4Sc?=
 =?us-ascii?Q?lDn7mZYE/wHZflVpYfvbUOt1kAGPXZTOSvQzYLidAgHo1Crguu8kC6yhs/ae?=
 =?us-ascii?Q?4iYbpgFmqb5FfudLg8hDrOq5ECJgUd1RgEoHPpT/WxlKlolp3zOGz49WgAwm?=
 =?us-ascii?Q?j1TbJVp4WUu+ZccS1eQM39ffhFkfiEIgbJ0qb+nMf/gIcdDlVF2MdymDLBBb?=
 =?us-ascii?Q?zfBjFjlQQKudprBjPSPbGHyatxVI7TwuaT2e2ceCMdzFwP2J4MV7pTUt6p8s?=
 =?us-ascii?Q?uHMwel3gpy8q7G/ubaw=3D?=
Content-Type: multipart/mixed;
 boundary="_002_SA1PR12MB86977E312AB3965DFB8D2DD79833ASA1PR12MB8697namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49b4bfb-ad2b-4cf6-92e8-08dddfa8842d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 05:15:02.1306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbIW9/fnTmmQB+5z0wPxwD3GiaovQx6wuNY6lgUD/meWtTNsGpMEHzW+BC6dBSMYIHFPSoR+4K14STF9Hh2nVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467
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

--_002_SA1PR12MB86977E312AB3965DFB8D2DD79833ASA1PR12MB8697namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Raymond Mao,
I was trying to test these patches with the transfer list binary which cont=
ains tl.bin(dtb+dtbo) inside it. Facing issue with the dtbo address and fdt=
_check_header(*blob) from fdtdec_apply_dto_blob() gets the invalid magic nu=
m.
fdt_magic=3D0x38 fdt_chk_version=3D0x1

Attaching the log with details. Let me know if you need any other informati=
on.

Thanks
Venkatesh

> -----Original Message-----
> From: Raymond Mao <raymond.mao@linaro.org>
> Sent: Friday, July 18, 2025 7:46 PM
> To: u-boot@lists.denx.de
> Cc: Simek, Michal <michal.simek@amd.com>; Abbarapu, Venkatesh
> <venkatesh.abbarapu@amd.com>; Raymond Mao <raymond.mao@linaro.org>;
> Tom Rini <trini@konsulko.com>; Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>=
;
> Liviu Dudau <liviu.dudau@foss.arm.com>; Simon Glass <sjg@chromium.org>; I=
lias
> Apalodimas <ilias.apalodimas@linaro.org>; Dan Carpenter
> <dan.carpenter@linaro.org>; Patrick Rudolph <patrick.rudolph@9elements.co=
m>;
> Andrew Goodbody <andrew.goodbody@linaro.org>; Harrison Mutai
> <harrison.mutai@arm.com>; Jerome Forissier <jerome.forissier@linaro.org>;
> Heinrich Schuchardt <xypron.glpk@gmx.de>; Evgeny Bachinin
> <EABachinin@salutedevices.com>; Matthias Brugger <mbrugger@suse.com>; Lad
> Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH v3 0/6] Add support for DT overlays handoff
>
> The series include refactoring on bloblist and fdtdec to support handoff =
of multiple
> DT overlays and applying them into the DT base during setup.
> All changes are aligned to the spec update for supporting DT overlay hand=
off[1].
>
> Notes for testing:
>
> Currently DT overlay is not yet enabled in TF-A, but with the test patche=
s I provided
> for TF-A and OP-TEE build, importing a DT overlay blob file from QEMU to =
TF-A
> reserved memory is supported.
> Follow below instructions to build and run for test:
> $ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml Repl=
ace your
> local qemu_v8.xml with [2], which contains all necessary changes in both =
TF-A and
> OP-TEE build.
> $ repo sync
> $ cd build
> $ make toolchains
> $ make ARM_FIRMWARE_HANDOFF=3Dy all
> Copy and rename your DT overlay blob as 'qemu_v8.dtb' into out/bin $ make
> ARM_FIRMWARE_HANDOFF=3Dy run-only
>
> [1] Add Transfer Entry for Devicetree Overlay
> https://github.com/FirmwareHandoff/firmware_handoff/pull/74
>
> [2]
> https://github.com/raymo200915/optee_manifest/blob/dt_overlay_handoff/qem=
u_v8.x
> ml
>
> Raymond Mao (6):
>   bloblist: add blob type for DT overlay
>   bloblist: add helper functions
>   bloblist: fix a potential negative size for memmove
>   bloblist: add API for applying blobs with specified tag
>   fdtdec: apply DT overlays from bloblist
>   configs: Select OF_LIBFDT_OVERLAY to hand over DTO via bloblist
>
>  common/bloblist.c                       | 67 ++++++++++++++++++++-
>  configs/qemu_arm64_defconfig            |  1 +
>  configs/vexpress_fvp_bloblist_defconfig |  1 +
>  include/bloblist.h                      | 34 ++++++++++-
>  lib/fdtdec.c                            | 80 +++++++++++++++++++++++++
>  5 files changed, 181 insertions(+), 2 deletions(-)
>
> --
> 2.25.1


--_002_SA1PR12MB86977E312AB3965DFB8D2DD79833ASA1PR12MB8697namp_
Content-Type: text/plain; name="tl_info_with_dtb_dtbo_log.txt"
Content-Description: tl_info_with_dtb_dtbo_log.txt
Content-Disposition: attachment; filename="tl_info_with_dtb_dtbo_log.txt";
	size=4378; creation-date="Wed, 20 Aug 2025 05:04:22 GMT";
	modification-date="Wed, 20 Aug 2025 05:15:01 GMT"
Content-Transfer-Encoding: base64

VEYtQSBsb2cgd2l0aCB0aGUgdHJhbnNmZXIgbGlzdCBkdW1wOg0KPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCklORk86ICAgIER1bXAgdHJhbnNmZXIgbGlzdDoNCklORk86
ICAgIHNpZ25hdHVyZSAgMHg0YTBmYjEwYg0KSU5GTzogICAgY2hlY2tzdW0gICAweGJkDQpJTkZP
OiAgICB2ZXJzaW9uICAgIDB4MQ0KSU5GTzogICAgaGRyX3NpemUgICAweDE4DQpJTkZPOiAgICBh
bGlnbm1lbnQgIDB4Mw0KSU5GTzogICAgc2l6ZSAgICAgICAweGQ3MDANCklORk86ICAgIG1heF9z
aXplICAgMHg2MDAwMDANCklORk86ICAgIGZsYWdzICAgICAgMHgxDQpJTkZPOiAgICBFbnRyeSAw
Og0KSU5GTzogICAgdGFnX2lkICAgICAweDEwMg0KSU5GTzogICAgaGRyX3NpemUgICAweDgNCklO
Rk86ICAgIGRhdGFfc2l6ZSAgMHg1OA0KSU5GTzogICAgZGF0YV9hZGRyICAweDEwMDAwMjANCklO
Rk86ICAgIEVudHJ5IDE6DQpJTkZPOiAgICB0YWdfaWQgICAgIDB4MTAyDQpJTkZPOiAgICBoZHJf
c2l6ZSAgIDB4OA0KSU5GTzogICAgZGF0YV9zaXplICAweDU4DQpJTkZPOiAgICBkYXRhX2FkZHIg
IDB4MTAwMDA4MA0KSU5GTzogICAgRW50cnkgMjoNCklORk86ICAgIHRhZ19pZCAgICAgMHgxDQpJ
TkZPOiAgICBoZHJfc2l6ZSAgIDB4OA0KSU5GTzogICAgZGF0YV9zaXplICAweGQzZDINCklORk86
ICAgIGRhdGFfYWRkciAgMHgxMDAwMGUwDQpJTkZPOiAgICBFbnRyeSAzOg0KSU5GTzogICAgdGFn
X2lkICAgICAweDcNCklORk86ICAgIGhkcl9zaXplICAgMHg4DQpJTkZPOiAgICBkYXRhX3NpemUg
IDB4MjQwDQpJTkZPOiAgICBkYXRhX2FkZHIgIDB4MTAwZDRjMA0KSU5GTzogICAgVHJhbnNmZXIg
bGlzdCB2ZXJzaW9uIGlzIHZhbGlkIGZvciBhbGwgb3BlcmF0aW9ucw0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg0KVUJPT1QgTE9H
Og0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09DQo9PT09PT09PT09c3RhcnQgb2YgYmxvYmxpc3Rfc2hvd19saXN0PT09PT09PQ0KYmxv
Ymxpc3Rfc2hvd19saXN0OiBoZHI9MHgxMDAwMDAwDQpBZGRyZXNzICAgICAgIFNpemUgICBUYWcg
TmFtZQ0KMDEwMDAwMjAgICAgICAgIDU4ICAgMTAyIGludmFsaWQNCmJsb2JsaXN0X25leHRfYmxv
YjogaGRyPTB4MTAwMDAwMA0KYmxvYmxpc3RfYmxvYl9lbmRfb2ZzOiBvZmZzZXQ9MHgxOCByZWMt
PnNpemU9MHg1OA0KYmxvYmxpc3RfYmxvYl9lbmRfb2ZzOiAyOm9mZnNldD0weDc4IHJlYy0+c2l6
ZT0weDU4DQpibG9ibGlzdF9ibG9iX2VuZF9vZnM6IDM6b2Zmc2V0PTB4ODAgcmVjLT5zaXplPTB4
NTgNCmJsb2JsaXN0X25leHRfYmxvYjogb2Zmc2V0PTB4NzgNCjAxMDAwMDgwICAgICAgICA1OCAg
IDEwMiBpbnZhbGlkDQpibG9ibGlzdF9uZXh0X2Jsb2I6IGhkcj0weDEwMDAwMDANCmJsb2JsaXN0
X2Jsb2JfZW5kX29mczogb2Zmc2V0PTB4NzggcmVjLT5zaXplPTB4NTgNCmJsb2JsaXN0X2Jsb2Jf
ZW5kX29mczogMjpvZmZzZXQ9MHhkOCByZWMtPnNpemU9MHg1OA0KYmxvYmxpc3RfYmxvYl9lbmRf
b2ZzOiAzOm9mZnNldD0weGUwIHJlYy0+c2l6ZT0weDU4DQpibG9ibGlzdF9uZXh0X2Jsb2I6IG9m
ZnNldD0weGQ4DQowMTAwMDBlMCAgICAgIGQzZDIgICAgIDEgQ29udHJvbCBGRFQNCmJsb2JsaXN0
X25leHRfYmxvYjogaGRyPTB4MTAwMDAwMA0KYmxvYmxpc3RfYmxvYl9lbmRfb2ZzOiBvZmZzZXQ9
MHhkOCByZWMtPnNpemU9MHhkM2QyDQpibG9ibGlzdF9ibG9iX2VuZF9vZnM6IDI6b2Zmc2V0PTB4
ZDRiMiByZWMtPnNpemU9MHhkM2QyDQpibG9ibGlzdF9ibG9iX2VuZF9vZnM6IDM6b2Zmc2V0PTB4
ZDRjMCByZWMtPnNpemU9MHhkM2QyDQpibG9ibGlzdF9uZXh0X2Jsb2I6IG9mZnNldD0weGQ0YjgN
CjAxMDBkNGMwICAgICAgIDI0MCAgICAgNyBEVCBvdmVybGF5DQpibG9ibGlzdF9uZXh0X2Jsb2I6
IGhkcj0weDEwMDAwMDANCmJsb2JsaXN0X2Jsb2JfZW5kX29mczogb2Zmc2V0PTB4ZDRiOCByZWMt
PnNpemU9MHgyNDANCmJsb2JsaXN0X2Jsb2JfZW5kX29mczogMjpvZmZzZXQ9MHhkNzAwIHJlYy0+
c2l6ZT0weDI0MA0KYmxvYmxpc3RfYmxvYl9lbmRfb2ZzOiAzOm9mZnNldD0weGQ3MDggcmVjLT5z
aXplPTB4MjQwDQpibG9ibGlzdF9uZXh0X2Jsb2I6IG9mZnNldD0weGQ3MDANCj09PT09PT09PT1l
bmQgb2YgYmxvYmxpc3Rfc2hvd19saXN0PT09PT09PT09PT09PT09PT09PT09DQoNClRoZSBhYm92
ZSBkdW1wIGlzIGZyb20gdGhlIGZ1bmN0aW9uIGJsb2JsaXN0X2luaXQoKSBhbmQgZW5hYmxlZCB0
aGUgREVCVUcgb3B0aW9uIGFuZCB0aGUgZHRibyBvdmVybGF5IGlzIGF0IDB4MTAwZDRjMCB3aGlj
aCBpcyBwZXJmZWN0Lg0KDQoNCkZyb20gdGhlIGZkdGRlY19zZXR1cCgpIGZ1bmN0aW9uIHRoZSBm
ZHRkZWNfYXBwbHlfYmxvYmxpc3RfZHRvcygpIGJlY2F1c2Ugb2YgcGFkZGVkX3NpemUgdGhlIGR0
Ym8gYWRkcmVzcyBpcyBleHRlbmRlZA0KdG8gMHgxMDEwNGM4IGFuZCB3aGljaCBpbnR1cm4gZmFp
bGluZyBhdCBmZHRfY2hlY2tfaGVhZGVyKCkuDQoNCg0KZmR0ZGVjX2FwcGx5X2Jsb2JsaXN0X2R0
b3M6IGxpdmVfZmR0PTB4MTAwMDBlMA0KZmR0ZGVjX2FwcGx5X2Jsb2JsaXN0X2R0b3M6IGJsb2Jf
c2l6ZT0weGQzZDIgbWF4X3NpemU9MHg1ZmZjZDIgcGFkZGVkX3NpemU9MHgxMDNkMg0KYmxvYmxp
c3RfbmV4dF9ibG9iOiBoZHI9MHgxMDAwMDAwDQpibG9ibGlzdF9ibG9iX2VuZF9vZnM6IG9mZnNl
dD0weDE4IHJlYy0+c2l6ZT0weDU4DQpibG9ibGlzdF9ibG9iX2VuZF9vZnM6IDI6b2Zmc2V0PTB4
NzggcmVjLT5zaXplPTB4NTgNCmJsb2JsaXN0X2Jsb2JfZW5kX29mczogMzpvZmZzZXQ9MHg4MCBy
ZWMtPnNpemU9MHg1OA0KYmxvYmxpc3RfbmV4dF9ibG9iOiBvZmZzZXQ9MHg3OA0KYmxvYmxpc3Rf
bmV4dF9ibG9iOiBoZHI9MHgxMDAwMDAwDQpibG9ibGlzdF9ibG9iX2VuZF9vZnM6IG9mZnNldD0w
eDc4IHJlYy0+c2l6ZT0weDU4DQpibG9ibGlzdF9ibG9iX2VuZF9vZnM6IDI6b2Zmc2V0PTB4ZDgg
cmVjLT5zaXplPTB4NTgNCmJsb2JsaXN0X2Jsb2JfZW5kX29mczogMzpvZmZzZXQ9MHhlMCByZWMt
PnNpemU9MHg1OA0KYmxvYmxpc3RfbmV4dF9ibG9iOiBvZmZzZXQ9MHhkOA0KYmxvYmxpc3RfYmxv
Yl9lbmRfb2ZzOiBvZmZzZXQ9MHhkOCByZWMtPnNpemU9MHhkM2QyDQpibG9ibGlzdF9ibG9iX2Vu
ZF9vZnM6IDI6b2Zmc2V0PTB4ZDRiMiByZWMtPnNpemU9MHhkM2QyDQpibG9ibGlzdF9ibG9iX2Vu
ZF9vZnM6IDM6b2Zmc2V0PTB4ZDRjMCByZWMtPnNpemU9MHhkM2QyDQoNCg0KPT09PT09PT09PT09
YmxvYmxpc3RfYXBwbHlfYmxvYnM6IGhkcj0weDEwMDAwMDAgdGFnPTA3DQpibG9ibGlzdF9uZXh0
X2Jsb2I6IGhkcj0weDEwMDAwMDANCmJsb2JsaXN0X2Jsb2JfZW5kX29mczogb2Zmc2V0PTB4MTgg
cmVjLT5zaXplPTB4NTgNCmJsb2JsaXN0X2Jsb2JfZW5kX29mczogMjpvZmZzZXQ9MHg3OCByZWMt
PnNpemU9MHg1OA0KYmxvYmxpc3RfYmxvYl9lbmRfb2ZzOiAzOm9mZnNldD0weDgwIHJlYy0+c2l6
ZT0weDU4DQpibG9ibGlzdF9uZXh0X2Jsb2I6IG9mZnNldD0weDc4DQpibG9ibGlzdF9uZXh0X2Js
b2I6IGhkcj0weDEwMDAwMDANCmJsb2JsaXN0X2Jsb2JfZW5kX29mczogb2Zmc2V0PTB4NzggcmVj
LT5zaXplPTB4NTgNCmJsb2JsaXN0X2Jsb2JfZW5kX29mczogMjpvZmZzZXQ9MHhkOCByZWMtPnNp
emU9MHg1OA0KYmxvYmxpc3RfYmxvYl9lbmRfb2ZzOiAzOm9mZnNldD0weGUwIHJlYy0+c2l6ZT0w
eDU4DQpibG9ibGlzdF9uZXh0X2Jsb2I6IG9mZnNldD0weGQ4DQpibG9ibGlzdF9uZXh0X2Jsb2I6
IGhkcj0weDEwMDAwMDANCmJsb2JsaXN0X2Jsb2JfZW5kX29mczogb2Zmc2V0PTB4ZDggcmVjLT5z
aXplPTB4MTAzZDINCmJsb2JsaXN0X2Jsb2JfZW5kX29mczogMjpvZmZzZXQ9MHgxMDRiMiByZWMt
PnNpemU9MHgxMDNkMg0KYmxvYmxpc3RfYmxvYl9lbmRfb2ZzOiAzOm9mZnNldD0weDEwNGMwIHJl
Yy0+c2l6ZT0weDEwM2QyDQpibG9ibGlzdF9uZXh0X2Jsb2I6IG9mZnNldD0weDEwNGI4DQpibG9i
bGlzdF9hcHBseV9ibG9iczogdGFnPTcgYmxvYj0weDEwMTA0YzANCmJsb2JsaXN0X2FwcGx5X2Js
b2JzOiBkYXRfb2ZmIG9mIGR0Ym89MHg4DQpibG9ibGlzdF9hcHBseV9ibG9iczogYmxvYl9kYXRv
ZmZzZXQ9MHgxMDEwNGM4IHJlY19zaXplPTB4MjQwDQo9PT09PT09PT09PT09PT1mZHRkZWNfYXBw
bHlfZHRvX2Jsb2I6IHNpemU9MHgyMzgNCj09PT09PT09PWZkdF9jaGVja19oZWFkZXI9PT09ZmR0
PTB4MTAxMDRjOA0KZmR0X21hZ2ljPTB4MzggZmR0X2Noa192ZXJzaW9uPTB4MQ==

--_002_SA1PR12MB86977E312AB3965DFB8D2DD79833ASA1PR12MB8697namp_--
