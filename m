Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE50D1358B
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 23:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA68488730;
	Mon, 28 Oct 2024 00:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jd7ERPa0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7996C888DD; Mon, 28 Oct 2024 00:12:27 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD7618862E
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 00:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b14f3927ddso296865585a.3
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 16:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730070742; x=1730675542; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R3z8NL8dpKyqVo3aYCWqpezqVuXptkIsS/ASinKrOV8=;
 b=jd7ERPa03/lhhMI+0psEXsBlIFnMPuOAkEWy5ppdbd3PCGA5aD9EzP1bZmuIvhfjDD
 GMx/fZq9HwR66SPP5pULGeuSqYCw0hW5Ym7VxmHp4OSeOSESLGO3irPXGMa+xQIMtI4M
 QfbrscwBZ76E0FEYswNCEJsmnwirQV0hTLKUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730070742; x=1730675542;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3z8NL8dpKyqVo3aYCWqpezqVuXptkIsS/ASinKrOV8=;
 b=tSut/PX5SQMP7co1MAiZN82iUVyrSKd1o9iIICGLFJyFJ6bPPyCrmJXJC2OMeNTLOq
 LZme4BWZYjsFuVZ8XElKFqLKFC7WMZ/djMQ0djDoenEgHirLZlFlJUKl9S0Mw7tigML7
 yQJ/Zganva0cY2mIDc8IcGsiEDK0DSb0tcxPbVgHKqdEvJtQLU6wfxdngDNzmU5HiVIY
 TCdxpVXF5DOXw8aIp4NEiQltE7hE5fZz8+bJnq0gd0hJry+HqyUZxm//EE9yHi5wl20b
 fTGaJeh3u2zuwLZFlZ8rGx4r8WLlIo65fZSeyYsd7ha6zLXq/4q/Pz4TW3H/0h+XaFWW
 ZQqA==
X-Gm-Message-State: AOJu0YwluxO2JtATBxbEqnioUJfue6GdgVOjVU+yNIhuAdiqAgzLkAo+
 mLM0CKMq9m7LapG0F716qNUhRX0WPwYlNeN+5zhssgMCBCZBq/JbPnhkhC8jjNCUGCz0Xot+gi6
 oflk=
X-Google-Smtp-Source: AGHT+IHOg1rj93a0Th8AjsuSe0nUauoFJmt6Cd1HkOrt46TSrgZsvI/G1TO6GhAHOacHQzAxifzqbg==
X-Received: by 2002:a05:6214:3ca1:b0:6cb:fb94:d435 with SMTP id
 6a1803df08f44-6d1858401f9mr138794906d6.36.1730070742476; 
 Sun, 27 Oct 2024 16:12:22 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17973e182sm27532806d6.19.2024.10.27.16.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 16:12:21 -0700 (PDT)
Date: Sun, 27 Oct 2024 17:12:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Hanyuan Zhao <hanyuan-z@qq.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
Subject: Re: [PATCH 1/8] net: dc2114x: add support for platforms that don't
 have pci controllers
Message-ID: <20241027231218.GA2057672@bill-the-cat>
References: <tencent_BD4B002FC63A5F77969D9BD1FFF125371C08@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KuOFvNud4rTZn4Ah"
Content-Disposition: inline
In-Reply-To: <tencent_BD4B002FC63A5F77969D9BD1FFF125371C08@qq.com>
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


--KuOFvNud4rTZn4Ah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 04:56:54PM +0800, Hanyuan Zhao wrote:

> There're a few ethernet IP cores which have the same functions with dc211=
4x,
> and can be connected to CPU by AXI or other buses. This commit adds suppo=
rt
> for the platforms that do not have PCI controllers, using MMIO to communi=
cate
> with the dc2114x IP core.
>=20
> Signed-off-by: Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>

For the series, applied to u-boot/master, thanks!

--=20
Tom

--KuOFvNud4rTZn4Ah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmceyMgACgkQFHw5/5Y0
tyxmNQwAnGJQ7XhWn+o4I/6fgw6C8C71ulKOakV+zspHkTzBlGgI48EmaXIyZP9q
sBg1i5XgZSuJkDp2Y16CX2/+vIZOATP5JTcoz57v/lCge/+wFsO4o/uxxPHCeZLm
1bqORy/q8ruxFzg5LYGTijSTBJe3RfnTntCSzXs/qB/UqZ+6MuoIv8mdHMRzzY6M
j/JGLcn0GwFmw5l/hlD6zfzNj+zgQjEcDM3eU9slK5dPhFADrS+HAr2GvdwG2967
dML+ycWnRelU+44atMaMaZ8hK9HgrysucTHNEyOlVf/OtqxTz0WtHivCpyVL3rYh
KInikCeiGpAz9xRuxB7rcHHYP47fbsyRzmTfqOiPnmnDNmSi3t5W4bbS7aD7i/py
rO2uRoG7CkMtmXFSUmlCe1DCw5x67NAvpweZpuKbe+3e8GcrNlxX0pq/stVA3p0Z
Qvi4+g3Xb1OmA28yIeLSTuFi7QFbCSfNeVHHzTtsRFzZjLd13XKTYwmwkKoGQgF+
HacBXKXl
=Oqui
-----END PGP SIGNATURE-----

--KuOFvNud4rTZn4Ah--
