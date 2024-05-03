Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3D7C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 22:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C4588208;
	Sat,  4 May 2024 00:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HIUQIYfw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D10088263; Sat,  4 May 2024 00:21:26 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B24881FD
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 00:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-de60d05adafso185165276.2
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 15:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714774883; x=1715379683; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mL+yWkICff93oXR6Kzy68NHIX+ESoBb47lagVNge4rU=;
 b=HIUQIYfwQ083TYLKBGzH8INrXg1v+U8tt/AThVLSxU1MVkkNHVP2iwwLC5vFpxtsS1
 VQWxTeYhOaIEWnNREN7B80FOmJO8wOrP/++46WdrkIS4xwQ/XY0ag0X0r/iOBxwO6B3t
 JQvVFqAI1liQlPYrlzYSQC0SC3/V0Ic7UHHr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714774883; x=1715379683;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mL+yWkICff93oXR6Kzy68NHIX+ESoBb47lagVNge4rU=;
 b=bzrf8J3qqEPEb4Rqk8HoX47CvvX4KDpQYduQOzdGgI6pOZWi5Q5pY8ehzSE8Ih2eLu
 w9AxZkazcUBggzdPHxKO+taEqmGmERLLAYC/XO4Bq+rJlfEXTxe262Khg7qPPbVVR6JO
 mxDQyE8SU2siYBe/UlcmtFuEZMK3mPpQL/U11gJLetdMsN6AoK2DVdX/WBNdW2xTM9le
 1gmPUzU2ey3w31ykd2EjLPg6qxooBRisVKD+ykX8xpZPvNk7BVBWU/cSUw8y27bcA/rz
 OANovGldxFvAxTBVhkm/2Ju08A4mty7jpxbIRz+ULKiWm7GC19W4A03qYMJ0FB8ws9Ud
 5wQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpmq03OqEXVvMN3MZeTGgphGapoD55MDgEintrQC7zXPKqwYzLwPzak7cSDSeWl1nSDerWQh2dJrJlHxy2oo6v/OIzxQ==
X-Gm-Message-State: AOJu0YwpgGo+6UZQXwMS5dU+ldT3pg2OM3noI+dEZwjZBfAf+ZKjl97T
 EWoIVXbJnRQNT0deWenTYULLCmtvy2p9yf57MLQT07CNTo/DgPPBfaXsumGHzEc=
X-Google-Smtp-Source: AGHT+IGxzeQzL5AMPfuEFnR9kAHUR1azY9QVOLp9/Qw2J+SVVFuFG4rLfZ8oFO0ZA6GKpFgGfoco5g==
X-Received: by 2002:a05:690c:b1b:b0:618:ce0e:b915 with SMTP id
 cj27-20020a05690c0b1b00b00618ce0eb915mr4566742ywb.27.1714774883157; 
 Fri, 03 May 2024 15:21:23 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 eh11-20020a05622a578b00b00439aa792ec0sm2027907qtb.37.2024.05.03.15.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 15:21:22 -0700 (PDT)
Date: Fri, 3 May 2024 16:21:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: YSCHU@nuvoton.com, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/3] Arm: npcm: fix npcm7xx boot to kernel error
Message-ID: <20240503222120.GG2568172@bill-the-cat>
References: <20240423072210.1926141-1-JJLIU0@nuvoton.com>
 <20240423072210.1926141-2-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sHGQBFpNXRLebEHu"
Content-Disposition: inline
In-Reply-To: <20240423072210.1926141-2-JJLIU0@nuvoton.com>
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


--sHGQBFpNXRLebEHu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 03:22:08PM +0800, Jim Liu wrote:

> Add mem and console env information and modify the wrong earlycon env.
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Applied to u-boot/master, thanks!

--=20
Tom

--sHGQBFpNXRLebEHu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY1Y2AACgkQFHw5/5Y0
tywQiQv+LoABLiiJup2sPGPA00gYPr2tTDJb1m1MQe2MFC8Yp0B/SiyocK7yLUgH
b/KZus0237aP+SkennATWdoVTxvpPpBidNll0CND9rjjs+ulqtiu7vjdzJOErkTT
gcGjaFnELSGshJAxWGndtsBpyUbdnU2A9Uvh5jYXQs9IEVBfMCjc4CLVFzgbHVBz
lxZJd8kH9804mgn4OJlmHMIaq6Q57o4fJrbHv031xRg1Oc5rTTTa+r+mtKlcPs2O
dahycVeCgLPUZvA0D11YtqhqrPFWVKLB8IXmOwNh1UbyJGhM53OSEGM2/5RH9RAP
EKJEQRj7Zip0vco09zR7ogtwVB6XJQPgmp2UNg2oiQJPLo+VA7+y4F0kE+hi8BOs
MgEHF6ivH0DGDn+lzUNH7kdkPlVz6yyfd33V0fC0+ny+1ERC5Cr3b1vCA4jVWrFA
MRL5BlbIpfVK7dIJtBbZkmCjd1C9vGDH/1oa4RMyaKUFYJYJLULH1Nw/beVnDxxt
r7oEn/Sp
=TXSp
-----END PGP SIGNATURE-----

--sHGQBFpNXRLebEHu--
