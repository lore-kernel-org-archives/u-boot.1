Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65785C48295
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 14:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F1087944;
	Mon,  5 Feb 2024 15:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="hCi2XgzO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 206468798F; Mon,  5 Feb 2024 15:38:49 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B07C0878CB
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 15:38:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d09fefabc1so18881971fa.1
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 06:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707143926; x=1707748726; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzdbfw0C60i5Ot2+zgJVNTQlGiFLZ4yWr+BR4rxd6U8=;
 b=hCi2XgzOYlVgqd8BUri97jrC9mIlXJkkJu/GWr4CDoRc1ehxLfz6l6BEt9ZztLAcfE
 24yzaZUDRWXYRGWoETBRnb6g1QbWTBCtPRgC8j1Oaeu71wKdHxWmFwX3u/o3Fgnj70NH
 CqjHhX0wUXB7kqqBEZq8PYQvnnx4VrGP9lM0kaQ6sAoDn6L8hWFz3p2FPqpz18okMgkf
 RptatjeK3+IDGHDiXRxeuS5DB6QEsflES2/7+hK8lhySyrjqF2WCIsgxSS63+HIcaxQ4
 9lszTtIxKZAi6h+eten50dtMbSxkTLoSmz74IUB8lJt/z/3c8NFg8donecEUgyxes66O
 Ceiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707143926; x=1707748726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzdbfw0C60i5Ot2+zgJVNTQlGiFLZ4yWr+BR4rxd6U8=;
 b=ppjO8rBG1JGZxv2OcXhUHpuWCwMOHQ7/pU963LSRPNp/Ba3hUqXll+hZFXGGeVJO5Y
 oJZMQMUgGxaBDVyZGr+yo5BiBDSAm/jiI0k7eUep9HPbuUyJEW8LpDG352CLdmmXEFxz
 UBB52vpyGfZMdbi6WAwtLZkmMaylnjMI/9QeVE4qQaEoHaUlhAEAsLV/LtyaQSvzFaro
 gfuwdqJFusJMpr9lVMxB21dLlt/Urgvcn4QX4OKm9ONHYnvKdLv/nAFDO4qPHXuSlBYr
 MA6lV+hHYLYMfCW2S4/DP8hCKMcWP7LfqeoED3y/b//d97PeIBiXpFG8AC68HtltBLyq
 qH8w==
X-Gm-Message-State: AOJu0YyNqdkEL3Ce7K8EK3PdPmEKutd4ZQZnh1BWBUgPqBovOlxRJEUu
 ZOoOV+nZYv1PFDLHBqBi1TYhYD54bUknG8KjCsMnc5qLpQg3XQI6qssgVH64mIzYgkDN0gA+ced
 CVzt0yN2I+zwqDwvn7TLDM4nRw2H6LslGKyNLlA==
X-Google-Smtp-Source: AGHT+IFaMxFYy07JXpREcBO9Wkl33TL9ZoZfCINK4W95JUYML5QRtwRyIKiaVX6wrEOPS/85gGa4fi6kZBlmtb2tBbM=
X-Received: by 2002:a2e:8e85:0:b0:2d0:a1e9:20f2 with SMTP id
 z5-20020a2e8e85000000b002d0a1e920f2mr3345586ljk.29.1707143925880; Mon, 05 Feb
 2024 06:38:45 -0800 (PST)
MIME-Version: 1.0
References: <20240202214429.2185563-1-igor.opaniuk@foundries.io>
 <CAAQ0ZWRFak3LwsSVCxi7sd6AmpJsegdv6A4Y=piwb8eStLTjLw@mail.gmail.com>
 <Zb36M+p4z2+zd+XB@trax> <tencent_0A657770FEC7B98668A070C65A10F4166007@qq.com>
 <tencent_BB07FFFEDC5A344A385BED0EBA35F0ADFB06@qq.com>
In-Reply-To: <tencent_BB07FFFEDC5A344A385BED0EBA35F0ADFB06@qq.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Mon, 5 Feb 2024 15:38:34 +0100
Message-ID: <CAL6CDMHvAo4YW8JL-4FfwcWduXJt863s0i_RzmZy==Kzqi7Jdw@mail.gmail.com>
Subject: Re: [PATCH] poplar: add myself as co-maintainer
To: Yang Xiwen <forbidden405@foxmail.com>
Cc: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Yang,

On Sat, Feb 3, 2024 at 10:59=E2=80=AFAM Yang Xiwen <forbidden405@foxmail.co=
m> wrote:
>
> On 2/3/2024 5:45 PM, Yang Xiwen wrote:
> > On 2/3/2024 4:32 PM, Jorge Ramirez-Ortiz, Gmail wrote:
> >> On 03/02/24 07:54:22, Shawn Guo wrote:
> >>> On Sat, Feb 3, 2024 at 5:44=E2=80=AFAM Igor Opaniuk
> >>> <igor.opaniuk@foundries.io> wrote:
> >>>>
> >>>> Add myself as co-maintainer for Poplar board, as I'm currently
> >>>> working on it (re-testing releases, addressing issues etc).
> >>>>
> >>>> CC: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> >>>> CC: Shawn Guo <shawn.guo@linaro.org>
> >>>> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> >>>
> >>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> >>>
> >>> I'm not actively working on poplar any more, so maybe remove me in
> >>> the meantime.
> >>
> >>
> >> hi Igor,
> >>
> >> Yes please go ahead and thanks for offering.
> >>
> >> I'll sync with you later next week (I found my Poplar in storage, so
> >> maybe we cam improve things a little)
> >> Also it would be good if we knew there are still users.
> >>
> >>
> >> Acked-by: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> >>
> > Hi, everyone. I'm working on a set-top box with a Hi3798MV200 SoC. It i=
s
> > very similar to the Hi3798CV200 SoC and many peripherals and drivers ca=
n
> > be reused. I think you can try moving
> > arch/arm/include/asm/arch-hi3798cv200 to arch/arm/mach-histb and let's
> > maintain all HiSTB series SoCs/boards under it altogether? The same
> > thing also applies to TF-A. Currently upstream code refers to poplar
> > everywhere but actually the port is portable enough to handle a lot of
> > other Hi3798-series SoCs such as Hi3798MV2x, Hi3798MV3x etc..
> There are some patches i sent pending for review. They are mostly
> originally sent just for Hi3798MV200, but the framework(such as
> drivers/clk/hisilicon) can be also used for poplar too. I hope you guys
> can take a look at them[1] and give your opinions about them(RBs and
> Acks are welcomed).
Sure, I'll take a look during this week .

>
> [1] HiSi clk framework:
> https://lore.kernel.org/u-boot/20240119-b4-hisi-clk-v1-0-279e38c95ca2@out=
look.com/
> >>>
> >>> Shawn
> >
>


--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
