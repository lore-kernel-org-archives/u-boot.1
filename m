Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA97C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 17:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63E48866E;
	Fri, 19 Apr 2024 19:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gcv1ltnm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 470FC807EC; Fri, 19 Apr 2024 19:03:57 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AD328884F
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 19:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a4702457ccbso254111566b.3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713546230; x=1714151030; darn=lists.denx.de;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s0oa/6pu2zczq9lOTHqJQkJF6jHbz8DIBrbG0303nSA=;
 b=gcv1ltnmzAumQsnB3b+f2M0sXkYYWW3ATrLk92lAam2o5qKnK0pJbGIz50M6Rxr0GF
 TD+0aMW6MLlbXLBeBu88v95XO/RTuGem5Hfpqj41Vq/R16T/Q0+LVQ0SUxUm5Aj+LNw9
 1f45LQlslfT7gzLgSDTj5jKLnS50W54NaeKKgIPvxaqcgPf9A2ie4BlY9CzRNlA43NXE
 sGQsu/RWaFcc3BJ8zUO81pGfgK0zaRAGv6JY5ZefoEC88Jz9XkzMF3SYLnVwtT3Kr/KA
 gvJdUtNlg14Y0k0ty8vynk2EmSUKeQVpJwa4F+Qqy9Cthm4PiSQiUow23RVW2N1RFoBO
 dxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713546230; x=1714151030;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s0oa/6pu2zczq9lOTHqJQkJF6jHbz8DIBrbG0303nSA=;
 b=da9B/GJa09AAb6yPnhIQd7/y/ZXLCxm3SMQ5rOY9lz4TXmXc3sOQWMz6Hh8gU8zEe0
 bQg90KtXbWSOPVBRqpBdBO8TJk8ZV55pC3TcS+NYfw1qbXClH4FyDzw+3k6cu1nfbyEq
 NgZyORq9gP1YJYWNMM2knOBBn4M5Gtwz1tM0OdYMNfDErgMV1V0VfvGGbP6vj2KYCdXN
 xQUWddJRZuiz01CCobYZNxf8DD+ERpbW8GcB8uSpCQpl2WQ5ltJYpYexZJVGuFhD1wVA
 EMgC+k8F8XpNAci67H6yl1KQecefq9eVnmTg70Z7VHEhMSBC5qE6tIhCRLdWndKZox9o
 7ojQ==
X-Gm-Message-State: AOJu0Yx4cUnOe82PHad7nqOxMQoKlyVjs4e4KyjscPMX/vp3Mgb4gXed
 gIHWYMPkpe6e7bpm7XgimdDNFnGdw1sp9DoK24DbYv8RPBT2I3rK
X-Google-Smtp-Source: AGHT+IFRN+46aJz3gto1sejDlDD+vsRoHzht8D070dHxyVRCplvRDPj4ezFueH0+W76GbYd5ISlPDw==
X-Received: by 2002:a17:906:2b9a:b0:a55:5ed2:44d5 with SMTP id
 m26-20020a1709062b9a00b00a555ed244d5mr1588352ejg.68.1713546229476; 
 Fri, 19 Apr 2024 10:03:49 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a1709067b9100b00a51bf5932aesm2392524ejo.28.2024.04.19.10.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 10:03:49 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=f2d7e5c96cba27e3adf9030c1cd3bb6d9b0d9a9e870fbe46405ec3ccde74;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 19:03:48 +0200
Message-Id: <D0O9FY1AMWFE.NBQ76X56Q12O@gmail.com>
Subject: Re: [PATCH v6 09/18] video: tegra20: dc: fix printing of
 framebuffer address
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-10-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-10-clamor95@gmail.com>
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

--f2d7e5c96cba27e3adf9030c1cd3bb6d9b0d9a9e870fbe46405ec3ccde74
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> From: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
>
> Framebuffer address should not be a pointer.
>
> Signed-off-by: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/tegra-dc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/teg=
ra-dc.c
> index a8e32e6893..000a0e02f8 100644
> --- a/drivers/video/tegra20/tegra-dc.c
> +++ b/drivers/video/tegra20/tegra-dc.c
> @@ -429,7 +429,7 @@ static int tegra_lcd_probe(struct udevice *dev)
>  	uc_priv->xsize =3D priv->width;
>  	uc_priv->ysize =3D priv->height;
>  	uc_priv->bpix =3D priv->log2_bpp;
> -	debug("LCD frame buffer at %pa, size %x\n", &priv->frame_buffer,
> +	debug("LCD frame buffer at %08x, size %x\n", priv->frame_buffer,

%pa is usually treated in a special way. At least it is on Linux, not
sure if the U-Boot printf implementation uses this, too. Looking at
doc/develop/printf.rst, it seems like this is supported, and given that
priv->frame_buffer is fdt_addr_t, %pa seems totally appropriate here.

Thierry

--f2d7e5c96cba27e3adf9030c1cd3bb6d9b0d9a9e870fbe46405ec3ccde74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYio/UACgkQ3SOs138+
s6FvSBAAo1V3+8yjJozrzUSS94U6opnpxXdzFtmNSfQA6wynDO6laAiXaPuZN5ks
KEfF9JBGlxpbNaxHb3kmbCh+uRQn67R1F3ynpTYByI+gVXrg6+a8qrPLJx4Gz95K
ydxPU2OgCobXL3IAacuspuGaNjjFo+5pXpmqrFMXrjHntWWwdw1hxklBjmmKwyJs
A91KZCCzImDRYmR88yYNjrT7Wgf3owj7zEBASVREpvRlaVO4NMTbdtjmEnbqLJi5
gq1p3ETQ8VUkNCdDBGJvCAdHjE3jbE73m2QwX1tJLMego1Jgma4mXTNbWfCgiPTS
c6c7+ha0I57jSMKfYudypRoNW5pxqM3i3Le7nyyXv1jF+0FiHWTlcWzzRZb8phHP
oR97U/KjI4ZAhhcFh6AWYsUaLvyi6/mneBMcoMlGdsXrJzSxdZFkn56iToBqp7kG
qic7wakLDFKtCcqr4MesIEFeuuA0DecrpBX2YqoefWiokd7mHy0YzWg5plVYGXi1
jqQXySBSrtgHZvrygF3d71irOVxw149OL8H+QIHrNhlDfd1oxl+Urf+9CvksmgSY
9jLGmJXJPpCk98BH0qOp3UFVpWF8MCuCqjtu49CC+lXiGprExfX4utucjHn3kYm3
qy9TnXeKBcE+vDKLU+Z8p6341NW6qzrBP14zOd3i0EeO1rJ0S80=
=aLrs
-----END PGP SIGNATURE-----

--f2d7e5c96cba27e3adf9030c1cd3bb6d9b0d9a9e870fbe46405ec3ccde74--
