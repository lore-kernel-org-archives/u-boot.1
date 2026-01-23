Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5524BD74EDC
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 15:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD31D83B21;
	Fri, 23 Jan 2026 16:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D9wM1jmo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B850583B27; Fri, 23 Jan 2026 16:01:38 +0100 (CET)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A4EB83B03
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 16:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-45c96b175baso779052b6e.1
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 07:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769180495; x=1769785295; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/Nuc/5nAK+Gjc9fqk8QXMYhEXY7K5VdNeF9JzoJR1+c=;
 b=D9wM1jmoLKbSAIQbo1racYTGkyx1B0sX3RovSrdfqgnWdmDxzDXe+phxxZWWrCyGEP
 IPU+kUrN8/K+hf67qZISTKPp2XGVGGw1tao1Gawojsod9QazA6PQ1o3fnBchJbWPlZq0
 HBsKMvCn0AGQ383bDbytM3iK7JAJrmjMoT2r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180495; x=1769785295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Nuc/5nAK+Gjc9fqk8QXMYhEXY7K5VdNeF9JzoJR1+c=;
 b=rPpS2zVGjAnV0VVfVu5yhovY26eiR7KvXtWhA6VXxWZ79UvwLLEudx1KIjS6aJjClG
 wAqPp/OxFUAA4cVUrU48V9h9is5zih8bMJkhsriR/3FEp0t+/ucnJmjQCpcPOi0sPjek
 wAEaAj7Bkr/rYHFUeoXZ33Nwnnqr/iqmBWL5NBPotVpRfLes9ut3JT9lmQRRoinTQgmt
 gZLWPHcOQuEPa+1vOaEkmKcqstWWm8Tq6xkvjftuWXJmJuf12MlZzZFRN2+5VY5ZIpud
 auqnMN+E0/TR7qA30KdCtiYLLy52grH/Ss39vLEz6W2o7ohGurR9OOcCCh3v4dVARSNE
 2+Rg==
X-Gm-Message-State: AOJu0YwwQ3oP20d+whK/4b3S5RrQewIR+T62tTuXJXE/2xxf0TfhVKwu
 qge32ARsdTLXllMs53IDutG7e3s6febg2QbIs6H+uEIkkCr3ApKkTfATfwDPy9Ym/wU=
X-Gm-Gg: AZuq6aLwyRUwCDVCqQLlj/biMTT8hOzvd6YCuJiGKA6pf3zeuHvTkGQ60vTaVXdkud5
 W1d7zGkyA2OrWkoYCjiyviWVeo40DaeCzJ704yMeumNGp3muwoAnI+bCpxSgNDwrCZ5RIodAgAR
 48IbWEwMu9a3AHActRzSuYiOkUfSN8dkycq+x6I/sxJBXOyOTPGETGupbFMuBVUhp7cUHlQHqRK
 pkWWi1DgYHdTm5t36dnsVRPVQ8nk/eiUCEwBBbOjbBlujEnr466Fl5/7mXi8gnwQsv6c9sxgqKO
 EdYYzlDzgjlxXY7IVZhGaIkMo3yKRnCDMFD3w0PAO6/x9w8ptbJBrSMp6xQgRVEAtsnfi2plJp2
 MkN8xLdw+uSuEJoY728NDYJ7D+Gy2yuhHx1Zj9MHrtgCVC2FB6KFbP+G4AkN6esaH8f5x+56y5+
 QAH5WqAp1CLFfSzjgh7byER5wfFb7n/8aNhAHpAMDkLi7QRSqBxHuPRIpkOWjaLpBJOV148p4ap
 i/cvTLX/mTmPP6+9IUeifvJNFDHWITJHnzy23bJ/yRi5uZJlA==
X-Received: by 2002:a05:6808:1911:b0:43b:8cf4:9284 with SMTP id
 5614622812f47-45eb1a81685mr1596918b6e.14.1769180492237; 
 Fri, 23 Jan 2026 07:01:32 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45eb40e39besm1359735b6e.1.2026.01.23.07.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:01:31 -0800 (PST)
Date: Fri, 23 Jan 2026 09:01:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Vitor Soares <ivitro@gmail.com>
Cc: u-boot@lists.denx.de, vitor.soares@toradex.com, n-francis@ti.com,
 b-padhi@ti.com, afd@ti.com, anshuld@ti.com
Subject: Re: Toradex Verdin AM62 boot failure on recent master
Message-ID: <20260123150129.GK3416603@bill-the-cat>
References: <d7d22e35540857e9726f4b435a73a1435aa4fe37.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PRxyfVcnnWxo9bd3"
Content-Disposition: inline
In-Reply-To: <d7d22e35540857e9726f4b435a73a1435aa4fe37.camel@gmail.com>
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


--PRxyfVcnnWxo9bd3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 11:58:54PM +0000, Vitor Soares wrote:

>=20
> Hi,
>=20
> I'm experiencing a boot failure on Toradex Verdin AM62 with the latest ma=
ster.
> The last known good commit is a4dc1c3b7d56 and it fails to boot at 64662b=
99c0eb
> (current HEAD).
>=20
> Looking at the 35 commits in this range, I noticed that the first commit =
after
> my last known good is 85f586035d75 ("ARM: OMAP2+: Pad SPL binary to 8-byte
> alignment before DTB"), which directly modifies the K3/AM62 SPL linker sc=
ript.
>=20
> Related commits:
>   85f586035d75 ARM: OMAP2+: Pad SPL binary to 8-byte alignment before DTB
>   8b0ebe054bb3 arm: Update linker scripts to ensure appended device tree =
is
> aligned
>=20
> Could these changes be related to the boot failure? Any insights would
> be appreciated.

You likely need
https://patchwork.ozlabs.org/project/uboot/patch/20260122172247.2995437-1-b=
-padhi@ti.com/

--=20
Tom

--PRxyfVcnnWxo9bd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXONRQAKCRAr4qD1Cr/k
Cp9MAQClfecMLn3321ClFBic8jOX+X0IXt8fh3epXWnSSnIbsgD+MARWnGguUe2K
tbE9BAgNyAxGSzZ9r2bSKKnl0C3idwI=
=VA7X
-----END PGP SIGNATURE-----

--PRxyfVcnnWxo9bd3--
