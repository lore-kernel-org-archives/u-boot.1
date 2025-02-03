Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF44C02197
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C1AE80285;
	Mon,  3 Feb 2025 21:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iU8Xddqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526CD80285; Mon,  3 Feb 2025 21:08:21 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C649805D7
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6eeff1fdfso442560885a.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613297; x=1739218097; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Djt2r5JauhGehsoPecJcBWpGV0AOtik3BORorO/M9IM=;
 b=iU8XddqvWNdZdJgtJllbKTe3Uxu4HHU00IXQH4JxfSQN5dcb1+gYZbVyJ17bUStA/X
 kFPLcoMZSl4yxF5/z1QBJRFXncEtJ2lt5poe12RnLBUe+mNgwlG5f1j4TBpB9C+FiuM0
 BFgZJPonciz/8AbFeB46zHRBosMoZxKdgcdJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613297; x=1739218097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Djt2r5JauhGehsoPecJcBWpGV0AOtik3BORorO/M9IM=;
 b=tRhoHRXHcK9N3zA48jDXMzya+gkU75/GJQjrWahqg3KuXhroeDk5XiX/2tMUw9XaXA
 zihsnn+bwRAHn7xywc91rUZNvzgHo/RE8CqvH1IjQ/FHZU0iDfaIgPO8bVM2+HRLRSnV
 QIrhKf5F+JyW0Z5VRijKZWzW/aUGT6mpr/6s6HArBVaP57XTBuNFZ0urnC5CeK8m0fuo
 q2RjpD5wc2bexYSdSORMDjxhAwZTQ6EZ+CrFZJ4Ijm2jdJx7njnDC2rdQ7JhXxl/BJYV
 loeTzgC/H1CQ7Q5NtCM+59y3Q2dOJJjxEUCIwXB+gz2og6qy9E2KDpL+tGj24Q+hQxYh
 HMOw==
X-Gm-Message-State: AOJu0Yy+mgqlNTDpwAD4QoMPr8xcaOh7cdRYfVu3fowROIng0CJA4XNm
 qwOe0s0XEoUnUQqN3HQr49KFdhSM9jrOiPfLiiIYU0W7ACXwu4txkooffXeF1Nc=
X-Gm-Gg: ASbGnctChGLkBqC4Rx+y+2f6lmDMNPxQTndaTlJ/sTp7NRnFvGxNnK2HnMKcpF/x4Ic
 A51TqR39lHY5PPk2HWUBWUVGalnS3XProE6m3H+eHJMgglCJkkjMFolm/LT0pkGCGakUBjrSufQ
 sEgbBSZ+ternJvg/4uarAiC48a1AfYxQKJJRzg59h645Hv0tZ6c94gkU3n847xBpYuLFDk8rQ55
 rUf7U+C6H5JXZxvjM8slb4xJ0E8jQ2yQUhSO+xjsKFg+sR7SlaetYhwahkklOML99FVWa2Z+JFX
 IvuyhUUhLRT8BUU=
X-Google-Smtp-Source: AGHT+IGMy3kMzycV9zyjzq9w5FODRKkKvm5xsd1qA4Tz4cnmuG8O7RD9EV7Py1kfBNMIWtfcjDh0lQ==
X-Received: by 2002:a05:620a:2b4d:b0:7b6:cedf:1b48 with SMTP id
 af79cd13be357-7bffccc4b73mr3169339885a.3.1738613296227; 
 Mon, 03 Feb 2025 12:08:16 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8d05ddsm563241685a.39.2025.02.03.12.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:08:14 -0800 (PST)
Date: Mon, 3 Feb 2025 14:08:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Matthias Brugger <mbrugger@suse.com>, Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH 05/32] lib: Provide fdtdec_get_pci_bar32() only with PCI
 enabled
Message-ID: <20250203200812.GC1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="45JKDStcl00PDN25"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-6-sjg@chromium.org>
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


--45JKDStcl00PDN25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:41:58AM -0700, Simon Glass wrote:

> This function calls dm_pci_read_bar32() which is only available if PCI
> is enabled. Add this condition here too, so that the EFI app can build
> without needing --gc-sections
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--45JKDStcl00PDN25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIiwACgkQFHw5/5Y0
tyx9XAv/R3XhgPgb1YOrKUc4wggPMvwBBjgW26G/YEIUswjCVGzFlDKEk3C8EgTr
H7qdRYNgpWpxJ7BaSOxNn9HWx5+5RUJYWi/37UbU4iwtuFR8QBjmRHRMtRUtEaKr
c/cDHvCuFLzZl8+PHEz8CX2DVO71g1suHEeh6YrizeC5byCwCVcj5Fa4mWhce05j
01/8B2uHPvAWOwHukZ9clxxGGPIaWWmwMRppB7AL3FhAf7zEuxzN2xeppG34xJ0W
vr2CJP5XJmTijzHfqXy1WqDjkDDQ3k9mD9KNIgoBSWi3RkaOocqOHVmmH3HX3F8k
OpJbL7eLFhQ2oQ9ysQ5YTwICmbzpzRP9hOlJ6gn4ay9pG3xezKcBSkNiAM5iMq7X
EVYVgVv0wrdSOz9tf9w5i46wczqRJwfDBw75GFe8TOVumiq8x7MmU4eC8TE627IQ
9U/NuOPztyf0PVAbraxoDT/gVY0gfixsWawg3S6QH8qjpi+JO9ErVSgC+AUp2dPC
Q35LE5O4
=yNaw
-----END PGP SIGNATURE-----

--45JKDStcl00PDN25--
