Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E6AC25B46
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 16:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F448794A;
	Mon, 23 Oct 2023 18:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nN/wXDss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D278887944; Mon, 23 Oct 2023 18:59:11 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9196087948
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 18:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7e5dc8573so35368977b3.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698080347; x=1698685147; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kYf6vsWBsl/vT3dlUf8+fQdnKP35/5ZnYErvaF/ZUFQ=;
 b=nN/wXDssdkOnn/S4EFA22VY3r1MGD1uVRyhOhnxGw7foru/Z1A2pWmDq4UbKdm5MQk
 ga1Vc5LG14hV6NaYBDaCA9pgupqevrGWJDMDN/IYtH8bNCdTELfIagzVCnoPHe/EWe9W
 PZueIxnBNlUGN3frjNsVKUQyncFRj64YG0Rw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698080347; x=1698685147;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYf6vsWBsl/vT3dlUf8+fQdnKP35/5ZnYErvaF/ZUFQ=;
 b=KyFyUrTQ78Cb77uL/QUDSzE6nwhSGDg2XOkBp55euXas/a93TtvqtqS0WA9LXwJObO
 cjpru4SKkdp7+x+p4lNhA/cDFFqJ9tPRkCEKCD0fYb3KTxRToXJn9vY4Uau0CYPOwX/o
 Kgvy2vSRVjeRO/Vg0V+TEqz27ri18/6nTNSGu/47tNRA05rKAHXsMtY42b7JzWHvGuCZ
 aEzg6r0+2mrLgKHJgD4i0ykBuRW9NbWN/hGGpuqM2nQWMa0pH/A6GNyU4YGCZ09sPmJ1
 X2nnYwLb1A5PvNQI5uAfDMA6N40N21uyQgfwqnSe+daE0Vkrx+XtAw9DIhR9Q2KeDxi0
 KvIg==
X-Gm-Message-State: AOJu0YwGTR2aaLpM3oJ3PCY2zTB5TX1dSof8PuWMVl1u1MxOgWTuK7Of
 mPpeH84Mdgru9FbuFzNFMgx7qsaOTtu0Ieq43AWaOA==
X-Google-Smtp-Source: AGHT+IHznPwElRRd1IHMKTE6D7/OO8KRSDOHxfIqJ3Axh1HKdu1ZO8HkOryz18egX000PrM+Pw6P1w==
X-Received: by 2002:a0d:fd82:0:b0:59b:1f6d:1958 with SMTP id
 n124-20020a0dfd82000000b0059b1f6d1958mr10794289ywf.46.1698080347156; 
 Mon, 23 Oct 2023 09:59:07 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 n192-20020a0dcbc9000000b0059f8120ee4dsm3300881ywd.30.2023.10.23.09.59.06
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 09:59:06 -0700 (PDT)
Date: Mon, 23 Oct 2023 12:59:05 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] ae350: Update defconfig list
Message-ID: <20231023165905.GR496310@bill-the-cat>
References: <20231023152853.1599056-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t9ziUnVmq+FUQ5Ny"
Content-Disposition: inline
In-Reply-To: <20231023152853.1599056-1-trini@konsulko.com>
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


--t9ziUnVmq+FUQ5Ny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 11:28:53AM -0400, Tom Rini wrote:

> Update the list of defconfigs, this was missed with the last pull
> request of the u-boot-riscv tree.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--t9ziUnVmq+FUQ5Ny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2plkACgkQFHw5/5Y0
tyw1Fgv/Ysg/wJHSizNkgwkb6vXCxCbi82GLaGWtF8nVh6dhx4icBjkbJH9xIHj1
IhpYtcuI9nQ7ZWgsyd8jRC9qpOGYSOuTKdES88dXI4yE1TFZyyaJKCOCEdocitKL
6VzAFKv7oCMCTwbI5gDWL+iyPIakLcpHdn+hbQB3qgJplUr9lXAZ1euam6hq/zw5
VoFucPftQmdOMVq3Uas4PkgpDMNpDdZ1g/3kl68USyJC9k5z5C+aZEkO+xsa7/oy
i9d0OlFcRcf1hIsXLDk8FfQ2CLQ3K7iF4PwdHyXoipQUj2OqsIrl30o0SnrPei6H
OO4cYebFJHWOTfhNq4QissS92abdGAKbvEx0sC8tKYg8MCOPlkzhawK1NL2cB94N
8QHOJQRjTjyUmgK4cUUosi+I2sF3yMTI/d29gwZ4NE+a5h2o1SJm7HmREhwzZcvm
MR1fio82i6oM3COEIzidmyVdZzFj6bhgNq8OZoDQLiTP6NSHIlPDavZ00vGJMNsF
lumxwCMB
=MdEC
-----END PGP SIGNATURE-----

--t9ziUnVmq+FUQ5Ny--
