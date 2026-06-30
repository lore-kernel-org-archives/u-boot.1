Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCF6C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 21:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 072E784A9E;
	Tue, 30 Jun 2026 23:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="YNWWa0w0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F30584ACD; Tue, 30 Jun 2026 21:20:31 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F9B84A49
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 21:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-92e5c92c389so159485185a.3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1782847227; x=1783452027; darn=lists.denx.de;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+Za4+zAGtbSd9GUnkKKLSTn2eXsj7Oa0+ZNRgGQQvmc=;
 b=YNWWa0w0VaR2QBxqTE46iO+jJcfLKqXeDMdXSfaaYkCpsXdcbC2Haz7eKtrNtd6681
 cOdHtD2BdODFqz5l8KHCG4XQVGhWwG9fxHEVcG0bMxI6p9OHWyHwWQ8TRPJ965szrZfL
 s3K7rKw9vdVHzqRDAYo9f8hpn0zupzWK5IEKYTjLXrD7V2BZADjh3iWT56eKp8KNTzK8
 icAr3k55oqhDxLjwxFW4ZNlLs9dk0UmA+/ruX0m4UkggP8kDrKaR6x8LyxO17lIKNWeZ
 0jyY9PKIHDblbREDBRTG0RXJFbfKaAGdu5cdGoZda1RF0p0kj1cmB326C0D8Gv2G2U5q
 ooaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782847227; x=1783452027;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+Za4+zAGtbSd9GUnkKKLSTn2eXsj7Oa0+ZNRgGQQvmc=;
 b=IiZyDl6ypxKFdvJhkJNtwExS1oQsdEsC+jnfaT/Ozf9wUDTnxmnqXQ6h4JJrQ/C+tZ
 Wtiazpai5tHhmyAIp2PUk9b8dyUh0EPMjmtMA0HqVIdjJpQwjha1nJs6jH79WEnk873G
 UdDdzq+DBi21lrPB395GhScM/112qsK8NnnlE63CW3v0XUzPCKR6kx8RWdybEm8wzrNK
 dp/zn51Df+PI1ZsiJ9uxMWRCQ1L7msJmLUsQuOoskX9FkptvxWD57B3f/kjykkRP4BtV
 MZTl/S9pEQGgH2ENCioxKI9o1ppf6fpUcDYhYJnTlRsYrbO+w8ZTRyhRDPgM+GgdL6qp
 TGPQ==
X-Gm-Message-State: AOJu0YxmHmz5r2Qp9unnAFtlxwxivqWF0wu1ibT5Vwwl9HTUpnMbCpi7
 VhfbmlFtbpDX7RKUvcx8oScKW/zRcMkm6wOJtxnmt9j/Dv3otXhJ4cHeMdqnNprQm6/fjZr66RE
 EpFEYo4zZlZxR
X-Gm-Gg: AfdE7cnHo+9tPzToPNyMER1yPdAaEkyeIaPt3aIBCReAly1ysiOnw50D9isg0nTmAlS
 dDp2mp2L8eEzo/T8F/dxG3d3IWDsb9ihPvMTbR3sEKss7WpPjXg+eHOvjnATDVC649GBIeQ97lM
 vfnMZIoCZeFaaaAL5r7H/j+oYKRr+bUFqgzYtGrX7ZMps7r+xGcim1iL+yh79x1geP+4Y2mAxi+
 +Kdh8ldk2UrSDDnBzJ4Hqd48izEHK9BsD6hQ1sGS0pbiOZ36rZpAW/aEbr1WCSsEmmyqLgMURTB
 bJGm9+NXzcke+TSlJvxBvdLZnR/eD5zZIPkbCPqmuylae/O7rPHk2IQcnhUy0f8RBoOMMOZ2fnc
 fBTvteIhgGlS6MjLs4vMVenY7XPWocFSnEl9WueAKmrOMIpE6+LQ+4xM4/Js18HTywN2IFwHm9M
 F2MdQ19ww7JMPkc49s/gqm+UFv0d53K5ExHw==
X-Received: by 2002:a05:620a:460f:b0:915:8bf1:bb10 with SMTP id
 af79cd13be357-92e6248ef03mr806395085a.10.1782847227028; 
 Tue, 30 Jun 2026 12:20:27 -0700 (PDT)
Received: from smtpclient.apple ([62.182.99.136])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e622e7fe3sm315176785a.27.2026.06.30.12.20.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jun 2026 12:20:26 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [RFC] bootstd: firmware-owned OS devicetree for EBBR / SystemReady IR
Message-Id: <205BD474-178D-4E91-8C41-33C46E1CCFBB@baylibre.com>
Date: Tue, 30 Jun 2026 21:20:13 +0200
Cc: sjg@chromium.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 trini@konsulko.com, dlechner@baylibre.com, jstephan@baylibre.com,
 baylibre-upstreaming@groups.io
To: u-boot@lists.denx.de
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Mailman-Approved-At: Tue, 30 Jun 2026 23:24:19 +0200
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

Hi all,

This is a design RFC, not a patch series. I would like to agree the =
approach
and the devicetree binding on the list before posting code, because the
mechanism touches both bootstd and the EFI loader and introduces a new =
binding.

A working implementation exists and has been validated on hardware =
(details at
the end); I will post it as patches once the design here is acceptable.


1. The problem
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Platforms that follow EBBR / Arm SystemReady IR treat the OS devicetree =
as part
of the firmware rather than part of the OS: the base DTB and its =
overlays live
on a firmware-owned partition and are updated independently of the =
operating
system, instead of being shipped in the OS image or on the EFI System =
Partition
(ESP). The firmware is expected to load that devicetree and hand it to =
the OS
(via the EFI configuration table).

U-Boot today can source the OS devicetree from its own control DT, from =
the ESP,
or from an EFI Boot#### load option, but it has no generic way to =
assemble it
from a firmware-owned partition. As a result vendors carry out-of-tree =
machinery
for exactly this. For example, MediaTek ships downstream `dtbprobe` =
(assemble the
DT from a partition) and `fdt authndtb` (authenticate it) commands. The =
goal of
this work is to provide one reusable, vendor-neutral mechanism in =
mainline so
those downstream commands can be dropped.


2. What a solution has to do
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

  - Assemble the OS devicetree (a base DTB plus a list of overlays) from =
a
    firmware-owned partition and install it for the OS.
  - Install it on *every* EFI launch path, not just one. SystemReady IR =
boots
    through the UEFI boot manager, which in U-Boot does not go through =
the
    per-device EFI bootmeth, so a per-device-only hook is not enough.
  - Support secure boot: when the firmware devicetree is signed, verify =
it, and
    never silently fall back to an unverified devicetree.
  - Support A/B firmware partitions.


3. Proposed design
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

A new bootstd helper, `firmware_fdt_load()` =
(`CONFIG_BOOTSTD_FIRMWARE_FDT`),
assembles the devicetree and returns it; the EFI launch paths install it =
via
`efi_install_fdt()`, exactly like any other devicetree source.

3.1 Where the source is described (new binding)
-----------------------------------------------

The *location* is described in the control devicetree. The bootstd node =
carries
a `firmware-fdt-source` phandle to a node that is a child of the media =
device
that owns the partition, and identifies the partition by GPT type UUID =
and/or
name:

	bootstd {
		compatible =3D "u-boot,boot-std";
		firmware-fdt-source =3D <&fw_fdt>;
	};

	&mmc0 {
		fw_fdt: firmware-fdt {
			compatible =3D "u-boot,firmware-fdt-block";
			partition-type-uuid =3D "....";	/* GPT type UUID =
*/
			partition-name =3D "firmware";	/* optional */
			extra-size =3D <0x3000>;		/* =
overlay headroom */
		};
	};

3.2 The dynamic parameters (environment) and board defaults
-----------------------------------------------------------

The source and its partition policy stay in the control devicetree =
(section
3.1). The values that change with the OS image rather than with the =
hardware are
layered:

  - the control DT describes the source and the partition policy;
  - the board default environment carries factory defaults for the =
static values
    (`fdtfile` and `dtb_path` for the base DTB, and the `fdt_addr_r` /
    `fdtoverlay_addr_r` working addresses), so a from-source build boots =
and
    `env default` restores a loadable configuration;
  - the (firmware-owned) stored environment overrides those at runtime, =
and
    carries the genuinely dynamic values: the overlay list (`list_dtbo`) =
and the
    A/B partition pin (`boot_dtb`).

As an alternative, the stable defaults (`fdtfile` and the path) could =
instead be
expressed as optional properties on the source node, keeping them in the =
control
devicetree rather than in the board default environment. See the open =
questions.

3.3 Where it is installed (both EFI paths)
------------------------------------------

The helper is consumed by both:

  - the per-device EFI bootmeth (`bootmeth_efi`), and
  - the EFI boot manager (`efi_bootmgr_run()`),

each installing the result through `efi_install_fdt()`. That is the =
convergence
point all EFI launches pass through, so the firmware devicetree is =
installed
regardless of how the EFI application was started, including the =
boot-manager
autoboot path that SystemReady IR uses.

3.4 Fail-closed error semantics
-------------------------------

Once a source is configured (the node is present), the result must be
deterministic. `-ENOENT` means *only* that no source is configured, in =
which
case the caller falls back to its normal devicetree. Any other failure =
to
assemble a configured source (unresolvable device, no matching =
partition, read
error, invalid blob, failed signature) is fatal for that EFI launch =
path: a
missing or bad firmware devicetree is never silently replaced by another =
source.
Missing environment metadata for a configured source is treated as a
configuration error (fail closed, or satisfied from the board default), =
never as
"no source".

3.5 Optional secure boot
------------------------

With `CONFIG_BOOTSTD_FIRMWARE_FDT_FIT` the base DTB and overlays are =
signed FIT
images. Each is verified by reusing U-Boot's existing verified-boot =
policy
(`fit_image_load()` with verification enabled and a required key in the =
control
FDT), and the verified flat devicetree is extracted in place. A non-FIT =
file is
rejected so an unsigned devicetree cannot be installed. This reuses the =
existing
trust model rather than adding new crypto, and replaces the downstream
`fdt authndtb`.


4. Why these choices
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  - Describing the source in the control DT, as a child of the media =
device,
    follows the existing bootstd guidance ("if a bootdev needs =
configuration,
    add it to the DT as a child of the media device") and the VBE =
precedent. It
    keeps the mechanism generic: no GPT UUID or board constant in the C =
code.
  - Splitting identity (control DT) from dynamic values (environment) =
and static
    defaults (board default env) keeps the firmware in control of what =
changes
    per OS image, while still letting a plain `make <board>_defconfig` =
build
    boot.
  - Installing at `efi_install_fdt()` rather than in one bootmeth is =
what makes
    this SystemReady-IR-grade: the boot-manager path carries the =
firmware
    devicetree too. A per-device-only hook leaves the autoboot path on =
the
    control DT.
  - Fail-closed is required for secure boot: there must be no path where =
a
    configured, signed devicetree silently degrades to an unverified =
one.
  - Reusing `fit_image_load()` keeps a single, reviewed verified-boot =
path.


5. Alternatives considered
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

  - A global bootmeth ordered ahead of the EFI boot manager (a structure =
used in
    an earlier proof of concept). It works for autoboot but does not =
converge
    all launch paths; `efi_install_fdt()` is the real single point.
  - A per-device bootmeth hook only. Simpler, but misses the =
boot-manager
    autoboot path, which is the one SystemReady IR uses.
  - Keeping the mechanism vendor-specific (the status quo). Does not =
help anyone
    else and keeps the command out of tree.


6. Open questions for the list
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

  1. Binding naming: are `firmware-fdt-source` and the =
`u-boot,firmware-fdt-block`
     compatible acceptable, and is the control-DT-described-source shape =
the one
     you want?
  2. The configuration boundary. The proposal keeps the source and =
partition
     policy in the control DT, puts factory defaults for the filenames =
and the
     working addresses in the board default environment, and lets the
     firmware-owned stored environment override at runtime (and hold the =
dynamic
     `list_dtbo` / `boot_dtb`). An alternative is to express the stable =
defaults
     (`fdtfile`, a path) as optional properties on the source node, so =
they live
     in the control DT rather than the board environment. Which does the =
project
     prefer?
  3. The `efi_bootmgr_run()` hook: is installing the firmware devicetree =
on the
     boot-manager path acceptable to the EFI maintainers, and is that =
the right
     place?
  4. The fail-closed semantics: a configured source that cannot be =
assembled is
     fatal; only an absent source falls back. Agree?
  5. Should the signed-FIT verification be part of this series or a =
follow-up?

Thanks for any feedback. I will follow up with the patch series once the =
binding
and approach are agreed.

Cheers,

=E2=80=94
Carlo Caione

