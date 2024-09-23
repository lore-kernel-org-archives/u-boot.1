Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6582CF9C71
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 20:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F6188C6F;
	Mon, 23 Sep 2024 22:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kJnOCoTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FEAB88BAE; Mon, 23 Sep 2024 22:35:27 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88D42889C9
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 22:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-49bdc6e2e3dso1554969137.3
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 13:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727123724; x=1727728524; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=635pzpa+rkujLJh4FLj4jU6IFrCi73my6N1B9I1KbW4=;
 b=kJnOCoTj2LumnJpjxdPVlrciNKM5SfezNNSR2VzKnNbEuyzsvz54ctOEpNPH92U3dT
 saumEfvs5QpdR8VyvVLPyPktfm1tjywsakpZEsiHL7Zjgu2MpyIIDNRVMYiFE4qcVgG0
 ET9HOZmFgzsvADKYWM38AwhT2PsRjeXjzX7cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727123724; x=1727728524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=635pzpa+rkujLJh4FLj4jU6IFrCi73my6N1B9I1KbW4=;
 b=jLGrmMnJeiKmwRsCOrEIxe0A8cRPodSMC72/G+w0CeMnXBbTAy0AXepOwvjfUV64Cc
 DOUr3F7lqNgBzN9j20J0/f9Nn/COe3fPcBBHw60PNeawR8dpJlBYLrjrr0OfH7fkUvJ+
 pLmOHxaKGR6yNUPoTviuaFDVwXLGnG4x89Xvrnwc19ylPu6j8EQW9zg8lmxescRfTT/E
 pCaxUjKlGxhLm3gqCijHrCIzqrKcslXoWFcFL2+NTCcasXLVnpEt5GrjDe22F8J0N6QV
 PYFGiajUaRn7zigYSTRaDdNqWJwUAjJfBV9mnYSt4ecd5HASY52RXyS4Fwk4cG7NDzG/
 i82g==
X-Gm-Message-State: AOJu0YwSOSZ+JxU4LD9Qtic2cwEQprhIDGuvsIAi1cZI4CGaNqvLRheO
 CxjrZVE3m0nLC2CF/Uy4UFwVraNGW22rz9VKsiQ+fQPtskoBmm0daKVlnk89goA=
X-Google-Smtp-Source: AGHT+IEKi8HMm8/8TfsgDDh7Dtdwsdj8n4GOozzMPfPg1UNRFklN7wXZ3HNKczo6fbo5Gu1I6KrXdA==
X-Received: by 2002:a05:6102:94f:b0:49d:433b:a603 with SMTP id
 ada2fe7eead31-49fc952a198mr8129175137.1.1727123724357; 
 Mon, 23 Sep 2024 13:35:24 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b52544854sm97051cf.6.2024.09.23.13.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 13:35:23 -0700 (PDT)
Date: Mon, 23 Sep 2024 14:35:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v6 02/19] test: Use a constant for the test timeout
Message-ID: <20240923203521.GR4252@bill-the-cat>
References: <20240920060158.106612-1-sjg@chromium.org>
 <20240920060158.106612-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fO+t2T7yXfthMTK6"
Content-Disposition: inline
In-Reply-To: <20240920060158.106612-3-sjg@chromium.org>
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


--fO+t2T7yXfthMTK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 08:01:37AM +0200, Simon Glass wrote:

> Declare a constant rather than open-coding the same value twice.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--fO+t2T7yXfthMTK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbx0QkACgkQFHw5/5Y0
tyxB+gv3YZunf1vPuYsbEfXC9EJIp2GlLl8U4bkesSGrRGK5SG7n5azVerAzllAB
ewaPSrXZRidWCUncsTppFxG5IS2u63JMLa4Y7kHGFEForVNJcCMX9vbpCcR5P2Wp
95DBsnjE7+T6abiljeorQ71ErbBjyjhiTAU7kK101ioQ5d6jnPCgA4zX4xe9z+TR
DEXei/cM8N1FBE1OGlk03GFibXv4mg7koB0BcM6MUaPSwhzeLHjH56VxgoRfvNbr
CJUaABxmVbsMnC0vgomgSENZ9b7sZHOPi/enhVXJjz1Su8dgYTJPdRIu+vI4DpCK
l7HfqD+vLm9ogLWgqNy/keUvwpoIOuOy7WgYF41yCg10kTF9nFWUgYGOCY3E0AE2
vJKjyeO59hmm/Q4evXVfMPFmsy8n815T9ElzAW7x+qeAGmrxw7xPqpq/n44CJ9I5
NFwLEuz8MOd8f3t6ZNlNf4NLRX37f0UGYhZFScwaRFmDGbUjD9NAZGOO8oyHr/+Z
5IM0eLU=
=0VTu
-----END PGP SIGNATURE-----

--fO+t2T7yXfthMTK6--
