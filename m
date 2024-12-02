Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564F3D78336
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 16:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38FD588E3F;
	Mon,  2 Dec 2024 17:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kiNTJsXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA7ED88E63; Mon,  2 Dec 2024 17:22:46 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B7388DE6
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 17:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d8adbda583so4268946d6.0
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 08:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733156563; x=1733761363; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UWwJsbw9X42sS2z8ME2wue8FcIzfOO0sMRZOt3DZneU=;
 b=kiNTJsXCuK0D85AAmBZ9Yh4WvN8jxM/NUwfdS6uqNqnQq0qh4XF+wCc8oporY35OJp
 gsszltq2YZaxYpnI2eTC9RKCbv3/q/5alRjgrvqmRcYsHvWAbkYYN4ND8CcV1lOKg/Pa
 j8szX0PZ5Ufe9+J7vt59WP7kdS7fQz4/UXoHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733156563; x=1733761363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWwJsbw9X42sS2z8ME2wue8FcIzfOO0sMRZOt3DZneU=;
 b=I2Ot03z9w5xKyjVKZHbIYm7x+K/53B1lGZLTqMXw2NBM1RTdi+jYDHt/M4AyMbJwC2
 h1+F0xkZq8TH5cixfZdNZlwxgVguR3tHLTfStaJbaoQcqSYh/Wc/deYLv0syerLCWDmB
 kzWve9WJYGM1sH6wIwymGZPkb0xLowHBlWMuIG+hHcDO30u1VHf0bmSZ2JKYB0TKBD0v
 GsY0pDGfoFW7EKGzi/DrtZ6DaKe8NO7BsgxNi4m1K5pELTdFex02YJUTwcLP8nrHP+dS
 Tlju3OToX7VRQJGBmbX4UbJWUT5um0KG/HDo/t+rtXTy6zSfK6i+lzaVXXwu5cD1VT0B
 xq4Q==
X-Gm-Message-State: AOJu0YzeRAqCYghjJ6NzMmc/FOJKVUCZpqnmo9mC85KgGCjBjdd/ugc4
 7220LGyGu6iZR2VehjQd9xuDIGhrNs6JQkz2QDLlROZUR6zxmYyR6BCAT7lo0PA=
X-Gm-Gg: ASbGncvU6exorDx7pnXhRwnL2HoIJ402LDQbibTj1S+ZEcEj0fqy21rbenD64VYA6QX
 UUEnHNaXf6L8aWLqtvnSCeB8zbRxIbkHFk+8/u0KEMdUX1IKJusrR88BsbW5g7eWP6aL6zEi+3g
 MuqSNPdHEywoiSTHxbcMO7FVRmXLowcTp4ZUEUUYUQXCIiqDqIdkhfCNQC7PmSaWRgDeBKU7Gbl
 R6vkk3dXZu0bQzRJOnR5Fo+F0oZILUp7bWJKu8lH7S/odAgzg==
X-Google-Smtp-Source: AGHT+IGfLj8R5WCLHLtkjr4lULSMWFaj2sklW51mLCr3J5fy5W8XmVP01OeLlkng9FsM9LAFbvny3Q==
X-Received: by 2002:a05:6214:485:b0:6d4:4100:75a1 with SMTP id
 6a1803df08f44-6d864dd3b42mr385180096d6.39.1733156563330; 
 Mon, 02 Dec 2024 08:22:43 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d88d72c0e1sm33683906d6.11.2024.12.02.08.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 08:22:42 -0800 (PST)
Date: Mon, 2 Dec 2024 10:22:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@linaro.org>, mason1920 <mason1920@use.startmail.com>
Subject: Re: [PATCH 4/8] Revert "fdt: Allow the devicetree to come from a
 bloblist"
Message-ID: <20241202162239.GE2457179@bill-the-cat>
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-5-sjg@chromium.org>
 <CAEfUkUKGKMb3rXS7sSDQnPTHs2iOcYFN8zbViajjDSp+aHzXZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uYH33fdnNehc3PGC"
Content-Disposition: inline
In-Reply-To: <CAEfUkUKGKMb3rXS7sSDQnPTHs2iOcYFN8zbViajjDSp+aHzXZQ@mail.gmail.com>
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


--uYH33fdnNehc3PGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2024 at 09:26:42AM -0500, Raymond Mao wrote:
> Hi Simon,
>=20
> On Sun, 1 Dec 2024 at 09:43, Simon Glass <sjg@chromium.org> wrote:
>=20
> > This stops coral, bob and kevin from booting.
> >
> > The correct way to do this was always to use a Kconfig option, so let's
> > first revert this broken idea.
> >
> > OF_BOARD and BLOBLIST should be general and hardware agnostic,
> do you have more information on why they don't work for a few boards?
> Maybe the way to handle these logic within certain boards should be
> changed other than to revert this?

Yes, I'd like to understand the whole problem better since we had a
forever-and-ever thread, compromised to what's in tree now and now you
want to revert the compromise and bring is back to what was argued
against for forever-and-ever, at least from a very quick read.

--=20
Tom

--uYH33fdnNehc3PGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdN3scACgkQFHw5/5Y0
tyxmJQv/dDzeq1rd4ZB/g2525lFVsvJ9HOj0VQeXLEphMB61CZA1rMg9dp4M7tqo
xx1D93EUV/UF48eLqAziLxdN+kFwewKb+a2rZqS3+RURU/Dftr/W7G7at2iE+PHi
ZmJ8PHRrKHI8FxtLOvpbRH7mlr9bSBWRdp89ri9QdqCS2qZ4DzYd/IpvQUEUoETx
giAYALY3fKwlZSEC716cOYUoApH8l5brZa5bSkIibbprLSG30kXUraZX0tmUtOa/
1B02UCEWKFM59dHfmyfLTWeNx+nIKczxs+52A9JMVG9ys28cHN1j0dq5auYaB5Pc
8wuL+i/3gp8hW9TCG/A9BEwllo1JbwdMlbS7khmrWDF6NZ1krPeWQOeWJUh23C8N
NQZBB+5oUbdmO406RP57LuXHSRs6Y/yu0C/44cS+amY7tWJGy8s/ch03epYCotvm
Bk8d4ApO2vvhYStW7ivlGHK2ZT/S/bRmTirdsEF6RPCDc4Ez0AxR1Y3GpDVA2El+
KIp4f5uv
=pm9U
-----END PGP SIGNATURE-----

--uYH33fdnNehc3PGC--
