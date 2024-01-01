Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78850C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 00:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A54F28785E;
	Mon,  1 Jan 2024 01:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A+MRSHML";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 479E58785D; Mon,  1 Jan 2024 01:37:53 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EE9987786
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 01:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-78104f6f692so642154685a.1
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704069469; x=1704674269; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdRzxw2IqNCdNyj1Kjb1rHEaVem8fObQXFy+Ee+Z/ro=;
 b=A+MRSHML/CH8qBoj56ro20ukXTUWBQbg/7vXh10SOHE+4WI6CzGeWEw84JbzKGtdJt
 lJS12ADy4/w3pGnOFqyjz3k5Dl3lbH3Ey79Y+TMuT9H7Vuv/Fo4PvgjlD0eFc0Rz3vA2
 RHkA/JOkJHn+YGmN44W9qKnSoukiBrU/OWp5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704069469; x=1704674269;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdRzxw2IqNCdNyj1Kjb1rHEaVem8fObQXFy+Ee+Z/ro=;
 b=HzygCgDORIvo3EvevEj9TK+WuVXN1Is4C9Agnsq4STAq3II0J0WNMWBG/aGTIBESJq
 wBBQQh8s5gofDczC1hsBCsGWHXtC8bhQxa3sw8FylykgzogTT+7fjO0/7npCWos8gtZD
 Fay7DxbQP8VlLg0NgITSJG4HeteKc2GJfSPvMh3x72XgxXG0s6QWdA+48K8v5/lfr1Iz
 ZCcW8NCc69WBS26xUfcDyCNHjNyBM1fudHWtogCnT47V8O/dgN/lRteoMj2I0RKCkwwf
 PMUDx2b7OY2xG/Os/5q+05V3uuBBM2I6GF8grDXm3NDezQbV/M2PfsdlJNuoT4K9zjf2
 zfkw==
X-Gm-Message-State: AOJu0YzxkXtJzGW3rxhFTX22XgL1RzvH6gVF2zkVWrad0l9nQi/hREGf
 Df3jH7+Z+/jnhoTqJL2j0Tr5322Jdrbjp99Bclp/Qu7nmPAf
X-Google-Smtp-Source: AGHT+IHSZHMryvY3egHjoC2eb0O5ND5Q1mTgEpkCh1TbZsRD9IJ9y7iflwe8gPQWNyiP85Nzv6prbwUui9BOdvVzdoc=
X-Received: by 2002:a05:620a:4952:b0:77f:289c:bb05 with SMTP id
 vz18-20020a05620a495200b0077f289cbb05mr22594628qkn.75.1704069469591; Sun, 31
 Dec 2023 16:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20231231152555.464874-1-sjg@chromium.org>
 <4683F3D9-7D61-4D26-B1F2-3DB07D009AE1@gmx.de>
 <54057bef-4466-43cb-a832-4b904f03b559@gmx.de>
In-Reply-To: <54057bef-4466-43cb-a832-4b904f03b559@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 17:37:39 -0700
Message-ID: <CAFLszTj0Ef1VQMA2nc7xN4i8hyZbkLVZ+gMyybSPKOcjfpy14A@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] smbios: Deal with tables beyond 4GB
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Igor Prusov <ivprusov@salutedevices.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Troy Kisky <troykiskyboundary@gmail.com>
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

Hi Heinrich,

On Sun, Dec 31, 2023 at 9:07=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 12/31/23 16:56, Heinrich Schuchardt wrote:
> >
> >
> > Am 31. Dezember 2023 16:25:43 MEZ schrieb Simon Glass <sjg@chromium.org=
>:
> >> When the malloc() region extends beyond 4GB on ARM we may end up with
> >> an SMBIOS table in that region.
> >>
> >> Add support for writing an SMBIOS3 table, which supports a 64-bit
> >> address.
> >>
> >> Note that this problem does not happen on x86 since it requires the
> >> tables to be placed just below 1MB in memory, unless
> >> CONFIG_BLOBLIST_TABLES is enabled.
> >
> > The ACPI specification only requires that a low memory RSDP exists on n=
on-UEFI x86 systems.
> >
> > Nothing stops us from copying the RSDP only to low memory when not boot=
ing via EFI. Maybe that way we could have more common code. But this is bey=
ond the scope of this series.
> >
>
> Same is true for the SMBIOS anchor. You could have all tables in high
> memory and only copy the anchor to low memory when booting non-UEFI x86.

Yes, that's right...do you think it is worth mentioning that, though?

[..]

Regards,
Simon
