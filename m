Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB10AC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 15:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D69387FC7;
	Thu, 23 May 2024 17:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U1pFRR/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB6ED87E9B; Thu, 23 May 2024 17:02:46 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8514B87FC7
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 17:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-43e06d21a06so14971531cf.3
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716476563; x=1717081363; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WTsw13iqihOG0Vm1E2rT9UmhDMNZt9vtlIVAjqQarEE=;
 b=U1pFRR/pqrqm8yDBznbtdEc+4enYh7aD1GAli4w+pDyHCW0hn1TrjavUFniKzT40jf
 hteemq93RfAqi0oDOCyZ5pROJ1DYOVejzZTLkyLoyz3vbOUkd/YqT8FJ71uFSZ5XtCwG
 O4HgzRmDfuJTfUMtmSJdyQ/5ZLjr5T84cfGx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476563; x=1717081363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTsw13iqihOG0Vm1E2rT9UmhDMNZt9vtlIVAjqQarEE=;
 b=KbusYufeusjT93WiRXEB+YEg0QFhXVken3rmf4ATT+klMygXyGdAJWteHRJY3Fw9c6
 fJHL053kv2wtoFsAytPp1w84vqrZXIRmFQOY0djNwc9tW30Zii4bBQcowZjZ+7mnqm+n
 /wRThxHvoCZcKj2+3tSzvi3IOhAxUGM40KyjRpgUVVhblfWKgmm/Nrttkd1ALeo4APAC
 HlycDQC3WY1DxaZ3vPdysExZ0g551DJNbwFHyH+e9ITSyiUbJV4NEUTlOjhG5ljxwv0k
 W2xGT9EJ44bcOfR+v03F8PfQeSUjEApOl8KomqKqHJzCgxmekp+AdazoZ6csTSFBxHV5
 AOPg==
X-Gm-Message-State: AOJu0Yw5J9X2bDwZbOJMBSE//SNpmQLPnu2hXEg+vmh0gKI8x/aWg3AX
 6nYNdsBvRb6U9nR30M9g6tKXJyca5sbU60ZGvDOIhSHPpl4tM0xTBfZiLeWBSMU=
X-Google-Smtp-Source: AGHT+IEZeCa6qrVcZsySlBt/EZumM+P9l/+lHKW6vwFnkgaqOT4rz83A8GPL7q1JcvhJGKJHg+/7Qw==
X-Received: by 2002:a05:622a:1ba6:b0:43e:607:f4d3 with SMTP id
 d75a77b69052e-43f9e194f2fmr47375391cf.48.1716476562960; 
 Thu, 23 May 2024 08:02:42 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df5513017sm186182301cf.46.2024.05.23.08.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:02:42 -0700 (PDT)
Date: Thu, 23 May 2024 09:02:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH 02/15] net-lwip: import lwIP library under lib/lwip
Message-ID: <20240523150239.GN2568172@bill-the-cat>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <3b93c2b7f753633fb27864a2667d022848b2ff28.1716393035.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D1+1ef3XF0fWnSnR"
Content-Disposition: inline
In-Reply-To: <3b93c2b7f753633fb27864a2667d022848b2ff28.1716393035.git.jerome.forissier@linaro.org>
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


--D1+1ef3XF0fWnSnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 06:00:02PM +0200, Jerome Forissier wrote:

> Import the Lightweight IP (lwIP) library as lib/lwip. The code is built
> when CONFIG_NET_LWIP=3Dy.
>=20
> The lwIP code was imported with the following commands:
>=20
>  (cd /tmp && git clone https://git.savannah.gnu.org/git/lwip.git -b STABL=
E-2_2_0_RELEASE)
>  mkdir -p lib/lwip
>  cp -R /tmp/lwip/src/{api,core,include} lib/lwip/
>  mkdir -p lib/lwip/netif && cp /tmp/lwip/src/netif/ethernet.c lib/lwip/ne=
tif/
>  mkdir -p lib/lwip/apps/tftp && cp /tmp/lwip/src/apps/tftp/tftp.c lib/lwi=
p/apps/tftp/
>  mkdir -p lib/lwip/apps/http && cp /tmp/lwip/src/apps/http/http_client.c =
lib/lwip/apps/http/
>=20
> The list of object files added to lib/liwip/Makefile was given by:
>=20
>  (cd lib/lwip && find . -name \*.c | sort | sed 's@\./@\t@' | sed 's/\.c$=
/.o \\/') >>lib/liwip/Makefile
>=20
> These files are adaptation layers written specially for U-Boot:
>=20
>   lib/lwip/u-boot/arch/cc.h
>   lib/lwip/u-boot/arch/sys_arch.h (empty)
>   lib/lwip/u-boot/limits.h (empty)
>   lib/lwip/u-boot/lwipopts.h
>=20
> They were initially contributed by Maxim in a previous RFC patch series.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
> Cc: Maxim Uvarov <muvarov@gmail.com>

As I believe I've said before, this needs to be a subtree moving
forward.

--=20
Tom

--D1+1ef3XF0fWnSnR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZPWo8ACgkQFHw5/5Y0
tyzL5Av5AX4tXXHVydz7KD1658+sVHkmRcyHqNH5Xf27mnpcXeoUm4U7wzvVy6SW
ULe3IaPvsqh03wCa8vg2PDakALeuWzm+wefbYfTNgfjPN7O4bR7m6LND3atkis0p
ElgRSAP9QfeuqMW1I75gKtJwfPALqmjoQEHgep+IxdnPnhaTmTJ129HY35hf/beY
gG/XeT0rOamzcCovdt9mGCQWx4BAm2S16R4Ij2klKnZwI78Z/ugid04IA94propT
TJCAVfBqr0nQr/pgIn7ywfkC7UPPvi0VTEIlDxNHt2hFV8oEqkiUOSAWoQJ8s93J
JeFK7E+HtOzy3ry+x0x56+LYk7SrgRNTIjHmM/FWviQ7Lcfj16642mt//52r8gIh
/1PkLjzEpxStQGkVTPf+YlltRjlYOWD37lDHyBd4JXjuctBFKa45Ob+X3xhhsrfu
1KLiS5eFQ9OGV6aCIi5pPg0FL+JbCoAKoqy7eG209EcW9FQrth+GIR5D58klEodb
jplYJGBE
=2UNN
-----END PGP SIGNATURE-----

--D1+1ef3XF0fWnSnR--
