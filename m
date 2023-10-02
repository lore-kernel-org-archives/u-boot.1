Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C77CE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D051587478;
	Mon,  2 Oct 2023 03:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HfH0q+nq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3F2871D0; Mon,  2 Oct 2023 03:22:21 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCDF587191
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9b275afb6abso568149266b.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209733; x=1696814533; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w9Pn84SqhCsqqkqEz4Z/M59frFTn5dHr3t6THG82QWY=;
 b=HfH0q+nqnXG2N7Y01QQB008yVkczGQyoweuRzh68orPLjI03wZp4iyenG4w0Nso0MH
 z9lXkM2cDQ2WR90eCvRY1MN3+7pyrDdvFe+ljLPq+gYuF3jdk5bKlib4lhfjmXPaMmbP
 yCndoSRPC05mavm1+FV3KXy/bhlJngxQpDHso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209733; x=1696814533;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w9Pn84SqhCsqqkqEz4Z/M59frFTn5dHr3t6THG82QWY=;
 b=jhcrAu0KuISwZNRcEDxR//8zsIGP8hdUHyK1ga7O7m+uZeQS9AC8iu3gxLIsNsLcTw
 1xzjHaaFgq7LVcmI1IEYdix94NM2vk278gek3zdJIKmYSg+vcilwqKqhB8/zbAyGp+os
 PCPiQJPtqMNZVsnwUxzUUXYg9g7aHHfQGdZ1F42zvPZa6NedBulzOPWfoniqGqJmHTPh
 ohUIRUMyBP4drJLPLQHdcD4Up2d2HElJdurOgLfIjSNxDFmywIJ+sv9RCiuckJ9Glbbw
 KDcdRTyI6QK2EPV8cip84yUwCv7hJ48MlsuONvnhb0ir9iZ5iPltw+wx7sLlhmq30keQ
 nEDg==
X-Gm-Message-State: AOJu0YxvPYpN1Y0nilAvGlkKKBZJjXvueoATXk/Pn2Jm4oBAhM1VeCBz
 BRF55Q7e8Nsdz90I9ZpxIunOkwZsv7hH0+On808Jgw==
X-Google-Smtp-Source: AGHT+IFQsrzeVmfrhASS5IRLZES4wY2P2ZUtcKO7duke7eTfzafyz68AWzXXKlcqwQM+GwpA2XfPieebjTq7mUy4Ix0=
X-Received: by 2002:a17:907:c1e:b0:9ae:6648:9b53 with SMTP id
 ga30-20020a1709070c1e00b009ae66489b53mr10815436ejc.23.1696209733224; Sun, 01
 Oct 2023 18:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230820220316.3517102-1-jonas@kwiboo.se>
 <05a3d9d4-cdcd-4145-aece-727f14a7efb3@kernel.org>
 <6087c770-4802-5c2f-322a-18eab9940a1e@kwiboo.se>
 <b258db08-c49b-4381-8265-7d49b41e0d00@kernel.org>
 <CAC928HY2rZoz6L8za+L20GAsbJCBYOe+k75L_N3aE-78smnLfg@mail.gmail.com>
In-Reply-To: <CAC928HY2rZoz6L8za+L20GAsbJCBYOe+k75L_N3aE-78smnLfg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:16:39 -0600
Message-ID: <CAPnjgZ3MgWX8T0A0SofphEr_Xd77pE3hte9DNye1RuBVeB9N8Q@mail.gmail.com>
Subject: Re: [PATCH v2] dm: core: Report bootph-pre-ram/sram node as pre-reloc
 after relocation : regression
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Roger Quadros <rogerq@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Tom Rini <trini@konsulko.com>, 
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 "Andrew F. Davis" <afd@ti.com>, 
 "Berard, Brian" <bberard@ti.com>, "Bajjuri, Praneeth" <praneeth@ti.com>
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

Hi Massimo,

On Sun, 1 Oct 2023 at 07:29, Massimo Pegorer
<massimo.pegorer+oss@gmail.com> wrote:
>
> Il giorno ven 29 set 2023 alle ore 13:23 Roger Quadros
> <rogerq@kernel.org> ha scritto:
> >
> >
> >
> > On 28/09/2023 22:18, Jonas Karlman wrote:
> > > Hi Roger,
> > >
> > > On 2023-09-28 14:59, Roger Quadros wrote:
> > >> Hi,
> > >>
> > >> On 21/08/2023 01:03, Jonas Karlman wrote:
> > >>> Nodes with bootph-pre-sram/ram props are bound in multiple phases:
> > >>> 1. At TPL (bootph-pre-sram) or SPL (bootph-pre-ram) phase
> > >>> 2. At U-Boot proper pre-relocation phase
> > >>> 3. At U-Boot proper normal phase
> > >>>
> > >>> However the binding and U-Boot Driver Model documentation indicate that
> > >>> only nodes marked with bootph-all or bootph-some-ram should be bound in
> > >>> the U-Boot proper pre-relocation phase.
> > >>>
> > >>> Change ofnode_pre_reloc to report a node with bootph-pre-ram/sram prop
> > >>> with a pre-reloc status only after U-Boot proper pre-relocation phase.
> > >>> Also update the ofnode_pre_reloc documentation to closer reflect the
> > >>> binding and driver model documentation.
> > >>>
> > >>> This changes behavior of what nodes are bound in the U-Boot proper
> > >>> pre-relocation phase. Change to bootph-all or add bootph-some-ram prop
> > >>> to restore prior behavior.
> > >>>
> > >>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > >>> Reviewed-by: Simon Glass <sjg@chromium.org>
> > >>> ---
> > >>> Changes in v2:
> > >>> - Drop use of !! to convert into bool
> > >>> - Update documentation for ofnode_pre_reloc
> > >>> - Rewrite commit message
> > >>> - Collect r-b tag
> > >>
> > >> This patch breaks boot on AM642-EVM. Boot log at the end.
> > >
> > > From what I can tell your board use a lot of bootph-pre-ram.
> > > https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> > >
> > > What happens if you change to bootph-all or add bootph-some-ram next to
> > > bootph-pre-ram on devices that is also needed in U-Boot proper
> > > pre-relocation phase in addition to SPL phase?
> >
> > Then it works.
> >
> > BTW, AM62-SK is broken as well and I suppose most K3 TI boards would be broken.
> >
> > Nishanth / Tom,
> >
> > What approach to take here?
> > Replacing bootph-pre-ram to bootph-all in *-u-boot.dtsi would be a quick fix.
>
> An exact quick fix is to add bootph-some-ram next to bootph-pre-ram:
> this will have the same effects of bootph-pre-ram before the patch.
> Instead, replacing bootph-pre-ram with bootph-all will affect also
> other boot phases (e.g. TPL) if any.

Yes.

Since this is in -next we have plenty of time to get things figured
out before it ends up in a release.

Regards,
Simon


>
> Regards,
> Massimo
>
> > Then we need to mark nodes required only for SPL as bootph-pre-ram.
> >
> > Meanwhile I will suggest to revert the $subject patch till this is sorted out
> > and gets a Ack from board maintainers.
> >
> > cheers,
> > -roger
> >
> > >
> > > Regards,
> > > Jonas
> > >
> > >>
> > >>>
> > >>>  drivers/core/ofnode.c | 2 +-
> > >>>  include/dm/ofnode.h   | 8 ++++----
> > >>>  2 files changed, 5 insertions(+), 5 deletions(-)
> > >>>
> > >>> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> > >>> index 8df16e56af5c..b1e94b2d60df 100644
> > >>> --- a/drivers/core/ofnode.c
> > >>> +++ b/drivers/core/ofnode.c
> > >>> @@ -1353,7 +1353,7 @@ bool ofnode_pre_reloc(ofnode node)
> > >>>      */
> > >>>     if (ofnode_read_bool(node, "bootph-pre-ram") ||
> > >>>         ofnode_read_bool(node, "bootph-pre-sram"))
> > >>> -           return true;
> > >>> +           return gd->flags & GD_FLG_RELOC;
> > >>>
> > >>>     if (IS_ENABLED(CONFIG_OF_TAG_MIGRATE)) {
> > >>>             /* detect and handle old tags */
> > >>> diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
> > >>> index 0f38b3e736de..13700f8266d7 100644
> > >>> --- a/include/dm/ofnode.h
> > >>> +++ b/include/dm/ofnode.h
> > >>> @@ -1198,15 +1198,15 @@ int ofnode_read_simple_size_cells(ofnode node);
> > >>>   * determine if a node was bound in one of SPL/TPL stages.
> > >>>   *
> > >>>   * There are 4 settings currently in use
> > >>> - * - bootph-some-ram: U-Boot proper pre-relocation only
> > >>> + * - bootph-some-ram: U-Boot proper pre-relocation phase
> > >>>   * - bootph-all: all phases
> > >>>   * Existing platforms only use it to indicate nodes needed in
> > >>>   * SPL. Should probably be replaced by bootph-pre-ram for new platforms.
> > >>> - * - bootph-pre-ram: SPL and U-Boot pre-relocation
> > >>> - * - bootph-pre-sram: TPL and U-Boot pre-relocation
> > >>> + * - bootph-pre-ram: SPL phase
> > >>> + * - bootph-pre-sram: TPL phase
> > >>>   *
> > >>>   * @node: node to check
> > >>> - * Return: true if node is needed in SPL/TL, false otherwise
> > >>> + * Return: true if node should be or was bound, false otherwise
> > >>>   */
> > >>>  bool ofnode_pre_reloc(ofnode node);
> > >>>
> > >>
> > >> ---boot log---
> > >>
> > >> U-Boot SPL 2023.10-rc4-00480-g9e644284ab (Sep 28 2023 - 15:53:09 +0300)
> > >> Resetting on cold boot to workaround ErrataID:i2331
> > >> Please resend tiboot3.bin in case of UART/DFU boot
> > >> resetting ...
> > >>
> > >> U-Boot SPL 2023.10-rc4-00480-g9e644284ab (Sep 28 2023 - 15:53:09 +0300)
> > >> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
> > >> SPL initial stack usage: 13408 bytes
> > >> Trying to boot from MMC2
> > >> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> > >> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> > >> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> > >> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> > >> Loading Environment from MMC... *** Warning - No MMC card found, using default environment
> > >>
> > >> Starting ATF on ARM64 core...
> > >>
> > >> NOTICE:  BL31: v2.8(release):v2.8-226-g2fcd408bb3-dirty
> > >> NOTICE:  BL31: Built : 00:42:57, Jan 13 2023
> > >> I/TC:
> > >> I/TC: OP-TEE version: 3.20.0 (gcc version 11.3.0 (GCC)) #1 Fri Jan 20 15:42:54 UTC 2023 aarch64
> > >> I/TC: WARNING: This OP-TEE configuration might be insecure!
> > >> I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html
> > >> I/TC: Primary CPU initializing
> > >> I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
> > >> I/TC: HUK Initialized
> > >> I/TC: Activated SA2UL device
> > >> I/TC: Fixing SA2UL firewall owner for GP device
> > >> I/TC: Enabled firewalls for SA2UL TRNG device
> > >> I/TC: SA2UL TRNG initialized
> > >> I/TC: SA2UL Drivers initialized
> > >> I/TC: Primary CPU switching to normal world boot
> > >>
> > >> U-Boot SPL 2023.10-rc4-00480-g9e644284ab (Sep 28 2023 - 15:54:37 +0300)
> > >> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
> > >> Trying to boot from MMC2
> > >> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> > >> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> > >>
> > >> ---boot log end---
> > >>
> > >> we expect U-Boot banner to be printed next but nothing is printed.
> > >>
> > >
> >
