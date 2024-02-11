Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB18C4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 09:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DEA687BA8;
	Sun, 11 Feb 2024 10:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F036187B9D; Sun, 11 Feb 2024 10:59:36 +0100 (CET)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com
 [209.85.160.48])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDCC487BA8
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 10:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=geert.uytterhoeven@gmail.com
Received: by mail-oa1-f48.google.com with SMTP id
 586e51a60fabf-214c940145bso1248246fac.1
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 01:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707645572; x=1708250372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3KkAxWSRsRVqnLK8aK70Cb5sASB4LcVupWqUX2gQf4=;
 b=ZTjmLU0G+SkRX0LPBccmjC4V+ywkDfHYXDdbvdOAnsUE/aoUJ57UmqAoj5KHSUYGPW
 BOh7elubJHoz/bn2HDH3lG86g98PQ9rUurCKJjzbJbdjV/WF/Q5DeAFufaTWEDl6gQYB
 UcHPbk1u0nKeBQopbS8I3TcCnEEk7nos8K1OCZLt3M5ZxNru6o5t2XSkiyGtvx7DExG/
 BfINnX+a0q6ouhM2kTMCrJNDJinOshwNxAulU9nUHRWdV4BHCuTzzvSc2ruNX7/vyutF
 VYqcmAB27r+UV0fQccJuomKsjhyn8SDgP+i6jUf0hLq1bhI3wxf+6S2vKd/g4OEJlJiz
 DhSA==
X-Gm-Message-State: AOJu0YwC3KLIQQ92gZ9REk9gjERvtfmlAkkr0X3em5iYbKjscIC045Ab
 kwYIBDQpM+Xj7uky7CycOSWnzTReK+thkRGCZWcslkBDQXmV5Sl+oVRuMxYoVVc=
X-Google-Smtp-Source: AGHT+IElapg+jnNGclJSHTNno1kgwbXAExheVdHjwQUz4KLYz1QFfVuubQVVyGB7wml1dg/EXocitg==
X-Received: by 2002:a05:6870:1605:b0:219:c9e9:8e65 with SMTP id
 b5-20020a056870160500b00219c9e98e65mr4059097oae.21.1707645572431; 
 Sun, 11 Feb 2024 01:59:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX+ybBh9hcaadkvo/vy7thpZUq9jjFMJ8ErBar57uCO6GQiMM7VEvqApYMK2sB/M/yhf/lbaJaSCyaSMiiRcQtbMQFhhQ==
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com.
 [209.85.210.50]) by smtp.gmail.com with ESMTPSA id
 q16-20020a056830441000b006e112c93b1esm1058290otv.6.2024.02.11.01.59.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Feb 2024 01:59:31 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-6e2d8a21b79so417081a34.2
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 01:59:31 -0800 (PST)
X-Received: by 2002:a05:6808:23c3:b0:3bf:d798:7689 with SMTP id
 bq3-20020a05680823c300b003bfd7987689mr4477262oib.2.1707645571682; Sun, 11 Feb
 2024 01:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20240209211535.3313392-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20240209211535.3313392-1-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 11 Feb 2024 10:59:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVTUQOogPTGNAa04koock6i=AMa5inO3Q43gJi_O2OBig@mail.gmail.com>
Message-ID: <CAMuHMdVTUQOogPTGNAa04koock6i=AMa5inO3Q43gJi_O2OBig@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: Fix broken clocks on all Gen2 boards
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, u-boot@lists.denx.de, 
 linux-renesas-soc@vger.kernel.org
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

Hi Niklas,

Thanks for your patch!

On Fri, Feb 9, 2024 at 10:22=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> To prepare support for multiple register layouts pointers to register
> tables where added to struct cpg_mssr_info. These pointers are suppose

supposed

> to be filled in at probe time and no intended change in behavior was
> intended.
>
> However the new pointers where only filled in by some paths of the

were

> driver implemented in clk-rcar-gen3.c. The path implemented in
> clk-rcar-gen2.c was not updated leaving the pointers uninitialized
> leading to a crash when trying to probe the clocks.
>
> Fix this by filling in the pointers in the Gen2 code path with the
> values used before they where moved to struct cpg_mssr_info.

were

> Fixes: d413214fb748 ("clk: renesas: Add register pointers into struct cpg=
_mssr_info")
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
