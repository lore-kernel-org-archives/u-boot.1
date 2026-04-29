Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DDDFF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 311F2848B4;
	Wed, 29 Apr 2026 16:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nnSa/vdm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A73B848AA; Wed, 29 Apr 2026 16:44:22 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEEB984894
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bb962ce4dcfso147167766b.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777473859; cv=none;
 d=google.com; s=arc-20240605;
 b=Pu2hVwZe3x6wjEsTdL2lkfRbyZHwYh103OeoEL4oxABsNoAFuyVSHVfr0AQvQlZ6AV
 pW6HdBkZUbbauyyHfg1qoewLo09/r37txyK8dFWcMxqvGAFqeLNR4XNFMxGsoJdnixeV
 aaEVetTRjbxvOo5PXe3cbXYJwF3lrH53r/NoPiSSmnGT5FLVnPhc+uGCgzPkjLSwkKpc
 Jn9/AUGTGSRWdeqxdZqAlLWX+zZgtL89OlsJr91OLJLBXTn9hpb4NkdySTByn4qDYFjQ
 OfWMJcIt76nqXG3FbemZGu+L3vGG7eNlKjlXsVaCgOb5AwytrVK4EeHDShyVca27/cm0
 plzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4NOLjY+Fa1Y3+atw8EIYG0USzqspBOyzujtYoi+/pHM=;
 fh=SPi/X0WlztfyTm38DRlSkfy/6oW86yZLUHiv9TSsvno=;
 b=ZYQ2QpF/6bVzxcZoBAImQoKi5MDTzFCFx32qb0jo9mDYUw6Z06Ov7xMIRiBn6vfNWR
 jvXiw9tMuQdLuazHPrMZr0/xvGAW+qEo+R41DmOyeAgtPwiLpqCCQr0HeFw9XHftzSnJ
 aKneR7LfCBWinCcgxPORT6nuRi5itlGCBN36mnQq9Vc6Kjy59DsklAUc2mPDNE0toJi8
 PRQLxfiBorzpyfPaGy5vUuOH6uTBB67bhbOWpfsd1zyvsRb0XmpPNhl6hMXgp7wp/bVF
 DqTYvghDZIpf7beHxP1DHzbWFPagGLkUnhK6v3FoxkU9AO49sxNKFxJaSmYWGuWIslSJ
 ZEag==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777473859; x=1778078659; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NOLjY+Fa1Y3+atw8EIYG0USzqspBOyzujtYoi+/pHM=;
 b=nnSa/vdmJbVpUc7jnXtMGo4Fx6ktLy4keo+DaznJNTnP4I1z1CfJ8fDdcxTaHDFQ6b
 Ct2JVm3XMNagfPNWx6mS301ru3CBTFh6M4qqEbgl76Nj33XStj1WPqyyO5OPtd9/Y4ch
 s3c5mQjMLGCwTtjLTr1qqsM2YldpsaiuM673w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473859; x=1778078659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4NOLjY+Fa1Y3+atw8EIYG0USzqspBOyzujtYoi+/pHM=;
 b=RlVB3TyEhKSbI/TdqD3dxAgwIhW3q14rB340Cce2YVx9sIIYgrDQKsAPyHHS7R3g52
 d/V6RydOIsyjAmZqP4N+S2WkU4il16TcsXgfbAZKj/wtUzU/5xIg8MHRiD3ot3gRMoo1
 TAd/eucyH/lmoQM1W6pZpGeKcr2lwfCt6hv9ri+S7xvinKye7t8LbJ9I7+KmnfawW6Ts
 0Iu+3p6/YMp84wRvY1L0/oKUuJiw56r5+hoVgqC5VfHQHb+HFlJhrBwb7q7dsDSEFr96
 0DBhNDJ7Q15cTWKfx8P8aKXAOnjhfhNqDtLSgciqJu7VkPepBv4RhDasY0Hrx34kmCWH
 Y48Q==
X-Gm-Message-State: AOJu0YwaTxcNTvdBQtwQucE9KT1vSyuLFSNusOlK8lZ319jvyFCxneLz
 Qvm0izToM/xijaFQ2MyyB2bIi5bvEgIeBIR//5r6pJC5x8Mbe4ALCos78GedCJ/qHaTOAlLMa6C
 DLEpwDqmH9dnITPaCApssJit24YKAZkoWgM6j41NV
X-Gm-Gg: AeBDietB7lBbnbEyZO7v+a26u0GM/6j8l+I6dJGED8w2DB2aDRId1/T32sEnzOsidbO
 E/k/a5MG6fC+D1L3Dt7o/o/7nSbmwjHUqGH2eXn6+v5taEiIo+IROrEeZIvzyk7Xm2FyEEXLjTk
 EHfxcMltG4P1Ky54mzXUpkqL1Q+mYoEENQ4C808G0n/96zaKboDf+81rD+MUanl8Ob5DHJ2kfv/
 g35BikBO3xWK29htYlQzDr6G8of47GmApIdvexcUUzuoYiOjwkuPZaFCrKvBwQbjca4EvjcWn+d
 8YpZUYKEKDmLavlQ
X-Received: by 2002:a17:907:c311:b0:bb7:c32d:c34b with SMTP id
 a640c23a62f3a-bb804f1b0c2mr499716766b.45.1777473859097; Wed, 29 Apr 2026
 07:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260423042824.3480-1-briansune@gmail.com>
 <CAFLszThg=EamyRohxNA7V+nk+OMVK356nUjAVSbu4+kokOJpdA@mail.gmail.com>
 <CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_uJjNwsHAhdmY3Q@mail.gmail.com>
 <CAFLszTgouk66AOaL2o8PvH9EKNFabE=pjxpa9QpC_F--VhE9cQ@mail.gmail.com>
 <CAN7C2SC-MuqHK2+0vaZzZFi-up1L7=KcOSRedF6f6F3D9Uoceg@mail.gmail.com>
In-Reply-To: <CAN7C2SC-MuqHK2+0vaZzZFi-up1L7=KcOSRedF6f6F3D9Uoceg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:44:07 -0600
X-Gm-Features: AVHnY4Ia1Ev1tPM31ZHyiJn8AYht7R1XaXIhqi0np_Ln8U6-iD-RxP4PmfxKfSo
Message-ID: <CAFLszTjz5SMpFMPjVd6tX5Lk9DKv3MMX+_qtkSgt6fztGceHFA@mail.gmail.com>
Subject: Re: [PATCH v6] Improve handoff prepare on SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de, Chee Tien Fong <tien.fong.chee@altera.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi Sune,

On Wed, 29 Apr 2026 at 08:34, Sune Brian <briansune@gmail.com> wrote:
>
> On Wed, Apr 29, 2026 at 10:21=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > Hi Brian,
> >
> > On Tue, 28 Apr 2026 at 08:34, Sune Brian <briansune@gmail.com> wrote:
> > >
> > > On Tue, Apr 28, 2026 at 10:04=E2=80=AFPM Simon Glass <sjg@chromium.or=
g> wrote:
> > > >
> > > > Hi Brian,
> > > >
> > > > On 2026-04-23T04:28:24, Sune Brian <briansune@gmail.com> wrote:
> > > > > Improve handoff prepare on SoCFPGA
> > > > >
> > > > > Ensure qts folder header files are properly updated by isolating
> > > > > the Python execution environment. This prevents partial or failed
> > > > > script runs from corrupting the target directory.
> > > > >
> > > > > Changelog v5 -> v6:
> > > > >  - Clean HANDOFF_KEEP comments.
> > > > >
> > > > > Changelog v4 -> v5:
> > > > >  - Change HANDOFF_KEEP condition to if [ '$${HANDOFF_KEEP:-0}' !=
=3D '0' ]
> > > > >  - Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk
> > > > >
> > > > > Changes:
> > > > >  - Implement a temp folder for Python script execution.
> > > > >  - Clean temp folder automatically despite execution failures.
> > > > >  - Gate the file replacement process on the successful exit of
> > > > >    the Python scripts.
> > > > >  - Execute the replacement (with or without keep) only upon scrip=
t
> > > > >    success via the NEW HANDOFF_KEEP=3Dxxx variable.
> > > > > [...]
> > > > >
> > > > > arch/arm/mach-socfpga/config.mk | 39 ++++++++++++++++++++++++++++=
++++++++---
> > > > >  1 file changed, 36 insertions(+), 3 deletions(-)
> > > >
> > >
> > >
> > > Dear Simon,
> > >
> > > B.C. the server is down and I don't expect Google to have an auto fai=
l
> > > mailing recovery.
> > >
> > > > I see 6 copies of this v6 patch in patchwork, so I wonder if I got =
the
> > > > right one?
> > >
> > > I will try to respond to this email as politely as possible.
> > > Please reference from "patchwork.ozlabs.org" list.
> > >
> > > > The per-version changelogs belong below the '---' separator, not in
> > > > the commit body. Also U-Boot convention is 'Changes in vN:' rather
> > > > than 'Changelog vN -> vN+1:'.
> > > >
> > > > You could try using 'patman' which will get this right for you auto=
matically:
> > > >
> > > > https://docs.u-boot.org/en/latest/develop/patman.html
> > > >
> > >
> > > 1) I only do basic software
> > > 2) I used ./script/checkpatch.pl There are no errors, warnings etc.
> > > 3) There is nothing to do with the patch itself either the software
> > > nor the file itself.
> > > 4) I am not too familiar with patman
> > > 5) There are many better things to do rather than complaining about
> > > the patch headers.
> > >
> > > So forgive me I really don't give a damn on whatever the header requi=
rements.
> > > If you feel this is not passing the patch standard simply reject or
> > > label all patches to
> > > "Changes Requested".
> >
> > That's up to whoever applies this patch. I am just a reviewer :-)
>
> Hi Simon,
>
> I am going to ignore all your mail in the future.
> So review whatever you like, don't care.
> There are many patch not following whatever rules or guidelines you
> mentioned.
> Just review those as well. What a waste of time on your emails.
>
> As politely as possible!!!

Oh, sorry about that and also the server being down, etc.. The
maintainer for SoCFPGA will handle applying this in any case.

> Brian
>
> >
> > The reason for the formatting rules is mostly so that maintainers can
> > apply them without manually redoing the patch, etc.
> >
> > There is also this which might help (although you might not want more r=
eading):
> >
> > https://docs.u-boot.org/en/latest/develop/sending_patches.html#commit-m=
essage-conventions

- Simon
