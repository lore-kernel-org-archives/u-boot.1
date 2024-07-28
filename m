Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3238AC3DA64
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 23:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 264C488755;
	Mon, 29 Jul 2024 01:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N72rLoY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E77B28867C; Sun, 28 Jul 2024 19:00:39 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CC4B87F7D
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 19:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-368526b1333so561888f8f.1
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722186037; x=1722790837; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NU7vFGsFVz9XttDSW/bkfmdXC55CVByOcRuEzg2DDFw=;
 b=N72rLoY6pYPMYNW8ohO0dwBFCck7UpvbqHGsX87Mw9IlssNqRlRYdxp1JPcm1IdiMV
 G1zR18YYoFiutIx4YGtiHpWJVe4HsDnS0KhjiGI8gowx7cZiDIHtxuYQ71WFA6MJVul9
 /KLvWCClKAqfKn0NOBnv95RoJDI29aHrP6RHTyY0qJtEGzGAZKQPyebq0sPyAOQdBMQq
 GVksGS2J6YI5y/fDjXghuW/P30yRpnkOFYvlp+6rzdFUv7//9b2GWV4dRP6pvm56ZT1l
 KE0j7n59KKghZJOPVi4lSwYrPJs1S1ATkCgbtZ0oN60TzyC+yzbSgEHWai5kPpFF08BY
 +UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722186037; x=1722790837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NU7vFGsFVz9XttDSW/bkfmdXC55CVByOcRuEzg2DDFw=;
 b=btM/jMkpbQ8y+vMiSEbAzhND99odqsGuDDecBPNlbNbzvQIZix/S4pyrHKXDoZ47Wv
 krz8yO7r0VTuRBTN8F7OxVBcNx4ghlrnFoBVw5D2dytdBm6PAnvF1az8v5gytFLKvI3l
 AE/KbLRZOnb6gUyjXSNqjKu7i6kRGctpt3DO0DSeSYNQQr3ZIA6yPj0JmHRJk8hWzt42
 R9cmlCzC3KnhBMQ7EhAG9Ou6JCh+ABI9ZpQorJxs1d9OBIdR2tZW4V+FQZ/w+rHVk3g0
 vCciZadUWZTYWnaZNxBrdr3/injVBZaSi5uap5O6/7r3PqUlOALFHt2+MGVQXQp9Gd5X
 8/aw==
X-Gm-Message-State: AOJu0YwwcivUm3UDqo+aRmvITPqNS8c/jOoqqdZ4RXtaxP+Rv2WM5MF/
 b7WC5O2Cb/SwAkV6xdp6jJYvxPUq1DjTI4ZgbAPhcK2v6bzN+GYXplKv4ix9vQDt7m3tTCSchuL
 x8DyvX7UJi5pAisLX3Dl8UPuqxPo=
X-Google-Smtp-Source: AGHT+IFLXABcTYMcrmM3hytyaQW+HN19qzm+5VB+qqS6LEf4j+QYQxtuAoWqKqdfFYtD/IQf9TyZFesJZgdKl1dXn+M=
X-Received: by 2002:a5d:604f:0:b0:362:4679:b5a with SMTP id
 ffacd0b85a97d-36b5d7d0054mr3401525f8f.16.1722186037138; Sun, 28 Jul 2024
 10:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
 <a73dffe5-87e3-4e96-965f-9d029f2af8ed@denx.de>
In-Reply-To: <a73dffe5-87e3-4e96-965f-9d029f2af8ed@denx.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 28 Jul 2024 20:00:25 +0300
Message-ID: <CAPVz0n0QWCjSgh6QPyo_wnXGQYwhnt30XKJ_ofJK1O08rK9qyA@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, 
 Dragan Simic <dsimic@manjaro.org>, Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi <matteo.lisi@engicam.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 29 Jul 2024 01:59:10 +0200
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

=D0=BD=D0=B4, 28 =D0=BB=D0=B8=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 19:38 Mare=
k Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 6/27/24 1:55 AM, Marek Vasut wrote:
> > In case a regulator DT node contains regulator-always-on or regulator-b=
oot-on
> > property, make sure the regulator gets correctly configured by U-Boot o=
n start
> > up. Unconditionally probe such regulator drivers. This is a preparatory=
 patch
> > for introduction of .regulator_post_probe() which would trigger the reg=
ulator
> > configuration.
> >
> > Parsing of regulator-always-on and regulator-boot-on DT property has be=
en
> > moved to regulator_post_bind() as the information is required early, th=
e
> > rest of the DT parsing has been kept in regulator_pre_probe() to avoid
> > slowing down the boot process.
>
> Is there anything blocking this series from being applied ?

I would like to try it to be sure that it does not break my devices. I
will respond within next 24 hours.
