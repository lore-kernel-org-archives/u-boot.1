Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC42C3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 13:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D964882B7C;
	Tue, 20 May 2025 15:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DmQTr45o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 888D382C30; Tue, 20 May 2025 15:57:22 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F43D82B00
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 15:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-30e87549254so5807986a91.2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 06:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747749439; x=1748354239; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6ijQ4DsejTN0iGkjXQsSe6E8IibraiAXL20UD0/Kmrw=;
 b=DmQTr45ognHC0FbxykScX6WRohrolZq0/x0nKFx+lbcKMgc1ze06GhHwbY4kXNNP3n
 OQhSPh16dIRtbnokdIpMOG9j9tnTDz1QwB2aMvWCWQHYVfYDLojn5bg17Kfd10j7T0WQ
 wOREeq8pgbNgM+vEEcLLsP9BImiH1y04ZnFGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747749439; x=1748354239;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ijQ4DsejTN0iGkjXQsSe6E8IibraiAXL20UD0/Kmrw=;
 b=dxjdwn8GGD4bQYvt7Zglie0BfCwteT48KeY90tyjtcVGr5CJIqOhYEJGRyn5Nf2Vmc
 9j397yBEa7Tkf2ScHhrhUzbCHJG3/bnGbj+chSRFQuZlwmsz2oO/8MGkgwC/O6LHNG8+
 a29xyCE+OhPn2HMOGb71mkDwZa0H6FmXk+ZDCWhVEJeax4HjUW/KaT4QQxPhF1lrSdX6
 MQwKJVlVbR0bPoY6rktZTdP90vdYyn7lEY7aZ7W+kNVcVk4cqLzlTwVGzhna9NS0e5UL
 l+ty5R94ZG7L97tYOh6tLf4Wy3v6Z3ubDmbWpuyVtuEZmq6UrbG3XzZetZtOpOe4fIy/
 NVeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfjh97jllxI0FJtvExFLoIu0O3IXcYE9CtX2+oARqG1LnnjLGH+DlfJPzRUG8LnbfX3eLImWk=@lists.denx.de
X-Gm-Message-State: AOJu0YzxxqwKaZDtlSYzCDXhAxidkjAsLL5/T4AAtkHJYkOUhB+v2f0z
 I6R2C7RDMR26ZTKJoEqTXBieh83jVZMyShw6k+0keuKiX/96CQ2FZQ/VOEzVlLe5Cl2KGozR9Ax
 5nmPY
X-Gm-Gg: ASbGncuG6iLI1+mlUSL4akWd4EjsdtanDX8XCOkMB09Nrj7mNA+2CbX9GmbxibwRcAW
 LZiwH9OWVSmGQwgQOqFdKwIiVkKtNq5SOZpOJExA75+JN/z0edXtaU0FyOsmJA/lyRjexk35ZBY
 zp5J/QCuA6FrkqrcSJRfSDcY/T7Lci5jpRWQrswS0CL3Sfg3ZI2CMhsTNcaccn/w7PKS1BvhlbV
 qgsO+Fm/Cyz6yGqdJ6fVx4ZlqtHKpWW2K0UmkU2L2EuiQQuGep46ZVTWtzJyv7invMDgoxlwvqC
 P9beFBQ3r5aaNkHjAKhjXM71g1uEjXs4UrOjuww7tGY0/KTiG/v8ZuEDmPRcP12g/vRJiwGHrw9
 q4gfkuenO3FjM
X-Google-Smtp-Source: AGHT+IHoopv6SJdvfmMI94dG2T5zgiDbwVcqI0lgNUMMAAUYWklhrRIdyfk6SSNXLM8jCLceyQVLeQ==
X-Received: by 2002:a05:6830:6104:b0:72b:946e:ccc7 with SMTP id
 46e09a7af769-734f69d2660mr10864580a34.0.1747749427851; 
 Tue, 20 May 2025 06:57:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3cbb4sm1810364a34.44.2025.05.20.06.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 06:57:07 -0700 (PDT)
Date: Tue, 20 May 2025 07:57:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: marek.vasut+renesas@mailbox.org, sjg@chromium.org,
 di.gerasimov@gmail.com, quic_vkarunam@quicinc.com, u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: Flush destination buffer only if it is available
Message-ID: <20250520135705.GX100073@bill-the-cat>
References: <20250519064935.3832233-1-quic_varada@quicinc.com>
 <20250519141905.GO100073@bill-the-cat>
 <20250520090553.ynmzfryhpjjctp2t@hu-varada-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FlH9N1E/I26WNYtG"
Content-Disposition: inline
In-Reply-To: <20250520090553.ynmzfryhpjjctp2t@hu-varada-blr.qualcomm.com>
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


--FlH9N1E/I26WNYtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 02:35:53PM +0530, Varadarajan Narayanan wrote:
> On Mon, May 19, 2025 at 08:19:05AM -0600, Tom Rini wrote:
> > On Mon, May 19, 2025 at 12:19:34PM +0530, Varadarajan Narayanan wrote:
> >
> > > From: Vandhiadevan Karunamoorthy <quic_vkarunam@quicinc.com>
> > >
> > > There are code paths in do_imgextract(), where 'dest' could be zero.
> > > Hence, avoid cache flush of 'dest' doesn't point to any data buffer.
> > >
> > > Signed-off-by: Vandhiadevan Karunamoorthy <quic_vkarunam@quicinc.com>
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > ---
> > >  cmd/ximg.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/cmd/ximg.c b/cmd/ximg.c
> > > index 29d7c3279b3..8907b579d4c 100644
> > > --- a/cmd/ximg.c
> > > +++ b/cmd/ximg.c
> > > @@ -265,7 +265,8 @@ do_imgextract(struct cmd_tbl *cmdtp, int flag, in=
t argc, char *const argv[])
> > >  		puts("OK\n");
> > >  	}
> > >
> > > -	flush_cache(dest, ALIGN(len, ARCH_DMA_MINALIGN));
> > > +	if (dest)
> > > +		flush_cache(dest, ALIGN(len, ARCH_DMA_MINALIGN));
> > >
> > >  	env_set_hex("fileaddr", data);
> > >  	env_set_hex("filesize", len);
> > >
> > > base-commit: 1b5e435102aa29a665119430196cb366ce36a01b
> >
> > A memory base of 0x0 is valid and not that uncommon, is there more going
> > on here that lead to this patch?
>=20
> Facing an abort if it 0x0 (arm64 based SoC).

OK, and is that valid memory? Or did you end up will a null pointer
somewhere? Other arm64 platforms, such as a Raspberry Pi, have valid
memory at 0x0 and so if we had used that address with this command would
need to flush the cache.

--=20
Tom

--FlH9N1E/I26WNYtG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgsijEACgkQFHw5/5Y0
tyya3gv7BFYOjh0MRzxIAkiSsE5/DQGrrYLr/Y74MVBY4eI0oNo7ejTeXWx5dsnh
Q1pTevdd8kZF+sMe9geI3bqsxP55AlO4SqHhD+FDbdRPVIgQT1iBruAF/6V8TWzT
BZHTHxX7E9mPJew8wN5REGB0PxaYx0159v5mEJeKXz9oPsbxf98c8+/h/ba3fVER
rxGLzNy4D8tnNl9S8ud5alrhyQKd+FDi90LPFLNmCSRwhs6BcQZOCKqSFd8KeByN
NE4/2BnRCOQ8Xg3V6khsKFtH52VIXuAx4+Ci+a92De2c3lD673yXUPTgxcRrNuUZ
6Koi+oCviVvH1AOtHPC2mJ+fBtUhCf2u1kZ07Wl9/wHdvKV5mpoKX2RXgHE9hXT0
Snb9OlGnRZB0+bY26tSbqcnr9//MVnm68yk/DIWUaGtQ/hnVwqP2Mi3p60t5S5Es
wVrVfnmEU69lBgrmPAncqywULe+eSHchHYO+YNqp0J86axpYBuNItjsm6rn1RqzU
wFMqohrS
=0Ev+
-----END PGP SIGNATURE-----

--FlH9N1E/I26WNYtG--
