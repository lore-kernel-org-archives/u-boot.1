Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA55C83033
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 19:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C94EA81FFC;
	Mon, 30 Jun 2025 21:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iBPCKDGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 290448206E; Mon, 30 Jun 2025 21:47:31 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D67881FEE
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 21:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2ef493de975so1619902fac.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 12:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751312835; x=1751917635; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4MqFgPbOPFQwLY/aH4zCnHyG55ybZgbjlvDANc4l1Jc=;
 b=iBPCKDGk6LnI4pocUuMrITZW+IAbHPNNPBRY7ipuPm1KWcdfft0EBT5PT+g1krX9Ql
 fp2xEOjgyc+isN3vQuSV6mm6pwu/e+8CYd3skgMVaRrS/kL5wf3Guke6yAbKrBE2Cx9R
 qy29Iz8jLEng6N/1jeYdFAh9ijjsVcYO+YQmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751312835; x=1751917635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4MqFgPbOPFQwLY/aH4zCnHyG55ybZgbjlvDANc4l1Jc=;
 b=P14gM6fufd8Bq/XvQex8J9v0UgzuKFWRMpsPYZmWBTZ//UON5kMUOcvyMuZ1tbIJ0/
 YIX2tIsEfwKnvCk6sGhvdJX9XGCelzD3I4zMQRyzwT9CGeBmNzv4lW7AB6B0Biz47uw+
 L91sy6tQzkkw3vM7um1Xq9KMS48qr8wWr8GN4sK9gj5xSKk+Hoj3DNeuClh1IkkyjSLN
 wgkdXU62a9qlnOV22yYUFm2Q9CnzD3xuE/A9xRktJFVAVBQbDmmTCWNhBpRuYaaR5pEe
 TDijexgHs40wytk1EeYTm2bsjr7NCFo/6gR38QDwCvon8UKoXM/wGzH9f7DhLWamhy+p
 SnTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQk0hV+BM3SCb1JtNugM4FQw0sPKG8y64JjEjAok0+g7t2mjM/NtqTp9+g/YAWzaGihYPzzAI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1lafN4EMiw9Gh/80PCsWmvj3TZb0H+DdGCl6KdqAPwNAZENec
 CJ2s9mWNe7IIydsRN+NRVt0HFjj8a43JuKX5uxv6lzMofep8XBYIJ5khPZWWNj3cuKM=
X-Gm-Gg: ASbGnctMerjSj/IX5C7Yetg5Xksq8WUcSrXXsoXsgabzXgaKVedfd1hVfJ877ccSWYN
 qxW3ZoHPbdSU9RAqOw64jiwb8TbI0WxB2vYZfDIK+Xxj/hUyRqTEQezciIUyIOeC76112Lqee3y
 m9UUI/cxcutconKW7+UqkRoE8Hg3HHUaxkWltti4jlFbhZ4yxps1K5T0+by8JX1rIXSA8xTvVzF
 W7snCxin34/XtmfVK8UZkrqpE7CEBw0kUTjaPe4dpK8YzibZdUhX6zDvvvTWGErRnWBxkaHyXnx
 Lj8vLhHDooIbymX3QsF+9hyJO/6G8zRwWVKT4M6YkAOhbsP/ZNxR1AUV/0XiG+nHBhNTJfeYp62
 4cxkHvHyMBV3B55tqooXw7Us=
X-Google-Smtp-Source: AGHT+IF/yoFMh2pXg/hknAjtXH1mr0XlOqzBD7c7dCPyy4cmNxlHfHHL8newWWW9BDy8/RQgIuOfig==
X-Received: by 2002:a05:6870:8910:b0:2c1:ac88:4a8d with SMTP id
 586e51a60fabf-2efed7378f3mr10242082fac.30.1751312834970; 
 Mon, 30 Jun 2025 12:47:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd512d709sm2847797fac.43.2025.06.30.12.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 12:47:13 -0700 (PDT)
Date: Mon, 30 Jun 2025 13:47:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/2] ARM: bootm: Add support for starting Linux
 through OpTee-OS on ARMv7a
Message-ID: <20250630194711.GA523899@bill-the-cat>
References: <20250630000832.952206-1-marek.vasut@mailbox.org>
 <97DFDFA0-80F7-462B-B2A9-BDBAD42A191A@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yHI6RQdkgueHXCCg"
Content-Disposition: inline
In-Reply-To: <97DFDFA0-80F7-462B-B2A9-BDBAD42A191A@gmx.de>
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


--yHI6RQdkgueHXCCg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 07:18:33AM +0200, Heinrich Schuchardt wrote:
> Am 30. Juni 2025 02:08:05 MESZ schrieb Marek Vasut <marek.vasut@mailbox.o=
rg>:
> >Add support for jumping to Linux kernel through OpTee-OS on ARMv7a.
> >This is only supported if U-Boot runs in PL1 secure. This change adds
> >two components, one is fitImage OpTee-OS loadable handler, which makes
> >a note of OpTee-OS being loaded and stores the load address for later
> >jump to it. The second part is the actual jump to Linux through OpTee-OS.
> >The jump through OpTee-OS requires set up of multiple CPU registers, r1
> >and r2 are passed through, r0 and r3 have to be set to 0, lr is set to
> >Linux kernel entry point. This setup is done by new assembler function
> >boot_jump_linux_via_optee().
> >
> >The boot_jump_linux_via_optee() also includes STM32MP13xx late TZC
> >configuration write, this cannot be moved easily, hence the ifdef.
>=20
> Hello Marek,
>=20
> Could you, please, add a documentation change to the series. This would a=
llow reviewers to test your proposal.
>=20
> Furthermore, please, provide tests on QEMU.

Documentation is good, also wiring up this use case for testing in CI
via QEMU is a rather large ask. We're still on needing a general boot OS
test or two in CI (and Ilias noted either on a call or IRC, I forget
now, that there's been some progress on making up a small enough generic
OS image to work from).

--=20
Tom

--yHI6RQdkgueHXCCg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhi6bwACgkQFHw5/5Y0
tyzsnQv9F1xul/XGHlbtWryo7AB0XpMzr8dUCED04Z/pLQcdOuhHQQH3z8ECwjnQ
ugexQKhXyWsv1gA7a6qYrhxJ08HhvyD/SBVIVqL62huyF/DfSa56vXEnws1x9Tla
glZyQ/dU/1hh+TPX7dP0A27xOgxk7nv0H3H9Lk7fN+WIg+8Vk1PajV9Rc6M6TqUc
X5/jCQ/hEto0fcv/06TN3d+/J0pe2zitSfXT+7EF7rSTrxbrlvLbpDTphShW8HJM
qvnAFfACWycaG+uU+M6SCGRpoUycay+nfKVBtckHwPo7x2jSe/4nPohRKW+zeVl6
wp54SEb1L/OYfWs1z93wiuwbP1QQF75Mqvqad9AnBFFCfeuJVqAvHe90Up9gAMIy
75cPGFJ+tbNbGoQWdQpUWuzE8dkJkhkgObEiQgvg7lnDoMmTgaF1vN8awllDS7Dm
+bjySaXYXurnPVGZWsotG9L7X9T87dEZNfQFr3idfRY+TAVDd7NauIiWm/2AF9bd
T/KH5Qas
=iiz0
-----END PGP SIGNATURE-----

--yHI6RQdkgueHXCCg--
