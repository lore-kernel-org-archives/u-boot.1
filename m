Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CF4C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 13:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4F4984A6F;
	Thu,  2 Jul 2026 15:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ip7Vx+Z/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0C5684A60; Thu,  2 Jul 2026 15:09:32 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18CDE84A1C
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 15:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so1479112a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 06:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782997769; cv=none;
 d=google.com; s=arc-20260327;
 b=gP/XLSL0F+C63FYy0INswRc6Nzk6uM0QCXU/Gotj3FJgfdh5A6NXk45yEsC0qfqIEi
 5ZbPhsbeoZK3HIjWOE6xh8dLyGz48LgRly0dRXFHegHPfwwVd3cOxe3u12T9A+6gmNMp
 h0rzC/Iog9Rs2qVEIozF9IOI0HmV9Dr/+IbNjw3wlRGQWdFu6QHQFi8/x/PAK1zENiSv
 gQnW42JZLu9B/Y9ckMIFuEAS+KmUrp3h+O4DDWhhiWLTvGvEX1APSqqo4XQJj9Cnbnk5
 6PXmVcK6lal68YA/ZyXsg6WK1S2xVQbutRNUvUZCzk+GsfDtiyWO61RSB1dNrxmgQ7Bg
 BrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PCYs7oWKcLoxFJtl7I7QKG2VOxXWCPlk2FnV96QT8sU=;
 fh=6hUQ+cBDEhdswFVdh7jsmENQZaH9K2EJzvSA9UTasck=;
 b=gnLegEDlK/Wx5oBT7dnwAuJ+ECogB3kDmv1oMCoyTM7Si83NCaR1dpR1h03HQBCAzp
 sbNS0qrlwlom+Ib/hNU7BOSY9V/rH01xpzCziYyN8/Adkn5ZZdtfseiEFAKjg4/PhQkC
 3m2j7WI1xsLtdzy69PtzxncKuzlj4RPIgoo1zTfP7p3qIlUGMDTKwka+3jWGq55A3Saq
 CwlDJ3cfyQPqVSlVrbJy8XV9XC0OYtmMw2RHcAwAHenwmPDKGcObDDyAKqeJ1Wh9gk0F
 Kb/lxCcJBvm84bDag4BDkwZLANQStmnbjdRz/Q88nEh/PgqQCfLU+/snFvtaQ7UTH42x
 gRUA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782997769; x=1783602569; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PCYs7oWKcLoxFJtl7I7QKG2VOxXWCPlk2FnV96QT8sU=;
 b=Ip7Vx+Z/5b0zM6VM6Y/zKfvPUSZWTt323ue9sl2gdhwZ6Cn2xufJ7NDzb5YsPhai24
 ahNROC77PL8cI7Tya+ATwlCxmLbd8Hxu0mxodDQYg5F3XuF/oGueY7wpJgJsPKDd+cRx
 sMCOUip6PEsDgWNZ4uj3FBSWfy9P0CDdd7gls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782997769; x=1783602569;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PCYs7oWKcLoxFJtl7I7QKG2VOxXWCPlk2FnV96QT8sU=;
 b=EUoPHOfGhBcXo4VvcaMTQ5b0CEU0PjF2h6qePzH5RSbgAhdqgJtbJn4vP1cBc/prJD
 sGQy4NoCspRvO9JI1i9skXO1I2OlR4a9bZzZUnCzJkE5DSqORg9d9W25HocnMLmIMTao
 I90WNQYGURMML4WUAIEAsmXSkQQi1YfdXvYCgrrFdyjhohaQS5aIWecFqy3GEDtRwitl
 PrxoU74MEWa19YuDRdLUY1M1850N8ShsHf359teGejA0ShbaEC/uMx1RSL0U25xyWHOr
 8AOdMsHIO762VOOZQWK5WC2x/o6eqm3Xak+awRqgnsxEg19/IXTWCBJYsiWfPCNTTneZ
 2XUA==
X-Gm-Message-State: AOJu0Yyb0yPuJ/IGHg0JySlPN4ReXyMveyr76sQjMnW9ETQ+zVPpQzeN
 agGMOP73wELV+Q4d4wwcki8vRt7N8uQ35SV5ENe84Bm5ugmNJtfeJEaja82wQvLSSIcPowsFAPJ
 VxhhcueabhkLq6Gd2MiYedxJBqkrQyU1b74IP08FH
X-Gm-Gg: AfdE7cmP31KU+0CoH6vgFevRvTUQnvZd+l6cHUY8bUzVZWnMcw7ywldE7RrYXbVgQf2
 DCv6TYl34mu/CCEVP8MQjCc/s3RQ511WOvUbSmpdKaUKu4G3KkbQpLMRNxS8+t1xc39gVT+rZAO
 W3lNyI/1WtVPfQp1n5tXr8nkd5cp/R3U4Qs0xJTiDz6xCZJDoXWTTfcDhHiqy5vzCUhJYZr8bvs
 qnLzygt0gCRbIOkiIiZUMFHf0OkbF0xSAmgW2u+uqFUpqUxYrRirlGBO5BFWCSRGjoLGj92AA==
X-Received: by 2002:a05:6402:a503:10b0:698:f7d:4e11 with SMTP id
 4fb4d7f45d1cf-698a2c60221mr1568737a12.1.1782997769422; Thu, 02 Jul 2026
 06:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <205BD474-178D-4E91-8C41-33C46E1CCFBB@baylibre.com>
In-Reply-To: <205BD474-178D-4E91-8C41-33C46E1CCFBB@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 14:09:17 +0100
X-Gm-Features: AVVi8Cfq2PLM4O33SLF9VM_qvsTMwCirG2ypx4d7iH9_nZPOcoU_WSBurQX7Wyc
Message-ID: <CAFLszTgP05iS-4dyaLbzmPGppdMmFxUQvh=JJJGnSjKJ0MnL7Q@mail.gmail.com>
Subject: Re: [RFC] bootstd: firmware-owned OS devicetree for EBBR /
 SystemReady IR
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, dlechner@baylibre.com, jstephan@baylibre.com, 
 baylibre-upstreaming@groups.io
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

Hi Carlo,

On Tue, 30 Jun 2026 at 20:20, Carlo Caione <ccaione@baylibre.com> wrote:
>
> Hi all,
>
> This is a design RFC, not a patch series. I would like to agree the approach
> and the devicetree binding on the list before posting code, because the
> mechanism touches both bootstd and the EFI loader and introduces a new binding.
>
> A working implementation exists and has been validated on hardware (details at
> the end); I will post it as patches once the design here is acceptable.
>
>
> 1. The problem
> ==============
>
> Platforms that follow EBBR / Arm SystemReady IR treat the OS devicetree as part
> of the firmware rather than part of the OS: the base DTB and its overlays live
> on a firmware-owned partition and are updated independently of the operating
> system, instead of being shipped in the OS image or on the EFI System Partition
> (ESP). The firmware is expected to load that devicetree and hand it to the OS
> (via the EFI configuration table).
>
> U-Boot today can source the OS devicetree from its own control DT, from the ESP,
> or from an EFI Boot#### load option, but it has no generic way to assemble it
> from a firmware-owned partition. As a result vendors carry out-of-tree machinery
> for exactly this. For example, MediaTek ships downstream `dtbprobe` (assemble the
> DT from a partition) and `fdt authndtb` (authenticate it) commands. The goal of
> this work is to provide one reusable, vendor-neutral mechanism in mainline so
> those downstream commands can be dropped.
>

For Mediatek specifically, I am hoping to eventually upstream support
for a load-only FIT (the spec supports it) so that you can load the DT
from a firmware partition, then still boot the OS (without a DT). This
works with FIT, but would need adjustment if the OS is actually an EFI
app.

I wrote a post about this challenge:

https://www-concept.deinde.dev/blog/devicetree-in-firmware-or-packaged-with-the-os/

>
> 2. What a solution has to do
> ============================
>
>   - Assemble the OS devicetree (a base DTB plus a list of overlays) from a
>     firmware-owned partition and install it for the OS.
>   - Install it on *every* EFI launch path, not just one. SystemReady IR boots
>     through the UEFI boot manager, which in U-Boot does not go through the
>     per-device EFI bootmeth, so a per-device-only hook is not enough.
>   - Support secure boot: when the firmware devicetree is signed, verify it, and
>     never silently fall back to an unverified devicetree.
>   - Support A/B firmware partitions.
>
>
> 3. Proposed design
> ===================
>
> A new bootstd helper, `firmware_fdt_load()` (`CONFIG_BOOTSTD_FIRMWARE_FDT`),
> assembles the devicetree and returns it; the EFI launch paths install it via
> `efi_install_fdt()`, exactly like any other devicetree source.

This sounds reasonable to me.

>
> 3.1 Where the source is described (new binding)
> -----------------------------------------------
>
> The *location* is described in the control devicetree. The bootstd node carries
> a `firmware-fdt-source` phandle to a node that is a child of the media device
> that owns the partition, and identifies the partition by GPT type UUID and/or
> name:
>
>         bootstd {
>                 compatible = "u-boot,boot-std";
>                 firmware-fdt-source = <&fw_fdt>;
>         };
>
>         &mmc0 {
>                 fw_fdt: firmware-fdt {
>                         compatible = "u-boot,firmware-fdt-block";

Does the -block suffix indicate that it is a block device, rather than
a filesystem? How does this cope with the fast where multiple DTs are
provided for different models?

>                         partition-type-uuid = "....";   /* GPT type UUID */
>                         partition-name = "firmware";    /* optional */
>                         extra-size = <0x3000>;          /* overlay headroom */

This seems like a parameter which would be better handled by U-Boot itself?

>                 };
>         };
>
> 3.2 The dynamic parameters (environment) and board defaults
> -----------------------------------------------------------
>
> The source and its partition policy stay in the control devicetree (section
> 3.1). The values that change with the OS image rather than with the hardware are
> layered:
>
>   - the control DT describes the source and the partition policy;
>   - the board default environment carries factory defaults for the static values
>     (`fdtfile` and `dtb_path` for the base DTB, and the `fdt_addr_r` /
>     `fdtoverlay_addr_r` working addresses), so a from-source build boots and
>     `env default` restores a loadable configuration;

I wish we could move away from filenames and use compatible strings
instead, as FIT does - this is how the FDT spec is written.

>   - the (firmware-owned) stored environment overrides those at runtime, and
>     carries the genuinely dynamic values: the overlay list (`list_dtbo`) and the
>     A/B partition pin (`boot_dtb`).
>
> As an alternative, the stable defaults (`fdtfile` and the path) could instead be
> expressed as optional properties on the source node, keeping them in the control
> devicetree rather than in the board default environment. See the open questions.
>
> 3.3 Where it is installed (both EFI paths)
> ------------------------------------------
>
> The helper is consumed by both:
>
>   - the per-device EFI bootmeth (`bootmeth_efi`), and
>   - the EFI boot manager (`efi_bootmgr_run()`),
>
> each installing the result through `efi_install_fdt()`. That is the convergence
> point all EFI launches pass through, so the firmware devicetree is installed
> regardless of how the EFI application was started, including the boot-manager
> autoboot path that SystemReady IR uses.

What if you run GRUB?

>
> 3.4 Fail-closed error semantics
> -------------------------------
>
> Once a source is configured (the node is present), the result must be
> deterministic.

Yes, this is very important.

 `-ENOENT` means *only* that no source is configured, in which
> case the caller falls back to its normal devicetree. Any other failure to
> assemble a configured source (unresolvable device, no matching partition, read
> error, invalid blob, failed signature) is fatal for that EFI launch path: a
> missing or bad firmware devicetree is never silently replaced by another source.
> Missing environment metadata for a configured source is treated as a
> configuration error (fail closed, or satisfied from the board default), never as
> "no source".
>
> 3.5 Optional secure boot
> ------------------------
>
> With `CONFIG_BOOTSTD_FIRMWARE_FDT_FIT` the base DTB and overlays are signed FIT
> images. Each is verified by reusing U-Boot's existing verified-boot policy
> (`fit_image_load()` with verification enabled and a required key in the control
> FDT), and the verified flat devicetree is extracted in place. A non-FIT file is
> rejected so an unsigned devicetree cannot be installed. This reuses the existing
> trust model rather than adding new crypto, and replaces the downstream
> `fdt authndtb`.

OK.

>
>
> 4. Why these choices
> ====================
>
>   - Describing the source in the control DT, as a child of the media device,
>     follows the existing bootstd guidance ("if a bootdev needs configuration,
>     add it to the DT as a child of the media device") and the VBE precedent. It
>     keeps the mechanism generic: no GPT UUID or board constant in the C code.
>   - Splitting identity (control DT) from dynamic values (environment) and static
>     defaults (board default env) keeps the firmware in control of what changes
>     per OS image, while still letting a plain `make <board>_defconfig` build
>     boot.
>   - Installing at `efi_install_fdt()` rather than in one bootmeth is what makes
>     this SystemReady-IR-grade: the boot-manager path carries the firmware
>     devicetree too. A per-device-only hook leaves the autoboot path on the
>     control DT.
>   - Fail-closed is required for secure boot: there must be no path where a
>     configured, signed devicetree silently degrades to an unverified one.
>   - Reusing `fit_image_load()` keeps a single, reviewed verified-boot path.

Agreed on all of these.

>
>
> 5. Alternatives considered
> ==========================
>
>   - A global bootmeth ordered ahead of the EFI boot manager (a structure used in
>     an earlier proof of concept). It works for autoboot but does not converge
>     all launch paths; `efi_install_fdt()` is the real single point.
>   - A per-device bootmeth hook only. Simpler, but misses the boot-manager
>     autoboot path, which is the one SystemReady IR uses.
>   - Keeping the mechanism vendor-specific (the status quo). Does not help anyone
>     else and keeps the command out of tree.
>
>
> 6. Open questions for the list
> ==============================
>
>   1. Binding naming: are `firmware-fdt-source` and the `u-boot,firmware-fdt-block`
>      compatible acceptable, and is the control-DT-described-source shape the one
>      you want?

Seems OK.

>   2. The configuration boundary. The proposal keeps the source and partition
>      policy in the control DT, puts factory defaults for the filenames and the
>      working addresses in the board default environment, and lets the
>      firmware-owned stored environment override at runtime (and hold the dynamic
>      `list_dtbo` / `boot_dtb`). An alternative is to express the stable defaults
>      (`fdtfile`, a path) as optional properties on the source node, so they live
>      in the control DT rather than the board environment. Which does the project
>      prefer?

See above...better to store a compatible string than a filename.

>   3. The `efi_bootmgr_run()` hook: is installing the firmware devicetree on the
>      boot-manager path acceptable to the EFI maintainers, and is that the right
>      place?
>   4. The fail-closed semantics: a configured source that cannot be assembled is
>      fatal; only an absent source falls back. Agree?

Yes

>   5. Should the signed-FIT verification be part of this series or a follow-up?

You likely get this for free, so I suggest including it.

>
> Thanks for any feedback. I will follow up with the patch series once the binding
> and approach are agreed.

Regards,
Simon
