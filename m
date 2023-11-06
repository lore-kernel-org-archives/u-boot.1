Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8855AC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 20:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E01D086F1E;
	Mon,  6 Nov 2023 21:52:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z6XN8H0F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 446FF87001; Mon,  6 Nov 2023 21:52:04 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 438A586D11
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 21:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c6b30acacdso66045121fa.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 12:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699303921; x=1699908721; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qIhGWFEs8ENjHver2M0EBj6gf1pYZsSv2rp80q0j/u0=;
 b=Z6XN8H0FS1Q9V/Kb9Dou2SkGw6PGiynJ5P7OfNi/VGohHW8E0N3meZBGnL1Mm4VQTQ
 tgG4nVPmfO2ZVH9V+msTz9WYxm2avOxm7VVZaObZDQ83dZvfP6wMKbaXhMvFsqm9wYlF
 3tDsmJuCzZ8ZvVICZRYzhIcBvTM9JlojHY2wqE2Kb4dCkIa+DePsLktH4B/TulqwxcRJ
 3gtDmW25hvtps+L9tjjLvJsyrgw1goceInWXQlPRmwc599ZpPD5noJAZ2F5etNi8pKKe
 +3lGprwfyjuHzGq2o29qDecjDtRxy4Oi0pt9ywgvrcDkrcS0NsPB+0+o0AnUSqhaR9Dh
 1o5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699303921; x=1699908721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qIhGWFEs8ENjHver2M0EBj6gf1pYZsSv2rp80q0j/u0=;
 b=OK4r/vNZx2TXrebKP4ppOI8xxP5wdu5AErZahUJyYbMwJLNE/fwNl+um9wlQ4Zsmld
 FgQdfMoobte2ZE/3u9gPzL9QuMI9q27ihKDFngDK+SEf8yo4r/gaYcy0X+kOu+0Y7wbF
 ZQ41COg4vJ6mrT41/OwZYfmT/VtU+iLWvXJRwASt5zqT5kSKL7vm0Wkpt905h3PvO58z
 LXprot28rQfVuaalLh5IHR3LLqqFMZ6F/2HEwTMmM5dqsVkKML2esYNFgMMUljGit3Wt
 15vaXxp6PY+AIpa1qg9K2VkJ0drm3kP7ZpOScR7oEHpQFT4uOKZ2TbcnE8Zhwkk/1aQ9
 WK4Q==
X-Gm-Message-State: AOJu0YzGbBX/lycowLOy9fvBb8BfaG6i3jwbLqt80dP7rLcNh+g2apI6
 Tz1F6fHzCS/3ATRLiVZ1cH2Ninptrf8wq8Ni1qc=
X-Google-Smtp-Source: AGHT+IFha/2I807MZ68ZTsN1NDNHx6+tKxrQxYd+P//8qdHjp5KUgH0Wxu3ubtnPPEJMTyEQT98B6lJLHQ6B2aWwsu0=
X-Received: by 2002:a05:6512:4026:b0:507:a16d:cf55 with SMTP id
 br38-20020a056512402600b00507a16dcf55mr29639204lfb.68.1699303921202; Mon, 06
 Nov 2023 12:52:01 -0800 (PST)
MIME-Version: 1.0
References: <CAJaLiFw67ztCo5TY=TPQneYgE5q6RHnj_XbnukQD=qhec3oRdg@mail.gmail.com>
 <CAPnjgZ3T8TOQbQKuy3wwfgb2K3sG5RDQdZ2zOxYT62XgGmVezg@mail.gmail.com>
 <CAJaLiFwx0j6Knthtgdy-wGDxaHYDuYEUws2LAkt05stc3f3ZBw@mail.gmail.com>
 <CAPnjgZ1FAEDs-f01Q-RCAV=sMWq40cD5UDo9O6SbqTRazS9gQA@mail.gmail.com>
 <CAJaLiFzsJP5u5ziHW7U5_0uqeGdr4uxHRG7kso2K-jahqLKBsg@mail.gmail.com>
 <CAJaLiFyqr88c8L1Lg+99XnP4geebwqrdKhSV4_h9uf1Mjr94Qw@mail.gmail.com>
 <CAPnjgZ1vxy+hYpHaCGC=g2sFOK_xPCP4N_QFvxdO4xVb-SP+FA@mail.gmail.com>
 <CAJaLiFzLFOH08CGRt5QY4-keSuO=947_gF1meyRiMWz5H0gcyg@mail.gmail.com>
 <20231106195057.GD496310@bill-the-cat>
In-Reply-To: <20231106195057.GD496310@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 6 Nov 2023 12:51:49 -0800
Message-ID: <CAJaLiFwRQAX1GJ=JDLS=F=kz=PF-b+9wLBRxG40JhvjzVP+9Ug@mail.gmail.com>
Subject: Re: bootstd: Scanning for USB bootflow will remove existing SCSI
 bootflow
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, Nov 6, 2023 at 11:51=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Nov 06, 2023 at 11:42:51AM -0800, Tony Dinh wrote:
> > Hi Simon,
> >
> > On Mon, Nov 6, 2023 at 9:25=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> > >
> > > Hi Tony,
> > >
> > > On Wed, 4 Oct 2023 at 21:23, Tony Dinh <mibodhi@gmail.com> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Mon, Oct 2, 2023 at 12:25=E2=80=AFPM Tony Dinh <mibodhi@gmail.co=
m> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Sun, Oct 1, 2023 at 6:22=E2=80=AFPM Simon Glass <sjg@chromium.=
org> wrote:
> > > > > >
> > > > > > Hi Tony,
> > > > > >
> > > > > > On Tue, 26 Sept 2023 at 13:40, Tony Dinh <mibodhi@gmail.com> wr=
ote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Tue, Sep 26, 2023 at 4:37=E2=80=AFAM Simon Glass <sjg@chro=
mium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Tony,
> > > > > > > >
> > > > > > > > On Mon, 25 Sept 2023 at 14:02, Tony Dinh <mibodhi@gmail.com=
> wrote:
> > > > > > > > >
> > > > > > > > > Hi Simon,
> > > > > > > > >
> > > > > > > > > Here is an observation during testing the bootflow comman=
d.
> > > > > > > > >
> > > > > > > > > If there is a SCSI bootflow, scanning for USB bootflow wi=
ll remove that existing
> > > > > > > > > SCSI bootflow. To bring it back, I scanned for SCSI bootf=
low again, and it was
> > > > > > > > > back to normal. Perhaps there is some kind of indexing pr=
oblem?
> > > > > > > >
> > > > > > > > Yes that's right. The 'botflow scan' command is not additiv=
e. The
> > > > > > > > first thing it does is removing existing bootflows.
> > > > > > >
> > > > > > > Thanks for clarifying that. I assumed it is additive, because=
 the
> > > > > > > existing USB bootflow was not removed when I did a "bootflow =
scan
> > > > > > > scsi" immediately after (see the end of the log).
> > > > > >
> > > > > > Yes, but I'm not sure what is going on there. Perhaps it is a b=
ug?
> > > > > > When you scan SCSI it should not also scan USB.
> > > > >
> > > > > Yes, it looks like a bug. I think I can see the problem and am wo=
rking
> > > > > on a patch.
> > > >
> > > > Just to let you know, I'm out of time to work on this topic. I will
> > > > revisit it some other time, if you have not already tracked it down=
.
> > >
> > > If you are able to use 'bootflow scan -l' in each case, then I might
> > > be able to see what it is scanning USB, when you are asking for SCSI.
> > > I also wonder if this bug may have been fixed due to other changes?
> >
> > I'm wondering about that, too. I will rerun the test with the master
> > branch with debug trace. If we cannot see it, I'll do it again when
> > other bootstd patches are merged. Right now I am not sure which of
> > your bootstd patches I should apply to the tree for testing, do you
> > have a list for that?
>
> Right now the only outstanding bootstd patch I know of is your recent
> one, as I was waiting for Simon's review (which he did today) before
> merging and applying.

Thanks Tom! I'll run the test in my tree as is then.

All the best,
Tony
