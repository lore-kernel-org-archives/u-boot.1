Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C564CC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 14:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C8A787858;
	Tue,  2 Jan 2024 15:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nvV90Xil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99A628785D; Tue,  2 Jan 2024 15:06:45 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FD6B87845
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 15:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-67fe0210665so47288366d6.1
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 06:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704204402; x=1704809202; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YEzzjkXQ6BpN4Wotm3eFqOpOeul8xwnKx1E+Pwzikzk=;
 b=nvV90Xili1XWEH91RsYUJ5DVbTRwuVpY8+HTXv0qfBz0JQWrhH0xoJeGLMRt3p0q/w
 qCRb/4dvbVybnxpAKHRbuoRiUjIyBQtLXgcgZ/+HxcayavZ9gLuBOlHSETZZaaP225Jc
 BolE/U4u9lzM9UKcXnH95ClcG9b3N9c8sKjAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704204402; x=1704809202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YEzzjkXQ6BpN4Wotm3eFqOpOeul8xwnKx1E+Pwzikzk=;
 b=pWyeqWpRB0dA6wwonK14fGIOv1xmrQdHY2vQcXQJoF/OIiWny5YGNb85LrzXp2r3rx
 SF+o3XiO3A8O/PR7Foo9FzU1I4NPaiyxjwWSQwPGG6KRKcnpkRt19QlfS3VRv1xN1hGX
 hyDb/+Wk0IgyImKadHn5M6hDFfErj1vwGDaS6xPQinG1qK8s2MEu8hTaU1+sPKs38jtx
 EPHvRaKRgBX/ouJttSsm1csYbHYg9sv49VFN23aPaIx/p3cha8FQXEyE2Kdg9+Jrxtur
 R6/BPbhAmlBARfzPyxbJm4O7hvV0lyJd8vN7Y9+gQt7Vdv+rNKhqkIHr9Tpv7T09ovkY
 YzCw==
X-Gm-Message-State: AOJu0YyAQ3Mj0OHjW3pgmwQL6Ik+Alvj5TictMj4n+l7vX4TNwJNVCnF
 GPlMOwoZkMvVdr9bz42Fjq+ICBsjaUnn0AnZ5UqhGmM6W7vk1QDL3IYqp8E=
X-Google-Smtp-Source: AGHT+IFka5af3ZTFbTBYN0EI3XowkoCS89GkOhf5h190ad2rGo/7WZlqEyTFQys9kXp/uDIj+HhvsS9S8vx7qmzsEMs=
X-Received: by 2002:a05:6214:2b0c:b0:67f:80d4:fcc with SMTP id
 jx12-20020a0562142b0c00b0067f80d40fccmr22817127qvb.12.1704204401975; Tue, 02
 Jan 2024 06:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20231228180154.50473-1-clamor95@gmail.com>
 <20231228180154.50473-5-clamor95@gmail.com>
 <CAFLszThd95iSPMOBr_21_Zckg74BtgA23EVpfXQKqnArFc-UDQ@mail.gmail.com>
 <CAPVz0n3OwhrW41tV9x32UXyL6yZdLr8CU9S7XuTneDiwUQY7AQ@mail.gmail.com>
 <8734vg5afv.fsf@baylibre.com>
In-Reply-To: <8734vg5afv.fsf@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jan 2024 07:06:31 -0700
Message-ID: <CAFLszTjmvpbxGguK+FuXZLO=kpYR4pVr4E27BGn1u0B-6uB2eQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] common: console: record console from the beginning
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, 
 Heiko Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
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

Hi Mattijs,

On Tue, Jan 2, 2024 at 2:52=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Simon, Svyatoslav,
>
> On Thu, Dec 28, 2023 at 21:52, Svyatoslav Ryhel <clamor95@gmail.com> wrot=
e:
>
> > =D1=87=D1=82, 28 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =D0=BE =
21:48 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On Thu, Dec 28, 2023 at 6:02=E2=80=AFPM Svyatoslav Ryhel <clamor95@gma=
il.com> wrote:
> >> >
> >> > From: Ion Agorria <ion@agorria.com>
> >> >
> >> > Set flag to enable console record on console_record_init
> >> > and not only on console_record_reset_enable. This fixes
> >> > missing start of U-Boot log for fastboot oem console
> >> > command.
> >> >
> >> > Signed-off-by: Ion Agorria <ion@agorria.com>
> >> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >> > ---
> >> >  common/console.c | 3 +++
> >> >  1 file changed, 3 insertions(+)
> >>
> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>
> >> OK, I can see the use of this...but I wonder if we can now get rid of
> >> the same line of code from console_record_reset_enable() ?
> >>
> >
> > Interesting question but let's leave it to a dedicated patch :)
>
> I've looked a little more into to this, and I'm not so sure we can get
> rid of the gd->flags |=3D GD_FLG_RECORD; in console_record_reset_enable()=
.
>
> Removing the flag seems to break quite some tests in
> test/py/tests/test_ut.py.
>
> The breakage can be explained that various unit tests clear the
> GD_FLG_RECORD with:
>
>         gd->flags &=3D ~GD_FLG_RECORD;
>
> Therefore, I would suggest we keep the flag in
> console_record_reset_enable().

From my look all of those are not needed in tests, i.e. are bugs. If
you are able to do a patch to remove those lines, it would avoid the
confusion.

Also, by setting UT_TESTF_CONSOLE_REC for a test, console recording is
set up automatically, so the console_record_reset_enable() is not
needed at the start of the test.

Regards,
Simon
