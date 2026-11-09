Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EE2606A325
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=td6166Gz;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=BsUo01V7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FE0D40596;
	Mon,  9 Nov 2026 19:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BDoTA8ukpO1y; Mon,  9 Nov 2026 19:56:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 802A84056B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794254173;
	b=Y1C7Uyp6Nev3wajDpTKeFp0I+70bj+qvWUWaSW/rzm3oAJ76Z7JYWaURNbJ3SPnZy5av
	 rpxlDyLGcAhmBa+Se59biQ2MN5nf1frbkvZkQdeuKf+nkEs5EDGGYrHiUscxq+SLyJmNG
	 XcAADZy1wGuy0qzWOCFVzwh2fWYb1WxA9MYKX1OmYoddWHiDA7V17Y1dAK1T+iQ4cX5E1
	 Il/uTpQpjAfuCoSk7JCTsQGjIF4HnYfVgQePgNRIaNNqnmwJ6rKevYGvbvavdvGXx7lN1
	 SXNCBe8YL+6qmQL7sU4SyUfzcVcDdelBkLVGJZLDQUFGTZiQeBM+Sl1BViAQs6sGIow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794254173;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J2593E4Abx3XBVG1UAEY9Vv46Be5CbcJfgb3J4IMq/E=;
	b=Dg0Z6zkEx/KAYvFWcDPexuH/1hm1Z6qWMuHt/zriWCGVuWu+m+neiOJQWCaySHIhq3wN
	 0Sg7sfb05QKh26VMFYAG0i1YJzkYIQ3iQuCouhV5p2mEcWZD9rYtQymY3mGQ0Jz6GoEZG
	 aNCc9/S9SFdAPRcSdauHaoNPIPSKDsqyBOqHUnTIl5w+MT8SFcuoUn1MRDpix1WgngUFj
	 OKbclc24kIEjfpNf8UhjOtg6fF5Mz+b/4S7uBekvRoyfHfVrwbxNsWU5xj2u67vImwwpl
	 sPGOqBeeX0F7cORj/mtRQZBt/YjiCmCTDr3ktF/m1ERuX2DC7ZvR87gpLmO7Gv+0McQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=BsUo01V7;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794254173;
	bh=J2593E4Abx3XBVG1UAEY9Vv46Be5CbcJfgb3J4IMq/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=td6166Gzb6Skbv8Gu2mcFaIb0o0VYn8QW4C7eCsl7+AIB+3jjuCYoOncTxSlGEJGL
	 DyEijq9suwaBhmA9JTOT+Bjo3DuBP2HuEi+C6hR4hsNpkxQ+dLWF6ILuy/9HinnAgn
	 lFOJKLZ0gir3OTTLEw/+UqytRFddrCzGcEB9wvrHlS9VaF/LvHaMIu1f6KEWsDD2T4
	 X3ZRL9uY0Q6oG22LynmZRzV7NZyFoovmC9b01lT2+MIsmPtj02c19oEnCMIYvRSkHr
	 nrJ4552lCkf2EYKoD8P5cwXPELXWZuJIeCy6iWLicNSYtKJXh6w2CoAWOFUjjdB4mf
	 eQcOfrGSHvzZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 802A84056B;
	Mon,  9 Nov 2026 19:56:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C13B3AD
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 823CB40582
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wAYyC2poD8Ae for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 19:56:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C56540562
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BsUo01V7
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C56540562
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:56:11 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-483c607ccb4so650627fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 11:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794254170; x=1794858970;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J2593E4Abx3XBVG1UAEY9Vv46Be5CbcJfgb3J4IMq/E=;
 b=BsUo01V7Vm/LadeO9rjaZhwd4VzyEePmxIL8XEPxZxe9gkM1ITwSDHfEc1hNNdIvEY
 E9QH7PIzOIdNJjgnmSy9M/eApRhpCWEs/B81wD1f8JHG8ZGCuSSrLMOz4Jz23po9VwPq
 s6QA+ArPJOUYAkWuXOCBa/DMF0Z25IJ6nHWjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794254170; x=1794858970;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J2593E4Abx3XBVG1UAEY9Vv46Be5CbcJfgb3J4IMq/E=;
 b=BtnPodVcOIR8xkrK598GzO3TK85b+kCng5fMlq1kWPSUyDkL02+1mFk1ac6NKkVGlW
 egDb4ifxOZhl02uUIbdpSvi+wD11NVVVMmDtwITMIOgloJWvqKFemS5ECeDCldzZtuG6
 w09XTAPi00Tql4fyLrf46zxsYDkLgtCEBgTl1G2ASyA1rZa5bup7OVWjoc0aUIVych8S
 ZKaqRDVuuNoJUrRyLCzjGaZGmcFW/y07efbFUByEcP4srQFLn+z2GF+GmrQZY/XfxZw6
 t/b0V7LTiwDr1gWrsvb/brjtQGJ3+jBihoVwl6JIou6yL2noKM1VjZBbu30bpcyuh3W9
 tXWg==
X-Forwarded-Encrypted: i=1;
 AL+hErEHRb3sCYTZKhNRX8aqJWgKweGSghvA01D4oBsmzWvbXMAMwlKSd0ijzc2jvQ0LOmB0rtAIQIE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+O01lvUvoTZ6O1TItRh2Ue2vxVW8tRFNjNeyt2ZlgWEWpYAo3s
 AJmDQJWWVdNQ15gozfBjmfIt/JOBdRnHDAtx6xFOtNT/w6wGP78ig6QehA0BFxOBGmU=
X-Gm-Gg: AYBFou0RNSZRTJI2osM4RWk1fhpXXG1y9M/uhp/dm28rEn2ILfgiEGwAirj469aDsL8
 iuBhs9uJm1VwRfraKHQyy91auB02mXvfQYSgnuvLghHwZiQPVR+QyqLeen7MEutWsacNgT8OPB/
 FPEEjesL0Ova95dk1TlHOZpZWmoxG2hMR07Bzhk1P5mj73xETi5c0LsU7Ayg5rneLG8H4TJyzk3
 iinsytojJBD1NEwZ/PeDg3D+pgw7bqHmozYlTE8TXuYCeE+ngXBTvhE7Vsj7V6MA9HEQ1+QLKSI
 uTyvT1Mk6oPSo9incSQNNdWdEEfVe1HxGJLFRO7x7bpL7FC6Os1N8c4TmrV7uv43wLvbXiv35ga
 ZoI/EnWx8910QPicAJaJB5Dv2fnF221xcmGji9NWgH7hDfSJnwch0FSwHfXVCeOutDJdK9qhKuU
 qKWU9Z2SH3Umep2rECAMBDwy7xDDSW0kLfU9cMJ81Lm5UVF3KbfrTpsdZSuuinBudKbIHNfK0zW
 cn/VXZB0mXLXYtXoINwNWEVoEbZlvwwSnr7OfQ2RxiUEZMFcl2NMnua4ciT210Op59Ad6orMpXZ
 kFvZjQdna1e46yWt+AqcwDWmu8Ne4uR6rKBHgzk4YA+U0YUZ1fr1/S/XCN1wIcq1FPxfwjaF5cm
 wagV3vsqgMoY4aUZQWGCafY2lRTQOwN4/BaHj7Ysl/K11I1ti5YrB1oYtWBVgi5o+/6nuuZPbIX
 2ZXL1nzhWv3cpjyZ1tEQC5TIhQ9PNtvw==
X-Received: by 2002:a05:6808:13c1:b0:4f6:1ef7:6cd9 with SMTP id
 5614622812f47-5683dc5db34mr566120b6e.64.1794254170118; 
 Mon, 09 Nov 2026 11:56:10 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905f2faf5sm97076b6e.13.2026.11.09.11.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 11:56:08 -0800 (PST)
Date: Mon, 9 Nov 2026 13:56:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Charkov <alchark@flipper.net>,
 Casey Connolly <casey.connolly@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>,
 =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@jo-so.de>,
 Johan Jonker <jbx6244@gmail.com>, Denis Mukhin <dmukhin@ford.com>
Subject: Re: [PATCH] block: add legacy block support for TPL
Message-ID: <20261109195605.GY3741582@bill-the-cat>
References: <20261109-legacy-block-tpl-v1-1-aeee138e9288@postmarketos.org>
 <CAC928HZLjxgkuoyMaZa8jFimiVPTGX+hkuN6dppCJeFja9axYA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gu2TMRuFFGdktuRY"
Content-Disposition: inline
In-Reply-To: <CAC928HZLjxgkuoyMaZa8jFimiVPTGX+hkuN6dppCJeFja9axYA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Gu2TMRuFFGdktuRY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2026 at 08:51:15PM +0100, Massimo Pegorer wrote:
> Hi,
>=20
> Il giorno lun 9 nov 2026 alle ore 09:01 Ferass El Hafidi ha scritto:
> >
> > Legacy block support is only selectable for SPL. However it is
> > useful in TPL too, where the full block driver (with DM and whatnot)
> > will not fit.
> > Add a TPL_LEGACY_BLOCK kconfig option to enable legacy block support in
> > TPL. Note that it is hidden in menuconfig (just like the SPL variant).
> >
> > Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> > ---
> > As I've been working on some TPL support for Amlogic I noticed that I
> > could not choose the legacy block driver (while I could choose it for S=
PL).
> > Given we only have 44K available, DM is a tight fit there so I'd rather=
 not
> > enable it where possible to save space.
> >
> > Adding the ability to select the legacy block driver in TPL seemed like
> > a good option for the same reasons it is already available for SPL
> > builds. And indeed it works just fine there too.
> > ---
> >  disk/Makefile          |  4 ++--
> >  drivers/Makefile       |  7 ++++++-
> >  drivers/block/Kconfig  | 12 +++++++++++-
> >  drivers/block/Makefile |  2 +-
> >  4 files changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/disk/Makefile b/disk/Makefile
> > index c16876e2073..18b839f6ecd 100644
> > --- a/disk/Makefile
> > +++ b/disk/Makefile
> > @@ -10,8 +10,8 @@ ifdef CONFIG_$(PHASE_)BLK
> >  obj-$(CONFIG_$(PHASE_)PARTITIONS)  +=3D disk-uclass.o
> >  endif
> >
> > -# Must have BLK or SPL_LEGACY_BLOCK to support partitions
> > -ifneq ($(CONFIG_$(PHASE_)BLK),$(CONFIG_SPL_LEGACY_BLOCK),)
> > +# Must have BLK or LEGACY_BLOCK to support partitions
> > +ifneq ($(CONFIG_$(PHASE_)BLK),$(CONFIG_$(PHASE_)LEGACY_BLOCK),)
> >  obj-$(CONFIG_$(PHASE_)DOS_PARTITION)   +=3D part_dos.o
> >  obj-$(CONFIG_$(PHASE_)ISO_PARTITION)   +=3D part_iso.o
> >  obj-$(CONFIG_$(PHASE_)EFI_PARTITION)   +=3D part_efi.o
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 5403206159c..989be07cd02 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -74,7 +74,6 @@ obj-$(CONFIG_SPL_USB_GADGET) +=3D usb/gadget/udc/
> >  obj-$(CONFIG_SPL_WATCHDOG) +=3D watchdog/
> >  obj-$(CONFIG_SPL_USB_HOST) +=3D usb/host/
> >  obj-$(CONFIG_SPL_SATA) +=3D ata/ scsi/
> > -obj-$(CONFIG_SPL_LEGACY_BLOCK) +=3D block/
> >  obj-$(CONFIG_SPL_THERMAL) +=3D thermal/
> >  obj-$(CONFIG_SPL_UFS_SUPPORT) +=3D scsi/ ufs/
> >
> > @@ -82,6 +81,12 @@ endif
> >  endif
> >  endif
> >
> > +ifdef CONFIG_XPL_BUILD
> > +
> > +obj-$(CONFIG_$(PHASE_)LEGACY_BLOCK) +=3D block/
> > +
> > +endif
>=20
> What's the purpose of the ifdeffery? I would expect it to work with or wi=
thout
> ifdeffery exactly in the same way. If CONFIG_XPL_BUILD is not defined,
> CONFIG_$(PHASE_)LEGACY_BLOCK becomes CONFIG_LEGACY_BLOCK which does not e=
xists.
>=20
> > +
> >  ifdef CONFIG_TPL_BUILD
> >
> >  obj-$(CONFIG_TPL_MPC8XXX_INIT_DDR) +=3D ddr/fsl/
> > diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> > index d44cf4bcb6b..e6f1d82267b 100644
> > --- a/drivers/block/Kconfig
> > +++ b/drivers/block/Kconfig
> > @@ -15,7 +15,17 @@ config SPL_LEGACY_BLOCK
> >         default y if SPL_AHCI_PCI
> >         help
> >           Some devices require block support whether or not DM is enabl=
ed. This
> > -         is only supported in SPL. With this, the blk uclass is not us=
ed, but
> > +         is only supported in SPL and TPL. With this, the blk uclass i=
s not used, but
> > +         instead a legacy implementation of block devices is used, wit=
h all
> > +         devices consisting of 'struct blk_desc' records.
> > +
> > +config TPL_LEGACY_BLOCK
> > +       bool # "Enable Legacy Block Device in TPL"
> > +       depends on TPL
> > +       default y if TPL_MMC || SCSI || NVME || IDE
> > +       help
> > +         Some devices require block support whether or not DM is enabl=
ed. This
> > +         is only supported in SPL and TPL. With this, the blk uclass i=
s not used, but
> >           instead a legacy implementation of block devices is used, wit=
h all
> >           devices consisting of 'struct blk_desc' records.
> >
> > diff --git a/drivers/block/Makefile b/drivers/block/Makefile
> > index c827fa81a2d..e88914db283 100644
> > --- a/drivers/block/Makefile
> > +++ b/drivers/block/Makefile
> > @@ -6,7 +6,7 @@
> >  obj-$(CONFIG_$(PHASE_)BLK) +=3D blk-uclass.o
> >
> >  ifndef CONFIG_$(PHASE_)BLK
> > -obj-$(CONFIG_SPL_LEGACY_BLOCK) +=3D blk_legacy.o
> > +obj-$(CONFIG_$(PHASE_)LEGACY_BLOCK) +=3D blk_legacy.o
>=20
> Should we have VPL_LEGACY_BLOCK too?
> Right now, this breaks sandbox_vpl_defconfig build.

Ugh. We should, yes, add a VPL_LEGACY_BLOCK symbol too, for
bisecability.

--=20
Tom

--Gu2TMRuFFGdktuRY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavIlUQAKCRAr4qD1Cr/k
CjgjAP0fU+BJ+/UMjTyEmhYb/IqTrl6nvgFrPM/dJjt7feBKAAEA8rVnU4/Vu1ik
ZebqGVpSWvvNaWQLy7cTPWTrZnQbGgU=
=sS/y
-----END PGP SIGNATURE-----

--Gu2TMRuFFGdktuRY--
