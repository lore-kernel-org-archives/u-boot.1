Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2E1606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A0yPmVbb;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BZgs9RzL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51FDB60897;
	Tue,  3 Nov 2026 15:33:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iMuoeMx_eOXU; Tue,  3 Nov 2026 15:33:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A319060867
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720032;
	b=fMKcuhbUdk9Sy2NDSqb4AE5P+Ktrzhprf9QOu4TXY2smNuG8mCTqBMrzAa5jXHKApd7w
	 umjg4NxBdlmZA3kZ21GZbPSIXtQXjMoD5cIBODGkA6G0gg0FEEet0tYhL9v8bHjziXPiY
	 5Mk8CjPlu8MLorMwRbikWOxRVc+B+VbZ1tEFzlrHodwk3Pd0y7SooxQYlnuE2NtWvFhNU
	 1LB2WLUyxIuwITvvl9xdb8kTKIRdRxyU8Spm5RMO+WM/5IoWMHfQG3oYrFo2LNjBDG8ll
	 kBd32xzkARwG2AaGHJ6P7DH11rx9ZSyqK+NkS7kKWOSPN/c11PJKW9TwJ5XvnXhq5RA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793720032;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nk4C5Qn9TlYdBet6BAVnEAspKmNAale1gSdzNWbL71I=;
	b=Cdyrw3ZRrkTYLxKPa4UqQpAjg0a26Z+3EQJPc047xc7ggOf2Eumo+eULbWTD+Lb5sgud
	 wuMjanT3l/oQ+Wnw94ccQrOOD+C4nD/fZOGfM/tTSJAF6FWra3jrnoCBtaX1CWj477kok
	 +VTlhah0YEzz/5Skl99yDx3GQqvAg1fR/QnplzxLcvKL/cEiD7fGc9EdrqpEZogsnvqbm
	 xxbPsc7IcAEFpsfzzcsjvy91tfpnnAZ7vMnagHZygh5I0ytsNj28V6MWck9src6v24YQR
	 nx/TFv6ypeQhtnPTIm64+KpWewWTIGw4BULQQT2+iNmd9nudIgPd+UDU9/t4xIhifog==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793720032;
	bh=nk4C5Qn9TlYdBet6BAVnEAspKmNAale1gSdzNWbL71I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A0yPmVbbEOa2yvRHEWc8ZF48ZqJ5voGg2ValJFr2llQKlXZu7iHKKy8j/Q6Y5bHXO
	 j2ybQ4eE+H9oyi98o8q2NTB7t93YE0YjkKEnGcbjJkKPrK96ASNMUm2KATvDCY4wXM
	 V4SKHx+CXauL42calRyTyZqHZPZ4Xs4rvPnG3J3gEWWNgYjU/Fr+0GjHPo/RECrjOl
	 Na+BcdbNEQPvADoFw8ld/TLmflnga8eORMru1PSokh+T3UvJR+zcSCaT/+uIR9KHC0
	 sqWWfhCxXSpKVx1eTLjEwmuibs2QQQJ4Kq/BHgkYDLjez705ZL5RMU/rEEDn/noWm8
	 8O6Sn/ely3uRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A319060867;
	Tue,  3 Nov 2026 15:33:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CFB9A5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E676840665
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:33:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tOg8kV9Ficb5 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:33:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D0B684064F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793720029;
 b=XltnCWoBkCl/BiWNIZxE/zxFeDIfNoGE6qnGhrC9LkVSEeHvZg+t/xh6aANhkzi/Rk2b
 XHR1LYRzJ6pLifpIFxIQBFFwsD5Clh0I7JgQVbtcFocw6QA/CVzzW1SSJ9pBcOvVlZ1E6
 lJDD13s742Ziz5ygFYpyaEzL+HlKIeKUZVUnGysFkrLtlJzlJkcdvcXAPLsB1udXxtHtY
 PU9i1aZVftXoZ2X2b+QDniHJUTVjgKmifxZvqiO5qlB+aBq6ee9Jl/7uUETKR2auO4VT9
 TTrC66+Vue6mWPadcKhjA/bEeyjYzqL2jRqOgd1LbR0hTku9BS/1uO2I5WpIFY0yLqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720029;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=nk4C5Qn9TlYdBet6BAVnEAspKmNAale1gSdzNWbL71I=;
 b=RleGlhAWghZubdL5CsyekkUbRAyjOIsPPtmf0Rt8MR+lekUAzj7P/rO1gNFzlZHacXpv
 IMDnViZE5HK2oAjPWdfEvBeGyQ0sKDHDmr7ed3SVIfvAnhwabhom7+p5zrtDXdjICJp6N
 yK3Xlt7rLyDLwqEIyTglSZomIVyv2MM17YXpqyC/xgVVrkb4K5VRSBjr/5e8U4W8JfwrY
 Ey57M6llHzZrQnjuWqpIiDaws6dgb4KlU/6EEFI9jdawrzovCSZSKihujKGi9cK0y2E99
 wBsVaws2LuJTee416Oq/VYt3buIxvHulSVhlCCL9KxdoVhwTbDnqTGQ9E4UmSGAF5gA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=BZgs9RzL; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=BZgs9RzL
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D0B684064F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:33:48 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so3796714f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793720026; x=1794324826;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nk4C5Qn9TlYdBet6BAVnEAspKmNAale1gSdzNWbL71I=;
 b=BZgs9RzLSmfHDD20TjdkBtdqgj7uN//SbIP4Zf+SMoOfTsCt2vdMW0Zb0y72HgHk3K
 gcSKnMdNm184CUApjIkmY+T/x53mR0f//WL2h0Cw3eg49+9FhwQpylTfCuU81D3mMQzJ
 6bdyZvuMrW2H+LZRB4rlcX3Jo0lcZpCDyCaV7YgAZiahKiw/GAg3Va5F9uuPkBtQOvRQ
 b8W4FJYzMdYZhvrPZ8NRdCUPtgCZS/f+Ul4zZUjKXeSzHnBWdycypDsBr86gax46DZoY
 lBTE0Mpb+9Nre6bg+2HiFZmnYMNpq7ek7al3eJh0WvLqFNeXBTasA7pTQBRTYx2YzRH4
 iimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720026; x=1794324826;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nk4C5Qn9TlYdBet6BAVnEAspKmNAale1gSdzNWbL71I=;
 b=R5tjSCpBmzHA73ydvwyov1thKVgfZ1I3UV3pMXbatdGQ7jBXdFLuQZX4XY39d32YjK
 WekooQV0zD7v0goeNujnG/8SrINCh/YwWcUX+2aHsgU0o+EDwAM80BoLLfqNEYlubfV2
 FYgQntod41h8WZ3ldDXXi1q9EI1QnPJEKxicqaZBpFh9S3aD0pwVHFr5Sxq+q3fCMTDu
 Lcux4Cz0GAwTgzln49LnS1SpahH+7re/Uuf4JBI2Uyti9tc9FCMPiZ8J2XEd4Cov8Ts0
 JBJe0d5C1lfYw+pBnhnKf1SsQd8qzOi1GDP1Npmzon5d6u70W4YUzTT2cEzRmsQ+DjBR
 vhUA==
X-Gm-Message-State: APuU4Z9DRcoDAEAaca27bt7teI0ndWRwCb7g6ItUXJWAyod3hm0hes59
 MLDaPVHyki24nfN3ixbpHRbwjAjmglOd3Xbqthz5Wo3C4rBtEU/mWviaCOP6fDTHfyPgsEfW
X-Gm-Gg: AYBFou0IrjOsFP88NopPWECOcLK15bcb/QxEZyLLXz4HdYkwm++xpvJt28oVMOKgCeN
 3k4tyRF4cbVpP60GLd8uWGUB1yMgxgXcx38NncqX5bk62r3sBDXNQHNu1788y+ERWZc4zNvHoQB
 4q4yzMbTWrl8mRA3ho3hJzFUbiORixtTOCdBnW5aErOybc9EDT6CHuyVYvQhS2JwlKRUQrysyLo
 STtHd1Vr2nQePMSvtr1AEwNj9z3OfOdXLh1nq2yu01to2XWlDzSVbF2OEHuOhPU4PZZKe8+MECJ
 fq3wORkpZVXkmx2Q1SxgdRCAEc10qrlLul4/iZ7lQtMqA0KKZFPiV6ijOzUTRV5TNFzIDhFWM5t
 Bzs8yusgbReMSGnIV8rlcQVsfqLwD+NIgZEgO+RmgsV+3v/B1x3S3cqn4QNIXoLI4jOZVuFPsiP
 OQrONNGPEOZdtFQHVCuDkz9lVFHqc58g9n754Z5c6ldVinKLR4JoqQMgvYz5zYVc2BlZcYeGJIR
 waenerWw9S4/79LzguY4vW0q+8Av+UfbUWAIi+VrYibd9g0CvXIfT9p7OTIvaVYQFxyIMEiFzwz
 p1CccRwaCev2aj+HG89Lcwd1gsQ1w4Q=
X-Received: by 2002:a05:6000:40e0:b0:48f:bb86:cc03 with SMTP id
 ffacd0b85a97d-48fbb86d828mr3450507f8f.11.1793720026060; 
 Tue, 03 Nov 2026 07:33:46 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bab1a8sm25412938f8f.57.2026.11.03.07.33.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 07:33:45 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 4/4] x86: zimage: Bound the kernel version string to the
 image
Date: Tue, 03 Nov 2026 15:33:44 +0000
Message-ID: <6c10de64-fb7d-4775-8d55-686aacaded90@gmail.com>
In-Reply-To: <68656bc0-c727-4d25-8066-f2633c04e02a@gmail.com>
References: <68656bc0-c727-4d25-8066-f2633c04e02a@gmail.com>
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

zimage_get_kernel_version() finds the version string at an offset of up
to 64KB from the kernel base, taken from the kernel_version field of the
setup header, and then scans it up to its nul terminator. It works out a
256-byte limit for the scan but never checks it, and it does not know how
much of the image is there to read.

This matters for the ChromiumOS bootmeth, which reads the kernel setup
data from disk into a buffer of bootloader_size + 8KB bytes and passes a
kernel base 24KB into that buffer. With a bootloader of less than 16KB,
the kernel base is already past the end of the buffer, and the header
fields come from the disk.

Pass zimage_get_kernel_version() the number of bytes it may read at the
kernel base, and stop the scan at the 256-byte limit. The zboot code
passes the size of the setup code, which holds the string according to
the boot protocol, and the ChromiumOS bootmeth passes what is left of its
buffer.

A version string longer than 255 characters is no longer shown; Linux's
are around 100.

Fixes: 7c79eddbec32 ("x86: zimage: Sanity-check the kernel version before printing it")
Fixes: f861b1ee70aa ("bootstd: cros: Add a function to read info from partition")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
(no changes since v1)

 arch/x86/lib/zimage.c | 27 ++++++++++++++++++---------
 boot/bootmeth_cros.c  |  7 ++++++-
 include/bootm.h       |  6 ++++--
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index a5f2231aa52..53c8e0429e4 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -145,11 +145,12 @@ static int setup_device_tree(struct setup_header *hdr, const void *fdt_blob)
 }
 
 const char *zimage_get_kernel_version(struct boot_params *params,
-				      void *kernel_base)
+				      void *kernel_base, ulong size)
 {
 	struct setup_header *hdr = &params->hdr;
-	int bootproto;
 	const char *s, *end;
+	ulong offset;
+	int bootproto;
 
 	bootproto = get_boot_protocol(hdr, false);
 	log_debug("bootproto %x, hdr->setup_sects %x\n", bootproto,
@@ -157,16 +158,23 @@ const char *zimage_get_kernel_version(struct boot_params *params,
 	if (bootproto < 0x0200 || hdr->setup_sects < 15)
 		return NULL;
 
-	/* sanity-check the kernel version in case it is missing */
+	/* the offset comes from the image, so check it is within @size */
+	offset = hdr->kernel_version + 0x200;
 	log_debug("hdr->kernel_version %x, str at %p\n", hdr->kernel_version,
-		  kernel_base + hdr->kernel_version + 0x200);
-	for (s = kernel_base + hdr->kernel_version + 0x200, end = s + 0x100; *s;
-	     s++) {
+		  kernel_base + offset);
+	if (offset >= size)
+		return NULL;
+
+	/* sanity-check the kernel version in case it is missing */
+	end = kernel_base + min(size, offset + 0x100);
+	for (s = kernel_base + offset; s < end && *s; s++) {
 		if (!isprint(*s))
 			return NULL;
 	}
+	if (s == end)
+		return NULL;
 
-	return kernel_base + hdr->kernel_version + 0x200;
+	return kernel_base + offset;
 }
 
 struct boot_params *load_zimage(char *image, unsigned long kernel_size,
@@ -206,7 +214,7 @@ struct boot_params *load_zimage(char *image, unsigned long kernel_size,
 	log_debug("Using boot protocol version %x.%02x\n",
 		  (bootproto & 0xff00) >> 8, bootproto & 0xff);
 
-	version = zimage_get_kernel_version(params, image);
+	version = zimage_get_kernel_version(params, image, setup_size);
 	if (version)
 		printf("Linux kernel version %s\n", version);
 	else
@@ -577,7 +585,8 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 	print_num("Start sys seg", hdr->start_sys_seg);
 	print_num("Kernel version", hdr->kernel_version);
 	version = zimage_get_kernel_version(base_ptr,
-					    (void *)state.bzimage_addr);
+					    (void *)state.bzimage_addr,
+					    (hdr->setup_sects + 1) * 512);
 	if (version)
 		printf("   @%p: %s\n", version, version);
 	print_num("Type of loader", hdr->type_of_loader);
diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index 805680f71ad..006f30c0bb4 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -225,9 +225,14 @@ static int cros_read_buf(struct bootflow *bflow, void *buf, ulong size,
 
 #ifdef CONFIG_X86
 	const char *version;
+	ulong kern_size = 0;
 
+	/* The kernel base may lie beyond the end of the buffer */
+	if (size > before_base + X86_KERNEL_OFFSET)
+		kern_size = size - before_base - X86_KERNEL_OFFSET;
 	version = zimage_get_kernel_version(map_sysmem(setup, 0),
-					    map_sysmem(kern_base, 0));
+					    map_sysmem(kern_base, 0),
+					    kern_size);
 	log_debug("version %s\n", version);
 	if (version)
 		bflow->name = strdup(version);
diff --git a/include/bootm.h b/include/bootm.h
index d1aac3d44df..5b202cf2d97 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -299,10 +299,12 @@ int zboot_run(ulong addr, ulong size, ulong initrd, ulong initrd_size,
  *
  * @params: boot_params pointer
  * @kernel_base: base address of kernel
- * Return: Kernel version as a NUL-terminated string
+ * @size: Number of bytes at @kernel_base which may be read
+ * Return: Kernel version as a NUL-terminated string, or NULL if there is no
+ *	valid version string within @size bytes of @kernel_base
  */
 const char *zimage_get_kernel_version(struct boot_params *params,
-				      void *kernel_base);
+				      void *kernel_base, ulong size);
 
 /**
  * zimage_dump() - Dump the metadata of a zimage
