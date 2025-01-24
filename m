Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4B2C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 19:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD2F580BAE;
	Fri, 24 Jan 2025 20:18:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TVz3ouZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19DED80BB0; Fri, 24 Jan 2025 20:18:40 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D061C80BA6
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 20:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-467a6781bc8so20114401cf.2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 11:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737746317; x=1738351117; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ElNsq2g5SyDNnCevDudDgcr8Zdy6kk7IFz/csTxfi10=;
 b=TVz3ouZF28DhXG/8+lHPxbzfZsR13n1X8id1J7bCUGYXuMrMIMhchaSXb3MxBHLgT7
 b+jev1IogXxPanP0MmayCDg8ZGGtHX9K5hGQUmhutNvWpPR/Z9nr6yqcVH1EWYLuYy+W
 4uUepXRB63rX8XiUkh8+69MUq9KW2LO6W1vMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737746317; x=1738351117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElNsq2g5SyDNnCevDudDgcr8Zdy6kk7IFz/csTxfi10=;
 b=pKXAUAokrmIb7YKctSKcN4YBBhuE80DDWNGhDYHOzf4I5rUryuQtBwLx+QUjK/M1uH
 HpkI6xe6xqge2mQ/2rYsqaXUKoSiJ/YMP2+LjGoxKArug+/38LcisZDFoAicp8v+siFV
 8U7x+qicNySqVB7IZnPnlopCXQzNjFizYzZnfSbl1QfOrjLMI2NrkBrxFAsVBIe13PKv
 qFI9c2x4z0tvgguFk6EY/ppCrDXSpC/nZufp9e2y+2nN7euS0L9cXLIabcbOmmAiRJUs
 C71LC+uO4zusXG7dYmgonBKBtBRhW22cPHQYo4JNBwVLRH8g1VwQJKUK3dKO70PB4Uyc
 nF1w==
X-Gm-Message-State: AOJu0YxrwX+GpFzwutnLVjwT/rofR68nZWWkY5eDNjIZ3Q49x2YMFi+1
 jh7hAsB5PTPVJpZFUbt3QctV9T9L4inkhZ5rfSmtzTlqHm/cWNLKnbTQkj3mEtE=
X-Gm-Gg: ASbGncu1cjFId6FvETiv6md0UCLhyHb6D5+wxhDZCypIzoyIiJCJLybAagGldm8YG3K
 eVDbVDv8W0CN3lgW/W2jNPFLmz7W5DXN76aHSkAXlQReeEy9Z5Mt1IyfUrPA+GvSfwhsHoBFSEp
 cH6kcW2LMzmQhmt77qwt4y9v6rdXofvxA0LfbMmiKxRecFrQRQZdkRI6oRZH/2WQljjAvpveFVd
 Q/1ZN8/141etqVfJ6VZ+MTg/LZBsCTlOuKxTP9bwW15LoTvd1+ahdEyRW78gdCsqDPeibYU2+L+
 Z793
X-Google-Smtp-Source: AGHT+IH/9CS+1qCil5xpit52aOl89QCi+uFGdfZ16CXZcS+KvNsUp5qVOnNighehkB6jYRRCqtgZ1Q==
X-Received: by 2002:ac8:7dd3:0:b0:467:597a:be4d with SMTP id
 d75a77b69052e-46e12b37e10mr477109851cf.18.1737746316654; 
 Fri, 24 Jan 2025 11:18:36 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e205136996sm11306146d6.12.2025.01.24.11.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 11:18:35 -0800 (PST)
Date: Fri, 24 Jan 2025 13:18:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v3 00/46] pxe: Support read_all() for extlinux and PXE
Message-ID: <20250124191830.GS60249@bill-the-cat>
References: <20241206023626.2456858-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eBF4ISVNXeQQVrpb"
Content-Disposition: inline
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
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


--eBF4ISVNXeQQVrpb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 07:35:39PM -0700, Simon Glass wrote:

> This series implements read_all() so that it is possible to read all the
> files relating to a bootflow, make adjustments and then boot.
>=20
> Unfortunately quite a few things stand in the way, so this series
> finishes off several pending items: zboot without CONFIG_CMDLINE,
> required support in pxe_utils and the differing code in the extlinux and
> PXE bootmeths. There is very little new code, but quite a lot of
> refactoring.
>=20
> The bootm, booti and bootz commands have all been refactored previously,
> so that they can operate without needing CONFIG_CMDLINE to be enabled.
> At the, time, zboot was left alone, since it is x86-specific and a bit
> more trouble.
>=20
> However it turns out that the booti support doesn't work with compressed
> booti images, so this series resolved that problem too.
>=20
> This series adds a programatic API for zboot and uses the forthcoming
> bootstd 'image list' to collect information from an extlinux file. It is
> therefore possible to parse the file, load the resulting images and then
> examine/adjust the resulting bootflow, before booting.
>=20
> The addition of options to extlinux resulted in the PXE and extlinux
> bootmeth having slightly different features. This is tidied up in this
> series, with common functions for both. This allows the same features
> (loading images as a separate step) to be provided for PXE.

With v4 of 45/46, this fails with lwIP on Pi in the PXE tests now. You
likely don't need more than CONFIG_NET_LWIP=3Dy being added but for
completeness here's everything:
CONFIG_UNIT_TEST=3Dy
# CONFIG_CMD_EFIDEBUG is not set
CONFIG_CMD_BOOTMENU=3Dy
CONFIG_CMD_LOG=3Dy
# CONFIG_CMD_BOOTEFI_SELFTEST is not set
CONFIG_IPV6=3Dy
CONFIG_IPV6_ROUTER_DISCOVERY=3Dy
CONFIG_CMD_TFTPPUT=3Dy
CONFIG_CMD_WGET=3Dy
CONFIG_FIT=3Dy
CONFIG_FIT_SIGNATURE=3Dy
CONFIG_FIT_BEST_MATCH=3Dy
CONFIG_SYS_BOOTM_LEN=3D0x4000000
CONFIG_NET_LWIP=3Dy
CONFIG_BOOTSTAGE_STASH_ADDR=3D0x02400000
CONFIG_BOOTSTAGE=3Dy
CONFIG_BOOTSTAGE_STASH=3Dy
CONFIG_CMD_BOOTSTAGE=3Dy
on top of rpi_3_defconfig.

--=20
Tom

--eBF4ISVNXeQQVrpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeT54YACgkQFHw5/5Y0
tywrwAv+KOGYxv9gLSNdZ4fm9tbrbkaPEl3y/nV0kfb+eRivfhI8P6YPH32caKyE
RtbczLwyo+r3TKwIHadppUAnUXOcNReXNviD8GfJji+pMjTh+hbskPsgC/t/bxyh
Z+iAl4dm0ikbfeyVabWLoiC1o71ua/2ZhC5bLWq5IWh79cRjtBkHjat0/QYd7JfO
3rzrsAAqJe6xwXOaiVcXf/5UQQd4aY2GD8z2ubw7A5sFr6kE90UmqYZ4b/xn349H
6TGRit6E2TLjsqixlp3udFb1nvknODNGzKnj8fqOE3RsMfDVcPoWOFZ7ctbXgZQI
n88N/2y7CfNXv1yaIyCKpoj35MAo6PBrHcQdSfyiNx8d6ZvwuBj4hrVhqH9pSHIz
L3/TKCviqjEm1jlAXIdEKhel7xTfIveEDsrC7zk7O42StxU7gGKpJCY0F2ZxgRds
/LAFUCW/wiQgYpasyCHcYA8TDW6wyc/gu199mUoULJQcAf0srK8uzwLzrOrJeMWR
6rrqEl0P
=aGOF
-----END PGP SIGNATURE-----

--eBF4ISVNXeQQVrpb--
