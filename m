Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B71C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 12:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD5C78803F;
	Tue,  5 Mar 2024 13:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DxifGnaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA0088042; Tue,  5 Mar 2024 13:36:12 +0100 (CET)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E50EB8803E
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 13:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-472d1912f80so101748137.3
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 04:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709642163; x=1710246963; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5+8zuP3MJOUgNNdP4KHvSrZTKRgDcPIgl7A75TCaYSM=;
 b=DxifGnaFS/d2RGir/4Uuxruh/BRllHG/JGHnScLgv0p33Kwz3ah8ac4B6KgZEkde0C
 dJIRU+odINbzsTy2m25PaGrC1jHjFu/+yURjL1ZSF6s1yEvRm1tezDQzezaQSLGzGT+/
 v7Ch8IoOauONKQ/BwcStpTxDVPdS8l2Vv/62THDQLp24DW9u/8T4gJy6thgja12bqDJO
 CqgFwdys0l6kRHDkHAW/+RamoKW/H3mGeljQDiALuEpNzUGTpGgrWoB9MCgTZ5cAogqA
 uF17qo5P0OU8Fc96xTNKGq8OD/nNE27d+xvEhcxkGPj2+trKb5R86LK83VHkjfQ2IXXM
 6EnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709642163; x=1710246963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5+8zuP3MJOUgNNdP4KHvSrZTKRgDcPIgl7A75TCaYSM=;
 b=DT2ju/UpCwghnTdi7lXlZ2hOXtJ+NYXIxUsBrek15wohmsRO51V+poI3mnPOzPxUbK
 q3qzlW9wjVBIOvH1VsX0fCYdZ9eUpnOjzkefmfZspYJWQV3HgCFNtMz/YRzocLD0QOKR
 VqOx1mHwYZlvMgduGb566jL8Lz2423PE7EEJJk+zcOcP+wQ0WoaCqXZhAWej7KMTbnMy
 i91a3xinSRLn818F06Xmn18zAhi3/872QtsvHm2OwodrQ8XV7qAzFRUl0sEHYCGUG1pF
 hv/7ld5mKsSEKdNVMk5xMdgs6ju/131txItqo7925jFfmguECl7Wns4zqe3bvHyFuzyQ
 cUtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG0WuAe2krygUbdnwi77k05N8aZ2wlN4PRnMuWCuWeozkjW/O+kDYSJJuxVGTJcOfeRf/zREUbsbEyNHWvfMqaX1vDWw==
X-Gm-Message-State: AOJu0YwiOTygNH4J+IqIdsEkQaohWR3gAhrYtk3OLNUl9jQn9lMoo70X
 EznPQDmYTv9VV5tn1FTbAHCDA8ssoO1Y20exXDoB/HRsyRZaNgNS2FLI/hwb0i5oroLQAOT/Qz5
 iP0IEMwDYXeBc1jma0n8QsgeGPyoEyEjI2C4yLA==
X-Google-Smtp-Source: AGHT+IEwMDMMamjJ87TRwA/Z5ITzuuzQra31/JT775CsgmZ3IqQ4Wso6CDXn3XaKxI0La0T2Rnw7aEBpJ2oUyzIWrgk=
X-Received: by 2002:a05:6102:1608:b0:471:fc99:519f with SMTP id
 cu8-20020a056102160800b00471fc99519fmr1835998vsb.2.1709642163569; Tue, 05 Mar
 2024 04:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20240304-b4-upstream-dt-headers-v1-0-b7ff41925f92@linaro.org>
 <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
In-Reply-To: <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 5 Mar 2024 18:05:52 +0530
Message-ID: <CAFA6WYM6sTEdw+VphKidUqjQW61eW8ZVq+oO35CJVM=5wPoniA@mail.gmail.com>
Subject: Re: [PATCH RFC 26/26] dts: support building all dtb files for a
 specific vendor
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com, 
 uboot-snps-arc@synopsys.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 05 Mar 2024 13:43:38 +0100
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

Hi Caleb,

On Mon, 4 Mar 2024 at 22:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This adjusts OF_UPSTREAM to behave more like the kernel by allowing for
> all the devicetree files for a given vendor to be compiled. This is
> useful for Qualcomm in particular as most boards are supported by a
> single U-Boot build just provided with a different DT.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  dts/Kconfig          | 24 ++++++++++++++++++++++++
>  scripts/Makefile.dts | 17 ++++++++++++++++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/dts/Kconfig b/dts/Kconfig
> index b9b6367154ef..67d9dc489856 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -100,8 +100,32 @@ config OF_UPSTREAM
>           However, newer boards whose devicetree source files haven't landed in
>           the dts/upstream subtree, they can override this option to have the
>           DT build from existing U-Boot tree location instead.
>
> +config OF_UPSTREAM_BUILD_VENDOR
> +       bool "Build all devicetree files for a particular vendor"
> +       depends on OF_UPSTREAM
> +       help
> +         Enable building all devicetree files for a particular vendor. This

Do we really want to build all the DTBs even if many of those aren't
supported by U-Boot at all? I would have rather added Makefile targets
for boards which really supports a single defconfig eg.
qcom_defconfig.

-Sumit

> +         is useful for generic U-Boot configurations where many boards can
> +         be supported with a single binary.
> +
> +         This is only available for platforms using upstream devicetree.
> +
> +config OF_UPSTREAM_VENDOR
> +       string "Vendor to build all upstream devicetree files for"
> +       depends on OF_UPSTREAM_BUILD_VENDOR
> +       default "qcom" if ARCH_SNAPDRAGON
> +       default "rockchip" if ARCH_ROCKCHIP
> +       default "amlogic" if ARCH_MESON
> +       default "allwinner" if ARCH_SUNXI
> +       default "mediatek" if ARCH_MEDIATEK
> +       default "marvell" if ARCH_MVEBU
> +       default "xilinx" if ARCH_VERSAL || ARCH_ZYNQ
> +       default "nvidia" if ARCH_TEGRA
> +       help
> +         Select the vendor to build all devicetree files for.
> +
>  choice
>         prompt "Provider of DTB for DT control"
>         depends on OF_CONTROL
>
> diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
> index 5e2429c6170c..8005527f3df7 100644
> --- a/scripts/Makefile.dts
> +++ b/scripts/Makefile.dts
> @@ -1,3 +1,18 @@
>  # SPDX-License-Identifier: GPL-2.0+
>
> -dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
> +dtb-y += $(patsubst %,%.dtb,\
> +       $(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
> +
> +ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
> +ifeq ($(CONFIG_ARM64),y)
> +dt_dir := $(srctree)/dts/upstream/src/arm64
> +else
> +dt_dir := $(srctree)/dts/upstream/src/$(ARCH)
> +endif
> +
> +dtb-vendor_dts := $(patsubst %.dts,%.dtb, \
> +       $(wildcard $(dt_dir)/$(subst ",,$(CONFIG_OF_UPSTREAM_VENDOR))/*.dts))
> +
> +dtb-y += $(subst $(dt_dir)/,,$(dtb-vendor_dts))
> +
> +endif
>
> --
> 2.44.0
>
