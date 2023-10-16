Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909D0CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28D5E86DEC;
	Mon, 16 Oct 2023 23:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZWHLx/NT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACBDD86C39; Mon, 16 Oct 2023 23:31:57 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB07986DDE
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d9ac3b4f42cso4001424276.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697491905; x=1698096705; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=clTnT8Q9f53smAwb5WKta26tsdgvegSw74GWbcHsabQ=;
 b=ZWHLx/NTQTKsPbAArsWHjzq/261ycLZNZUdzblfCROF8V1YAm74aaUhd2qx6XLasbg
 pCnReG5IwVxyeYAEF41wF3ZDjcOd5Kssj3oLxPSFp5L5eChp9RmWwg8lUBwcgocxOLJd
 DLPXaVZxcP193BQ/YSB/6v+NrCZ7ZmWuaD30c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697491905; x=1698096705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clTnT8Q9f53smAwb5WKta26tsdgvegSw74GWbcHsabQ=;
 b=dC/IVNyD7d0O74kQ5ZnB7ki2hnrFZcIw7pzj7Ht8E13+akJKCYGGgX5qlDiTJhTSht
 75FqLH6xQyIvsIPjoSlTndrroy64XM6sh8xyZpAdcwns9B/qgoX578L1w0sfpCho8+8P
 rdtQHg3IjFrt4dNJ5ieJZPaTdt1vqDFdT2UlP6OwzwnnR9xfC35thMQDFW1iqMRno7ku
 qUmovUyrl422RC6SgWVk7OJG0M37SAxtR2//o++/BEUqTg9kQS58/popwNad2bOqeNOp
 ecAMzhwcIJpMWBmY9mndekYlAFTS0xYkj3r6c/cLDYaKaq1AVumUZ9JV0nXwj35etYK3
 nW7g==
X-Gm-Message-State: AOJu0Yxx1AZVsDuKtWW+E/xjTn+Bk7eH+kVKU9w9yEhDtf4RMbDn9KVV
 VN2szajUcfZb1uFZOvkb/0mk2A==
X-Google-Smtp-Source: AGHT+IHjbRMO5AEqne3ZXhqSiZAxuIPrn+aZU1IyAvMKi5zahegTkKBC5JM70txlfc5ww7SjX84WKw==
X-Received: by 2002:a25:d447:0:b0:d9a:60b4:6fca with SMTP id
 m68-20020a25d447000000b00d9a60b46fcamr20266ybf.7.1697491905204; 
 Mon, 16 Oct 2023 14:31:45 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 ew7-20020a05690c2f8700b005a0f9718a5fsm29769ywb.78.2023.10.16.14.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 14:31:44 -0700 (PDT)
Date: Mon, 16 Oct 2023 17:31:42 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Knecht <rknecht@pm.me>, Neil Armstrong <neil.armstrong@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/6] eeprom: SiFive Unmatched: re-implement mac command
Message-ID: <20231016213142.GJ3119521@bill-the-cat>
References: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
 <20230930120147.59482-4-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zgWfHU038zQlFkQR"
Content-Disposition: inline
In-Reply-To: <20230930120147.59482-4-heinrich.schuchardt@canonical.com>
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


--zgWfHU038zQlFkQR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2023 at 02:01:44PM +0200, Heinrich Schuchardt wrote:

> The different implementations of the mac command have board or vendor
> specific sub-commands.
>=20
> Add the command definition specific to the SiFive HiFive Unmatched board.
>=20
> Don't call cmd_usage() directly but return CMD_RET_USAGE instead.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--zgWfHU038zQlFkQR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUtq74ACgkQFHw5/5Y0
tyzIvQwAl/z0XV90g2GVEr3x/NAxp/Xngha88n+iFe74TenAt5MPAh0GPkC+G5ke
j0AlRk9VtcrqNpNJiX/Y31JO8wyog2p0a+oONvLRFE3cTbKA46G5ygu00HO5PmDR
nIRZYiEeUwfMj79ZZn91siuMxWbl7DMtXyhCTwPT9Rz69ANvep4wUAHU8kbIAL3h
+/6LQPQTgONHMYnKB7kQmjC6n91b4rLkUqFwmCNu/HMjG68F/Aby4Aqu3zkMW69Q
THT7mS5BvdBHmNfPOYI0W2wwXTi3U4HnhyVEwY7IjDNmdoHsS31nkx4qutKO6GnM
Zr1LIoHP2WzXglIM4fZKcUCnFLzgmttNKoJiJ+c4o+dlP5qnCmab+6OpRpoApqqi
s0EO0rdUB0WT+dEvjYXXW20cW2ByhgswiUSKJkgn4QYeEWj+6cU/3fmQe0ce+RFm
iSVLMbKSMXvaoNm9g/kMZsezCUXhaeEYVqYHpzil+xnUGSJUn97yHW70vsImiLfU
Rpb44J1M
=HDIG
-----END PGP SIGNATURE-----

--zgWfHU038zQlFkQR--
