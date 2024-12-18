Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF35BE77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 14:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7121A80241;
	Wed, 18 Dec 2024 15:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i2a4SUUd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E005F80241; Wed, 18 Dec 2024 15:32:28 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C69788022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 15:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d888fc8300so31328076d6.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 06:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734532346; x=1735137146; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DZs2GhFQScN2DNjCv7v6Ti4M/tMuxHdYESXJVGvgB9k=;
 b=i2a4SUUduz3KmpRylenIktyPdNKpHPsyd95Vto16ms2ZX57pGIiBVodNb/zKO8IZjJ
 nq1POb9ihXtl382tFjeNIJfNKuxpTxK0q8w0tpw/eBnyOOTPMIXidteoseOGAS2IUxMB
 2ba/O6GQVrj3VISSkNs+lOQm3UEj1t+6Ub+qM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734532346; x=1735137146;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DZs2GhFQScN2DNjCv7v6Ti4M/tMuxHdYESXJVGvgB9k=;
 b=c0eTuuXGXB+C8YtVxaQsFPn4pTtFXjOCkqkFeR22HvhfeLbG+WtNcOlB0Rip7mPw/A
 +dQOfYA7PeF7ktxr2lEeHI7Ec8+VDcN4dRnno81Ro2LQYL1g04PzX1jHjz3CibxCRieJ
 YJ3lqXbbFX7VOkz8TNd8Z2oA0qtA15H6cs91VivqgfqOGsgQBLNsRV3ZHd03OeScIUxt
 lGtmN6thFW7GkfnyAndG3jCGbHCauPa5/KIiAO6x1sVcFNWu9MAzv7v2qxb3gYGY9E4P
 Z/pMbcB+3CqSTO+LmMQdYeW+VlVEnrnjzDvHYZNG7mShV+khMVcyMR63jH6FIhafUVbv
 1vbA==
X-Gm-Message-State: AOJu0YzuaPDuWBh9XM4zcChIxpvbJgOiU+pgc+DiMS5Z/CoU+wwO9Imh
 1/ClbV+GgZL46hkqCCgtfIFbM4PMfRm8Kqk0kW9DaZKG8HgGLx+Rn7h4DSwaoK0=
X-Gm-Gg: ASbGncvfMqLTgfLlzpdpLoF3S3HmSzgfwmC7vZYifvDJo5auXDGb92yOgIKPWT89nsY
 nriVh8c6T9OqB7els0vCyKQN+TZxUa29p/ICxBZiKsNxOaZGne0WV1RVORRkfrWgdaH2kn6DTlD
 Rn9EYsUVgI+xnTVudpXMcgvARV4rU0ImWwNXcjmru8T7p7KDlKlLTNzzdFcMzqcItXST08ROUl9
 MydBmHVMElkpMWjGqUgJDmohVIgB2JOS5E7XJORv25whJIRDa6UjLcH
X-Google-Smtp-Source: AGHT+IFZup5PvCv6vR0XI8NKcnj+RASyMAXvBv4B+4Ey7VT+M9iERjA5h+3WENNMH6vOjvrkMloO0A==
X-Received: by 2002:a05:6214:2129:b0:6da:da7b:c196 with SMTP id
 6a1803df08f44-6dd091c9334mr51867396d6.16.1734532345555; 
 Wed, 18 Dec 2024 06:32:25 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd257215sm50537686d6.41.2024.12.18.06.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 06:32:24 -0800 (PST)
Date: Wed, 18 Dec 2024 08:32:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 3/3] gitlab: Resurrect the samus in the sjg lab
Message-ID: <20241218143222.GZ1505244@bill-the-cat>
References: <20241218025540.3025522-1-sjg@chromium.org>
 <20241218025540.3025522-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rQowFTFcMKAmYwZJ"
Content-Disposition: inline
In-Reply-To: <20241218025540.3025522-3-sjg@chromium.org>
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


--rQowFTFcMKAmYwZJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 07:55:40PM -0700, Simon Glass wrote:

> This ancient Chromebook that nobody cares about is working again, so
> add it back.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  .gitlab-ci.yml | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

If for nothing more than my own debug needs, was this another
OF_BLOBLIST fixes it platform, or something else? And is this using
chromebook_samus or chromebook_samus_tpl ? Thanks.

--=20
Tom

--rQowFTFcMKAmYwZJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdi3PYACgkQFHw5/5Y0
tyxOvwv9GV0NGJ4S8zMQx5v2E6ZBDPrsYGaEGYLrGdHzWm8xXq2wHzAvZbuCr4bA
sHfR2kOYpTQ2i82Yd/ZtdfAJK8BdPX7+8BsFnBf+KnhqMmXTfgj4HwziTorKzszd
opWGt2U6owO6jb1kUCTgDlKn3lpjbjaRK4TxOfhhs4E8dwNYILxxGfmsHEEgh0/T
0FpRe46Avc2pjyn2T03Da2C782axVGGjJze5r1iXNzaaOGGIG42PkdloKOFJsInK
Wpv9c+KbS+7mb4JB9BTLIQKrybJJSp2EmoPSmxP5bO+AGV/EjsY1Uq4ojGWwKp5Q
2eLaPWaMgdZxJ9OjkNuOWKCKWxrAkiHzRZwHZMCg54SZaw70icl0O7UwgZXpIpBL
X7zGehuG4GW0gL993LVr8PlanM9z60F9R2OTmWVi+ip/1v44Cv9E8K1kJYe80GBq
+7yfUVQw/9NLBPxysKOdCxhH1j7nFRYQ3Fy3kZesHehilaz6Nsxnt4JXjCbtlCvT
c0e2fI+O
=o0YJ
-----END PGP SIGNATURE-----

--rQowFTFcMKAmYwZJ--
