Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5A8C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 07:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB04878FA;
	Wed, 27 Dec 2023 08:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fxcHh5ta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B659387899; Wed, 27 Dec 2023 08:40:54 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62FEE878A1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-67f83812a32so30639076d6.3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 23:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703662851; x=1704267651; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K61uHjVKctLX+tGZLnhCYBFO24S3r3aQkA/YvTqW+Nc=;
 b=fxcHh5tazNYaGLtMIBRs3XKJcvIlyxvbMxIJX5tZXIxR7fGHC0yLIOZnz3PVy+DlIE
 5v25fiCkRPLSePiTTwYhIqpOfyon0RUFCPZT7cFK1VcESiCwGZQEdE4Omq4Ljt4i1X+s
 TUBh6RuDyGTjmE5Qw3dM0P50ObyFft473qjdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703662851; x=1704267651;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K61uHjVKctLX+tGZLnhCYBFO24S3r3aQkA/YvTqW+Nc=;
 b=VHxtY1s2HUelgP0daVtxbXJDXiI5jVbAHC1tPCvKj/IOHElSPP3Sy3TcsDpA8j47Dc
 LU7cn6aP0+y5VO0DrmY6tSLBXKzdmIBWH09P84HdzPLNgEyELmjX72P59gKbqR/TvheS
 ZGkEj5lvY4pC+zsbOcAicCCdfhLiu0ZEaR2fUhZCoVPTpiLvbJE/HIGLAzFNnUglHZ9c
 NX0ebVVDjbtOIaGQw/Hea9iTw7yTBGM27aLaV/TgfSAJMKAu1FgpAVVn9uHn1EohB8Ej
 iKAQt3H1c+dhwToXvunVZ8A9OvSnuAhV8889VotvsfQhv5stInERNlS/vr6pv6bSzFnK
 sanw==
X-Gm-Message-State: AOJu0YwtxGpQFiMflO1gnHeCJp+6iPN6gicjWPEY8IOrprWJjOmvUOD0
 FofmMvznXojJIjT3CApayiPiXqdg4MbWVWWSpez61sFL7sb7
X-Google-Smtp-Source: AGHT+IHJjfgHgI0cyRYzy7k203rq+tfdzsWRNgwka1iyOpYBEE+QZuHuRIPIIeV9ckghYqNGsvwD9hrsvdsOr6b1SuA=
X-Received: by 2002:ad4:4145:0:b0:67f:e030:d31f with SMTP id
 z5-20020ad44145000000b0067fe030d31fmr4330079qvp.131.1703662851136; Tue, 26
 Dec 2023 23:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-6-xypron.glpk@gmx.de>
 <CAFLszThrHODfu-ZhHEzRe5wT-nMpXAp=UCBJC3FipTi9owhajQ@mail.gmail.com>
 <f66c51bb-7dd8-432b-9579-598eb3619c04@gmx.de>
In-Reply-To: <f66c51bb-7dd8-432b-9579-598eb3619c04@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Dec 2023 07:40:40 +0000
Message-ID: <CAFLszTimwDXjbQrER+808pezWD_1UaMk+g56RzNmo9Bwc9Uuew@mail.gmail.com>
Subject: Re: [PATCH 5/5] test: unit test for smbios command
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

On Tue, Dec 26, 2023 at 10:11=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> On 12/26/23 10:47, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sat, Dec 23, 2023 at 12:49=E2=80=AFAM Heinrich Schuchardt <xypron.gl=
pk@gmx.de> wrote:
> >>
> >> Provide a unit test for the smbios command.
> >>
> >> Provide different test functions for QEMU, sandbox, and other systems.
> >>
> >> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> ---
> >>   test/py/tests/test_smbios.py | 47 ++++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 47 insertions(+)
> >>   create mode 100644 test/py/tests/test_smbios.py
> >
> > Can you please write this test in C?
> >
> > Regards,
> > Simon
>
> According to our documentation we can use either Python or C tests.
> We generally use Python tests for testing the CLI.

Not really...there are lots of C tests for the CLI. It is actually
easier to code, in most cases.

>
> I cannot see any benefit in trying to write this in C.

I did go to some effort to document this:

https://docs.u-boot.org/en/latest/develop/tests_writing.html#test-types

Regards,
Simon
