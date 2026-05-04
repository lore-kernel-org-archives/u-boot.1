Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34A7FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3498484836;
	Mon,  4 May 2026 22:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ictuy779";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 911758483A; Mon,  4 May 2026 22:38:35 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50D72846DB
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67b6dc50b61so6661408a12.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777927113; cv=none;
 d=google.com; s=arc-20240605;
 b=E5NyIjED13+oeWH2lMuaY02xiwDRJT5z6+8wSPKnqiJ/eKloADmWx7XEuBqR0ZoOcF
 RgEpEJqwpLP/rCnENs/TxUgKI/gSyylYCugc63sNQK7U7lee2+9Loj1M8qDHGGm3vraZ
 Z/a+zWFtvgq/N3B+TnvHHPympLPKtQFmyuKu5fLnHkevSnLE1OXBowr8w8zcJlBnS7rG
 8/XHucfAFfEpRdMmy06rTzp8lG9JqqcwvZQ9gZigzw4k/IyStLgG5cFH0QBQmOu8bZaO
 OaPprvNI6wms9+ybReE3g9YQBX1ivnulJmPOoDZupazwcxalfrbPU68xdSKfO//Esk5w
 XzvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n47CV2uz5VDGGoNyqC8BTcwhD0wbhupurmRzuE0ZoTU=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=XAoXIBCatKaIC5zHIbq87B0UwIYcaqgzxA9ON/ftTT8VdmXFzbfOIGilvUQEK4lWE0
 HFYGIBOWM6j5eZUPaBMYQAk79bkkQbkFiOqYmxOpa4Ct12oJwwGrW9fIoniO3aJyXXS5
 lhqtdOESBO7MAbKi8K2U/qY0XKEjoFpuPnyx6nO23FJVstZZ1xaN3rAZRG/jt3UmSHqO
 wFNXf/mpni0D4VHe+SI0utwQhol+NQVddoG7bQrevpCeabcjFKqk0raWxBDM6C7GPIcA
 zHjwTvQr8TNzQJu7zPlg0Z5xU3oX801K95wNotugWsqG7zwmSEsjBuiVXf8UNdHmYQuk
 SpCg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777927113; x=1778531913; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n47CV2uz5VDGGoNyqC8BTcwhD0wbhupurmRzuE0ZoTU=;
 b=Ictuy779RF1YeDNK70hbhGlDwiO/2bHH1TOTdebZhqhiMIDIzaF2ovjz5ijh8YT38w
 4dyaU/BMSrHrtKoGQDCfJ7A4Vf1Zlqg0F2dU86HT0nHEbiZqZuEpHTdS0CEP6rG/RvlM
 HGrj/9fbPWxtfiuq26HdOKr3VwFb0pu2+sxPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777927113; x=1778531913;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n47CV2uz5VDGGoNyqC8BTcwhD0wbhupurmRzuE0ZoTU=;
 b=KZjfXu3vhBGiv8tbNn+oXuSzUfAnpyYWb6sBODOK1qs4sH5my3lZM0QSTcevVeA/jU
 ziVtabfnIMHYXr/ZaFPJrZzpLDRpxSPPrYgjoTutetfRai0x868u71ahoMpkkr4cx2ox
 /5C040hevLKavSXpvISld6i8h1fR4STZoihDzsEkiOjuPk012VkSb3IqWf254PVM4rfV
 MiMg6xQO/xIvzyFB3TMAWPgotlReWBR7rlPaDGzLYQ5BLvDNU/0QpPttaXinSm1+rbOZ
 4v9ME/NT2sz0eQCG64/IyrO7xYfjqsQGk7KKl2ayu2ZuGQlCsZTTpx1oWGh7UJzwYG3Q
 SWlg==
X-Gm-Message-State: AOJu0YzET8EhAo/1gusLQhaWBZeQ6QCGddSG6wJXTsRisW3pySDVy4Tv
 QovK4/y1QzsihRi/PdOQyCtkYqPFad2636F2YpERiZ3LlpjYeV3FOvlJjKblW2XDwAQUwB1Fo2O
 ohUKQJQTNMNCItRaXwRTYUUq8lqCuq7Dnty8YKvyZ
X-Gm-Gg: AeBDieu2FeHJN+7cV7k/ht3N3YTWXhd4yVwiCIXw96cr91NrD8xKeyo6PP7b5VFAxmS
 Zai4YqqXVSW5wIOeZ2bMFuFF1LjP0v8uQowb3hKneV60n33yjNPGROz3n9Q54R8OupDvjJP831h
 fUbj7PdVeuyVXOK14qQOkVGgG6PyVNF3Vb8u/JzqraAVYqfYJuRzy8h1hlqbXY701jA+a4tyGyR
 7ks0P6zJYIvqpy2COiBIYqyMNtCKGAsrgQveKBD6nt6RqnJSJFlcZ8QbzdBPwSsUQz7X+jH3r/t
 Zq70310e1Z3v6ob6
X-Received: by 2002:a17:907:ea5:b0:ba7:3578:f627 with SMTP id
 a640c23a62f3a-bbffbf77a93mr615951566b.37.1777927112661; Mon, 04 May 2026
 13:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-17-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-17-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:38:20 -0600
X-Gm-Features: AVHnY4KcopQVZbpQR8pTizOTEIhuYSmwr2O6hFEV642FzubjJ3v4QPNpqrdLNrE
Message-ID: <CAFLszTj43X2y5xnr50HSqdHtmR62BcMOLYdW9FLNdumpk2h0ZA@mail.gmail.com>
Subject: Re: [PATCH RFC next 17/18] scripts/Makefile.build: do not run
 kernel-docs with warnings
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> scripts/Makefile.build: do not run kernel-docs with warnings
>
> We have too many of them for now and the kernel has switched to a Python
> script with likely many other small changes. We also have a couple of
> patches in our fork, so it'll need to be ported to the new version once
> sync'ed.
>
> For now, let's simply not run kernel-docs with warnings, which allows us
> to use W=e to enable Werror for host and target compilers as well as the
> linker and assembler. This will then be used in buildman in next commit.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> scripts/Makefile.build | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> @@ -127,7 +127,10 @@ else ifeq ($(KBUILD_CHECKSRC),2)
>  endif
>
>  ifneq ($(KBUILD_EXTRA_WARN),)
> -  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $<
> +  # U-Boot: Too many warnings in our docs and this prevents us from using the
> +  # very convenient W=e to configure -Werror via a Make variable, so silence it
> +  # for now.
> +  # cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $<
>  endif

Reviewed-by: Simon Glass <sjg@chromium.org>
