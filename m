Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF6FCA0FF9
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 00:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F2BA86703;
	Sat,  2 Sep 2023 02:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R1huqaWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 930B88679F; Sat,  2 Sep 2023 02:09:50 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8884A8669D
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 02:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52a069edca6so3318797a12.3
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 17:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693613387; x=1694218187; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AndRtDmSVhlJX42z/SNOR/nS0NKdEvkg0PSSEfMLMZw=;
 b=R1huqaWben4dGqw1EzXEcQPhIYx3lPpRIn6sRmsqoxR6lcSDS1k/IWIcvIn9CFQvFy
 oQxdhU2Q7iKJAqLud6j47PIuY+O+ViOqhssd88PuP8J0JKlb78Vv5a817ndfuszIW8tn
 ZUZTloTn0oXHoyrd9u9X/dJgUhcP6df5F+9DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693613387; x=1694218187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AndRtDmSVhlJX42z/SNOR/nS0NKdEvkg0PSSEfMLMZw=;
 b=hK/hw6pRUhktoRE3hKQ+bunQSE6jAznhqZjENUyLfopunQsylZXozGe0yJJMU6TRkq
 nRSax9Z6ICdSCfFuAYu2YueFJ7S5QQfL6/5RnaOkmHQtVWdUGytwXxiNtirHyUFo+KI3
 M/QLbmLxvuqZ77/d3at8AIBHi3NlitPfmPdlgA8XmZp0hDJMaEyVCq5Hs3HdiD+NOgL/
 ZG0GnlGxo7bhRQEuKVVfxAE7d95RTJbKc0qC1k3V0ua5ld5/QRxfg6//2IVmn0DFQs+y
 pTIQQfDTq6i4nsrNV2BsDayr8YAMifREDqfHe/+wKdz/QrV7jar57L2hRTbOobrNtIq6
 YuAQ==
X-Gm-Message-State: AOJu0Ywm1zoEU3YZo44D8yAKwJiUHEilXpeMhky39fKw/CYvXqFRYVYS
 VXzo8VyLzuaemw/uP1FsXpmwKTuGjqMAgGiBrNrfqA==
X-Google-Smtp-Source: AGHT+IE54zpy6rJTodUBLCbpkfVNLKAQrQxyjdxw/3Ve/DsfxJwsCIsNbyYTZJ2ByJWgmWd0cOyQP+Jwq+JTToBFUf4=
X-Received: by 2002:aa7:d615:0:b0:523:2e63:b9b with SMTP id
 c21-20020aa7d615000000b005232e630b9bmr3334165edr.24.1693613387032; Fri, 01
 Sep 2023 17:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230619120011.1587499-1-sjg@chromium.org>
 <20230619125956.v4.32.Ia13846500fab3d5a1d5573db11a040d233994fa6@changeid>
 <CAEUhbmXa_ADjVmnqZrhbam_BS5nYKoQx4P7Z6DB-zsX3DcO2ig@mail.gmail.com>
 <CAPnjgZ1LN1R9qYc=yJYrQ8OMRu5FyGj8MY8UQxFKgWO_PGzj2g@mail.gmail.com>
 <CAEUhbmWug6K-rWfMZKcrTMdvc58RLbMguj3RwkRdGy32J-Xc1g@mail.gmail.com>
 <CAPnjgZ3Ox6uw=6mnkMyrw6Osa974rfTp8YC=NmiDtLuzgUqMPQ@mail.gmail.com>
 <CAEUhbmXXLxZNNUO9tEZTEJeNHoMmVmxqTDu=e-8=T2iaM+kzbw@mail.gmail.com>
 <CAPnjgZ34WtaxM1yF2sz+zvWD_b=_Zy-yPokgB4K5-CucY607Ag@mail.gmail.com>
 <CAEUhbmVXObKogOXH91kxq_MNXWQAE4aMbeqFm4JXsW3kctEZLw@mail.gmail.com>
 <CAEUhbmWb_F7t0qM=Ygpv77cjvtWuiDT1k9a6rbdkj-rgVQor=Q@mail.gmail.com>
 <CAPnjgZ3KdzT5Hrr7TmmZstM3aVg9-ZDDKRX-xQgwMRJJGOwaZQ@mail.gmail.com>
 <CAEUhbmWkfs+PQxo79oiM5MOWjPAnojt5bdsXopqmc9-W_Qkd+Q@mail.gmail.com>
 <CAPnjgZ1wUWrQGrgJoPLSvO+Rz7N5Ns22oxMNdd3YtDAngVBcwQ@mail.gmail.com>
 <CAEUhbmUCZ08oU1TfhW+djQu6espSW2YE=ywyY_0_Ya2QQkEfVQ@mail.gmail.com>
In-Reply-To: <CAEUhbmUCZ08oU1TfhW+djQu6espSW2YE=ywyY_0_Ya2QQkEfVQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Sep 2023 18:09:24 -0600
Message-ID: <CAPnjgZ2fPmHLW11uMQRjxsrKi=Vgy3VTeqQPna1FQxF2-RuVBA@mail.gmail.com>
Subject: Re: [PATCH v4 32/45] fs: fat: Support reading from a larger block size
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Bin,

On Wed, 2 Aug 2023 at 07:18, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Wed, Aug 2, 2023 at 8:50=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Bin,
> >
> > On Tue, 1 Aug 2023 at 07:47, Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Tue, Aug 1, 2023 at 9:26=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > > >
> > > > Hi Bin,
> > > >
> > > > On Mon, 31 Jul 2023 at 04:54, Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > >
> > > > > On Mon, Jul 31, 2023 at 6:33=E2=80=AFPM Bin Meng <bmeng.cn@gmail.=
com> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Fri, Jul 28, 2023 at 7:56=E2=80=AFAM Simon Glass <sjg@chromi=
um.org> wrote:
> > > > > > >
> > > > > > > Hi Bin,
> > > > > > >
> > > > > > > On Wed, 19 Jul 2023 at 01:58, Bin Meng <bmeng.cn@gmail.com> w=
rote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > On Wed, Jul 19, 2023 at 9:11=E2=80=AFAM Simon Glass <sjg@ch=
romium.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Bin,
> > > > > > > > >
> > > > > > > > > On Sun, 16 Jul 2023 at 09:19, Bin Meng <bmeng.cn@gmail.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Simon,
> > > > > > > > > >
> > > > > > > > > > On Sun, Jul 16, 2023 at 7:42=E2=80=AFAM Simon Glass <sj=
g@chromium.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Bin,
> > > > > > > > > > >
> > > > > > > > > > > On Thu, 13 Jul 2023 at 04:49, Bin Meng <bmeng.cn@gmai=
l.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, Jun 19, 2023 at 8:02=E2=80=AFPM Simon Glass=
 <sjg@chromium.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > At present it is not possible to read from some C=
DROM drives since the
> > > > > > > > > > > > > FAT sector size does not match the media's block =
size. Add a conversion
> > > > > > > > > > > > > option for this, so that reading is possible.
> > > > > > > > > > > >
> > > > > > > > > > > > I am completely confused. The CDROM uses iso9660 fi=
le system. This has
> > > > > > > > > > > > nothing to do with FAT.
> > > > > > > > > > >
> > > > > > > > > > > It actually can use both - this is the -cdrom option =
in QEMU which can
> > > > > > > > > > > emulate an old-style CDROM, with a FAT filesystem on =
it!
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > What QEMU command line is this to enable a CDROM with F=
AT file system?
> > > > > > > > > >
> > > > > > > > > > If that is the case, what you changed in this commit on=
ly works with
> > > > > > > > > > QEMU, not with any real-world devices, I believe?
> > > > > > > > > >
> > > > > > > > > > Could you use iso9660 instead?
> > > > > > > > >
> > > > > > > > > Sure, but the image I am using has an MSDOS partition nam=
e, an EFI
> > > > > > > > > partition table, a FAT filesystem and an ISO9660 filesyst=
em! I was
> > > > > > > > > trying to look at the FAT filesystem via the MSDOS partit=
ion table.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Is that a released installer iso that I can download somewh=
ere?
> > > > > > > >
> > > > > > > > Which QEMU command line should I use for reproducing the is=
sue?
> > > > > > >
> > > > > > > Here is what I did:
> > > > > > >
> > > > > > > qemu-system-x86_64 -m 2G  -smp 4 -bios /tmp/b/qemu-x86/u-boot=
.rom
> > > > > > > -cdrom /vid/software/linux/debian/debian-11.5.0-i386-DVD-1.is=
o -serial
> > > > > > > mon:stdio
> > > > > > > =3D> part set ide 2 iso
> > > > > > >
> > > > > > > Partition Map for IDE device 2  --   Partition Type: ISO
> > > > > > >
> > > > > > > Part   Start     Sect x Size Type
> > > > > > >   1     6912        1   2048 U-Boot
> > > > > > >   2     5912     1000   2048 U-Boot
> > > > > > > =3D> ls ide 2:2
> > > > > > > FAT sector size mismatch (fs=3D512, dev=3D2048): translating =
for read-only
> > > > > > >             efi/
> > > > > > >       160   ubootefi.var
> > > > > > >
> > > > > > > 1 file(s), 1 dir(s)
> > > > > > >
> > > > > > > =3D>
> > > > > > >
> > > > > > > Without this patch we cannot enable translation and it is not=
 possible
> > > > > > > to read the files.
> > > > > >
> > > > > > I cannot reproduce this issue.
> > > > > >
> > > > > > I investigated this a little bit, and it looks the iso image yo=
u are
> > > > > > using is of the so-called "isohybrid" [1] type. Almost all rece=
nt
> > > > > > Linux distros release their CDs using the isohyrbrid format.
> > > > > >
> > > > > > So with isohybrid I think you can directly boot this using the =
"-drive
> > > > > > file=3Dxxx.iso,if=3Dvirtio" without this patch, no?
> > > >
> > > > Yes, that's right.
> > > >
> > > > > >
> > > > > > [1] https://wiki.syslinux.org/wiki/index.php?title=3DIsohybrid
> > > > > >
> > > > >
> > > > > I don't think QEMU's -cdrom should work with the isohybrid format
> > > > > images. The isohybrid image is a hack, according to the Rufus aut=
hor
> > > > > [1].
> > > > >
> > > > > The isohybrid images are nothing different from the normal harddi=
sk
> > > > > images, so it should only work with the disk controllers that exp=
ect
> > > > > the 512 byte sector size.
> > > > >
> > > > > The -cdrom should work with the original iso image, for example,
> > > > > distros 10 years ago, like Ubuntu 10.04 [2]
> > > > >
> > > > > [1] https://superuser.com/a/1527373/241386
> > > > > [2] https://old-releases.ubuntu.com/releases/10.04.0/ubuntu-10.04=
-desktop-amd64.iso
> > > >
> > > > I think this patch is needed when virtio is not used, but for virti=
o
> > > > it is not needed.
> > >
> > > For other block interfaces like if=3Dnvme, if=3Dsd, they are not need=
ed too.
> > >
> > > As I said in the comments, only -cdrom needs this patch to work with
> > > IsoHybrid images, but I don't think that's a valid use case.
> >
> > OK, should we document that -cdrom is not supported by U-Boot? It is
> > quite confusing since when I tried it, since the built-in thing
> > (seabios) work fine.
> >
>
> Yeah we need to document -cdrom is supposed to work with the original
> iso format images, not the recently invented iso hybrid image.
>
> If SeaBIOS works with -cdrom + isohybrid then it must have done some
> hack as well.

OK I sent a doc patch.

Regards,
Simon
