Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29CAC71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 263D78651B;
	Mon, 28 Aug 2023 17:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BZxXvyrY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D059286452; Mon, 28 Aug 2023 17:47:09 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CCAF864C4
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59205f26e47so38672497b3.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693237625; x=1693842425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CMrjZ6LIJOP7KNKp26/e8323dWdcLGpMsXxoB0vsLfw=;
 b=BZxXvyrY6gvcqB7EehNu9rFYQKnA5zgJNULANBJ/G9vIjBjVuageflfCpT37RQxB5O
 TdQ9ql6VYjbxhZUyDqmR7RKNjYAhLOv6HPijyOma/QVQZMATouOm+6MJWsGZqCx5vsgM
 P3UHCT+17b/NlRkEQtNQOK5PNefu00Mn37WWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693237625; x=1693842425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CMrjZ6LIJOP7KNKp26/e8323dWdcLGpMsXxoB0vsLfw=;
 b=QYHRFNg2OpaOuniRnJVBY4QWvipB7pne+Y9q0pZVBpmpQpKUTpPw2P1GBuO3fsjYtu
 HehQmIDNz7XRyCb4anaxFjp8+SJoYOx9VryFY4DYCEMi600nPjzBSXYCj0Dt5OcOp+BC
 DX0Nbm2yP9JN2HMlTo9S4YLD92l03lD+2QBciwwL4s9yuZryEwMLif9HpO7PUU8TBZ/0
 0eWVDrUG+pqHFDVLiMOKywNXa/KU5rmokXxpxdOwsbkIDMwEtgphjIMwfi9H2kyHsWPp
 +cqstJSSOgpf3fBTk3y6UPtYGCUD6n4WNyPXLQt8yhA9NjrierXCWKaApGEFbto2i6Gi
 PAQQ==
X-Gm-Message-State: AOJu0Yz1nbuwuEKnClL4T8xukiPpAV7F5DgH1z8HhRz2INUJGR8UJ4Hv
 SS6iOGSJBEbU9B2KF7YasQhrrQ==
X-Google-Smtp-Source: AGHT+IHkavu9vQaLd3hM5mG3bqzb0rqXHMmeTVhdu2XP+lk6xvWjp4aTf8Zu8jMAZr0oDfKXezwPvA==
X-Received: by 2002:a0d:e291:0:b0:58c:873e:3174 with SMTP id
 l139-20020a0de291000000b0058c873e3174mr23038199ywe.6.1693237625366; 
 Mon, 28 Aug 2023 08:47:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c01a-9a8d-1e42-2ea4.res6.spectrum.com.
 [2603:6081:7b00:6400:c01a:9a8d:1e42:2ea4])
 by smtp.gmail.com with ESMTPSA id
 x144-20020a81a096000000b00589f4021f84sm2203497ywg.37.2023.08.28.08.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:47:04 -0700 (PDT)
Date: Mon, 28 Aug 2023 11:47:02 -0400
From: Tom Rini <trini@konsulko.com>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Asherah Connor <ashe@kivikakk.ee>, Alexander Graf <agraf@csgraf.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v2 7/7] x86: qemu: Enable ramfb by default
Message-ID: <20230828154702.GF3953269@bill-the-cat>
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
 <20230822121026.1007105-8-alpernebiyasak@gmail.com>
 <CAPnjgZ36NmL0jkHaRyeCSQQm78bDaYwei84WVLt32-ZX0M_J1w@mail.gmail.com>
 <69354e85-2c73-4623-b286-e4820aef494b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mq8pGxADrPNNWnvb"
Content-Disposition: inline
In-Reply-To: <69354e85-2c73-4623-b286-e4820aef494b@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--mq8pGxADrPNNWnvb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 06:40:10PM +0300, Alper Nebi Yasak wrote:
> On 2023-08-22 21:56 +03:00, Simon Glass wrote:
> > Hi Alper,
> >=20
> > On Tue, 22 Aug 2023 at 06:10, Alper Nebi Yasak <alpernebiyasak@gmail.co=
m> wrote:
> >>
> >> Now that we have everything in place to support ramfb, let's wire it up
> >> by default in the x86 QEMU targets. That way, we can use ramfb graphic=
al
> >> console instead of the default by passing -vga none -device ramfb to t=
he
> >> QEMU command line.
> >>
> >> Also increase SYS_MALLOC_F_LEN for QEMU x86_64 to be the same as its S=
PL
> >> counterpart, because we're running out of alloc space in pre-reloc sta=
ge
> >> with ramfb enabled.
> >>
> >> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> >> ---
> >> This also suffers from the same issue with distros as the Bochs display
> >> driver [1], where it results in a hang after GRUB menu selection before
> >> the kernel can display anything. Couldn't reproduce on arm*/riscv*.
> >=20
> > Yes I see that problem too. I wonder how we can debug it?
>=20
> No idea, and I couldn't find a good commit to bisect from, tried as far
> back as v2021.10.
>=20
> >> But just having it enabled doesn't seem to cause problems unless you r=
un
> >> QEMU with -device ramfb, so this (unlike the Bochs video driver) can
> >> actually be co-enabled with VIDEO_VESA.
> >=20
> > Indeed...which makes me wonder if we can do something similar with
> > Bochs, so that (from the cmdline) it is possible to chose ramfb, bochs
> > or vesa?
>=20
> (Tried to answer video choice and DT concerns in another mail)
>=20
> >> [1] https://lore.kernel.org/u-boot/20230724145210.304917-4-sjg@chromiu=
m.org/
> >>
> >> Changes in v2:
> >> - Add patch "x86: qemu: Enable ramfb by default"
> >>
> >>  arch/x86/cpu/qemu/Kconfig           |  4 +++
> >>  board/emulation/qemu-x86/qemu-x86.c | 47 +++++++++++++++++++++++++++++
> >>  configs/qemu-x86_64_defconfig       |  4 +--
> >>  configs/qemu-x86_defconfig          |  1 -
> >>  4 files changed, 52 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/x86/cpu/qemu/Kconfig b/arch/x86/cpu/qemu/Kconfig
> >> index f8f2f6473088..e0a57ac2d687 100644
> >> --- a/arch/x86/cpu/qemu/Kconfig
> >> +++ b/arch/x86/cpu/qemu/Kconfig
> >> @@ -13,6 +13,10 @@ config QEMU
> >>         imply USB
> >>         imply USB_EHCI_HCD
> >>         imply VIDEO_VESA
> >> +       imply VIDEO_RAMFB
> >> +       imply BOARD_EARLY_INIT_F
> >> +       imply BOARD_EARLY_INIT_R
> >> +       imply CMD_QFW
> >>
> >>  if QEMU
> >>
> >> [...]
> >>=20
> >> @@ -59,7 +58,6 @@ CONFIG_CMD_USB=3Dy
> >>  CONFIG_BOOTP_BOOTFILESIZE=3Dy
> >>  CONFIG_CMD_EFIDEBUG=3Dy
> >>  CONFIG_CMD_TIME=3Dy
> >> -CONFIG_CMD_QFW=3Dy
> >=20
> > What is happening here? Why disable it?
>=20
> I used `imply CMD_QFW` above to be consistent with previous patches, so
> it's no longer necessary in defconfigs. Should I drop the imply and keep
> these in defconfig?

I think our Kconfig logic around the QFW options is a bit backwards,
given that it's universal to the "qemu" boards and not used on
qemu-emulates-known-hardware platforms.  The qemu boards should be
select'ing QFW, and CMD_QFW should be depends on QFW and default y,
rather than selects.

--=20
Tom

--mq8pGxADrPNNWnvb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTswW0ACgkQFHw5/5Y0
tywftgwArysXxT60wsqIWptdhp+3Mked0kJYcDUnECIEslepxrT41TlmT7TwM81D
/KlO5EvS4G5VNSopIExDQzK0MRRqOWf5X44HDiThxVrdTq2hWQOxRjD/0Gub5DFp
/wHMKkWp5uW8iVIAnPkKe7rvk3Zhq1mCDoOtNOve/aPqE8LhzDtNFszwgJNPxwkj
G3IQbNFcBfk2DnwrOwNUEPsaq7ZhG/CXFa1EmroksycZP31XWaS2drO3Hm/swJi1
aN7AM2mIULi/grTFqS0YMzj2jFiKznYKXFpbsjxxu5elaABHFqVaLuDLx1Dz4zbw
CnGZf4RtTtFfLGQfStgjQfjnUqcxD8XZRxKSI4U3QB1S23Nic8I/oOcmK5lVhnQw
Lq+1+ttj4lOKW4bFG9OCbTxK+DdI2s/GZR6H162wwOIphKT3E0w+I8GFHckKa3V/
jYve8Uj1oLyG6zQ/ZQNPCI40V1YBTjhPYsOn1iEy1X8NvxGIg0lx9si9RkWAGNwE
yIwe4dxD
=ey6d
-----END PGP SIGNATURE-----

--mq8pGxADrPNNWnvb--
