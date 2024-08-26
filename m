Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9921DC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 06:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E7D2885F1;
	Mon, 26 Aug 2024 08:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z4J8pacD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5292588840; Mon, 26 Aug 2024 08:49:19 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB24288481
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 08:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-498e1e3bee8so1228430137.0
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 23:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724654956; x=1725259756; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r6l3NDa4Gw3FWoAnIMnhGzwwkHIvdDN1voXvilc48lA=;
 b=Z4J8pacDsoJrlhpQXS90iiUnjYTMyP4QzadtXJLOSW7zlPlKSlPhsSIco+RydFKqnS
 coai0IANVP93yacmJOQLQWuYEcM1DFSjsWW2/8X8GfKR7d5aSyYqE0zfsWFCd3sTQfvw
 Ki05blkgvxDcr/9WVu6b9zmQI9LtwL1Tv+qUjpIFaaA6V8n+GkfW6wNnJ2fQbCfNF7GT
 wbHLkE1dSgHQ4EpwxoxEipV41Z+lnBAkyA7ewi4duRKXot+1LIEhb2yJzK033AhFloiR
 9W77jGDDaX/LlLbyee+bams/ooKx+Xo/fl8LMvQ04HT5qxb5z4XSD8b8/AX+8LEjD7Tl
 PFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724654956; x=1725259756;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r6l3NDa4Gw3FWoAnIMnhGzwwkHIvdDN1voXvilc48lA=;
 b=MmKWhXPZhsTGgJLnyTiiQdqCzpt0NjjsOPFxev95KoBe6u9/h3NVTaoFYVCztIdDVV
 9sO1pIC6lXbufwLDbfhGqdvUnkC8YNCaIhmbxXPCVacNdnZqkDnzE8eQn83l1PKxK6Od
 glEA9SLfxaUjcpZSpzHrAlJJ/mW4XhahjRPRlWrUD2+KpAxp5BdcwjP1nftFT9mDI2iW
 bYXYwSujHQZR1PIh+3KIrFrLfoGD3/Z2DBC4J2wdJxjShJORt9YrXzefKE1Jc9TRVzN/
 FF7GDwW0FqHrJ74UMyJgmc8XoVrp98Gf3oMIWA9ot/xSpSaPFqAMDpyY31KqxzZfipRx
 QOEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqN1S/ydqrvA8emkNFVL6hFFlWoG+NJgKAu1mkfhAwlMFUDuuRY9sGB8tvReRF5OjmhmmHryk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxg3QSjhkOoG8vaM2r4MLukZGiKsfeE6v5XRAHmen71phEQ0Ssn
 PBClDuMa8EQydRpnS4eE10bDSu3vtb/F0R7bW/mXkIR2fFBClMnlNhasCiUzim/wohdfk6dEbAp
 nYdxxRTd9b07VSAh6sYmvlmvU8jhv/b5uWp+i+w==
X-Google-Smtp-Source: AGHT+IEFzaJft2qW/0IfpOc7U3EK3hHfcAhXi7j/tjbiFkbQZjD4jHrS4EQk4mFTLb3ZwzvqIsF1dfO/LUirogvRB38=
X-Received: by 2002:a05:6102:38c8:b0:493:31f9:d14a with SMTP id
 ada2fe7eead31-498f472dc56mr7526701137.27.1724654955577; Sun, 25 Aug 2024
 23:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240813105400.4054657-1-c-vankar@ti.com>
 <20240813105400.4054657-11-c-vankar@ti.com>
 <20240813124718.4zpvz3ryhdexxqdr@sharpness>
 <8623c13f-deb8-4bc0-b202-e214185cbaa6@ti.com>
In-Reply-To: <8623c13f-deb8-4bc0-b202-e214185cbaa6@ti.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Aug 2024 12:19:04 +0530
Message-ID: <CAFA6WYNLLMzpRwWgXK-xaAOzLZz6zKhm9dp0cGwDMJRZWTA=pg@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] arm64: dts: ti: k3-am62x-sk-common: Add
 bootph-all property in phy_gmii_sel node
To: Chintan Vankar <c-vankar@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Michal Simek <michal.simek@amd.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Devarsh Thakkar <devarsht@ti.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Andrew Davis <afd@ti.com>, Michael Trimarchi <michael@amarulasolutions.com>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Wadim Egorov <w.egorov@phytec.de>, 
 Dhruva Gole <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 14 Aug 2024 at 07:22, Chintan Vankar <c-vankar@ti.com> wrote:
>
>
>
> On 13/08/24 18:17, Nishanth Menon wrote:
> > On 16:24-20240813, Chintan Vankar wrote:
> >> Add missing bootph-all property for CPSW MAC's PHY node
> >> phy_gmii_sel.
> >>
> >> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> >> Link: https://lore.kernel.org/r/20240430085048.3143665-1-c-vankar@ti.com
> >> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> >>
> >> [ upstream commit: ba50141137fae205a731005e70687f4a52289050 ]
> >>
> >> (cherry picked from commit 2bdd1743a9f6515efe7c3648a25d63b4a9ce4a10)
> >> ---
> >>
> >> Link to v4:
> >> https://lore.kernel.org/r/20240812114945.3844224-1-c-vankar@ti.com/
> >>
> >> Changes from v4 to v5:
> >> - Updated this patch with the cherry picked patch from
> >>    devicetree-rebasing repo as pointed out by Sumit.
> >>
> >>   dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> >> diff --git a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
> >> index 3c45782ab2b..96378b19c41 100644
> >> --- a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
> >> +++ b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
> >> @@ -128,6 +128,10 @@
> >>      };
> >>   };
> >>
> >> +&phy_gmii_sel {
> >> +    bootph-all;
> >> +};
> >> +
> >
> >
> > If you cannot wait for upstream dt sync, why not just do this in R5-sk
> > or u-boot.dtsi?
> >
> >
>
> This node was added in "k3-am625-sk-u-boot.dtsi" till v3 of this series,
> https://lore.kernel.org/all/20240705045030.1141934-11-c-vankar@ti.com/
> but Tom suggested to use cherry pick since equivalent node got merged in
> Linux:
> https://lore.kernel.org/r/171826022268.240984.16645643062603851712.b4-ty@ti.com/

Yeah cherry-picking is better than adding bits into u-boot.dtsi as the
next DT sync can manage bits automatically without the need to drop
bits from u-boot.dtsi again.

-Sumit
