Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB42FC3DA49
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 23:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8402E887B9;
	Mon, 29 Jul 2024 01:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lYgYUbFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A334B88657; Sun, 28 Jul 2024 21:02:19 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74ECB87DB6
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 21:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4280c493719so9441925e9.3
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 12:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722193337; x=1722798137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WyLS4y9iJuROkNAp+unWORCf9hCeHmyoOzji1v/BwLU=;
 b=lYgYUbFgQOYzUdxaghMtZ5jd0sGF09t1i9pxhyk7QDjcDInoPkojbhyi8XZjmUOb6C
 x9ECs3UscT2KZUnXq6jzg1nLf/PqZXlhv5vDcme7exhKRKFSgzBlyWEi8C5+rQHLEUVQ
 R9twtllEBoRmjuYnr7JpyGq1MTcF8ZjYbAMv0nXGiGe7f419U5CDn+kHNlarqW9V6Jz4
 AMx/MVyUv0U63PYxBca20JtTVx2v/XDcTR2KBdKAlD6wZcC+mZpavuPs+U67PyAv2Xxr
 JKMCDnfZkr4bTXzEkvbp0jVReB8MS6r8gzjjCKzpm9j2Lh6QgdHBCOuFH9cjbXaxPUrB
 mqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722193337; x=1722798137;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WyLS4y9iJuROkNAp+unWORCf9hCeHmyoOzji1v/BwLU=;
 b=qKqI88Co4hohtkVC9xba9PDUCqzVxkwaRa9OFElxUdgOa2vfp30ZURA38FRGLdYQLt
 1rckQrZhRbBq1BOnjWLLx1xrSlk9k6Q+ylm08GDoLtByGnw6M4AGZ8zkHzJlEpYvDkmF
 n/Ke+6NgguvQb8hvNcN3lbsqY6TiKzdxHRlFaVsGHzBvH8q3nk2IDUbCrsKMncTRXz20
 TpAz5p5qVB9Zzt7RVzRPBLkmTMPQgwWo+3uOksyjgM9gygxRCpEXRDBu5Hy2iZE3nuXx
 4yuFh27CB+8ZfVlu5xxQ5oN7vgALkDw/RAiAPPfNZnt+ZP8fhjMM6ujgqLjvf7IAX9VJ
 MPEg==
X-Gm-Message-State: AOJu0Ywwiv5Uyty4jTUQlV20kNuCsmmUGmUV3B8wNL6d8YtrJdBeCX2E
 jvl/VGTbj8ih9HXkTRUy917r0QnmltotkygNh+n41KPKnF9Xr3UU
X-Google-Smtp-Source: AGHT+IGnZnmBAIVRuhr5m4qHpEpfUm2i9qzZDvt9ZHB6sVD8IJkFmIXZ/U8HMXd7kcxFf6QnmDpN6Q==
X-Received: by 2002:a05:600c:354a:b0:426:6c70:dd9c with SMTP id
 5b1f17b1804b1-42811e0b770mr39089175e9.31.1722193336685; 
 Sun, 28 Jul 2024 12:02:16 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.159.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428057a6c81sm153186835e9.34.2024.07.28.12.02.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jul 2024 12:02:16 -0700 (PDT)
Date: Sun, 28 Jul 2024 22:02:15 +0300
From: Svyatoslav <clamor95@gmail.com>
To: Marek Vasut <marex@denx.de>
CC: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kostya Porotchkin <kostap@marvell.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/4=5D_power=3A_regulator=3A_Trigger_prob?=
 =?US-ASCII?Q?e_of_regulators_which_are_always-on_or_boot-on?=
User-Agent: K-9 Mail for Android
In-Reply-To: <0910419d-e8ab-4bf9-a083-dc2783afaca1@denx.de>
References: <20240626235717.272219-1-marex@denx.de>
 <a73dffe5-87e3-4e96-965f-9d029f2af8ed@denx.de>
 <CAPVz0n0C6TPdBRUEvJmgAUGAKoetuzr1j=0cMXweP2EqMTwn=g@mail.gmail.com>
 <0910419d-e8ab-4bf9-a083-dc2783afaca1@denx.de>
Message-ID: <4D07A6E5-F156-44C3-A26D-0F2D913CE92D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



28 =D0=BB=D0=B8=D0=BF=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 21:35:27 GMT+03:0=
0, Marek Vasut <marex@denx=2Ede> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2=
(-=D0=BB=D0=B0):
>On 7/28/24 7:55 PM, Svyatoslav Ryhel wrote:
>> =D0=BD=D0=B4, 28 =D0=BB=D0=B8=D0=BF=2E 2024=E2=80=AF=D1=80=2E =D0=BE 19=
:38 Marek Vasut <marex@denx=2Ede> =D0=BF=D0=B8=D1=88=D0=B5:
>>>=20
>>> On 6/27/24 1:55 AM, Marek Vasut wrote:
>>>> In case a regulator DT node contains regulator-always-on or regulator=
-boot-on
>>>> property, make sure the regulator gets correctly configured by U-Boot=
 on start
>>>> up=2E Unconditionally probe such regulator drivers=2E This is a prepa=
ratory patch
>>>> for introduction of =2Eregulator_post_probe() which would trigger the=
 regulator
>>>> configuration=2E
>>>>=20
>>>> Parsing of regulator-always-on and regulator-boot-on DT property has =
been
>>>> moved to regulator_post_bind() as the information is required early, =
the
>>>> rest of the DT parsing has been kept in regulator_pre_probe() to avoi=
d
>>>> slowing down the boot process=2E
>>>=20
>>> Is there anything blocking this series from being applied ?
>>=20
>> This patchset causes PMIC regulators probe too early which results in
>> i2c line setup failure=2E These patches MUST NOT be applied in this for=
m
>> since they will break at least 15 Tegra 3 devices which use DM PMIC,
>> maybe more=2E
>
>Thank you for testing=2E I do not have any tegra 3 devices, but this patc=
hset does not do anything with pinmuxing=2E If a regulator is probed, all o=
f its dependencies (i2c bus, pinmux configuration, etc=2E) should be probed=
 as well=2E Can you have a look at what the problem with pinmuxing is on te=
gra 3? It seems it might be unrelated to this patchset and would eventually=
 show up elsewhere?

Pinmux? Wdym, I wrote about a PMIC which is usually located on i2c line=2E

<https://patchwork=2Eozlabs=2Eorg/project/uboot/patch/20231003062126=2E420=
26-4-clamor95@gmail=2Ecom/>

This is a similar patch=2E

You may be able to reproduce the issue I face if you have a device which u=
ses SPL and has DM PMIC with regulators that need always-on/boot-on propert=
ies=2E
