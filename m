Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6078F606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n5qY7lhN;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jw0+CsXf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C92260AB3;
	Sat, 24 Oct 2026 12:17:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dicPalvOopiU; Sat, 24 Oct 2026 12:17:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2DE2E60A98
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792844236;
	b=T/AY3d6KWn5TZRdS4uM5M5pZ5MBlSb0pqbyj9A2rcMjYGXdniDVJ9mpJNWghO9p4GZ/+
	 DjOON/UzE8IZNPY6ex/FFlSunmtNlXSSUgNDZ04ia6h06FvycytijE7l9lzWUhMY2PjTr
	 X29vmpOiJUPkf/lKM5J3LkfF+VHtcqBzWu9qLCgohiRsMUsOgOOxvsPgY0LQdCOpj7bAl
	 suRhrRR9yEYvQ6Y5M2aprb8LVo8BhTNATYZfwQ/L33srE9AP2Ga3PJNZSOUUAlKcNiuVp
	 YjVdBEYDpumK50CkY3vxPDUeKopblrvSXwcndn6y46l8laEPZ8p58sXXgjo8iJjw39A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792844236;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nOrCn27+AKs9Yu6JfPtxE2xGq+uwB0f13YklvM4c5us=;
	b=SvnLVCUtuswGf4hwDBFr7r7rUoPoUVx5wm2aBvWWSh7gKYfnFUS6ZGE9LHXyimogYbp+
	 794LytiGc3O1ys/+a2rNaegFrUFw+FOI/gdcjJrcqIsPBweKwp2OVk7B+EafUo0Cvmeia
	 EiiWTxQ7Z+sD/3jplFBcw7Gmd2l6niPIy/GNs4kioEh8nJoVy+6saz/6AFa+4yvD/WUou
	 FZkDoDNyhVeGxKv0HLil1jg2Jmu2pJ3Ke4PLiGbkQ99gf7Hq5F5zxrDfLRQPewOhPnOtA
	 jpMuOFSyMx5tLo0Dj8OTe2BZvadAA07qzZg85DUhM+xLUkqz4YYsDDS5q/oQVZ+fsng==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792844236;
	bh=nOrCn27+AKs9Yu6JfPtxE2xGq+uwB0f13YklvM4c5us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n5qY7lhN8bzHeAxDv7rRKcWgc2wUXO5l0h/IG6Ow8eKRQX/zoq+sFW00mRh3OGu6n
	 u3EkaYPEuT22bULDdz/rrNJMtHOsCH6ueMujFgkNCl4eyjiQrUtbbg9nFeKS0GcO5T
	 oxgH443MUvXsK3vfoUbRuCxM+M3rUh8ew4YIzpW1UzAUCAKlsiDwZ+eTRqUuowpkUZ
	 IlmTbOYv0rdBGi/ESbJ/B8taKjbyIGSSM0HyDEvX4VvWh1+d+yU+6TfYrVU9cxM5gs
	 wT7Rt4eEiux5N31IvS1xPpgiiUNEcJi9IxmYd+aOTe/aRWD9HbE4XazBLda8+EQIjj
	 APuQYaybNx6EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DE2E60A98;
	Sat, 24 Oct 2026 12:17:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BC48043
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9A4A81763
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AaJO0oZioJKb for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 12:17:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 693E38175A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792844233;
 b=Cp7tAiPqT3bCr03MvSPcuswU6Lz9Hk2HhXerHfFB+UAvDM+Nvmg6spawb3vAd6Kd+Np9
 5X4MpQju61UoMoK99cKwgBbKOhMuEihlqGNBAHhJPSgU6tZONmhAZNNTdTvp3fBdZ1y9a
 CLJXB0xHnnJzWD48N2kpcVACMSrAklSffaChYwmGSyWQVQ+q6FKkgtpZA1Tjx5lgNfZeH
 94wdHnAiHsFIczGvPgQK/LS3diA99b0BxzCMHBI/NAnWYWprUb+hIotNxcEfYTD7iRM2E
 2JjkJTl30V40uEQcEBrdYAr5IcayutNqpxs1VriwSdvkSl5E5yoASzdChj6L6iz/V0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792844233;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=nOrCn27+AKs9Yu6JfPtxE2xGq+uwB0f13YklvM4c5us=;
 b=mWxw4ble1+Ju2t0aeeKt9QBh0E7oHZk8VRIHbwyYab1meghIuvR1EAd1kqpVeyuicsXX
 B1QACyUYcZb73DSTOYiU77Dwal/K8m4JzVW3jGGKGtDY2hv3ecECLB+pPLaJ63frzh7ro
 +2u8YOQMpDsE+CwBjdi5xJgapNlL5RRdNnlPioU5hUzPCSzEtvjgRJhef1Fc16fNpwpAe
 U8D2D2IX27T5J4J5ETMGVVvhmla28ukWh2Agn0+Dct6eyHvxHzt7AP5fCwRcPA+oK+sZQ
 fCSmHM8YU9YI7QGxUsbZSZnX2pO4k/ZXIlniSxklAxwL2Vc/Fj+EAkAIFIQ273chKiQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jw0+CsXf; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=jw0+CsXf
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 693E38175A
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:12 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e47347279so47821f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 05:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792844231; x=1793449031;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nOrCn27+AKs9Yu6JfPtxE2xGq+uwB0f13YklvM4c5us=;
 b=jw0+CsXf4MU/vQMdE+q1RBNWmUhGp12i7ceg25VoPyCNDmB/zIctOCWtWgs9jcUNOu
 ujyrwE2xmjw9TXno9kAqdPnzfrse/u49z1Jv+rplPAP2waXiXUjHVj+TuyEGBBSzycoX
 lP58eWSEs58fzUpR6rfda5w7kcYhk6fyoJRc27Sn0Nl2HCWx+yvdobhE3X14hCGtjJoK
 3B3zatSKbWXMCvRIZGYXON7QVY7LI/oqneq1Sg9AIhXMj1b1Cw2pzq7ZN/cssN2eFhjJ
 fyuVgmbik365eSqtetYly9Mtmy1IAsV3Pkyx8UJwlCfHf7cHUriryNAHVtzjNOZiUmWF
 3qmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792844231; x=1793449031;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nOrCn27+AKs9Yu6JfPtxE2xGq+uwB0f13YklvM4c5us=;
 b=fTbrdMKC1DAKR8MmE+DTIRLIFI0myIMzwZuIqiHcflDhkIzUvgx2Ed3Kb9NzM88Gh6
 mQf2yjwER3TTDDXlUKMxizaWYfqxfJ6+uRO2BoHE+hgk7MgT1/T7yiIi96dG/M/VIscL
 wqIEJX2E2Lu0NP9sWNPgzTSaAI2zFQVljYRC0YHktpj0lmf0JrWtxW5s9kFGGK30NY72
 d7qhMKN9ligJXgSXlQA/kb3lMVUJSIBKm1TtAGuk854Z5zYHr2+tjfJR9BtXUy42tyXH
 0c31llzbBVAWk3D/djvr7VxO5v9Kq58yzr6CVnIUSqDqirBleJF7tV9EeMBy7/6TkOJq
 CfzA==
X-Gm-Message-State: AFq9FYLz7K511tWSVioKtTcKi3TPAnyNJpMzLDAyzDVFGzkgyDrp/hD+
 +Zw4Z+LKvJL+i5/w1+rVaavySrclLh8CVTM4QwaGqmQ/9IZkeERVUYnIeVAGnMbB
X-Gm-Gg: AYBFou257svvujNZfnWyn6Y5pOMwzm4xKcBBAL2ONRzhqRLU+uuYgYNcilC+x3F7FqU
 flIK5wKA30zftVGfImNOcrqVJF09VGZ71/BbS80q/ioHjh7FUQENcqx32vpL/zuv/CaR2dx3ijm
 he0ljvPujPst3gDRJKOg5uxtOrKjT7V8v9o9TvG4dOOTKDeQR5ySb5ljgujk2Pkj0NYcPwVeyk7
 OpE4BubUz/UTbU1zw0s6UEuZMZ3BMMWdV8PPercMGEACkIDnTbNzVf6JqvsLdCOFlK6N/jx7/q+
 TOuVuFbBhS9UNYF/RZwT4zuw/TfPi/ryjwP3oUDC2HhBI2Azf4YYmXIdZDpD+SuoD9aGrdPmire
 XrlcLJRdWoIZonefJNi2FjbjZG9lKWr+JSeL4xjh0ug7HmfPtxLjwR6pHv0inGOWGxkUFhVRTaR
 LRM4fYuWslQcc1hLRAL5RsytqL/jUvavSXhnsUStUAaXRC9MSBPlMD40jOub0SGYx1fb+K5wOjb
 iXr3WBNOYIKRIdZDbT58ctDDruvHZW8fdQF+UmQBLILIzK80n9srP9a3g==
X-Received: by 2002:a05:600c:3e1a:b0:4a1:e250:b191 with SMTP id
 5b1f17b1804b1-4a35aca6ae2mr27500175e9.17.1792844230981; 
 Sat, 24 Oct 2026 05:17:10 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a58a0e2sm61680785e9.13.2026.10.24.05.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 05:17:10 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH RESEND 6/9] disk: part_efi: Check the header and entry sizes
 of a GPT
Date: Sat, 24 Oct 2026 12:17:09 +0000
Message-ID: <23ae3d1c-1d7d-4c2a-9b09-3216d53e4e3a@gmail.com>
In-Reply-To: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
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

validate_gpt_header() computes the CRC of a GPT header over header_size
bytes, as the header gives it, and nothing checks the size of the
partition entries before they are used:

- the header is read into a buffer of one block, on the stack behind
  part_get_info(), part_print_efi(), gpt_repair_headers() and the gpt
  command, so a header_size larger than the block size makes the CRC
  read past the end of that buffer
- alloc_read_gpt_entries() allocates and reads
  num_partition_entries * sizeof_partition_entry bytes, computed in 32
  bits, but the entries are then used as an array of
  num_partition_entries gpt_entry structures: with a smaller entry size,
  or a product that wraps, part_get_gpt_pte() and part_print_efi() read
  past the end of the allocation. On a 32-bit board, rounding a product
  close to 4GiB up to whole blocks also wraps, to a tiny allocation that
  the entries are then read into.

As Linux does in is_gpt_valid(), refuse a header whose header_size is
smaller than the header or larger than the block it is read from, one
whose sizeof_partition_entry is not sizeof(gpt_entry), and one whose
entry array is larger than 4MiB (KMALLOC_MAX_SIZE in Linux with 4KiB
pages, 32768 entries). Larger entries are allowed by the UEFI
specification, but U-Boot has never read them correctly, and Linux does
not accept them either.

The header size is checked before the CRC is computed over it. All the
checks are in validate_gpt_header(), so they also apply to
is_valid_gpt_buf(), which fastboot uses on a GPT it is sent.

Add a test that gives the primary header of a GPT on a blkmap device
each of these sizes, with CRCs to match, and checks that it is refused
and that the backup header is used instead.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 disk/part_efi.c     |  46 +++++++++++--
 test/lib/part_efi.c | 155 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 196 insertions(+), 5 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index d8751297fbe..efb6756cf2c 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -30,6 +30,12 @@
 #include <linux/printk.h>
 #include <u-boot/crc.h>
 
+/*
+ * Largest partition entry array accepted, as in Linux (KMALLOC_MAX_SIZE with
+ * 4KiB pages): 32768 entries, far more than any tool writes
+ */
+#define GPT_ENTRIES_MAX_SIZE	SZ_4M
+
 /* GUID for basic data partitons */
 #if CONFIG_IS_ENABLED(EFI_PARTITION)
 static const efi_guid_t partition_basic_data_guid = PARTITION_BASIC_DATA_GUID;
@@ -89,10 +95,11 @@ static int get_bootable(gpt_entry *p)
 }
 
 static int validate_gpt_header(gpt_header *gpt_h, lbaint_t lba,
-		lbaint_t lastlba)
+		lbaint_t lastlba, unsigned long blksz)
 {
 	uint32_t crc32_backup = 0;
 	uint32_t calc_crc32;
+	u32 header_size, entry_size, num_entries;
 
 	/* Check the GPT header signature */
 	if (le64_to_cpu(gpt_h->signature) != GPT_HEADER_SIGNATURE_UBOOT) {
@@ -103,12 +110,22 @@ static int validate_gpt_header(gpt_header *gpt_h, lbaint_t lba,
 		return -1;
 	}
 
+	/*
+	 * The CRC covers header_size bytes, so the header has to fit in the
+	 * one block that was read into gpt_h
+	 */
+	header_size = le32_to_cpu(gpt_h->header_size);
+	if (header_size < sizeof(gpt_header) || header_size > blksz) {
+		log_debug("GPT: header_size incorrect: %u not in %zu..%lu\n",
+			  header_size, sizeof(gpt_header), blksz);
+		return -1;
+	}
+
 	/* Check the GUID Partition Table CRC */
 	memcpy(&crc32_backup, &gpt_h->header_crc32, sizeof(crc32_backup));
 	memset(&gpt_h->header_crc32, 0, sizeof(gpt_h->header_crc32));
 
-	calc_crc32 = efi_crc32((const unsigned char *)gpt_h,
-		le32_to_cpu(gpt_h->header_size));
+	calc_crc32 = efi_crc32((const unsigned char *)gpt_h, header_size);
 
 	memcpy(&gpt_h->header_crc32, &crc32_backup, sizeof(crc32_backup));
 
@@ -143,6 +160,24 @@ static int validate_gpt_header(gpt_header *gpt_h, lbaint_t lba,
 		return -1;
 	}
 
+	/*
+	 * The partition entries are used as an array of gpt_entry, read into
+	 * a buffer whose size is the product of these two fields, worked out
+	 * in 32 bits and then rounded up to whole blocks
+	 */
+	entry_size = le32_to_cpu(gpt_h->sizeof_partition_entry);
+	if (entry_size != sizeof(gpt_entry)) {
+		log_debug("GPT: sizeof_partition_entry incorrect: %u != %zu\n",
+			  entry_size, sizeof(gpt_entry));
+		return -1;
+	}
+	num_entries = le32_to_cpu(gpt_h->num_partition_entries);
+	if (num_entries > GPT_ENTRIES_MAX_SIZE / entry_size) {
+		log_debug("GPT: num_partition_entries too large: %u\n",
+			  num_entries);
+		return -1;
+	}
+
 	debug("GPT: first_usable_lba: %llX last_usable_lba: %llX last lba: "
 	      LBAF "\n", le64_to_cpu(gpt_h->first_usable_lba),
 	      le64_to_cpu(gpt_h->last_usable_lba), lastlba);
@@ -925,7 +960,7 @@ int is_valid_gpt_buf(struct blk_desc *desc, void *buf)
 	/* determine start of GPT Header in the buffer */
 	gpt_h = buf + (GPT_PRIMARY_PARTITION_TABLE_LBA * desc->blksz);
 	if (validate_gpt_header(gpt_h, GPT_PRIMARY_PARTITION_TABLE_LBA,
-				desc->lba))
+				desc->lba, desc->blksz))
 		return -1;
 
 	/* determine start of GPT Entries in the buffer */
@@ -1095,7 +1130,8 @@ static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
 		return 2;
 	}
 
-	if (validate_gpt_header(pgpt_head, (lbaint_t)lba, desc->lba))
+	if (validate_gpt_header(pgpt_head, (lbaint_t)lba, desc->lba,
+				desc->blksz))
 		return 0;
 
 	if (desc->sig_type == SIG_TYPE_NONE) {
diff --git a/test/lib/part_efi.c b/test/lib/part_efi.c
index 82153fdabfd..c8fdfe2f41c 100644
--- a/test/lib/part_efi.c
+++ b/test/lib/part_efi.c
@@ -12,6 +12,7 @@
 #include <part.h>
 #include <part_efi.h>
 #include <asm/byteorder.h>
+#include <u-boot/crc.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -280,4 +281,158 @@ static int lib_test_gpt_blkmap(struct unit_test_state *uts)
 }
 LIB_TEST(lib_test_gpt_blkmap, 0);
 
+/**
+ * gpt_sizes_check() - check the size fields of a GPT header one by one
+ *
+ * Give the primary header of a good table each set of sizes in turn, with
+ * both CRCs recomputed over what those sizes cover, as a crafted disk would
+ * have them. Only the checks on the sizes themselves can then refuse it.
+ *
+ * @uts:	test state
+ * @dev:	blkmap device with nothing mapped yet
+ * @lba:	size of the device in blocks
+ * @buf:	memory to back the device with, @lba blocks of DEFAULT_BLKSZ
+ * @hdr:	two blocks of memory, to rewrite the header in
+ * Return: 0 if OK, other value on error
+ */
+static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
+			   lbaint_t lba, void *buf, gpt_header *hdr)
+{
+	static const struct {
+		u32 header_size;
+		u32 num_entries;
+		u32 entry_size;
+		int ret;
+	} cases[] = {
+		{ sizeof(gpt_header), GPT_ENTRY_NUMBERS, sizeof(gpt_entry), 0 },
+		/* the reserved rest of the block may be part of the header */
+		{ DEFAULT_BLKSZ, GPT_ENTRY_NUMBERS, sizeof(gpt_entry), 0 },
+		/* a header longer than the block it is read from */
+		{ DEFAULT_BLKSZ + 1, GPT_ENTRY_NUMBERS, sizeof(gpt_entry), -1 },
+		{ sizeof(gpt_header) - 1, GPT_ENTRY_NUMBERS, sizeof(gpt_entry),
+		  -1 },
+		/* entries are only ever read as a gpt_entry array */
+		{ sizeof(gpt_header), GPT_ENTRY_NUMBERS, sizeof(gpt_entry) / 2,
+		  -1 },
+		{ sizeof(gpt_header), GPT_ENTRY_NUMBERS, sizeof(gpt_entry) * 2,
+		  -1 },
+		/* an array whose size comes to a single entry in 32 bits */
+		{ sizeof(gpt_header), U32_MAX / sizeof(gpt_entry) + 2,
+		  sizeof(gpt_entry), -1 },
+	};
+
+	char str_disk_guid[UUID_STR_LEN + 1] =
+		"8d60b397-1bb6-4d33-80ee-b1587d24c2f8";
+	const unsigned long blksz = DEFAULT_BLKSZ;
+	struct disk_partition parts[1], info;
+	struct blk_desc *desc;
+	struct udevice *blk;
+	gpt_entry *gpt_pte;
+	void *entries;
+	int i, ret;
+
+	ut_assertok(blkmap_map_mem(dev, 0, lba, buf));
+	ut_assertok(blk_get_from_parent(dev, &blk));
+	desc = dev_get_uclass_plat(blk);
+
+	memset(parts, '\0', sizeof(parts));
+	strcpy((char *)parts[0].name, "first");
+	parts[0].size = 0x100;
+	disk_partition_set_uuid(&parts[0],
+				"a2a0d0eb-e5b9-3344-87c0-68b6b72699c7");
+	ut_assertok(gpt_restore(desc, str_disk_guid, parts, 1));
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		u32 header_size = cases[i].header_size;
+		u32 array_size;
+
+		/* start from the primary header as it is on the disk */
+		memset(hdr, '\0', 2 * blksz);
+		ut_asserteq(1, blk_dread(desc, GPT_PRIMARY_PARTITION_TABLE_LBA,
+					 1, hdr));
+
+		hdr->header_size = cpu_to_le32(header_size);
+		hdr->num_partition_entries = cpu_to_le32(cases[i].num_entries);
+		hdr->sizeof_partition_entry = cpu_to_le32(cases[i].entry_size);
+
+		/* the array CRC covers the size as the parser works it out */
+		array_size = cases[i].num_entries * cases[i].entry_size;
+		entries = buf + le64_to_cpu(hdr->partition_entry_lba) * blksz;
+		hdr->partition_entry_array_crc32 =
+			cpu_to_le32(crc32(0, entries, array_size));
+		hdr->header_crc32 = 0;
+		hdr->header_crc32 = cpu_to_le32(crc32(0, (void *)hdr,
+						      header_size));
+		ut_asserteq(1, blk_dwrite(desc, GPT_PRIMARY_PARTITION_TABLE_LBA,
+					  1, hdr));
+
+		/*
+		 * Read it back into a buffer as large as the one above, so
+		 * that a header longer than its block is refused by the size
+		 * check rather than by a CRC over whatever follows the buffer
+		 */
+		memset(hdr, '\0', 2 * blksz);
+		gpt_pte = NULL;
+		ret = gpt_verify_headers(desc, hdr, &gpt_pte);
+		free(gpt_pte);
+		ut_assertf(ret == cases[i].ret,
+			   "case %d: header %u, %u entries of %u: %d\n", i,
+			   header_size, cases[i].num_entries,
+			   cases[i].entry_size, ret);
+
+		/* fastboot checks a GPT it is sent in memory the same way */
+		ut_asserteq(cases[i].ret, is_valid_gpt_buf(desc, buf));
+
+		/* either way the disk still reads, from the backup if needed */
+		desc->part_type = PART_TYPE_UNKNOWN;
+		part_init(desc);
+		ut_asserteq(PART_TYPE_EFI, desc->part_type);
+		ut_assertok(part_get_info(desc, 1, &info));
+		ut_asserteq_str((char *)parts[0].name, (char *)info.name);
+		ut_asserteq_64(parts[0].size, info.size);
+	}
+
+	return 0;
+}
+
+/*
+ * A GPT header gives its own size and the size of its partition entries, and
+ * its CRCs cover only what those say, so a CRC does not show that either size
+ * is one the parser can use. Check that a primary header with a size the
+ * parser cannot use is refused, CRCs or not, and that the backup is used.
+ */
+static int lib_test_gpt_sizes(struct unit_test_state *uts)
+{
+	const unsigned long blksz = DEFAULT_BLKSZ;
+	const lbaint_t lba = 0x400;
+	struct udevice *dev;
+	gpt_header *hdr;
+	int ret, err;
+	void *buf;
+
+	buf = memalign(ARCH_DMA_MINALIGN, lba * blksz);
+	ut_assertnonnull(buf);
+	memset(buf, '\0', lba * blksz);
+
+	hdr = malloc_cache_aligned(2 * blksz);
+	ret = hdr ? blkmap_create(GPT_TEST_LABEL, &dev) : -ENOMEM;
+	if (ret) {
+		free(hdr);
+		free(buf);
+		ut_assertok(ret);
+	}
+
+	/* clean up here, as lib_test_gpt_blkmap() explains */
+	ret = gpt_sizes_check(uts, dev, lba, buf, hdr);
+	err = blkmap_destroy(dev);
+	free(hdr);
+	free(buf);
+	if (ret)
+		return ret;
+	ut_assertok(err);
+
+	return 0;
+}
+LIB_TEST(lib_test_gpt_sizes, 0);
+
 #endif /* BLKMAP */
