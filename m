Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42650C47074
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 14:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0191E878F4;
	Tue,  2 Jan 2024 15:06:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E8NxVy/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8651187834; Tue,  2 Jan 2024 15:06:48 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C20D8783D
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 15:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-67f85fe5632so68681946d6.0
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 06:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704204405; x=1704809205; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rx7y/MjYOoZlRc6zUP3oQqp/74TRCkyTXWoGqDG9/4=;
 b=E8NxVy/GSg+lVeftTU2rOrL+mfJNDiQsm0X41KCtGLx4uDt8ay2+gKTk7l0xxlaHEF
 sB2WaZH+RsK0mE4gQ2FMYNV6JNXMh0nGye1Xfoy5ITQWRhsIq/x/qv1yphN9adPnyQZ5
 ZEi2eAZF/rOZcG4/HcaCAR0RmFUlCr3zElY2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704204405; x=1704809205;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rx7y/MjYOoZlRc6zUP3oQqp/74TRCkyTXWoGqDG9/4=;
 b=HqlpHbXQY2rgg/4Nqj1yDEeWrtLuMCoPsUVdlvG8KWkc5R7qcyVA1YxHTdOf+CVxG0
 QrI99s9bvRZUm75S2vS8NXXhDCbaxGUYVSTgGRetDdp2T6ZKeTEB0YU2dSBEH/t9PjCd
 1OzpVNmDYTOlvDhdtiNDOz4tAs0P8uB/E8kxySDcSqRbvUVn7avDhqnwzC3owug9U42D
 hcpJlfr9v8tqNxd9XTMWm5PGAJ/ElpuxFKxn3LEC4VZ9xQC91eNKauguZhvSy+RCM5jn
 okbFmk7USlMVQl8bXC1mpr0MZvNPD+QgZR/oXII6QDLZ/eDGW/gKmQxBmJd83v41ywDc
 XGfg==
X-Gm-Message-State: AOJu0YwKOudg2hMJrGN3r5uFy+QP/DMLYuAXUkFLSqslOGn8zZwYFNxa
 NNKQ8KxyFBY2Avp4Qzd+dEteNfsI4KuGQ+HUdPo5DxlIUw0L
X-Google-Smtp-Source: AGHT+IF4KhHEy9iXP9p9W4ICeJv95qvcO+1vv7fWjiLAixsrqiXfkT/zEZJHaQoIvi4CXxOr/PRa61/JqHUYmEPBZdc=
X-Received: by 2002:a05:6214:2b06:b0:67f:2bf8:28ad with SMTP id
 jx6-20020a0562142b0600b0067f2bf828admr28391727qvb.12.1704204405242; Tue, 02
 Jan 2024 06:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20240101185004.268790-1-heinrich.schuchardt@canonical.com>
 <20240101185004.268790-3-heinrich.schuchardt@canonical.com>
 <CAFLszTiH6awH9jt514b0Tod-dB0jigYa3vo2gtTRxZHRk2nNkw@mail.gmail.com>
 <c2f78de7-9dc7-47f2-a3f7-3ce84917ac99@canonical.com>
In-Reply-To: <c2f78de7-9dc7-47f2-a3f7-3ce84917ac99@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jan 2024 07:06:34 -0700
Message-ID: <CAFLszTgdkgDM-uM+iWyLMoe+2qWEybotyCdvC6YEAxyuvp=sQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi_loader: provide tool to dump SMBIOS table
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Mon, Jan 1, 2024 at 4:23=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 1/1/24 23:41, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, Jan 1, 2024 at 11:50=E2=80=AFAM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> An EFI binary dmidump.efi is provided that can be used to check the SM=
BIOS
> >> table for consistency and to dump it as a file.
> >>
> >> The tool provides the following commands:
> >>
> >> check
> >>      Check the SMBIOS table for consistency.
> >>
> >> exit
> >>      Leave the tool.
> >>
> >> help
> >>      Show available commands.
> >>
> >> save
> >>      Save the SMBIOS table to a file on the EFI system partition. The =
file
> >>      can be further analyzed with the dmidecode command line tool::
> >>
> >>          dmidecode --from-dump <filename>
> >>
> >> Specifying 'nocolor' as load option data suppresses colored output and
> >> clearing of the screen.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >> v2:
> >>          fix an incorrect variable usage when checking the result of m=
emcmp
> >> ---
> >>   lib/efi_loader/Makefile  |   7 +
> >>   lib/efi_loader/dmidump.c | 595 +++++++++++++++++++++++++++++++++++++=
++
> >>   2 files changed, 602 insertions(+)
> >>   create mode 100644 lib/efi_loader/dmidump.c
> >
> > Does this tool need tests?
>
> Once we have all the SMBIOS stuff in, we could use the tool in a test to
> verify that the SMBIOS tables are correctly installed.

Yes that is useful for the EFI side of things, along with your new
test for smbios within U-Boot.

>
> >
> > Can you please split up do_save() a bit and also move the command loop
> > into its own function? Otherwise it looks good to me.
> >
> >>
> >> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> >> index 24d33d5409..71880d330e 100644
> >> --- a/lib/efi_loader/Makefile
> >> +++ b/lib/efi_loader/Makefile
> >> @@ -16,6 +16,8 @@ CFLAGS_boothart.o :=3D $(CFLAGS_EFI) -Os -ffreestand=
ing
> >>   CFLAGS_REMOVE_boothart.o :=3D $(CFLAGS_NON_EFI)
> >>   CFLAGS_helloworld.o :=3D $(CFLAGS_EFI) -Os -ffreestanding
> >>   CFLAGS_REMOVE_helloworld.o :=3D $(CFLAGS_NON_EFI)
> >> +CFLAGS_dmidump.o :=3D $(CFLAGS_EFI) -Os -ffreestanding
> >> +CFLAGS_REMOVE_dmidump.o :=3D $(CFLAGS_NON_EFI)
> >>   CFLAGS_dtbdump.o :=3D $(CFLAGS_EFI) -Os -ffreestanding
> >>   CFLAGS_REMOVE_dtbdump.o :=3D $(CFLAGS_NON_EFI)
> >>   CFLAGS_initrddump.o :=3D $(CFLAGS_EFI) -Os -ffreestanding
> >
> > Is there a way to have a list of these tools such that the flags stuff
> > is done automatically and doesn't need to be repeated each time?
>
> Looking at
>
> scripts/Makefile.lib:102:
> _c_flags =3D $(filter-out $(CFLAGS_REMOVE_$(basetarget).o), $(orig_c_flag=
s))
>
> this is not possible.

Not with that rule, but perhaps another could be added. Anyway, I
suppose we can put up with it for now.

>
> >
> >> @@ -31,6 +33,11 @@ always +=3D helloworld.efi
> >>   targets +=3D helloworld.o
> >>   endif
> >>
> >> +ifneq ($(CONFIG_GENERATE_SMBIOS_TABLE),)
> >> +always +=3D dmidump.efi
> >> +targets +=3D dmidump.o
> >
> > How about smbios_tool ? I think 'dmi' is a bit of an obfuscation.
>
> We can call it smbiosdump.efi.

Yes that is better.


>
> Thanks for reviewing.
>
> Best regards
>
> Heinrich
>
> >
> >> +endif
> >> +
> >>   ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
> >>   always +=3D dtbdump.efi
> >>   targets +=3D dtbdump.o
> >
> > [..]

Regards,
Simon
