Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EDDCD6E44
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 14:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 034BA803C6;
	Thu, 28 May 2026 16:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pfm2BzSA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E51F68056B; Thu, 28 May 2026 16:28:49 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48FA880398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 16:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e61da76fd9so3899600a34.0
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779978526; x=1780583326; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v2FEhzo+6IV+AdbEoVFyl71EBiXKH4de81dPX8Juico=;
 b=Pfm2BzSAF5K5RZRiO8EI5eaRfAOOf+uiyvjwSEANBumOt6+kM2KRXMFdklBSUCH/22
 fxXXCk4SthG20V6eDXqgs4sBty2BHLebl3sPAQCwWvsj5++oj3r9x/qi7eR2daQsXUlc
 XEQ+TlACJgnsXnG0vUQSjSzXeZRFeTwqLOhPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779978526; x=1780583326;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2FEhzo+6IV+AdbEoVFyl71EBiXKH4de81dPX8Juico=;
 b=SPQIfow62yGph8RJKPLWpI3d1z2tGhAY6rNm9kr2iPIF5sJoC17UA8uDEbcoaerYlT
 L9mgQiGqKvShbmqTYbbFJJSPietV++sKiqOZ2NiAh7kG9jMRrxio0xVcwifEd/SNdSpP
 sQ2CE0L6YS2IE8q9CtBh7PLX0sGZMnjrjE0EQ04khthiQWfEMN15YgUK/Ms2wfKzKiGw
 qM+TvibSiJlj9skizenP2K0nc3Z08Mny7jjBwmNEagVUKIyn5MXk427cYmXr2vvqafK8
 Diw47Z1qwk3H2lm4XXEMVH1KpV3Fhku8GwhJo6G0V7a+PKsYqnDiAX7b6KH40aX4vGq4
 mySQ==
X-Gm-Message-State: AOJu0YwOB1+UDQLMwBmZflkhAldITGGmvn4yBkUx11NSlmK88l+WrJNJ
 9wPczRMv3Ga9mG27AAf0I6tQqCVq/Fa5qsxNucz09A913IQRAGaoGDpX4vHSJQjJSik=
X-Gm-Gg: Acq92OGecl2Ezh1A0xXlffzLDWT71SNTgEv40rFGDq4rYFFXfmtPzRdAr/sM5Nt+9/5
 nUzZm5oN7cHQBmQOVPvQVXORcb3yneZviXkqMRpYZ0I3otFESjj8dgfRUfSB03eJoG6he+gEga5
 SMRYL6PGlDxfwXcs0eng94MNPpv6hbGnuqqX0WBp5g3vz60LoOVHaFZ4UKcflUGaMZ1oyi1NPKk
 MNsgCZJRupa4lyGBPt+FmxgYi+fZE4WBj0PhLPTE9eK7/ZPGPqeVl7kRwrmGRE5hQBMGcOxJvhd
 yCxsKJb6zKwEgEP4kCkELuKCn2beHUNIEsFehoezUHCiEfeM8XJhh0LkmFDIWn/5l6S0WyqhXa4
 36pSiNTs0ky8+sg6yKEbupccEa5P9gk0A1J9vMrMs33GDS4HKHHOX8dWPlBankXeCPgorxVX155
 eZuYfTntQdC5Q4TVoPbCtAsrss6gkkJug3aakm0qfs39wsu09831FHPglIygpwEdgr/ummkhDGr
 kIJBb50ZbOuRhl47n8ry3lQKNe6V3zmFZth5tuJR3epaWKb39vn0NVO
X-Received: by 2002:a05:6830:d8b:b0:7de:a2cc:9da2 with SMTP id
 46e09a7af769-7e5feeb9b4emr17365621a34.15.1779978526014; 
 Thu, 28 May 2026 07:28:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e7722sm13967280a34.15.2026.05.28.07.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 07:28:45 -0700 (PDT)
Date: Thu, 28 May 2026 08:28:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Siu Ming Tong <smtong@axiado.com>
Cc: u-boot@lists.denx.de, Prasad Bolisetty <pbolisetty@axiado.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Tzu-Hao Wei <twei@axiado.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Karthikeyan Mitran <kmitran@axiado.com>
Subject: Re: [PATCH v2 0/2] This series introduces initial U-Boot support for
 mach-axiado AX3005 SCM3005 board,
 a quad-core ARM Cortex-A53 (ARMv8/ARM64) platform.
Message-ID: <20260528142842.GD93986@bill-the-cat>
References: <20260527-review-v2-0-10daefddf47d@axiado.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RfSpD4PHm/03mKMN"
Content-Disposition: inline
In-Reply-To: <20260527-review-v2-0-10daefddf47d@axiado.com>
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


--RfSpD4PHm/03mKMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 07:38:35PM -0700, Siu Ming Tong wrote:
> Patch 1 adds the device tree files: an SoC-level DTSI describing
> GIC-v3, Cadence/Zynq UART, a fixed reference clock, and spin-table
> secondary CPU boot, plus a board-level DTS setting the console to
> uart3 at 115200 baud with 2 GB DRAM at 0x80000000.
>=20
> Patch 2 adds mach-axiado to support Axiado SoC-based boards, Kconfig=20
> plumbing (AXIADO_AX3005 and TARGET_SCM3005), defconfig, board source=20
> with ft_board_setup() and a MAINTAINERS entry.
>=20
> Tested on SCM3005 EVK hardware
>=20
> B4-Revision: 2
> To: u-boot@lists.denx.de
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Siu Ming Tong <smtong@axiado.com>
> Cc: Prasad Bolisetty <pbolisetty@axiado.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Tzu-Hao Wei <twei@axiado.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
>=20
> Signed-off-by: smtong <smtong@axiado.com>
> ---
> ---
> Changes in v2:
> - Added new mach-axiado with support for SCM3005 boards.
> - Link to v1: https://lore.kernel.org/r/20260428-ax3005_scm3005-v1-0-7fed=
19ee6fe0@axiado.com

My questions to v1 were not answered, please go back and reply, thanks.

--=20
Tom

--RfSpD4PHm/03mKMN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahhRFwAKCRAr4qD1Cr/k
CqxjAP4xcZkROlVq71IglI0wHp4e0K3aih/kYreajuytvs4vAQEAk/+L/g+4DpaV
5trT0MMAOcXjrb0hvBj0wpqJlpuITAU=
=+ucA
-----END PGP SIGNATURE-----

--RfSpD4PHm/03mKMN--
