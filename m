Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A98C54E66
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE13187F28;
	Thu, 14 Mar 2024 01:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sc1Kyiv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A10987F28; Thu, 14 Mar 2024 01:39:24 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4418487F6E
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3c1ea5b42e7so275904b6e.2
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376760; x=1710981560; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xxchcH2kGmshZsVsb/Yca3csYYzv8bw48QZ+sAoMHyk=;
 b=Sc1Kyiv1Qgyoa3Xyy4ovMVbztat+uVTaHEoVoPYoPKuZHqFyTv9A1pPf/kcebxJpjF
 DuP2nLzztrmUukRSzoVabwJdPjvLSZ/vxQfg3sLYoc4VnlRsAei8ZWSaj86zjvvg0nk7
 5GTbLBQtJbB2ghzFhk+Vk/I7zLOBK0mPbMmZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376760; x=1710981560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxchcH2kGmshZsVsb/Yca3csYYzv8bw48QZ+sAoMHyk=;
 b=byr3//SGaQglmMYHuVVSc9SO/5JsqwGEsvfZIwq4vR/3khllH8C6FJM2tKF1d89QV0
 fC11tikU8VQGEiKezYakt37Aoq40K/DOeRFsUT5szLhzQbPg4k6f/WOMw7SYHkSCabS0
 4ABk4fqydSThwI9Afdba5hIWAjSGDr71rjDDV/CmnJwmaf1d6hR4zwW5fXiaiyiDTdav
 ThYmKf+GmhqMiGSEG4/hYblyRsFCA8Brmfg/Ceo7rJidGkKtCEle3KNNu3HV/WiNeu9v
 VvglmDR18faN6vxJku2CFjDo8JF94+k2gqk2K53D9Gj9SHGt5f6X9y19HztXva5fFJ4n
 iw8g==
X-Gm-Message-State: AOJu0YwV1okg1kClv8l1r625UX32pyRKybZk0FsuANQdkqcnTHh1NxXh
 Sk2gTqC4lbhGk0ljKd2FVeTMsEiqbTsGsGCH8tS6BnaPaJgjrsAiRaeA3OwCUOprE1bKVk8PYcF
 c
X-Google-Smtp-Source: AGHT+IEuNk/iM9Cjy6CTZG0hhIFD/C+9qBc6+r7ihb0BS83D2lG214FykF75eEalEV3Yai4Y9dvJKw==
X-Received: by 2002:a05:6808:22a4:b0:3c2:4e74:731b with SMTP id
 bo36-20020a05680822a400b003c24e74731bmr299463oib.39.1710376759948; 
 Wed, 13 Mar 2024 17:39:19 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 o3-20020ae9f503000000b0078821519902sm173010qkg.20.2024.03.13.17.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:39:19 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:39:17 -0400
From: Tom Rini <trini@konsulko.com>
To: Hanyuan Zhao <hanyuan-z@qq.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 1/3] cli: panic when failed to allocate memory for the
 history buffer
Message-ID: <20240314003917.GH3442575@bill-the-cat>
References: <tencent_2AE7952872F803E81AEF7D49589E6CCEFF0A@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6+h1UriUZY/LIBZl"
Content-Disposition: inline
In-Reply-To: <tencent_2AE7952872F803E81AEF7D49589E6CCEFF0A@qq.com>
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


--6+h1UriUZY/LIBZl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 03:37:33PM +0800, Hanyuan Zhao wrote:

> This commit simply modifies the history initialize function,
> replacing the return value by panic with reasons. The calling
> chains of hist_init don't have steps explicitly throwing or
> dealing with the ENOMEM error, and once the init fails, the
> whole system is died. Using panic here to provide error
> information instead.
>=20
> Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>

Applied to u-boot/next, thanks!

--=20
Tom

--6+h1UriUZY/LIBZl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyRzUACgkQFHw5/5Y0
tyxx5gv/aG4/ZbXEoKjUstXbL9KnP5mCSajV/HJ0eD1kLdFXTeML7STK4mmSj+Es
18N49GkM7IT5KFwkGhyeh/YezJvh73sFn62zQkajPaGT2zKejjf629BiK3vsINn5
Q3gGLOH421M0eaBFAZcmdD51A1AYTLFQEArV94VOEDUJLSThKbxQwIAjlnGN39NB
DSEjT/ur+Hf5gH1AeAeImlMr4oqwkrBhaQ3YanBcAr7ygE8BEqZ4a5pyXYwDGQ+T
xy0aaCrJYcHOI8pp/MAK2RVCrGbLDyPx05sYFB1OwFSD8tUFpW2L5ewnZ3BC1vEr
EBRXH8CrX3F7RfmB6F3A8J0zRgWaC5oYlBC5uouzomx4iA5Bop4viHGIGYJ4KuEg
g1xLl9FxBz1bg8wy+uLZd+xKrBB+RCbMJZB7HT6T41iTENNqY75LI1W4B95TuxI/
xaicDmfJpcVMYVxB8LiUWaWGn5cRt/D5dOe7oWBHsPYA4lj6cNG7Can2Xt3IxHFj
BVolPGH+
=7RfN
-----END PGP SIGNATURE-----

--6+h1UriUZY/LIBZl--
