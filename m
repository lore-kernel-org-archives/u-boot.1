Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34BAC282C1
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 17:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DF8C814A4;
	Thu, 27 Feb 2025 18:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o/1oDTcw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D4F811C1; Thu, 27 Feb 2025 18:05:08 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0583A812BF
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 18:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fea795bafeso1568530a91.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 09:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740675868; x=1741280668; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OPyU8CX2MELF2NJjBzrXg3fAkpqefj7XUFPe4Hs55Gg=;
 b=o/1oDTcwzRb8GYPf5imkOgEkecd/bb7nJjwvXanTa0CHv7dKjwV78rd/oVytp8SgKP
 SH+uHp2RWEzPavLwvHKGouO46kqwjY63pwwUct9BajQJ7MNCfJnyXv+uZb0dZaGIU8FV
 gU3+TOCBZL8v5BMBbP9RAdFc11pp+SUlF6eF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740675868; x=1741280668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPyU8CX2MELF2NJjBzrXg3fAkpqefj7XUFPe4Hs55Gg=;
 b=cjRqebFLkS1o0GIkmq+dN6aOD0I+HiwIv2xB8BfSJKXhrbQgg5PKAl+p8xLDu443/a
 xRRsx1rvX7gA4N4d0+pDwDGCOnJP1Zu7AUix0o55gsyU9vOkuKgmrwq3yqUIi5AecjSg
 3UAwPj+lFaMrd23y2yD3d7lNW3qJKTC/jzRqk5abQwPvgIGafeWkIgsM+1YloZE6/Fq8
 DqMQZHJBYJfBzP5tK4dZKAiPL/DC4zVE4GZfkHk6t2yMo2+IyqfVyMb7AF6L2/5qCkqC
 ++3Y3GHNjvW6aSohNM3xnlVDqkNqJNhA6tzu2Y0N9Sw4oXaygYKhwFebYFMDaYjWT3Yw
 mrfA==
X-Gm-Message-State: AOJu0YyN3LFk4HurCkTCN5pkmx9TfT/HDVE92D+GpMQtWcpC/23xdyvk
 azsBxWj0yoSueemrU3lc5TfPNeWc8Cz6oneWixQMu1A1rFfoEUzkhJ3jcrHUMWE=
X-Gm-Gg: ASbGnctP3pF3umlw0z6Isl7xq9xThgZLrWeAtiz0L1c+QfYA8nExPTRUQhFYimNTy4h
 iy/IhHZKNkaX7KY+L1OeDqBukQFepC7tbzxkAgSpT8zNeokBkIFiPIbPAl8FywPr/vGRaY9Vjjw
 9C1FTQG66D5UjR9cnZZC9u8q0zEMRm2wOj8m9fGD4inlOv0L4jWUR3fT8bhcLxBN0przrjIYeTn
 I+9n9E1pd4G2s95Ed7OcaeRB5ZdOBcGEXXKq0VhSgQAIbf/fBRCP1weF+i+uTPtinrM7Egsdhjl
 645KtZ1BiLF4QJVzmIBZ1ftl
X-Google-Smtp-Source: AGHT+IE32pYuN6wrOCNJCOEDM25cKX7SBgTrZ3a6McfI7OAnw9C6/YI8CM+ApP891IX9lLPxAx5jNA==
X-Received: by 2002:a17:90b:3b8d:b0:2f1:2e10:8160 with SMTP id
 98e67ed59e1d1-2feba92bfd4mr271717a91.11.1740675866833; 
 Thu, 27 Feb 2025 09:04:26 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501d2786sm17515305ad.6.2025.02.27.09.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:04:26 -0800 (PST)
Date: Thu, 27 Feb 2025 11:04:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 14/15] cmd: ximg: Support LZO compressed images
Message-ID: <20250227170423.GC2640854@bill-the-cat>
References: <20250226221607.1283592-1-swboyd@chromium.org>
 <20250226221607.1283592-15-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RyR1umAo9nUBFbRu"
Content-Disposition: inline
In-Reply-To: <20250226221607.1283592-15-swboyd@chromium.org>
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


--RyR1umAo9nUBFbRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 02:16:00PM -0800, Stephen Boyd wrote:

> Add support to decompress LZO images.
>=20
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--RyR1umAo9nUBFbRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfAmxcACgkQFHw5/5Y0
tyzEVgv9FW827NIEM/s7xZtHumLetVgp7hfHcmdxSNE4DVouuF8S1q4IxIvw0oI1
zJIHjuyVO8s9n/PplrqErqR+Jz+dGEC9q8JNQn3yLaoSewHkEVgUsXgAxz2P++vx
u7h7JvdppvNiuRf5vHio5qbs1p+mTLCDWhzNEvuPLO2BAGa0eT2MRrF8EqD1P8Rb
FezUBvFDkPxfxH0UO9xsbdtNyLbTtBoBOLBJMeNUCEWRzMRjE0gyW93taDNpthky
Ar49R1lqAhfLOZDxLBnwBDvkh0I5Sa9atxu5eo6Ix6BtFBcLeXCyNDYOOEyyU//D
P9WDCcyiZc/XYGF+jOp7lTvt6N9WOp3gD7K+p3mSBAthn5z6fRh0eYRUM/Sk66xD
E0aTNuhEx4yduWaGaOPS8ah6B1xU5OvC27G6BhB3ZHqcmqYNLP1CK/b8BtAu0gr+
8ElxsLYxhfP86iz3+6mSv7QtgzG3fOJa42zsCh+xvIJh/1wNHu+EiFG1SDhob2QL
o211Z0KN
=pIt9
-----END PGP SIGNATURE-----

--RyR1umAo9nUBFbRu--
