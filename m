Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910A9C54E5D
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 09:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5FEC87F01;
	Thu, 14 Mar 2024 10:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OS2Xm5dd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65D5187F36; Thu, 14 Mar 2024 10:25:47 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6E287E9A
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 10:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dc238cb1b17so670980276.0
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 02:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1710408343; x=1711013143;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbceTkN3541PE6ntyqRhVY+yYLN4+EfLodxN2WYnwgc=;
 b=OS2Xm5ddEpXWWiXKX3CgCLhBe2HJA6uRdc5Y7eE0hJJgXdGLT3zgLNHIvPo7RzXN5m
 TCSxyOwwgrfhoJqwDbuEqkIIwAhUUBaMyjmpNoRyByBeyOrxWa3vOEKgohzSsGNrVbv+
 tapvcb72+GkFmTXgLfEafz8/3bkdcpu5Rmfek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710408343; x=1711013143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kbceTkN3541PE6ntyqRhVY+yYLN4+EfLodxN2WYnwgc=;
 b=MbGVrx8/Ey6JfLz0c5z38zfe5DUSzaKapt3ZZ5JVso0a4c0r1vdEVe4DztGzcP1zJQ
 GSSi+zPXpSS/4Mb4wsgrQepnm7adfPZ+NGHCw6PGzTTa1aL1mrlBeVTpl0gmJFyRjkdy
 rUVTndFfuQlAa2vqfB8rZUeeeEGwkJYNAP49lzuEkfVctkPP9b0Uwydse0CbVqMdW2mY
 YlAouLjE9zCXF4fBuJqIjSDTEN6K9tm5dmacJbjmpiWDu7EHLlw2Zg4UoHQXA36XcFyQ
 8yhG3VU7hv7ixWqgHkCb/DwVps0jUGQ4O3EaHf9ZIY15tT4zRLxJlmwV90mh6zRGPTxU
 i99Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvMpOm5/h5L9ZHPN5E++NOzVW/DMTMrKSfVCUVzkvg0RsmvCKbAjwCyW4TIXeAwnePfjNUcG4vakPzzxSsqRuohqi+XQ==
X-Gm-Message-State: AOJu0YyahnBz20/DUssqO3rCPNmUloA9A5LGgevKuXUHO1SqH4zKKq4x
 DUBA1EYasJxHqVHq1O8LMS77deOspgO14VyfIjp1Kq91U4O4OJ6WqnlX+55d/yBejnHprEfwg39
 O6SKZHKbRpHyDjrGsrFEKPqJ28IJa3LdKIfqhXQ==
X-Google-Smtp-Source: AGHT+IHLwyEEjzeJqZn8+lhSl9sRrppGxunENJhx7LjShheavrkOnYyP6hZtfN5j9xOY6kcdAWgIUE1RtV0ccwsWf9g=
X-Received: by 2002:a25:ab2c:0:b0:dcc:2f94:591a with SMTP id
 u41-20020a25ab2c000000b00dcc2f94591amr1221010ybi.12.1710408343583; Thu, 14
 Mar 2024 02:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
 <CAMty3ZACUq6_hf_y7uM30EVmaVGtnqRH01sDWwZgKMNoLXw=CA@mail.gmail.com>
In-Reply-To: <CAMty3ZACUq6_hf_y7uM30EVmaVGtnqRH01sDWwZgKMNoLXw=CA@mail.gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 14 Mar 2024 14:55:32 +0530
Message-ID: <CAMty3ZACYxo0s9=J3qu9Md1FrskcQTJjY6=2TiUpvYPHE2_Rcg@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] video: dw_hdmi: Support Vendor PHY
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>, Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de, 
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

Hi Anatolij,

On Mon, Feb 19, 2024 at 5:19=E2=80=AFPM Jagan Teki <jagan@amarulasolutions.=
com> wrote:
>
> Hi Anatolij,
>
> On Wed, Jan 17, 2024 at 1:22=E2=80=AFPM Jagan Teki <jagan@amarulasolution=
s.com> wrote:
> >
> > From: Jagan Teki <jagan@edgeble.ai>
> >
> > Unlike RK3399, Sunxi/Meson DW HDMI the new Rockchip SoC Rk3328 would
> > support external vendor PHY with DW HDMI chip.
> >
> > Support this vendor PHY by adding new platform PHY ops via DW HDMI
> > driver and call the respective generic phy from platform driver code.
> >
> > This series tested in RK3328 with 1080p (1920x1080) resolution.
> >
> > Patch 0001/0005: Support Vendor PHY
> > Patch 0006/0008: VOP extension for win, dsp offsets
> > Patch 0009/0010: RK3328 VOP, HDMI clocks
> > Patch 0011:      Rockchip Inno HDMI PHY
> > Patch 0012:      RK3328 HDMI driver
> > Patch 0013:      RK3328 VOP driver
> > Patch 0014/0017: Enable HDMI Out for RK3328
> >
> > Changes for v3:
> > - updated phy_ops logic
> > - tested in BPI-M64
> > - updated handoff logic for rk3328
> >
> > Changes for v2:
> > - Use proper cfg function for meson
> > - Add VOP cleanup code.
> > - Add DCLK get rate
> >
> > Linux VOP/HDMI out issues seems resolved with explicit WIN0 disable.
> >
> > Any inputs?
> > Jagan.
> >
> > Jagan Teki (17):
> >   video: rockchip: hdmi: Detect hpd after controller init
> >   video: dw_hdmi: Add Vendor PHY handling
> >   video: dw_hdmi: Extend the HPD detection
> >   video: dw_hdmi: Add read_hpd hook
> >   video: dw_hdmi: Add setup_hpd hook
> >   video: rockchip: vop: Simplify rkvop_enable
> >   video: rockchip: vop: Add win offset support
> >   video: rockchip: vop: Add dsp offset support
> >   clk: rockchip: rk3328: Add VOP clk support
> >   clk: rk3328: Add get hdmiphy clock
> >   phy: rockchip: Add Rockchip INNO HDMI PHY driver
> >   video: rockchip: Add rk3328 hdmi support
> >   video: rockchip: Add rk3328 vop support
> >   ARM: dts: rk3328: Enable VOP for bootph-all
> >   rockchip: Enable preconsole for rk3328
> >   configs: evb-rk3328: Enable vidconsole for rk3328
> >   configs: Enable HDMI Out for ROC-RK3328-CC
>
> Any comments on this? Or is it okay if I send a PR for this?

Any update?

Jagan.
