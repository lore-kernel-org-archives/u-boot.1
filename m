Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFFBEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:17:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8994F8645D;
	Tue, 22 Aug 2023 11:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mLiTY89n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A9508645E; Tue, 22 Aug 2023 11:16:57 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83FCB8645C
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2bbac8ec902so66395211fa.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692695814; x=1693300614;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqbYCvYPVM1nZ1YyuWiUZlNHQ99/I3VTmTnoxPaP6FA=;
 b=mLiTY89nHzTFJA2/WW30OHW4F+XhH2Z59XTJmgvxIjZzdd7J/Dpc9RmkzubHLpOl+Y
 adH8hB18ScwS/46IuPtyqDh8kd0I6/03bcxKpL+wGEXkgBN/Dh1CjbAPYxywV5bYe7Ss
 M0ApPxOan+ivUzpEKmTW78CFzZVUJXmJy6B6h7PzOciSBtzNBeqrdbgQXNUkRnFmzulW
 sEaWeYpivheY0ElLvAueqVcDB71KFpOSZ/wVHNNw8fuMwxyCoGk68aWTka06eniqaQKY
 6+BBHBhQbxHnPcjbZ12LeSouV0+eD6snLxb9HONArZPYZUfakMgYFjdRqgJsxulyEZNn
 efQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692695814; x=1693300614;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rqbYCvYPVM1nZ1YyuWiUZlNHQ99/I3VTmTnoxPaP6FA=;
 b=hlk0ZQ1C2ZORmDy7gpKl99cCF07XgJkRmnVwSC7a5FGn7R4SZFYSTaPV/C+ThAOGJl
 9C+GPFUqvgfP/3FBAup16q727pjGzIimo6RL3yhOLcJe+wOrB9/ZYYwoEMyRlV7Yuefl
 MyOf0UgINHRvJD7HrGiumQ1i9/jnJdsM6mdpV92FscG2PPzqfkmCUCOocZSwLYyKMn3L
 QF/akINtODE29waTjwh4Mxtp0bz3KJTFN0CgxnGrrt2eK7RDFVv4F+3Ke3AYpALtgMR3
 m2kQEEtCOodo0bEL4ROLMUTer3P/j4N/8rv2m0Rb91AXii3WTKg+p+ITDUDtMpP1/KIv
 oK8w==
X-Gm-Message-State: AOJu0Yy3LcdGhP6pBADLG+1nmy16bxLjAvAGI99drOPiLrtcCSklVwPB
 GHHZT4r2Mb2F+GLtkByEswBBwN34PwetvoKaeLI=
X-Google-Smtp-Source: AGHT+IFZ+FOFNUbq5FI2lmQgqBiB3Xwnqk+wvJBYJkeubhPL5/YIXPsv/JT3Lrjuax+7+xwfoJ/5i+kSSp8yq5x27cw=
X-Received: by 2002:a2e:b0da:0:b0:2b9:d7b7:36d4 with SMTP id
 g26-20020a2eb0da000000b002b9d7b736d4mr6511365ljl.16.1692695813574; Tue, 22
 Aug 2023 02:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230727215433.578830-1-sjg@chromium.org>
 <CAPnjgZ2krc9eTrCye9UC6=HM8oTrpVmv8mHEGHJRu5kqu7ts+w@mail.gmail.com>
 <CALeDE9OF_a-e=BOCfDG90uju4Ma7_mrLczAwOSo9rjvjR5sahw@mail.gmail.com>
 <CAPnjgZ0yfn6wvgP04scMm03v2irHCbCHdejZJoT+p+_NQrLkug@mail.gmail.com>
In-Reply-To: <CAPnjgZ0yfn6wvgP04scMm03v2irHCbCHdejZJoT+p+_NQrLkug@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 22 Aug 2023 10:16:42 +0100
Message-ID: <CALeDE9NkHMNE1+Xshgrq0FtKZ5mo809xXjo_YX2v9m8p5v63VQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] rpi: Convert to standard boot
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Matthias Brugger <mbrugger@suse.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
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

On Mon, Aug 21, 2023 at 8:13=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Peter,
>
> On Sat, 19 Aug 2023 at 07:53, Peter Robinson <pbrobinson@gmail.com> wrote=
:
> >
> > On Wed, Aug 16, 2023 at 4:08=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Matthias, Peter,
> > >
> > > On Thu, 27 Jul 2023 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > This series moves Raspberry Pi boards over to use standard boot.
> > > >
> > > > It also moves rpi over to use a text-based environment. Unfortunate=
ly it
> > > > is not possible to empty the header file due to several CFG options=
.
> > > >
> > > > Fix the repeated "and and" while we are here.
> > > >
> > > > Note that this reduces rodata size by about 4.5KB. We could get ano=
ther
> > > >
> > > > for a total image-size saving of about 15KB. This is mostly because
> > > > HUSH_PARSER is not enabled anymore and the environment shrinks down=
 by
> > > > about 3.5K. Hush is not actually needed anymore, since standard boo=
t does
> > > > not use it. Also CMD_SYSBOOT is dropped since standard boot calls t=
he
> > > > pxe_utils code directly in that case.
> > >
> > > It has now been about 6 months since I sent the v1 series of this.
> > > Even this v3 series is now out of date (in the cover letter).
> > >
> > > Is rpi still maintained?
> >
> > Yes, but we've had conversations about this in the past and snide
> > comments and regressions don't enamor me to your patches...
>
> I'm sorry for the snide comments.
>
> >
> > That said without seeing this email I actually started tested them yest=
erday.
> >
> > U-Boot isn't part of my $dayjob and I've had limited time of late,
> > that's slowly getting better.
>
> OK, good. We have seen quite a few regressions and bugs. I expect that
> to continue for at least a few more releases, as more boards pick this
> up.

Yes, tracking regressions, like the numerous ones on rockchip over the
last few releases, and making things continue to work for users have
been taking up the lions share of my free time and are definitely one
of the reasons I've been reticent to take these patches.

I have been following reports of supposed regressions upstream on the
Raspberry Pi boards and most of them are not regressions but rather
users looking to do things that aren't widely tested (NVME) or aren't
enabled by default (USB on CM4) and related pieces. We're certainly
not seeing them on Fedora.

I've pushed these patches to a Fedora build for wider testing and I'm
testing my devices more this week and should have a pull later in the
week.

Peter
