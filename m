Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24895CD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 16:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F57E84671;
	Thu, 28 May 2026 18:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=axiado.com header.i=@axiado.com header.b="r6XNuW5i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B0F846A5; Thu, 28 May 2026 18:24:09 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD330839A8
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 18:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=smtong@axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCxwUR+T3WEp+plkrRiMm11YyKzhuaPIB70G+e3WmDN7ItjRY9aAfy/B2/YWY7fE3wFpq3l6C9AE9yp2eSj71dwaIK7W/x+8DkCTL56XuG8K92E7VwZeaVWNjUykBDcJdxlOG+PWSVzKiUXgmH2uADQghl46jN/sNMziarJ0Ix++4YH0Fqcgjm5jd4aWnvto5r/landAO7DLNgkm4uJ+BATI2VzkdAMnZ63PwxcurTXPlzPnvhHD6N/bF4L3sNnHoxDcnM1kkc6+pJehaqIEDZ1COLPW/6LlQJFycM81aNKX39XTlgBzeJxVLX2bwBUsEhrpItBA/Gn8q+wcFm9lig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e25RPRECLFwVRPn5tu/VSMNQl6htSsP18PNEb5DdNzc=;
 b=OBWTYAbiRtNI+jfsIL0ptZ5tjXKP2yXXDQJp6CBGPBMVX6kDSg9gU3BOD6YlAiNllE3tDRdelOwbZ65ecCmmB7ptZaby0rRprwe0lOM/O4krOwcmm5KsWEHBYrTQUZECIgRWtAwzFNOkU4fQQu6Hdfpf3KqhC14Csg4FW3MLnFzi5GZPI3Xq1XH1oKsoJSL4BZVKwec+QoZ2YHW2GuurcTa8906FmH9TaWetgZBuT7pHMFwrreklfuwoEpGCDNwGRN7vcj5oipQ+SfuGpkWWYu/7x6klzDenlMH/0nc/bx6B8RzqAV6lhzxxizx0/BRJGJZ3MuBEHmQO3Q5nqXkvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e25RPRECLFwVRPn5tu/VSMNQl6htSsP18PNEb5DdNzc=;
 b=r6XNuW5iVHxgfl/kj13A/bipTpGoQ1K8NKqaJftdi/5jiSRCNObTghGUWKVf4Ln60U+lph5f2iiqC+fAVwc9j3LuJjDuKnRKKDq9n4SmIyF3RDStJW+wO9KNPb/Hv4OVz3vkBiTApgVUuTIoKeyV1dmk7lLkrt7UzjvRs3h3RW7ZXG9ZMXYh0fXRp57CgafoP/TSt5XN5zNJbasOYOZ/VNLfZlz6O7V8X3LKlHCfcvgDHMHjKsgLmuEBKjMSwrU15iVUXvneJ+3cuS5tw8bqcC/ZUQfRaWWbnCJYbUWuJEe0Upr1yTUKFIsA/TzMrcLpIqTItllbRP2DM1a4DJtNpA==
Received: from BN9PR18MB4188.namprd18.prod.outlook.com (2603:10b6:408:103::24)
 by LV1PR18MB6399.namprd18.prod.outlook.com (2603:10b6:408:2b4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 16:23:59 +0000
Received: from BN9PR18MB4188.namprd18.prod.outlook.com
 ([fe80::31fd:87fd:7a41:d0f]) by BN9PR18MB4188.namprd18.prod.outlook.com
 ([fe80::31fd:87fd:7a41:d0f%5]) with mapi id 15.21.0048.013; Thu, 28 May 2026
 16:23:59 +0000
From: Siu Ming Tong <smtong@axiado.com>
To: "trini@konsulko.com" <trini@konsulko.com>
CC: "andre.przywara@arm.com" <andre.przywara@arm.com>, Karthikeyan Mitran
 <kmitran@axiado.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, Prasad Bolisetty <pbolisetty@axiado.com>,
 "sjg@chromium.org" <sjg@chromium.org>, Siu Ming Tong <smtong@axiado.com>,
 "sumit.garg@kernel.org" <sumit.garg@kernel.org>, Tzu-Hao Wei
 <twei@axiado.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] arm: axiado: Add AX3005 based SCM3005 board support
Thread-Topic: Re: [PATCH 2/2] arm: axiado: Add AX3005 based SCM3005 board
 support
Thread-Index: AdzuRukLVGB4el2DRMCBUP/vj+YnsA==
Date: Thu, 28 May 2026 16:23:58 +0000
Message-ID: <BN9PR18MB41883375E85F8CE353018080A3092@BN9PR18MB4188.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4188:EE_|LV1PR18MB6399:EE_
x-ms-office365-filtering-correlation-id: bc2e33e6-36a6-4726-c6c4-08debcd585b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|8096899003|13003099007|38070700021|3023799007|18002099003|6133799003|56012099006;
x-microsoft-antispam-message-info: xZp/qBEi0793ZDmqJiYXQNNXMZsHO6RPvmBXjZgz4H0aXtQio49mW/Vdg3G0PwmhqdPPqpaKRmUJC1RBIBIsB+cC1GseLJPh6C1J4IOTFYDZoHtvpKXgz/Iv9onXDg2Mv7YIYsynyO9iaGbMCWjmenKArMO5gJkFB2wMNZsgRb5naLxGtmdKJHA8KsIsDGkKnVBAKD8Wpw3U/qX+0rw5bkvQ5Bj3fBWWqzKrKtLxUtyAk3zWKS10NyZM3Vl1E6ypW1uv8HWP2Gh5zybsjfmQbwglahb/vUFIbGRwbLxwKwv1fDacUzQI9omPpn55nnY3JGYaALExEkya3YXbF1nqqE1hSkJQCgq0DQJ5PwxIWAzp6Oe3H+bCV5ck5oTcRayea55OcSL1RrTvFxpOy2M+rOzQLxEMABlgigGc94JCKP/VVtnoUc9QzIKxSzqe2ExQfVFnF9Jb3mEuZcdCruC1U4cEJN0w17TdG2i9PDJ+nFMu31mboI77bQWX7OvNK9BsMWKoyoaUoF59g2Udx+XizrcHtbx7QLgNNSmha9UrLk/kAEgLps0rT29m0gxezchyjYYeg2QMmFvxWftsnCNyaFdu74HNz+07ifnsFyPFQEADvCHlpWq8QjIxaqP/dUh+8sBGRdWr9OZbprW1qB7e/rgc7N41a9pTwhcfkQ+flqLaY6pmH6oalitvT9r9Telo7vOtI/NyGBbxxaHG/tQ4a8mLdikE7IfoAuTo0vEarwiSG4xQ87aRW6ieNGiEfZiv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR18MB4188.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(8096899003)(13003099007)(38070700021)(3023799007)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zikf4SgW657ofymq2io9vsbuxzhnd0xOvNbPrfJEb0tQBRcwT5jCrx9nuiCM?=
 =?us-ascii?Q?h2bQe1N0Z8R43x6p58CFcGWQY/PWDhyX/UhS0W362e0FwJDr76TF9GaGIkud?=
 =?us-ascii?Q?YPHysaMVC6R4IvgAAy46F3Zw7wPHbfhLlEAyBfjxcoEImQYUuKAsoi+rKPuv?=
 =?us-ascii?Q?ql26AYgRhCD2eBdplbHSt2WNKjNmyelHMBWJk3DSMSeiqRUq/bpFPuTE72dy?=
 =?us-ascii?Q?PFoy0foF+6KtmylxBDpBxp/tfCp8grtvW/Orokii86Ugh42lg4Y04giLh7x/?=
 =?us-ascii?Q?pQUshIfSjwv/F/qb3X45H7abWGeH156OnRYTX7ERvj+TWoT09FO/+rPByxUr?=
 =?us-ascii?Q?Xk+U2unBdlA4ZUmFmv+Z3Z9fekzUEEioQEX9CxNBlA4P2oX7yhcljekA3g1F?=
 =?us-ascii?Q?MACaNFq4Nm1zZZzaZ9LjO+rl5XBTE75ZKkkZVWdFjoRrQ+zqimkN396wzH0O?=
 =?us-ascii?Q?7GfPxuLd0Orhe9+f8TD6X+GUAQ0lV5vEH4qO96sLmAxwLzT5vSa1iVfNr8At?=
 =?us-ascii?Q?HypWhgq2DfGhn67+Omvb/M+rqhaRGowVxs7VCPAi/axqKY1hAxq9vh2Vbvs3?=
 =?us-ascii?Q?jIQvLy9aSJDnt3hrOZ6phDKbiNb1Oh786T0zr1t20twjB2dh1Dci+ZQafzAN?=
 =?us-ascii?Q?8G3vLdlVXDS7xuRvJfTyRgSosXH2k8fMxhNLf7GByp8dNLP7R+jBMzhE0XR7?=
 =?us-ascii?Q?mbrCrIhBIWEZz+GTCdVHG+CjdYVIzysHibAOWuReK675jQJyQYqiqN7MPCQs?=
 =?us-ascii?Q?TzTESqO1B1YuCoXj3znmaDMoHBB7jKHqCYDVM3kBs0fS3KXnR+tr4gAWJjPf?=
 =?us-ascii?Q?RFwysiz8krbVEIA/CYfnPwZklt0u3m0q+3A39qP42V+EMFRuk8Ja0ChsAciL?=
 =?us-ascii?Q?kFXQn3lWv2Ajrpbx8glzljpgv5ru6smUeGiX5nJKlF7y/kX59dB/UO8GgW96?=
 =?us-ascii?Q?MF1iVVo5fXVe91rYNSmVqE4uJ+0jsPwOSyFuzp0MaYN1OIW++g7PI0Xeano9?=
 =?us-ascii?Q?0i8YSOYWJVR9vYlsojw7bTvA3iCEibSeVj0fZJHpjHBHcxdZUaLbQOrmVftH?=
 =?us-ascii?Q?7fj4GYWdZ/H0OAosND3M1Bq9z7vLRn+n9oCTCiwklP7f7mOMwbLjROtUz9Sq?=
 =?us-ascii?Q?y3GWO2VrdQxc0olLhpwoAOI5gNYLEdCuIeXFTrgUWkTdmqzJpbDLHCCs1Q5T?=
 =?us-ascii?Q?Xj4GFkvcedv/pZ8lEkUzlSC2dbRjBLmInQ9SLP02eJliqMtAiJey/Ba+N9zK?=
 =?us-ascii?Q?QwI5UDZr1cN7XAjo6DUUASU0PXIoXcXpuyPmKovtrSaBBqrbYk0bM37VGsoj?=
 =?us-ascii?Q?r9fWj9qiXos6irf0ROkgg5q4kYEL1tGnCTPbm2QCMeLrYluza10AXrvRQCc1?=
 =?us-ascii?Q?93gXijKd+lSiQnTTCesV2AQ53TVi619MFn3eU4Ge7asWt1xJrfe9WU5nlVbA?=
 =?us-ascii?Q?r3AWzlwmvfth3yqbFdHeZmPelASqjzcaDOdX/qDIINa28bQOqvD/VKSeVEEq?=
 =?us-ascii?Q?xCphpDCpRS10ACOlWaK9o73irP2Slj7k3eWTLeyXfuvxrNTA0josVnP3LIc9?=
 =?us-ascii?Q?b8V4hBpAxBr5J2f/KbeZeXrIM4qY20ILANtkzfjdFlog/l6y7hTQvdvUA3P4?=
 =?us-ascii?Q?WFJtqIv0raLoyDBH1rGlhUxnDQFEB1BR5VL7PZxvfnzUMzPqHOZ8L+ljb18s?=
 =?us-ascii?Q?oXpRHxRgUna82Su4+01cFCi/3TmJk0ouuQ3SqCnect283f0cR0HhuRbo65w0?=
 =?us-ascii?Q?ZSfTwNxl1Ma+fW5DyEY7OkEXvUGRJ2FguSJTZWaola0VMHUYjy/U?=
MIME-Version: 1.0
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4188.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2e33e6-36a6-4726-c6c4-08debcd585b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 16:23:58.9744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqHrtGCXhq402J+eT6Ndagx0KaqGg6wnqN7TpPf4GuazfGPYhY1AFM37mx3TDHM5T3j8U9SbOZjI5Rnjf53fHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR18MB6399
X-Mailman-Approved-At: Thu, 28 May 2026 18:51:46 +0200
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

>From: Tom Rini <trini@konsulko.com>
>To: Karthikeyan Mitran <kmitran@axiado.com>
>Cc: u-boot@lists.denx.de<https://lore.kernel.org/u-boot/?t=3D2026042914315=
9>, Siu Ming Tong <smtong@axiado.com>,
>        Prasad Bolisetty <pbolisetty@axiado.com>,
>   Andre Przywara <andre.przywara@arm.com>,
>       Tzu-Hao Wei <twei@axiado.com>, Simon Glass <sjg@chromium.org>,
>   Neil Armstrong <neil.armstrong@linaro.org>,
>    Sumit Garg <sumit.garg@kernel.org>
>Subject: Re: [PATCH 2/2] arm: axiado: Add AX3005 based SCM3005 board suppo=
rt<https://lore.kernel.org/u-boot/20260429143149.GV41863@bill-the-cat/#r>
>Date: Wed, 29 Apr 2026 08:31:49 -0600      [thread overview]<https://lore.=
kernel.org/u-boot/20260429143149.GV41863@bill-the-cat/#r>
>Message-ID: <20260429143149.GV41863@bill-the-cat> (raw<https://lore.kernel=
.org/u-boot/20260429143149.GV41863@bill-the-cat/raw>)
>In-Reply-To: <20260428-ax3005_scm3005-v1-2-7fed19ee6fe0@axiado.com<https:/=
/lore.kernel.org/u-boot/20260428-ax3005_scm3005-v1-2-7fed19ee6fe0@axiado.co=
m/>>

>[-- Attachment #1: Type: text/plain, Size: 2054 bytes --]<https://lore.ker=
nel.org/u-boot/20260429143149.GV41863@bill-the-cat/1-a.txt>

>On Tue, Apr 28, 2026 at 07:32:37PM -0700, Karthikeyan Mitran wrote:

>>From: Siu Ming Tong <smtong@axiado.com>
> >
> >Add U-Boot board support for the Axiado AX3005 based targets, a quad-cor=
e
> >ARM Cortex-A53 (ARMv8) platform.
> >
> Board Kconfig introduces ARCH_AX3005, which selects ARM64, driver
> model, GIC-v3, and Zynq UART. TARGET_SCM3005 selects ARCH_AX3005,
> allowing future SoC variants to share the platform configuration.
> >
> Secondary cores use spin-table boot. ft_board_setup() corrects
> the cpu-release-addr in the FDT, which arch_fixup_fdt() overwrites
> with the post-relocation address. The board linker script pins
> spin_table_v8.o at offset 0x2fa0 from text base to match the
> address declared in the device tree.
> >
> >Tested-by: Siu Ming Tong <smtong@axiado.com>
> >Signed-off-by: Siu Ming Tong <smtong@axiado.com>
> >Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
> Signed-off-by: Karthikeyan Mitran <kmitran@axiado.com>
> >---
> > MAINTAINERS                      |  10 +++
> > arch/arm/Kconfig                 |  17 ++++
>  >board/axiado/scm3005/Kconfig     |  15 ++++
> > board/axiado/scm3005/Makefile    |   5 ++
>  board/axiado/scm3005/scm3005.c   | 128 +++++++++++++++++++++++++++
> > board/axiado/scm3005/u-boot.lds  | 183 ++++++++++++++++++++++++++++++++=
+++++++
> > configs/ax3005_scm3005_defconfig |  73 ++++++++++++++++
>  include/configs/ax3005-scm3005.h |  29 +++++++
> > 8 files changed, 460 insertions(+)

>We're adding a new ARCH symbol, but without a new mach- directory, which
>I suspect some of the board code should be in, instead. Also:
We added the new mach-axiado in v2 2/2 patch.

> >diff --git a/board/axiado/scm3005/u-boot.lds b/board/axiado/scm3005/u-bo=
ot.lds
> >new file mode 100644 > >index 00000000000..8e56535fdf9
> >--- /dev/null > >+++ b/board/axiado/scm3005/u-boot.lds
>> @@ -0,0 +1,183 @@ > >+/* SPDX-License-Identifier: GPL-2.0+ */
> >+/*
> >+ * Copyright (c) 2021-2026 Axiado Corporation (or its affiliates).
> >+ *
> >+ * Based on arch/arm/cpu/armv8/u-boot.lds
> >+ */
>What differs here really? Thanks. --
We removed the u-boot.lds from v2 2/2 patch.

>Tom
>From: Tom Rini <trini@konsulko.com>
>To: Karthikeyan Mitran <kmitran@axiado.com>
>Cc: u-boot@lists.denx.de<https://lore.kernel.org/u-boot/?t=3D2026042914294=
5>, Siu Ming Tong <smtong@axiado.com>,
>        Prasad Bolisetty <pbolisetty@axiado.com>,
>   Andre Przywara <andre.przywara@arm.com>,
>       Tzu-Hao Wei <twei@axiado.com>, Simon Glass <sjg@chromium.org>,
>   Neil Armstrong <neil.armstrong@linaro.org>,
>    Sumit Garg <sumit.garg@kernel.org>
>Subject: Re: [PATCH 1/2] arm64: dts: axiado: Add AX3005 SCM3005 device tre=
e<https://lore.kernel.org/u-boot/20260429142935.GU41863@bill-the-cat/#r>
>Date: Wed, 29 Apr 2026 08:29:35 -0600       [thread overview]<https://lore=
.kernel.org/u-boot/20260429142935.GU41863@bill-the-cat/#r>
>Message-ID: <20260429142935.GU41863@bill-the-cat> (raw<https://lore.kernel=
.org/u-boot/20260429142935.GU41863@bill-the-cat/raw>)
>In-Reply-To: <20260428-ax3005_scm3005-v1-1-7fed19ee6fe0@axiado.com<https:/=
/lore.kernel.org/u-boot/20260428-ax3005_scm3005-v1-1-7fed19ee6fe0@axiado.co=
m/>>
>
>[-- Attachment #1: Type: text/plain, Size: 1258 bytes --]<https://lore.ker=
nel.org/u-boot/20260429142935.GU41863@bill-the-cat/1-a.txt>
>On Tue, Apr 28, 2026 at 07:32:36PM -0700, Karthikeyan Mitran wrote:
>> From: Siu Ming Tong <smtong@axiado.com>
>>
>> Add device tree source files for the Axiado AX3005 SCM3005 board.
>> The AX3005 is a quad-core 64-bit ARMv8 Cortex-A53 SoC.
>>
>> The DTSI describes the SoC-level nodes: GIC-v3 interrupt controller,
>> Cadence/Zynq UART, fixed reference clock, and spin-table secondary
>> CPU boot.  A /memreserve/ directive protects the spin-table release
>> address at 0x80002fa0 from being overwritten during boot.
>>
>> The SCM3005 DTS sets the console to uart3 at 115200 baud and declares
>> 2 GB of DRAM starting at 0x80000000.
>>
>> Tested-by: Siu Ming Tong <smtong@axiado.com>
>> Signed-off-by: Siu Ming Tong <smtong@axiado.com>
>> Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
>> Signed-off-by: Karthikeyan Mitran <kmitran@axiado.com>
>> ---
>>  arch/arm/dts/Makefile           |   1 +
>>  arch/arm/dts/ax3005-scm3005.dts |  28 +++++++++++
>>  arch/arm/dts/ax3005.dtsi        | 100 +++++++++++++++++++++++++++++++++=
+++++++
>>  3 files changed, 129 insertions(+)

>What's the status of upstreaming these files? As of v7.0-dts I see:
>dts/upstream/src/arm64/axiado/ax3000.dtsi
>dts/upstream/src/arm64/axiado/ax3000-evk.dts
These dts files were submitted by our kernel team for Axiado ax3000 boards.
The patches we are submitting are for Axiado ax3005 boards.
Once the ax3005 patches are approved, we will work on submitting ax3000 pat=
ches.

>Thanks.
>-- >Tom

