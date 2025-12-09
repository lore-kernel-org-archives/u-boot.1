Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE01D3B99E
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 22:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D55883C4B;
	Tue,  9 Dec 2025 23:34:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XrKsBb7Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C33B083C94; Tue,  9 Dec 2025 23:34:25 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A7FF836C8
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 23:34:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c75dd36b1bso4789286a34.2
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 14:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765319662; x=1765924462; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XhY3V0tlgdjOSbNioR0nkT0CO2SakUJnp3zH98IjJVU=;
 b=XrKsBb7ZIg5KnKdoCAfAzy3gylmcz5Jj8byWXiJZBiDCJuen66taygBoK8HmM0WCGP
 EcelrE6u+RDCMVouJLBXWwFF+2+vFYk2QHeqmVPgQABeQ1qV6Rp2TdMz3NuJvHHY/tdR
 caej6vyqc63ZXk+BqMDBYLcNJfNruKns5kntY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765319662; x=1765924462;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XhY3V0tlgdjOSbNioR0nkT0CO2SakUJnp3zH98IjJVU=;
 b=prGe5gGrzUKrJZg+FVL1axSEddiVuLhJvc2sQAhG5BNyw4HpqDDtBWu96FMF2FTdDK
 1clLhZOMGEyD33VcF/FQrd9yyDYuN0Nu97En1kBaiZUEpu6QC8DBQb1CUbubjnPhIWqY
 zYK9yFL/1rUUsay8oVzPK/HGkTNjoAtJG30lh8uCHYGypmt7YKZOvCmWK+j30cUwHmpc
 B7ozZs/nXi1ig27xBwge9Xfu0SC6MUM6fL8HKuZ+LYigekC+AGz5SmTeEon1lYGkF2hM
 EyEAYS+TEN61D0So5yUbpzpziop8RHjT7kxJdcZKmKDnyXBaRuz9O6jow2VHjpvPtDbW
 JPYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1UUJ8owQdNarbjo+NCAk/4MhD9nwHzAWro40vqT61lCJhmST5UtXmMEiMWNAr0o7pJXcfOuI=@lists.denx.de
X-Gm-Message-State: AOJu0YzcA2kQ4E13baRMxOe0Nt73G9qPLLWFokfiJUR7Qh8zbWBV6S1f
 MlKzK+JjlPAjf8Z19eCEvwXwU6od8sE22HL8/CVe6ov0zQg5icdB/Vs6zSsba36qjrRmKstWwva
 6tqisNLc=
X-Gm-Gg: ASbGncs/gkCy60xJDpimIgu34EfC1MfF370Eqgjxwjp69bkwlB7FKZCrINtDDKDrBzD
 fk6slFENSzAZy3uxB6GYnk4bwUkWwsRcXtEkAFDpTfzdNkNB8mz4jOtHLp57q7bgEY8qNAfbAPe
 PFcZZIs/Wf6ucmr5tDcLLMG6cOME/5cco4y18ETgwBiLLhfOeDK1N5tJyQOSUB9ehriL3T2MXMf
 D3mB8cJnI0AvoMsMyC0vAZEOKevgLSGZ5hjiizrAjAufKlHFRiev19StBltC4cCzdi+5oxhpvC3
 NHeir9cNM/6j0PDyJGtAmKLyknfhODx3O0wdD/ZtsE/9jmz7CGkwi+bYLgTkWLI3ajQPVd3FqOW
 eIWHgpH739hthwBM1+PUxDtEDaMpjljXBXm43xJ3esA0ZM/z2badgaKtHkawt4simaiX6s73SQn
 hlHKJEGhroXPv0nnmjPG3JQJZRJDPXvQvnLOB4jXdSxUgOv71/1g==
X-Google-Smtp-Source: AGHT+IFzjdxrhwl10KBS3mXzKVr8DwIfrYISxT9ErC8OPXwagzPYOSFDwz8cpI8dDxRZdmMqA9FdIQ==
X-Received: by 2002:a05:6830:90b:b0:7c6:819d:bddd with SMTP id
 46e09a7af769-7cacec5f44bmr263202a34.34.1765319662345; 
 Tue, 09 Dec 2025 14:34:22 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acdb599sm12962554a34.28.2025.12.09.14.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 14:34:21 -0800 (PST)
Date: Tue, 9 Dec 2025 16:34:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] tools: use setuptools 78.1.1
Message-ID: <20251209223419.GC303283@bill-the-cat>
References: <20251209223238.415022-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wlXFByTO3obhMF50"
Content-Disposition: inline
In-Reply-To: <20251209223238.415022-1-heinrich.schuchardt@canonical.com>
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


--wlXFByTO3obhMF50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2025 at 11:32:38PM +0100, Heinrich Schuchardt wrote:

> CVE-2025-47273 describes a path traversal vulnerability.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

As this also keeps us in sync with tools/patman/requirements.txt:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--wlXFByTO3obhMF50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTij6AAKCRAr4qD1Cr/k
CmQSAP9ma5VyvkPcjVCkW0rpOzU55mb22My2MhuKE8cBopuqHQD8DeegtCTbeNKT
A7MIbxD8PNoIwMERioEzCckZeR68cA0=
=P2+T
-----END PGP SIGNATURE-----

--wlXFByTO3obhMF50--
