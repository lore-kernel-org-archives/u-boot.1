Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D32C2BA1A
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 19:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 722F288263;
	Tue, 18 Jun 2024 21:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="RX0iN0+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8ECF8824C; Tue, 18 Jun 2024 21:30:35 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E9A088335
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 21:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57cc1c00b97so4798402a12.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 12:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1718739032; x=1719343832; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/XfflaiLyYA9UdlLnkp0NFE4WAAXpIQfkWiHn7XGC0=;
 b=RX0iN0+6mF9OX1TPBZOYqvYwqNyv5DB04CGpD7B+sYPOjCK61SIWmFcLOY6JlweTBY
 VHGj3xYq6Wf3fLMX9WxdxibAySSQ3Vjbt6ZpYfmnjl3eQcacbpAc6jMua4CY7IOGbNGr
 N/tTXZZczNgixIPI9Q2HBojj+lrTajJREAv3fDbqwgMsT/XKg0xnZaz6EZMa/Im/ZLTo
 OKQ7QXUqWZuVzrw1PvDtsu24m4GYxedg3YRA0+2m3LMhE636rHiOhexFf2NcZUiCbRzY
 XJc35FGL47lyeytPSfg3kGc5wksW0wOL44qPsnl0fzAwSyi4nrlxjpFZrWkde6LWIq8E
 gNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718739032; x=1719343832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b/XfflaiLyYA9UdlLnkp0NFE4WAAXpIQfkWiHn7XGC0=;
 b=grfJDEqKt5a/z4KqMy6HXVMJ25J/MErgf6OvcHFl7Hy3j/9sWqrhC38JIzCpVXxhHs
 nQQFSyj+ZuFOB2AdPo/4f6/pbNVMgSEZg8jKpCB1IkQUGNFKGcSCrM9Cm15kwxL73Q3E
 lbY6IXiubi6WkfQVtPPHEsdCtIse+e1AkwLKCsipgldhNkvuo6fr2wcOdYmVZTTY0Eqf
 jo+JxetsUjqdu315Cb4FBVj4cdBJz/w8FMLN/sM5zkomVHOTjjMSZBWS2TEfN/1UXK7I
 hBqCPf3WYTqNoDSvT1d4mVVPV2TdF3OdzlWI7fXowkr3Klrc4U7UhXybimAct345ZM+K
 irRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX38xU5+iuuKCPQOZJdZgwCHrCQyrHyIZ8gbBlpjLCYPlZ9bEjRMhN0UsgqFj9JHG22WpROvbGJamzCsLAGb8DtUpi6iQ==
X-Gm-Message-State: AOJu0Yz0jlTwUmAz+FRh+cp6oXm3lpeGOw4mZtGeb1X2mddW6J0IMxcU
 5asFP/3stjwjQLTHg38w+TGoI3xgzsCDxwo4dQtBHVCE4cF+2uk4OiuNhCbz8DodoJDUWNPaVc+
 D5sfLdwy2tbOhgP2UXNRmb+psuMkARjCPuKVpEzUKwiISYrqwFzY=
X-Google-Smtp-Source: AGHT+IEOXdebd1HZfrL8QOziI4j3FF8CHbX9fydX9TsQ/M0a7RnvzVziRSdFaf+fhQ5fMaI4Q5OCTSPMRNJej6KiF7k=
X-Received: by 2002:a17:906:b84e:b0:a6e:feb5:14a8 with SMTP id
 a640c23a62f3a-a6fab648965mr19139266b.39.1718739032312; Tue, 18 Jun 2024
 12:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240617191416.1351790-1-tharvey@gateworks.com>
 <20240617191416.1351790-5-tharvey@gateworks.com>
 <626fe70e-ff61-46f6-84de-e9b8486ac5ed@gmx.de>
 <CAJ+vNU3rtrGkL3gQwEZW0x=ivSPqv-jxsdUX59bCcYRofe7Wxw@mail.gmail.com>
 <CAJ+vNU2KH8NgFkjWt5ZPKMauPjhLXwd-oNfGFy-+QHO6MWKARA@mail.gmail.com>
In-Reply-To: <CAJ+vNU2KH8NgFkjWt5ZPKMauPjhLXwd-oNfGFy-+QHO6MWKARA@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 18 Jun 2024 12:30:20 -0700
Message-ID: <CAJ+vNU02a0VASJzAghDpSWm6XuOseQj9T70eRn0bD9deiHo6dA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] test: cmd: fdt: fix chosen test for DM_RNG
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>, u-boot@lists.denx.de, 
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

On Tue, Jun 18, 2024 at 9:45=E2=80=AFAM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> On Tue, Jun 18, 2024 at 8:48=E2=80=AFAM Tim Harvey <tharvey@gateworks.com=
> wrote:
> >
> > On Tue, Jun 18, 2024 at 4:51=E2=80=AFAM Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> > >
> > > On 17.06.24 21:14, Tim Harvey wrote:
> > > > Now that kaslr-seed is automatically added to the chosen node if DM=
_RNG
> > > > is enabled, adjust the test to expect this.
> > >
> > > We need to check that if CONFIG_EFI_TCG2_PROTOCOL=3Dy no kaslr-seed n=
ode
> > > is passed to EFI binaries.
> > >
> > > The right location for such a test is lib/efi_selftest/efi_selftest_t=
cg2.c.
> > >
> >
> > Hi Heinrich,
> >
> > I see you sent a patch for that but I'm not understanding how that
> > fits into the ut framework.
> >
> > > We need as similar check for CONFIG_MEASURED_BOOT=3Dy.
> >
> > Can you explain more please?
> >
> > Does this explain the CI failures I see here:
> > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D8721&view=
=3Dlogs&j=3D6ebe5bb0-481f-5026-b4e6-2d4192a94e80&t=3D66c5926e-2461-580f-927=
d-c0d0a6120549&l=3D539
> > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D8721&view=
=3Dlogs&j=3Da1270dec-081b-5c65-5cd5-5e915a842596&t=3D69f6cf72-86f3-551a-807=
d-f28f62a1426f&l=3D541
> >
> > I'm still trying to make sense of those.
> >
> > In order to test this locally I built for sandbox64_defconfig and ran
> > "./u-boot -Dc 'ut fdt'" but it seems that doesn't cover enough cases.
> >
>
> I believe I understand the Azure pipeline failures now. I don't see
> exactly where they pick a defconfig but the failed test cases are
> under 'test.py for sandbox sandbox' and 'test.py for sandbox
> sandbox_clang' which I've come to understand means they use
> 'sandbox_defconfig' which defines CONFIG_MEASURED_BOOT where
> sandbox64_defconfig which I tested does not.
>
> So I need to update the test to:
> +       if (IS_ENABLED(CONFIG_DM_RNG) &&
> +           !IS_ENABLED(CONFIG_MEASURED_BOOT) &&
> +           !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
> +               ut_assert_nextlinen("\tkaslr-seed =3D ");
>
> I've issued a PR for v7 to test via CI and will submit if all is well.
>

Hi Tom,

Can you explain what the following Azure pipeline error means [1]?

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
____________ TestEfiCapsuleFirmwareSignedRaw.test_efi_capsule_auth5 _______=
_____
test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py:178:
in test_efi_capsule_auth5
capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
test/py/tests/test_efi_capsule/capsule_common.py:17: in capsule_setup
u_boot_console.run_command_list([
test/py/u_boot_console_base.py:297: in run_command_list
output.append(self.run_command(cmd))
test/py/u_boot_console_base.py:256: in run_command
m =3D self.p.expect([chunk] + self.bad_patterns)
test/py/u_boot_spawn.py:193: in expect
raise Timeout()
E u_boot_spawn.Timeout
----------------------------- Captured stdout call ------------------------=
-----
=3D> host bind 0 /tmp/sandbox/persistentcyclic function wdt-gpio-level
took too long: 5523us vs 5000us max
-data/test_efi_capsule.img

This seems like something from test/dm/wdt.c and unrelated to my patchset.

Best Regards,

Tim
[1] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D8731&view=
=3Dlogs&j=3Da1270dec-081b-5c65-5cd5-5e915a842596&t=3D69f6cf72-86f3-551a-807=
d-f28f62a1426f&l=3D541

> Best Regards,
>
> Tim
>
> > Best regards,
> >
> > Tim
> >
> > >
> > > Best regards
> > >
> > > Heinrich
> > >
> > > >
> > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > Cc: Michal Simek <michal.simek@amd.com>
> > > > Cc: Andy Yan <andy.yan@rock-chips.com>
> > > > Cc: Akash Gajjar <gajjar04akash@gmail.com>
> > > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > Cc: Simon Glass <sjg@chromium.org>
> > > > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > > > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > > > Cc: Devarsh Thakkar <devarsht@ti.com>
> > > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > Cc: Marek Vasut <marex@denx.de>
> > > > Cc: Tom Rini <trini@konsulko.com>
> > > > Cc: Chris Morgan <macromorgan@hotmail.com>
> > > > ---
> > > > v6: new patch
> > > > ---
> > > >   test/cmd/fdt.c | 4 ++++
> > > >   1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> > > > index 547085521758..537d8a338bbf 100644
> > > > --- a/test/cmd/fdt.c
> > > > +++ b/test/cmd/fdt.c
> > > > @@ -1347,6 +1347,8 @@ static int fdt_test_chosen(struct unit_test_s=
tate *uts)
> > > >       ut_assert_nextlinen("\tu-boot,version =3D "); /* Ignore the v=
ersion string */
> > > >       if (env_bootargs)
> > > >               ut_assert_nextline("\tbootargs =3D \"%s\";", env_boot=
args);
> > > > +     if (CONFIG_IS_ENABLED(DM_RNG))
> > > > +             ut_assert_nextlinen("\tkaslr-seed =3D ");
> > > >       ut_assert_nextline("};");
> > > >       ut_assertok(ut_check_console_end(uts));
> > > >
> > > > @@ -1363,6 +1365,8 @@ static int fdt_test_chosen(struct unit_test_s=
tate *uts)
> > > >       ut_assert_nextlinen("\tu-boot,version =3D "); /* Ignore the v=
ersion string */
> > > >       if (env_bootargs)
> > > >               ut_assert_nextline("\tbootargs =3D \"%s\";", env_boot=
args);
> > > > +     if (CONFIG_IS_ENABLED(DM_RNG))
> > > > +             ut_assert_nextlinen("\tkaslr-seed =3D ");
> > > >       ut_assert_nextline("};");
> > > >       ut_assertok(ut_check_console_end(uts));
> > > >
> > >
