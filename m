Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD842EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 142A78645E;
	Wed, 23 Aug 2023 16:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="gI4ge7EM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E1F8645F; Wed, 23 Aug 2023 16:54:34 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06A90863F9
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5280ef23593so7028556a12.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692802472; x=1693407272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yy5mBAYXh88eMRxuF9t1ftiSDcvyi54rTVj4BMal+PY=;
 b=gI4ge7EMkH2wcGeMfjF7M+FWW60A5eJw3dUYJHlZDY1C6B6TTvpvXAnhga8TbeMMnC
 XC61DjDyyw4ALMVneGdCt0rlzDmm8ezgZ8ZdPViSEBGrUTPE8o8fRgOxJuOf64ASeYZ0
 FEprPgJMmg6iYoDE0F5uoD4W3Pcmthv4BNc0fTfdWPqK3vPS137g3p2xBM8HqIWRvduz
 C3plE1SjRTmLLI7n98xuvdxVfyByQctZgEo7p3zjRA5c42N+U0aeNcFrUABQPPZ7sLwn
 yp7zSFuQq4oO5AwaYpYmleppQSPXfjYqA7OGA3kXRO/8S8Sfq5dV9MokAJTCIylc7llY
 qyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802472; x=1693407272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yy5mBAYXh88eMRxuF9t1ftiSDcvyi54rTVj4BMal+PY=;
 b=FPA/Hv5TQXGQ6FkJdX1Fz2GiXTvpKZM3r7hZ+Qs1PokhRij1RXrdle5LmKgk1Dt47Y
 mD29PToVMA/VRDfkFfbb2x3+ZD2nm2FB3NbqyT9Zmrq/ATx0ZdlVtir2yrZyCoDsYNF2
 i2xYEbe6n15Slzk3UVAUEJ5Nw30PTTfMkff0vGgBlVGUHZy1Tmk1iQJpT5HsSluciBfw
 P73HSjlusP29Mjtcov5l949H8KjfZS+z8HPtKRbTb210cZlv8aLY2fti/9MBTiMueQCy
 VxT+vsFbCGDNWC0kOQwy42sQ8ZPHhGbvgMfGgxn+57kIZObj/z4+YO9xMDpcdf2U8TIL
 Wnkw==
X-Gm-Message-State: AOJu0YxL7aRURwVfABAmYxopBX5lfJgJ8ouuLl+Ne4u0G15bgLS/zju8
 kcnXRQiBQKkQ2g4VrWcbHmiw6A7sYfkEv2gspJ3MlA==
X-Google-Smtp-Source: AGHT+IEi1sJ5xwjJ8jrZHaicx3LXdUhUQAMia/gvFlULp4eX0rEDAmwKkHxQVWvGkOKIgBbkPzcN7g2lUIYPqNBEvLM=
X-Received: by 2002:aa7:ca48:0:b0:525:4ea3:a373 with SMTP id
 j8-20020aa7ca48000000b005254ea3a373mr9546788edt.29.1692802472374; Wed, 23 Aug
 2023 07:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230822112217.4646-1-clamor95@gmail.com>
 <20230822112217.4646-18-clamor95@gmail.com>
 <ZOXq0SrF9h0Z9uHw@orome> <86A72122-840F-46B1-9C25-0B6F5AFB82A1@gmail.com>
In-Reply-To: <86A72122-840F-46B1-9C25-0B6F5AFB82A1@gmail.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 23 Aug 2023 08:54:21 -0600
Message-ID: <CAPnjgZ2G6V3WqO6ZP4Fsuuz4AWKV6LMQ4Fxmk=nRmOsEZ7zpag@mail.gmail.com>
Subject: Re: [PATCH v1 17/19] ARM: tegra: dt-setup: convert TrustZone remove
 into config
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
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

Hi,

On Wed, 23 Aug 2023 at 05:47, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
>
>
> 23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 14:17:37 GMT+03:00, =
Thierry Reding <thierry.reding@gmail.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=B2(-=D0=BB=D0=B0):
> >On Tue, Aug 22, 2023 at 02:22:15PM +0300, Svyatoslav Ryhel wrote:
> >> Remove of TrustZone nodes is required by many product devices
> >> which require repetable calls of same function from device board.
> >> To simplify this, TZ remove is converted into Kconfig option.
> >>
> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> ---
> >>  arch/arm/mach-tegra/Kconfig    | 14 ++++++++++++++
> >>  arch/arm/mach-tegra/dt-setup.c |  7 +++++++
> >>  2 files changed, 21 insertions(+)
> >
> >I kind of preferred the original because it's very explicit. There's
> >also no big advantage in consolidating this because the code is unlikely
> >to ever require changing (the libfdt API is quite stable and these nodes
> >are all hard-coded anyway). This new variant put non-generic code (it
> >requires a Kconfig option after all) into a generic place, so it seems a
> >bit backwards.
>
> So you say that I have to add same function to boards over and over for a=
ll devices I plan to mainline? Unneeded code duplication in action.
>
> List of devices which need this:
> - transformers t30
> - transformers t114
> - grouper
> - lg x3
> - endeavoru
> - tegratab
> - wexler qc750 and basically ALL t30 and t114
>
> Ok, fine. Dropping and moving on.

Where is the binding for this node? I have never heard of it.

Regards,
Simon
