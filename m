Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B264ECD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 09:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DC7F88A02;
	Mon,  2 Sep 2024 11:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Soszx/q0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E5E888A12; Mon,  2 Sep 2024 11:09:46 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8FFA889A2
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 11:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6c3f1939d12so33817317b3.2
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 02:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725268182; x=1725872982; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k4l8/wb9COMMs0FwiqXjaZklafBYYnm9X3i56mk8+kQ=;
 b=Soszx/q0HoeIQL6CRVdU3qaG7BjQ96XCI+8iQ0tWzZpJExb7JFzFOt9oVhpXHJ3EFe
 imJLMGL/bvntzTUOmLb/vysN1+GKZw60SKcQjg5X4Vb24zSDGFNm83+75ZVud/C9fTbw
 F8VxIIAzo8PMIFqL2uc36TbwReHfm9qbcO3hriWA4icc1aDV1eb4emMAsFtWqmttTjIF
 6RbdnYXf1QwbGbYJpjgo6v1XVpF1+Of6DKKJ+ryuHqNLXmRWSMHyly5tBQRhcQKzBCkY
 5fwHQt4N67Hf/RW6jV2mBo8TJTLR43V9pFssyOgG2NTrIxI/u967ESDtPUp+ORF/gFm1
 wE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725268182; x=1725872982;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k4l8/wb9COMMs0FwiqXjaZklafBYYnm9X3i56mk8+kQ=;
 b=WX9IpVDEoyTb+VKPQ9Ohh8PJZDIe+0eg+jLmzHMS76aReDMmGIO6+aAzH/vqWvbSNG
 3QPrlP++LQ38pgpgZrhnYUPOeatgA9qdxXhC5FBcoiqNfeJHKnOQnCq+G3xCTp9Sj7NE
 qfdeOMBOqppSt5DqV0gqnejro66trMBMnpOClO01/N/fBxTu39O4SW4TG5aLDnYZbXvT
 pCthll8ixJd/L7YNty7LUiJeMsceHd5/ssWw9DJhw6OvpYyIHN+466wto1ckjSmQAThG
 lpHBmfI4zoV4WSKKPRZFysozxpLEn9pYXN9sTfjdR86BMd7PTq+Fbi/eRA+oWo7X+jMN
 bPUw==
X-Gm-Message-State: AOJu0YzwUe4OyJ5Sma0XYulLHCacg5vRD4N+vSi3adAhP/90Nr+TuHN4
 Y0uYk6ue+XUCgTFfn4xHsGFNn7zygAZ/D/aM++YzpcA4a9YgkomqtQ4NENM4jNavsWsYQkgEZsG
 fIJrLTKZpysVx6oxn3Gmzikb8xXLjj2CNwPJQzg==
X-Google-Smtp-Source: AGHT+IGteoJygKcNErq1P4+kncPvP/JuKfE2Q7DPvt4oZZK1Jgk4ovTEPz0K0mbpjKS+FuH2ZOPaB0mHYBTSSEf95Ck=
X-Received: by 2002:a05:690c:660b:b0:6be:28ab:d873 with SMTP id
 00721157ae682-6d40d88b9e1mr118185837b3.2.1725268182505; Mon, 02 Sep 2024
 02:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-3-patrick.rudolph@9elements.com>
 <CAFLszTiCvvrp-PcVRsA3A=odKN9-zJCPuAG7O+c=gBtBg4Hxhw@mail.gmail.com>
In-Reply-To: <CAFLszTiCvvrp-PcVRsA3A=odKN9-zJCPuAG7O+c=gBtBg4Hxhw@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Mon, 2 Sep 2024 11:09:31 +0200
Message-ID: <CALNFmy0fBD3G6xqpp6QAF4iiko0wErL8ndWL5iyrnWXZBrW+nQ@mail.gmail.com>
Subject: Re: [PATCH 02/17] acpi: x86: Write FADT in common code
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com, 
 trini@konsulko.com, bmeng.cn@gmail.com, 
 Maximilian Brune <maximilian.brune@9elements.com>
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

On Mon, Jul 29, 2024 at 5:28=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Patrick,
>
> On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > From: Maximilian Brune <maximilian.brune@9elements.com>
> >
> > Write the FADT in common code since it's used on all architectures.
> > Let the cpu code fill out the FADT body by introducing a new weak
> > function acpi_fill_fadt().
>
> This should be done using the acpi_ops struct...i.e. add a new
> operation which fills allows a CPU driver to fill out the CPU info.
>
Which of the fields in FADT are related to the CPU driver?
Some fields like "preferred_pm_profile", "iapc_boot_arch" and "flags"
seem to be board specific.
How would the board specific code integrate into the acpi_ops?
As far as I understand there are no drivers for "mainboard class" devices.

> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >  arch/x86/cpu/apollolake/acpi.c    | 20 +++------------
> >  arch/x86/cpu/baytrail/acpi.c      | 17 +------------
> >  arch/x86/cpu/quark/acpi.c         | 19 +-------------
> >  arch/x86/cpu/tangier/acpi.c       | 25 ++----------------
> >  arch/x86/include/asm/acpi_table.h | 12 ---------
> >  arch/x86/lib/acpi_table.c         | 23 -----------------
> >  include/acpi/acpi_table.h         |  9 +++++++
> >  lib/acpi/acpi_table.c             | 42 +++++++++++++++++++++++++++++++
> >  8 files changed, 59 insertions(+), 108 deletions(-)
>
> Regards,
> Simon
