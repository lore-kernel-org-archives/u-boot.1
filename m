Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54A2CCF9E3
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 19:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11B6B83642;
	Sun,  2 Nov 2025 20:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t4/0X9uk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C57B78389A; Sun,  2 Nov 2025 20:30:22 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55D98830A0
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 20:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-3d199f29161so3055671fac.0
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 11:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762111819; x=1762716619; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lteBE4QM4lJr3s8qY34OSoZ4WuZxA2ItOQUYv+4F22A=;
 b=t4/0X9ukUCO885tRm135FWvnjfV4CwPJtNjGK0tPVjRgRbVnkSmG1VXM87WsrKmpmo
 2OfV5X+Io3vvAYb5MDQs9unsmlN97GfSGMTcVPQHGZFpcSoTy6bu+LkvVYgikDb7rqjX
 B+YTCSTDHlmwBJFk71RLvRpVKq++Vf1yEwTts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762111819; x=1762716619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lteBE4QM4lJr3s8qY34OSoZ4WuZxA2ItOQUYv+4F22A=;
 b=nPy7oXnlLlFNm+hf2bDNn4kI9lNrNH32jCwHr4GuTToJjvPzgtXYXmSJoTl03MjlOs
 u5Nu2nVCOxzyHQoB6bE363ZXOBqZVD/Q9/uqhawlUnYMrDPzw9+TnnOMjt5F2MljJhdZ
 yXNTghoNsGFN8oZ50Rls5+ztlzX/x5LanipN06zy+nNiqR10sizhDruYLn295z3A8SNP
 vDUD/CGvFRy1rM6hwoPsZ7Hf2uqRWzYVOCH8YW9NHdajrs8Pyq4ZBKYqWvhsKCkAqpFP
 dZkLDPPL67Xq/NeapImES1owUJokhSC376b5yvXfaQGmWLev3Y4E+QEWlZZ8RHbCvZS/
 beKA==
X-Gm-Message-State: AOJu0YxuI0YwTfXyiCVU+98vRsFdJew1wND83RnLRnkBxo+psp2nvQLN
 VgceDJb6cKZJNkYJ6AE7+hZqBMDFy2vqX2o1AywpziTVP6wEjHBTsBZ7rheH/Pe5QC4=
X-Gm-Gg: ASbGncuqL5FwpZIFGKZUElF7nP+c1vXQ4d6Q2rgL1uEYdPAO3ZrX6x4qDBbLTk+05MO
 CXjeTCyVw9sQU9WFcn0YmhPFGzXjAYHQrl7/TWG77ueao41gzbrqyszBwdE6Z8LOnfpUrEeLppH
 tBfg+m1BAgJU+RNsqco6ZOYA3kIb9s73//n1GTl64zcYmHNl/Lw1LWbyrkewOeeG2nLaZYHry+R
 Jhu+88b2Lc3fNTtnYUfnO9oG2+BjbDNGeZk0IaY+amGV1QDyCtaseHmUxQvmaGDDHyoGnfjbUOj
 QMDoZobJQMCNnU+BFLANHZ/05afP9MF1ZKQzcqTYN0UxdymMVv8eZGgfzjfZB5JwCn2E8smsU3s
 E+idqepFWnQa4igcKPBYVVPEcDNoCkuVoevIjj1RptNDmLW2OLYdb558pF1VpRNf1m2XcvOh+Nl
 29E9hhmydlwEWL7+s0ZZ0/05PuGp8HOUUSkjxTP9/Y/btua/+yIw==
X-Google-Smtp-Source: AGHT+IFXqCkd4vv89805ooTZhm+OWoW06tx2mRU/tAJCwdePwJuEFeApLgx4PfbdO/eRohxKp0eApQ==
X-Received: by 2002:a05:6870:e2d5:b0:3d3:52b1:d731 with SMTP id
 586e51a60fabf-3dacbfc13b4mr5250840fac.31.1762111818958; 
 Sun, 02 Nov 2025 11:30:18 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3db40d8efcbsm2848302fac.9.2025.11.02.11.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 11:30:18 -0800 (PST)
Date: Sun, 2 Nov 2025 13:30:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20251101
Message-ID: <20251102193015.GH6688@bill-the-cat>
References: <20251102022349.326599-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rhfGe++1LS8zNC8/"
Content-Disposition: inline
In-Reply-To: <20251102022349.326599-1-kever.yang@rock-chips.com>
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


--rhfGe++1LS8zNC8/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2025 at 10:23:49AM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the updates for rockchip platform:
> - New Boards support:=20
> 	rk3588: MNT Reform2
> 	rk3528: Radxa ROCK 2A/2F
> 	rk3576: ArmSoM Sige1, Luckfox Omni3576, FriendlyElec NanoPi M5, Radxa RO=
CK 4D
> 	rk3568: Lunzn FastRhino R66S
> - Other board level updates.
>=20
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/28119
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit e34d01d23e45e007368685ffa6dfd674b6dd7b=
17:
>=20
>   Merge tag 'u-boot-ufs-20251029' of https://source.denx.de/u-boot/custod=
ians/u-boot-ufs (2025-10-29 07:41:43 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20251101
>=20
> for you to fetch changes up to 498a9756adf57e94af64e31b144a6698c656c50a:
>=20
>   mmc: rockchip_sdhci: Set xx_TAP_VALUE for RK3528 (2025-11-02 00:29:58 +=
0800)
>=20

First, in general, this is now applied to u-boot/master. Second, in
specifics, configs/mnt-reform2-rk3588_defconfig enabled
CONFIG_CMD_USB_MASS_STORAGE however there are dependencies missing which
means that it's not actually in the build.

--=20
Tom

--rhfGe++1LS8zNC8/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQexRAAKCRAr4qD1Cr/k
CtzZAP9+e8blE1ke2ucxzC1z0XPyCIfhy7rCuASEEm3Sw3gkbQEAki6DB66zefsr
2ghgA0yph6+RVAzAZPoyWRAxTrogGgA=
=zvLZ
-----END PGP SIGNATURE-----

--rhfGe++1LS8zNC8/--
