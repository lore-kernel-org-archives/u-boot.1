Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA5CC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 20:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B451849D2;
	Sun,  5 Jul 2026 22:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s1CN1Ald";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7797C8490A; Sun,  5 Jul 2026 22:26:59 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C9A484857
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 22:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-43b7e186a0cso797302fac.0
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783283216; x=1783888016; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u12TEiGJRlYN0ji7bm+gssir89w0aJucKNksYFlqdZw=;
 b=s1CN1AldIBqVUmbs9Eg8mh4aDvMfHcBnkOIBPtxDBFjAiC+h3axG7x01NGNF2VAL0K
 DzfpvZhbpm97EAcAUoMoaN6KLaWkAamS53HJ6PYybCnxyLh3ToGg8DgyVnkYS58mIM4J
 5fiENmgUF2jEWh7GGG/mrAJyHFnynO5lA8kKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783283216; x=1783888016;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u12TEiGJRlYN0ji7bm+gssir89w0aJucKNksYFlqdZw=;
 b=fNBZ+J16Gn+aOqgQT5zhRcXIMQzpxXVTkAnG4VH7RWSvuiW0cjhrF/PJkPrs28LXIH
 N6aSO7HeFH9PLERZFEbpNCczg8KbTvPWImpa7X1wQzThYfy6b1efYKqRaBTK0NdBz2Iz
 h8GFnhWIhyUgigwgD+cvO5oKC5eP3R0ieZFxhetxorsTCB6mjzOLI6Q++Kb3senjHGru
 pEky0LpLhSkrCQJ/7pZJE5Ke9cGA30f85clINiZVOYz8If6H/2YFKQ9qShP0T8efb6pO
 DRAWpAiiGxF99Ce1e/5ewayYDkkvpPQy6mAFSt9UkWJaBPtkkDMIjoZvlmgcJTP5j1tG
 TfMg==
X-Gm-Message-State: AOJu0YwYh1bKpmjGRWTOK945499T8f7ow2TLxMwMIQLLP7qiachKtQMA
 3tUtyvDeltL9xGeHT/NBjl2hl2hcIL5XBhoJw/swxMKusIeUEpGXuXL/oBzPCo3KV7M=
X-Gm-Gg: AfdE7clD3LTgYkcw7/uHh7W+LkVBTQ+Qm5E+ulxmoBMQAzdBA7HBJxvGnJBImIvg8Z1
 4zIk7//f2MmblHsMcfrXUeGa0i53/7wFIOnS0BNGyzRTgMl3AQnhx617IAjzlPhZNd17WqKT4sf
 4csrec/BpeHE7WrylCtViEjpfpiCKKuh+PjInpHFzDKD8jpLP8+jZltRS01nPG7odBL6FctOZQh
 KcLQxJDHWuK+dkMx6EluBZO21Eee3hO+ajPLToETJy/LvDBd2gPKkdmDPJ1mC/WrKKcGq9Q/qSf
 FWsFJ7WYo2/FfyciFjdtmIoeEBeSURc6Hf4mnXcjKvRFmdnBGF3KPpjdR8HpIO77+AQywaJmDmv
 GGwA62KSGojq73LgZouk3PbL+9XR+8SseMg5i5Xx8UZOjOMwjR6vESIFrq5lARHsWHOPXwVunmf
 nvgO5eekRWE80KrKnIHTrVTMUgvBNJhjlrAT3J3RoWscaPhxFSsf2owVYh39djZzA1z8PGYh7W4
 9to9//tLZ9zNRg8ItGw+ofEbxE89JP5gR7kPQ==
X-Received: by 2002:a05:6870:c253:b0:448:aaaa:6b93 with SMTP id
 586e51a60fabf-44d18039fcamr4608994fac.17.1783283216079; 
 Sun, 05 Jul 2026 13:26:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1c8092sm8205024fac.6.2026.07.05.13.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 13:26:55 -0700 (PDT)
Date: Sun, 5 Jul 2026 14:26:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>
Subject: Re: [PATCH v2 07/11] CI: Install pylibfdt's requirements in the tool
 jobs
Message-ID: <20260705202653.GS749385@bill-the-cat>
References: <20260705193251.2190705-1-sjg@chromium.org>
 <20260705193251.2190705-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QEKkiHXHaEQRySzA"
Content-Disposition: inline
In-Reply-To: <20260705193251.2190705-8-sjg@chromium.org>
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


--QEKkiHXHaEQRySzA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 05, 2026 at 01:32:18PM -0600, Simon Glass wrote:

> The GitLab and Azure tool-test and pylint jobs build the pylibfdt
> bindings, which need setuptools. That currently comes only from patman's
> requirements.txt, which a later patch drops. Install
> scripts/dtc/pylibfdt/requirements.txt in those jobs, the proper source
> for that dependency, so setuptools survives patman's removal.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--QEKkiHXHaEQRySzA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakq+DAAKCRAr4qD1Cr/k
CiGKAQDlUTjzuQbyAFrt9d+YU1CktGQwJ+9SPvRcsiOCgwMfmgD/XSJKBxK9raem
i/8vogq15YcAZ7TBRnIExolYyX2j9gQ=
=e0Ls
-----END PGP SIGNATURE-----

--QEKkiHXHaEQRySzA--
