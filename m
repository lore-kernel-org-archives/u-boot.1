Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B56C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 00:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6832B86517;
	Thu, 24 Aug 2023 01:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="DZo8OpEE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D239864FF; Thu, 24 Aug 2023 01:59:26 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F221D86508
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d66f105634eso5594269276.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4YDAo5w8lg1HQTJgaC1Dt0ef480DoxZMKD+KWxnAgTc=;
 b=DZo8OpEEhEjGOiTn8Y9bjREjpA4dHAwrnms9mpSbzzYbSKlVXbnDKz//LqsWfl5dnY
 jSHUUy37Dy4HO8rt66DgdMOWoPrYLSKPXBdAoW5Vgw+tRO+0xPqpfvdL/uFCsQrOnKEP
 g+Y5pLh/52/nISy2YeFUC85VLacFvnk4Z7+BgcX3tOZWV50e8O9JvyqlBs9yJ2q7KrDx
 suBRQ87+Ku3/V5+4RkUVDNKEr6yEfsQAdNobfF1ZbYgneb/alzdWCaLNxfizINjq7K4k
 cTKeP5hwGJdeZ821cbImXTzuhAV4oo4i6yn2frB9WlL4mbHZ3kW8sJufhoOoNuIt/txd
 xSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4YDAo5w8lg1HQTJgaC1Dt0ef480DoxZMKD+KWxnAgTc=;
 b=BNnZmjNJckaJBnvXS5O8c/QwvT/2QMA0ow4XNs6nQH0jOhDWM7iEXkITB5LuU6NyDd
 6iwGEgdUyswud3Vu9vdyXhcqn1jSM9l9YNq+/oiRIX41vqulluQFSzmt7/4HRyvrhq50
 yiZYTFOD0Igyfky7oEGC/xYhC44BclfltljTMG3PXE7GAycHVFpvP9GEoeAFr5/0nvsD
 Yd/9KwUkRMKiRK8aCTlp4LEbun3kZTHxnln/0tlzQcw8yfGMNGbSpWRcFFm7JLceAsgX
 OGAwx5/2YtvrWjMLpvp6+634LM9Viw8RgXf5maieQNW5eVJ3W+0REzjkGdbkOTb30ZqM
 juZQ==
X-Gm-Message-State: AOJu0YzHxYtQL1XKCgnJfJncX5DxVsiLRCrFI7ppUK6bWTLa69H/7ZR5
 I12Bk2Ynkr3EIKen6U5L3w+tfOaS8rNZ9Tx//sYxmw==
X-Google-Smtp-Source: AGHT+IFqf1NBvEc9xytyj7IQXitePOncOcOcKk7FIu2zH5/N9jLagHqgSUJANCikXGVE7bUJuadz81RbfxedkT+5y9g=
X-Received: by 2002:a05:6902:531:b0:d3a:28bb:2c95 with SMTP id
 y17-20020a056902053100b00d3a28bb2c95mr13698092ybs.22.1692835156457; Wed, 23
 Aug 2023 16:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ1wGkq66ZEXHUVzLpc47fYgV0+Kk9WNwqDWcO0R7jEYVA@mail.gmail.com>
 <20230823171502.GQ3953269@bill-the-cat>
In-Reply-To: <20230823171502.GQ3953269@bill-the-cat>
From: Simon Glass <sjg@google.com>
Date: Wed, 23 Aug 2023 17:57:48 -0600
Message-ID: <CAPnjgZ2t2aUnreA8Hzg11moQ2Z5hqW1r-16WTF0PRMjK3iXe_A@mail.gmail.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
To: Tom Rini <trini@konsulko.com>
Cc: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Wed, 23 Aug 2023 at 11:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 23, 2023 at 09:30:31AM -0600, Simon Glass wrote:
> > Hi Nishanth,
> >
> > On Tue, 22 Aug 2023 at 12:43, Nishanth Menon <nm@ti.com> wrote:
> > >
> > > Add base documentation for BeaglePlay
> > >
> > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > ---
> > > Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >
> > > Changes Since V3:
> > > * Updated documentation to give a more clear overview of MMC partitions
> > >   and flashing information.
> > > * Added OpenOCD debug documentation
> > > * Added LED status information and indication of various boot stages
> > >
> > > V3: https://lore.kernel.org/all/20230815164440.2713726-5-nm@ti.com/
> > > V2: https://lore.kernel.org/u-boot/20230727234446.3651836-5-nm@ti.com/
> > > V1: https://lore.kernel.org/all/20230725185253.2123433-7-nm@ti.com/
> > >
> > >  doc/board/ti/am62x_beagleplay.rst    | 256 ++++++++++
> > >  doc/board/ti/img/beagleplay_emmc.svg | 697 +++++++++++++++++++++++++++
> > >  doc/board/ti/k3.rst                  |   1 +
> > >  3 files changed, 954 insertions(+)
> > >  create mode 100644 doc/board/ti/am62x_beagleplay.rst
> > >  create mode 100644 doc/board/ti/img/beagleplay_emmc.svg
> > >
> >
> > Great docs, an example to others.
> >
> > Some nits below.
> >
> > The bigger problem is that we cannot build this with buildman since it
> > needs config fragments and we don't have a way to describe them. In
> > fact none of my existing flows can build this board and it breaks all
> > my scripts, etc.
> >
> > I don't think anyone else sees this as a problem?
> >
> > Anyway, I'll send a separate email on the topic.
> >
> > > diff --git a/doc/board/ti/am62x_beagleplay.rst b/doc/board/ti/am62x_beagleplay.rst
> > > new file mode 100644
> > > index 000000000000..5adb7b4c9ace
> > > --- /dev/null
> > > +++ b/doc/board/ti/am62x_beagleplay.rst
> > > @@ -0,0 +1,256 @@
> > > +.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> > > +.. sectionauthor:: Nishanth Menon <nm@ti.com>
> > > +
> > > +AM62x Beagleboard.org Beagleplay
> > > +================================
> > > +
> > > +Introduction:
> > > +-------------
> > > +
> > > +BeagleBoard.org BeaglePlay is an easy to use, affordable open source
> > > +hardware single board computer based on the Texas Instruments AM625
> > > +SoC that allows you to create connected devices that work even at long
> > > +distances using IEEE 802.15.4g LR-WPAN and IEEE 802.3cg 10Base-T1L.
> > > +Expansion is provided over open standards based mikroBUS, Grove and
> > > +QWIIC headers among other interfaces.
> > > +
> > > +Further information can be found at:
> > > +
> > > +* Product Page: https://beagleplay.org/
> > > +* Hardware documentation: https://git.beagleboard.org/beagleplay/beagleplay
> > > +
> > > +Boot Flow:
> > > +----------
> > > +Below is the pictorial representation of boot flow:
> > > +
> > > +.. image:: img/boot_diagram_k3_current.svg
> > > +  :alt: Boot flow diagram
> > > +
> > > +- On this platform, 'TI Foundational Security' (TIFS) functions as the
> > > +  security enclave master while 'Device Manager' (DM), also known as the
> > > +  'TISCI server' in "TI terminology", offers all the essential services.
> > > +  The A53/M4F (Aux core) sends requests to TIFS/DM to accomplish these
> > > +  services, as illustrated in the diagram above.
> > > +
> > > +Sources:
> > > +--------
> > > +.. include::  k3.rst
> > > +    :start-after: .. k3_rst_include_start_boot_sources
> > > +    :end-before: .. k3_rst_include_end_boot_sources
> > > +
> > > +Build procedure:
> > > +----------------
> > > +0. Setup the environment variables:
> > > +
> > > +.. include::  k3.rst
> > > +    :start-after: .. k3_rst_include_start_common_env_vars_desc
> > > +    :end-before: .. k3_rst_include_end_common_env_vars_desc
> > > +
> > > +.. include::  k3.rst
> > > +    :start-after: .. k3_rst_include_start_board_env_vars_desc
> > > +    :end-before: .. k3_rst_include_end_board_env_vars_desc
> > > +
> > > +Set the variables corresponding to this platform:
> > > +
> > > +.. include::  k3.rst
> > > +    :start-after: .. k3_rst_include_start_common_env_vars_defn
> > > +    :end-before: .. k3_rst_include_end_common_env_vars_defn
> > > +.. code-block:: bash
> > > +
> > > + $ export UBOOT_CFG_CORTEXR="am62x_evm_r5_defconfig beagleplay_r5.config"
> > > + $ export UBOOT_CFG_CORTEXA="am62x_evm_a53_defconfig beagleplay_a53.config"
> >
> > Can you drop those two variables? It seems to just confuse the matter.
> > They are only used once. We are used to seeing a 'defconfig' target
> > when configuring, and this just obfuscates things.
>
> This is how we have a common bit of rST for how to build N boards,
> without having to do a literal copy and paste N times.

How about using this?

https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#substitution-definitions

Regards,
Simon
