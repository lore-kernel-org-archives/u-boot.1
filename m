Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3168CF3962
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 17:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5651588CB9;
	Thu, 19 Sep 2024 19:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TcTmG0u4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD0FF88CB9; Thu, 19 Sep 2024 19:48:12 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FC6F88B58
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 19:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6c35b545b41so19136056d6.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726768088; x=1727372888; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zdx22nMy0wtSgSPOpvssGVtMez4y0onVLukkRAPpepU=;
 b=TcTmG0u4pv4eu/izCfeGKjZ4tTOlvgTV4b3csb+caNa48Ql8GWlficu+lBG2kJS4ic
 GypaRGXNqdi1GITUPjV7W+ipkYap3+MOEFC8DWBmHo8UAxB1i7szjUaTUWuT5V8tBQn8
 MWc6ejpzTG/623Pwc8odr6vgEqp3unUyUCXfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726768088; x=1727372888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zdx22nMy0wtSgSPOpvssGVtMez4y0onVLukkRAPpepU=;
 b=MuKM81y2EtLuoppFfghWu5jpXH2vPTDXtnjg0Yx0m8p6a7wpuLI8d+S1VkCRJXMRSo
 fSd/9xeGL4AM8KfiwZhUc2CK8+GKsz+UF+VfD86ynP3npa5zUSC6sq5hu4JKhTh3Zxi7
 8rrqu/aYRdcm9AQugZ2/B6rTEim9FITcZv2P3w0eEM/9te4hREprYMCH+e1MA4oWejx3
 F1L0pbVCS1YIfjFaY3dK5RA21hwiZB81JRGm8+OzLVKX7k3Mn2dyFSmLtHJNIcZtxMFm
 4+pIsgByQAi58QHbzjeMQwAi1KUXsfE1aI7NEQehVV8ZsjhPzPusDAzQqN1+rh1zVL6Y
 D08w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+yNJcUCIkuO4yVUyPdwIM0jImEG2Y1WWDz5E11mtpFMo0dNC2vKP/PGn5HKnwklEh/mlqwl0=@lists.denx.de
X-Gm-Message-State: AOJu0YzEiYYJBSS7oAdfTyHRSUbdqZ8IFdVVbwuOzQ3OBvet3JJ/VP5k
 9uf/qusjDLN7rUBGkypoGtRRvK+4WD6NtgNFFmxmTyi0qcoqE0Oje4K8+XAuVa0=
X-Google-Smtp-Source: AGHT+IHlzFjW4ZpEfteu+aw2UVQdwMnMpndrVMl0cB3xzi7HwPccRrxsLrC6+8ZD7Q/XTqkfUzk/nQ==
X-Received: by 2002:a05:6214:5706:b0:6c5:7dc7:6dee with SMTP id
 6a1803df08f44-6c7bbbfd2bcmr7190616d6.19.1726768088236; 
 Thu, 19 Sep 2024 10:48:08 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e46f072sm9611096d6.53.2024.09.19.10.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 10:48:07 -0700 (PDT)
Date: Thu, 19 Sep 2024 11:48:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Stefan Roese <sr@denx.de>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH 00/10] SMBIOS improvements
Message-ID: <20240919174803.GU4252@bill-the-cat>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
 <ffeb90f8-4f3b-4455-83db-d7b03b872c84@linaro.org>
 <CAFLszTg8gM53pcbHGj-LoA9GDSU-X294_q6ZRnP_QjYFppG0sw@mail.gmail.com>
 <20240826182345.GJ2479150@bill-the-cat>
 <CAFLszTiD4A2eCMfnnKvrbm__urLu+vdi_L1T1iiwU-qOY-yYJQ@mail.gmail.com>
 <20240826195924.GM2479150@bill-the-cat>
 <93c2ab53-aa9a-4403-80da-7bd6d8872b3c@gmx.de>
 <20240915182831.GD4252@bill-the-cat>
 <CAFLszTiVwOMHPPZV3iHyW4cdz7cr5vPZj=-6_VwCWXnix=Kg7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UY4XFYaQuOkupkHw"
Content-Disposition: inline
In-Reply-To: <CAFLszTiVwOMHPPZV3iHyW4cdz7cr5vPZj=-6_VwCWXnix=Kg7Q@mail.gmail.com>
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


--UY4XFYaQuOkupkHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 04:13:02PM +0200, Simon Glass wrote:
> Hi,
>=20
> On Sun, 15 Sept 2024 at 20:28, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Sep 15, 2024 at 07:57:19PM +0200, Heinrich Schuchardt wrote:
> > > On 8/26/24 21:59, Tom Rini wrote:
> > > > On Mon, Aug 26, 2024 at 01:12:16PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 26 Aug 2024 at 12:23, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Aug 26, 2024 at 11:58:54AM -0600, Simon Glass wrote:
> > > > > > > Hi Caleb,
> > > > > > >
> > > > > > > On Mon, 19 Aug 2024 at 17:03, Caleb Connolly <caleb.connolly@=
linaro.org> wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > > As a general comment, this is adding a load of code which=
 is used by a
> > > > > > > > > lot of platforms. As more and more aarch64 platforms are =
created, this
> > > > > > > > > data grows. Why not use the devicetree for this hardware =
information?
> > > > > > > > > That is what it is for.
> > > > > > > >
> > > > > > > > This data does not belong in devicetree, the various system=
 registers
> > > > > > > > exist to describe this information... Putting it in DT woul=
d be
> > > > > > > > duplicating it.
> > > > > > >
> > > > > > > I am not wanting to duplicate info which can be read from sys=
tem registers.
> > > > > > >
> > > > > > > >
> > > > > > > > Using DT for this would additionally require having binding=
s accepted
> > > > > > > > upstream and for all SoCs to add them. To what end?
> > > > > > >
> > > > > > > To get the correct information in there. How are boards suppo=
sed to
> > > > > > > add SMBIOS info? Do we end up creating a whole infra in U-Boo=
t just
> > > > > > > for the driver to read it out? It just doesn't make any sense=
 to me...
> > > > > > >
> > > > > > > Let's put hardware info in the DT where it belongs.
> > > > > >
> > > > > > I'm a little confused here because of some older threads on thi=
s overall
> > > > > > topic. Part of the issue here is that in user space, "everyone"=
 has
> > > > > > SMBIOS-based tooling today, and wants to have that work, rather=
 than
> > > > > > inventing new tooling or modify existing tooling. And you were =
concerned
> > > > > > I thought that we had tied SMBIOS too much to EFI being present=
 when
> > > > > > indeed it should be possible to pass the location along to the =
OS
> > > > > > without EFI, but at the time Linux at least only supported that=
 notion
> > > > > > on MIPS I think?
> > > > >
> > > > > That is a whole other concern I have, that we are perpetuating th=
is
> > > > > legacy format which is a real pain to work with, when we already =
have
> > > > > devicetree. Let's leave that issue aside as I have not detected a=
ny
> > > > > interest in solving that problem, or even any agreement that it i=
s a
> > > > > problem.
> > > >
> > > > OK, yes, lets set that aside.
> > > >
> > > > > But for this particular series, I am just wanting to get the corr=
ect
> > > > > info in there. Having the CPU-detection code provide an opinion a=
bout
> > > > > what type of chassis is in use (just to take an example, the patch
> > > > > pieces I highlighted have been dropped from the email I am replyi=
ng
> > > > > to) just seems a bit daft to me. Only the board vendor would know=
 that
> > > > > info.
> > > >
> > > > Yes, I agree the detection should be reworked a good bit as some
> > > > information will be board design specific while others SoC specific=
=2E And
> > > > we should avoid adding many unused at run time strings to all platf=
orms
> > > > that enable this too (looking at all the CPU vendor related stuff).
> > > >
> > >
> > > I doubt on productive machines there will be much use of U-Boot's smb=
ios
> > > command use. It is more a developer tool.
>=20
> Many commands fall into that category.

Yes, there is a trade-off to be made.

> > > For reading all the details we currently have
> > > lib/efi_loader/smbiosdump.efi which can dump the SMBIOS table to a fi=
le
> > > that dmidecode can read.
> > >
> > > Maybe instead of adding more and more decoding logic into the U-Boot
> > > smbios command we should add an smbios sub-command to dump to a file.
> > > This would be less of a hassle than running an EFI program for the sa=
me
> > > purpose.
> >
> > Sounds like a good idea to me.
>=20
> I would like to see this series land in U-Boot as I believe it is very
> helpful for seeing what the table looks like. Dumping to a file which
> then needs to be decoded is not as convenient. We may also find it
> easier to add tests for SMBIOS.

And I don't look forward to the seemingly inevitable parsing bug means
CVE assigned. If the command is broadly enabled then "everyone" gets to
worry about it, and if it's narrowly enabled have we really gotten
better than the options of dump to file, parse elsewhere or load a
parser and run it?

--=20
Tom

--UY4XFYaQuOkupkHw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbsY9MACgkQFHw5/5Y0
tyxqTQwAgZHmuUYxN6rsPEs7SaoUDAx6p9X9jWNgPkoCQ7WCM173Gy7Brx5WuI0B
IvFIQcXkliz5kXISASvbb7+vSTBnGiL+qPY6Epa/icrdCj2E7Sj6FaPmYHtMB2aY
GfqTSuzH/9SYFQTjcVUkpa031sAVTIi700nvpFDmwuRADNP+zJHkq1obtH24stym
/kbhg3rS4gzk+OLrNsLE/62oCm21QTbg/FBaQoRMjdIkH8mQYd/II0IUCvF5NzhL
4P1INWaksQpibhRko+SXguY5YQ0EGorDpfpr0Db1ZzJzcZRDgAs/yCZlBoK6gzc8
wsXrzJ30OivnJnKKp5P8zLk3m5PvzZcVh0T0T7Qp/DacH2Re5voKmB2U6dUfk5+6
VnsNkKAJ2tVmEwDUX104QbfxVcD2ko2JB0Nv8QTR57EqHbLEB1Qf0SdmE9DuA3Z0
vpyPTU6QytWedkyfLlmBgqXy2dcHsLy0pibc0zigw+i9Y+DFMIK0ye9XQ72CJ/K+
V1grLSS3
=u5aF
-----END PGP SIGNATURE-----

--UY4XFYaQuOkupkHw--
