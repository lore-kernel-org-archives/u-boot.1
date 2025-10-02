Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3116CAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 14:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589B1828A2;
	Thu,  2 Oct 2025 16:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ywu7kcka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC543834D4; Thu,  2 Oct 2025 16:02:15 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD67780107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 16:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-9298eba27c2so40933939f.3
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759413732; x=1760018532; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vBbP6FFnRTH7WBHY/Ej3SJiitZHPpA7hYVb6IxKAR4E=;
 b=Ywu7kckapuvFn+yoUx3Tp9rEg6jHPpmVsOyC7oAH1VXqxrOVrKFzB4/YbdjWlDkj4w
 xf/0WaE2shhbVk3ed5FauOCGd/t2V7vFkpCDdhHMGfrwDyPUjW+91fZyF7yuUfMApQrv
 i8lxTC0sQcMCMuW8jBxpT9z+DMfH/rZj+YBHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759413732; x=1760018532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBbP6FFnRTH7WBHY/Ej3SJiitZHPpA7hYVb6IxKAR4E=;
 b=dNYzS95uz7q9XXALGEcl+TbLc5OH00Y34WmRPWO3401XgnzoekzObSVqqGIAU0N6A8
 NCP/U/Prrjd4ft4zwwIOHWJJZa56acKlq+MvMP6SPR/EOZz8HAlR4gDX07O6Wp1qY+hx
 qCZJ1mWXjQUpql9iOfg1VUWKsHyIbh/jpW1NHAywB+awcai6wVQ2rtML7PvFXNgLR4Pe
 KN8xDMKL8Fs2w/JLqNCjBsUI8hqGGb8L5IyU2xM5MOZjH1wXuIWcKV6/zJte29kO0JjI
 WfSilIBphdf0Fne54ZtwL3Mpr5jtfb4isZtN2ES3mpacQkj7Zb857IFjEDPJmLVk2RDC
 2MwQ==
X-Gm-Message-State: AOJu0YwugwxfQwiwpJmCwhizSKC0USUtY+J/wh43k/AIVCtSSfJBBU8U
 +iHzYVBt/GLev+NpbofFJhgbScrNi+MKr7U24wAWhSruC+JoD3RF7GVOwTgriWVocIs=
X-Gm-Gg: ASbGncvVHsw062Evgtld0sAPolpSPNgHglCE2meBJhw5++2tYjt3GG6UnudwB4ymKra
 7KvmEpEjnNkA2xNaRn0JlGbOv/hchO1WpKJ4EeiyELIv+wo7a/+Co//1elMvXAQFb2lHAz/1ano
 FrG3SKL2Lrs6YzxSeQrE1OXYmYFrAuLuW/EwCneKoYlwaWlqK+g+yweuhPBmi8bm3zjdlKwNSRR
 JYlgU5xg+zgFe1CbGlcs2uuYB/HKi+I1x43cZaJyZ0+2Ot4rFw+so4aZqNMtuSz6o6iXKf+hSwv
 uS9CxW3Oq7kc6pZy0vWlXbZlLS/W7jzcySoU07sbqQYjUIVQpFP10ZZjkE7jw0ZZyGm8eLEKwOO
 fr/xbP+GUJ0jZT+1hfAzcEkn1M5z8wwIFVY+OVRFU92sx3PZRp/NjTj7o4LAg1xL710w3LyqH3u
 DIYCtO3einfg==
X-Google-Smtp-Source: AGHT+IGJaTQWqyQ8Ca0jp4gZjdZluZyR9aCUhnGPKmBGKVQH0PA4sMC1NpLVYcS8IJSg6Hu6tpLDqQ==
X-Received: by 2002:a05:6e02:1fcd:b0:42e:d95:b9e2 with SMTP id
 e9e14a558f8ab-42e0d95bdc2mr15385245ab.25.1759413730310; 
 Thu, 02 Oct 2025 07:02:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b215dd6sm10174525ab.14.2025.10.02.07.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 07:02:09 -0700 (PDT)
Date: Thu, 2 Oct 2025 08:02:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH 4/7] doc: make pdfdocs: Ensure SVG files are converted to
 PDF before the compilation of *.tex files
Message-ID: <20251002140206.GL6093@bill-the-cat>
References: <20250825230044.GB124814@bill-the-cat>
 <CACAHuLCyX_32AQozgt-Wf18b7ia5m3nRJZ7bA=M9oM1mwh-OXA@mail.gmail.com>
 <20250827002317.GF124814@bill-the-cat>
 <CACAHuLB0uwUjnR58qgeoOcHO-PC5geYFuBKF4Mw+=UFjT9urRQ@mail.gmail.com>
 <CACAHuLDZzgF1a7wG8fwNZ1YnUruPgyd9MifY2COS1kQFsqXsTw@mail.gmail.com>
 <CACAHuLDp5COeBue8jt8U3s59UsTnzjFH33ThXVFXk7-XLCF1BQ@mail.gmail.com>
 <20250905230929.GN124814@bill-the-cat>
 <CACAHuLBgL2h+XYysfwYSOBcwyjrJRk7Z4X5Axr6PDDF_Xq17Rw@mail.gmail.com>
 <20250924005717.GG197373@bill-the-cat>
 <CACAHuLBdYcpXRP0MTeiz4AGUAScQ0zf=+81Ez+wXEP+fzyhUrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+Gfpx+QFBLhsnp9G"
Content-Disposition: inline
In-Reply-To: <CACAHuLBdYcpXRP0MTeiz4AGUAScQ0zf=+81Ez+wXEP+fzyhUrw@mail.gmail.com>
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


--+Gfpx+QFBLhsnp9G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025 at 01:06:27PM +0100, Adriano Carvalho wrote:

> Is it ok to replace all instances of ".. image" with ".. kernel-image"
> (65 occurrences / 17 files)?

Yes, that's fine. And a commit doing it makes sense, rather than one per
file/directory.

--=20
Tom

--+Gfpx+QFBLhsnp9G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaN6F2wAKCRAr4qD1Cr/k
CvegAQCSjRWjUY7und4HBCvpoRD8OAnsS0wGj7GVDl0QXID/3wEAxnEIqBJ/Lv7q
FgXHZhXPLAl9lRsBS9HGL6Y0ZECkDQs=
=w/p4
-----END PGP SIGNATURE-----

--+Gfpx+QFBLhsnp9G--
