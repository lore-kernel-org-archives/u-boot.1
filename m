Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA974606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f47EmOSR;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CNroE0rE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A570460AD5;
	Fri, 30 Oct 2026 06:14:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZdSTf79FEmJQ; Fri, 30 Oct 2026 06:14:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0554160AA4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793340875;
	b=RTGNXTve1WlgCjp52v+fWQQmKt1M3PVVIUnxHcN5zr8odxCzQ/97tia0NVIPIPJrRWS0
	 BLYso+bIM1Ikz7u8EywP5wna9yA4toRh9rGvIyxSryfG0FeAO7oqQNSjMaEJcgp9emv+F
	 M8ta74kxrgVLsloQpt2sdDe3T9XcV1t3h/ytw2weGcPootqc1J+uqMvAniQZVIYxR3732
	 CaVn/C8ciUfPSMKOxaq0AbXrMYjGsED4LyNBeouiz7+gakp6FFmB4I7VSR3swedlSd99K
	 84K0TUWGyfGuymTCWaJASx32/WRbDjI3FEdCHG4Fq7HneYJiMG4sTKf4G3ZAANUr2CA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793340875;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=mgr5kKUQJ757XkvSyNuANuO1XoON0NsUu1WJAcW9UF0=;
	b=YHsI6i+42rfPxFt52wJAzEPaQ0fJMF1zbVhBbBuOBv5EYfX5d9zJfFyGTDpVqVbc24Y8
	 VV1iQ+s4QtywUoPk1oI8cuEGOI0kHytwbkbuw7TCtdAaftsQohi7yo2CuJcX/h1usKd7L
	 dkNHjAHNkrXo816SYvVRkNNM+i0dPxOtyb/kmHol87fggdLufaTMK4oSpPS3Jh6N5o8rL
	 HPBwaCpJ8p7Y/WKAfvESiMaoZkxm3ySmqFihEAOtrEHocwoviNo2LWic2ph444gwh3YyU
	 xu5jlbRXflUGiK/H3yaLYbIva1GrN0Av+sSWK+snTXd1pX5Z/+HGhYyTInwc1mCTCGg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793340875;
	bh=mgr5kKUQJ757XkvSyNuANuO1XoON0NsUu1WJAcW9UF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f47EmOSRi/9bTsZQfkh5LoKtHhBwgHky8b33BlwavQ7KRAJsFuVbad/S3E6ZRn/rx
	 FcgG3W3LisQTKXKw4UjOwgf3ops6Q893VASfNzBdkTbNowzyM0LEiNeCzHoR2gX60q
	 fdQgH6KsRV6CokiIQPLj01nw1d18VLf24YRjHhwU/VBCYo1auPSCtRrps6cA50kk+d
	 XCeGKC50yGZZXw0Y7nwvD37WP7MpmE8O+q/8jPsqM3NLMXjD5U5/D1kzqh5vHTPWws
	 oblsnD1xGWiR/AIR2iA9mOdrpYsmIpWsAvJXsA4y/ufKs68a8Kjs2ALcwdlnvKhxi+
	 NgPWA+zIMqb7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0554160AA4;
	Fri, 30 Oct 2026 06:14:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F335D43
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70F24810C2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QdouwU9yfgKz for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:14:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E914680D3E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793340872;
 b=J/PXonxe/6+SnrT3nsm7v5VFvMhDUp++FDZsBQ4dkxKxV6kvIGqsLaBZepxzlsf/qHXJ
 gEmrKXuchhBzDeXiFkAhEqUnDm1OlLgbGUfWByiaVJty2/VxIuIb1pb3MAT1X4Zx+dxe6
 fd+bRheBLa5jQiC9/QFH0gnGojxTPzlOExDIhWg+6kgb1h/5aEBtzOPaS9KpQtNmut2id
 2gA6/hnTrhYoT4CCSNWpMBF6NL+XAv2nHm2BBaE3LZjTUKT9k/MvzNybvlMyNwi9IU61w
 UrAACVRCovRy/flxcge0+kmd4VZNodIxx0ZAlO3wRlSDTFMon9487my82fT/+Yi+c9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793340872;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=mgr5kKUQJ757XkvSyNuANuO1XoON0NsUu1WJAcW9UF0=;
 b=Yu28STY/ez5uTIsIZToYGWzcyTb064uqAYEOrOqlCfb6LHXgwaDh8TdJ1QTFR5FraNEf
 gQ3cx5rR04L1+rjHLtQJCFYqq46k2gV44P+4YYTaBgCNo1g7n0U7XiWpwwb5/xQX11Ypu
 bL44wnSZm5piyCqtunYe1LJ9C4p2JXs/KdmEh0DKQ5QHn4bhpVTwZnYbBcRTKfiwj7XzV
 zTeuGiRGxdTrhawvElwQN6oxLHFPSaDbzqWAbUJ8Lfau12Ju5vRyt72TC1LFDaSO29FJ9
 8Ylua3hv/pvvS6iP3oC2nlW6VMMioPR+KVwT2SQ9pZSZnT2KapJc1cRRoTA4gPkBuLg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=CNroE0rE; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=CNroE0rE
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E914680D3E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:31 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so256546f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793340870; x=1793945670;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mgr5kKUQJ757XkvSyNuANuO1XoON0NsUu1WJAcW9UF0=;
 b=CNroE0rEVULLsKtrchunXwU+qZXhbbPYcyGfCubWnjdPxD05wZucyOQx0eqqUSK09C
 F98ZpnVpPDYYCyfXfJihR5Es/7f4cMR3jBki9XygyhCkOodXmpPCksg37ZmICGNdwRYc
 7Sljg5BHAwwTb4EBoNcZ034kTczjbmB24ITmYXLKaeUGFGZvdl9/3Oe1z6+hW/BHpBe9
 jD33+vh0hHlsLA2B+Oetz2vVa75b3Go73xa66VWAOXwDQv0EiJ1eM8MdQw2zPU0RaTZ3
 581IPHGOV9WLKYyG4OASsgilyRThEkQec/NBEEpjvADAmkpLyCkqr2/M0D+ZN2DjSRnc
 6CQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793340870; x=1793945670;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mgr5kKUQJ757XkvSyNuANuO1XoON0NsUu1WJAcW9UF0=;
 b=DxD7uBM1/K2YrK5MJJqqzkJUzfKEVJy732wuRdYPfX9ps/XcX1Vbk9JhvxCADe5xwg
 e+SXOwvqwILDbiDrRGI6Vs/5XdGOlJ7m90LKVSY1xt8cen7FfS61tRRchLAlKTbtv2O5
 45tAojgK91MojZMDdHLvXAz9t7wtijbp5mb+t20Y5l8zncEXWKjFPLNQwKaZcP5zsN7b
 I1ZORDIskejg2jhmGO1haZHwi5HYETIrUxjCnXq77AOgqoZApGH7UNjVGirVr8b8dPay
 7o264+/YZBAvW1sM3FEPcTu7Ck+NO8PbeIrnXEGjKFCR/SEvuf9bWoQz3hFMD6bgDLTJ
 zSBQ==
X-Gm-Message-State: AFq9FYJNOQzzN/ZCepbAHY0QFNZqETjnC/4v/XZYmGYEhZmVw5367JO9
 FIvZCmdxwLLqiqMYFDTjnf2lP1oGYkoRRm4jumPUPGQv53JTaMs7yGqrD0lAgQvnX3o=
X-Gm-Gg: AYBFou0eGm7k54BF3Mjdy+KvLLgcUz011Ob++vdlCKYGt68DavX/l1bpV+j3kDr43T/
 ce7j2p5TsU2xqLSlc33A9ErZNUXp9KHaIdw4iQxZDBSrV+rIAIludUGRRv+F0T1h8bk5E7UU7PR
 pXF0SmVX1w9si/tBJ1sJ+yUP6sx6Vp40oxnjBsEYw3d9bwLflQGz7YSJjwtlPjs++rwr3c/aEv+
 lE84DxF2iJStBDYszT11HP2MzlMBaYf6gpENlrhs1c4nRKnbSG/s0s0ot4G7fwGVjjsUutzDOds
 l4RHAvOdMshg2NzkjOcqRhjSFyiHY+dlEwhCEWKHo87AvBWr8/Zkj5Mh8VyJGcshwXOzw04Dode
 YaHr0/ty3BOBqSoxT/27FQfNxLjL9fBORMQoM0bDNZTXn2MgCiyy8aJsj9SvqKFOO6DeDTrAkWm
 ddSPAPsIYo6BZroDSUwjNnmkOKZUEuJah5AlerXhNklUfUrF8DrKy3dF9T7SWxxJITfrsEpNGFf
 LAXVyxhrbXjLY0P95OFkAv9NqAV4XY51pnYva0BEFbzDE8/91R6tsAQMEIvYrcg+KvECJKO7asM
 cAVNTYi7F2C4hLJQzIK+KOdbz3lNgdo=
X-Received: by 2002:a05:6000:2587:b0:48e:5d63:a4e5 with SMTP id
 ffacd0b85a97d-48e6e26184emr3319988f8f.0.1793340869518; 
 Thu, 29 Oct 2026 23:14:29 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm1438237f8f.30.2026.10.29.23.14.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 23:14:29 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/10] test: lib: add tests for the PE image checks
Date: Fri, 30 Oct 2026 06:14:28 +0000
Message-ID: <107b5f12-d28c-4518-80c9-9248ca8a3f46@gmail.com>
In-Reply-To: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
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
- a section whose raw data runs past the end of the image;
- headers that do not fit into the loaded image;
- a relocation table past the end of the image;
- an image that cannot be measured, when TCG2 is installed;
- headers, an optional header, a certificate table entry, a section or
  a certificate table that do not fit, a file alignment that is not a
  power of two, and sections sharing their raw data.

Check that PE32 and PE32+ images with 16, 6 or 5 data directories, an
empty section, a last section that is not padded and trailing data of an
odd size still load and parse.

Each image is built at the start of a larger zeroed buffer, so that
without the checks most tests read the bytes after it and get a wrong
status instead of faulting. Without the checks the tests of the wrapped
section and of the relocation table far past the image crash, and the
test of the headers writes past the loaded image.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 test/lib/Makefile           |   2 +-
 test/lib/efi_image_loader.c | 442 ++++++++++++++++++++++++++++++++++++
 2 files changed, 443 insertions(+), 1 deletion(-)
 create mode 100644 test/lib/efi_image_loader.c

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
index 00000000000..2cd4520a4e3
--- /dev/null
+++ b/test/lib/efi_image_loader.c
@@ -0,0 +1,442 @@
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
+	return 0;
+}
+LIB_TEST(lib_test_efi_load_pe_section_raw, 0);
+
+/* efi_load_pe() must check that the headers fit into the loaded image */
+static int lib_test_efi_load_pe_headers(struct unit_test_state *uts)
+{
+	struct test_image img;
+	int num_sections, i;
+	size_t hdr_size, size;
+
+	if (!TEST_MACHINE)
+		return -EAGAIN;
+
+	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
+
+	/*
+	 * Enough empty sections for the section table to end past the first
+	 * page, while the only section with data is TEST_FILE_ALIGN bytes
+	 * long at virtual address 0: the loaded image is a single page.
+	 */
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	num_sections = (EFI_PAGE_SIZE - ((void *)img.sections - (void *)buf)) /
+		       sizeof(IMAGE_SECTION_HEADER) + 2;
+	hdr_size = ALIGN((void *)&img.sections[num_sections] - (void *)buf,
+			 TEST_FILE_ALIGN);
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
+	ut_asserteq_64(EFI_LOAD_ERROR, load_image(size));
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
+/* efi_load_pe() must not load an image that cannot be measured */
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
+	 * the image cannot be hashed for its measurement.
+	 */
+	test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
+	opt_set(&img, FileAlignment, 3 * TEST_FILE_ALIGN / 2);
+	ut_asserteq_64(EFI_ACCESS_DENIED, load_image(TEST_IMAGE_SIZE));
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
+	 * The certificate table entry lies past the optional header, in the
+	 * section table: clear the section name read as the entry.
+	 */
+	test_image_init(&img, false, IMAGE_DIRECTORY_ENTRY_SECURITY, 1);
+	opt_set(&img, NumberOfRvaAndSizes, IMAGE_NUMBEROF_DIRECTORY_ENTRIES);
+	memset(img.sections[0].Name, 0, sizeof(img.sections[0].Name));
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
