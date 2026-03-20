Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0C0109319C
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 09:17:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75BCA83F8A;
	Fri, 20 Mar 2026 10:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RonKpsc+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCE7880517; Fri, 20 Mar 2026 09:01:17 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5805780517
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 09:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso2657825e9.3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 01:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773993674; cv=none;
 d=google.com; s=arc-20240605;
 b=g0nKbIAg0iaDsU36QV7fb/4cjcI0qABQCvUK/WrrdY4zBJui3EHONK33hlpdOzRTzu
 zBCmq4ENjX5THjDRZ2uj+P6orSe8USRf9ZfM3zWXdcWvb82FISm5QJGm9IKeTE4P8Pnw
 DqLxahp1XHsLqflK9MTeMur1i8+z8tK+9Y8CHOtOAQgRdSj87PPYrmaKo1rnYeRu6Ewo
 tP4UzgAG4ILY2E9UbtpiIoijT2pc2Vp3+PqpvVy5ZRh5UJ9xPhU5jykqf8XPIH8ucne2
 d8A4kW7Q/QQ11wZhKz07Mh/DYz/vQVzCu2jO07LJkc8y/qywhd9lHwNaqoK0Ogvb4iBe
 D+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X+sjlpsZtTar9rWBPEkW1QVIElMjQv+QGZoB0+bBmR8=;
 fh=c1I9dxPUHj8G5Z06bUPOnWIuQfhGPwL9XjGZKIpW9CA=;
 b=Y64awyvMeRAdu+8BuqkayB4i63hwoRaNpndNDhlEGZ1PEav64Hehinn6D3xDkPDM31
 xpzmixceyFGWCkurm6L6dkbLwDN46odRxyaEjqhWBsw1lO4KrZ39wxA61Sprr9z6/pIu
 pwdjjAtEW2EpohmBz6AoXVdzCp3jG7vpSwVrCUoROGk1jtDr9e4SWNZYud+tjJjJ71HC
 aa5v4FXmLTbYKLcBqFtim4T1rQisi0scWgCneVy5KEHrQ34+hThlPNITFqv1NNDTLlDO
 97jJMyvMGlTHyFQPRKUWuC+29iO0vrlw57ranwDOKkMNRM8p8hLR14v6/FT8VdRFdErk
 1MGg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773993674; x=1774598474; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+sjlpsZtTar9rWBPEkW1QVIElMjQv+QGZoB0+bBmR8=;
 b=RonKpsc+psgf9jzaKXidnWV8N2Uq4p1z4TKuOdPdzOUTY+/2p1dgcp19cR0p+jlCA1
 zC2cMlQF20cB/QW7VCD/6OwkozNOrdu5nb7D9kvmlw0xxe9OM9BTfKpErKzUkjbwjBAo
 UxFJ81O+NbW2vYQP6UhshHVhZgw3KdLF+Fzv7mgivoCLhhuTRHNF59w4hrtOd9ugGqyu
 SCioVDrJ1/2g2EcPIepMom7gLIuFyr2sIQp3PfN+/DSGUXjJYX238JQ52JFqwZ3kdYd8
 aXcmKZFEb3CTlvukCNNLFqqLeTD4aJbLjint7WiQAIaTD5BW/jQDV5B+qNQ+bSaSqmVh
 fK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773993674; x=1774598474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X+sjlpsZtTar9rWBPEkW1QVIElMjQv+QGZoB0+bBmR8=;
 b=Hx8zf8uzTL3zitHH9Pnk4cB0sr4QzkMDg8qN4hNQ1SlyeV4/pxRhHi7nXyg9xcrpVO
 OADxEuxVgy5If3LJKr/NmKGTvxAb3/YEfSBkIXEZBooGRL/+JF4dBfxR+/Cu6ttFbo5h
 uKq+4CG3veVR9/oPaoZ3OrxOrC3m1DPqcv/oeh1HfcLkqPpFMARwWztxE/oLY/WgTTyU
 GxFSAVEtZigYiuUmp6uwmPo/wnc7684IyNTcbllFeFodh9Y8mXnum3R08lG6jOBXbQnn
 CYpXd2xoIVTXzo7/8v+MI/MpXvsh34pUKT7Thd7DY9PxDg9a+cL/+tNKGb2WkaNoVord
 VgVg==
X-Gm-Message-State: AOJu0YwnD58CFvgdspzq00Rvo6Zfv1tq/Z1XqOkPh9hwr4aRpIuxQEoV
 jD82Vz9u9Atda/fRtFqlSecixp9fWjQ1maF1CiufY3PVHBd+3uON+n1UYC3RaVIgrDsMvf0oloD
 wXSRkWYSXm2CFS2iYWUq+5/d2tZasvQg=
X-Gm-Gg: ATEYQzxQe2L9/ZCaV4E8Tx7b+Bx7otAL6zhWESk9fNgn6WyKk2ep6+yfr7mZWYxK4nJ
 1fG19FNKcawcuiPEZrk/780ubFosEvgVZWjjPNUhDdLhMfgymZRoh/LkdWhgujK7wt6e3v4RjjG
 sEzbsaFEW/F+Y30GcxDhu/vHoMxvuqY1P7kMI4sbjkc/SI7/PIRtmpJeiq0dwsbgnHJxkeD3acs
 bibDEsBQqXFHuCrRFuYZWj5iAgAWqegs16/tVFSvneQik+j93gnMimHkatOxqbvafWpDI9kPAPH
 bQdvO5sR
X-Received: by 2002:a05:600c:8b46:b0:485:3baa:af14 with SMTP id
 5b1f17b1804b1-486fee0fc11mr28417675e9.18.1773993673728; Fri, 20 Mar 2026
 01:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260319213551.267031-1-sjg@chromium.org>
In-Reply-To: <20260319213551.267031-1-sjg@chromium.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 20 Mar 2026 10:01:01 +0200
X-Gm-Features: AaiRm51BsgHkQp2oxCS9hDNAHFgGzlHDnTb8sx-PTIWBTzpse7IiOpZZUECRBsk
Message-ID: <CAPVz0n0DYDPcT7ZDLwXz0pUFc04R-X1C3GROpmSEp1z=xrA7Vg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/15] RFC: dm: Add uclass adjunct support
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Brian Sune <briansune@gmail.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 George McCollister <george.mccollister@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Jim Liu <JJLIU0@nuvoton.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Martin Schwan <m.schwan@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Stanley Chu <yschu@nuvoton.com>, Stefan Bosch <stefan_b@posteo.net>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tim Harvey <tharvey@gateworks.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 20 Mar 2026 10:16:48 +0100
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

=D1=87=D1=82, 19 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 23:36 Simo=
n Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> [Note: this is marked RFC as I am still not sure that this is the best
> approach. But this is my third redesign so I think it makes sense to get
> some feedback before trying to refine it further]
>

Hello Simon!

With all do respect how this change improves current situation? From
what I can see introducing multi-uclass will bring only chaos and
confusion.

> U-Boot's driver model requires each device to belong to exactly one
> uclass. Multi-function hardware must work around this by creating
> child devices in different uclasses via device_bind_driver_to_node(),
> with a NOP parent device.

Example you are targeting behaves as it should. MFD can have a
multiple cell linked to the parent node and/or its subnodes, this is
not a workaround, this is how Linux MFD operate too. And a parent may
not be a NOP device, it may be a core providing access or misc
communication functions (like PMICs do).

>
> This is quite common: at least 8 PMIC drivers bind sysreset children,
> every Qualcomm GCC driver (15+ platforms) does this and several PHY
> drivers bind clock children.
>
> This series adds uclass adjuncts, which allow a device to register
> in additional uclasses without creating child devices. Each adjunct
> carries its own ops pointer, per-device uclass private/platform
> data, and sequence number.
>
> With this series, uclass lookup and iteration functions include
> adjunct registrations alongside primary devices. The
> uclass_foreach_dev() iterator walks all entries in the uclass,
> including adjunct ones. Iterators that use a struct udevice * to
> iterate (uclass_find_first_device() etc.) only see primary devices,
> since they navigate via the embedded primary ucm.
>
> A new ucm_ iterator API uses struct uclass_member * as the cursor,
> enabling adjunct-aware iteration and lookup. It provides find, probe,
> check, drvdata, seq and ofnode variants. uclass_foreach_dev_probe()
> uses this internally so that it includes adjuncts.
>

It seems to be overcomplication. ATM cells can be bound to the parent
device node and called by the UCLASS from the parent node. For
example, if PMIC has gpio cells and does not expose them as an
individual node then gpio driver can be bound to parents node and used
as a gpio function provider which matches what OF schema expects
pretty accurately.

> As a concrete example, a Qualcomm GCC driver could register as
> UCLASS_CLK (primary) with adjunct UCLASS_RESET and
> UCLASS_POWER_DOMAIN, thus removing the UCLASS_NOP container and the
> qcom_cc_bind() function. The raa215300 PMIC conversion in this series
> demonstrates the pattern: one device, no child sysreset driver,
> no dev_get_priv(dev->parent) indirection.
>
> The mechanism is enabled by a new CONFIG_DM_UC_ADJUNCT option. Code size
> is largely neutral without this, except for the change to add
> dev_int_set_seq() which is used by PCI boards.
>

So you basically propose to squash everything into a single enormous
driver coding every function that MFD provides instead of keeping
existing layout of separate cells with dedicated function. This seems
to be a maintainers hell.

> Note that a couple of linker-list fixes are included so that sandbox
> will start up correctly. It still does not pass all tests though, due to
> various bugs surfaced by this series. If we go ahead, we will need at
> least one precursor series to resolve these pre-existing problems.
>
> This is an RFC. The next steps could be:
> - Convert one Qualcomm GCC driver to use adjuncts
> - Convert one RK8xx PMIC from child-sysreset to adjunct
> - Update per-subsystem ops accessors (clk_dev_ops(), etc.)
>
