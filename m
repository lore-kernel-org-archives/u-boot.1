Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B760C3DA64
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 23:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E9C088763;
	Mon, 29 Jul 2024 01:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UxbE8MBC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6577F88703; Sun, 28 Jul 2024 19:55:15 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FB94882D6
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 19:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3683329f787so900050f8f.1
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722189313; x=1722794113; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XuLif95oo8Vc95yl+NcoucyXKoSKsTdFXYZX9JLI1Kc=;
 b=UxbE8MBC+x2suOXKOTgKZab2fbsQSi+bVVZ/yILAqXaoJilNHbNASoAjtaoIkd7QPX
 1WL2h1+sVWkTuYfzC1wDcySS670UG2Bv3fhYBaVWfTqfB3yNBTDlJczymAvz01PJv1LC
 pzrmr6jMw/eWC8tqYAkSIPZwTAwzBY9Vs28J7PuDYD1IUSh5R2MXjdW7Syh/z8/IHKfz
 n7m71PzgjEhlW/kNQprvVkqs2fvzlNQJe5HVoNOLAnElET0zZzn2qUMiYVWIGBmJFoz5
 QrWogj0YBSVTVMH0bQpH4wN2piq1lACU6mjJ+fSh2XqA333Zb5BqsoL1jxA/tiX/kYuS
 wKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722189313; x=1722794113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XuLif95oo8Vc95yl+NcoucyXKoSKsTdFXYZX9JLI1Kc=;
 b=DB3wqpSW4gXTYpv+Ssh2G7xZvJ8lODti+j+paQlZg0rpJfcaGIConuSq9+oDdKmEhd
 dqd2UmvHU99wdfHAdpMzFju6ujxclSu8MRv/Na9LAdCXKpordb0OWXhBj/uNAvOLp6dc
 IyfkqykNzatQMuEIhQmeYyWbr0IXDYckIiqlIB3tNUlMSryZLaY6eMVT/q6GfOpvss0p
 YjbbSj1Dh17gYxJ4SyXRQoWxbR8dzZ592UoGQyh8YyFGrvGlU1xFvjSdtyYwcGVHADba
 f/dP69EGBn9Euxc1C3UtKtLuRnFuvVo31CKZ9I+ZGhL1qBmQyfUBc3gWYGwCkzmxe0kM
 jSHA==
X-Gm-Message-State: AOJu0YxDr12mHJlFG82AxkisN9cukNyHpF7+ibIeMSRF+GBSNeUoAeBc
 xy6yFWIQWI0tmOAvdgYCakGGdXBSiFtX/zQxkAIxHYrsnQpNVN1qB/0wNTP7ssT8HYGXfFuH43V
 IrGdVKLjkIzJ4RgaGFkxJYvmgMeo=
X-Google-Smtp-Source: AGHT+IEXccUotEEis3LUoAkPv4+NVUfzyS3O5how4MkRKe11zkrDwrYFo4jppYKBUBQmB1H8h5wDraDHmd2XkBamLps=
X-Received: by 2002:a05:6000:bc3:b0:368:7fca:9040 with SMTP id
 ffacd0b85a97d-36b5d0ace36mr3567938f8f.39.1722189312647; Sun, 28 Jul 2024
 10:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
 <a73dffe5-87e3-4e96-965f-9d029f2af8ed@denx.de>
In-Reply-To: <a73dffe5-87e3-4e96-965f-9d029f2af8ed@denx.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 28 Jul 2024 20:55:01 +0300
Message-ID: <CAPVz0n0C6TPdBRUEvJmgAUGAKoetuzr1j=0cMXweP2EqMTwn=g@mail.gmail.com>
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

This patchset causes PMIC regulators probe too early which results in
i2c line setup failure. These patches MUST NOT be applied in this form
since they will break at least 15 Tegra 3 devices which use DM PMIC,
maybe more.
