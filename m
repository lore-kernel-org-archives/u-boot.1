Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEA0CDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 21:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A07186EA8;
	Thu, 12 Oct 2023 23:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KkoL+qNd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3335186E75; Thu, 12 Oct 2023 23:12:35 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 384DC86EB8
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 23:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59f82ad1e09so17130277b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697144658; x=1697749458; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8KHw0pP+6T7iTyzNF3ZOMtQtp+dlxJtTt9eojRIdcOc=;
 b=KkoL+qNd1zkvorPQjAZMlTxGVgv9MbRA2LT7aeFccCIKTguP5uLvBA77yk5fCwjT+5
 /AOpmJbNSGvGj9c9LRNNfi5CUL79Wh5OF5UzJfaxCbUWFfKRE5q6EX6moL8bLqgnjRGc
 cwy1okybVILe6TWjpkI3FuMrGJhudh06Jqm8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697144658; x=1697749458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KHw0pP+6T7iTyzNF3ZOMtQtp+dlxJtTt9eojRIdcOc=;
 b=uUgcP+dFD5cxHBmaeu6O/er0VP27jw5dum/edKlWXDrc3be7gLvxardrDz/iQD4X0l
 yDI1liZo9BHI5CoNGeQX+6DeCOU+PK0UpSAyP7+zFQq58XHJ9SUWn/HnkDt7S8EfDb0u
 6qCHFdL+ZsFFLcT/b8EJTS5j0I3Ia9AiTRD6viPYDl7f/z627gQyDF4CnJJD/dYuGQZk
 CUXgVnFX6TTnnuRqpC2DlUMgj7pehwBdeBEurYiVXuILYlf9jxNtS8IugmZtcMld36QX
 8vQZbZc5C6/vZed4It1o85bvgcplus6K04Zri/Aw6Zlyru0aJO9WW+vXjwFcIVbj4SHj
 l/ag==
X-Gm-Message-State: AOJu0Ywy/Kwt+RnPUBPic/wnidEnUGMVp2qvP9rvWpG9n7QgHYGOjJpC
 a7Zu4qIdlz4+KIFEgMtsFUmuwA==
X-Google-Smtp-Source: AGHT+IG8x29PMO/mueAnBmm09XHbl25hgdF8yfK9kZprQ/qKiNArPHqBvTWaUcNBnr3XK9aULbZpyw==
X-Received: by 2002:a81:8645:0:b0:5a2:20ec:40be with SMTP id
 w66-20020a818645000000b005a220ec40bemr28225613ywf.29.1697144658343; 
 Thu, 12 Oct 2023 14:04:18 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 d198-20020a0ddbcf000000b005a50575b1c8sm220597ywe.26.2023.10.12.14.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 14:04:18 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:04:16 -0400
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v7 3/7] arm: mach-k3: j721s2: Add mcu_timer0 id to the
 dev list
Message-ID: <20231012210416.GC3119521@bill-the-cat>
References: <20231006-b4-upstream-j721s2-r5-pinmux-v7-0-5d31f765dd2c@ti.com>
 <20231006-b4-upstream-j721s2-r5-pinmux-v7-3-5d31f765dd2c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qXBj3qqNtvsz37du"
Content-Disposition: inline
In-Reply-To: <20231006-b4-upstream-j721s2-r5-pinmux-v7-3-5d31f765dd2c@ti.com>
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


--qXBj3qqNtvsz37du
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 10:15:57AM +0530, Manorit Chawdhry wrote:

> mcu_timer0 is used by u-boot as the tick-timer. Add it to the soc
> devices lsit so it an be enabled via the k3 power controller.
>=20
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--qXBj3qqNtvsz37du
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoX1AACgkQFHw5/5Y0
tyyWjAv/RDPflyMJ6MMA/OePObDDuPdYmweD9u3xDFLPB0g2PnLfZ3Mx/JOHobgj
Lhg05nKXZTNahZqd8ZRA2tERfQFTqxoxQjP/K2dYB5+xZw9I1JceOYUZXd/iVPhm
9tPwrKN4KyApbbrLu4LMdEdLuHw9ZSA8n0EnSAN0rNAMEmVkuTG83gijeX623r70
n9wd4TbxRG2K54pu3kUTRZf1GFxckCCd2r9sj+9Szwe1XFvgb6WGhFPtFbR6HEmr
fr9k+5sm5TwxdTAvZiBeik0fhNDxskpBQBiAM102cuNZaukbbkuK04R6wGqdZFDI
R4zBktuh6SAhqzS4F9YEltVrDV/Yik7Lgrfa2P2rkJ9Xgqerhk8fCZnNBpYn0ax1
jZSv8zITAI7NQzaH0b58DBMlT38XR/nVx4id/BB9tEErCUyAUhdfPR5mOLmO7DZb
hlfRl98BdITjbPXKB9Wo954OO/dmkKJowUHHGdhxwd/TZcsVfYNu3/LXzQv9fBSd
IF47hKop
=xD2U
-----END PGP SIGNATURE-----

--qXBj3qqNtvsz37du--
