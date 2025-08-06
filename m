Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184DBC87FCA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50355842D4;
	Wed,  6 Aug 2025 07:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DXjcLVGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B773E83986; Wed,  6 Aug 2025 06:36:36 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B7F783950
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxc5QFAGnhY6PwKq5tRjfEF7SHJVmA89nUzII0TMECF4ADF9LGeXd4CzUF0eKILrLDDz8IRvHZN8UjaXDHNPQLwreKSMiuwt/A9lbJPeTPuz6sx01JePsBXbuQti7HI+F+5X9BQc9mcj4Yry8699CuAWihDPp9tvaT6/2GjNESdJtsyR+UhVlqVj1f5xQ8H8Gyn4DZ07oEqHhR6U0qeydcdBOterex4TItTInYjqkgseHzFNlGleXBB2y8bZT/oS6yFWzspjo2qditR2SGtWTBrsggFS3ymNNFiGzxcS+ePlclOmk6FlleU+d/MbLIEYeHLz4CfUcF3YePmUG1EU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVreBLt2piril5CyR6msr/6x3dHvDgfGJ3WRZZaXLMY=;
 b=Oq19jgNHlkCsb8CSA/radwjBkiiTyjJOFGiPAQDDU3xp6xuh0zUuEAVt80Q+s65FGbj43//pxjH0I1aQr+k8bC84scVyACSexgcmhaxH+xU8b6kVBqi/z7pyk/BrSQUrgNXkmeGQV9EpbixSWUyTjTDjwJ0qrbVtZneFqDsPTLuAocqDzwFg6lCO09Ka1niICx0wpFwIvhAtKbCCnb/EXEGRexU7IfI7picKCEcBv/ekIn5AcRP+0NHoC2IsxcKoAUXU/RqXtH+iNvJefIBy2HZc2IgCF/s4lkLI6AKMOwIwPuBFtRzIxo07JTJDnFey7WSXToToXNi5QUI8+8ZAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVreBLt2piril5CyR6msr/6x3dHvDgfGJ3WRZZaXLMY=;
 b=DXjcLVGlRH8hW6JBTy0nqQwz52/Pe2xSI7248Lf93PyrVujIsVTgGRONFn1Z/iA/PLLiQTpGfvKy3mYoJBjpfAgOGTsCvYVfmjRWy6MkS/O4aLMo9FglOZwer6NaNhtVr39+JQM7+ee7dqrrJYu/69gX1t6vVk4qFKizOVgIhXRrCA62MOGEzaNVD+oicJuQ9SLpat2D8reTVDeTWNbQunrhFXeJnGDFBXcDs0P1azCj6WieHhp8d/XmjXkWT0MmOsVAWvXYn1xOEohP6l9dEapq7RIIhwuCloCwWmRvhLBPJeHpcY48nixp7jXrAuhBmu7xpfz/9X6wjnceGhOoWA==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:36:22 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:36:22 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Heiko Schocher <hs@denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon" <jit.loon.lim@altera.com>, 
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
Subject: RE: [PATCH v8 00/12] Add Synopsys MIPI I3C Driver support
Thread-Topic: [PATCH v8 00/12] Add Synopsys MIPI I3C Driver support
Thread-Index: AQHcBos0QEJ0L66IDEKTCbNwlN4m4LRVCeJg
Date: Wed, 6 Aug 2025 04:36:22 +0000
Message-ID: <PH7PR03MB6942CB28FFADF40750BC622EF72DA@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20250806043235.2260-1-dinesh.maniyam@altera.com>
 <20250806043235.2260-2-dinesh.maniyam@altera.com>
In-Reply-To: <20250806043235.2260-2-dinesh.maniyam@altera.com>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-Mentions: hs@denx.de
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|BY5PR03MB5202:EE_
x-ms-office365-filtering-correlation-id: 0f77012f-2c48-4c34-ba0f-08ddd4a2cbce
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?br12G01XtXiKnjH0HUmJUZJCaflsgUtAgYenc8kkGes0E6TonSkC5tx4w0dB?=
 =?us-ascii?Q?1SVsWR7lTUPhXpJb07SJBD07JcM8x5EX9KO+Xgd6eL1IZMJ12qsBVLbkmkSR?=
 =?us-ascii?Q?eCUhnbr5PBsifeteSI4Rx4IYFPvNmAl/e7krqAEqGRlYSy/mSNhRdYBTjcBG?=
 =?us-ascii?Q?pz3PkMKBitZ0AxWWTKqHVJP4XkyGyk2yHQZr33Cx4hGjyfrCTpuVS1RvaNwX?=
 =?us-ascii?Q?68mUqqlcFNTWhAz9vkQTd8TNZ5IBWwfmAF36EBdO0vVeH9XLrQVjk0JX2pCe?=
 =?us-ascii?Q?yIObNotEuZxMpkotze4GDq3nvUMrTTME+lGiDmorMzjIZtP6sEgInRu5LyG8?=
 =?us-ascii?Q?aoGxaV/elcU5Bc3ckUrtlb0pwp8sstE3gHJ/jpCupSK5tysM4pepfrniiza0?=
 =?us-ascii?Q?FIZrhvcASci1TdUjAMS2TPpbH6VToOIRUu7GHFAC9I+YC9djDDvwPfOiQzBw?=
 =?us-ascii?Q?XWcEva2QuStyuh3ESgZWTmDSwulH1vdIMG7PCG1/0qH6ha7fbQB5B6L83dZ4?=
 =?us-ascii?Q?taOXENiWf7O1k5/Hm6OnPJqhMgLZptSIZPx0aq3deGOhhiANhmhT+iVs7IX5?=
 =?us-ascii?Q?xsZilRNHFDQ1kUbBpeqsbEpwszwS+fHGvuxsAHXbykPwthga0ePk7A+eBp/M?=
 =?us-ascii?Q?WduwYmhm+pwChMmzF5DM0yijrgFAcd+EA/bMJ2hvl5Y42TI9Xujdj62VNzf3?=
 =?us-ascii?Q?izGJCNK3PD4Er4IAgRiROPlKIhbFzUrEvnGK9R0t1ecQsMkzPT90NxX8C6p7?=
 =?us-ascii?Q?GmGwoP2ovE8+nWU7tULCzpWymYdYj5lLx2mEOpw/TIk0NBqOm9NB7geCuMcF?=
 =?us-ascii?Q?LPu8X6a12FPjO2nkO14g86SUvdLWII5zJX7qeKT7wqBYL6Uptkypb6o9I14R?=
 =?us-ascii?Q?cJLizgU3yjLev8qPkuMaIAULbk+ojnZYCNrlOFYh0n1Nhv7NOghw7ADXR2mn?=
 =?us-ascii?Q?q1ZxP6kgJftqp8CCIhPNGtaG7j0tg+u1SspFKYD5c4vpW8cqpBBpAp+TlhjQ?=
 =?us-ascii?Q?KVW0sbu/ds6Ot3f+FAUXPMN91UtMaljRzi71+kcrpgzVO1nRGUtyfrTkjCEH?=
 =?us-ascii?Q?ePykKtZ68kUm8MjH1tYxIP0P4dM6fbftyK6wpRRqy/iXt0njjqdJYi3il+9J?=
 =?us-ascii?Q?wHKktapTpq5aBumlPwJkT+4+QoEQY2a7QwxF08+MtzX8VCvjhtl+AJO2W7wA?=
 =?us-ascii?Q?/rUfmm+LoZSM4q0dmpVs8ggy5s5cgDb4uJJrPycxsJw8D0Sd2bxU0fte1415?=
 =?us-ascii?Q?6PwiAuXEzN7ovflIwVSE9Rtk8FmhfWl1M/L1fGuhSx09iWaaHYQ+9kTMapZc?=
 =?us-ascii?Q?HQXVBx7gy9uzh1t55nHqckuRahMnpUOihZblv1S9Y9VEKp3iJdPlmqSGkaB1?=
 =?us-ascii?Q?vkkv5CvcrCoHjB2yJLxFI2tBGw08VuK5zZNNJbmD7QE7vRB8DZ6KSs/gX260?=
 =?us-ascii?Q?N+4+xZlU6wGb8jfqtCCt1cvDTnhZljzZ71jSBEveqRWQVg4FwMOVsQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LFpx7tb4ioBEt7nZOc//l3I8ayyYZxwEKjMKkuoDngn/GILoy2wjYVCw9zrO?=
 =?us-ascii?Q?1LpgZ1ZvaHkvVW2lEU/fr0ssC4Du1qrKX5kuUBZQrs+Gd7ASqSxSoZYJomZ4?=
 =?us-ascii?Q?wIdIVsqrRLXvi2fYUMzNVVDOrssSFzqhmIkjCaDfDWVCYlCuxBQV0rVfeMq5?=
 =?us-ascii?Q?GijiMzC/nh2F6mJ8NGbGAD9KbzDY2wDs4GHCpLtBP9bmTZ+1dZ8INIa3CnZs?=
 =?us-ascii?Q?jJUJXtHyCYG4e8V8QSD3CEe6pG7qt/JCykOHklyp8IiEaMErNypL3IskzlKv?=
 =?us-ascii?Q?kbzi3UdHQ/01O3WAZ+mXvf0z6SfyxR4Z/J8yVOCL81NKqQhcjGJw8knbKR4r?=
 =?us-ascii?Q?hAKoMsVi/vdOVMAi+Gyx7jrNCVmyw2CvFnEYWmEJtBatHAIT4+uhadkxsQAX?=
 =?us-ascii?Q?cM4R/Pzj2kuZw+Z1XwTXrgtlZq57U+usKwcN0lYxpNNo2BebAJrrPE1A4lJO?=
 =?us-ascii?Q?DMvtBx55OJdv0YkFtleu0r7BcSdiLzsuLCB1VKuHidIMCugDSobBcTBTmXr0?=
 =?us-ascii?Q?jskLXnnMdQYtACvBV7otUJYzVsWIMLVASEUxT7GXUGj98qDSCLxgBBQrrhvP?=
 =?us-ascii?Q?KWlDlIBZUKQBqa1UQCYPZJtogJJHe8Jxrvf/2CLy7pK4i58mP38kp/FIg+10?=
 =?us-ascii?Q?z8HTgTDeLc4l1ZaaQ37QV497aYJv3sI1VWah3kPxMFXeHtwzvtzQOYY0yF9T?=
 =?us-ascii?Q?1INsZA6ICOR936UaE40zS6yf1WWqC0xy3prdCyMq1y7xdEjEuHbKPVIt4gcl?=
 =?us-ascii?Q?s2K8WzqaLPgs0s0ZvVnvmIRPqPkx8+JRCAKWvYejXeG3r1SiGUj94dULnEC2?=
 =?us-ascii?Q?tzh+P6tFXfIL/+zPUWx+5kkF5KdBAF7cRh5kPcvIRFvUjkpyg2wdAd6tWQhi?=
 =?us-ascii?Q?yueHYFJGhbmqMsYZGrtEV/OJD846iLsohuqySGL0BBLAXvmKgTpf7iuiHAOM?=
 =?us-ascii?Q?Tf40DwSWkKA4m+uax6+tcc6ldBTLalGCBAxWbGxhJ5uSvEllXeLAqmLPxt4r?=
 =?us-ascii?Q?07AmQv81v5hWsuN+vdgcsVN5gf5HqaoeSTYadchdJCR+YtcM9kOZbYQLuuNN?=
 =?us-ascii?Q?BKW5KVTeic+ivQG4Fbx1v1cfz11jGEc7jM3sri6iRWJ2NWk5WPm5b/xXfnEK?=
 =?us-ascii?Q?JfwJfD6cZZ0a691Rq2WRG+YxdW8pgRUexF7ydIwgaJboDBOcpmT8igAPwbCT?=
 =?us-ascii?Q?DVoezjW0o7lqUAfyOayUbCXA8Ty4k+3iVgP0hcamUSElmyF7ePz3MiEW17Xt?=
 =?us-ascii?Q?TqG6e01BARGIhVANgXmrrw1MB/PSr5PMqrour9X4vRyFXVYGtQIbVfqs04dX?=
 =?us-ascii?Q?V5/PQXcikLshz6THFXYtoTK8UVz0z0rHI/ZIAqGmey0xvQA1mkZy5IWZwXKi?=
 =?us-ascii?Q?BA3MLSFZ0+/mVLP534oE7v8KFstTeZIE1RevkL2Zx2ftkQPBJMfM0WwreIXz?=
 =?us-ascii?Q?NGBSfgdmM5Qmihtbkl42w4GWRN5knQUCZJKD8W5tgfZbavkpw9PA3j8ocSt+?=
 =?us-ascii?Q?2cI20x9/PjN+DOg2DK5tZmwvPZsOPZeKO1dmUiRd7qTF7gyPTpE+HCmbLsJR?=
 =?us-ascii?Q?7FcaGcw4c0rYdgPTVeWM2kDZ9j+3wjqMFlI6tbTkXJT/hIqvghkKbW4I6Rvz?=
 =?us-ascii?Q?UQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f77012f-2c48-4c34-ba0f-08ddd4a2cbce
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 04:36:22.5472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wY0vrO/KBIhmG/qgtnISbgH9Ni4pCbpwBirgOkSKwIl3aPmVZPGaXdhwae4yt4QtD6BtGUbeN+SIyWg+//qC6AwYVpqJuZwi9N5K4mUWOag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5202
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

Hi @Heiko Schocher,

> -----Original Message-----
> From: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> Sent: Wednesday, 6 August 2025 12:32 pm
> To: u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Heiko
> Schocher <hs@denx.de>; Dario Binacchi
> <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
> <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
> Reichel <sebastian.reichel@collabora.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Hea, Kok Kiang <kok.kiang.hea@altera.com>;
> Maniyam, Dinesh <dinesh.maniyam@altera.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Lim, Jit Loon <jit.loon.lim@altera.com=
>;
> Dinesh Maniyam <dinesh.maniyam@intel.com>
> Subject: [PATCH v8 00/12] Add Synopsys MIPI I3C Driver support
>=20
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>=20
> This patchset add Synopsys MIPI I3C Driver support for Intel Agilex5 devi=
ces.
>=20
> The i3c driver is leveraged from the master/dw-i3c-master.c, i3c/device.c=
 and
> i3c/master.c Linux version 6.6.37 LTS And few header files included to be=
 part of
> the migration; i3c/internals.h, include/linux/i3c/ccc.h, include/linux/i3=
c/device.h
> and include/linux/i3c/master.h.
> Additional i3c uclass driver and command files added to support i3c read =
and
> write in U-Boot.
>=20
> Patch status:
>=20
> Detail changelog can find in commit message.
>=20
> v8->v7:
> --------
> - Patch 9: Make the CMD_I3C dependent on I3C support
> - Patch 10: Sorted i3c.o in alphabetical in test/cmd/Makefile
>=20
> v7->v6:
> --------
> - Remove extra variable in struct udevice
> - reuse the existing dev_ofnode to get the node in  master.c
>=20
> v6->v5:
> --------
> - Resolved documentation warning in include/i3c.h
> - Move declarations to the top in cmd/i3c.c functions
>=20
> v5->v4:
> --------
> - Add header file to doc/api/i3c
> - Rephrase function description for i3c.h
> - Separated subcommand as a function for cmd/i3c.c
> - Used memory address to transfer msgs from i3c
> - Rephrase description in cmd/i3c.rst file
> - Replaced int with unsigned for positive variables.
>=20
> v4->v3:
> --------
> Resolve ci test:
> - Add i3c node in index.rst
> - Formating error in i3c.rst
> - Resolve cpu_relax undefined for sandbox
>=20
> v3->v2:
> --------
> - Squash commit 10 to commit 9
> - Resolve index for new files to pass the checkpatch
>=20
> Commit: sandbox_defconfig: Enable configs for sandbox i3c
> Commit: agilex5_defconfig: Enable i3c configs for agilex5
> - use savedefconfig
>=20
> drivers: Enabled Kconfig and Makefile for i3c support
> - Add maintainer for i3c
>=20
> drivers: i3c: Enabled Kconfig and Makefile for DWI3C
> - Add empty lines for if/endif
>=20
> drivers: i3c: Add i3c sandbox simple test.
> - Removed DECLARE_GLOBAL_DATA_PTR
>=20
> v1->v2:
> --------
> Reorder commits.
>=20
> Added commits:
> - drivers: i3c: Add i3c sandbox simple test.
> - test: cmd: Add simple test for i3c
> - configs: sandbox_defconfig: Enable configs for sandbox i3c
> - configs: agilex5_defconfig: Enable i3c configs for agilex5
>=20
> History:
> --------
> [v1]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250218025705.50051-1-
> dinesh.maniyam@intel.com/
> [v2]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250314040902.43621-1-
> dinesh.maniyam@altera.com/
> [v3]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250324083704.26259-1-
> dinesh.maniyam@altera.com/
> [v4]: https://patchwork.ozlabs.org/project/uboot/cover/20250417021840.621=
2-
> 1-dinesh.maniyam@altera.com/
> [v5]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250513101913.30880-1-
> dinesh.maniyam@altera.com/
> [v6]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250513101913.30880-1-
> dinesh.maniyam@altera.com/
> [v7]: https://patchwork.ozlabs.org/project/uboot/cover/20250728065612.603=
9-
> 1-dinesh.maniyam@altera.com/
>=20
> Dinesh Maniyam (12):
>   drivers: i3c: Add new i3c uclass id
>   drivers: i3c: Add driver for MIPI DWI3C
>   drivers: i3c: Add i3c uclass driver.
>   drivers: Enabled Kconfig and Makefile for i3c support
>   drivers: i3c: Enabled Kconfig and Makefile for DWI3C
>   drivers: i3c: Add i3c sandbox simple test.
>   drivers: i3c: master: Enable probe i3c without slave device
>   i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
>   cmd: Add i3c command support.
>   test: cmd: Add simple test for i3c
>   configs: sandbox_defconfig: Enable configs for sandbox i3c
>   configs: agilex5_defconfig: Enable i3c configs for agilex5
>=20
>  MAINTAINERS                        |    7 +
>  arch/sandbox/dts/test.dts          |    8 +
>  cmd/Kconfig                        |    7 +
>  cmd/Makefile                       |    1 +
>  cmd/i3c.c                          |  271 ++++
>  configs/sandbox_defconfig          |    4 +
>  configs/socfpga_agilex5_defconfig  |    3 +
>  doc/api/i3c.rst                    |    8 +
>  doc/api/index.rst                  |    1 +
>  doc/usage/cmd/i3c.rst              |  146 ++
>  doc/usage/index.rst                |    1 +
>  drivers/Kconfig                    |    2 +
>  drivers/Makefile                   |    1 +
>  drivers/i3c/Kconfig                |   27 +
>  drivers/i3c/Makefile               |    5 +
>  drivers/i3c/device.c               |  262 ++++
>  drivers/i3c/i3c-uclass.c           |   38 +
>  drivers/i3c/internals.h            |   26 +
>  drivers/i3c/master.c               | 2066 ++++++++++++++++++++++++++++
>  drivers/i3c/master/Kconfig         |   11 +
>  drivers/i3c/master/Makefile        |    3 +
>  drivers/i3c/master/dw-i3c-master.c | 1062 ++++++++++++++
>  drivers/i3c/sandbox_i3c.c          |   56 +
>  include/dm/uclass-id.h             |    1 +
>  include/dw-i3c.h                   |  252 ++++
>  include/i3c.h                      |   93 ++
>  include/linux/i3c/ccc.h            |  385 ++++++
>  include/linux/i3c/device.h         |  286 ++++
>  include/linux/i3c/master.h         |  698 ++++++++++
>  test/cmd/Makefile                  |    1 +
>  test/cmd/i3c.c                     |   50 +
>  test/dm/Makefile                   |    1 +
>  test/dm/i3c.c                      |   34 +
>  33 files changed, 5817 insertions(+)
>  create mode 100644 cmd/i3c.c
>  create mode 100644 doc/api/i3c.rst
>  create mode 100644 doc/usage/cmd/i3c.rst  create mode 100644
> drivers/i3c/Kconfig  create mode 100644 drivers/i3c/Makefile  create mode
> 100644 drivers/i3c/device.c  create mode 100644 drivers/i3c/i3c-uclass.c =
 create
> mode 100644 drivers/i3c/internals.h  create mode 100644 drivers/i3c/maste=
r.c
> create mode 100644 drivers/i3c/master/Kconfig  create mode 100644
> drivers/i3c/master/Makefile  create mode 100644 drivers/i3c/master/dw-i3c=
-
> master.c
>  create mode 100644 drivers/i3c/sandbox_i3c.c  create mode 100644
> include/dw-i3c.h  create mode 100644 include/i3c.h  create mode 100644
> include/linux/i3c/ccc.h  create mode 100644 include/linux/i3c/device.h  c=
reate
> mode 100644 include/linux/i3c/master.h  create mode 100644 test/cmd/i3c.c
> create mode 100644 test/dm/i3c.c
>=20
> --
> 2.35.3

Submitted v8, corrected the minor nitpicks.

Thanks!
