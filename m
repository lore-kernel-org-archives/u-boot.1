Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCF2C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 18:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE8E87214;
	Sun, 19 Nov 2023 19:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WAiRTl9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6434287208; Sun, 19 Nov 2023 19:24:26 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87D0C870DE
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 19:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9f27af23443so510280066b.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 10:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700418255; x=1701023055; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VqYVocZ1mieDb/zZgLNqz8dFcPVCuUnZhT/LAPBTil0=;
 b=WAiRTl9Y5fHtwATLlQRdrZuvGAauxxN7WOjXvrSTgL5cIxWbVXPCf17ZSQRRe39u3O
 mXcb42dPtAezj61WoA/TN2kZMUnNPdrfeF+UDZjsV9+SVtH05ILyBnu8+dIhZ7eEdxj9
 pELAJQeqDBkyGQ/PM7CS8xvGiSpjVvCjCAjWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700418255; x=1701023055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VqYVocZ1mieDb/zZgLNqz8dFcPVCuUnZhT/LAPBTil0=;
 b=SKNOzVX0Jb5f3lfUOYHsyyTbDiZBDGHxKBUeNSObwLWIUQLC4Jnr+0UKopJghrNdhb
 cI/78bHdwG4vwj5g8yRXsb+mNZ07jBEIdWgLC4udS7QxXPOQTg/bCaval+T5ykhN1cAH
 Wvm40fu8E2nmFvRfsiBN3SiSAKBkGxHVRJcvEZYCmBRdq5bMb3yw26bMToN+kJ9G+mWq
 d2Av96X0k5xhh3DHLWYhyaYHzPDupgty188gJq20NcItVHhKPWmhtEwgpG5RU2egfIFW
 4sD8F/kWMtzKNQ0qOhM1hB9pppObNqkz7g72gjO2s6ccIFt2BMxwzst5xpCLIQw6Uj5+
 VS7g==
X-Gm-Message-State: AOJu0YyqLsXO3v/a0dRW+l+/eI7LE7RBss1T2IUOV92LjZMn6y41sO5f
 QjzwHuIEFyh20U1EMSvpAcDA7Ja31FnfGmi51KLJMQ==
X-Google-Smtp-Source: AGHT+IHN4BHYUJNeJHj9HWL1dWxj/J04s6HeXGaPJvoNsAo9yw9ffVNtHc+f2EzF35EAEyJ56zXf1XOIofht80fcfhc=
X-Received: by 2002:a17:906:a019:b0:9ae:65a5:b6fa with SMTP id
 p25-20020a170906a01900b009ae65a5b6famr3535169ejy.32.1700418254971; Sun, 19
 Nov 2023 10:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20231117212039.1210784-1-i@shantur.com>
 <20231117212039.1210784-3-i@shantur.com>
 <CAPnjgZ19Q4RZMR080gqqzginpCNkCkj4OuVgJX6drRt+dJbLNQ@mail.gmail.com>
 <CAHc5_t1rR0gjkP2z=CQh0zy3hYUf734fVUq8eKjG1i2V3h0Hsw@mail.gmail.com>
 <CAPnjgZ3E4CFBH6xHqmt9HyvKZOJwfMc4YX3qXw0ndhZ36aWsQQ@mail.gmail.com>
 <CAHc5_t1PD-ZYXpnpPAme1UcC--wh9tiKY0U9A5o1v_ZF3oYktw@mail.gmail.com>
In-Reply-To: <CAHc5_t1PD-ZYXpnpPAme1UcC--wh9tiKY0U9A5o1v_ZF3oYktw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Nov 2023 11:24:03 -0700
Message-ID: <CAPnjgZ3GKnmeR5Noy8VXUMm-ex93F3ZngmC6JAReWrAk7CsCpg@mail.gmail.com>
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

On Sun, 19 Nov 2023 at 10:01, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Simon,
>
> On Sun, Nov 19, 2023 at 12:44=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > Hi Shantur,
> >
> > On Sat, 18 Nov 2023 at 14:17, Shantur Rathore <i@shantur.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Sat, Nov 18, 2023 at 5:11=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > +Ilias too as this involves a design decision
> > > >
> > > > Hi Shantur,
> > > >
> > > > On Fri, 17 Nov 2023 at 14:22, Shantur Rathore <i@shantur.com> wrote=
:
> > > > >
> > > > > efi_set_bootdev is already called as part of tftp while doing dhc=
p_run()
> > > >
> > > > Is that in tftp_complete() ?
> > > >
> > > > > Doing this again crashes U-boot and we don't need to call again.
> > > >
> > > > U-Boot
> > > >
> > > > The problem is that we might scan for 4 bootflows, then later decid=
e
> > > > which one to boot. So we cannot know which one it will be until tha=
t
> > > > point.
> > > >
> > > > The hack is needed so that it actually tells EFI about the right on=
e.
> > > >
> > > > The addition of EFI hacks when reading files (i.e. the code in
> > > > tftp_complete()) is a real problem, unfortunately. I understand tha=
t
> > > > it was a convenient hack, but with standard boot we really don't wa=
nt
> > > > it to do that. We end up calling it multiple times for bootflows th=
at
> > > > won't be used.
> > > >
> > > > So I believe the fix is to be able to disable those calls, leaving =
it
> > > > to bootstd.
> > > >
> > > > I'm not sure of the best way to do that. Perhaps we should have a
> > > > function like bootstd_scanning() which returns a bool indicating th=
at
> > > > bootstd is scanning? If that is true then no efi_set_bootdev() call=
s
> > > > are made? We could have a flag in 'struct bootstd_priv' which is se=
t
> > > > before bootflow_check() is called and cleared afterwards.
> > > >
> > > > As to how this should be done with standard boot, we should create =
a
> > > > function like efi_start_app() and pass it the information we need.
> > > > That function should do the equivalent of the 'bootefi' command,
> > > > except programmatically, with no prior state hanging around.
> > > >
> > > > As to when we might be able to do that, we need more refactoring of
> > > > the bootm code. There is a start on this [1] but it likely needs 2-=
3
> > > > more series before it might be possible.
> > > >
> > > > So for now, I think bootstd_scanning() is the best approach. If you
> > > > are not sure about that, I can send a patch.
> > > >
> > >
> > > My apologies, the fix I submitted is incorrect.
> > > After reading your explanation, I started thinking on why dhcp can
> > > call this multiple times but bootmethod can't.
> > >
> > > There it was clear that the issue bflow->fname is null when we call
> > > this function.
> > > The correct fix should be below
> > >
> > > +       /* bootfile should be setup by dhcp by now*/
> > > +       bootfile_name =3D env_get("bootfile");
> > > +       if (!bootfile_name)
> > > +               return log_msg_ret("bootfile_name", ret);
> > > +       bflow->fname =3D strdup(bootfile_name);
> > > +
> > >     /* do the hideous EFI hack */
> > >     efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
> > >                     bflow->size);
> > >
> > > I have a patch ready for this which I will send but I have some
> > > queries regarding that.
> > > As I sent this a series of patches out of which 2 were reviewed,
> > > should I send a new version for the whole series even though 2 are no=
t
> > > going to be changed?
> >
> > Yes you normally send the whole series but include any review/tested
> > tags that you received for each patch ('patman status' can help).
> >
>
> patman... that's the missing piece in the puzzle. I was trying to find
> out how everyone is managing their commits.
>
> Thanks for pointing it out to me.

:-) If you have ideas to improve it, please send patches.


- Simon
