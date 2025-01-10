Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD87E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 22:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D27D800D0;
	Fri, 10 Jan 2025 23:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RRBf+faV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F69B800D0; Fri, 10 Jan 2025 23:46:05 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A8A80050
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 23:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6e9586b82so207866285a.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736549160; x=1737153960; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ubRMGJwf4yhRgul+jXopjExLug6Oen+e45LPKBt8GtE=;
 b=RRBf+faVPEyCHp/Ltx2agTa97aK/Mc6YDOlsHyV7jznh3n09pVt0IcXXjUpha3UOxw
 KYY7ce8Ca8gNgTB1UmvJaVfhYPhRMJrAKxRIUTN6zTKcYvIvzzt3Gf2XzJsiwhFOc8Fa
 jaXDFON1SXNkY18OdG+GaoXagwyc+Co3U34i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736549160; x=1737153960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubRMGJwf4yhRgul+jXopjExLug6Oen+e45LPKBt8GtE=;
 b=O1fsHNilhgVBat+pHMBDc+obNkKnDl5El5mxuQBPvh8Q4ojMwKKNoXl0r8XDQyCo48
 OycyC/0+eHCJ1bnj515tGGmTYJhMH35q0nnGKnnT/ESIhLF4Nu04hSQZs8ZaYMHBJ7Ao
 nUINmMA311rnYrZBsTlm1TnZTLMvgPgG7wrs5NXy+pud9BQ/VMSOc2YAU02CFTYN2Lrd
 WAQCgd2qErw9R7nX936qDVBDcPcrIF7/l4v9NYRJLrJUe1ajoyvobE2jo+h1H4xfprDE
 d+Y0Fwhzfami2GrSe1EQGCf3EMvFktFfdTjGUzW1b9EIxrMUJLqB3XmvDy4EbNAMNydz
 YaNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtYQ8CPWOXPfANVzOvt7JV1Em3bChfBRJagjuA0ymSOngPqXQwGerx8bCC45KsLn/EDCDG/yE=@lists.denx.de
X-Gm-Message-State: AOJu0YzMwpYeRyWmR8UX7rZq1IAmoh/G7WkZKSqJfwr4xrGrb9TVGx6M
 R/5tjwR8kFfQWiARLHqKkZ+KmEy751Axkqelag1Ft6zC8szCd88ILhHQas3L7sI=
X-Gm-Gg: ASbGnctLFaGOJ9sY1B8jjSSArsqK1ANUjubAUAdePCrSuaJkzdnQxjSrlQVJZDqlPYi
 ZjO/G85S3gQi6pHOa0WcRFy+VbE7ch9xCfCbP+0AvkKKk9tuivUpd51DEzv+WghWhrUu4eaKNxV
 yKAgkUyPSJQKsvuAQ4kp6AdT/gTOjTyvw5rVZdi25na5wyNmhrVfK0HahZn8+wbGRAk+U0mLSVC
 MqhqB8nJdLQew6JFMU1SO2xhsNLl7opGtVT1PYQosoxEo5gQdCdQjI=
X-Google-Smtp-Source: AGHT+IG90YYZPVsQfxi7xbU8XCthSkCOPbaGkDKelqxD2x4Xn/amPKZ4gepgCMZceqplbXFh/dX+4g==
X-Received: by 2002:a05:620a:45a3:b0:7b6:f557:a840 with SMTP id
 af79cd13be357-7bcd970c130mr1897302585a.26.1736549160134; 
 Fri, 10 Jan 2025 14:46:00 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3238003sm222198485a.2.2025.01.10.14.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 14:45:59 -0800 (PST)
Date: Fri, 10 Jan 2025 16:45:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 5/6] cmd: bootmenu: add parameter -e for UEFI boot
 options
Message-ID: <20250110224554.GA2278614@bill-the-cat>
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
 <20241127070631.16412-6-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bEaR7c7BNWPbX+Sj"
Content-Disposition: inline
In-Reply-To: <20241127070631.16412-6-heinrich.schuchardt@canonical.com>
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


--bEaR7c7BNWPbX+Sj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 08:06:30AM +0100, Heinrich Schuchardt wrote:

> The bootmenu command can display
>=20
> * menu entries defined by environment variables
> * menu entries defined by UEFI boot options
>=20
> Not in all cases showing the UEFI boot options is desired.
> Provide a new parameter '-e' to select the display of UEFI boot options.
>=20
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Very strangely, this leads to the EFI selftest "Executing 'random number
generator'" test failing on Pi 4, where was was passing previously (and
Pi 4 has an RNG, unlike Pi 3), and this is on rpi_4_defconfig with:
CONFIG_CMD_BOOTEFI_HELLO=3Dy
CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
CONFIG_IPV6=3Dy
CONFIG_IPV6_ROUTER_DISCOVERY=3Dy
CONFIG_CMD_TFTPPUT=3Dy
CONFIG_FIT=3Dy
CONFIG_FIT_SIGNATURE=3Dy
CONFIG_CMD_BOOTMENU=3Dy
CONFIG_CMD_LOG=3Dy
CONFIG_UNIT_TEST=3Dy
# CONFIG_CMD_EFIDEBUG is not set
CONFIG_BOOTSTAGE_STASH_ADDR=3D0x02400000
CONFIG_BOOTSTAGE=3Dy
CONFIG_BOOTSTAGE_STASH=3Dy
CONFIG_CMD_BOOTSTAGE=3Dy

added.

--=20
Tom

--bEaR7c7BNWPbX+Sj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeBoxsACgkQFHw5/5Y0
tyzh6wwAgrG1rTOQA8UeNll6GFJ6ocLlit9CPiPh2XHDN/yWrxvQE7lzXhiDB9mC
Tzl1YgVE9Rsn6tBwCgxvhUsYOooKK06aFiH9MidUpqzyJ8uywDxFsn0jaEGhC3gg
lyzoC+EoLMn3U/K5kwolSS+K1ejtHe7MY/8ouziNmetJsI6ax6bXx3lvfRqSxKM0
sec6qlT2i726BNFvBlYMVenUCu1/m375y60YObniWkEDhcYEKVUD7dyHUGWt5L/Z
cKWg2vQR1urmRHLKLXwgCD+zRSIgXbmNkpwn1LRFMv4tvQS+inwc8dpKUYy7HJZo
OMJVTend+2RRQ67NJUqpauYyAlfQPdNv2W7fa4JBbNeVKr/D3kttd1ATewY6YBtj
YlDPec2/tixoX0ZDiHGR7Oejy2KOaWy/6MuPL0KoaclwT0b4uLw9Ez4Nc+fNBhUI
DgZ4HVBvgD5JEbfbPNUFk63BYVZ6hecGAH5wZgXeHoLKMxoN1mqTnqGuw+Lq5cpn
3O0Zwvu+
=rksc
-----END PGP SIGNATURE-----

--bEaR7c7BNWPbX+Sj--
