Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC86FC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 16:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFAC0882E2;
	Wed,  5 Jun 2024 18:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W7IpI/vQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBE75882E2; Wed,  5 Jun 2024 18:53:53 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88377881A2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 18:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6f12eda7c7fso3490207a34.2
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717606430; x=1718211230; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zYzg1zNfVaNdoc4VTXVbCekBRKyklyv6l5ksn8tB+pU=;
 b=W7IpI/vQLlMFHTglk/I9bpnsOoG3Lj1P1YHb59f6lqyQjg4cY+y0d387+NxYrOt8iV
 KjTiaABQvyxj4ZK4eHpAoJke/5g3TUFyDKnuIwQ6JiiB49uBkyYRVIkd65qcEKIzvmI4
 FQG2WzueQhIVoJwoHWjA13y0iWKhywOspijXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717606430; x=1718211230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYzg1zNfVaNdoc4VTXVbCekBRKyklyv6l5ksn8tB+pU=;
 b=AQgo+Dq9FHaL7G8M0RXtxokN0S+Lxtvn0JOxdRyFyTVdh4QMnfasd/6gIL+3Z6eE7P
 39XAUFuMqpSEFJBVbkI55B0S8vuDUzRWvd85ZgJNnnkklZow8yUR+vd/lY+/tRFaYfDr
 0LfKtp/rF9h2Ehx+CnCDB6Y/z9RHQ8ye8vaxdoL5rl3RY5bYhbi4XAOJcwl42d902dD4
 rkaTb6wwbXgnhDFr0b3JBqi3IXUrb2X3GvINg8ZGf7z1fS9+XLRk3dvkQEJWYV4pj0/V
 /pQuDLvIe4Og/vaE2ads41fKegLt6IXT5WIY0D96/S/z8byzZmRup4qnnKuxtbTG6ydA
 Dydg==
X-Gm-Message-State: AOJu0YwHW8zaINfFl7PQ4rC0O8E4qy7XGQngliyDVENA1ZDAPTZ17cVJ
 rNcFRUpbwp1gX+1heT0Pgk6+jacPjLq2HpXPB2wmZJjIUQjDN+lH4O8BVaoyWyE=
X-Google-Smtp-Source: AGHT+IGeZZuXU1fF4AmiG4apPmOcSgw450FI5wJbz4xW3EsFGFPxXSqSMjY6BEVqyzXGB6uIrNBH2Q==
X-Received: by 2002:a05:6870:7247:b0:24f:eada:e1e with SMTP id
 586e51a60fabf-25121ff2ee2mr3290603fac.42.1717606428642; 
 Wed, 05 Jun 2024 09:53:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25084f7a51csm4108007fac.13.2024.06.05.09.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 09:53:48 -0700 (PDT)
Date: Wed, 5 Jun 2024 10:53:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v7] test/py: net_boot: Add test cases for net boot
Message-ID: <20240605165344.GA1145946@bill-the-cat>
References: <53549cdc5fc6c144f83ade47e159a3830f05e575.1717580941.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pve94MqKOes7XXcJ"
Content-Disposition: inline
In-Reply-To: <53549cdc5fc6c144f83ade47e159a3830f05e575.1717580941.git.love.kumar@amd.com>
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


--pve94MqKOes7XXcJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 03:19:35PM +0530, Love Kumar wrote:

> Add tests for booting image using tftpboot/pxe boot commands, tftpboot
> boot case loads the FIT image into DDR and boots using bootm command
> whereas pxe boot cases downloads the pxe configuration file from the
> TFTP server and interprets it to boot the images mentioned in the pxe
> configurations file.
> This test relies on boardenv_* containing configuration values including
> the parameter 'pattern'. tftpboot/pxe boot cases boots the Linux till the
> boot log pattern value is matched. For example, if the parameter
> 'pattern' is defined as 'login:', it will boot till login prompt.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Thanks for iterating on this so many times, I'm now able to run all of
these tests in my lab.

Tested-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--pve94MqKOes7XXcJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZgmBUACgkQFHw5/5Y0
tyzouQv9EE4UhBTPN/EzVvMgjH9aw0XBGZcTOOYdfSeGQb4O/1spdYHsf5lKVLfI
CYvf7Y3U4LiJ0l2K3fRcyaMl/Avaw+ipWy+dZ4zn+zcJTBxnEM1HhtJwN9IjY+5+
P7thsAeltS++x//3JhNexFfPx/J/Pg6koByTnAd8LYNoFOFF1MtVwuKZlqF2jMa2
rTI2PpZ5HNowEZK8plj6hyxxdhGyurJT19QA5mOi7uJejRlnOXmws+OeyZIbxxWH
dejpney/zqLMk4OZIDLk9VnmIiGEjtGtoXoLNG61lG8F1NeahiUbdi9BZJdEmMch
h83waNqYIWxSUQ/vvBUCHr5XKzqVOxN8X+ijFRD07o6L2IvW1CTMEm/HKHcg3Sbo
k/qsYV/zAkx3szL/fimGblEbRBj3Zp1jR7ClOsV5LoJc9wcIuyvTVCyWri3NUayQ
gOJO67/8gvUdKRn89Asym/aIvyeff0BHt6eWzTVZai0T25ATmnSm6Lnrc+wq/+m5
SxC1p4Nv
=dfF9
-----END PGP SIGNATURE-----

--pve94MqKOes7XXcJ--
