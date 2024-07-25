Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22214C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 16:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30E28879AF;
	Thu, 25 Jul 2024 18:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d4FVx+/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06B8887C86; Thu, 25 Jul 2024 18:25:38 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D293B87876
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 18:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d5bb03fe42so22856eaf.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721924734; x=1722529534; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y52DJLxoR0hdWhVFwnOyiwe22qaA3uwhzlu0HpqZH48=;
 b=d4FVx+/5Y9fXUr50IIONKkm3PdemfyF/sKJFWH8TaGky+mAxq/XLhI99N+poxxIVWX
 4DhX71YxxQ1GkUsofeZTiyQ6i7CPjJv02nMpDvbkYGDazW/4DV+g99KhLA3rKmKHA9nw
 zaE8lvN/4elWufbwxSISqBBhJAOkeKN92B1Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721924734; x=1722529534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y52DJLxoR0hdWhVFwnOyiwe22qaA3uwhzlu0HpqZH48=;
 b=vlPmc8kDhNgQXzbAb4JssUglKZR1aNilvqiPy+6yRPQ94CDcAEl2Sl8Ytvcm64uy9a
 NuJmCuDv4bwscCSDpApWuIDFfPILlFEZ4pfWx26JTYNwRaOoUN7WcYh25APUa/t1m8Wd
 UUnrmjOv1OYABZ+CDCwPqIM1RacbnhniKut9JtePfnDxrYWMbLDcF1j1sgTpyDxaxOLc
 mB/JZoCe+j5rWnocYGiRd7kOIHV6ksre/M2TSxefMwRIO9C1ilDlskX+tVSh7EWDERlf
 +DVWNm8BGfN8raViAamxcFoCAK3mXeD4wz1jiDxiUe8He6TTwwduvEbPcpyDa0rip/9d
 eh4g==
X-Gm-Message-State: AOJu0YwQKolcrVjgFpo2fa0TEttmIGevohyFRsONJLRlMWD7yeOrgUpD
 xhGGCN5QzN4MvD6FbAu0074Wwk9NkSdCGqoz4jMRW7OxzxfSBSL+mDlgBUCq9qk=
X-Google-Smtp-Source: AGHT+IEr2Pp5ZE4Cy8koJw9gCnyml+Xh/kD0bdU/9/ESTGZzUFv5TWNQSWoSNxuCRAwIeDDKPZFbHA==
X-Received: by 2002:a05:6820:308f:b0:5c4:2c2a:2358 with SMTP id
 006d021491bc7-5d5adcf4ac4mr4213897eaf.6.1721924734524; 
 Thu, 25 Jul 2024 09:25:34 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d5b36943b4sm189865eaf.41.2024.07.25.09.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 09:25:33 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:25:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v5 16/20] configs: add qemu_arm64_lwip_defconfig
Message-ID: <20240725162531.GX989285@bill-the-cat>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <dcb78f4958be3ad322168ccac6214991af44c884.1721910373.git.jerome.forissier@linaro.org>
 <20240725155806.GV989285@bill-the-cat>
 <5d3859cb-f1c5-4f43-9223-ba1ce021937f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="55L7ZuZccBWQKapz"
Content-Disposition: inline
In-Reply-To: <5d3859cb-f1c5-4f43-9223-ba1ce021937f@linaro.org>
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


--55L7ZuZccBWQKapz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 06:10:48PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 7/25/24 17:58, Tom Rini wrote:
> > On Thu, Jul 25, 2024 at 02:57:37PM +0200, Jerome Forissier wrote:
> >=20
> >> Add qemu_arm64_lwip_defconfig which #include's qemu_arm64_defconfig and
> >> selects NET_LWIP instead of NET. This config has all the supported net
> >> commands enabled.
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> ---
> >>  configs/qemu_arm64_lwip_defconfig | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>  create mode 100644 configs/qemu_arm64_lwip_defconfig
> >>
> >> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lw=
ip_defconfig
> >> new file mode 100644
> >> index 00000000000..1afef04d7a0
> >> --- /dev/null
> >> +++ b/configs/qemu_arm64_lwip_defconfig
> >> @@ -0,0 +1,5 @@
> >> +#include <configs/qemu_arm64_defconfig>
> >> +CONFIG_NET_LWIP=3Dy
> >> +CONFIG_CMD_DNS=3Dy
> >> +CONFIG_CMD_WGET=3Dy
> >> +CONFIG_EFI_HTTP_BOOT=3Dy
> >=20
> > This doesn't work,
>=20
> How so? I've used "make qemu_arm64_lwip_defconfig" hundreds of time to bu=
ild for
> arm64 QEMU :o

Yes, but buildman (and CI) are in a chicken-and-egg situation without a
few more details in the new defconfig, sadly.

--=20
Tom

--55L7ZuZccBWQKapz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaifHsACgkQFHw5/5Y0
tyxYhAv8DtnAli7AEl3CgWLTX9rw4TQy2LJWgXsMlTlLsQz5tGCamHjpQIJVZ8uX
Ew7oSSnqzNujDz06cafL2jBz5Rv+pwmkbZEdOScNlCu/2GC3SFzBVSG5Q+v/k9+p
IZrd4j3yBfI0TJBCxE4xbHxuA5QLj4xcJgXZut7aU3BqGVr7d23REvtk9IvgFT/F
xHmUbwX+a0P5NG+6zaOFd7YbHXHj7ugevdf6loVhW8Wq8cjnMNyThrNMd5Dy8EuZ
7tysaV5rnlC/kyRtt7CzuEQT0BBB+ahtpDbE1AXr6Du5HoLkP2VSaIn3aQcRnNrU
F88ew0fg+ZCRvd6BCSmhiyYH3ijX9Uvwx5JgBho87SgmHU9otCU7J6LVM4WEoQhL
2Ws1UFyWe6er74R0AZ6ajn1CilpKGtNMExyUxiPeipYytfrz5KJbwPBn+/9YUxyX
RBbv+ZSZA0nRZRLIWwy6VIQwZUM+P4z6rbcOc5mOzNaQvkpzUbDNGDvoFW9NZlZi
y/oFZEDa
=aRVi
-----END PGP SIGNATURE-----

--55L7ZuZccBWQKapz--
