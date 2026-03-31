Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B2F109B474
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 14:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDAB183DA6;
	Tue, 31 Mar 2026 16:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IU1WSZoV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 342D383DA7; Tue, 31 Mar 2026 16:28:13 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C714A83A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 16:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40ea611d1a4so2266200fac.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 07:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774967289; x=1775572089; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+AKTkWb4JidNcUmhseJnVh9x6XUWl9RepWqDkCG76wM=;
 b=IU1WSZoVbiWDKk4HLOPloa9IeofP/4a/Od/eweKdVK2CIYGXMzkqKoAf9sh08yDl3d
 TgTzsN50DxqGgRtvv/HocelsCXaNAZtX75I/o4qSQbqn8vnyrs4tRYLLRJZx+aBN26Uw
 1WycPB2qj8avaGckWvTnxTQGVGmkAPXBGRaWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774967289; x=1775572089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+AKTkWb4JidNcUmhseJnVh9x6XUWl9RepWqDkCG76wM=;
 b=MypjOuMLqOMubspCtGB9RTiR8SD3J6FrD7WkOjqO7AqMypx+fZiJJ/SljPlOMsjAjh
 u3etAReG3KyCvmEncTJn0UriNgB/D5JV0yU1zhVSR2K9aCQjMY3dEH0MhR73dYlwGCNT
 X9Th/S3K8Hbe3RQbHPJ2I+XiB58QxD6pyoqybaodQdofztYQC+3Y0u1y/9zW9dsc9M+b
 wgnJp8zkPPPmny98FACY4rGkxiwdTbmEVQV9xZRhSmRoMRgHAceBA8I+rYUrWPtkpN/N
 mjqbkbsqTJkAvx1M4oYsdmtDxk4ZN0z5FuZpdB+PPdYpVC6pzvaF3edZTO1coB6KI35H
 +ZAg==
X-Gm-Message-State: AOJu0YxprAcFCbbGGht7vJGIWLuboGhnMPTE+toqPcdr5l4G2G6T5jiK
 awdEYkSNjUcJVDR/SDdioQMGpjuS3AoVADge7mHU5XKKF1LIBc54d0xmAyyWHM6NAL4=
X-Gm-Gg: ATEYQzw2nAJGcVYuATIYePSfy4RcWdiRscHkgSL+echNBFzyNlpgcdHRehVTwGxLKJp
 UKicPp3CvTb/b7b8gS+707S29N2bJxpJUvUvBDHW08fjXIxVrf2tApyKxcysDLZFCxx4yPUBmMP
 BrILqN6fEmKUxZB4NUOi+Xlnrq6LsvCrSf0HNZZ4fRPzWZY9dIDP64omfogX8cQL6zkS447wgdZ
 NAKMa7cw13w1VM+GgqJr3qmSy0VCOL+APnfuDeRA+RA0W153ka5ZPfnSjNBe+gLLV2pP1OkAQqA
 vAHUxOGXFbxP8th8/083JiHg4qezsSvS29NLWXPTVzkLMyPzkvE2rFzHzJv4K9UuT9d4y+CDsEL
 veu0iP4N+MozLC0VoEhgeFrQah4IQVo35TYlhIHh+4Hon3vivdTwujnVXSBeaBhF47jVeIH/yNK
 Lw8dRLcnGrhdY4Bv40VFQpjauZc22r/VcNHj75RHfaU5Au3okhmPY9i/zY/279AWK6KKDW/obVI
 4Tds4j0FP8IAm0njVgT2z0g+C8WlNObav8mcY3A5RGHGuVJ
X-Received: by 2002:a05:6870:f20d:b0:41b:f7f5:e887 with SMTP id
 586e51a60fabf-41cec27479emr9310158fac.24.1774967289424; 
 Tue, 31 Mar 2026 07:28:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d04501478sm7362136fac.0.2026.03.31.07.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 07:28:08 -0700 (PDT)
Date: Tue, 31 Mar 2026 08:28:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v2 0/3] fwu: Call EFI stack initialization after preboot
Message-ID: <20260331142806.GA1235458@bill-the-cat>
References: <cover.1773840306.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nlUeZ3HRg1+4JIcL"
Content-Disposition: inline
In-Reply-To: <cover.1773840306.git.michal.simek@amd.com>
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


--nlUeZ3HRg1+4JIcL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 02:25:08PM +0100, Michal Simek wrote:

> Hi,
>=20
> the whole series is trying to address issues we have on platforms where u=
sb
> and ufs init are not done before efi initialization. This is happenin on
> platforms where A/B update is enabled. FWU code is called early and do EFI
> initialization before usb and ufs started that's why they are not visible.
>=20
> We are workarounding it by starting usb/ufs from board file but this shou=
ld
> be more generic approach.

This doesn't build on current next:
https://source.denx.de/u-boot/u-boot/-/jobs/1416493#L1001
common/event.c:56:1: error: static assertion failed: "event type_name size"
   56 | _Static_assert(ARRAY_SIZE(type_name) =3D=3D EVT_COUNT, "event type_=
name size");
      | ^~~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:271: common/event.o] Error 1
make[1]: *** [Makefile:2201: common] Error 2
make[1]: *** Waiting for unfinished jobs....

--=20
Tom

--nlUeZ3HRg1+4JIcL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacvZ8wAKCRAr4qD1Cr/k
CqPHAQC0lzhjTjCbTcfHrOdlSi+gwQImIa3cADiEJxvMbj3I4gEAmAopblGtnXvz
vE/gALlSKgnklZ6AmttFai2qyLVNzAc=
=YLqW
-----END PGP SIGNATURE-----

--nlUeZ3HRg1+4JIcL--
