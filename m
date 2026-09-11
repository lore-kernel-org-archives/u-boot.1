Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48ACC88E4A
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:46:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 983CA8128E;
	Fri, 11 Sep 2026 10:46:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wrd4_R5Uc6M0; Fri, 11 Sep 2026 10:46:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4C770811FD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123603;
	b=pA0vCf1/vGe5gfhc66uWanib0jBiS4OlYjCTbXv/D/3fcnjAPbK5wHK1Qsn6GbnlUusC
	 9GSB1FhuWPAyMiG2QM5xsgU1qKoG+DzHHkMMXpgb3oqfeaqnlylutZJXIIoz1rndbIRUV
	 Uu97EJsVZ0QKUwsP0iesGgNHx2Q2exr1kA9yyL7GDP+qlpgqgNVylCUhN/4YY0wCp2taW
	 JskHBvpkkARwvM3eOs/wj5zx34/jQ5TrMDAdyk2sJVN8P5n+9JvV6cngzS6vit+OGFLT5
	 fdrVhfkv/Hp2rosVUkO0ZpXP6anMPfVZ0ayFcMs/aaUUebieVy1BDt5cRJRLVkfztSw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DBrEh2VmZ7hCFeHj+kdoJycyEXC0ozRLwicjHRS4aFU=;
	b=jEZkv6C1lXL6C6xBi4sKC0reOZHkBsTzdGUjRZQlvzBq+ARxgyFfKAjL9PsMs3lp/qk4
	 CUqIBCCCNP/6H1iB4z4sVO9C/dLi/UAGMrg650JPge3Ec4TqhuDkYAPraR77Hj3Sf36Xv
	 lFfchvxPiNmViGA0VJ8e+7RHAMwko04yZBmRPgGVu4RQmIPredTuhLtLJ3scikrD71pgw
	 rQmCNwW/43mazVCn64xvVMPHti0aufhSevOLVrL8YMaFH+E0xj+wN2NwUB524mKwoYPI/
	 v0ZJ3PJ/PGT57QibX8HOS0OOw4HXMUa3IbF3+xibT9s//1IdyiiNs0AGbgIZHmEIimw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=Ht9QGptW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123603;
	bh=DBrEh2VmZ7hCFeHj+kdoJycyEXC0ozRLwicjHRS4aFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JjC+MmtxMCFkXzxp8u2CJdE1D5Prclqsuy6p1EbgVp3roGcdzHDUICSaoWbAr29vZ
	 GydRhN5bB0RdVSkFeVZegyXekiB23oN5jqgr4BLlOT9shmVrisRS06h7iqpT5cLfVy
	 hNbI7LawdT1cwd9h0LYAWcfctO/w9jgN4ydJLtLV7D7Gw8cve5orCx5dsbiKc9laGi
	 ZP7LCPlIYs8FcgEurPQZFUuJPx/95BsgljvRq0HBasrYqYa6Mlt7FrIth8jM7HGfZ6
	 83EMgcO+e6M++xoHDRAb4LkdEIj7asLWszlsPVoqm2A32zrqdggIJ76TZ2WceXvu8P
	 IRsUKELWBc/Fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C770811FD;
	Fri, 11 Sep 2026 10:46:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 92D291EA0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:46:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 787D68126C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:46:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3uGyG7qgQdnS for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:46:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3ED06811FD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123599;
 b=jy3Nuupw7DUvE9Aps9UqoY+GG9b0t2SzQ+kvpe3MyHWj+X+NzQl0KpRFfMoNs+QGtgjr
 8WZxHctfFBl9hvlZBE/XWXXg8yhHC0H12CfN8ZoroCDj3CF0ex6NCzia0qjTA3DNIsVgK
 U8KZB0zsd57GS/WEE2tSVQTW3TVKH46zqcrNbsGH9GgnszZSF1UZapEO0psz5k0fvxepQ
 LX2dZscsZNTagivpvm0ZW+Fu+XNZjigSJnChSMQMCo0Z/EcB4hgURUCmc1YEZvw+Muq49
 BxSlB3g4qJ0AmFVDw/Yk3Ng6+gV35rtdRy9RhtcZf2mXNYxmab2+zULYRNlVdVE/chA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123599;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=DBrEh2VmZ7hCFeHj+kdoJycyEXC0ozRLwicjHRS4aFU=;
 b=bAY3MMhFiBXAIsCcDnRljc7NG/iS0xdq2e81NqU/BQOEW1SwkakBud2pnI6GJ6XCXfh/
 O23X4Gq5h/XO00+IMIeZ52KoEgEAnHQAcbVoGwzgJvGh6g2IWNTJ16pg4N6Ty/aEex3wG
 pnWGIBedW2O2usefNNLaPKd0tvhcFMDt0tgBovKwrxNgTkALQvJDrjy9yZDpb4GqkUWIf
 0FPglzVjC9nDLPa82DmlBCdMAi5mPu43n6IqccPw2Woo06unN8wQL6gYkgqC8lORntUVD
 kF9BRY72+gSNjcigwaVRemJUPoRSU8exr532lGRQulirhusC/NMvCKcZ5WqWB4kxAPQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Ht9QGptW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=Ht9QGptW
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3ED06811FD
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123591; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YHECt5+HAdwHawCxVBZb0FLcb0cAeU+DphsbiZnuegLIzKB7qjDp5/cJ96Z+B/phpNKHAGAhzEMk6z0YoatW8ucXepKDaJtizNUdj/sqt07A/ft1GoPZizIzXCV5LwybvpOoyNWQvSrlKgk3WNSCT7hquLWF1yVljvx7SJLuHvM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123591;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DBrEh2VmZ7hCFeHj+kdoJycyEXC0ozRLwicjHRS4aFU=; 
 b=hg+8j+PG10uvqhY4AXwLKtMj+jLpdWBiowsFfl8KfK6ky3Xh+6N5RAXyvPI3bqYqFClH5WTQcCLfbc9oquNtJqEqpuuOSZDkFm/0gDG89fC+DbZ7LUsS8sLcKkiFjz85mwbqYLkTQmGm5KSLKstQU0LaJBG6iBRVXfwtfGS/GqQ=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123591; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=DBrEh2VmZ7hCFeHj+kdoJycyEXC0ozRLwicjHRS4aFU=;
 b=Ht9QGptWM4cMcplIMi05t9Jk4v220RxBzjKCcc2N9p/EthXU0atPemQBogpCxUzU
 I+Fjy+I6dlAt7zG6z2vlI+y1V8SNbGv77A75Xf/Mz3L9U+fkfAMkrCr3NU8gs+d7pHM
 D1g7+mf0NUmZJKv3picxrG1fleMbHVFQzEQxyxPo=
Received: by mx.zohomail.com with SMTPS id 1789123590538600.3758372848331;
 Fri, 11 Sep 2026 03:46:30 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 03/19] image: Take entry point as an output of setup_booti
Date: Fri, 11 Sep 2026 10:45:48 +0000
Message-ID: <20260911104604.2910944-4-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911104604.2910944-1-me@ziyao.cc>
References: <20260911104604.2910944-1-me@ziyao.cc>
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

Changed from v3
- Collect Tom's review tags

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
index 758edeb964c7..fa862a5c2818 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -857,9 +857,10 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
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
@@ -873,7 +874,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
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
index 11af6f1d522d..0a5b04d71ebc 100644
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

