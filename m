Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33961C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 07:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649BD8700D;
	Tue, 19 Dec 2023 08:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="h61bc0hM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4079C86FF7; Tue, 19 Dec 2023 08:42:42 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F3708709C
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5e7415df4d6so9056467b3.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 23:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702971758; x=1703576558;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2mDcxWGGSF670/jtmnCi8F7nHtFZxkeL8yxrv9WPRE=;
 b=h61bc0hMmIZ5n9lnVVzG9mg1fFgm1sOE6NZciorj9Hvbwjx2w3KqtqsZDg//kiJGtS
 6elzIHm2otnohD89eknuJSOJUPaA+C3emeFs/UUcTIqm/VVcpk4Zkd0yQQRY/5BdlZhc
 2IO7kielkWYq7+QKnDXtycovo7gNR/+gfcmjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702971758; x=1703576558;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2mDcxWGGSF670/jtmnCi8F7nHtFZxkeL8yxrv9WPRE=;
 b=CToQcKC5swJencFgc5c/QX0C2yW1xgbCZYv8/9lZxkmJivk2EdqQdWpQ+rlWlEvH6D
 +nFrrE9DJJ1AC8zSfwtsjg299qGRy+BV0+/RDIaD8CGV/0rvOgZ/65RO9zfKNF4j06Tc
 bWi2r0kLKiAbRhcAxZsc4TUMR7kBevd1dKXYz+VJeB7qhBfkqSP9CesIZggZ86kOHtNo
 2XezwVvWUOyhxnp3ROGNRiLxZl/udLe1wjI2IcX6ij8UAxTTQpTD5qI8tVW+IrrPieJv
 4SCmg/nqZ1IM+xjl8+LChnHsarBbxR+UQIADnAv9qNb7qBI5ZlkMhTgpKSSshsI4TJ2P
 jMGQ==
X-Gm-Message-State: AOJu0Yxg/On7WOFmAKZP08QazridC2Ejp98MvNB9YrdZPXfI80gy4cm2
 5G4FKxH9Wa6HhofoBm+TypSVAlDl/36QTYKn92Xemg==
X-Google-Smtp-Source: AGHT+IFw1nk2ikkxFCZTgjYK5YnLpmeKLzfizyqLfZ6Tb9dlvwKbKabCtGhom+f9Yi1j9WCXK+DOLlSMUfCcsW3aYdE=
X-Received: by 2002:a05:6902:144:b0:dbc:da55:b397 with SMTP id
 p4-20020a056902014400b00dbcda55b397mr305865ybh.65.1702971757773; Mon, 18 Dec
 2023 23:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
 <20231218191114.129329-14-jagan@amarulasolutions.com>
 <672979fb.5ea.18c7fa8dce9.Coremail.andyshrk@163.com>
In-Reply-To: <672979fb.5ea.18c7fa8dce9.Coremail.andyshrk@163.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Tue, 19 Dec 2023 13:12:26 +0530
Message-ID: <CAMty3ZDUtZvjOrHgovAxwvwLFO6YnS3jLi_3=v707gfg9EkEeg@mail.gmail.com>
Subject: Re: [PATCH v2 13/17] video: rockchip: Add rk3328 vop support
To: Andy Yan <andyshrk@163.com>
Cc: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Heiko Stuebner <heiko@sntech.de>,
 Robin Murphy <robin.murphy@arm.com>, 
 u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@edgeble.ai>
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

On Tue, Dec 19, 2023 at 6:50=E2=80=AFAM Andy Yan <andyshrk@163.com> wrote:
>
>
> Hi Jaqan=EF=BC=9A
>
> At 2023-12-19 03:11:10, "Jagan Teki" <jagan@amarulasolutions.com> wrote:
> >From: Jagan Teki <jagan@edgeble.ai>
> >
> >Add support for Rockchip RK3328 VOP.
> >
> >Require VOP cleanup before handoff to Linux by writing reset values to
> >WIN registers. Without this Linux VOP trigger page fault as below
> >[    0.752016] Loading compiled-in X.509 certificates
> >[    0.787796] inno_hdmi_phy_rk3328_clk_recalc_rate: parent 24000000
> >[    0.788391] inno-hdmi-phy ff430000.phy: inno_hdmi_phy_rk3328_clk_reca=
lc_rate rate 148500000 vco 148500000
> >[    0.798353] rockchip-drm display-subsystem: bound ff370000.vop (ops v=
op_component_ops)
> >[    0.799403] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found,=
 using dummy regulator
> >[    0.800288] rk_iommu ff373f00.iommu: Enable stall request timed out, =
status: 0x00004b
> >[    0.801131] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found,=
 using dummy regulator
> >[    0.802056] rk_iommu ff373f00.iommu: Disable paging request timed out=
, status: 0x00004b
> >[    0.803233] dwhdmi-rockchip ff3c0000.hdmi: Detected HDMI TX controlle=
r v2.11a with HDCP (inno_dw_hdmi_phy2)
> >[    0.805355] dwhdmi-rockchip ff3c0000.hdmi: registered DesignWare HDMI=
 I2C bus driver
> >[    0.808769] rockchip-drm display-subsystem: bound ff3c0000.hdmi (ops =
dw_hdmi_rockchip_ops)
> >[    0.810869] [drm] Initialized rockchip 1.0.0 20140818 for display-sub=
system on minor 0
> >
> >Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> >---
> >Changes for v2:
> >- Add VOP cleanup
> >- Update commit
> >
> > drivers/video/rockchip/Makefile     |  1 +
> > drivers/video/rockchip/rk3328_vop.c | 83 +++++++++++++++++++++++++++++
> > 2 files changed, 84 insertions(+)
> > create mode 100644 drivers/video/rockchip/rk3328_vop.c
> >
> >diff --git a/drivers/video/rockchip/Makefile b/drivers/video/rockchip/Ma=
kefile
> >index 4991303c73..f55beceebf 100644
> >--- a/drivers/video/rockchip/Makefile
> >+++ b/drivers/video/rockchip/Makefile
> >@@ -6,6 +6,7 @@
> > ifdef CONFIG_VIDEO_ROCKCHIP
> > obj-y +=3D rk_vop.o
> > obj-$(CONFIG_ROCKCHIP_RK3288) +=3D rk3288_vop.o
> >+obj-$(CONFIG_ROCKCHIP_RK3328) +=3D rk3328_vop.o
> > obj-$(CONFIG_ROCKCHIP_RK3399) +=3D rk3399_vop.o
> > obj-$(CONFIG_DISPLAY_ROCKCHIP_EDP) +=3D rk_edp.o
> > obj-$(CONFIG_DISPLAY_ROCKCHIP_LVDS) +=3D rk_lvds.o
> >diff --git a/drivers/video/rockchip/rk3328_vop.c b/drivers/video/rockchi=
p/rk3328_vop.c
> >new file mode 100644
> >index 0000000000..a4da3a91e8
> >--- /dev/null
> >+++ b/drivers/video/rockchip/rk3328_vop.c
> >@@ -0,0 +1,83 @@
> >+// SPDX-License-Identifier: GPL-2.0+
> >+/*
> >+ * Copyright (c) 2023 Edgeble AI Technologies Pvt. Ltd.
> >+ */
> >+
> >+#include <dm.h>
> >+#include <video.h>
> >+#include <asm/io.h>
> >+#include "rk_vop.h"
> >+
> >+DECLARE_GLOBAL_DATA_PTR;
> >+
> >+static void rk3328_set_pin_polarity(struct udevice *dev,
> >+                                  enum vop_modes mode, u32 polarity)
> >+{
> >+      struct rk_vop_priv *priv =3D dev_get_priv(dev);
> >+      struct rk3288_vop *regs =3D priv->regs;
> >+
> >+      switch (mode) {
> >+      case VOP_MODE_HDMI:
> >+              clrsetbits_le32(&regs->dsp_ctrl1,
> >+                              M_RK3399_DSP_HDMI_POL,
> >+                              V_RK3399_DSP_HDMI_POL(polarity));
> >+              break;
> >+      default:
> >+              debug("%s: unsupported output mode %x\n", __func__, mode)=
;
> >+      }
> >+}
> >+
> >+static int rk3328_vop_probe(struct udevice *dev)
> >+{
> >+      /* Before relocation we don't need to do anything */
> >+      if (!(gd->flags & GD_FLG_RELOC))
> >+              return 0;
> >+
> >+      return rk_vop_probe(dev);
> >+}
> >+
> >+static int rk3328_vop_remove(struct udevice *dev)
> >+{
> >+      struct rk_vop_priv *priv =3D dev_get_priv(dev);
> >+      struct rk3288_vop *regs =3D priv->regs;
> >+      struct rk3288_vop *win_regs =3D priv->regs + priv->win_offset;
> >+
> >+      /* write reset values */
> >+      writel(0xef013f, &win_regs->win0_act_info);
> >+      writel(0xef013f, &win_regs->win0_dsp_info);
> >+      writel(0xa000a, &win_regs->win0_dsp_st);
> >+      writel(0x0, &win_regs->win0_yrgb_mst);
> >+      writel(0x01, &regs->reg_cfg_done);
> >+
> >+      return 0;
> >+}
>
> I think this just workaround Linux iommu page fault by luck=E3=80=82
> The reset value=EF=BC=88what you called it is=EF=BC=89your write just let=
 win0 read a
> 320x240 rectangular from address 0 and display it at next frame=EF=BC=88m=
aybe 16ms later if your
> current display is run at 60HZ=EF=BC=89=E3=80=82
>
> 1. we don't know what content is at address 0, so you will see something =
strange on your monitor.
> 2. there is no guarantee that address 0 is really readable=EF=BC=88maybe =
a security memory space=EF=BC=8C or maybe
>     it is not a valid address=EF=BC=89=EF=BC=8C this may cause another is=
sue that not easy to detect=E3=80=82

Okay. Can you suggest any proper way to clean up VOP? All these reset
values are referred to as per the TRM and read before enabling the
video.

Thanks,
Jagan.
