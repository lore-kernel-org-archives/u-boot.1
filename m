Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8A6CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 340194099D;
	Fri, 16 Oct 2026 06:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LMDf1vaj-8So; Fri, 16 Oct 2026 06:55:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F1FF340999
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133733;
	b=ZiMmloyU/woXG6FlGyukkAXG9qfX2gr1z1SYTuS29F0RWBOF06g+IEu3S8NOQ/rEbNI/
	 M3iSiqSgO+dv6UrvY1l7tdoWNPhNCeiJIjsO6P2SFBPO9j7AI90KQh7/v9zLU30pOnW7w
	 UpJlMKR0z/oFp3tkLc+YRxmGHLMOFSN4gh0YuHXROzYaYGNitJ9xe3j8UFKoO3m9qgP0O
	 A6P6pRQnBsNBHH2u6YV2LLAV87PxWUySsvjCUOYc3I1DUTJ/08kJfI0LGZCgH57vOylgg
	 Mvfgnvzw+/g9q9ywHu05Uh88RtMA5SoWQouFX9+hCpyuhGmHGTDCUD8Un4Z1duEsFGg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133733;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SFFtj/03m2coA98Mdxyj0wmpnN2L1OjM7XDlGXySeu4=;
	b=XlL5vVq30rwe45Xoe/1Je9uHbRMqXiG1xKISGt4Tmig+XO1BG/ku5F5P3KPNuI0r23hm
	 s7NTde76MaL0ksjEIbV99hiSnYX/0dZmsO1s9095l8Og3saEnQ4s9fGqbbJnQDLAGMLfn
	 kvBqbFDO5/S2tIObVs3LuexqyYpfdZy9RpZ2SrFLCDQQvjl/7wBRe1MyhtmHkvlncFYqY
	 rJk5B9RuFoxoN/KwVI2y0Nzry8jxUDghVogqYxwW4uZIBYx1myq567I5m/9JAWupP7LU4
	 kOJhZlCmtzg1xzc6O49Fsc38ROeu2obKOn8QEhD+sMPPmm7uqMe0q82VkfqTiNGi78Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133733;
	bh=SFFtj/03m2coA98Mdxyj0wmpnN2L1OjM7XDlGXySeu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DT7LwkAkU8gtVBSDxFikk6GQTKWXgQUHsp8Zx1fc+y744vbQ9MeATbSJxoT1vYXIE
	 4db9w4plA9JQo9g2xm78q1AkrFbssBV9ammVb7nfL5tiI0CnoPEndhOqtINuBSf+IL
	 PavCKI85aryy1v9Elq7ZtD6b795d2zOAYzRuoDYwV4lUnNmacdvueqAeXyqTbcxbKa
	 Z8yBLdzIxSrRTn2su+I+/jnXhDwYTC8QVDPYcHP010WkBcHiYHJZ1cOiAEOwyLGYpv
	 YcOo7w2sz6Jmse0a9HozU7EnoHpc9sZ2RKZbCS8uI69Hzj33LpcqHOsDGusHUJ42Wx
	 si7PlCp1+JnEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1FF340999;
	Fri, 16 Oct 2026 06:55:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 12A5D263
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FA4E812AC
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:55:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZejshlUo9dKB for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:55:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6C58812A8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133729;
 b=CrtEfCvQ/NscZYvsBD/vXffaQlBXF7aeBag41qqdzW03g3NDRTC7pKuKjPrm8rAAKWOA
 RuDXoYqC4areUI1wRnAwE+P3z8KmFGNdpNpL7oPUJlKYVdZRWB7z8Rbgc0zFfj8E0g3r/
 hJ74y2gB3XljAdl7vMPAhdRHJB0Ev8j0jhPZ0N90GOGZ6Pjwse/3oo/jvUhPTwNGdYDZx
 c9YrGMaSe6L/zxhyXZyNHkxMEqzaX2FkJgb6jZLi7LxZ8WYfUJ0ZM0klU8CGwAVdPPe4e
 Kkd0YkMqvbqiRvqxiTLatGWvRcj68HxJKR3+T8JGAiWZQpT/h/nwQS4SpRz5I0FJ5/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133729;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=SFFtj/03m2coA98Mdxyj0wmpnN2L1OjM7XDlGXySeu4=;
 b=kA0+Yj2Z/MvDrtHUjnPT1RuOPnKw7kS7XeDPSDStxMiQ6/SeI/Nq9m4QDjhNEpxXuoWy
 tDhRDt3ePuISTRbmjw9xf3NtlBEO6NpBFrmRoLkab45FNhIf66CAwt0GzNX5Vpg6Qnfoo
 jyWCZnBntZ68nVSDSFDQb0nj4N86GoTaWBUASFBxNUlT367kCI2o6vVGap5SATa7PcIRi
 NqdcRlPiBev8VgtzdJ187a3Xdds3AmSz/MiZxuNQM61w1H/5nAWu0KiPLJrYOUawegljk
 mlg3Fy+PVz7H9Jm0JplKKPqNqdFN1/fN1dfj3vGqHm1wi7UQjePhGVU8CAG6t9JykoA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=kqVPIWyc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=kqVPIWyc
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6C58812A8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133721; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=faPcZcFPHuv8slMkHwoZSv0t2NCJG5dk+L7OknBfo4bWgtxY9pGTebaLjDLfIAcyufc7KGz6x6eUNWheYdpzh84y14XrZlaM+LZHS+VMb0yq+7n1EIX36/7Jh5jDyLPSJtr8PWduIGmhtncwYp0Iab5zsI24Pke3+6s0eVT2tTg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133721;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SFFtj/03m2coA98Mdxyj0wmpnN2L1OjM7XDlGXySeu4=; 
 b=BFHme6yBzc/O2MaL2QKM1wiw5vzmLPB9ZGVuomYdsDrEYZ1G2YF+/ZJWXw+elMiE0RKWCXCWvhC58pNd8Ytli1Vx0yLzxgvpHUKeHWuEYQyY7tcm8VT2jT1Umk1SuCAEe6udg61M9Qmd66k0j511q03imZgHmLTngdFMwn4XdQM=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133721; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=SFFtj/03m2coA98Mdxyj0wmpnN2L1OjM7XDlGXySeu4=;
 b=kqVPIWycdyB183WGOauCfYcZC1HZKoLMvm6+iRKtor2mbVrK6jHONpVP0tvV6RjH
 hm/p9B6TAPEf21kRo8ZyNpp3JUmE3FNVqKAwmuW8szYW+0KGsA1aBSaLpyhCV0CKGpB
 /0VGKSynqvyGNLUDYrg58djXwTFhNZDIuMHzUuRg=
Received: by smtp.zohomail.com with SMTPS id 1792133718113351.94798873098875; 
 Thu, 15 Oct 2026 23:55:18 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 03/20] image: Take entry point as an output of setup_booti
Date: Fri, 16 Oct 2026 06:54:43 +0000
Message-ID: <20261016065500.137544-4-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016065500.137544-1-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

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
index 92c8452a5d35..228c24e47493 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -887,9 +887,10 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
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
@@ -903,7 +904,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
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
index 5248ca98d411..09cae96b2a8d 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1128,16 +1128,17 @@ int image_setup_linux(struct bootm_headers *images);
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

