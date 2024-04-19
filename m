Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAD2C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5855881F6;
	Fri, 19 Apr 2024 18:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gp8v9c0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81D8C881F6; Fri, 19 Apr 2024 18:30:41 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CDCC88011
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a4715991c32so239533466b.1
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713544238; x=1714149038; darn=lists.denx.de;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WcHz7prGfx83USaXQ83VaWKBOG+2Cp5vzfmL33XPip0=;
 b=gp8v9c0EY76GH9M5BGjrJ4cbk5yXdu8KYnS9HvCx1L1q3OATLG85opz1NkVfYLVFs9
 6on5nZdewm65VQ9SJeYqLu4VYt/783G+VYupVRJHllXUUOitP+ievXtw0sqDJhDOyCqS
 TOyNQ7raRS4qWdoPTOvFvGCXBCxX+Y0B/PiiKwGQuNU8vBrXDRsLdLUths1SX3wNPFe/
 tvOdXYpVMUayv/+pL/XRb62lFB7gyRDyNujs+VmSA0S83yFBRLs12lOOhiFYl5YW0RPl
 nw64LOOsoCGNJ7NyAlhMR1wK7VAeDcVC1febmUrSvK54JFqdWDL1Y1LKokEr/6Mn0cJB
 m8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713544238; x=1714149038;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WcHz7prGfx83USaXQ83VaWKBOG+2Cp5vzfmL33XPip0=;
 b=YcL66MxhVOmlyJY5AonnbTZc10U8SOL1o+UyhzCExPtD2soRPDYqQRRzYiCNXjgBfF
 ZJB/27+I4QzXizv50rq0B+/VjRQZhkK00bhFiv6o7FdmQ8yxH7aayL33RiFPgpo61jFr
 JeYEmTkapmRnu7Me++HDaPJxaeWb5QBQFWr6KlX1tgPygbjQOc79ekTAENIw5s6yIbhG
 FXsmOjLYjTLvyN/lfSGZDzDfyj3haHJytemrDevLgYI887AWfGqmlSzYYn0DxA8TnYL3
 JBsEiKlwHicP8LKni6wRv66qoRSBDEGz256zQcRwo12rXvyGRlua+mvRSanN+xwt4uuS
 g52g==
X-Gm-Message-State: AOJu0Yx5aONghOEnRrrdLLNh5mgHRormaf+S6+qZLdWJdd3TmtAKRA63
 73kcKS+nuP9Z+dO5sg135ArFqL9R2IYygfwNoWHC4EFRxVozZ8zK
X-Google-Smtp-Source: AGHT+IGADpWlRNF9N3Z34SwVy4B1cSQu4VFHZ34n7RZ1TNLT2sz4TyLal1eHRosanjj3TviSuPoO9w==
X-Received: by 2002:a17:907:7ea5:b0:a55:66d2:95dc with SMTP id
 qb37-20020a1709077ea500b00a5566d295dcmr2410578ejc.48.1713544237896; 
 Fri, 19 Apr 2024 09:30:37 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a17090657d400b00a51b403e30esm2391914ejr.90.2024.04.19.09.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:30:37 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=89d646d9222ebbb06c2b7135b60f9d48971634988d74de48318e8a94adbc;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:30:36 +0200
Message-Id: <D0O8QJ2GIHXK.JTYDS2OJTCOZ@gmail.com>
Subject: Re: [PATCH v6 17/18] video: tegra20: dsi: set correct fifo depth
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-18-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-18-clamor95@gmail.com>
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

--89d646d9222ebbb06c2b7135b60f9d48971634988d74de48318e8a94adbc
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> From: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
>
> According to Thierry Reding's commit in the linux kernel
>
> 976cebc35bed0456a42bf96073a26f251d23b264
> "drm/tegra: dsi: Make FIFO depths host parameters"
>
> correct depth of the video FIFO is 1920 *words* no *bytes*
>
> Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
> Signed-off-by: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/tegra-dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--89d646d9222ebbb06c2b7135b60f9d48971634988d74de48318e8a94adbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYinC0ACgkQ3SOs138+
s6FLJQ//a01kznrMXomNn+1f0NfDMT+pWx8LhJlMvzf9cgei6laKfnR6oeP85Eww
a7v9/qvsheYX7TLyJ+98zPI6rM6eHK5Q3MfnIrgz/2C8C6o6WI7Lq87zWOmHO5qX
JKeD4fXSmQ/AHJDxyhJKbQf6/pah4SwrVdAGIwuFKR/b+RF9/hkA+koIctMEeF8M
/UOQF6eNR164BgEJOoZJCbUMGHnaCYhxW3ukVs2ZRUbMpDyxWjx4mD5qoNa6GxlY
9KM++5HsGuEfc8XhrlazV6xMq7eWzqE+U0mkS4PirIMbVKAJ3qxmO6Qrk0ub/KTO
ioqFyUQD6Dspnw0NUPoK0jHalyaY0KMozAlxet0JvpS26bLzfwgFjUDHCBy602db
hT2CNh1fQswouGvs5JjpMcz/DBvJf00+h7EDEuj61sgLbGn7cdXnsbLllKoUiJud
95R15Fa75OyJPjUuIds9M3OeKkr8YqRWG0q1dlp8l4NSOAuWP50upSJbcV/N8Ymf
SWsdwo+zmxJjSaBEYVjqlZ8onh1U7z7s9FHuQ6mWm9hCV5GnM8ZpZevBUWjG1PkT
yqvtJZwnhHCDOLRwoQMgmaGfN5hv2DXOuuEVrg7+E6Ay/gN9u75PluMvCniOi2f+
S+k1wY8sc/+CRcxh1Hh9rWGnRCq84JluG66BSE57s8r+X4Pdk2k=
=0SdC
-----END PGP SIGNATURE-----

--89d646d9222ebbb06c2b7135b60f9d48971634988d74de48318e8a94adbc--
