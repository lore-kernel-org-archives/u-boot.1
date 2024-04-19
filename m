Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B87C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 21:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8984A8861B;
	Fri, 19 Apr 2024 23:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ngVmJgOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B6218862B; Fri, 19 Apr 2024 23:31:54 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF8A888736
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 23:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6eb8809a44eso1506350a34.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713562310; x=1714167110; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n5FwHrysRgFM+q1tyr3ZnDjd8f4FYLB9wrFVmJDr+TA=;
 b=ngVmJgOP+5PoIo/H7v7Lz53cxS3a7qFWj5M38i2wc87CAqxgcAPhmS/sXVFuSypFaf
 wR0D3cfZYJNo6Uje6jIkXbNtEJEV6dof0t54k3ohSrWpA3tt+yhX/+Gry10aRzEqnJYJ
 x6Wz4pnB84CBGxUGJju0oCNKe3NkiysL9szq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713562310; x=1714167110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5FwHrysRgFM+q1tyr3ZnDjd8f4FYLB9wrFVmJDr+TA=;
 b=GrUfwhtsOI/GHSYJPdnJ38nEQWcFfxeKBoD7rgByCMLwzvo5MqXSU4SwXkeKGzCSc2
 ZZPZE3fyLszfWoX/h7LE/APfddTZR4EydrPRS7UO5jr0m8jAix4XEGj4lpYnt/FFb4KA
 tHaeJhCb5mJXHv8XU4s4AxPlHioTB0wgPmL8xBbmUIAwpcOpifex6YCseJ/yxTidcIxT
 j1cl7vhKAf058xkuCulkeZo7wVoXAN4Bq7kBCCNeX8ytD0MORZ3CO9EeiZWQCmP07xNX
 FQeKO2/niihWZ8a859cyc2vuV+w7NEnaPK58BxAAURHyJ0PBphUSBe+AvXKI3iE16nu5
 ykUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHYvRmQ1rgZfaVBWiOjKiVX/7FKKPXg4+CBBNFEebHwCvTQj0qd3dfLAAV058puR9/D01wcH6+XPanCmXs1Tw1EU8E1A==
X-Gm-Message-State: AOJu0Yy4Ll1QwXbtp+5oOsIzI/WlbSyUCarirHNF6tY6m1n1nTTFjlzD
 ofDnFs4ijqaBl4CQ/eK5UajDNEUnmqiI6c/S6xXcXFq4lH9sGzXmoNjWgVxYvjM=
X-Google-Smtp-Source: AGHT+IHRcYkzXMHzfaJtwKhJtMJtnWa0Z8bKGk3jkfWk0xOwQggAlUQ9K31GcYAlKb53J2o5cN+FNg==
X-Received: by 2002:a9d:6407:0:b0:6ea:2d0c:6140 with SMTP id
 h7-20020a9d6407000000b006ea2d0c6140mr3653003otl.29.1713562310595; 
 Fri, 19 Apr 2024 14:31:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 oo8-20020a05620a530800b0078d693c0b4bsm1926240qkn.135.2024.04.19.14.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 14:31:50 -0700 (PDT)
Date: Fri, 19 Apr 2024 15:31:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Christophe Roullier <christophe.roullier@foss.st.com>,
 Christophe KERELLO <christophe.kerello@foss.st.com>,
 Marek Vasut <marex@denx.de>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PULL] Pull request for u-boot master / v2024.07 =
 u-boot-stm32-20240419
Message-ID: <20240419213147.GP1054907@bill-the-cat>
References: <7d10ae39-6134-4bd2-bf81-8b16ec88d294@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zngw7wMmSTbC1yiq"
Content-Disposition: inline
In-Reply-To: <7d10ae39-6134-4bd2-bf81-8b16ec88d294@foss.st.com>
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


--Zngw7wMmSTbC1yiq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 02:01:47PM +0200, Patrice CHOTARD wrote:

> Hi Tom
>=20
> Please pull the STM32 related patches for u-boot/master, v2024.07: u-boot=
-stm32-20240419
>=20
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipeline=
s/20430
>=20
>=20
> The following changes since commit 97b34f6ace539c9c16eb8565f8b58730848ba9=
7a:
>=20
>   env: mmc: print MMC device being read (2024-04-18 16:37:25 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm=
32-20240419
>=20
> for you to fetch changes up to b0283b5e3d37daff48b45c3f98d298844603def4:
>=20
>   ARM: dts: stm32: Add led-blue for stm32mp157c-ed1-scmi-u-boot (2024-04-=
19 12:05:10 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Zngw7wMmSTbC1yiq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYi4sMACgkQFHw5/5Y0
tyz6/Av8CBsFwtet+IFE7Xa/Mttc0eOMSNF2P46SohMbwM3gn6Hj/EmjMOHgnQB/
JoKDS3NxFwk1NwihhYJjR9fWDNJwcc0T5cyLEfpfwi2apQuL+vGM6yqMjsOK5JbR
gTW8cWT1pJiZK9P4uPy7FYtKcSBUzqCpQ00MNREtmjSZ7GC62kZPo6JKRwgpwFBO
FFaXi2Fjf1VkCqkus1yY6XcT1+RBRlIyx1o0CEyX8Yb2M/WcUvDh1wXfpykXaL/s
jzpNa0XGT4c2kVGlMtVpDocHLXcoX6N4blY5sM/zJSvOHaGZkoxG6edfBnjxT02L
74iudk6LfFvK29AfEGTr45ledb44yyCPaGk+6RYk8dBjiTkYnc5ouU55FadtzCKV
cDwemFYJmMdjefz4aYF90NfouQDTk4uoOQ1XbRJ2kgITEG4PpUCdseIT76E6BN4r
jVCsHHnLYVkzCG9mkKdDWkyTRMk2FEZ8bvI9pluy2l7I/zkcU48WMlCu3xJfDMOt
FRkzrpCw
=UMgc
-----END PGP SIGNATURE-----

--Zngw7wMmSTbC1yiq--
