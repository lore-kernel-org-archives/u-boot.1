Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B19DC54FB9
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 19:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8152D8749E;
	Fri, 17 Nov 2023 20:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J7tTYqEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A84D874B9; Fri, 17 Nov 2023 20:42:27 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A6888749E
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 20:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-66d122e0c85so12354256d6.3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 11:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700250140; x=1700854940; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3jMFcTLvnV2YM9Ca4djD1sLbZKrK46B6IozmoTsRwP4=;
 b=J7tTYqEKjJqDtDXElGULPmdqnvcf1oQXadH4PFJLGvNINslri3oJRXujNi4IycMqU0
 LLN8qDHeG9qvarpewYIYlTlkfGDAMP84OcTxAKa9MOgl89CAR9NTv8hqxEgVTtwvD7Me
 IYuctpwhGD0xdgr3eHW7foZm2Lfky5VmMuzSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700250140; x=1700854940;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jMFcTLvnV2YM9Ca4djD1sLbZKrK46B6IozmoTsRwP4=;
 b=Kcf0WNkJ5QyN9vESMfxcSy8mCBmMe7i+IyBJN7nly2gNvVQfDtbrFxdw3p+oF/iEZ7
 2fe+Rs/yefRUjapIiQ16VDyAJMQi6dqKBHGs0+iEVcr9ump7uQBfe6Vckf3imoivoD9T
 f2Pbk4+zJV2V1qzuF2xs74oZWGjexOvUOYjkuqyT5WDViBs+ZxZllDbt4BCuond1sCiR
 6vZT76PmzfWYY1IAzWPyKX6Jk7aiNIjwH4H4rPVilhaG9ZuOHF8FkCwwOmLKCN3QV50g
 QghdN/0vnZxx5JE57G1t16rvWpj7DsJCe/Pho+QjQ4D9a15OPBeDZZRCkNGd53CylpRL
 q36g==
X-Gm-Message-State: AOJu0YzQzy9fYTH0mcNeOARbqn+nstxhD62k5WT5Tl5OhpNSd0m3E1tP
 bFgfdajhXYSfTKsXm7P/RpyDXw==
X-Google-Smtp-Source: AGHT+IGMmo5US26hp+4tS/rDRFB1vDC8KhCTPLVdjcNqw5S+we9l7/4blvaPZV0n5LzJ7l0ujvW+AQ==
X-Received: by 2002:a05:6214:cad:b0:65a:f5e3:5ac0 with SMTP id
 s13-20020a0562140cad00b0065af5e35ac0mr74449qvs.51.1700250140297; 
 Fri, 17 Nov 2023 11:42:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a05620a056a00b00765ab6d3e81sm819682qkp.122.2023.11.17.11.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 11:42:19 -0800 (PST)
Date: Fri, 17 Nov 2023 14:42:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Chris Packham <judge.packham@gmail.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Marc Zyngier <maz@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
 Simon Glass <sjg@chromium.org>, Ye Li <ye.li@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 meitao <meitaogao@asrmicro.com>
Subject: Re: [PATCH 3/3] Revert "arm64: Use FEAT_HAFDBS to track dirty pages
 when available"
Message-ID: <20231117194217.GW170968@bill-the-cat>
References: <20231027002409.430285-1-judge.packham@gmail.com>
 <20231027002409.430285-4-judge.packham@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rnn/ZpIzIymgRSgi"
Content-Disposition: inline
In-Reply-To: <20231027002409.430285-4-judge.packham@gmail.com>
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


--rnn/ZpIzIymgRSgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 01:23:54PM +1300, Chris Packham wrote:

> This reverts commit 6cdf6b7a340db4ddd008516181de7e08e3f8c213. This is
> part of a series trying to make use of the arm64 hardware features for
> tracking dirty pages. Unfortunately this series causes problems for the
> AC5/AC5X SoCs. Having exhausted other options the consensus seems to be
> reverting this series is the best course of action.
>=20
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--rnn/ZpIzIymgRSgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXwhkACgkQFHw5/5Y0
tyz1KQwAjL/ENLjxlXaD675PjLBIyBBj7TuIS9uJmy8VgKvyKYoQXlWRENCTRtec
HJwRg84bQQtYIUkk8ifuOwlZ9RLXeRHz6TYgVCR1a91z/0xfYA9TkcDwOvafgTDa
mb6iW+ouFKfRFAsSbJjGwCdC7uIkl0/r9bBDeRnX7LotBypiq8o0pTSMBWA9cG0s
e9zNbILuTXeYStJna9M5qeJ4HSlN2A6OIQCvnhyKfGwjcBAmFqThhbUQo0OWflC4
0z75aoqDTrtvGvLzGio55EEjL09mdvScsWB3CJByphzrUHpf1txARaI6VkFvyeBB
iIGvLAIGgpzgAAF2Kwroy2vCktyVZt8KirferERgOgOUg1YSCtlB6B9H/amzGb4m
o8vuGiu3TOC6YKGk8YkU38hGzOhXDnu4ylpU1L1xiSm2bmY3C7wFCSson7CIyZV5
tcwFCltEd2RswgihzTY/aWFnE0nD7YN3pOzWKjLStEeYdGgdRfgyc36RiQhxz889
P+HwO+Hz
=OeBE
-----END PGP SIGNATURE-----

--rnn/ZpIzIymgRSgi--
