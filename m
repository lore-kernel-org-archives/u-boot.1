Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C78DC36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5B9E80107;
	Fri, 28 Mar 2025 17:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pr+GSPIz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3590581951; Fri, 28 Mar 2025 17:25:49 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EDE5810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:25:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3fefbbc7dd4so1306442b6e.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743179144; x=1743783944; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mmX1FcR1u8D62ThEtLHNz9rsGgBsilCqLZo46P1FPZc=;
 b=pr+GSPIzjCS4CA3gCgUei97FMNALm1lELQiT9CliQb1oMEk24zegoPatj670DThh2g
 9oZtGGQYA10oiO5DNU23glRyno8u/+tzUrPbPnbsPHJvItnEEd3EByothCvpCRGsktqH
 NVlsBtp91QJ2HwfWKlHVUwouW3nrAUwffzd9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743179144; x=1743783944;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmX1FcR1u8D62ThEtLHNz9rsGgBsilCqLZo46P1FPZc=;
 b=FiBca/EZIM/GBW+VIRB/cBf9yoqaNmHxYmCt5JVfn62NC/pdN0PFQKr1YLyzGIQ3oa
 SJkNBv5F3LsZa8tOeWryf1WrPOlRMXpCPyyq2eH4WO3CkZ0J5UjxHifSUCDx0bDlTgf3
 z8PyhFe47XzxNvoflmA4/n0HhjCCnfjs7uVIRSbHDD7MkjvUH5uvmtp62xCmiDKnJmA6
 vJUmXt8XRf7XBe2Gi8kI6PzrhyTAFJ7t5Fa0HORIFunw4jc5HJWNq3BRn4fW9STgb7wa
 vzF5ohb1I2GGPqlsw+nzVIF4K8TAIBJt8GurPsT+2f9O/E7n/Nj3MADsLOFHgqyOpK8D
 tiYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVetITk7J2SwHK9qwAFGuR7clbsf0LVTVvwBEuzHwBSGr2XwVPMWEgX2zJC2e4Bn1Q7Y7OHdcc=@lists.denx.de
X-Gm-Message-State: AOJu0YymJp3APJk2/drRZLrlIzfZirSgLfC+Y3kzCyunRRlRIQZliNO2
 5atYzxh4m4tWYjv/wVgmurY9J7cs7uD3grUwUE6sBpDgAzEKCwAf4wxiQDx4I7Y=
X-Gm-Gg: ASbGncuqr5P8V1XSJ+OcyusoqQ+AAF9+UkWnNta7eXfA6uaIw7yzUa1wq9X5oQ0ymXm
 VH/aB1fK9SSe0ONqtwSM2Dfp2H7ZNiBXZXUzxdJtlQDo5eZnm6dGbacdhuAp/G+1hZLWvZB500P
 wBdbq+wEb0UMZUoWSraDM6bzi/9iEYkeYPVhKKiKph9XBfhh/4iIjtGuYMZZEX06d3E/C6EIMpx
 Is7oAjA+zXhwiKF0z6J/3YVVlp7gP9zlVp/zaqExHmyaPq8xoAFTUaGdkjhQGE3mFvi7a2ESF8e
 wkLi/Z0m6sKvL8o9rX8W4HeNPX99Kk2LUhV3iyaJSe//B/zivRFOoSR+BAjL+sc9s+UDhCBXB8P
 ts9rMMQ==
X-Google-Smtp-Source: AGHT+IEtEp8Fltx6zSaCsl4n0w1dNtkTFm0SwzyRJqyrP3mLSjtFqMWcDDu7PYnE1buu4SCmFX1gOw==
X-Received: by 2002:a05:6808:2e4b:b0:3fa:c549:d009 with SMTP id
 5614622812f47-3fefa4f387amr6523855b6e.2.1743179144163; 
 Fri, 28 Mar 2025 09:25:44 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05279bb3sm383801b6e.31.2025.03.28.09.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 09:25:43 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:25:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, e@freeshell.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Ashish Kumar <Ashish.Kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Udit Agarwal <udit.agarwal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Manish Tomar <Manish.Tomar@nxp.com>, Mathew McBride <matt@traverse.com.au>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Sumit Garg <sumit.garg@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Robert Marko <robert.marko@sartura.hr>,
 Lukas Funke <lukas.funke@weidmueller.com>, Peng Fan <peng.fan@nxp.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] efi_loader: remove EFI_BOUNCE_BUFFER
Message-ID: <20250328162539.GC93000@bill-the-cat>
References: <20250317133845.138061-1-ilias.apalodimas@linaro.org>
 <380f1f2c-59cd-4c52-a598-5e6f1ed1dcad@gmx.de>
 <CAC_iWj+DazCNrMktmwJQxt7bVPbu-qWCfjW4bgcv0cngiH03gw@mail.gmail.com>
 <CAFLszTgq25-E-n+UaJ_wRdimCLcAta-fetWpOW++NCOfN_eL5w@mail.gmail.com>
 <CAC_iWjLS_yNPCMY2RhGZ0390ZysH=N5x5JZ-qOnNjX7nofPS4Q@mail.gmail.com>
 <CAFLszThhK4-+Qh_eQLD0fuJZVodBkwit4rw5mOcGU58m6=5knw@mail.gmail.com>
 <CAC_iWj+2EsRUBT5ThAR7+wwxVkFSzrApCNDbTEEHQ-W658LwCw@mail.gmail.com>
 <20250328160419.GX93000@bill-the-cat>
 <2c9efc39-b0b9-41e7-b42e-1d026bc286a7@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QoykfpATO7cYb6pP"
Content-Disposition: inline
In-Reply-To: <2c9efc39-b0b9-41e7-b42e-1d026bc286a7@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 28 Mar 2025 17:32:08 +0100
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


--QoykfpATO7cYb6pP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 05:17:36PM +0100, Heinrich Schuchardt wrote:
> On 28.03.25 17:04, Tom Rini wrote:
> > On Fri, Mar 28, 2025 at 02:26:39PM +0200, Ilias Apalodimas wrote:
> > > On Fri, 28 Mar 2025 at 13:34, Simon Glass <sjg@chromium.org> wrote:
> > > >=20
> > > > Hi Ilias,
> > > >=20
> > > > On Thu, 27 Mar 2025 at 15:19, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >=20
> > > > > Hi Simon
> > > > >=20
> > > > > On Thu, 27 Mar 2025 at 15:33, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > > >=20
> > > > > > Hi Ilias,
> > > > > >=20
> > > > > > On Wed, 26 Mar 2025 at 02:37, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >=20
> > > > > > > Hi Heinrich,
> > > > > > >=20
> > > > > > > On Mon, 24 Mar 2025 at 19:50, Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> > > > > > > >=20
> > > > > > > > On 17.03.25 14:38, Ilias Apalodimas wrote:
> > > > > > > >=20
> > > > > > > > %s/EFI_BOUNCE_BUFFER/CONFIG_EFI_LOADER_BOUNCE_BUFFER/
> > > > > > > >=20
> > > > > > > > > The EFI subsystem defines its own bounce buffer for devic=
es that
> > > > > > > > > can't transfer data > 4GB. U-Boot already has a generic B=
OUNCE_BUFFER
> > > > > > > > > which can be reused instead of defining another symbol.
> > > > > > > > > The only limitation for EFI is that we don't know how big=
 the file a user
> > > > > > > > > chooses to transfer is and as a result we can't depend on=
 allocating the
> > > > > > > > > memory from the malloc area, which can prove too small.
> > > > > > > > >=20
> > > > > > > > > So allocate an EFI buffer of the correct size and pass it=
 to the DM,
> > > > > > > > > which already supports bounce buffering via bounce_buffer=
_start_extalign()
> > > > > > > >=20
> > > > > > > > Looking at
> > > > > > > >=20
> > > > > > > >       if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && desc->bb) {
> > > > > > > >=20
> > > > > > > > in drivers/block/blk-uclass.c the bounce buffer has to be e=
xplicitly
> > > > > > > > enabled by the device driver. Only the scsi drivers sets bb=
 =3D true.
> > > > > > > >=20
> > > > > > > > Cf. 81bd22e935dc ("rockchip: block: blk-uclass: add bounce =
buffer flag
> > > > > > > > to blk_desc")
> > > > > > > >=20
> > > > > > > > Which device-drivers of the boards mentioned below do actua=
lly need
> > > > > > > > bounce buffering?
> > > > > > >=20
> > > > > > > Unfortunately, I don't have any of the hardware to test and I=
 havent
> > > > > > > worked with that platform much.
> > > > > > > That 'bb' variable and the fact that EFI needs bigger allocat=
ions is
> > > > > > > why I ended up allocationg properly aligned memory from the E=
FI
> > > > > > > subsystem. But as Mark pointed out, the cache flush is a no g=
o for
> > > > > > > now, so I'll drop this and see if I find time to rework the b=
ounce
> > > > > > > buffer logic overall
> > > > > >=20
> > > > > > There was quite a bit of discussion about all this in the conte=
xt of
> > > > > > my attempt to just add a message to warn the user[1]
> > > > > >=20
> > > > > > We might consider adding an event to reserve memory before relo=
cation,
> > > > > > along with a way to discover (in board_r) where the memory was
> > > > > > allocated. That would make the solution more generic.
> > > > >=20
> > > > > I am not sure what you are trying to solve here. The EFI bounce b=
uffer
> > > > > after the LMB patches can't overwrite memory, nor can it be
> > > > > overwritten.
> > > >=20
> > > > I am thinking of we can create a single implementation of the
> > > > bouncebuf logic which also works for EFI.
> > > >=20
> > > > I think the two sane things to do are:
> > > > - restrict U-Boot to using memory below 4GB for platforms which have
> > > > the DMA limitation
> > >=20
> > > You don't need that. The bounce buf code has a callback you can use to
> > > define the limitations
> > >=20
> > > > - create (in board_f) a special region below 4GB for use with the
> > > > bouncebuf logic
> > >=20
> > > The only problem with EFI is that you don't know how much memory it
> > > needs and we can't use the existing memalign calls. So if we replace
> > > that memalign in the bounce buffer code, with an lmb reservation we
> > > have everything we need.
> >=20
> > It's not even an EFI problem is it? You could hit the same problem
> > reading a file from a filesystem outside of EFI too. These specific
> > SoCs just aren't heavily exercised is one of the challenges I think and
> > so it's possible that we have a few things to yet improve in the
> > bounce buffer code (which was added for other SoCs and done as generic
> > enough starting point for others).
> >=20
>=20
> EFI or LMB allocate memory top down. So EFI applications have a good
> chance of loading files into high memory. Other file-system operations
> typically use predefined addresses line $loadaddr. This is why the
> problem became more visible in EFI.
>=20
> It is evident that the bounce-buffer functionality is not EFI specific
> per se.

Right. But it's not the destination address we're talking about but
rather that for "fun" system design reasons we need to have the storage
IP block read from device to one address and then bounce it over to the
final address. Or have I missed understood which kind of bounce buffer
we're needing something here for?

--=20
Tom

--QoykfpATO7cYb6pP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfmzYMACgkQFHw5/5Y0
tyy4xwv/Wu+SO6u6ygojfL6RYNylSVYwvp4tSMIrPLG5G13681TfgCBSbPajbCRx
jgsrXXRwAI456zB+Fyjyvu+RrzruuOWVufcZeVaqXuijZiGmzwJugsxkuDkQpCOd
IxFTo2BQ2r7rG/dVXw3pDYv9Wyk/re42lemex2u37OfeKdrlphpr0of2cYsBijy5
fzMVMH6Admp83tj/OBaQjsvGsQvKHcM3NAG3Q/rUN4xZ/AlPoI3e4KVInmZX+uFh
TGePLsMZ1AbKvqk717PpAJEQSWpdHddEhJn8G+EZSih3P+WYfAGS59uVXU95y0fR
+gGAR9vliEu4xxD47OeJB+/ePnaCbYuP9oHZ8Ll29RSel0A5c+Q+5NuGhaU15aMx
4lOjdPrmaGuoUyewctIOScxxpKwKj/bwBW6kBN3s7hndNZioZObtn0Ibv9k3Ndci
rGD3rILX59Eo8jFsedXMMzLmgOxo0lZDn7e53x8SREgGvzh35+wtPsrYpAapgyox
pMpIUS/i
=LzfY
-----END PGP SIGNATURE-----

--QoykfpATO7cYb6pP--
