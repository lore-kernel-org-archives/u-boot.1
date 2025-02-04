Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595C3C0219C
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 22:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A65801BE;
	Tue,  4 Feb 2025 23:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GJvjVwb8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 961FD801DE; Tue,  4 Feb 2025 23:18:48 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF98C800B3
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 23:18:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-71df1f45b0cso133519a34.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 14:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738707523; x=1739312323; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kAVx7CXg95BZ6eiURLYA6UVVv0re/14N7VFOCbaf438=;
 b=GJvjVwb8OGpfs4xsMMZ1V6p1Yiw2qX6+8q+Xn0QJBH3S4Ababte/aSD0sziHsPtSIE
 Oif1aVxcN5XwnaCnyKzE8Skh319TjeDFspBM5ODRVcK4KVm2VCAW9hDopOzD3MyZ8MR6
 xRpEnfBe6wnV3j2fLCqy8TV7iOuIwiYqMGuKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738707523; x=1739312323;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kAVx7CXg95BZ6eiURLYA6UVVv0re/14N7VFOCbaf438=;
 b=tKzGoeOOzMYX4sfifn1QDUjP1MxP/8nVuq4Yb/W8s16KxgFEY3OUGVgjH3jt0PfRBs
 luoK+lKNUJljBzXlZeUNrVS7ylKS/NUUS8eMMFy0zs9o8LP4qc9ARPO+DSSfFV0ExNtn
 bqKmbMLAKnP1MCRuq3CD+UKvoVpjGhCY7SfOrGtAMwdpwXOGK8rt1BkYkwfIOdvxTNVY
 gWpx2qq1+LhpqQJuqv9C7sGh+3PZuz5gLwiZ5/X+3uydi9PAxAaT7E+Sr1aORQV0lkuX
 CXehv5Llih/hhCyOmV1nE0yg+1enE4npd9jpTsGnvI6KhIqn0MxgctdsEKoWmqL8uMbR
 UE+A==
X-Gm-Message-State: AOJu0YyszxIFs6V7/A5nA9KPX38Bzak+Icf5WbPW+eFt4upd3Csft/ZR
 C6GKFBpIcklwxVNNv5/Op7OCc7QeBwtLMn6J/Dv5G0R5ZCZNQVHnxZd/sNGVx4t3JPckWr2Mtji
 jQyY=
X-Gm-Gg: ASbGncsA9rlHWnj7bqJM42oZO2ceAkaJZp+IrsRM8azvX3EIcWaeu8ftOPPGmyzsdBW
 5EdeRUhFuzUL6O0B6/Y/mm/0yx98XlnQd6M5WE5YsBSuZet/uzTfbZ6e/wLRcBxj64pLJuGcONk
 xNEtboQ3M1plUL1zXh12FwSRtTny5FYlWePPVqK++LTUdfOWEIqt/Rt9zLDBbroFD+Se7h3sLyg
 eU0iTP4dOXoK3FC2x2Nui32ix/wgU5AALISzQ/UySRKNCc8kZOsWIIBzd48qFC/iLNmO6SnXbl4
 aqsqa/7AzElkJ3E=
X-Google-Smtp-Source: AGHT+IHZhuK2DWQmcjubzb+RYoXI5BB7MYMjlInb+X6fGoRi/6bWt7loUAsxxmVzOQ9dL5CprgbnTg==
X-Received: by 2002:a05:6870:9690:b0:29d:c9f6:efdc with SMTP id
 586e51a60fabf-2b804a75d61mr472764fac.17.1738707523605; 
 Tue, 04 Feb 2025 14:18:43 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b3561a66e6sm4290748fac.16.2025.02.04.14.18.41
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 14:18:42 -0800 (PST)
Date: Tue, 4 Feb 2025 16:18:40 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: U-Boot community meeting @ Tue Feb 11, 2025 9am - 10am (CST)
 (u-boot@lists.denx.de)
Message-ID: <20250204221840.GJ1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YGht5G89lrVkTMYm"
Content-Disposition: inline
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


--YGht5G89lrVkTMYm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

I've edited the calendar entry for the previous community meeting to be
recurring and so here again are the details:

> U-Boot community meeting
> Tuesday Jan 28, 2025 =E2=8B=85 9am =E2=80=93 10am
> Central Standard Time - Bah=C3=ADa de Banderas
>=20
> Join with Google Meet
> https://meet.google.com/btj-wgcg-euw?hs=3D224
>=20
>=20
> =09
> Join by phone
> (US) +1 224-585-7864
> PIN: 107799403
>=20
> More phone numbers
> https://tel.meet/btj-wgcg-euw?pin=3D1307528552322&hs=3D0
>=20
>=20
> U-Boot community meeting
>=20
> Guests
> u-boot@lists.denx.de
> View all guest info https://calendar.google.com/calendar/event?action=3DV=
IEW&eid=3DN280N2tlcXE3aDVtbjlicnNkcm82YnA1bDAgdS1ib290QGxpc3RzLmRlbnguZGU&t=
ok=3DOTAjODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjBhYmQxMWMxYjgzNjA2MWFlMD=
ZjMWM3ZGJjZDE4ZGY0MUBncm91cC5jYWxlbmRhci5nb29nbGUuY29tNmU1M2I5ZWI3N2M5MmQwZ=
DQxOTczYzg4NzZmMjYxMDZkZTlkZjBmYg&ctz=3DAmerica%2FBahia_Banderas&hl=3Den&es=
=3D0

--=20
Tom
--YGht5G89lrVkTMYm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeikjgACgkQFHw5/5Y0
tyzQvQv/W/02HJMSTe+pAJmaHCB56b9BGQk0deyr8SMJqCywgUeqmpjVHMkSX1eV
JY/0JfNnM+9EurHnD8cacVrAcxZmtL2DwwwuhbQ07GuLX42MfM3+EOVC7Frz13qm
P7KC/z39BMLNpakmZqmrvFKlHq+x4D8qhre6VtPCtcdVAwroLm438v9EPx3czPoV
Yl54RjXjtNb7M0MkhrI6hOo589jqNBpeDe4qC2kwK2EL0eJS491TbwNU9pQwfN3b
cbeZmTFaVAzft8HVYXcvJZ2GMYmncj92mddeqZcflKofJXdkFTutOJur9Sr3SiU8
q0no9aLFVa0y+8YzbdQ4f7qeyK1LcUFm0dqk9EqqCGIhwqNnqByf20p4zihi/qBh
LQDKKnZwuhRDG3VXQw+I0j0AXjSsUbb012HOI62WzmpmV31ZbniOf8SQW5cC/Yct
dQI0E6pvw7Ikbtc0fnZKjPEdwH6calxA6WD74b1IKQtDZzjfauwT5A5SIWz6k4Ll
sq2HKmGq
=Y/oh
-----END PGP SIGNATURE-----

--YGht5G89lrVkTMYm--
