Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BB7CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E4D686EED;
	Mon, 16 Oct 2023 23:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZNa62JQT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69DEB86C2D; Mon, 16 Oct 2023 23:32:59 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BDD86A3C
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d9ac31cb051so5334093276.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697491971; x=1698096771; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zo2TKSTBwmXnvf0PRhKWijFvi/rfDBgNrupVVM74Tf8=;
 b=ZNa62JQT31NsPqBYYUgIjyfHZgexVrny92Jo+kFDz+NFt+EANFPB2luZ9Y9cQH0jzo
 Ib6RL3HFM3XU7zTqZbrEfDlRv0G1iMn+DAcpqiUhsj9cEIoTukV12h5DZ4WRwO6Kfoae
 3uP3oqTCAymV6VL/rafUDkyeDKLmoWPeEXd/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697491971; x=1698096771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zo2TKSTBwmXnvf0PRhKWijFvi/rfDBgNrupVVM74Tf8=;
 b=ihuvPnu7jYnxq3FL4x4jIGfMqlyJX4oDy7bCMOISzryGiwXKbtI93g1UPZjv6lRv2Q
 CGvkfk8vaC7OCmjM+BpWrjPxwXyN3S1nbECLK+DYCPOSTVaSWvcyp5nK2TS21ClbgylH
 5a5aVxui4kYlVc/A37PPQpObwpkUq4f7RBUD4531yDdRgfRLKx9YPv74eg2CMGM9Oj1P
 MHppiFpFdnvUJGigJADmhp6Ix8wnu9kLtseZ5eA3hHIpclhh493JotPRTQzluzCIasmO
 tPQpQHrPW2LmV3+ddACreuN2Ru9NYZq++Tj3pP2eIdNqQ6cXor/1vw0hx6xuM+5fguah
 GFCw==
X-Gm-Message-State: AOJu0YyzExsyg709+nZYfQUCbqEjT7oaUUCKj8Z+Hm4YJGQOAFAhyo2Q
 NOhM9T6e5yKXaMyJV4O0oxnRbQ==
X-Google-Smtp-Source: AGHT+IEHKiz01nZC+Frz5WRW/D4kLWvqVeEXyQoiulJ8eCe172AdyUQKVdMPoeHImgH6rLdoQ9FTwg==
X-Received: by 2002:a25:cbd0:0:b0:d9a:e337:b6a with SMTP id
 b199-20020a25cbd0000000b00d9ae3370b6amr247963ybg.61.1697491971371; 
 Mon, 16 Oct 2023 14:32:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 x17-20020a5b0f11000000b00d9abce6acf2sm3458ybr.59.2023.10.16.14.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 14:32:49 -0700 (PDT)
Date: Mon, 16 Oct 2023 17:32:48 -0400
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-marvell/master
Message-ID: <20231016213248.GQ3119521@bill-the-cat>
References: <ddd355c2-344e-4fbd-ace9-29d10f3966d3@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wVo4xUuL79izNmSd"
Content-Disposition: inline
In-Reply-To: <ddd355c2-344e-4fbd-ace9-29d10f3966d3@denx.de>
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


--wVo4xUuL79izNmSd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:50:26PM +0200, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull this first batch of Marvell related patches:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--wVo4xUuL79izNmSd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUtrAAACgkQFHw5/5Y0
tyxxjwwAtHXpHf7ww3c6rVm7CsPlmrucAyGjRsErmAEW/22jX5dYSkvBy+D2I0Lw
WWxw/wItrycRha/dI9ZyxHIlvNJWsXPuwQg5dZGXkfgKT7KK5XwYbpAivUaBkrte
kvoKkpIeHftWSo4kIWkeHNlKCABipvR6cGEHGM7v/t9OE5o8i7N/nM5ClLvk7W6p
LAWmNB8pKkNBeciAyUOzIFXBRLeXZvTfOqOA+FRmT4Q6sezxoqG8BILUAXDE8qzE
HFyA3tsynoBGaTiu2Cs+MySUGMTglTOwKzvheEskRX0ZIAdXjLIOSGU26CSZvc/J
GxMewA8HcRddhxY7eS+ldK+xZ86r10PiZqD5TKeaeHtXmcj2DMxNJL7pkGwIK549
rkSMuHSJjFeA6mLEoe+PZ14nhuKJxQz4sGCTuI9DN1J4RoxphqbNoLL4INresRS8
CCNvaVH6BOwObxxdzAI9Pdcp9YXSelIM9YZ6/WvJ1sSqt+90IqRXgBG3tmq8sZ/r
ZR77Dwc7
=Rhvy
-----END PGP SIGNATURE-----

--wVo4xUuL79izNmSd--
