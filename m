Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9744CC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF2384832;
	Fri,  3 Jul 2026 13:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lyhwAxs2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 245F384979; Fri,  3 Jul 2026 13:49:37 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26CCC8469D
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-664cb440f9eso557513d50.1
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 04:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783079372; cv=none;
 d=google.com; s=arc-20260327;
 b=EEI3GUNJdQ3Ak8j9b/aU8dqwvJOmgF42VqBXtdTSpZr35Fuua8PBzcBzA9GtQDHeCs
 MiVg9zscGA5dNYR8zApFoZE3XofgGXWefdqhR+09U6d5zfvNhqhQxRGcnnKhoIJoRVcs
 hzmWobCYUcyYWbl8U/qpDImkhuerBHc+Oid8SVtkxOnTV39nkQWUfFXLwOev23hMBQAB
 qZWU4F/pM7qgPD9RLUWOEIrNrfEYLPySLs2OjM3P9D4Kjt+Bnw/ebNs+jJ2/ZT4Eh7Ye
 l+BMR8V8qYCJaaLPJ6e/S52LrCgHwwTHfzEWg9iQL7s5JpbTGX/STp+J+Jwws+pSDx+Y
 9wvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WCeCRCScrD6bTuqbmRfM/Whux5fZ/G//QTmNtXjlINk=;
 fh=i7Ykna/Zx96hum3n0GRaGqwDM1KjKP8vo5bjptFJDKI=;
 b=GQYyFKjfb7PLKKh3f3o0WyhgfAGbxsUjLlczrnVTADLKcNKG1sDAhWVi2+Twn5nefI
 XAEwhn+FEN4ghRTdFcB/6tMvN433fa8bY7GrCN9mABfrQSkOYue/awbSAWDsIq9UMzdv
 2WdN3/LvlSpsL9oVUZ2klS1IBUwTGS1n6lnb2rNzNFEPnF3u1mVNxRz8nkp9vW8aDmgf
 RdC3Bqt6q48m1cwEjlPuq50zXfg3GW1pFqQfE5goSX6yU0SAfawUcROOqUyYlKIdAF/L
 /coGhaai84eGxgPT1ImsHjYF3b6AGFy20/fzj0C6CgiSu0JRFhPdfnIhxDQTKkK4WjLk
 MnKQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783079372; x=1783684172; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WCeCRCScrD6bTuqbmRfM/Whux5fZ/G//QTmNtXjlINk=;
 b=lyhwAxs21BbDuJ3FSrZQ1mmu7GsvDv1ACurv9Okk8HetfJXamQOml+wJ38KMvI8IuH
 b9gCMDc11RhyzsoAquq385bwBds1WgJjtgmDbJ8BNE7YZwsfWB0wiUOhrN6stvpUYIEk
 mjkqCmI/F5OCF+jjcdF29K1hiqiVzxArfKL+XqtOK8+jnevieqaVlXyKghJMsyVRPnRf
 Ra+MT6aOl7NXkmBH+bekQffG6Lx+GU5SPxXp5huYhQu7hMwje8njVfl2yx2H2isxs8cY
 5ePXI3arhJvDtx2+eU05jXz3/u3Mc8ZwxCsoqthr13e0IpoQ0IEAMLmRqI6oTWolGKDf
 1YIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783079372; x=1783684172;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WCeCRCScrD6bTuqbmRfM/Whux5fZ/G//QTmNtXjlINk=;
 b=XJXXdcC7/d4YboTIlm+ZgVeNalCn6HS8RQWZlgrBYxUsnxmLsrTVxaAN/Z91LaD1Rf
 5f6u4QLmlZf6na5Rc8Nn0QDt0LaDtrt2ODyr7BPVfQke2UHnGJlxYMLm5NnoblbrAstE
 hScZv3hOuTp4y31NOalTYCuCgNEJJbLbnAXvScrvESt9dawNtzTYeIhEuhwEjCBz/sdo
 yFYQbbm+SI0YbMNOcWMH9nbOvSYIkzTRDIP8r+NMHg4ugFQehgy0NU0c17mAvOXvE3qC
 yIeGGvl8UTj/8EeS1pxOlzNXda6ucy30XMJqAeAWGaRyvAdNAZ71xhC9Bw9uoiFjZm7x
 W5XQ==
X-Gm-Message-State: AOJu0YyzmHUFrl27f2GHB6L0MHvGvEzvNLUakep6LUX+GCkoQXzbHl30
 kt2fJauWznSDwKr3vUveyfHy28NZgIxTOjH0737w9uYUBQsG33OX5eYoeJfCKjlJ2Bhid+EBnYw
 RA3RfVNyfwWrDK5+TY9tz1hkxyPCG3KLczdSMqY3Zaw==
X-Gm-Gg: AfdE7cnzypesVQ14jAjK4oYT23grGUNMD2/F7wHBg0hmk/lxkxY8ceylFfEy2pGMiek
 ZVUBnkS+F97W2W7FJrDxh4MJrMypE114gypk/AHpyq3xcks3N/dRgTt157dd536eWenmgjrWZ2O
 TRwiQLfV1SrTPOWrQlRNf5BaU8VQs9ff/8JnX2H2EAqMklaqwm+qd9UQU25HFyXGzfyfJE/zFtr
 yVkcIql1IfX8rAzVclHuc4dhEXdZ/2gzKebSCzYRVNrNO4Yu7Yn7PkoVX9XnwffPhVQMvUBK0Fd
 e1bCzBGER/XOZG92QuCOHqlIrI/r4k0FPFxBWEyPXs0t6p+ggp54dM42EKYFEYmjG3Esm3sP/8c
 hP/1GZBs8pwe+iYlYdTqCc3YPXFYyzprYHwV0eTqioIOCHLn0cw/dYRcTS+VzBm0Q5dElQuR1sr
 2TzbmNVNhVFzhOT3aBv9jdgA3ea6Qw8Blm1gMUPOPviy/rTjbiMdJ+/cjQWTve1T99OppHOjXvz
 7rbvI1RdYwl34ZBTFm7pVSOlyYOTFXZVTBKGzHzB384kZyt51svEhObMI4VMAIwHvMWXZNgCacT
 q8L0XLAvhr/eTIqTxsPRjbrAQkleKW8nLsbPfAnNKMQUjTOnERjHWmuyw3JIFY6welbkA1Q=
X-Received: by 2002:a05:690e:1441:b0:664:cb17:ec7b with SMTP id
 956f58d0204a3-665219bc871mr9188509d50.27.1783079371540; Fri, 03 Jul 2026
 04:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <140504E6-5BCB-4566-A03F-2A94B0F5BA01@baylibre.com>
In-Reply-To: <140504E6-5BCB-4566-A03F-2A94B0F5BA01@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 3 Jul 2026 14:48:55 +0300
X-Gm-Features: AVVi8CemhNKmUUDPQWgqEih3Qu71rwROET8Onrywcn0kgzQpRqFpNo33PTW0w2Q
Message-ID: <CAC_iWjKUghtMYU_g4JUJbXF12sGL=zW8W8bcCfNWRsN7xx11Yg@mail.gmail.com>
Subject: Re: [RFC v2] bootstd: firmware-owned OS devicetree for EBBR /
 SystemReady IR
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de, 
 trini@konsulko.com, dlechner@baylibre.com, jstephan@baylibre.com, 
 baylibre-upstreaming@groups.io, a.fatoum@barebox.org
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

Hi Carlo,

On Fri, 3 Jul 2026 at 12:40, Carlo Caione <ccaione@baylibre.com> wrote:
>
> Hi all,
>
> This is v2 of a design RFC, not a patch series. v1 [1] proposed a mechani=
sm
> for sourcing the OS devicetree from a firmware-owned partition; v2 refine=
s the
> same design. The main change is that the devicetree set is now described =
by a
> firmware-owned FIT manifest carried on that partition, instead of by envi=
ronment
> variables.
>
> This text is self-contained; you do not need to have read v1.
>
> A working implementation exists, with sandbox tests, and has been validat=
ed end
> to end on hardware in both the plain and the secure (signed) setup.
>
> 1. The problem
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Platforms that follow EBBR / Arm SystemReady IR treat the OS devicetree a=
s part

Not the OS devicetree. The devicetree. It should be a single entity
consumed by the firmware, os etc.

> of the firmware rather than part of the OS: the base DTB and its overlays=
 live
> on a firmware-owned partition and are updated independently of the operat=
ing
> system, instead of being shipped in the OS image or on the EFI System Par=
tition
> (ESP). The firmware is expected to load that devicetree and hand it to th=
e OS
> (via the EFI configuration table).
>
> U-Boot today can source the OS devicetree from its own control DT, from t=
he ESP,
> or from an EFI Boot#### load option, but it has no generic way to assembl=
e it
> from a firmware-owned partition. As a result vendors carry out-of-tree ma=
chinery
> for exactly this.
>
> For example, MediaTek ships downstream 'dtbprobe' (assemble the DT from a
> partition) and 'fdt authndtb' (authenticate it) commands. The goal of thi=
s
> work is to provide one reusable, vendor-neutral mechanism in mainline so =
those
> downstream commands can be dropped.
>
>
> 2. What a solution has to do
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>   - Assemble the OS devicetree (a base DTB plus a list of overlays) from =
a
>     firmware-owned partition and install it for the OS.
>   - Install it on *every* EFI launch path, not just one. SystemReady IR b=
oots
>     through the UEFI boot manager, which in U-Boot does not go through th=
e
>     per-device EFI bootmeth, so a per-device-only hook is not enough.

This should be happening already
commit 7e624377e99 has some info

>   - Support secure boot: when the firmware devicetree is signed, verify i=
t, and
>     never silently fall back to an unverified devicetree.
>   - Support A/B firmware partitions and per-SKU devicetree variants.
>
>
> 3. Proposed design
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> A bootstd helper, firmware_fdt_load() (CONFIG_BOOTSTD_FIRMWARE_FDT), asse=
mbles
> the devicetree from a FIT manifest on the firmware partition and returns =
it;
> the EFI launch paths install the result via efi_install_fdt(), exactly li=
ke any
> other devicetree source.
>
> 3.1 The manifest: describe and carry in one artefact
> ----------------------------------------------------
>
> The partition carries one FIT image (by default 'fdt.itb'). Its images ho=
ld
> the base DTB and the overlays; each of its configurations names one boota=
ble
> combination through the standard 'fdt' property:
>
>         /dts-v1/;
>         / {
>                 description =3D "Firmware-owned OS devicetree";
>                 #address-cells =3D <1>;
>
>                 images {
>                         fdt-base {
>                                 data =3D /incbin/("board.dtb");
>                                 type =3D "flat_dt";
>                                 arch =3D "arm64";
>                                 compression =3D "none";
>                                 hash-1 { algo =3D "sha256"; };
>                         };
>                         fdt-panel {
>                                 data =3D /incbin/("panel.dtbo");
>                                 type =3D "flat_dt";
>                                 arch =3D "arm64";
>                                 compression =3D "none";
>                                 hash-1 { algo =3D "sha256"; };
>                         };
>                 };
>
>                 configurations {
>                         default =3D "conf-panel";
>                         conf-panel {
>                                 fdt =3D "fdt-base", "fdt-panel";
>                         };
>                         conf-base {
>                                 fdt =3D "fdt-base";
>                         };
>                 };
>         };
>
> The helper selects a configuration, verifies it, and assembles the device=
tree
> by reusing boot_get_fdt_fit(), the same code path bootm already uses for
> FIT-carried devicetrees: multi-configuration selection, per-image verific=
ation,
> overlay application in the listed order, and packing of the result. No ne=
w
> format, parser, or crypto is introduced.
>
> The manifest must be self-contained: images must be 'flat_dt' with embedd=
ed
> data (external-data FITs are rejected) and must not carry a 'load' proper=
ty
> (rejected, so a misbuilt manifest cannot overwrite arbitrary memory).
>
> 3.2 Where the partition is described (new binding)
> --------------------------------------------------
>
> The *location* is described in the control devicetree. The bootstd node c=
arries
> a 'firmware-fdt-source' phandle to a node that is a child of the media de=
vice
> that owns the partition:

A lot of boards are building with  CONFIG_OF_UPSTREAM. Is this
something that wil be injected in the DT during build?

>
>         bootstd {
>                 compatible =3D "u-boot,boot-std";
>                 firmware-fdt-source =3D <&fw_fdt>;
>         };
>
>         &mmc0 {
>                 fw_fdt: firmware-fdt {
>                         compatible =3D "u-boot,firmware-fdt-block";
>                         partition-type-uuid =3D "....";   /* GPT type UUI=
D */
>                         partition-name =3D "firmware";    /* optional */
>                         filename =3D "fdt.itb";           /* optional, th=
e default */
>                 };
>         };
>
> The '-block' suffix names the backend: a block device with a GPT partitio=
n
> holding a filesystem. It leaves room for sibling backends later, e.g. an =
UBI/MTD
> variant for NOR-based boards.
>
> The partition is matched by GPT type UUID and/or name; when both are conf=
igured,
> both must match, so a misprovisioned disk fails instead of silently selec=
ting
> whichever same-type (A/B) partition comes first.
>
> 3.3 Configuration selection: by compatible, not by filename
> -----------------------------------------------------------
>
> The primary selection mechanism is the compatible string, the way the
> FDT spec intends: with FIT_BEST_MATCH, the configuration whose devicetree
> best matches the compatible of U-Boot's control devicetree is chosen
> (fit_conf_find_compat()), falling back to the manifest's 'default'
> configuration. No filename names a devicetree anywhere; the only filename=
 in
> the design is the manifest container itself, a fixed convention in the sa=
me way
> EFI/BOOT/BOOTAA64.EFI is.
>
> On top of that, two optional environment variables can override the choic=
e:
>
>   - 'fw_fdt_config' names a specific FIT configuration (SKU selection);
>   - 'boot_dtb' pins a partition number, for A/B firmware partitions.
>
> All selection paths only choose among combinations the firmware author
> shipped; with signed configurations, a tampered value cannot select an un=
signed
> combination. There is no other environment dependency: the description li=
ves
> in the manifest and is updated atomically with the devicetrees it describ=
es, so
> 'env default -a' cannot break the boot.
>
> 3.4 Where it is installed (every EFI launch path)
> -------------------------------------------------
>
> The helper is consumed by:
>
>   - the per-device EFI bootmeth (bootmeth_efi), on both its disk and its
>     network (PXE/DHCP) bootflow paths, so a TFTP server cannot substitute=
 the OS
>     devicetree either; and
>   - the EFI boot manager (efi_bootmgr_run()), where the firmware devicetr=
ee is
>     tried first and outranks a Boot#### load-option FDT, so a stale or br=
oken
>     load option can neither replace nor block it. An FDT explicitly passe=
d on
>     the command line still wins.
>
> Each path installs the result through efi_install_fdt(), the convergence
> point all EFI launches pass through, so the firmware devicetree is instal=
led
> regardless of how the EFI application is started, including the boot-mana=
ger
> autoboot path that SystemReady IR uses.

That path should be fine since it applies the local fixups before installin=
g it.

> This is transparent to the EFI application: the devicetree sits in the EF=
I
> configuration table before the application starts. In particular, booting=
 GRUB
> works unchanged: GRUB does not touch the table entry and the kernel's EFI=
 stub
> consumes it.
>
> The assembled firmware devicetree is complete and authoritative: no other
> devicetree source is layered on top of it. In particular, extension-board
> (extension_scan()) overlays are intentionally not applied, since modifyin=
g
> the assembled (and, in secure mode, signed) devicetree would defeat the
> authenticated-combination model; such combinations should be shipped as m=
anifest
> configurations instead.
>
> 3.5 Fail-closed error semantics
> -------------------------------
>
> Once a source is configured (the node is present), the result is determin=
istic.
> -ENOENT means *only* that no source is configured, in which case the call=
er
> falls back to its normal devicetree. Any other failure to assemble a conf=
igured
> source (unresolvable device, no matching partition, read error, invalid
> manifest, missing configuration, failed signature) is fatal for that EFI =
launch
> path: a missing or bad firmware devicetree is never silently replaced by =
another
> source. Error codes from inner layers that happen to be -ENOENT (for exam=
ple
> a missing FIT configuration) are remapped before returning, so the fallba=
ck
> sentinel stays unambiguous.
>
> 3.6 Secure boot
> ---------------
>
> Signing a FIT configuration authenticates the whole combination: the base=
, the
> overlay set and its ordering are the signed unit. With FIT_SIGNATURE enab=
led
> and a required key in U-Boot's control devicetree, verification is enforc=
ed
> by the existing FIT policy code: an unsigned or tampered manifest is reje=
cted,
> and because a configured source never falls back, the boot fails closed. =
There
> is no separate Kconfig option for this: FIT is the mechanism, and the usu=
al
> verified-boot configuration turns enforcement on.
>
> Thanks for any feedback. I will follow up with the patch series once the
> binding and approach are agreed (or in a few days anyway :)
>
> Cheers,
>
> [1] https://lists.denx.de/pipermail/u-boot/2026-June/623429.html
>
> =E2=80=94
> Carlo Caione
>

Thanks
/Ilias
