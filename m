Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88890C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 21:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E44578752A;
	Tue, 18 Jun 2024 23:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="VAScksue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE3DF8839F; Tue, 18 Jun 2024 23:04:03 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA3F88752A
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 23:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a6efae34c83so723498066b.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 14:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1718744640; x=1719349440; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BkDzeJhcj6XpAtztbjL5d1LCtxnp8AYsNXhngwTtShY=;
 b=VAScksueMLmU24YYiIHPcMSROCT7VaglUima1TdH0+r78qNlzeSsFoR1Ez7NAO9Efv
 eThs+5pRgUwDl9i7A27IjE2Axhj5davrN04aCkF3f6aXYexEOIgaEuOouiERLIbyLe/m
 q7xQ+MHQkTCR5RQRIeHWu5WQq+p0uL/k12dFEi3eCkza+vXudMIOdLnZpVXOWE0eqMhZ
 Z4fitzC0ss8K0vbvAZc6j268oOcmS1OZyBbsmdCyzTGvP5LcJpZ4s2ivJw1poXUNrUyD
 oDTnCF5L6myHtXChWQxh7m3qULLuZYAfScpCWCpkd813cX1nBv24oNa9/7QymU77BX2P
 0jXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718744640; x=1719349440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BkDzeJhcj6XpAtztbjL5d1LCtxnp8AYsNXhngwTtShY=;
 b=quJ5pu7xHdlG/MD9QetMBOAUUl65l2b0JixRkykRkTqDpBdnmKvQbDg+im38pDDYEP
 69X6zMWWEwrzbFl6OAuyFHHKVZvj3Ecy2lKYU9YmKhQ0npkvPCXkPpf/4B3AhPewoX0h
 j7IBA209OwPBCgdWyAfv17tZuU38bTppBxgqP571GFsBb2M0Ju1rjWaZFmGhrZE5u9L1
 Um2SpHgNimujpOwQ2muRaBN2kU83sxScsm0ft1U5ojYb0KtCprWpz+1nGGai8+n9zPVB
 lxG39FsxVapQgLJfCAQqzzSK7sTx1vlGUJN/XOaHVILoAiE7yT7Iqx5FD1jt3F+Yz8o9
 R1Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQvMCyMTre/u6bxdqCqcMZ6bdmxv59p8rBNDsAIz78ViWemYuOWmpUhZptur9qIPSOOcMbeLcnPa6GxYtwvepem02iVg==
X-Gm-Message-State: AOJu0YzPyZjMAaBzI/4hNKX12bdDQNRvdQhc59Pbywsm4Nu3K6xs10an
 BC6RcC0Gl7gCtvPUdWi0ocEXeJ7kHmG/e6AfmN4X2g5DLNYfE2t1A5glkx48LViGccKFFUV/nzS
 puC55Jo/VrRDjjmthoNOVTQsmtzkfVnJxMgDEXA==
X-Google-Smtp-Source: AGHT+IFJ0PgC2bPbrUnqZdzFu4fowGYTu8eYKpRdI7SWQHyPmq38+fiRiRi7LZ3kaIKdG2+fO1eFJCD/euqRPVLvxpU=
X-Received: by 2002:a17:906:ee8c:b0:a6f:e19:6fb2 with SMTP id
 a640c23a62f3a-a6fab62f551mr40332866b.29.1718744640241; Tue, 18 Jun 2024
 14:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-12-51472eb70357@flygoat.com>
 <20240612160053.GS68077@bill-the-cat>
 <49522625-8663-4102-82aa-cabc0f239afa@app.fastmail.com>
 <20240612165048.GD68077@bill-the-cat>
 <e94995af-f9dd-4262-8dfb-2c47ab817e61@denx.de>
 <20240617232904.GL68077@bill-the-cat>
 <c50b3dc0-0385-4548-80ed-ffdc8623bfcc@app.fastmail.com>
 <20240618143159.GR68077@bill-the-cat>
In-Reply-To: <20240618143159.GR68077@bill-the-cat>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 18 Jun 2024 14:03:48 -0700
Message-ID: <CAJ+vNU1fifv8gi3MLV+qBk2-Q4aiZNG4Vwr=MgbfjZzMOAbvHA@mail.gmail.com>
Subject: Re: [PATCH 12/20] cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000
To: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>
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

On Tue, Jun 18, 2024 at 7:32=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Jun 18, 2024 at 03:00:50PM +0100, Jiaxun Yang wrote:
> >
> >
> > =E5=9C=A82024=E5=B9=B46=E6=9C=8818=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=
=E5=8D=8812:29=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> > [...]
> > >> Acked-by: Stefan Roese <sr@denx.de>
> > >
> > > Can we please get either this, or
> > > https://patchwork.ozlabs.org/project/uboot/patch/20240524210817.19532=
98-1-rasmus.villemoes@prevas.dk/
> > > merged for master? The number of false negatives in CI due to this is
> > > big issue for getting more contributors to use CI. Thanks.
> >
> > It seems like CYCLIC doesn't have it's own custodian tree.
> > How are we going to handle it in this case?
>
> Note that in U-Boot it's less important to have a tree per sub-section
> and more important that custodians have a tree (and then use appropriate
> tags when sending pull requests).
>
> --
> Tom

Stefan and Tom,

I'm seeing CI issues here even with 5000us [1]:
host bind 0 /tmp/sandbox/persistent-cyclic function wdt-gpio-level
took too long: 5368us vs 5000us max

Best Regards,

Tim
[1] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D8737&view=
=3Dlogs&j=3Da1270dec-081b-5c65-5cd5-5e915a842596&t=3D69f6cf72-86f3-551a-807=
d-f28f62a1426f&l=3D748
