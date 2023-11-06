Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BD5C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 17:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F548702F;
	Mon,  6 Nov 2023 18:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L2QoIkKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0165186F9A; Mon,  6 Nov 2023 18:25:36 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74CDE8701B
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 18:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5441305cbd1so5770880a12.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 09:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699291530; x=1699896330; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nk6r45gCJFINrCpPcr6xdgHGvJUfhj37x0TdiBVvcDk=;
 b=L2QoIkKwkdGPOYCirAsaazWZTRhlsK3NqYG4EPbelTfh3xwSjhbt78c8mu8JlVIauV
 mEH4Det+ZrNJsuC20aT1T9Dd7wfeSlMG8Vf2fci6w0tADWoxCFAWpjTWlwMYEPhYQAFY
 RaS9UrqWdltN9hK9qQdzp6u0AZEIlCi6kXNhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699291530; x=1699896330;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nk6r45gCJFINrCpPcr6xdgHGvJUfhj37x0TdiBVvcDk=;
 b=EcwpSbX/i4QyCj6adjz74USWkvpfyzEF/Bl2ZgixDqmnr28UxeKFEMrB9QveZfx1Qg
 OIftzfHwPx+98TyHkuynKIs3AfUm13XT86KAOJGRFUYo7Lq0VTYSMhZHE/lef3+lr1vl
 20VZqalTTTd+NGmQeMyb5pF+hO03K5ss+jzT1LYRNkhHBwJXtev2qof3s1jK7rJTU0Mj
 XjfJrgO+QGKk7W5mre993XlHiTvdaw82OH18fVVDImtoTPpXvMf17EraSmTmKaUgffhC
 imGXsrpuzXBNvd/Kl38CUzo8TLQgZ3c7fD+EdJTGwNBAMOYtE/6+3OWc1utueU6/0lFG
 ATzw==
X-Gm-Message-State: AOJu0YxGxSDTuPeu7RDsYldznngCjJLLgUhqLyqR6mya0z1fIpAZ6Fx7
 ErxfN46HU4UvKFCFDO1TRBSwazHWQLjYzvAXGukOcQ==
X-Google-Smtp-Source: AGHT+IHmGeZTI0iXSQB1aS5lZ9jMPHK1RriFWxMtWpb2QSRmu6UjdtZa9I9rtntPZvRpBdmokBHx/s/POyGnugk2u4c=
X-Received: by 2002:a50:baa7:0:b0:533:97c:8414 with SMTP id
 x36-20020a50baa7000000b00533097c8414mr25211535ede.7.1699291529885; Mon, 06
 Nov 2023 09:25:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJaLiFw67ztCo5TY=TPQneYgE5q6RHnj_XbnukQD=qhec3oRdg@mail.gmail.com>
 <CAPnjgZ3T8TOQbQKuy3wwfgb2K3sG5RDQdZ2zOxYT62XgGmVezg@mail.gmail.com>
 <CAJaLiFwx0j6Knthtgdy-wGDxaHYDuYEUws2LAkt05stc3f3ZBw@mail.gmail.com>
 <CAPnjgZ1FAEDs-f01Q-RCAV=sMWq40cD5UDo9O6SbqTRazS9gQA@mail.gmail.com>
 <CAJaLiFzsJP5u5ziHW7U5_0uqeGdr4uxHRG7kso2K-jahqLKBsg@mail.gmail.com>
 <CAJaLiFyqr88c8L1Lg+99XnP4geebwqrdKhSV4_h9uf1Mjr94Qw@mail.gmail.com>
In-Reply-To: <CAJaLiFyqr88c8L1Lg+99XnP4geebwqrdKhSV4_h9uf1Mjr94Qw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Nov 2023 10:25:15 -0700
Message-ID: <CAPnjgZ1vxy+hYpHaCGC=g2sFOK_xPCP4N_QFvxdO4xVb-SP+FA@mail.gmail.com>
Subject: Re: bootstd: Scanning for USB bootflow will remove existing SCSI
 bootflow
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Tony,

On Wed, 4 Oct 2023 at 21:23, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Hi Simon,
>
> On Mon, Oct 2, 2023 at 12:25=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wro=
te:
> >
> > Hi Simon,
> >
> > On Sun, Oct 1, 2023 at 6:22=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> > >
> > > Hi Tony,
> > >
> > > On Tue, 26 Sept 2023 at 13:40, Tony Dinh <mibodhi@gmail.com> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Tue, Sep 26, 2023 at 4:37=E2=80=AFAM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > Hi Tony,
> > > > >
> > > > > On Mon, 25 Sept 2023 at 14:02, Tony Dinh <mibodhi@gmail.com> wrot=
e:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > Here is an observation during testing the bootflow command.
> > > > > >
> > > > > > If there is a SCSI bootflow, scanning for USB bootflow will rem=
ove that existing
> > > > > > SCSI bootflow. To bring it back, I scanned for SCSI bootflow ag=
ain, and it was
> > > > > > back to normal. Perhaps there is some kind of indexing problem?
> > > > >
> > > > > Yes that's right. The 'botflow scan' command is not additive. The
> > > > > first thing it does is removing existing bootflows.
> > > >
> > > > Thanks for clarifying that. I assumed it is additive, because the
> > > > existing USB bootflow was not removed when I did a "bootflow scan
> > > > scsi" immediately after (see the end of the log).
> > >
> > > Yes, but I'm not sure what is going on there. Perhaps it is a bug?
> > > When you scan SCSI it should not also scan USB.
> >
> > Yes, it looks like a bug. I think I can see the problem and am working
> > on a patch.
>
> Just to let you know, I'm out of time to work on this topic. I will
> revisit it some other time, if you have not already tracked it down.

If you are able to use 'bootflow scan -l' in each case, then I might
be able to see what it is scanning USB, when you are asking for SCSI.
I also wonder if this bug may have been fixed due to other changes?

Regards,
Simon
