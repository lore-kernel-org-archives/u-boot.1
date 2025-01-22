Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE08C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 15:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E415380805;
	Wed, 22 Jan 2025 16:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E08B80817; Wed, 22 Jan 2025 16:53:28 +0100 (CET)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::42ac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3F3F807EC
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 16:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YdTBY0R2CzTSR;
 Wed, 22 Jan 2025 16:53:25 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4YdTBX3Mwkzfyt; Wed, 22 Jan 2025 16:53:24 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 22 Jan 2025 16:53:15 +0100
Subject: [PATCH v4] image: apply FDTOs on FDT image node without a load
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-extlinux-relocate-dtb-when-dtbo-v4-1-573d6d568309@cherry.de>
X-B4-Tracking: v=1; b=H4sIAGoUkWcC/43NzQ6CMBAE4FcxPVtDl/KjJ9/DeKDtVJoQMAURQ
 nh3C4kJ8YK3nc3km4m18A4tuxwm5tG71jV1CPJ4YLos6ge4MyEzikgKEmeOoatc/Rq4R9XoogM
 3neLvEvVyNFzqLIlTm+eRIhaUp4d1w7pwu4dcurZr/LgO9mL5/m/3ggtukQAqt0ZacdUlvB9PB
 myxe/p6SSREuu9R8EyoJjlpUhl+vXjjEe17cfBkqmAlCp1RtPXmef4A0ifMcG4BAAA=
X-Change-ID: 20241219-extlinux-relocate-dtb-when-dtbo-4c7536f880b2
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex@denx.de>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

A FIT image which is NOT using -E when created by mkimage - that is with
image data within the FIT - will fail to apply FDTO if the base FDT
image node does not specify a load property (which points to an address
in DRAM). This is because we check that the FDT address we want to apply
overlay to (i.e. modify and likely increase in size) is not inside the
FIT and give up otherwise. This is assumed necessary because we may then
overwrite other data when applying in-place.

However, we can do better than giving up: relocating the FDT in another
place in DRAM where it's safe to increase its size and apply FDTOs.

While at it, do not discriminate anymore on whether the data is within
the FIT data address space - that is FIT images created with mkimage -E
- as that still may be susceptible to unintended data overwrites as
mkimage -E simply concatenates all blobs after the FIT. If the FDT blob
isn't the last, it'll result in overwriting later blobs when resizing.

The side effect is that the load property in the FIT is only
temporarily used to load the FDT but then relocated right before we
start applying overlays.

Suggested-by: Marek Vasut <marex@denx.de>
Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
This actually forces the base FDT to always be relocated whenever FDTO
are expected to be applied, regardless of the presence of the load
property in the base FDT image node.

Tested with extlinux with:
- conf node with multiple fdt entries (scenario A)
- conf node with base fdt + conf node with fdto (stored in fdt property)
  (scenario B)
- conf node with multiple fdt entries with base fdt with load property
  (scenario C)
- conf node with base fdt + conf node with fdto (stored in fdt property)
  with base fdt with load property (scenario D)

"""fit.its
/dts-v1/;

/ {
	description = "Kernel fitImage for Jaguar";
	#address-cells = <1>;

	images {
		kernel-1 {
			description = "Linux kernel";
			data = /incbin/("arch/arm64/boot/Image.gz");
			type = "kernel";
			arch = "arm64";
			os = "linux";
			compression = "gzip";
			load = <0x06000000>;
			entry = <0x06000000>;
			hash-1 {
				algo = "sha256";
			};
		};
		fdt-rk3588-jaguar.dtb {
			description = "Flattened Device Tree blob";
			data = /incbin/("arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb");
			type = "flat_dt";
			arch = "arm64";
			compression = "none";

			hash-1 {
				algo = "sha256";
			};
		};
		fdt-rk3588-jaguar.dtb-load {
			description = "Flattened Device Tree blob";
			data = /incbin/("arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb");
			type = "flat_dt";
			arch = "arm64";
			compression = "none";
			load = <0x12000000>;

			hash-1 {
				algo = "sha256";
			};
		};
		fdt-rk3588-jaguar-pre-ict-tester.dtbo {
			description = "Flattened Device Tree blob";
			data = /incbin/("arch/arm64/boot/dts/rockchip/rk3588-jaguar-pre-ict-tester.dtbo");
			type = "flat_dt";
			arch = "arm64";
			compression = "none";

			hash-1 {
				algo = "sha256";
			};
		};
	};

	configurations {
		default = "conf-rk3588-jaguar.dtb";
		conf-rk3588-jaguar.dtb {
			description = "1 Linux kernel, FDT blob";
			kernel = "kernel-1";
			fdt = "fdt-rk3588-jaguar.dtb";

			hash-1 {
				algo = "sha256";
			};
		};

		conf-rk3588-jaguar.dtb-and-dtbo {
			description = "1 Linux kernel, FDT blob";
			kernel = "kernel-1";
			fdt = "fdt-rk3588-jaguar.dtb", "fdt-rk3588-jaguar-pre-ict-tester.dtbo";

			hash-1 {
				algo = "sha256";
			};
		};

		conf-rk3588-jaguar.dtb-load {
			description = "1 Linux kernel, FDT blob";
			kernel = "kernel-1";
			fdt = "fdt-rk3588-jaguar.dtb-load";

			hash-1 {
				algo = "sha256";
			};
		};

		conf-rk3588-jaguar.dtb-load-and-dtbo {
			description = "1 Linux kernel, FDT blob";
			kernel = "kernel-1";
			fdt = "fdt-rk3588-jaguar.dtb-load", "fdt-rk3588-jaguar-pre-ict-tester.dtbo";

			hash-1 {
				algo = "sha256";
			};
		};

		conf-rk3588-jaguar-pre-ict-tester.dtbo {
			description = "0 FDT blob";

			fdt = "fdt-rk3588-jaguar-pre-ict-tester.dtbo";

			hash-1 {
				algo = "sha256";
			};
		};
	};
};
"""

"""extlinux.conf (scenario A)
LABEL rk3588-jaguar
LINUX /boot/fit#conf-rk3588-jaguar.dtb-and-dtbo
APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
"""

Log:
"""

   Using 'conf-rk3588-jaguar.dtb-and-dtbo' configuration
   Verifying Hash Integrity ... OK
   Trying 'kernel-1' kernel subimage
     Description:  Linux kernel
     Type:         Kernel Image
     Compression:  gzip compressed
     Data Start:   0x020000cc
     Data Size:    11862415 Bytes = 11.3 MiB
     Architecture: AArch64
     OS:           Linux
     Load Address: 0x06000000
     Entry Point:  0x06000000
     Hash algo:    sha256
     Hash value:   51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
   Verifying Hash Integrity ... sha256+ OK

   Using 'conf-rk3588-jaguar.dtb-and-dtbo' configuration
   Verifying Hash Integrity ... OK
   Trying 'fdt-rk3588-jaguar.dtb' fdt subimage
     Description:  Flattened Device Tree blob
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x02b50370
     Data Size:    168750 Bytes = 164.8 KiB
     Architecture: AArch64
     Hash algo:    sha256
     Hash value:   96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
   Verifying Hash Integrity ... sha256+ OK
   Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
Working FDT set to ece9d000

   Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
     Description:  Flattened Device Tree blob
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x02ba2bb4
     Data Size:    2753 Bytes = 2.7 KiB
     Architecture: AArch64
     Hash algo:    sha256
     Hash value:   e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
   Verifying Hash Integrity ... sha256+ OK
   Booting using the fdt blob at 0xece9d000
Working FDT set to ece9d000
   Uncompressing Kernel Image to 6000000
   Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
Working FDT set to ece70000
"""

"""extlinux.conf (scenario B)
LABEL rk3588-jaguar
LINUX /boot/fit#conf-rk3588-jaguar.dtb-load-and-dtbo
APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
"""

Log:
"""

   Using 'conf-rk3588-jaguar.dtb-load-and-dtbo' configuration
   Verifying Hash Integrity ... OK
   Trying 'kernel-1' kernel subimage
     Description:  Linux kernel
     Type:         Kernel Image
     Compression:  gzip compressed
     Data Start:   0x020000cc
     Data Size:    11862415 Bytes = 11.3 MiB
     Architecture: AArch64
     OS:           Linux
     Load Address: 0x06000000
     Entry Point:  0x06000000
     Hash algo:    sha256
     Hash value:   51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
   Verifying Hash Integrity ... sha256+ OK

   Using 'conf-rk3588-jaguar.dtb-load-and-dtbo' configuration
   Verifying Hash Integrity ... OK
   Trying 'fdt-rk3588-jaguar.dtb-load' fdt subimage
     Description:  Flattened Device Tree blob
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x02b79784
     Data Size:    168750 Bytes = 164.8 KiB
     Architecture: AArch64
     Load Address: 0x12000000
     Hash algo:    sha256
     Hash value:   96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
   Verifying Hash Integrity ... sha256+ OK
   Loading fdt from 0x02b79784 to 0x12000000
   Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
Working FDT set to ece9d000

   Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
     Description:  Flattened Device Tree blob
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x02ba2bb4
     Data Size:    2753 Bytes = 2.7 KiB
     Architecture: AArch64
     Hash algo:    sha256
     Hash value:   e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
   Verifying Hash Integrity ... sha256+ OK
   Booting using the fdt blob at 0xece9d000
Working FDT set to ece9d000
   Uncompressing Kernel Image to 6000000
   Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
Working FDT set to ece70000
"""

"""extlinux.conf (scenario C)
LABEL rk3588-jaguar
LINUX /boot/fit#conf-rk3588-jaguar.dtb#conf-rk3588-jaguar-pre-ict-tester.dtbo
APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
"""

Log:
"""

   Using 'conf-rk3588-jaguar.dtb' configuration
   Verifying Hash Integrity ... OK
   Trying 'kernel-1' kernel subimage
     Description:  Linux kernel
     Type:         Kernel Image
     Compression:  gzip compressed
     Data Start:   0x020000cc
     Data Size:    11862415 Bytes = 11.3 MiB
     Architecture: AArch64
     OS:           Linux
     Load Address: 0x06000000
     Entry Point:  0x06000000
     Hash algo:    sha256
     Hash value:   51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
   Verifying Hash Integrity ... sha256+ OK

   Using 'conf-rk3588-jaguar.dtb' configuration
   Verifying Hash Integrity ... OK
   Trying 'fdt-rk3588-jaguar.dtb' fdt subimage
     Description:  Flattened Device Tree blob
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x02b50370
     Data Size:    168750 Bytes = 164.8 KiB
     Architecture: AArch64
     Hash algo:    sha256
     Hash value:   96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
   Verifying Hash Integrity ... sha256+ OK
   Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
Working FDT set to ece9d000

   Using 'conf-rk3588-jaguar-pre-ict-tester.dtbo' configuration
   Verifying Hash Integrity ... OK
   Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
     Description:  Flattened Device Tree blob
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x02ba2bb4
     Data Size:    2753 Bytes = 2.7 KiB
     Architecture: AArch64
     Hash algo:    sha256
     Hash value:   e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
   Verifying Hash Integrity ... sha256+ OK
   Booting using the fdt blob at 0xece9d000
Working FDT set to ece9d000
   Uncompressing Kernel Image to 6000000
   Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
Working FDT set to ece70000
"""

"""extlinux.conf (scenario D)
LABEL rk3588-jaguar
LINUX /boot/fit#conf-rk3588-jaguar.dtb-load#conf-rk3588-jaguar-pre-ict-tester.dtbo
APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
"""

Log:
"""

   Using 'conf-rk3588-jaguar.dtb-load' configuration
   Verifying Hash Integrity ... OK
   Trying 'kernel-1' kernel subimage
     Description:  Linux kernel
     Type:         Kernel Image
     Compression:  gzip compressed
     Data Start:   0x020000cc
     Data Size:    11862415 Bytes = 11.3 MiB
     Architecture: AArch64
     OS:           Linux
     Load Address: 0x06000000
     Entry Point:  0x06000000
     Hash algo:    sha256
     Hash value:   51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
   Verifying Hash Integrity ... sha256+ OK

   Using 'conf-rk3588-jaguar.dtb-load' configuration
   Verifying Hash Integrity ... OK
   Trying 'fdt-rk3588-jaguar.dtb-load' fdt subimage
     Description:  Flattened Device Tree blob
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x02b79784
     Data Size:    168750 Bytes = 164.8 KiB
     Architecture: AArch64
     Load Address: 0x12000000
     Hash algo:    sha256
     Hash value:   96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
   Verifying Hash Integrity ... sha256+ OK
   Loading fdt from 0x02b79784 to 0x12000000
   Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
Working FDT set to ece9d000

   Using 'conf-rk3588-jaguar-pre-ict-tester.dtbo' configuration
   Verifying Hash Integrity ... OK
   Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
     Description:  Flattened Device Tree blob
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x02ba2bb4
     Data Size:    2753 Bytes = 2.7 KiB
     Architecture: AArch64
     Hash algo:    sha256
     Hash value:   e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
   Verifying Hash Integrity ... sha256+ OK
   Booting using the fdt blob at 0xece9d000
Working FDT set to ece9d000
   Uncompressing Kernel Image to 6000000
   Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
Working FDT set to ece70000
"""

Cc: Heiko Stuebner <heiko@sntech.de>
---
Changes in v4:
- of_flat_tree type changed to char* from void*, as v3 wouldn't compile,
- add comment explaining why char * for of_flat_tree
- Link to v3: https://lore.kernel.org/r/20250122-extlinux-relocate-dtb-when-dtbo-v3-1-46bef4eac720@cherry.de

Changes in v3:
- of_flat_tree type changed from char* to void*,
- added Marek's Rb trailer,
- Link to v2: https://lore.kernel.org/r/20250116-extlinux-relocate-dtb-when-dtbo-v2-1-d011582c2b7e@cherry.de

Changes in v2:
- Indiscriminately relocate, regardless of location of FDT to be on the
  safe side wrt data overlap/overwrite,
- print return value of boot_relocate_fdt when it fails,
- Link to v1: https://lore.kernel.org/r/20241219-extlinux-relocate-dtb-when-dtbo-v1-1-fe5eeb8fd4f1@cherry.de
---
 boot/image-fit.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index db7fb61bca948e42a4136b9ceb263a53362ad3f8..8ebe54fd663fc4cf09a0f744160b63554c787ff4 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2348,10 +2348,17 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	char *next_config = NULL;
 	ulong load, len;
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
-	ulong image_start, image_end;
 	ulong ovload, ovlen, ovcopylen;
 	const char *uconfig;
 	const char *uname;
+	/*
+	 * of_flat_tree is storing the void * returned by map_sysmem, then its
+	 * address is passed to boot_relocate_fdt which expects a char ** and it
+	 * is then cast into a ulong. Setting its type to void * would require
+	 * to cast its address to char ** when passing it to boot_relocate_fdt.
+	 * Instead, let's be lazy and use void *.
+	 */
+	char *of_flat_tree;
 	void *base, *ov, *ovcopy = NULL;
 	int i, err, noffset, ov_noffset;
 #endif
@@ -2395,17 +2402,18 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	/* we need to apply overlays */
 
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
-	image_start = addr;
-	image_end = addr + fit_get_size(fit);
-	/* verify that relocation took place by load address not being in fit */
-	if (load >= image_start && load < image_end) {
-		/* check is simplified; fit load checks for overlaps */
-		printf("Overlayed FDT requires relocation\n");
+	/* Relocate FDT so resizing does not overwrite other data in FIT. */
+	of_flat_tree = map_sysmem(load, len);
+	len = ALIGN(fdt_totalsize(load), SZ_4K);
+	err = boot_relocate_fdt(&of_flat_tree, &len);
+	if (err) {
+		printf("Required FDT relocation for applying DTOs failed: %d\n",
+		       err);
 		fdt_noffset = -EBADF;
 		goto out;
 	}
 
-	base = map_sysmem(load, len);
+	load = (ulong)of_flat_tree;
 
 	/* apply extra configs in FIT first, followed by args */
 	for (i = 1; ; i++) {

---
base-commit: 82d262ae162d859d3b0bbcd40a9464e890b009da
change-id: 20241219-extlinux-relocate-dtb-when-dtbo-4c7536f880b2

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

