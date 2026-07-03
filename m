Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0E5C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 09:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C65846A4;
	Fri,  3 Jul 2026 11:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="cudccNz5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31834847C8; Fri,  3 Jul 2026 11:40:40 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 737CF84119
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 11:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-91d44b471d8so12094085a.1
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 02:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783071636; x=1783676436; darn=lists.denx.de;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2NiKhOhhsk1F+L9klIZVQ3CkBT3W1rBvapd+Fujw/IA=;
 b=cudccNz5WL9gFZ8lH2eDgG2+HgA0NxNPY/q8NLSpNTFQAOFOFoJndF4rXdgseAnN4R
 C8HcFiC4xQxFauti6qjoM19f8IW2G4T8t/2qP3ATUtu46XG4mc2RZu+Tp87eDGFbLm3c
 wW0yVayEWQyRc/MnRN5WpJsQ920RBIeh2/xJTaRWFTf0QgS1YakZaKGG0vbQShc1GLs6
 b9Oj6oTG48cI56iLlOE0mbANPjS4nKiox58y4mNzistcICgLA1bJ1o1UdWp11iqqOpwL
 p7CG+Drln/7ENmlhwC2GaLNG0aKJOjDrFa4P76g9PPY1BcDaPMtXWvn+E5xDQfxz4Leo
 G68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783071636; x=1783676436;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2NiKhOhhsk1F+L9klIZVQ3CkBT3W1rBvapd+Fujw/IA=;
 b=jHdX9tpRcHibWdnYNINXHq820hUlooEdyGuXyRCGTNxvL9mTtnaY4sUXxq7aJzJvPL
 xy+lVEkLWldardKSrhGemoWXOJtWqM5TLYeEmIxsdvWHRzJC4DHak1P75VXvuAhPTsRC
 SRbhse3o+LYxtcf04l5gPfv5mtNMJDYdxr95ZhHceyRi7IMrb1ho1RvbPv04u8d/i4RU
 OXehvzkOXXkXbSjSpiAelTN9zWTr024DtqZUZwWg1/WH+JyO0jFhE6dK5KKUXbWxZSPf
 J6or1UME0mIoJAnpYoN3Yz/S1XVW+cBeZtyf8fgWkEH0rahp1Gz5sghbJC/pRsr0uTfH
 2RzA==
X-Gm-Message-State: AOJu0YzH0RAPcmqOtdaEb5STk/dCD3c6P28p9PMb85iBPRY7nNs8HFN5
 dtHVq8DI6KaSbILvK8EE1zsXljNbWOEAyVk4I7NN6YV++qdDezuSaC8gB2sbdQSKj2OTsDFLd6f
 hVnknX5jEj1HZ8Do=
X-Gm-Gg: AfdE7clqPo7+qLxDUKDULmezNoUyN+oOed3IBLOlMedZPu6d3OytzLEOBrlhgCX7m1R
 X6EKZfHInstp7sx7ffolOy2IOg1SxIeEdtPOb206+UO3n3ZG0VWdoLzLBY0uPjcuKV48qRQ0JdZ
 TNuxcaekie4XaMWFIiDBtsX1O19cxWiaSXf/qrAJ/tU7ZUET93dIwYxHSV2yYDphWL32O+hoZIW
 1gT1NmELp4AfkEK6aY3GSMhgIadsQ9jd9ag5oQbS0QSINdiwH874dY3v/USbWGU0nEbyQ1ybhpl
 J6gFF0xha6VmBis7H1YiEWIzaS7sIU37CV/dydAxcW4Hk5F93O8IcbcaJIAeRmnB+stdk12u87V
 8DPX3XGbEz7aE0X8TVL0ykcXGN7f9QU+7NH+QxHAK1K7VSGUrCzA2n6rzllflKK+PJVM3Btpg1R
 4iYGcvdoXtsX6TKWi4iB4u/qRsoe0UgOzlBaE=
X-Received: by 2002:a05:620a:2945:b0:92b:1233:9a2 with SMTP id
 af79cd13be357-92e782055c4mr1230666585a.17.1783071636012; 
 Fri, 03 Jul 2026 02:40:36 -0700 (PDT)
Received: from smtpclient.apple ([194.124.76.118])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90b804dasm125363085a.1.2026.07.03.02.40.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 03 Jul 2026 02:40:35 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [RFC v2] bootstd: firmware-owned OS devicetree for EBBR / SystemReady
 IR
Message-Id: <140504E6-5BCB-4566-A03F-2A94B0F5BA01@baylibre.com>
Date: Fri, 3 Jul 2026 11:40:22 +0200
Cc: sjg@chromium.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 trini@konsulko.com, dlechner@baylibre.com, jstephan@baylibre.com,
 baylibre-upstreaming@groups.io, a.fatoum@barebox.org
To: u-boot@lists.denx.de
X-Mailer: Apple Mail (2.3864.600.51.1.1)
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

This is v2 of a design RFC, not a patch series. v1 [1] proposed a =
mechanism
for sourcing the OS devicetree from a firmware-owned partition; v2 =
refines the
same design. The main change is that the devicetree set is now described =
by a
firmware-owned FIT manifest carried on that partition, instead of by =
environment
variables.

This text is self-contained; you do not need to have read v1.

A working implementation exists, with sandbox tests, and has been =
validated end
to end on hardware in both the plain and the secure (signed) setup.

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
for exactly this.

For example, MediaTek ships downstream 'dtbprobe' (assemble the DT from =
a
partition) and 'fdt authndtb' (authenticate it) commands. The goal of =
this
work is to provide one reusable, vendor-neutral mechanism in mainline so =
those
downstream commands can be dropped.


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
  - Support A/B firmware partitions and per-SKU devicetree variants.


3. Proposed design
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

A bootstd helper, firmware_fdt_load() (CONFIG_BOOTSTD_FIRMWARE_FDT), =
assembles
the devicetree from a FIT manifest on the firmware partition and returns =
it;
the EFI launch paths install the result via efi_install_fdt(), exactly =
like any
other devicetree source.

3.1 The manifest: describe and carry in one artefact
----------------------------------------------------

The partition carries one FIT image (by default 'fdt.itb'). Its images =
hold
the base DTB and the overlays; each of its configurations names one =
bootable
combination through the standard 'fdt' property:

	/dts-v1/;
	/ {
		description =3D "Firmware-owned OS devicetree";
		#address-cells =3D <1>;

		images {
			fdt-base {
				data =3D /incbin/("board.dtb");
				type =3D "flat_dt";
				arch =3D "arm64";
				compression =3D "none";
				hash-1 { algo =3D "sha256"; };
			};
			fdt-panel {
				data =3D /incbin/("panel.dtbo");
				type =3D "flat_dt";
				arch =3D "arm64";
				compression =3D "none";
				hash-1 { algo =3D "sha256"; };
			};
		};

		configurations {
			default =3D "conf-panel";
			conf-panel {
				fdt =3D "fdt-base", "fdt-panel";
			};
			conf-base {
				fdt =3D "fdt-base";
			};
		};
	};

The helper selects a configuration, verifies it, and assembles the =
devicetree
by reusing boot_get_fdt_fit(), the same code path bootm already uses for
FIT-carried devicetrees: multi-configuration selection, per-image =
verification,
overlay application in the listed order, and packing of the result. No =
new
format, parser, or crypto is introduced.

The manifest must be self-contained: images must be 'flat_dt' with =
embedded
data (external-data FITs are rejected) and must not carry a 'load' =
property
(rejected, so a misbuilt manifest cannot overwrite arbitrary memory).

3.2 Where the partition is described (new binding)
--------------------------------------------------

The *location* is described in the control devicetree. The bootstd node =
carries
a 'firmware-fdt-source' phandle to a node that is a child of the media =
device
that owns the partition:

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
			filename =3D "fdt.itb";		/* optional, the =
default */
		};
	};

The '-block' suffix names the backend: a block device with a GPT =
partition
holding a filesystem. It leaves room for sibling backends later, e.g. an =
UBI/MTD
variant for NOR-based boards.

The partition is matched by GPT type UUID and/or name; when both are =
configured,
both must match, so a misprovisioned disk fails instead of silently =
selecting
whichever same-type (A/B) partition comes first.

3.3 Configuration selection: by compatible, not by filename
-----------------------------------------------------------

The primary selection mechanism is the compatible string, the way the
FDT spec intends: with FIT_BEST_MATCH, the configuration whose =
devicetree
best matches the compatible of U-Boot's control devicetree is chosen
(fit_conf_find_compat()), falling back to the manifest's 'default'
configuration. No filename names a devicetree anywhere; the only =
filename in
the design is the manifest container itself, a fixed convention in the =
same way
EFI/BOOT/BOOTAA64.EFI is.

On top of that, two optional environment variables can override the =
choice:

  - 'fw_fdt_config' names a specific FIT configuration (SKU selection);
  - 'boot_dtb' pins a partition number, for A/B firmware partitions.

All selection paths only choose among combinations the firmware author
shipped; with signed configurations, a tampered value cannot select an =
unsigned
combination. There is no other environment dependency: the description =
lives
in the manifest and is updated atomically with the devicetrees it =
describes, so
'env default -a' cannot break the boot.

3.4 Where it is installed (every EFI launch path)
-------------------------------------------------

The helper is consumed by:

  - the per-device EFI bootmeth (bootmeth_efi), on both its disk and its
    network (PXE/DHCP) bootflow paths, so a TFTP server cannot =
substitute the OS
    devicetree either; and
  - the EFI boot manager (efi_bootmgr_run()), where the firmware =
devicetree is
    tried first and outranks a Boot#### load-option FDT, so a stale or =
broken
    load option can neither replace nor block it. An FDT explicitly =
passed on
    the command line still wins.

Each path installs the result through efi_install_fdt(), the convergence
point all EFI launches pass through, so the firmware devicetree is =
installed
regardless of how the EFI application is started, including the =
boot-manager
autoboot path that SystemReady IR uses.

This is transparent to the EFI application: the devicetree sits in the =
EFI
configuration table before the application starts. In particular, =
booting GRUB
works unchanged: GRUB does not touch the table entry and the kernel's =
EFI stub
consumes it.

The assembled firmware devicetree is complete and authoritative: no =
other
devicetree source is layered on top of it. In particular, =
extension-board
(extension_scan()) overlays are intentionally not applied, since =
modifying
the assembled (and, in secure mode, signed) devicetree would defeat the
authenticated-combination model; such combinations should be shipped as =
manifest
configurations instead.

3.5 Fail-closed error semantics
-------------------------------

Once a source is configured (the node is present), the result is =
deterministic.
-ENOENT means *only* that no source is configured, in which case the =
caller
falls back to its normal devicetree. Any other failure to assemble a =
configured
source (unresolvable device, no matching partition, read error, invalid
manifest, missing configuration, failed signature) is fatal for that EFI =
launch
path: a missing or bad firmware devicetree is never silently replaced by =
another
source. Error codes from inner layers that happen to be -ENOENT (for =
example
a missing FIT configuration) are remapped before returning, so the =
fallback
sentinel stays unambiguous.

3.6 Secure boot
---------------

Signing a FIT configuration authenticates the whole combination: the =
base, the
overlay set and its ordering are the signed unit. With FIT_SIGNATURE =
enabled
and a required key in U-Boot's control devicetree, verification is =
enforced
by the existing FIT policy code: an unsigned or tampered manifest is =
rejected,
and because a configured source never falls back, the boot fails closed. =
There
is no separate Kconfig option for this: FIT is the mechanism, and the =
usual
verified-boot configuration turns enforcement on.

Thanks for any feedback. I will follow up with the patch series once the
binding and approach are agreed (or in a few days anyway :)

Cheers,

[1] https://lists.denx.de/pipermail/u-boot/2026-June/623429.html

=E2=80=94
Carlo Caione

