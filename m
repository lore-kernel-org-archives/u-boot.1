Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3BBC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 22:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC21A60674;
	Mon, 24 Aug 2026 22:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uKIT7gu4brDH; Mon, 24 Aug 2026 22:55:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787612117;
	bh=kPb1K8o8cHNv5Wq67RkkmzuQkQJxvXdtLtlm9+Bwiq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xHJ4ZbpGkAIrssrk3NTVSO9j185fWVNKgDEdna7VFPp54oW0MDN7x1NyXrfhr7Ak6
	 sw5iI1bfUDNSdKM7ZUt/bH2O1PUAsfkQR4dnJUeksglt9hAx2dGtGCnek0U0Jar278
	 PokQLWfvqbM7a3pQ5IPdvbV6pAQKsuw/VybBEAePp3qjE5Aq3raufUyQ4dyIg8IU50
	 fRN31wazzCJEcal0A2W5eCUDXMwT8w3y8Pfo5g4OhE1ok8A2IUxuLNqqPf1uUHD42W
	 QoR7RM/Fh8ls78nMc52lleCAJWFWsWdJlFCf9zAqXV94KSSTierIGTk4GOCbMcGyeP
	 BJhdYkEYiXYrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EACD6063A;
	Mon, 24 Aug 2026 22:55:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0853A118
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 22:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E24696063A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 22:55:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S9McXrKkT1Nn for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 22:55:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=N7+Wa9R1
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1EA2560618
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 22:55:14 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4472500e25fso2932334fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787612114; x=1788216914;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kPb1K8o8cHNv5Wq67RkkmzuQkQJxvXdtLtlm9+Bwiq8=;
 b=N7+Wa9R1/4kbBc4i6vcsH2JKbUyPizsMa4kLiik9Rg5TXhRWvqamrgBzRHz7mtzPhz
 GaDRerJDiIa2tNCzPSbzZwPmimzfw0WZkG0W8KpQZK7O9stBQ3x1nLyQ0I2GGyXRMTop
 Z77QG2LbTfrHtobnVII/di1XDBzyn8Slvcf6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787612114; x=1788216914;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kPb1K8o8cHNv5Wq67RkkmzuQkQJxvXdtLtlm9+Bwiq8=;
 b=ZI6gu7Y/UuJYgSujaJcjAO+ljJiOx+nkGKqkDX+876SmjCcb3wnNjCOC7IxKYMnxn9
 Zs4O83xz6K5oFajkiprW7owfyQY68gkCO0qosQfktd6m6gPeoLTZKzkYuWWxRFw+YQpi
 RU5A2qvWhq7xcewL6ZQiiEzoHlEpscWtdh8z5JfazjH+HMbamku4uwIv3oq1bux61BXd
 Y5Vs77+sLB9YzZFfUb5DTLWJHyJVFC2K7PaMPAnRT420LpDzmk17Ef+Oip3oi4nd8jO9
 U2GLDww6LdJcqIXUg2ScTzmNjF/1Hv5XXiNaocmztbHcu3OanJrS7V/EoISGGsWR3Ce2
 CBXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RotCa6T1SkvYl5PyRL29FKewKIyx1P+cMMiXEHIrpI/09R9aaMnL4hHOXnhNc72210gKqeECIo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mcYOhHMD+v9GPusjSuOtY43fkZKclsqfrZhOwWW8IpkpZ7kZuU
 AKGH4AXTGUAQctjkBQs06Jp3SMWvQfMd0KhTgual9m7pWZFbRLywZ8kNzvQFMbW1+O0=
X-Gm-Gg: AR+sD13yEDdfgDH9M9GzuIRG0RakpWX32F+vLD8QTK8ZJ2lPQLlUWhE9UJJ0/5HrM7f
 DRf+2+YXp2VdjkbGWLtBSVtawCBJ935BHk4wOWn2IyxE39huCugtDIj63LYSJq1Q2c0r0Bh/epE
 Fwkvn7r8CPB11h2Z/R0Iynjr0fsWGh6hkY6PPK2ZHExs7GjmGTCPJMYwAeRFh3fLyGyfqqRPn3g
 g6LKNzkluUkHzqPsXq4c8JkvWRXQ9X6cS2bCEnRggrnKDYyl9K8h3ub2XfSPe/2667fLqPeZ7Ol
 xnh4rEGbdWytXx4g+C8BuHzFjCTBxGsuwS2fqoti/8kRME73wSm/68vhaNt4Z8jurxAAoEjbM/B
 8sZ6fgmnYlycn2O9UMI1J1yLH2CfHKS2JiWXQKd/1hFsJz1PPF49GY4PN6LX1Y78NH06hWOFJPz
 8RTA14f61tPYMT3Z8p52CgyHtAu+Qr9CiKTQ7mBLC7uNQ2Cvbnvs5m96+16ipQM8ml8nf0rszCC
 GDQSbmuqgbMZBafg9LMx+XZa9SzplXsG5cOa1NFFj2wVFM8r0EC8BPKKbhljdDgaHUe0MnlbRbA
 Rq+aUFWmrFoUbXz0nmCz
X-Received: by 2002:a05:6870:d365:b0:448:908d:27e0 with SMTP id
 586e51a60fabf-4637f9f4426mr21226002fac.4.1787612113639; 
 Mon, 24 Aug 2026 15:55:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4638313340dsm6004797fac.2.2026.08.24.15.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 15:55:12 -0700 (PDT)
Date: Mon, 24 Aug 2026 16:55:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Weijie Gao <weijie.gao@mediatek.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>,
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: Re: [PATCH 5/9] boot: add imagemap on-demand loading from storage
Message-ID: <20260824225509.GN523975@bill-the-cat>
References: <cover.1787272661.git.daniel@makrotopia.org>
 <0d1a6ae2867fddcefe2c224ed47af14fc41abd2e.1787272661.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FhgBebJeBDDKk4R8"
Content-Disposition: inline
In-Reply-To: <0d1a6ae2867fddcefe2c224ed47af14fc41abd2e.1787272661.git.daniel@makrotopia.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--FhgBebJeBDDKk4R8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 08:13:55PM +0100, Daniel Golle wrote:
> Introduce imagemap, a small layer that reads image data from a storage
> device on demand and keeps a translation table of the byte ranges
> already loaded into RAM, instead of copying the whole image up front.
>=20
> An imagemap device (UCLASS_IMAGEMAP) is created over a partition of a
> block device with imagemap_create(); imagemap_map() then returns a RAM
> pointer for any byte range, reading it in on first access and reusing
> it on later accesses -- so a header probe, verification and the final
> load of the same range share a single read. Block devices cover more
> than raw disks: an MTD partition is reached through mtdblock and a UBI
> volume through ubiblock, each exposed as a named block-device
> partition, so imagemap needs no storage-specific code of its own.
>=20
> The read path is built on the SPL struct spl_load_info abstraction and
> a new spl_load_region() helper (added to spl.h): the block reader
> reports the device block length and spl_load_region() performs the
> native sector alignment. imagemap_map_to() keeps a payload byte-exact
> at a caller's load address, reading the aligned middle straight to the
> destination and bouncing only the partial head/tail block.
>=20
> Regions that are not placed at a caller-supplied address are allocated
> through the LMB allocator and released on cleanup; the translation
> table doubles as the registry of those allocations. imagemap is gated
> to the full-U-Boot phase, so SPL and TPL carry no new cost.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
[snip]
> diff --git a/include/spl.h b/include/spl.h
> index 5078d7525ab..24df44d23e1 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -350,10 +350,21 @@ typedef ulong (*spl_load_reader)(struct spl_load_in=
fo *load, ulong sector,
>   * @phase: Image phase to load
>   * @no_fdt_update: true to update the FDT with any loadables that are lo=
aded
>   */
> +/*
> + * struct spl_load_info carries a device block length for the SPL block
> + * loaders (CONFIG_SPL_LOAD_BLOCK) and, in full U-Boot, for the imagemap
> + * on-demand loader (CONFIG_IMAGEMAP);

This part should be made clear in updates to the existing comment block.

> imagemap is gated out of the xpl
> + * phases so SPL and TPL carry no new cost.

This doesn't need to be noted I think because..

> + */
> +#if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK) || \
> +	(IS_ENABLED(CONFIG_IMAGEMAP) && !defined(CONFIG_XPL_BUILD))
> +#define SPL_LOAD_INFO_HAS_BL_LEN
> +#endif
> +
>  struct spl_load_info {
>  	spl_load_reader read;
>  	void *priv;
> -#if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
> +#ifdef SPL_LOAD_INFO_HAS_BL_LEN

Why not just:
#if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK) || CONFIG_IS_ENABLED(IMAGEMAP)

? Then for when someone says "Ah, I want to do all of this right in SPL"
there's less changes.

--=20
Tom

--FhgBebJeBDDKk4R8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaozLyQAKCRAr4qD1Cr/k
CokTAP9Ea1Gn/wH0kP2wWqTYAz2p/jwFvrOF7TvewP5ItNTJeQD/XZFinbhSoz2r
/zW8BWmrp/NACnitD2IpKJKmtd051QQ=
=gKL3
-----END PGP SIGNATURE-----

--FhgBebJeBDDKk4R8--
