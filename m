Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E93E71068
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 12:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AACC86660;
	Thu, 21 Sep 2023 14:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XiGEObiE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C83086679; Thu, 21 Sep 2023 14:52:32 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E9286484
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 14:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9a58dbd5daeso112126066b.2
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695300749; x=1695905549; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eQkAFIqCSDo1Mm/ljjpZwAbp5fPJXf5Z9eYl1/g2yyg=;
 b=XiGEObiE0ApZdlmQIIv/AwacSySWAWjUMI8pJGErYHif0oJH2fzLiToir7lU24Kr+r
 su1/bX4nFL8Z1ZZ3Rdeu9gJPmukNthi7GwVaCjUAMJ5jP+vlsd1UZudhxMchxsilopGt
 Lq6gnvfPYGZMBOhAGy8WnylQPOPD+kxX1ARHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695300749; x=1695905549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eQkAFIqCSDo1Mm/ljjpZwAbp5fPJXf5Z9eYl1/g2yyg=;
 b=bmcZGvvSY6J9+PJMJdJfPi+PgcowH5N2/xoOgXbHIQoZl+UOcf2WKoBriQ/38hbtZC
 0VwiUu8xP9GnSt929DLwIC/N80UmH6ZDJwWvy//UNcyvJCeM9asSloxXRaNjtKdmPJrD
 vjQkGbF7ghnRtYawwdHUsyVtUHPH8ffk0crb67xjN+wWEPt0eVH4HsPPIZNnKTVuNspO
 VUc7pD6mqwoVSwIVm7R529fo7ynXizDMVZRp4W7La8YoS8tB/tKLyocsG4+cj0u+M2Bk
 EiSKbBvlD5wAmw24Qn2Tj1r6Cj+Cpayk8yV2TwJot7zP540OLjvyldEgVRV2mhuNTagh
 0ASA==
X-Gm-Message-State: AOJu0YwjC6eA5h7LCRpTcoOYalSMXq+UqeRzFBBQc4u+QGRFFwRMMdlT
 SKnrrxQEj8DyennFEG6aNurPj357YaPC1zudP2NhZQ==
X-Google-Smtp-Source: AGHT+IGpg1G3z+f3goxyIdKfv+IIRvQ+1noSGmDIaNx2cMpuRgeomHGM5JNLgcwU+2MOX/GTwrcoPSrnQXX4HS12pko=
X-Received: by 2002:a17:906:5357:b0:9ae:3cdc:bd4a with SMTP id
 j23-20020a170906535700b009ae3cdcbd4amr5258633ejo.68.1695300749337; Thu, 21
 Sep 2023 05:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230920030027.1385833-1-sjg@chromium.org>
 <CAEUhbmWc9us8HnNAVTsbdAQ_ykkOQxDnB1LwLFCzFR1-2opHHg@mail.gmail.com>
 <CAEUhbmVHNoV8J2CuOa05AqVyECQfuMp=8=xpSQsJbfhR653rnQ@mail.gmail.com>
In-Reply-To: <CAEUhbmVHNoV8J2CuOa05AqVyECQfuMp=8=xpSQsJbfhR653rnQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 Sep 2023 06:52:11 -0600
Message-ID: <CAPnjgZ1mGphwpEYiChdEdjPcTjUq9zprOtM6pYr7cpPNazZfaw@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] x86: efi: Fixes and improvements for coreboot
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Bin,

On Thu, 21 Sept 2023 at 00:31, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Thu, Sep 21, 2023 at 1:27=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wro=
te:
> >
> > Hi Simon,
> >
> > On Wed, Sep 20, 2023 at 11:00=E2=80=AFAM Simon Glass <sjg@chromium.org>=
 wrote:
> > >
> > > This little series fixes various bugs and annoyances in coreboot and
> > > coreboot64.
> > >
> > > With this both coreboot and coreboot64 start up and work reasonably w=
ell
> > > on Brya (x86 Chromebook) and U-Boot can boot common Linux distros.
> > >
> > > - Make coreboot64 debug UART start reliably
> > > - Avoid the long USB-init delay on startup
> > > - Correct the timer speed on coreboo64
> > > - Fix a bootstd cros bug (will likely be squashed into another patch)
> > > - Fix the terribly slow console scrolling
> > >
> > > With v2 I have also brought in some lost x86 patches so they are all =
in
> > > one series.
> > >
> > > Changes in v5:
> > > - Use 'lzma' instead of 'LZMA'
> > > - Drop unwanted space
> > > - Correct 'teechnique' typo in commit message
> > > - Make use of the uSE_PREBOOT mechanism
> > >
> > > Changes in v4:
> > > - Fix arm and riscv
> > > - Rewrite this to use events instead
> > >
> > > Changes in v3:
> > > - Allow SMBIOS if EFI_LOADER is enabled
> > > - Reword the help
> > > - Use log_debug() to show the message
> > > - Squash in the next patch
> > >
> > > Changes in v2:
> > > - Update the malloc size too
> > > - Add new patch
> > > - Add new patch
> > > - Add new patch
> > > - Add new patch
> > > - Add new patch
> > > - Add new patch
> > > - Add new patch
> > > - Add new patch
> > > - Add new patch
> > >
> > > Simon Glass (20):
> > >   x86: coreboot: Add IDE and SATA
> > >   x86: coreboot: Enable standard boot
> > >   x86: coreboot: Rearrange arch_cpu_init()
> > >   x86: Set the CPU vendor in SPL
> > >   x86: Allow APCI in SPL
> > >   x86: coreboot: Look for DBG2 UART in SPL too
> > >   x86: coreboot: Enable CONFIG_SYS_NS16550_MEM32
> > >   x86: coreboot: Drop USB init on startup
> > >   x86: coreboot: Align options between coreboot and coreboot64
> > >   x86: coreboot: Enable VIDEO_COPY
> > >   efi: x86: Correct the condition for installing ACPI tables
> > >   x86: smbios: Add a Kconfig indicating SMBIOS-table presence
> > >   bootstd: Keep track of use of usb stop
> > >   Record the position of the SMBIOS tables
> > >   efi: Use the installed SMBIOS tables
> > >   x86: coreboot: Record the position of the SMBIOS tables
> > >   x86: doc: Move into its own directory
> > >   x86: doc: Update summaries and add links
> > >   x86: doc: Split out manual booting into its own file
> > >   x86: doc: coreboot: Mention 64-bit Linux distros
> > >
> >
> > Patch #8 needs to respin to address PREBOOT comment
> > Path#18 does not apply.
> >
> > Patch#13, 15 v6 version are applied.
> >
> > Reset patches in this series are applied to u-boot-x86/next, thanks!
>
> The CI still fails on u-boot-x86/next which is already rebased on origin/=
next.
> https://source.denx.de/u-boot/custodians/u-boot-x86/-/pipelines/17784

OK, I found the problem. I will include a fixup patch in v7.

Regards,
Simon
