Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD00FC72CB
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 18:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E22EF84090;
	Sun, 22 Mar 2026 19:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WiLcl4Cb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01F0F840AA; Sun, 22 Mar 2026 15:37:23 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C7D884082
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 15:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9825ba7e8dso396387966b.3
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 07:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774190240; cv=none;
 d=google.com; s=arc-20240605;
 b=Mk1y3EMLkge7pA1PLPX/8ZCA4do/dqaRivFWGOSaQYBHx5rvSjXACFr/AI0mzbfRKB
 Ox9+XHxXicFLuqRpQBjvxsjrMC2Br8P+v/CW90LtgVjQZI9f0h4T5TxY+UcIudMVW1Il
 NXBsrj83sgx9ppA2DW/OEBQGd2DzLW9pdylhfgHrImYXR1WMvkwCmV4TAeUUieUfXMjh
 Cz9vKbfRPqwajJuyfZHFXsziAleRRMWO1KPxFB2E8twEBCNou3TRxLY4J87YB/GAG72j
 j5Ftgif2jgzZH7TppaBeSioA3OpQ0YuxnuqCLBRH8JaE+6ZSI+gfeYdM6iAswup5Tixj
 syoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MHg4GweYtLm0NcAk25X9agBHb2n1L7sTgfvhd5yGtRY=;
 fh=Mwjd0rnSvpf0+LVRVKefCJ+wk1xopgZF6pU+T4cdJSk=;
 b=c2FG1Px8RY7RGxk+7mPnVzu3vz4/PMSEdx4bNnCvUgsyVp3TuxD0yXJpJYDUNN5FKf
 t60XUcJmpellcNsMdfSEBYI8EWfB28ox+aX3ksQ9I/9HcGRmWOZ5LeTJ509mGEcKEDZd
 kWnExJoyA6Qw47n7ekJueB5BeNG8F2ygU4x20+Jm2FzPbmRQ9uAfXAw8DfIp/a+CIqn+
 Kh5K6CORW/NMf61Yn+4RU2j1XoA8lwUPLdbu5o5Yb2k/A1y45sS9SHGqrFSwcOozgojT
 TfbKljtttePPVliQihklTLpOjlpugSJPSA8BXDwfmWImvf/ibJs46ATF3SyU104R40FY
 dF/w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774190240; x=1774795040; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHg4GweYtLm0NcAk25X9agBHb2n1L7sTgfvhd5yGtRY=;
 b=WiLcl4CbRT17jcA9gXOX/B2A87hWu+OjxpwPlNI+/V46UWkIySYXlBklfLgc0ltxGZ
 5+lcqp+S0HU33Vn+ccJzFiTzy25MABDsjtP50rIMs9pqAouHpOl+WcTEBJA11QXjrVJk
 x+s3dV5+WPVW1G6FI1EzPn7WivMDGim/qgr64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774190240; x=1774795040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MHg4GweYtLm0NcAk25X9agBHb2n1L7sTgfvhd5yGtRY=;
 b=sMwnfXDddKJrn+UU5fZIqE9GwnPRzLfWBunNDiYNyBUU5rcs4r6yMbalLGQ6YQIxJz
 ePoXN/MDUC3utkxI7ghX7mIoqsZsz0+CEjQ0DCIJSSIMflcuTV2OPXQyrE3QbuTXXi4G
 TXjHtNnqjZ/qdkK3XcsWll6Lif76kWtUCitwTIp6TNT8xjOK3NZwQE9pllv2gPvS0pJT
 5K6JG3F1ucpsl1J5Sqq4xesiZ46wwJk0Epp0Py8st8+HQytr9cJvDirmbeOdamizcY9P
 lPsh8Nsr1uNye56m4vIfS6m2SAQumTwAc2B2q9ROgdd343b5W/SFlbVvi/e2iQNzw/1C
 KLNQ==
X-Gm-Message-State: AOJu0YzJb/8Shjkdf9Ks9N32OYuojpi1DW99EpKADXMIn4ZN3ZnVuLUw
 TzMJVgLCGVUntHMuZVHVZ+jRTaFCjiWdldIZFQ/zDxQFR0QqpJem2wff9i5tUu0mT0/BEq0io2A
 gPPYkdhSbOHdKtKw2KelPpGhpevtiHf4ZfJ9iuRj1
X-Gm-Gg: ATEYQzwlwjLkrGVKQl3YgRmk9AG8X1nUeagamwIbGI7mNwrWgo1pIzX2yKD5m0R1quJ
 phyFC2vB4yy5wlQkOKPuHWiUZT1Sni8jLPZM/C7C8gSRw6SfKMcFfDm2HkP/osJ7PrUPiz8IjFf
 OizK+Shvg2Pv70mtYIj+euweiE+9U4lM2N3tRkb6sh7OVJvv3886AuNCVBjfIkIosw1s3eidSE6
 whH9jNoAg7/BGwfzJjY+oA1Rf7eciMen/I/R3rYesttqjxeUrHPodx4r77VQGmVIEy7Mmfpah2J
 6ylWh6I=
X-Received: by 2002:a17:906:b382:b0:b96:ed21:f46f with SMTP id
 a640c23a62f3a-b982f284cefmr394732766b.14.1774190239558; Sun, 22 Mar 2026
 07:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260319213551.267031-1-sjg@chromium.org>
 <CAPVz0n0DYDPcT7ZDLwXz0pUFc04R-X1C3GROpmSEp1z=xrA7Vg@mail.gmail.com>
In-Reply-To: <CAPVz0n0DYDPcT7ZDLwXz0pUFc04R-X1C3GROpmSEp1z=xrA7Vg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 22 Mar 2026 08:37:08 -0600
X-Gm-Features: AaiRm50ZyqK_eNkqODMmbJ02CWIH5Yz-kDLQWwzYvxyyh6puRhxIhiGdD1epXRo
Message-ID: <CAFLszTiZYiQgaspCutyQeZy+Tok9scLp-rG9_Sdk8XirUinOSA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/15] RFC: dm: Add uclass adjunct support
To: Svyatoslav Ryhel <clamor95@gmail.com>
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
X-Mailman-Approved-At: Sun, 22 Mar 2026 19:41:11 +0100
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

Hi Svyatoslav,

On Fri, 20 Mar 2026 at 02:01, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> =D1=87=D1=82, 19 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 23:36 Si=
mon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > [Note: this is marked RFC as I am still not sure that this is the best
> > approach. But this is my third redesign so I think it makes sense to ge=
t
> > some feedback before trying to refine it further]
> >
>
> Hello Simon!
>
> With all do respect how this change improves current situation? From
> what I can see introducing multi-uclass will bring only chaos and
> confusion.
>
> > U-Boot's driver model requires each device to belong to exactly one
> > uclass. Multi-function hardware must work around this by creating
> > child devices in different uclasses via device_bind_driver_to_node(),
> > with a NOP parent device.
>
> Example you are targeting behaves as it should. MFD can have a
> multiple cell linked to the parent node and/or its subnodes, this is
> not a workaround, this is how Linux MFD operate too. And a parent may
> not be a NOP device, it may be a core providing access or misc
> communication functions (like PMICs do).
>
> >
> > This is quite common: at least 8 PMIC drivers bind sysreset children,
> > every Qualcomm GCC driver (15+ platforms) does this and several PHY
> > drivers bind clock children.
> >
> > This series adds uclass adjuncts, which allow a device to register
> > in additional uclasses without creating child devices. Each adjunct
> > carries its own ops pointer, per-device uclass private/platform
> > data, and sequence number.
> >
> > With this series, uclass lookup and iteration functions include
> > adjunct registrations alongside primary devices. The
> > uclass_foreach_dev() iterator walks all entries in the uclass,
> > including adjunct ones. Iterators that use a struct udevice * to
> > iterate (uclass_find_first_device() etc.) only see primary devices,
> > since they navigate via the embedded primary ucm.
> >
> > A new ucm_ iterator API uses struct uclass_member * as the cursor,
> > enabling adjunct-aware iteration and lookup. It provides find, probe,
> > check, drvdata, seq and ofnode variants. uclass_foreach_dev_probe()
> > uses this internally so that it includes adjuncts.
> >
>
> It seems to be overcomplication. ATM cells can be bound to the parent
> device node and called by the UCLASS from the parent node. For
> example, if PMIC has gpio cells and does not expose them as an
> individual node then gpio driver can be bound to parents node and used
> as a gpio function provider which matches what OF schema expects
> pretty accurately.
>
> > As a concrete example, a Qualcomm GCC driver could register as
> > UCLASS_CLK (primary) with adjunct UCLASS_RESET and
> > UCLASS_POWER_DOMAIN, thus removing the UCLASS_NOP container and the
> > qcom_cc_bind() function. The raa215300 PMIC conversion in this series
> > demonstrates the pattern: one device, no child sysreset driver,
> > no dev_get_priv(dev->parent) indirection.
> >
> > The mechanism is enabled by a new CONFIG_DM_UC_ADJUNCT option. Code siz=
e
> > is largely neutral without this, except for the change to add
> > dev_int_set_seq() which is used by PCI boards.
> >
>
> So you basically propose to squash everything into a single enormous
> driver coding every function that MFD provides instead of keeping
> existing layout of separate cells with dedicated function. This seems
> to be a maintainers hell.
>
> > Note that a couple of linker-list fixes are included so that sandbox
> > will start up correctly. It still does not pass all tests though, due t=
o
> > various bugs surfaced by this series. If we go ahead, we will need at
> > least one precursor series to resolve these pre-existing problems.
> >
> > This is an RFC. The next steps could be:
> > - Convert one Qualcomm GCC driver to use adjuncts
> > - Convert one RK8xx PMIC from child-sysreset to adjunct
> > - Update per-subsystem ops accessors (clk_dev_ops(), etc.)
> >

Just to clarify, the goal here is not to squash all MFDs into one. It
is not intended to move away from how Linux handles a particular
subsystem (quite the opposite!)

This is really just aimed at allowing a driver to support multiple
uclasses, in cases where that is useful. It can actually simplify
certain drivers, since they can have their state in one place rather
than having to deal with the parent/child relationships and multiple
priv/plat data. I have had quite a few bugs calling an operation on
dev instead of dev->parent as well. I still believe that modelling a
PMIC with child devices for CLK, REGULATOR, SYSRESET and GPIO makes
sense in many cases. But now it becomes optional. Ssee the example in
this series, which I hope you will agree does actually simplify the
driver.

The original design of driver model was based on uclass being
associated with a particular API, with a device being in a single
uclass. This series is really just looking at what it might look like
if we relaxed that contraint.

I've been thinking about doing this for years...the most recent
impetus comes from the clk/reset/power domain discussion on irc and
Casey's recent series, although in fact that seems to be heading
towards mostly separate infra rather than enhancing driver model. I
would like to steer it towards still integrating fully with clk - e.g.
using clk_get_by_index(), etc.

Regards,
Simon
