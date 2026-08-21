Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483BAC5DF8C
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 08:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BC8A810C1;
	Fri, 21 Aug 2026 08:42:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-YWnNvNZk8Y; Fri, 21 Aug 2026 08:42:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787301776;
	bh=JhyBmJqgA593UaqwmjFVe+hFQuJc079lnvAzJJ0iLa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WB/I1sGI29o8lPQTQKXfJGG53cPEd2SSdA9fh/31SvfeWqj71PAH47d6rBiyPBxVX
	 DimT0ltfLRb8n2L8jJg6rKaIAmTVP8zjaGhl8kzOa95DIxQUsXixd8trE8S9JjBgxa
	 ycs1ZWkSbajqteW01vhfudXRvfBlQkggg+vuG2i+BYIy5wCp0+dTz7l5TZJb81GVIO
	 ur6wC4WCnQ/SLRllbJ4JENt6YnZ8A8mx9b9BtiRU+mUsyr4BRHjOrvN/6W+Ipqc3f6
	 Ri/KeZpBSmsvNe+pZs+Zm5IhlwGEDnDXokmCkRFkFC/uOfjvDgqkPjDCclgV538w/d
	 jtxwpPp7YJVGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06227810BA;
	Fri, 21 Aug 2026 08:42:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 577001B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A83F60662
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:42:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GGFH89M3LiOP for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:42:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=SrY6kA5d
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 49EBD60661
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787301761; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Zeemi9ldau/Xe/9dyxQDxUBM0KBeeDD2sVWKZgayPGCByrMdNzr4X6H0hQRmSbdAZVVO+NsTgBh9RHEJdGeeib5Wym21P6T1e39gZ5j/FAyrXFZSD/FOfmGi4cZhiZb6D/Wuv1yzOn97RyB/2QweSXu4q7n65M00SjchLu+4WpU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787301761;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=JhyBmJqgA593UaqwmjFVe+hFQuJc079lnvAzJJ0iLa4=; 
 b=VTiKlxGKah1CsfMbwVL/YYsfoGj5yNwiOSJLHIZjbsglVNS2AJEHqpNvHjYxTy0KNZ9gErybtjlmZ8fBolmjYHQ5vKhKs6F1GQ8LdtfjRvtEa+apoE07kPMV3HTWz6T34eMpYZp0MUDMryNxmlsFK5g97wI5+9gPOAVSRUNALhg=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787301761; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=JhyBmJqgA593UaqwmjFVe+hFQuJc079lnvAzJJ0iLa4=;
 b=SrY6kA5d23JQVOtRkOO/mCoU+8hN2/aVfbENYa8pXrb8H+BkQFE5B7VLuWiB9bs6
 Z4q2Ljnlg1W+4Lnf0k9V10KObEHY+9GRme6gWwWlb/q7S7i+07iszIykZY0NJNItZze
 AWyrJ2yuyaDHnxK/vDmQH+no5GsaOaiaeglpY89U=
Received: by mx.zohomail.com with SMTPS id 1787301759153552.9563489312683;
 Fri, 21 Aug 2026 01:42:39 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 03/19] image: Take entry point as an output of setup_booti
Date: Fri, 21 Aug 2026 08:42:03 +0000
Message-ID: <20260821084219.1703743-4-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084219.1703743-1-me@ziyao.cc>
References: <20260821084219.1703743-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

For LoongArch, the start of the image is not the entry point. Refactor
the code base to allow entry point to be supplied by booti_setup().
Also update the kerneldoc comment for booti_setup() to reflect the
latest argument lists.

Link: https://www.kernel.org/doc/html/v7.2/arch/loongarch/booting.html#header-of-linux-loongarch-kernel-images
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

Changed from v2
- Improve commit message, attach a link to documentation of LoongArch
  kernel image format
- Update kerneldoc comment for booti_setup()

Changed from v1
- Correct type of "entry" argument for RISC-V and sandbox

 arch/arm/lib/image.c     | 3 ++-
 arch/riscv/lib/image.c   | 4 +++-
 arch/sandbox/lib/bootm.c | 2 +-
 boot/bootm.c             | 5 +++--
 cmd/booti.c              | 5 +++--
 common/spl/spl.c         | 9 +++++----
 include/image.h          | 7 ++++---
 7 files changed, 21 insertions(+), 14 deletions(-)

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
index 3bce85868346..2f92798f8320 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -723,9 +723,10 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
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
@@ -739,7 +740,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
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
index 6c9a1a1cbcc3..3856aafbca9a 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -115,7 +115,8 @@ int __weak bootz_setup(ulong image, ulong *start, ulong *end)
 	 return 1;
 }
 
-int __weak booti_setup(ulong image, ulong *relocated_addr, ulong *size, bool force_reloc)
+int __weak booti_setup(ulong image, ulong *relocated_addr, ulong *size,
+		       ulong *entry, bool force_reloc)
 {
 	 return 1;
 }
@@ -342,13 +343,13 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
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
index 6edcb1995bfe..742e2b8cba7a 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1126,16 +1126,17 @@ int image_setup_linux(struct bootm_headers *images);
 int bootz_setup(ulong image, ulong *start, ulong *end);
 
 /**
- * Return the correct start address and size of a Linux aarch64 Image.
+ * Return the correct start address and size of a Linux Image.
  *
  * @image: Address of image
- * @start: Returns start address of image
+ * @relocated_addr: Returns start address of image
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
2.55.0

