Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0E6D3C926
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 17:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8587C891A4;
	Sat, 19 Oct 2024 19:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UriyMo/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D76F8919D; Sat, 19 Oct 2024 19:51:30 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B19CE88EAE
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 19:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b150dc7bc0so226376985a.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 10:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729360286; x=1729965086; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6D/MU8QICWS0Dxdaczin66vsC8vTjQWajItjz5hoNA0=;
 b=UriyMo/2TxzYfnShXwIVlnP2CCOalJlcTlz68DSbJNMcI0I2WUzvdlzOs3CJxx+ng5
 2kZa5TuVsFDXeoy+03DMfMhkSfke0EuX6lLkIei7r+Wi4q20mHtCTdup3AjfI8Xj1PcR
 xmHMvdQh2lk3COvPhQtAzD9r61+3KU+1BVkF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729360286; x=1729965086;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6D/MU8QICWS0Dxdaczin66vsC8vTjQWajItjz5hoNA0=;
 b=GtnX4C/DRcZxPozlAkdleTRLAknpwp/HYTH/gh9L3VBz4W6jtpvUTUsafbkvtTxxuv
 BRItAM1bEKZvltxl6SkML5uf+0jXfX41p5t5rZI+cUt+KDAr2tgJQHHIGAfpKixibUc2
 QR+2vMa9sh2oXfWEjQYvo004T+/KfhwjBwItzk36pTILoCiIw6MYy5AF9RB7mswW1l9b
 PFAoKcQs8qGdhGjUC0fIHi5dXbfmBtBf6iJGCZmAOfWVQ/1c16rDPjLymBu1PQadZ9Rc
 rfFv8fdqM3eV5EB+x7NJsYHTaxx5HeK11MqOhrJ0CCuAqIM4F44edKA+ftjDR18d+Tes
 Y2ug==
X-Gm-Message-State: AOJu0YzQcuIgsA+sWk0Ftwt1YBGJpkO0ShEuyM4C8le6CqNec/p8Ndgw
 GNW3Y1oVaNJ1dW0otF3Y1hj5rZwz79q479C7krbNCdROM/USdHe+kudvP48vteU=
X-Google-Smtp-Source: AGHT+IF3UP6aOy+wdO8w4bx8KNp17OQIV68F2pAeQdUjrYEh9mDtjZPWffn+udX4YmapW20szDPgyA==
X-Received: by 2002:a05:620a:24d0:b0:7a9:b268:3655 with SMTP id
 af79cd13be357-7b157bdeb54mr858489485a.43.1729360286467; 
 Sat, 19 Oct 2024 10:51:26 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a06daasm1808785a.70.2024.10.19.10.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 10:51:25 -0700 (PDT)
Date: Sat, 19 Oct 2024 11:51:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: Re: [PATCH v7 6/7] test: efi: boot: Set up an image suitable for EFI
 testing
Message-ID: <20241019175121.GA4959@bill-the-cat>
References: <20241019152434.1017394-1-sjg@chromium.org>
 <20241019152434.1017394-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WSSSUBLeR5BtVfqu"
Content-Disposition: inline
In-Reply-To: <20241019152434.1017394-7-sjg@chromium.org>
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


--WSSSUBLeR5BtVfqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 09:24:33AM -0600, Simon Glass wrote:

> Create a new disk for use with tests, which contains the new 'testapp'
> EFI app specifically intended for testing the EFI loader.
>=20
> Attach it to the USB device, since most testing is currently done with
> mmc.
>=20
> Initially this image will be used to test the EFI bootmeth.
>=20
> Fix a stale comment in prep_mmc_bootdev() while we are here.
>=20
> For now this uses sudo and a compressed fallback file, like all the
> other bootstd tests. Once this series is in, the patch which moves
> this to use user-space tools will be cleaned up and re-submitted.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
>=20
> ---
> Here is the patch to avoid sudo and CI fallback:
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/patch/
> 20240802093322.15240-1-richard@nod.at/
>=20
> (no changes since v1)
>=20
>  arch/sandbox/dts/test.dts           |   2 +-
>  test/boot/bootdev.c                 |  18 +++++++++-
>  test/boot/bootflow.c                |   2 +-
>  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes

This I think best illustrates the problem with "BOOTSBOX.EFI". This
image will work for CI up until I can figure out how to get access to
free arm64 servers to run some tests on and then it will fail.

This is also an ext4 image and while the specification only says SHOULD
for being FAT32 there are practical problems with using ext4 and not
FAT32 for us (some missing features in our ext4 implementation that
prevent variables from working) and so should be done as FAT32 and not
ext4.

--=20
Tom

--WSSSUBLeR5BtVfqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcT8ZkACgkQFHw5/5Y0
tyzf1Av9H+WjJLgh7JKg9ItGWW/R9GxN6cNkb5uRQ8bQI/NYgMppOJ1fa8voD9qG
F+oxPQ9tEUNnrr8KHTHQJQ2ozJcIze5mR4kjFlHviG7P+bvLWiQN6u8YxzLPzO3V
26UNr2D0wg17BYykGtmRxXaIdVBBNS32q/a1I7nujXFVL5JVWi/x/2CpnOaYAY0G
Yw/jEaj7m85RuEjvmKfIpfph2daUhC5KIIIyBKcqlHNsXAAlpzMFqhyitZD/2Lwb
KB2h6F5Q1OQUIB4hpH4WoW42Kk70b1gaT4MxGS9P3QP6WYS2byVpCH7h8iNPfTU+
xqFWDGG73QQIG3gsAdWkhos433+nqZ596bUg9C/OS5WhPcEJ/B6ZjhaNOW9G7rA1
pk9jGoY6c1RCPNIJ70lkyEZE+HKoQDLMLLechInIFIKFtzseXJQaTBkp6QNXPMlq
C3GyOIFco3PZggh7ajGouOkhAROxd52m9LAx8ww9bTFK/CqDH4/xl0HT8s0F+Yqk
7kEndA5w
=2a1A
-----END PGP SIGNATURE-----

--WSSSUBLeR5BtVfqu--
