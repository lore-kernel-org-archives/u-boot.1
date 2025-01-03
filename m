Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BDAE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 01:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D59A1802EF;
	Fri,  3 Jan 2025 02:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GH2n8FWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87CA0803A9; Fri,  3 Jan 2025 02:41:19 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7316180196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 02:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso2016402266b.1
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 17:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735868477; x=1736473277; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xPgFD/4QgLqEShJVuI6Zj5R53NQsC7NEwfnt7fUDMu0=;
 b=GH2n8FWIXRQ/j05IkwnMXgtYdZssQTYXRvl7CxCUOjFXbP7A50VDJ3iiO3QIX8T2kz
 gXtZiK87Xi0P+ioUDCyNSKP0N/dlh2Bs+xQJMRtncH+9uc997KXSOcTKtEtI98Yv8Pdw
 6OO9yJto13xpBeynwcXjVW1VxpvCF8GtdlngU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735868477; x=1736473277;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xPgFD/4QgLqEShJVuI6Zj5R53NQsC7NEwfnt7fUDMu0=;
 b=KVVNQ+7oDNTOV03WG9XWdqxg6UoNAFor+2gLaqjA1AvU2Ce9ytpaFmcmOaeYXpJvi5
 x6dHJi+Y2RH1eIHR5IT8xDMBbU6jPkTXjd7bwkhbHiUX6uf+2kf2KQcxCbRXHGyoCsnC
 yzo5ReRcAjoBvhDD48LQenPClK9HvZvXyRqrRR6RdflnyO7J5d1xshDjoGDz/NnWDlNp
 uhpFwAI75Qka9COnfqCKabX1jrsWRToT+tOgsfP6ePIdQBuNX4j08Kz68E0WWP/m3HFN
 OuUmIgbfyD11JJD1BnIP04jqbwg/dsKI++i++bYq3gKPPXB8GaXd5cbljGd9En4QAPDm
 Rqgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp4pC4Pv7akGCuJRc5KinW2yUNdZ990NYvNBINN4obMHhrBGJ/9a0zF6gMpJbFCMb3p+c7hFQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyvwyoZUYhxFFr+P+st45a4rVX9yKI/+82py6sDrwZO4n7TK3K3
 qVizGlURklBaLNzyX/I5SzY7ooP8F3rBP7a99qoXSlfPlKaIiHKO6uy8wX1TjVWVGEe7oK2xML+
 jhe6WG2FE7qhOlXXtrkBCiyRiAyf2UhhL+bP2ekj347l6S4M=
X-Gm-Gg: ASbGncsrwWJcH6kJ6M/iJHTwZKOdz8Fo7LmiolxTqrSFfz6Lu87a9q6d49AjAgNVASg
 4X74U7JklU3dBC8BWRtTr3NB4SXn9EkDbrAPzQfaJ
X-Google-Smtp-Source: AGHT+IHgZYfXRFHKvut4XMC2jruk60saoP63IwfNfmm8q0RxOhQaJoFRpi3XKbR14oQhpEG3udnfRC+rfnJDY8x6vi0=
X-Received: by 2002:a17:907:2cc5:b0:aa6:96be:2bed with SMTP id
 a640c23a62f3a-aac3378cbd9mr3693571766b.59.1735868476897; Thu, 02 Jan 2025
 17:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20241220035927.3243648-1-sjg@chromium.org>
 <85929b02-3250-4260-8838-4d90e807ccdb@gmx.de>
In-Reply-To: <85929b02-3250-4260-8838-4d90e807ccdb@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Jan 2025 14:41:05 +1300
Message-ID: <CAFLszThXX=Hu3mOVKSpWTAM6H+GMvA6oqFJqagvpgt++wR2KGA@mail.gmail.com>
Subject: Re: [PATCH] sandbox: Adjust configuration to hang on panic()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 2 Jan 2025 at 00:32, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/20/24 04:59, Simon Glass wrote:
> > It is annoying to have sandbox enter a boot loop when an assertion
> > fails. Hang instead, since then the error message is only printed once
> > and Ctrl-C can be used to quit, as per normal.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   configs/sandbox_defconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> > index 3de4aa79c6d..636130a360d 100644
> > --- a/configs/sandbox_defconfig
> > +++ b/configs/sandbox_defconfig
> > @@ -354,6 +354,7 @@ CONFIG_WDT_FTWDT010=y
> >   CONFIG_FS_CBFS=y
> >   CONFIG_FS_CRAMFS=y
> >   CONFIG_ADDR_MAP=y
> > +CONFIG_PANIC_HANG=y
>
> Command line option -S is used for running the UEFI SCT. We need the
> sandbox to reboot and to allow the SCT to report the failed test.

What is causing it to panic in this case?

>
> This patch is not needed. You can already exit the assertion caused loop
> with CTRL-C.

Right, but this creates a continuous stream of output.

I suppose we could add a command-line flag to reboot on panic, but I
would like to understand the mechanism.

Can you please add something to doc/ about how to run this with
sandbox, including which build/commit of EDK2 works on x86_64? I was
never quite able to get this running with sandbox.

>
> >   CONFIG_CMD_DHRYSTONE=y
> >   CONFIG_MBEDTLS_LIB=y
> >   CONFIG_ECDSA=y
>

Regards,
Simon
