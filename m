Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14393C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CC9B87ECA;
	Mon, 26 Feb 2024 09:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="M4fGbQKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2DD987E9C; Mon, 26 Feb 2024 09:08:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AD4587ECA
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jit.loon.lim@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708934886; x=1740470886;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5cozlZL5+ht/rTdfXodNIDlr9ipRW2Z1DICYVbe1pdc=;
 b=M4fGbQKvMshmxWM2rDyri/UgwHXMMZg3NpsAapRCNEofBo+mDvt2xq8W
 ucCKQ46md5JiJkHBlzaNYm1d2Lg+6YXKuhDQOSDDON2uC3TPsyI39TweU
 r4QuwFY4GRRda8jXqRfTb3EDwRC80F6MATMxxp/udSRLHyQ9COtlqjuNU
 wkyjLcCoqO7M2aN9XSrTUyyRs31+HrlBrlZybnMGZYsrtIcMmUa4KhYn5
 By0lsZUFz+vqQZFAtwukQ83CT4u0nIU9VWnk4RDkKWCb4E7OKiSU/gxyR
 B6ZBKh4MbUksufWhk7UkLA+Jr6Svw1B1rEjxm+qm1mgHJW7UY1+cGsT+q w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="20656153"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="20656153"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 00:08:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="37582896"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Feb 2024 00:03:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 00:03:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 00:03:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 00:03:25 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 00:03:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0wLDbbOrt1VeUa2PKpi8CSBuMSV7Cn8tvaNSWccvC5wJQSzFkPSW3/XBz7CndXnuqgi5tyghh1VaqPATYvF9l2zSP09JyWwvaWNyZS51QAzi8EX7WNeOPmPwLcOdDKcXG91797BHD7Krsm3srISCVtxnQHJ8PGLGvp5qTfkyWYUyTrLeYrs0+UqBY3khcFI0kqscunuMxPgDts6ee/FGYecWUZD+KklV3x6ste99iJBtPJ8xHD1BaNn8ruTngyJSKsxoJnQzQvHKKIe2vKUsFzqjxvVsj7wLN98pcon4KPN4Ns+iL3LjopnAR+zsI5SfuKRGHD682l6Frsubs/U1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5Ztj3uuCqdlRgF1gFoBaPjOHc/6YyJQQaJyRWLTyuc=;
 b=WlKQoEB1HNUixWg6okUvdyUwvxV64NMyGQ5fbQmd+D0gCVSH7mNjOsUU8wwhrNe0VZrLQMYuHfd00sk+/BF9PFMvZAN7gsSCkDdQFB7ePV2BiSLKO1B1H0qKrisA/6gkTt6aY/EDB8RGR/fU4GlhMKnRWpvRw11ZPGhOQCpJKdUbypedpHbHCbEb4cCDdhtsZscAgDRE742d8cT54RJuWckYtVz6TmUwE2D3/M/5YK4PedZnlAZadvSe1QJ/XcFKjn1uaWqpEfWnQlZGNDujlwU4KmijVk2SK1QRC770+LTnqNxj3L1AN1RTO2WC96J+jvJU308VekbfdHevSlNarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4945.namprd11.prod.outlook.com (2603:10b6:303:9c::8)
 by DM4PR11MB8089.namprd11.prod.outlook.com (2603:10b6:8:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Mon, 26 Feb
 2024 08:03:20 +0000
Received: from CO1PR11MB4945.namprd11.prod.outlook.com
 ([fe80::9aec:3496:2566:cd4f]) by CO1PR11MB4945.namprd11.prod.outlook.com
 ([fe80::9aec:3496:2566:cd4f%5]) with mapi id 15.20.7339.024; Mon, 26 Feb 2024
 08:03:20 +0000
From: "Lim, Jit Loon" <jit.loon.lim@intel.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Jagan Teki <jagan@amarulasolutions.com>, Marek <marex@denx.de>, Simon
 <simon.k.r.goldschmidt@gmail.com>, "Chee, Tien Fong"
 <tien.fong.chee@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>, "Ng, Boon Khai"
 <boon.khai.ng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Chong, Teik Heng"
 <teik.heng.chong@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>, "Tang, Sieu Mun"
 <sieu.mun.tang@intel.com>, Bin Meng <bmeng.cn@gmail.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>
Subject: RE: [PATCH v2 1/1] arch:arm: Agilex5 enablement
Thread-Topic: [PATCH v2 1/1] arch:arm: Agilex5 enablement
Thread-Index: AQHaaIJzoczFlMTwAUWdgbGEhTEoArEcQ0MA
Date: Mon, 26 Feb 2024 08:03:20 +0000
Message-ID: <CO1PR11MB4945A0A2CB9891D602B0C2F4D25A2@CO1PR11MB4945.namprd11.prod.outlook.com>
References: <20240226070704.15153-1-jit.loon.lim@intel.com>
 <20240226070704.15153-2-jit.loon.lim@intel.com>
In-Reply-To: <20240226070704.15153-2-jit.loon.lim@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4945:EE_|DM4PR11MB8089:EE_
x-ms-office365-filtering-correlation-id: b3635b3d-8702-4348-ea13-08dc36a165c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ZuMg6XXuPVCj8ScYx+QeoEeCqL4EqN3R71OY3itw1KLZ95OhSaKzRk4Sc/GZ8BbYuoNyYnFLpP9GyEq9ucg9epig+ILuM3g2ZgJxEIjdwY84gz7SVpy5zj/fyE8Uq262MSgGRO3DIkz2pIn1vYtXHZV8eGARzNFFUmPEYhD7hb/I68QOBhzSg5TNFdIZCGazVTVXg7vWrg7j8L9VridadF0R0727ldh4Z7hMxnoeLn535olczNGjpaW4+15kjxKc3S6UBMGnvrge+Q5CS8h1ZCObqeyVOmIGfH7P1ZproZOmgBVxfNOCToIWRpAZ8ej1Vc+uTNSa2zijV7ryolQP0m0FjdtkUlqK1Dg84R8ra6LAssz5ZerTFfiPDoVobcCReMn/wHvxlQwv0lhWpQ26tg/2c1Vw0NPR3vB+5y0K1WZDCGZ0D194Jejedozt5ZS+08zg2k1s0avpiveoiMueVE+F/nOFXoZkZ6grElhGgfIicNi5NhepfnoT+fgdszfns4VBgbB9t9cqi8jc12CfOvevVk3TNEpdoTYkTcsgtnjb3LE8Nebvnzj0MXk2e1aQRVB5nI3a/qoAkG46/5OL+mrYs8KaUowdUnc9JHh8NuWePUVkjxv8NjHw7vp90KJYr99faOBeAeTqHwp1a7xjPIc8b70QRvKxQ/2dauZvW7FHcID0lsaongl2HcYz11TxOIzyPze7EodDhHT9mxQcw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4945.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZD5S5tJ0DFCIVMm06gCwpA9dfh/PrmWDEVGM/7f9LZ12rTMCdotkV/diatFV?=
 =?us-ascii?Q?A7j4doVKudH6zQQrfu/mAEQG1aj0unsffWTZG0l90RFPNdokeCE1HCPhrIVw?=
 =?us-ascii?Q?+5idnaIt6hvDyi98NJoupIIQqJU4xBAxtmbK6ZhP6y+VdyZnb8lIiFqRu92I?=
 =?us-ascii?Q?BkYjJruzu4mhBA95oP5peCZZC7d8mzYot2mEqy3ziGBA02b9qtQ14bwZUUwG?=
 =?us-ascii?Q?fdRDx/mDJeZzXBR/ecUhvKG0TnYAvTx7FfT0a8R+1aLVfWMuzzyXvi1325k+?=
 =?us-ascii?Q?frDnXS2XmF5bSyb/YQIGnnxX6LpLCzVVdWe3q7G2BAJXmILkyiTGXR5C+rm5?=
 =?us-ascii?Q?Mow4sZPfozINPJV/BJUOW/eW0HXE3mzRZfETvPmPjLjG6v1FCoteMftpvW4Y?=
 =?us-ascii?Q?ANvMXQbDr9MAu9GyYCthTllXRONTzdArfqc4/GS/ro22mWslZy4DpRyk9ufV?=
 =?us-ascii?Q?5tSc/7dWsudTiGuMXNh5mtX8rAPGct1KhhD5N9rR7EIryEvP5p3klFmbVCZZ?=
 =?us-ascii?Q?vw5g7e6+gleJEm0WPiaRAkrbByyoGa/zIhv9114L6op20jkL5El3GLvehnbE?=
 =?us-ascii?Q?lwiIRPeiLXS0v16p3IN3ltLUWZ6NJIXPoj2L47vX+KJI1vFTk/olsyMwVLnR?=
 =?us-ascii?Q?HdjkCHbUo15crCKcxovfDkdLimWs8DuLA2JzgtcinS9R/l/Nb4IxyrRq+Tqo?=
 =?us-ascii?Q?kbCLWNN0Dcj0mixujQ5XjXtRJHrQ5AERbsD9grLLrUbmVsTfC9sGPo86wn2B?=
 =?us-ascii?Q?lYXpfsteX8btFYh1NjgRM00EHBGGK6bDABu3lhq9Y9WOSpPdHGmKtrOpSXcm?=
 =?us-ascii?Q?Xs0gN86DK9JABS1Ykl+tz3t6GKXvpONVlAZWJ5ae8T0hFH0oGBuIKw8yzDhu?=
 =?us-ascii?Q?WJQ8dAjVTTxwuSKdJUnPr34+p35pJn77U24+3YLJmOCdwuKj6CO4Nmuzhoxn?=
 =?us-ascii?Q?ZCcAcUlZhAKrbPlRmFldQqrDtO/SRr2sAesdZ+yY475cMek0SYE0oFNS7T4J?=
 =?us-ascii?Q?8Wj1l3tIb2qAdtFDUPYozhJD7Lueo93aZ16FRdCu8nkh0NGUexKNnVHTx/Gm?=
 =?us-ascii?Q?sV0rhQ5ivmRRiFuSJ1gNKxYkQVsWpuMZzIHbVdfDP9juKZcgVxEbb/0/V+bS?=
 =?us-ascii?Q?2eHpWFyPJTjrjXHcBcgR/mLeH3ZQPZ0g/HLYzQ4R5csoCtgRIYT4TMFXiFhg?=
 =?us-ascii?Q?n+/7TdmPSN5Owev9F7DgRXkhaGhA8vXfQsYOArjr9TMimLc+8WbyAIfM9B0B?=
 =?us-ascii?Q?24oFuHkZRcW8NVq3P9XOfUeoGDEurdPufJpO30d7QQEEN4Cg2as60zPYqy58?=
 =?us-ascii?Q?lPPpR4AqznJdWYv3cxKk/108lUrfeUnj8mnhWjTV6EZBMTnQ+28ab4Ktmzeo?=
 =?us-ascii?Q?l1bOx5RTHz6ukyP00NUUZoDOMtZmUqbADKaVZH1o4JBaD8kPbq0/xz4wtPoP?=
 =?us-ascii?Q?o4n8aG0VKm0TEtpXD/gWf+twlDk8+ZywdcNqEwsQ/5h+gmgVJ1Fo7S+4jva4?=
 =?us-ascii?Q?A+9S3Ra3kUXexoLfi+wiChoTcv35RkHXp8TaxFW8rFmNIgXZ6OUH8UxGL/Ci?=
 =?us-ascii?Q?T/za2ibFYHckzAGf/CN2Rc3nZshismUNCq+ym0bA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4945.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3635b3d-8702-4348-ea13-08dc36a165c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 08:03:20.4995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3cViuRlpT2EvrKTs2XaLupbLQXGBr6HbqptVAzVOBJ0VAKLobqFogZAi4vSAe/oPWQs+PDpZX3YmxL81BXVxnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8089
X-OriginatorOrg: intel.com
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

> -----Original Message-----
> From: Lim, Jit Loon <jit.loon.lim@intel.com>
> Sent: Monday, February 26, 2024 3:07 PM
> To: u-boot@lists.denx.de
> Cc: Jagan Teki <jagan@amarulasolutions.com>; Marek <marex@denx.de>;
> Simon <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@intel.com>; Hea, Kok Kiang <kok.kiang.hea@intel.com>;
> Maniyam, Dinesh <dinesh.maniyam@intel.com>; Ng, Boon Khai
> <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Chong, Teik Heng
> <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>; Bin
> Meng <bmeng.cn@gmail.com>
> Subject: [PATCH v2 1/1] arch:arm: Agilex5 enablement
>=20
> This patch is to enable Agilex5 platform for Intel
> product. Changes, modification and new files are
> created for board, dts, configs and makefile to
> create the base for Agilex5.
>=20
> Signed-off-by: Jit Loon Lim <jit.loon.lim@intel.com>
> ---
> Changes v1 -> v2:
> - fixed git auto merge issue
> ---
>  arch/arm/Kconfig                              |  13 +-
>  arch/arm/dts/Makefile                         |   1 +
>  arch/arm/dts/socfpga_agilex5-u-boot.dtsi      | 458 ++++++++++++
>  arch/arm/dts/socfpga_agilex5.dtsi             | 654 ++++++++++++++++++
>  .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 144 ++++
>  arch/arm/dts/socfpga_agilex5_socdk.dts        | 163 +++++
>  arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi    |  38 +-
>  arch/arm/mach-socfpga/Kconfig                 |  69 +-
>  arch/arm/mach-socfpga/Makefile                |   4 +-
>  arch/arm/mach-socfpga/board.c                 |  56 +-
>  .../include/mach/base_addr_soc64.h            |  44 +-
>  board/intel/agilex5-socdk/MAINTAINERS         |   8 +
>  board/intel/agilex5-socdk/Makefile            |   7 +
>  configs/socfpga_agilex5_defconfig             | 113 +++
>  include/configs/socfpga_agilex5_socdk.h       |  12 +
>  include/configs/socfpga_soc64_common.h        | 209 +++++-
>  16 files changed, 1957 insertions(+), 36 deletions(-)
>  create mode 100644 arch/arm/dts/socfpga_agilex5-u-boot.dtsi
>  create mode 100644 arch/arm/dts/socfpga_agilex5.dtsi
>  create mode 100644 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
>  create mode 100644 arch/arm/dts/socfpga_agilex5_socdk.dts
>  create mode 100644 board/intel/agilex5-socdk/MAINTAINERS
>  create mode 100644 board/intel/agilex5-socdk/Makefile
>  create mode 100644 configs/socfpga_agilex5_defconfig
>  create mode 100644 include/configs/socfpga_agilex5_socdk.h
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index fde85dc0d5..baecb0463d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -28,6 +28,7 @@ config COUNTER_FREQUENCY
>  			ROCKCHIP_RK3288 || ROCKCHIP_RK322X ||
> ROCKCHIP_RK3036
>  	default 25000000 if ARCH_LX2160A || ARCH_LX2162A ||
> ARCH_LS1088A
>  	default 100000000 if ARCH_ZYNQMP
> +	default 200000000 if ARCH_SOCFPGA && ARM64 &&
> TARGET_SOCFPGA_AGILEX5
>  	default 0
>  	help
>  	  For platforms with ARMv8-A and ARMv7-A which features a system
> @@ -1116,6 +1117,8 @@ config ARCH_SOCFPGA
>  	select SPL_LIBGENERIC_SUPPORT
>  	select SPL_OF_CONTROL
>  	select SPL_SEPARATE_BSS if TARGET_SOCFPGA_SOC64
> +	select SPL_DRIVERS_MISC if TARGET_SOCFPGA_SOC64
> +	select SPL_SOCFPGA_SEC_REG if TARGET_SOCFPGA_SOC64
>  	select SPL_SERIAL
>  	select SPL_SYSRESET
>  	select SPL_WATCHDOG
> @@ -1124,7 +1127,8 @@ config ARCH_SOCFPGA
>  	select SYS_THUMB_BUILD if TARGET_SOCFPGA_GEN5 ||
> TARGET_SOCFPGA_ARRIA10
>  	select SYSRESET
>  	select SYSRESET_SOCFPGA if TARGET_SOCFPGA_GEN5 ||
> TARGET_SOCFPGA_ARRIA10
> -	select SYSRESET_SOCFPGA_SOC64 if TARGET_SOCFPGA_SOC64
> +	select SYSRESET_SOCFPGA_SOC64 if !TARGET_SOCFPGA_AGILEX5 &&
> TARGET_SOCFPGA_SOC64
> +	imply SYSRESET_SOCFPGA_AGILEX5 if TARGET_SOCFPGA_AGILEX5
>  	imply CMD_DM
>  	imply CMD_MTDPARTS
>  	imply CRC32_VERIFY
> @@ -1158,7 +1162,9 @@ config ARCH_SUNXI
>  	select DM_SPI_FLASH if SPI && MTD
>  	select DM_KEYBOARD
>  	select DM_MMC if MMC
> +	select DM_SCSI if SCSI
>  	select DM_SERIAL
> +	select GPIO_EXTRA_HEADER
>  	select OF_BOARD_SETUP
>  	select OF_CONTROL
>  	select OF_SEPARATE
> @@ -1865,7 +1871,7 @@ config TARGET_SL28
>  	select PCI
>  	select DM_RNG
>  	select DM_RTC
> -	select SCSI
> +	select DM_SCSI
>  	select DM_SERIAL
>  	select DM_SPI
>  	select GPIO_EXTRA_HEADER
> @@ -2082,6 +2088,7 @@ config TARGET_POMELO
>  	select PCI
>  	select DM_PCI
>  	select SCSI
> +	select DM_SCSI
>  	select DM_SERIAL
>  	imply CMD_PCI
>  	help
> @@ -2375,4 +2382,4 @@ source "board/xen/xenguest_arm64/Kconfig"
>=20
>  source "arch/arm/Kconfig.debug"
>=20
> -endmenu
> +endmenu
> \ No newline at end of file
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index d9725030d5..2b4f896ad2 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -548,6 +548,7 @@ dtb-$(CONFIG_TARGET_THUNDERX_88XX) +=3D
> thunderx-88xx.dtb
>=20
>  dtb-$(CONFIG_ARCH_SOCFPGA) +=3D				\
>  	socfpga_agilex_socdk.dtb			\
> +	socfpga_agilex5_socdk.dtb			\
>  	socfpga_arria5_secu1.dtb			\
>  	socfpga_arria5_socdk.dtb			\
>  	socfpga_arria10_chameleonv3_270_2.dtb		\
> diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> new file mode 100644
> index 0000000000..daa8c982da
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> @@ -0,0 +1,458 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * U-Boot additions
> + *
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + */
> +
> +#include "socfpga_soc64_fit-u-boot.dtsi"
> +
> +/{
> +	memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		bootph-all;
> +	};
> +
> +	soc {
> +		bootph-all;
> +
> +		/* socfpga_secreg: socfpga-secreg { */
> +			/* compatible =3D "intel,socfpga-secreg"; */
> +			/* #address-cells =3D <1>; */
> +			/* #size-cells =3D <1>; */
> +			/* bootph-all; */
> +
> +			/* DSU */
> +			i_ccu_caiu0@1c000000 {
> +				reg =3D <0x1c000000 0x00001000>;
> +				intel,offset-settings =3D
> +					/* CAIUAMIGR */
> +					<0x000003c0 0x00000003
> 0x0000001f>,
> +					/* CAIUMIFSR */
> +					<0x000003c4 0x00000000
> 0x07070777>,
> +					/* DII1_MPFEREGS */
> +					<0x00000414 0x00018000 0xffffffff>,
> +					<0x00000418 0x00000000
> 0x000000ff>,
> +					<0x00000410 0xc0e00200
> 0xc1f03e1f>,
> +					/* DII2_GICREGS */
> +					<0x00000424 0x0001d000 0xffffffff>,
> +					<0x00000428 0x00000000
> 0x000000ff>,
> +					<0x00000420 0xc0800400
> 0xc1f03e1f>,
> +					/* NCAIU0_LWSOC2FPGA */
> +					<0x00000444 0x00020000 0xffffffff>,
> +					<0x00000448 0x00000000
> 0x000000ff>,
> +					<0x00000440 0xc1100006
> 0xc1f03e1f>,
> +					/* NCAIU0_SOC2FPGA_1G */
> +					<0x00000454 0x00040000 0xffffffff>,
> +					<0x00000458 0x00000000
> 0x000000ff>,
> +					<0x00000450 0xc1200006
> 0xc1f03e1f>,
> +					/* DMI_SDRAM_2G */
> +					<0x00000464 0x00080000 0xffffffff>,
> +					<0x00000468 0x00000000
> 0x000000ff>,
> +					<0x00000460 0x81300006
> 0xc1f03e1f>,
> +					/* NCAIU0_SOC2FPGA_16G */
> +					<0x00000474 0x00400000 0xffffffff>,
> +					<0x00000478 0x00000000
> 0x000000ff>,
> +					<0x00000470 0xc1600006
> 0xc1f03e1f>,
> +					/* DMI_SDRAM_30G */
> +					<0x00000484 0x00800000 0xffffffff>,
> +					<0x00000488 0x00000000
> 0x000000ff>,
> +					<0x00000480 0x81700006
> 0xc1f03e1f>,
> +					/* NCAIU0_SOC2FPGA_256G */
> +					<0x00000494 0x04000000 0xffffffff>,
> +					<0x00000498 0x00000000
> 0x000000ff>,
> +					<0x00000490 0xc1a00006
> 0xc1f03e1f>,
> +					/* DMI_SDRAM_480G */
> +					<0x000004a4 0x08000000 0xffffffff>,
> +					<0x000004a8 0x00000000
> 0x000000ff>,
> +					<0x000004a0 0x81b00006
> 0xc1f03e1f>;
> +				bootph-all;
> +			};
> +
> +			/* FPGA2SOC */
> +			i_ccu_ncaiu0@1c001000 {
> +				reg =3D <0x1c001000 0x00001000>;
> +				intel,offset-settings =3D
> +					/* NCAIU0AMIGR */
> +					<0x000003c0 0x00000003
> 0x0000001f>,
> +					/* NCAIU0MIFSR */
> +					<0x000003c4 0x00000000
> 0x07070777>,
> +					/* PSS */
> +					<0x00000404 0x00010000 0xffffffff>,
> +					<0x00000408 0x00000000
> 0x000000ff>,
> +					<0x00000400 0xC0F00000
> 0xc1f03e1f>,
> +					/* DII1_MPFEREGS */
> +					<0x00000414 0x00018000 0xffffffff>,
> +					<0x00000418 0x00000000
> 0x000000ff>,
> +					<0x00000410 0xc0e00200
> 0xc1f03e1f>,
> +					/* NCAIU0_LWSOC2FPGA */
> +					<0x00000444 0x00020000 0xffffffff>,
> +					<0x00000448 0x00000000
> 0x000000ff>,
> +					<0x00000440 0xc1100006
> 0xc1f03e1f>,
> +					/* NCAIU0_SOC2FPGA_1G */
> +					<0x00000454 0x00040000 0xffffffff>,
> +					<0x00000458 0x00000000
> 0x000000ff>,
> +					<0x00000450 0xc1200006
> 0xc1f03e1f>,
> +					/* DMI_SDRAM_2G */
> +					<0x00000464 0x00080000 0xffffffff>,
> +					<0x00000468 0x00000000
> 0x000000ff>,
> +					<0x00000460 0x81300006
> 0xc1f03e1f>,
> +					/* NCAIU0_SOC2FPGA_16G */
> +					<0x00000474 0x00400000 0xffffffff>,
> +					<0x00000478 0x00000000
> 0x000000ff>,
> +					<0x00000470 0xc1600006
> 0xc1f03e1f>,
> +					/* DMI_SDRAM_30G */
> +					<0x00000484 0x00800000 0xffffffff>,
> +					<0x00000488 0x00000000
> 0x000000ff>,
> +					<0x00000480 0x81700006
> 0xc1f03e1f>,
> +					/* NCAIU0_SOC2FPGA_256G */
> +					<0x00000494 0x04000000 0xffffffff>,
> +					<0x00000498 0x00000000
> 0x000000ff>,
> +					<0x00000490 0xc1a00006
> 0xc1f03e1f>,
> +					/* DMI_SDRAM_480G */
> +					<0x000004a4 0x08000000 0xffffffff>,
> +					<0x000004a8 0x00000000
> 0x000000ff>,
> +					<0x000004a0 0x81b00006
> 0xc1f03e1f>;
> +				bootph-all;
> +			};
> +
> +			/* GIC_M */
> +			i_ccu_ncaiu1@1c002000 {
> +				reg =3D <0x1c002000 0x00001000>;
> +				intel,offset-settings =3D
> +					/* NCAIU1AMIGR */
> +					<0x000003c0 0x00000003
> 0x0000001f>,
> +					/* NCAIU1MIFSR */
> +					<0x000003c4 0x00000000
> 0x07070777>,
> +					/* DMI_SDRAM_2G */
> +					<0x00000464 0x00080000 0xffffffff>,
> +					<0x00000468 0x00000000
> 0x000000ff>,
> +					<0x00000460 0x81300006
> 0xc1f03e1f>,
> +					/* DMI_SDRAM_30G */
> +					<0x00000484 0x00800000 0xffffffff>,
> +					<0x00000488 0x00000000
> 0x000000ff>,
> +					<0x00000480 0x81700006
> 0xc1f03e1f>,
> +					/* DMI_SDRAM_480G */
> +					<0x000004a4 0x08000000 0xffffffff>,
> +					<0x000004a8 0x00000000
> 0x000000ff>,
> +					<0x000004a0 0x81b00006
> 0xc1f03e1f>;
> +				bootph-all;
> +			};
> +
> +			/* PSS NOC */
> +			i_ccu_ncaiu3@1c004000 {
> +				reg =3D <0x1c004000 0x00001000>;
> +				intel,offset-settings =3D
> +					/* NCAIU3AMIGR */
> +					<0x000003c0 0x00000003
> 0x0000001f>,
> +					/* NCAIU3MIFSR */
> +					<0x000003c4 0x00000000
> 0x07070777>,
> +					/* DII1_MPFEREGS */
> +					<0x00000414 0x00018000 0xffffffff>,
> +					<0x00000418 0x00000000
> 0x000000ff>,
> +					<0x00000410 0xc0e00200
> 0xc1f03e1f>,
> +					/* DMI_SDRAM_2G */
> +					<0x00000464 0x00080000 0xffffffff>,
> +					<0x00000468 0x00000000
> 0x000000ff>,
> +					<0x00000460 0x81300006
> 0xc1f03e1f>,
> +					/* DMI_SDRAM_30G */
> +					<0x00000484 0x00800000 0xffffffff>,
> +					<0x00000488 0x00000000
> 0x000000ff>,
> +					<0x00000480 0x81700006
> 0xc1f03e1f>,
> +					/* DMI_SDRAM_480G */
> +					<0x000004a4 0x08000000 0xffffffff>,
> +					<0x000004a8 0x00000000
> 0x000000ff>,
> +					<0x000004a0 0x81b00006
> 0xc1f03e1f>;
> +				bootph-all;
> +			};
> +
> +			/* DCE0 */
> +			i_ccu_dce0@1c005000 {
> +				reg =3D <0x1c005000 0x00001000>;
> +				intel,offset-settings =3D
> +					/* DCEUAMIGR0 */
> +					<0x000003c0 0x00000003
> 0x0000001f>,
> +					/* DCEUMIFSR0 */
> +					<0x000003c4 0x00000000
> 0x07070777>,
> +					/* DMI_SDRAM_2G */
> +					<0x00000464 0x00080000 0xffffffff>,
> +					<0x00000468 0x00000000
> 0x000000ff>,
> +					<0x00000460 0x81300006
> 0xc1f03e1f>,
> +					/* DMI_SDRAM_30G */
> +					<0x00000484 0x00800000 0xffffffff>,
> +					<0x00000488 0x00000000
> 0x000000ff>,
> +					<0x00000480 0x81700006
> 0xc1f03e1f>,
> +					/* DMI_SDRAM_480G */
> +					<0x000004a4 0x08000000 0xffffffff>,
> +					<0x000004a8 0x00000000
> 0x000000ff>,
> +					<0x000004a0 0x81b00006
> 0xc1f03e1f>;
> +				bootph-all;
> +			};
> +
> +			/* DCE1 */
> +			i_ccu_dce1@1c006000 {
> +				reg =3D <0x1c006000 0x00001000>;
> +				intel,offset-settings =3D
> +					/* DCEUAMIGR1 */
> +					<0x000003c0 0x00000003
> 0x0000001f>,
> +					/* DCEUMIFSR1 */
> +					<0x000003c4 0x00000000
> 0x07070777>,
> +					/* DMI_SDRAM_2G */
> +					<0x00000464 0x00080000 0xffffffff>,
> +					<0x00000468 0x00000000
> 0x000000ff>,
> +					<0x00000460 0x81300006
> 0xc1f03e1f>,
> +					/* DMI_SDRAM_30G */
> +					<0x00000484 0x00800000 0xffffffff>,
> +					<0x00000488 0x00000000
> 0x000000ff>,
> +					<0x00000480 0x81700006
> 0xc1f03e1f>,
> +					/* DMI_SDRAM_480G */
> +					<0x000004a4 0x08000000 0xffffffff>,
> +					<0x000004a8 0x00000000
> 0x000000ff>,
> +					<0x000004a0 0x81b00006
> 0xc1f03e1f>;
> +				bootph-all;
> +			};
> +
> +			/* DMI0 */
> +			i_ccu_dmi0@1c007000 {
> +				reg =3D <0x1c007000 0x00001000>;
> +				intel,offset-settings =3D
> +					/* DMIUSMCTCR */
> +					<0x00000300 0x00000003
> 0x00000003>;
> +				bootph-all;
> +			};
> +
> +			/* DMI1 */
> +			i_ccu_dmi0@1c008000 {
> +				reg =3D <0x1c008000 0x00001000>;
> +				intel,offset-settings =3D
> +					/* DMIUSMCTCR */
> +					<0x00000300 0x00000003
> 0x00000003>;
> +				bootph-all;
> +			};
> +
> +			/* L4 peripherals firewall */
> +			noc_fw_l4_per@10d21000 {
> +				reg =3D <0x10d21000 0x0000008c>;
> +				intel,offset-settings =3D
> +					/* NAND */
> +					<0x00000000 0x01010001
> 0x01010001>,
> +					/* USB0 */
> +					<0x0000000c 0x01010001
> 0x01010001>,
> +					/* USB1 */
> +					<0x00000010 0x01010001
> 0x01010001>,
> +					/* SPI_MAIN0 */
> +					<0x0000001c 0x01010301
> 0x01010301>,
> +					/* SPI_MAIN1 */
> +					<0x00000020 0x01010301
> 0x01010301>,
> +					/* SPI_SECONDARY0 */
> +					<0x00000024 0x01010301
> 0x01010301>,
> +					/* SPI_SECONDARY1 */
> +					<0x00000028 0x01010301
> 0x01010301>,
> +					/* EMAC0 */
> +					<0x0000002c 0x01010001
> 0x01010001>,
> +					/* EMAC1 */
> +					<0x00000030 0x01010001
> 0x01010001>,
> +					/* EMAC2 */
> +					<0x00000034 0x01010001
> 0x01010001>,
> +					/* SDMMC */
> +					<0x00000040 0x01010001
> 0x01010001>,
> +					/* GPIO0 */
> +					<0x00000044 0x01010301
> 0x01010301>,
> +					/* GPIO1 */
> +					<0x00000048 0x01010301
> 0x01010301>,
> +					/* I2C0 */
> +					<0x00000050 0x01010301
> 0x01010301>,
> +					/* I2C1 */
> +					<0x00000054 0x01010301
> 0x01010301>,
> +					/* I2C2 */
> +					<0x00000058 0x01010301
> 0x01010301>,
> +					/* I2C3 */
> +					<0x0000005c 0x01010301
> 0x01010301>,
> +					/* I2C4 */
> +					<0x00000060 0x01010301
> 0x01010301>,
> +					/* SP_TIMER0 */
> +					<0x00000064 0x01010301
> 0x01010301>,
> +					/* SP_TIMER1 */
> +					<0x00000068 0x01010301
> 0x01010301>,
> +					/* UART0 */
> +					<0x0000006c 0x01010301
> 0x01010301>,
> +					/* UART1 */
> +					<0x00000070 0x01010301
> 0x01010301>,
> +					/* I3C0 */
> +					<0x00000074 0x01010301
> 0x01010301>,
> +					/* I3C1 */
> +					<0x00000078 0x01010301
> 0x01010301>,
> +					/* DMA0 */
> +					<0x0000007c 0x01010001
> 0x01010001>,
> +					/* DMA1 */
> +					<0x00000080 0x01010001
> 0x01010001>,
> +					/* COMBO_PHY */
> +					<0x00000084 0x01010001
> 0x01010001>,
> +					/* NAND_SDMA */
> +					<0x00000088 0x01010301
> 0x01010301>;
> +				bootph-all;
> +			};
> +
> +			/* L4 system firewall */
> +			noc_fw_l4_sys@10d21100 {
> +				reg =3D <0x10d21100 0x00000098>;
> +				intel,offset-settings =3D
> +					/* DMA_ECC */
> +					<0x00000008 0x01010001
> 0x01010001>,
> +					/* EMAC0RX_ECC */
> +					<0x0000000c 0x01010001
> 0x01010001>,
> +					/* EMAC0TX_ECC */
> +					<0x00000010 0x01010001
> 0x01010001>,
> +					/* EMAC1RX_ECC */
> +					<0x00000014 0x01010001
> 0x01010001>,
> +					/* EMAC1TX_ECC */
> +					<0x00000018 0x01010001
> 0x01010001>,
> +					/* EMAC2RX_ECC */
> +					<0x0000001c 0x01010001
> 0x01010001>,
> +					/* EMAC2TX_ECC */
> +					<0x00000020 0x01010001
> 0x01010001>,
> +					/* NAND_ECC */
> +					<0x0000002c 0x01010001
> 0x01010001>,
> +					/* NAND_READ_ECC */
> +					<0x00000030 0x01010001
> 0x01010001>,
> +					/* NAND_WRITE_ECC */
> +					<0x00000034 0x01010001
> 0x01010001>,
> +					/* OCRAM_ECC */
> +					<0x00000038 0x01010001
> 0x01010001>,
> +					/* SDMMC_ECC */
> +					<0x00000040 0x01010001
> 0x01010001>,
> +					/* USB0_ECC */
> +					<0x00000044 0x01010001
> 0x01010001>,
> +					/* USB1_CACHEECC */
> +					<0x00000048 0x01010001
> 0x01010001>,
> +					/* CLOCK_MANAGER */
> +					<0x0000004c 0x01010001
> 0x01010001>,
> +					/* IO_MANAGER */
> +					<0x00000054 0x01010001
> 0x01010001>,
> +					/* RESET_MANAGER */
> +					<0x00000058 0x01010001
> 0x01010001>,
> +					/* SYSTEM_MANAGER */
> +					<0x0000005c 0x01010001
> 0x01010001>,
> +					/* OSC0_TIMER */
> +					<0x00000060 0x01010301
> 0x01010301>,
> +					/* OSC1_TIMER0*/
> +					<0x00000064 0x01010301
> 0x01010301>,
> +					/* WATCHDOG0 */
> +					<0x00000068 0x01010301
> 0x01010301>,
> +					/* WATCHDOG1 */
> +					<0x0000006c 0x01010301
> 0x01010301>,
> +					/* WATCHDOG2 */
> +					<0x00000070 0x01010301
> 0x01010301>,
> +					/* WATCHDOG3 */
> +					<0x00000074 0x01010301
> 0x01010301>,
> +					/* DAP */
> +					<0x00000078 0x03010001
> 0x03010001>,
> +					/* WATCHDOG4 */
> +					<0x0000007c 0x01010301
> 0x01010301>,
> +					/* POWER_MANAGER */
> +					<0x00000080 0x01010001
> 0x01010001>,
> +					/* USB1_RXECC */
> +					<0x00000084 0x01010001
> 0x01010001>,
> +					/* USB1_TXECC */
> +					<0x00000088 0x01010001
> 0x01010001>,
> +					/* L4_NOC_PROBES */
> +					<0x00000090 0x01010001
> 0x01010001>,
> +					/* L4_NOC_QOS */
> +					<0x00000094 0x01010001
> 0x01010001>;
> +				bootph-all;
> +			};
> +
> +			/* Light weight SoC2FPGA */
> +			noc_fw_lwsoc2fpga@10d21300 {
> +				reg =3D <0x10d21300 0x0000004>;
> +				intel,offset-settings =3D
> +					/* LWSOC2FPGA_CSR */
> +					<0x00000000 0x0ffe0301>;
> +				bootph-all;
> +			};
> +
> +			/* SoC2FPGA */
> +			noc_fw_soc2fpga@10d21200 {
> +				reg =3D <0x10d21200 0x0000004>;
> +				intel,offset-settings =3D
> +					/* SOC2FPGA_CSR */
> +					<0x00000000 0x0ffe0301
> 0x0ffe0301>;
> +				bootph-all;
> +			};
> +
> +			/* TCU */
> +			noc_fw_tcu@10d21400 {
> +				reg =3D <0x10d21400 0x0000004>;
> +				intel,offset-settings =3D
> +					/* TCU_CSR */
> +					<0x00000000 0x01010001
> 0x01010001>;
> +				bootph-all;
> +			};
> +		};
> +	};
> +};
> +
> +&clkmgr {
> +	bootph-all;
> +};
> +
> +&i2c0 {
> +	reset-names =3D "i2c";
> +};
> +
> +&i2c1 {
> +	reset-names =3D "i2c";
> +};
> +
> +&i2c2 {
> +	reset-names =3D "i2c";
> +};
> +
> +&i2c3 {
> +	reset-names =3D "i2c";
> +};
> +
> +&mmc {
> +	resets =3D <&rst SDMMC_RESET>, <&rst SDMMC_OCP_RESET>;
> +};
> +
> +&porta {
> +	bank-name =3D "porta";
> +};
> +
> +&portb {
> +	bank-name =3D "portb";
> +};
> +
> +&qspi {
> +	bootph-all;
> +};
> +
> +&rst {
> +	compatible =3D "altr,rst-mgr";
> +	altr,modrst-offset =3D <0x24>;
> +	bootph-all;
> +};
> +
> +&sdr {
> +	compatible =3D "intel,sdr-ctl-agilex5";
> +	reg =3D <0x18000000 0x400000>,
> +	      <0x18400000 0x400000>,
> +	      <0x18800000 0x400000>;
> +	resets =3D <&rst DDRSCH_RESET>;
> +	bootph-all;
> +};
> +
> +&sysmgr {
> +	compatible =3D "altr,sys-mgr", "syscon";
> +	bootph-all;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +};
> +
> +&watchdog0 {
> +	bootph-all;
> +};
> diff --git a/arch/arm/dts/socfpga_agilex5.dtsi
> b/arch/arm/dts/socfpga_agilex5.dtsi
> new file mode 100644
> index 0000000000..0be51d8e72
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_agilex5.dtsi
> @@ -0,0 +1,654 @@
> +// SPDX-License-Identifier:     GPL-2.0
> +/*
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/reset/altr,rst-mgr-agx5.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/agilex5-clock.h>
> +
> +/ {
> +	compatible =3D "intel,socfpga-agilex";
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		service_reserved: svcbuffer@0 {
> +			compatible =3D "shared-dma-pool";
> +			reg =3D <0x0 0x0 0x0 0x1000000>;
> +			alignment =3D <0x1000>;
> +			no-map;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible =3D "arm,cortex-a55";
> +			device_type =3D "cpu";
> +			enable-method =3D "psci";
> +			reg =3D <0x0>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible =3D "arm,cortex-a55";
> +			device_type =3D "cpu";
> +			enable-method =3D "psci";
> +			reg =3D <0x1>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			compatible =3D "arm,cortex-a76";
> +			device_type =3D "cpu";
> +			enable-method =3D "psci";
> +			reg =3D <0x2>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			compatible =3D "arm,cortex-a76";
> +			device_type =3D "cpu";
> +			enable-method =3D "psci";
> +			reg =3D <0x3>;
> +		};
> +	};
> +
> +	pmu {
> +		compatible =3D "arm,armv8-pmuv3";
> +		interrupts =3D <0 170 4>,
> +			     <0 171 4>,
> +			     <0 172 4>,
> +			     <0 173 4>;
> +		interrupt-affinity =3D <&cpu0>,
> +				     <&cpu1>,
> +				     <&cpu2>,
> +				     <&cpu3>;
> +		interrupt-parent =3D <&intc>;
> +	};
> +
> +	psci {
> +		compatible =3D "arm,psci-0.2";
> +		method =3D "smc";
> +	};
> +
> +	intc: intc@fffc1000 {
> +		compatible =3D "arm,gic-400", "arm,cortex-a15-gic";
> +		#interrupt-cells =3D <3>;
> +		interrupt-controller;
> +		reg =3D <0x0 0x1d000000 0x0 0x10000>;
> +	};
> +
> +	soc {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "simple-bus";
> +		device_type =3D "soc";
> +		interrupt-parent =3D <&intc>;
> +		ranges =3D <0 0 0 0xffffffff>;
> +
> +		base_fpga_region {
> +			#address-cells =3D <0x1>;
> +			#size-cells =3D <0x1>;
> +			compatible =3D "fpga-region";
> +			fpga-mgr =3D <&fpga_mgr>;
> +		};
> +
> +		clkmgr: clock-controller@10d10000 {
> +			compatible =3D "intel,agilex5-clkmgr";
> +			reg =3D <0x10d10000 0x1000>;
> +			#clock-cells =3D <1>;
> +		};
> +
> +		clocks {
> +			cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
> +				#clock-cells =3D <0>;
> +				compatible =3D "fixed-clock";
> +			};
> +
> +			cb_intosc_ls_clk: cb-intosc-ls-clk {
> +				#clock-cells =3D <0>;
> +				compatible =3D "fixed-clock";
> +			};
> +
> +			f2s_free_clk: f2s-free-clk {
> +				#clock-cells =3D <0>;
> +				compatible =3D "fixed-clock";
> +			};
> +
> +			osc1: osc1 {
> +				#clock-cells =3D <0>;
> +				compatible =3D "fixed-clock";
> +			};
> +
> +			qspi_clk: qspi-clk {
> +				#clock-cells =3D <0>;
> +				compatible =3D "fixed-clock";
> +				clock-frequency =3D <200000000>;
> +			};
> +		};
> +		gmac0: ethernet@10810000 {
> +			compatible =3D "intel,socfpga-dwxgmac",
> "snps,dwxgmac-2.10", "snps,dwxgmac";
> +			reg =3D <0x10810000 0x3500>;
> +			interrupts =3D <0 190 4>;
> +			interrupt-names =3D "macirq";
> +			mac-address =3D [00 00 00 00 00 00];
> +			resets =3D <&rst EMAC0_RESET>, <&rst
> EMAC0_OCP_RESET>;
> +			reset-names =3D "stmmaceth", "stmmaceth-ocp";
> +			tx-fifo-depth =3D <32768>;
> +			rx-fifo-depth =3D <16384>;
> +			iommus =3D <&smmu 1>;
> +			altr,sysmgr-syscon =3D <&sysmgr 0x44 0>;
> +			clocks =3D <&clkmgr AGILEX5_EMAC0_CLK>;
> +			clock-names =3D "stmmaceth";
> +			status =3D "disabled";
> +		};
> +
> +		gmac1: ethernet@10820000 {
> +			compatible =3D "intel,socfpga-dwxgmac",
> "snps,dwxgmac-2.10", "snps,dwxgmac";
> +			reg =3D <0x10820000 0x3500>;
> +			interrupts =3D <0 207 4>;
> +			interrupt-names =3D "macirq";
> +			mac-address =3D [00 00 00 00 00 00];
> +			resets =3D <&rst EMAC1_RESET>, <&rst
> EMAC1_OCP_RESET>;
> +			reset-names =3D "stmmaceth", "stmmaceth-ocp";
> +			tx-fifo-depth =3D <32768>;
> +			rx-fifo-depth =3D <16384>;
> +			iommus =3D <&smmu 2>;
> +			altr,sysmgr-syscon =3D <&sysmgr 0x48 0>;
> +			clocks =3D <&clkmgr AGILEX5_EMAC1_CLK>;
> +			clock-names =3D "stmmaceth";
> +			status =3D "disabled";
> +		};
> +
> +		gmac2: ethernet@10830000 {
> +			compatible =3D "intel,socfpga-dwxgmac",
> "snps,dwxgmac-2.10", "snps,dwxgmac";
> +			reg =3D <0x10830000 0x3500>;
> +			interrupts =3D <0 224 4>;
> +			interrupt-names =3D "macirq";
> +			mac-address =3D [00 00 00 00 00 00];
> +			resets =3D <&rst EMAC2_RESET>, <&rst
> EMAC2_OCP_RESET>;
> +			reset-names =3D "stmmaceth", "stmmaceth-ocp";
> +			tx-fifo-depth =3D <32768>;
> +			rx-fifo-depth =3D <16384>;
> +			iommus =3D <&smmu 3>;
> +			altr,sysmgr-syscon =3D <&sysmgr 0x4c 0>;
> +			clocks =3D <&clkmgr AGILEX5_EMAC2_CLK>;
> +			clock-names =3D "stmmaceth";
> +			status =3D "disabled";
> +		};
> +
> +		gpio0: gpio@10c03200 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "snps,dw-apb-gpio";
> +			reg =3D <0x10c03200 0x80>;
> +			resets =3D <&rst GPIO0_RESET>;
> +			status =3D "disabled";
> +
> +			porta: gpio-controller@0 {
> +				compatible =3D "snps,dw-apb-gpio-port";
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
> +				snps,nr-gpios =3D <24>;
> +				reg =3D <0>;
> +				interrupt-controller;
> +				#interrupt-cells =3D <2>;
> +				interrupts =3D <0 110 4>;
> +			};
> +		};
> +
> +		gpio1: gpio@10c03300 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "snps,dw-apb-gpio";
> +			reg =3D <0x10c03300 0x80>;
> +			resets =3D <&rst GPIO1_RESET>;
> +			status =3D "disabled";
> +
> +			portb: gpio-controller@0 {
> +				compatible =3D "snps,dw-apb-gpio-port";
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
> +				snps,nr-gpios =3D <24>;
> +				reg =3D <0>;
> +				interrupt-controller;
> +				#interrupt-cells =3D <2>;
> +				interrupts =3D <0 111 4>;
> +			};
> +		};
> +
> +		i2c0: i2c@10c02800 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "snps,designware-i2c";
> +			reg =3D <0x10c02800 0x100>;
> +			interrupts =3D <0 103 4>;
> +			resets =3D <&rst I2C0_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c1: i2c@10c02900 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "snps,designware-i2c";
> +			reg =3D <0x10c02900 0x100>;
> +			interrupts =3D <0 104 4>;
> +			resets =3D <&rst I2C1_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c2: i2c@10c02a00 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "snps,designware-i2c";
> +			reg =3D <0x10c02a00 0x100>;
> +			interrupts =3D <0 105 4>;
> +			resets =3D <&rst I2C2_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c3: i2c@10c02b00 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "snps,designware-i2c";
> +			reg =3D <0x10c02b00 0x100>;
> +			interrupts =3D <0 106 4>;
> +			resets =3D <&rst I2C3_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c4: i2c@10c02c00 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "snps,designware-i2c";
> +			reg =3D <0x10c02c00 0x100>;
> +			interrupts =3D <0 107 4>;
> +			resets =3D <&rst I2C4_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		i3c0: i3c@10da0000 {
> +			compatible =3D "snps,dw-i3c-master-1.00a";
> +			reg =3D <0x10da0000 0x1000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			interrupts =3D <0 164 4>;
> +			resets =3D <&rst I3C0_RESET>;
> +			max_devices =3D <11>;
> +			clocks =3D <&clkmgr AGILEX5_L4_MP_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		i3c1: i3c@10da1000 {
> +			compatible =3D "snps,dw-i3c-master-1.00a";
> +			reg =3D <0x10da1000 0x1000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			interrupts =3D <0 165 4>;
> +			resets =3D <&rst I3C1_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_MP_CLK>;
> +			max_devices =3D <11>;
> +			status =3D "disabled";
> +		};
> +
> +		combophy0: combophy@0 {
> +			#phy-cells =3D <0>;
> +			phy-type =3D <1>;
> +			compatible =3D "cdns,combophy";
> +			reg =3D <0x10808000 0x1000>;
> +			resets =3D <&rst COMBOPHY_RESET>;
> +			reset-names =3D "reset";
> +			status =3D "disabled";
> +		};
> +
> +		mmc: mmc0@10808000 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "cdns,sd4hc";
> +			reg =3D <0x10808000 0x1000>;
> +			interrupts =3D <0 96 4>;
> +			phys =3D <&combophy0>;
> +			phy-names =3D "combo-phy";
> +			clocks =3D <&clkmgr AGILEX5_L4_MP_CLK>,
> +				 <&clkmgr AGILEX5_SDMMC_CLK>;
> +			clock-names =3D "biu", "ciu";
> +			fifo-depth =3D <0x800>;
> +			resets =3D <&rst SDMMC_RESET>;
> +			reset-names =3D "reset";
> +			iommus =3D <&smmu 5>;
> +			status =3D "disabled";
> +		};
> +
> +		nand: nand@10b80000 {
> +			compatible =3D "cdns,nand";
> +			reg =3D <0x10b80000 0x10000>,
> +				<0x10840000 0x1000>;
> +			reg-names =3D "reg", "sdma";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			interrupts =3D <0 97 4>;
> +			clocks =3D <&clkmgr AGILEX5_NAND_CLK>;
> +			resets =3D <&rst NAND_RESET>, <&rst
> COMBOPHY_RESET>;
> +			cdns,board-delay-ps =3D <4830>;
> +			status =3D "disabled";
> +		};
> +
> +		ocram: sram@00000000 {
> +			compatible =3D "mmio-sram";
> +			reg =3D <0x00000000 0x200000>;
> +		};
> +
> +		rst: rstmgr@10d11000 {
> +			#reset-cells =3D <1>;
> +			compatible =3D "altr,stratix10-rst-mgr";
> +			reg =3D <0x10d11000 0x1000>;
> +		};
> +
> +		smmu: iommu@16000000 {
> +			compatible =3D "arm,mmu-500", "arm,smmu-v2";
> +			reg =3D <0x16000000 0x40000>;
> +			#global-interrupts =3D <2>;
> +			#iommu-cells =3D <1>;
> +			interrupt-parent =3D <&intc>;
> +			interrupts =3D <0 128 4>,	/* Global Secure Fault */
> +				<0 129 4>, /* Global Non-secure Fault */
> +				/* Non-secure Context Interrupts (32) */
> +				<0 138 4>, <0 139 4>, <0 140 4>, <0 141 4>,
> +				<0 142 4>, <0 143 4>, <0 144 4>, <0 145 4>,
> +				<0 146 4>, <0 147 4>, <0 148 4>, <0 149 4>,
> +				<0 150 4>, <0 151 4>, <0 152 4>, <0 153 4>,
> +				<0 154 4>, <0 155 4>, <0 156 4>, <0 157 4>,
> +				<0 158 4>, <0 159 4>, <0 160 4>, <0 161 4>,
> +				<0 162 4>, <0 163 4>, <0 164 4>, <0 165 4>,
> +				<0 166 4>, <0 167 4>, <0 168 4>, <0 169 4>;
> +			stream-match-mask =3D <0x7ff0>;
> +			status =3D "disabled";
> +		};
> +
> +		spi0: spi@10da4000 {
> +			compatible =3D "intel,agilex-spi",
> +				     "snps,dw-apb-ssi-4.00a", "snps,dw-apb-
> ssi";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0x10da4000 0x1000>;
> +			interrupts =3D <0 99 4>;
> +			resets =3D <&rst SPIM0_RESET>;
> +			reg-io-width =3D <4>;
> +			num-cs =3D <4>;
> +			clocks =3D <&clkmgr AGILEX5_L4_MAIN_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		spi1: spi@10da5000 {
> +			compatible =3D "intel,agilex-spi",
> +				     "snps,dw-apb-ssi-4.00a", "snps,dw-apb-
> ssi";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0x10da5000 0x1000>;
> +			interrupts =3D <0 100 4>;
> +			resets =3D <&rst SPIM1_RESET>;
> +			reg-io-width =3D <4>;
> +			num-cs =3D <4>;
> +			clocks =3D <&clkmgr AGILEX5_L4_MAIN_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		sysmgr: sysmgr@10d12000 {
> +			compatible =3D "altr,sys-mgr-s10","altr,sys-mgr";
> +			reg =3D <0x10d12000 0x500>;
> +		};
> +
> +		/* Local timer */
> +		timer {
> +			compatible =3D "arm,armv8-timer";
> +			interrupts =3D <1 13 0xf08>,
> +				     <1 14 0xf08>,
> +				     <1 11 0xf08>,
> +				     <1 10 0xf08>;
> +		};
> +
> +		timer0: timer0@10c03000 {
> +			compatible =3D "snps,dw-apb-timer";
> +			interrupts =3D <0 113 4>;
> +			reg =3D <0x10c03000 0x100>;
> +			resets =3D <&rst SPTIMER0_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			clock-names =3D "timer";
> +			status =3D "disabled";
> +		};
> +
> +		timer1: timer1@10c03100 {
> +			compatible =3D "snps,dw-apb-timer";
> +			interrupts =3D <0 114 4>;
> +			reg =3D <0x10c03100 0x100>;
> +			resets =3D <&rst SPTIMER1_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			clock-names =3D "timer";
> +			status =3D "disabled";
> +		};
> +
> +		timer2: timer2@10d00000 {
> +			compatible =3D "snps,dw-apb-timer";
> +			interrupts =3D <0 115 4>;
> +			reg =3D <0x10d00000 0x100>;
> +			resets =3D <&rst L4SYSTIMER0_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
> +			clock-names =3D "timer";
> +			status =3D "disabled";
> +		};
> +
> +		timer3: timer3@10d00100 {
> +			compatible =3D "snps,dw-apb-timer";
> +			interrupts =3D <0 116 4>;
> +			reg =3D <0x10d00100 0x100>;
> +			resets =3D <&rst L4SYSTIMER1_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
> +			clock-names =3D "timer";
> +			status =3D "disabled";
> +		};
> +
> +		uart0: serial0@10c02000 {
> +			compatible =3D "snps,dw-apb-uart";
> +			reg =3D <0x10c02000 0x100>;
> +			interrupts =3D <0 108 4>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			resets =3D <&rst UART0_RESET>;
> +			status =3D "disabled";
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			clock-frequency =3D <100000000>;
> +		};
> +
> +		uart1: serial1@10c02100 {
> +			compatible =3D "snps,dw-apb-uart";
> +			reg =3D <0x10c02100 0x100>;
> +			interrupts =3D <0 109 4>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			resets =3D <&rst UART1_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		usbphy0: usbphy@0 {
> +			#phy-cells =3D <0>;
> +			compatible =3D "usb-nop-xceiv";
> +			clocks =3D <&clkmgr AGILEX5_USB_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		usb0: usb@10b00000 {
> +			compatible =3D "snps,dwc2";
> +			reg =3D <0x10b00000 0x40000>;
> +			interrupts =3D <0 93 4>;
> +			phys =3D <&usbphy0>;
> +			phy-names =3D "usb2-phy";
> +			resets =3D <&rst USB0_RESET>, <&rst
> USB0_OCP_RESET>;
> +			reset-names =3D "dwc2", "dwc2-ecc";
> +			clocks =3D <&clkmgr AGILEX5_USB_CLK>;
> +			iommus =3D <&smmu 6>;
> +			status =3D "disabled";
> +		};
> +
> +		usb31: usb31@11000000 {
> +			compatible =3D "snps,dwc3";
> +			reg =3D <0x11000000 0x100000>;
> +			resets =3D <&rst USB1_RESET>;
> +			phys =3D <&usbphy0>, <&usbphy0>;
> +			phy-names =3D "usb2-phy", "usb3-phy";
> +			dr_mode =3D "host";
> +			maximum-speed =3D "super-speed";
> +			snps,dis_u2_susphy_quirk;
> +			status =3D "disabled";
> +		};
> +
> +		watchdog0: watchdog@10d00200 {
> +			compatible =3D "snps,dw-wdt";
> +			reg =3D <0x10d00200 0x100>;
> +			interrupts =3D <0 117 4>;
> +			resets =3D <&rst WATCHDOG0_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		watchdog1: watchdog@10d00300 {
> +			compatible =3D "snps,dw-wdt";
> +			reg =3D <0x10d00300 0x100>;
> +			interrupts =3D <0 118 4>;
> +			resets =3D <&rst WATCHDOG1_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		watchdog2: watchdog@10d00400 {
> +			compatible =3D "snps,dw-wdt";
> +			reg =3D <0x10d00400 0x100>;
> +			interrupts =3D <0 125 4>;
> +			resets =3D <&rst WATCHDOG2_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		watchdog3: watchdog@10d00500 {
> +			compatible =3D "snps,dw-wdt";
> +			reg =3D <0x10d00500 0x100>;
> +			interrupts =3D <0 126 4>;
> +			resets =3D <&rst WATCHDOG3_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		watchdog4: watchdog@10d00600 {
> +			compatible =3D "snps,dw-wdt";
> +			reg =3D <0x10d00600 0x100>;
> +			interrupts =3D <0 175 4>;
> +			resets =3D <&rst WATCHDOG4_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		sdr: sdr@10d21000 {
> +			compatible =3D "altr,sdr-ctl", "syscon";
> +			reg =3D <0x10d21000 0xc0>;
> +		};
> +
> +		/* TODO: Update the ECC registers */
> +		eccmgr {
> +			compatible =3D "altr,socfpga-s10-ecc-manager",
> +				     "altr,socfpga-a10-ecc-manager";
> +			altr,sysmgr-syscon =3D <&sysmgr>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			interrupts =3D <0 15 4>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +			ranges;
> +
> +			sdramedac {
> +				compatible =3D "altr,sdram-edac-s10";
> +				altr,sdr-syscon =3D <&sdr>;
> +				interrupts =3D <16 4>;
> +			};
> +
> +			ocram-ecc@ff8cc000 {
> +				compatible =3D "altr,socfpga-s10-ocram-ecc",
> +					     "altr,socfpga-a10-ocram-ecc";
> +				reg =3D <0xff8cc000 0x100>;
> +				altr,ecc-parent =3D <&ocram>;
> +				interrupts =3D <1 4>;
> +			};
> +
> +			usb0-ecc@ff8c4000 {
> +				compatible =3D "altr,socfpga-s10-usb-ecc",
> +					     "altr,socfpga-usb-ecc";
> +				reg =3D <0xff8c4000 0x100>;
> +				altr,ecc-parent =3D <&usb0>;
> +				interrupts =3D <2 4>;
> +			};
> +
> +			emac0-rx-ecc@ff8c0000 {
> +				compatible =3D "altr,socfpga-s10-eth-mac-ecc",
> +					     "altr,socfpga-eth-mac-ecc";
> +				reg =3D <0xff8c0000 0x100>;
> +				altr,ecc-parent =3D <&gmac0>;
> +				interrupts =3D <4 4>;
> +			};
> +
> +			emac0-tx-ecc@ff8c0400 {
> +				compatible =3D "altr,socfpga-s10-eth-mac-ecc",
> +					     "altr,socfpga-eth-mac-ecc";
> +				reg =3D <0xff8c0400 0x100>;
> +				altr,ecc-parent =3D <&gmac0>;
> +				interrupts =3D <5 4>;
> +			};
> +
> +			sdmmca-ecc@ff8c8c00 {
> +				compatible =3D "altr,socfpga-s10-sdmmc-ecc",
> +					     "altr,socfpga-sdmmc-ecc";
> +				reg =3D <0xff8c8c00 0x100>;
> +				altr,ecc-parent =3D <&mmc>;
> +				interrupts =3D <14 4>,
> +					     <15 4>;
> +			};
> +		};
> +
> +		/* QSPI address not available yet */
> +		qspi: spi@108d2000 {
> +			compatible =3D "cdns,qspi-nor";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0x108d2000 0x100>,
> +			      <0x10900000 0x100000>;
> +			interrupts =3D <0 3 4>;
> +			cdns,fifo-depth =3D <128>;
> +			cdns,fifo-width =3D <4>;
> +			cdns,trigger-address =3D <0x00000000>;
> +			clocks =3D <&qspi_clk>;
> +
> +			status =3D "disabled";
> +		};
> +
> +		firmware {
> +			svc {
> +				compatible =3D "intel,stratix10-svc";
> +				method =3D "smc";
> +				memory-region =3D <&service_reserved>;
> +
> +				fpga_mgr: fpga-mgr {
> +					compatible =3D "intel,stratix10-soc-
> fpga-mgr";
> +				};
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> new file mode 100644
> index 0000000000..28e1c140c2
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * U-Boot additions
> + *
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + */
> +
> +#include "socfpga_agilex5-u-boot.dtsi"
> +
> +/{
> +	aliases {
> +		spi0 =3D &qspi;
> +		freeze_br0 =3D &freeze_controller;
> +	};
> +
> +	soc {
> +		freeze_controller: freeze_controller@0x20000450 {
> +			compatible =3D "altr,freeze-bridge-controller";
> +			reg =3D <0x20000450 0x00000010>;
> +			status =3D "disabled";
> +		};
> +	};
> +
> +	memory {
> +		/* 8GB */
> +		reg =3D <0 0x80000000 0 0x80000000>,
> +		      <8 0x80000000 1 0x80000000>;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +		u-boot,spl-boot-order =3D &mmc,&flash0,&nand,"/memory";
> +	};
> +};
> +
> +&flash0 {
> +	compatible =3D "jedec,spi-nor";
> +	spi-tx-bus-width =3D <4>;
> +	spi-rx-bus-width =3D <4>;
> +	bootph-all;
> +	/delete-property/ cdns,read-delay;
> +};
> +
> +&flash1 {
> +	bootph-all;
> +};
> +
> +&i3c0 {
> +	bootph-all;
> +};
> +
> +&i3c1 {
> +	bootph-all;
> +};
> +
> +&mmc {
> +	status =3D "okay";
> +	bus-width =3D <4>;
> +	sd-uhs-sdr50;
> +	cap-mmc-highspeed;
> +	bootph-all;
> +};
> +
> +&combophy0 {
> +	status =3D "okay";
> +	bootph-all;
> +	cdns,phy-use-ext-lpbk-dqs =3D <1>;
> +	cdns,phy-use-lpbk-dqs =3D <1>;
> +	cdns,phy-use-phony-dqs =3D <1>;
> +	cdns,phy-use-phony-dqs-cmd =3D <1>;
> +	cdns,phy-io-mask-always-on =3D <0>;
> +	cdns,phy-io-mask-end =3D <5>;
> +	cdns,phy-io-mask-start =3D <0>;
> +	cdns,phy-data-select-oe-end =3D <1>;
> +	cdns,phy-sync-method =3D <1>;
> +	cdns,phy-sw-half-cycle-shift =3D <0>;
> +	cdns,phy-rd-del-sel =3D <52>;
> +	cdns,phy-underrun-suppress =3D <1>;
> +	cdns,phy-gate-cfg-always-on =3D <1>;
> +	cdns,phy-param-dll-bypass-mode =3D <1>;
> +	cdns,phy-param-phase-detect-sel =3D <2>;
> +	cdns,phy-param-dll-start-point =3D <254>;
> +	cdns,phy-read-dqs-cmd-delay =3D <0>;
> +	cdns,phy-clk-wrdqs-delay =3D <0>;
> +	cdns,phy-clk-wr-delay =3D <0>;
> +	cdns,phy-read-dqs-delay =3D <0>;
> +	cdns,phy-phony-dqs-timing =3D <0>;
> +	cdns,hrs09-rddata-en =3D <1>;
> +	cdns,hrs09-rdcmd-en =3D <1>;
> +	cdns,hrs09-extended-wr-mode =3D <1>;
> +	cdns,hrs09-extended-rd-mode =3D <1>;
> +	cdns,hrs10-hcsdclkadj =3D <3>;
> +	cdns,hrs16-wrdata1-sdclk-dly =3D <0>;
> +	cdns,hrs16-wrdata0-sdclk-dly =3D <0>;
> +	cdns,hrs16-wrcmd1-sdclk-dly =3D <0>;
> +	cdns,hrs16-wrcmd0-sdclk-dly =3D <0>;
> +	cdns,hrs16-wrdata1-dly =3D <0>;
> +	cdns,hrs16-wrdata0-dly =3D <0>;
> +	cdns,hrs16-wrcmd1-dly =3D <0>;
> +	cdns,hrs16-wrcmd0-dly =3D <0>;
> +	cdns,hrs07-rw-compensate =3D <10>;
> +	cdns,hrs07-idelay-val =3D <0>;
> +};
> +
> +&qspi {
> +	status =3D "okay";
> +};
> +
> +&nand {
> +	bootph-all;
> +};
> +
> +&timer0 {
> +	bootph-all;
> +};
> +
> +&timer1 {
> +	bootph-all;
> +};
> +
> +&timer2 {
> +	bootph-all;
> +};
> +
> +&timer3 {
> +	bootph-all;
> +};
> +
> +&watchdog0 {
> +	bootph-all;
> +};
> +
> +#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
> +&fdt_0_blob {
> +	filename =3D "arch/arm/dts/socfpga_agilex5_socdk.dtb";
> +};
> +
> +/* To add NAND dtb when ready in future */
> +
> +&binman {
> +	/delete-node/ kernel;
> +};
> +#endif
> +
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts
> b/arch/arm/dts/socfpga_agilex5_socdk.dts
> new file mode 100644
> index 0000000000..852e1e5ae3
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier:     GPL-2.0
> +/*
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + */
> +#include "socfpga_agilex5.dtsi"
> +
> +/ {
> +	model =3D "SoCFPGA Agilex5 SoCDK";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +		ethernet0 =3D &gmac0;
> +		ethernet2 =3D &gmac2;
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +		hps0 {
> +			label =3D "hps_led0";
> +			gpios =3D <&portb 20 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		hps1 {
> +			label =3D "hps_led1";
> +			gpios =3D <&portb 19 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		hps2 {
> +			label =3D "hps_led2";
> +			gpios =3D <&portb 21 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	memory {
> +		device_type =3D "memory";
> +		/* We expect the bootloader to fill in the reg */
> +		reg =3D <0 0 0 0>;
> +	};
> +
> +	soc {
> +		clocks {
> +			osc1 {
> +				clock-frequency =3D <25000000>;
> +			};
> +		};
> +	};
> +};
> +
> +&gpio0 {
> +	status =3D "okay";
> +};
> +
> +&gpio1 {
> +	status =3D "okay";
> +};
> +
> +&i2c0 {
> +	status =3D "okay";
> +};
> +
> +&i2c1 {
> +	status =3D "okay";
> +};
> +
> +&i3c0 {
> +	status =3D "okay";
> +};
> +
> +&i3c1 {
> +	status =3D "okay";
> +};
> +
> +&uart0 {
> +	status =3D "okay";
> +};
> +
> +&usbphy0 {
> +	status =3D "okay";
> +};
> +
> +&usb0 {
> +	status =3D "okay";
> +	disable-over-current;
> +};
> +
> +&watchdog0 {
> +	status =3D "okay";
> +};
> +
> +&watchdog1 {
> +	status =3D "okay";
> +};
> +
> +&watchdog2 {
> +	status =3D "okay";
> +};
> +
> +&watchdog3 {
> +	status =3D "okay";
> +};
> +
> +&watchdog4 {
> +	status =3D "okay";
> +};
> +
> +&timer0 {
> +	status =3D "okay";
> +};
> +
> +&timer1 {
> +	status =3D "okay";
> +};
> +
> +&timer2 {
> +	status =3D "okay";
> +};
> +
> +&timer3 {
> +	status =3D "okay";
> +};
> +
> +&spi0 {
> +	status =3D "okay";
> +};
> +
> +&spi1 {
> +	status =3D "okay";
> +};
> +
> +&qspi {
> +	flash0: flash@0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "mt25qu02g";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <100000000>;
> +
> +		m25p,fast-read;
> +		cdns,page-size =3D <256>;
> +		cdns,block-size =3D <16>;
> +		cdns,read-delay =3D <1>;
> +		cdns,tshsl-ns =3D <50>;
> +		cdns,tsd2d-ns =3D <50>;
> +		cdns,tchsh-ns =3D <4>;
> +		cdns,tslch-ns =3D <4>;
> +
> +		partitions {
> +			compatible =3D "fixed-partitions";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +
> +			qspi_boot: partition@0 {
> +				label =3D "u-boot";
> +				reg =3D <0x0 0x04200000>;
> +			};
> +
> +			root: partition@4200000 {
> +				label =3D "root";
> +				reg =3D <0x04200000 0x0BE00000>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> index 84b91e8df0..7a5af489c5 100644
> --- a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> @@ -2,7 +2,7 @@
>  /*
>   * U-Boot additions
>   *
> - * Copyright (C) 2020 Intel Corporation <www.intel.com>
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
>   */
>=20
>  #if defined(CONFIG_FIT)
> @@ -21,14 +21,18 @@
>  			description =3D "FIT with firmware and bootloader";
>  			#address-cells =3D <1>;
>=20
> -			images {
> +			images: images {
>  				uboot {
>  					description =3D "U-Boot SoC64";
>  					type =3D "standalone";
>  					os =3D "U-Boot";
>  					arch =3D "arm64";
>  					compression =3D "none";
> +				#if
> IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +					load =3D <0x80200000>;
> +				#else
>  					load =3D <0x00200000>;
> +				#endif
>  					uboot_blob: blob-ext {
>  						filename =3D "u-boot-
> nodtb.bin";
>  					};
> @@ -43,8 +47,13 @@
>  					os =3D "arm-trusted-firmware";
>  					arch =3D "arm64";
>  					compression =3D "none";
> +				#if
> IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +					load =3D <0x80000000>;
> +					entry =3D <0x80000000>;
> +				#else
>  					load =3D <0x00001000>;
>  					entry =3D <0x00001000>;
> +				#endif
>  					atf_blob: blob-ext {
>  						filename =3D "bl31.bin";
>  					};
> @@ -53,11 +62,11 @@
>  					};
>  				};
>=20
> -				fdt {
> -					description =3D "U-Boot SoC64 flat
> device-tree";
> +				fdt-0 {
> +					description =3D "socfpga_socdk";
>  					type =3D "flat_dt";
>  					compression =3D "none";
> -					uboot_fdt_blob: blob-ext {
> +					fdt_0_blob: blob-ext {
>  						filename =3D "u-boot.dtb";
>  					};
>  					hash {
> @@ -66,17 +75,18 @@
>  				};
>  			};
>=20
> -			configurations {
> -				default =3D "conf";
> -				conf {
> -					description =3D "Intel SoC64 FPGA";
> +			board_config: configurations {
> +				default =3D "board-0";
> +
> +				board-0 {
> +					description =3D "board_0";
>  					firmware =3D "atf";
>  					loadables =3D "uboot";
> -					fdt =3D "fdt";
> +					fdt =3D "fdt-0";
>  					signature {
>  						algo =3D "crc32";
>  						key-name-hint =3D "dev";
> -						sign-images =3D "atf", "fdt",
> "uboot";
> +						sign-images =3D "atf", "uboot",
> "fdt-0";
>  					};
>  				};
>  			};
> @@ -96,8 +106,8 @@
>  					arch =3D "arm64";
>  					os =3D "linux";
>  					compression =3D "none";
> -					load =3D <0x4080000>;
> -					entry =3D <0x4080000>;
> +					load =3D <0x6000000>;
> +					entry =3D <0x6000000>;
>  					kernel_blob: blob-ext {
>  						filename =3D "Image";
>  					};
> @@ -146,7 +156,7 @@
>  	filename =3D "signed-bl31.bin";
>  };
>=20
> -&uboot_fdt_blob {
> +&fdt_0_blob {
>  	filename =3D "signed-u-boot.dtb";
>  };
>=20
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-
> socfpga/Kconfig
> index 114d243812..bb61e91ac3 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -8,7 +8,7 @@ config NR_DRAM_BANKS
>=20
>  config SOCFPGA_SECURE_VAB_AUTH
>  	bool "Enable boot image authentication with Secure Device Manager"
> -	depends on TARGET_SOCFPGA_AGILEX || TARGET_SOCFPGA_N5X
> +	depends on TARGET_SOCFPGA_AGILEX || TARGET_SOCFPGA_N5X ||
> TARGET_SOCFPGA_AGILEX5
>  	select FIT_IMAGE_POST_PROCESS
>  	select SHA384
>  	select SHA512
> @@ -54,10 +54,51 @@ config TARGET_SOCFPGA_AGILEX
>  	select BINMAN if SPL_ATF
>  	select CLK
>  	select FPGA_INTEL_SDM_MAILBOX
> +	select GICV2
>  	select NCORE_CACHE
>  	select SPL_CLK if SPL
>  	select TARGET_SOCFPGA_SOC64
>=20
> +config TARGET_SOCFPGA_AGILEX5
> +	bool
> +	select BINMAN if SPL_ATF
> +	select CLK
> +	select FPGA_INTEL_SDM_MAILBOX
> +	select GICV3
> +	select NCORE_CACHE
> +	select SPL_CLK if SPL
> +	select TARGET_SOCFPGA_SOC64
> +
> +config TARGET_SOCFPGA_AGILEX5_OOBE2
> +	bool "Enable build that bootable only on Agilex5 OOBE2 DevKit"
> +	help
> +	 This is for Agilex5 platform.
> +	 It enable build that bootable only on Agilex5 OOBE2 DevKit.
> +
> +config TARGET_SOCFPGA_AGILEX5_NAND2
> +	bool "Enable build that bootable only on Agilex5 NAND2 DevKit"
> +	help
> +	 This is for Agilex5 platform.
> +	 Enable build that bootable only on Agilex5 NAND2 DevKit.
> +
> +config TARGET_SOCFPGA_AGILEX5_TSN_AIC0
> +	bool "Enable build that bootable only on Agilex5 TSN_PHY_AIC0
> MuDV"
> +	help
> +	 This is for Agilex5 platform.
> +	 Enable build that bootable only on Agilex5 TSN_PHY_AIC0 MuDV.
> +
> +config TARGET_SOCFPGA_AGILEX5_TSN_AIC1
> +	bool "Enable build that bootable only on Agilex5 TSN_PHY_AIC1
> MuDV"
> +	help
> +	 This is for Agilex5 platform.
> +	 Enable build that bootable only on Agilex5 TSN_PHY_AIC1 MuDV.
> +
> +config TARGET_SOCFPGA_AGILEX5_TSN_AIC2
> +	bool "Enable build that bootable only on Agilex5 TSN_PHY_AIC2
> MuDV"
> +	help
> +	 This is for Agilex5 platform.
> +	 Enable build that bootable only on Agilex5 TSN_PHY_AIC2 MuDV.
> +
>  config TARGET_SOCFPGA_ARRIA5
>  	bool
>  	select TARGET_SOCFPGA_GEN5
> @@ -121,6 +162,25 @@ config TARGET_SOCFPGA_STRATIX10
>  	select FPGA_INTEL_SDM_MAILBOX
>  	select TARGET_SOCFPGA_SOC64
>=20
> +config ARMV8_PSCI_NR_CPUS
> +	default 4 if TARGET_SOCFPGA_SOC64
> +
> +config ARMV8_SECURE_BASE
> +	default 0x00001000 if TARGET_SOCFPGA_SOC64 && ARMV8_PSCI
> +
> +config SYS_HAS_ARMV8_SECURE_BASE
> +	default y if TARGET_SOCFPGA_SOC64 && ARMV8_PSCI
> +
> +config TARGET_SOCFPGA_AGILEX5
> +	bool
> +	select BINMAN if SPL_ATF
> +	select CLK
> +	select FPGA_INTEL_SDM_MAILBOX
> +	select GICV3
> +	select NCORE_CACHE
> +	select SPL_CLK if SPL
> +	select TARGET_SOCFPGA_SOC64
> +
>  choice
>  	prompt "Altera SOCFPGA board select"
>  	optional
> @@ -129,6 +189,10 @@ config TARGET_SOCFPGA_AGILEX_SOCDK
>  	bool "Intel SOCFPGA SoCDK (Agilex)"
>  	select TARGET_SOCFPGA_AGILEX
>=20
> +config TARGET_SOCFPGA_AGILEX5_SOCDK
> +	bool "Intel SOCFPGA SoCDK (Agilex5)"
> +	select TARGET_SOCFPGA_AGILEX5
> +
>  config TARGET_SOCFPGA_ARIES_MCVEVK
>  	bool "Aries MCVEVK (Cyclone V)"
>  	select TARGET_SOCFPGA_CYCLONE5
> @@ -202,6 +266,7 @@ config TARGET_SOCFPGA_TERASIC_SOCKIT
>  endchoice
>=20
>  config SYS_BOARD
> +	default "agilex5-socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
>  	default "agilex-socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
>  	default "arria5-socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
>  	default "arria10-socdk" if TARGET_SOCFPGA_ARRIA10_SOCDK
> @@ -223,6 +288,7 @@ config SYS_BOARD
>  	default "vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
>=20
>  config SYS_VENDOR
> +	default "intel" if TARGET_SOCFPGA_AGILEX5_SOCDK
>  	default "intel" if TARGET_SOCFPGA_AGILEX_SOCDK
>  	default "intel" if TARGET_SOCFPGA_N5X_SOCDK
>  	default "altera" if TARGET_SOCFPGA_ARRIA5_SOCDK
> @@ -245,6 +311,7 @@ config SYS_SOC
>  	default "socfpga"
>=20
>  config SYS_CONFIG_NAME
> +	default "socfpga_agilex5_socdk" if
> TARGET_SOCFPGA_AGILEX5_SOCDK
>  	default "socfpga_agilex_socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
>  	default "socfpga_arria5_secu1" if TARGET_SOCFPGA_ARRIA5_SECU1
>  	default "socfpga_arria5_socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-
> socfpga/Makefile
> index ec38b64dd4..181bb01fdd 100644
> --- a/arch/arm/mach-socfpga/Makefile
> +++ b/arch/arm/mach-socfpga/Makefile
> @@ -4,7 +4,7 @@
>  # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>  #
>  # Copyright (C) 2012-2017 Altera Corporation <www.altera.com>
> -# Copyright (C) 2017-2021 Intel Corporation <www.intel.com>
> +# Copyright (C) 2017-2024 Intel Corporation <www.intel.com>
>=20
>  obj-y	+=3D board.o
>  obj-y	+=3D clock_manager.o
> @@ -94,6 +94,8 @@ obj-y	+=3D spl_agilex.o
>  endif
>  ifdef CONFIG_TARGET_SOCFPGA_N5X
>  obj-y	+=3D spl_n5x.o
> +ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
> +obj-y	+=3D spl_soc64.o
>  endif
>  else
>  obj-$(CONFIG_SPL_ATF) +=3D secure_reg_helper.o
> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-
> socfpga/board.c
> index 09e09192fb..616e1afe5d 100644
> --- a/arch/arm/mach-socfpga/board.c
> +++ b/arch/arm/mach-socfpga/board.c
> @@ -7,9 +7,11 @@
>=20
>  #include <common.h>
>  #include <asm/arch/clock_manager.h>
> +#include <asm/arch/mailbox_s10.h>
>  #include <asm/arch/misc.h>
>  #include <asm/arch/reset_manager.h>
>  #include <asm/arch/secure_vab.h>
> +#include <asm/arch/smc_api.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <errno.h>
> @@ -23,6 +25,8 @@
>=20
>  DECLARE_GLOBAL_DATA_PTR;
>=20
> +#define DEFAULT_JTAG_USERCODE 0xFFFFFFFF
> +
>  void s_init(void) {
>  #ifndef CONFIG_ARM64
>  	/*
> @@ -92,13 +96,50 @@ int g_dnl_board_usb_cable_connected(void)
>  }
>  #endif
>=20
> -#ifdef CONFIG_SPL_BUILD
> -__weak int board_fit_config_name_match(const char *name)
> +u8 socfpga_get_board_id(void)
>  {
> -	/* Just empty function now - can't decide what to choose */
> -	debug("%s: %s\n", __func__, name);
> +	u8 board_id =3D 0;
> +	u32 jtag_usercode;
> +	int err;
>=20
> -	return 0;
> +#if !IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_SPL_ATF)
> +	err =3D smc_get_usercode(&jtag_usercode);
> +#else
> +	u32 resp_len =3D 1;
> +
> +	err =3D mbox_send_cmd(MBOX_ID_UBOOT, MBOX_GET_USERCODE,
> MBOX_CMD_DIRECT, 0,
> +			    NULL, 0, &resp_len, &jtag_usercode);
> +#endif
> +
> +	if (err) {
> +		puts("Fail to read JTAG Usercode. Default Board ID to 0\n");
> +		return board_id;
> +	}
> +
> +	debug("Valid JTAG Usercode: %u\n", jtag_usercode);
> +
> +	if (jtag_usercode =3D=3D DEFAULT_JTAG_USERCODE) {
> +		debug("JTAG Usercode is not set. Default Board ID to 0\n");
> +	} else if (jtag_usercode >=3D 0 && jtag_usercode <=3D 255) {
> +		board_id =3D jtag_usercode;
> +		debug("Valid JTAG Usercode. Set Board ID to %u\n",
> board_id);
> +	} else {
> +		puts("Board ID is not in range 0 to 255\n");
> +	}
> +
> +	return board_id;
> +}
> +
> +#if IS_ENABLED(CONFIG_SPL_BUILD) &&
> IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)
> +int board_fit_config_name_match(const char *name)
> +{
> +	char board_name[10];
> +
> +	sprintf(board_name, "board_%u", socfpga_get_board_id());
> +
> +	debug("Board name: %s\n", board_name);
> +
> +	return strcmp(name, board_name);
>  }
>  #endif
>=20
> @@ -116,6 +157,8 @@ void board_fit_image_post_process(const void *fit,
> int node, void **p_image,
>  #if !IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_FIT)
>  void board_prep_linux(struct bootm_headers *images)
>  {
> +	bool use_fit =3D false;
> +
>  	if (!images->fit_uname_cfg) {
>  		if (IS_ENABLED(CONFIG_SOCFPGA_SECURE_VAB_AUTH) &&
>=20
> !IS_ENABLED(CONFIG_SOCFPGA_SECURE_VAB_AUTH_ALLOW_NON_FIT_IMA
> GE)) {
> @@ -127,12 +170,13 @@ void board_prep_linux(struct bootm_headers
> *images)
>  			hang();
>  		}
>  	} else {
> +		use_fit =3D true;
>  		/* Update fdt_addr in enviroment variable */
>  		env_set_hex("fdt_addr", (ulong)images->ft_addr);
>  		debug("images->ft_addr =3D 0x%08lx\n", (ulong)images-
> >ft_addr);
>  	}
>=20
> -	if (IS_ENABLED(CONFIG_CADENCE_QSPI)) {
> +	if (use_fit && IS_ENABLED(CONFIG_CADENCE_QSPI)) {
>  		if (env_get("linux_qspi_enable"))
>  			run_command(env_get("linux_qspi_enable"), 0);
>  	}
> diff --git a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
> b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
> index 3f899fcfa3..8215238ac7 100644
> --- a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
> @@ -1,21 +1,59 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Copyright (C) 2016-2021 Intel Corporation <www.intel.com>
> + * Copyright (C) 2016-2024 Intel Corporation <www.intel.com>
>   */
>=20
>  #ifndef _SOCFPGA_SOC64_BASE_HARDWARE_H_
>  #define _SOCFPGA_SOC64_BASE_HARDWARE_H_
>=20
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#define SOCFPGA_CCU_ADDRESS			0x1c000000
> +#define SOCFPGA_F2SDRAM_MGR_ADDRESS		0x18001000
> +#define SOCFPGA_SMMU_ADDRESS			0x16000000
> +#define SOCFPGA_OCRAM_FIREWALL_ADDRESS		0x108cc400
> +#define SOCFPGA_MAILBOX_ADDRESS			0x10a30000
> +#define SOCFPGA_UART0_ADDRESS			0x10c02000
> +#define SOCFPGA_UART1_ADDRESS			0x10c02100
> +#define SOCFPGA_SPTIMER0_ADDRESS		0x10c03000
> +#define SOCFPGA_SPTIMER1_ADDRESS		0x10c03100
> +#define SOCFPGA_SYSTIMER0_ADDRESS		0x10d00000
> +#define SOCFPGA_SYSTIMER1_ADDRESS		0x10d00100
> +#define SOCFPGA_L4WD0_ADDRESS			0x10d00200
> +#define SOCFPGA_L4WD1_ADDRESS			0x10d00300
> +#define SOCFPGA_L4WD2_ADDRESS			0x10d00400
> +#define SOCFPGA_L4WD3_ADDRESS			0x10d00500
> +#define SOCFPGA_L4WD4_ADDRESS			0x10d00600
> +#define SOCFPGA_GTIMER_SEC_ADDRESS		0x10d01000
> +#define SOCFPGA_GTIMER_NSEC_ADDRESS		0x10d02000
> +#define SOCFPGA_CLKMGR_ADDRESS			0x10d10000
> +#define SOCFPGA_RSTMGR_ADDRESS			0x10d11000
> +#define SOCFPGA_SYSMGR_ADDRESS			0x10d12000
> +#define SOCFPGA_OCRAM_ADDRESS			0x00000000
> +#define SOCFPGA_FW_DDR_CCU_DMI0_ADDRESS		0x18000800
> +#define SOCFPGA_FW_DDR_CCU_DMI1_ADDRESS		0x18000A00
> +#define SOCFPGA_FW_TBU2NOC_ADDRESS		0x18000C00
> +#define SOCFPGA_FIREWALL_L4_PER			0x10d21000
> +#define SOCFPGA_FIREWALL_L4_SYS			0x10d21100
> +#define SOCFPGA_FIREWALL_SOC2FPGA		0x10d21200
> +#define SOCFPGA_FIREWALL_LWSOC2FPGA		0x10d21300
> +#define SOCFPGA_FIREWALL_TCU			0x10d21400
> +#define SOCFPGA_FIREWALL_PRIV_MEMORYMAP_PRIV	0x10d24800
> +#define GICD_BASE				0x1d000000
> +#define GICR_BASE				0x1d060000
> +#else
>  #define SOCFPGA_CCU_ADDRESS			0xf7000000
>  #define SOCFPGA_SDR_SCHEDULER_ADDRESS		0xf8000400
>  #define SOCFPGA_HMC_MMR_IO48_ADDRESS		0xf8010000
>  #define SOCFPGA_SDR_ADDRESS			0xf8011000
> +#define SOCFPGA_FW_MPFE_SCR_ADDRESS		0xf8020000
>  #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
> -	IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
> +	IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X) || \
> +	IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7)
>  #define SOCFPGA_FW_MPU_DDR_SCR_ADDRESS		0xf8020200
>  #else
>  #define SOCFPGA_FW_MPU_DDR_SCR_ADDRESS		0xf8020100
>  #endif
> +#define SOCFPGA_F2SDRAM_MGR_ADDRESS		0xf8024000
>  #define SOCFPGA_SMMU_ADDRESS			0xfa000000
>  #define SOCFPGA_MAILBOX_ADDRESS			0xffa30000
>  #define SOCFPGA_UART0_ADDRESS			0xffc02000
> @@ -39,10 +77,12 @@
>  #define SOCFPGA_FIREWALL_SOC2FPGA		0xffd21200
>  #define SOCFPGA_FIREWALL_LWSOC2FPGA		0xffd21300
>  #define SOCFPGA_FIREWALL_TCU			0xffd21400
> +#define SOCFPGA_FIREWALL_PRIV_MEMORYMAP_PRIV	0xffd24800
>  #define SOCFPGA_DMANONSECURE_ADDRESS		0xffda0000
>  #define SOCFPGA_DMASECURE_ADDRESS		0xffda1000
>  #define SOCFPGA_OCRAM_ADDRESS			0xffe00000
>  #define GICD_BASE				0xfffc1000
>  #define GICC_BASE				0xfffc2000
> +#endif /* IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) */
>=20
>  #endif /* _SOCFPGA_SOC64_BASE_HARDWARE_H_ */
> diff --git a/board/intel/agilex5-socdk/MAINTAINERS b/board/intel/agilex5-
> socdk/MAINTAINERS
> new file mode 100644
> index 0000000000..b696f788c8
> --- /dev/null
> +++ b/board/intel/agilex5-socdk/MAINTAINERS
> @@ -0,0 +1,8 @@
> +SOCFPGA BOARD
> +M:	Tien Fong Chee <tien.fong.chee@intel.com>
> +M:	Teik Heng Chong <teik.heng.chong@intel.com>
> +M:	Jit Loon Lim <jit.loon.lim@intel.com>
> +S:	Maintained
> +F:	board/intel/agilex5-socdk/
> +F:	include/configs/socfpga_agilex5_socdk.h
> +F:	configs/socfpga_agilex5_defconfig
> diff --git a/board/intel/agilex5-socdk/Makefile b/board/intel/agilex5-
> socdk/Makefile
> new file mode 100644
> index 0000000000..d598d249e5
> --- /dev/null
> +++ b/board/intel/agilex5-socdk/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Copyright (C) 2024 Intel Corporation <www.intel.com>
> +#
> +# SPDX-License-Identifier:	GPL-2.0
> +#
> +
> +obj-y	:=3D socfpga.o
> diff --git a/configs/socfpga_agilex5_defconfig
> b/configs/socfpga_agilex5_defconfig
> new file mode 100644
> index 0000000000..415c8e4a2b
> --- /dev/null
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -0,0 +1,113 @@
> +CONFIG_ARM=3Dy
> +CONFIG_SPL_LDSCRIPT=3D"arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
> +CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x04000000
> +CONFIG_ARCH_SOCFPGA=3Dy
> +CONFIG_TEXT_BASE=3D0x80200000
> +CONFIG_SYS_MALLOC_F_LEN=3D0x2000
> +CONFIG_NR_DRAM_BANKS=3D2
> +CONFIG_ENV_SIZE=3D0x2000
> +CONFIG_ENV_OFFSET=3D0x04100000
> +CONFIG_DM_GPIO=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"socfpga_agilex5_socdk"
> +CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK=3Dy
> +CONFIG_IDENT_STRING=3D"socfpga_agilex5"
> +CONFIG_SPL_FS_FAT=3Dy
> +CONFIG_DISTRO_DEFAULTS=3Dy
> +CONFIG_FIT=3Dy
> +CONFIG_SPL_FIT_SIGNATURE=3Dy
> +CONFIG_SPL_LOAD_FIT=3Dy
> +CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x82000000
> +# CONFIG_USE_SPL_FIT_GENERATOR is not set
> +CONFIG_QSPI_BOOT=3Dy
> +CONFIG_BOOTDELAY=3D5
> +CONFIG_USE_BOOTARGS=3Dy
> +CONFIG_BOOTARGS=3D"console=3DttyS0,115200 initrd=3D0x90000000
> root=3D/dev/ram0 rw init=3D/sbin/init ramdisk_size=3D10000000 earlycon pa=
nic=3D-1
> nosmp kvm-arm.mode=3Dnvhe"
> +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_CRC32=3Dy
> +CONFIG_SPL_CACHE=3Dy
> +CONFIG_SPL_ATF=3Dy
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
> +CONFIG_SYS_PROMPT=3D"SOCFPGA_AGILEX5 # "
> +CONFIG_CMD_NVEDIT_SELECT=3Dy
> +CONFIG_CMD_MEMTEST=3Dy
> +CONFIG_CMD_GPIO=3Dy
> +CONFIG_CMD_I2C=3Dy
> +CONFIG_CMD_SF=3Dy
> +CONFIG_DOS_PARTITION=3Dy
> +CONFIG_SPL_DOS_PARTITION=3Dy
> +CONFIG_SPL_SYS_DISABLE_DCACHE_OPS=3Dy
> +CONFIG_CMD_MTD=3Dy
> +# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
> +CONFIG_CMD_SPI=3Dy
> +CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_CACHE=3Dy
> +CONFIG_SPL_SPI_FLASH_MTD=3Dy
> +CONFIG_SPI_FLASH_MTD=3Dy
> +CONFIG_SPL_MTD_SUPPORT=3Dy
> +CONFIG_CMD_UBI=3Dy
> +CONFIG_CMD_UBIFS=3Dy
> +CONFIG_MTD_UBI=3Dy
> +CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
> +CONFIG_MTD_UBI_BEB_LIMIT=3D20
> +# CONFIG_ISO_PARTITION is not set
> +# CONFIG_EFI_PARTITION is not set
> +CONFIG_OF_LIST=3D""
> +CONFIG_ENV_IS_IN_UBI=3Dy
> +CONFIG_ENV_UBI_PART=3D"root"
> +CONFIG_ENV_UBI_VOLUME=3D"env"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> +CONFIG_NET_RANDOM_ETHADDR=3Dy
> +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> +CONFIG_SPL_ALTERA_SDRAM=3Dy
> +CONFIG_FPGA_INTEL_PR=3Dy
> +CONFIG_DWAPB_GPIO=3Dy
> +CONFIG_DM_I2C=3Dy
> +CONFIG_SYS_I2C_DW=3Dy
> +CONFIG_MISC=3Dy
> +CONFIG_MTD=3Dy
> +CONFIG_DM_MTD=3Dy
> +CONFIG_SF_DEFAULT_MODE=3D0x2003
> +CONFIG_SPI_FLASH_SPANSION=3Dy
> +CONFIG_SPI_FLASH_STMICRO=3Dy
> +CONFIG_UBI_SILENCE_MSG=3Dy
> +CONFIG_DM_ETH=3Dy
> +CONFIG_RGMII=3Dy
> +CONFIG_DM_RESET=3Dy
> +CONFIG_SYS_NS16550_MEM32=3Dy
> +CONFIG_SPI=3Dy
> +CONFIG_CADENCE_QSPI=3Dy
> +CONFIG_DESIGNWARE_SPI=3Dy
> +CONFIG_USB=3Dy
> +CONFIG_USB_DWC2=3Dy
> +CONFIG_USB_XHCI_HCD=3Dy
> +CONFIG_UBIFS_SILENCE_MSG=3Dy
> +# CONFIG_SPL_USE_TINY_PRINTF is not set
> +CONFIG_PANIC_HANG=3Dy
> +CONFIG_SPL_SPI_LOAD=3Dy
> +CONFIG_SYS_LOAD_ADDR=3D0x82000000
> +CONFIG_WDT=3Dy
> +CONFIG_CMD_WDT=3Dy
> +CONFIG_DESIGNWARE_WATCHDOG=3Dy
> +CONFIG_SPL_WDT=3Dy
> +CONFIG_WATCHDOG_AUTOSTART=3Dn
> +CONFIG_TIMER=3Dy
> +CONFIG_DESIGNWARE_APB_TIMER=3Dy
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80300000
> +CONFIG_SPL_MAX_SIZE=3D0x40000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> +CONFIG_SPL_BSS_START_ADDR=3D0xbff00000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x7f000
> +CONFIG_SYS_SPL_MALLOC=3Dy
> +CONFIG_HAS_CUSTOM_SPL_MALLOC_START=3Dy
> +CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=3D0xbfa00000
> +CONFIG_SYS_SPL_MALLOC_SIZE=3D0x500000
> +CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_EFI_LOADER is not set
> +CONFIG_I3C=3Dy
> +CONFIG_DW_I3C_MASTER=3Dy
> +CONFIG_CMD_I3C=3Dy
> +CONFIG_SYS_MAXARGS=3D32
> +CONFIG_CMD_TIMER=3Dy
> diff --git a/include/configs/socfpga_agilex5_socdk.h
> b/include/configs/socfpga_agilex5_socdk.h
> new file mode 100644
> index 0000000000..b5b5bd767f
> --- /dev/null
> +++ b/include/configs/socfpga_agilex5_socdk.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + *
> + */
> +
> +#ifndef __CONFIG_SOCFGPA_AGILEX5_H__
> +#define __CONFIG_SOCFGPA_AGILEX5_H__
> +
> +#include <configs/socfpga_soc64_common.h>
> +
> +#endif	/* __CONFIG_SOCFGPA_AGILEX5_H__ */
> diff --git a/include/configs/socfpga_soc64_common.h
> b/include/configs/socfpga_soc64_common.h
> index 820372c28b..26a7ad1a5c 100644
> --- a/include/configs/socfpga_soc64_common.h
> +++ b/include/configs/socfpga_soc64_common.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0
>   *
> - * Copyright (C) 2017-2019 Intel Corporation <www.intel.com>
> + * Copyright (C) 2017-2024 Intel Corporation <www.intel.com>
>   *
>   */
>=20
> @@ -14,29 +14,193 @@
>  /*
>   * U-Boot general configurations
>   */
> -/* sysmgr.boot_scratch_cold4 & 5 (64bit) will be used for PSCI_CPU_ON ca=
ll
> */
> -#define CPU_RELEASE_ADDR		0xFFD12210
>=20
>  /*
>   * U-Boot console configurations
>   */
>=20
> -/* Extend size of kernel image for uncompression */
> -
>  /*
>   * U-Boot run time memory configurations
>   */
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#define CFG_SYS_INIT_RAM_ADDR	0x0
> +#define CFG_SYS_INIT_RAM_SIZE	0x80000
> +#else
>  #define CFG_SYS_INIT_RAM_ADDR	0xFFE00000
>  #define CFG_SYS_INIT_RAM_SIZE	0x40000
> +#endif
>=20
>  /*
>   * U-Boot environment configurations
>   */
> +/*
> + * NAND support
> + */
> +#ifdef CONFIG_NAND_DENALI
> +#define CONFIG_SYS_NAND_ONFI_DETECTION
> +#define CONFIG_SYS_MAX_NAND_DEVICE	1
> +
> +#define CFG_SYS_NAND_U_BOOT_SIZE	(1 * 1024 * 1024)
> +#define CFG_SYS_NAND_U_BOOT_DST	CONFIG_TEXT_BASE
> +#endif /* CONFIG_NAND_DENALI */
>=20
>  /*
>   * Environment variable
>   */
> +#if IS_ENABLED(CONFIG_SPL_ATF)
> +#define CONFIG_BOOTFILE "kernel.itb"
> +#else
> +#define CONFIG_BOOTFILE "Image"
> +#endif
> +
> +#if IS_ENABLED(CONFIG_DISTRO_DEFAULTS)
> +#if IS_ENABLED(CONFIG_CMD_MMC)
> +#define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0)
> +#else
> +#define BOOT_TARGET_DEVICES_MMC(func)
> +#endif
> +
> +#if IS_ENABLED(CONFIG_CMD_SF)
> +#define BOOT_TARGET_DEVICES_QSPI(func) func(QSPI, qspi, na)
> +#else
> +#define BOOT_TARGET_DEVICES_QSPI(func)
> +#endif
> +
> +#define BOOTENV_DEV_QSPI(devtypeu, devtypel, instance) \
> +	"bootcmd_qspi=3Dubi detach; sf probe && " \
> +	"setenv mtdids 'nor0=3Dnor0,nand0=3Dnand.0' && " \
> +	"setenv mtdparts 'mtdparts=3Dnor0:66m(u-boot),190m(root);" \
> +	"nand.0:2m(u-boot),500m(nand_root)' && env select UBI; saveenv
> && " \
> +	"ubi part root && " \
> +	"if ubi part root && ubi readvol ${scriptaddr} script; " \
> +	"then echo QSPI: Running script from UBIFS; " \
> +	"elif sf read ${scriptaddr} ${qspiscriptaddr} ${scriptsize}; " \
> +	"then echo QSPI: Running script from JFFS2; fi; " \
> +	"echo QSPI: Trying to boot script at ${scriptaddr} && " \
> +	"source ${scriptaddr}; " \
> +	"echo QSPI: SCRIPT FAILED: continuing...; ubi detach;\0"
> +
> +#define BOOTENV_DEV_NAME_QSPI(devtypeu, devtypel, instance) \
> +	"qspi "
> +
> +#if IS_ENABLED(CONFIG_CMD_NAND)
> +# define BOOT_TARGET_DEVICES_NAND(func)	func(NAND, nand, na)
> +#else
> +# define BOOT_TARGET_DEVICES_NAND(func)
> +#endif
> +
> +#define BOOTENV_DEV_NAND(devtypeu, devtypel, instance) \
> +	"bootcmd_nand=3Dubi detach && " \
> +	"setenv mtdids 'nor0=3Dnor0,nand0=3Dnand.0' && " \
> +	"setenv mtdparts 'mtdparts=3Dnor0:66m(u-boot),190m(qspi_root);" \
> +	"nand.0:2m(u-boot),500m(root)' && env select UBI; saveenv && " \
> +	"ubi part root && " \
> +	"ubi readvol ${scriptaddr} script && " \
> +	"echo NAND: Trying to boot script at ${scriptaddr} && " \
> +	"source ${scriptaddr}; " \
> +	"echo NAND: SCRIPT FAILED: continuing...; ubi detach;\0"
> +
> +#define BOOTENV_DEV_NAME_NAND(devtypeu, devtypel, instance) \
> +	"nand "
> +
> +#define BOOT_TARGET_DEVICES(func) \
> +	BOOT_TARGET_DEVICES_MMC(func) \
> +	BOOT_TARGET_DEVICES_QSPI(func) \
> +	BOOT_TARGET_DEVICES_NAND(func)
> +
> +#include <config_distro_bootcmd.h>
> +
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +
>  #define CFG_EXTRA_ENV_SETTINGS \
> +	"kernel_addr_r=3D0x82000000\0" \
> +	"fdt_addr_r=3D0x86000000\0" \
> +	"qspiscriptaddr=3D0x02110000\0" \
> +	"scriptsize=3D0x00010000\0" \
> +	"qspibootimageaddr=3D0x02120000\0" \
> +	"bootimagesize=3D0x03200000\0" \
> +	"loadaddr=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
> +	"bootfile=3D" CONFIG_BOOTFILE "\0" \
> +	"mmcroot=3D/dev/mmcblk0p2\0" \
> +	"mtdids=3D" CONFIG_MTDIDS_DEFAULT "\0" \
> +	"mtdparts=3D" CONFIG_MTDPARTS_DEFAULT "\0" \
> +	"linux_qspi_enable=3Dif sf probe; then " \
> +		"echo Enabling QSPI at Linux DTB...;" \
> +		"fdt addr ${fdt_addr}; fdt resize;" \
> +		"fdt set /soc/spi@108d2000 status okay;" \
> +		"if fdt set /clocks/qspi-clk clock-frequency" \
> +		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
> +		" elif fdt set /soc/clkmgr/clocks/qspi_clk clock-frequency" \
> +		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
> +		" else fdt set /clocks/qspi-clk clock-frequency" \
> +		" ${qspi_clock}; echo QSPI clock frequency updated; fi; fi\0" \
> +	"scriptaddr=3D0x81000000\0" \
> +	"scriptfile=3Dboot.scr\0" \
> +	"nandroot=3Dubi0:rootfs\0" \
> +	"nandfitboot=3Dsetenv bootargs " CONFIG_BOOTARGS \
> +			" root=3D${nandroot} rw rootwait rootfstype=3Dubifs
> ubi.mtd=3D1; " \
> +			"bootm ${loadaddr}\0" \
> +	"nandfitload=3Dubi part root; ubi readvol ${loadaddr} kernel\0" \
> +	"socfpga_legacy_reset_compat=3D1\0" \
> +	"rsu_status=3Drsu dtb; rsu display_dcmf_version; "\
> +		"rsu display_dcmf_status; rsu display_max_retry\0" \
> +	"smc_fid_rd=3D0xC2000007\0" \
> +	"smc_fid_wr=3D0xC2000008\0" \
> +	"smc_fid_upd=3D0xC2000009\0 " \
> +	BOOTENV
> +
> +#else
> +
> +#define CFG_EXTRA_ENV_SETTINGS \
> +	"kernel_addr_r=3D0x2000000\0" \
> +	"fdt_addr_r=3D0x6000000\0" \
> +	"qspiscriptaddr=3D0x02110000\0" \
> +	"scriptsize=3D0x00010000\0" \
> +	"qspibootimageaddr=3D0x02120000\0" \
> +	"bootimagesize=3D0x03200000\0" \
> +	"loadaddr=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
> +	"bootfile=3D" CONFIG_BOOTFILE "\0" \
> +	"mmcroot=3D/dev/mmcblk0p2\0" \
> +	"mtdids=3D" CONFIG_MTDIDS_DEFAULT "\0" \
> +	"mtdparts=3D" CONFIG_MTDPARTS_DEFAULT "\0" \
> +	"linux_qspi_enable=3Dif sf probe; then " \
> +		"echo Enabling QSPI at Linux DTB...;" \
> +		"fdt addr ${fdt_addr}; fdt resize;" \
> +		"fdt set /soc/spi@ff8d2000 status okay;" \
> +		"if fdt set /soc/clocks/qspi-clk clock-frequency" \
> +		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
> +		" elif fdt set /soc/clkmgr/clocks/qspi_clk clock-frequency" \
> +		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
> +		" else fdt set /clocks/qspi-clk clock-frequency" \
> +		" ${qspi_clock}; echo QSPI clock frequency updated; fi; fi\0" \
> +	"scriptaddr=3D0x05FF0000\0" \
> +	"scriptfile=3Dboot.scr\0" \
> +	"nandroot=3Dubi0:rootfs\0" \
> +	"socfpga_legacy_reset_compat=3D1\0" \
> +	"rsu_status=3Drsu dtb; rsu display_dcmf_version; "\
> +		"rsu display_dcmf_status; rsu display_max_retry\0" \
> +	"smc_fid_rd=3D0xC2000007\0" \
> +	"smc_fid_wr=3D0xC2000008\0" \
> +	"smc_fid_upd=3D0xC2000009\0 " \
> +	BOOTENV
> +#endif /*#IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)*/
> +
> +#else
> +
> +#define CFG_EXTRA_ENV_SETTINGS \
> +	"kernel_comp_addr_r=3D0x9000000\0" \
> +	"kernel_comp_size=3D0x01000000\0" \
> +	"qspibootimageaddr=3D0x020E0000\0" \
> +	"qspifdtaddr=3D0x020D0000\0" \
> +	"bootimagesize=3D0x01F00000\0" \
> +	"fdtimagesize=3D0x00010000\0" \
> +	"qspiload=3Dsf read ${loadaddr} ${qspibootimageaddr}
> ${bootimagesize};" \
> +		"sf read ${fdt_addr} ${qspifdtaddr} ${fdtimagesize}\0" \
> +	"qspiboot=3Dsetenv bootargs earlycon root=3D/dev/mtdblock1 rw " \
> +		"rootfstype=3Djffs2 rootwait;booti ${loadaddr} - ${fdt_addr}\0"
> \
> +	"qspifitload=3Dsf read ${loadaddr} ${qspibootimageaddr}
> ${bootimagesize}\0" \
> +	"qspifitboot=3Dsetenv bootargs earlycon root=3D/dev/mtdblock1 rw " \
> +		"rootfstype=3Djffs2 rootwait;bootm ${loadaddr}\0" \
>  	"loadaddr=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
>  	"bootfile=3D" CONFIG_BOOTFILE "\0" \
>  	"fdt_addr=3D8000000\0" \
> @@ -53,24 +217,51 @@
>  		"bootm ${loadaddr}\0" \
>  	"mmcfitload=3Dmmc rescan;" \
>  		"load mmc 0:1 ${loadaddr} ${bootfile}\0" \
> +	"mtdids=3D" CONFIG_MTDIDS_DEFAULT "\0" \
> +	"mtdparts=3D" CONFIG_MTDPARTS_DEFAULT "\0" \
>  	"linux_qspi_enable=3Dif sf probe; then " \
>  		"echo Enabling QSPI at Linux DTB...;" \
>  		"fdt addr ${fdt_addr}; fdt resize;" \
>  		"fdt set /soc/spi@ff8d2000 status okay;" \
> -		"fdt set /soc/clkmgr/clocks/qspi_clk clock-frequency " \
> -		" ${qspi_clock}; fi; \0" \
> +		"if fdt set /soc/clocks/qspi-clk clock-frequency" \
> +		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
> +		" elif fdt set /soc/clkmgr/clocks/qspi_clk clock-frequency" \
> +		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
> +		" else fdt set /clocks/qspi-clk clock-frequency" \
> +		" ${qspi_clock}; echo QSPI clock frequency updated; fi; fi\0" \
>  	"scriptaddr=3D0x02100000\0" \
>  	"scriptfile=3Du-boot.scr\0" \
>  	"fatscript=3Dif fatload mmc 0:1 ${scriptaddr} ${scriptfile};" \
> -		   "then source ${scriptaddr}; fi\0" \
> -	"socfpga_legacy_reset_compat=3D1\0"
> +		   "then source ${scriptaddr}:script; fi\0" \
> +	"nandroot=3Dubi0:rootfs\0" \
> +	"nandload=3Dubi part root; ubi readvol ${loadaddr} kernel; ubi readvol
> ${fdt_addr} dtb\0" \
> +	"nandboot=3Dsetenv bootargs " CONFIG_BOOTARGS \
> +			" root=3D${nandroot} rw rootwait rootfstype=3Dubifs
> ubi.mtd=3D1; " \
> +			"booti ${loadaddr} - ${fdt_addr}\0" \
> +	"nandfitboot=3Dsetenv bootargs " CONFIG_BOOTARGS \
> +			" root=3D${nandroot} rw rootwait rootfstype=3Dubifs
> ubi.mtd=3D1; " \
> +			"bootm ${loadaddr}\0" \
> +	"nandfitload=3Dubi part root; ubi readvol ${loadaddr} kernel\0" \
> +	"socfpga_legacy_reset_compat=3D1\0" \
> +	"rsu_status=3Drsu dtb; rsu display_dcmf_version; "\
> +		"rsu display_dcmf_status; rsu display_max_retry\0" \
> +	"smc_fid_rd=3D0xC2000007\0" \
> +	"smc_fid_wr=3D0xC2000008\0" \
> +	"smc_fid_upd=3D0xC2000009\0 "
> +#endif /*#if IS_ENABLED(CONFIG_DISTRO_DEFAULTS)*/
>=20
>  /*
>   * External memory configurations
>   */
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#define PHYS_SDRAM_1			0x80000000
> +#define PHYS_SDRAM_1_SIZE		(1 * 1024 * 1024 * 1024)
> +#define CFG_SYS_SDRAM_BASE		0x80000000
> +#else
>  #define PHYS_SDRAM_1			0x0
>  #define PHYS_SDRAM_1_SIZE		(1 * 1024 * 1024 * 1024)
>  #define CFG_SYS_SDRAM_BASE		0
> +#endif
>=20
>  /*
>   * Serial / UART configurations
> --
> 2.26.2

Shall RESEND additional changes in V2.

