Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF3BCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D00A87248;
	Thu, 19 Oct 2023 16:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gCI5rSp9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCDF187232; Thu, 19 Oct 2023 16:07:15 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E63868722B
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53db360294fso13988643a12.3
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697724430; x=1698329230; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nx7S/HpGvFfxaPO0feMyDrZ0J2ORTbR5GKMexKg/r3o=;
 b=gCI5rSp9oqZlwlQAW0MZO+3qVYAjF3sSKLTWu6ROb4sE7gPv3UzjgnsCnsj7adPt/d
 ZNmz8+TSQsYqS1yRchCpXv0HuwUeXlUoizgx9VNQvx9zipM9V6VW7+GF/NS2iasksYrq
 MU6MfnHID2UYXWx2sagoVL031K1xFvplPUJh9s/R6YherP/4m6Lfjj2wwBoN4YlGLYYt
 CoPW9U1eT1tG83PrnqW6IC/+1DFdN2Gqwd1n8eScCujg95CxQMVp72A70htsLsvkSOZm
 Z+2+QOF2Id/Vjj3qgG6dpbDBnc5JKAr3nAXiz2kyc3mqdb/LE/GVOUs/ybjeIi9bKO04
 r3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697724430; x=1698329230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nx7S/HpGvFfxaPO0feMyDrZ0J2ORTbR5GKMexKg/r3o=;
 b=qcuJDCZbrk2AiYFuY3ji6akoTAEs5k0F/QWcgvHaitckcyqg++X8VISkd9IhHRkDdO
 MPH8BAkUeJvsKJu7e2oZ+1qNMv1Gusu+oFPVXm+CoeKPVb33eWOOp0+xITvxDcT1I5Lc
 9nCsIcjUwVHQCbpvSUnk36QSOPeF95BTHrwvsiTANDq8x+9u941ZhEs9E5XJpMvW3dmE
 6Tgo0DM+i3GmJIbGSueyiqjlvVI7J5N270QOvgI/YW25X+mbcJ9KDnwShiIzLvmTBlUu
 OdM2FVyPOhxHJg1GdXlCyXkwil5z599Naddb7ChPGXPDpbo4q/CPpiF+vZVXruYBo1OE
 5WYw==
X-Gm-Message-State: AOJu0YyJyFKBkCpBhQJ9MONbS7bsYGiWoFesGGMqPeHmdnS2H1+y2H1V
 gqQeG69nh/RTvV9ZhgwrDBWIdGe13vjrOwl0XWB7ev4T
X-Google-Smtp-Source: AGHT+IHFkdeJx9zVbu0EQEvitlmkqptgML7YjERujCVDOUyZj4cUYqnryMQH8LMWVp0ItYFvMFyHFKhhfQYM7AhftEI=
X-Received: by 2002:a05:6402:254e:b0:53f:a526:779 with SMTP id
 l14-20020a056402254e00b0053fa5260779mr904969edb.12.1697724430488; Thu, 19 Oct
 2023 07:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CALeDE9N6nhRBwtYqJ=7nqYuCsmbw03j3RBXRQ8jYsD=OMY=gBw@mail.gmail.com>
 <VI1PR08MB28474179AFB989B308072B1E83CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CAPnjgZ3t9-trzoLGc7Jcj0=J0sQLQcHSGN3_Pf+3=iZ6=rPPqA@mail.gmail.com>
 <CALeDE9Oh9c+X5tG9RswuE=a=yQRW-j93q2oHJeOehLHHY2bSgw@mail.gmail.com>
 <CALeDE9MnMuHSH4sgAC+Z2_+71QgToHt8e8rib3igxFDKV+DYWw@mail.gmail.com>
 <20231013174850.GT3119521@bill-the-cat>
In-Reply-To: <20231013174850.GT3119521@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 19 Oct 2023 15:06:48 +0100
Message-ID: <CALeDE9ODXAgEVM3bmzd6Y+fry-UyVM8Do0OJTNJyLjwgaMXFLw@mail.gmail.com>
Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Guillaume Gardet <Guillaume.Gardet@arm.com>,
 Matthias Brugger <mbrugger@suse.com>, Ivan Ivanov <ivan.ivanov@suse.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, Oct 13, 2023 at 6:48=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Oct 13, 2023 at 05:22:03PM +0100, Peter Robinson wrote:
> > On Fri, Oct 13, 2023 at 5:09=E2=80=AFPM Peter Robinson <pbrobinson@gmai=
l.com> wrote:
> > >
> > > On Tue, Oct 10, 2023 at 3:58=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, 10 Oct 2023 at 04:39, Guillaume Gardet <Guillaume.Gardet@ar=
m.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Peter Robinson <pbrobinson@gmail.com>
> > > > > > Sent: Tuesday, October 10, 2023 12:22 PM
> > > > > > To: Guillaume Gardet <Guillaume.Gardet@arm.com>
> > > > > > Cc: mbrugger@suse.com; Ivan Ivanov <ivan.ivanov@suse.com>; Simo=
n Glass
> > > > > > <sjg@chromium.org>; u-boot@lists.denx.de
> > > > > > Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
> > > > > >
> > > > > > On Tue, Oct 10, 2023 at 10:26=E2=80=AFAM Guillaume Gardet
> > > > > > <Guillaume.Gardet@arm.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > U-Boot 2023.10 does not boot from uSD on RPi4.
> > > > > > > This has been found on openSUSE Tumbleweed. The only diff we =
need is:
> > > > > > >   -CONFIG_OF_EMBED=3Dy
> > > > > > >   +CONFIG_OF_BOARD=3Dy
> > > > > > > To use firmware provided Device Tree. But that should not aff=
ect the mmc
> > > > > > behavior too much, I think.
> > > > > >
> > > > > > I've been booting Fedora fine on a RPi4 BUT there's issues with=
 the display
> > > > > > turning off [1] when the accelerated display modules load
> > > > > > (vc4) as a result of this patch set. Can you confirm if that's =
the same problem
> > > > > > you're seeing?
> > > > >
> > > > > No, that's not my problem. My issue is grub was not loaded by u-b=
oot from uSD.
> > > > > It seems more like Simon's problem: https://lists.denx.de/piperma=
il/u-boot/2023-October/533162.html
> > > > >
> > > > > @Simon, can you check if the patch below fixes your boot problem =
on RPi4, please?
> > > >
> > > > This has been reported at least twice before. There is a fix [2] wh=
ich is in my queue to apply.
> > >
> > > Looking at that patch it scans the first 3 devices, how does it handl=
e
> > > non storage devices like SDIO WiFi modules? It shouldn't be trying to
> > > scan those.
> >
> > And in the case of the RPi the other enabled SDHCI interface is the
> > WiFi, why would we even be trying to boot off a non storage interface,
> > something here just feels broken/wrong in general.
> >
> > The patch does make it work with pure upstream, and I'm not sure why
> > the Fedora build boots it fine out of the box, but the patch just
> > feels like it's hacking around some other underlying problem with
> > bootstd, we didn't have this problem with the previous method and
> > trying to boot off non storage interfaces feels like it could cause
> > other problems.
>
> I think the answer here is that we're doing the best we can given that
> we just don't know until run time what we have. In the case where sdhci

Well that's not entirely true in the case of mmc/sdhci, we know what
devices could be storage, such as when a device is a mSD or eMMC or a
wifi interface, those don't change from boot to boot, a SDHCI
interface on one boot is not mysteriously going to become a emmc
storage unit the next boot.

> is something other than storage, we get as far as asking "are you a
> block device?" which then fails when sdhci is a WiFi an not an eMMC.
> This does mean the user could notice "Card did not respond to voltage
> select! : -110" being printed, and I don't know if we should do
> anything about that (it's a handy message when your uSD isn't fully
> inserted, etc).  But since we (can) support everything on a single
> build, we just have to figure it out at run time.

It has caused issues and it causes bug reports from users which is an
issue for me as a maintainer as it wastes my time. In short it's not a
great user experience.

Overall the last few U-Boot releases have been a nightmare from my
PoV, I have spent *all* my available time for upstream U-Boot dealing
with regressions.

In the case of the RPi I currently have 3 issues, 1) display 2) mSD 3)
USB (that Ivan has also mentioned). The 3 of these together make
things very hard to bisect and I am struggling. I also have 3 other
devices with issues I'm trying to debug for the Fedora release, and
the asahi people have also reported [1] regressions in their fork. I
honestly regret applying the bootstd patches.

When even Simon [2] is losing track of things I think we need to
change approach, the problems here upstream are nearly breaking me and
for Fedora I am now considering just forking U-Boot and cherry picking
the patches from upstream we need for particular devices and features.
It's absolutely not something I want to do but I feel it's getting to
the point I need to do it for the Fedora users and my sanity.

I like the concept of bootstd and other features but the quantity of
patches, and sometimes other series of change for changes sake, where
the testing is clearly either not there, or is relying on "it works on
CI" [3] (and other examples) and is clearly not tested on real HW
makes some of the churn hugely problematic, similarly the applying of
patches when there's been opposition and push back for the sake of it
(eg NFSv1 patch) as is things like force enabling people's pet
projects (looking at VBE here) where there's no actual real world
users and real security ramifications (alternate unaudited boot
methods of devices) also adds to my thought process for forking.

I feel we as a project need to have a proper discussion about these things.

Peter

[1] https://bugzilla.redhat.com/show_bug.cgi?id=3D2244305#c6
[2] https://lists.denx.de/pipermail/u-boot/2023-October/534348.html
[3] https://lists.denx.de/pipermail/u-boot/2023-October/534442.html
