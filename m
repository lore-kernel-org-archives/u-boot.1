Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D170CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 19:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC5D84974;
	Tue,  9 Jun 2026 21:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OAq4Onlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFDB884975; Tue,  9 Jun 2026 21:01:33 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE5998496E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 21:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4863cd41330so4414466b6e.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781031690; x=1781636490; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K1hARBktbX0Aym9iHPJSFOCLvQRcHhQIHhd0fXxDlMM=;
 b=OAq4OnlfHZs0goKdepnw8MHZGa+b3O1EzJ8Wtz/Ur3Qp/AQPGQVYk8O2MdkmGmn5uW
 5JrjWSztFxz7A6nqOChfPtFCJoRJp717GLPzW2y7wXHArbRSfnzOANHWRWDgbJcJpQJS
 iE1pHNa9H6eOKuVyWlhZNziJ1bG2fHODN8tFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781031690; x=1781636490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K1hARBktbX0Aym9iHPJSFOCLvQRcHhQIHhd0fXxDlMM=;
 b=ZbTrRx8T8EbKblHnqzExUOY167wxJKRl881FaR+VexDWwjcxDBAVkDyhToXQN4ZpG+
 RfD1EBOw1VsMcSVg+R1IZwurJqkzsUdZkJnu4Hy3kwVi3dqLlCyHxxco0ZkHpGnaAWsd
 07mNeKtmbTJyN+6UzeWUYCBACBWu336l/k7+L0LuG7gmAzLeCOxlNX++XnJPNDPTzpLd
 AOuEvifR/6MrKXIYl6RSUkNZQj/HuhlyrPjwALOQ2ENo0n6bMAZ79HJIumsa6Vl6ie2O
 PnYlUlc+9MSUWcPbCJyPkVX1GLphfJXpoLNhJNiA/OyY88p0c4PQayUpJbl/Zso+cxZn
 V79Q==
X-Gm-Message-State: AOJu0YxTOG6UMu7iDfi1tvhR9Pto3mCVzCEjD619Q64MNT6XlKMtF6Gf
 4i6STmo4ufUWV9xaWCr8bD5/vqaeY4Met1sO5y+qvbGW3Kv/zxpx1k3V0unU5cvLvfk=
X-Gm-Gg: Acq92OEOXslIzWGHoOE+n1zJR9oAL2TO9ZBt7cjRXbBWHK4PkzkDcxgozHmCkKSsyB8
 UBbNpZSQffamZLkeTmvswcWNTCUOlbVJfqPLEkqEv23KvIK1md162SVeuqUjtY22uilHDc0qT0h
 SFPnw/k0R/Ncu0BNg2ZMP4QdPgjaIF0HhT27W86qNSIoyyU3KVLWLvPtu2G24jWoS6AP9Aplbm7
 O0svjC7zCo+evYj3cnC+ZbrHyx1aXCSYcHMim79XotVaNB+H38wrwBXNkg10ttop5KbPT69hfyk
 FakOgK9PM+RSp1hUMT84Y3O07l0LapvuSppMhQjPlnZkgoImVLUoOO9C7kf7wpXngyHiBN0+k1x
 peX3LznOzR02lnrYFLDimdCu43xFewAdMzCaxb3CSZYOdtkZvRh2oco4CtqIYdUO3QnxgAVvvW5
 zssuJFBdDnPnZHjRJIBO3VCx63/eIaXWqZvSnRh4+WSNzn2foUGWpKruZ1xVFow+DYPDdnjfE1J
 lkxTUo5013UUDxj0BAmUWi5eVUQk9Cxp8BGSeBjeVvWbA4UgcjWcs76i5aWE9nS8++HUJJ3
X-Received: by 2002:a05:6808:1925:b0:485:50e:5899 with SMTP id
 5614622812f47-48692abc2c6mr9280629b6e.2.1781031690381; 
 Tue, 09 Jun 2026 12:01:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b91eaffsm16507120b6e.11.2026.06.09.12.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:01:29 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:01:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 3/8] Kconfig: power: pmic: fix typo
Message-ID: <20260609190127.GW382693@bill-the-cat>
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
 <20cb8609-eecd-4863-9542-572dca14a294@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cYVCzJnlZcG2JNCD"
Content-Disposition: inline
In-Reply-To: <20cb8609-eecd-4863-9542-572dca14a294@gmail.com>
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


--cYVCzJnlZcG2JNCD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 03:25:11AM +0200, Johan Jonker wrote:

> While restyling Kconfig the script checkpatch.pl gives
> this info:
>=20
> WARNING: 'refered' may be misspelled - perhaps 'referred'?
>=20
> Fix by changing 'refered' to 'referred'.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--cYVCzJnlZcG2JNCD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaihjBwAKCRAr4qD1Cr/k
CiyTAP4qN4nPgRYn0esrbk9gQYUEfpdIELe4Pg+V2IDuaZJvkwEAtGuAx/8G2V6V
nTwQJLA57VDM0tUl+rfTjhrzHb84awg=
=Yb0r
-----END PGP SIGNATURE-----

--cYVCzJnlZcG2JNCD--
