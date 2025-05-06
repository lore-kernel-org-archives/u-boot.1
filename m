Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C99C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 16:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A576F82153;
	Tue,  6 May 2025 18:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q7u959CA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8796582163; Tue,  6 May 2025 18:44:42 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F9781FAB
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 18:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3f8df49e75fso1384756b6e.1
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746549879; x=1747154679; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uw85h3nU7Qh5diujtbhxpICa+yD3uQUaJKGeLQHwncI=;
 b=Q7u959CAcHxl70pjzTn7Y5V1wUZykxBeVr35VhfrEvvVmzJPBvkZDkQh/3qM688f5A
 8mUK8DMTVHzkp/MkOZxwxnWU9T4LsJzOuAoSx6AcUk3sUTh7+a64XaK7NkKru9DmHXC+
 dZy0wcr9/XaTsYCMdMWUhdPPcU0RRDThZFk8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746549879; x=1747154679;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uw85h3nU7Qh5diujtbhxpICa+yD3uQUaJKGeLQHwncI=;
 b=M0WNINDioohXdCbPeR3yEXyOeGNbZBKFo2IdCNttkbAmoOZq1SoO19FPygL5dfsvMt
 ZpxSQvUhvfjUFLLZEXPrWZgNCOcpGWgURslGB7HU0idQ73zER711JDt2cI0Zcf+o0g1p
 4DSU6rhYvfHF1MvKAMfZHyGPTK0vrkzlk15WGyCPR1HtHxJq/PPGr7n31TpzDqQONWLb
 KvsI+0C2Xu8vTsGYS61YPPIdFezCc8gMEzBpaN7nNXC6MPQ6thJUVM72uYr5M7ohGwBR
 Z89pLj3DXyTiizclVaw31CriLhL4h1VoUFeVdwwyHv3Ywjr3iA+5qN+gFUzbuilAOZxw
 v45Q==
X-Gm-Message-State: AOJu0YyWFzDp0zgA6BQ9IOuKIWBVm/m7g/8ZfajEyqK2mW5O8WuV0LgW
 cQt5az1pGM9oo//+QFhTGZqgOm8HljGtdwnZhgMCw5ACQwjIBUy2F51HBBFBzHfTub/PNA4pbXO
 d
X-Gm-Gg: ASbGncvD/SCtZdmn89o/qzaxH81pvwYfjDPeJD2B3uXB6cWiuRMdMoRioMI0CY6fuBK
 IG1vQrEXUA0WyEVvLJcEoF2uRXF/Jtxe1vS4xMCNRwY2qfmqB0jCLB3qlpW1yNKC3i/Yppssnmo
 ch09aVmtH+SExm+KQ0TkNHbiR25G6Vzohdx1m7ofeDMVRH/FW6IeSBkaBC6isDpdu2MeVGw/uWI
 rBCsGr02xwlsBSUfp9cKWF5lhLUj0tXTLbAI0MGMWRddJaszgECRPU1W26aUq4EvJQH71D5XCUm
 8VJJt0MaVCqNTc15uW2s08D1NN639z9N5I7Z2Paq7HYPck3xgja94B79QketVciLdWDo160GH0b
 X6g==
X-Google-Smtp-Source: AGHT+IEWoXXPsgZM6En/sAEwhJYhBUEbs/Mx72LVsvJRJqMh1/QLYeOwUFRFlo2wL6OEklT7r2AM5A==
X-Received: by 2002:a05:6808:3848:b0:401:e933:5de2 with SMTP id
 5614622812f47-4036f08983fmr12163b6e.18.1746549879001; 
 Tue, 06 May 2025 09:44:39 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4033d9c21e4sm2600459b6e.17.2025.05.06.09.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 09:44:38 -0700 (PDT)
Date: Tue, 6 May 2025 10:44:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 00/11] regex patches
Message-ID: <20250506164436.GZ5430@bill-the-cat>
References: <20250506141035.385756-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kq1UbswogjGjutHT"
Content-Disposition: inline
In-Reply-To: <20250506141035.385756-1-ravi@prevas.dk>
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


--kq1UbswogjGjutHT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 04:10:24PM +0200, Rasmus Villemoes wrote:

> This started as a rather simple patch, 1/11, adding the ability to
> more conveniently do regex matching in shell.
>=20
> But with that, it became very easy to see what the slre library can
> and especially what it cannot do, and that way I found both outright
> bugs and a "wow, doesn't it support that syntax" gotcha. I couldn't
> find any tests ('git grep slre -- test/' was empty), so I added a
> small test suite and tweaked slre.c.

I will say I worry there might be users depending on the bugs you've
fixed here, but I don't think that's a reason to not fix the bugs. We
can if needed deal with bug compatibility some opt-in way if required in
the future. And yes, this is a note to anyone in the future that has hit
upon the problem.

--=20
Tom

--kq1UbswogjGjutHT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgaPGsACgkQFHw5/5Y0
tywjiAv/UfhGFXjP8Xi53rzBdj242gByJiZNZzKCLPTXbyD/RsKhpdaiINeBKvpC
UCBBozhoCT4mNwSJAql0WB58sG1nVBeWXzyrMJMCxbJ0IsuLn0cp4TeeSNCmCP/o
gv19+2dRBgbwtkCwPkIgrgZ30+OmhN1bjhi641v+JZKQPzmq2THJDX74MBjBdfof
NtKBkLuSfUSNaLMF5z3oGdPKfpjEb5Wxx+WA/PWxiPgdUCZcHo2l+WxJydOAwWw+
apGz0Y4xGAhv7M4QxjoUOSPzWNj9iZVuqfNTcVh6/GJaXXdOY35mVAWGdX7jHh9/
aQ718dyfNwMpkm0enRUD6tReQlTOVm67dAphQtjepCD7EBtX7aCZwUZc7y+rDjJu
Iypd2WfVLTBMglOhj7Gu+QlsNr54HO5ABXS99D1JCj7xnHol2DG3ddGkncFzmBkv
MoozlbVj/LYCECSGjZkQHSPWcMePfdcV7HFLVS6YoAVVIlTGMFJyuAr9oiwyEnLI
6JoE1B+K
=H75e
-----END PGP SIGNATURE-----

--kq1UbswogjGjutHT--
