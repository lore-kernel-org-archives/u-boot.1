Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EAEF3C9A8
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 15:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00B4683981;
	Tue, 24 Feb 2026 16:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="TRjoXxFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F383383DCB; Tue, 24 Feb 2026 16:57:20 +0100 (CET)
Received: from mta-65-228.siemens.flowmailer.net
 (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 735AD83642
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 16:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id
 20260224155717034fb6d1ca00020700 for <u-boot@lists.denx.de>;
 Tue, 24 Feb 2026 16:57:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=NV+XFajIUBbul0WBJC4Oa4wjnuOAqqNkVR5zXpbqYfw=;
 b=TRjoXxFRsdMnZumz6kKyDAiDpQrFkoCYc1YZ16i48UCtqWpxxAMNRu5KB80opglOsTb6i2
 CokR157Vi7cPA4epN8MlkWHAXRIy0SWb0J1k4IYFJSin/JvmUk0PeGr66RQZoWgn8t9YfT6N
 ojzGbpsQMx/pxBfn18jUEf7OPVmejbSPBx6o7NnNpl1NO63018awprlbr/Oj5Rg+wWYf5cF1
 VGBsMMv8znUFpoL7n2iMMq6NMlt+jtWBmgOKL+zq8Bc63p6BjjduhNMYkTRe56KjHTHpg+HZ
 0uPijcbSKaEEudNw9iK8NFwSq67HOJVHOrNYdBhHL+FCniDTI1hfPoRA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>
Subject: [PATCH] bootm: fix booting kernel_noload image
Date: Tue, 24 Feb 2026 16:57:10 +0100
Message-ID: <20260224155712.286317-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

FIT images don't work without having to explicitly specify physical
load addresses. Digging into that it looks like a flaw in
bootm_load_os().
It duplicates images->os for convenience. However, the code handling
"kernel_noload" images then updates the load address in the copy with
the value lmb_alloc_mem() returned. Later there's another call to
lmb_alloc_mem() that uses the old value. This leads to havoc due
to subsequent calls of lmb_alloc_mem() picking too low addresses.

The "fix" is to mark the local variable const to avoid accidental
assignments. This works but IMO the logic is still flawed somehow as
this leads to overlapping lmb reservations. I guess the fixed
reservation should only be done when the noload path wasn't hit.

Without the change:
+ bootm 0x40200000#qemu-arm 0x40200000#qemu-arm 0x40000000
   Using 'qemu-arm' configuration
   Verifying Hash Integrity ... OK
   Trying 'kernel' kernel subimage
     Description:  Linux kernel
     Created:      2026-02-24  14:10:09 UTC
     Type:         Kernel Image (no loading done)
     Compression:  gzip compressed
     Data Start:   0x402000b8
     Data Size:    12227440 Bytes = 11.7 MiB
     Hash algo:    sha256
     Hash value:   7ea661fdecdd1127edd419cfbf8bff52e2d5ac55c...
   Verifying Hash Integrity ... sha256+ OK
   Using 'qemu-arm' configuration
   Verifying Hash Integrity ... OK
   Trying 'ramdisk' ramdisk subimage
     Description:  Initial ramdisk
     Created:      2026-02-24  14:10:09 UTC
     Type:         RAMDisk Image
     Compression:  uncompressed
     Data Start:   0x40da9528
     Data Size:    1067114 Bytes = 1 MiB
     Architecture: AArch64
     OS:           Linux
     Load Address: unavailable
     Entry Point:  unavailable
     Hash algo:    sha256
     Hash value:   2a711dcb5f58615187645ccec615c67eddcfbb3138...
   Verifying Hash Integrity ... sha256+ OK
   Booting using the fdt blob at 0x40000000
Working FDT set to 40000000
   Uncompressing Kernel Image (no loading done) to 13a400000
   Loading Ramdisk to 400fb000, end 401ff86a ... OK
device tree - allocation error
FDT creation failed!
resetting ...
Bloblist at 0 not found (err=-2)
alloc space exhausted ptr 400 limit 0
Bloblist at 0 not found (err=-2)
[reset]

After:
+ bootm 0x40200000#qemu-arm 0x40200000#qemu-arm 0x40000000
   Using 'qemu-arm' configuration
   Verifying Hash Integrity ... OK
   Trying 'kernel' kernel subimage
     Description:  Linux kernel
     Created:      2026-02-24  14:10:09 UTC
     Type:         Kernel Image (no loading done)
     Compression:  gzip compressed
     Data Start:   0x402000b8
     Data Size:    12227440 Bytes = 11.7 MiB
     Hash algo:    sha256
     Hash value:   7ea661fdecdd1127edd419cfbf8bff52e2d5ac55ce...
   Verifying Hash Integrity ... sha256+ OK
   Using 'qemu-arm' configuration
   Verifying Hash Integrity ... OK
   Trying 'ramdisk' ramdisk subimage
     Description:  Initial ramdisk
     Created:      2026-02-24  14:10:09 UTC
     Type:         RAMDisk Image
     Compression:  uncompressed
     Data Start:   0x40da9528
     Data Size:    1067114 Bytes = 1 MiB
     Architecture: AArch64
     OS:           Linux
     Load Address: unavailable
     Entry Point:  unavailable
     Hash algo:    sha256
     Hash value:   2a711dcb5f58615187645ccec615c67eddcfbb3138...
   Verifying Hash Integrity ... sha256+ OK
   Booting using the fdt blob at 0x40000000
Working FDT set to 40000000
   Uncompressing Kernel Image (no loading done) to 13a400000
   Loading Ramdisk to 13a2fb000, end 13a3ff86a ... OK
   Loading Device Tree to 000000013a1f8000, end 000000013a2fafff ... OK
Working FDT set to 13a1f8000

Starting kernel ...

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---
 boot/bootm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 4bdca22ea8c..280efb26e90 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -602,7 +602,7 @@ static int handle_decomp_error(int comp_type, size_t uncomp_size,
 #ifndef USE_HOSTCC
 static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 {
-	struct image_info os = images->os;
+	const struct image_info os = images->os;
 	ulong load = os.load;
 	ulong load_end;
 	ulong blob_start = os.start;
@@ -631,7 +631,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 			return 1;
 
 		load = (ulong)addr;
-		os.load = (ulong)addr;
+		images->os.load = (ulong)addr;
 		images->ep = (ulong)addr;
 		debug("Allocated %lx bytes at %lx for kernel (size %lx) decompression\n",
 		      req_size, load, image_len);
-- 
2.43.0

