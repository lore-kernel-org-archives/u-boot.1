Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80165606D814
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uFLZAbjx;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WIqggrJZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DEBA60D72;
	Fri,  6 Nov 2026 21:57:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p48ieQy8409Q; Fri,  6 Nov 2026 21:57:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CDD1F60ABC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794002248;
	b=Vm5jqq/eZz4aeGYewtBS+1QTndgZugXYT2xWL+FoKntMh2pRIkAtKbApfRFzUveRlLgs
	 jmJWtC/zMpVgaKUys1XYKVw/xIm38wskXL/xFld2V/vekHD3G40YcwtDd4ipTaf1DHQ+0
	 4WOB5gH/QFc5sRBMgQTU7HosWmLTCt5AAucJFmrea9gfmUJRA1dhrcCq4bPCW6e2Cel9G
	 K4tMjSXgmSWagHkKP9A+48KMKNBgFAhddyFp3NBEk0T6j2x7QCw9IIGHngdNDV+hRb/Ga
	 mp5CyZSWhG+3KxIQi83Lspj2ogDViSvovCeMAlU13taGz6ADJmB/r8KPzqEVIL4nrwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002248;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=HsfMwLhlb1hu+zNa2Rg3xor3yrSapCd4MXxJ3mOyRMI=;
	b=GZrhMOQPn3pboRF9z53m1cMfykRFjFROdbMl/+nUKVawn5I/pJHYujt5i4f3vGBUJR6b
	 JOhxOsWD/6YiBp1K5+gf0y6M+AEQQS5+Z5aTJQjmilLQGHsTDxlw76WmBQp14d249DAux
	 EyBsyDit4LY9Rv0WEkteITVHKiUeHTe1OfnqmJfQVOj9rIIr/NTklJg5ZQkf1GsRIJSQ4
	 3lzRylAE8+O6AvzkOKGKyN+lahCs5G2tHWU87RV7dHy1gGCs9wCriW0goNcaCNV/8/eqP
	 I9HlTLXYFRuj7heotf0Y8lmUXxntTmKJGG1IevIiuI60UHLuigjPurgLaj1nDI/X/uA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794002248;
	bh=HsfMwLhlb1hu+zNa2Rg3xor3yrSapCd4MXxJ3mOyRMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uFLZAbjxuVIfVqHGIq5baDMpT6tg3xAAf64lZTJhuXGqO4Z9ZY7cJBa6gwqdMCcNf
	 nQVHA5hCz56cRmWBrSQ/Y5fJG9+jZxXGacSwW3hd8YOFNf31l6+JVFRRRajwjXfZPn
	 UaXz7FRJ3UGOJIGVuyFSEmbZVXTKyBhPc54SV48AJN1aZyGumrczonHOUwftfKVJ4N
	 wvfs4WTBHoH2Uo4G4Jqf96In6o83GZY4kyzdMqyntXzoZZublGpb+NzVdg7G92W3kw
	 6hZnGKNKkBiHQufe7eBkfKpe8LVm5ECx7PAmLLkCf3lEmnh3AxWcOtg5kqURzfxkGj
	 C6Fakj9EHZOBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDD1F60ABC;
	Fri,  6 Nov 2026 21:57:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 166541C6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06CFB80F5D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d8ZJZDUuml6m for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:57:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E49880F81
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=WIqggrJZ
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E49880F81
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:24 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-49376eb635fso445159f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794002243; x=1794607043;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HsfMwLhlb1hu+zNa2Rg3xor3yrSapCd4MXxJ3mOyRMI=;
 b=WIqggrJZEH14C3kXjmsZuW1kA2JHDfwBf+MpKqCk2njagPx72wQuZe0Plk1/8Fi78E
 iqyTWCmpACVpgIF36jItUgYSYHABfRNu9PnAmpmZonckn1PYsJGUm2AjuqZZH5CDGXzy
 qghtSFkfGfPIm9QZxgGLcr3ba1YXwO1/GD1tQtXE6mK6PM8McxqPvmzYb82Vy2SGF3ED
 I+ruy147v3DMwlC4Ei7ETPGNp/uk1nilC7jN/RxBVCl4lPGbIHE1YdYneA+QIikBBirV
 rUYaJcEB9KnidBCJIAt/XlH7xIaHSd8BMyPCrNRkOWYv2dJ9zJqxGLon6Uu1GzS3WvBQ
 +9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002243; x=1794607043;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HsfMwLhlb1hu+zNa2Rg3xor3yrSapCd4MXxJ3mOyRMI=;
 b=oZW3HgDpW1KUGPTudZyKKtitETJO7u/B92jD/YkI8WFYXnNN8hXYA+WK2AfUTKkwAa
 m3ikdU4z3irL0LghZ+RVdbw8SyiET1KCL1AcDKa0ATu2RBKcepmjEjuytm7OZt9OJsc1
 2dOq30stMk6Cb08lD55wczEtyCzhZILCrozktYqZdVAZHN2semXqzeNmr3UrdOnasOy3
 2R0CMea850AjnvpyslPWd2bodPu7TSgh72iA9nlBnk5CU9nXdkZHDuqrz/djR9Qdcpve
 jX+NpLaowjVhxMkKpX9jvHaLUyn+RUD5J9GqmQGbbCIXI2jcaY8mXYGgVgNXf/OjP4k5
 /G/A==
X-Gm-Message-State: APuU4Z+Iqc9LTqZeUyJsSVsrXj5/F+1F2387R3Gv7+Hv4EYXYl2pns3v
 HcGnX0cV613UsqvGdbIKziVZ6/ASRQtoQE9WG4U+uJGo/zq4eUP91uWzlVTapIIiz5U=
X-Gm-Gg: AYBFou00xCMja80eQcphGcdyfnuvmMsmk1GjX6sFmYN109C4OJXS6FotyCiwUOXzZW8
 WLJv5J1/zY9MoWNhHUUUT+i4rkqUSSM/DqVi3r2f+TAEPkSudHQLhyNDy3a3qmNpUr9akaAra64
 IlYos6P2pAAQb3o4mY2wk3IqjX4KngjfjABnlm0wftb/Qg1/Hl1fnQ6Jlyag9R/pg3QGIzdN91O
 HHdb+V0v3M3k5PSJWG/zqBSWF0QkwSP8De6Fhq8Lzl/AGhx4Y3LCXKFlLZwW/x5nspYZUR6eIZQ
 diIM9AspODIR7lQnKVt/7JKdI/G2/X8kbOTHSrlm3l18XdVAUIinHOd3OWvR3VFJnoaw0Mv/7u4
 1kWdXsxqxMHtlpBn7rb/kHz9N+gwyiP7mEdchqs5LXHL/rgxfqJ95hwQ/ueI/rkBPZGAOoiXGiq
 qyD/aiBVuGBUA2Nsh/4sp/vUyTR7XL69nYWlzQK4fohExwE6zHlNTfXvl74Ap6/+ZaTQJnmovKo
 Pwdf/rO+GJpHw8V86R7olhrJXfskQh4qyYF7chfHJUaNwZMM3bOaSBR+jJamWT+wko6xKFYMPi8
 OlgPFEl69N0QE28rhC4lmD+Qb7Ezr6k=
X-Received: by 2002:a05:6000:22c1:b0:48d:f3ee:7cc with SMTP id
 ffacd0b85a97d-4927669881emr8397346f8f.30.1794002242740; 
 Fri, 06 Nov 2026 13:57:22 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4932901d9c9sm4854997f8f.59.2026.11.06.13.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 13:57:22 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 10/11] test: lib: add tests for the PE image checks
Date: Fri, 06 Nov 2026 21:57:20 +0000
Message-ID: <608bd6ca-5dec-4f2e-a17a-83bfd3608261@gmail.com>
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

Add unit tests that pass malformed PE images to efi_check_pe(),
LoadImage() and efi_image_parse() and check that they are rejected:

- an image ending after a 32bit NT header;
- a section whose end wraps around 4 GiB;
- a section whose raw data runs past the end of the image, also when
  its VirtualSize is smaller;
- a relocation table past the end of the image;
- an image whose subsystem is not a UEFI image type;
- an image that cannot be measured, when TCG2 is installed, which may
  be loaded but must not be started;
- headers, an optional header, a section or a certificate table that do
  not fit, an optional header that holds fewer data directories than it
  declares or more than 16, a file alignment that is not a power of two,
  and sections sharing their raw data.

Check that PE32 and PE32+ images with 16, 6 or 5 data directories, an
empty section, a last section that is not padded, a file alignment of 0
and trailing data of an odd size still load and parse, and that the
loaded image holds all of the headers when they are longer than the
sections.

Each image is built at the start of a larger zeroed buffer, so that
without the checks most tests read the bytes after it and get a wrong
status instead of faulting. Without the checks the tests of the wrapped
section and of the relocation table far past the image crash, and the
test of the headers writes past the loaded image.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 test/lib/Makefile           |   2 +-
 test/lib/efi_image_loader.c | 501 ++++++++++++++++++++++++++++++++++++
 2 files changed, 502 insertions(+), 1 deletion(-)

diff --git a/test/lib/Makefile b/test/lib/Makefile
index 9fc4a1a9b5d..a67e53ca9c5 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -9,7 +9,7 @@ ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += abuf.o
 obj-y += alist.o
 obj-$(CONFIG_ECDSA_VERIFY_MBEDTLS) += ecdsa.o
-obj-$(CONFIG_EFI_LOADER) += efi_device_path.o efi_memory.o
+obj-$(CONFIG_EFI_LOADER) += efi_device_path.o efi_image_loader.o efi_memory.o
 obj-$(CONFIG_EFI_SECURE_BOOT) += efi_image_region.o
 ifdef CONFIG_RISCV
 obj-$(CONFIG_USE_PRIVATE_LIBGCC) += test_clz.o
diff --git a/test/lib/efi_image_loader.c b/test/lib/efi_image_loader.c
new file mode 100644
index 00000000000..8b4fff4a6f9
--- /dev/null
+++ b/test/lib/efi_image_loader.c
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test the checks of the PE image loader
+ *
+ * Copyright (c) 2026 Ana Bobillo <anabobillo3@gmail.com>
+ */
+
+#include <efi_loader.h>
+#include <pe.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+#if defined(__aarch64__)
+#define TEST_MACHINE	IMAGE_FILE_MACHINE_ARM64
+#elif defined(__arm__)
+#define TEST_MACHINE	IMAGE_FILE_MACHINE_THUMB
+#elif defined(__x86_64__)
+#define TEST_MACHINE	IMAGE_FILE_MACHINE_AMD64
+#elif defined(__i386__)
+#define TEST_MACHINE	IMAGE_FILE_MACHINE_I386
+#elif defined(__riscv) && (__riscv_xlen == 64)
+#define TEST_MACHINE	IMAGE_FILE_MACHINE_RISCV64
+#elif defined(__riscv) && (__riscv_xlen == 32)
+#define TEST_MACHINE	IMAGE_FILE_MACHINE_RISCV32
+#else
+/* The loader supports no other machine: skip the tests that load images */
+#define TEST_MACHINE	0
+#endif
+
+#define TEST_FILE_ALIGN		0x200
+#define TEST_SECTION_ALIGN	0x1000
+/* Size of a valid image: headers and one section, each TEST_FILE_ALIGN */
+#define TEST_IMAGE_SIZE		(2 * TEST_FILE_ALIGN)
+
+/**
+ * struct test_image - a PE image at the start of buf
+ *
+ * @dos:	DOS header
+ * @nt:		NT headers, of a PE32 or a PE32+ image
+ * @opt32:	optional header of a PE32 image, else NULL
+ * @opt64:	optional header of a PE32+ image, else NULL
+ * @dirs:	data directories
+ * @sections:	section table
+ */
+struct test_image {
+	IMAGE_DOS_HEADER *dos;
+	IMAGE_NT_HEADERS32 *nt;
+	IMAGE_OPTIONAL_HEADER32 *opt32;
+	IMAGE_OPTIONAL_HEADER64 *opt64;
+	IMAGE_DATA_DIRECTORY *dirs;
+	IMAGE_SECTION_HEADER *sections;
+};
+
+/* Set a field of the optional header of a PE32 or a PE32+ image */
+#define opt_set(img, field, val)			\
+	do {						\
+		if ((img)->opt64)			\
+			(img)->opt64->field = (val);	\
+		else					\
+			(img)->opt32->field = (val);	\
+	} while (0)
+
+/*
+ * Images are built at the start of this buffer, which is larger than any of
+ * them. The bytes after an image are zero, so that they can be read without
+ * a fault if a size check is missing.
+ */
+static u8 buf[0x4000] __aligned(8);
+
+/**
+ * test_image_init() - set up a valid image at the start of buf
+ *
+ * The image is TEST_IMAGE_SIZE bytes long: the headers, padded to the file
+ * alignment, and one section of TEST_FILE_ALIGN bytes. Further sections are
+ * empty.
+ *
+ * @img:		image to set up
+ * @pe32plus:		true for a PE32+ image, false for a PE32 image
+ * @num_dirs:		number of data directories
+ * @num_sections:	number of section headers
+ */
+static void test_image_init(struct test_image *img, bool pe32plus,
+			    u32 num_dirs, int num_sections)
+{
+	size_t opt_size;
+
+	memset(buf, 0, sizeof(buf));
+	memset(img, 0, sizeof(*img));
+
+	img->dos = (void *)buf;
+	img->dos->e_magic = IMAGE_DOS_SIGNATURE;
+	img->dos->e_lfanew = sizeof(*img->dos);
+
+	img->nt = (void *)buf + img->dos->e_lfanew;
+	img->nt->Signature = IMAGE_NT_SIGNATURE;
+	img->nt->FileHeader.Machine = TEST_MACHINE;
+	img->nt->FileHeader.NumberOfSections = num_sections;
+
+	if (pe32plus) {
+		img->opt64 = (void *)&img->nt->OptionalHeader;
+		img->opt64->Magic = IMAGE_NT_OPTIONAL_HDR64_MAGIC;
+		img->dirs = img->opt64->DataDirectory;
+		opt_size = offsetof(IMAGE_OPTIONAL_HEADER64, DataDirectory);
+	} else {
+		img->opt32 = &img->nt->OptionalHeader;
+		img->opt32->Magic = IMAGE_NT_OPTIONAL_HDR32_MAGIC;
+		img->dirs = img->opt32->DataDirectory;
+		opt_size = offsetof(IMAGE_OPTIONAL_HEADER32, DataDirectory);
+	}
+	opt_size += num_dirs * sizeof(IMAGE_DATA_DIRECTORY);
+	img->nt->FileHeader.SizeOfOptionalHeader = opt_size;
+	img->sections = (void *)&img->nt->OptionalHeader + opt_size;
+
+	opt_set(img, AddressOfEntryPoint, TEST_SECTION_ALIGN);
+	opt_set(img, SectionAlignment, TEST_SECTION_ALIGN);
+	opt_set(img, FileAlignment, TEST_FILE_ALIGN);
+	opt_set(img, SizeOfImage, 2 * TEST_SECTION_ALIGN);
+	opt_set(img, SizeOfHeaders, TEST_FILE_ALIGN);
+	opt_set(img, Subsystem, IMAGE_SUBSYSTEM_EFI_APPLICATION);
+	opt_set(img, NumberOfRvaAndSizes, num_dirs);
+
+	memcpy(img->sections[0].Name, ".text", 5);
+	img->sections[0].Misc.VirtualSize = TEST_FILE_ALIGN;
+	img->sections[0].VirtualAddress = TEST_SECTION_ALIGN;
+	img->sections[0].SizeOfRawData = TEST_FILE_ALIGN;
+	img->sections[0].PointerToRawData = TEST_FILE_ALIGN;
+}
+
+/**
+ * load_image() - pass an image at the start of buf to LoadImage()
+ *
+ * If the image is loaded, unload it again.
+ *
+ * @size:	size of the image
+ * Return:	status code of LoadImage()
+ */
+static efi_status_t load_image(size_t size)
+{
+	efi_handle_t handle = NULL;
+	efi_status_t ret;
+
+	ret = EFI_CALL(efi_load_image(false, efi_root, NULL, buf, size,
+				      &handle));
+	if (handle)
+		EFI_CALL(efi_unload_image(handle));
+
+	return ret;
+}
+
+/**
+ * parse_image() - pass an image at the start of buf to efi_image_parse()
+ *
+ * @size:	size of the image
+ * Return:	result of efi_image_parse()
+ */
+static bool parse_image(size_t size)
+{
+	struct efi_image_regions *regs = NULL;
+	WIN_CERTIFICATE *auth = NULL;
+	size_t auth_len = 0;
+	bool ret;
+
+	ret = efi_image_parse(buf, size, &regs, &auth, &auth_len);
+	free(regs);
+
+	return ret;
+}
+
+/* The checks must let valid images through */
+static int lib_test_efi_image_valid(struct unit_test_state *uts)
+{
+	static const u32 num_dirs[] = { IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 6 };
+	struct test_image img;
+	int i, j;
+
+	if (!TEST_MACHINE)
+		return -EAGAIN;
+
+	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
+
+	for (i = 0; i < 2; i++) {
+		for (j = 0; j < ARRAY_SIZE(num_dirs); j++) {
+			test_image_init(&img, i, num_dirs[j], 1);
+			ut_asserteq(true, parse_image(TEST_IMAGE_SIZE));
+			ut_asserteq_64(EFI_SUCCESS, load_image(TEST_IMAGE_SIZE));
+		}
+	}
+
+	/* An empty section, and trailing data of an odd size */
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 2);
+	memcpy(img.sections[1].Name, ".bss", 4);
+	img.sections[1].Misc.VirtualSize = TEST_FILE_ALIGN;
+	img.sections[1].VirtualAddress = 2 * TEST_SECTION_ALIGN;
+	opt_set(&img, SizeOfImage, 3 * TEST_SECTION_ALIGN);
+	ut_asserteq(true, parse_image(TEST_IMAGE_SIZE + 3));
+	ut_asserteq_64(EFI_SUCCESS, load_image(TEST_IMAGE_SIZE + 3));
+
+	/* An image with five data directories has no relocation table */
+	test_image_init(&img, true, 5, 1);
+	ut_asserteq(true, parse_image(TEST_IMAGE_SIZE));
+	ut_asserteq_64(EFI_SUCCESS, load_image(TEST_IMAGE_SIZE));
+
+	/* The last section is not padded to the file alignment */
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	img.sections[0].SizeOfRawData = TEST_FILE_ALIGN / 2;
+	ut_asserteq(true, parse_image(TEST_IMAGE_SIZE - TEST_FILE_ALIGN / 2));
+	ut_asserteq_64(EFI_SUCCESS,
+		       load_image(TEST_IMAGE_SIZE - TEST_FILE_ALIGN / 2));
+
+	/* A file alignment of 0 stands for the default of 512 */
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	opt_set(&img, FileAlignment, 0);
+	ut_asserteq(true, parse_image(TEST_IMAGE_SIZE));
+	ut_asserteq_64(EFI_SUCCESS, load_image(TEST_IMAGE_SIZE));
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_image_valid, 0);
+
+/* efi_check_pe() must check that the image holds a 64bit NT header */
+static int lib_test_efi_check_pe_nt_header(struct unit_test_state *uts)
+{
+	struct test_image img;
+	size_t size;
+
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	ut_asserteq_64(EFI_SUCCESS, efi_check_pe(buf, TEST_IMAGE_SIZE, NULL));
+
+	/* The image ends after a 32bit NT header */
+	size = img.dos->e_lfanew + sizeof(IMAGE_NT_HEADERS32);
+	ut_asserteq_64(EFI_INVALID_PARAMETER, efi_check_pe(buf, size, NULL));
+
+	/* The NT header offset lies past the end (wraps on 32bit hosts) */
+	img.dos->e_lfanew = 0xfffffff0;
+	ut_asserteq_64(EFI_INVALID_PARAMETER,
+		       efi_check_pe(buf, TEST_IMAGE_SIZE, NULL));
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_check_pe_nt_header, 0);
+
+/* efi_load_pe() must reject a section ending past 4 GiB */
+static int lib_test_efi_load_pe_section_wrap(struct unit_test_state *uts)
+{
+	struct test_image img;
+
+	if (!TEST_MACHINE)
+		return -EAGAIN;
+
+	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
+
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	/* VirtualAddress + VirtualSize wraps around to TEST_SECTION_ALIGN */
+	img.sections[0].VirtualAddress = 0xfffff000;
+	img.sections[0].Misc.VirtualSize = 0x2000;
+	ut_asserteq_64(EFI_LOAD_ERROR, load_image(TEST_IMAGE_SIZE));
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_load_pe_section_wrap, 0);
+
+/* efi_load_pe() must check the raw data of a section against the image */
+static int lib_test_efi_load_pe_section_raw(struct unit_test_state *uts)
+{
+	struct test_image img;
+
+	if (!TEST_MACHINE)
+		return -EAGAIN;
+
+	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
+
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	/* The raw data of the section runs past the end of the image */
+	img.sections[0].SizeOfRawData = 2 * TEST_FILE_ALIGN;
+	img.sections[0].Misc.VirtualSize = 2 * TEST_FILE_ALIGN;
+	ut_asserteq_64(EFI_LOAD_ERROR, load_image(TEST_IMAGE_SIZE));
+
+	/* Only the part copied for the smaller VirtualSize lies within it */
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	img.sections[0].SizeOfRawData = 2 * TEST_FILE_ALIGN;
+	ut_asserteq_64(EFI_LOAD_ERROR, load_image(TEST_IMAGE_SIZE));
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_load_pe_section_raw, 0);
+
+/* efi_load_pe() must make room for the headers in the loaded image */
+static int lib_test_efi_load_pe_headers(struct unit_test_state *uts)
+{
+	struct efi_loaded_image *info;
+	struct efi_handler *handler;
+	efi_handle_t handle = NULL;
+	struct test_image img;
+	int num_sections, i;
+	size_t table_end, hdr_size, size;
+
+	if (!TEST_MACHINE)
+		return -EAGAIN;
+
+	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
+
+	/*
+	 * Enough empty sections for the section table to end past the first
+	 * page, while the only section with data is TEST_FILE_ALIGN bytes
+	 * long at virtual address 0: the sections alone fit into one page.
+	 */
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	num_sections = (EFI_PAGE_SIZE - ((void *)img.sections - (void *)buf)) /
+		       sizeof(IMAGE_SECTION_HEADER) + 2;
+	table_end = (void *)&img.sections[num_sections] - (void *)buf;
+	hdr_size = ALIGN(table_end, TEST_FILE_ALIGN);
+	size = hdr_size + TEST_FILE_ALIGN;
+	ut_assert(size <= sizeof(buf));
+
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES,
+			num_sections);
+	opt_set(&img, SizeOfHeaders, hdr_size);
+	opt_set(&img, AddressOfEntryPoint, 0);
+	img.sections[0].VirtualAddress = 0;
+	img.sections[0].PointerToRawData = hdr_size;
+	for (i = 1; i < num_sections; i++)
+		memcpy(img.sections[i].Name, ".bss", 4);
+
+	ut_asserteq_64(EFI_SUCCESS,
+		       EFI_CALL(efi_load_image(false, efi_root, NULL, buf, size,
+					       &handle)));
+	ut_asserteq_64(EFI_SUCCESS, efi_search_protocol(handle,
+							&efi_guid_loaded_image,
+							&handler));
+	info = handler->protocol_interface;
+	ut_assert(info->image_size >= table_end);
+	/* The section at virtual address 0 overwrites the first bytes */
+	ut_asserteq_mem(buf + TEST_FILE_ALIGN,
+			info->image_base + TEST_FILE_ALIGN,
+			table_end - TEST_FILE_ALIGN);
+	ut_asserteq_64(EFI_SUCCESS, EFI_CALL(efi_unload_image(handle)));
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_load_pe_headers, 0);
+
+/* efi_loader_relocate() must check the relocation table against the image */
+static int lib_test_efi_load_pe_reloc_table(struct unit_test_state *uts)
+{
+	struct test_image img;
+	IMAGE_DATA_DIRECTORY *dir;
+
+	if (!TEST_MACHINE)
+		return -EAGAIN;
+
+	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
+
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	dir = &img.dirs[IMAGE_DIRECTORY_ENTRY_BASERELOC];
+	/* The relocation table starts in the section and ends past it */
+	dir->VirtualAddress = TEST_SECTION_ALIGN;
+	dir->Size = TEST_SECTION_ALIGN;
+	ut_asserteq_64(EFI_LOAD_ERROR, load_image(TEST_IMAGE_SIZE));
+
+	/* The relocation table lies far past the end of the image */
+	dir->VirtualAddress = 0xfffff000;
+	dir->Size = sizeof(IMAGE_BASE_RELOCATION);
+	ut_asserteq_64(EFI_LOAD_ERROR, load_image(TEST_IMAGE_SIZE));
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_load_pe_reloc_table, 0);
+
+/* efi_load_pe() must refuse an image whose subsystem is no UEFI image type */
+static int lib_test_efi_load_pe_subsystem(struct unit_test_state *uts)
+{
+	static const u16 subsystems[] = { 0, 3, IMAGE_SUBSYSTEM_EFI_ROM };
+	struct test_image img;
+	int i, j;
+
+	if (!TEST_MACHINE)
+		return -EAGAIN;
+
+	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
+
+	for (i = 0; i < 2; i++) {
+		for (j = 0; j < ARRAY_SIZE(subsystems); j++) {
+			test_image_init(&img, i,
+					IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+			opt_set(&img, Subsystem, subsystems[j]);
+			ut_asserteq_64(EFI_UNSUPPORTED,
+				       load_image(TEST_IMAGE_SIZE));
+		}
+	}
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_load_pe_subsystem, 0);
+
+/* efi_load_pe() must not let an image that cannot be measured start */
+static int lib_test_efi_load_pe_measure(struct unit_test_state *uts)
+{
+	const efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
+	struct efi_handler *handler;
+	struct test_image img;
+
+	if (!TEST_MACHINE)
+		return -EAGAIN;
+
+	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
+	if (efi_search_protocol(efi_root, &tcg2_guid, &handler) != EFI_SUCCESS)
+		return -EAGAIN;
+
+	/*
+	 * LoadImage() takes a file alignment that is not a power of two, but
+	 * the image cannot be hashed for its measurement: it must be marked
+	 * as not authenticated, so that StartImage() refuses it.
+	 */
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	opt_set(&img, FileAlignment, 3 * TEST_FILE_ALIGN / 2);
+	ut_asserteq_64(EFI_SECURITY_VIOLATION, load_image(TEST_IMAGE_SIZE));
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_load_pe_measure, 0);
+
+/* efi_image_parse() must check the PE headers against the image */
+static int lib_test_efi_image_parse_headers(struct unit_test_state *uts)
+{
+	struct test_image img;
+
+	/* The headers run past the end of the image */
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	opt_set(&img, SizeOfHeaders, 2 * TEST_IMAGE_SIZE);
+	ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
+
+	/* The optional header is shorter than its fixed fields */
+	test_image_init(&img, true, 0, 1);
+	img.nt->FileHeader.SizeOfOptionalHeader = 0x40;
+	ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
+
+	/*
+	 * The optional header holds fewer data directories than it declares:
+	 * the certificate table entry would be read from the section table,
+	 * so clear the section name read as the entry.
+	 */
+	test_image_init(&img, false, IMAGE_DIRECTORY_ENTRY_SECURITY, 1);
+	opt_set(&img, NumberOfRvaAndSizes, IMAGE_NUMBEROF_DIRECTORY_ENTRIES);
+	memset(img.sections[0].Name, 0, sizeof(img.sections[0].Name));
+	ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
+
+	/* The optional header holds more than 16 data directories */
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES + 1, 1);
+	ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_image_parse_headers, 0);
+
+/* efi_image_parse() must check each section against the image */
+static int lib_test_efi_image_parse_section(struct unit_test_state *uts)
+{
+	struct test_image img;
+
+	/* The raw data of the section runs past the end of the image */
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	img.sections[0].SizeOfRawData = 2 * TEST_FILE_ALIGN;
+	ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
+
+	/* The raw data of the section starts past the end of the image */
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	img.sections[0].PointerToRawData = 0xfffffe00;
+	ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
+
+	/* The file alignment is not a power of two */
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	opt_set(&img, FileAlignment, 3 * TEST_FILE_ALIGN / 2);
+	ut_asserteq(false, parse_image(2 * TEST_IMAGE_SIZE));
+
+	/* Two sections share their raw data */
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 2);
+	img.sections[1] = img.sections[0];
+	img.sections[1].VirtualAddress = 2 * TEST_SECTION_ALIGN;
+	ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_image_parse_section, 0);
+
+/* efi_image_parse() must check the certificate table against the image */
+static int lib_test_efi_image_parse_cert_table(struct unit_test_state *uts)
+{
+	struct test_image img;
+	IMAGE_DATA_DIRECTORY *dir;
+
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	dir = &img.dirs[IMAGE_DIRECTORY_ENTRY_SECURITY];
+	/* The end of the certificate table wraps around to 0x10 */
+	dir->VirtualAddress = 0xfffffff0;
+	dir->Size = 0x20;
+	ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_image_parse_cert_table, 0);
