Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C96ECD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 09:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5B7388501;
	Fri,  5 Apr 2024 11:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f/NQd+zn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE672884FE; Fri,  5 Apr 2024 11:23:38 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60C0F88501
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 11:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-479e2ad0d4aso10811137.0
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 02:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712309014; x=1712913814; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8JHKwrtivAFZO7+0R87anQ/AwYov8Znx2KUbC0xRibw=;
 b=f/NQd+zns/POAZsg6lK2sSxDZNCW0FJeALcOazKf4adWGuRTy9QSeVwa3LL0ShV4bn
 Jo5aGLKPghmVV1e+zq1wVfdXZYNhcDYdSaSuUBaPeWLuISzr4HX6wJ+TpFozRRbMPgVa
 h9WMZjqrdBUpTCkvdt80eHo1DW7Ny4P/rOQLLZvaG/DpcMte+0/P91s30wInJvZRYzB0
 ggFku1obKCy0RyVoBfFrFQp5Fr6UFtXYbaShe1vn/04SgJSgwdj7huRu0xrasX39Xfiu
 ixWu93YEM4MORTBBU256aY9YU3dFQBvzOqEaDc1oDoneIgvsMySj0qCIlYyF6wgcpvw7
 9vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712309014; x=1712913814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8JHKwrtivAFZO7+0R87anQ/AwYov8Znx2KUbC0xRibw=;
 b=CP0CTJuIBSoUnjzwVaeC8guTk1fX+XO/OIq3R4MF8T2EwKL1bNiz9XSzWTdgXTI/ps
 W6xg65kUH0DF3lpR43uJch0A1XkOHyBHosn0GTivIfHB5oVE2dcIjxoed0FTqg1/VgOZ
 1HEhFQostUi727KaTF4agY9p9AZNTy6e43fQ0I/hiH+Pclds4HUIHxeVcoJoTBAvX04Z
 DqoJJLzStx5Vm61l77boe/BG10dM3nSKvDKbF56K0y5GvO+UfUeqB4KbyVogX/mvu1O+
 Tz5dI2muBvnrS3TksRnCqH6lxUoesxYZx5byXNbSB/CZpAhT9dEPgm+QAcafg5Qaw6tg
 AXgg==
X-Gm-Message-State: AOJu0YzmUsjtqNmpXrN7Yz7WOaOMJsMpA2WPw4TOMO49oqXvDHu1mD6Y
 +irIuDgT2RMD916bL/nb9Pkb5mIKWxobJfb8spdBNNg//aSrYerIo8qEKuRuzNHW36lre5+u0rU
 vxPQLlvQwveV894F4Bdsf4SIfOMnoKhPtuAQbSw==
X-Google-Smtp-Source: AGHT+IEdTZ1JJ1CETq4sgMfoP880b4EqECAp/bJxXCBSx/SIYBi+xssyz7Mz2eUeQo0S4PjAfRyn7BHAQlbBtK5qifE=
X-Received: by 2002:a05:6102:2927:b0:479:e027:516 with SMTP id
 cz39-20020a056102292700b00479e0270516mr457474vsb.11.1712309014087; Fri, 05
 Apr 2024 02:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240404090039.87458-1-j-choudhary@ti.com>
 <20240404090039.87458-2-j-choudhary@ti.com>
 <CAFA6WYOjmVDigxT_Nw_vpEyOMmU=FK0jvCM0bVQ=fzVAaf205g@mail.gmail.com>
 <60c854a1-11fb-42ec-aaba-364910b4f5e2@ti.com>
In-Reply-To: <60c854a1-11fb-42ec-aaba-364910b4f5e2@ti.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 5 Apr 2024 14:53:23 +0530
Message-ID: <CAFA6WYMCtWBA0yGwVVt1oPYkSj9qAhqBGGRun5SHmg8hZuToKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/15] DO-NOT-MERGE: dts: upstream: src: Necessary
 pulls from upstream dts
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, jh80.chung@samsung.com, 
 lukma@denx.de, seanga2@gmail.com, vaishnav.a@ti.com, n-francis@ti.com, 
 u-kumar1@ti.com, vigneshr@ti.com, nm@ti.com, afd@ti.com, bb@ti.com, 
 rogerq@kernel.org, r-gunasekaran@ti.com
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

On Fri, 5 Apr 2024 at 11:17, Jayesh Choudhary <j-choudhary@ti.com> wrote:
>
> Hello Sumit,
>
> On 05/04/24 10:27, Sumit Garg wrote:
> > Hi Jayesh,
> >
> > On Thu, 4 Apr 2024 at 14:30, Jayesh Choudhary <j-choudhary@ti.com> wrote:
> >>
> >> j722s dts support that needs to be pulled from devicetree-rebasing
> >> tree. The whole series depends on this support.
> >>
> >
> > Which devicetree-rebasing tag does this patch depend upon? v6.8-dts
> > has already made its way to U-Boot mainline [1].
> >
> > [1] https://source.denx.de/u-boot/u-boot/-/commit/bc39e06778168a34bb4e0a34fbee4edbde4414d8
> >
>
> These patches are on top of the next branch (same commit)
> The required patches[0][2][3] are in tag v6.9-rc1-dts.
>

Okay, the next sync is expected to happen when U-Boot next branch
opens again and I suppose during that time frame only Linux kernel
v6.9 will be released. If you are targeting the U-Boot July release
then you have to opt out of OF_UPSTREAM.

-Sumit

> [0]:
> <https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/commit/?id=1339c374a4c10f184d2bb4c6dadd3155f9260599>
> [2]:
> <https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/commit/?id=4dd9e11aa40f6d7bb2bd4993a8ddf17c935c9686>
> [3]:
> <https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/commit/?id=ec136bb18fcc85d32787530bc065bd97ee3bba60>
>
> -Jayesh
>
>
> > -Sumit
> >
> >> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> >> ---
> >>   dts/upstream/Bindings/arm/ti/k3.yaml       |   6 +
> >>   dts/upstream/src/arm64/ti/k3-j722s-evm.dts | 383 +++++++++++++++++++++
> >>   dts/upstream/src/arm64/ti/k3-j722s.dtsi    |  89 +++++
> >>   dts/upstream/src/arm64/ti/k3-pinctrl.h     |   3 +
> >>   4 files changed, 481 insertions(+)
> >>   create mode 100644 dts/upstream/src/arm64/ti/k3-j722s-evm.dts
> >>   create mode 100644 dts/upstream/src/arm64/ti/k3-j722s.dtsi
> >>
> >> diff --git a/dts/upstream/Bindings/arm/ti/k3.yaml b/dts/upstream/Bindings/arm/ti/k3.yaml
> >> index c6506bccfe..d526723484 100644
> >> --- a/dts/upstream/Bindings/arm/ti/k3.yaml
> >> +++ b/dts/upstream/Bindings/arm/ti/k3.yaml
> >> @@ -123,6 +123,12 @@ properties:
> >>                 - ti,j721s2-evm
> >>             - const: ti,j721s2
> >>
> >> +      - description: K3 J722S SoC and Boards
> >> +        items:
> >> +          - enum:
> >> +              - ti,j722s-evm
> >> +          - const: ti,j722s
> >> +
> >>         - description: K3 J784s4 SoC
> >>           items:
> >>             - enum:
>
> [...]
