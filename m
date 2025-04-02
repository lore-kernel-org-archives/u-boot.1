Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00417C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 14:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78A2681703;
	Wed,  2 Apr 2025 16:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NRalzSsn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8258381703; Wed,  2 Apr 2025 16:28:58 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 350FD80FDA
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 16:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2c7b2c14455so3973055fac.2
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743604135; x=1744208935; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S0dxFW+uqJ6GawGLMt7e4U+RdxbLlNKtDEYeF5fBRAA=;
 b=NRalzSsnViUdVZ99TMWwe4KtGizoD4sUiki68lZU68OgEi9HcNfVrvhC9EgWpfmqaK
 Wg6u8be1Y/E4sOjDZgHjk4y1k0fuKBwvOeNUMjDk0F5cAheEbe7nM8SJEjQ7ibNX/hkP
 +4zN/EdXMSvA5CFkm4hklHsMGz0zo+27NZsmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743604135; x=1744208935;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0dxFW+uqJ6GawGLMt7e4U+RdxbLlNKtDEYeF5fBRAA=;
 b=xHaY06gZm93t4hdN2A/wxvV7T+Gcnwnh0uD7E9OqFQI+Ag6n8EZb+EQvmqFKrXpWoX
 Mg3NEfbIx0++2caQOVRyK7FUPjQf1y/yh6trCcbtxj0WhCGQiCir91n8GE+UyOTX9bdn
 YJ+Jm/cziv+y2CNT4mKvNp7FyHby8FNzy7W3DK1ZfZBET8ZckyBO6BZ1IEvUtmc6K55h
 7ZDq/j4UyQ1KJqZLqAKAaG0GhodqMgpC4weATgRuCjKX/NFpF5nfnxrQidpTF7w40v4O
 gqYRb5BkpEthVrqKfnMkD7DwkcMKqlHuAp45aNs3TxUx9GO/sR2T8EI/papoWGmw/iIw
 dhcg==
X-Gm-Message-State: AOJu0Yy9km6EYhDEE9MUJsGFcks08vy4qJ3/lQ8nDApziRPY81sUuC9I
 7WoPz4CGdlqvTp++q9X+ek96rgRqyZ58LEkpJRTrzmggAewws6sWcFip1337WQs=
X-Gm-Gg: ASbGncv2PL9+BT90UzrwIP0acL3FGgow3anR33INqPsqMUg/RFPePJfJZdlbGFFIr1X
 P46amObmAgMyQZyQC2ZQx6ckDPmMOduNSRgi1l1tk+5Kff1ZMjpE0Mf43BmgCYMUkvx4kzhTfBe
 QuI0mrEXM9HZvjgShsGKPJxnadpIxLge2EPR4a0bqZn6IKaBVLR6oH8G9K/4FFnkLP1sfX4nJxp
 PqcxR6B70XjXYVG1+epK02znS774rDElcW8LFCfyAgsSw68xsuRwy9A8FtW4LZCa11xRtFb+oA7
 AY392aPKmLdG+zxmXKL7i7nyvX6HmE2BAzUJEPqlxT5QqpebNBeVF1U7Rv0vwM4LXnkj9OE+aRP
 Kfjd5yQ==
X-Google-Smtp-Source: AGHT+IE6a7jfr1E2VTwi/vDnoahAZmPdSoV/3dqJ+VOI2YKkyvTOJiEfIymQYH6hdzZ73Cqq1iVb9Q==
X-Received: by 2002:a05:6871:68a:b0:254:bd24:de83 with SMTP id
 586e51a60fabf-2cbcf4fbc33mr9858657fac.12.1743604134868; 
 Wed, 02 Apr 2025 07:28:54 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a860267sm2810188fac.36.2025.04.02.07.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 07:28:54 -0700 (PDT)
Date: Wed, 2 Apr 2025 08:28:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v5 38/46] boot: Consider non-bootable partitions
Message-ID: <20250402142851.GS5495@bill-the-cat>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-39-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0m5O/RSLJnoK7OTI"
Content-Disposition: inline
In-Reply-To: <20250315142643.2600605-39-sjg@chromium.org>
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


--0m5O/RSLJnoK7OTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 02:25:58PM +0000, Simon Glass wrote:

> Any 'bootable' flag in a DOS partition causes boostd to only scan
> bootable partitions for that media. This can mean that extlinux.conf
> files on the root disk are missed.
>=20
> Put this logic behind a flag and update the documentation.
>=20
> For now, the flag is enabled, to preserve existing behaviour. Future
> work may provide a command (or some other mechanism) to control this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v4)
>=20
> Changes in v4:
> - Rewrite the commit message
> - Enable the flag by default
>=20
> Changes in v3:
> - Add new patch to consider non-bootable partitions
>=20
>  boot/bootdev-uclass.c            | 4 +++-
>  cmd/bootflow.c                   | 2 +-
>  doc/develop/bootstd/overview.rst | 5 +++--
>  include/bootflow.h               | 2 ++
>  test/boot/bootdev.c              | 1 +
>  test/boot/bootflow.c             | 5 +++--
>  6 files changed, 13 insertions(+), 6 deletions(-)

Having spent another 10 minutes just now trying to understand things,
again:
- The commit message, and the implementation are either in disagreement
  or just too vague. Saying "to preserve existing behaviour" is unclear
  about which behavior is being preserved, since we're setting the flag
  to continue to only check bootable flagged partitions
  (BOOTFLOWIF_ONLY_BOOTABLE). But then we would continue to miss
  extlinux.conf files on root filesystems, which would seem to be the
  bug that needed fixing?
- It's still unclear if this makes bootstd match the exiting distro
  script behavior or not, and from your other emails it sounded like you
  were expecting someone else to dig around.

--=20
Tom

--0m5O/RSLJnoK7OTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmftSZwACgkQFHw5/5Y0
tywZiAv/eRjPjPExwdxJyzRyBmYoWQcU3BZOw7F4KeinEGo5/rSQkX7D1JVAxCqt
fdKhKZdo5yDw4U9ezZnPE9k06TSEsYjTiBS9BLW/RzOyYFs2KrCByOxR5jwhe1tA
1P8xGMRxyLZSMKkug09au0QyCPkGxB6Onz40w5/xPbqvcho6FGVe8JpN0Ub1/OgO
v1uD9ppwUMJnKrqBGSNYddGJRk3mgIMBLn+UoKfbpaXXVdqxFS9Zbtzp5Iit8gU8
q9T3RQ5Ff1OSAuSNQlAf7a9C/0NZy0j37OYK5gnKWBwGjZFUHU1N9Qrz5+bieyj3
mDzP5yksqlI06rHKQeaVIRFYm7/+FVs7wNeRMjbGuneulcL/k8iVglQpNTo6vV4L
1OlLOxicXzUvVfF6TwM9MhN5+rpHstKpSuyBST1i9Qrhiv1SZtTr9ddhOW4Jzyvl
SshsrPiHojX/pd7yDquGcJgxcWOru0KlEdj0s7BB2rZzkdW9HN2BEXjBbfAJWC84
R4oi/Bs4
=YPP7
-----END PGP SIGNATURE-----

--0m5O/RSLJnoK7OTI--
