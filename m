Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D26AC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2CF78144A;
	Mon, 28 Apr 2025 19:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gClPaFZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A22681E0F; Mon, 28 Apr 2025 19:25:45 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13E0580FDA
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 19:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-606477d77easo2955073eaf.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745861142; x=1746465942; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eV58YpVitFfrDHc1mLy+J/2yxUl6utXch5ZKuMNQutE=;
 b=gClPaFZmz4LC1qjrI/hjn08BGKzGukwhqjeLleiQoW4jiuZnnZ+vPlOF+VRewEnqL+
 jnVzaX9AuI3UqHj+jXLxkoI9dFzZi6lThpNx4MRLmDf9HYowXOuwRh5eJRCMLjKOPt9F
 Q9zAbagTblD8DzNcv0gUt+qNakW/7LDu+pPpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745861142; x=1746465942;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eV58YpVitFfrDHc1mLy+J/2yxUl6utXch5ZKuMNQutE=;
 b=gSsVuBMQn7VIb9DQqE1bM5Kiit7OgwUcOnWb6DP618aN1VIubFNPUA252sC5+RDPjb
 5h5TpucUVHFCbiEkupebLB5gEwCT2nFxvnxBw/k9DyaLzFH9oSKPZr0X52DH64wLLa2G
 R8hOvHDdKtOW5YwakO/OYApEPI1p0vwHhGufDyhkIWSy5jg5cWPgz1djlOs38JrG0L+w
 +PJCr1TkpGW/80EMdBDTP1UhbFU/eJ30N+PAybPg20lIyWhGT4LZbQ+WikNT3KA1WBMq
 VFdRT+K6QS3qd3AcIsxTSwmBkhValta2StrW8vMdTUMQk8WkA1An6l8PVJPlwlFJW88F
 Bjng==
X-Gm-Message-State: AOJu0YxQUsI0ueA2+1Ex4Z2KiCrPzQDZvWHzkf5MJ5jmDkXDQ17gFt2L
 KjhdThL24vgJUbQTqsZQNNFFBEHLRN13ubOBu+Lqbar/HGNABcLKIu+SPUxSPW4=
X-Gm-Gg: ASbGncuwTXOgLOVKNdVymQo8vPNiaRtqCDBsPF0O1LRFyoRbNqyABZ0OY8/Gtr4wj1q
 dIH3UAmzNc4AaTOiswmWifEEbpsXN7nT8GrMiYTv0ZRBQUwBd1bOFAv6M2KQwcR9MHbH2q6NjQX
 8jBkOxO7k1KMHDZxOzQ/io/yaqdIxoTSIfU9YfnN9Vq3xCiFQW4MzlS1rM6nTikmDEpls6j8VEz
 /rn/zNTyc4od4cUngy2Tv3HV7hBJFO7IKe33SHr0UHimAffDIzo0PcmlL+oeBthDelcjALMTrM8
 3TW+5TQJppGGRL9W3CSPa6ilGkeDND93vm4DeCvGIhCDUxf/S6olmoxsxcX167lQTbNQ09QlsoQ
 96q+tfWPkE+p2
X-Google-Smtp-Source: AGHT+IH9NcRe6nFa36cf3xpzFey0yOnZwsJdJZiG8B+zJeayEpnkXk2sZYzad82eL8EltSxvqLleCQ==
X-Received: by 2002:a05:6820:206:b0:604:99a6:4e90 with SMTP id
 006d021491bc7-60684c67549mr62821eaf.0.1745861141860; 
 Mon, 28 Apr 2025 10:25:41 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6064688141asm1963216eaf.10.2025.04.28.10.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 10:25:41 -0700 (PDT)
Date: Mon, 28 Apr 2025 11:25:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, khasim@ti.com, vigneshr@ti.com, afd@ti.com,
 m-chawdhry@ti.com, n-francis@ti.com, b-liu@ti.com
Subject: Re: [PATCH v5 9/9] doc: ti: am62: add falcon mode documentation
Message-ID: <20250428172538.GE5495@bill-the-cat>
References: <20250425145644.2228186-1-anshuld@ti.com>
 <20250425145644.2228186-10-anshuld@ti.com>
 <20250425180511.GW5495@bill-the-cat>
 <D9I1U8TT57S8.3OE688N2ZHRST@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y5WVSMHDeXAcx7kJ"
Content-Disposition: inline
In-Reply-To: <D9I1U8TT57S8.3OE688N2ZHRST@ti.com>
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


--y5WVSMHDeXAcx7kJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 11:44:06AM +0530, Anshul Dalal wrote:
> On Fri Apr 25, 2025 at 11:35 PM IST, Tom Rini wrote:
> > On Fri, Apr 25, 2025 at 08:26:40PM +0530, Anshul Dalal wrote:
> >> This patch adds user documentation for falcon boot for am62 platforms.
> >> The main section is added to am62x_sk.rst and other documents just
> >> include the section. Steps to build falcon support, usage and the
> >> modified R5 memory map have been documented.
> >>=20
> >> Two svg images have also been added for reference, one for the modified
> >> tispl_falcon.bin and other for the falcon specific fitImage format.
> >>=20
> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> ---
> >>  doc/board/ti/am62ax_sk.rst                    |   7 +
> >>  doc/board/ti/am62px_sk.rst                    |   7 +
> >>  doc/board/ti/am62x_sk.rst                     | 248 ++++++++++++++++++
> >>  doc/board/ti/img/fitImage_falcon.svg          | Bin 0 -> 5511 bytes
> >>  .../ti/img/tifsstub_dm_tispl_falcon.bin.svg   | Bin 0 -> 9466 bytes
> >
> > I suspect these SVGs suffer from the same feedback that was given to
> > some of Neha's recently, which is that instead of being good line SVGs
> > they're embedding other graphical blobs. Please check and rework these
> > so they show up as just good xml files on the inside and not binary,
> > thanks.
>=20
> Actually the issue seems to be with the .gitattributes file, after the
> commit 284ef1bbcefc ("doc: memory: Add documentation for system RAM")
> all svgs are treated as binaries by git by default. The content of the
> SVGs I posted is just regular xml but git still treats it as a binary
> blob.
>=20
> For now, I'll send the next patch set with the svgs added as text files
> instead.

Oh. Lets just fix the gitattribute file then, thanks!

--=20
Tom

--y5WVSMHDeXAcx7kJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgPuhIACgkQFHw5/5Y0
tywNVwv/W1a5r8Byo0hHsFB7/yiANd09spmezNntSxQjtLmFWIbw2KBajWnTZ1eZ
T50MBXlA9EpCyTXeS2NrLEaRIlbD8oxCGkrbRfnHsbluL/gs4ah8llTtLEyTbFCP
cO5TEOlnbAz0V/9A2ZPk+lkoGlLEivEeAh5SflAL9Rwo9/yWbqKvghgeT6fCI3wo
McbkNrelOtcVb8BA2OpF6+V85WZzaJLhOhU3bERmGh5RO5nOBhFwh9vP0r0Xzuo2
WJXvzXs/R05/pTLG3LQzhOSXSO+Ye/RBX64nGSDtfVQztaLetMrPD9eOgb9oi11f
VYnfd+6iNTzfN/X5NLQKqm9CssvVeJHwtFnAPEDyGmBUQFjw2EBYpRv1IBfsb9q1
b//H3z5902WxAt8MQck912Gg4TpYct6lcJ79SajUm6iS4ZYioKflNF19qM6lfHOJ
yb7YjCkyq8wNCUGDJk35ArDhXvOlbfNaWJVJDgiz56EIoL6rDva43/98qwnNGIdE
+Lg/Fgh2
=QWnT
-----END PGP SIGNATURE-----

--y5WVSMHDeXAcx7kJ--
