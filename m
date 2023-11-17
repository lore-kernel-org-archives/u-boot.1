Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAA8C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:46:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30AF8874FB;
	Fri, 17 Nov 2023 14:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yo6EjvwH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C2CA874F6; Fri, 17 Nov 2023 14:46:42 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36AC587501
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-777754138bdso118088385a.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228796; x=1700833596; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gkVMTdMYl8kI17haRkaTvSQJSKMfSCxAK9DmX51L7a8=;
 b=Yo6EjvwH58h9+8/Z9bhx/h272cdmcmT8lGshHrxYOjgYnaPtKngjJuI5BPY0KdX44W
 bk997XTWgKiMUN+G7zc7HZvBnx7x6IHUy5KCoJvh5dyAPXiaryu04n900Yutdrw0lbyE
 k3GhmCmF3eXauUGWu46K4XVJ7Lw8fqAmjC0t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228796; x=1700833596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkVMTdMYl8kI17haRkaTvSQJSKMfSCxAK9DmX51L7a8=;
 b=fg6qmvC0FZrz2uNJjPwOoHcp4ckiyEEAfKkIbiNGuY3ZNmWZTk+p0ywn5c1mtwhyDU
 0GP8HF1X7Wo8uRrgeQRM0T6D4+32ul363Qk5fvtnjzlpG+SZHTCSFHFKCmPyF5VwgqS8
 gljsw9jwswc64zZ/kowIIevJw3bcyJqOtA4w7To2cAsgBEhrbnat6N0ad4vRLJqGNE1o
 qzLF+XbuIWpA2MWIxp21CElEGbAg6yPSFvZ4gYToN5BwcQIaDhQHi9/hEVqEzxOtJy1j
 LEcgY8+Ww+XISAS9/7zSTOs47zs8bCrkbgUOnNgW9/rZL2R5ZtmJKZ3BdcJo7znITEXc
 G5Tg==
X-Gm-Message-State: AOJu0YyIl/80P7TwU3yLLb1fhkQ/MtzYwtraUCrkCsgdRLsjDDY5coBy
 j9GK8/JcmWbZfyXOjg7XabpCxg==
X-Google-Smtp-Source: AGHT+IHqv13uM78VYBiYHl0gbuSe743GToVZnnNGuwMauAifrOqRMoUFSQFViCK3dr2ncRnFhyN6LQ==
X-Received: by 2002:a05:620a:2292:b0:77a:2f9:a3cf with SMTP id
 o18-20020a05620a229200b0077a02f9a3cfmr9752075qkh.72.1700228796033; 
 Fri, 17 Nov 2023 05:46:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a05620a134600b00773f008da40sm602928qkl.125.2023.11.17.05.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:46:35 -0800 (PST)
Date: Fri, 17 Nov 2023 08:46:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Aubin.Constans@microchip.com
Subject: Re: [PATCH] arm: Enable SYS_THUMB_BUILD on AT91
Message-ID: <20231117134633.GB170968@bill-the-cat>
References: <20231105022742.632175-1-seanga2@gmail.com>
 <170022845734.752997.10698883770687016451.b4-ty@konsulko.com>
 <7c54854e-9319-4577-aa10-44a49a9160c1@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ztZTaXoBAgBjwdeb"
Content-Disposition: inline
In-Reply-To: <7c54854e-9319-4577-aa10-44a49a9160c1@collabora.com>
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


--ztZTaXoBAgBjwdeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 03:45:02PM +0200, Eugen Hristev wrote:
> On 11/17/23 15:40, Tom Rini wrote:
> > On Sat, 04 Nov 2023 22:27:42 -0400, Sean Anderson wrote:
> >=20
> > > Several AT91 boards are quite close to their SPL size limit. For exam=
ple,
> > > sama5d27_wlsom1_ek_mmc is just 173 bytes short of its limit and doesn=
't
> > > even fit with older GCCs.
> > >=20
> > > All AT91 processors should have thumb support. Enable SYS_THUMB_BUILD=
=2E This
> > > shrinks SPL by around 30%.
> > >=20
> > > [...]
> >=20
> > Applied to u-boot/next, thanks!
> >=20
>=20
> so I'd assume that it would go through at91 tree.

Ah, sorry. Since it was blocking two other series from coming in and you
had gotten it tested I had assumed I could pull it to -next now to
unblock that work.

--=20
Tom

--ztZTaXoBAgBjwdeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbrkACgkQFHw5/5Y0
tyyATwv7BvNp4qVWAAh9r5fKmNylMdMub6MjpFS6YLctwRD12wuAIwwQTzp1R4bJ
ucV6lNua+IsXiWwENI7UZHZkp8tZgWMJVLrD+cRwK3WhjCXE2A6NwdntoDYLTMA6
jlx02bXZchYvQjDZECRQyqpsS8br16IWkoocZqz/5qT3AbEL70BALt0w6+8Ff18o
oJpjj5XXPyj3mzD2ZEr2s2xEZnWR87k6g2q7Wc6ty0p/jm+x3qdL6tLOLnsXnvWU
tmhJNlCueGerfI/Bk9IQxdXBSLyU0DxqGZ8khjBiOCzeo/VfgbIBTVQLQ6TqqvO3
l5vzyzvrDzyS3jxE3VOirQ7HX4nmUhrzUtvFvdJE0jr0Ah679OLcqG4IxBHLPJYk
q7J7G8WOBPpmldc7/1sfhomMQ7URZxpBorB2YpPS+fFdyQKFAuyh2bdd9bHnDX63
aa2URdn7EiOyfbvyRnPEIXgJQq9zhQZvI0YB0+N6L2Vt5JREPa0TlRdVRmdtEfH7
/5h2vzo3
=gAKd
-----END PGP SIGNATURE-----

--ztZTaXoBAgBjwdeb--
