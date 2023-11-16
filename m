Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD540C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 20:18:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB8E886F45;
	Thu, 16 Nov 2023 21:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ACHHXAZN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA57E86F3A; Thu, 16 Nov 2023 21:18:00 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 883A786F5C
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 21:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41cda69486eso7041881cf.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 12:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700165875; x=1700770675; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2vEj3m2xU7vooDDWmPMgOn86oaK3bEHR1NDsnJHXGmQ=;
 b=ACHHXAZNYpRP2Zs96vLVg5Je2s7cz+IVPFJyuJbrvV1dk1wuviSJWFBs+FdefMRU2m
 ELhMqVbENMvo+cWM9SD8dxzIfpiYWEYTQzZklR4Tv3fsOdbBxDj1wo+f+MqVAB43Nku1
 u+ZwqAmdTfsq3rWdVi2+4kN99EZdbY5nXgexk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700165875; x=1700770675;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vEj3m2xU7vooDDWmPMgOn86oaK3bEHR1NDsnJHXGmQ=;
 b=BQ/aflhdE//A5GIh9iOWmWjId9TUHZkeL1gnyFdzx5VQjKpKJn52z09F7sBr/rLKFN
 AVCGDPoE8CG2ph+2Kbvy2Fyr9BLp+c0W2pPnOU7r42rsekBip+y1usecXcUrTtJ5s8j3
 Nw7zNBvSRrohgWnl5wE1jKJHqXGaz8ri+M7n2qwDMwfsS9QvyvVk7KCPKQ/iHm/kkfT6
 fQ/Lm/e4EJYbhAuprRJw2dN9ymhBZ8tgrffUqIkvIqT2RrUyWRyHAj9QqutHF9yZjw39
 pnucUHy4JjGcRNZehhCvaryXaJu3jIiImc5v+BhZGEn+ch+MUGil1S/Ff3KohgmuNt6c
 yPDA==
X-Gm-Message-State: AOJu0Yy92H+s7hlUhadrF/mNQCXopMg4LzSjkDzZHj7tdfkmVxjtffsb
 z8fMZgFn8IqWl0RaDlcF2jkjNg==
X-Google-Smtp-Source: AGHT+IEt23bXWFlgOoYVQ5FdAOktqCtmT0m1uY2LC3x9aoafYwZx8/6DXIBxJzrIOlur2KXqRPjFsw==
X-Received: by 2002:ac8:5a8c:0:b0:418:273:c337 with SMTP id
 c12-20020ac85a8c000000b004180273c337mr9598682qtc.61.1700165875323; 
 Thu, 16 Nov 2023 12:17:55 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-31e8-20a7-2ee8-ec91.res6.spectrum.com.
 [2603:6081:7b00:6400:31e8:20a7:2ee8:ec91])
 by smtp.gmail.com with ESMTPSA id
 z5-20020ac87105000000b0041aff9339a2sm42567qto.22.2023.11.16.12.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 12:17:54 -0800 (PST)
Date: Thu, 16 Nov 2023 15:17:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Alexander Gendin <agendin@matrox.com>, Zong Li <zong.li@sifive.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 6/6] configs: defconfig for QEMU RISC-V with ACPI
Message-ID: <20231116201751.GH170968@bill-the-cat>
References: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
 <20231115142355.123038-7-heinrich.schuchardt@canonical.com>
 <20231116183703.GD170968@bill-the-cat>
 <5eef4f1d-106d-4a74-bc9b-4929fc96294b@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3dXXlVnmf84JghvC"
Content-Disposition: inline
In-Reply-To: <5eef4f1d-106d-4a74-bc9b-4929fc96294b@canonical.com>
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


--3dXXlVnmf84JghvC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 09:04:27PM +0100, Heinrich Schuchardt wrote:
> On 11/16/23 19:37, Tom Rini wrote:
> > On Wed, Nov 15, 2023 at 03:23:55PM +0100, Heinrich Schuchardt wrote:
> >=20
> > > Provide a defconfig for testing ACPI on RISC-V.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   board/emulation/qemu-riscv/MAINTAINERS    |  1 +
> > >   configs/qemu-riscv64_acpi_smode_defconfig | 27 ++++++++++++++++++++=
+++
> > >   2 files changed, 28 insertions(+)
> > >   create mode 100644 configs/qemu-riscv64_acpi_smode_defconfig
> >=20
> > This feels like a case where we should start using fragments rather than
> > a cp'd defconfig.
>=20
> Do our CI scripts support Kconfig fragments?

With some other patches, yes we could have build coverage. Or if this
moves to the point where we'll be running pytest on the configuration as
well it would be handled that way instead.

--=20
Tom

--3dXXlVnmf84JghvC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWeO8ACgkQFHw5/5Y0
tyw8Dgv+PB6PpXMMf9hsIWg4OoRMcGbwjTEe2zw1lrBZJJAQ/QQte7PN146GSYi+
8W1yaBX2udvoUkEFNLpusKhyAKJYtZhif/0q3TgEAXrKNRcDIXk21CmEHqoJegMq
DyCJ13Ek9Xl0l8JHCd+ViL4ZCKKmmrTHBqVH/NpmtmSn6FLgxZBy6pefqaixWi6b
uyop54Lj8Ia6qkS1A3XF/cuZs19uhEyh7pkZGknht8JmBRE/SZGj3xfBmTYxLeYp
FeOk06CG262fD/wCFRKyxt6NmytdVcR8BHYaa7Xht/BLPSV+Oo3c7pRu40P1xbR/
FT6EwviC8dMO1KLwYhQTMck5bgk+0swjOU7J1Y27sY7YEe+xr/Otd5mR7fZ/j0Zf
ecxPz91K2HnNMNTm6ba1LgtNQkctcp1dC9mNnMP+B4xnYdN0lF3ApmbG84xaszUm
66ni7VwprqvXYSuAZe0QLTN6wkQB+8Oa0HdImVZuveQc2eFRRLUTu4QWYqsPc5Nw
sRDifPcm
=3eih
-----END PGP SIGNATURE-----

--3dXXlVnmf84JghvC--
