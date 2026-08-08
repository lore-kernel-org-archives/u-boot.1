Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E860C5AD4E
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 19:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38671606A9;
	Sat,  8 Aug 2026 19:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9IhBiL-XeqZ0; Sat,  8 Aug 2026 19:35:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E0F06066F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786217724;
	bh=GjlBT0MElMcVKdLr8OZt8wtNuFaCxIyr5xPfaWv2jNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i5zLeDXyH/g/YdPfsxJ4P9fX1/u6QOhUlh2PtzZSG5d1JHQfTJz8/FxwpF8WyhWJo
	 e/3Pe7faV/A/wJOHAyl6yT8Odoq5r7ABtqyj4t5ErIN78gXuWCzbpR89Lo2PkgYjjn
	 yCcqpx9EmrvlOFF2SXnIc3nOetJ/jJ70aRHx5OTyXDL4rtbIKX4hDmMsa6vHUkuR0d
	 I9wNIMp8K/O8dZWIC0fNjRs1Lmro/mNEJOdfIDKkZR2wKgMdq5Gc+mzyFvhNXlB+Pz
	 zkIQm5ylqQ1Ba/z/yO61Op/8sK+ex8Th6tl67P4ZMGcsodPKaYev7cxncCPwuXI+VQ
	 IK0ndeGGDoetg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E0F06066F;
	Sat,  8 Aug 2026 19:35:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 20CCA1AF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1333580BFB
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w3cPUc7axRW1 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 19:35:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 474F880BDD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 474F880BDD
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 474F880BDD
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:35:22 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e9d7464b71so198520a34.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 12:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786217721; x=1786822521;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GjlBT0MElMcVKdLr8OZt8wtNuFaCxIyr5xPfaWv2jNY=;
 b=DFYsgB+69tHt6IloF8jpz2I2Z2O7/F587EvrdLwePcjePv1LOZILGuvBL9Ns2PvESx
 G8+OY84zB2wEx3bYn5Ec2I92QYIewWdLYJtMTUstZJf0Mz+CJ+gdZQaqlaOkhPdPGy2x
 gRFJw3ZL7K+llDSAAM7QDUgSYH2hOrtmWM6QgG9NFlkiTZEzdco50zxTKlU/DHRyO95+
 r7AiLhQ0ImNbf+2QGOKMEIpzatGW2SgTfMSWhMddsWc0tGfEWJpcrrY1hBE1le/YyvnQ
 6DJw9lNt9D9R7ZxfnnHWBag/IvoZ95IwPmBmDGK0XpsL0WCy08MMzwThGHdreJ3Y6dhJ
 o2vg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrdm7YUVfFv3Rwa9JnGu5QLDbc0e4COc80SPVOdEnnrRcyw6KDK/Z0tO0GBQ35AD/A3ivYTHKE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxV860rhYmvr5TAsoLhSZoyx/yH6s+RJFQhUn5T5zHluLaIoB0+
 JK4Y3TVTRq2+UZsfkT6i/vqgfFSMVH43GC6RQaKlI0tQc3Ley+0+xYJ8dsbjUK1vzbA=
X-Gm-Gg: AR+sD11kOjWSxy2ejL1qvsGUuShfTvImCbRct1rakgGs38bKXSBtF9t5gI76aPb4fHQ
 8wfFqhkJk1TDUH3SAkVc2wXQ2g1xPIS+HGgVZ6pf5ir+x7qgkviBXy8gjdEDCnyEYXpi8/oIwwD
 D+/gcvsD57LD0o6RlGLas4SUDpKxO9fGzvZE+CMhr6DICoYi/ZOvpwRUwz0nyqV/aerWbrkXGo5
 fhgRWZ0+dNmBNnFVV9aGShrVjmykNyXzTftZ+2EyY41dRSdJ69336wUhKCnc7MRK30v928rwWve
 phAML0kPXkk10nOUNeNOV6nXZXaaQju/YuAcOUW4CqwqeFV0mb1J27WlIS77QukYbmrEw/+Wi59
 uaJNUOt1WfeG+b0FrN1R5Ggk7dph5ehbciSqbCmZcb5qdHavl99jl4WTzMoRQ2ykYb6H7lfvcqM
 Fh3ErIU8a3DILDxGNA/tHs2rfRjQNsFhWTIQSn71Sok+keBpEy0XEbP1a0Co4lOL0t9QSGe+NPp
 GwJ336IjY57fVdf03VG7suzj389n1l3172Jb3tNtx6/kTy3GcOGGr2jFiG1XdJM0iZre4B0FTXQ
 Pa0bl8Bd3A==
X-Received: by 2002:a05:6830:6d0d:b0:7e6:d384:459e with SMTP id
 46e09a7af769-7f1e5c0dee9mr20077908a34.3.1786217721154; 
 Sat, 08 Aug 2026 12:35:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f1e2d668sm4770775fac.14.2026.08.08.12.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 12:35:20 -0700 (PDT)
Date: Sat, 8 Aug 2026 13:35:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: alchark@flipper.net, u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] board_f: Make printing reset information optional
Message-ID: <20260808193518.GE394392@bill-the-cat>
References: <20260730-resetinfo-optional-v1-1-0b500903e4b3@flipper.net>
 <CAFLszTis8DL=VVUOKhCijxkKif62=ypMW0e_OdO2_WF3Q21t7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a8EzTx2SBBNHqLnh"
Content-Disposition: inline
In-Reply-To: <CAFLszTis8DL=VVUOKhCijxkKif62=ypMW0e_OdO2_WF3Q21t7w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786217721; x=1786822521;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GjlBT0MElMcVKdLr8OZt8wtNuFaCxIyr5xPfaWv2jNY=;
 b=ig0ybHtGISBRmaHPneVRye+N5Oq50zs1k9IsnS2oPTsFCchH74dDSBOSJSCP//IubW
 VhYvPLDEWE5OKNa25D9t7LLud5AW+74lIubKqFmAU2LIrpSipKhvrhcLHXdIeldvvG9O
 rn1ioaKugNeKpWJKXNkkGIzAWZ/yFJ6PQrAFc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ig0ybHtG
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--a8EzTx2SBBNHqLnh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 08, 2026 at 11:24:46AM -0600, Simon Glass wrote:
> Hi Alexey,
>=20
> On 2026-07-30T08:39:27, Alexey Charkov <alchark@flipper.net> wrote:
> > board_f: Make printing reset information optional
> >
> > Current code tries to print information about the reset method whenever
> > sysreset support is enabled. This causes the core to try to bind the
> > sysreset device in board_init_f, even if the driver doesn't support
> > reset status reporting, causing pure waste on some platforms (e.g. on
> > Rockchip RK3576 it increases the boot time by ~0.4s even though the dri=
ver
> > doesn't support reset status reporting).
> >
> > Make the printing of reset information optional, so that it can be
> > enabled only on platforms where it is supported and useful.
> >
> > Only four sysreset drivers actually implement the get_status() op, so
> > default the new symbol to y wherever one of them can be in use to avoid
> > regressing those platforms:
>=20
> >
> >  - sysreset_sandbox
> >  - sysreset_mpc83xx
> >  - sysreset_psci, whose weak stub get_status() is only overridden by i.=
MX9;
> >  - the pca9450 PMIC sysreset child driver.
>=20
> This would age better if each driver implementing get_status() opted
> in from its own Kconfig with 'imply SYSRESET_PRINT_RESETINFO', so the
> next addition or removal doesn't have to touch this Kconfig too. What
> do you think?
>=20
> >
> >  - sysreset_sandbox
> >  - sysreset_mpc83xx
> >  - sysreset_psci, whose weak stub get_status() is only overridden by i.=
MX9;
> >  - the pca9450 PMIC sysreset child driver.
> > [...]
> >
> > common/board_f.c         |  4 ++--
> >  drivers/sysreset/Kconfig | 14 ++++++++++++++
> >  2 files changed, 16 insertions(+), 2 deletions(-)
>=20
> > diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> > @@ -43,6 +43,20 @@ config VPL_SYSRESET
> > +config SYSRESET_PRINT_RESETINFO
> > +     bool "Print reset information during boot"
> > +     default y if SANDBOX
> > +     default y if SYSRESET_MPC83XX
> > +     default y if SYSRESET_PSCI && ARCH_IMX9
> > +     default y if DM_PMIC_PCA9450
>=20
> If you don't want the imply approach, please note in the help text
> that any board adding a new get_status() implementation must flip this
> on, otherwise the print will silently disappear on their next
> defconfig regeneration.

That's a bit of a non-sense comment.

--=20
Tom

--a8EzTx2SBBNHqLnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaneE9QAKCRAr4qD1Cr/k
CuxyAP9g9/iwf95/eBCxxxpWxFQE6QjFLDyr7wxtj8w2xy3OZwEA7fLS85NJgXLd
ocWP1NAIv6AtimlIXNYWbodwLPRCuQM=
=tZTD
-----END PGP SIGNATURE-----

--a8EzTx2SBBNHqLnh--
