Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612DEC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 18:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7504F8747A;
	Mon, 18 Dec 2023 19:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cXJqJTCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B50DE87469; Mon, 18 Dec 2023 19:54:14 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F3D0871A6
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 19:54:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5e4b6353482so22832367b3.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702925650; x=1703530450;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5h4mc2WG/t/UgKDI4gCpvl7fJ97pxJIPlX66cpdNHw=;
 b=cXJqJTCl+4uSOY+CIy9ArBnK1JXFpQP9P2miqdAuC4PqJFqtDzEvg2+ayVZ1mQxy/4
 mjdgI7FCRyq+P0DEIR6kRvkMqgOwhPNDwgY0HDDCaWc79fmcmOuu9M7hEavOoS/a8c3S
 Ej6ncmeFSBLC2VVXkpqof8NqPnzHND2VX06Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925650; x=1703530450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5h4mc2WG/t/UgKDI4gCpvl7fJ97pxJIPlX66cpdNHw=;
 b=NNe2L5l9S+Gc5ALmU+rlIQGplb5fFgPWSPcekza1MUP/Sh3bIsdJoXXI35vdqdocy3
 DQH/8zZ0SdeEguCFx7TRSs1EWSsr9RVIzJVb/blG7E/6ZEEfoz0icglsA1jMg1e0FMJx
 E3amnCQwxFsQPypNAt6vd4dM+VJhU566jTcW8ta2BNYj8x39mEjxZ/Yw4iWWxQhtHoRa
 7v8WDYwU50UrbUybnYNshf0MtDeu0hE62THcyzNtniZqKfBYaNvAn46o24MXgvPnPTip
 9HZ+JkrhlSQpOEnvc/pVSJ7p3PdqB7Hc9gZCpInaq+EzGt/BAZJEhoba+eqd4P9iGVYw
 aLBw==
X-Gm-Message-State: AOJu0Ywbuw/uxPod4uTnLaWaPzwfXeTmq0YaBvDdnnxOR6DDv17+EcG4
 wnKAdH7qi1YxQLDiUVqKeYNY9cNX3nwJQ16HrS2u3su7iQr/WWovZ9k=
X-Google-Smtp-Source: AGHT+IHShL8Bih0XKLhwi28+/FHQNSL2OZ0HWjawlEP+/Lthvk4OoFI5WMBU660lEm/QVCEREz5hmClZ44pRr3JhlVA=
X-Received: by 2002:a05:690c:82c:b0:5e6:20cf:961e with SMTP id
 by12-20020a05690c082c00b005e620cf961emr1511775ywb.15.1702925649857; Mon, 18
 Dec 2023 10:54:09 -0800 (PST)
MIME-Version: 1.0
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
 <CAMty3ZBNC7Fpi-S4uOwfJ3ULWQ27PiVAKTqbnQKB3nB5vXHrhg@mail.gmail.com>
 <f04a716f-1383-493c-87b5-e39edacee857@rock-chips.com>
 <75c3b7e3-5184-4ec6-88b5-ec11ff269dd5@arm.com>
In-Reply-To: <75c3b7e3-5184-4ec6-88b5-ec11ff269dd5@arm.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Tue, 19 Dec 2023 00:23:58 +0530
Message-ID: <CAMty3ZC7j5MtzsuJD_-HQt5pCgqCrhkU=Y1WWOqjreyvmFe0yA@mail.gmail.com>
Subject: Re: [PATCH 00/17] video: dw_hdmi: Support Vendor PHY
To: Robin Murphy <robin.murphy@arm.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>, 
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 =?UTF-8?B?6Jab5bCP5piO?= <xxm@rock-chips.com>, 
 =?UTF-8?B?5pON55Ge5p2w?= <algea.cao@rock-chips.com>, 
 =?UTF-8?B?6Zer5a2d5Yab?= <andy.yan@rock-chips.com>
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

On Mon, Dec 18, 2023 at 7:23=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-12-15 7:13 am, Kever Yang wrote:
> > Hi Jagan,
> >
> > On 2023/12/15 14:36, Jagan Teki wrote:
> >> Hi Heiko/Kerver/Anatoloj,
> >>
> >> On Mon, Dec 11, 2023 at 2:30=E2=80=AFPM Jagan Teki
> >> <jagan@amarulasolutions.com> wrote:
> >>> Unlike RK3399, Sunxi/Meson DW HDMI the new Rockchip SoC Rk3328 would
> >>> support external vendor PHY with DW HDMI chip.
> >>>
> >>> Support this vendor PHY by adding new platform PHY ops via DW HDMI
> >>> driver and call the respective generic phy from platform driver code.
> >>>
> >>> This series tested in RK3328 with 1080p (1920x1080) resolution.
> >>>
> >>> Patch 0001/0005: Support Vendor PHY
> >>> Patch 0006/0008: VOP extension for win, dsp offsets
> >>> Patch 0009/0010: RK3328 VOP, HDMI clocks
> >>> Patch 0011:      Rockchip Inno HDMI PHY
> >>> Patch 0012:      RK3328 HDMI driver
> >>> Patch 0013:      RK3328 VOP driver
> >>> Patch 0014/0017: Enable HDMI Out for RK3328
> >>>
> >>> Importent:
> >>> One pontential issues is that Linux HDMI out on RK3328 has effected b=
y
> >>> this patchset as I wouldn't find any relation or clue.
> >>>
> >>> [    0.752016] Loading compiled-in X.509 certificates
> >>> [    0.787796] inno_hdmi_phy_rk3328_clk_recalc_rate: parent 24000000
> >>> [    0.788391] inno-hdmi-phy ff430000.phy:
> >>> inno_hdmi_phy_rk3328_clk_recalc_rate rate 148500000 vco 148500000
> >>> [    0.798353] rockchip-drm display-subsystem: bound ff370000.vop
> >>> (ops vop_component_ops)
> >>> [    0.799403] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not
> >>> found, using dummy regulator
> >>> [    0.800288] rk_iommu ff373f00.iommu: Enable stall request timed
> >>> out, status: 0x00004b
> >>> [    0.801131] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not
> >>> found, using dummy regulator
> >>> [    0.802056] rk_iommu ff373f00.iommu: Disable paging request timed
> >>> out, status: 0x00004b
> >>> [    0.803233] dwhdmi-rockchip ff3c0000.hdmi: Detected HDMI TX
> >>> controller v2.11a with HDCP (inno_dw_hdmi_phy2)
> >>> [    0.805355] dwhdmi-rockchip ff3c0000.hdmi: registered DesignWare
> >>> HDMI I2C bus driver
> >>> [    0.808769] rockchip-drm display-subsystem: bound ff3c0000.hdmi
> >>> (ops dw_hdmi_rockchip_ops)
> >>> [    0.810869] [drm] Initialized rockchip 1.0.0 20140818 for
> >>> display-subsystem on minor 0
> >>>
> >>> The only way I can use Linux HDMI by disabling IOMMU or support
> >>> disable-iommu link for RK3328 via DT [1].
> >>>
> >>> [1] https://www.spinics.net/lists/devicetree/msg605124.html
> >> Is anyone aware of this issue? I did post the patches for Linux IOMMU
> >> but seems not a proper solution. Any suggestions?
> >
> > I'm not expert in HDMI/VOP, so I can't provide a suitable solution in
> > the kernel,
> >
> > but here is the reason why we need patch to workaround the issue in the
> > kernel:
> >
> > - The VOP driver working in U-Boot is non-IOMMU mode, and the VOP acces=
s
> > DDR by physical address;
> >
> > - The VOP driver working in kernel with IOMMU enabled(by default), the
> > VOP access DDR with virtual address(by IOMMU);
> >
> > - The VOP is keep working in kernel before kernel VOP driver is enabled=
,
> > and the IOMMU driver will be enabled by
> >
> >     the Linux PM framework, since the IOMMU is not correctly configured
> > at this point, the VOP will access unknown
> >
> >      space(the original physical address in U-Boot) convert by IOMMU;
> >
> > So we need to disable the IOMMU temporary in kernel startup before VOP
> > driver is enabled.
>
> If U-Boot isn't handing off an active framebuffer, then it should be
> U-Boot's responsibility to stop the VOP before it exits; if on the other
> hand it is, then it can now use the "iommu-addresses" DT property (see
> the reserved-memory schema) on the framebuffer region, and we should
> just need a bit of work in the IOMMU driver to ensure that is respected
> during the period between the IOMMU initialising and the Linux VOP
> driver subsequently taking over (i.e. so it won't get stuck on an
> unexpected page fault as seems to be happening above). The IOMMU aspect
> of that ought to be fairly straightforward; the trickier part might be
> the runtime PM aspect to ensure the IOMMU doesn't let itself go idle and
> actually turn anything off during that period. I also still think that
> doing the full rk_iommu_disable() upon runtime suspend is wrong, but
> that's more of a thing which confounds the underlying issue here, rather
> than being the problem in itself.

Thanks for your comments. Okay, keeping the Linux IOMMU issue aside I
think whatever change that u-boot makes on VOP has to clear it before
handoff to Linux - so clearing the VOP registers during handoff seems
working. I only wonder why it happens only on RK3328 (RK3399 and
RK3288 seem fine).

I will post the next version with VOP clear during handoff.

Thanks,
Jagan.
