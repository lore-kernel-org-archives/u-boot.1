Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18F5D597B6
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 23:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54D1894B9;
	Wed, 13 Nov 2024 00:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sOvbebLR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F711894BE; Wed, 13 Nov 2024 00:11:14 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26916894B9
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 00:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e30d1d97d20so5589126276.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731453071; x=1732057871; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EwrEt5c7aEiLiyX2w7FTfbFTnpctsOkmPYo6lE03prY=;
 b=sOvbebLRcBsJqPvoJ3Sa4FW2IzrmAxJPGqqT+SN6Jaefo1CzvhBeq2vvy4Qdj2MIIF
 J7n6HXffJe3H4nvQFmV9UCAdBT8qjTiiSue0DJNCxN7tjdbsMXhGFrZKjxslwpORYOLg
 DdfwV0FpywK8SqsejnwJvX13HNYXMNJokttWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731453071; x=1732057871;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EwrEt5c7aEiLiyX2w7FTfbFTnpctsOkmPYo6lE03prY=;
 b=fFdaaorvq1QMsNhfPePtycGAtq5wV8vuKg6m65Hrs+rN8UZRA9XBsL3tUP1IJNQFpr
 gNso9/vRRTgLwCF5RTvgmMkX/cQvJeQ/e9zx872YuWkK58qrKqg04h/QF0rBnYObuhVV
 v5yGX/4CFduOweEDa7uxbEZhXA7Lx3NkXT6N1IwUb3+Yqr/kSZuFq0nUwQPiG5pnVTvM
 d5H/aD6InV38OtORmUxu1/nCtznSR+67Kckrcs5T0E4kpU76dHVcDEYZuHI2sI1cWi13
 OLHygjNCzYEAf1oeJd6fYxafUuPoIL5/vAjFTM66Y2k19yBK81h55hz9XdMZ292Vol48
 aJfw==
X-Gm-Message-State: AOJu0Yzziw/oY6DdwBIbOrz9YFA9y7mfU+vIlsKgrIIGAJjLwQBEhcsd
 hlem66D7fdPF3O9cvGNZHcLKj5OFLhldA08BVK6M6EORRtHjyuIpu57HFCj3/iM=
X-Google-Smtp-Source: AGHT+IFGVSDvm7Jmtu4Oo+ziDupopOK7lCYJIl+HkcmbckjO6afHIf7DXrRkPOmZULimiCtUTmQ16Q==
X-Received: by 2002:a05:690c:7083:b0:6ea:95f5:2608 with SMTP id
 00721157ae682-6eaddd8a695mr196364467b3.7.1731453070920; 
 Tue, 12 Nov 2024 15:11:10 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3961f6674sm76507246d6.52.2024.11.12.15.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 15:11:10 -0800 (PST)
Date: Tue, 12 Nov 2024 17:11:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 4/9] docker: Adjust packages for arm64
Message-ID: <20241112231107.GB3600562@bill-the-cat>
References: <20241112141105.640189-1-sjg@chromium.org>
 <20241112141105.640189-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CF3YBLDIZt9rrstS"
Content-Disposition: inline
In-Reply-To: <20241112141105.640189-5-sjg@chromium.org>
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


--CF3YBLDIZt9rrstS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 07:11:00AM -0700, Simon Glass wrote:

> The package names are slightly different for arm64 and we don't seem to
> have a linux-image-kvm package. Provide some extra ones for x86
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--CF3YBLDIZt9rrstS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcz4IsACgkQFHw5/5Y0
tyzq5gv/S00AF2aB3kqooXFRToA8eEGxVuiIbICyfLcYAofN8k5aS1fYLr7IJziC
e6XqBbEfLCl6KwDB/24Pr9gmH0kq68AwicrkC9yZR0Ky8X3LDICpcy2kDRXJjD6k
DqhlhxF9oD1gCyeSlD7Iug8OdC7CuIr/1bueMVLnljTY7PDg2Z4TEol8+iwCqAuc
FaMWy7kz77e6rEbsavlhY15DE4Mtj44WCL+U1q4yCh4Z0zsWBiDvOiIWo1NmO3bY
ybXZUdzdX9r5F61p3UNVFCQFANTr5ocMw16mlJPOk52aZl+FhJzlxQuP7xgGV0Hy
apla0lMnKKx6jUvro2PbTLg+EJG/U85UIWbDaLXgB7PRS3WqWi619lFYpsbXUFgi
7q5EpbyBEQsBPKY5KqqcaJjvoAgl9DPka0OLysAhB+t3xHhEJzaUOhw1P6aCKDq7
+49sBGEN+KLDSviDNu0HYg3O8tpXP7xS0tzHIhreiZWTV7vC0FY9qZbdtdngIXWH
tmFYfEkc
=j1UL
-----END PGP SIGNATURE-----

--CF3YBLDIZt9rrstS--
