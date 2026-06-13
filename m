Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7AECD98D8
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 18:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53B98485F;
	Sat, 13 Jun 2026 20:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UKCpYsTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 853DC8484F; Sat, 13 Jun 2026 20:04:30 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7209F84869
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 20:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-69e505c7e22so671573eaf.3
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 11:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781373867; x=1781978667; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AVoskDuX9AjnHuBotIwWcqypd6g7We1rBl6udZ0isTw=;
 b=UKCpYsTvX2Fet27doTE+Jh/zUJp3+PK1GBXx5njzvRC1hakQdsVKfxaSaaTQ8e2CaW
 J8J4SWBcrlfb1JWnZJ4CjEe1/Szcr7zzJs/jbOTQ5JLPOe0x2PgNaPrbKprLuL6N7JV4
 gkQYMbxGgpfp4wbhtP6/y6nqMWG7iqJcASOr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781373867; x=1781978667;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AVoskDuX9AjnHuBotIwWcqypd6g7We1rBl6udZ0isTw=;
 b=U8k+hMPZp+Iom/kimQuRX2ohJJXQaupnyfPiv7ZYs9kAWEx/TU5mmwpNhX5o8vSUWi
 MY/Js1Qp0sJqYHqoHe5KT76xyPmrbl6tX3Ujqu300J7RgatY0evb5gLi2tocVQjMj8ne
 5B9I6hQItqTE4chWoA4Y7Zd9cu2sOXny7yWQ+yH0l2SJ40Vs+zP9Tpzz6AYKERrE1rY3
 LXG7YlrpOsGMMWZvvUua4Tqok+LPiEoNCVXTjXNbZ509ehOGgyhBr0nixmUXFczguwcL
 Ev4h/lg42dQg9heiMCyhyRDwd9uBJK95lY2jCevB/cjJTkQc/tAz9QLR+coEpyy9UXU0
 W72A==
X-Gm-Message-State: AOJu0Yxdf+BwFdiWlrpNwCZqXlzPiBl6/6s/s7uQvJnzkc/bprxthQ+j
 IHdZVpgaEMsLBEi4JOnkzxUiSpalzHEFheQBxqnvz7qt+bbAV7AswOTQFA1jJ8Ae3RA=
X-Gm-Gg: Acq92OF22Up7edBmaRdpZ7dbDQDBnt4ijder4khzYzK4MddkzVAIyT17Vinn0u5IRRs
 NgH6/rM0xj3wPPkZlCUvsqHskhKi+CYya4hK6j6CXwcbNMZoDTzj6Ho7AoKwCIJxjb8VNsmxwtv
 CkQaJ7NfGKodb97e3e32iKVT9shpI4Fr4bFx5ZfpljEBzioZu2yIGGJctgTpaT7b1abKiohqfR5
 AQAQDu/hQRi60vHEcc8qCL836S18SG8jQL1ihJUJoHV9V1PqZ595gBVhVS7p/f4tGHG2bivczC+
 WTaVVJu9tw765UXu0j0c1LLJd6vwRFJbYn1ry1GVNaQYCHQ+7L/y9vfyf7UOD8h3i1mBF3vSQPa
 FP3RUVJVOOHemMZ6c9XDzdj1KhCJioZTvhA59iwNklT28L+1Dm5dGJcQbq/iAEoq12DK6+KplG6
 vPOWD/lzrOng/TRkzYW5SvaEdpFj0WFshUnUXTqeUvpYkzEQCJx2rX2LHb1NWC5F3VdpTsBHj7y
 ReFwuNlWWB7cokGfv0vV9YEh2tHRL3CZyW0FUcvrS2c1lCg
X-Received: by 2002:a05:6820:81d3:b0:69e:57a1:8923 with SMTP id
 006d021491bc7-69edc620813mr4986689eaf.14.1781373866984; 
 Sat, 13 Jun 2026 11:04:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4426a449e79sm4739104fac.0.2026.06.13.11.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 11:04:26 -0700 (PDT)
Date: Sat, 13 Jun 2026 12:04:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.denx.de, sjg@chromium.org, vr@binarly.io
Subject: Re: [PATCH v4] fdt_region: Check return value of
 fdt_get_property_by_offset() calls
Message-ID: <20260613180424.GV382693@bill-the-cat>
References: <20260527112443.13870-1-anton@binarly.io>
 <20260602183017.63967-1-anton@binarly.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ztRcQHJ4AUubziSI"
Content-Disposition: inline
In-Reply-To: <20260602183017.63967-1-anton@binarly.io>
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


--ztRcQHJ4AUubziSI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 07:30:17PM +0100, Anton Ivanov wrote:

> fdt_get_property_by_offset() returns NULL for FDT with version
> less than 0x10. fdt_find_regions() dereferences the result without=20
> checking, leading to a NULL pointer dereference during signature
> verification of an untrusted FIT. fdt_add_alias_regions() and=20
> fdt_next_region() also lack validation.
>=20
> Add NULL checks before accessing the returned property pointer.
> Also add a missing NULL check for fdt_string() in
> fdt_add_alias_regions() and fdt_next_region().
>=20
> Signed-off-by: Anton Ivanov <anton@binarly.io>

Applied to u-boot/next, thanks!

--=20
Tom

--ztRcQHJ4AUubziSI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCai2bqAAKCRAr4qD1Cr/k
CtEZAP4voA1kOrN2rwqNv7vF5KihZX5l/Om4b7tEjmAYaM2u+gEAznxKn/cKzv5O
9gM4FB2hV/HZEeqPpAxIfOJZC+ks6Qw=
=xK4K
-----END PGP SIGNATURE-----

--ztRcQHJ4AUubziSI--
