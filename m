Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92F3C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 08:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF8F0876B4;
	Thu, 21 Dec 2023 09:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ep65jd1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A760387846; Thu, 21 Dec 2023 09:24:45 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C9C6876B4
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 09:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5d2d0661a8dso6136637b3.2
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 00:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703147082; x=1703751882;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwdgcBClQfvdj8OqBhUWtIpUXAivzTsY+SbWSn2fxd8=;
 b=ep65jd1EXo5g+//DbCQk3i4nmTCyYUkuBjUwiH02IqJM/SvvXIibOGDxdnae1dd2GZ
 xm9C3AE5oG5ZM3s2CNy+Ubla0FKifAM/7QF81VVE7h4Opv6egAOf3/m5gjxXcWvtWo83
 Tpbs2Z1FQBMd6e2fa7OggTouJJDYAhBSfPNjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703147082; x=1703751882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UwdgcBClQfvdj8OqBhUWtIpUXAivzTsY+SbWSn2fxd8=;
 b=wVp2G6vsPZVJZyJ7Mn9VLMWEe2vZZwTEiLe/j4ZPNtVBC6m4hzDlJq37N2PKnw2JGZ
 vpbHhNszH4uCArTlMkCtzrS3a0DgVS8tSYEwFp3l09uIWzQZ11PbUF0ltrTWfjKEEKnH
 idY3xutA6kAs9c4Fh8je7MU4hYJNe0lyx/qoiTIqiuPHyGV9qwp+ZvxTUwAAZ7nfKTZi
 G8iZ85DD5EVkhAJL1psbgYwznAj17xKKG/WPHW/zhHXnla8M8ECzNGbQfTpIenMJNZZn
 zr6kBrTrS3lNzu8FCnJMRM42CfVz2TmN6iZ2RP7ha/ZKSrUxqtHZAbHYaEswlle/OrHu
 xbbA==
X-Gm-Message-State: AOJu0YzBt9ijp50qbsHuEhL2wn9v18GZ/Ms1nr9nl96ML4FysWn6C5wT
 5NVDOSdFNtfuo1cQDb0wUSZseU5zbbhxsioJVIJTysdkxoGWWjTvleE=
X-Google-Smtp-Source: AGHT+IEd99/HOqnvffwn0mlW68kvGWCbSJ5c6FVjKh1mFIPI77tkjoNhkw7Cxd3h2El6XNPyaiArzSuZUrh3YE/LtaQ=
X-Received: by 2002:a0d:e202:0:b0:5e7:f292:56c1 with SMTP id
 l2-20020a0de202000000b005e7f29256c1mr971183ywe.38.1703147081823; Thu, 21 Dec
 2023 00:24:41 -0800 (PST)
MIME-Version: 1.0
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
 <20231218191114.129329-14-jagan@amarulasolutions.com>
 <672979fb.5ea.18c7fa8dce9.Coremail.andyshrk@163.com>
 <CAMty3ZDUtZvjOrHgovAxwvwLFO6YnS3jLi_3=v707gfg9EkEeg@mail.gmail.com>
 <33a60ff6.2e50.18c8141e502.Coremail.andyshrk@163.com>
In-Reply-To: <33a60ff6.2e50.18c8141e502.Coremail.andyshrk@163.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 21 Dec 2023 13:54:30 +0530
Message-ID: <CAMty3ZDaPmJ3N=C8EcjSJPOeLPq+Ht0C85-+zj=KTw6U4bQnnQ@mail.gmail.com>
Subject: Re: Re: [PATCH v2 13/17] video: rockchip: Add rk3328 vop support
To: Andy Yan <andyshrk@163.com>, Anatolij Gustschin <agust@denx.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Heiko Stuebner <heiko@sntech.de>, Robin Murphy <robin.murphy@arm.com>,
 u-boot@lists.denx.de, 
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Andy,

On Tue, Dec 19, 2023 at 2:17=E2=80=AFPM Andy Yan <andyshrk@163.com> wrote:
>
>
>
> Hi Jaqan=EF=BC=8C
> =E5=9C=A8 2023-12-19 15:42:26=EF=BC=8C"Jagan Teki" <jagan@amarulasolution=
s.com> =E5=86=99=E9=81=93=EF=BC=9A
> >Hi Andy,
> >
> >On Tue, Dec 19, 2023 at 6:50=E2=80=AFAM Andy Yan <andyshrk@163.com> wrot=
e:
> >>
> >>
> >> Hi Jaqan=EF=BC=9A
> >>
> >> At 2023-12-19 03:11:10, "Jagan Teki" <jagan@amarulasolutions.com> wrot=
e:
> >> >From: Jagan Teki <jagan@edgeble.ai>
> >> >
> >> >Add support for Rockchip RK3328 VOP.
> >> >
> >> >Require VOP cleanup before handoff to Linux by writing reset values t=
o
> >> >WIN registers. Without this Linux VOP trigger page fault as below
> >> >[    0.752016] Loading compiled-in X.509 certificates
> >> >[    0.787796] inno_hdmi_phy_rk3328_clk_recalc_rate: parent 24000000
> >> >[    0.788391] inno-hdmi-phy ff430000.phy: inno_hdmi_phy_rk3328_clk_r=
ecalc_rate rate 148500000 vco 148500000
> >> >[    0.798353] rockchip-drm display-subsystem: bound ff370000.vop (op=
s vop_component_ops)
> >> >[    0.799403] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not fou=
nd, using dummy regulator
> >> >[    0.800288] rk_iommu ff373f00.iommu: Enable stall request timed ou=
t, status: 0x00004b
> >> >[    0.801131] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not fou=
nd, using dummy regulator
> >> >[    0.802056] rk_iommu ff373f00.iommu: Disable paging request timed =
out, status: 0x00004b
> >> >[    0.803233] dwhdmi-rockchip ff3c0000.hdmi: Detected HDMI TX contro=
ller v2.11a with HDCP (inno_dw_hdmi_phy2)
> >> >[    0.805355] dwhdmi-rockchip ff3c0000.hdmi: registered DesignWare H=
DMI I2C bus driver
> >> >[    0.808769] rockchip-drm display-subsystem: bound ff3c0000.hdmi (o=
ps dw_hdmi_rockchip_ops)
> >> >[    0.810869] [drm] Initialized rockchip 1.0.0 20140818 for display-=
subsystem on minor 0
> >> >
> >> >Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> >> >---
> >> >Changes for v2:
> >> >- Add VOP cleanup
> >> >- Update commit
> >> >
> >> > drivers/video/rockchip/Makefile     |  1 +
> >> > drivers/video/rockchip/rk3328_vop.c | 83 +++++++++++++++++++++++++++=
++
> >> > 2 files changed, 84 insertions(+)
> >> > create mode 100644 drivers/video/rockchip/rk3328_vop.c
> >> >
> >> >diff --git a/drivers/video/rockchip/Makefile b/drivers/video/rockchip=
/Makefile
> >> >index 4991303c73..f55beceebf 100644
> >> >--- a/drivers/video/rockchip/Makefile
> >> >+++ b/drivers/video/rockchip/Makefile
> >> >@@ -6,6 +6,7 @@
> >> > ifdef CONFIG_VIDEO_ROCKCHIP
> >> > obj-y +=3D rk_vop.o
> >> > obj-$(CONFIG_ROCKCHIP_RK3288) +=3D rk3288_vop.o
> >> >+obj-$(CONFIG_ROCKCHIP_RK3328) +=3D rk3328_vop.o
> >> > obj-$(CONFIG_ROCKCHIP_RK3399) +=3D rk3399_vop.o
> >> > obj-$(CONFIG_DISPLAY_ROCKCHIP_EDP) +=3D rk_edp.o
> >> > obj-$(CONFIG_DISPLAY_ROCKCHIP_LVDS) +=3D rk_lvds.o
> >> >diff --git a/drivers/video/rockchip/rk3328_vop.c b/drivers/video/rock=
chip/rk3328_vop.c
> >> >new file mode 100644
> >> >index 0000000000..a4da3a91e8
> >> >--- /dev/null
> >> >+++ b/drivers/video/rockchip/rk3328_vop.c
> >> >@@ -0,0 +1,83 @@
> >> >+// SPDX-License-Identifier: GPL-2.0+
> >> >+/*
> >> >+ * Copyright (c) 2023 Edgeble AI Technologies Pvt. Ltd.
> >> >+ */
> >> >+
> >> >+#include <dm.h>
> >> >+#include <video.h>
> >> >+#include <asm/io.h>
> >> >+#include "rk_vop.h"
> >> >+
> >> >+DECLARE_GLOBAL_DATA_PTR;
> >> >+
> >> >+static void rk3328_set_pin_polarity(struct udevice *dev,
> >> >+                                  enum vop_modes mode, u32 polarity)
> >> >+{
> >> >+      struct rk_vop_priv *priv =3D dev_get_priv(dev);
> >> >+      struct rk3288_vop *regs =3D priv->regs;
> >> >+
> >> >+      switch (mode) {
> >> >+      case VOP_MODE_HDMI:
> >> >+              clrsetbits_le32(&regs->dsp_ctrl1,
> >> >+                              M_RK3399_DSP_HDMI_POL,
> >> >+                              V_RK3399_DSP_HDMI_POL(polarity));
> >> >+              break;
> >> >+      default:
> >> >+              debug("%s: unsupported output mode %x\n", __func__, mo=
de);
> >> >+      }
> >> >+}
> >> >+
> >> >+static int rk3328_vop_probe(struct udevice *dev)
> >> >+{
> >> >+      /* Before relocation we don't need to do anything */
> >> >+      if (!(gd->flags & GD_FLG_RELOC))
> >> >+              return 0;
> >> >+
> >> >+      return rk_vop_probe(dev);
> >> >+}
> >> >+
> >> >+static int rk3328_vop_remove(struct udevice *dev)
> >> >+{
> >> >+      struct rk_vop_priv *priv =3D dev_get_priv(dev);
> >> >+      struct rk3288_vop *regs =3D priv->regs;
> >> >+      struct rk3288_vop *win_regs =3D priv->regs + priv->win_offset;
> >> >+
> >> >+      /* write reset values */
> >> >+      writel(0xef013f, &win_regs->win0_act_info);
> >> >+      writel(0xef013f, &win_regs->win0_dsp_info);
> >> >+      writel(0xa000a, &win_regs->win0_dsp_st);
> >> >+      writel(0x0, &win_regs->win0_yrgb_mst);
> >> >+      writel(0x01, &regs->reg_cfg_done);
> >> >+
> >> >+      return 0;
> >> >+}
> >>
> >> I think this just workaround Linux iommu page fault by luck=E3=80=82
> >> The reset value=EF=BC=88what you called it is=EF=BC=89your write just =
let win0 read a
> >> 320x240 rectangular from address 0 and display it at next frame=EF=BC=
=88maybe 16ms later if your
> >> current display is run at 60HZ=EF=BC=89=E3=80=82
> >>
> >> 1. we don't know what content is at address 0, so you will see somethi=
ng strange on your monitor.
> >> 2. there is no guarantee that address 0 is really readable=EF=BC=88may=
be a security memory space=EF=BC=8C or maybe
> >>     it is not a valid address=EF=BC=89=EF=BC=8C this may cause another=
 issue that not easy to detect=E3=80=82
> >
> >Okay. Can you suggest any proper way to clean up VOP? All these reset
> >values are referred to as per the TRM and read before enabling the
>
> >video.
>
>
> Maybe write 0 to the windows enable bit=EF=BC=8C disable this window=E3=
=80=82
> But this is a little rude=EF=BC=8CI wonder if the mainline has a way to h=
andleoff
> bootloader framebuffer to linux kernel drm system seamless=E3=80=82

I don't think any sort of handoff procedure in U-Boot - Anatolij any
comments on this?

I did see some nxp platform drivers turn off the DE during handoff. So
disabling WIN0 is the only option that I'm thinking of as of now.

>
> [0] is also what Robin mention is V1,  maybe a better direction.
>
>
> [0]https://lore.kernel.org/all/20230120174251.4004100-1-thierry.reding@gm=
ail.com/

Yes, it looks like a proper solution to check but it requires some
iommu re-work to handle iommu-address.

Jagan.
