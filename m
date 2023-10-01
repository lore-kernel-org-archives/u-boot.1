Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A38BE748ED
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 13:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2115486EF1;
	Sun,  1 Oct 2023 15:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VM6TIzHB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA09B870A6; Sun,  1 Oct 2023 15:29:04 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C3B786DFF
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 15:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d8164e661abso17380981276.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 06:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696166941; x=1696771741; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mNpiMl/CUZvZKkI14tIvWy/MkH7szYQdXIF95nICbJM=;
 b=VM6TIzHBaWFmpZfGyK7lUxtYJfzwwHO8fknzKUfjpm+ylpyEQpE+YA6HIydLWDDE4s
 llXzUazLCvzGy8AE9YJEMttzmxMXW4eYyseLOVtpuJ7CPjvk94hihjkzi4OOMFOoIsm4
 nQReO5SEUxwwTu0iHlMYanU9Bh2ZqC1njQ64cq0JGQICuA/zDQNASUvwo3N49Vczg2Ba
 yqoSAe1IDUbZmkqkvbqwM1ohoaKNq1bqdlMdWzuHoOLkdfjx5w4KfntJcplZ5EWFzfs+
 a8I/QRLOfKj4rP/iQr0FugKdixDLAvREm8YsXWsvQfiyeS+uCjqvzE0Ms+XMXDFeP4b+
 490g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696166941; x=1696771741;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mNpiMl/CUZvZKkI14tIvWy/MkH7szYQdXIF95nICbJM=;
 b=o2pR1G8yzMKEtQz7hXCn4LEtL6vqEZ7jfZXZQWOlscT9mGrzQgA6gwtVrwCImHZWWr
 aWGP1fJ8XqzY4ZZsplg4CfcXbap4MDyLBc3m1Ws/cUeb6hf1JeRzm3Iv/6iZ+AUX52gg
 Xn7GXwkq7Z1KV/NbL0kdebIQxsI1P54EyLocXkd+mU6G98ldS5dZZ/WnIgilk3V0fG7u
 tjsBtgaWVFCP8bwMR3teG/FUId6xAQdKfNEAsAOUELeK2ruFEz1xRCB3ddMoHPYdRBGm
 7EIf6uxNSK9cN4Lcy88zAB+9dJfXDNBBUcvZpyX97Sdy5P5Jq4HZSunt3eKcrL9Wgbwo
 vh5Q==
X-Gm-Message-State: AOJu0YwbOxqJ3MZgnwHYzWBbMdue3nE6YqEY97vmQ6P6CG9bxGBfD6WZ
 1Z1ZN25SLd648p10n3RkaTltlqkeTJJsL5itxO0=
X-Google-Smtp-Source: AGHT+IHi6rM4OL4thcJriHpv+com1FaHdoySK8qUPvU3m78teh8qkg0up5uQeVcTClvyNTq8VXZnEFajEHUq1CKs9q8=
X-Received: by 2002:a25:403:0:b0:d7f:cdc8:e184 with SMTP id
 3-20020a250403000000b00d7fcdc8e184mr9040745ybe.49.1696166940965; Sun, 01 Oct
 2023 06:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230820220316.3517102-1-jonas@kwiboo.se>
 <05a3d9d4-cdcd-4145-aece-727f14a7efb3@kernel.org>
 <6087c770-4802-5c2f-322a-18eab9940a1e@kwiboo.se>
 <b258db08-c49b-4381-8265-7d49b41e0d00@kernel.org>
In-Reply-To: <b258db08-c49b-4381-8265-7d49b41e0d00@kernel.org>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 1 Oct 2023 15:28:47 +0200
Message-ID: <CAC928HY2rZoz6L8za+L20GAsbJCBYOe+k75L_N3aE-78smnLfg@mail.gmail.com>
Subject: Re: [PATCH v2] dm: core: Report bootph-pre-ram/sram node as pre-reloc
 after relocation : regression
To: Roger Quadros <rogerq@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
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

Il giorno ven 29 set 2023 alle ore 13:23 Roger Quadros
<rogerq@kernel.org> ha scritto:
>
>
>
> On 28/09/2023 22:18, Jonas Karlman wrote:
> > Hi Roger,
> >
> > On 2023-09-28 14:59, Roger Quadros wrote:
> >> Hi,
> >>
> >> On 21/08/2023 01:03, Jonas Karlman wrote:
> >>> Nodes with bootph-pre-sram/ram props are bound in multiple phases:
> >>> 1. At TPL (bootph-pre-sram) or SPL (bootph-pre-ram) phase
> >>> 2. At U-Boot proper pre-relocation phase
> >>> 3. At U-Boot proper normal phase
> >>>
> >>> However the binding and U-Boot Driver Model documentation indicate that
> >>> only nodes marked with bootph-all or bootph-some-ram should be bound in
> >>> the U-Boot proper pre-relocation phase.
> >>>
> >>> Change ofnode_pre_reloc to report a node with bootph-pre-ram/sram prop
> >>> with a pre-reloc status only after U-Boot proper pre-relocation phase.
> >>> Also update the ofnode_pre_reloc documentation to closer reflect the
> >>> binding and driver model documentation.
> >>>
> >>> This changes behavior of what nodes are bound in the U-Boot proper
> >>> pre-relocation phase. Change to bootph-all or add bootph-some-ram prop
> >>> to restore prior behavior.
> >>>
> >>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>> Changes in v2:
> >>> - Drop use of !! to convert into bool
> >>> - Update documentation for ofnode_pre_reloc
> >>> - Rewrite commit message
> >>> - Collect r-b tag
> >>
> >> This patch breaks boot on AM642-EVM. Boot log at the end.
> >
> > From what I can tell your board use a lot of bootph-pre-ram.
> > https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> >
> > What happens if you change to bootph-all or add bootph-some-ram next to
> > bootph-pre-ram on devices that is also needed in U-Boot proper
> > pre-relocation phase in addition to SPL phase?
>
> Then it works.
>
> BTW, AM62-SK is broken as well and I suppose most K3 TI boards would be broken.
>
> Nishanth / Tom,
>
> What approach to take here?
> Replacing bootph-pre-ram to bootph-all in *-u-boot.dtsi would be a quick fix.

An exact quick fix is to add bootph-some-ram next to bootph-pre-ram:
this will have the same effects of bootph-pre-ram before the patch.
Instead, replacing bootph-pre-ram with bootph-all will affect also
other boot phases (e.g. TPL) if any.

Regards,
Massimo

> Then we need to mark nodes required only for SPL as bootph-pre-ram.
>
> Meanwhile I will suggest to revert the $subject patch till this is sorted out
> and gets a Ack from board maintainers.
>
> cheers,
> -roger
>
> >
> > Regards,
> > Jonas
> >
> >>
> >>>
> >>>  drivers/core/ofnode.c | 2 +-
> >>>  include/dm/ofnode.h   | 8 ++++----
> >>>  2 files changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> >>> index 8df16e56af5c..b1e94b2d60df 100644
> >>> --- a/drivers/core/ofnode.c
> >>> +++ b/drivers/core/ofnode.c
> >>> @@ -1353,7 +1353,7 @@ bool ofnode_pre_reloc(ofnode node)
> >>>      */
> >>>     if (ofnode_read_bool(node, "bootph-pre-ram") ||
> >>>         ofnode_read_bool(node, "bootph-pre-sram"))
> >>> -           return true;
> >>> +           return gd->flags & GD_FLG_RELOC;
> >>>
> >>>     if (IS_ENABLED(CONFIG_OF_TAG_MIGRATE)) {
> >>>             /* detect and handle old tags */
> >>> diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
> >>> index 0f38b3e736de..13700f8266d7 100644
> >>> --- a/include/dm/ofnode.h
> >>> +++ b/include/dm/ofnode.h
> >>> @@ -1198,15 +1198,15 @@ int ofnode_read_simple_size_cells(ofnode node);
> >>>   * determine if a node was bound in one of SPL/TPL stages.
> >>>   *
> >>>   * There are 4 settings currently in use
> >>> - * - bootph-some-ram: U-Boot proper pre-relocation only
> >>> + * - bootph-some-ram: U-Boot proper pre-relocation phase
> >>>   * - bootph-all: all phases
> >>>   * Existing platforms only use it to indicate nodes needed in
> >>>   * SPL. Should probably be replaced by bootph-pre-ram for new platforms.
> >>> - * - bootph-pre-ram: SPL and U-Boot pre-relocation
> >>> - * - bootph-pre-sram: TPL and U-Boot pre-relocation
> >>> + * - bootph-pre-ram: SPL phase
> >>> + * - bootph-pre-sram: TPL phase
> >>>   *
> >>>   * @node: node to check
> >>> - * Return: true if node is needed in SPL/TL, false otherwise
> >>> + * Return: true if node should be or was bound, false otherwise
> >>>   */
> >>>  bool ofnode_pre_reloc(ofnode node);
> >>>
> >>
> >> ---boot log---
> >>
> >> U-Boot SPL 2023.10-rc4-00480-g9e644284ab (Sep 28 2023 - 15:53:09 +0300)
> >> Resetting on cold boot to workaround ErrataID:i2331
> >> Please resend tiboot3.bin in case of UART/DFU boot
> >> resetting ...
> >>
> >> U-Boot SPL 2023.10-rc4-00480-g9e644284ab (Sep 28 2023 - 15:53:09 +0300)
> >> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
> >> SPL initial stack usage: 13408 bytes
> >> Trying to boot from MMC2
> >> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> >> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> >> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> >> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> >> Loading Environment from MMC... *** Warning - No MMC card found, using default environment
> >>
> >> Starting ATF on ARM64 core...
> >>
> >> NOTICE:  BL31: v2.8(release):v2.8-226-g2fcd408bb3-dirty
> >> NOTICE:  BL31: Built : 00:42:57, Jan 13 2023
> >> I/TC:
> >> I/TC: OP-TEE version: 3.20.0 (gcc version 11.3.0 (GCC)) #1 Fri Jan 20 15:42:54 UTC 2023 aarch64
> >> I/TC: WARNING: This OP-TEE configuration might be insecure!
> >> I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html
> >> I/TC: Primary CPU initializing
> >> I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
> >> I/TC: HUK Initialized
> >> I/TC: Activated SA2UL device
> >> I/TC: Fixing SA2UL firewall owner for GP device
> >> I/TC: Enabled firewalls for SA2UL TRNG device
> >> I/TC: SA2UL TRNG initialized
> >> I/TC: SA2UL Drivers initialized
> >> I/TC: Primary CPU switching to normal world boot
> >>
> >> U-Boot SPL 2023.10-rc4-00480-g9e644284ab (Sep 28 2023 - 15:54:37 +0300)
> >> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
> >> Trying to boot from MMC2
> >> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> >> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> >>
> >> ---boot log end---
> >>
> >> we expect U-Boot banner to be printed next but nothing is printed.
> >>
> >
>
