Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F08C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46938803B5;
	Mon,  3 Feb 2025 21:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PsSaJvmS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7AB280269; Mon,  3 Feb 2025 21:08:43 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC7C480207
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b8618be68bso477322585a.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613320; x=1739218120; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zgr2QB1TxaAU0FDeEeCMZ9W4w3oG68TRQIdLEh2SZV8=;
 b=PsSaJvmSsKgm4kvIj5aYGLA7BoDdlHhqNwXQmyIW2XIMl9blnHg/P78Z7APuq26vsX
 lNEgXhiYVPH0eh1aqw45wyVpxshXdYteEAAYd+SVyyWLkdUZz0Ab6P748cQ7VLvW7lMX
 UvQuGs8L6MRIae43w6oS6ZsReuHMVmyPA1Ub0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613320; x=1739218120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zgr2QB1TxaAU0FDeEeCMZ9W4w3oG68TRQIdLEh2SZV8=;
 b=t8r1Sz4EHLMQ0L4thNCbGkvN0XB/ArvgpK8RxCKhhw6OQ7gT/whqtAFFz1keTPUKFB
 qIgAEPuDgPrXaiV5d0ehyPlOUDD74BzgHDokVlOM6pxchvkgqwmUMdM8oe5jCJEi62QR
 VkzenJbZlUu/SvRIo2Lt2JIyIVnolGABCfY+De7tTvgx9g19GiP3rn/rAcTNtbmQcZoX
 fpxCBbqJ8dV8ciFVvNSARNtXjnM74dpIEInuLX6UtaGSkiYHTu6EO+A9K4ik4/AK98UR
 sk1n00+IAnLMdG4a02rih2ILh7tMJqmWFjp7kSbMLhe6l1ZlMa+mp6FfVvyGZhTGdArB
 pXIg==
X-Gm-Message-State: AOJu0YxXJh5mKjFMvb4l/M6W2zspTcOB7P7VmI06nxVEDS3JlmRhmWAV
 I6DXbqaEYCyr8jj+uvGHpct9anCNW1eZ19uteOlvHJeq/tVSWwJGOm0V4P+Kl6k=
X-Gm-Gg: ASbGnctXJzwiWdJDUPdgatFiWFYC7dVn4BW1madDAg9UJijoH9k1Uk3hGBt5PoAWRF/
 2DWVlSz6XIkDAgqDB1fE1YN028qCt6eEcCEzkJFYLsOzDsxxl0nC9oKZO0BNbzc6GTHtDu34+Ll
 x1upLHGpTxRkyhsZ8jw1X4EwkQfXvoHIFv62UW8uPlCl83jvOHTdeMadaS1CwpgSbXgVFrkA0kg
 vlSJNJhifwvXo9pivv9BUHFnGAe1GhY1kzsKYFaX39Gqv2l7Qcpn3hKbzIwCibpmjZWS8Of0Ekq
 9dfTCEc5oAP7cNk=
X-Google-Smtp-Source: AGHT+IFOka9Cn6XTYobBHYAtbd2I5WCISQWCvfiwqn/EHWjoAv9QvvkrIk1vkZy9+/M6QWCwgFBOXQ==
X-Received: by 2002:a05:620a:4247:b0:7b6:d393:c213 with SMTP id
 af79cd13be357-7bffcccaf39mr3642749685a.8.1738613320659; 
 Mon, 03 Feb 2025 12:08:40 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254922e16sm53631346d6.80.2025.02.03.12.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:08:39 -0800 (PST)
Date: Mon, 3 Feb 2025 14:08:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>
Subject: Re: [PATCH 10/32] efi: x86: Move EFI SDRAM-handling into a common file
Message-ID: <20250203200837.GF1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-11-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TSS2DUtT6jz6s0qa"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-11-sjg@chromium.org>
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


--TSS2DUtT6jz6s0qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:03AM -0700, Simon Glass wrote:

> This code is not actually x86-specific, so move it into the lib/efi dir
> where other archs can use it.
>=20
> Drop inclusion of the unnecessary x86-specific header.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--TSS2DUtT6jz6s0qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIkUACgkQFHw5/5Y0
tywtkgv/XsyAfuIMidaFBdrHYU6ClH8piOrCaM/PJpq1nlR5z0lNbwNBOlIZ7jH7
OSDoWnUG3fjkuGi+qZGMTZiU7kOpfjdWww6j002T+6p5mjFgz98m7G4qLZB+SG/h
H83RyiTVCw/rbkf3JWni/v9foK1BHjr+5dSKmzZjulPd1oYFklUTczMj02Vf1Dig
08G+R9H/3DgSifVV8k5uLqT7VK88sG5oZVtvokxTixggD7eMepMipyLTccvOq5ln
6dNobK6uKadfZmiCUOfBsLxs08xLEStg4N9TIcMwdjt46cwFZdpzUrS4M4MVjbNH
XVVSVcpmYtH26QxcEvrtWlCmiqNmedgT7u6evzHRC85C+B/27AO4zT2kRui7NmUe
YU0gEXCzN70UkpigvsuxPn0t5SfSGBUgloDkr0lbYeeH+y7hOABhX7rHrr6FYWfo
SWuPhLlsvDzCBJqEn19wUFwkfJlneWcCzQQBU+lTMRz/ZFMVb0hZqnYg1XuYprWh
j8jaEcBR
=ab9j
-----END PGP SIGNATURE-----

--TSS2DUtT6jz6s0qa--
