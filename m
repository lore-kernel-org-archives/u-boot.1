Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58958C48291
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 08:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 826C2877CB;
	Mon,  5 Feb 2024 09:38:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="euSluEsa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE56D8786C; Mon,  5 Feb 2024 09:38:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A37877CB
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 09:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707122301; x=1738658301;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oE+GXDHGNWklal/SP89Vf9cMQPgCEanabyJFJvAJlbE=;
 b=euSluEsaDPftb6pvA7u04FlC692NH/zLPAVj1XxMT1CyHFw7fOR9OHAU
 beOhGFhJEwvOPmSa09B+BmHQbOjqX0BPZSucovFWTlrC7Q+9+EKJvxW0u
 YZc18fUFImD3u56PUs7uQeXMZDzqRT0is41kuGZzYg1e5SivCNgSsfk7J
 b0aPvGKVa0qhTFpxoZx9tDd7+f81GlebIqV2YV2UY/NboJs5WzqoNoanl
 JauZvyRCwH9wPipCA9vshywljIY5LqOE5Rwyq43xBvwjudIoZgh/MVD4B
 3hDo1LYpaBlNeZqfMaJl3lWszRbp9eoYzltpo95cRgmPTJTNYZYUD+m+A w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11569251"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; d="scan'208";a="11569251"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2024 00:38:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="5403075"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Feb 2024 00:38:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 00:38:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 00:38:13 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 00:38:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsrWvQVYw3a3uYGK/a7jrUCtyC3AK17/3D3D2FQixGfJtYehrypVPM5xZJuDngLkZDcBiR+2voQmqstXc78Dj5e5JL/mQBsOU0ftEVKD25MKhjeDBdDiGYOgbvMx6UoS/+i3T4F0p23D9dqxFn0QFDfIMWCjqd7TE5O4etm7InhNyMtk8JUn8cCiqskv0eBDvgDXNZSWaeeaxVKvt8MgY7aK+2MKi/lJEXVvk/DXrwmITqomLgclqK35iSgo3HL+fcoDjRzMlmYjhSLLTdvBIDH8CkieWmmOHeJz7SVA6mePXdBgNEeAeoVXbA+WVu1/JHWi53tAwMyait5w5gPOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bK6sUET9/uN2eUcRY0Ug5jgFk54Gq9uTmB7r2Nh/1E=;
 b=d7NIv4AA98zj9siCwOxbe3SAvgIBmqZC/OEiRD5cG3XXggHEPgbga3NoOst2BdyN+Iq3KtwhK0/qr/4IK7+lGqUqqG7I9KW9RnljwzXHyJc8cr3uNVBAmat/a7jANER+7W0Y7UZI3nPzYj9eLqVeBGzl/mxTDGA5G4QbA5+jEkMIoA4C86d0x4oYtb/gNAiTazjhR+QVQoSCyzlJrampiqrXJckxHSLHyfBOhFVMSaGN8GznXb7gDmC3/lmEySmIfHC8KBl7jhvLHKRLd2ZoVlv7wPBz/IaWr8GsV0K1T6fJi7kUGs38N8yq4PpOOD4Asb+KuS3wuF2EKuIrB8hOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5585.namprd11.prod.outlook.com (2603:10b6:5:356::23)
 by CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 08:38:11 +0000
Received: from CO6PR11MB5585.namprd11.prod.outlook.com
 ([fe80::15d9:dc9b:64a8:c93a]) by CO6PR11MB5585.namprd11.prod.outlook.com
 ([fe80::15d9:dc9b:64a8:c93a%5]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 08:38:11 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Lau, Wan Yee" <wan.yee.lau@intel.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, "Hea, Kok
 Kiang" <kok.kiang.hea@intel.com>, "Chong, Teik Heng"
 <teik.heng.chong@intel.com>
Subject: RE: [PATCH v2 1/1] drivers: misc: Add socfpga_dtreg driver for Intel
 SoCFPGA
Thread-Topic: [PATCH v2 1/1] drivers: misc: Add socfpga_dtreg driver for Intel
 SoCFPGA
Thread-Index: AQHaV+YKycLCGmwtSUi1xN5PgSC/AbD7bULQ
Date: Mon, 5 Feb 2024 08:38:10 +0000
Message-ID: <CO6PR11MB5585602202F7C39DCCAA8B62D2472@CO6PR11MB5585.namprd11.prod.outlook.com>
References: <20240205034716.10812-1-wan.yee.lau@intel.com>
In-Reply-To: <20240205034716.10812-1-wan.yee.lau@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5585:EE_|CO1PR11MB5089:EE_
x-ms-office365-filtering-correlation-id: 93c763c3-9926-4d05-eb99-08dc2625c92b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2wXfAoOxK0z7HNA85VAvy0ooiofQABMet3mLwNUFYYYq2Vh8b+4MZmRWllDrSR/7LClqK5/GpUf/pT8jkEfgfdWb4Grz9rOldBbuUOC6jO+gcz+18NoVxRoxnkoAmOncd8SoCu9OWbb/USgGuVHU1YoT7YIspwzz5hMf5ZrqmeAFS4GAIKoU/2GMfCJC8FWClfCxo9TfrOh5BLAa/QNAjR3dDQj7xQXo7q/8GZX79MbS2In1+O1sfiBrqCKMwS6kp1L5MidHU6DeNTuPZdvRhPTudnV3+kSMKQoOHibFKtTlO9fR7qWa/Xe2YlM1//VGQFASbV0zY/7tg4CyNH1rgYn85JHuh/RME8a3eZHeG7HdcHvW5iy0WkiWCSFnit52wrqP8F8Tbc1Z8kpnNY7pRzbx7J3FStkrsbYl1dWBRjfXPIbKxg0lT1xoEmHGkCbh9m6Wi4aIEHkMeJC1AVqdt4mmC/dJhBPbhOp4QZIDLErg3VGZZ4bp+BhLZ3CoJFKQ/m9qv9bdvV2F9sHd/Tc85PB6dEFcVw+nHPN2NtGHnCvDFxNb8I1kk6KIh1GJWrfHFtZ+nlH3a9jrB4I1200VpkOr00XKBVE9sLnfND47Ku0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR11MB5585.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(107886003)(26005)(86362001)(5660300002)(478600001)(2906002)(38070700009)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(8936002)(8676002)(4326008)(52536014)(9686003)(71200400001)(6506007)(7696005)(53546011)(33656002)(316002)(55016003)(122000001)(83380400001)(38100700002)(82960400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?afx8f5wJkLC8lYdf+dBb2+Kudl8159VX5wt5Ytuyqi3wYbnihNUrfyVKy/81?=
 =?us-ascii?Q?EUGGyvvTu6JknDO3ik/IwX4l3zX8qEYc8avzCxV2rcAsfjaCAp4k3JzZn5ow?=
 =?us-ascii?Q?qB/N1KPMKfXC0fjdBzi83dS9ZhQGJgXq0HiTNmyy/kHDrmLJrPTPfjiXJfqt?=
 =?us-ascii?Q?/npvyD+7ouqBFPndZsBRSM0Ahq/IpKCA4Y0r52a2cGY5wgHqb/rWC6wAeGxJ?=
 =?us-ascii?Q?1q/kStclU//MnKHEwwiqGZmKQhmwH6tYScUoPmNmc1a4tPM7d5CgNCd0k0iA?=
 =?us-ascii?Q?j6bMl/STpzjX1/mrzmN5L8imaE6yDqdNLBkMi4qiTIxWDRhd7D8KYdfCHL4O?=
 =?us-ascii?Q?hxc1mNeiOVRqePTKV/YibeWaEZMv9uqooD7Np9ISvimKuTeDFxDeZr96h4Kw?=
 =?us-ascii?Q?dIDoUhmYrlBFeq6JF6Q6sOpaw8Pvp+GR799Dv3+MOSpNVgwzkjaGfSfG1So/?=
 =?us-ascii?Q?7BPX1Ld/DI/TbxVBYCUVDtNN+opi2/eNb0Hrspx8iC8iehcUXbbcEWIhJdTy?=
 =?us-ascii?Q?6ABhdd4oHDQrWPBIIyLv021jG81Rcd7buPNHOc9Za47SKhfU0IvI6zG4iqtH?=
 =?us-ascii?Q?pxNGqWtozXg5ULTn2cDSyNOTWPevFNtOe7TUPKD26nv0AG5PXsLn1mNP2r3A?=
 =?us-ascii?Q?jH2ZiA71lIpI8guhvZ2Ahp4Pn+IFIqAefFlXf6iC3yFCpG2KTOhGKc318b81?=
 =?us-ascii?Q?MZp+nNkrWCAJSeKIyfL/pEHMu/vbmvoqc4UafWOxUavaRquHWdJK3tSBkmEn?=
 =?us-ascii?Q?BnqdlqgfwY1HpbrZjzeJSx84EYYsOtScgr8V/b1rlQr0Us1p701+Z/3GRYfy?=
 =?us-ascii?Q?kFlY+6+DbPFlSWKz3N9Nf8+5uW5dQM0PhotfNmEP7u8ThIjGk+zw42spNfY4?=
 =?us-ascii?Q?gFe7bgX6kwNuXJe5dppByrS+dK9WZvox/d6GaXYLbixT5IHmTaTkWbrMOnqI?=
 =?us-ascii?Q?+39ETkeR0Wy9uKg1RwCvCvfu+MsHNZ9aLKwLXcCqJAZW13uklRv58rWJE44q?=
 =?us-ascii?Q?CYFLh4fR2F4HfDiky+CGc4GRSlA+U8vvCXT18QDGvaUIyjTkYxRgsIjgq4J+?=
 =?us-ascii?Q?1EzyDXu/yYCODTYHaFaOAkPjP4IT7LbkfIfhbq7lBdQBVI9QqZ5zkHK5r3PD?=
 =?us-ascii?Q?nXqO8YOG7j7JrakNGkxc82+79R29NwvjJej5OfVpmm87J18xEDc1/okP53v9?=
 =?us-ascii?Q?+G/B9c1snX3uxW45fJelAKCUKRkRUkAX+KpQ1IzylSqYOZy3V/FBaAejS+js?=
 =?us-ascii?Q?cIs3X0kMVmYsD/rt/wplyEuP9Txv5dkzwvmaCJVhVGEMy1y4EgDDKl/k2P/Y?=
 =?us-ascii?Q?QVX8unnZpEZ8LEu8eIJYDf0K6NOlM2WV5Dudt44/0AnaS4vmdMwLPj02BH13?=
 =?us-ascii?Q?jkMoY13/0zhSWEvds5tkSTVzuyxCGWPJ+S+aCltbLI/9hbUDRFA8MPCM1+r9?=
 =?us-ascii?Q?72JZDkhXIsxm3bsXcMXOARmMimi3Nv4e/orCZWUazUZipr4Tuy+8OlWQAqkR?=
 =?us-ascii?Q?JvSXWenEQOWt3lEP6kPH2a/YJhKaIeuqG806OZoxsJxdZ8e0rBubU0CxLLjs?=
 =?us-ascii?Q?1cVSCzDoLx6R1m+mgFT9Pehq1h63iwO4fdpFFdfx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c763c3-9926-4d05-eb99-08dc2625c92b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 08:38:11.0131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RfJX/aLp7HGI7pkkLQtHJoufw3y7mVb8/XOpabL9SSbFbY8QGl0/U11IZU8aSIsaHBOvwHyiO4JywRnXQLzRWwXSeWmFRoxCwMgnX04hi1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5089
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
> From: Lau, Wan Yee <wan.yee.lau@intel.com>
> Sent: Monday, February 5, 2024 11:47 AM
> To: u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Chee, Tien Fong <tien.fong.chee@intel.com>; Hea, Kok Kiang
> <kok.kiang.hea@intel.com>; Chong, Teik Heng <teik.heng.chong@intel.com>
> Subject: [PATCH v2 1/1] drivers: misc: Add socfpga_dtreg driver for Intel
> SoCFPGA
>=20
> From: Wan Yee Lau <wan.yee.lau@intel.com>
>=20
> Add socfpga_dtreg driver enablement for Intel SoCFPGA.
>=20
> Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
> ---
> Changes for v2:
> - Rearranged header file in socfpga_drteg.c, moved <asm/io.h> lower.
>=20
>  arch/arm/Kconfig                              |   2 +
>  .../misc/socfpga_dtreg.txt                    |  74 +++++++++++
>  drivers/misc/Kconfig                          |   7 ++
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/socfpga_dtreg.c                  | 117 ++++++++++++++++++
>  5 files changed, 201 insertions(+)
>  create mode 100644 doc/device-tree-bindings/misc/socfpga_dtreg.txt
>  create mode 100644 drivers/misc/socfpga_dtreg.c
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig index
> 531b081de9..6087345eb8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1092,6 +1092,8 @@ config ARCH_SOCFPGA
>  	select SPL_LIBGENERIC_SUPPORT
>  	select SPL_OF_CONTROL
>  	select SPL_SEPARATE_BSS if TARGET_SOCFPGA_SOC64
> +	select SPL_DRIVERS_MISC if TARGET_SOCFPGA_SOC64
> +	select SPL_SOCFPGA_DT_REG if TARGET_SOCFPGA_SOC64
>  	select SPL_SERIAL
>  	select SPL_SYSRESET
>  	select SPL_WATCHDOG
> diff --git a/doc/device-tree-bindings/misc/socfpga_dtreg.txt b/doc/device=
-
> tree-bindings/misc/socfpga_dtreg.txt
> new file mode 100644
> index 0000000000..6057f792b9
> --- /dev/null
> +++ b/doc/device-tree-bindings/misc/socfpga_dtreg.txt
> @@ -0,0 +1,74 @@
> +* Firewall and privilege register settings in device tree
> +
> +Required properties:
> +--------------------
> +
> +- compatible: should contain "intel,socfpga-dtreg"
> +- reg: Physical base address and size of block register.
> +- intel,offset-settings: 32-bit offset address of block register,
> +			 followed by 32-bit value settings and
> +			 the masking bits, only masking bit
> +			 set to 1 allows modification.
> +
> +The device tree node which describes secure and privilege register
> +access configuration in compile time.
> +
> +Most of these registers are expected to work except for the case which
> +some registers configuration are required for granting access to some
> +other registers, for example CCU registers have to be properly
> +configured before allowing register configuration access to fpga2sdram
> +firewall as shown in below example.
> +
> +Some registers depend on runtime data for proper configuration are
> +expected to be part of driver that generating these data for example
> +configuration for soc_noc_fw_ddr_mpu_inst_0_ddr_scr block register
> +depend on DDR size parsed from memory device tree node.
> +
> +Please refer details of tested examples below for both fpga2sdram and
> +QoS configuration with default reset value and the comments.
> +
> +Example:
> +--------
> +
> +Configuration for multiple dtreg node support in device tree:
> +
> +	socfpga_dtreg0: socfpga-dtreg0 {
> +		compatible =3D "intel,socfpga-dtreg";
> +                	#address-cells =3D <1>;
> +                        #size-cells =3D <1>;
> +		        bootph-all;
> +
> +                        coh_cpu0_bypass_OC_Firewall_main_Firewall@f71002=
00 {
> +                        	reg =3D <0xf7100200 0x00000014>;
> +                                intel,offset-settings =3D
> +                                	/* Disable ocram security at CCU for no=
n secure
> access */
> +                                        <0x0000004 0x8000ffff 0xe007ffff=
>,
> +                                        <0x0000008 0x8000ffff 0xe007ffff=
>,
> +                                        <0x000000c 0x8000ffff 0xe007ffff=
>,
> +                                        <0x0000010 0x8000ffff 0xe007ffff=
>;
> +                                bootph-all;
> +                        };
> +                };
> +
> +	socfpga_dtreg1: socfpga-dtreg1 {
> +        	compatible =3D "intel,socfpga-dtreg";
> +                	#address-cells =3D <1>;
> +                        #size-cells =3D <1>;
> +			bootph-all;
> +
> +                        soc_noc_fw_mpfe_csr_inst_0_mpfe_scr@f8020000 {
> +                                reg =3D <0xf8020000 0x0000001c>;
> +                                intel,offset-settings =3D
> +                                        /* Disable MPFE firewall for SMM=
U */
> +                                        <0x00000000 0x00010101 0x0001010=
1>,
> +                                        /* Disable MPFE firewall for HMC=
 adapter */
> +                                        <0x00000004 0x00000001 0x0001010=
1>;
> +				bootph-all;
> +                        };
> +                };
> +
> +To call the nodes use:
> +
> +	ret =3D uclass_get_device_by_name(UCLASS_NOP, "socfpga-dtreg0",
> &dev);
> +	ret =3D uclass_get_device_by_name(UCLASS_NOP, "socfpga-dtreg1",
> &dev);
> +
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
> fccd9b89b8..c423905ba2 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -683,4 +683,11 @@ config SL28CPLD
>  	  the base driver which provides common access methods for the
>  	  sub-drivers.
>=20
> +config SPL_SOCFPGA_DT_REG
> +	bool "Enable register setting from device tree in SPL"
> +	depends on SPL
> +	help
> +	  Enable register setting from device tree. This also
> +	  provides user a clean interface and all register settings are
> +	  centralized in one place, device tree.
>  endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile index
> b67b82358a..b74c8b9f80 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -89,3 +89,4 @@ obj-$(CONFIG_K3_AVS0) +=3D k3_avs.o
>  obj-$(CONFIG_ESM_K3) +=3D k3_esm.o
>  obj-$(CONFIG_ESM_PMIC) +=3D esm_pmic.o
>  obj-$(CONFIG_SL28CPLD) +=3D sl28cpld.o
> +obj-$(CONFIG_SPL_SOCFPGA_SEC_REG) +=3D socfpga_dtreg.o
> diff --git a/drivers/misc/socfpga_dtreg.c b/drivers/misc/socfpga_dtreg.c =
new
> file mode 100644 index 0000000000..a8554bfd1d
> --- /dev/null
> +++ b/drivers/misc/socfpga_dtreg.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>  */
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <errno.h>
> +#include <asm/io.h>
> +#include <linux/sizes.h>
> +
> +#define NUMBER_OF_ELEMENTS 3
> +
> +static int socfpga_dtreg_probe(struct udevice *dev) {
> +	const fdt32_t *list;
> +	fdt_addr_t offset, base;
> +	fdt_val_t val, read_val, mask, set_mask;
> +	int size, i;
> +	u32 blk_sz, reg;
> +	ofnode node;
> +	const char *name =3D NULL;
> +
> +	debug("%s(dev=3D%p)\n", __func__, dev);
> +
> +	if (!dev_has_ofnode(dev))
> +		return 0;
> +
> +	dev_for_each_subnode(node, dev) {
> +		name =3D ofnode_get_name(node);
> +		if (!name)
> +			return -EINVAL;
> +
> +		if (ofnode_read_u32_index(node, "reg", 1, &blk_sz))
> +			return -EINVAL;
> +
> +		base =3D ofnode_get_addr(node);
> +		if (base =3D=3D FDT_ADDR_T_NONE)
> +			return -EINVAL;
> +
> +		debug("%s(node_offset 0x%lx node_name %s ", __func__,
> +		      node.of_offset, name);
> +		debug("node addr 0x%llx blk sz 0x%x)\n", base, blk_sz);
> +
> +		list =3D ofnode_read_prop(node, "intel,offset-settings", &size);
> +		if (!list)
> +			return -EINVAL;
> +
> +		debug("%s(intel,offset-settings property size=3D%x)\n",
> __func__,
> +		      size);
> +		size /=3D sizeof(*list) * NUMBER_OF_ELEMENTS;
> +
> +		/*
> +		 * First element: offset
> +		 * Second element: val
> +		 * Third element: mask
> +		 */
> +		for (i =3D 0; i < size; i++) {
> +			offset =3D fdt32_to_cpu(*list++);
> +			val =3D fdt32_to_cpu(*list++);
> +
> +			/* Reads the masking bit value from the list */
> +			mask =3D fdt32_to_cpu(*list++);
> +
> +			/*
> +			 * Reads out the offsets, value and masking bits
> +			 * Ex: <0x00000000 0x00000230 0xffffffff>
> +			 */
> +			debug("%s(intel,offset-settings 0x%llx : 0x%llx :
> 0x%llx)\n",
> +			      __func__, offset, val, mask);
> +
> +			if (blk_sz < offset + SZ_4) {
> +				printf("%s: Overflow as offset 0x%llx or reg",
> +				       __func__, offset);
> +				printf(" write is more than block size 0x%x\n",
> +				       blk_sz);
> +				return -EINVAL;
> +			}
> +
> +			if (mask !=3D 0) {
> +				if (mask =3D=3D 0xffffffff) {
> +					reg =3D base + offset;
> +					writel(val, (uintptr_t)reg);
> +				} else {
> +					/* Mask the value with the masking
> bits */
> +					set_mask =3D val & mask;
> +
> +					reg =3D base + offset;
> +
> +					/* Clears and sets specific bits in the
> register */
> +					clrsetbits_le32((uintptr_t)reg, mask,
> set_mask);
> +				}
> +			}
> +
> +			read_val =3D readl((uintptr_t)reg);
> +
> +			/* Reads out the register, masked value and the read
> value */
> +			debug("%s(reg 0x%x =3D wr : 0x%llx  rd : 0x%llx)\n",
> +			      __func__, reg, set_mask, read_val);
> +
> +		}
> +	}
> +
> +	return 0;
> +};
> +
> +static const struct udevice_id socfpga_dtreg_ids[] =3D {
> +	{.compatible =3D "intel,socfpga-dtreg"},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(socfpga_dtreg) =3D {
> +	.name		=3D "socfpga-dtreg",
> +	.id		=3D UCLASS_NOP,
> +	.of_match	=3D socfpga_dtreg_ids,
> +	.probe		=3D socfpga_dtreg_probe,
> +};

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Regards
Tien Fong
