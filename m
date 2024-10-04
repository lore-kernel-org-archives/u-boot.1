Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313B7CF8853
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 17:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E3588C98;
	Fri,  4 Oct 2024 19:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jDeA6Qbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58EDF88CC1; Fri,  4 Oct 2024 19:16:38 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4496088C4C
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 19:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cb35f2aec1so18623076d6.2
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728062195; x=1728666995; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HLyiNORaOMASCXSS59b2Cuf/sQVjxNKNRSYKahRynH0=;
 b=jDeA6Qbu3XGQDr3LICr7u3K2yFpNIS5jTynXav3wQw36F+dA97B6UlgH747JkQ/WPK
 OXVxIsYnP3XPDLnR5QS9D76y75n18Ui0FWJbvV1bzVY4CGSDf9E2TNkpXUzqpGEpHHVx
 HVFQKtxRjaBDprBLyzVx9E9xTc1yNJbsCVlqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728062195; x=1728666995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLyiNORaOMASCXSS59b2Cuf/sQVjxNKNRSYKahRynH0=;
 b=jJm7yIA6gSBNk7kzVOb+fILhrCqP38JcpraAWdvcwAJeGQHafuJVPYHhg2YX55vIxk
 +6fWxiu6iQTHhR5xlhJGEHH3nHQPZeaJ9kT8Gl1rDAJm6W2JbLAhlfzZY6CexUVXFVKY
 nnkjEcLXHcqFZFWeLT6nPSl6/KLKKmuXRWq7UfYa7zBFECrtTDBskq/0UM6A7CkaYKpo
 pDRIUdMPZ5wp1tTQFP21mb2ghdNLLW49nSjO4PVPCxWeHjojWuWeaSoHjDaUmRQWlxHO
 BPW3inB2DyybSZLMeyOlIN2Cl+Dbc/1/MJ4nXmatkdLReFwHPKEIwWhltEXyvDi4kR7N
 /FdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv8NuPmnmGEYiIbVj5TW8w1UYD71U+yIfv1A6lWousGpXedE8oOmnI/z/+cvwkkDHCLzBMX6k=@lists.denx.de
X-Gm-Message-State: AOJu0YwNaADPwFmW/5jQNhJqqS+L2SFhWD3+V+eu8FDPEbZAaMvyU8sD
 m3H5CKqagn7s8Gm/O+OXYPjEOjRRrL6pZc1y6OfLVM1D91cgb0wUPLT4gMuM1jk=
X-Google-Smtp-Source: AGHT+IFulBqnMDdDEnSQzkpt7ZA99RSeUqMr9UkGVqs23HnxyctIzjKKCwo10XIMZSJUZ3xuo1tCQQ==
X-Received: by 2002:a05:6214:5683:b0:6cb:99db:bdd6 with SMTP id
 6a1803df08f44-6cb9a4655dcmr64930676d6.39.1728062195138; 
 Fri, 04 Oct 2024 10:16:35 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba4772e70sm912646d6.133.2024.10.04.10.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 10:16:34 -0700 (PDT)
Date: Fri, 4 Oct 2024 11:16:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/4] bootretry: check for bootretry variable changes
Message-ID: <20241004171631.GF4737@bill-the-cat>
References: <20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
 <20241004-qcom-phones-v2-3-c7ab67ac3043@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eqHyTv67Lhz2vBv1"
Content-Disposition: inline
In-Reply-To: <20241004-qcom-phones-v2-3-c7ab67ac3043@linaro.org>
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


--eqHyTv67Lhz2vBv1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 02:46:52PM +0200, Caleb Connolly wrote:

> To enable more complex sequencing of the bootmenu, autoboot, and
> bootretry, handle changes to the bootretry variable between tries. This
> makes it possible to turn bootretry off (e.g. to drop to a shell) and
> then back on again.
>=20
> This makes it possible to have a persistent bootmenu (the only way to
> navigate U-Boot on devices like smartphones which lack a physical
> keyboard) by having bootcmd be defined to launch the bootmenu. This
> allows for menu options like enabling USB mass storage gadget to return
> back to the boot menu once the gadget is shut down.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--eqHyTv67Lhz2vBv1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcAIu8ACgkQFHw5/5Y0
tyx3IAv/Tlahidc6ChVgPWrRPTqMhlJb+rnhyzNsa3dt0pdPKAuSCk5HYHbomS9e
AnN1QxzHOagxlWy48Uyc46PAAQMawNIZjzHRBx2WsM7JsFmh+9Dxgsfyyy27+VUl
7msERhOCrdYTrJNb6/XPYM8s/gPZaYgj2LOIQ64Y1bLBEa6c0L9+1NG7WjIPa8SI
2uCt8/w5TNUvYYUGD+BCbvNauip8jh/DkVnfMOE5Mi2JOT1pnsvz/13YZ3Df4le3
TqUhmvkFp9vpHgzTOdv7AFK98st80BPZL6eXel0Q6tUZ47GiikF2tqrrfQsGB9o8
Nc7yinCnBAHphn9yvPG2SKarGA+aBjPMhzzwIKJ4oQywa7NuXR9Cuk/FaF2fLQsh
ZJiXkN6/Qr9mt0djrkkggMPchUb9dnsUML/7Dih811bv72NBpmnJNT//bebkTx4i
wJ24QtQfOYpiqGbvSRiWIVVIkjhlhYFpjXWoqr/1LO193TtziWeucxfYQ/WcxpQ7
kO1XY8cd
=B5GN
-----END PGP SIGNATURE-----

--eqHyTv67Lhz2vBv1--
