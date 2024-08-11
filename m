Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2236EC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6440B885F4;
	Sun, 11 Aug 2024 16:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OAv5ZgTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 757DD88580; Sun, 11 Aug 2024 16:50:15 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0083787E9D
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b7b23793c1so22159286d6.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387812; x=1723992612; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6c3NzLRSVdNOFX9HBBZ6d4nN1mdvUu0jBhOtkkJCHEk=;
 b=OAv5ZgTLGLsTOxcCn6GeIn9ZeWh/eq1mX8WJi0I2aRAt1tKuPqi+8xUiFQ6/GMLyO2
 Ao4AwLbBPU8obYykKwEU8OHjLWDbRcbKABsFEqq/51Dcf+a72pno6ZQBm3WUBOyhzD/G
 UHs8zeUyydpTF5gtYVlqPGPOMlnRL8v59xr0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387812; x=1723992612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6c3NzLRSVdNOFX9HBBZ6d4nN1mdvUu0jBhOtkkJCHEk=;
 b=OawR+zMgoYbkVaVTUzGXp1vFraPJfRTakzUOrF0QmhdFLNseHcuJ/VrXLkkfaJd6pv
 3YbZwAzqMX+jbTSjglrXBeiJpjEn9etnWVRGNvdBHnNlaP3If4dXHWmPlzV3ybkCaK2r
 e59g8mOppiu2Kyzl+nDTnRuZrjsL6xsjrwljSVC0V1olvyhLj/641NPM3uewU3yqtmK/
 8NO+Bt6bmM2bYonLEQdFNBBzXUZn5MpRBDhnSyci2WKytQlR8OfTK7MfRqssfT/GvbGt
 6FMUE2HdrMNXzmOHQ3HQy007E1m3cfxO7WzgjMhq7cnGxiLgaU5DePSvMV4WmXCtmmg/
 2TzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL2Af8fbSRlb4ubXx+AVbYY40dQiLPySoVhaq4cTF9fw/YL8Nb5AfLh00smrVGZX6PtbGdWUA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6/4CbtunyjCWLijNbDoBvItscSwthemOETKqoHebbQ5uRNjF2
 9XGJQXfLxkhQFvNv+89hEMU0K7OnC7aMdzTACdhOe5UR4N+waDyzawA0l5mwZ3KbdGiQRHv95Ho
 SRkzTI0Quc2v0ldWDXJ9gBMIKwOQsW29MfCoy
X-Google-Smtp-Source: AGHT+IFhQMS33c+Qw5AcY+M+ElvqfAPyNYcNhlK5E3eZ2cThqgcerKLKkEma6482R41cxRnmFTz4HDtHIPJ1F185m8k=
X-Received: by 2002:a0c:f40e:0:b0:6bb:84af:d632 with SMTP id
 6a1803df08f44-6bd78da58a8mr73692116d6.5.1723387811714; Sun, 11 Aug 2024
 07:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <03cdd29b-331c-76b0-f6d7-a064552ffd67@marvell.com>
 <CAFLszTiCS-jRfL__PJ=uEQf0rUKcw4J8czp-=khzkHB=q9ySOg@mail.gmail.com>
 <b4d4fe48-c3b0-98cc-dccf-8b96318ec204@marvell.com>
In-Reply-To: <b4d4fe48-c3b0-98cc-dccf-8b96318ec204@marvell.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:01 -0600
Message-ID: <CAFLszTgN3AqhPzT+Zpe=sfM_cOZOmOQPseG_ipwMcNYzLbGUdQ@mail.gmail.com>
Subject: Re: [PATCH v2] env: remove vars that are not in default env
To: Ravi Minnikanti <rminnikanti@marvell.com>
Cc: Tom Rini <trini@konsulko.com>, quentin.schulz@bootlin.com, 
 U-Boot-Denx <u-boot@lists.denx.de>
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

Hi Ravi,

On Fri, 9 Aug 2024 at 13:36, Ravi Minnikanti <rminnikanti@marvell.com> wrot=
e:
>
>
> current env_set_default_vars() doesn't delete
> var that are not in the imported env. hashtable
> removes vars that are not in the imported
> env but present in the current env only if H_NOCLEAR
> flag is not set.
>
> This change is to avoid passing H_NOCLEAR flag if
> specific vars are passed to env_set_default_vars()
>
> Without this change:
> Marvell>> env default boot_mode
> Marvell>>
>
> With the change:
> Marvell>> env default boot_mode
> WARNING: 'boot_mode' not in imported env, deleting it!
>
> Signed-off-by: rminnikanti <rminnikanti@marvell.com>

That should have your name at the start

> ---
> Changes in v2:
> - Added env ut to test the scenario
> - Updated doc usage/cmd/env.rst
>
> =3D> ut env
> Running 5 environment tests
> Test: env_test_attrs_lookup: attr.c
> Test: env_test_attrs_lookup_regex: attr.c
> Test: env_test_env_cmd: cmd_ut_env.c
> Test: env_test_htab_deletes: hashtable.c
> Test: env_test_htab_fill: hashtable.c
> Failures: 0
>
>  doc/usage/cmd/env.rst |  4 +++-
>  env/common.c          | 10 +++++++++-
>  test/env/cmd_ut_env.c | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+), 2 deletions(-)

Just some nits below

>
> diff --git a/doc/usage/cmd/env.rst b/doc/usage/cmd/env.rst
> index 9629f97ffc..9104c88525 100644
> --- a/doc/usage/cmd/env.rst
> +++ b/doc/usage/cmd/env.rst
> @@ -79,7 +79,8 @@ The *env default* command resets the selected variables=
 in the U-Boot
>  environment to their default values.
>
>      var
> -        list of variable name.
> +        list of variable name. If variable is not part of default

list of variable names. If a variable is not ...

> +        environment, it is deleted with a warning message on console.
>      \-a
>          all U-Boot environment.
>      \-f
> @@ -309,6 +310,7 @@ Delete environment variable in memory::
>  Reset environment variable to default value, in memory::
>
>      =3D> env default bootcmd
> +    =3D> env default ipaddr serverip
>      =3D> env default -a
>
>  Save current environment in persistent storage::
> diff --git a/env/common.c b/env/common.c
> index 8d47d72605..2f783e3a69 100644
> --- a/env/common.c
> +++ b/env/common.c
> @@ -401,7 +401,15 @@ int env_set_default_vars(int nvars, char * const var=
s[], int flags)
>          * Special use-case: import from default environment
>          * (and use \0 as a separator)
>          */
> -       flags |=3D H_NOCLEAR | H_DEFAULT;
> +
> +       /*

There is a trailing space on the end of that line. Be sure to check
your patch with patman/checkpatch.pl

> +        * When vars are passed remove variables that are not in
> +        * the default environment.
> +        */
> +       if (!nvars)
> +               flags |=3D H_NOCLEAR;
> +
> +       flags |=3D H_DEFAULT;
>         return himport_r(&env_htab, default_environment,
>                                 sizeof(default_environment), '\0',
>                                 flags, 0, nvars, vars);
> diff --git a/test/env/cmd_ut_env.c b/test/env/cmd_ut_env.c
> index 13e0998341..99961311aa 100644
> --- a/test/env/cmd_ut_env.c
> +++ b/test/env/cmd_ut_env.c
> @@ -9,6 +9,42 @@
>  #include <test/suites.h>
>  #include <test/ut.h>
>
> +static int env_test_env_cmd(struct unit_test_state *uts)
> +{
> +       console_record_reset_enable();
> +       ut_assertok(run_command("setenv non_default_var1 1", 0));
> +       ut_assert_console_end();
> +
> +       console_record_reset_enable();
> +       ut_assertok(run_command("setenv non_default_var2 1", 0));
> +       ut_assert_console_end();
> +
> +       console_record_reset_enable();
> +       ut_assertok(run_command("env print non_default_var1", 0));
> +       ut_assert_nextline("non_default_var1=3D1");
> +       ut_assert_console_end();
> +
> +       console_record_reset_enable();
> +       ut_assertok(run_command("env default non_default_var1 non_default=
_var2", 0));
> +       ut_assert_nextline("WARNING: 'non_default_var1' not in imported e=
nv, deleting it!");
> +       ut_assert_nextline("WARNING: 'non_default_var2' not in imported e=
nv, deleting it!");
> +       ut_assert_console_end();
> +
> +       console_record_reset_enable();
> +       ut_asserteq(1, run_command("env exists non_default_var1", 0));
> +       ut_assert_nextline_empty();

You don't need that line. It means that the next line should exist,
but be empty. In fact this exposes a bug in console checking which I
will fix.

> +       ut_assert_console_end();
> +
> +       console_record_reset_enable();
> +       ut_asserteq(1, run_command("env exists non_default_var2", 0));
> +       ut_assert_nextline_empty();

same here

> +       ut_assert_console_end();
> +
> +       return 0;
> +}
> +
> +ENV_TEST(env_test_env_cmd, 0);

Set the flags to UT_TESTF_CONSOLE_REC and you can drop all the
console_record_reset_enable() calls above. Unfortunately many of the
tests don't do this as the flag was added later.


> +
>  int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const arg=
v[])
>  {
>         struct unit_test *tests =3D UNIT_TEST_SUITE_START(env_test);
> --
> 2.25.1
>
> Thanks,
> Ravi
>
> On 8/9/24 08:58, Simon Glass wrote:
> > Hi Ravi, On Fri, 9 Aug 2024 at 09:=E2=80=8A38, Ravi Minnikanti <rminnik=
anti@=E2=80=8Amarvell.
> > com> wrote: > > > current env_set_default_vars() doesn't delete > var t=
hat are
> > not in the imported env. hashtable > removes vars that are not in
> >
> >
> > Hi Ravi,
> >
> > On Fri, 9 Aug 2024 at 09:38, Ravi Minnikanti <rminnikanti@marvell.com> =
wrote:
> >>
> >>
> >> current env_set_default_vars() doesn't delete
> >> var that are not in the imported env. hashtable
> >> removes vars that are not in the imported
> >> env but present in the current env only if H_NOCLEAR
> >> flag is not set.
> >>
> >> This change is to avoid passing H_NOCLEAR flag if
> >> specific vars are passed to env_set_default_vars()
> >>
> >> Test:
> >>
> >> Without this change:
> >> Marvell>> env default boot_mode
> >> Marvell>>
> >>
> >> With the change:
> >> Marvell>> env default boot_mode
> >> WARNING: 'boot_mode' not in imported env, deleting it!
> >>
> >> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
> >> ---
> >>  env/common.c | 10 +++++++++-
> >>  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > Could you add to usage/environment.rst and also update the tests for
> > this - test/env/ - I suppose your patch fixes a bug, but it is hard to
> > figure out what it is supposed to do from the docs.
> >
> > See for example dm_test_acpi_cmd_set() for how to check output from a c=
ommand.
> >
> >>
> >> diff --git a/env/common.c b/env/common.c
> >> index 8d47d72605..2f783e3a69 100644
> >> --- a/env/common.c
> >> +++ b/env/common.c
> >> @@ -401,7 +401,15 @@ int env_set_default_vars(int nvars, char * const =
vars[], int flags)
> >>          * Special use-case: import from default environment
> >>          * (and use \0 as a separator)
> >>          */
> >> -       flags |=3D H_NOCLEAR | H_DEFAULT;
> >> +
> >> +       /*
> >> +        * When vars are passed remove variables that are not in
> >> +        * the default environment.
> >> +        */
> >> +       if (!nvars)
> >> +               flags |=3D H_NOCLEAR;
> >> +
> >> +       flags |=3D H_DEFAULT;
> >>         return himport_r(&env_htab, default_environment,
> >>                                 sizeof(default_environment), '\0',
> >>                                 flags, 0, nvars, vars);
> >> --
> >> 2.25.1

Regards,
Simon
