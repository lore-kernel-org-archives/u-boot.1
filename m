Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A613ACAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 22:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C60C28387E;
	Sat,  4 Oct 2025 00:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e6QTccDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAD62838BF; Sat,  4 Oct 2025 00:57:23 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDDF58383E
 for <u-boot@lists.denx.de>; Sat,  4 Oct 2025 00:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-88703c873d5so102902639f.3
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 15:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759532239; x=1760137039; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dxGN682wTm0nWcJxii75hwq2PjbU7hMn8tyTHiRQTVU=;
 b=e6QTccDs7d+0IVKlAXIlfPPmk0oh1clt+0+NfMpeRsR/du3uZrEDIj9hVNA62jBCZZ
 bR+HVP/4OaD0ghD25uvY4FYgFoKPtE4ViEte/zcyQQ5VXvs+XBt2y8Xt8o1QzR4uwy4O
 1IVbRSABxJzhkoMW7i0NOUfzsCqmjdb5jpWnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759532239; x=1760137039;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxGN682wTm0nWcJxii75hwq2PjbU7hMn8tyTHiRQTVU=;
 b=pruZ3VR/tm+3jtekIwZQT4o95R+zAM42Mbh7nH7yN06WIhtHTGUJ4B12AGf8W7amZA
 wgwr0OH1u4FvO+BeNYVgIyXiO8UtCDFHXXwKXpQ8CXW6XC+sGYtdJ9c9ws4XTFaNtIL/
 dadUC/gAAp7kadTMpx36GfyMUZ6nYlqbh5D2tMGsUK4AcTu/k49cKIEddMoXVR9ANt9D
 MhtafmC0o/91YXnaQ27E4cu0DWR/3En2UwPoGTi9Uz1s+pbO4RQv5bjc8pPB3zG59yoX
 UYn16T7M37lW2Gr7NOcix1oPhQ/Oy8YJCXP2fhqBleT8N9+vQY6vzn//3vxje+CfcfNu
 /frA==
X-Gm-Message-State: AOJu0Yzvn7zbmmZKrznDyQmS9q7iaSuwoXH+dYi/uN3wzLRFGcgTa+rS
 nBRSaX6wGbv3cKQqVIwjL7HkdOWF/3zjld8/W6eH8zEanKfy2igU/bOXN9PD18mzUSC5dse5inc
 JsgMXZ+M=
X-Gm-Gg: ASbGncuPONlwIs53p8UASrrthvhTOny7IGqdXwDZR1pIYJuli9uMSuCp5kgLwvNLSDf
 q40zupCn58Jj1aBP9VYiPQTPxL5vySKrLByZI5gPic0Z2zlOzDZmOcwPUaBzFgekErTJ963cwIt
 WaPLGL36wNXLRXvC6OdQiTimr0yPhl7B2m6fkrahYuf6+85wFFrUB6sSCA3WQTQNF+4FoDwh9uz
 rqzMq7Tuk3HpxIm2JmQ5fJIh3UIHQqchU6qLAuFOyrKB+7yT0H32ttWAE26WPDB8OB+WYSsghvK
 lNfUFWRDGrn+tCWrwb3YYVr2mCSJkKqVTr1z+gC7HuUtDLWbiL+3brasBXFoJigEf56SLVZUpOl
 OBuBnUj6aBr9TKc4MPEOBBMA8pufFKnljJ3T4dYgDPJBxzoW4TyIiYtY5mFYl4io35UfjSlWjjj
 ehOeoWI/pUaA==
X-Google-Smtp-Source: AGHT+IG67jsznuSth10CvcUmv8hLHKO7mxcg62/2O5qH54LSCM9uGiJPDAfivcr2zVFkwQcmaEFiYg==
X-Received: by 2002:a05:6e02:16c9:b0:424:b860:7d84 with SMTP id
 e9e14a558f8ab-42e7adaa636mr58317425ab.27.1759532239556; 
 Fri, 03 Oct 2025 15:57:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b28152csm25797115ab.21.2025.10.03.15.57.17
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 15:57:18 -0700 (PDT)
Date: Fri, 3 Oct 2025 16:57:15 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: spl: Remove ATAG support from this command
Message-ID: <20251003225715.GA2203498@bill-the-cat>
References: <20250915190548.446942-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EZ34IfgxkKYgWfEu"
Content-Disposition: inline
In-Reply-To: <20250915190548.446942-1-trini@konsulko.com>
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


--EZ34IfgxkKYgWfEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 01:05:48PM -0600, Tom Rini wrote:

> While we continue to have some systems which support extremely legacy
> OS booting methods, we do not have use cases for supporting this in
> Falcon mode anymore. Remove this support and references from the
> documentation.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

After adding Anshul's changes and Co-developed-by tag, applied to
u-boot/next, thanks!

--=20
Tom

--EZ34IfgxkKYgWfEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOBUxwAKCRAr4qD1Cr/k
CgfrAP400vjKHoKT+AfO0+Fkp1qI9il6Gb2iuYhMaBKuNzXW1wEA0OGMNC0XikTr
Bgwa5UYq7M4vVpXfREqUH0s8ErN2Gg8=
=LVBX
-----END PGP SIGNATURE-----

--EZ34IfgxkKYgWfEu--
