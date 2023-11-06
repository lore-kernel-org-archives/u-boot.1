Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE68C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 19:43:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B98F286F87;
	Mon,  6 Nov 2023 20:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LYJOsPd6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF1E986F5D; Mon,  6 Nov 2023 20:43:06 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 969BE8644E
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 20:43:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-543c3756521so8113324a12.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 11:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699299784; x=1699904584; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNme11VbryGiyyjBpK0Y7ZnQwBuSW0l+OEZSGBrJDr4=;
 b=LYJOsPd6s+oxax20VUBdViHPZF1HJ2x3GNRmyE6X9HozdyyIn+lHHvzJpkYGIu3yCR
 VQVfD583L3tvIbgsnNriQY3BuP6zRxVODgww2rQv0T54TY041CLNv3g5wx3G2/+MxJ1q
 XA7xmvX1ICpK1q4G7IGz3uMOzm3TQDknSKKlshVwDpzLsWRmP4tLLS7Deiu5q+P/kHhF
 vU9kVXFHCAI8zAmOpLOOOLku2wuFal9ROtEh7Ixx5eUv7j/dPpcGumX/LTwZg6KOaSpe
 Q9igvJeGBjIoEfh61e0lEkLE/0O4kfeUE3ztkU6rqCgJAiHiy3JysyEs2Kd4qdeZ4JWt
 z3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699299784; x=1699904584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UNme11VbryGiyyjBpK0Y7ZnQwBuSW0l+OEZSGBrJDr4=;
 b=VNkrcfoRhGbUafM039inLJeRgsCMQGd0efr3BuWFXmB8w96APBq/ig0BBDFKQRfhRR
 5NqcVT1u/hs0HGWPAruMHA80cS1J/9CpTqXpouRQ+ocu52o500FFCHBzYxFcnQnk1WCh
 lCGMHxiDVy9nOXo8KN3wmfH3tOHU2lh13uVW3luwDw4jj2z0E7nbPwacsbzoSHjvdf9h
 x8/eMZof6JD7LaiTZsE+TPdpw/vYrP5U3Xd89BvxZLQyy7J1fcEaGfnbHWn9EfKoa28k
 yfUt3cIP8E024PQb1yQ3crMpivKs9NZ+x3FIcsSolMGDRbpn/NjmvCXEiYzVlDN3s3P8
 np3w==
X-Gm-Message-State: AOJu0YxqM1utBzsh+Puo1kXzJq6744iSE8HS3Srn8EvwO5szCFbc71vS
 betETRAMTB5zuu7AbK1l69Qr+955DIfpWaGFs5o=
X-Google-Smtp-Source: AGHT+IFV4Ik3goU80hNsuos2ix1HBrjxJk/PgLfILuCWvG84idBsKQEQ7+pBRj7wFuG48zSOgV7cAkv0B8rRVeAvG0Q=
X-Received: by 2002:a05:6402:229a:b0:541:875:53d8 with SMTP id
 cw26-20020a056402229a00b00541087553d8mr21911867edb.23.1699299783822; Mon, 06
 Nov 2023 11:43:03 -0800 (PST)
MIME-Version: 1.0
References: <CAJaLiFw67ztCo5TY=TPQneYgE5q6RHnj_XbnukQD=qhec3oRdg@mail.gmail.com>
 <CAPnjgZ3T8TOQbQKuy3wwfgb2K3sG5RDQdZ2zOxYT62XgGmVezg@mail.gmail.com>
 <CAJaLiFwx0j6Knthtgdy-wGDxaHYDuYEUws2LAkt05stc3f3ZBw@mail.gmail.com>
 <CAPnjgZ1FAEDs-f01Q-RCAV=sMWq40cD5UDo9O6SbqTRazS9gQA@mail.gmail.com>
 <CAJaLiFzsJP5u5ziHW7U5_0uqeGdr4uxHRG7kso2K-jahqLKBsg@mail.gmail.com>
 <CAJaLiFyqr88c8L1Lg+99XnP4geebwqrdKhSV4_h9uf1Mjr94Qw@mail.gmail.com>
 <CAPnjgZ1vxy+hYpHaCGC=g2sFOK_xPCP4N_QFvxdO4xVb-SP+FA@mail.gmail.com>
In-Reply-To: <CAPnjgZ1vxy+hYpHaCGC=g2sFOK_xPCP4N_QFvxdO4xVb-SP+FA@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 6 Nov 2023 11:42:51 -0800
Message-ID: <CAJaLiFzLFOH08CGRt5QY4-keSuO=947_gF1meyRiMWz5H0gcyg@mail.gmail.com>
Subject: Re: bootstd: Scanning for USB bootflow will remove existing SCSI
 bootflow
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Mon, Nov 6, 2023 at 9:25=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Tony,
>
> On Wed, 4 Oct 2023 at 21:23, Tony Dinh <mibodhi@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > On Mon, Oct 2, 2023 at 12:25=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> w=
rote:
> > >
> > > Hi Simon,
> > >
> > > On Sun, Oct 1, 2023 at 6:22=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > > >
> > > > Hi Tony,
> > > >
> > > > On Tue, 26 Sept 2023 at 13:40, Tony Dinh <mibodhi@gmail.com> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Tue, Sep 26, 2023 at 4:37=E2=80=AFAM Simon Glass <sjg@chromium=
.org> wrote:
> > > > > >
> > > > > > Hi Tony,
> > > > > >
> > > > > > On Mon, 25 Sept 2023 at 14:02, Tony Dinh <mibodhi@gmail.com> wr=
ote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > Here is an observation during testing the bootflow command.
> > > > > > >
> > > > > > > If there is a SCSI bootflow, scanning for USB bootflow will r=
emove that existing
> > > > > > > SCSI bootflow. To bring it back, I scanned for SCSI bootflow =
again, and it was
> > > > > > > back to normal. Perhaps there is some kind of indexing proble=
m?
> > > > > >
> > > > > > Yes that's right. The 'botflow scan' command is not additive. T=
he
> > > > > > first thing it does is removing existing bootflows.
> > > > >
> > > > > Thanks for clarifying that. I assumed it is additive, because the
> > > > > existing USB bootflow was not removed when I did a "bootflow scan
> > > > > scsi" immediately after (see the end of the log).
> > > >
> > > > Yes, but I'm not sure what is going on there. Perhaps it is a bug?
> > > > When you scan SCSI it should not also scan USB.
> > >
> > > Yes, it looks like a bug. I think I can see the problem and am workin=
g
> > > on a patch.
> >
> > Just to let you know, I'm out of time to work on this topic. I will
> > revisit it some other time, if you have not already tracked it down.
>
> If you are able to use 'bootflow scan -l' in each case, then I might
> be able to see what it is scanning USB, when you are asking for SCSI.
> I also wonder if this bug may have been fixed due to other changes?

I'm wondering about that, too. I will rerun the test with the master
branch with debug trace. If we cannot see it, I'll do it again when
other bootstd patches are merged. Right now I am not sure which of
your bootstd patches I should apply to the tree for testing, do you
have a list for that?

All the best,
Tony

>
> Regards,
> Simon
