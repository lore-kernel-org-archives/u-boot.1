Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6E5C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 13:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3243C88087;
	Tue,  5 Mar 2024 14:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FA39UOhS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BEF588079; Tue,  5 Mar 2024 14:27:48 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9294E87FA5
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 14:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-783045e88a6so436906185a.0
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 05:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709645265; x=1710250065; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WAllrRDdw1bXQ7JpIY7rhBHGah0RurMyjRY45of9Ej8=;
 b=FA39UOhSqrKbLrDlJS7duKTzLt2d50oL5bjHq+g2tOkfacYuC4o7MQAmkqg8ei5057
 xTNz47uxnRUyBp7aN//7WRc2uaZb/1h/rvqxHKlIW6yLLYoLc5PAgbnlGGD+5arJbIQ8
 0yHD1mWWew4Z4dzkNXLSWy9zl3HaWdhuBWjOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709645265; x=1710250065;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAllrRDdw1bXQ7JpIY7rhBHGah0RurMyjRY45of9Ej8=;
 b=eISoCZHc3KHBFQXAP+H2QUrrMILRHQ7YJXU+dRdVFZzT2uQ4CSJO3MwpXa13HCkG08
 xFZipbaHjjeb+x7nFAuPZFnPL27NBv8bbaXMA6g9IKaEnGnWBFHPdvo4wVz3lNVfoFTZ
 /WHXG2wMSWsuep0ig5ikmaycvIKR+syVxgffdfmoZRrqa/ebEZ/avkHHLqZ07lFNLBa0
 qYIHEZtYuTYpEfC0ChzBxiHoUDJIevY9hLSOyrtmA53C2oN8wwxv+sZ118wdXU/e740h
 AaYDRxusseeidA9s6h8r11JZcwqWBRQ0bZTJavppfGrm9Uyz+qf0tPNvbkU63791HbuG
 aBZA==
X-Gm-Message-State: AOJu0YzOLAv/+GNmZ2iWBFtxo3oqGsP4nkRQQXM9nfIpW3DT+TtxwJv8
 HA3KrKEyksu0zKEbpDOZlL/+66wyEGcuLIL1jpArJS9evwI7IwgF2j+9PuXkInte3UoO5KVes2S
 xKhA=
X-Google-Smtp-Source: AGHT+IHqPIhrtVelOpZje1S9dTPj7okndmvPCBU5RukSml8omHPJEFhkHhzjGG6OuvZkcLU9+U3FuA==
X-Received: by 2002:a05:620a:109a:b0:787:f9ba:1d5b with SMTP id
 g26-20020a05620a109a00b00787f9ba1d5bmr1926302qkk.19.1709645265370; 
 Tue, 05 Mar 2024 05:27:45 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1000.res6.spectrum.com.
 [2603:6081:7b00:7f::1000]) by smtp.gmail.com with ESMTPSA id
 u7-20020ae9c007000000b007883841e28dsm349207qkk.82.2024.03.05.05.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:27:44 -0800 (PST)
Date: Tue, 5 Mar 2024 08:27:43 -0500
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-marvell/master
Message-ID: <20240305132743.GB1523872@bill-the-cat>
References: <6a3008a0-d918-4ec4-92db-f1762bdb02b4@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MZyK8MiGAM6ztPML"
Content-Disposition: inline
In-Reply-To: <6a3008a0-d918-4ec4-92db-f1762bdb02b4@denx.de>
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


--MZyK8MiGAM6ztPML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 11:35:30AM +0100, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull this next batch of mostly Marvell related patches:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--MZyK8MiGAM6ztPML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXnHc8ACgkQFHw5/5Y0
tyyicQv/ZECbmIoLs+GY7aTTmG+whcwRPnxPPW3Aovd5km1HRURFoK5bFYAsBmT8
YOPpsfu0uZpf0nse5R65rH/bLlBb3senh0V7AEueZr+Y8JMHuzjTz80daNrGxZZy
OJcIFhLDB4z9DvOdh+VTTBhq9e1mTLDy4FyzITyaBMvYP63lMhsyfWbs+5XepGPB
0Aeo3mjfVdZZEST2b3dM2qL5gsOVgMN4NltsriLiGIo2Fh2oEC/YvZHiTWI04GFV
AAntgmIZp9bRiYnrLQkI8oczLLN1inT/9csGAxEtCrBA5Dt2lQ/j+ac02ocTl8sB
h0rBCdGc1z/q1HEuXj9JVXkOTUjkSUhqUGA6JLgM3N4MR9QwfaQc9Y9jCib30w0J
cPCf+XPyX/RadttmJ6eOmqDU29+PCRZ5VJ1O+AN5t89atLmuMB6NSQN6//XI9xHR
1t6MFhcNUsa/HpJtvnynWNXMtePfNw50jeZYXUs9+52fxJWYfdr7Xb/Q7IhSkSNz
ALfET9Xq
=Wjjy
-----END PGP SIGNATURE-----

--MZyK8MiGAM6ztPML--
