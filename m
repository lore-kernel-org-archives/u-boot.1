Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E017C54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 00:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52B2B8752B;
	Sun, 19 Nov 2023 01:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fy7z3rmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1652A870E3; Sun, 19 Nov 2023 01:44:26 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28B7587446
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 01:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5c5b9c142e8so26031387b3.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 16:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700354655; x=1700959455; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlg8fiRR4Wtp7p8S2QUR9JS1LkGrz3XryUNiYLOzdGE=;
 b=fy7z3rmtsFzfeEzH+0NfYzX0sa88RtkXQquj1ge6tvkVG1vc0Va5fhc//Y/yyWXR5X
 B7Z/DLYG6CVHbpdUPbc7+9V6tx+Qm0zBqs7YCTusCohrpLSCNR1vXNolOjkpthWPnaJH
 8lnwQYBO6xx21vBBwW5zz7tJKOhR7wxMKZPhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700354655; x=1700959455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vlg8fiRR4Wtp7p8S2QUR9JS1LkGrz3XryUNiYLOzdGE=;
 b=cl0lFMCcB2L72yenv7h0iDYZ/Kr/Z6XxBRrnO6xXZtke7DlSYjJXuv04dG3QIVVDzn
 Jxs7HUyZYbQGolESxVX256djOJWX1L4CxP/Bifr1P+p8DTxvmBG0IOkQXRqX1j0nnfS2
 iL8hSP2eKCOJUG/36Myt1dbHZgBsItqiQd1nPHdJAbgLHq6ypYlnk+jl8KegOrPn9tIh
 lQrFyvTmpUCJiqhdcuK0DLX8irflCXZPY86sUQDJu/0MbvogvbmwRKH2AevGm37VW6lq
 7pVpYN8Xl53mf6TvI2F1CIXQw+okD+vZ2IdfA77fRK5WCcwgiwTzmSW+H0Mr7y0OZKfY
 LpyA==
X-Gm-Message-State: AOJu0YxX7lKjNZ4LCocYuDiJzbt7eRQtp9EBl8dlKG5493xJSCnfGJRW
 x/xiuQ33jX8x50IfP3+rVMSgLPSznFAFErfqWh2NoKYcwbfXddqVcUc=
X-Google-Smtp-Source: AGHT+IF0MFna+IdufB10gyDYjRfmjZltzYEwJzQm1SKx46gNrubGvIU5ibSHQWcmb0uAF/GoMnJ5I/V7+XCj+D/7t5I=
X-Received: by 2002:a0d:ea8e:0:b0:5ae:c35a:807a with SMTP id
 t136-20020a0dea8e000000b005aec35a807amr3854924ywe.48.1700354655313; Sat, 18
 Nov 2023 16:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20231117212039.1210784-1-i@shantur.com>
 <20231117212039.1210784-3-i@shantur.com>
 <CAPnjgZ19Q4RZMR080gqqzginpCNkCkj4OuVgJX6drRt+dJbLNQ@mail.gmail.com>
 <CAHc5_t1rR0gjkP2z=CQh0zy3hYUf734fVUq8eKjG1i2V3h0Hsw@mail.gmail.com>
In-Reply-To: <CAHc5_t1rR0gjkP2z=CQh0zy3hYUf734fVUq8eKjG1i2V3h0Hsw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 17:43:10 -0700
Message-ID: <CAPnjgZ3E4CFBH6xHqmt9HyvKZOJwfMc4YX3qXw0ndhZ36aWsQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] bootflow: bootmeth_efi: Don't set bootdev again
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Shantur,

On Sat, 18 Nov 2023 at 14:17, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Simon,
>
> On Sat, Nov 18, 2023 at 5:11=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > +Ilias too as this involves a design decision
> >
> > Hi Shantur,
> >
> > On Fri, 17 Nov 2023 at 14:22, Shantur Rathore <i@shantur.com> wrote:
> > >
> > > efi_set_bootdev is already called as part of tftp while doing dhcp_ru=
n()
> >
> > Is that in tftp_complete() ?
> >
> > > Doing this again crashes U-boot and we don't need to call again.
> >
> > U-Boot
> >
> > The problem is that we might scan for 4 bootflows, then later decide
> > which one to boot. So we cannot know which one it will be until that
> > point.
> >
> > The hack is needed so that it actually tells EFI about the right one.
> >
> > The addition of EFI hacks when reading files (i.e. the code in
> > tftp_complete()) is a real problem, unfortunately. I understand that
> > it was a convenient hack, but with standard boot we really don't want
> > it to do that. We end up calling it multiple times for bootflows that
> > won't be used.
> >
> > So I believe the fix is to be able to disable those calls, leaving it
> > to bootstd.
> >
> > I'm not sure of the best way to do that. Perhaps we should have a
> > function like bootstd_scanning() which returns a bool indicating that
> > bootstd is scanning? If that is true then no efi_set_bootdev() calls
> > are made? We could have a flag in 'struct bootstd_priv' which is set
> > before bootflow_check() is called and cleared afterwards.
> >
> > As to how this should be done with standard boot, we should create a
> > function like efi_start_app() and pass it the information we need.
> > That function should do the equivalent of the 'bootefi' command,
> > except programmatically, with no prior state hanging around.
> >
> > As to when we might be able to do that, we need more refactoring of
> > the bootm code. There is a start on this [1] but it likely needs 2-3
> > more series before it might be possible.
> >
> > So for now, I think bootstd_scanning() is the best approach. If you
> > are not sure about that, I can send a patch.
> >
>
> My apologies, the fix I submitted is incorrect.
> After reading your explanation, I started thinking on why dhcp can
> call this multiple times but bootmethod can't.
>
> There it was clear that the issue bflow->fname is null when we call
> this function.
> The correct fix should be below
>
> +       /* bootfile should be setup by dhcp by now*/
> +       bootfile_name =3D env_get("bootfile");
> +       if (!bootfile_name)
> +               return log_msg_ret("bootfile_name", ret);
> +       bflow->fname =3D strdup(bootfile_name);
> +
>     /* do the hideous EFI hack */
>     efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
>                     bflow->size);
>
> I have a patch ready for this which I will send but I have some
> queries regarding that.
> As I sent this a series of patches out of which 2 were reviewed,
> should I send a new version for the whole series even though 2 are not
> going to be changed?

Yes you normally send the whole series but include any review/tested
tags that you received for each patch ('patman status' can help).

> Another thing, should I send them as a reply to the original email or
> a new thread?

A new thread is fine.

Regards,
Simon
