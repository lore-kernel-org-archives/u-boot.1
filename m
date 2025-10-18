Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6403CCD195
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 20:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E55D583631;
	Sat, 18 Oct 2025 22:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QcCb6yF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2536836B4; Sat, 18 Oct 2025 22:22:18 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2E2683438
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 22:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-58b025fce96so2737767e87.1
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760818936; x=1761423736; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2z0L2krZvFhyfdEzj5LVFyUinK2wJqIGFqwCWQR4CZQ=;
 b=QcCb6yF7Ru4dDw7G0iNU5uVjDTBeLQYHelj0QV64QQ4wZ3IblHIjZomR0hLyjCgN2Y
 B9AxQxyAEcjKuwrQeWYb9wJemG7XPHq4Y9M+iy8TxkQBZOl54FppJVcrWsN2WZmGgry/
 KrsDopHYRgWhdR9OqylJgcLAH+uxbe0zjEYBF2OV7VsKDdbiVvvHRCdx9jWvILfTTAIJ
 Q7gyx9zP+p7b4u7YoT/m+Yup/UYZqpvlIhXicOAXCIYg0WhdzMrl10gJEtQoVEj8ZY2B
 I/ywIqh3Cc46dzxvvu0qMISJASSKaK+0M5j/t9EdISLIOS2lTdgm18PnYGF7brHJTeNX
 1vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760818936; x=1761423736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2z0L2krZvFhyfdEzj5LVFyUinK2wJqIGFqwCWQR4CZQ=;
 b=IRtiAuhhThqxiJivxDS1ZExaMbWvfPZlfvaFk2M9mV5Twtixw1pulfAjP5yaYM2/iL
 1ah0fd57Wpq35EZKRD06D2Ga2fWG5Y0I9bMus6rE+Cu3xk1bQBJPgpLZqmr4Ai3lHmWR
 W0mipDPhRuEfc1hgC6Ch6Xu80zckjaDVtgbgdqnGRR9Z4Xsdi46Db83+8ukIafst8av/
 ZHwZO9O5O9Su4nWzGuHTnQnhodjeDF1iT4HXfuzaS+S6vN0SGa98dcnXXVnRA3GCdQFd
 WD0QSTXjJj0vdqpHDEOigbaomeCUUvrtXZeAPYEbx3bmdtBU0J7VC5XQ1k0gX6o6EikQ
 vXcA==
X-Gm-Message-State: AOJu0YzCzfz1NFzTS4ANdfPCTb1hus8xgWDIR4cIFDUF5YRI8FYYgkDB
 h82S4yOxLEsbTLYquzdAtARMTiuYUHjwSok+n0JYF32xGqI6TKa0Bzh/tY3DIBmkDORudRWTn/M
 /Rso8t3bxhv9/piGJQTiOfNWacHumtSg=
X-Gm-Gg: ASbGnctfw8WPvIgOiuFcrGKZExlBawi7pr1RAn144B/8eVWr+MBErAadQh9YqXmmpZm
 aGtFjYZnRdi1kJSrDZr52phOpW3TBtR5J9lV+1KgyuZj8FVPoqlFCBNScsYIJ3OarS7AfdiE2zX
 ZOTXSBETjY3uicQoqlbI6CZfCx9Ue+amlB+xDTnrlsyZmtW3OtNKAVYjgncLejpBz/elHLm1+qR
 fDplhsYNcN3opaBmE6c7a2roAD9WXU3votUn+WYdMeGMbumBNcDunjy9649oDqKG2XLM2jQQzlf
 yBPuM8sLobgvPoDoXw0vh5IZVw==
X-Google-Smtp-Source: AGHT+IEzmbBZ2MlRINx+W2LnB0KDhrb6kFLrftQg9zG/smlrHgFUMcylr7dGVwIbMlObvdyllp+CGwKzXayMED6RksM=
X-Received: by 2002:a05:6512:2251:b0:57b:fb1d:616e with SMTP id
 2adb3069b0e04-591d85661b0mr2750133e87.39.1760818935677; Sat, 18 Oct 2025
 13:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20251014111756.446456-1-alice.guo@oss.nxp.com>
 <20251014111756.446456-2-alice.guo@oss.nxp.com>
In-Reply-To: <20251014111756.446456-2-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 18 Oct 2025 17:22:04 -0300
X-Gm-Features: AS18NWAUi8qljlRy9wUqkGr_d1oyuXzkaydJJuS8fk656mkPBnnQc0ZmDOKBNiE
Message-ID: <CAOMZO5B0VWBwcpxRCF+iCN9jJw+0uWN_pJjyNha_B1Yz6e9h2A@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] spi: nxp_xspi: Add new driver for NXP XSPI
 controller
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com, trini@konsulko.com, 
 sbabic@nabladev.com, jagan@amarulasolutions.com, ye.li@nxp.com, 
 alice.guo@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com, sjg@chromium.org, 
 mkorpershoek@kernel.org, marek.vasut@mailbox.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Alice,

On Tue, Oct 14, 2025 at 8:19=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:

> +static const struct udevice_id nxp_xspi_ids[] =3D {
> +       { .compatible =3D "nxp,imx943-xspi", .data =3D (ulong)&imx943_dat=
a, },

I don't see this compatible string used in Linux.

Will this driver be sent for Linux inclusion?

Please provide us with more details about that.
