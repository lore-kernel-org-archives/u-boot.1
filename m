Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24851606A323
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YKGZowEs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=FRY9FJ8b
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB66440DAD;
	Thu, 12 Nov 2026 11:59:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gOaACTAzcj0G; Thu, 12 Nov 2026 11:59:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E973940DA7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484786;
	b=Qv4NoG9AdlqSf1sYDAMz2oTA+t9XD28kQHQUfScCGoyt66gvr2AiU+ja7+8HXNWiglLl
	 pOJ+hTYAdhQh2BZyji+zHFG2xnHFklmeRBeenEdiYnhtBcMAadAViVwEXJQ7+o15CN7hH
	 mQPCxO4R4nOiRiyS4vaO+V6gHdbpFPo8iHKCosWi9JkYUy43hbc+oj9+V33Df/lan4GJk
	 6eBzUwby5nTAnyzw44yPLQTDNjFVrTD8SyNyK0WfbGFh5T7QxtF/pnpmsXPXzhCLq1ecp
	 7Hgm2/M1N6KKR0obFQxJfDAxRrKscXd/VfR4vxKyP6zE6RxebmJ2vm2lYCBWbDz+Fhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484786;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lLTu73auAnkjgCglIJ8Ph2v+Ce5jXeZ3RYlf0yBgs1s=;
	b=T70ZafgnYscxe+HcmkM1tealtr1vHRjA4SFSiyH6fw+mxl4h8zYY7plxC/e8cIk65w/o
	 1fM0PEXXNy+0han3g4W5Ra+4T/hxzPQP95gauZpfvuEvrKhqnxyTMqbIfw5pyIvHKCtgW
	 Q/3zheinf4/C9rmOe99u54KBKOVp/0nIQjaxWIl788HUUfxktAGOCF5zaCtuBtfLoBlGd
	 CwzruoJPhCZGZLUVqnk7a9loNMVKo9CK2Nzt6+0yQcKNZwhwlkY2NXAJ5lWwI6qX7bBRh
	 VvJ/jsNfCrc26CDSOJBb5MCXTi9RFseDEs0Esaw/Ls1ZCshM02aFXrckyDmk7Cq3Kfw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484786;
	bh=lLTu73auAnkjgCglIJ8Ph2v+Ce5jXeZ3RYlf0yBgs1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YKGZowEsvnAhlsyiM1VnVuAO6uRnokgdZAMF4cFum3WrRggRoy549i6NrwT4vJ8YJ
	 qwOiyDvZ6qwytEdulpxqnHhVUOm3hR0H1pkDcmMdHl9b851s9NZayywfBD3OVIxtor
	 w8xQMbpxyOaVCYJ8glDrAaBQGKxKBF07S03JMosUV2lWp8NUbCaqS9kHjcs8S7+4OL
	 XhbSgr07QpuNMZrhk81JRQZjmaUsRzkJ2STqF4H5rp+jpZ5q8R3/0qnJ6JP/qLJhE8
	 sy3sJPEdwPNACnHkeHTFsDE+DJzBKjH1KxDWvRcRgGHrPH1QfhiTQKefeeNo8/Onwu
	 0bqOD2H0NABKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E973940DA7;
	Thu, 12 Nov 2026 11:59:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 829681A6
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68BB7815B6
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:59:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kowhcc4zt8XM for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:59:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D25281746
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=FRY9FJ8b
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D25281746
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:59:42 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=FRY9FJ8b++Y1tcwoVniIY0Yx4KUcNA2/XPa1b443Ta1JxmQF+Y7kSgivjsgvPfXAKedg84+SIzmpDgvLPStCwtbDKCNZj8Ckt7YM6idLMRa6SNm3CMMLBMeWhdywpPn2pKBoJyiY3Ctwljqnzi8g7D1+PKR97TAepsF5QYf9Fxw=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=lLTu73auAnkjgCglIJ8Ph2v+Ce5jXeZ3RYlf0yBgs1s=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484502714878.7723796529884;
 Thu, 12 Nov 2026 03:55:02 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 03/20] image: Take entry point as an output of booti_setup
Date: Thu, 12 Nov 2026 11:54:21 +0000
Message-ID: <20261112115438.1837663-4-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112115438.1837663-1-me@ziyao.cc>
References: <20261112115438.1837663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

For LoongArch, the start of the image is not the entry point. Refactor
the code base to allow entry point to be supplied by booti_setup().
Also update the kerneldoc comment for booti_setup() to reflect the
latest argument lists.

Link: https://www.kernel.org/doc/html/v7.2/arch/loongarch/booting.html#header-of-linux-loongarch-kernel-images
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v6

Changed from v5
- Re-title, change "setup_boot" to "booti_setup"

No changes since v4

Changed from v3
- Collect Tom's review tags

Changed from v2
- Improve commit message, attach a link to documentation of LoongArch
  kernel image format
- Update kerneldoc comment for booti_setup()

Changed from v1
- Correct type of "entry" argument for RISC-V and sandbox
---
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
index 4b03a367a217..46a19a37f19f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -888,9 +888,10 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	    (images->os.arch == IH_ARCH_ARM64 || images->os.arch == IH_ARCH_RISCV)) {
 		ulong relocated_addr;
 		ulong image_size;
+		ulong entry;
 		int ret;
 
-		ret = booti_setup(load, &relocated_addr, &image_size, false);
+		ret = booti_setup(load, &relocated_addr, &image_size, &entry, false);
 		if (ret) {
 			printf("Failed to prep kernel image (err=%d)\n", ret);
 			return BOOTM_ERR_RESET;
@@ -904,7 +905,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
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
index f059fc5811c0..eb19f6d34e39 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1129,16 +1129,17 @@ int image_setup_linux(struct bootm_headers *images);
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
2.56.0

