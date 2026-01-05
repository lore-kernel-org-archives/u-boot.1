Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BE7C79FB7
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 18:20:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3049783E7A;
	Mon,  5 Jan 2026 19:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eQVuD8+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46A5E83A26; Mon,  5 Jan 2026 19:16:02 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 064558398C
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 19:16:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4f4c89f8cc6so1782361cf.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 10:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767636959; x=1768241759; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZEIrKZ+XY5kVT38ye5jD00eR6kl00BHJjpMu9BB8mI=;
 b=eQVuD8+rCHAe1k4uQSul9mCLtznJF4SAXxg9pcLP3ekya/IIMazqTHv/5u7b3jmpuB
 oiYekz35ZOT12jTte0rhOWriBf/IAyNhV1fA2kZPWbaGbVa+tVMXNv5jWMHYPFlJeO68
 DtiqAwXwFRsF63QqOZTH7F4OHKUPMY8ZZ8AtE+aixMHbjvdLb9ZntvG2D0DRrHjjtk3i
 DoP4CFb+Fun56FGmTUJK4SBZnYC97IMCHJG+zrNeDnjaQUovB6+2a7hryZY0V90lmr5F
 KDqgK7+6IDO3+gw3oLeH7pjJ8HpyHx3vMkcymugsgsLoajt5xvu7kyI6uqfVuKrpEJoj
 pCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767636959; x=1768241759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eZEIrKZ+XY5kVT38ye5jD00eR6kl00BHJjpMu9BB8mI=;
 b=pzg7xmystbYO812lHa4RvqXbQaQK45kWg0czY8zTw59Iy2FJ2Zmrhg3y30AdF604uI
 pVI1mNeAqW0QFmVqQ4kOrfS3ZKE+6T073C3dGm7YRvprq3LPnBihJ1Nk5+zpsAe/4rml
 pgoa+yxptM2QG2tWGJ0fP+1n48w/ssWyYpdGFzlmo3q+5wup1CIr7YvwjEGmUH6Q8g58
 JcJjISSY3gy90poKCy591hbfMbsjhKbljgjXfo+A9JR5HGfUzSegsDqcwvQ6zn9YN+Ml
 1RX3jYtt5ZszO0oCGQB3zpPWQ5uLw82VY87of8RSUGdTITjic8FKGxCQcRfdKm9BouU6
 cHKQ==
X-Gm-Message-State: AOJu0YxYAmAhp9GhkRPk13CVyXOcQ2ypPTfdOIpYPG9AiaNvFo07ONGH
 WFQieXSuIxCOb/DV18KwuqSJe8AeSkwmky3ioNaKUaDizR/teLPjVwxTTYjGJRcIbRikPNhFArC
 aJIojBWdPO4NYwcyS934EvB90o4+8424=
X-Gm-Gg: AY/fxX5GuAGPXlhWKe9gAKzgkvp6q/FFvOcRxb5i9LZc5k3aBNNM+ddo+OJWVv3LdIs
 NS3wAmn+5qxK0GIn+sTOmQdZd0aTkviSyiZhaIWW6+LSwzQRltSMr6jPXDQSCSsXcsGDD/S6XrX
 AFifBD2IUbKjFp+pmPL9DRNCjq6uN+TVbqZY0vg1bQIVHe7rR6dNjO8MYzhSwORpUpWI8a5M+3h
 3RoIGRF722qrlaNc6DocgNAJs290AWYCWj5U91dYGFqOfN2CaMuapKnEcC/pF2CI0445DSuYaUL
 onDLkXUKPWJCnNOnU1N8SU8LXrLOjFsexAXkVZ4=
X-Google-Smtp-Source: AGHT+IGOF8eu4wgvVcyiR8KPIRjNOuG2+X3jFxXbrWNrk6wkg9C/Q45H+vxMWSMPGzENq+NfcgktLWcUhTjZfdp0BFs=
X-Received: by 2002:a05:622a:2590:b0:4b0:6205:d22b with SMTP id
 d75a77b69052e-4ffa77a77damr5923191cf.52.1767636958432; Mon, 05 Jan 2026
 10:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com>
 <20260105-rk3576-ufs-v2-1-caba979a0d6b@gmail.com>
 <20260105151816.GM6124@bill-the-cat>
In-Reply-To: <20260105151816.GM6124@bill-the-cat>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 5 Jan 2026 22:15:47 +0400
X-Gm-Features: AQt7F2pfeVGURNUE183WBM9xg9TIMZDOl0V_3BvcgSQVD-TkO8abIcY8VR_dLYA
Message-ID: <CABjd4YzxpEFA0qCgUT4T1Z3R4O0W7LqPNdFWn7=5NDHO8K7XKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] spl: Make UFS available for SPL builds
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Heiko Stuebner <heiko@sntech.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Elaine Zhang <zhangqing@rock-chips.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sumit Garg <sumit.garg@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Dhruva Gole <d-gole@ti.com>, Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Huan Zhou <me@per1cycle.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 05 Jan 2026 19:19:09 +0100
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

Hi Tom, Neil,

Your replies came pretty much simultaneously :)

On Mon, Jan 5, 2026 at 7:18=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 05, 2026 at 07:05:36PM +0400, Alexey Charkov wrote:
>
> > Add minimal infrastructure to build SPL images with support for UFS
> > storage devices. This also pulls in SCSI support and charset functions,
> > which are dependencies of the UFS code.
> >
> > With this, only a fixed offset is supported for loading the next image,
> > which should be specified in CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR as the
> > number of 4096-byte sectors into the UFS block device.
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> [snip]
> > +config SPL_UFS_SUPPORT
> > +     bool "Support loading from UFS"
> > +     select SPL_LOAD_BLOCK
> > +     help
> > +       Enable support for UFS in SPL. This allows
> > +       use of UFS devices such as hard drives and flash drivers for
> > +       loading U-Boot.
> > +
> > +config SPL_UFS_BOUNCE_BUF
> > +     bool "Use a bounce buffer for UFS loading"
> > +     depends on SPL_UFS_SUPPORT
> > +     default y if ARCH_ROCKCHIP
> > +     help
> > +       On some platforms the UFS host controller may be unable to load=
 all
> > +       image segments directly to their required memory locations (e.g=
. due
> > +       to DMA constraints). This option enables an interim bounce buff=
er in
> > +       system RAM to let such platforms boot directly from UFS, at a c=
ost of
> > +       an additional memory move while loading the image.
>
> So, the full U-Boot rockchip UFS driver does not use the generic
> BOUNCE_BUFFER mechanism. Is this because of memory constraints in SPL?
> Second, can we not just re-use the generic bounce buffer code
> (common/bouncebuf.c) ? Thanks.

On Mon, Jan 5, 2026 at 7:22=E2=80=AFPM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
> Can't this be replaced by the SCSI bounce buffer ?

Thanks for the pointers. Frankly, I've overlooked the existing generic
functionality, being somewhat new to the codebase.

It seems that the current UFSHC driver only deals with broken 64-bit
addressing when deciding to use a generic bounce buffer, while the
constraint in this case is that part of the FIT image containing the
ATF wants to load itself not to system RAM, but to a PMU SRAM region,
which is inaccessible to the UFSHC's DMA engine either due to security
firewall settings (as Jonas Karlman proposed in his comments to v1 of
this series) or some other reason.

I guess I could add a per-variant override of the scsi_ops
->buffer_aligned() callback (which in turn gets propagated to
blk_ops), checking if the requested buffer is above/below the start of
RAM on Rockchip RK3576 specifically? Just wondering whether that would
be considered an abuse of the interface, given that it's not really
anything to do with alignment as the callback name implies.

Best regards,
Alexey
