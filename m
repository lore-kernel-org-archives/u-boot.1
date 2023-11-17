Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E969C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E50E1874FB;
	Fri, 17 Nov 2023 14:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m1MfiQo3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FFC9871B4; Fri, 17 Nov 2023 14:41:51 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8638D874E4
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:41:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41cc535cd5cso10440401cf.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228501; x=1700833301; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1lm7IIOJc1DCT5aFcm7dQygLnoLp8o2WfUdnw1tLfjI=;
 b=m1MfiQo3PxXWFo+sHB9bg34CfNZ2xkQ2EPbSukvhEb0jCqxorUfUH8Tzq6xRqccODj
 5r0ow/+COlUqBoEKdFfc1fWrKwXMTZEDJlRwkOVEoIFT8saMBet2DIE8s7IbcKXfJQe6
 XS+oVdEFPp7HEVgTI3T3PYp/9RqJiEVMBZS+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228501; x=1700833301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lm7IIOJc1DCT5aFcm7dQygLnoLp8o2WfUdnw1tLfjI=;
 b=K/kDN1sr4stit1Dt3sh61a8UJzKI2b3+Iz053v7mizYifP4efqHFJRHRNabaKlF492
 5qGu2OMe4kd3rUiIy69powEgMg6NCs+X5Ib3Kma4CxEQCySYVXii/OMM1gOETWhElKtP
 D4EbdUwZKeoXjgUtZv3FrCfRFiHTKbVmWycaBVaaBVLoxDUuUnNMjXQlG+FKHlRGxu1C
 71kT/EyUE9KpMOdOiv+lXVTM7DicBMdP1M3UtTwtAE4lvBPvPfFd6uNrVDrbELtGW+S6
 nnq/LgirCKzZ5kPeaOtc3FPJxF4d0bgNne+Vk7zYrSb9spnh2CT7XuCj3hcJj2bJ/aeR
 /3fA==
X-Gm-Message-State: AOJu0Yz2rzYzd8+IeVzWSacrWuR2PpHse4iAEaRDZZUFUcwpwXG3sFH+
 S8S4vtMhGGtW4Fh3EuMx0F/A8vfv5a0oXJuib7E97w==
X-Google-Smtp-Source: AGHT+IEmwk7JcV+70mTkX1jtTtSmsJ1kvfoWlsNqKbRyIAW008VoA6UmEQeIe6SRDENzCrKI5np1kA==
X-Received: by 2002:ac8:7f0a:0:b0:417:eb3c:494e with SMTP id
 f10-20020ac87f0a000000b00417eb3c494emr15062355qtk.59.1700228501335; 
 Fri, 17 Nov 2023 05:41:41 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 fu40-20020a05622a5da800b004182037f655sm587519qtb.14.2023.11.17.05.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:41:40 -0800 (PST)
Date: Fri, 17 Nov 2023 08:41:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] fs: ext4: Remove unused parameter from ext4_mount
Message-ID: <20231117134139.GQ170968@bill-the-cat>
References: <20231108175109.3507947-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p254yclxhXwh9nyZ"
Content-Disposition: inline
In-Reply-To: <20231108175109.3507947-1-seanga2@gmail.com>
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


--p254yclxhXwh9nyZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 12:51:09PM -0500, Sean Anderson wrote:

> The part_length parameter is not used. Remove it.
>=20
> Signed-off-by: Sean Anderson <seanga2@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--p254yclxhXwh9nyZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbZMACgkQFHw5/5Y0
tyx3GAwAnBHEcp4Hd43KVukO3c1GIcj/y1DEd1YycC9rNOHhQfr9v1hR2r220su+
/KXA+ivnqE6jv7UcV6h3Vwol4U+wbGbPYkFyFJkZGfVYtZ3zpeZDGSg9BorBISfW
RAPMK/gvKJWeGqiser5aPJJbnNFOedWkeH4lvFIpP06p4tHO9aN1BRIyqq/snfy3
JEU7PZwFcsO1Jghc11kJsqNpP03oWy5iGb5mWMFztOUIbrvmc1YMMYDhX7I9LcKE
u2x/ClCmhuJA6B2QB7qT5xe+DlNaFgqhmKimJHbrqRAElfc6w2umgUyn1LZvCblf
BHXvAgTR1v92hPoczI97ekMnL+E4YHbtPbaIq26JZZ1YStBpOkgIJAV7SaMjR8xd
i0lTuxhTDfN33mTgeCrVNjrSfUR83rFBBuEAWwb43Bm6/qhUF3OaPYia/In1eWLE
fdWnTFWodf5MViBkdkWlqsUWASG9qp3U8rxgnFK6qBEkiYhjXBP/7a+2GiA9XaOY
EQsXrs+D
=k5qN
-----END PGP SIGNATURE-----

--p254yclxhXwh9nyZ--
