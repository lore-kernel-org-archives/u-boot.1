Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5626C54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A8286A43;
	Sun, 19 Nov 2023 16:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rikrSKd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A87EE869CA; Sun, 19 Nov 2023 16:59:09 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 157A886EF6
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5afbdbf3a19so38139447b3.2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700409542; x=1701014342; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Hx5fOHu0VBQP5AKotzPyEmNa/gDFkH7+KuSebO/WGIM=;
 b=rikrSKd7j/WdqfmrEPEd2sVvABmnsF77br+7e+9BXCjr6YfP8bUxkfVFK7MLKqxcAC
 SqQXHJptRkvi28X9cOsLrHnvm94rkIxZFkHr93w0G4FVGph5tymkpEKW7FzlE5nt0GTs
 havqJYMhiBOLYNmwXur4VlLF/26i9Jf6cm6DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700409542; x=1701014342;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hx5fOHu0VBQP5AKotzPyEmNa/gDFkH7+KuSebO/WGIM=;
 b=PC1HKCDqXasDNqMevOGSYfsHZVSwD+nqlpo6ioOmcy2xc97vkzLB4obMq4x6I+Dixz
 KiB+0lk9LgeMcoOq9NlawhWnY4ohuJ3Dht9SCrzQpvcLespDgYWALUFCBwAAn3dAHHJQ
 zIC5z3CGZ91SzdH2/rWxb8XlGhCEkoiJNTgZAoz8xuevu1VRC2sChrB0PIl8rFlpw6LL
 FMHGHLebyx7ryNPa/JzZNdEL4s2Mb2kl9qkAMoUrbcKi/SEFNPVwX5N66kueTLwjao7O
 5g6+woaUO9lHtV6HII95x0D40oMj+iWW/WTc1NNcLZZOKgOzskrNOCOWLg9EYknNvxNT
 IkgA==
X-Gm-Message-State: AOJu0Yzp0CiOCxTCRlNcts6+9GRjd8H9LjQWeF9usxYe+NDXtO26EQ6e
 GZWGoWyf4Z8jfmwqg7ZWW/xl8g==
X-Google-Smtp-Source: AGHT+IHDBCb5hamBjGEvBZkQTZWEmGjPEgYk+Sfbx7faOH0gZK2QaH0+OIZR/jGnxnQNIQwoWcxsEw==
X-Received: by 2002:a81:8082:0:b0:5a8:1d75:65c3 with SMTP id
 q124-20020a818082000000b005a81d7565c3mr5309423ywf.13.1700409541791; 
 Sun, 19 Nov 2023 07:59:01 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-af10-dfdb-a5aa-dfc7.res6.spectrum.com.
 [2603:6081:7b00:6400:af10:dfdb:a5aa:dfc7])
 by smtp.gmail.com with ESMTPSA id
 v134-20020a81488c000000b0059b1e1b6e5dsm1788762ywa.91.2023.11.19.07.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:59:01 -0800 (PST)
Date: Sun, 19 Nov 2023 10:58:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/master-mmc-clock
Message-ID: <20231119155859.GA2513409@bill-the-cat>
References: <20231118152341.63823-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aDqTQFTV//SWB2zL"
Content-Disposition: inline
In-Reply-To: <20231118152341.63823-1-marek.vasut+renesas@mailbox.org>
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


--aDqTQFTV//SWB2zL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 04:23:17PM +0100, Marek Vasut wrote:

> The following changes since commit 17e9db18f17b6cad278694d4a61df95e96bdf4=
f5:
>=20
>   Merge tag 'doc-2024-01-rc3' of https://source.denx.de/u-boot/custodians=
/u-boot-efi (2023-11-11 09:22:54 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master-mmc-clock
>=20
> for you to fetch changes up to 70d2c9940e54ada6bf9e1e538c958f13ccc97c38:
>=20
>   mmc: renesas-sdhi: Disable clock after tuning reset when possible (2023=
-11-13 04:12:47 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--aDqTQFTV//SWB2zL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVaMMAACgkQFHw5/5Y0
tywqsAwArd+KCL81IwfWxjjiCVswcdNS+2Ta9k8kvpe0GyhdG24th9CR1vuz4kgF
kkQnBJtFnHUJrcEvnGeTf/gDAUPh1q/SvrM4+ZRO75a+FfKu6g6//Rc6muPmtyHZ
vo43+b2eWYalxUt6PG4YdmnUIFZSuIpvhmkrC2hv1WYMMryH5QFzb1e7sh5x9neA
ab7F9G8lkpnAZThJeTqnPLV1GDKF+nOVqHnLZffYrjJo5ne59Ubyc7YjrByQplNr
bNDb+p9A5MojOWUKxu/QyvvX39J7nl9AO4Ve5umBCrgX0FdBuhllQPNOUCFLP5hS
PMRag/zCfbGPxFg4GkifUwOAcsMlB0hqjhc/iLWyBkRbHC8vhBZ41zmvZT8P+G8y
BluFEKSV0RSTaJHeKc/W6RbCpi+nGYwnKpSz9rZsrAd4UyAy1hNoc4JDz8G6O5oe
I/rfw42scWNo6IJT6gBMrnXK1ninLIHXw/+46QYVluUc2eYbjUsrciS22qhg9f5j
3eWE4EWM
=DqIL
-----END PGP SIGNATURE-----

--aDqTQFTV//SWB2zL--
