Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6056BC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D2DC866E1;
	Thu, 31 Aug 2023 18:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eUa4EsxU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C40C8666B; Thu, 31 Aug 2023 18:26:44 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A4D086759
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5925e580f12so11525277b3.3
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693499199; x=1694103999; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hSyDf+rI2+QAKBXttYgO1KgufP+jvwrPo2IMmjWtrBg=;
 b=eUa4EsxUpzM9YL5JIczVY/WMOZ/eFD95nsNHABoCgQfZisYdM81aNTP3NaYczrK//j
 M0y1obvYQPD9WuH4h6Y7+ah+9HmVFbipXa7AZQ66hvDBtG3xU6p2OsOxWIaygTlEG00k
 GpLry0lAtlHJHjyTqGS6mxSDWT6vmzbMYOwsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693499199; x=1694103999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSyDf+rI2+QAKBXttYgO1KgufP+jvwrPo2IMmjWtrBg=;
 b=L/H4EvSuIUeR1Oem8g/SAMatCi9OKjSwpiMgy2mUs9hg3qirrLDXqdgHTYrRwyRWmX
 iqE4JGWcjdIlh3bXrEq8cbdjfGqKyPKjVPUM86OQ+TcGLXWl0mlM1MqvtDDXoOtdg7/O
 DlyTgxSoX25vCbx6yni5AwvDUMXZCG8eK5kLNqGEy7W93Abvg1SYpeBNhJdIAm0bXWNM
 OrkkWZn9bdbQyD6/l0tlV8QBhawCTWmp6T0w/tt+Pf9JwNI5XGZLzTZysB54onIh4MUp
 SPmQKvJ6WcrZ6epACVN8zSJUPvRYfDAkoB1mi1z9SAH53fd1zAqsALxsDnvyLs45RDZx
 RntA==
X-Gm-Message-State: AOJu0YwLf6YIYiqPG+04fKp0/Rz9P0fpJih7U9YIQI4LrbiUMCO/FxTQ
 PytxRtf/uvPV/xZzxdGw8ABohw==
X-Google-Smtp-Source: AGHT+IEkQvLPw8WtqXkIPYBFmTtl213hRX9nKkWlOLbDEdMc2sw2CUAZbCTNswfmi6aMlutHNRESAw==
X-Received: by 2002:a0d:d082:0:b0:57a:f72:ebf8 with SMTP id
 s124-20020a0dd082000000b0057a0f72ebf8mr6429689ywd.28.1693499199361; 
 Thu, 31 Aug 2023 09:26:39 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 p21-20020a0de615000000b00586a09026casm512221ywe.34.2023.08.31.09.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:26:38 -0700 (PDT)
Date: Thu, 31 Aug 2023 12:26:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 2/5] drivers/mtd/nvmxip: Rework the read accessor to
 support 32bit systems
Message-ID: <20230831162637.GF3101304@bill-the-cat>
References: <20230823001821.266578-1-marek.vasut+renesas@mailbox.org>
 <20230823001821.266578-2-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="limYrxoNx4SW3QYR"
Content-Disposition: inline
In-Reply-To: <20230823001821.266578-2-marek.vasut+renesas@mailbox.org>
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


--limYrxoNx4SW3QYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 02:18:18AM +0200, Marek Vasut wrote:

> Get rid of nvmxip_mmio_rawread() and just implement the readl()/readq()
> reader loop within nvmxip_blk_read(). Cast the destination buffer as
> needed and increment the read by either 4 or 8 bytes depending on if
> this is systemd with 32bit or 64bit physical address.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--limYrxoNx4SW3QYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwvz0ACgkQFHw5/5Y0
tyyt7Qv+OawLSwJLaBdk+orbKDnrPDDP8AOPBzO9orgYa0xgPxbu1/GJTPj1q1U3
chSTlJeXGMcH3cG4SR+8zdaKGYyf84qEFnB2Kqm9oe4swlr7wjig+3dWKaINaxH5
5ybc2/0XzAdA8YnZizWU+oUzmvkRsiu93rdXUtsw2rE1BlNBh8Xfz/5O/PjdYEDj
ZwXzwC01aCFz/5eyAw3atMiZgt/H6YJTangqn774o18l9gMhkkXjsPupRFOc4ASp
ZjBYG6TUxaZWRmYgbW8qgVhwZDjAGdOUO/8iJxlRO2sznbC8nfR/ERK/RcMAha+s
S1pQaKWXNAW26TxjwLdwpoudZjMDWFRSjtOvIvTE6dcUq3+GIryCQzTsSNAPJkrs
MG5AlApq9AuZe3NU2sgGrbmhbFnCfpX2DWX/yY4Ec73A3FYgFz+26fTw284wcR2P
JHPdfWhe5N96FdKcBcvYp4D2wcyXhAQULk8HpQGWC788S/2c4eBPmdKzdgegjdms
WvFQ5fUa
=N0jL
-----END PGP SIGNATURE-----

--limYrxoNx4SW3QYR--
