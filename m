Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF3FE668BE
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 16:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C3F88952D;
	Sun, 24 Nov 2024 17:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SwsoDI5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669028951E; Sun, 24 Nov 2024 17:17:49 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36F6B890B1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 17:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b18da94ba9so313739385a.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 08:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732465066; x=1733069866; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pl2SM81a6epYnRstzGx5YOvT9LfZIaczBJWmLFxa3Ck=;
 b=SwsoDI5ueg8ta6Vu/+cJIH0qzSOC7S/LG8qIPDcDrD7Zc/aAQqQJqHvwH8NrZdEgo9
 UOjTWEeejMp+7bMmYKgOI0PaafFVXYkvW7FQ/5KgC60xOjVZRoRo7nPJMs1KjCAzp4dg
 pgiQsjlt65/xzyDelz7MONSJDlIrY8KNow3js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732465066; x=1733069866;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pl2SM81a6epYnRstzGx5YOvT9LfZIaczBJWmLFxa3Ck=;
 b=apqQfsobDyFX63YCuKge7v7Jq/o0mcyQiwBU77rZGe4UekhM9TPZA7T7gyTBxslelO
 aaM9kjveXnx5CPOqeZpgY9IDAZXCSYJRv5IqmECnasCkDTur1Oby0oyA0d+RTneKzzz7
 ermtmwIFGIW25w2KQMbi9xIeNoDptTEWCNIdjTOsHnDGd7Qr1uA780OknCiVepqKpX/3
 tLwQKbXwwLZ4PuXH+Px9FNiue9DF6pEPjG7BxCouiNSVuc6TUWae/KDtBOlzPG3Vejsc
 a16dB4EbLlLH6dTpb7y7Tttynf5P7a7Di7eL5wCc+NwqCrxLvBkFdB4rcq6UBXLVvh1h
 u0gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyvo8WstrrVXiJKEKWRkd3DGrjE7nJcgzSay6IX9fHvko9riLQO9ClddS/8w8N+E2+uXJFgr4=@lists.denx.de
X-Gm-Message-State: AOJu0YxaAc8DyDIvRzmtViLjEkQ60qpdYVoaoCFmKR21G7FAmPIEKgwi
 g3PFBUCbT65EbvpXXuz4uMJYzfSd2sRgGEQmhu1T0r8UA5OqnzclooVdpxHl94A=
X-Gm-Gg: ASbGncsnwBgTsMOgjmQvsRR+9kdZuHEhlgomQhPmrrMrkK/dZ9Htb/HMcnOeUsF3zpG
 1tmrh353zFBa6qGLrv9zAeOVjcxAAa73jZVtU+x3AipGvauAt+FTurNB1YVt5nUZHhrVMSSsP6N
 h+xvBkLQ9Gme05j4qrP+77/iYUNNiiRQ7r9RaPkqyKl4Edp7u25omu71wDmqeJjnGFgMGn5AHpx
 8/+/hb6yyZcp2VRnV8iTTDD+tmJkGrTHJK078I5Wvrz4eMDaA==
X-Google-Smtp-Source: AGHT+IHkGacL2Yrsy4UI0JIS+MRYDQSAVaRe9mxdmmEHp1dfFDaz7n4HpDdkiYRQ4iyM2LZ8eVySbA==
X-Received: by 2002:a05:620a:2403:b0:7a6:601c:c827 with SMTP id
 af79cd13be357-7b5143fca63mr1670068685a.27.1732465065978; 
 Sun, 24 Nov 2024 08:17:45 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b51417c003sm267668685a.122.2024.11.24.08.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 08:17:44 -0800 (PST)
Date: Sun, 24 Nov 2024 10:17:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/6] configs: sandbox_deconfig: remove
 CONFIG_AMIGA_PARTITION
Message-ID: <20241124161741.GD3600562@bill-the-cat>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GmithuzR17NDNhkG"
Content-Disposition: inline
In-Reply-To: <20241123214554.305285-3-heinrich.schuchardt@canonical.com>
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


--GmithuzR17NDNhkG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 10:45:50PM +0100, Heinrich Schuchardt wrote:

> We do not actually test the code.
> Scanning for Amiga partitions of the sandbox is extremely slow,
> especially on the partially implemented USB device.
>=20
> For build testing the other sandbox defconfigs are good enough.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	new patch
> ---
>  configs/sandbox_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 718e4a8283c..683888f238f 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -142,7 +142,6 @@ CONFIG_CMD_SQUASHFS=3Dy
>  CONFIG_CMD_MTDPARTS=3Dy
>  CONFIG_CMD_STACKPROTECTOR_TEST=3Dy
>  CONFIG_MAC_PARTITION=3Dy
> -CONFIG_AMIGA_PARTITION=3Dy
>  CONFIG_OF_CONTROL=3Dy
>  CONFIG_OF_LIVE=3Dy
>  CONFIG_ENV_IS_NOWHERE=3Dy

This means we don't do static analysis on the code anymore either, which
isn't good, in theory. In specifics, this is fine since the code rarely
changes. But I wonder instead if we're timing out too quickly now? Or if
we should have but weren't timing out before, but that's now been fixed?

--=20
Tom

--GmithuzR17NDNhkG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdDUZ0ACgkQFHw5/5Y0
tyyYlAv/dsrugW7fI8aklPVUkpvFUgW+IdGLFH9Exlwtn8K+Dt1hUyF2hjQd5Utq
7iXU6/kJWHqlY+5O35g9YjtlbfWIEMdVJW0tBzGH3OlFQqqvGar1ppyYBAWL8owu
/Q+foDrPzgCzvlVX/VGbAV4zcg7qULkvu3JtqIAo/+qO5XNyqBSmwTa3nIXoktVK
YYTep5KuOygPtTMpOicxXqKhuJcTjd7mB6tbFIqrCoJIj5CkZQP4HCJlmibgJK0O
h6x1Y+I+imPkXWUJ70jHgCpETdHpb1fxrb8wHYGey4hEWsRkR0/CL1VeYhw5E8fF
0wvEO7fx+iPw5OEcyfH4vHdv30vygPPQW37Z3kQHvoH2EvDELHfgNtXaNtkqQDgi
36ecX5yXHwMeu1qpIocfgRh20KrCUgNFKoLcU/O3VloEc+SXZPZcBhMRQPpPAzcv
Lz3TuCs+my1qMxNFhl0Zuogt7Rrv7n8yLHOMUr2YknBapc04Fd20yGjzFFPzq+dM
RUk+k1CW
=QMFD
-----END PGP SIGNATURE-----

--GmithuzR17NDNhkG--
