Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B02EC4167B
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 22:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B4F3871A4;
	Sat, 25 Nov 2023 23:38:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tLZ0sj06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 362ED871BE; Sat, 25 Nov 2023 23:38:10 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F64F871A4
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 23:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d9beb865a40so2639972276.1
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 14:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700951887; x=1701556687; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aBu9ncrW0T0n1QzZem3sWptD8h/xzaQwvBhIQGFIAOA=;
 b=tLZ0sj06FheHAtnuNAcPc645NEhNWk8r6pnKIdiSwvFx8FtAr3Epmah6+zuI6waVLD
 o+cFKdbcP7n8aXbpvkh+tOsLqCOrRhkyBwhSvRikEmMMRiUySFtdpg5inO4/b6IQzcGJ
 AV3Vn62NEZvtVhy32/AwrKreFAbmWE2YeVZrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700951887; x=1701556687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBu9ncrW0T0n1QzZem3sWptD8h/xzaQwvBhIQGFIAOA=;
 b=ftv0psjPe+0eSQGskprqMkH74b4l/XMdx3VOb1KzjEgFafE+Ow609+3uoKW04uCC6v
 KtAU+pZx4FO6fueT7b1nvgafOctE459yt+IqVcSrhgfwGM4FvBUoj+pdY3W4TxHhbg3S
 uv+immIv12bLt2z9NeCJ01dPrJbH7leVKwjk90JuYUlfW/fopA5FfouNgsxasGmTkQV5
 3eluChJJ4eIZ7H2YynaAMe91v9g+UXvfKEu4hYxQ5oQcMCHD5YLNl6Trbm9vU3ib3P97
 Hv8ksLFWg4GeHtcLoEeGMVGwKI9vUXn7IN0rRoCKjG0LmLQwoJzzUsWThU/VpyF3oII8
 GFWg==
X-Gm-Message-State: AOJu0YxS27sDmJF7EPZZq3DyUKbf43EcR6jJX0bBFVnL65JuwteUaeTT
 5xg9qDagk3AeH+Ly5kDgIeLHlXXFjZrVxC2P5Vn48w==
X-Google-Smtp-Source: AGHT+IEE4qlkjEI6nt6lyuT8yIbtWiP+cQOHXVZvItLpbeESUJIaGRVCrF49YvqR+Ue70IBVOJ+mIg==
X-Received: by 2002:a25:4c81:0:b0:d9a:bddd:f714 with SMTP id
 z123-20020a254c81000000b00d9abdddf714mr5719053yba.9.1700951886719; 
 Sat, 25 Nov 2023 14:38:06 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-18aa-0515-8718-e379.res6.spectrum.com.
 [2603:6081:7b00:6400:18aa:515:8718:e379])
 by smtp.gmail.com with ESMTPSA id
 i7-20020ad44107000000b0067a254f0febsm1132237qvp.146.2023.11.25.14.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Nov 2023 14:38:05 -0800 (PST)
Date: Sat, 25 Nov 2023 17:38:04 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] net: Make NET imply NETDEVICES
Message-ID: <20231125223804.GV2513409@bill-the-cat>
References: <20231109001225.2357160-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pzxIbYreJJYjPM48"
Content-Disposition: inline
In-Reply-To: <20231109001225.2357160-1-trini@konsulko.com>
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


--pzxIbYreJJYjPM48
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 07:12:25PM -0500, Tom Rini wrote:

> Normally, when NET is enabled, CMD_NET will then be enabled and in turn
> NETDEVICES will (likely) be enabled via imply. However, if we disable
> CMDLINE in a defconfig we now no longer get CMD_NET enabling NETDEVICES
> for us. This suggestion (as an imply is) really isn't about the network
> commands but network itself and is a legacy of how intertwined
> NET/CMD_NET were historically. Move this over to the NET entry instead
> where it is a more logical fit.
>=20
> Reported-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Tested-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--pzxIbYreJJYjPM48
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVid0wACgkQFHw5/5Y0
tyxuVwv/ZThxwt73g9AfcJAviCWwX8qG94kPclMM19T8TLT+wKDs360Ff0cPGwBs
bjoNi8ub1yQnL5WgBW1vX9luD/dNuoRPsPF/I8kxA2YppIrbxwCdimrCLYt27aBc
U3QP1ji5zjqm2QfWtRHLba2+xuUr9IkbgWmHMQ2uhi4me6oSJDmpXEmw9EYJ4umd
pTz0zvtVV8/MFbs8DhiMRC6ChNja2z3Z7t5zRcwsasAjFL4+/R+g50wSjGEOkpld
tiq+eyVGUWxtW9Ym4ZfE6pJm4TqTZVk8plmZ0+vDNucJJ6c1pwG4Pf8w8IZfhJPo
OOzSjUo/SnAcsMjhY1PC95G7mWy5cNbxckuhvwfFqM9UiXngw5CCMn2sej6fyZHW
Wum1ZORs7LdzeokoEjkdI7c4y3MvG6O1w6KH7jxRBWQXNzPoB3L7qsgfNy1H25sX
vUKsGIGvQsp+CVHNLhJrD3ZV73MpPN2+ad9Mh7fM0mviBkFzWUx/02OG1pTbW03N
7YNup5Vd
=q3cH
-----END PGP SIGNATURE-----

--pzxIbYreJJYjPM48--
