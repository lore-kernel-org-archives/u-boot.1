Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC537C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 14:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF304881EA;
	Mon, 27 May 2024 16:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZKFMGoql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B15D8824B; Mon, 27 May 2024 16:55:54 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7EAD87DEA
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 16:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6ab9d9c34faso13872556d6.3
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716821750; x=1717426550; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MD9Yc6NwEDvb7haLfsNcrLgrWgZ5cFfnkV3Xpe3F4S0=;
 b=ZKFMGoqlTDYAej+DQ5DWNSmXyOUIngJi+e8I4vo5LB3CPqxdMIZ+BG0TuwLwL9z04V
 FGifrW5bh67W5kTxsSdWXSTDVxIc6fb/ttOT+mZo+VoDAkH99ddyCmwP0PWVcRb/I55D
 a+Rq6xuuP64YLpB6FxgkE5uPFa+ncUzdIMbUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716821750; x=1717426550;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MD9Yc6NwEDvb7haLfsNcrLgrWgZ5cFfnkV3Xpe3F4S0=;
 b=CC5g39iZo/PP+xY3Vz5XSKdD5aFzM3l5f5xiaC/jeAEsIb2fEycIUw8fp0Ne6K0vph
 8g1IiJlVMVNll4fxumRedrQPW2rVnVQL8cd1UmDxf7Dvg5WGT164DuIibG3F+Rol/Ltx
 ouujIAYIVs71H8BiEtPUMJiwUKqECXA89G5MRMEhfF5qIoOlpBubD8rEqAdqpouaagNd
 Y1T/dlNqg06J5dsgURU61CK7Dw9KjMdeegMR3CsZ9v4SgpTeG+mRQ6e9e0mZXy0ztqdM
 NVz0QJG+w5wspWIsobhs9pt3dt3WjvKwWcVI1FM6XpvOee1d1h0lR149OPtb9IeCL2Qd
 FcrQ==
X-Gm-Message-State: AOJu0YzD7Xmzcz9eC3w1/06+FQJcV3EYJsony8GbDn/4N58QllYWWyoX
 68c0uumG3FxSrD/6gDP2nX5t+HgdCPnltiHhFtHc/Y7gzlCr1suw0ZzW54gJKfoSEUxCY4G9qkQ
 9
X-Google-Smtp-Source: AGHT+IEcJAlEO80miW4oiupfveLpMNgNy0ezV5PgZuV8sSvnaS7VGmI0tPaG0BVaZe6gjUw6rNsLFw==
X-Received: by 2002:a05:6214:44a0:b0:6ad:7af0:e37a with SMTP id
 6a1803df08f44-6ad7af0e98fmr42964826d6.6.1716821750564; 
 Mon, 27 May 2024 07:55:50 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ad8040edc2sm11180376d6.12.2024.05.27.07.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 07:55:50 -0700 (PDT)
Date: Mon, 27 May 2024 08:55:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20240525
Message-ID: <20240527145547.GF2568172@bill-the-cat>
References: <20240525033251.1418456-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PuJevaWDc2qI4njM"
Content-Disposition: inline
In-Reply-To: <20240525033251.1418456-1-kever.yang@rock-chips.com>
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


--PuJevaWDc2qI4njM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 11:32:51AM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the updates for rockchip platform:
> - new board: rk3566 Powkiddy X55, rk3588s Indiedroid Nova;
> - rv1126 migrate to OF_UPSTREAM;
> - Fix for px30 ringneck board;
> - Fix for rk3588 SPLL clock init;
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/20844
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit a7f0154c412859323396111dd0c09dbafbc153=
cb:
>=20
>   Prepare v2024.07-rc3 (2024-05-20 10:05:16 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20240525
>=20
> for you to fetch changes up to 5c7caa95982c481cc0d6a0e9997629afb0d2ce10:
>=20
>   board: rockchip: Add Indiedroid Nova (2024-05-25 10:28:19 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--PuJevaWDc2qI4njM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZUnvAACgkQFHw5/5Y0
tyw2EgwAkRGc69AFRkN+odXSB0SSa2R/kqdTRuh+Z98HawIK/kq5vUJ+KtYehO99
25AeVZGxAYt97XvThgEDUG+g/dCswf9/3xLDD4NO4znDyt5aRk/7eZ8yWmunWkBb
zq01HZKkReaIXWrgGF5WQNFRMTKEhSMlJ18S41F3HSBvRubo9f7UtBxfS11M875e
PwI+gqphuKpcllPlUEMCrV8OR6KRUWJGn5G7wH5kTacVpyR3gaXsQ8EJf0dDbztk
8ttOoChWM8+5syBnxeOj6wP+Z6DNbVqlAo0j1PQ382rG8AmKO3u60jzI3p6OJnv+
pLbXf1CAgBHqPsLzkqR5Lb+L0H56MJKhlhIb9mFGePLMcKdWT976z2/HeemBhRbH
/UI9GVxGltRHLU1Uwuvnj6WDl9gLuw/lQuKAqI2mc/xdtNrm0WTFVDyeC1b3Qtu7
Yz/mtM7mZDgmlUeSjJr027QXHyZ0jc6XjXb4qIq1Ow32KskOQ5BBl2unLX/F4qiG
FKu7sQXj
=A5oF
-----END PGP SIGNATURE-----

--PuJevaWDc2qI4njM--
