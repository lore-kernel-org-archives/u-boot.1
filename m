Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B3606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=egPMs+Sn;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XSWnacZE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DBAE80F07;
	Sun, 15 Nov 2026 19:00:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VomFEonWTTyK; Sun, 15 Nov 2026 19:00:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 361D580EED
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794769237;
	b=hDP4vrlRIYn90HZvviu+o5P1VuDCAgZJ1SD3zDESGi8mB6IWjL1R9jzq1hnSDVJBcpzw
	 ayXZLcfVUNejyQoH4LvR60gQKISIvUE6futR+kxiOBuKxHs+pT13BQqIfKLjrUy5kPxhP
	 tbrVXtqA2tZredpVogBWcjPsKVZuVAgiMM6eylJoSHTbdwTDKf0RW7WnvsZQTOESYO2xB
	 GAFqOLIPNKsyVYXP7VmAPCuPv7lvZGWpsh8S9yYy50FIA4UlQ5+RxQb04huzXW386i+E7
	 +axUZlyIjr/Ti8dv6eor2AbZZb0W4lXeX3dCrJMcq9k8K36eKnR/alOhRtAjImLvzKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794769237;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Xz1m8AYzgy7kTA6RepI7tJRimqW/7pUUBhvF3Y4kfrU=;
	b=IimSAMAWK2CfY8a7kOHf6ObLTq3OgGx5+EjL9O67iFOdffUeZOn83HgOhEq2mrdlHlYc
	 r/xuAcrxvDa/tIzYMSrKdQEESELul3r3t+snKcbNLo51tSz5+ddGNijD6Fh/dvt4kS3r3
	 TcucKeMf1VRipykKlBhIhLJkTmMo/62VX+SfclgHrpguXJ5gaHeaI1XsD1T5FBi6ideH5
	 ADk1iWWQtSah4HEGgmy5qa4+PbptkjiYolmnXAEo53TmaOqlyPPrhoHLNpra213C30giD
	 9UXmU1rx89KUameAtOgyz6SuGcJhhJz2iEU5BGjrmjyMgO3Esssbp+U3X/xdBpfBD6w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794769237;
	bh=Xz1m8AYzgy7kTA6RepI7tJRimqW/7pUUBhvF3Y4kfrU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=egPMs+SndaQv18UvzvVd/rOSSKgGHF5JNuUKmbinStnQVrelik4nEmvbxifgyS+BH
	 /U/kUrmEHUjZr21lfP8LW/cSTI09tCKXkxAmdIW0S2e+Dopbqkw3UnhJIMsvxC3Uo8
	 1bYjHmdmU6BTa5DRrMO2spDSNMtZD3b8kkwg7Tm+yIQwGQuyI/NEf/oUsYJDMCHL6o
	 SeBkVbueexbNH3pDeP6NXh6NggEbmVA3nrfHD/XwsYrRSHbmI80Cet7d/jlS6zeksN
	 MOy1+fsOL75KDA7CbXlWLsE+YzfRXR4S7pwiktSxxpdOYYnCMihAmpRPD/gY8SsL0T
	 /xIkTBAzUqyoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 361D580EED;
	Sun, 15 Nov 2026 19:00:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D2AD2FE
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3FC5260603
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OaBXKU2j60Ku for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 17:12:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 31E51605E5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::92f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92f; helo=mail-ua1-x92f.google.com;
 envelope-from=georgekola@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=XSWnacZE
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31E51605E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:11 +0000 (UTC)
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-9950a7530d9so2605086241.2
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 09:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794762731; x=1795367531;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xz1m8AYzgy7kTA6RepI7tJRimqW/7pUUBhvF3Y4kfrU=;
 b=XSWnacZEj6eYuN5QbPeTLfOMBk8+uFJ+/ci2T8+aCJBOHiTS+Gw4Qf23MAc/RHiRP9
 8MXf9aMkIRSqGOYlI7sOThEey0ad4tAQE0SJzWXgKS84e/dV+N5+wClX0LGoftUL1SJ8
 Vlj8DnBJNZhyLn7nVCMnQJn84HWCsE2yKNfKn//cdQepQi7yvQTsgr9ILalwad81Pb3q
 w/ZDWWNg+D0YNaXBtwJ860y7iX5uJ15LLIkJgn1POq81YI/k9Pq17qujxyWU41d9uUpA
 Zg+ELYwsMrI1EuY48wdqB7aa7TXS7Xt31F3K6OPZ4SCSWjCLBFeggjBi1ZEiUROS2bYj
 vHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794762731; x=1795367531;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Xz1m8AYzgy7kTA6RepI7tJRimqW/7pUUBhvF3Y4kfrU=;
 b=a7tQKu1dyB8PBwtaiwbWbOaD6lE13MS/JHp9NXgSVJdHzOcXb7OB0OXGQu6ev0gHBk
 EHJcBSGEde4+2WNssehSPpMlkVJMsKyKHzRBgMVrFWW1BphIsYtKbJoCx/SsU09u45GH
 gkRiNjeOydIaDHCi+qLdQoMYW2FYg9kWvRJDj3Pm89C9DhtTtVdwazlGsPwbmlr2cKzf
 kNwmZbLemgO59HzQRc5uTDV+iLCjZEOxpZnjX74cjtplMFxzahE2bmiyzTNaIkTf7eb6
 JobmTmz1snJ6ZNX2lZqrg7TXme9awwolHF7d7vTCJgwwrgI9kra9XMxpSwZmjiqhCMu9
 puOA==
X-Forwarded-Encrypted: i=1;
 AL+hErF4bbDGhdlv/sblMiaBkKzkC5peyi09yaCL9VSJD8EblSjSo/89ShNlHt6VY3H0MNk8PIILbAM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+cgC6affwf2eJlJwxeZdU4fowpPT+U5pR9cps9pRpV/opr6sEs
 aDnIri6l3/pBp7p2/si/IWNhEqrp+/+cgDbSKgDF6+m7FllHXlB9KEcZFKVE5ETHI/TRqkUcAWo
 6Ts/GPhql3sYIZlTTqnb0AZnPGBwKTpjWRldNaVWh
X-Gm-Gg: AYBFou2zUb4aVbOeyF5r3NkORuUloZtsRg1XCYEipsUnds5b3v5+ceGYsNznHNt9+Or
 af3mZfV0WvAVGSgdJ3ag8VZRjKwC2vRbU1/S1XY3zgR1L2DsuSfFWqicseuwbchq8Yhmf4jcgaR
 foNUM9EqF4miUufOvTiWv5PllrbH3QCYT+4wpthZTtHFY7ezd4aloNyHm3jwliqzNQFhgee3J5C
 PuOFa/tkYvujJKFZLQznb5TDrg59Am59hiiVJavVoLYfi/K7arQZXWh86Tri+swEKBmP6Roh5uM
 egBG7+cPHMKHLx/4UNtGRW9x2ySoCa5E32s+i6C1y/R/UYFFrpSI7SBVzss1uxBttZ2Rs6s032k
 zVudSoy1XXD6zRC0aMymy1HwgzHJ1hZdowDkzswPUW1jjc6YoW7TG0MX4TmGbtG+03w==
X-Received: by 2002:a67:e111:0:b0:7d2:da60:d0f7 with SMTP id
 ada2fe7eead31-7d64d7d3570mr2640136137.28.1794762729938; Sun, 15 Nov 2026
 09:12:09 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 15 Nov 2026 09:12:09 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: George Kola <georgekola@google.com>
Date: Sun, 15 Nov 2026 09:12:09 -0800
X-Gm-Features: AclHuK8hu4X4N1Jbu96fAAsvkKq_tklyDHiSTmLY3WOq-cDjVnwLk5n9xbKF5IU
Message-ID: <CAOTQ16Jz3KphYO54zYA6YG-b7s8AbrKXLHmZ86WuRv4DhqRvSA@mail.gmail.com>
Subject: [PATCH] efi_loader: prevent PE header and section RVA overflows
To: Alexander Graf <agraf@csgraf.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 15 Nov 2026 19:00:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In efi_load_pe(), sec->VirtualAddress + section_size(sec) is evaluated
in 32-bit unsigned arithmetic before promotion to unsigned long,
allowing a crafted PE-COFF section to wrap virt_size and write out of
bounds. In addition, e_lfanew, SizeOfOptionalHeader, section alignment,
AddressOfEntryPoint, and DataDirectory bounds are not validated before
dereferencing headers or copying raw section data.

Validate e_lfanew bounds and alignment in efi_check_pe(), and verify
SizeOfOptionalHeader, section table alignment, and section count
against efi_size before pointer arithmetic in efi_load_pe(). Compute
section end offsets in 64-bit arithmetic, reject 32-bit RVA or unsigned
long overflows, validate raw section offsets, skip zero-length raw
section memcpy() calls, and verify optional header DataDirectory and
entry point bounds before copying validated headers_size.

Fixes: cb149c66342c ("efi_loader: Add PE image loader")
Signed-off-by: George Kola <georgekola@google.com>
---
 lib/efi_loader/efi_image_loader.c | 123 +++++++++++++++++++++++++-----
 1 file changed, 103 insertions(+), 20 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c
b/lib/efi_loader/efi_image_loader.c
index f9a2d2df40..11798c6c71 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -849,7 +849,10 @@ efi_status_t efi_check_pe(void *buffer, size_t
size, void **nt_header)
 	 * least one section header follows we only need to check for the length
 	 * of the 64bit header which is longer than the 32bit header.
 	 */
-	if (size < dos->e_lfanew + sizeof(IMAGE_NT_HEADERS32))
+	if (size < sizeof(IMAGE_NT_HEADERS32) ||
+	    dos->e_lfanew < sizeof(*dos) ||
+	    !IS_ALIGNED(dos->e_lfanew, sizeof(u32)) ||
+	    dos->e_lfanew > size - sizeof(IMAGE_NT_HEADERS32))
 		return EFI_INVALID_PARAMETER;
 	nt = (IMAGE_NT_HEADERS32 *)((u8 *)buffer + dos->e_lfanew);

@@ -897,7 +900,7 @@ efi_status_t efi_load_pe(struct
efi_loaded_image_obj *handle,
 			 struct efi_loaded_image *loaded_image_info)
 {
 	IMAGE_NT_HEADERS32 *nt;
-	IMAGE_DOS_HEADER *dos;
+	IMAGE_DOS_HEADER *dos = efi;
 	IMAGE_SECTION_HEADER *sections;
 	int num_sections;
 	void *efi_reloc;
@@ -906,6 +909,9 @@ efi_status_t efi_load_pe(struct
efi_loaded_image_obj *handle,
 	unsigned long rel_size;
 	int rel_idx = IMAGE_DIRECTORY_ENTRY_BASERELOC;
 	uint64_t image_base;
+	size_t opt_size;
+	size_t headers_size;
+	size_t sec_offset;
 	unsigned long virt_size = 0;
 	int supported = 0;
 	efi_status_t ret;
@@ -929,14 +935,20 @@ efi_status_t efi_load_pe(struct
efi_loaded_image_obj *handle,
 	}

 	num_sections = nt->FileHeader.NumberOfSections;
-	sections = (void *)&nt->OptionalHeader +
-			    nt->FileHeader.SizeOfOptionalHeader;
-
-	if (efi_size < ((void *)sections + sizeof(sections[0]) * num_sections
-			- efi)) {
+	opt_size = nt->FileHeader.SizeOfOptionalHeader;
+	sec_offset = (size_t)((u8 *)&nt->OptionalHeader - (u8 *)efi);
+	if (opt_size > efi_size - sec_offset) {
+		log_err("Optional header exceeds image size\n");
+		return EFI_LOAD_ERROR;
+	}
+	sec_offset += opt_size;
+	if (!IS_ALIGNED(sec_offset, sizeof(u32)) ||
+	    (size_t)num_sections > (efi_size - sec_offset) / sizeof(sections[0])) {
 		log_err("Invalid number of sections: %d\n", num_sections);
 		return EFI_LOAD_ERROR;
 	}
+	sections = (void *)((u8 *)efi + sec_offset);
+	headers_size = sec_offset + (size_t)num_sections * sizeof(sections[0]);

 	/* Authenticate an image */
 	if (efi_image_authenticate(efi, efi_size)) {
@@ -946,18 +958,39 @@ efi_status_t efi_load_pe(struct
efi_loaded_image_obj *handle,
 		log_err("Image not authenticated\n");
 	}

+	virt_size = headers_size;
+
 	/* Calculate upper virtual address boundary */
 	for (i = num_sections - 1; i >= 0; i--) {
 		IMAGE_SECTION_HEADER *sec = &sections[i];
+		u32 copy_size = min(section_size(sec), sec->SizeOfRawData);
+		u64 sec_end = (u64)sec->VirtualAddress + section_size(sec);

+		if (sec_end > U32_MAX || sec_end > ULONG_MAX) {
+			log_err("Section %d virtual address overflow\n", i);
+			return EFI_LOAD_ERROR;
+		}
+		if (copy_size &&
+		    ((u64)sec->PointerToRawData + copy_size > efi_size)) {
+			log_err("Section %d exceeds image size\n", i);
+			return EFI_LOAD_ERROR;
+		}
 		virt_size = max_t(unsigned long, virt_size,
-				  sec->VirtualAddress + section_size(sec));
+				  (unsigned long)sec_end);
 	}

 	/* Read 32/64bit specific header bits */
 	if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR64_MAGIC) {
 		IMAGE_NT_HEADERS64 *nt64 = (void *)nt;
 		IMAGE_OPTIONAL_HEADER64 *opt = &nt64->OptionalHeader;
+
+		if (!IS_ALIGNED(dos->e_lfanew, sizeof(u64)) ||
+		    opt_size < offsetof(IMAGE_OPTIONAL_HEADER64, DataDirectory) ||
+		    opt->AddressOfEntryPoint >= virt_size) {
+			log_err("Invalid 64-bit optional header\n");
+			ret = EFI_LOAD_ERROR;
+			goto err;
+		}
 		image_base = opt->ImageBase;
 		efi_set_code_and_data_type(loaded_image_info, opt->Subsystem);
 		handle->image_type = opt->Subsystem;
@@ -970,10 +1003,40 @@ efi_status_t efi_load_pe(struct
efi_loaded_image_obj *handle,
 			goto err;
 		}
 		handle->entry = efi_reloc + opt->AddressOfEntryPoint;
-		rel_size = opt->DataDirectory[rel_idx].Size;
-		rel = efi_reloc + opt->DataDirectory[rel_idx].VirtualAddress;
+		if (opt->NumberOfRvaAndSizes > (u32)rel_idx) {
+			if (opt_size < offsetof(IMAGE_OPTIONAL_HEADER64,
+						DataDirectory[rel_idx + 1])) {
+				efi_free_pages((uintptr_t)efi_reloc,
+					       (virt_size + EFI_PAGE_MASK) >>
+					       EFI_PAGE_SHIFT);
+				ret = EFI_LOAD_ERROR;
+				goto err;
+			}
+			rel_size = opt->DataDirectory[rel_idx].Size;
+			if (rel_size &&
+			    ((u64)opt->DataDirectory[rel_idx].VirtualAddress +
+			     rel_size > virt_size)) {
+				efi_free_pages((uintptr_t)efi_reloc,
+					       (virt_size + EFI_PAGE_MASK) >>
+					       EFI_PAGE_SHIFT);
+				ret = EFI_LOAD_ERROR;
+				goto err;
+			}
+			rel = efi_reloc +
+			      opt->DataDirectory[rel_idx].VirtualAddress;
+		} else {
+			rel_size = 0;
+			rel = NULL;
+		}
 	} else if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR32_MAGIC) {
 		IMAGE_OPTIONAL_HEADER32 *opt = &nt->OptionalHeader;
+
+		if (opt_size < offsetof(IMAGE_OPTIONAL_HEADER32, DataDirectory) ||
+		    opt->AddressOfEntryPoint >= virt_size) {
+			log_err("Invalid 32-bit optional header\n");
+			ret = EFI_LOAD_ERROR;
+			goto err;
+		}
 		image_base = opt->ImageBase;
 		efi_set_code_and_data_type(loaded_image_info, opt->Subsystem);
 		handle->image_type = opt->Subsystem;
@@ -986,8 +1049,31 @@ efi_status_t efi_load_pe(struct
efi_loaded_image_obj *handle,
 			goto err;
 		}
 		handle->entry = efi_reloc + opt->AddressOfEntryPoint;
-		rel_size = opt->DataDirectory[rel_idx].Size;
-		rel = efi_reloc + opt->DataDirectory[rel_idx].VirtualAddress;
+		if (opt->NumberOfRvaAndSizes > (u32)rel_idx) {
+			if (opt_size < offsetof(IMAGE_OPTIONAL_HEADER32,
+						DataDirectory[rel_idx + 1])) {
+				efi_free_pages((uintptr_t)efi_reloc,
+					       (virt_size + EFI_PAGE_MASK) >>
+					       EFI_PAGE_SHIFT);
+				ret = EFI_LOAD_ERROR;
+				goto err;
+			}
+			rel_size = opt->DataDirectory[rel_idx].Size;
+			if (rel_size &&
+			    ((u64)opt->DataDirectory[rel_idx].VirtualAddress +
+			     rel_size > virt_size)) {
+				efi_free_pages((uintptr_t)efi_reloc,
+					       (virt_size + EFI_PAGE_MASK) >>
+					       EFI_PAGE_SHIFT);
+				ret = EFI_LOAD_ERROR;
+				goto err;
+			}
+			rel = efi_reloc +
+			      opt->DataDirectory[rel_idx].VirtualAddress;
+		} else {
+			rel_size = 0;
+			rel = NULL;
+		}
 	} else {
 		log_err("Invalid optional header magic %x\n",
 			nt->OptionalHeader.Magic);
@@ -1010,11 +1096,7 @@ efi_status_t efi_load_pe(struct
efi_loaded_image_obj *handle,
 #endif

 	/* Copy PE headers */
-	memcpy(efi_reloc, efi,
-	       sizeof(*dos)
-		 + sizeof(*nt)
-		 + nt->FileHeader.SizeOfOptionalHeader
-		 + num_sections * sizeof(IMAGE_SECTION_HEADER));
+	memcpy(efi_reloc, efi, headers_size);

 	/* Load sections into RAM */
 	for (i = num_sections - 1; i >= 0; i--) {
@@ -1026,9 +1108,10 @@ efi_status_t efi_load_pe(struct
efi_loaded_image_obj *handle,
 			memset(efi_reloc + sec->VirtualAddress, 0,
 			       sec->Misc.VirtualSize);
 		}
-		memcpy(efi_reloc + sec->VirtualAddress,
-		       efi + sec->PointerToRawData,
-		       copy_size);
+		if (copy_size)
+			memcpy(efi_reloc + sec->VirtualAddress,
+			       efi + sec->PointerToRawData,
+			       copy_size);
 	}

 	/* Run through relocations */
-- 
2.56.0.611.g1030f0b940-goog
