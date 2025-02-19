Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803E8C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D93F980F7B;
	Wed, 19 Feb 2025 14:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="l305mric";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A49C80C98; Wed, 19 Feb 2025 08:20:17 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DEDC801DE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9t3xaTjdh3WNPd4bDKGk7VAYC2B7tCnVpj/N8vl+C1j7SAwO5jIZ+WvqPTdaVBwBdl0B5VegqGmY4pUqcCH0fM623tLR14Et8d9+nXxQuqGDeUwZoeFmbR4mX0lL9d91MOqbP2rzYr4vlAEhAPy/CWmjn5VrVtwkSmkGxCznDuly2idJJ/JsCfX5FBqp+IsN6GBQaES50SBNvknxDbvqc67CdPnkTzTukLQzNrUwhXEtv+AJKx5u3g9Zxx3K7FVVte4vYbxGwn0NPiDRSvuXB4pFD+cWGSJIIymCvd0Xiz1QXebvsUF6m0WmYp5EZHskWlTIglWsDqtSCJtg/ugvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysWTQWR763xbtHnK6G/jF5CRhpSkjcpaTO4SOdyZg7U=;
 b=J1at3JLApUHRVYUZqN6TmjpejXhivEjCAiNbyqM/r8qspAhw0DvTeCHCSbFHMyPP2BYX2wirJHndnq/IdNUUh7lLu3FIAw/MdtDcGAGpXlPrRRl73VLE42Eti01hATuH5z6AcsuAt7lLLUMj2VtuDk3sYe9OqbGvRe+PkGBZpdysGKHQDldli1BuJMC0cBb+4KmmQ76OLvEH9IyzXj+hLJvldDXfzRvaucTvTOBzI/ZRNNNEHilwmOMYJT6twju3ZFFSKrhPrhnF8HFkAIiDk6rljVZEADLqjiOMFSSbiQj32axHQsDHrSyo6RIWrZtCOv0WFAgDdsjvggNIbkiFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysWTQWR763xbtHnK6G/jF5CRhpSkjcpaTO4SOdyZg7U=;
 b=l305mricEgGVAJ7dX5v1rqdmQf0148+tuyXKuiMC30uUjaAkF6000xExnZcUlbnghpbLpDNesAYFZh4TngXXEbp0gyAqCHXrbDrRJ3Lxu6CscG/cH+GmbnfarP19MvvldpclCk8G0roAWejsp2eDs+ytrzwWMRQ+g+Fq+buvgu09FxCWeLLRZmRB1SbQPL6BQqR8lClZEz4WX9kyYw1EHmuz6t5hPz2vcTMm1wKIbypX9RMGqlVu+wUyT+lR3KRiWVLjVGT6sYMNcaWAxFwnm7bhtyV8/lXbd/7D3WBL0D16v2OQwVE1gt5H6i4KrZTxap3Pfpe/zm578Lo+wY1KGw==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6679.namprd03.prod.outlook.com (2603:10b6:510:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:20:11 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:20:11 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: RE: [PATCH v2 07/26] arm: socfpga: Disable GIC for Agilex5
Thread-Topic: [PATCH v2 07/26] arm: socfpga: Disable GIC for Agilex5
Thread-Index: AQHbgeAYxAGd1Km4G0ujPLKJpUecqLNOOaQg
Date: Wed, 19 Feb 2025 07:20:11 +0000
Message-ID: <SN6PR03MB358396D2BD15CBF0CB9445D2A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-8-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-8-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6679:EE_
x-ms-office365-filtering-correlation-id: 6adc43c0-1aa2-414c-e9e3-08dd50b5d8da
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KcJEVR2ChyJvETedLNXBlAeAcVBfxiDGClW+I5LFnq4r4SSm8GJu+eBDj0MK?=
 =?us-ascii?Q?qOvOXK4ZmUpMjZm+302dqOZnOchjD45h9RCYxcksrh9B5sXU4Gvanl6XNVlK?=
 =?us-ascii?Q?jbux0K0/pddYZndUdmTvzSaR8yk/v5L7LPjO1FW/sK/DgtHx7vPo5LsdDBU1?=
 =?us-ascii?Q?A2abLgKaFlpZ+Ly1woMopb2ST3sRdH5DhobcXLshgPH7yxFHxxMJN/GZKaEW?=
 =?us-ascii?Q?iPKdpciRA4ZQqmes4KLyv1pzvaeFgiOM33PAcDcbFcmtEHAJPSezCYOBR7r0?=
 =?us-ascii?Q?JUE8rZQwZyjIimkgb4tWoAAka1JPeDpAC5iKQiyFoqYdB9cYMb7iFgRp0yT9?=
 =?us-ascii?Q?Hx/CNxShQEJPCKNreI/L90CcHttsCqwFPH+qbIgDqYtcRorr2Xn1nO1ww1+d?=
 =?us-ascii?Q?hfoc4uxdtY7gf/uoZhkzfU+/HlypnmbMIBiflshU8ubFb025EICYe/ZAP5FX?=
 =?us-ascii?Q?LF2RKd+N8KGUy5kVIKI4tOMbTybhPBscD/ytIThKIPzyCxAfNuYaZgGZVTwQ?=
 =?us-ascii?Q?F+wnelEmLIrxkXiyk1a0Cr3VRUW4zANooccj0GwOC1d9hjXCB/UVSZj0VP2w?=
 =?us-ascii?Q?4sWPkMDjw10FiPXLkNuHVHhe2bDg12zeZXx8YLvzODnCxjik1sMz3Mnxzp2/?=
 =?us-ascii?Q?IIHZFHUXAOcweDeC9eFQR6tmBhcACcXilybNUVS4aToG1vE4FLaXeZ3c0i4A?=
 =?us-ascii?Q?qxvrYWHoN+CrGBK5y5N8yINzrcadNfjo9tzxsjrDfxFcS4BqrAOv3TzyG64c?=
 =?us-ascii?Q?S48J4DU5H/fk34LQ1MlTUnfoIaSjnVHkmh3Y4Zk2PcMEidFBFRSPCKyjXurP?=
 =?us-ascii?Q?mMw2LiGf1FvDJTKoqYdlQtsMZOQugmGzj1RnfwuQVHbGv+sN19QAeHYdtpwz?=
 =?us-ascii?Q?31Mza7FYLZo5o7MXU2kQm854+JLjYsdvlzEpTbJhL9Lw/Aar0KeNC9JJqj4+?=
 =?us-ascii?Q?+CgO5PLcY/K0bVNNBxTAvprY6a/dHabs8+nFinHazO8eh98/MP66twde02MV?=
 =?us-ascii?Q?x3SfNT3kV7Mk7QFD/lmsyEhoN9DkoGKLyqJpi+ng8/TUZPf0wjCpGQ1XwJ4D?=
 =?us-ascii?Q?NFJ4U9O4QHUlLa/hW2/kn5LradQux0YyAt6TURhNHM2PsythCx2CZdV74Yx2?=
 =?us-ascii?Q?DVAzF1KxdCSO+0anW/4vXI2SKGjrtDvAUXJQ9Avx24QcNswdWkSiVVrzoGnN?=
 =?us-ascii?Q?x94sUV2baSQFHWL8f5vWNOPvIKj6Bizvw+V4a+h4grGz2FnWjZJ85n/6GoXf?=
 =?us-ascii?Q?gjxnPF8TQMgXaibjptSeRj3MWCQjplzKCRhPBPKG0ZwiZmb1PP2m3tvZDo6c?=
 =?us-ascii?Q?o2MlvmNcF7CwdiB6dvx5hQEcqYmlB2bakLoz9XnsqAwTHc2HyhlTyvFWWKzo?=
 =?us-ascii?Q?FEfu754mE5k9QoKxYNgg0ScsgPG2noZ+5k+US/hM3KPNjZ4k+/FjY0Zx075f?=
 =?us-ascii?Q?Vpgy3YVHkwz8xI6JfZLVRc72DcnGMhLG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Emutya6edKc3slXLDZDHRsW9OYMQKyK26D+TcA1QLpSkQDATGVYNNZ1ICQvi?=
 =?us-ascii?Q?TVyZhQbW+koAr0peSHahq32GbSVcxmKZxwzq9MMYCr9ga9iyit1esSL4d/02?=
 =?us-ascii?Q?o1tiF1iTjMNnhjcIPUuOj49Sktcef4ycIUNSVaPnHIGsByDJCjD6MQcG77tw?=
 =?us-ascii?Q?MMDdD4jrIafVY2r3dmiBrI6rwGWU9m8kXdanxzbQ7SWt0JqCo2qnxnY0DluJ?=
 =?us-ascii?Q?c7egNSvAZV56HHOJdPWI7LIxmu9wRjOE2GUIucmlQBaH8PXT9XRyrsJqfljc?=
 =?us-ascii?Q?xykoglPEJ+bxdkKDHMzvCI/FoGhyKq0enrMG5GD10rM8ZrJcKhu8yVyJm4+q?=
 =?us-ascii?Q?XGCBrEqnrtJWc3S7KheDYUkQJPtkpVfQ+NxfMwMktz8j0SoXLOtr52k3SMXN?=
 =?us-ascii?Q?vfg8dhO+YslUcMGpxsBZMwO3Qk+31Kv/lRfWEknDA7P0slqbaVxX39HdiiAo?=
 =?us-ascii?Q?9Fe3hu05EH+5f7NcA4SmqCQBZaOK24yQK7+S4QaWC/PvTAN6JnnowtlnXU6D?=
 =?us-ascii?Q?I3nlSE2aZF2ObPqdQwM5u+/B0+Bl4DDGcFubHfb2PIN3o9SmCYlOqBxigF5K?=
 =?us-ascii?Q?HupCmGk++xNDT5C8/ZH1WF2RRHxXpowEuDexzf1jjsfQv4n6eaRvrwSL2kv2?=
 =?us-ascii?Q?pOetzhdLoPmnt86P7b+JfCU1G4jfXzEiSb/0gRoWFTrOJrHMc82XwKpWZ8Ch?=
 =?us-ascii?Q?5yoSd6gxNwv2NTJe6OM4quF8gP+J048Md3ZqA2BPh0o1r2d7TgaRewLQs1j/?=
 =?us-ascii?Q?isavAKppisNucxMrYM6jJ5Bq0g/KwkJEKuAR+4a6oY9LhVvhxNiFVBuOMp+n?=
 =?us-ascii?Q?MzgZalI5+mf7uHiZM9+cQlrit1urVMEYDXv1ItJNdcLLtDzWRdJ1tFBz4T5v?=
 =?us-ascii?Q?pPQtUsx+rNYUYopSJnxwg9XB5jeMpPTgR49W2RPtTaXHX43j8yUv4HkcMsqy?=
 =?us-ascii?Q?BtI3qsN6cUgKwnrKPtgz/GHlvw/O94dxygUVnsVLNrBJy4HTCTIBqAyZzGT+?=
 =?us-ascii?Q?7IeItmSGNHzRTmNAyig+ciddfag49yYt4IDwsFdU75oAUWEnGieRGjiw+zW2?=
 =?us-ascii?Q?WnY4Jd+5BjhK3ExoasVotry8AsoiFDB5jujZ/bGn1nkJf+VtMH7DDihOWn2i?=
 =?us-ascii?Q?sn7uLnOqNUHa9Cpcgbyf5ZaPcvX7w8Y5vauHjs2ZlOyLG12oNuZ3yXIFD9x/?=
 =?us-ascii?Q?HvYgFqIWlUEBTzrjNF0OmfLgZbNeKLIpAOIJ5j7+45v4lwZBieQQ0s7u4EKJ?=
 =?us-ascii?Q?RxFUg55f5YqMGZ1lWxzA9QE7LwAhC1czp8qDM+3RytY8MhuMNtgAZVIR/7PI?=
 =?us-ascii?Q?J3UYjtbmBLVMs7yxAjJxZUSxS7GhdUQU8LYfuCZZOgpXYyiUpCXUA8JjFv+q?=
 =?us-ascii?Q?F7PcSEFI9jjS0GjRruwbWZqbvfo8AOVLxUuG7Pe1dfr+4Tygr6MhuL3Zzw0m?=
 =?us-ascii?Q?73zpAZJwo5FD7ARIsPnhrDRkAvunlONlfUx90zvafYN93ye6yACcHrni2JJD?=
 =?us-ascii?Q?+C56P6qx72SW4ThGBz0etVcWdGmzOIFqR9SDczwrkYQBLrylaiBr2PvLW8Uh?=
 =?us-ascii?Q?HtI0TXVl9B/NAqgVBIDwU55dputYjRm1WmBkDCV/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adc43c0-1aa2-414c-e9e3-08dd50b5d8da
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:20:11.3714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ZHnSEonpsnNUjvuvHsAbeKMaLyHYSXamiTOZ3b+PaUisIsTA/sRRzvA74Dl9VeNcKFjU4Kv7fesvtzN/O/s2i08x2/QWqM2KqUpvgLD+EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6679
X-Mailman-Approved-At: Wed, 19 Feb 2025 14:04:13 +0100
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



-----Original Message-----
From: alif.zakuan.yuslaimi@intel.com <alif.zakuan.yuslaimi@intel.com>=20
Sent: Tuesday, February 18, 2025 4:35 PM
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Yuslaimi, Alif Zaku=
an <alif.zakuan.yuslaimi@altera.com>; Meng, Tingting <tingting.meng@altera.=
com>; Ng, Boon Khai <boon.khai.ng@altera.com>; Hea, Kok Kiang <kok.kiang.he=
a@altera.com>; Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v2 07/26] arm: socfpga: Disable GIC for Agilex5

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Status polling is used instead of using interrupt controller for Agilex5.

Disabling GICV3 in Agilex5 target, as well as disabling GICV2 enabled by de=
fault for all SoCFPGA devices.

All the other SoCFPGA devices uses GICV2, thus enabling GICV2 in each of th=
e devices.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/Kconfig              | 1 -
 arch/arm/mach-socfpga/Kconfig | 5 ++++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig index 3ed9494dfe4..865a56e=
2c8d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1110,7 +1110,6 @@ config ARCH_SOCFPGA
 	select CPU_V7A if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
 	select DM
 	select DM_SERIAL
-	select GICV2
 	select GPIO_EXTRA_HEADER
 	select ENABLE_ARM_SOC_BOOT0_HOOK if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA=
_ARRIA10
 	select OF_CONTROL
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig =
index 6b6a162f568..a76a9fb2a39 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -55,6 +55,7 @@ config TARGET_SOCFPGA_AGILEX
 	select BINMAN if SPL_ATF
 	select CLK
 	select FPGA_INTEL_SDM_MAILBOX
+	select GICV2
 	select NCORE_CACHE
 	select SPL_CLK if SPL
 	select TARGET_SOCFPGA_SOC64
@@ -64,7 +65,6 @@ config TARGET_SOCFPGA_AGILEX5
 	select BINMAN if SPL_ATF
 	select CLK
 	select FPGA_INTEL_SDM_MAILBOX
-	select GICV3
 	select SPL_CLK if SPL
 	select TARGET_SOCFPGA_SOC64
=20
@@ -74,6 +74,7 @@ config TARGET_SOCFPGA_ARRIA5
=20
 config TARGET_SOCFPGA_ARRIA10
 	bool
+	select GICV2
 	select SPL_ALTERA_SDRAM
 	select SPL_BOARD_INIT if SPL
 	select SPL_CACHE if SPL
@@ -118,6 +119,7 @@ config TARGET_SOCFPGA_N5X
 	select ARMV8_SET_SMPEN
 	select BINMAN if SPL_ATF
 	select CLK
+	select GICV2
 	select FPGA_INTEL_SDM_MAILBOX
 	select NCORE_CACHE
 	select SPL_ALTERA_SDRAM
@@ -137,6 +139,7 @@ config TARGET_SOCFPGA_STRATIX10
 	select ARMV8_SET_SMPEN
 	select BINMAN if SPL_ATF
 	select FPGA_INTEL_SDM_MAILBOX
+	select GICV2
 	select TARGET_SOCFPGA_SOC64
=20
 choice
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
