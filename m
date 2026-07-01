Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59283C43602
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB4884BAA;
	Wed,  1 Jul 2026 13:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="jMCVG1di";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC78B84B53; Wed,  1 Jul 2026 13:18:35 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9537B84BBD
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782904709; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KcT1f+JSgUeUgMFwvI7J+HEay8bp8mLbOCBcaXiDRWQdcrX67E0FVL5LxplRszcCG0Za1WmAcN+FInr5ek1Q4/Nz/ns3f5P4c4egdkuO8CbbworcchU9vdDhdzsUcMIaOquTm2jfepIH0S6/wU52Nf8LNu1c3azYMrkyLtLxyxc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782904709;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kGRVOnRoUzFaovttIlwucr2E5zSnBHBbp634ZC93u9k=; 
 b=dAfjyOljtS1f/Go5dDA0PFmiypF1WiuUQhl1EqSd/h4viNbnYBUlK3XQQzf0rZTFdD5R59uwtOG9UIwZb1KQoVN6ITRazvs7eEwuCEWAmCa38TbH1NFpYZChAVmEpuvl/WdRivIAeafkHfIvNKfet74C+6x0+YcZSI6WDFWbyic=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782904709; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=kGRVOnRoUzFaovttIlwucr2E5zSnBHBbp634ZC93u9k=;
 b=jMCVG1diQu0Z4fMr7jgolsAplTQ8Nem/CgrZeRZKtWukDjSnVJoKsjRDT/+ed4WL
 STcoF68nctV37Ji7I31J66KuYSnThH3YMi+KQDUNVMx5qUhnV0wtDSC6M7O+90NhZCe
 8SB8d1mbdHm+hGtoirgAla/8Ax2QMk9b67Dn/rDU=
Received: by mx.zohomail.com with SMTPS id 1782904707540327.83440701302015;
 Wed, 1 Jul 2026 04:18:27 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 03/16] image: Take entry point as an output of setup_booti
Date: Wed,  1 Jul 2026 11:17:55 +0000
Message-ID: <20260701111808.870705-4-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701111808.870705-1-me@ziyao.cc>
References: <20260701111808.870705-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

For LoongArch the start of the image is not the entry
point to the image.

We refactor the code base to allow entry point to be
supplied by setup_booti.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

Changed from v1
- Correct type of "entry" argument for RISC-V and sandbox

 arch/arm/lib/image.c     | 3 ++-
 arch/riscv/lib/image.c   | 4 +++-
 arch/sandbox/lib/bootm.c | 2 +-
 boot/bootm.c             | 5 +++--
 cmd/booti.c              | 5 +++--
 common/spl/spl.c         | 9 +++++----
 include/image.h          | 3 ++-
 7 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/arm/lib/image.c b/arch/arm/lib/image.c
index 2268661de93a..62c28b8310a5 100644
--- a/arch/arm/lib/image.c
+++ b/arch/arm/lib/image.c
@@ -29,7 +29,7 @@ struct Image_header {
 };
 
 int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
-		bool force_reloc)
+		ulong *entry, bool force_reloc)
 {
 	struct Image_header *ih;
 	uint64_t dst;
@@ -72,6 +72,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 		dst = gd->dram[0].start;
 
 	*relocated_addr = ALIGN(dst, SZ_2M) + text_offset;
+	*entry = *relocated_addr;
 
 	unmap_sysmem(ih);
 
diff --git a/arch/riscv/lib/image.c b/arch/riscv/lib/image.c
index a82f48e9a505..300be365ddfd 100644
--- a/arch/riscv/lib/image.c
+++ b/arch/riscv/lib/image.c
@@ -33,7 +33,7 @@ struct linux_image_h {
 };
 
 int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
-		bool force_reloc)
+		ulong *entry, bool force_reloc)
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
index 7a5f6f7d36ed..1a41c7c2735b 100644
--- a/arch/sandbox/lib/bootm.c
+++ b/arch/sandbox/lib/bootm.c
@@ -84,7 +84,7 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 /* used for testing 'booti' command */
 int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
-		bool force_reloc)
+		ulong *entry, bool force_reloc)
 {
 	log_err("Booting is not supported on the sandbox.\n");
 
diff --git a/boot/bootm.c b/boot/bootm.c
index 4c260a5f5ced..50d18cb2c294 100644
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
index e6f67d6e1368..24c55ff92a27 100644
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
@@ -74,7 +75,7 @@ static int booti_start(struct bootm_info *bmi)
 	}
 	unmap_sysmem((void *)ld);
 
-	ret = booti_setup(ld, &relocated_addr, &image_size, false);
+	ret = booti_setup(ld, &relocated_addr, &image_size, &entry, false);
 	if (ret)
 		return 1;
 
@@ -85,7 +86,7 @@ static int booti_start(struct bootm_info *bmi)
 		memmove((void *)relocated_addr, (void *)ld, image_size);
 	}
 
-	images->ep = relocated_addr;
+	images->ep = entry;
 	images->os.start = relocated_addr;
 	images->os.end = relocated_addr + image_size;
 
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 722b18c98edc..1d32b0a5b7fd 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -114,7 +114,8 @@ int __weak bootz_setup(ulong image, ulong *start, ulong *end)
 	 return 1;
 }
 
-int __weak booti_setup(ulong image, ulong *relocated_addr, ulong *size, bool force_reloc)
+int __weak booti_setup(ulong image, ulong *relocated_addr, ulong *size,
+		       ulong *entry, bool force_reloc)
 {
 	 return 1;
 }
@@ -341,13 +342,13 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 	}
 
 	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && IS_ENABLED(CONFIG_SPL_BOOTI)) {
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
 			debug(PHASE_PROMPT
 			      "payload Image, load addr: 0x%lx size: %d\n",
diff --git a/include/image.h b/include/image.h
index 9c8a746d576e..97f66b9045bd 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1131,11 +1131,12 @@ int bootz_setup(ulong image, ulong *start, ulong *end);
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
2.54.0

