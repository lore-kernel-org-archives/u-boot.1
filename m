Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03938D1A639
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 15:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20D8884371;
	Fri,  9 Jan 2026 16:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o85gqrPS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B02D84371; Fri,  9 Jan 2026 16:03:43 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1020884248
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 16:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c75178c05fso1718599a34.0
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 07:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767971020; x=1768575820; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bwpso2+WVjKkWF0g0WShDd+PgV60+N6KiGqGKqgilIY=;
 b=o85gqrPS2Jii4B3fwDEOkJoMNDEmq/qRImDpwqI1aulTNbeX59MjheiLGVMRW1iLjC
 t6SecenM3/9UckX0J5R9x6prY/dpqmCtYN+ngV8ijm9Si01gE98FgZ2Dn+epefsQ+BC/
 Lae6mFwzJStK2+GG59z8dp2kIb0EUXfS4xAjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767971020; x=1768575820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bwpso2+WVjKkWF0g0WShDd+PgV60+N6KiGqGKqgilIY=;
 b=vrsbbtiYXlY6CZ7fEfcqZQCmlvA+vkFjXx/x6GoQD8OJHsl+IiKfrhodI92xVYoYdQ
 reXAJxUjE4zqt5FPvX/dGdDKoRx1cqQ3LDLqmpPfkqyJmmX+Oc7GrzxRCrAHeexD4xWf
 eb5Sozp5KMLAN/89qigKjYNYbmryma5eXYTa/TZaqbn+o5Y7W0f5BvR5DXtLLcniUIjm
 jmyattzkwYQaRd2IIkbrjuxfTidOA/KZLBSRJTviZGtCjtT7MKohSH1aQXsmxdYl34CF
 o3WZUnolI8ZGBpRAxHRm+Ge/gg+4bMPVRJL3SKQm1aqVtSTAs+q/OF0/Q7oV82MpH3HK
 YQHA==
X-Gm-Message-State: AOJu0Yxhl8EwrS1YFr8UvjMCNRTi8G25/Kdcv8xG7NOncuuKDyVoq+PK
 rHrUlbwwhKHbJEYwIgD+zpSOjaeJvwZ2OQ3M2aTSaXGACrtrBI4ZsSWvRCZ0yUhfisCK/zpHRz3
 g3ZjrvQc=
X-Gm-Gg: AY/fxX6L9AIyAAPsoD+dxN4ZeBoRpAcmii9iPtAw9l0fVZ0wJbdj+r4AaGUMaCcCOut
 JIBsqJCwFvEr2MLOY5F+DH3eGR2Edjd090tkm1pzalt7T3xx7Wr28z4QOe4YdDQHvivzuP4c9Hz
 UUhfuo7LYo+Pi9nYGTVyB4L2Uxv7xiby04ZAIoQVFnGplGod0lZDP8faA2q4+IidWhiGWtOBfQb
 Ycz6YQ7cC1VLUNEQoR3l7X67DvjYJTRKuDBVXoFqYnyByrZiXf/dNqYoQUYTq063XH6c3CbmTSf
 B6G1CD2jibKxtbDG/g3YuIgolhDQTIc1Wq/8lUtH27yJMyBkV1jSJYpOIEyt92bNu+hgijWPW7K
 GoORzNG48FnwkrP3EtU2pgOB7pPEcic0NArsykcx2p9v2EwQTkpyu0528WEUz+gSYwsOaBZvIlq
 pOC5A72BSP03HBY8f7BScNYZKbNYR2rreUHDE7BF08YY342AFltq4o4pDOpYE8fghZJA9zHOJbj
 PvBeBmXCzA/RpvHlQGhb+r53KVUMxHYWFPUOUQ=
X-Google-Smtp-Source: AGHT+IHin932PJeUyJdmQugNp0G0c4BQzxXitx8Z+BC+v85tUo+ppz8ZbwdIXimOvBT9pM5myXRoGQ==
X-Received: by 2002:a05:6830:2684:b0:7ca:c803:f539 with SMTP id
 46e09a7af769-7ce50a923fbmr5912747a34.5.1767971019610; 
 Fri, 09 Jan 2026 07:03:39 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478d9c17sm7493857a34.22.2026.01.09.07.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 07:03:39 -0800 (PST)
Date: Fri, 9 Jan 2026 09:03:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Timo tp =?iso-8859-1?Q?Prei=DFl?= <t.preissl@proton.me>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3 3/4] fs: prevent integer overflow in sqfs_concat
Message-ID: <20260109150336.GB3416603@bill-the-cat>
References: <20260109112428.262793-1-t.preissl@proton.me>
 <20260109112428.262793-4-t.preissl@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lq2a5EHLQi5SLwZT"
Content-Disposition: inline
In-Reply-To: <20260109112428.262793-4-t.preissl@proton.me>
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


--lq2a5EHLQi5SLwZT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 11:24:59AM +0000, Timo tp Prei=DFl wrote:

> An integer overflow in length calculation could lead to
> under-allocation and buffer overcopy.
>=20
> Signed-off-by: Timo tp Prei=DFl <t.preissl@proton.me>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--lq2a5EHLQi5SLwZT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWEYyAAKCRAr4qD1Cr/k
CgBvAQC2hCwMASJCH+YIndoZHOeNbNn/+x72EywuN+3qoDaz4AD+JiCifz+/sWhY
Z1HfYBj4eGaAuy6FqUjULAdrnOucfQ0=
=xoOO
-----END PGP SIGNATURE-----

--lq2a5EHLQi5SLwZT--
