Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38708E6ADDD
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 02:41:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCBA8989C;
	Sat, 23 Nov 2024 03:41:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l1etTNHO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F20893CA; Sat, 23 Nov 2024 03:41:28 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CC4A893DB
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 03:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b15467f383so185551585a.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 18:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732329685; x=1732934485; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Az4huVuheaHXx4ujkBnRb0EqCgRMLRm+ybC3sSGokMc=;
 b=l1etTNHO1S1vRvAREzM/iO+2uNTio/j8v6SREFDot2rg4llk/O66o/kSY/K/nM/KeW
 hcBXcUGliYNRVF1ALKhDaB/LkzGcIKyDF3sQOZLWMe7/5UVjUikR0tpk6PzhkDHxxGb8
 qmsgJuoIBDKD2bfszIS+hAPaoRJg8yRp9AdS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732329685; x=1732934485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Az4huVuheaHXx4ujkBnRb0EqCgRMLRm+ybC3sSGokMc=;
 b=dSU4a773rL2RzsVbJMreN+sUa2XDzYupar5P7vPPDDEvC7jfExFWfT1sZisk9Mc8OK
 6PeTklvd9EKdrcqvpPUiVR7487qfMxNKJpVfGxeVyV8mKIvi3pbeMPeuXHc6Eg+BuCSZ
 BmcnosJg6KV/VWODsiX4rNs7JX0e9Lq65Y/LAD0tQtViiF3LDXdoxwQOrdSqQehAJzIX
 KvXAeUkZBBgX7pMRwkIBJ3eikYhMlERlnvJK3WiXvAKPl2U9sBMoEwgKWt96CLjMY2EH
 Z//DYMUK2qAxByNO6YwK728N7f8Itk5vUAchA6r0CjH+yk42FdUBPDIa5oex609SZVW0
 pDNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKaycC3LiWmP7ltYlgNlanFbAvNdu9GFPnDlHwa4M3UzWvOzTaL6M3N10nZTVNJlpMpCCLcqw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6kKTzmwIkVDnsZ3SRntDlhQybldyM2A8ugdZKMtZWpRHlejaA
 1786TjRNuSdhcEbOH84OhqooYA+CCFtrT/6jQmxewPuKHVV+Yc797/M3Nybj8Cwm2+yPsykJuUV
 e
X-Gm-Gg: ASbGnct/KMuif4uHIe7mUffm1ejGKOqyUhvy/hbN7eD9F/2+IrNZQPTuNjsJE4sSDeJ
 2KGLz5TgObh8eYnbyzqx4azkTNnJtatHHc5/MD2eqNmrX6wcQqSpJi4gx3YkbIosJ7jfaKN/aYL
 76z7XPrWKqA7TXDQqtOrl8B6xxWrrIKkS7HQOQaF3KmoySRfSPNWs07t02+ZmbEOEgCcodFkiKC
 QBFSRLS5WeWjL14UlTMpcJJ0JSCz+jglfHJtip/KXn1WaJuCA==
X-Google-Smtp-Source: AGHT+IF89nXEPlX8RfypBuN41PX6tYHTKCe+skvYia9N38Q5aQ/YCe3mArovh04udmXCd5PssPGK5g==
X-Received: by 2002:a05:620a:4892:b0:7a1:e2d4:4ff3 with SMTP id
 af79cd13be357-7b5144ba642mr607891785a.3.1732329685172; 
 Fri, 22 Nov 2024 18:41:25 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b513f90436sm147364685a.6.2024.11.22.18.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 18:41:24 -0800 (PST)
Date: Fri, 22 Nov 2024 20:41:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, u-boot@lists.denx.de,
 u-boot-qcom@lists.denx.de
Subject: Re: [PULL] Please pull qcom/qcom-main
Message-ID: <20241123024120.GN3600562@bill-the-cat>
References: <20241120173127.977520-2-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bD/MEWGqBC6V3gB1"
Content-Disposition: inline
In-Reply-To: <20241120173127.977520-2-caleb.connolly@linaro.org>
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


--bD/MEWGqBC6V3gB1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 06:16:50PM +0100, Caleb Connolly wrote:

> Hi Tom,
>=20
> Some nice new features this cycle and a few cleanups for rc3.
>=20
> * UFS support is enabled for SC7280 and SM8150 platforms.
> * Qualcomm dt-bindings headers are all dropped in favour of dts/upstream.
> * The SMMU driver now correctly handles stream ID 0 and is disabled in EL=
2.
> * Initial support for capsule updates (using the new dynamic UUIDs) is ad=
ded
>   for the RB3 Gen 2 board alongside a new SCSI backend for DFU.
> * CONFIG_PINCONF is enabled in qcom_defconfig.
> * The vqmmc supply is now enabled for sdcard support on boards that need =
it.
> * A quirk is added for reading GPIOs on the PM8550 PMIC
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipeline=
s/23474
>=20
> Previous CI run prior to rebase: https://source.denx.de/u-boot/custodians=
/u-boot-snapdragon/-/pipelines/23364
>=20
> The following changes since commit 8573ea4105829b9a915b23f56d1577b3f09ed9=
18:
>=20
>   Merge patch series "labgrid: Provide an integration with Labgrid" (2024=
-11-13 16:39:19 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:/u-boot/custodians/u-boot-snapdragon.git HEAD
>=20
> for you to fetch changes up to 7aad7833323aa9260935d172744a50f56356d52a:
>=20
>   treewide: remove Qualcomm dt-binding headers that are available upstrea=
m (2024-11-20 17:57:58 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--bD/MEWGqBC6V3gB1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdBQNAACgkQFHw5/5Y0
tywcPAv+Jsb5hbhHMSMMntMgydvWPb8hfoaV1yIV8tAh3TsOMgW/g8HU2fBbPInU
5zDbVN+lelDMlTKXONTCZpt5aOUAosKitI9V/kYLHx2gEBGdxLEB0fRVtrehOspQ
bVoANEPnGoKKoaepH3Y0PFH3s3Ls5/BUFtikm906J1TQlgz9h7JnUCwlzRPY204l
0lAo5Xgti2qw64n16WORikY0AGGJ9w93nk8Mjpm3xyA+xTg8gZq+jwtoa0aTLuZ+
2irSF/rce4SAa47LPHzkdeE4Xz0xsJdl+Jz3k5+DjHqLYWkMWC6jyXRlGBJM5FJr
y0ltbBLwqdt96hkBDu5PdFzg4zE2rn28nuKF6DPSVmLVQIx8nUKVezux1BstjIx3
rZsFbGIrPVdgITUx+tjt4ToBgFzHhHB/xmouuy/WifBFrqIoiuNU142RfHLIxiHw
nzI+u4MDSnF+p5kUhz/JPrGMf5B0APeI8c5TGkBq3LTQWT3pys2SIu/t4oAIBxCp
kT1fr98z
=nLAA
-----END PGP SIGNATURE-----

--bD/MEWGqBC6V3gB1--
