Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7C8C369D1
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 18:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D1F18056A;
	Thu, 24 Apr 2025 20:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PkgmUtQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B848380BA8; Thu, 24 Apr 2025 20:32:44 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D13A803CC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 20:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so232685966b.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745519562; x=1746124362; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WoCrr+OOXRUhroxt92prhvvTQKFmqb30yqwmBKarbEk=;
 b=PkgmUtQ212zhsCUmakYb3w7kswYfWYlRYHtb9QV+0HAY+cDbN9s3dmx3W4qNM/t/6d
 3AtjZmTzNtnmpNqLkgwS3qDEJ5mO53dRW/6v1YROKRwLr787aj5/sON+GkRObykTDo6A
 X0M1PgRHPFrt+6ZjQir4nQWz5xLgR8D5TxnZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745519562; x=1746124362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WoCrr+OOXRUhroxt92prhvvTQKFmqb30yqwmBKarbEk=;
 b=Pu4DOjpi0fj/PDhB4PYAyyXJbdSbh02w8Y0+fIh60SCGofA3UBHxGkjrB1GneLbqmz
 N7W4+Dp5RjNkHSWxCKfWNj5eyChHk5aRJHw11SZRXouxM8E8y8CveSSy8bPrxcIrUbdx
 xaNVWPp4bWNEUkgdRKIyftRdZKH0HhTYdSrrOUvZkbDOm9jhMfiVPKF4MIhsLIy7iHBe
 OiWX3aX3mvVSF2ebUSIoEGQfpA5QCf+F/W18xsnV/fcgCKZ1ZyXQl7YYZyfwnO7METsd
 cDVE80Wg0iSlCpAjJ5IOCP1v5TPd2NNrcof6vqKW6OfDbxDywqUq2zzW2YH6jGPlcvkS
 FXeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL5iQjGWTkELxjFhVxyVL8zF3T3+0OjNH3AipS50ON43GeyP5MP6EW8wZMDhNLS2ndaQrDdME=@lists.denx.de
X-Gm-Message-State: AOJu0YyVUroc06D7RFJJ3FQT8G7v1wq2Rvd+cKg50ZcZVqP7UYoSBfcb
 mMalJ63hMP/EgI5U78dOGjk38XIR3tKv+yn2ceMsA0drkUl67EodDPebBY2FfLWqW1hP6BjPaIg
 MZk89s0e8rhOYOfvKDiGB6UFa0qpf+7+5wMNx
X-Gm-Gg: ASbGnct1DGyOk3UnSFFlr5HqTBbck3tiEUlcAO3hovxyc0qnEFdwV8Gp6SsGkaPcMVP
 qVu/heEAItLGliDygHMD6kVPcI0dBOkCGBR2kV3Z46+y+IO4sPN5HUCHM5pnrbUs6+cFLtgHQP7
 58RfEIhjSTyYGKp+HM/fgmAqeqF6d8F2nKQA==
X-Google-Smtp-Source: AGHT+IFtwH9Hz5UgKL/onvaRrDZjO1r9NkbeSBGlGmOYPKvy9Sua3wQ52NxxKnRn526VX+rvfRAD/4Wc0iCxf1YXtS8=
X-Received: by 2002:a17:907:9412:b0:ac3:ccf7:3a11 with SMTP id
 a640c23a62f3a-ace6b50b88fmr68629666b.44.1745519561652; Thu, 24 Apr 2025
 11:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250418-binman-pubkey-dir-v2-0-b6b90a765ffe@cherry.de>
 <20250418-binman-pubkey-dir-v2-2-b6b90a765ffe@cherry.de>
 <CAFLszTh49HqGC4P2=nefc8vgdWrLe_p6HoyoEZ=FkadNBLsp3Q@mail.gmail.com>
 <f9f57c41-9623-45da-878b-f62927beee9e@cherry.de>
 <CAFLszTgDJsO5UFVhpWfo3zoLmjC_o=GnONjQeeWU=mejfMbNDQ@mail.gmail.com>
 <f2a278ff-ac32-4b12-a3c0-d93709be887e@cherry.de>
In-Reply-To: <f2a278ff-ac32-4b12-a3c0-d93709be887e@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 24 Apr 2025 12:32:30 -0600
X-Gm-Features: ATxdqUEE5lQ9N-kiir3nidsKm1HErMNcxcMg4nicYS1yMIZYWTwx_h5w43XJ0Oc
Message-ID: <CAFLszThWCS470MOkkOniCboBdq+pD5o_Fi971ruDDUUtR372iQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] binman: etype: u_boot_spl_pubkey_dtb: provide more
 explicit error for key-name-hint with path
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Alexander Kochetkov <al.kochet@gmail.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, u-boot@lists.denx.de
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

Hi Quentin,

On Thu, 24 Apr 2025 at 02:14, Quentin Schulz <quentin.schulz@cherry.de> wro=
te:
>
> Hi Simon,
>
> On 4/23/25 2:27 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Tue, 22 Apr 2025 at 02:53, Quentin Schulz <quentin.schulz@cherry.de>=
 wrote:
> >>
> >> Hi Simon,
> >>
> >> On 4/18/25 7:19 PM, Simon Glass wrote:
> >>> On Fri, 18 Apr 2025 at 05:26, Quentin Schulz <foss+uboot@0leil.net> w=
rote:
> >>>>
> >>>> From: Quentin Schulz <quentin.schulz@cherry.de>
> >>>>
> >>>> key-name-hint property in u-boot-spl-pubkey-dtb binman entry may con=
tain
> >>>> a path instead of a filename due to user mistake.
> >>>>
> >>>> Because we currently assume it is a filename instead of a path, binm=
an
> >>>> will find the full path to the key based on that path, and return th=
e
> >>>> dirname of the full path but keeps the path in key-name-hint instead=
 of
> >>>> stripping the directories from it.
> >>>>
> >>>> This means mkimage will fail with the following error message if we =
have
> >>>> key-name-hint set to keys/dev:
> >>>>
> >>>> binman: Error 1 running 'fdt_add_pubkey -a sha256,rsa2048 -k /home/q=
schulz/work/upstream/u-boot/keys -n keys/dev -r conf /home/qschulz/work/ups=
tream/u-boot/build/ringneck/u-boot-spl-dtbdhsfx3mf': Couldn't open RSA cert=
ificate: '/home/qschulz/work/upstream/u-boot/keys/keys/dev.crt': No such fi=
le or directory
> >>>>
> >>>> Let's make it a bit more obvious what the error is by erroring out i=
n
> >>>> binman if a path is provided in key-name-hint (it is named key-name-=
hint
> >>>> and not key-path-hint after all).
> >>>>
> >>>> Fixes: 5609843b57a4 ("binman: etype: Add u-boot-spl-pubkey-dtb etype=
")
> >>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>>> ---
> >>>>    tools/binman/etype/u_boot_spl_pubkey_dtb.py              |  2 ++
> >>>>    tools/binman/ftest.py                                    |  7 +++=
++++
> >>>>    .../binman/test/348_key_name_hint_dir_spl_pubkey_dtb.dts | 16 +++=
+++++++++++++
> >>>>    3 files changed, 25 insertions(+)
> >>>>
> >>>
> >>> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>>
> >>> The change log seems to be missing?
> >>
> >> The change log?
> >>
> >> Between v1 and v2? It's in the cover letter of the series, this is how
> >> b4 handles it, not per-patch change log.
> >
> > Oh dear, that's harder to work with. I believe someone is working on
> > b4 so perhaps that feature could be added?
> >
>
> https://lore.kernel.org/tools/CAOiHx=3Dm8tPANa+5A2dohEdkz48aPgH1g7ZXvF4uL=
mEu+SCo6DA@mail.gmail.com/t/#u
>
> seems to indicate it's possible to do this manually within the editor
> when doing a git commit, by adding stuff after a --- line. I checked,
> seems to be working fine indeed?
>
> The cover letter will still have a new changes entry, so I guess this
> will somehow duplicate the work, with having to list the changelog in
> two different places and making sure they keep in sync somehow?
>
> Note that you can also do a
>
> b4 diff --compare-versions 1 2
>
> which will do a range-diff of both versions and you'll see differences
> for yourself. Note that the same limitations as for the typical
> range-diff apply, namely that if the changes are too big, it won't
> attempt at comparing the commit diffs, during rebases the git context
> may pollute a bit the output.
>
> This seems like it's bothering you, but you're the first to complain
> since I've started to use b4 a while ago. I don't mind doing it, but it
> would be nice to know for which subsystems/projects I need to do this
> (and hopefully remember doing it :) ). Should we have some documentation
> for that maybe? And not specific to a specific tool used for contributing=
?

It depends on the size of the series, but if the change log is not in
the patch then I struggle to match it to the patch and in practice I
don't really take much notice of a change log in the cover letter, or
perhaps of the patch in general.

But I'm not looking for people to do manual work.

My question was really whether b4 could add this feature, if people
are starting to use it more, as I had understood that someone is now
working full-time on Linux tooling.

The feature is in patman, which also keeps the change logs in sync
between the cover letter and the patches. It isn't that hard to do.

Regards,
Simon
