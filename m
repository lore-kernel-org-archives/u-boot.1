Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D141C47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE08687C37;
	Mon, 29 Jan 2024 13:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EfVwNiqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28D9787D8A; Mon, 29 Jan 2024 13:14:56 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BCBF876F8
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5ff7a8b5e61so23879737b3.2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 04:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706530493; x=1707135293;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9sGTdOwJ/XZLCQtC9PSKLfeES0/sCXvvsHgy5bNkxc=;
 b=EfVwNiqbeSfHPGfpFNgsVwZQOETGemAjJLf7FMEuT34/bO5kVKbEHkrl+TuwAnxM0q
 ui52hRrYnSpSVw+v5jDv3RvcbwebHjZHD7VvpgBOOPtk7UJNr/bQOL98HyEqXiJmaFaN
 yazCkPrkLcjcRBTj5w7RrN1YB8CgIo0CUzhtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706530493; x=1707135293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i9sGTdOwJ/XZLCQtC9PSKLfeES0/sCXvvsHgy5bNkxc=;
 b=fMXHUygZRwwYAKDlTMMOcdSClxZPcKKd1jt/rfSFdDQbR+YRhqUUBVghk2IttvufRh
 eyECpveVYSCwSU5W/s0uJXa4/soePiBLhuE8a1bP7nPWJNJ1O4oKvbMjfLIgjvoxgigg
 nS2cgXL+ASOFKRSdaYJJQe3hxC4ze2QiKLYM9NF7U6Fybcr/U1/atZkVa7tLrmSx2Gae
 e/2Jz+O99gWFXrwDiOR3zbQapV21hCdGgaSKL4P3ixB2NxTblxtdjDPlswKQ6QIqMLiP
 Ph3Dz8tgld0KBj56h1kWADxOBmF/DYoUlMXhRizYFaQGNs2XbddOfUvSx1/p+ejKlk+5
 Kzjw==
X-Gm-Message-State: AOJu0Yy2kWSl7a9/p811xfJHQuRsUyhv0kFNDjfnYWZ+r0vOsWlLaEY6
 14XVfigAHeaCzotviTD6sfv1dd/qK+FVjUFq176vczhk1Ms+zRVlxOO81p5fvCUve7bWETKOYNp
 JcPjfI7WoMUvdoeMctkgfYCEd/ndB1x4LjVCQM+NWgeD+6nVaiZv5lA==
X-Google-Smtp-Source: AGHT+IFL3oVgyUlYFR678BRI/xlfxECX7SJdMTs1wEhW3iCgvAwB7QvD4Fa2h/yX3yMzuJlmoMx/cxdeQ4HihBjX6VU=
X-Received: by 2002:a81:ad18:0:b0:5ff:c4b8:9517 with SMTP id
 l24-20020a81ad18000000b005ffc4b89517mr3504160ywh.25.1706530492818; Mon, 29
 Jan 2024 04:14:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
 <ceb99692ba605ef079c6f796082055bed047248b.1703220284.git.Takahiro.Kuwano@infineon.com>
In-Reply-To: <ceb99692ba605ef079c6f796082055bed047248b.1703220284.git.Takahiro.Kuwano@infineon.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:44:41 +0530
Message-ID: <CAMty3ZCyRdZkMoRZSB32cFd2CV2fb9xaGZDJnpVr01BSX_d2dQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] mtd: spi-nor-core: Use CLPEF(0x82) as alternative
 to CLSR(0x30) for S25 and S28
To: tkuw584924@gmail.com
Cc: u-boot@lists.denx.de, vigneshr@ti.com, tudor.ambarus@linaro.org, 
 pratyush@kernel.org, d-gole@ti.com, Bacem.Daassi@infineon.com, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
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

On Fri, Dec 22, 2023 at 11:16=E2=80=AFAM <tkuw584924@gmail.com> wrote:
>
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>
> Infineon(Cypress) S28Hx-T family does not support legacy CLSR(0x30) opcod=
e.
> Instead, it supports CLPEF(0x82) which has the same functionality as CLSR=
.
> spansion_sr_ready() is for multi-die package parts including S28HS02GT, s=
o
> we need to use CLPEF instead of CLSR.
>
> This change does not affect to S25x02GT which uses spansion_sr_ready() as
> S25Hx-T family also supports CLPEF(0x82) as well as CLSR(0x30).
>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
