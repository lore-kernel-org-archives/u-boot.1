Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD94BC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 08:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C80284A51;
	Thu,  9 Jul 2026 10:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="YI5NqI2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1764984A78; Thu,  9 Jul 2026 10:36:23 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C822849BA
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 10:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7eb4d8a21a8so981006a34.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 01:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783586179; cv=none;
 d=google.com; s=arc-20260327;
 b=DMjZGyNT0hLQbuJvqv8tma3dOpGDj/HTALZA52auMfIXssj7z3PHq/nXG4mWRvvk6g
 t7xcTvOWdG7x5VIzhSGvOFjy7N0BwgRORXO5ctzuq7y/JdyUJMtiPOREdyv4rz6xfkjm
 9cjEx3DfdmVXMRB3/nXAB6Wahug+fFqL2n6RUv8MLvhxLBh0ZAIcOqYyEuh0j9s1BqLH
 yNt5hKJPENXVPdD+0/QqChE7M15QzZ7i4H004K4YdYcDEWXb9HhRBNJKW12EI7m/QGBS
 PqhMglXga/KhxXg+pp0/s0TPf0elq8DBqLv/C1uXcgX7LWjrgycWyGNSXuLRatKIdYJU
 CrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OIM0JIXouykj9FTkzuEJ1byQZbtOVu822UYTD+/A2vs=;
 fh=oTMOb4w+vB7TeWRv0wOLHRCBshw4WXF0p8wPAgOsXMI=;
 b=XHhBv0jnxMsWEo7vKR58SA7iT+bFS58kK9HKnN3MDXU6w5dd72gi5GXEqTqLHyjhhR
 VxneUO+8kOZwIEnH72Aqz6sYCoTXla0y2rRX6VpQy5SVOHrayAgJXn7MWxahyV9hQfRI
 KQh71Eipq3NHEPv6cKLiLHmYJrlXX3SZtMsw6yX4SmH3mUaO+kLYeRhrkjsqgMYiSFBn
 OoVjp2qnL3qdofHCLkZN6+Q370NUFE2lDd+wsEjftNq7TlounD7TTJiB+Pmi0WSsBL+O
 AB00tGwyGO5MHyLs6ozAtbtEGKN4X+H2JO6gN+pdcRfW9Ze+jlDO3qU8SfiSqnR3WJDr
 Uwxg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783586179; x=1784190979; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OIM0JIXouykj9FTkzuEJ1byQZbtOVu822UYTD+/A2vs=;
 b=YI5NqI2Zkt9qJjYWYHqjawvbJVFGTeEGMR277KDQrjyq4o02X5k/n3To95b/o581EF
 gugseA8y+aBt1P5538NTE1v6C3xEuST23gTPXu0lcG1vkaVi0dMiGQSkFaS8IFAbLPQU
 jQ1bQas/6fy4iy5cWYJxI/qqkostTCs/D8dM2uj0HHK29ZH+voHtWumcAmFrxPQo1Ud6
 d94MdhEj3VHO/kJKnCxcCXDnr7ohb68L69BZIMRp5uP1H0Vr7/rEa9+sxeX+VG8Pd+K9
 TTsvL2cuuDNsvSK99lCYsj5PkYoYA/eBCYN6tNmWh5Nyse9N7OykqAoeQVMpx2aUOONt
 dJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783586179; x=1784190979;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OIM0JIXouykj9FTkzuEJ1byQZbtOVu822UYTD+/A2vs=;
 b=e6RsYt3V+Vd2dBE86LI6jFsmA96twg9iGufgQpxJtrkJO8nNx9+E6e4fFW10xMJYS7
 DRCOCWi4ll3KxhDIJ8KFf+4l618Fq2S4mgHP6cckPhg1f3ZWVELkr866Kvs09dyAOP8m
 20pSpoQiZtlGzyJ1aQfOHVbbpQiQj/96zXSjy9cwz0IxWfxidrkadSdylqMTenT/t56R
 RyskcECP/Di20TbkVKNIoY9A0JbM0FPXYs/rHs3jS/H2jY95D+dReldWs6ZuDfCmlm9x
 Y1WEaqrDsRfJ2kpPtWa2pd6J5JLFuOQ9gGcnjtjecXvmNaY5yz0VRYJYP40VFXZSKdlE
 8qQg==
X-Gm-Message-State: AOJu0YzIeuiabYydBh6gEfLCYTiuCX9cS2XwAUyprgP2H7mFW1LQGk9x
 GJJwDz4YGCG2KmTEPNFlti2upZL5sApBfqRI/iZ/oA9DamtHLt4g8tlCTJGyf7tqHrP8E3AgNY2
 nEym5g33ZcAPMpeHSJYKhrVOMCSVeCwk8rs9tkliBhw==
X-Gm-Gg: AfdE7cn54lIBMu7oVnVcIFFUQMz+4sZ4H0gBCK0P5qHH4Kio3QDZ3IYSjIJTpEi3Cl3
 IZfmBD2TyYX/qxM8rsHI+5Wj7vylhkid3P9mY3aQ0l3kpAX+1yzJj0BkTwIQxOmX8XSZFyJ5s26
 Zg/P7dRa/r0JH7V4Kp8g/39oOvo/MXzb4+z61Ge6rqda3HK5suzFt/ah90LxDd4p/BVnVpIOAJD
 z/D0Q+StOWpGJhPsX+MyKc9bxlxFWL1cCWm+c7D6rO3gaidgt/3QPV+H15+qQKhUCfPOQKl
X-Received: by 2002:a05:6830:4129:b0:7e9:e4b8:8cc2 with SMTP id
 46e09a7af769-7ebcffc5eb5mr5126730a34.27.1783586178888; Thu, 09 Jul 2026
 01:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
 <20260706-ccaione-upstream-ebbr-v1-1-e742cdd6abe5@baylibre.com>
 <20260708171806.GZ749385@bill-the-cat>
In-Reply-To: <20260708171806.GZ749385@bill-the-cat>
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 9 Jul 2026 10:36:06 +0200
X-Gm-Features: AUfX_mzouRv1GlCgdgoUKq-RDe_8v2Ui_OsC38jWx6nJztmqH4953gJwpkYY_AA
Message-ID: <CADh8LseqgrheGSjHhwXsH=prD1=Tnpnt0ZMx=-9jKV88Gsbumg@mail.gmail.com>
Subject: Re: [PATCH 1/4] bootstd: add a firmware-owned devicetree source
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, Anshul Dalal <anshuld@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <floss@jetm.me>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Martin Schwan <m.schwan@phytec.de>, Michal Simek <michal.simek@amd.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>
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

On Wed, Jul 8, 2026 at 7:18=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:

> I think I wasn't clear enough on the RFC, sorry. We need to get this
> binding approved over in https://github.com/devicetree-org/dt-schema/
> and I strongly suspect that barebox would be able to make use of this
> too, so a u-boot prefix would be inappropriate.

Addressing also the comment from David:

> I have some doubts that it is safe to add arbitrary child nodes to
> arbitrary storage controller devices like this. Many of these devices
> already define child nodes in their bindings, so this could break
> drivers that expect a certain type of child node already. (And also
> break validation against the binding schemas.)
>
> So it seems like it should go under /bootstd if this is u-boot-only
> or /options [1] if we want to try to make it generic for other bootloader=
s.
> And it could just have a phandle to reference the target block device
> provider or just reference it by name (to match using alias).

Thank you both for the review.

I would like to split this into two parts:

1. The on-media contract: a firmware-owned devicetree FIT manifest
where configurations describe the valid base+overlay combinations and,
when signed, authenticate the whole combination.

2. The bootloader-local locator: how a particular bootloader finds
that FIT container on its platform.

The first part is the piece that looks useful beyond U-Boot. The
second part is bootloader policy (IMO).

For the U-Boot-local locator, I would like to follow the existing FWU
metadata precedent. FWU metadata solves a similar problem:
firmware-owned data whose storage location the bootloader must find,
using GPT and MTD backends. It uses a standalone U-Boot control-DT
node, not a child of the storage controller, and points to the storage
provider by phandle:

    fwu-mdata {
        compatible =3D "u-boot,fwu-mdata-gpt";
        fwu-mdata-store =3D <&sdmmc1>;
    };

Modeled the same way, the firmware-devicetree source would become a
standalone U-Boot control-DT node, per backend:

    /* eMMC / SD (GPT) */
    firmware-fdt {
        compatible =3D "u-boot,firmware-fdt-block";
        firmware-fdt-store =3D <&mmc0>;
        partition-type-uuid =3D "384e979b-eb76-435a-a3a6-1a071dbad91d";
        partition-name =3D "firmware";
        filename =3D "fdt.itb";
    };

    /* SPI-NOR / UBI */
    firmware-fdt {
        compatible =3D "u-boot,firmware-fdt-mtd";
        firmware-fdt-store =3D <&spi_nor>;
        ubi-volume =3D "firmware";
        filename =3D "fdt.itb";
    };

(please note that for the sake of simplification in the patchset we
are only implementing the `u-boot,firmware-fdt-block` backend, `-mtd`
variant to follow).

This fixes the child-node problem David raised: the controller node is
untouched and only referenced by a phandle. It also keeps this as
U-Boot control-DT policy, matching the existing FWU metadata pattern,
rather than defining a new cross-bootloader locator ABI in this series
(so exonerating us from dealing with dt-schema at all, considering
also that we would deal with that for each different
`u-boot,firmware-fdt-*` backend that we would introduce).

What I think is genuinely shareable with barebox is the on-media
contract: the `fdt.itb` FIT layout, configuration semantics, signing
model, and whatever partition or volume naming convention the platform
or specification defines. That seems like the right thing to document
at the EBBR level, where barebox could adopt the same container
convention independently of how each bootloader locates it. So we
share and define the 'what' but how then barebox (or any other
bootloader) would source `ftd.itb` (the what) is not part of the ABI
and very much bootloader specific.

Does following the existing U-Boot FWU-metadata precedent work if we
scope this binding explicitly as U-Boot control-DT policy?

Cheers,

--
Carlo Caione
