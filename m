Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E55D111A0
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 03:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA01889138;
	Mon,  4 Nov 2024 04:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ozfpf98l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8506088DA0; Mon,  4 Nov 2024 04:35:41 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A27AC89148
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 04:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e5a0177531so2846861a91.2
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 19:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730691337; x=1731296137; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sL8CgHXo6gEKvF9i9zyzyFD3LVmVIN8emGN/5lPlSxs=;
 b=Ozfpf98l2PtmxhTMPyYdfq44T6INCWXVm3pTtZRxHf/AIezrTK1WImbnpQrNgfeXQ5
 cuzRZXoJeGFgPgn6opbEgcdxjUsRPouwIg6QIdBaLXEoCUID+BnSdaVKM773p7MFYrWz
 3kNUB/I6mKhNq6wbHEEiiQfNgSxape4uW9Vi7T3D9xzLRfkNynPR9MbYR5KOzHrHQYJJ
 ZUn7rPoyAxcQvbGvfra5goAj4ydbnP8pQPVauDqKZBgXXp1jFOvOdTKj+Of2kfqrMGWX
 P7Xmpm38EXkVbU+Psuqvt4gzij9T37QtJTAohC7Jb4LoYiz1mFi9w+sAfyzLkikstwbX
 rKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730691337; x=1731296137;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sL8CgHXo6gEKvF9i9zyzyFD3LVmVIN8emGN/5lPlSxs=;
 b=IHXH+XrvIjmO2MB9zJJSzVrQbmERyY5XAT3nzk5XoZGKGRzTDqF8slWAWHn4eu66h0
 DhYS+M54cmxjD6gb8BazMKW1vXvLWvb3YB0mEaK024Wbaox28PfRWyYlg5DwKFdj7kFJ
 8r5F1YsEoCRlSgotIzglEBMbR7MIWIQr6xvqmWCPCmfibXHQOqYrSMYTwHKvIv3sgHwF
 k3nXInGYPNowCarE5L/ROdct/SyO35Y6QxsGNfvxCUGV7Zlgt1FUoS53y4hvNmeWj5S+
 xTppjRY7+6bItQCE55Iiz8ce/EIGdxGcnqHHNV1Nx1OMWY4lEcUAKf3ZWoMrvBfyI85c
 HFvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRWGOd1n62KGOFsrjPJJqr/f3nRUlRD+TX1IqZ1ETo02PKhSR7wE5Cb9rMnbCL15KASoSFmeg=@lists.denx.de
X-Gm-Message-State: AOJu0YyzVWqSMDm7GKOhEiqCiUkGr6fHlWpAUbPN1iKjM/B3wgSQOwDG
 b932/rZxTN5Vi7b/LPfssOBe3nwlFerSj5SFk7mb0WkdyR3uG3ELBjAaboc8wERD2ao2fpo5Tie
 E1CHBLCCN8i2bnt0efF6EotDEPyc=
X-Google-Smtp-Source: AGHT+IGFF4vHQIR889H6esij1jVE1Fjo8SdNoSXXsisQqQ+eS5fp6Ypm3/RBZOvcRxKfq/DgR8faQ66T+igVQ/ql0Q4=
X-Received: by 2002:a17:90a:bb86:b0:2e2:e6bf:534b with SMTP id
 98e67ed59e1d1-2e8f11de31amr27116796a91.40.1730691336938; Sun, 03 Nov 2024
 19:35:36 -0800 (PST)
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
In-Reply-To: <CAHCN7xK3-iUUGf20-JxAWfK05-te=sskbdpU4kU8ahy8sfROFg@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 3 Nov 2024 21:35:24 -0600
Message-ID: <CAHCN7x+2BixvmtSrX2LmBCak4rXZ-b_5VCxhJsHSr2=QNy0KXA@mail.gmail.com>
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

On Sun, Nov 3, 2024 at 8:00=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> On Sun, Nov 3, 2024 at 7:41=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
> >
> > On Thu, Sep 5, 2024 at 8:54=E2=80=AFAM Lukasz Majewski <lukma@denx.de> =
wrote:
> > >
> > > Hi Adam,
> > >
> > > > On Wed, Aug 28, 2024 at 3:04=E2=80=AFAM Lukasz Majewski <lukma@denx=
.de> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Tue, 27 Aug 2024 at 12:47, Fabio Estevam <festevam@gmail.com=
>
> > > > > > wrote:
> > > > > > >
> > > > > > > Hi Lukasz,
> > > > > > >
> > > > > > > On Thu, Aug 15, 2024 at 5:14=E2=80=AFPM Lukasz Majewski <lukm=
a@denx.de>
> > > > > > > wrote:
> > > > > > > > Unfortunately not - this change is only for properly settin=
g
> > > > > > > > start address of the u-boot.
> > > > > > > >
> > > > > > > > The _real_ problem here is the symbol placement generated b=
y
> > > > > > > > binman when we try to define the image as a single one.
> > > > > > > >
> > > > > > > > Moreover, this change follows other boards with imx8mm
> > > > > > > > processor - ./configs/imx8mm_beacon_fspi_defconfig to be
> > > > > > > > specific.
> > > > > > > >
> > > > > > > > The "fix" (for which I'd been now probably opt) for this is=
sue
> > > > > > > > would be to generate two images with binman - one for
> > > > > > > > u-boot-spl-ddr.bin and the final flash.bin with the former =
one
> > > > > > > > included (as it was before SHA1:
> > > > > > > > 37e50627efacd8dae18b564e9d8886a033e181bc)
> > > > > > >
> > > > > > > Is QSPI boot broken on i.MX8MM?
> > > > > > >
> > > > > > > I am adding Adam and Mamta who have tested QSPI booting on
> > > > > > > imx8mm_beacon and imx8mm_evk, respectively.
> > > > > >
> > > > > > Note also that I sent a series[1] which allows the symbols-base
> > > > > > to be adjusted, if that helps.
> > > > >
> > > > > I've seen them - but not yet tested.
> > > > >
> > > > > Thanks Simon for the patch series.
> > > >
> > > > Is it still broken with this patch series?  I have been traveling a=
nd
> > > > haven't had much time to test.
> > >
> > > Yes, I can confirm that it is still broken.
> >
> > Sorry for the delay.  I had to return my 8MM to Beacon, and I was
> > waiting for a replacement.
> >
> > To not prolong it anymore, I decided to try it with an 8M Nano, and I
> > got a boot failure on master. I was able to successfully boot
> > 2024.01-rc5, but I haven't had time to bisect it yet.  I'll try to do
> > that this week.  I think once we can bisect the error, it might become
> > more apparent.
>
> Git bisect narrowed down the git which broke the build:
>
> commit 37e50627efacd8dae18b564e9d8886a033e181bc (HEAD)
> Author: Marek Vasut <marex@denx.de>
> Date:   Fri Apr 26 01:00:37 2024 +0200
>
>     ARM: dts: imx: Convert i.MX8M flash.bin image generation to binman
>
> I am guessing the binman isn't prepending the header stuff.  I'll try
> to investigate it this week.

Despite being tired (and having a little wine), I couldn't put this down.

The working version appears to have a sequence that starts at 0x1000:

   00001000  d1 00 20 41 00 20 91 00  00 00 00 00 00 00 00 00

The same sequence on the non-working version has the same sequence at
a different offset:
   000005c0  d1 00 20 41 00 20 91 00  00 00 00 00 00 00 00 00

I think the offset needs to be fixed.  I tried the following patch,
but I am now getting some i2c clock failures, so I need to investigate
further:

diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.d=
tsi
index 6875c6d44f..91fc67099c 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -117,7 +117,9 @@
                                nxp,rom-version =3D <2>;
                                nxp,loader-address =3D <CONFIG_SPL_TEXT_BAS=
E>;
                                args;   /* Needed by mkimage etype supercla=
ss */
-
+#ifdef CONFIG_FSPI_CONF_HEADER
+                               offset =3D <0x1000>;
+#endif
                                section {
                                        filename =3D "u-boot-spl-ddr.bin";
                                        pad-byte =3D <0xff>;


Wtih the above patch, SPL tries to execute:

U-Boot SPL 2025.01-rc1-g6ebfafe8c532-dirty (Nov 03 2024 - 21:23:04 -0600)
Failed to get i2c clk

Once I can figure out the i2c clk issue, I can further test and/or
submit a patch with a fixes-tag.

adam
>
> adam
>
> >
> > adam
> >
> > >
> > > I've applied:
> > > https://patchwork.ozlabs.org/project/uboot/cover/20240826191143.42638=
7-1-sjg@chromium.org/
> > >
> > > on top of mainline:
> > > SHA1: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
> > >
> > > Adding symbols-base =3D <0>; to imx8mm-u-boot.dtsi did not help.
> > >
> > > >
> > > > adam
> > > > >
> > > > > >
> > > > > > Regards,
> > > > > > Simon
> > > > > >
> > > > > > [1]
> > > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D42101=
0
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
> > > > > DENX Software Engineering GmbH,      Managing Director: Erika Unt=
er
> > > > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > > > > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email=
:
> > > > > lukma@denx.de
> > >
> > >
> > >
> > >
> > > Best regards,
> > >
> > > Lukasz Majewski
> > >
> > > --
> > >
> > > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> > > Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx=
.de
