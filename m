Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405A4C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 22:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83E4E87670;
	Tue,  7 Nov 2023 23:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rWkFbAKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BD4287675; Tue,  7 Nov 2023 23:38:44 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55C088761A
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 23:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1f04c5ed8d7so3629123fac.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 14:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699396721; x=1700001521; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K2vQcQY5/0DH1U640qMitRHIC2nYs9cToQnqwzbEQ1g=;
 b=rWkFbAKZ0GxzSqoxVBmpswOSrHv8gdSnUBRjjI/to7isLXss/3XMNPmg57Ly9YIxVe
 4D2JBTqe4dSr8Gmgr1PKomTW71TwISp5fbZZ63ieXTJWjc+ycq8Pctq5jAe3CgZLPPJk
 JaQXRShMf2iKmt5gzRd482HXJCeGNvfaEHXOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699396721; x=1700001521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K2vQcQY5/0DH1U640qMitRHIC2nYs9cToQnqwzbEQ1g=;
 b=epuMcBV/oyNm5GMcOYbgx98dU2LLru6lQDVz6eHoEZ0rD9AhaC9x7bzSD63VNJ+wXK
 YEQUto1//QHTS8G1uaYskxVzPqoaaUfYQYxKE9ffTLvjmHFn1pU0O8N7IVaEIrrPb8GX
 nfoizuB8F02+5Vi324ixqXyu4g38jIS5B0/QwrhKdT3wr99WbBf09cAqod0g7K4Myb6d
 bwt7odQsnN2tWz8XcURhTe0/WnuC8yDhgUDiW3mqWFfIG/vgJtCLHpB3i3AgG4TLwj9o
 xwr6zJ2JmwtDWdqJTIKIJoPgmr9WDS6Y9r/CStddw9skglFsixHvSzOd3vFMDYQNTION
 TBLQ==
X-Gm-Message-State: AOJu0YwGG8X30K2AVO+kzas1F/OBvGwXsqhtAyUU5iaFXj8tE3TBs8sh
 bhEetK5u9VpetWQR23Dmf0FMSw==
X-Google-Smtp-Source: AGHT+IH0yAQfZeV0mfsW0r7EqXeCFJlx78m7nWTEzWxreVpl0N6sviHvJ3pbAiLzh3NYvAVA4sHcPQ==
X-Received: by 2002:a05:6871:14e:b0:1ef:bd6e:f4c6 with SMTP id
 z14-20020a056871014e00b001efbd6ef4c6mr60934oab.41.1699396720987; 
 Tue, 07 Nov 2023 14:38:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 s1-20020a05687090c100b001e578de89cesm64792oab.37.2023.11.07.14.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 14:38:40 -0800 (PST)
Date: Tue, 7 Nov 2023 17:38:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231107223837.GU6601@bill-the-cat>
References: <20231104171212.3d041a4f@slackpad.lan>
 <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106204608.GJ496310@bill-the-cat>
 <CAPnjgZ28HskiFDBDa=s_k6=WNoPfWu88bAaYCY7ew8dcYXW=aQ@mail.gmail.com>
 <20231107193025.GN6601@bill-the-cat>
 <CAL_JsqKkjPyVUxjANC3_rOkEAyNUBY_mXf27N6U++KTpujYYLQ@mail.gmail.com>
 <20231107221023.GS6601@bill-the-cat>
 <20231107-flyaway-arguable-0bccc778b256@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FwfiM+0dy0tgfYEd"
Content-Disposition: inline
In-Reply-To: <20231107-flyaway-arguable-0bccc778b256@spud>
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


--FwfiM+0dy0tgfYEd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 10:27:50PM +0000, Conor Dooley wrote:
> On Tue, Nov 07, 2023 at 05:10:23PM -0500, Tom Rini wrote:
>=20
>=20
> > further clarify or not
> > the RISC-V ISA thing that's elsewhere in this thread (and part of the
> > kernel, not a U-Boot thing).
>=20
> TBH, this a bit fragmented across threads, and as someone that hasn't
> been following it it's a bit difficult to tell exactly what is being
> asked for. Would someone be able to ask it as a direct question?

Sorry for being unclear, and thanks for asking. What I think the U-Boot
community would like to know is, what is the device-tree based way to
know if a RISC-V platform has the Zbb extensions and so the RNG opcodes,
similar (in concept at least?) to the ARMv8.5 RNG feature.

--=20
Tom

--FwfiM+0dy0tgfYEd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKvG0ACgkQFHw5/5Y0
tyy84Av/R9dzL87JSCp10MOwtvcWUbpHIC46v4UkzjsJ5PNCqsoaldwr7l5D5HGc
RWwtnhg9+JckVVuQfL0Ws/5gi66Ix/KT7XSyaUQycLqpDGwH7rC6XS+ldAWkFFAE
pno0AqW/G8vIrPJp/3t5XYa8Oj2x/x7oAHcHUOiV56lL9J6vLmfKz/zWPevES/7P
FoCS2EzqYCyvkYP8ZpMg5GoWtY1/fpAiT1xUBXsa18YKnKj9RkLx0BbkU78b5OIt
T4+qn708C934Lav1C1bJ2ftM55NelhwasYynK7TpA6BEqLef0iJDB46vZJK3aXoD
w/xcB1aKGcjA/BtsdXWJepRu/MQzzM3LLxc6l2QIQEvEPAjDQVqqBb+8xYnlqtpB
z81cU37WxpaUAOUMfcc0JpelKY9+yjyH1hVOgraM6GrWALl4hxtNHSSycmF+OUC/
RLcbr96/EAnJjWweFD6mEplupAin0oOryciaRHfAZEf4PLjA0rkOdo4mdnUcGXBk
KRsZ2B/L
=xxK/
-----END PGP SIGNATURE-----

--FwfiM+0dy0tgfYEd--
