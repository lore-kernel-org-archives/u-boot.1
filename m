Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A2EC001DF
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 14:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF3648775C;
	Sun, 22 Oct 2023 16:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gj9cuN/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92C788775B; Sun, 22 Oct 2023 16:29:30 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28E098775E
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 16:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a84204e7aeso24521277b3.0
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697984966; x=1698589766; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=evm5Vbm9vRZQV251ysvSdzgfeaD/u+JyvtfhZ5c5oYw=;
 b=Gj9cuN/WQtb9a2uv6IOGvgdA74NW6SR+P0MqjR3c6dY5euo1kCwIetJHxgaKIrI+Hj
 WwaCog768ZsxRgz2XbC2U/VievYNQwmSebNjmdwfan0EJCsMHV8JskB4E7Ce8erwzzC3
 LGUm1hVJ+xouuZfjIKM1RbBKUqnzAMvkgqy0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697984966; x=1698589766;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evm5Vbm9vRZQV251ysvSdzgfeaD/u+JyvtfhZ5c5oYw=;
 b=oFm/ZVsvlMSNLrCzEF9L8tYXZJl1M5hdAKvniSK7+8bIet7Z5ftPm+MPIDZv7clzzi
 6JBsh/9TVr9TM+Y2f0/SV4LtEvIM7wPcSG7DMokPOcKt2pnoURfh6MDUH8qn6KQE+MQz
 H3Vvy+I+yIK10Afi2+g7KcNRV96aZmL56XXwXVeK1yqL4JGuSeR0AOO/NbtklqfG69mR
 +sdvnB7Y8tZjVXCF28SOGGJB0dTxxnz1ODM+9Q+UjVKfwnaX8ejXpUTXDH0HNOXlPBYG
 MNn/5JXxK1y3hVPMCHXiNhfLn4Kjio7OOty5YoyxuTwOTz1syJtuLLmYBkk7MemQqzx8
 buNA==
X-Gm-Message-State: AOJu0YzKK+z5jsP8YaSyG8zASc2HHH/BFsF9OKIMgWtkzdrEGxuOfaqh
 M1VJPCR2u/z9rW5o4SfhWpdy0Q==
X-Google-Smtp-Source: AGHT+IHzjBianc/rcWADmZHDFTjKZzpZhcuYjLSSfhaZE8zydu37Fto+oUEZN+dyH9mKCl9D2Qr43Q==
X-Received: by 2002:a0d:d8cd:0:b0:5a7:af65:4ec6 with SMTP id
 a196-20020a0dd8cd000000b005a7af654ec6mr8108843ywe.32.1697984965616; 
 Sun, 22 Oct 2023 07:29:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d02f-b9d9-0a79-793c.res6.spectrum.com.
 [2603:6081:7b00:6400:d02f:b9d9:a79:793c])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a0de20f000000b0059beb468cb4sm2339220ywe.1.2023.10.22.07.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 07:29:24 -0700 (PDT)
Date: Sun, 22 Oct 2023 10:29:22 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Message-ID: <20231022142922.GA496310@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231017140925.GB3119521@bill-the-cat>
 <cac1ad58-5a7a-41fd-84db-f972609f95c6@gmx.de>
 <CAPnjgZ2tJEBNWsx_tLDTWyQ+xNyLj6feDenqEcCe+t3JNEdv8g@mail.gmail.com>
 <ZTHKKurIp67bx2MJ@octopus>
 <CAPnjgZ1DrzW=2M4UG8aPYmN+MedJODuj5-zE0Y9nVfu-Scpsxw@mail.gmail.com>
 <20231021182612.GA53397@bill-the-cat>
 <49cc3e85-bcc1-4a31-a8e0-293e6ecd952b@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wt2QI3KyUzvan/uP"
Content-Disposition: inline
In-Reply-To: <49cc3e85-bcc1-4a31-a8e0-293e6ecd952b@gmx.de>
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


--wt2QI3KyUzvan/uP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 08:08:11AM +0200, Heinrich Schuchardt wrote:
> On 10/21/23 20:26, Tom Rini wrote:
> > On Sat, Oct 21, 2023 at 08:43:08AM -0700, Simon Glass wrote:
> > > Hi,
> > >=20
> > > On Thu, 19 Oct 2023 at 17:30, AKASHI Takahiro
> > > <takahiro.akashi@linaro.org> wrote:
> > > >=20
> > > > On Thu, Oct 19, 2023 at 08:01:11AM -0600, Simon Glass wrote:
> > > > > Hi Heinrich,
> > > > >=20
> > > > > On Wed, 18 Oct 2023 at 06:55, Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
> > > > > >=20
> > > > > > On 10/17/23 16:09, Tom Rini wrote:
> > > > > > > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
> > > > > > >=20
> > > > > > > > Since efi_device_path.c calls eth_get_dev() and assumes tha=
t Ethernet is
> > > > > > > > available, add it as an explicit dependency.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >=20
> > > > > > > > (no changes since v2)
> > > > > > > >=20
> > > > > > > > Changes in v2:
> > > > > > > > - Add new patch to update EFI_LOADER to depend on DM_ETH
> > > > > > > >=20
> > > > > > > >    lib/efi_loader/Kconfig | 1 +
> > > > > > > >    1 file changed, 1 insertion(+)
> > > > > > > >=20
> > > > > > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > > > > > index 13cad6342c36..fca4b3eef270 100644
> > > > > > > > --- a/lib/efi_loader/Kconfig
> > > > > > > > +++ b/lib/efi_loader/Kconfig
> > > > > > > > @@ -11,6 +11,7 @@ config EFI_LOADER
> > > > > > > >       # We need EFI_STUB_32BIT to be set on x86_32 with EFI=
_STUB
> > > > > > > >       depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32=
BIT
> > > > > > > >       depends on BLK
> > > > > > > > +    depends on DM_ETH
> > > > > > > >       depends on !EFI_APP
> > > > > > > >       default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D=
 armv8
> > > > > > > >       select CHARSET
> > > > > > >=20
> > > > > > > Does this work for you Heinrich, or do you want to clarify the
> > > > > > > dependencies (and re-organize the code as needed) around netw=
orking?
> > > > > > >=20
> > > > > >=20
> > > > > > We should be able to boot via EFI on devices without U-Boot net=
work support.
> > > > > >=20
> > > > > > We already use IS_ENABLED(CONFIG_NETDEVICES) to avoid invoking
> > > > > > eth_get_dev() if there is no network. CONFIG_NETDEVICES=3Dy sel=
ects
> > > > > > CONFIG_DM_ETH.
> > > > > >=20
> > > > > > Why is this not sufficient?
> > > > > > Is there a configuration that does not build?
> > > > >=20
> > > > > The point of this series is to disable CMDLINE and fix up what br=
eaks.
> > > > >=20
> > > > > In this case we have some sort of breakage...perhaps Tom has alre=
ady
> > > > > found it, but otherwise could you take a look?
> > > > >=20
> > > > > We should be able to disable NET and LTO in sandbox and still bui=
ld.
> > > > > But this fails at present[1]. You can try it on -master
> > > >=20
> > > > Obviously, it would be necessary to enclose efi_dp_from_eth()
> > > > with "if defined(CONFIG_NETDEVICES)" (or DM_ETH).
> > > > Then, we could drop "depends on DM_ETH".
> > >=20
> > > Strange that it only happens on the non-LTO board, though?
> >=20
> > There's two issues. The first of which is that I think you need to
> > re-check your error exactly? With my series, and LTO also disabled the
> > problem is a call to efi_get_image_parameters() as that's defined in
> > cmd/bootefi.c, but also only used with cmdline invocations. So we can
> > fix that CMDLINE=3Dn && LTO=3Dn case with a IS_ENABLED(CONFIG_CMDLINE)
> > around that, and then discard efi_dp_from_name() entirely.
> >=20
> > The second issue is that with LTO we more completely find the cases
> > where if x() calls y() and y() is undefined but nothing calls x() we can
> > just discard x() and not care that y() is undefined.
> >=20
>=20
> I will send a patch for function efi_dp_from_eth().

There's no problem with efi_dp_from_eth as far as I can tell.

> @Simon
>=20
> One thing that I don't understand is why we don't let the linker
> eliminate the unused functions on the sandbox.
>=20
> On other architectures we put each function into a separate text section
> and let the linker eliminate the unused text sections:
>=20
> arch/riscv/config.mk:29:
> PLATFORM_RELFLAGS       +=3D -fno-common -ffunction-sections -fdata-secti=
ons
> LDFLAGS_u-boot          +=3D --gc-sections -static -pie
>=20
> Shouldn't we keep the sandbox close to what other architectures do?

Oh my, I didn't realize that sandbox was missing the garbage collection
stuff.  Yes, that needs to be fixed first, then we can see what's next
to change, as there are some issues (my series first fixed CMDLINE=3Dn on
qemu_arm64).

--=20
Tom

--wt2QI3KyUzvan/uP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU1MbsACgkQFHw5/5Y0
tywHLQv9ElrPxBmq3ZtJIDEINccjqd+KRnt5aYo7piKVmfVEHlytx+5v9js5JT1O
JLO8FMIuymStTIZ7ReTh4nvToQhOMRJaQ4ERuAHhlFKfB3exotl533imYbJ/yvPF
4yb4fdalNTn0CuOh7Av9RkJDVGcBcTCQeV+ihEfmJbzDo8yOvDlXRFLW4I3MhTLp
n2/4Dn7hbiK1sD2NfVSYU6V2vJWC2Wfwe9WPZfKkw7QDYU6KxPvCGRlA3ikyz3sJ
30D7+s9UahLOiByQo8O4iRyT7EMvFSmly7tjJHOB/xtKiYvGskTN9cNKcgrSi+9z
EnhEsjlKrr4P+cn5rD0vSazyXeRBqkngqz+Wa8S6VYxbzMQT9Uo2gBEYGSr+gVKa
cTRuNhTmkGHwQM/jj2+b28EacZDqUbSmMWp/ZrIJFnc+j45Iic1SS09p+I85+cqC
RUxfv+2YhX9KpGXdC+JcjTOLI/oSgQXVOY9fqm7JxTW9ceYRstH2xg9MJ+8Czz1V
kcWf8Ydo
=1QZd
-----END PGP SIGNATURE-----

--wt2QI3KyUzvan/uP--
