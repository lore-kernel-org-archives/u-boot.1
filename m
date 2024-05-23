Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46789C25B7C
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 15:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 953E188253;
	Thu, 23 May 2024 17:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DPBGcJRT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A642E87FC7; Thu, 23 May 2024 17:17:48 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F34E88253
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 17:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-792b8ebc4eeso463493285a.1
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 08:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716477465; x=1717082265; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LFQIWHk5yHGRpzJ8SZ79g3kW4nMijOoEgwihpYJOoDY=;
 b=DPBGcJRTiYSmmdXHfb8fyqIX7SKE1TZMQGHtn982DcrzNILuWUIFvv0H06iSpDYt33
 Mt1vA3f1OYdnBWurwq3HIkH+yIYumFRjrkyJdL/aQWAU8WMTTWCThbs7ffbb9LfJIp6q
 2bmXpbTarAcsiyUUL3iu8GslEoHBxGl4MHnSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716477465; x=1717082265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFQIWHk5yHGRpzJ8SZ79g3kW4nMijOoEgwihpYJOoDY=;
 b=ElO3tIwI4wYCHRUT6uP1VB8e7SFwzGr3piDMDWnO86q49B3osshW1QJ7yqqeR5ZKEz
 jocrhU6wUpw1g2uejKCM2QVDiWeOoNiayR4btyoEc6/8c3SO5kXAqOiwtO09ZHJBox0i
 CGQAFXbqHvsuMvKIHEtQqNOSmjgvM1N+6hMKaACTbdEZwHsweolLYH3ynqOGRYVIVnEZ
 +pHUviGDOiz4FLyYbu77N5baoyxwgQgrj3qiMEpc+N1bzlmbGcDXQEUkefYsyecuJBNH
 5DhhYPSRTaWJ3Q2HUNyn0iZdkRmWhQZXak96v0cqNKz103sYKP1E8ItuLn8O/VTAmKU+
 pA/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMGjFbJiwtEd4Fkof8LxGbdDPlTLCLlaGewqiWNOdD9TjRVK+POmK3klUahQUBYGI+3035vItMrAOTPIww8YquAtgryQ==
X-Gm-Message-State: AOJu0YyXYjM5dhDfeQgpybvrFtKD01QKR+43jxJqoCH83X9XxjBu71Nm
 P8VQQhbmf04lmDYCVTGzTmbEV/qi+KeZ7PrjcqA3g5Iq37ArI9dMFOlXi3lfdwI=
X-Google-Smtp-Source: AGHT+IEeMyf7fEf9lxcZMP38trY4xNZBCUJL7yk3/vRSSix622XLqQFGo5ObLuwWv17cQgknJL+arQ==
X-Received: by 2002:a05:620a:6209:b0:792:909e:cc76 with SMTP id
 af79cd13be357-794994c4d56mr470336785a.77.1716477464986; 
 Thu, 23 May 2024 08:17:44 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7931062091asm672391085a.47.2024.05.23.08.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:17:44 -0700 (PDT)
Date: Thu, 23 May 2024 09:17:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Jon Humphreys <j-humphreys@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/7] dts: beagleplay: binman: Include firmware
 capsules binman nodes
Message-ID: <20240523151740.GQ2568172@bill-the-cat>
References: <20240419212819.170033-1-j-humphreys@ti.com>
 <20240419212819.170033-5-j-humphreys@ti.com>
 <20240510173200.GV2568172@bill-the-cat>
 <86o78yd1ud.fsf@udb0321960.dhcp.ti.com>
 <20240522141048.GG2568172@bill-the-cat>
 <86jzjlcgjw.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tuRg/F5jQvlnq4oR"
Content-Disposition: inline
In-Reply-To: <86jzjlcgjw.fsf@udb0321960.dhcp.ti.com>
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


--tuRg/F5jQvlnq4oR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 11:12:35PM -0500, Jon Humphreys wrote:
> Tom Rini <trini@konsulko.com> writes:
>=20
> > On Tue, May 21, 2024 at 09:20:26PM -0500, Jon Humphreys wrote:
> >> Tom Rini <trini@konsulko.com> writes:
> >>=20
> >> > On Fri, Apr 19, 2024 at 04:28:16PM -0500, Jonathan Humphreys wrote:
> >> >
> >> >> Fill in the BeaglePlay's capsule GUID properties of the base binman=
 capsule
> >> >> nodes.
> >> >>=20
> >> >> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> >> >> ---
> >> >>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 27 ++++++++++++++++=
++++
> >> >>  arch/arm/dts/k3-am625-r5-beagleplay.dts      | 15 +++++++++++
> >> >>  2 files changed, 42 insertions(+)
> >> >
> >> > This series introduces failure to build in CI, and it's a little tri=
cky
> >> > to replicate locally, depending on your environment. You first need =
to
> >> > NOT have BINMAN_INDIRS set and instead be using fake binaries. Secon=
d,
> >> > it seems python version dependent perhaps? I don't see this on my ho=
st,
> >> > but by:
> >> > - Using the CI container
> >> > - Setting up a virtualenv inside of it
> >> > - pip install -r tools/buildman/requirements.txt
> >> > I get:
> >> > $ ./tools/buildman/buildman --keep-outputs --reproducible-builds -dv=
el --force-build -PEWM --output /tmp/am62x_beagleplay_r5 --board am62x_beag=
leplay_r5
> >> > Building current source for 1 boards (1 thread, 12 jobs per thread)
> >> >        arm:  +   am62x_beagleplay_r5
> >> > +(am62x_beagleplay_r5) Image 'tiboot3-am62x-gp-evm.bin' is missing o=
ptional external blobs but is still functional: ti-fs-gp.bin
> >> > +(am62x_beagleplay_r5)
> >> > +(am62x_beagleplay_r5) /binman/tiboot3-am62x-gp-evm.bin/ti-fs-gp.bin=
 (ti-sysfw/ti-fs-firmware-am62x-gp.bin):
> >> > +(am62x_beagleplay_r5)    Missing blob
> >> > +(am62x_beagleplay_r5) binman: object of type 'NoneType' has no len()
> >> > +(am62x_beagleplay_r5) make[1]: *** [Makefile:1126: .binman_stamp] E=
rror 1
> >> > +(am62x_beagleplay_r5) make: *** [Makefile:177: sub-make] Error 2
> >> >     0    0    1 /1              am62x_beagleplay_r5
> >>=20
> >> Tom, this is failing in the CI container because the container is miss=
ing
> >> the mkeficapsule tool.
> >>=20
> >> To solve this, we just need to add it to the CI container.
> >>=20
> >> My understanding of binman's handling of missing bintools is that it s=
hould
> >> gracefully continue with fake data, so that buildman can successfully =
test
> >> out builds for boards even when you don't have all the required bintoo=
ls.
> >> If I have that correct, I can also create a patch to properly handle t=
his
> >> when using mkeficapsule. But I want to verify this is the desired beha=
vior,
> >> since mkeficapsule isn't a unique or vendor specific tool, so shouldn'=
t we
> >> require it as part of the U-Boot build environment and err out if it is
> >> missing?
> >
> > Perhaps it's a binman issue since we build mkeficapsule or at least
> > should be? Neha?
> >
>=20
> Never mind - I figured it out.
>=20
> The mkeficapsule tools is built by u-boot if TOOLS_MKEFICAPSULE config is
> set. I didn't explicitly set it because it is implied by
> EFI_CAPSULE_ON_DISK config. But this is only set for the A core u-boot, as
> that is what would apply the capsules. SPL running on the R cores does not
> need this. But that then means that the R core u-boot builds don't have
> TOOLS_MKEFICAPSULE set and if that is all that is being built (as in the
> case of buildman), the mkeficapsule tool isn't built and so is missing.
>=20
> So I need to explicitly set TOOLS_MKEFICAPSULE in the R core defconfigs.
> I'll repost the patches.

Interesting. My next thought here is that whatever symbol is allowing
for "make a capsule" should be select'ing TOOLS_MKEFICAPSULE and so the
current logic is a bit flawed. I'm just not sure off-hand where it
should be instead, do you have some ideas now? Thanks.

--=20
Tom

--tuRg/F5jQvlnq4oR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZPXg0ACgkQFHw5/5Y0
tyyH5AwAo2dX54GqptTlxfuMmN7xyxaK6BplzA45x/JuJkW7MOeZhB0Oa2d2qdhr
ufvaH5dLyWmV+J9RxCaISdEuZhD9Ou1F6FMcHTAlvHVBU/PzdqQqmu9TB9Q967RQ
H5haFjWMfnSVvQ66zmqzfMlo3NKLNDUmTDa9KiWYu/fySXSUUKLipZRm83k0K5Mg
jCttVPD+Q3e2wdFkIK5iniNx21By8bCKBFUuiWvEXhr+T9pccSYk9icjCzwa7PD+
dSD3TjiZHJG7Jcn8bHGOj/kP4tnpwWmgimfFrC6mOyfV2eJWPbG/gTwHQyAkq0pZ
vglfiRi0rFQENiNvAPhzHnjccXOPruZF2XvdIqKHI8Yu5xMVHB0Q8PKdbs+NfYQH
IGxCgCNHCTQPo29x8PwJAVz/dLvWWYDyy/7o2WgP6nWsNf7rx338NwyKHbmaU3aP
esI/NFUwBBMrKVc01/8jjm9S6IHZz9+9LfVh9kL1MHfRj3oSPF92FKS0BBFNPJsd
5zg7wJvd
=cWeZ
-----END PGP SIGNATURE-----

--tuRg/F5jQvlnq4oR--
