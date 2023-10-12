Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075B8CDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 21:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D45D386D41;
	Thu, 12 Oct 2023 23:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j+PpCU5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26FA886DD8; Thu, 12 Oct 2023 23:04:50 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D9C86D17
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 23:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7b91faf40so17599397b3.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697144624; x=1697749424; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xzlaR7lfX3aakIfj36Ja+K59YND8M7rsNrj4eFm2NIs=;
 b=j+PpCU5dL4TrRJxE+XQMt4F3ms+y8S9oiYP3uKJ3BplkP/95/6xhmO32gRgPDGCjOb
 /TIHbjGvJ7l6hqV73jAfQo4V8syWa59OYN7iDxoQegGMtAisR/6odU2umkrxHwO1OwIE
 AsL2KAdYHZvm4ic/v6vCPYmz2p03z/C69OGrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697144624; x=1697749424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xzlaR7lfX3aakIfj36Ja+K59YND8M7rsNrj4eFm2NIs=;
 b=BEqIjYkRGSSCFah8Y+ipRrmM/r4r93FjL2KcR2UqrP9O9uYca5br8uySgZPz4o4FLj
 2vlPPP3CnQaEBp27h7z64gjYmjnE4+5jLvgm/890Ym9/FC0vxlmcNnj9bGp8LGCx1HMz
 2u32KwgpbZiKsczjCvD34Jw/UIVIHZd3bxXDox95Dg6z4C3T2wcHV7STl5ksdn9XweyV
 QYwQ0pf06n7eGvtL0DmnZeWxG0IJG57GeLKDjto81wyJ8QzVzO8gTg0WYL24dGV6XHzv
 BfHt7Kmez8sG4BhHz6UeI6i4bv9KvpIiQKwxVa6p6eE9YUcGNVnDrt2QBAQqPjVYar+K
 NA5g==
X-Gm-Message-State: AOJu0Ywy2m7jqsUEczAZ2a0alrA7LaCjQyPbW0mqpVH8A+0/35NJJfDr
 lMCFFIAkS8+ug2Nos8RcyxWWZ93WJewJKazk8U6KYQ==
X-Google-Smtp-Source: AGHT+IERkx3XlXfx7CqLP8ft8QdIBIV9ZnFLzs8S4Wx+cVVnu0r8FKDx3NVJ63bVgAEuIHaZoQylTw==
X-Received: by 2002:a0d:d990:0:b0:5a7:bfbf:691d with SMTP id
 b138-20020a0dd990000000b005a7bfbf691dmr10602181ywe.42.1697144624271; 
 Thu, 12 Oct 2023 14:03:44 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 u74-20020a0deb4d000000b005a7ba08b2acsm230110ywe.0.2023.10.12.14.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 14:03:43 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:03:42 -0400
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, seanga2@gmail.com, u-boot@lists.denx.de,
 lukma@denx.de, bb@ti.com, Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] clk: ti: clk-sci: Notify AVS driver based upon clock rate
Message-ID: <20231012210342.GV3119521@bill-the-cat>
References: <20230921170343.3214027-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TG31qn8HiueNGsS8"
Content-Disposition: inline
In-Reply-To: <20230921170343.3214027-1-u-kumar1@ti.com>
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


--TG31qn8HiueNGsS8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 10:33:43PM +0530, Udit Kumar wrote:

> AVS driver needs to be notified before or after clock change,
> depending upon new rate is greater or less than current clock rate.
>=20
> Fixes: 1e0aa873bc7cd ("clk: clk-ti-sci: Notify AVS driver upon setting cl=
ock rate")
>=20
> Cc: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--TG31qn8HiueNGsS8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoXy0ACgkQFHw5/5Y0
tyyS1gwAnZYFBEzT47OAqzyr5eLsLEuzxWIw5Cci6oX5GSx0PY7ma454o6+rBGL3
i0dsp4Y9ppTBO786jkZ2lrhnayINMxl8KSpQ4aqAiirCirnC0fwrKNx66MKpz7bJ
9D3S7di5wQ5WeXADq1O8Ze9UwGVVBv+nZ23mQSsTe2ufWeRDi49QCRML+fff1XHx
yGNUK9jbNphgOW/z59ZyvoPvCct00BX0EnU2rKuC9BIWLjGCXj4neomu7rRV87Du
3aVqPBhMgswb2LMCn22zcpFL+sjrMCDvMl9ftWvgB0m8R+oAKm6QVdHqFg4ZBNF3
fmXZuxuVSJnUNZ0wZ1pNSIAoxKYO0j08N/pGUHfOrmDIpKmGIS5aDCF9T5ZvVRkH
8zZT5sn82M7r4/lzST33hrZBdYbdtVAP3EKAm9UnguFz+Jop/lL3M2Uu7OC5VW1l
/d3E8iWusenPZyY+Cm8sCO4XpwKWncLk6txOhVKH6MaodqfFWq1H7QXgp77qIt2P
9jA+sKMt
=giOW
-----END PGP SIGNATURE-----

--TG31qn8HiueNGsS8--
