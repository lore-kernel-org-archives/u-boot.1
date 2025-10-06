Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919C6CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1650583BB5;
	Mon,  6 Oct 2025 17:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OpgRphv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5908183C46; Mon,  6 Oct 2025 17:33:35 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D738083A8E
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-42d7ef9a402so22918865ab.0
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759764811; x=1760369611; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VLc5jPko28gENmGY15zDAzpoVLwoaYRfSVcgRpcXXQQ=;
 b=OpgRphv3Kd0DacPByVL4ivgfC/1ta8Ket788os225ZDvpwdUO/vf4TCWr59F72HwpH
 XlGoJ+HlmivYjF/Cn1fSnqEfYwMdqX4cCqViXnMaDLnxmk+9njH+r5bUAz+PR55vUKSm
 +ZF8evCeDwz5RDBwkAbvgKRr2dcoOGzXZ2BQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759764811; x=1760369611;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLc5jPko28gENmGY15zDAzpoVLwoaYRfSVcgRpcXXQQ=;
 b=q8OkiXgLCmHCiXOxhdySzwYBSQbSabGB47RCRCJcBmlcYYN6wt020sAY2eU0+TUZ4I
 8hi4EKh1hnrTl6Zf6I2ExpqzxTb7zO6Zg75i+Pr668CjcfCcsNP20wCpwbXUk/aR/r8G
 vcYu5VtPVYi1VlKE28xoBhPZylySNMstmZRoXXb67o0CFhvGxx7vt1GJ9ny09Wn7dOo9
 JtUw3fhdd5Sl4UkSzERiE0CNYVTrPA0eF2/ThD8sWi0KrNJESpy6iTJOeQx9gP4lglmP
 rp67xjOwjJI0c8YQxbeDuBEBru3axHn0YtznLQloevnWKlHpO25jRLaTZDEeBJ9AydDI
 QVAw==
X-Gm-Message-State: AOJu0YzmMLLMCivWgxGc+ORZo2vCJqIWi55FScs33rJQVjj+AQoBsZ++
 AYihEXZanyrtmXcBvwX6jmCjIjGv5GZmXFiAUGCU7uh4AQ26LiWdGj4RaGhTp8DRp3QgdEb85fD
 4jflM6W8=
X-Gm-Gg: ASbGncslzEM4nxpv8rH6wEMMjKINZwIu0/fwTWInZhu5BSEdTHPARFJge6hGshF7HE9
 lNwb9HIvK26Gyrt/E86P1VB6uOyaj6MP30pg4jxFDPFMonVTbzgr4l1ATfdaxytgAArjAYuXaSd
 kzi0PI1aU2T5OykBUylU46sJ3an4CDNngxyg+KluJNpNYEYbWWArR4QrFvzZY3WhEgo+iJkWAq6
 HjcXIuHB5P0NpXBwvRnUYvDsQxzcKDzaYLbGVZFZIEgkO5Vy5YgWXnTmdZGzuzA0DiF8J78lNdu
 TxwfGCCOnAG+Qssz3tUrWzt0lP036kjrohItKbpvh5XzclZJ8KdGeI3bCkRfAHRHl9mTS7c2dgl
 1sHCZzjh3S68qrDtE2KPAZoI0g30eaibwGUGLazfeFT58DFUAh31JTXnDEvjJvY1MXxyS0gdjGJ
 yb/iyhWMjhgA==
X-Google-Smtp-Source: AGHT+IHLMYWQvhlGC3pWcJKyvaMlxb4cRj8UZc5ASozFHBtgyV4HMRsHnIptGT6YXIj0jEy/nOXjAA==
X-Received: by 2002:a05:6e02:3398:b0:424:4bc:4b33 with SMTP id
 e9e14a558f8ab-42f7c349c8fmr535725ab.1.1759764811404; 
 Mon, 06 Oct 2025 08:33:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ebc8488sm5061597173.46.2025.10.06.08.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 08:33:30 -0700 (PDT)
Date: Mon, 6 Oct 2025 09:33:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, Alison Chaiken <alison@she-devel.com>
Subject: Re: [PATCH] test: Update logic for video test
Message-ID: <20251006153328.GA6303@bill-the-cat>
References: <20250818165406.3194425-1-trini@konsulko.com>
 <20251006171335.7b40302c@kmaincent-XPS-13-7390>
 <20251006172224.0a8d1919@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8/4ZeNziBvuzSKCP"
Content-Disposition: inline
In-Reply-To: <20251006172224.0a8d1919@kmaincent-XPS-13-7390>
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


--8/4ZeNziBvuzSKCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 05:22:24PM +0200, Kory Maincent wrote:
> On Mon, 6 Oct 2025 17:13:35 +0200
> Kory Maincent <kory.maincent@bootlin.com> wrote:
>=20
> > On Mon, 18 Aug 2025 10:54:06 -0600
> > Tom Rini <trini@konsulko.com> wrote:
> >=20
> > > The video test here is specific to the sandbox SDL video driver, so o=
nly
> > > build it when that is enabled rather than VIDEO is enabled. =20
> >=20
> > This broke the build of sandbox_defconfig:
>=20
> It seems CONFIG_SANDBOX_SDL=3Dy is missing in every sandbox defconfig, an=
d it is
> required to have CONFIG_VIDEO_SANDBOX_SDL enabled.

How we detect SDL is kind of odd and could be improved. I suspect that
VIDEO_SANDBOX_SDL needs to 'depends on SANDBOX_SDL' as part of the
solution too.

--=20
Tom

--8/4ZeNziBvuzSKCP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOPhQAAKCRAr4qD1Cr/k
CsslAP4+S/J0KD2EuzADR5dMbAJcwdSaABT+YljfeOiD6EuBAwEAoJ6MuaI+DCSl
t+TG41h8coxicsft2i69zH5nw/thDgw=
=wi5v
-----END PGP SIGNATURE-----

--8/4ZeNziBvuzSKCP--
