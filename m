Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B088CFA45E
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 18:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56A7F8926F;
	Wed, 23 Oct 2024 20:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bhw9hV4m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63FC988DB7; Wed, 23 Oct 2024 20:41:25 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89AC891B8
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 20:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b1467af9dbso8923685a.0
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 11:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729708878; x=1730313678; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aXk2PzyIE77yDfQDzPBj+1IQOhSZQ/HwCaxZABt2eOk=;
 b=Bhw9hV4mLSJhpqoewfyebvXW0OCuKixM1eGUDo1tNzTwKBN+xjX9nXBneta/ctdv3u
 ox+4ngWEy8v0VkI5g23UMvxtsnCLYbOA/3ulDX54ZlxjTy8uOCBtwmsDA3rZmZSXmM9d
 8DU/+TvvwH8dzxsy620DnQDqIUAnE3zbbjmSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729708878; x=1730313678;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aXk2PzyIE77yDfQDzPBj+1IQOhSZQ/HwCaxZABt2eOk=;
 b=EMPgCyxuc8+Vs8bLUp0xe6tDAO+2ezwLeCfLMdkT1K/gsSFcJe7EydgXl/VnZpvNvf
 vKEyc3ctSRkM+tRltEsACZZoqzKdcsI+J/VkuAvuJzvF5TDLNINORF6WolsHKpmWPrR/
 acfmPYAy/MLKsvX7NBTi6CUEpfx2N2N7o1EqKq/HClIvLNakXivxAJ3b3y9Xev9L6dOK
 9JioBitObggJKqvR2TknpTE/llvfnUN1D4I9/TCixMCJdrLVjf4YjUbfSfD7FgRKvob6
 cDBYYQkzPsl/HK6afV/TGqEwmPj5wOKWDUCrTjtKsGrzPK1R+6RJVNyyw7Se7sfWO3Zk
 Mkkg==
X-Gm-Message-State: AOJu0Yx1Jk5UjQedgrhQmQNdb3vTB+5Vrs8DqHWP9vGW1kJDXRXd7ZVe
 daj1rWEGptUYn/pE50ZCLM08BWSj05m7GRJYEkhJJcD2WistvhEhrC2pwqhoXfn4EfQ9XRKodsC
 JJS3DBg==
X-Google-Smtp-Source: AGHT+IFvjLrr29xUdk/hMy7VE58Nyq2enAFsbECfZQoroUIAEPhZBc0WXdQ9M901/PJGKuySTykkkw==
X-Received: by 2002:a05:6214:570f:b0:6cc:2cda:bd5e with SMTP id
 6a1803df08f44-6ce3413a5e0mr34820876d6.11.1729708877777; 
 Wed, 23 Oct 2024 11:41:17 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009996e0sm41960866d6.82.2024.10.23.11.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 11:41:16 -0700 (PDT)
Date: Wed, 23 Oct 2024 12:41:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-watchdog/master
Message-ID: <20241023184113.GK4959@bill-the-cat>
References: <87707c04-dc76-41f0-8fca-5782ca37091a@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2IkISrIUIzPmMJXo"
Content-Disposition: inline
In-Reply-To: <87707c04-dc76-41f0-8fca-5782ca37091a@denx.de>
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


--2IkISrIUIzPmMJXo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 12:55:02PM +0200, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull the following watchdog related patches:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--2IkISrIUIzPmMJXo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcZQ0UACgkQFHw5/5Y0
tyxDowv8CBunoOmVCiSKb2o/JQrAjVNsFdMWmFBgR09fQADpN2Hc7+chNAv/IYgI
gpNW56oca7Ux+t75v5D0lPNDD577UPSxvB4/X2SmlAyj/QirN1BSUhonah5sGklR
CTStWrCMpHm5fivth7yuj4ClrX0hTD7hVqquPvdMrs8Ccyco9sW4I5QNCnxbAaU6
eckmGaFeH6Lx4vZsuN5gZTvUl4URKFKcWOJFZHUetZWQAfWvPwvwp7JfuQjc8Jjq
RUsqurQK5lOA9R29ulyeqW1IzWAWdxtYLwlq6/MCsasoa9wxcT0F2UoNPpfUvpZe
RHXlQu5v6PvrpBzuiFg9DRnirqePr7t3f+SPTFkS/sOyp0mg8fB3dESWPhiumpx7
jjmmbfG6Ea83v8/LEtHsYJdlkFcGPphh2sZ4zfrK7Vi/pr2iqrVT98T+DyQRfh8I
zGbNHWxBC9BtBCWQp9KC27Qnxr6OzlQKTL+Alkf7m7dPmfIta9UjI7bvtLCN9+o0
K8Pj4i+0
=TVmT
-----END PGP SIGNATURE-----

--2IkISrIUIzPmMJXo--
