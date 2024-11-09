Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D47D64099
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 02:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F9088E14;
	Sat,  9 Nov 2024 03:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ITO4C++7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7225588F7B; Sat,  9 Nov 2024 03:12:58 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D7488E0F
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 03:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e2e87153a3so2074535a91.3
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 18:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731118374; x=1731723174; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7INcVwujoff45W47etFVovzqgpoMjUrsQpASO0jcDlA=;
 b=ITO4C++7GnkJq4K/m+roolsNv/jb9GwKlak7+32TprUiAFBCZWB0EEfUCv4XxwOv3l
 GL18LGk7Ep2nW/IBQaXRVOel0XD+KPUsQnhtPh710JgE+e1llgkoMtPrevYCCeNwGPuG
 BmQM1YcexasBORoC6dk2rj02wk+zdUXsDcEj/+WiovpKHWgSEgXiPf65TJr66sByCizg
 xbKjUCC5GUEtZw5NPuhIyDbu0wyhgKuGGf6KdmY5m63VZnYVamvDLuNliDX3CCKTqLJA
 qaBm90QaUcnjx0xGLp8q54yB/JybvaKukiiJ8F21XVgs+jlAIYUuV3R95bbi7LPA78Sf
 Fgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731118374; x=1731723174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7INcVwujoff45W47etFVovzqgpoMjUrsQpASO0jcDlA=;
 b=StiN+yNEaDgcbQqn8LuGYdGJ3Ek2oYFXaDbrk0ypafpBB72rmsuiDxbE+T495cVO85
 6bz8H/bUBvMYeXVhetb1KF1ePwyv8EXscwLpywvcDjuhAHXEALN844qCpSFScUCuckdC
 kYx5Ggf9TPS5TGR7G7zU//j0jZfjXCCQmSoL1bAOKHF6r92I9+7Dr2CIBaO8aBeMJuH7
 kc7p6LLL6uLVp9oDI/tfQkd+mosH/a2BI5F9PyD3GIBa3lxDJKv5uNmbqw6xgkNzw5AU
 yZX3qeIOd0chr9JNJGPSxaBrayPEpQ2jrDnwFyMHig4sKrDOEZL3sNkPoMujaflkCLj5
 DAug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqDfMFD16okntzWJjs6cLKf8LZI8ZllfWm2xIuNWhKbxTRLIg5/MZ+v0qwohISsnpHS9PZL8I=@lists.denx.de
X-Gm-Message-State: AOJu0Yy92lremWzg7M9v0QR+20jj7on6dxNSBcGxKuxzjFd6ggiBdVVu
 uLMSz/AN4YY33gtBkTLDGsEyzGVdI6GIl6czo1qL3wo4nxhpYSfN6Rn0odhcE+C/u8AnCpM3a+F
 YcqYbKycCBGBip+qzRbq3Mqrrb/Q=
X-Google-Smtp-Source: AGHT+IFMD6zIRVPNfg1RnALCCmUUkGG3p4SkvXuKx+qcpF8wNgx1MRMg4u+T0c9joXWIIxA2KYiGmkl4LXBC6tseHLc=
X-Received: by 2002:a17:90b:5484:b0:2d3:c9bb:9cd7 with SMTP id
 98e67ed59e1d1-2e9b178fd92mr6245697a91.36.1731118374139; Fri, 08 Nov 2024
 18:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20240808110654.4215b129@wsk>
 <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
 <20240815221421.61f64a17@wsk>
 <CAOMZO5B-fkLQsQx205mxXQdmk3ij6Hxx4ErM84DtEtBg3mYa7Q@mail.gmail.com>
 <CAFLszTggpR9aaDAH_Mx_zDNnKAb7r_O+sdyyVVG_xULqkrWnzg@mail.gmail.com>
 <20240828100452.2143873d@wsk>
 <CAHCN7xLY4FxB4HZLcE0pEZsx7V=dhVokh2Wcrn2Jjf+B+SLCJg@mail.gmail.com>
 <20240905155402.486a7110@wsk>
 <CAHCN7x+jLfzMGFUcbAfHr9u_2s3Z=LxN-TNCtbzUUop66p4Rpw@mail.gmail.com>
 <CAHCN7xK3-iUUGf20-JxAWfK05-te=sskbdpU4kU8ahy8sfROFg@mail.gmail.com>
 <20241104091418.74acd1f1@wsk>
 <CAHCN7xKGW2+_8P0nnMM6gyJVPQOw15S2pFUhwwuv13JVqY3qNA@mail.gmail.com>
In-Reply-To: <CAHCN7xKGW2+_8P0nnMM6gyJVPQOw15S2pFUhwwuv13JVqY3qNA@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 8 Nov 2024 20:12:42 -0600
Message-ID: <CAHCN7x+K14RkvbDdCHPq+YaH7bXSBH-6Sdwnb1+TULCE-H5puw@mail.gmail.com>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
To: Lukasz Majewski <lukma@denx.de>
Cc: Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>
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

On Fri, Nov 8, 2024 at 7:04=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> On Mon, Nov 4, 2024 at 2:14=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wr=
ote:
> >
> > Hi Adam,
> >
> > > On Sun, Nov 3, 2024 at 7:41=E2=80=AFPM Adam Ford <aford173@gmail.com>=
 wrote:
> > > >
> > > > On Thu, Sep 5, 2024 at 8:54=E2=80=AFAM Lukasz Majewski <lukma@denx.=
de>
> > > > wrote:
> > > > >
> > > > > Hi Adam,
> > > > >
> > > > > > On Wed, Aug 28, 2024 at 3:04=E2=80=AFAM Lukasz Majewski <lukma@=
denx.de>
> > > > > > wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > On Tue, 27 Aug 2024 at 12:47, Fabio Estevam
> > > > > > > > <festevam@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Lukasz,
> > > > > > > > >
> > > > > > > > > On Thu, Aug 15, 2024 at 5:14=E2=80=AFPM Lukasz Majewski
> > > > > > > > > <lukma@denx.de> wrote:
> > > > > > > > > > Unfortunately not - this change is only for properly
> > > > > > > > > > setting start address of the u-boot.
> > > > > > > > > >
> > > > > > > > > > The _real_ problem here is the symbol placement
> > > > > > > > > > generated by binman when we try to define the image as
> > > > > > > > > > a single one.
> > > > > > > > > >
> > > > > > > > > > Moreover, this change follows other boards with imx8mm
> > > > > > > > > > processor - ./configs/imx8mm_beacon_fspi_defconfig to b=
e
> > > > > > > > > > specific.
> > > > > > > > > >
> > > > > > > > > > The "fix" (for which I'd been now probably opt) for
> > > > > > > > > > this issue would be to generate two images with binman
> > > > > > > > > > - one for u-boot-spl-ddr.bin and the final flash.bin
> > > > > > > > > > with the former one included (as it was before SHA1:
> > > > > > > > > > 37e50627efacd8dae18b564e9d8886a033e181bc)
> > > > > > > > >
> > > > > > > > > Is QSPI boot broken on i.MX8MM?
> > > > > > > > >
> > > > > > > > > I am adding Adam and Mamta who have tested QSPI booting o=
n
> > > > > > > > > imx8mm_beacon and imx8mm_evk, respectively.
> > > > > > > >
> > > > > > > > Note also that I sent a series[1] which allows the
> > > > > > > > symbols-base to be adjusted, if that helps.
> > > > > > >
> > > > > > > I've seen them - but not yet tested.
> > > > > > >
> > > > > > > Thanks Simon for the patch series.
> > > > > >
> > > > > > Is it still broken with this patch series?  I have been
> > > > > > traveling and haven't had much time to test.
> > > > >
> > > > > Yes, I can confirm that it is still broken.
> > > >
> > > > Sorry for the delay.  I had to return my 8MM to Beacon, and I was
> > > > waiting for a replacement.
> > > >
> > > > To not prolong it anymore, I decided to try it with an 8M Nano, and
> > > > I got a boot failure on master. I was able to successfully boot
> > > > 2024.01-rc5, but I haven't had time to bisect it yet.  I'll try to
> > > > do that this week.  I think once we can bisect the error, it might
> > > > become more apparent.
> > >
> > > Git bisect narrowed down the git which broke the build:
> > >
> > > commit 37e50627efacd8dae18b564e9d8886a033e181bc (HEAD)
> > > Author: Marek Vasut <marex@denx.de>
> > > Date:   Fri Apr 26 01:00:37 2024 +0200
> > >
> > >     ARM: dts: imx: Convert i.MX8M flash.bin image generation to binma=
n
> > >
> > > I am guessing the binman isn't prepending the header stuff.  I'll try
> > > to investigate it this week.
> >
> > This is the problem with adjustments.
> >
> > I've prepared following fixes for it (but are not upstreamable):
> > https://github.com/lmajewski/u-boot/commits/phycore-imx8mm-qspi-nvme
> >
> > (problem is with wrong offsets assigned -> 0x1000 switch)
> >
> > Unfortunately, I don't have the HW any more at hand.
>
> I think we should try to generate two binaries.  The original
> flash.bin file with the references to the FSPI stuff removed and the
> offsets left as if FSPI booting doesn't exist, then a second binary
> which adds the FSPI header at 0x400 and append the original flash.bin
> file (build for sd booting) moved to offset 0x1000.
>
> I manually created a binary like this using DD and it worked, but
> building the image with the various offsets in the device tree appears
> to break both SPL and U-Boot phases.
>
> I tried to create a second file node to do this, but I don't
> understand the binman stuff enough to have been successful.  I have
> only tried the Nano, but I will test a Mini as soon as I can get my
> hands on one again.

I think I have a fix for the Nano.  I want to get my hands on a Mini
again to test it.  My solution creates two files, a flash.bin for
booting SD/eMMC and a second file which adds the FSPI header at 0x400
with the whole standard image starting at 0x1000.  I have been able to
boot both the SD and eMMC's with one config option which can allow me
to remove the FSPI config file and consolidate both configs into one.
Once I can verify it works on Mini, I'll post my proposed fix.

adam

>
>
> adam
> >
> > >
> > > adam
> > >
> > > >
> > > > adam
> > > >
> > > > >
> > > > > I've applied:
> > > > > https://patchwork.ozlabs.org/project/uboot/cover/20240826191143.4=
26387-1-sjg@chromium.org/
> > > > >
> > > > > on top of mainline:
> > > > > SHA1: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
> > > > >
> > > > > Adding symbols-base =3D <0>; to imx8mm-u-boot.dtsi did not help.
> > > > >
> > > > > >
> > > > > > adam
> > > > > > >
> > > > > > > >
> > > > > > > > Regards,
> > > > > > > > Simon
> > > > > > > >
> > > > > > > > [1]
> > > > > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D4=
21010
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Best regards,
> > > > > > >
> > > > > > > Lukasz Majewski
> > > > > > >
> > > > > > > --
> > > > > > >
> > > > > > > DENX Software Engineering GmbH,      Managing Director: Erika
> > > > > > > Unter HRB 165235 Munich, Office: Kirchenstr.5, D-82194
> > > > > > > Groebenzell, Germany Phone: (+49)-8142-66989-59 Fax:
> > > > > > > (+49)-8142-66989-80 Email: lukma@denx.de
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > Best regards,
> > > > >
> > > > > Lukasz Majewski
> > > > >
> > > > > --
> > > > >
> > > > > DENX Software Engineering GmbH,      Managing Director: Erika
> > > > > Unter HRB 165235 Munich, Office: Kirchenstr.5, D-82194
> > > > > Groebenzell, Germany Phone: (+49)-8142-66989-59 Fax:
> > > > > (+49)-8142-66989-80 Email: lukma@denx.de
> >
> >
> >
> >
> > Best regards,
> >
> > Lukasz Majewski
> >
> > --
> >
> > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> > Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.d=
e
