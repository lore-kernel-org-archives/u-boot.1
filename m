Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE17AE909A4
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 14:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B7583981;
	Tue, 17 Feb 2026 15:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fBWcBfFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ED9283C72; Tue, 17 Feb 2026 15:01:31 +0100 (CET)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BA0C80325
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 15:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-56739adfa1aso2389962e0c.0
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 06:01:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771336888; cv=none;
 d=google.com; s=arc-20240605;
 b=UfGYVLKEDRumvPXcbQHGtjSutaEIEZEEfhZIvGKg/QONXmwp37OXHdMNy9DwZCWCsM
 jks1+pWVdWpw5jlqUcv+G3gLZoUYZs9Z8mPThYjzhPfb5B8ZTste+Rj5uxQnGhgqQceX
 MVTVAVMmWGXieKMbt8t08T7canjt5Uwzi0n1UYX95A+R5qcLhikjDPjduDYai1c1irV9
 SuF4iJgd1X8HVTvbxdrWuNm2YpmlCtaJ4scMjlQ8IoUqXKVDzUV2DKCTDd/g8NZ4ysnp
 SpZrBs6jA2GaxTjY+2xlruQ9JpekQ+E7qFdI5rW8jxPeJ83BHPUuMealmKHAdhRAdhUA
 rjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BYj5lK/RGF4B7FmeqZ9ALpxO/YKSK6CrO5f/tSktcPI=;
 fh=lHhyN+Kr5gIiaLGDXtqmf5slgFn8HyhPjw5CO+TDZ2o=;
 b=fUsDTdxUo9A9U77wWVY+5UecBm+D4Ehxtx0E98me0D6RZSFs7+ped1mEWQoPOoaFTL
 elCQ9O9bGZPgToDYCcHpH9rxfUzxTKb9Gc/SMHXRQNeIBf8m+wZqqCRVzeV6daNv5quD
 bCHfLvBz3KmjyLcUTtOwj8Z1B5lJTiDAfyTOHm1D07UdalJkTRSWmxAiCxMGDrUWlKX7
 x0B20knM6JvT5lAjSyvoi2leldg3BVjMx6V7hEprw1QXv3p7C8IZKhtzcI08woRH1GMv
 c65QC+rqcIwc/Y6gPIAAUiFEJm2hFd9lxDLoVBKseOtImYGovq/YyAVtlZYX4GRwLFEV
 xEnQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771336888; x=1771941688; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYj5lK/RGF4B7FmeqZ9ALpxO/YKSK6CrO5f/tSktcPI=;
 b=fBWcBfFMp58jiUsZS6ml8wo7TtRNwIBPFOOwNL8zbs8LVWp1kFAshN8ZNHB0pRhKyl
 tdgkNIHIx08ZkEWOzxp4M4C9JSzjwbUAS6fgdGoIILlXJg40crNr+GqitteGknuN02Hh
 xl4delBYp3mvnKIPsuBjPB6WG3Ay/DWx1kn7F8UtWf2ZAdA0k/0SUvf7dNk2lUlXx3R8
 VFEJMdB4PphbV/7Lj0OGDWIDnBWF7vErrGBrhDKO0JLYWtl/SK+B3pFSaLKsMxRhYvG9
 pybJxBLxc1uEXfQsUZPFPuh57unsQBc0rVqpTCubki3zAiwvHrmlS1CjnqaVVa0Hu5vt
 D/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771336888; x=1771941688;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BYj5lK/RGF4B7FmeqZ9ALpxO/YKSK6CrO5f/tSktcPI=;
 b=OINjcpWysJnu+LNxdDTLzzlkjXJakfuDOm3X/0QoB976GT69C4ZWlvVftF8bxbWBPR
 qF271K5OAbPa9Z0NfC8+TgZ8kz3e3BlqeuDPZAL2Gi5pXWHw9errPYDI806uVViRs5oy
 +IvexHZ2x1oV9MI+yCsPz4qBkhsGl429xsHMKj0+xrxvxyFEC8g14SC9CyFkNvYdD1EF
 NPNzuz9uK8OMyhUYDP2uQFCl+QcXcdvYUXjO9hGe4Ucm5RpMmOb7ABOjgTdSU3wFHaC/
 SpOy56kRjcT9F0kXJPOIanw3CCnqgpql88htNX1iULTO+vHaY7sZZMAHQq9TX/8b8/Js
 MTbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfdg+IJneAVeM6Zj5Oh5fD/YGMPTibU9fC8vlky+abOd9LCSJRpUs9dkY4NBWCqAuTfMD6iLg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxng1mGAvtGM/gRybGT03jGd/jFcEW9hPg3jWQzR0HG/RI0H3vx
 PKL4jihLmqythhuWNB1oT5NJ5yeJBv346mmOM+r97RKP2+iT23YzyPLojZ8kYY439Kgjo/Qu5L1
 rH4IS8pRnMPXdZlfICLRFQrgYR3umoiY=
X-Gm-Gg: AZuq6aKgx/uFPy7+VCiRKJJIh0SV+nxMIBrfQ/57Tq/ZgQIifWq2hiMKWuqLA0W91g1
 I4pi5aFKpS/w2H7MgSJoAGKEBvadEWw0el9itlgVDkJbZSt1njdt3zs/EZbbQiiQ+6qCGey/Oc3
 /iB88irA86H40c3qDm52KAZqxoeT+tkau4+svZcz59OwnJiPC/iqp2FLLZzztAybn75IUGD2OXh
 QWXzNYX+Z6l991XSL91IuCCZV9b1qkiXruwfy9ImYxtsR4cDMA8vmWU34LvUfOjk+M+QwmA8/ze
 gaBaDude
X-Received: by 2002:a05:6122:330d:b0:566:3954:f74e with SMTP id
 71dfb90a1353d-5676a90b4fbmr4783432e0c.5.1771336886580; Tue, 17 Feb 2026
 06:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20260213225254.2544596-1-raymondmaoca@gmail.com>
 <CAC_iWjLaWYndgvrCFGer-8mgW+t1usawjy+QroW+H92NmY3WZg@mail.gmail.com>
In-Reply-To: <CAC_iWjLaWYndgvrCFGer-8mgW+t1usawjy+QroW+H92NmY3WZg@mail.gmail.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 17 Feb 2026 09:01:14 -0500
X-Gm-Features: AaiRm51C3FOVXUWzXjvQoe6Sh4JnnJyRMiuubfq1WrCy8QNyG3os0gLLpJc5uI0
Message-ID: <CAMDkj5yeM4+yFK_RJz-jSJoVcw84KA_68GPpCr7hWaby8p_paA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Implement all missing SMBIOS types required by
 distro tooling
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Raymond Mao <raymond.mao@riscstar.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baocheng Su <baocheng.su@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Samuel Holland <samuel.holland@sifive.com>
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

Hi Ilias,

On Tue, Feb 17, 2026 at 2:15=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Tom, Raymond
>
> I tested the patches and they now work properly in linux.
> Unfortunately I don't have time to review them depth, but I think we
> can pull them in since they improve the SMBIOS reporting overall
>
>
> For the series
> Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>

Thank you so much for spending the time to test.

Regards
Raymons

> On Sat, 14 Feb 2026 at 00:53, Raymond Mao <raymondmaoca@gmail.com> wrote:
> >
> > From: Raymond Mao <raymond.mao@riscstar.com>
> >
> > This series finish the last missing puzzle of required SMBIOS types by:
> > 1) Fixing duplicated handles when multiple instances exist in one type;
> > 2) Implementing the rest of required types 9/16/17/19;
> > 3) Adding version control when printing properties for all types.
> >
> > Type 9/16/17/19 are generally DT-based, the idea is to write these tabl=
es
> > using a hybrid approach:
> > Explicit DT definitions under existing '/smbios/smbios' take precedence=
,
> > with fallback to scan and interpret values from the entire DT.
> >
> > Moreover, all below APIs:
> > smbios_get_val_si()
> > smbios_get_u64_si()
> > smbios_add_prop_si()
> > are on top of sysinfo, thus allow vendors to get values from other
> > subsystems by implementing their own sysinfo driver if needed.
> >
> > Raymond Mao (6):
> >   smbios: Fix duplicated smbios handles
> >   smbios: add support for dynamic generation of Type 9 system slot
> >     tables
> >   smbios: add support for dynamic generation of Type 16 table
> >   smbios: add support for dynamic generation of Type 17 table
> >   smbios: add support for dynamic generation of Type 19 table
> >   smbios: print the properties only when they exist in a specified
> >     version of spec
> >
> >  arch/arm/dts/smbios_generic.dtsi |   12 +
> >  cmd/smbios.c                     |  365 +++++++++-
> >  drivers/sysinfo/smbios.c         |    5 +
> >  include/smbios.h                 |  151 ++++
> >  include/smbios_def.h             |  250 +++++++
> >  include/sysinfo.h                |    4 +
> >  lib/smbios.c                     | 1151 +++++++++++++++++++++++++++++-
> >  7 files changed, 1905 insertions(+), 33 deletions(-)
> >
> > --
> > 2.25.1
> >
