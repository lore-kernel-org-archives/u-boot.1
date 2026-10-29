Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C17606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ja/yhxXj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=B6ZgQ5+j
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E490780F86;
	Thu, 29 Oct 2026 05:08:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x65oiBFYnYk4; Thu, 29 Oct 2026 05:08:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BEA7880F81
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250512;
	b=ZEa+YKkYJmhs3ngyC2LirDE6gwzxIfzo+hxQtZfHRBq43cdhlhjNDnReP0eu4kUfUNMx
	 bT6Bh/XKCbp+A76C7iwe+xWOmdori/9SyXKv549IO17Qo9XfOojyqwa0yJf5/V7wh9UXf
	 Nr4tp8F/GSEVE92YlYdhFerfRcGxbU+TKlL/S1nB3KNlpHTkA/fcDbSTAxDZ/rkCByPlO
	 478m41xbQvnNerz6v4FO+8/SEK7ypg05dihEdjN+6MZJUzpNeLW54SXHOiHi8UskWULWV
	 nuyTfp09Kt41bq4N61dsBQaSCxlr/dg6t/0fQ8Q7Dbugvfwc56OkamHToC/GR2qb73g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250512;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UNtHOpM/Ts/uX4+79n/o+GajIk93EldsGW8P1GKx8Ak=;
	b=EF8NyIrrylZHiW4Sb8yJOX3ESFKnyA/jrwRES8N+xlNkn29Vw4HaJdRx04eLhSEKWAqb
	 VNo1hOvTG4/oXhhFMErbm0T7O4Dogs8Ge/jOP/1AEl6hyFpOXsXeFT3sqb6lv3kr+QvqL
	 eD+eNou1NKvtuYpzjyalIwkZ8WHOqdT4HELn9FWGUm4Jc3Zci3V7uaw0l6zaqq/GxPmud
	 Uz6xZsZotGSbdFgLHVGGMtl9DNzjyqZ50XZBCjNISm6eQr4VpDreRtlHVXzy3DD6ETVfE
	 soHIvSbmF5iCLgZ3jZsnxbmBq+y1VoCE2Z6v0WWmf4dU76ZKme36cn1ThIjDrU2EY0A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=B6ZgQ5+j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250512;
	bh=UNtHOpM/Ts/uX4+79n/o+GajIk93EldsGW8P1GKx8Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ja/yhxXjm3zenfnx5eV+5KBC4hCVFp5ecL2Oc40fh3yB/VVXDHW49VMCLHkdbBb81
	 KTa0K4yiz4wCHtiaXevdvp9JTq7SCal/4yuDAONLUTaPbR5WggU2D7XBVpIFNX6bcB
	 hJMcQ10IDtzJHJksok1zruXeVP+KmwTAKx1a30CnJrJj7QJuUtrbpJpx2Cha72u8oA
	 5Po5rkmviSqPcHb+SiRUrAe915gGSxVb9FK8PQXtcLfO2swUjxHhzjci/5YUdL/IaM
	 ETwbaWQQaFvmqnaeWFSC49tOHhp/xBnQYW1lmc2oN+nGMhOfFSJbkqVEtZoZJieceb
	 R+p5qzn+SdErw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEA7880F81;
	Thu, 29 Oct 2026 05:08:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 68259235
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 59C7980F66
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:08:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ay9DG51_uoHm for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:08:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 24DDE809B5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250504;
 b=XtM40veH9OiaKBLYxk0NZmXc4SALzz75neUPih3QzTWWReDIxMTyRXmk/dY2W6oCiMzO
 DbPDIAJiv/v/twAOKLrJZ4X4zzXDhGbBzBNbX6trJTjTT+YJ7lazEqJ8iuOeEK3gi2nTs
 MqmaloOCBlp9bFASgp3LfLzn6tB3g4UnzaMqUD+0tRaioVeRJxzOsVzJ09n8ByhNr8nYf
 5rg1sJ/72hccCO80ZBD0toZBiH0kaP3PucJ+HC8DH+TmOmdNd9TW2+fo8ejcBMg7jdWzD
 rhG7nwfA72+zSp6WyNmF3gl0Isd0YVoSs2tT48ug7/GJZO1NfH+/hxPSlm1OOcNu1zA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250504;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=UNtHOpM/Ts/uX4+79n/o+GajIk93EldsGW8P1GKx8Ak=;
 b=XJ2vglEAYaBhTWpEHEeIWtZnbRcRdOydWgKEmaNbOPxfImgNDmNlGwN4T0fNQDuGIJT8
 fCO/2AIoZhyx27/0neBx4oxdN3SVD30kuDHn5s5/v0izA6SftWF7feU52/mvV2THf9Q0h
 wo3c+kxZKbT5IDw9kIfEV01grZC+C/PzptF75ZexF00GOzZps/dk5U+Zg4JFoSIR+Hw95
 cwVTguj6Z6O7lEpeB8h+wHFL6Z/eQ3R00r9NoQ+uLqX2RIN9qV82xE/YAmSB9tgEyb7bE
 V5X/1zEMG8+ePOHu8xsn8VAzHWf5yeOFGvbYBUDrnFN1G4c/fyAD0lMYEQRVJ8Uc33g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=B6ZgQ5+j; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=B6ZgQ5+j
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 24DDE809B5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250497; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OEyxUTR3XQWvenDqPKWFpfb2pCaq3CWftwH3vIV+zes3IHtT1F/KokF3ywlYsVre6ypMfyjhmIAkmC+k74hE0KbdhiGnRx7Mr7ldvI6+OLg19ymr7n4MyDadFBcTPnni1Esarg1Ab6PAY2A91eRwQ9H/NRGmrL3tWRcUHgfXw7Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250497;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=UNtHOpM/Ts/uX4+79n/o+GajIk93EldsGW8P1GKx8Ak=; 
 b=Ry3WCKJHUoAbEfUydEb5TyntAEzl1K5S2+M6fsOAT48Obbsav/9zQLeE5+1i5QQl0OZNSmV1imVBooZ0PGjfvoTN8uQPs4G9qKjBwEd+cFXQu5fdamrr9EYAJBN4fcJ0eHMavA/EL8MCvOaMIQhG4++u+kPu2lcpjnucyA5nyVs=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=B6ZgQ5+j8bV0k3TQ1xH5zWG/nQ8phurTtptlcqmWIpGQz3XL7e1tejkY/XJC7uDkb5/pC98cGpp3je6GdR3udMdS+gnTcMT9LqvCWYSokRpgrMf/hx5y042o0CIstggqJIQh42GfKs61qMfmNpsSmq9A2zopccp7Dsg8DKH9OM0=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=UNtHOpM/Ts/uX4+79n/o+GajIk93EldsGW8P1GKx8Ak=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250495791552.8151467287227;
 Wed, 28 Oct 2026 22:08:15 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>
Subject: [PATCH v6 03/20] image: Take entry point as an output of booti_setup
Date: Thu, 29 Oct 2026 05:07:20 +0000
Message-ID: <20261029050738.1107663-4-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
---

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
index b2214ad9c4c3..f91036cd9b31 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -888,9 +888,10 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
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
2.56.0

