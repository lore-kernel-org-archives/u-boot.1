Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E58EE4981
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 16:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DC6283F7F;
	Tue, 30 Dec 2025 17:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ClrADvad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F21383F82; Tue, 30 Dec 2025 17:09:43 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A3F83F69
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 17:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c7545310b8so4994026a34.1
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 08:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767110980; x=1767715780; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vSzvQwF0fg0ISF+Gcd5htUz6K3HQqvtChOwT4nb3kKI=;
 b=ClrADvad3uhe3Cxnl3m6SLsiBouwSCJxf9Wj5k12ut9Vhr1JphVm9RXq64XQNZcZ8M
 RHh4UNEYd4lstPbAmTv2I0pAwC0UR+o6dVuDTL9Ms+vBp5QRr6EDpXnmpyhJlG5MomUV
 65BQZr6plbCx7QrIuJQA/2D67CHP0AOnzh2tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767110980; x=1767715780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vSzvQwF0fg0ISF+Gcd5htUz6K3HQqvtChOwT4nb3kKI=;
 b=e0mNDKCO+sySdxiteWclM4Bd4b+/ZZ9QXSWsnIJm2xsA40tDDm4RJ9LUJxJrOxhLMH
 g2q31vJyDQa35oQN9NQAfvZxRThhF7PL6hMWe+hMFotCQqH5wLCsJfzxhrRyM6msHZLP
 TLaEqVH3BlHxfUOwdfpKYhZoM5cf8efW1xvYF0znP6PSV6w42bvcWUm54PvuM0FjMTO9
 E3ppD79is1v9ahiIJtbVxEP3Xn/lwbnoJVIZXeLYLSFUCGu8Qx/edSkf7qwjqASIXoSW
 Yij1erVo+ofUpbDqseX6ILeGuU9L3dlJDJWfC6jfp4F9PWOxLah/O02ehUhyCcX87MeZ
 EM/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn5I+nVmOE4DogmFZWIsXR3Er6U0OIz2Viz/DgpHcpE40XRpW5bYdBtnQUTuGthTvY2aJHmY0=@lists.denx.de
X-Gm-Message-State: AOJu0YxzvBOJIsaB9i1GX2oPQfm7/Me4CKtZu4HPcUjAQg8SjE7DecGA
 8OCJksOaUi56fwoQrXFAX1ectdEsBzfJSjXMd5MvNemQGSiRBYiKpnA2Q5jqAGb9DUU=
X-Gm-Gg: AY/fxX4J4LzoiPpUDzcnVUUkMizYkFnpvZttU8ko3TS2PEJ2Qri36QBJl2qR/jjYbE+
 CK30/O9MfDq4I5OGJKzzLYXGoI/qVtt6NrEGcT6QXClVFF+DQwwZuG86R1LjvDa01bvAyaI2row
 KBV9Se9tOoEzbpdArAAIHnII60xqBLzfMS7IaENSqgtCXuNXM72dREKlV6ib1J5/gRBnP/pqak+
 QlrrHfg4314PfPOs84q2zZgTIXbc24W58ZXadKZNsQ1bWAUnL6kf5Fls9tj4XWqLAeqtMY6hL/5
 f2t9eN4ZLMDviPdORw6HXvy+9X9bYkLywmgaLvNKoYhfUOndSuDOCI3GsWeuem+P2CyXakyEHzJ
 dt6rXONnGPkIhAb1FmR9wHeqgBkAqoC9JFB/4PS3hiR3hY50Wq5RqzDsDNV9eDgT+PaCtYqb1NV
 /vhKAWu82v7r7weqUvZkTFGJ55O1ZvK4SwNhjhCKGMQze6bEqjAu2FPTPVK6tFyDMcsVIUV/8+h
 ODpt5loBH5i2WQOgzZH09dpQZ3DhrWfCKGMp8A=
X-Google-Smtp-Source: AGHT+IEuvLD3JBF3RlnGk3WoMvn9Wi2x/BwQuc2PwDpGQoblgnWvfpZXKfnesq9mPzg1qTap1TKCzw==
X-Received: by 2002:a05:6830:719c:b0:7ca:e8bf:8c2f with SMTP id
 46e09a7af769-7cc66a36d07mr15669472a34.25.1767110975033; 
 Tue, 30 Dec 2025 08:09:35 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc66645494sm22836084a34.0.2025.12.30.08.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 08:09:34 -0800 (PST)
Date: Tue, 30 Dec 2025 10:09:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, me@ziyao.cc,
 daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 6/6] CI: Add test jobs for QEMU m68k virt machine
Message-ID: <20251230160932.GT710860@bill-the-cat>
References: <20251230160112.3045527-1-visitorckw@gmail.com>
 <20251230160112.3045527-7-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ql+Qp/P8oqShE5Jl"
Content-Disposition: inline
In-Reply-To: <20251230160112.3045527-7-visitorckw@gmail.com>
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


--ql+Qp/P8oqShE5Jl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 04:01:12PM +0000, Kuan-Wei Chiu wrote:

> Enable CI testing for the newly introduced QEMU m68k 'virt' board on
> both GitLab CI and Azure Pipelines. This ensures the new M68040
> architecture support is built and booted correctly in the emulated
> environment.
>=20
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ql+Qp/P8oqShE5Jl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVP5PAAKCRAr4qD1Cr/k
Cmn5AQDEmqrXtUAvcE1wGpWAl/wj2BIf2gTVX21wQFJ+N0k5MgEAlrERpLBUZi9D
9VAJlFgorPggHjcgnCymsitW2xd4nAI=
=TTgO
-----END PGP SIGNATURE-----

--ql+Qp/P8oqShE5Jl--
