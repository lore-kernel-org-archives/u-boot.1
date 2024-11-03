Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF3ED11141
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 15:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02AED88E41;
	Sun,  3 Nov 2024 16:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bGdRfcv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B58788E41; Sun,  3 Nov 2024 16:50:09 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0220188E14
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 16:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b1507c42faso343350085a.0
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 07:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730649006; x=1731253806; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dnD3NmSWFkMLCyT2Yx/q73Tj+i+KUep11D0ybIl38Xs=;
 b=bGdRfcv/+ZCY7mLXcESZ29njvAz5Rj2juGIVCOZmPQ1iqn1cFQimRwb35qd+JuADrz
 epwl8/MXLIs2zae3SemDBL46jOz3NrHjvcPS1BPsyyNbRxc6yYxbt9F2F39yNiknP3t/
 44mWhf63gIYab0HEoYi0qqTCtRUxvuG6MmmGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730649006; x=1731253806;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnD3NmSWFkMLCyT2Yx/q73Tj+i+KUep11D0ybIl38Xs=;
 b=pHItB5yuAt/vcRX2mghJyyhWxXVhzcIGQ5H2j8R7eJP+0r/3z3jB3MNEfulsHvqn3e
 BhgSHH3BDTFH+EKM7DlP01PmNbdpUzKlAvLgj6LgT7FrTXevEb0v9uukL1UafgDORMwD
 krtnEuMFUxVYZJfz3rE6XOQLQ27MSSfAyTDAAYXAoVCxqinxWEjqVoLCX7mNwmhta/Je
 jwgCa+HXlHrAbvcoHgK9CuLxAJbpQi7fAmd7vs5blDskY3/uIzP297hkX+KK06u3Q4or
 vIKfilAdf6muAanTlAltP2CRYWXtkt9b7f3rAR5bHtpQvKUPvFDYgUtFDAUPjiZ2nEpf
 IqsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUblsjVVxJdyhJ8hYOR2Pr15Tun9eKs8W6hdYC3s3EPTCk1kH6CSlMYeOEAoXkdjgkfqm0mJ38=@lists.denx.de
X-Gm-Message-State: AOJu0YxqrcG/DKdS6IYX5rvOmpjCjpGB4rFAHm9oTemKwIxA5dRCeGGZ
 DNvyfonUnYKxUvjU8116sbkqcAKkFrKV0IObuz/GoX6N1hGMp0Q+RAphz4TZ2WI=
X-Google-Smtp-Source: AGHT+IFjFY+Y6DmIHjR5BLZ5vg3bWlNn1BMRBCCu+TwV8LgdDhfh2rSS77qMHvi08/5z2iBjhgHp7Q==
X-Received: by 2002:a05:620a:258e:b0:7af:cea2:75f1 with SMTP id
 af79cd13be357-7b2f3d39c03mr2031778985a.24.1730649005873; 
 Sun, 03 Nov 2024 07:50:05 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a0c199sm347027585a.64.2024.11.03.07.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 07:50:04 -0800 (PST)
Date: Sun, 3 Nov 2024 09:50:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] configs: enable UNIT_TEST on qemu_arm_defconfig
Message-ID: <20241103155001.GC3600562@bill-the-cat>
References: <20241103071200.82853-1-heinrich.schuchardt@canonical.com>
 <20241103071200.82853-4-heinrich.schuchardt@canonical.com>
 <ae7eadd9-175f-4903-b272-71bf9c862e3f@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NQm7zwlwh7522sDL"
Content-Disposition: inline
In-Reply-To: <ae7eadd9-175f-4903-b272-71bf9c862e3f@canonical.com>
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


--NQm7zwlwh7522sDL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 04:45:41PM +0100, Heinrich Schuchardt wrote:
> On 11/3/24 08:12, Heinrich Schuchardt wrote:
> > The lib_test_uuid_to_le test fails on 32-bit systems. But we never caug=
ht
> > this in our CI because we never ran any of our C unit tests on 32-bit.
> >=20
> > Enable CONFIG_UNIT_TEST on qemu_arm_defconfig.
> >=20
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >   configs/qemu_arm_defconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
> > index d042aea49bb..cc4f4540fd5 100644
> > --- a/configs/qemu_arm_defconfig
> > +++ b/configs/qemu_arm_defconfig
> > @@ -67,3 +67,4 @@ CONFIG_TPM2_MMIO=3Dy
> >   CONFIG_USB_EHCI_HCD=3Dy
> >   CONFIG_USB_EHCI_PCI=3Dy
> >   CONFIG_TPM=3Dy
> > +CONFIG_UNIT_TEST=3Dy
>=20
> Before merging this patch we also have to fix the lib_test_dynamic_uuid
> which fails on 32-bit.

Is it the test, or is it the UUID changes? I didn't go so far as to
revert the UUID changes when I hit this on Pi 3 32b, just poked Caleb on
irc.

--=20
Tom

--NQm7zwlwh7522sDL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcnm6kACgkQFHw5/5Y0
tyzSJAv/YASCLtA1+nZ1kax+LjvtkTZ2affJjWZqC5IX3uT5wt9WXB37WacgrZDN
g4TOzp0X24I6BVmjINbBl/+yWsNKiFNoJfpv6AcQZ4QNSKozU+ZBHsejGRnpK6SM
LXtFr1t1iBDGdq4zMOVajBtOviItvdhsDU1Ybeu5oK1P28pwiZ+ZfO4ledsi0OY0
8ys0t9K2oFHN5MpeNuiXRrpe9c+hzFyxYMx6xq6DN47G096HAyWqKQFuIuuvriqO
9y0yv8cSn7qFjmtazplGzbLKF4qRE8fX1QZeRXphRFWyCnMrVNp4KmUpHQb/BKxV
xlXLSuLJ7hCe+k1f8Q+Ucn7fejBkNz4DZUDv2Htk63mxF28OMtkyrB1uGwRsjbT2
lwUhk/imPPdLGbv40oVFzGTl+WB1J8t87UfMOvABWOTz13L9i/imJX1bv4T2go3p
vdeACOKvSmkENaVYiQE0O/z92tdLgMGsy/+ia52FOiQgObDEan8T/JD9SZ923nmt
cv93SrgR
=Lnz9
-----END PGP SIGNATURE-----

--NQm7zwlwh7522sDL--
