Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DF8C54E49
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 23:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C19487F83;
	Tue,  5 Mar 2024 00:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hx9nFG/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F50E876A4; Tue,  5 Mar 2024 00:02:34 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1247287F8F
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 00:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5658082d2c4so6918505a12.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 15:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709593351; x=1710198151; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EfKVvCc8ZYEfB1COmorOeK1mNHbPkMIzSdBUHLdvQJI=;
 b=hx9nFG/RY0yV9RDhzlg9l+2cqM18pKDLNMMkjrjirOC7cEsClRLrKAVehXw0873y+j
 Rxib1V4dWe8/hwVuS3L3t8Xt+KTLZJZurqFGRZ3xJ68/9lkaumjpI1Ww1UxJgednU9op
 ZrcVSeaF2Cy+moa/aa21/zHdoqJqXinZXgk4HWuDAnU9Xio1jSysVmhAZERU4uiVRux0
 L2xca+ZO/8NeQjnDzgeUVZ+VtA214ykHcvD9lFEldrrJIKCVJ/87COVkiEn+UvN4+qHz
 /FAtl4xh9mmil4ex0YavSOFoWdhA8W9fgSA6gUCH49iNX59xt5n4v0JAxSU/EVj3cFPF
 O1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709593351; x=1710198151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EfKVvCc8ZYEfB1COmorOeK1mNHbPkMIzSdBUHLdvQJI=;
 b=HmdcDFgPYMwIsYLQZWylhlnVkTeQvNV0TN+1cOR8JgJPqsEUEXtaSktTo5cqNcz91B
 Lz7/HFW1VU14RNSFSNvhqwb+BK54R10fkj67cPe99Dp+cdEnK2+8gF7+uLlaPA1ftkTl
 i2cN1WcJp/zGI+IB61Spe41NMylYdttgax2eCwrXj1M71BlyMY+oAancz3aCGQmPOfF9
 o3hNbmmg6T15otkKcJOEBByQ1rzM3W9/nuhzvJzLMjqAnp9qE1UR7XidVX5zfwTUxAUm
 Bp8PTm17yY1FspQwKcMvwrvaHLD0uaaJMiEofXES2ZrY8pihZ2u4Ku3nU0Vf15q7zqYz
 rgeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCjENg0qOi45ItoZq6jDHtAgQ3NMkapl3sy28ZGzskji/8f1MZIhLbd3k+FUkQWjhausr9FshjXlxzguhsQqQaqmmvcw==
X-Gm-Message-State: AOJu0YwGRp9fLhf/zAsE9VBk4VEmQ45DkdHwnPgqs2Ni6sjlgp5fidaM
 wa/ocfMLSxj81AC5P11Uuh/gQ95rtneBZNWAPeRYS8CAnUXmmJW4XL5aqyuRU6rZMHfzR8Qm2mw
 3oA8WszrHnso5yU7vVZbiJR7oJl8=
X-Google-Smtp-Source: AGHT+IHrbX0TI1QzY4ITSD9vI9OrADmTTHJvB5pQMV71Lb/GX8KJKjae0afRbrPN2TprSlhSuU8msCqZoppsjaE4sys=
X-Received: by 2002:a50:cdd0:0:b0:566:3f3e:3a23 with SMTP id
 h16-20020a50cdd0000000b005663f3e3a23mr6881548edj.1.1709593351307; Mon, 04 Mar
 2024 15:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20240304-b4-upstream-dt-headers-v1-0-b7ff41925f92@linaro.org>
 <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
In-Reply-To: <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 4 Mar 2024 15:02:12 -0800
Message-ID: <CAJaLiFyXC2-wkwbyvK+bKWhwzV9=rWY445Lz5dFQSWdB0Zb5Bg@mail.gmail.com>
Subject: Re: [PATCH RFC 26/26] dts: support building all dtb files for a
 specific vendor
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 05 Mar 2024 00:17:10 +0100
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

On Mon, Mar 4, 2024 at 9:24=E2=80=AFAM Caleb Connolly <caleb.connolly@linar=
o.org> wrote:
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
>           However, newer boards whose devicetree source files haven't lan=
ded in
>           the dts/upstream subtree, they can override this option to have=
 the
>           DT build from existing U-Boot tree location instead.
>
> +config OF_UPSTREAM_BUILD_VENDOR
> +       bool "Build all devicetree files for a particular vendor"
> +       depends on OF_UPSTREAM
> +       help
> +         Enable building all devicetree files for a particular vendor. T=
his
> +         is useful for generic U-Boot configurations where many boards c=
an
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

Perhaps here it should be:
default "marvell" if ARCH_MVEBU || ARCH_KIRKWOOD

All the best,
Tony

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
> -dtb-y +=3D $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $=
(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
> +dtb-y +=3D $(patsubst %,%.dtb,\
> +       $(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONF=
IG_SPL_OF_LIST)))
> +
> +ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
> +ifeq ($(CONFIG_ARM64),y)
> +dt_dir :=3D $(srctree)/dts/upstream/src/arm64
> +else
> +dt_dir :=3D $(srctree)/dts/upstream/src/$(ARCH)
> +endif
> +
> +dtb-vendor_dts :=3D $(patsubst %.dts,%.dtb, \
> +       $(wildcard $(dt_dir)/$(subst ",,$(CONFIG_OF_UPSTREAM_VENDOR))/*.d=
ts))
> +
> +dtb-y +=3D $(subst $(dt_dir)/,,$(dtb-vendor_dts))
> +
> +endif
>
> --
> 2.44.0
>
