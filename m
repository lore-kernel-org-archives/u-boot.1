Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3172BC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 15:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B4083893;
	Thu, 24 Jul 2025 17:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J5VgaOcw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3C9283894; Thu, 24 Jul 2025 17:06:17 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3997F83844
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 17:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2eb6c422828so1421529fac.1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753369574; x=1753974374; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=are2wh8H152Zx+DZoCmbVcNNNZy2i/G0EX7e5epd864=;
 b=J5VgaOcwzjpSlMOq8ogAM0x9QLLnn42Wjq20YCZN7uSJoj4fnnZ4jRV8MiY7IOhOhk
 YRuhc1x2J5HrjE4gkzJXsSqPsUfcd3NWFQ5IVqwmpKCatCpvfL1tsCQowTNx7dQzJiXA
 7lBl12tSJM0NP6ZRrW0C7lPZDJ09GtzjoZtZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753369574; x=1753974374;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=are2wh8H152Zx+DZoCmbVcNNNZy2i/G0EX7e5epd864=;
 b=Eoyprp40GtI7IylOmhn+gZPWBxbIDGKz1E8svJ1FfNEE3wVpj/j6Y3BuB8+H5XYybv
 vfFAOY8nAUnzoPKnnOZ0UDTKu7M01RSiD1pA8hYdv4TSWvEkS+71VijpfszNWC8+TrVz
 cYBbU70ZRwivIXLlr5CK5rxZ2mDySsr6Uag0UYYnnjptv9bNhD6mBbSC/rSi8Tek8wdK
 ixWCJLtKJKaHwjZHFJDP2lMA1Thy7KlemfE/kkWABWW8WDr4eQ7udIqKtgl58774Jhkn
 u4AjV3EbqE7MXYYf0efkm+Tz+ZdbbU0nEVWlx6BmHixRG/PLKLDJMY10kJbJgd4/lmaD
 qKpg==
X-Gm-Message-State: AOJu0YzjRCbUOPPoJhCM+sARpyg/phXbXaZcfdHqWkhGxludd9kKw7ME
 CoqHeYwHw3Mbe3eJWdFvySp4BwRXu1BEyQZqXVj1Xz2olbPxIecjhQTL0wy87c2W7I0=
X-Gm-Gg: ASbGncutSpUA0/TEPKeTMhYP8o5ITFTPbt1Fu3wsUOukSWB/uHr9YIHsGZBUtEUJf9J
 7E9t42aC4zAfQvKp/ktB5vL9xRkHtPHyumxmU55Xv5nxDmIXgpUrpx3nsLcJLKeYDWqSmHfX0e+
 YNzp4K9Tg8xb2Y4pfJQm/Qw+WvtPHnI9yFwxQPVw6oFPzCAQPGdXx3D1nSG7vjP+0CqcNq2Ab3x
 GjMY7iaPOGOTUOKwiTolslMXaQuJ0ZtAI8KNcAYGfCFIETRUTJNI9zVql2d2VmvOV+RSAYrmO7q
 f6hb6V+rA6D87mac1Gty+aKcUNSZWQj9LaFtlpS6MJwxi0b4YpfMrosOTzeVmtq1qREvnIiGSKP
 lmspL0k4a6JiWHgT9Am/Esh1G42hiHyS8Xzx5teAhi7iJBfFT2BX1MJdv
X-Google-Smtp-Source: AGHT+IFIwu47u8ZEffw9w4ymylSOgZIIQGSOrIJ6ZS/qe/8aFQZ3oNYW0QyxGBMd1X9kkImpDWlfSg==
X-Received: by 2002:a05:6871:2312:b0:2e8:f6d4:535f with SMTP id
 586e51a60fabf-306e8410541mr1501026fac.14.1753369573209; 
 Thu, 24 Jul 2025 08:06:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7412d319dcesm276470a34.51.2025.07.24.08.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 08:06:12 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:06:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: Re: [GIT PULL] AMD/Xilinx/FPGA changes for 2025-10-rc1-v
Message-ID: <20250724150610.GP2847763@bill-the-cat>
References: <fec4bd62-0883-40c5-a1a6-cb672e489075@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iGyHEzsEroFjcqgv"
Content-Disposition: inline
In-Reply-To: <fec4bd62-0883-40c5-a1a6-cb672e489075@amd.com>
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


--iGyHEzsEroFjcqgv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 02:10:05PM +0200, Michal Simek wrote:

> Hi,
>=20
> I am sending you another series of patches for rc1. Gitlab CI is not show=
ing
> any issue. The biggest is FPGA series and there is on patch revert in spi
> which should get to tree.
> I have some other patches pending but I want to give others more time for
> review that's why will apply them in future.
>=20
> Thanks,
> Michal
>=20
>=20
> The following changes since commit 3532f1f5edfc97c9dcea723cdeb732eda44bc6=
69:
>=20
>   block: Remove blk_find_first/next (2025-07-23 17:37:14 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2025.10-rc1-v2
>=20
> for you to fetch changes up to 27fa1e2c1794cc589d72d485488c0bbb3b877f09:
>=20
>   firmware: zynqmp: Simplify power-domain driver bind (2025-07-24 09:06:5=
2 +0200)
>=20
> ----------------------------------------------------------------
> AMD/Xilinx/FPGA changes for v2025.10-rc1 v2
>=20
> zynqmp:
> - Generate fit-dtb.blob all the time
> - Simplify power-domain driver bind
>=20
> zynqmp_mini:
> - Remove PSCI_RESET
>=20
> fpga:
> - Improve user feedback in case of FPGA bitstream load failure
>=20
> misc:
> - Fix kernel-doc in gpio zynq and axi_mrmac
>=20
> spi:
> - Revert fix in STIG mode
>=20
> ----------------------------------------------------------------
> Michal Simek (3):
>       xilinx: zynqmp: Remove PSCI_RESET from mini configurations
>       arm64: zynqmp: Let fit-dtb.blob generated all the time
>       firmware: zynqmp: Simplify power-domain driver bind
>=20
> Pieter Van Trappen (6):
>       cmd: fpga: improve user feedback in case of bitstream load failure
>       drivers: fpga: add Kconfig dependency
>       drivers: fpga: correct compiler errors and warnings
>       drivers: fpga: cleanup printf usage
>       drivers: fpga: fix function declaration without a prototype
>       configs: enable FPGA commands and drivers at sandbox_defconfig

So here's a real fun problem that for now I've just worked around by
disabling CONFIG_FPGA_VERSALPL=3Dy on sandbox. One of the tests that's in
Azure but not Gitlab is building sandbox with clang with ASAN
(AddressSanitizer) support enabled. And only in that configuration do we
see this build failure:
/usr/bin/ld: /tmp/lto-llvm-3b170f.o: in function `versal_load':
drivers/fpga/versalpl.c:(.text.versal_load+0x11d): undefined reference to `=
xilinx_pm_request'
clang-18: error: linker command failed with exit code 1 (use -v to see invo=
cation)

This function is defined in drivers/firmware/firmware-zynqmp.c (requires
CONFIG_ZYNQMP_FIRMWARE, which can't build on sandbox) and a weak
do-nothing in drivers/mmc/zynq_sdhci.c (can't build on sandbox).

I don't know why clang trips up on this, but gcc does not. But in the
end, now that this series has been applied I'll do a further "Tighten
up..." patch on drivers/fpga/Kconfig and update drivers/fpga/versalpl.c
and drivers/fpga/zynqmppl.c to depend on ZYNQMP_FIRMWARE.

I'm testing the rest of this PR still, I just wanted to note this part
now while I've dug it out.

--=20
Tom

--iGyHEzsEroFjcqgv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIJL3gAKCRAr4qD1Cr/k
CqEWAQCBItJN4ZovhCClDuX1op/gxPZw8t0uVy8xqCUq3sAGOgD8DlcvB6739cCn
MuUdWdQ5MDQa7hbVoMzZEWrKgjKFwQM=
=quyt
-----END PGP SIGNATURE-----

--iGyHEzsEroFjcqgv--
