Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B407C3DA42
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 14:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9435188771;
	Mon,  8 Jul 2024 16:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IhRnO2cV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7858D8752A; Mon,  8 Jul 2024 16:35:26 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF9C88771
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 16:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3d932f991f6so557971b6e.1
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720449321; x=1721054121; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=280rrqZxmrfQbUlXSWhopO4YjIsmqfvoD76ol3mVPiY=;
 b=IhRnO2cV5MFDgzrxv/P0ZY2hskYPxbGWsq6o+L7oUZtICBwYVZJZ84K8NjIC9aUm8S
 BKx43lXj0XVSS1go7u2XmRc4+WyB7eE+LXTlI0RaSBu0KWuxkhbHWzxsiod4e3m+u505
 YhqLT8qECpCXZZ9o2IfTxP1aG7+ilOo37UXd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720449321; x=1721054121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=280rrqZxmrfQbUlXSWhopO4YjIsmqfvoD76ol3mVPiY=;
 b=pBMHc3jdZnyQmc8hutEq49ZCtlCwztXt2BiGKRrAC0ohI8WMrgfuospmqAsla65ML7
 58vc7AuXtFcWxNWErG72U791t10u6+GMIoof40PndwC1HrqSnQfaounWicpfFrx2vQA6
 ff/GA43Sckh0awFOdNTWedZFLlKQLB7OAYd/Jk+sq0klBFs+Lp1yxGHHeuS+RRpvIL2X
 39TOZh/hJotkFjCHfnfM0nr22iwsoeZWzELgz7CCYPcSpQaV/EZYKtncVYckpqm133aU
 iy5nfCOr8H64a0VpnNoOXqya8+G6mTgFY6Y8c05jm7Zp6JM3Ko9rzKDnFfJMsXKubRxt
 LWEQ==
X-Gm-Message-State: AOJu0Yz0h2tSSkTEdOecndKiyu8OWdkctVU2N3PLv9K0Tj+f1sy7lhdN
 YUoVWxojx+3CgUupVpYkSE+haoa6+dT4Mfn3MpW/uTcZai+a3Yv3hqsByNLx45M=
X-Google-Smtp-Source: AGHT+IGVUA8CkVZ1bC6ulsIYiecrhguFcnW4OYr4jW0yzJHuQ2erMD0P3vao83y9W5mWVx9FHFDIlg==
X-Received: by 2002:a05:6808:23d2:b0:3d9:32c8:46d5 with SMTP id
 5614622812f47-3d932c8516bmr2582236b6e.39.1720449321622; 
 Mon, 08 Jul 2024 07:35:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d93ad13733sm11454b6e.16.2024.07.08.07.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 07:35:21 -0700 (PDT)
Date: Mon, 8 Jul 2024 08:35:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 00/48] Make U-Boot memory reservations coherent
Message-ID: <20240708143518.GC38804@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0mXt8Bm6NMjQOabh"
Content-Disposition: inline
In-Reply-To: <20240704073544.670249-1-sughosh.ganu@linaro.org>
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


--0mXt8Bm6NMjQOabh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 01:04:56PM +0530, Sughosh Ganu wrote:

> The aim of this patch series is to fix the current state of
> incoherence between modules when it comes to memory usage. The primary
> issue that this series is trying to fix is that the EFI memory module
> which is responsible for allocating and freeing memory, does not have
> any visibility of the memory that is being used by the LMB
> module. This is further complicated by the fact that the LMB
> allocations are caller specific -- the LMB memory map is not global
> nor persistent. This means that the memory "allocated" by the LMB
> module might be relevant only for a given function. Hence one of the
> requirements for making the memory usage visible across modules is to
> make LMB allocations persistent and global, and then have means to
> communicate the use of memory across modules.
>=20
> The first set of patches in this series work on making the LMB memory
> map persistent and global. This is being done keeping in mind the
> usage of LMB memory by platforms where the same memory region can be
> used to load multiple different images. What is not allowed is to
> overwrite memory that has been allocated by the other module,
> currently the EFI memory module. This is being achieved by introducing
> a new flag, LMB_NOOVERWRITE, which represents memory which cannot be
> re-requested once allocated.
>=20
> A review comment on the earlier version was to do away with the static
> arrays for the LMB lists of free and used memory. This version
> uses the alloced list data structure for the LMB lists.
>=20
> The second set of patches are making changes to the EFI memory module
> to make use of the LMB functions to allocate and free memory. A
> *_flags() version of LMB API's has been introduced for the same. The
> earlier version was using notification mechanism from both LMB and EFI
> modules to maintain memory coherence. This version makes use of the
> LMB API functions for the memory allocations. This is based on review
> comments of EFI maintainers.

Please re-work so that the series is bisectable. For example
xilinx_zynqmp_r5 fails that check currently. And I found that looking in
to why it grows by ~1500 bytes overall. This likely is due to
CONFIG_EFI_LOADER=3Dn and so while the case where EFI_LOADER is enabled
tends to be a size win (reduction) or wash we need to look at the
CONFIG_EFI_LOADER=3Dn case more. The alist code will be a little growth
and that's fine enough. But realloc and do_bdinfo are the two big
growths at the top, in this case.

--=20
Tom

--0mXt8Bm6NMjQOabh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaL+SIACgkQFHw5/5Y0
tyzdvgv8C1JHwJ8oi9v3Ugv7BDhFl4ZPl3k9mHs1jiSGsKOYYfkyWsWYR7eBksmt
lSfzfWEwYFPOJWsEDE1ckrAsUNf4jOc53qpgobp9vQ+LNQHzZ5I3LnekSEJy34ij
fM2zWnvIKKtZw4v4Y9SL4RUsX5pfLdt7xIa6Fc0MYBV7x85pNrdPGTbvtccoeX5z
vCsYbw7HIu+e2qA11pWeA9ZxibI2VZjDzNZypFJ4w8NdyFls6f6uHM0a2icKS181
PSNrlKZJQOLASvQrUaKjg2l2Rocya1ELEU2W6/6iPsWE82uDXaPsLnxiiNwTDExM
/tvVqGdTauUffnbchdl+uFdxr4y7myp8XA4eEr9s3uI+0IJ1/1LFQMsJMFsGVXGg
i6Kw+wYZA7j0N759a08AvLSgS9JGLdWiSP2c3LPzXel32uI+mGs9Ca6nxAxpznLc
5DBc3HmX24Or98XPceGY3PfS1hZG4bxsQRI3CqFFU8z/fVMR3EDy0OLHOcd4n7dC
475I/S1d
=iQgn
-----END PGP SIGNATURE-----

--0mXt8Bm6NMjQOabh--
