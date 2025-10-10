Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEAACCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 20:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B0D283FAD;
	Fri, 10 Oct 2025 22:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W23dTc3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1B7683FB0; Fri, 10 Oct 2025 22:55:21 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9465383F91
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 22:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-378aa12c13dso877948fac.2
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760129718; x=1760734518; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cuJtWmL1j5XGqM5hsaKYTbhUuX1DPKEsxP/dMpn+0wc=;
 b=W23dTc3daXBWkabNl5G7ZwKzfICHWfj4HKUKis6nJFQZnG2jptMOD63OtXJfXmwG4j
 mfvz/PFHp9mFRg5f1qVuxymPy4/dckcGPfrIE1GYKTLGC4pLd8MvPCTLIx2uqpGk6eza
 Sm61HQzuo0fdS+1hrYGsgMf3doswtg+ZopSR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760129718; x=1760734518;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cuJtWmL1j5XGqM5hsaKYTbhUuX1DPKEsxP/dMpn+0wc=;
 b=Ik2DMK9kFwc20kXHxt9SsaNQ62YqZmimvxfojxmTaG65UMb5g96NBUSxb4GRPvv2M4
 q1nXw91sKKtbDC2ThqoR6bV2DdwcwoH2OD35gfY4UPuJQtEIW/Z3zH8sXXoN5hK6aojL
 Z7Ja1z/z1W+dTWgRNtl21YgmybB1DHVSBeW333RW+yMRfhzedJWt1EC5RWvwhL/RUS61
 3yXhEWBt54iYLFEqMzPqoaynJVVSE8qslsaQ6fMbg9EyEn1hVIGbChi1rrvbngyxTLpF
 S80/FZTTQDqCcBPZfvUoxRRTzKkr/NPP4I0g1Nwk8Qzl6kIUQObbtgzlJRuEjs0grMo/
 lMRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDMipJDKprrsmJQtifX8clnhnT5MIZREGYQnMjDi8WCBT2QnwsjMA+27GO6LWzKOBvUYMxy2s=@lists.denx.de
X-Gm-Message-State: AOJu0YwQwgEWwbb6FKNAAPMbcAJ33OHa/pnU9ELeD9GdHE1bPzzT/Nup
 m8ExM82hlPekKAmiaBc2/psHxXWy1dvOjHR2oDXDnFqm5xgmM+hcl0CELPxmrmrbMeY=
X-Gm-Gg: ASbGncvJc4JwZq9fXh0GQ6laL0/tJIL4xARB9oQNTk7DtnByrOXITgk2iepFwldPR7U
 42mbaSrWyZV/3izXtlb9PSMb/Eg/ZqHMHpkSqLc0UYyTPGmqLIvwUvzzQLw+1nDUaAeNqzzpTs2
 ivn34k4zWV7CViy9FEWSKPM6hg+Bi2Ap+bq40sHZUJMRmaHQ7hMyWx6hU9ZS0zRhlmh25T76iSb
 Ogu40Bfrt3CA7x1Z5rndBwR77mEKeBd97HZWckqC/NfXMncfohSKIH+1fiiOypRLP2NVhaCvySH
 VqGFdV0qVEtRnVFLset+PFTUp4VXitgOZ6JqrH5ofX4knE6U06JiWcP+AHVgylDIhCRu6jWzzoQ
 cCH0j92H/DN1ao6CKhUY9wscvwUSRac3e5jMnV6r5QcUBLm/0mk7zamqFlDaqT4Ljumf0lPVH9f
 hDKJWAUwCYmtXb4K0=
X-Google-Smtp-Source: AGHT+IHhVDtIN9WbYCs5tKrNizjoMH7KLeMSK5jN3s30yMVygC70Ld64pSFamIrNZpNcn3jpo5Nc9w==
X-Received: by 2002:a05:6871:5809:b0:346:865e:d044 with SMTP id
 586e51a60fabf-3c0f48c23d6mr5592486fac.11.1760129717951; 
 Fri, 10 Oct 2025 13:55:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8f67c7csm1210306fac.27.2025.10.10.13.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 13:55:17 -0700 (PDT)
Date: Fri, 10 Oct 2025 14:55:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] test: uninstall PK after secboot tests
Message-ID: <20251010205514.GG298503@bill-the-cat>
References: <20251010202926.2603488-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DBwP7HB9EnFjuIwN"
Content-Disposition: inline
In-Reply-To: <20251010202926.2603488-1-heinrich.schuchardt@canonical.com>
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


--DBwP7HB9EnFjuIwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 10:29:26PM +0200, Heinrich Schuchardt wrote:

> The EFI secure boot tests install a security data base.
> Other EFI tests assume that secure boot is not enabled.
> Add the missing tear-down at the end of each secboot test sequence.
>=20
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Thanks for digging in to this!

Tested-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--DBwP7HB9EnFjuIwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOlyqwAKCRAr4qD1Cr/k
Cq/WAP9WDyQR9WpGu/6OlEAe8OYGCyTcWQmXacgpgYNTLufP2QD/S8+fx5EVt//H
kTfcA7gSCozSIkU3MYAL86gLq9vudgg=
=3inq
-----END PGP SIGNATURE-----

--DBwP7HB9EnFjuIwN--
