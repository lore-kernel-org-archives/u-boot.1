Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B29FEFB6E
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 17:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05C1D83D1A;
	Fri, 27 Feb 2026 18:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cq2d5Cx3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 821A883D1A; Fri, 27 Feb 2026 18:39:29 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D23E683CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 18:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-45effa36240so1747082b6e.1
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 09:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772213965; x=1772818765; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1srLfxqNiUws/k6FZXFi/Yz+Z0dI00qn1j2xdpf297s=;
 b=Cq2d5Cx30DER/3I66cwsMBfKM4owcPYpsZ4H9ipubfAMR5bH+FmwvZVRlNi9sU1hOO
 fCM/iy/Xe6+4Gi8ZYFQV/ALRDzfW1z1kQPv1Kv1uayVVPyUyAkO4A4xkxEcONGo+ffvm
 +pOuaLZsMe5HFphzZdeX4zrQFJOLWew8yegUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772213965; x=1772818765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1srLfxqNiUws/k6FZXFi/Yz+Z0dI00qn1j2xdpf297s=;
 b=UILCtEizOGCjiQEbEG/8G+Wt4WeI5ARSeKU/XxQciw4eMLZy73+GbBWQrbEsTBSmDs
 2pkBrzSKhhVMXK9YddlA0TMgzsUlNqR5NDUpVJJE259noKwjF3fr+8yQaz1o/CQj2M94
 8aOXJyJxryPzzQKOcSpmIfdV8CfXkaRJDzJE06IDaIhYr76fGcJuOFT6dOoB5BlNAuZz
 e834h+W7R0fG33YTPiXi8EMg6MSqKopebCdKto81iysdVoWXfj0V3ayZDyV6XlArstC8
 A25Kv8qjtqrziZBHJdIgGwkzdsr3S74OcdKeK+DAMAUAY03bygrnUtkJaTxcBy61qNM+
 d1cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWexEzGdJNjkNBdnRMyK1hgLQ81fW5VnaxJ1bl8kgnxpBkTCM/6PlfVFHO8g+KIvUgp/dwBSig=@lists.denx.de
X-Gm-Message-State: AOJu0YzTHID8TTWwuRlda2m1T7c65cBr6HscY60XdyMSw3tVkCa1acZ3
 L6qdcC+lgO8G89m0M5KXfheJUOdJ+F/gMDUCd2F2aRXNMJBeCZi7JUwGymra5jI3A2o=
X-Gm-Gg: ATEYQzxfGt6TdzQqvRHqNjIxPrNWO7i283c+KLKq30NoYtl88t2XDjC6LB3wM79bI79
 DvsA9DeTe+wcOPGQmdJUY/BemsAj6KycxdJKMXwnh4vIh41xeRvPAU3kE39r4gxLBYamulxeWD8
 jWzpKawWYt6i2E78CWeOWBWLPHQB2/8qQ3mT1eQtgM8tQ+zzIdaqTX9QfchZ5wqLmHursT83ufF
 tyGJEQfoRwONRw9ENkhPUyVXV9ylZpRGjaLj/AfZxhGK7VAl5/nv3cjZ1kJtruSgDtQE70+G1gA
 WbKT6HjLZ4YPEqQ6mzhEi3ak5DdBYJghGPGpSV3+rbXubEH4ftJMCLkEg5MVsBd2PrhP65ZwGqk
 v0ZYioIUmrcxkAcNbAyKvAcZnD8r4gSXoaSN9oZh/xF8r0U4soRmWG0qmsEI41LoCnQT0toi54n
 20VJe99Y0nKhMQJKprRD/Qq4bvKU+8x2k76w4Voyu9urWbW0YP170X0ov4m7PCOzSQE1hMDos1W
 bqYPJyclSGoz2XyIvuVCS+9JrChWdMZSKjz3HahnLF1cwVndv8=
X-Received: by 2002:a05:6808:f87:b0:450:cc23:98c6 with SMTP id
 5614622812f47-464bec615bemr1903619b6e.56.1772213965450; 
 Fri, 27 Feb 2026 09:39:25 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb352720sm2393797b6e.2.2026.02.27.09.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 09:39:24 -0800 (PST)
Date: Fri, 27 Feb 2026 11:39:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: "Francis, Neha" <n-francis@ti.com>,
 Stefan Eichenberger <eichest@gmail.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 stefan.eichenberger@toradex.com, s-k6@ti.com, w.egorov@phytec.de,
 emanuele.ghidoli@toradex.com, francesco.dolcini@toradex.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] common/memsize.c: Fix get_ram_size() original data
 restore
Message-ID: <20260227173922.GV1593142@bill-the-cat>
References: <20250314100734.23777-1-eichest@gmail.com>
 <20260226070502.GA6701@francesco-nb>
 <20260226142345.GB1593142@bill-the-cat>
 <20260226160901.GA29510@francesco-nb>
 <aaB1DifzODCVv4SU@eichest-laptop>
 <20260226163117.GJ1593142@bill-the-cat>
 <c8e7db77-5c9f-490c-a5e5-30607fde09aa@ti.com>
 <34966334-4658-4fe2-8b6f-550969c1f91f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p1G5u38snRIlWCk0"
Content-Disposition: inline
In-Reply-To: <34966334-4658-4fe2-8b6f-550969c1f91f@gmail.com>
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


--p1G5u38snRIlWCk0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 11:39:44AM +0100, Emanuele Ghidoli wrote:
>=20
>=20
> On 2/27/26 11:13, Francis, Neha wrote:
> >=20
> >=20
> > On 2/26/2026 10:01 PM, Tom Rini wrote:
> >> On Thu, Feb 26, 2026 at 05:30:06PM +0100, Stefan Eichenberger wrote:
> >>> Hi Francesco and Tom,
> >>>
> >>> On Thu, Feb 26, 2026 at 05:11:49PM +0100, Francesco Dolcini wrote:
> >>>> +Emanuele
> >>>>
> >>>> Hello Tom,
> >>>>
> >>>> On Thu, Feb 26, 2026 at 08:23:45AM -0600, Tom Rini wrote:
> >>>>> On Thu, Feb 26, 2026 at 08:05:02AM +0100, Francesco Dolcini wrote:
> >>>>>> Hello Tom,
> >>>>>>
> >>>>>> On Fri, Mar 14, 2025 at 11:06:49AM +0100, Stefan Eichenberger wrot=
e:
> >>>>>>> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >>>>>>>
> >>>>>>> The get_ram_size() function fails to restore the original RAM dat=
a when
> >>>>>>> the data cache is enabled. This issue was observed on an AM625 R5=
 SPL
> >>>>>>> with 512MB of RAM and is a regression that became visible with
> >>>>>>> commit bc07851897bd ("board: ti: Pull redundant DDR functions to =
a common
> >>>>>>> location and Fixup DDR size when ECC is enabled").
> >>>>>>>
> >>>>>>> Observed boot failure messages:
> >>>>>>>   Warning: Did not detect image signing certificate. Skipping aut=
hentication to prevent boot failure. This will fail on Security Enforcing(H=
S-SE) devices
> >>>>>>>   Authentication passed
> >>>>>>>   Starting ATF on ARM64 core...
> >>>>>>>
> >>>>>>> The system then hangs. This indicates that without a data cache f=
lush,
> >>>>>>> data in the cache is not coherent with RAM, preventing the system=
 from
> >>>>>>> booting. This was verified by printing the content of this addres=
s when
> >>>>>>> the issue occurs.
> >>>>>>>
> >>>>>>> Add a data cache flush after each restore operation to resolve th=
is
> >>>>>>> issue.
> >>>>>>>
> >>>>>>> Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to =
a common location and Fixup DDR size when ECC is enabled")
> >>>>>>> Fixes: 1c64b98c1ec4 ("common/memsize.c: Fix get_ram_size() when c=
ache is enabled")
> >>>>>>> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.c=
om>
> >>>>>>
> >>>>>> Tom, can we merge this?
> >>>>>> This is the last bit to solve the regression reported here,
> >>>>>> https://lore.kernel.org/all/20260224152405.GD340942@francesco-nb/
> >>>>>
> >>>>> I wasn't happy with this at the time, and Stefan's last email in the
> >>>>> thread left me with the impression more investigation was needed and
> >>>>> likely something else was the root cause.
> >>>>
> >>>> I believe that this patch is needed.
> >>>>
> >>>> On AM62 what is happening is the following.
> >>>>
> >>>> We have a cortex-R5 that is the first core booting (there is also a
> >>>> cortex-m4, but it's not relevant for this discussion).
> >>>>
> >>>> It runs from internal memory and it configures the DDR ram
> >>>>
> >>>> We load to DDR memory various pieces of firmware (TFA, U-Boot for the
> >>>> cortex A53, ...)
> >>>>
> >>>> We do execute get_ram_size(), that read/write the memory, and it is
> >>>> supposed to restore it back the original content
> >>>>
> >>>> However when we have the cache enabled, we might miss to write back =
the
> >>>> original memory content, where the other pieces of firmware are.
> >>>>
> >>>> And after that we start the cortex A53, running in DDR, and there the
> >>>> memory content might not be correct, because there is no cache coher=
ency
> >>>> between the cortex-A and the cortex-R. And because of that we have
> >>>> crashes.
> >>>>
> >>>> Stefan: any comment here? Can you help?
> >>>
> >>> I think what you wrote summarises the issue well. If I recall correct=
ly,
> >>> I "fixed" the issue last time by simply calling get_ram_size() once
> >>> before enabling the cache. This was in commit 4164289db882e. The SPL
> >>> then informs U-Boot of the memory size via fdt fixup. However, someth=
ing
> >>> has probably changed now (possibly in the R5 SPL), meaning the cache =
is
> >>> enabled earlier, so the cache is enabled again when get_ram_size() is
> >>> called.
> >>>
> >>> For the AMP use case, either "get_ram_size" should not be called once
> >>> the cache is enabled, or a similar patch to the one I proposed is
> >>> required.
> >>
> >> I would lean towards the former if at all possible.
> >>
> >=20
> > Just trying to understand, what is the reasoning behind ensuring get_ra=
m_size is
> > not called if cache is not enabled? Wasn't get_ram_size written with the
> > possibility of cache being enabled (existence of dcache_en logic); then=
 this
> > patch is a valid fix right?
> >=20
> > In parallel, I do agree we need to have a code analysis w.r.t dram_init=
, we are
> > making certain cache and dram calls spuriously making this confusing.
> >=20
>=20
> Hello Tom,
> I agree with Francis.
>=20
> When I proposed commit 1c64b98c1ec4 ("common/memsize.c: Fix get_ram_size()
> when cache is enabled"), I was not considering the presence of other acto=
rs
> (other cores, DMA engines, etc.).
>=20
> That patch fixes what I had overlooked at the time. We need to restore the
> actual RAM contents, not only what is perceived by the core executing
> get_ram_size().
>=20
> To me this patch sounds intrinsically correct.

Alright. Can I please get some Reviewed / Tested by tags? Thanks.

--=20
Tom

--p1G5u38snRIlWCk0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaHWxgAKCRAr4qD1Cr/k
ChPFAQDDf0dcw2KIMC0383CVdQpgfhY85twcf09VIBwJZ09vvwD/dL6xTJcukeyt
L54yuucuJZpc5g4s9tuHyh5jmge6lAU=
=Xbjq
-----END PGP SIGNATURE-----

--p1G5u38snRIlWCk0--
