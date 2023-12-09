Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A1EC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 21:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB404876B1;
	Sat,  9 Dec 2023 21:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jiXco/fr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62EFD876B1; Sat,  9 Dec 2023 21:59:56 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFB34876A8
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 21:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-daf26d84100so3169520276.3
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 12:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702155592; x=1702760392; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EaeaxVl3WY/ZfT2p7wIC9iNIQedljorhcxlY+BJy0jE=;
 b=jiXco/frm/2amM/cCu+PF/oUHhQ/Cq4/ftm6X7vxM7Fa7ut+eTTVU9yUtt8aGOUKkh
 1Jcdyp7FeRIFFWrKLRVaD6r1Ym4LKlv73FBtmA7cHNq8mcDL23xIyJk1GFlUh1btVcO+
 mqO0WjoJrqmU7nndjIrVq167jBPuqI+qpafRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702155592; x=1702760392;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EaeaxVl3WY/ZfT2p7wIC9iNIQedljorhcxlY+BJy0jE=;
 b=iLYGl6WqiEpxVuMSMevByn9DhYie2mK0Abu+Ofg2ypZSj1Y6p0I8QjN2LSwDoHcwUU
 xiB/xbOK/cZMM5cNkz089mfP9CIY2TFimqoCjq0N9matpuFfFu9x2QhgnDlIZrvJ8hxw
 3tCDhmPsYl+GjAsJsOBZFq5EIhm/M8OT4WBFNMGG2PzAJ1JckHTl82+RceNOGk9BXE3A
 iJOx624DLvndVQoKJLG6bZzJWBE3ioV1UcI++872VvIqGTQQyVo/rYCKmBIi105GVy5i
 hVRG7s9oU2V2GlMKE+ieij+EQyN2U0M9SRbVmCs/hobbPrvwqCirlry/LJMUo1NFuX5V
 XWvQ==
X-Gm-Message-State: AOJu0YxB3DM9BNN8hNB381xHrK4VzSdg36XNgs8CEpGnavYsrK+5PLIb
 ZUszIRxjUjedoS/MOOf9Vb1rtCclOZK0EDJypQv4kw==
X-Google-Smtp-Source: AGHT+IHHEnZvvhL5hVgC/+Mqvmm0qBRbdNOYXv/Es0bAiKGVOiJ/Humabp6ixYoJQ+VzGRpYGJZztQ==
X-Received: by 2002:a81:5b85:0:b0:5cd:c65c:8173 with SMTP id
 p127-20020a815b85000000b005cdc65c8173mr1725497ywb.10.1702155592691; 
 Sat, 09 Dec 2023 12:59:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a0dc203000000b005c5a08c5c15sm1708871ywd.136.2023.12.09.12.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 12:59:52 -0800 (PST)
Date: Sat, 9 Dec 2023 15:59:50 -0500
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20231209205950.GK2513409@bill-the-cat>
References: <ZXHMh3tIsPEZa3Vc@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4Zh5Az9XEkHULq+0"
Content-Disposition: inline
In-Reply-To: <ZXHMh3tIsPEZa3Vc@swlinux02>
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


--4Zh5Az9XEkHULq+0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 09:46:23PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b=
63:
>=20
>   Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to 94533cd9c15a60b74420e53a725fab54d38dd555:
>=20
>   starfive: visionfive2: add device tree overlay support (2023-12-06 16:0=
5:39 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/18812
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--4Zh5Az9XEkHULq+0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV01UYACgkQFHw5/5Y0
tyw4Zgv/e8L/4a6k6V+PtmWFbmjpcOTcy+8Q8CtXmi+xV/P5tKw++tX/Rh5SZEhI
+4Auoqq3EcrbSrHnugkWYTeteVwtfegeYfdLzGiecQ7rgH1l0Ow5dwULn2T+MJM6
aDAMIHhYx76xGWvjybE9xLA+UoiqodziUwvAGJEKuAzR74QSsJXKWz8V5T3eh8ri
Xbio2f3tqNOVe3+KX4YbBdvIwYzw7ZPa5KsFa1Dm58h86xnAufBCsBtiw5EKJMBO
F7mRhFGpdtkCFpIW9AsQ8EtJK5bdQ9PsG77RZHIH0jjtx2q8NLD2nMo8ZkdDn75Y
MCQhkOeRNDAm0t8qKQnNzkAtr5YnPpUyyfZ+Q3JeUWxnwmA6JMjxCDwdbhY2GDhD
lRv9DtmYWT/fNKFSpAo0hKW5NqX3Mq8YIDAIyflloy336Nq50suHKvLH5SFIHqoG
Q4yWMpMgLIiZpQZH0/IcnKgK7pMZp/sAmeX6RDQSQvvyUgOazHiPfyPzDHRAacpx
0TKAiF8b
=pmZy
-----END PGP SIGNATURE-----

--4Zh5Az9XEkHULq+0--
