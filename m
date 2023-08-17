Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B28C52CDA
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 19:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D27B486BCC;
	Thu, 17 Aug 2023 21:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YgOtGH26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7472786BC5; Thu, 17 Aug 2023 21:02:09 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D5B86BC7
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 21:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-58d41109351so17746127b3.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692298925; x=1692903725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KhFnv97nXzef9PlnF8k9GI61/4sN4auxOTF/Zypcn0s=;
 b=YgOtGH262+0hjLD2g1CUIOYFDP4W2hdy3E7f6N9nIWpqhZt0TdLjzvYNsadU8k1jLE
 4kWbDwhHvnU95mVNbASViL2LLASDm8feX714Tp6jPeNcHgUngcl2KM6nSOfhmN0tbLJX
 lq57rQMybx40KOIo7Z9WT+6XI/fWXup+FzNJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692298925; x=1692903725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhFnv97nXzef9PlnF8k9GI61/4sN4auxOTF/Zypcn0s=;
 b=fqvN1d3lRHWR7F0S7H6mQ3iaU1JfKJYYPuNSWAT9HoltyuBzkaLIVEinz0s1R3GuZC
 J9ZNTNT8TSH1f0vlvEHbg9w/i55DgDSBA/T37BGsIV83HHqSkpuLtiMVdh4wZfIcDr7T
 oDQxvNdEOv6PRoJJvc77HJsQ39dePv7/dVp+mtUhApCxfacsJyLYm8UTiZ2uOKtJHKxJ
 goaiyOOsftJADGV3Jr7+aku3+iKShTez9066buXtjMTV8PGJv09OHhcca+YJ/xfNR9Td
 RnwbNy0E0MSRoiXzbwhi1DSO7gNeOein5bJxzCWWdU4LQYxC0/T7j1xixvQu/uGuNDL8
 4R/g==
X-Gm-Message-State: AOJu0YwF8UnjcVIOQcVOFxy7DdPbBta0G/aEt2b3d3rpMpSLMzRmJG1M
 NbeII2WOuiuBKmB0uUghRSzz4RhLeEZTC3mwep27xQ==
X-Google-Smtp-Source: AGHT+IGKsQZOKURI/9HXTJrj/BPosYDYcYamntI4nWNO9QgK+Ttsa5c+/nEHAwRNvE2ePeFb6CkvhA==
X-Received: by 2002:a0d:d9c7:0:b0:570:2542:cc9b with SMTP id
 b190-20020a0dd9c7000000b005702542cc9bmr315212ywe.18.1692298925139; 
 Thu, 17 Aug 2023 12:02:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 g123-20020a0ddd81000000b0055a373a7e5asm43449ywe.131.2023.08.17.12.02.04
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 12:02:04 -0700 (PDT)
Date: Thu, 17 Aug 2023 15:02:02 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] arm: Add arch/arm/dts/Makefile specifically to MAINTAINERS
Message-ID: <20230817190202.GL1515023@bill-the-cat>
References: <20230807210811.667320-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jn+yt539CauKsez0"
Content-Disposition: inline
In-Reply-To: <20230807210811.667320-1-trini@konsulko.com>
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


--jn+yt539CauKsez0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 05:08:11PM -0400, Tom Rini wrote:

> In order to reduce the number of people that are cc'd on a patch for
> simply touching arch/arm/dts/Makefile (which is a big common file) add
> an entry specifically to MAINTAINERS under the ARM entry.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--jn+yt539CauKsez0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTebqQACgkQFHw5/5Y0
tyzACAv+JZj7Mbq7exZZeX/N2YNBEYo/AvZPRDDPk/XzZndJJrZLCT79VZIkOdSw
Tqx4k6EI+r4oWDh/vG5C+uSfJqbWaIkd8pLU/M7jMOCbO9m+fBvdLyLK0zW8uO0P
BgEOn3Mr+5c9uiX01opDONdtdBHQaIaRjlGhvN9ZiCp+5bChBP7R8zoZZJ7BMaY5
zvXkcQjaTGAImVBMdCCd9XcQhh62B5I3fBb/dNS7kOHS+LRd1kIz3AgnlshxwWWk
fe+8qLmTfCQ3WJRVVS8WJpwsQ55GVA2+zet22N4AiXNBpD872t6fsyuGZBFiv4bb
QyLsoFJ8H2KKl2JyEmItqHE3OUbdbPqd0Eerro+j+9rjFBeZecU+uKykq0NgdAdJ
dxfhdILbM9Jx+6BzQZBoHdXWzHJTK2f4XDGcEzSihewZXKM9vEMmgH1CfBDIFKti
Zn7CixFo4xnNLJKaQGDaxGL0pXpfmDD3yDIARDitV3GtxSSXk9tLq1kUQ0kXUBcQ
83yOGKMi
=2paj
-----END PGP SIGNATURE-----

--jn+yt539CauKsez0--
