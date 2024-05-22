Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D70C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 15:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE43C8886C;
	Wed, 22 May 2024 17:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="j6Qm62Bt";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="guSvStLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DE748884F; Wed, 22 May 2024 17:35:13 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60CDC87D43
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 17:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.west.internal (Postfix) with ESMTP id 92B1E180009D;
 Wed, 22 May 2024 11:35:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Wed, 22 May 2024 11:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716392109;
 x=1716478509; bh=b2Mw6vBwECqrdcVNnp8oE+d/lcmpTxZT7jzfSmjR0Eo=; b=
 j6Qm62BtXeYbEvnuApyCc5Zc/t9QOhtS5F58RVImiCnvyR6H1dYvCBalrb06UsPr
 7lVHTRL6SApeHcTzxN4b5kfURemtEf2JxnKDVGmOD+QS7beNCLEEPyqs557Cb3ky
 NyBX5o5cBlRtz6hrjY2GC1q/CKtCpS6ySb12EiPuEg+6Wh9NiN3s+MSlbpaGnPe+
 Ohnbd1n9GMvqfyLam239Unrw9JnMnsISKVmEtkwdvoREF9fMYy05gwiVnGnunwgq
 JAEquytEMacrnOLaYfksEN7FQYna4w3fN5g9ZSY12e9STA7UFzPHDBs+UCGiUzPM
 z3HCIglQNVjXNf1oE0TV5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716392109; x=
 1716478509; bh=b2Mw6vBwECqrdcVNnp8oE+d/lcmpTxZT7jzfSmjR0Eo=; b=g
 uSvStLfissg7q1mX4KvM7xzF1JED10MKHorQesk/LnwIctc6Nee0Z/gO+wrw5miS
 cQF36WAPABFzfsDahWN7pN5Hsbq+myex7tnq85x2GoKMPVgoaOMi1dI+Xr9Vz58G
 5Ii2JyQdtf0IU7PzPShhgJHh84yDZwstfmNOos2TvivEXQQeKTAtrpeDf1QefrAB
 twY0Bw5I0qCaMqosagqjzFS7g9qdBW1Qi5pXn9F4Uwue+QpQahbJ8DCypVP/deWu
 LayLBZTQ7a/2Au6TNfNB+W9eo5lQ1kNbHWZuKF94wIrRiELvZGTl9Op941wOURkS
 sM9XH7mroxOahQyeJ4jfQ==
X-ME-Sender: <xms:rRBOZn_jceJp-SM4rP1ZHbRO5gcs9gNVBFEoiY4b6YhRRSPyDb0bkA>
 <xme:rRBOZjsT7N_ZOGFetbprWkvKbRyIxBG0lxXmhGyE8B6Q-4Q8SGCpYKQNU_ab7oLz4
 pD8KfLIpK82dU3KEDA>
X-ME-Received: <xmr:rRBOZlCKj0z51qvlXHpdy8Y5F8jsQDYJFErrQYuRxkNApEsCq2w6-50>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:rRBOZjcwBbYihLG0cuehhE40RoaxD4h89UuuQQut8QUUe5UF-mW7vw>
 <xmx:rRBOZsO1for3NbvyDONLXa8d3ypbzTYyNtyH2PSaVw_1j0Sf6Pl5Vg>
 <xmx:rRBOZlky6_nuXnNZY74s3-sTU1EDku6ISRmS6ySsAiLioq-_7o8kyg>
 <xmx:rRBOZmv3CcOjQ8F4A0cqmSaJNwLYtyuc-_zlLgcTI6CIx6vmTGNOIg>
 <xmx:rRBOZoAmq8NdAViteatWZFP5knpQZIAvWX9oT4XuzrmTGRJIJ-uooHZ->
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 11:35:08 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 16:34:46 +0100
Subject: [PATCH 03/16] image: Take entry point as an output of setup_booti
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-v1-3-1407e0b69678@flygoat.com>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
In-Reply-To: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5802;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=zLILHYJolYI3rWcS5HwuxcBBBXEMPGLZCx1OwmuU+BQ=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/geVBwgrrtbUMUvvupiSdW2eku8/E+4ro4uDJjvH58
 2axFCl3lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwEQesjL8LxPZd/PtVr0XjPxf
 WIoYP0qp34/6fP2qzQW3xx2/LF/MUmD4p9xoXhi7MWLCj4oFJ8WXMP8M86vP07wStv7tqYIHt5d
 zsgEA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

For LoongArch the start of the image is not the entry
point to the image.

We refactor the code base to allow entry point to be
supplied by setup_booti.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/arm/lib/image.c     | 3 ++-
 arch/riscv/lib/image.c   | 4 +++-
 arch/sandbox/lib/bootm.c | 2 +-
 boot/bootm.c             | 5 +++--
 cmd/booti.c              | 5 +++--
 common/spl/spl.c         | 9 +++++----
 include/image.h          | 3 ++-
 7 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/arm/lib/image.c b/arch/arm/lib/image.c
index e394c1ad9093..024b6adc75e7 100644
--- a/arch/arm/lib/image.c
+++ b/arch/arm/lib/image.c
@@ -30,7 +30,7 @@ struct Image_header {
 };
 
 int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
-		bool force_reloc)
+		ulong *entry, bool force_reloc)
 {
 	struct Image_header *ih;
 	uint64_t dst;
@@ -73,6 +73,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 		dst = gd->bd->bi_dram[0].start;
 
 	*relocated_addr = ALIGN(dst, SZ_2M) + text_offset;
+	*entry = *relocated_addr;
 
 	unmap_sysmem(ih);
 
diff --git a/arch/riscv/lib/image.c b/arch/riscv/lib/image.c
index a82f48e9a505..2fd1f6c535ae 100644
--- a/arch/riscv/lib/image.c
+++ b/arch/riscv/lib/image.c
@@ -33,7 +33,7 @@ struct linux_image_h {
 };
 
 int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
-		bool force_reloc)
+		ulong entry, bool force_reloc)
 {
 	struct linux_image_h *lhdr;
 
@@ -56,6 +56,8 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 		*relocated_addr = image;
 	}
 
+	*entry = *relocated_addr;
+
 	unmap_sysmem(lhdr);
 
 	return 0;
diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
index 44ba8b52e139..4ef34c81d6d2 100644
--- a/arch/sandbox/lib/bootm.c
+++ b/arch/sandbox/lib/bootm.c
@@ -83,7 +83,7 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 /* used for testing 'booti' command */
 int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
-		bool force_reloc)
+		ulong entry, bool force_reloc)
 {
 	log_err("Booting is not supported on the sandbox.\n");
 
diff --git a/boot/bootm.c b/boot/bootm.c
index 032f5a4a1605..770300132891 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -693,9 +693,10 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	    images->os.os == IH_OS_LINUX) {
 		ulong relocated_addr;
 		ulong image_size;
+		ulong entry;
 		int ret;
 
-		ret = booti_setup(load, &relocated_addr, &image_size, false);
+		ret = booti_setup(load, &relocated_addr, &image_size, &entry, false);
 		if (ret) {
 			printf("Failed to prep arm64 kernel (err=%d)\n", ret);
 			return BOOTM_ERR_RESET;
@@ -709,7 +710,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 			memmove((void *)relocated_addr, load_buf, image_size);
 		}
 
-		images->ep = relocated_addr;
+		images->ep = entry;
 		images->os.start = relocated_addr;
 		images->os.end = relocated_addr + image_size;
 	}
diff --git a/cmd/booti.c b/cmd/booti.c
index b9637b3ec3d8..9586a4c58ac1 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -27,6 +27,7 @@ static int booti_start(struct bootm_info *bmi)
 	ulong ld;
 	ulong relocated_addr;
 	ulong image_size;
+	ulong entry;
 	uint8_t *temp;
 	ulong dest;
 	ulong dest_end;
@@ -73,7 +74,7 @@ static int booti_start(struct bootm_info *bmi)
 	}
 	unmap_sysmem((void *)ld);
 
-	ret = booti_setup(ld, &relocated_addr, &image_size, false);
+	ret = booti_setup(ld, &relocated_addr, &image_size, &entry, false);
 	if (ret)
 		return 1;
 
@@ -84,7 +85,7 @@ static int booti_start(struct bootm_info *bmi)
 		memmove((void *)relocated_addr, (void *)ld, image_size);
 	}
 
-	images->ep = relocated_addr;
+	images->ep = entry;
 	images->os.start = relocated_addr;
 	images->os.end = relocated_addr + image_size;
 
diff --git a/common/spl/spl.c b/common/spl/spl.c
index e06bc75d36b2..52a4bee13728 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -113,7 +113,8 @@ int __weak bootz_setup(ulong image, ulong *start, ulong *end)
 	 return 1;
 }
 
-int __weak booti_setup(ulong image, ulong *relocated_addr, ulong *size, bool force_reloc)
+int __weak booti_setup(ulong image, ulong *relocated_addr, ulong *size,
+		       ulong *entry, bool force_reloc)
 {
 	 return 1;
 }
@@ -324,13 +325,13 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 
 #if CONFIG_IS_ENABLED(OS_BOOT)
 #if defined(CMD_BOOTI)
-		ulong start, size;
+		ulong start, size, entry;
 
-		if (!booti_setup((ulong)header, &start, &size, 0)) {
+		if (!booti_setup((ulong)header, &start, &size, &entry, 0)) {
 			spl_image->name = "Linux";
 			spl_image->os = IH_OS_LINUX;
 			spl_image->load_addr = start;
-			spl_image->entry_point = start;
+			spl_image->entry_point = entry;
 			spl_image->size = size;
 			debug(SPL_TPL_PROMPT
 			      "payload Image, load addr: 0x%lx size: %d\n",
diff --git a/include/image.h b/include/image.h
index acffd17e0dfd..a2bfc7bb19a3 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1061,11 +1061,12 @@ int bootz_setup(ulong image, ulong *start, ulong *end);
  * @image: Address of image
  * @start: Returns start address of image
  * @size : Returns size image
+ * @entry: Returns entry point of image
  * @force_reloc: Ignore image->ep field, always place image to RAM start
  * Return: 0 if OK, 1 if the image was not recognised
  */
 int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
-		bool force_reloc);
+		ulong *entry, bool force_reloc);
 
 /*******************************************************************/
 /* New uImage format specific code (prefixed with fit_) */

-- 
2.43.0

