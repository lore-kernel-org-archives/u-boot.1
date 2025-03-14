Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E64C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCBC281E76;
	Fri, 14 Mar 2025 17:38:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VpKs5ZNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 973C181E76; Fri, 14 Mar 2025 17:38:47 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 538E181E5B
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7c08b14baa9so177116185a.3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741970324; x=1742575124; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QihYIcFKQHmCUmbbTKDKfDZKiqBkmQR7ifpXMpOxmYk=;
 b=VpKs5ZNGKQ5jH+AtWI00iS3Ei5eMwICJ2cP07A4a3SnKnH3kP3NG/zMf/bDjcshib/
 UrEUwAMBEwUN3RrIXcy7A4nnH3Uv8gYT+hz+TKL4CHqrjaVVqDrDc8IhnNnzopJiFWUs
 t4DIMcPjBa/sFLfXnCi+D2l0HAve36nUyRdJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741970324; x=1742575124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QihYIcFKQHmCUmbbTKDKfDZKiqBkmQR7ifpXMpOxmYk=;
 b=YEqVG3wxdhZdW3636JOC7XXeAUsBDsWjIS4BqUWBFoMRs4DFxA4J9wNziORDMtmoTR
 J1jR0LaeU/i/UN3gyZCwzDXz6brTeGr3j1fUPE/R4/nkrk1x9pVX3Kc7/sNpU0ilUtkW
 gnQzjOm5Z6ajg0rkK8WSmxqX188TKp2ONeCPMXHHymFZvKGbJNvAGFTrBZL9XIMX6OX5
 fwFlJjF72cUp2uoNOetS3HmTsKt3dXT1q30ZaoVPdjOT615AbRc31raBeqWI7pkJ739R
 aP9eV9nE89LIC+SwFiMv7sZ2ogfMbLJuHW6GnMiIVdFrg1J+UQKdvdJpysXVNt0V8KDH
 WbWA==
X-Gm-Message-State: AOJu0YxDc3Hlx9wypr6+NZrwJ1zzCTNNVuHahKORqxkY1v0UsQP4rIGr
 GI3S70GWjTC9Up2e3aTbRjSmZViY7wEAB4lVv7VZnVHUlWM3fkkGHyUrxzfzzWw=
X-Gm-Gg: ASbGnct6Fcg+yWC5p8yMSnzrTExoNnxe9UYF26rQue48nC6thTo5GCpbnzR4uxe8Maa
 ipjxS3wavQB7DhPp9Jv5F/dRgkc82idf9hPdsuyE8MrXbcfz834NNeT4ETuqslPOm+LEfniD/u/
 ih5YX5flZPd2j+MSoW4N7usS7H7KLsVcGfUwHPVd6Gse0LGDs2DFGsUxhx8IidRu63apCDsIDMr
 BbyWAZkqXQMW7J9hRSsVu/7KfzJ49tUzDURTm4KwFM6rq6xv7dd20GBEkADFFKBBe+yL1ktZ+io
 9DAnC9Yr85tTnYTrn0yHy5+FxB77EG17HA2s6z4TtgLkUQ==
X-Google-Smtp-Source: AGHT+IEHWdbApTfs/sjdPgPKZeUKOrfG/YvcEHONadhcHr71PAdRcYVI2eLtphg9JtG5A8J+Hcx/mw==
X-Received: by 2002:a05:620a:248a:b0:7c5:674c:eec9 with SMTP id
 af79cd13be357-7c57c7d451bmr406079585a.28.1741970324075; 
 Fri, 14 Mar 2025 09:38:44 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573b3a042sm279746685a.0.2025.03.14.09.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:38:43 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:38:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, k-malarvizhi@ti.com, kamlesh@ti.com
Subject: Re: [RFC PATCH v2 2/5] doc: cmd: add documentation for fuse command
Message-ID: <20250314163840.GW2640854@bill-the-cat>
References: <20250314135706.184807-1-h-vm@ti.com>
 <20250314135706.184807-3-h-vm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="INHai39U/X+4kD+g"
Content-Disposition: inline
In-Reply-To: <20250314135706.184807-3-h-vm@ti.com>
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


--INHai39U/X+4kD+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 07:27:03PM +0530, Harsha Vardhan V M wrote:

> Add documentation for the 'fuse' sub-system commands.
>=20
> Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
> ---
>  doc/usage/cmd/fuse.rst | 156 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 doc/usage/cmd/fuse.rst

This should delete the old doc/ file as well. Also please run:
make htmldocs KDOC_WERROR=3D1

As this will fail due to not including this in the index at a minimum.
Thanks.

--=20
Tom

--INHai39U/X+4kD+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUW5AACgkQFHw5/5Y0
tywmGQv9EcUGXh+F90gafYFSK/t8oo4MCQI9PdMkB7F7Wh7MjZz+8RjmOW0UM02a
871mo7x1V35LopJcvWlroULfGXJUFAudkpahQxEJz5jBSXALXYvaIM04xArb6rv6
1nxb8gey/FPDEE0DA6GQqxisgASBbgXispDvrG0ZTNrPAX050pPj0UiOxX+oX/rU
Uj0kxpV6nkwsvJRICAw/RSlTicmReFArTrv6E/uV3DnsPxTGdptDg3KsUPKOz9xi
jx5voagkTHSUpPgpInaFAF8Oj80wK4Hw3DBg3aFtAddvQQu9/fWfhWCR8aGmPdR3
/G5wQswksqqbAFMqDgDe8AloVm3dL4zSS2jkLmYkbSGU/r8Dv2uLbiUUDc4X+vzf
ug5B8HC9B95czg6yt1i6sITMWnuPFUguxowtoyg9E6oYEwrixN4WyBTn/hsVPQ4l
PRJq0G4CrcIkumTcqUr+ZWoqFDXWb88Zm6tP2B+TZIpZoiRYRp6cmwT0ad+HuZK+
QGtHIzSZ
=29oN
-----END PGP SIGNATURE-----

--INHai39U/X+4kD+g--
