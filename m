Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F34EC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 14:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD0B81DFA;
	Tue, 28 Jan 2025 15:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rEjUzh2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 571D681E5B; Tue, 28 Jan 2025 15:13:12 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 335A381DB4
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 15:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d8e8445219so49797996d6.0
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 06:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738073589; x=1738678389; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CJEAYNfrDuigyHFHp0FV3WXdP6RYRjSX86+Z+JcwbMU=;
 b=rEjUzh2H5fo6I0jlGj3SyCU3S8o/FDxDZZS9g/orAKavFbIQsicb7jtUYwCdW6Js6A
 SpGOEO+GT+MQpVp+femNosdNj4vkIA/BRh74EqbU6qZZu+Dsh1N1KsOFuPLfJV/69esv
 BrbSiXDd6kEbQM4Oqp1+6pVuy34kuXimtFRxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738073589; x=1738678389;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJEAYNfrDuigyHFHp0FV3WXdP6RYRjSX86+Z+JcwbMU=;
 b=eN9w+pJMOkDjNzJ9/m53JTBmVVgLx+cu9lys6ADICtYMYCP4jCNKm0gNBw7CZQvfrd
 oAM7zbqEwX0SsPjXRr7SO4TWqyY7u4Gq9RF7JPHVVsLRnVNRPN51tfzSNulWPtwBNa/U
 ZT2zOz02fdO8o5UoXF87aKeDAzHuS00lFnfNqeGMGSuSlBTKXIh+ge64ycbZ5f45uvo7
 My7aa6Y2hMIFTKBO30TDMtkTAnu23JJMZgQmFHHMB/rThuu5Xwwgcz96h46spVJezKh/
 ZjJnk79I0/C44PQbLOLEbveYTo6IQh7ZNWRt2wj8jvjTGhJHXaOUkdTAXio8uCPIFOVe
 qMAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvapdmY+m/PHsbkifK7fTV0+NidRq7W17VtB7HIQw+b0VvSUKa8SmoIOzdTKsqY6T0lbyNJmQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyWMvE/WPc5t56sTtjIgrCtATLqd8PMJqXw0m5brnoJ5ghf2okn
 KCOUUXNkxedEMsr6lFJKF0+MTTsgwlJa50TxEkDKtWPc2KdwKRXdrrShXtn2sDQ=
X-Gm-Gg: ASbGncsmYAQsFkLQfCc741p22knoXM3gODFMxDThy1Y2tjwWunSsI0nYHTNG+naBB1X
 ID43ASGBl+WMh1oCVz3A/LAziLFw2e3vbwpM8x5cy+n53K5NaxaX1lAYbzICGmDsDVZGoqCFUN9
 f6y6xepCgnmx+rKGiwPnNNqfc4DinoEMa6UnQ8cwCqN8zaoKQDZbT7s0sAEYl0JIR7SHSmw2iBA
 /4rDX+CIMycmbKhAAD18kXOOi7t5Rb7En/n3RXpbCCtstqAoSJCXlgu2QF9d+92/Y+fJk+pRfd7
 6qTxNIYSDczNUHw=
X-Google-Smtp-Source: AGHT+IHrZ4JgzkaRrUvHn4a++qmVpgN1tDaZFkgqs5Z79MWAlmHxP+Haewo3t0kqenv1VhFx86jHJA==
X-Received: by 2002:a05:6214:5b8a:b0:6d8:8416:9c54 with SMTP id
 6a1803df08f44-6e1b217d47fmr719260226d6.16.1738073588956; 
 Tue, 28 Jan 2025 06:13:08 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2051369e7sm45693506d6.11.2025.01.28.06.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 06:13:08 -0800 (PST)
Date: Tue, 28 Jan 2025 08:13:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Day <me@samcday.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH 2/6] armv8: spin_table: add hook for booting cores
Message-ID: <20250128141305.GM1233568@bill-the-cat>
References: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
 <20250128-msm8916-smp-support-v1-2-39587f18cf0c@samcday.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ktb5PgUxqrBOOXoH"
Content-Disposition: inline
In-Reply-To: <20250128-msm8916-smp-support-v1-2-39587f18cf0c@samcday.com>
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


--Ktb5PgUxqrBOOXoH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

:n Mon, Jan 27, 2025 at 11:03:01PM +0000, Sam Day wrote:
> Introduce the weak symbol spin_table_boot_cpu, which is called by

> spin_table_update_dt during pre-boot FDT fixup phase for each CPU that
> has enable-method=3D"spin-table".
>=20
> This saves the board/arch code from needing to scan the DT looking for
> CPUs to boot, and also makes it easier to bring the secondary CPUs online
> as late as possible.
>=20
> Signed-off-by: Sam Day <me@samcday.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Ktb5PgUxqrBOOXoH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeY5fEACgkQFHw5/5Y0
tyxFigv/Toyc75Y/OE8QllHo3LrG2ezczdwyNw9atuOWESMU4TJqyypUjETuQmhd
yAb9FHqdfaRMAt/tQLXdmnVbqqgfslN6+PWaGZNbB1ZIyjhN1jXLiMSZqKxt3wiF
Gur0YM5lKWBRxcXJYrzE9txJZjRA/1QQ6JipGRZjMxd6Ig9/78atwxUrkyX86JgQ
QTlOItW9YS6A8BnxHkQ8ZdUEi1GhRyBAiJKLdEwMSwhGf1jFGVVHAVFtLVlLpmIt
KWvFY5nRau7DGicniGVtIKiJvTxxS9BL7Q7NQmS0d4YR4ntUlIHxty6z3QJ43WM0
uXxifGib8UJrs62dW2oRMGbTdubQyW7MOhU6qEqsYfEg8MRAWrTAF0Qju8+nw/LM
I/gbbguLwnLI/aZZu1s5rIWhSISPGuYQXnGmxXOeLjLUtlRYYEvFfGg6zFtEmTkM
hlQP2M/opbIsOj7rE0TBzt0Y7QelrHdvGKyb48hVnsyIAShzYNMWTQBhSmCcygq5
jQbA/bn8
=SXQj
-----END PGP SIGNATURE-----

--Ktb5PgUxqrBOOXoH--
