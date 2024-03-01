Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D34C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 21:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E37D488165;
	Fri,  1 Mar 2024 22:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CZaWlFfv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 892298816B; Fri,  1 Mar 2024 22:37:08 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7858588160
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 22:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-608ceccb5f4so18349507b3.3
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 13:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709329025; x=1709933825; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sUTxADevHKe4J1DbeB6q0BUIPxZwMZGJUdWLdhYA2f0=;
 b=CZaWlFfvWIO27puS7zdFTWwX5CYqySdhuzs2DICovuKgDKlLVZin/3xuIR1+YXsWqg
 91M9ZGuwUGQJUsKv8snJXiYsLkfOhEhFNSzEMherQplUvTzyBYPFIpw/0aj6q9CAOHe3
 OgY1SB3jkWsAvkWzTwmspRYpGbqFJPSX2hJSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709329025; x=1709933825;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sUTxADevHKe4J1DbeB6q0BUIPxZwMZGJUdWLdhYA2f0=;
 b=p7eiLFKGLuKWJdmrL8i/SBPYL+03xHfRbYNYP7Q4WLMuVpLSGpvKGU3KvJ5pTFVjRN
 8QK7DipWqBaPEp3HVHIpdGMQCfWnS2T7pRR7m/OXIbD7nj3yhWVECFCfxK43yBy8nNWu
 6SyzBteOa8FFl2tFL4HED4toiGKi+A+oTABPPY5oBCl1O6zrVgW+S+bIiaFy1CKdjW6x
 dUWBsOceI/Pk3Fkr9SgkVX4UfH8NlgFPqltP4DUFoyzV2XaGODGPfjiXdd4XBRWKtZMr
 a4mcIFiBV06UX9YxHWJ3Q0JdNGIo/bdG3tzRmcTyVdTgswdid28xpEhUjBZxBl5QSIVC
 ToNg==
X-Gm-Message-State: AOJu0Yz4buz5V11B+sNAKjtCwvNWZ4dkwJzLBOsP9t4gr90qa3oUO4PB
 TVkhwKJOZhwKgWFJJ1u6A6UDaIU455GUjaf+5tMziMGwvkSgpz40PH/k44Hax/E=
X-Google-Smtp-Source: AGHT+IGRNDYUj//X94HEreJDGTUCbVopl8vN8WRIs1/e9kJRMx1+tA43o+rJh2lWcs9NDphNEJdJCQ==
X-Received: by 2002:a81:4841:0:b0:609:25e4:8f2c with SMTP id
 v62-20020a814841000000b0060925e48f2cmr2809838ywa.1.1709329025009; 
 Fri, 01 Mar 2024 13:37:05 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 q129-20020a81b287000000b00608665ebcc1sm1163183ywh.52.2024.03.01.13.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 13:37:04 -0800 (PST)
Date: Fri, 1 Mar 2024 16:37:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Hanyuan Zhao <hanyuan-z@qq.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] cli: allow users to disable history if unused at all
Message-ID: <20240301213702.GA1401112@bill-the-cat>
References: <tencent_411A9B7DA959D26CCAFCE7961870C400E80A@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ulyyt5OVlhJVX2P8"
Content-Disposition: inline
In-Reply-To: <tencent_411A9B7DA959D26CCAFCE7961870C400E80A@qq.com>
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


--ulyyt5OVlhJVX2P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 09:54:43PM +0800, Hanyuan Zhao wrote:

> This commit allows user to determine whether to have history recording
> in command-line. Previously the history data as uninitialized static
> array would not directly take much space in binary file since it only
> marks size in the binary. However now it asks to allocate space. By
> connecting the original CMD_HISTORY flag in Kconfig, users could unset
> the whole history function, and the memory usage could be eased, if the
> history function is not used at all.
>=20
> Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>
> ---
>  cmd/Kconfig           |  1 +
>  common/cli_readline.c | 44 ++++++++++++++++++++++++-------------------
>  2 files changed, 26 insertions(+), 19 deletions(-)

This breaks current tests, please re-test, thanks.

--=20
Tom

--ulyyt5OVlhJVX2P8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXiSn4ACgkQFHw5/5Y0
tyxBQwv/Rt4huZaLXEO3V4H3pF+0lYNKM77i8WR24yqvavC48Y2AZh9xbhsAFUIN
SwoVuGuo6+JjLhJsPylrkZq6CCngM1N2UCaYI59YaVray8d3H2utTecDVXW0tw5Y
MBAM8J9uLoMkh8u/eoOrS3IEXBk9PMFmGJqFoz3q0DB8zHUJK0sZBieK2ddlK+TC
ue4a7My/3bC/G1sy/PxJDth1s3cO3aciRQRuZ+LyOQVa3Mkr3OfXR4fbWe8BUhqK
pCMxA/TFxbo20KKYGPkjWGn3JrlBaHSQtp9sjc6AL2sn063EACeyVx5cPe5I6NqS
HvlYXwIR5lFgjNWuCGbCIAt+uEt0tx0ofoQ6o14eX0fzNPqBmE52qpPWxlrHl9g2
uP3Fh617J139mupxeL0DI7WkrnfCZwK+jVAsCpYx6Cqj71vXzIRJ+uXm7H1wwl6J
0fFwW/rzdnvIDzGBWmNaVfVVGL2wETnnwXmdMkPWSLO1lUYvqrJ3MH3/1ZYZIri8
V6qwYEbO
=7uQk
-----END PGP SIGNATURE-----

--ulyyt5OVlhJVX2P8--
