Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6ECCD3427
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 08:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E48A984706;
	Mon, 11 May 2026 10:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="n9HDLGZ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91D1E84715; Mon, 11 May 2026 10:25:33 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9D2A846CB
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJXTAqnFdU9G2iUrkZ5xIb55LOIvEIJf0cDMMWaIUvQQ8iOnayor3o39k1swvkHgIBFZ3df9bRbCtr/OPfMM9XHCsP8CsadYG2NIGaASLyTjGECtTevkQOdHlu+XdVqEMK2dDR2UDUTk7hQWVsR9lY5l2jUh+MBgG2nEyjjQ99CaReGGeo24Vd6D3mOTmUJa8wIF3NIkmSsoqrAf8X5PMj1Y4mXCvWi/ZWz6mo5agpFDIeTGqNFY1j9CWUp59/ekOweAEAdXdX2ZOES7cRa4Gmrkn4njq3bphGpRI3xOQ7494aMoRkK1lrd82YqTjQ4e2ul3LpBY/NHPjhQhVJcJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OShKPXClP5hfrEFPP9i1Ot1rQF+39itpwd2e6kncJoY=;
 b=hyOEsywy44N4frSLsqDkwKSAkW8rXCW9rRehoe3v7RkSXuPkjMubaFeg/83tfgo3Zz4Gg242sdtoLZanZs77CcgPek1VILnN016Uxp7jelKXgZUW98xNPkC8n6Rb9XjkUU2GRVmj/OIPE9pKyCJz+XBQxGnQEShH1r3qvsiWzLbYXG2BHFQ7ap0+yj9i+RGc/oRH4ORoAqzac5pXGLJw114oLP5pTQKHFNA1o+koPW+DlOMbklJX1CZA2Ufl2HHurflSagy/+MUD8EB3ZwlqLJcfNgyX8R0YlUQ0gqdeEfDGr7a4iTTjbQYtPN8GJDNbD64I7P07YGGg3em1D4m+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OShKPXClP5hfrEFPP9i1Ot1rQF+39itpwd2e6kncJoY=;
 b=n9HDLGZ5sbgGDY/awWdNj6kprn0MNefLNpvLB2YNU9tC1EbqZ4cPg7honxhsePryadrufMCkTEEzo5mLXpKhI5DMHbCoBjpWxdDE0+QiZBkLuhHRPTThtFnf6RJfZ3WhdmuVX/mMZaubBBcuTIGscOc8ilXVP9yCG+DyPgvbl8A=
Received: from MN0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:52f::12)
 by DS4PPF3689F8B17.namprd10.prod.outlook.com (2603:10b6:f:fc00::d12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 08:25:28 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::5d) by MN0PR03CA0005.outlook.office365.com
 (2603:10b6:208:52f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 08:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 08:25:27 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 03:25:25 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 03:25:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 11 May 2026 03:25:25 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64B8POrA3307337;
 Mon, 11 May 2026 03:25:25 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 May 2026 13:55:24 +0530
Message-ID: <DIFPCP4IT3G1.3RRSF2ZPW4PZZ@ti.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andre Przywara
 <andre.przywara@arm.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>, "Casey
 Connolly" <casey.connolly@linaro.org>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ion Agorria
 <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>, Kongyang Liu
 <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>, "Mattijs
 Korpershoek" <mkorpershoek@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Ryder Lee <ryder.lee@mediatek.com>, Simon Glass <sjg@chromium.org>, "Stephan
 Gerhold" <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Varadarajan Narayanan
 <quic_varada@quicinc.com>, Weijie Gao <weijie.gao@mediatek.com>, Zixun LI
 <admin@hifiphile.com>, Jerome Forissier <jerome.forissier@arm.com>, "Jerome
 Forissier" <jerome.forissier@linaro.org>
Subject: Re: [RFC PATCH v2 64/64] usb: fix build after resync of DWC3 with
 kernel v6.16-rc7
From: Anshul Dalal <anshuld@ti.com>
To: Jens Wiklander <jens.wiklander@linaro.org>, <u-boot@lists.denx.de>, "Marek
 Vasut" <marex@denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-65-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-65-jens.wiklander@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS4PPF3689F8B17:EE_
X-MS-Office365-Filtering-Correlation-Id: ead41835-a9c0-4a3a-a9ec-08deaf36db7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0lO38wHEevLaoU0a01AdPgZ7lFtGS0MyJArNMbtz0Wln1O4Cj8wz54+Sp7kpl/OUejSCvK+sGCjsjeTvX4M6/37nm+dGw3ZkgfesuDVUn0NPFhhAi4TiLgs+qDzQO5hEW6+Mj5jCAlo6Jrx9FE0f0h3jnviVpyZ5eXvwz7vnLY/5Ox416yy7LDdCaJ0jQ5RldjZnmj82qD/xlGaWgM5yRfz3jdVTLNemPMZ0czIahvC4sMJ+cSSdThHGPe13i2c/JggOF2Vae1dxDSKDGAyZfLBdJ/8NhwNJqp54EOF4wqk64b5DOl3qfbNIpS2tzP2jaNJiLBcmB772ZSDReT/11i4WMYCdEO1wMpVxrGKL9FOIjB9Dt0dJCHHsBWEQfewk3ZB7y4VCSOXF4b5HSyUD6OZia491H2k5A/MkD4Y5Y5A23TcYmAfyY1fkwXAw0H++iUlYOcxpe0n5z7TnDv8TCTTCl2RUHnKDOKFinDCLYByTClUy31gvW0gesf050du9f6yOONqyDI2TZv2WcJKcN/hMgaoRR5UMMRWSPellxNKorGTp4/3uXbM+J1Mud3RJ8rNnrvkCdAoerbQjVnxfstH7UXoxsadHww+Hr9sdrQj6kl/OXaB/smtQMAnI+3jZubrHfakQkz+vPPRQAsfwZtJGC7hNGSxOfegXJbtmel2/qEA1OI6pK6hd8GaaBd4FPnv99Lis2yeVBZXQTw/hpd6WsXPSvRgB+y7XCKSKUXA=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JOCR5QWoVKglqQbU1ukfEe5OJVw5gofkBWMDxip1RuUoiQUahE1tTB3kSzutQWIloIAnci5vA+41LjOxm/dF7+CdyXERIsRFaZaFc3R7QZCUiezp2x/5fWvnB2vPMbmEonPo6UtKECO4hM6oq6ByLdol5dn7J9SfGXVxg/rtHtZ2RGYEm967BaZh8c26t6PSuNM6liKYwC1vYzwCrVIeFOj8VkR6i8bTq0xRR3fNuMB0okyzR6jzbV63HhzDw6KrlyEicxPxwMXQ8k1tXsvwduZkrn8fZflWaFIYQFMy2CMz+CUSZKoIMu8rvnhbGA+riG9Xx/Y7DlWW3ku+TzKxEKCsKDueSIX4GELYt+icqKCJI4FdiExybeiFPgUjCPIXrtiQjC2gSEzKAtR7SXmdnFVK+RmxDKkqS/ZRNshNeqzL4RDvTxS7cI1RpMo+VHcM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:25:27.7845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead41835-a9c0-4a3a-a9ec-08deaf36db7d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3689F8B17
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

On Thu May 7, 2026 at 2:58 PM IST, Jens Wiklander wrote:
> From: Jerome Forissier <jerome.forissier@linaro.org>
>
> Fix build errors after the re-sync of the DWC3 driver with the kernel.
> U-Boot has different needs than the kernel: buses, interrupts, internal
> APIs (DMA, traces, DT...) so many adaptations are required. This commit
> re-introduces many of the changes that were done locally after the
> initial import of the DWC3 code from kernel 3.19-rc1 11 years ago, as
> well as other fixes. This is compile-tested only.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/usb/cdns3/ep0.c                |    8 +-
>  drivers/usb/common/common.c            |   23 +
>  drivers/usb/dwc3/Makefile              |   57 +-
>  drivers/usb/dwc3/core.c                | 1761 ++++++------------------
>  drivers/usb/dwc3/core.h                |   39 +-
>  drivers/usb/dwc3/dwc3-am62.c           |  424 +-----
>  drivers/usb/dwc3/dwc3-omap.c           |    2 -
>  drivers/usb/dwc3/ep0.c                 |  110 +-
>  drivers/usb/dwc3/gadget.c              |  786 +++--------
>  drivers/usb/dwc3/gadget.h              |    4 +-
>  drivers/usb/dwc3/io.h                  |   28 +-
>  drivers/usb/dwc3/ti_usb_phy.c          |    2 -
>  drivers/usb/gadget/at91_udc.c          |   46 -
>  drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
>  drivers/usb/gadget/ci_udc.c            |  419 ------
>  drivers/usb/gadget/composite.c         |    2 +-
>  drivers/usb/gadget/dwc2_udc_otg.c      |  174 +--
>  drivers/usb/gadget/epautoconf.c        |    2 -
>  drivers/usb/gadget/ether.c             |   21 +-
>  drivers/usb/gadget/f_acm.c             |   20 +-
>  drivers/usb/gadget/f_fastboot.c        |   10 +-
>  drivers/usb/gadget/f_mass_storage.c    |    5 +-
>  drivers/usb/gadget/f_rockusb.c         |   11 +-
>  drivers/usb/gadget/f_sdp.c             |   12 +-
>  drivers/usb/gadget/f_thor.c            |   19 +-
>  drivers/usb/gadget/udc/Makefile        |    1 +
>  drivers/usb/gadget/udc/udc-core.c      | 1021 +++-----------
>  drivers/usb/host/xhci-dwc3.c           |    4 +-
>  drivers/usb/host/xhci-exynos5.c        |    2 +-
>  drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
>  drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
>  drivers/usb/musb-new/musb_uboot.c      |   39 -
>  include/dm/device_compat.h             |   13 +
>  include/dm/read.h                      |   46 +
>  include/linux/compat.h                 |   15 +
>  include/linux/usb/ch9.h                |   25 +-
>  include/linux/usb/gadget.h             |  520 ++-----
>  include/linux/usb/otg.h                |   10 +
>  include/linux/usb/phy.h                |   56 +
>  39 files changed, 1347 insertions(+), 4532 deletions(-)
>

[snip]

> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index a619cd374fb4..ae1725756c0e 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -1,18 +1,59 @@
> -# SPDX-License-Identifier: GPL-2.0+
> -
> +# SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_USB_DWC3)			+=3D dwc3.o
> =20
>  dwc3-y					:=3D core.o
> =20
> -obj-$(CONFIG_USB_DWC3_GADGET)		+=3D gadget.o ep0.o
> +ifneq ($(filter y,$(CONFIG_USB_DWC3_HOST) $(CONFIG_USB_DWC3_DUAL_ROLE)),=
)
> +	dwc3-y				+=3D host.o
> +endif
> +
> +ifneq ($(filter y,$(CONFIG_USB_DWC3_GADGET) $(CONFIG_USB_DWC3_DUAL_ROLE)=
),)
> +	dwc3-y				+=3D gadget.o ep0.o
> +endif
> +
> +ifneq ($(CONFIG_USB_DWC3_DUAL_ROLE),)
> +	dwc3-y				+=3D drd.o
> +endif
> +
> +ifneq ($(CONFIG_USB_DWC3_ULPI),)
> +	dwc3-y				+=3D ulpi.o
> +endif
> +
> +ifneq ($(CONFIG_DEBUG_FS),)
> +	dwc3-y				+=3D debugfs.o
> +endif
> +
> +##
> +# Platform-specific glue layers go here
> +#
> +# NOTICE: Make sure your glue layer doesn't depend on anything
> +# which is arch-specific and that it compiles on all situations.
> +#
> +# We want to keep this requirement in order to be able to compile
> +# the entire driver (with all its glue layers) on several architectures
> +# and make sure it compiles fine. This will also help with allmodconfig
> +# and allyesconfig builds.
> +##
> =20
> -obj-$(CONFIG_$(PHASE_)USB_DWC3_AM62)	+=3D dwc3-am62.o
> +obj-$(CONFIG_USB_DWC3_AM62)		+=3D dwc3-am62.o

Why is this change being made here? We need dwc3-am62 driver at SPL
stage for DFU boot on K3 devices. The Kconfig should have a
corresponding CONFIG_SPL_USB_DWC3_AM62 symbol as well.

Regards,
Anshul
