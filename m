Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AE8D12D60
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 13:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9576580433;
	Wed,  3 Dec 2025 14:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QYkjFR+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DDE9808AF; Wed,  3 Dec 2025 14:40:53 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 633808003E
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 14:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5957d7e0bf3so950296e87.0
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 05:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764769251; x=1765374051; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RrFBrg/M8NvstuGrRQivhJAk1WQ1FSlRe3EiQhr5Rnc=;
 b=QYkjFR+l0wF9jIZ4vT3fdIXNhdYdtzXh8Tu9nGRikdj6LD9RfhgqDiH8RgfEkArcB4
 q1urYSZBI7PnhZo40ukE+MYpW2wTel/Ddqwt6WYfxvzE8Rswrp5fDknGrd9uHmYBpEMl
 RxiBw0c3y38pQveqRIPy7pUgTcwZxK7ytmSuTx4a4Rfl66IQMhWIyIUhTwk7sp/HvpWl
 kjhpvlgY4oGTIk5ihu2XMAurx/gw8b4w/DLTyqxbL08iE+LpXQTAGpEhUof3wJjhYgG8
 nZOCZ+JSIRhr7S0Am/NtPfMK5cHWfDeAi4/p5rwVB/AZ1fd6xaAdHXstoQNu2v+4LDC4
 4+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764769251; x=1765374051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RrFBrg/M8NvstuGrRQivhJAk1WQ1FSlRe3EiQhr5Rnc=;
 b=AKzo72OFq4pjklMbFOTLs+2JmZ2oHGrq6HHELl1wgNKvbdYgCARoCPN+dp9u1HdolW
 XuN/esmHbU4nyuWJUQwEow/oZalScAE0Whz648etp2UlgMepgtqZ/iwZ3Yiu6pIGdrUd
 azxXhNLvnHCc2IJlIRgo076r5wmwtirrLuaCb6HM/9ZSLq5WJkc1S87/lbU25A9QufWc
 oX74F5DSfBWAbHyAOGfh6a8IPYFTilihPK4sExCBWOXYt+17ECvJO+MOd/ia8U11fJyf
 feTjmGEiutOHRibncwLscktJ0lipa6zqo9Z4gVOwMUSNev69/8iifgw7ZqxzjA0sW3R+
 TP1w==
X-Gm-Message-State: AOJu0YxTMOcx6K+T3AyUhvZyRUTyeH0Bwdj0R1bY1GJCsO8G2eTMak3J
 7x9Tlt6aj1mZSa90vBuRsiPqFGj61Ugi4cA1aAh2CpoyoNBsOu9xtJEkt1eoZLRsymHm/cc3kRa
 abZYhp4c3zG9vI54Ue71kE5yhza9/pxY=
X-Gm-Gg: ASbGnctp6vIAWi+MHEDI66eXWsAVetT8N4Mnup3miZ99u9WSizxkUYgz8LZb9TGThGP
 mRrzwTZJ9T4Yuz3cEcuzylesX+B9Gh8rQ757lu6Dgm4XB7c8QWwnodN/AfHAk8n5xqpd3cm7qjB
 FE+8w1ag6z9tIrVl4HonhmMRcmWBzLpncxnCbQNbfpYK+9MZqpNyi8LcnnOiFqjVoXNrDDSFdG+
 VBrV34swNmu0pRGDPpe/Nl887220gQnuY2Myz/1rdX6If8Ts2xIGwqeMMfgr1dqcMp+9eAdBv2i
 ur8XOXLrMPuuyeq3T+tMzbyZvXE=
X-Google-Smtp-Source: AGHT+IGz8tlF0cku3XEjaZbZShKryATh5uGOqHUhMM8d+3jqq+wd1VCJzNfCoNkfZmgDq2qjEZJMuDyAOsWJjvI7mcg=
X-Received: by 2002:a05:6512:1285:b0:594:1279:dfc0 with SMTP id
 2adb3069b0e04-597d3e3c706mr994747e87.18.1764769250478; Wed, 03 Dec 2025
 05:40:50 -0800 (PST)
MIME-Version: 1.0
References: <20251203-topic-am33-evm-lcd-v2026-01-v2-0-262cf4f34eb5@baylibre.com>
 <20251203-topic-am33-evm-lcd-v2026-01-v2-3-262cf4f34eb5@baylibre.com>
In-Reply-To: <20251203-topic-am33-evm-lcd-v2026-01-v2-3-262cf4f34eb5@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 3 Dec 2025 10:40:39 -0300
X-Gm-Features: AWmQ_bl03NdZKl_aq0YpVPtGCVTXFJF_i3hnixvzQKzF4bvkfjNwYjcFiB5rUEU
Message-ID: <CAOMZO5AdZs1+rsD+XB7tFRPpMG3o_FoJZAFK1HkRDVuKOBtEsA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] video: simple_panel: Add tfc_s9700rtwv43tr_01b
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Sukrut Bellary <sbellary@baylibre.com>
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

On Wed, Dec 3, 2025 at 7:19=E2=80=AFAM Markus Schneider-Pargmann (TI.com)
<msp@baylibre.com> wrote:

> +static const struct drm_display_mode tfc_s9700rtwv43tr_01b_mode =3D {
> +       .clock =3D 30000,
> +       .hdisplay =3D 800,
> +       .hsync_start =3D 800 + 39,
> +       .hsync_end =3D 800 + 39 + 47,
> +       .htotal =3D 800 + 39 + 47 + 39,
> +       .vdisplay =3D 480,
> +       .vsync_start =3D 480 + 13,
> +       .vsync_end =3D 480 + 13 + 2,
> +       .vtotal =3D 480 + 13 + 2 + 29,
> +       .flags =3D DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,

Thanks for respinning. It matches the simple-panel Linux driver:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
