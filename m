Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC438C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 23:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31D7581026;
	Tue, 25 Mar 2025 00:34:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iS/owITL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D8B811BB; Tue, 25 Mar 2025 00:34:07 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F326680F70
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 00:34:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-301e05b90caso7545318a91.2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 16:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742859243; x=1743464043; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ojI17rDZBrg8FykQ4R+tzdh2DQuKmSupwSZPw2cNUWw=;
 b=iS/owITLtCHKwVkAMRqRgBvPAwDgJVJQ4q70smyT/+TP0LLgDd2iYYgpvbPQoTdTSj
 Op48Rbhl9EmPQTnH9U9EeGtWbtumhRA893yRFjG4+4ecMa0ljUIoSOW76rwVd+YEeT/s
 +cmVBvR8uaQGjSvQx7YS2M4khs7rskn2fAkZNNEojT1MX1klyUuupOEI/NnkA43TbMHS
 AXWfRn+3maWRmk8mdjPCnVEsCOZb8LdpP3Xo7R9tL128jtTFF9P56Pm9eF5LjYppOzjD
 M3xw/tP1BZeNE6n3LyFVdQ8cA7phlqpDy7tynZQ3HnJr3aHKpr6llvqcRlzFLFhyKTL4
 e27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742859243; x=1743464043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ojI17rDZBrg8FykQ4R+tzdh2DQuKmSupwSZPw2cNUWw=;
 b=WNyEV3cPL8RNnIw0Xdb80phuA3Jw/mchBt9SIB8o2OD8hfTJqUTrMRhV3kn9AkULPt
 trcHFvwmn9Bo57uJV3E3KgNdx8n3yzV0XQwVpKAJETlDqA3/7Asmw9Zlavx0etw8etj6
 uVzBhUAGVCJ4yqxkbCgu7r+qbC7WpXkIG0Hwfre3LjNydgAjnWi3XcpTFO8Q0SlImrn9
 hk1WZbLoTxrwx7FIeqysT9P19/yY5WQzHy/adZNamVlmlMOZ1MMX5CMusLtUJje8RZHq
 8aXGUR9nERWYm2VpY7DDS9hm7ucX+svB7I+4aTf6EXmOSjR4aat7U3KnRcqkd9cfio7g
 QMoA==
X-Gm-Message-State: AOJu0YyaB+ec9KK4Zb141cmviQD7MI1YC1ursnVoAoMjTbWLLIpY49Wi
 coPw/GHIB9Yc+6g8ctKnODqSkHS1Ao3tkilIOhoJTO+DofW3QiIashBuQWtOoT0qqwiMwvj1apj
 PDoIqC5Eq2dwF4k6YqJ/4O1IsKxk=
X-Gm-Gg: ASbGncseJX+72JX9u2a2m4EtRK7anx89BDCtI6DkyAmNYXRY30AiwG3CxzueUDct2eu
 +MF5mHyQw6GZ1/Z1MCFWi5yr9Ta9y8YuOE3BLrM6WR3OtmijuNQaI6zzVaPrVFxELGU05qzeu5B
 v28NJ3fi1kScKFj6x53y1BvDEitA==
X-Google-Smtp-Source: AGHT+IFcfZEDNTrg0KQIwTCt8bEZ7TgSdGfcGCZJaioQh+hjqZzaaqcm7UNmkEq/iSIx9FxZ6eMLZvX63Hfhx4bs6yc=
X-Received: by 2002:a17:90b:1d46:b0:2fa:1851:a023 with SMTP id
 98e67ed59e1d1-3030ff11268mr24392895a91.35.1742859243280; Mon, 24 Mar 2025
 16:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250323160107.145749-1-marex@denx.de>
In-Reply-To: <20250323160107.145749-1-marex@denx.de>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 24 Mar 2025 18:33:52 -0500
X-Gm-Features: AQ5f1JoDFiJ-IQ1OozEX2XWcR6653Zrzfz2T_MetdahQNMX44yB324czs6r5HTY
Message-ID: <CAHCN7xK=hmHKSDZ3A4TU0-9PC5=s52eR3vvEduOqYNjjMzfGVw@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] clk: Add clk_resolve_parent_clk() and fix up iMX
 clock drivers
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, 
 Fabio Estevam <festevam@denx.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 uboot-imx@nxp.com
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

On Sun, Mar 23, 2025 at 11:01=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Add clk_resolve_parent_clk() to resolve parent clock udevice name
> based on clock-names DT property. This is used in SoC clock drivers
> to look up the clock name in clock tables, which matches a clock
> name in DT clock-names property, and convert it into udevice name
> which is used by U-Boot clock framework to look up parent clock in
> e.g. clk_register() using uclass_get_device_by_name(UCLASS_CLK,
> parent_name, &parent);
>
> Pass struct udevice pointer through the various iMX clock drivers.
>
> Marek Vasut (24):
>   clk: Add clk_resolve_parent_clk()
>   clk: clk-mux: Fold clk_register_mux()
>   clk: clk-mux: Use struct udevice instead of struct device
>   clk: clk-mux: Resolve parent clock by name
>   clk: imx: Pass struct udevice into imx_clk_mux*()
>   clk: imx: Pass struct udevice to clk_register_mux()
>   clk: clk-gate: Use struct udevice instead of struct device
>   clk: clk-gate: Resolve parent clock by name
>   clk: imx: gate2: Use struct udevice instead of struct device
>   clk: imx: gate2: Resolve parent clock by name
>   clk: imx: Pass struct udevice into imx_clk_gate*()
>   clk: imx: Pass struct udevice to clk_register_gate*()
>   clk: clk-composite: Use struct udevice instead of struct device
>   clk: clk-composite: Resolve parent clock by name
>   clk: imx: Pass struct udevice into imx_clk_composite*()
>   clk: imx: Convert clock-osc-* back to osc_*
>   clk: imx: Pass struct udevice into imx_clk_pllv3*()
>   clk: imx: pllv3: Resolve parent clock by name
>   clk: clk-divider: Use struct udevice instead of struct device
>   clk: imx: Pass struct udevice into imx_clk_divider*()
>   clk: clk-divider: Resolve parent clock by name
>   clk: clk-fixed-factor: Use struct udevice instead of struct device
>   clk: clk-fixed-factor: Resolve parent clock by name
>   clk: imx: Pass struct udevice into imx_clk_fixed_factor*()
>
>  drivers/clk/clk-composite.c        |   4 +-
>  drivers/clk/clk-divider.c          |   7 +-
>  drivers/clk/clk-fixed-factor.c     |   6 +-
>  drivers/clk/clk-gate.c             |   5 +-
>  drivers/clk/clk-mux.c              |  47 +---
>  drivers/clk/clk-uclass.c           |  18 ++
>  drivers/clk/imx/clk-composite-8m.c |   4 +-
>  drivers/clk/imx/clk-gate2.c        |   5 +-
>  drivers/clk/imx/clk-imx6q.c        |  80 +++----
>  drivers/clk/imx/clk-imx8mm.c       | 254 +++++++++++----------
>  drivers/clk/imx/clk-imx8mn.c       | 246 ++++++++++----------
>  drivers/clk/imx/clk-imx8mp.c       | 348 ++++++++++++++---------------
>  drivers/clk/imx/clk-imx8mq.c       | 226 +++++++++----------
>  drivers/clk/imx/clk-imx93.c        |   8 +-
>  drivers/clk/imx/clk-imxrt1020.c    |  42 ++--
>  drivers/clk/imx/clk-imxrt1050.c    |  78 +++----
>  drivers/clk/imx/clk-imxrt1170.c    |  30 +--
>  drivers/clk/imx/clk-pllv3.c        |   9 +-
>  drivers/clk/imx/clk.h              | 116 +++++-----
>  include/clk.h                      |   9 +
>  include/linux/clk-provider.h       |  10 +-
>  21 files changed, 783 insertions(+), 769 deletions(-)


For the series:

Tested-by:  Adam Ford <aford173@gmail.com>  #imx8[mnp] beacon-kit
>
> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> Cc: uboot-imx@nxp.com
>
> --
> 2.47.2
>
