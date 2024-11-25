Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78206D59D64
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 23:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8489894DE;
	Mon, 25 Nov 2024 23:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OjseK7vc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EE1A899F1; Mon, 25 Nov 2024 23:59:52 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82FF0885F4
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 23:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b66402d0b0so118031385a.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 14:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732575589; x=1733180389; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pOA3EClvru0kn42IwLKblg0QzOlPsDO983bTHuZgLo0=;
 b=OjseK7vcgt7CZCgOSGo5vadpY/ESEDN3pjNB5GC71IDayRfBokNOtde3XuOZyPCPCq
 E6FwFZMHQkH3SVyl3a8X7cM+Ov94TmXhMMtCZm+qRcVf0DRRwwBtA1h9rAsCFw2OViDn
 sJnVmyDy4F5nqKWsNCxY41B5HHRkv4/jz4eiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732575589; x=1733180389;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pOA3EClvru0kn42IwLKblg0QzOlPsDO983bTHuZgLo0=;
 b=R0A7neho/71+TUGwrzMgQ8EWJwGC+p+dDgN2xTePsmoRx8tdzwRdvCEokt4jpQTUCi
 crPE0NkUQ8CwVPuk+cmfnA+23IG2uypRWpMnJ9Wu2Q4XQMSxGzZ7hgWOc09xAO9HIKNk
 0M7Ws3Up/DNIxd4EMCRRYSVeaXXLUv8Ft8rVxUeQjPz7cJMLvIU0XPi1Jfra+GPFjguA
 A8O4HUBjPqY3nQ5P0AyLFr6v8+i/CFPprrdvyFG/2GrIRUYf3VvhmfclDEoQ7GrKa3WP
 PKVJ5WAnKTUzFTZEiYb8HjZp4SNlS8FKqAXBtML92xapLlj/0MveJI+Iz7q66t2iYjll
 M00w==
X-Gm-Message-State: AOJu0YxBstsI79ASl1JMqeBnFGley4FAuUI6Rz0YmGCRblM7QQ5lJcCm
 vOiYKDF3Qz115FliuOICQmAcnYVzZdsjyq9LcnuWFw2FudS00TwAOSRPB1Q0IKY=
X-Gm-Gg: ASbGncuHRu00uHx9/maO2WpuwyreMn6uxQyVxqQA18czm94tqkGVUYWXNgmvLtv2EbK
 ywRtBJwjcUU8KR513Rd2qSllieIo3eSn0XXGNCYt8MM06ZMI5ADNDkzP0WsOcuxfpM1t8VAHnEf
 WZk3BBx5UIHLqxtdIDPTZOs4DIKFN89eaU1DZMEGtYrlp7S++qFC3O+pRDcEtcbt1kogH+y2mY8
 c/InmPVrENFzR9xt90GmSm2cUlx/AD9erTFfYkuVuSCO8Ep4Q==
X-Google-Smtp-Source: AGHT+IHV2V+95/71Epp3R7huuJkmc7TubBEGGrEY5SKlGWvrVdEISdXddljSGCl6jTABNEbELeXBMg==
X-Received: by 2002:a05:620a:2889:b0:7ac:d673:2057 with SMTP id
 af79cd13be357-7b5144ba7bdmr1880903785a.13.1732575589337; 
 Mon, 25 Nov 2024 14:59:49 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b66b5a5dfdsm156604385a.99.2024.11.25.14.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 14:59:48 -0800 (PST)
Date: Mon, 25 Nov 2024 16:59:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Khoa Hoang <admin@khoahoang.com>
Subject: Re: [PULL] u-boot-usb/master-asix
Message-ID: <20241125225946.GO3600562@bill-the-cat>
References: <20241125204117.18423-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wLuNFr7aribNKXZQ"
Content-Disposition: inline
In-Reply-To: <20241125204117.18423-1-marex@denx.de>
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


--wLuNFr7aribNKXZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 09:41:04PM +0100, Marek Vasut wrote:

> The following changes since commit 52c0e5f8a39ef022ee5ab2dfd67661d1d34941=
c7:
>=20
>   Merge branch '2024-11-22-assorted-fixes' (2024-11-22 15:04:54 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master-asix
>=20
> for you to fetch changes up to 05278af8b3df1c0c02e345ccf4c8c59bd0111f68:
>=20
>   eth: asix88179: packet drop when receiving large fragmented packets (20=
24-11-25 19:11:19 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--wLuNFr7aribNKXZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdFAWIACgkQFHw5/5Y0
tyx9jQv9FKx47+uM00U584fbchK0ri5dWPMW/rublHIhHupBHhEXEIJO0VccrLEf
auPne78+5s6RF0X+32AZRf741hrr5eihIbKcZwp6MMqnHbaupMYqLjk7lHSxjCDn
lXSxzT9uwZ+sjI9G4irQJ4LjYXzi1p8/DyZ02x9pSf4ShDsxNf94GAVoJqT7meeP
Ugp/G9ma0FTMnVMw7I9+Z5IB+wX+veey1OEtRXFkqOo6Dvw4b6AvPwLS9tU/MdMO
X584y9IO7X1KEIajmlmXlOgO97iwpkvU48oXj40/h8Lr9Xq+MuhlkYPnfqHAes1m
+a5Zd2f9b/nbrqqwnheNf2X1MBBrhwTh6XmuEERnq0jRuHRwcpR3g9sINaniznEI
BiW6wld0cQD+B/yQzzvwplkHYAkKMapW9yD/1DmgOT+Oaw1H6kdy7Xk2f53Kafd0
AY02TdxFrXrL0Ef6h+wfXNtV7sTqQHdBTrRbVsfPQcT1dZDzLga8qFv0an17giEd
6UgaV7DF
=taoy
-----END PGP SIGNATURE-----

--wLuNFr7aribNKXZQ--
