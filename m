Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CA2C47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46B2E87D59;
	Fri, 19 Jan 2024 17:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nJarvYlN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94B8487D32; Fri, 19 Jan 2024 17:09:40 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0097E87D52
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dc25e12cc63so1176815276.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680575; x=1706285375; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BdxXKL4PhRZT5WThmQ+PEZ51UaGV0+fXckvmE686mOE=;
 b=nJarvYlN6i0aHkC+MUekDd6VGmdg0YXUzjOUTbQZZxeJYq7s8jLIhryiu09m4xk2IN
 qENSyHth7tfs6CSJ+Alz9jm+p1Bv+uJCZ/rfoN+e7nI/LmjOgp2NIoUDLu+zRaoBNcOp
 6qeWu3e7Pv8td6N6MwE1AEC7eZV22It2Kls6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680575; x=1706285375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdxXKL4PhRZT5WThmQ+PEZ51UaGV0+fXckvmE686mOE=;
 b=md3+47TZVSofqTMXPUG3GvFBDLjZYrYgh0jalV5rQXdJuo4iTY9Fe999qwq8gu2uz9
 gmcE5T7GgERlAt/ak7E5GBRaHNAYACMvz1tHtF41JX3Z32w/ZTME880S17pHUirHxaaD
 JJvqfuJvRmqOMzekgjsewbMQnq3f19uf7ZQjlm7wSu+U3TQ7l0a8YcQK/ukMsz9hV8UP
 7HUy2Mm+gU8VEc+KRW2ZYX4A0kHCfHtjTYUS4rqNcvE0f33QznjfSmiYm2Gji3JDZ1wQ
 Z4W+r4PAUSfjwxhNwcbnwF0YM8xQu8i+A/KRuUJTmTNrbqftckIPpeqCvKLZfLDvcrZr
 +6gg==
X-Gm-Message-State: AOJu0YxfPzYGM3i7bO9pT9th7AWRM6STHkRScK0z0ZMByfBefCe5BxuS
 BhTVO3FTtradryAJlZFLnRarb0luJcyzH22yCbhRaPqHq2g8HJiV5Ym8nDq0Rcg=
X-Google-Smtp-Source: AGHT+IG+U5zzYxofz79xZItNrCcPDgbZVcr+7M3lU7gvhJE8PEBfaIRlhDs3gdMyccKIQoGJjqaDiQ==
X-Received: by 2002:a05:6902:1207:b0:dc2:54b0:533e with SMTP id
 s7-20020a056902120700b00dc254b0533emr92767ybu.39.1705680575689; 
 Fri, 19 Jan 2024 08:09:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 o18-20020a258112000000b00dbed7110107sm6610133ybk.12.2024.01.19.08.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:09:35 -0800 (PST)
Date: Fri, 19 Jan 2024 11:09:33 -0500
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: u-boot@lists.denx.de, Ayoub Zaki <ayoub.zaki@embetrix.com>
Subject: Re: [PATCH 2/2] lib: rsa: Allow legacy URI specification without
 "pkcs11:"
Message-ID: <20240119160933.GC12635@bill-the-cat>
References: <20240105140804.14383-1-csokas.bence@prolan.hu>
 <20240105140804.14383-2-csokas.bence@prolan.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nY0lVXLvNFjATKi7"
Content-Disposition: inline
In-Reply-To: <20240105140804.14383-2-csokas.bence@prolan.hu>
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


--nY0lVXLvNFjATKi7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 03:08:04PM +0100, Cs=F3k=E1s Bence wrote:

> But emit a warning for it. Then we can remove support when
> everyone had time to update their scripts, docs, CI etc.
>=20
> Fixes: ece85cc020 rsa: use pkcs11 uri as defined in rfc7512
>=20
> Signed-off-by: Cs=F3k=E1s Bence <csokas.bence@prolan.hu>

Applied to u-boot/master, thanks!

--=20
Tom

--nY0lVXLvNFjATKi7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnr0ACgkQFHw5/5Y0
tyzuLQwAr9c7WMV5JREoPuj0uDLjtqPTaVl0EFeSm7POW+ZTUcqZ+MsPQsyZElxR
zq8xKTtQGel7a7js2VrjuRYsnBMIZm6xcQmnviTVDy6BUc7zqrMYDWfiknc07oEw
yp0Sq5txZjTSpBI2Mpz2CTCdxwOn3g3lKWEHObWAXyrZ07c4DEGOgqBCqmHwquF9
jfR4RtcQPOrCSGW25l6YlTHmIM+nCVnBYRb0zxly5ZwP4vGOdEUwef1QaPl+tZXh
A9TTnVX0OhYwKvMa42UCqjhufJI+g696TLIs+ZpqTKIed6m2pqV1KxaWtJhYQ4T4
00Pnxaw/uEm5Q6WSxsR9rZQMvka3l5sFnHEXHIVXZjiyEpsNzzc0qxwy5o3aCZCG
Ek0SOPj7qWklvarPY+3CI/JoLhWSu1EVhIT9eSWZw2jCPcDpIpS+VotCETwI42ae
Y7UKGBYt0Gyi+hzcRxzi2NEVeo5/FrWAE/CDIL8IXv9iD7PnCDB+eGzUDe/FV6xX
vO/grCHS
=LyxK
-----END PGP SIGNATURE-----

--nY0lVXLvNFjATKi7--
