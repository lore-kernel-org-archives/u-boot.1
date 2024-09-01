Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643D8CD3420
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37BEF88CB8;
	Sun,  1 Sep 2024 22:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LD+fJ+Wt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 609DB88C6D; Sun,  1 Sep 2024 22:10:29 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B8E988C3C
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7143ae1b48fso2069244b3a.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221425; x=1725826225; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wssEY7u2fUql9OMA0N1F1YJvZrD6Saf0gqocCuULnhM=;
 b=LD+fJ+WtPuAminaq643pkKLN/iJPQ7X40CAHxa4qeID2sdxVzQPYFuCxl2V3Kz2Goy
 prK7+OvWaHuv2WUsNxrEwFOGXwmeNRKUpHqnHS1QwjHUrW1dGMSEqDt+m1YMbBJ0w3pE
 o+nPOI++iQ47oBGaFU7QmXnhAOCWyaAjNR414=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221425; x=1725826225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wssEY7u2fUql9OMA0N1F1YJvZrD6Saf0gqocCuULnhM=;
 b=YnP/2EgMbD7qp/6u3+KpRp8m5l4l8TrDbdNuurOeP+6GYZkWH1MM3Z19Rt/4fG07Yd
 gsyE0s503+q7rNpfZUs8iQPEGHFzivVhGyFtQGhiWxruE2oasktSZ5jMgUkB3T22smb5
 c4SZQ3jLRw0deTYyqbwuyEeVbogFVUCUOJ/8atIKHD5WScKJu/zwG2I3eLFlY6InhJjA
 sTGMaH/mMpGlMsAqTLl5Rjsjhju0wOyGeD6R2o1L8JgVHNTB43qmnyNesNus83VB/3W8
 N/+cDyxzjR/3syWwkB7U5fktjpsJ7fYUboXSJmef8Oyu6k+lUL60HmBWehDXgHYk2mn5
 Aqjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4kjFNNO0gn5Sc8YVgY/Xmb/0KoYta81A69tJPU+DZwFOQZGedmbHHh93SVCrkT5U9+slsrZc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywuz7q7/MIaOGnTEgUNeZIbBvTBwq1dMhrZXCSnb/LLUI3OkXuI
 WtQUtC0EtvDlQ1O7T6Hmusl1nAtaI72lY4Ayi0M3d+r30AaBoWmuzUMO1i3qUEOwKZB9VDeJPGV
 HVr3/gYmDL25OMB0aeb2f0XRNaHyd3C9pufDS
X-Google-Smtp-Source: AGHT+IHaOZnvGDzvTkw60DwGGODieLAqvC9PSLSd7Eic3qXpu+3VxOyOO9grs8uVP78DIBVMrVXJeds2YQAP1EafeTk=
X-Received: by 2002:a05:6a21:3a93:b0:1c0:e49a:6900 with SMTP id
 adf61e73a8af0-1cece4d7233mr5079430637.7.1725221424793; Sun, 01 Sep 2024
 13:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240831164639.2298097-1-caleb.connolly@linaro.org>
 <CANV2PTM+wevfK7w15j-=a2oakPMMXpTdr7ntzBfkc3jbbv+veg@mail.gmail.com>
 <feff5299-6378-4de9-867d-808c23625af4@linaro.org>
In-Reply-To: <feff5299-6378-4de9-867d-808c23625af4@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:10:08 -0600
Message-ID: <CAFLszTiZ75zK2L8=5E9dXOHXqEybh7O=OsQiW5hkJ9xoPiWT4Q@mail.gmail.com>
Subject: Re: [PATCH] cmd: fdt: use U-Boot's FDT by default
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: E Shattow <lucent@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Caleb,

On Sun, 1 Sept 2024 at 08:21, Caleb Connolly <caleb.connolly@linaro.org> wr=
ote:
>
> Hi,
>
> On 31/08/2024 23:22, E Shattow wrote:
> > Hi Caleb, the problem here is hidden conditional behavior.
> >
> > On Sat, Aug 31, 2024 at 9:56=E2=80=AFAM Caleb Connolly
> > <caleb.connolly@linaro.org> wrote:
> >>
> >> When using the FDT command to inspect an arbitrary FDT in memory, it
> >> will always be necessary to explicitly set the FDT address. However it
> >> is also quite likely that the command is being used to inspect U-Boot'=
s
> >> own FDT. Simplify that common workflow of running "fdt addr -c" to get
> >> the control address and set it by just making $fdtcontroladdr the
> >> default FDT if there isn't one.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>   cmd/fdt.c | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/cmd/fdt.c b/cmd/fdt.c
> >> index d16b141ce32d..8909706e2483 100644
> >> --- a/cmd/fdt.c
> >> +++ b/cmd/fdt.c
> >> @@ -276,8 +276,17 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag=
, int argc, char *const argv[])
> >>
> >>                  return CMD_RET_SUCCESS;
> >>          }
> >>
> >> +       /* Try using U-Boot's FDT by default */
> >> +       if (!working_fdt) {
> >> +               struct fdt_header *addr;
> >> +
> >> +               addr =3D (void *)env_get_hex("fdtcontroladdr", 0);
> >> +               if (addr && fdt_check_header(&addr))
> >> +                       set_working_fdt_addr((phys_addr_t)addr);
> >> +       }
> >> +
> >>          if (!working_fdt) {
> >>                  puts("No FDT memory address configured. Please config=
ure\n"
> >>                       "the FDT address via \"fdt addr <address>\" comm=
and.\n"
> >>                       "Aborting!\n");
> >> --
> >> 2.46.0
> >>
> >
> > The use of `fdt` command in the default action might be depended on by
> > some userspace script as a success/fail result. I don't imagine what
> > that might possibly be, just that the logic of scripts in u-boot
> > depend on that pattern of use.
>
> I'm not sure what the rule is about breaking changes in the CLI, I do
> think this is not a realistic concern here though. Maybe Tom or Simon
> can weigh in?
> >
> > Secondly there would need to be a warning to the user that some hidden
> > conditional action is being applied? i.e. "No valid FDT address is
> > configured to $fdt_addr_r or $fdt_addr so now configuring to use
> > $fdtcontroladdr instead." or however you would phrase that.
>
> Since I call set_working_fdt_addr() it prints a message telling you that
> the fdt address was set on the first call.
> >
> > Otherwise I agree improvement to the fdt is welcome and my memory of
> > first using this command is that it has not-sensible defaults but I
> > then assumed it was designed this way because of possible use in
> > U-Boot scripts.

Definitely a useful feature, but how about adding a flag which sets
the working fdt to the control one? That would make it less painful
than using -c, and will keep existing cases running.

Also note that test/cmd/fdt.c and doc/usage/cmd/fdt.rst need an update for =
this.

Regards,
Simon
