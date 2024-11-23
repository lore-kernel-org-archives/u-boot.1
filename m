Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E177E6ADD9
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 02:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B79CC89873;
	Sat, 23 Nov 2024 03:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iCnU/Lu5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B7A893DB; Sat, 23 Nov 2024 03:41:35 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B8EA891E8
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 03:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-460af1a1154so16963461cf.0
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 18:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732329692; x=1732934492; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SFIDr4Feq/3zBpAzG4V8MIC4X7aPJsecLfOna4ivQws=;
 b=iCnU/Lu5A0fDY4yB64txnfReifW41Auq6nT763uJEPfH+ZgWO4yIiuZCFSba2uCWwQ
 VhUBbJDDWluQ0AIus9NaFKXSYGmwFZZNh0S+Uo6hpS/jFZPYM1WC52cauKDeYXuCU8XB
 9yF6QrYNlPL8Kjl6idBX7IWN1XWcuvrBrMT/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732329692; x=1732934492;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFIDr4Feq/3zBpAzG4V8MIC4X7aPJsecLfOna4ivQws=;
 b=tyEZ5FXOOfEN+pY//Wr3NEUUycROho/PQyxOdOeMGUoyU9+6IGTep4ttAFEnvr+UyV
 qgcWvIGDZ86FGs6cxnoaJQ9a/Y/4NDXGYiaDR58+USoSI7yWZGtY5hw3Yvfp0A14vlkT
 qxnDbhAhPsqUboSrpEVbfuTI9DeAT+QK6x4bU9CxmE22nUzUEzNZMwjnsiiRKla8JouA
 fudRyF8B+Ck//F+h7722YCWYeMzmcmr1KASb+zNr3jO77NE7X2LEYPvdhZysmzLL3t8F
 HfeGoMwGuiLBP+seUPTzGm0TkH8FDo3a1rXlFu/MtE643BVfNsOktwX1Vh4exU13IAaJ
 dwjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7Obwj5dyaQLFLFFPLhfxaKlK52wOH69d8/DIGQaGwBJksYp8D7hIHkLd4sFPEdcYnjgjb2Bc=@lists.denx.de
X-Gm-Message-State: AOJu0YzsmX0HW80gq9eJ9U1CK9uRj6wBHem3EFcjhQITkr1catOSlt9p
 dtcc6/tEh294vdrjwYfxjiKfaskMm+0h7QURPkLQgYglzX2Y3cdalhuhYy3yK1w=
X-Gm-Gg: ASbGnctfHOPfvUALkUfiyfAV5yzjtOpO70KnEB3gZLLq5uNT8yDFjkRkycM1wozQX6/
 CNomjohc3wNCJ7GM2gUG3hhHQ1mkZvc73nwA5uHf/ZE5qQSBQ0wXhXkURuw0sqRLO9C2zS2jIIT
 vWhmv9MO/+ZJ4t0+R73Je+xcsDoK+ctyxKFlsnklTqV3Oqn182ye32zaOvIwTM02d1SR2spREbC
 lxoomXbg2sxF1n0B+PdbWj00xRxzpZbDsNoYncsk92CHK5ehw==
X-Google-Smtp-Source: AGHT+IGyV4IFj/72tobqlNxc5J9GMV9TO8a9J+c+xGCzbhAv3Qo6zEL8WWmmgXbzsHstchWIzkuhMA==
X-Received: by 2002:a05:622a:408:b0:463:5c34:d8b8 with SMTP id
 d75a77b69052e-4653d637214mr78254431cf.55.1732329692537; 
 Fri, 22 Nov 2024 18:41:32 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4653c47fb4csm19059051cf.70.2024.11.22.18.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 18:41:31 -0800 (PST)
Date: Fri, 22 Nov 2024 20:41:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] cmd: improve description of the cdp command
Message-ID: <20241123024128.GO3600562@bill-the-cat>
References: <20241111095035.35319-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L+64UFZa9cRKBFIn"
Content-Disposition: inline
In-Reply-To: <20241111095035.35319-1-heinrich.schuchardt@canonical.com>
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


--L+64UFZa9cRKBFIn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 10:50:35AM +0100, Heinrich Schuchardt wrote:

> Users might not know what 'CDP' refers to. Provide basic information.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--L+64UFZa9cRKBFIn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdBQNgACgkQFHw5/5Y0
tyyBxwv/ZMgWCofv5w1Z4J8ejhw8+diyxWqDf5BgqT8YJ8DdZIl+MoOEn3a6E2QB
+HkVSUDeRguFCa+J4gcwTGfa5lSuFBtZve2JXis1f7rrxh0iNVTLV4aOnoCECtFs
r4ZL4hjTmSOZdyIfkONWl0u//o+iVzHoHpvTsNoj1vKyp2K5gJ6qonwkGVQjNJPc
JMlqgi0YnEJUs7loPbJbTYJgNW+dhNXsIojiNzQyh4tf5AQSKg6HWuS14Xd1kgpy
LR6N06HIy+jd/1m0JL4fGCTugd3yPWXNAu12A+HqdJFKz2cI85z1QU63h0KWzDwg
eHrDZYOHuJKv6yPr9qqWMYibYiNqqyakzxjjmVUsA/4GjSb04/+IfBmfXxkoIr3E
0xcEjuMNjBsxb3/HPdvCcrhJOFaD8C8z2Ji7xzYGuNOXjR7F+lhnXhJHx2jzn9gV
RGgDK/kIMU15/fFaxZR5qfKa6p1UxJcxicXjhdKMi3riYbc98Ky/Gxpmp4kftj+L
mU/gzHwp
=85Gf
-----END PGP SIGNATURE-----

--L+64UFZa9cRKBFIn--
