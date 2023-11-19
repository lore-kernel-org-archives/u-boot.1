Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AF4C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 17:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2906D86EE0;
	Sun, 19 Nov 2023 18:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="wi/FDBSe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9133A86E95; Sun, 19 Nov 2023 18:01:52 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D18158715C
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 18:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso5110096a12.2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 09:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700413308; x=1701018108;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+/AQoJFWzTlVSYrKAvlAH2x/rR4hLy3Tu8DVT8vVew=;
 b=wi/FDBSe9zaJxWrKq2GVBKri5Ta+F8dLG8MXiUZi8yx8b7gwKhwmaZt0FcVmmEoztp
 ElUs+7C06itz74PEyLIhvjN7ne8nc1KESVsZ4CU8nHxGH397g5lvBNW7DDIReM72lt1I
 ASKK9enyWqeDjczpkfXeJF2Idcca2JZX2NIbKdP1jAZZPVYlJE1GbSnl6bZPhpDUChDu
 38EK33mrCkKd9rpDpfhzrGLxH9Gls2ab8qiKQxdvI0vKDhGc5hYdZlTIwG8jlcv93AwL
 OaRYOJxulJ6tsKwrc0h4s6oMKJ4nGBQSNrxL5ui6jE5uMAw9xlXWd/uD5RUuQBmy3i9Q
 WtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700413308; x=1701018108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o+/AQoJFWzTlVSYrKAvlAH2x/rR4hLy3Tu8DVT8vVew=;
 b=OrMAeTlrs1j8Vsa2guIiHFCam+IbdyMkQ1puw9Y5oM8gmuICnWcWzRoJQ6RwCdVDlD
 wa4jMMsbmcw+dBwK9loIfSzTQjULHJchPhLv+WtHxj+WScKdnOMdVeBwMBV/pMx1jwae
 MCn3ri55q7HTO7VVfZZ/iuyuFwvXJE5ZHsjI+pLvirWWpdBWVqU+CLWFIciQSEEmdx8q
 3TqEPxyG4CRNhxqxZGipBPZlGXqCzwVuSba8WSyb95GYNzRcB//QbCvvbre0ZK8fZdaq
 dBLUhYMEd4DZ10aPxE97xh29ed/6jszP0zVgZfR26uMEhF8uA0D/FAmZu1WKrZ6NjUEN
 8Nng==
X-Gm-Message-State: AOJu0YycJieE1YVOZXROUIV56uBxrQy1TW6Sx+auW8R3vPQGbu1OplsV
 OjyJUcjs5HoSUsDGOPo6ZZE4lRFb49oE1aaymMzGOw==
X-Google-Smtp-Source: AGHT+IEJ7AsiMnBBOYGwzSqYOF8Q0Yl7Cmdr0z/lAhLb43sRjuWMpfgHtiOwCwWUcQXWatVrjwq3EQ==
X-Received: by 2002:a17:907:2d0f:b0:9e7:1e22:bbe7 with SMTP id
 gs15-20020a1709072d0f00b009e71e22bbe7mr3974996ejc.64.1700413307922; 
 Sun, 19 Nov 2023 09:01:47 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com.
 [209.85.208.41]) by smtp.gmail.com with ESMTPSA id
 ca3-20020a170906a3c300b009fc42f37970sm1071213ejb.171.2023.11.19.09.01.47
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Nov 2023 09:01:47 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-5431614d90eso5133897a12.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 09:01:47 -0800 (PST)
X-Received: by 2002:a05:6402:54a:b0:543:6fb:9cd8 with SMTP id
 i10-20020a056402054a00b0054306fb9cd8mr3778106edx.4.1700413307098; Sun, 19 Nov
 2023 09:01:47 -0800 (PST)
MIME-Version: 1.0
References: <20231117212039.1210784-1-i@shantur.com>
 <20231117212039.1210784-3-i@shantur.com>
 <CAPnjgZ19Q4RZMR080gqqzginpCNkCkj4OuVgJX6drRt+dJbLNQ@mail.gmail.com>
 <CAHc5_t1rR0gjkP2z=CQh0zy3hYUf734fVUq8eKjG1i2V3h0Hsw@mail.gmail.com>
 <CAPnjgZ3E4CFBH6xHqmt9HyvKZOJwfMc4YX3qXw0ndhZ36aWsQQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ3E4CFBH6xHqmt9HyvKZOJwfMc4YX3qXw0ndhZ36aWsQQ@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Sun, 19 Nov 2023 17:01:36 +0000
X-Gmail-Original-Message-ID: <CAHc5_t1PD-ZYXpnpPAme1UcC--wh9tiKY0U9A5o1v_ZF3oYktw@mail.gmail.com>
Message-ID: <CAHc5_t1PD-ZYXpnpPAme1UcC--wh9tiKY0U9A5o1v_ZF3oYktw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] bootflow: bootmeth_efi: Don't set bootdev again
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Sun, Nov 19, 2023 at 12:44=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Shantur,
>
> On Sat, 18 Nov 2023 at 14:17, Shantur Rathore <i@shantur.com> wrote:
> >
> > Hi Simon,
> >
> > On Sat, Nov 18, 2023 at 5:11=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > +Ilias too as this involves a design decision
> > >
> > > Hi Shantur,
> > >
> > > On Fri, 17 Nov 2023 at 14:22, Shantur Rathore <i@shantur.com> wrote:
> > > >
> > > > efi_set_bootdev is already called as part of tftp while doing dhcp_=
run()
> > >
> > > Is that in tftp_complete() ?
> > >
> > > > Doing this again crashes U-boot and we don't need to call again.
> > >
> > > U-Boot
> > >
> > > The problem is that we might scan for 4 bootflows, then later decide
> > > which one to boot. So we cannot know which one it will be until that
> > > point.
> > >
> > > The hack is needed so that it actually tells EFI about the right one.
> > >
> > > The addition of EFI hacks when reading files (i.e. the code in
> > > tftp_complete()) is a real problem, unfortunately. I understand that
> > > it was a convenient hack, but with standard boot we really don't want
> > > it to do that. We end up calling it multiple times for bootflows that
> > > won't be used.
> > >
> > > So I believe the fix is to be able to disable those calls, leaving it
> > > to bootstd.
> > >
> > > I'm not sure of the best way to do that. Perhaps we should have a
> > > function like bootstd_scanning() which returns a bool indicating that
> > > bootstd is scanning? If that is true then no efi_set_bootdev() calls
> > > are made? We could have a flag in 'struct bootstd_priv' which is set
> > > before bootflow_check() is called and cleared afterwards.
> > >
> > > As to how this should be done with standard boot, we should create a
> > > function like efi_start_app() and pass it the information we need.
> > > That function should do the equivalent of the 'bootefi' command,
> > > except programmatically, with no prior state hanging around.
> > >
> > > As to when we might be able to do that, we need more refactoring of
> > > the bootm code. There is a start on this [1] but it likely needs 2-3
> > > more series before it might be possible.
> > >
> > > So for now, I think bootstd_scanning() is the best approach. If you
> > > are not sure about that, I can send a patch.
> > >
> >
> > My apologies, the fix I submitted is incorrect.
> > After reading your explanation, I started thinking on why dhcp can
> > call this multiple times but bootmethod can't.
> >
> > There it was clear that the issue bflow->fname is null when we call
> > this function.
> > The correct fix should be below
> >
> > +       /* bootfile should be setup by dhcp by now*/
> > +       bootfile_name =3D env_get("bootfile");
> > +       if (!bootfile_name)
> > +               return log_msg_ret("bootfile_name", ret);
> > +       bflow->fname =3D strdup(bootfile_name);
> > +
> >     /* do the hideous EFI hack */
> >     efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
> >                     bflow->size);
> >
> > I have a patch ready for this which I will send but I have some
> > queries regarding that.
> > As I sent this a series of patches out of which 2 were reviewed,
> > should I send a new version for the whole series even though 2 are not
> > going to be changed?
>
> Yes you normally send the whole series but include any review/tested
> tags that you received for each patch ('patman status' can help).
>

patman... that's the missing piece in the puzzle. I was trying to find
out how everyone is managing their commits.

Thanks for pointing it out to me.

Kind regards,
Shantur
