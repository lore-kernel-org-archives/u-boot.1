Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC8AD0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 22:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD6C888D99;
	Sat, 12 Oct 2024 00:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UNC4qYPD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBADE893CC; Sat, 12 Oct 2024 00:28:15 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CECE88D72
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 00:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-460407b421bso18981991cf.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 15:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728685692; x=1729290492; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oqsidmOxJ87Q2oCtiUIpzxVTu+p8F3nRmLQ6R1uxIYg=;
 b=UNC4qYPDUnpQWWRFKl4ZW17t9hOPD1oR+nLTZOhGiY0B879AHzNjnY8HYao0aF/VaK
 JiZ59h5590sDp6zDB1KNA6K84BjuWVZv+XvOGExva0m2ZTWqWoW1dtoID1mQ0FFWnBY8
 YdsxsPrqcV9dJWPiIQWcTL0bZVJH+V6UaDQlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728685692; x=1729290492;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqsidmOxJ87Q2oCtiUIpzxVTu+p8F3nRmLQ6R1uxIYg=;
 b=Ae2ujH5tTX8zGxA6tqglkSOe4HqcWupkQZvg3i7cn0h++DnpHz7lKUUE2+Z8GJnmVM
 z30RZC/30JjKFDo2vuM0IY+7JEgKz4ZGZD5qhoF5niEeasVclRhVRUj31VHcPlu+B7bT
 CmSV0AnKdETu/btl7mapz5C2yAHZ7Uc5/fHxSmimCYDaAACgATxYsdm18DFm2nwKNnt7
 EUvbCx+p1/TeBFj/HMzl9GUCJ/DkNYBNZNqjhgUMI+EXcaCw6bxMm0aZCDRRqOsTs1Ul
 8vxVyG3p3T3L/XdF82grxQlebUu+ZJfMQ7OnAWPlqkrmAfhu2tnnRU8d04ltIXeYwOtv
 Y3+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYvlen5G2WRfFwvFxtQiGc5Xsoz8Jr/kjeXhjmEt5AteiiJJeXXzIGGzVELbRD/7yVpsr/HbA=@lists.denx.de
X-Gm-Message-State: AOJu0YxyPZ98ay/2Oe5DX00UKN+4yhRYCMmRr25eh8Zp+ek8zk0M7nSx
 vru82R/S9wZf6aK4TnvR2hBveWwCNhYNUxHiVypJFy9W/s4ib56AxHboBlf/4q0=
X-Google-Smtp-Source: AGHT+IHm0I/o1ihyzFsVhTuHR4Vnl+eH47YxN7RpVFPbSwNIMUYR/t0ArSEVXhnJC61XPTmzMYysEA==
X-Received: by 2002:a05:622a:1827:b0:45f:211:b319 with SMTP id
 d75a77b69052e-4604bbd9a36mr56956041cf.36.1728685692396; 
 Fri, 11 Oct 2024 15:28:12 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4604287f9e3sm19994751cf.75.2024.10.11.15.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 15:28:11 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:28:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
Message-ID: <20241011222807.GZ14210@bill-the-cat>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
 <20241001002442.GC4737@bill-the-cat>
 <79d98f61-7659-47a3-938f-1eb79f402edf@gmx.de>
 <20241001180235.GH4737@bill-the-cat>
 <e02a9912-7260-4e0a-81d8-c7814907a791@gmx.de>
 <CAFLszTj6Zuj0b3kEA4OKOQY_D5XMWmtbn+HJXik+xSrB7LUjLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8IHa1EVP5+pQhD7j"
Content-Disposition: inline
In-Reply-To: <CAFLszTj6Zuj0b3kEA4OKOQY_D5XMWmtbn+HJXik+xSrB7LUjLA@mail.gmail.com>
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


--8IHa1EVP5+pQhD7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 04:16:28PM -0600, Simon Glass wrote:

> Hi Heinrich, Tom,
>=20
> On Tue, 1 Oct 2024 at 16:18, Heinrich Schuchardt <xypron.glpk@gmx.de> wro=
te:
[snip]
> > The relevant error message is:
> >
> >      E   Exception: Bad pattern found on console: spl_signon
> >
> > The error occurs because the substring
> >
> >      U-Boot SPL 2024.10
> >
> > occurs multiple times during the reboot process. This is not expected in
> > wait_for_boot_prompt().
> >
> > The EFI test is resetting the board and then calling restart_uboot()
> > which by itself does another reset.
>=20
> We had this discussion a while back and I was very-much opposed to
> restarting U-Boot within a test. It has set a bad precedent and now
> several tests do it.
>=20
> This is another EFI thing that I would like to resolve at some point.
> As previously mentioned, I understand we might be one test to check
> that U-Boot does actually kick up a firmware update when started, but
> I don't think we should be restarting willy-nilly.

We should indeed not be restarting willy-nilly. And we don't. But the
test for "can we restart the system" must restart the system. That's the
test. It's not changing. Testing if we can restart the system by faking
the restart is not testing restarting the system.

--=20
Tom

--8IHa1EVP5+pQhD7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJpnQACgkQFHw5/5Y0
tyxTcAv/YOf9pJH8KbQAV91UdtbiCNeoezQrICpITUuUOBEJ2Hs5i+0q7Aa8ubVm
w2fRThN4CuKwEqgYOf1jmxQ3o4leJXxBCZuuDYHaq7tmHeVuk1xPBdxkUzwqRIfk
v2FLogl2Z2z3n4ixIh/72ZvtwBpGWszvwMiONxTubSjDIVNq+gAkcMeqhSvLHxGW
n3P4DdCw4tjsR+6oyBjl3JcqKj3DI24aqydUHQ3NDmiY+GxmwlMPlXA+aCebcOpt
QghXkXihjCCqjofh1lN5tF7kDlkW3XZW9s7Nc1oVvoApKwNVENi0Kq+eSyT9Qg8H
eFkMup9sjR18mbCCL4b/Ty10MR9+hfuInlPS9n1IE6ojLpAFy+JSr8N7dycFCSTa
ev3t+crhH8dI7GWOAsxMQ8LKQpcrNluYtM34Lg9AkKyo5KgsyFEYonQL16TOtiQJ
GicvicyjRyIbuiptg401IX7348pEeYEmwvmBaCbMnWrqi4ZnXktWtJXo8t4/9+7W
cZ4dMHKD
=1zbz
-----END PGP SIGNATURE-----

--8IHa1EVP5+pQhD7j--
