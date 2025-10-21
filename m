Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63DACCD1AF
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 15:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490A780107;
	Tue, 21 Oct 2025 17:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cj2aEqJX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 968B782B20; Tue, 21 Oct 2025 17:37:55 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29266800D7
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 17:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6504c33afb1so3037160eaf.1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761061072; x=1761665872; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TYAYa3nzcTZp23OxvTm7EA9zf9MKHR9i0Rc/Dkzor2A=;
 b=cj2aEqJX8iM+NCFiATlWCbGITQxTazTEYi3OjJzsmjclyhypj79ZM9Sn0NEkGMyOne
 mt0bfpSqVdcq9alKSl2p8JDxwAX6+TEEz4xCIWFQ8kvsmUh+EI/pbuWzWjr2i+pIDDEm
 GuGyJeqdl9eydeM8WwoRJ4uokf2uT9fQJa3JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761061072; x=1761665872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYAYa3nzcTZp23OxvTm7EA9zf9MKHR9i0Rc/Dkzor2A=;
 b=uYAqTVmlXuhwq+2vQphV3p+plAVQFvDAtrZexwmGrdSQG898NU11UZ93xE+IMcwjwe
 iu33FtPTfny2kJarHiW0cf3iGCjTCXkbFykWMEjEcUVwZsCfEx9/Ziv93DcbePwRa6wd
 rTF+dzdGXwyAytayk1epL++lpFpg4EqoEWDSCl8ejDrfhyF098XIQ2JiVEh4nYyp+TWa
 3Nn2BxKFFXQ+4Ul5MYFpgZ8kPgiSDspj9m2DUgTm7xjj+rFvT2Y7tuQOmTBWlytwlm82
 Vp1tatVonxM3TU4hMT0rdAS+vhYvX0Eqfsmf+6ua3m7pzXoCJurWx5FIoITdLIleej6B
 U2uw==
X-Gm-Message-State: AOJu0Yxm7cIZRK7lRzLnFBVcUlLx3Cn37/GOrLxZHbwxublVe2QUMhsg
 Zm2w22NVCiX7R0HrCsTqo5Y2GJkdcv0pNQ+pmtfQNKpovP4gi4+DjsaAPp9BetNHZgE=
X-Gm-Gg: ASbGnctq1sBASU7JWERvai85K0IITNagWuMubHLY9N5S88lcKHNAJb6RUZnxiPDazzR
 rF6z0J0gEvOMzyc7daoyq1+wICYS85k2fawV4UHMONCfK1IrUjWDeUtDUJQWni69Y7WuHnckqEj
 dvGLsq1JyA9hjtqOdXCxgrMkvVYiIX0ouf7mzCUcapMtkXGhUwgRU8qcMKp+GbJo/evDR64JPvS
 D14U8VochtXiaIwIWBpaxr7Csz6QgUx44/+QxVCMJrLoxb2WJlBVrydgLsCQ3VVS6SjJNW3vghh
 fVxTm56yXf/pIdW6sSPXFAonBHKlAjwihA08jhuEp6OjkYSgxhlZonMd9vTNsZdaSDcKMMgih/Y
 b5wS6wYfQ/3qKB4aIkniaKRfAvNQpebL7hYQ7yDCvfsyLUn8xqwPjI+OFbLSNbFE3e9i/202ldP
 Szd+6G7vH8YGx4zSGQQd+b0BM9H3vWaYReE8u4Mz4=
X-Google-Smtp-Source: AGHT+IHXKLgyezoR8Dtx39t688cGXLX5KK5uCTZNDzPELNtb8cGB39/fJK9a5/tDXUHZMUNKn8jlUA==
X-Received: by 2002:a05:6820:2981:b0:61e:16d0:9ea2 with SMTP id
 006d021491bc7-65363cd1803mr37329eaf.3.1761061071842; 
 Tue, 21 Oct 2025 08:37:51 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-651d7cc4b60sm2620275eaf.3.2025.10.21.08.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 08:37:51 -0700 (PDT)
Date: Tue, 21 Oct 2025 09:37:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v5 1/5] docker: add OP-TEE and TF-A build for testing
 Firmware Handoff
Message-ID: <20251021153748.GD6688@bill-the-cat>
References: <20251021153443.219326-1-raymond.mao@linaro.org>
 <20251021153443.219326-2-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zW0OBvc9O1Bv7pxu"
Content-Disposition: inline
In-Reply-To: <20251021153443.219326-2-raymond.mao@linaro.org>
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


--zW0OBvc9O1Bv7pxu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 08:34:33AM -0700, Raymond Mao wrote:

> Fetch OP-TEE (4.7.0), TF-A (v2.13.0), MbedTLS (v3.6) and build
> bl1 and fip with both Firmware Handoff and Measured Boot enabled.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
> Changes in V2:
> - Move OP-TEE dependencies into the common group.
> - Fetch MbedTLS/TF-A and build bl1/fip in dockerfile instead of
>   post-buildman script.
> - Remove Trust Boot related build options.
> Changes in V3:
> - Clean-up of OP-TEE deps.
> Changes in V4:
> - Minimize OP-TEE build options.
> Changes in V5:
> - Add '--depth=3D1' and '--branch' when cloning OP-TEE, MbedTLS and TF-A.
>=20
>  tools/docker/Dockerfile | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 5b4c75f8400..3286b2ba6b2 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
[snip]
> @@ -227,10 +229,22 @@ RUN git clone https://gitlab.com/qemu-project/qemu.=
git /tmp/qemu && \
>  	make -j$(nproc) all install && \
>  	rm -rf /tmp/qemu
> =20
> -# Build fiptool
> -RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.gi=
t /tmp/tf-a && \
> +# Build OP-TEE for qemu_arm64
> +RUN git clone --depth=3D1 --branch 4.7.0 https://github.com/OP-TEE/optee=
_os.git /tmp/optee_os && \

I was asking for this to be two lines:
RUN git clone --depth=3D1 https://github.com/OP-TEE/optee_os.git /tmp/optee=
_os \
	--branch 4.7.0 && \

So that updates to later versions can be a single line change that's
also clearly just changing the version number.

--=20
Tom

--zW0OBvc9O1Bv7pxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPeoyQAKCRAr4qD1Cr/k
CnT4AQCh2G2YMDrNcG4D6/tC85AV5lhHSohltIYmZz0u7ZWCMgD/TR6uHamb+/sq
krx+YNY3nygl6keu9HuOGlG/dbWIbAg=
=wBiv
-----END PGP SIGNATURE-----

--zW0OBvc9O1Bv7pxu--
