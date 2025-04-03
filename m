Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17A2C3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 12:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6045B82163;
	Thu,  3 Apr 2025 14:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NemiICzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34E0381F69; Thu,  3 Apr 2025 10:59:48 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A015B81CF0
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 10:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bjorn@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5821F5C3AD7
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 08:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B09C4CEF7
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 08:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743670784;
 bh=f/PyVXr1+GDvPS0pvipsrQtUvxshHgiZc9S5OfegtaM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=NemiICzKp7Yc8Y0+V4Sh7RzpHLsQ5v+zmbILYSdjSmacWYfvssgoEPr1T/Hggo3Qo
 xH5qMUEWAvv11QJtYWjrlyNlxfsZ1X5SidbINy06ccjegArS8nWt7IbtxlD/qmyFu3
 Ly6wNZ1SfxhQXArWRyI4nDUOOgX0hFIApyPlKNVzbdC2M0fjD67F24ayfq1a9Qy+I7
 9KwiGSNtWPTq4m3uo+FD/vo6fuKmOQZvLHlieLXk5laSUgpBniGsirn9Px2DBssF1W
 bTbIyYkgrh3aqU2sbK8mB6rbtgQVDwaaXIOrJpIwq0G88M7O9ni4nXSP3mOwRsXOoB
 wMo7t5o0NzECA==
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-476ae781d21so5868801cf.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 01:59:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXOs79/1ceMtAh+U6SxaVZmN5rzUvqAMoUd/GCZkWCZXPDCNNRLb1ZppUlIXOxhp6nvDFbedEU=@lists.denx.de
X-Gm-Message-State: AOJu0Yyr3RiSAKcWsmq7qfwgWNUx75XXgH15xRe6XIwEUdw75gj5V1SS
 jH19mLF4uT+DmHqJPLVpxooR5hX5pzZ2yp0jnLT9kEYQXGbqIjZT3Q2I5+UTbRFdEUykF2yGYxb
 wG6rue1Qd+dmDzPLO9N5p35eAsFU=
X-Google-Smtp-Source: AGHT+IE1o7HbSdB9pBljTshr0IrQIrCSdJkoHrirfOJLH0fMpJ9sjXqAEz5DqgUs3aaVwaNVnwPaxBmLmq2hE5bP12Y=
X-Received: by 2002:a05:622a:110b:b0:476:980c:10a8 with SMTP id
 d75a77b69052e-479192d0b30mr27332061cf.21.1743670781957; Thu, 03 Apr 2025
 01:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250403053444.2551339-1-ilias.apalodimas@linaro.org>
 <CAC_iWjLTUgocaxOPDtQCGS==yjV=66_=37nFv-Grv6b32FNDYA@mail.gmail.com>
 <e23ce969-3cd6-4bdf-9119-d0175806ecd1@gmx.de>
 <CAC_iWjJ56Et24FUcVn38t_hAWDFe-Q=NLxEfgpLk_WmGbgDKOg@mail.gmail.com>
In-Reply-To: <CAC_iWjJ56Et24FUcVn38t_hAWDFe-Q=NLxEfgpLk_WmGbgDKOg@mail.gmail.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Thu, 3 Apr 2025 10:59:30 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNgL8r=B1PQCfg=sH_56Qxvm0v3o_J-0bLarDeZN8azLKQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqfGmgvEEKzRbymhnjiyscl9KIH7Sa9OZpGUoTiAMBrWb9azc_qazzpFso
Message-ID: <CAJ+HfNgL8r=B1PQCfg=sH_56Qxvm0v3o_J-0bLarDeZN8azLKQ@mail.gmail.com>
Subject: Re: [PATCH] acpi: Fix table length for QEMU
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 03 Apr 2025 14:36:19 +0200
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

On Thu, 3 Apr 2025 at 09:02, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 3 Apr 2025 at 09:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wro=
te:
> >
> > On 4/3/25 07:53, Ilias Apalodimas wrote:
> > > On Thu, 3 Apr 2025 at 08:34, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > >>
> > >> The end of the ACPI table is set to 'addr' instead of 'end'. The ACP=
I
> > >> code for QEMU relies on those values to mark memory as 'ACPI Reclaim=
'
> > >> and as a result the ACPI RSDP ends up in Boot services Data.
> > >>
> > >> Reported-by: bjorn@kernel.org
> > >
> > > I obviously messed up my reported-by...
> >
> > Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

With this patch applied to 2025.04-rc5:

  | ...
  | efi:   0x00047eed1000-0x00047eed1fff [ACPI Reclaim|   |  |  |  |
|  |  |  |  |  |   |WB|  |  |  ]
  | ...
  | ACPI: RSDP 0x000000047EED1000 000024 (v02 BOCHS )
  | ...

...and I can successfully kexec. ;-) Thank you!

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
