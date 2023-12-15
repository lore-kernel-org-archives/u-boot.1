Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C21C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 06:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA3687A64;
	Fri, 15 Dec 2023 07:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OcUuJKm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EB4587A3D; Fri, 15 Dec 2023 07:37:01 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E37B087A64
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 07:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5e263e43ff2so2811577b3.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 22:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702622217; x=1703227017;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skbHt4xm7Klu+/6DuZigwMambDElCj4uSrCuTLPKbOo=;
 b=OcUuJKm0ZoXHtsULA2NNbHQaPsbfHi3IgtuE2YbWbhxcq4Lvmq8iSFT82MpDlS8lN8
 8WXz7xjse7tDDUKePmX/0+ei3fjgdGIGP3obnFa0RSnw89qky2SfPyb+bS+Y0OPhWIdd
 j63rYvm1yDvGCm2cYk3dYUhLv9bimhXvbakqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702622217; x=1703227017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=skbHt4xm7Klu+/6DuZigwMambDElCj4uSrCuTLPKbOo=;
 b=g+9kSDs84o9oeUm/z0JBH7pt3/H5tQPiYhJlxJi+HsWrCVnauTWJMT/mszTu4pxInx
 FKvIj3EajjdBlk0OKf1lqHY22Mgq5yykQAjZDB48jTqwkU+IAcCAVn9j5v4gJnbx0Cil
 bImGoSKKkxrV/mWV0H96JqVKKKQfjJZokL7ZUDYtj0ojhFxyXSQdRSpVPQuSfbNbTK1B
 dCw1pY2AfOYqkVbVXTh0kOhOGotVlZz3PxchQnzn+WXhVBnHtDRCxMPY4FZnVO8QN44s
 8jUQ7QtzOCr7P3XHwmDm8qUZitYzAH4mQ0ht9ABOv+nn4Iop0wSfTowgmDJuJ40/M/ID
 Il8Q==
X-Gm-Message-State: AOJu0YwHS7jRD2aszQ3rwrw2gAtKsiG3HZ58RRWTA8u3Ctq4Htv7xH/+
 0KAdQFAb6swcYNcvwFp082UcYtkCKRtE89C9vSAtsg==
X-Google-Smtp-Source: AGHT+IEdxc4p9lQT36rs5JTkrGy8HWp9Evc9OxIga+yLzdwaOl1pUAmTIQhAYNC+utuY5xiaxTd4rtQywMi6Zzfauw8=
X-Received: by 2002:a81:4e83:0:b0:5e4:9d7a:d1cc with SMTP id
 c125-20020a814e83000000b005e49d7ad1ccmr50919ywb.46.1702622217445; Thu, 14 Dec
 2023 22:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
In-Reply-To: <20231211085939.5478-1-jagan@amarulasolutions.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 15 Dec 2023 12:06:46 +0530
Message-ID: <CAMty3ZBNC7Fpi-S4uOwfJ3ULWQ27PiVAKTqbnQKB3nB5vXHrhg@mail.gmail.com>
Subject: Re: [PATCH 00/17] video: dw_hdmi: Support Vendor PHY
To: Heiko Stuebner <heiko@sntech.de>, Kever Yang <kever.yang@rock-chips.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>, 
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
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

Hi Heiko/Kerver/Anatoloj,

On Mon, Dec 11, 2023 at 2:30=E2=80=AFPM Jagan Teki <jagan@amarulasolutions.=
com> wrote:
>
> Unlike RK3399, Sunxi/Meson DW HDMI the new Rockchip SoC Rk3328 would
> support external vendor PHY with DW HDMI chip.
>
> Support this vendor PHY by adding new platform PHY ops via DW HDMI
> driver and call the respective generic phy from platform driver code.
>
> This series tested in RK3328 with 1080p (1920x1080) resolution.
>
> Patch 0001/0005: Support Vendor PHY
> Patch 0006/0008: VOP extension for win, dsp offsets
> Patch 0009/0010: RK3328 VOP, HDMI clocks
> Patch 0011:      Rockchip Inno HDMI PHY
> Patch 0012:      RK3328 HDMI driver
> Patch 0013:      RK3328 VOP driver
> Patch 0014/0017: Enable HDMI Out for RK3328
>
> Importent:
> One pontential issues is that Linux HDMI out on RK3328 has effected by
> this patchset as I wouldn't find any relation or clue.
>
> [    0.752016] Loading compiled-in X.509 certificates
> [    0.787796] inno_hdmi_phy_rk3328_clk_recalc_rate: parent 24000000
> [    0.788391] inno-hdmi-phy ff430000.phy: inno_hdmi_phy_rk3328_clk_recal=
c_rate rate 148500000 vco 148500000
> [    0.798353] rockchip-drm display-subsystem: bound ff370000.vop (ops vo=
p_component_ops)
> [    0.799403] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, =
using dummy regulator
> [    0.800288] rk_iommu ff373f00.iommu: Enable stall request timed out, s=
tatus: 0x00004b
> [    0.801131] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, =
using dummy regulator
> [    0.802056] rk_iommu ff373f00.iommu: Disable paging request timed out,=
 status: 0x00004b
> [    0.803233] dwhdmi-rockchip ff3c0000.hdmi: Detected HDMI TX controller=
 v2.11a with HDCP (inno_dw_hdmi_phy2)
> [    0.805355] dwhdmi-rockchip ff3c0000.hdmi: registered DesignWare HDMI =
I2C bus driver
> [    0.808769] rockchip-drm display-subsystem: bound ff3c0000.hdmi (ops d=
w_hdmi_rockchip_ops)
> [    0.810869] [drm] Initialized rockchip 1.0.0 20140818 for display-subs=
ystem on minor 0
>
> The only way I can use Linux HDMI by disabling IOMMU or support
> disable-iommu link for RK3328 via DT [1].
>
> [1] https://www.spinics.net/lists/devicetree/msg605124.html

Is anyone aware of this issue? I did post the patches for Linux IOMMU
but seems not a proper solution. Any suggestions?

Thanks,
Jagan.
