Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC788E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 22:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1330B8021A;
	Tue, 31 Dec 2024 23:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UdTVrElZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DD268021D; Tue, 31 Dec 2024 23:51:40 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5F280196
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 23:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b6e5c74cb7so727007585a.2
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 14:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735685497; x=1736290297; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tm2Qj6xlxtRKrKe53CcV0wvvRKy6odMMY0DWtrDTdZQ=;
 b=UdTVrElZTrvZUXhOkZFjad3pldl4mZyhnvEy7/TaV1yw4bdIb80CuF2Zu9d3EOynZo
 rlhc3wfiFmElmkY3+PhSn5ydCW+/bfU8kNe/+k98Dd1d+6yykLtKdkyc5gpv0O434l+Z
 nWo+UxRipyt6yzrqOtndc2XRSdNuAZcW3bw3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735685497; x=1736290297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tm2Qj6xlxtRKrKe53CcV0wvvRKy6odMMY0DWtrDTdZQ=;
 b=TG2GOcZTzalRA/GvWzir+9jR2I3HKgkZq9gc+VgJYjs9URmnYdnQia7C6itVLmatns
 2Oew11P/bP/MiIKIdu21fwK9ReKnl6vSYnf3mutqDRm7w5QL/DDy4LWCj8pRjrcHAGyt
 ajg+6j1G+aKfvLP/Jfb2FDrx81aNNYlatWB1F6nWZDokj3LzmHL234ljZL8kBxxTogEs
 ZwxSy0J7R72OEeiYTHv0hgMkzgk8eh45YCceN/GTEiN8uplS5Hg/s7WHVBbzUVs2aDz5
 JP4kK4UFgNU0kcFdNWDX1IhmdKO3FZVCAsEe9CzfC3yik1xdmk+xmm+r9cRiCh1afIxe
 Gkww==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3JjGJwp5qHS6KDmGARk5Z7mqLs4PuHMuh15xgOtpOHtK0aPVqC4YuscVgRRtcmDT/YLWesCs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9Yn1SCJyA/w4eEeTlU4A2lwuKn5U1vpL6yk9bYTUokyWAmjVq
 A2+yC+6VtshwiyvAOpRPEYM6ogUY996cfPS0IzIVymRaKSR6Ya7DfQdQ9sY8JVU=
X-Gm-Gg: ASbGncu6LiO5sT+mc+mSBMdaAbPpKQhPpcQyqdEfswyVFTavX7vNec+nub3ATHoay/x
 z+Ww50LGVRWgmuJ4xTLav6wA1WubdxciAKzbueLe+OK+B+wojDRsQ6AgPgpXZBDVBH/vo/ZLD/j
 BA1qDGKICmhWkiyIpS6SUaCFxUIPL82D57O98THzwoBmOTKSaEoMjHIpWDjAJTy9ftnnrv+cxPx
 I/A2jdXiLu5Bwhjvg8UfBFUm3aNC+6SY0OoPmhtbAHmeIjMuUnt2mZxvQ==
X-Google-Smtp-Source: AGHT+IFv75D/Csw1bEPem7JKE9Il6r6lTBIwyVjYjGu2kjWb3+d/6MLHeC6F/FdUjz/icMekezldLw==
X-Received: by 2002:a05:620a:8006:b0:7b6:e9ba:2853 with SMTP id
 af79cd13be357-7b9ba7bc17amr7151195685a.35.1735685496891; 
 Tue, 31 Dec 2024 14:51:36 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb1760fsm119899771cf.71.2024.12.31.14.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 14:51:35 -0800 (PST)
Date: Tue, 31 Dec 2024 16:51:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, u-kumar1@ti.com, bb@ti.com,
 m-chawdhry@ti.com, vaishnav.a@ti.com, j-choudhary@ti.com,
 u-boot@lists.denx.de, w.egorov@phytec.de, n-francis@ti.com
Subject: Re: [PATCH v5 9/9] board: ti: Pull redundant DDR functions to a
 common location and Fixup DDR size when ECC is enabled
Message-ID: <20241231225131.GA494453@bill-the-cat>
References: <20241213103129.332246-1-s-k6@ti.com>
 <20241213103129.332246-10-s-k6@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PZWfZ3R3lcn6Akyy"
Content-Disposition: inline
In-Reply-To: <20241213103129.332246-10-s-k6@ti.com>
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


--PZWfZ3R3lcn6Akyy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 04:01:29PM +0530, Santhosh Kumar K wrote:

> As there are few redundant functions in board/ti/*/evm.c files, pull
> them to a common location of access to reuse and include the common file
> to access the functions.
>=20
> Call k3-ddrss driver through fixup_ddr_driver_for_ecc() to fixup the
> device tree and resize the available amount of DDR, if ECC is enabled.
> Otherwise, fixup the device tree using the regular
> fdt_fixup_memory_banks().
>=20
> Also call dram_init_banksize() after every call to
> fixup_ddr_driver_for_ecc() is made so that gd->bd is populated
> correctly.
>=20
> Ensure that fixup_ddr_driver_for_ecc() is agnostic to the number of DDR
> controllers present.
>=20
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>

This causes a failure to build on current next on j722s_evm_a53 so
please rebase and repost, thanks.

--=20
Tom

--PZWfZ3R3lcn6Akyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd0dWgACgkQFHw5/5Y0
tyz6swwApYr1L+8Gd6rpFwWRLkEGb25FbfWSORHIy4LF9hXHzuEGrdO0BtUabNt1
cX6qwyaG8QdpK205hlas+M+ZXJMO9YdyLEMqtADejHe57jfvdkH3TZAa30DUpObQ
d1oMSdbBvIOPoAz+EsWLRsQvsexYMnS37P7iZcUrubWo3akCToT0LHSvQcQLEqvi
Po+TrDmwYbCtcc8hIwlyu83kpzJUMEGVFJy83mkmSaKa/B8XI8PtcSjTuc2aAHV2
+QcVoYzWWLOMS1YI+FIVa7d2o25E7ff7+oNxPcud1hlvpQFJ7nsGV7A+Wn6IzW5I
h6RUhi4vK2ZIJduvHvdRVRv2hUbUMvein1b3RV5ZHcjfeuztjlza5kP20ylpEFOQ
eRgUD79dJCB8ueipHAWy1vpbMqFTwImcdA/9caPiZ98JcxvZR1SVsKL6Yl2dOvtj
BsjI/HDsKUYjx0kJPknO8q2/mKz3xQkYV6wIChU5lQ+zRfgHdVWd6WEgjgPPipAo
LdyFg90S
=9M0l
-----END PGP SIGNATURE-----

--PZWfZ3R3lcn6Akyy--
