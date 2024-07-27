Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3A5C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 01:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D612287FC7;
	Sat, 27 Jul 2024 03:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m/5Pw8w8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4FB2880D8; Sat, 27 Jul 2024 03:44:48 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2360A87F7D
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 03:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7093efbade6so526270a34.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 18:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722044685; x=1722649485; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T1Y5MwRfz4Stvo3vag3mbFgvix6HRYitvujq26ulAOs=;
 b=m/5Pw8w8i7d4XqUseRSKMNnrqlOLXOr2iJKDjbrTPza7HLRttl8Thr/48pouCUWhUY
 BP28dUnVKPryOhE2Io/OJeqccXi92GIgwl7g/j9rg8/4uoCxrImEQRZ8AgITqd1P4B0G
 OkqrWw4Qp/IjecO67c/sUaygWOrPYufvd8rZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722044685; x=1722649485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1Y5MwRfz4Stvo3vag3mbFgvix6HRYitvujq26ulAOs=;
 b=MgXnDq9TYkbQhMW9Tune4eliybM4Zzl8iWmdMt7l2HAo3HZXWt7SUvFl8IYxVhHT9j
 vb5Cewuvjgl4VlhHRHrytC+aHgl8Hqj5IBvIwDvMy7aC8g7oTMjmTkPXmeD4g/HxKXCd
 788Bq/2IbvT+k1srN0bKU0e9JdhSKKBr3Th0qTFbb0jqNxPEnCwmB21iQKTIsnt7FaRh
 FLiY/1ISLNUvW+MzFcimLRSrNJDk8fW6YflewCl2bG6VYIjpuFvt+iUMbFezFezUz+K5
 iQXpINPK79WGHMfVU79oSxrpKmxAnbRTacIpD08DVtLkIyl0g1R7MgJXMg6mxJ0NCSZT
 yoYQ==
X-Gm-Message-State: AOJu0YzjLOrVKdPl5lMHfbEVu2D6cPCf/oCFwxiV5zbPtU+ZLM8rOzva
 YYaSUF8st0APDdXUGjR1wGjeiXaU+LPAT3tOi4O980nbX7QdhKYPVqkn5l+DJjo=
X-Google-Smtp-Source: AGHT+IG4Kj1yNCzeY3Gj1vriB+pTekgz9Crd/hCCSeD02GQab2RCrwdTCI6+1oky2FQoFUv5O0O+RQ==
X-Received: by 2002:a05:6830:6381:b0:704:4563:b66a with SMTP id
 46e09a7af769-70940c03fd9mr2146631a34.4.1722044684849; 
 Fri, 26 Jul 2024 18:44:44 -0700 (PDT)
Received: from bill-the-cat ([2806:370:561e:3de8:7a74:316b:e427:1809])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70930778280sm1022378a34.64.2024.07.26.18.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 18:44:44 -0700 (PDT)
Date: Fri, 26 Jul 2024 19:44:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm
Message-ID: <20240727014440.GK989285@bill-the-cat>
References: <CAFLszThGWecZAzEEzopkCbJF36R_gPoFcJFu-qh-BqL2eUiSGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6OH6+TnzmY/ZfM8G"
Content-Disposition: inline
In-Reply-To: <CAFLszThGWecZAzEEzopkCbJF36R_gPoFcJFu-qh-BqL2eUiSGw@mail.gmail.com>
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


--6OH6+TnzmY/ZfM8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 08:54:50AM -0600, Simon Glass wrote:

> Hi Tom,
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/21781
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D65&view=
=3Dresults
>=20
> The following changes since commit f4e163ece454bcf949a9b2005de3b70392ca05=
d1:
>=20
>   Merge branch 'qcom-main' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-snapdragon (2024-07-26
> 07:49:36 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-pull-26jul24
>=20
> for you to fetch changes up to e8effc385496d76a6cbaf9683dfede96ac634f72:
>=20
>   buildman: Show board list with -x (2024-07-26 08:01:06 -0600)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--6OH6+TnzmY/ZfM8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmakUQUACgkQFHw5/5Y0
tyzt8Av+JWiwEqDqjZSiH1DAZRe2Tv8Z6R1sZAyC9PKkF7YjHe/4fOxghnFdbJuU
ikfa/Ipf6utqD/QL6OnJmrOdI61EmxRkL7JtCX11IZ4z86siiUlP+kk1TTlInVDJ
ia8Uc4zH0me9mW7iKJBS3ulfPbiwJivRMWpw4y4NcezVhwwsQE+i1q3/MSr9Y0Ug
BwtnhgKHyX89ulK+qbCnoW2UHptCJMqUt9QwAjlPD4BBJBcLzWzV4+LhZzabx1MQ
G+tSMfauPV0fOqZvp/DTQLecOot06ywodAdi+eLz3gxymmHfpnhridO894pCSro7
AoHFdXeZCCljroatjeySQnQziT4vwPOuGEM6dYaWqfsMWMvIRtEf+e3jKAXJLeur
OKw2d5xNinEnHjMgziyXaxLehgEtuqT+mz6Z+bE3T6DnZknUhOk3EZul7pNube9I
mkRjV5rO9Iw/lqUw2nHQUPXOwLQsYvklaGvg/YOXezWARRGS1lHPACsk6JHG1l51
URC88I93
=UoI3
-----END PGP SIGNATURE-----

--6OH6+TnzmY/ZfM8G--
