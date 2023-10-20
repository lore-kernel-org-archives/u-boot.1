Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E62C001DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 14:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A296C8744E;
	Fri, 20 Oct 2023 16:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qcs9RWur";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DB9187478; Fri, 20 Oct 2023 16:45:51 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86E0A8729D
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 16:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7c93507d5so9465067b3.2
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 07:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697813148; x=1698417948; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jhWAkumB6HZmuGhVKFqjOkEDyypwBhEziPhrn0xxlDM=;
 b=qcs9RWurzd+3XfgyMhle9Jy82lBdLsj/gqho+K929buBNIS4TjLoTJm7+jNhenIZRQ
 UCtq9N7h9QkF0zPnc1DdXlC7ItpSpGuIF/TXAIXuu6wMdUF1JG4GAL3Ak580y6rUplKJ
 n7a/pLdNpECkqMwNI8kG+Eq8d01pMy2ejYwaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697813148; x=1698417948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhWAkumB6HZmuGhVKFqjOkEDyypwBhEziPhrn0xxlDM=;
 b=UQLq9F21erUlEpcmdDdz6ycbjlVm+T6+pzANJYJ+UIk1WBPyWHz3vsZtM4ksbWI9aG
 Inrs7zI9FDYDZWM+a7sqKa79WgiKWmDtWDLL63CnQqXY0V/8s/Yt9H96iQW5iJhl44+I
 a9lhelvixBg/XD5m5+K0Z+ncsOoyV0ZlvtgsWMgHL2G1TByqn6OgciWF8/1JtdwCFVBC
 AGJ5cm672OcIInWMSF66jeGdkh6ZlpTCof+c5XC56NFk6S1CcqYxfimhprHkbDqVnXhN
 ZbAHFrnWwxmoCNiAuyGR4W3cNk159GlqyAjml/UDQc5g+dHJYAc7MyMUtz4OqK1wYS4r
 +SKA==
X-Gm-Message-State: AOJu0Yy0Uswvws7U3uneio9h9X8Ndo//fxWwJ69Kw/Ov0r2w/qY0rfBs
 h7oTixioXchzs2T/+384+tb4bg==
X-Google-Smtp-Source: AGHT+IGY2iaRXZTqbox+EInVzcZdV61lekghP4hqxZjavszsQWB9MrBhPbW8qEd4WWJSbwM6StE5Yg==
X-Received: by 2002:a81:9294:0:b0:5a7:da0d:e4ee with SMTP id
 j142-20020a819294000000b005a7da0de4eemr2467194ywg.16.1697813148148; 
 Fri, 20 Oct 2023 07:45:48 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 u142-20020a818494000000b0059bd8447721sm722553ywf.21.2023.10.20.07.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 07:45:47 -0700 (PDT)
Date: Fri, 20 Oct 2023 10:45:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Chris Packham <judge.packham@gmail.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: Please pull u-boot-marvell/master
Message-ID: <20231020144545.GJ3119521@bill-the-cat>
References: <f84925f4-9c3f-4901-902c-49bb10a10765@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sVhd3KnFSUXA/++y"
Content-Disposition: inline
In-Reply-To: <f84925f4-9c3f-4901-902c-49bb10a10765@denx.de>
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


--sVhd3KnFSUXA/++y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 02:51:08PM +0200, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull this next small batch of Marvell related patches:
>=20
> ----------------------------------------------------------------
> - kirkwood: Pogo v4: Enable LTO (Tony)
> - mvebu: AC5/AC5X: use fixed page table size (Chris)
> ----------------------------------------------------------------

Given Marc's request, can you please either respin this with a revert of
6cdf6b7a340d or I'll do that later, and drop the AC5 commit from here
instead.  Thanks.

--=20
Tom

--sVhd3KnFSUXA/++y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUykpIACgkQFHw5/5Y0
tyydxwwAoyhdrbehtnrAm8UjwrTlxJe0dFlFo0sJTiyvDwW83J7yiW+6vM0YrSj4
EsVeCzmN+LWBKGVnzX1NZbQolB+OsWAHxGST0BKjsaYq8BzoI0eiRcglByFgznoB
MxV2lO5843RkaCxHwpxq3458VVQrRBjZFZ6xhf9GTRWRBOYSqxX/v8tmzlYFF+ys
h3LjDmEiHP39QPPcPZkjbjLFc5nYohFrdWwKh8BnPvmNkLq5AFjGHJIL+g9dzl0s
NWl9fcixGwSDZNSgi1gJs5WGZ0jz/Bei+hmDqXk35GCRu/ugfej63QG5koUL/X55
zpsqI5y09/PYAOT/Zqzof2TZFd83t+V0T8+ziFxB1WKAa5tUwiKBgcBioHW9rkwr
8Kjru0LjFl/DMULKqzUEb0S0NVUzPj57uQ++twn0cLY8bMrdq4h5w8ilDL9cssNI
pA2ZNw5g3dmfDmvyvXXRPvoqSo+tSih3ntwbRcAtXXM1vQPrVdmzIjWkl3QV/9z+
FIzd9fEa
=kz5n
-----END PGP SIGNATURE-----

--sVhd3KnFSUXA/++y--
