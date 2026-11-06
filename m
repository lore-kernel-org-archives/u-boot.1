Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79892606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=avtpSGlB;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BK0+0eiT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F87560D56;
	Fri,  6 Nov 2026 21:56:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IzkRmoM_D7KA; Fri,  6 Nov 2026 21:56:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D8C8F60A5D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794002200;
	b=tHy+DMETwwxjiAoKsCgwS0NCdyoEUZtfFNCWEsq7mOZabEZ9L0L42zoGTUJMXyE/8pWq
	 scExB3F8cfUL+Kq1Rp2fyVMdZeVROKQ0yRkI5oFvWIQOPpHQY+TdcASMPwnKeFho1CP6G
	 eNYmjj7bmYLD5488kCYV5SjflC3tazmLc49gg4dINTnAHg2Xq1LdYVKwoYYyfbhUQ9zqo
	 2P7RGT9Hf2sdAseNznP+gFy0plQL+Al55oLS8+RXUXdkel52sNgg1viLNYdYL4M6SpSlG
	 VlqA15N4y0oJhw7MJ6zOh875Cf96Zy6xAeTb4E1bQKUD0UzWhnDcyzxmlDToe0X9p6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002200;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4oIEMNUQ0JLeXuNZ2h6FjSTR1ZNfwk3x2rsXYm0kh0Y=;
	b=SHL/22RoSGj/4qmS6taxE5Bu2MiRWlTsT6masLmhviU97tyjjl8rXjLJUECjVDGwQSAn
	 IKhImysHuIM5/DpsjItt1hpqcsbxCxUeaxuoaMevOHDhcx5IBqC2svlgKKdQUANsoWUti
	 JA1xoWGpwSMCGc1sE48fKXeD6b+sCBB020e0AnBkcnyNg6jOdtsXtp9O8byPjBvafiP/7
	 iaThA7VQ5kaBqCt5rWlhDOQuHqcgCv/0LOqRD6q58V8fpVjmBpVluZOnOb2GoVu+b//6g
	 W6IJ43KNAMDTJQ1Xx8+meR2zkovbGgi6MrM6WA8h8m+02NW1ya+IlmjidqGS3ObSubw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794002200;
	bh=4oIEMNUQ0JLeXuNZ2h6FjSTR1ZNfwk3x2rsXYm0kh0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=avtpSGlBISQiZ00ZphGsIsvwySOEFwZUrqRgBiowiHtUIYh+mFp9NArDiEZ2Y8lln
	 gYeT4qRacKh4+DraRlzyS3lwQQVbIM0yDcB1r0Pb3hHfLKZY+pzgvOAk3O86J5qVCI
	 IuxjSYE8H1nm9oRg8CcooaSVlVEYYdZDS4zYaKRF7Zq78WX+9FdAsSGxhqaYdyALuE
	 WLVbROItDVo5KB2cO8S0/bR/W2w/oct3ALb8s5YBVBcH2PsF9XXTMqB1NFfkuFOBA/
	 ROWFJxspQngV+xCczCravLFnlxiHQFIedf9m9dll6BkYV84ZY/B6EOadAA8ti81oMO
	 qPAKhBlnuSAHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8C8F60A5D;
	Fri,  6 Nov 2026 21:56:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 89C2732A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B96D403FE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rLG5EoZ4BvbB for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:56:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2E0FA40401
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=BK0+0eiT
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E0FA40401
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:36 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-491aaed7565so652912f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794002194; x=1794606994;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4oIEMNUQ0JLeXuNZ2h6FjSTR1ZNfwk3x2rsXYm0kh0Y=;
 b=BK0+0eiT8ctACZQM/9XaqGqF3m8B2Ik950/d/aS2f1zsSb/MCwiBZGo73W5p/4WPts
 qTsFkeh0qnW+gq/LBhUbua784+G1VXTE3X1T6UnZh4GfILPR1GK3PFGjF2hj6p2bqUtZ
 0A4bfljWqXWyQajVEtrHj1T5SicVZULhSTFTL4My57GzwhKlo3ao9PoCXmDZT6iRuIrZ
 tuee4uFFAB/9sQF/rjp5MvSxOXQUXEY6AGQOCDa3AYebqlOjlmLNMV2yylMZch8MPNhb
 E04FEZ0JwML/Rp4eO4Ml0/Pn7Dj1mW+WYRiHwqAMK7MRqC8F5ZxErxPpt2BbhcOfYwOH
 zlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002194; x=1794606994;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4oIEMNUQ0JLeXuNZ2h6FjSTR1ZNfwk3x2rsXYm0kh0Y=;
 b=moEDhUnU+mOEy49QYJ+9A3yeLL8N7pSjOn0Ynh0dp5VzqqDMCBSs12KpvPZ+qckOwc
 GvmlO+8RTJeJveEWel2kuZ2nSyrwCtQ3g1tVIyX7xRDN4FPVTfKKjOSKZ/5O1SkwYay+
 d5Gn/9Froo10RUS+L2p6dH64UsTW8VGFtYYyL487/lKcA+/zi5tQI8QIznaJAmXD/Ynl
 r/2eZN6M8XAxYnZpKaey8U9Yi0hZdTZeDqHRtNIcsU6enRYs6GVCJMNmUE/LuOTjjtfE
 Ltfhd28BzMMz51r66tomJg5tFYOj7qmpNd5AdPh0KrOnWD/CKX4Kn29YiBSJTs7ArBZY
 xYag==
X-Gm-Message-State: APuU4Z/QbT0qrf6pRyDxZT6/k1SRmIqS/3x1bsgxWpdNWAaznXrukogi
 oJEXqOohxmSZrEPAFQyjcX+VODVdY7H9Ci9lEkhUfOwxBlGls0eticf3x6Sc1Q4vwiU=
X-Gm-Gg: AYBFou0GiJuwZVy2TcCdEhnaqucHPdmYyZ2RtXl14QbU2DetrDZ6mn3z8MZEA3fSuaX
 khnHzIh0Zh0+XcY9FHUCy/izTXMqSi0fMQ16fQg1s/l/Ms80QRzbP8PVMFPefxBZRAwLFkz4hga
 qgXaCxgUqISQaKo0CnxPJ6UdXDlXd0wYwqJcIFSKQIJBEN+mHQNCsxUJZbhbSrFH4XQBBEJvP8p
 7+QG26awhcI/LZ0DUT+vuirzQfQaK+kyWy1OIrEZN1sDWAll5iITtzIyPSga8lBiowSMXOcT1Ev
 +mt/3uSZKdiS6SgHfLAgSkUAZ45itQJfPIecqAs3WXcm99brGeqZ+2VmiEX+hgcPllSBgsYQDKF
 0UHiPMEgIhJJazWNbTsje+RJj6YaHa7Rex7SkuZ2A0uIZcXlCnlDXsMa5E3cutzRbymX9nwJvYi
 NynMMYBRgq/UhlggFCbB9tIRuXgY5OYkyFUVsFGxgWBnoIIanmDEH2hT/ef/kbFOfqAWBNs73jH
 qvnFaALKrslY4nNnALE8xHCfV6UbMMfk7Ha0pkOOYxu3Dtsu2337lL7jPfJn8L+aft+nunZywXk
 pcNPOAMJbMPulsj2pfrQcoq+uATUdPM=
X-Received: by 2002:a05:6000:2011:b0:492:7f3b:8cc3 with SMTP id
 ffacd0b85a97d-4927f3b8d62mr8257471f8f.29.1794002194414; 
 Fri, 06 Nov 2026 13:56:34 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7701cf9sm5129126f8f.39.2026.11.06.13.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 13:56:33 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 02/11] efi_loader: check the PE image ranges in
 efi_image_parse()
Date: Fri, 06 Nov 2026 21:56:31 +0000
Message-ID: <b185f41c-1008-47f6-aac2-1005fae9f8e8@gmail.com>
In-Reply-To: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
References: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_image_parse() collects the regions of an image to be hashed for
Secure Boot and for TCG2 measurements. It takes the header size, the
section table, each section's raw data and the certificate table from
the image without checking them against the image size:

- SizeOfHeaders and each section's PointerToRawData and SizeOfRawData
  are added as regions even when they run past the end of the image,
  which is then read out of bounds when the regions are hashed;
- the section table is read wherever SizeOfOptionalHeader and
  NumberOfSections put it;
- the end of the certificate table is computed in 32 bits, so a large
  offset wraps around and passes the check;
- errors of efi_image_region_add() are ignored.

All of this happens before the signature is verified.

Call efi_check_pe() first, check each offset and size against the image
size without wrapping, add regions only through a checked helper and fail
on its errors. Require the optional header to hold exactly the data
directories it declares, at most 16, as EDK2 and shim do. Take a file
alignment of 0 as the PECOFF default of 512 and require any other to be
a power of two. The padding of a section to the file alignment is hashed
only as far as the image goes, so an image whose last section is not
padded is still accepted. Check the certificate table against the size
of WIN_CERTIFICATE, not of a pointer to it. The sorted section table is
now freed on the error path too, which the new error exits from the
section loop need.

barebox, whose EFI loader is based on this file, added similar checks in
4ec1f7166778 ("efi: validate PE parser input ranges").

Fixes: 4540dabdcaca ("efi_loader: image_loader: support image authentication")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_image_loader.c | 254 +++++++++++++++++++++---------
 1 file changed, 176 insertions(+), 78 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 7cda338882c..82083cb73d9 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -393,6 +393,45 @@ void *efi_prepare_aligned_image(void *efi, u64 *efi_size)
 	}
 }
 
+/**
+ * pe_range_ok() - check that a range lies within the image
+ * @len:	size of the image
+ * @off:	offset of the range from the start of the image
+ * @size:	size of the range
+ *
+ * Return:	true if [@off, @off + @size) lies within [0, @len)
+ */
+static bool pe_range_ok(size_t len, size_t off, size_t size)
+{
+	return off <= len && size <= len - off;
+}
+
+/**
+ * efi_image_region_add_checked() - add a region of an image
+ * @regs:	pointer to array of regions
+ * @efi:	pointer to the image
+ * @len:	size of the image
+ * @start:	offset of the region in the image
+ * @size:	size of the region
+ * @nocheck:	flag against overlapped regions
+ *
+ * Add the region [@start, @start + @size[ of the image to @regs if it lies
+ * within the image.
+ *
+ * Return:	status code
+ */
+static efi_status_t efi_image_region_add_checked(struct efi_image_regions *regs,
+						 const void *efi, size_t len,
+						 size_t start, size_t size,
+						 int nocheck)
+{
+	if (!pe_range_ok(len, start, size))
+		return EFI_INVALID_PARAMETER;
+
+	return efi_image_region_add(regs, efi + start, efi + start + size,
+				    nocheck);
+}
+
 /**
  * efi_image_parse() - parse a PE image
  * @efi:	Pointer to image
@@ -401,8 +440,8 @@ void *efi_prepare_aligned_image(void *efi, u64 *efi_size)
  * @auth:	Pointer to a pointer to authentication data in PE
  * @auth_len:	Size of @auth
  *
- * Parse image binary in PE32(+) format, assuming that sanity of PE image
- * has been checked by a caller.
+ * Parse image binary in PE32(+) format. Each offset and size taken from the
+ * image is checked against @len before it is used.
  * On success, an address of authentication data in @efi and its size will
  * be returned in @auth and @auth_len, respectively.
  *
@@ -411,97 +450,142 @@ void *efi_prepare_aligned_image(void *efi, u64 *efi_size)
 bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 		     WIN_CERTIFICATE **auth, size_t *auth_len)
 {
-	struct efi_image_regions *regs;
-	IMAGE_DOS_HEADER *dos;
+	struct efi_image_regions *regs = NULL;
 	IMAGE_NT_HEADERS32 *nt;
-	IMAGE_SECTION_HEADER *sections, **sorted;
+	IMAGE_SECTION_HEADER *sections, **sorted = NULL;
 	int num_regions, num_sections, i;
 	int ctidx = IMAGE_DIRECTORY_ENTRY_SECURITY;
-	u32 align, size, authsz, authoff;
-	size_t bytes_hashed;
+	u32 align, authsz, authoff, header_size, num_dirs;
+	size_t bytes_hashed, opt_off, opt_size, dirs_start;
+	size_t csum_off, subsys_off, dir_off, dir_end;
+	size_t sections_off, sections_size;
 
-	dos = (void *)efi;
-	nt = (void *)(efi + dos->e_lfanew);
 	authoff = 0;
 	authsz = 0;
 
 	/*
-	 * Count maximum number of regions to be digested.
-	 * We don't have to have an exact number here.
-	 * See efi_image_region_add()'s in parsing below.
+	 * efi_check_pe() checks the DOS and PE signatures and that the image
+	 * is large enough to hold a 64bit NT header, which is longer than a
+	 * 32bit one. Every optional header field and data directory entry
+	 * read below therefore lies within the image.
 	 */
-	num_regions = 3; /* for header */
-	num_regions += nt->FileHeader.NumberOfSections;
-	num_regions++; /* for extra */
-
-	regs = calloc(sizeof(*regs) + sizeof(struct image_region) * num_regions,
-		      1);
-	if (!regs)
-		goto err;
-	regs->max = num_regions;
+	if (efi_check_pe(efi, len, (void **)&nt) != EFI_SUCCESS)
+		return false;
+	opt_off = (u8 *)&nt->OptionalHeader - (u8 *)efi;
+	opt_size = nt->FileHeader.SizeOfOptionalHeader;
 
-	/*
-	 * Collect data regions for hash calculation
-	 * 1. File headers
-	 */
 	if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR64_MAGIC) {
 		IMAGE_NT_HEADERS64 *nt64 = (void *)nt;
 		IMAGE_OPTIONAL_HEADER64 *opt = &nt64->OptionalHeader;
 
-		/* Skip CheckSum */
-		efi_image_region_add(regs, efi, &opt->CheckSum, 0);
-		if (nt64->OptionalHeader.NumberOfRvaAndSizes <= ctidx) {
-			efi_image_region_add(regs,
-					     &opt->Subsystem,
-					     efi + opt->SizeOfHeaders, 0);
-		} else {
-			/* Skip Certificates Table */
-			efi_image_region_add(regs,
-					     &opt->Subsystem,
-					     &opt->DataDirectory[ctidx], 0);
-			efi_image_region_add(regs,
-					     &opt->DataDirectory[ctidx] + 1,
-					     efi + opt->SizeOfHeaders, 0);
-
+		dirs_start = offsetof(IMAGE_OPTIONAL_HEADER64, DataDirectory);
+		csum_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER64,
+					      CheckSum);
+		subsys_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER64,
+						Subsystem);
+		dir_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER64,
+					     DataDirectory[ctidx]);
+		header_size = opt->SizeOfHeaders;
+		align = opt->FileAlignment;
+		num_dirs = opt->NumberOfRvaAndSizes;
+		if (num_dirs > ctidx) {
 			authoff = opt->DataDirectory[ctidx].VirtualAddress;
 			authsz = opt->DataDirectory[ctidx].Size;
 		}
-
-		bytes_hashed = opt->SizeOfHeaders;
-		align = opt->FileAlignment;
 	} else if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR32_MAGIC) {
 		IMAGE_OPTIONAL_HEADER32 *opt = &nt->OptionalHeader;
 
-		/* Skip CheckSum */
-		efi_image_region_add(regs, efi, &opt->CheckSum, 0);
-		if (nt->OptionalHeader.NumberOfRvaAndSizes <= ctidx) {
-			efi_image_region_add(regs,
-					     &opt->Subsystem,
-					     efi + opt->SizeOfHeaders, 0);
-		} else {
-			/* Skip Certificates Table */
-			efi_image_region_add(regs, &opt->Subsystem,
-					     &opt->DataDirectory[ctidx], 0);
-			efi_image_region_add(regs,
-					     &opt->DataDirectory[ctidx] + 1,
-					     efi + opt->SizeOfHeaders, 0);
-
+		dirs_start = offsetof(IMAGE_OPTIONAL_HEADER32, DataDirectory);
+		csum_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER32,
+					      CheckSum);
+		subsys_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER32,
+						Subsystem);
+		dir_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER32,
+					     DataDirectory[ctidx]);
+		header_size = opt->SizeOfHeaders;
+		align = opt->FileAlignment;
+		num_dirs = opt->NumberOfRvaAndSizes;
+		if (num_dirs > ctidx) {
 			authoff = opt->DataDirectory[ctidx].VirtualAddress;
 			authsz = opt->DataDirectory[ctidx].Size;
 		}
-
-		bytes_hashed = opt->SizeOfHeaders;
-		align = opt->FileAlignment;
 	} else {
 		log_err("%s: Invalid optional header magic %x\n", __func__,
 			nt->OptionalHeader.Magic);
+		return false;
+	}
+	dir_end = dir_off + sizeof(IMAGE_DATA_DIRECTORY);
+
+	/*
+	 * The optional header must hold exactly the data directories it
+	 * declares, at most 16, as EDK2 and shim require. The section table
+	 * follows the optional header; it and the whole header area
+	 * (SizeOfHeaders) must lie within the image, as must the certificate
+	 * table.
+	 */
+	num_sections = nt->FileHeader.NumberOfSections;
+	sections_off = opt_off + opt_size;
+	sections_size = (size_t)num_sections * sizeof(IMAGE_SECTION_HEADER);
+	if (num_dirs > IMAGE_NUMBEROF_DIRECTORY_ENTRIES ||
+	    opt_size != dirs_start + num_dirs * sizeof(IMAGE_DATA_DIRECTORY) ||
+	    !pe_range_ok(len, sections_off, sections_size) ||
+	    !pe_range_ok(len, 0, header_size) ||
+	    header_size < sections_off + sections_size) {
+		log_err("%s: Invalid PE headers\n", __func__);
+		return false;
+	}
+	if (authsz && !pe_range_ok(len, authoff, authsz)) {
+		log_err("%s: Size for auth too large: %u\n", __func__, authsz);
+		return false;
+	}
+
+	/* The file alignment is a power of two, by default 512 (PECOFF) */
+	if (!align)
+		align = 512;
+	if (align & (align - 1)) {
+		log_err("%s: Invalid file alignment %u\n", __func__, align);
+		return false;
+	}
+
+	/*
+	 * Count maximum number of regions to be digested: three for the
+	 * header, one for each section and one for extra data.
+	 * We don't have to have an exact number here.
+	 * See efi_image_region_add()'s in parsing below.
+	 */
+	num_regions = 4 + num_sections;
+
+	regs = calloc(sizeof(*regs) + sizeof(struct image_region) * num_regions,
+		      1);
+	if (!regs)
 		goto err;
+	regs->max = num_regions;
+
+	/*
+	 * Collect data regions for hash calculation
+	 * 1. File headers
+	 */
+	/* Skip CheckSum */
+	if (efi_image_region_add_checked(regs, efi, len, 0, csum_off, 0))
+		goto err;
+	if (num_dirs <= ctidx) {
+		if (efi_image_region_add_checked(regs, efi, len, subsys_off,
+						 header_size - subsys_off, 0))
+			goto err;
+	} else {
+		/* Skip Certificates Table */
+		if (efi_image_region_add_checked(regs, efi, len, subsys_off,
+						 dir_off - subsys_off, 0))
+			goto err;
+		if (efi_image_region_add_checked(regs, efi, len, dir_end,
+						 header_size - dir_end, 0))
+			goto err;
 	}
 
+	bytes_hashed = header_size;
+
 	/* 2. Sections */
-	num_sections = nt->FileHeader.NumberOfSections;
-	sections = (void *)((uint8_t *)&nt->OptionalHeader +
-			    nt->FileHeader.SizeOfOptionalHeader);
+	sections = (void *)((uint8_t *)efi + sections_off);
 	sorted = calloc(sizeof(IMAGE_SECTION_HEADER *), num_sections);
 	if (!sorted) {
 		log_err("%s: Out of memory\n", __func__);
@@ -516,14 +600,29 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 	qsort(sorted, num_sections, sizeof(sorted[0]), cmp_pe_section);
 
 	for (i = 0; i < num_sections; i++) {
+		size_t size;
+
 		if (!sorted[i]->SizeOfRawData)
 			continue;
 
-		size = (sorted[i]->SizeOfRawData + align - 1) & ~(align - 1);
-		efi_image_region_add(regs, efi + sorted[i]->PointerToRawData,
-				     efi + sorted[i]->PointerToRawData + size,
-				     0);
-		log_debug("section[%d](%s): raw: 0x%x-0x%x, virt: %x-%x\n",
+		if (!pe_range_ok(len, sorted[i]->PointerToRawData,
+				 sorted[i]->SizeOfRawData)) {
+			log_err("%s: Invalid section %d\n", __func__, i);
+			goto err;
+		}
+		/*
+		 * The padding to the file alignment ends with the image. Round
+		 * up in 64 bits, where the sum of two u32 cannot wrap around.
+		 */
+		size = min_t(u64, ALIGN((u64)sorted[i]->SizeOfRawData, align),
+			     len - sorted[i]->PointerToRawData);
+		if (efi_image_region_add_checked(regs, efi, len,
+						 sorted[i]->PointerToRawData,
+						 size, 0)) {
+			log_err("%s: Invalid section %d\n", __func__, i);
+			goto err;
+		}
+		log_debug("section[%d](%s): raw: 0x%x-0x%zx, virt: %x-%x\n",
 			  i, sorted[i]->Name,
 			  sorted[i]->PointerToRawData,
 			  sorted[i]->PointerToRawData + size,
@@ -534,25 +633,23 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 		bytes_hashed += size;
 	}
 	free(sorted);
+	sorted = NULL;
 
 	/* 3. Extra data excluding Certificates Table */
-	if (bytes_hashed + authsz < len) {
+	if (bytes_hashed < len && authsz < len - bytes_hashed) {
 		log_debug("extra data for hash: %zu\n",
 			  len - (bytes_hashed + authsz));
-		efi_image_region_add(regs, efi + bytes_hashed,
-				     efi + len - authsz, 0);
+		if (efi_image_region_add_checked(regs, efi, len, bytes_hashed,
+						 len - bytes_hashed - authsz,
+						 0))
+			goto err;
 	}
 
 	/* Return Certificates Table */
 	if (authsz) {
-		if (len < authoff + authsz) {
-			log_err("%s: Size for auth too large: %u >= %zu\n",
-				__func__, authsz, len - authoff);
-			goto err;
-		}
-		if (authsz < sizeof(*auth)) {
+		if (authsz < sizeof(**auth)) {
 			log_err("%s: Size for auth too small: %u < %zu\n",
-				__func__, authsz, sizeof(*auth));
+				__func__, authsz, sizeof(**auth));
 			goto err;
 		}
 		*auth = efi + authoff;
@@ -569,6 +666,7 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 	return true;
 
 err:
+	free(sorted);
 	free(regs);
 
 	return false;
