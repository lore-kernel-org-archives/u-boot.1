Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C31606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kAioz9UA;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b6+yRFVE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83C1C6080B;
	Wed,  4 Nov 2026 12:51:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H1dVNCgohJkw; Wed,  4 Nov 2026 12:51:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 456076062C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796686;
	b=iokoBp3yBR7+5KrDzzwVkit4HvoZSItA7cERE0q8HLyyf/6lCVwp9AF0y6epc1HAlCLm
	 1DWFk4MvUw1yxf7jrVdP2ISLdS9rrum/YVJkwTEoqG4UuhwL2+kGMiRnTpajaZnRmYavT
	 0evXsLS27nJb4VBpMHF5iw4qLdyOOqb8MAZCrNgQPyLryMUrPSJuHq5L0LVHTrunzEH1v
	 XsBaTiW3X+Va6xJY51M2fGn4XKt6/xO2pXsYflQ22y/4tz7PRZhFDiXX59R/eBHtLQ2qg
	 7IEnmHyRUZiAJVZTkxuNWgmHmd1jrl53xujukzX9+m6wZgLUI7rpGWEs8RT118oGxoQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796686;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BG4ovAF8I7ZQBghDYHMcXUwFiT0Vr7iTEz4GO71/daE=;
	b=lr054t6L7B1wOVhB1ZOd2R0ROjVPDXDP8Yn8u4ulRtobMrv1VOp61c0cQo6i+LG/fjdw
	 U+tcjyvYRPkf1z1HPYZY3TdOZjFKANkFTfuswRm6JWuDK8kUomlm+lsDfGp9G4ezyf7uo
	 7/CgR9guPllAr7yKBmx1tgX9+LpVnuXiCrVEKsu/vafMXzgryWJj9iKLO9z7XL3Yozi6T
	 UFRTM0ZxJtACKUq+pOv5buX2+Tluqxel3lwtLG8M/q4lqm9C0EpgHxeyFCRbE3l/4aMKT
	 0pdnCd+AbdrmsG9/Z0xpmHk68Rzy+9gRYq35F873hgku/srVaETIbKnluSYhvG0/7cw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796686;
	bh=BG4ovAF8I7ZQBghDYHMcXUwFiT0Vr7iTEz4GO71/daE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kAioz9UA+W0kB+kSYXq9A6hle7Mc7vdh1zo3BUaidNEeB9O0ieOQNBAOWwdGf8HyX
	 sdDLJ4tob2NHUJ6FWla6TbrvsXMUBk5Pv03J95PyRqj1xegTAesuGtoCVVWTb6rt4Y
	 scUntZrUdSQOio4X6RNLRBRU+rNNyIXKTP9xNILeQZ9x+wcfpk0HWKKcyDWZhdOH4a
	 Y4nxLt2iXnzqXT90zV6M2SWUAjePt9TBeTGaJ+V8P7L6rH/0INM37DH+0BsEG6o5nr
	 OL/ZEC2By8JrT/Miyu9acsZAJAIrv8QaLYrye9Ih4NAAsybW1iJaea82j5PAoNVXRF
	 VzCVMuq/h5RSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 456076062C;
	Wed,  4 Nov 2026 12:51:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CD7034D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3EAF7400B0
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OlmNa_cntca3 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:51:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E647740068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796684;
 b=YIeSgZjIdI5lFo+8uUJuNErB6uhjDC1SRRN3oqRR6BcmpsZ56AYT9dP/UlpNdNejaS/W
 1LMKBSI8iQeDcs1z1fHTFzqp+8C4kCP02d1pdQwYfzPNRiI5tLA6Xah44zShmejP2h7za
 jUkLxrE5tj8vDGdTJ3aeDkAJ3hkHJbP0QxbFTB7DHRSEZxXiR2cFu8ncV9BZvUCrB1sM8
 PbUVh7sdG4W1PGXO46ZdfaEOcMU23e4KH+AkX+E6jEfpbynkrGVjzCDbtJvHT0TMSCoCy
 E/olW2XAB0aM3gad9Vr+SIJgjXw6czb3QKOIDDsbbGiFyX+JTPW/sjSXSyC3Pg/RI/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796684;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=BG4ovAF8I7ZQBghDYHMcXUwFiT0Vr7iTEz4GO71/daE=;
 b=qD0EocOogWYSzg4kDbLf8qXXYQGYB4fwatXEHuxu7wanMBMWECMg3dEljv/rSX/QZayV
 8UlJhRhCUaFL6AQSCl36Gkj3VEDKY8OyQMMQO3u12O5ETYmyebQz/48rRFdE1Rz99A0cK
 tumzfmz8atXotpbY9aBcCOL8kShYg7Hvz9lv1ry2E2QTJNhCVgQGPL3lLdMdYVtmZSQgE
 xzxx8RV0YBMiN3mK6o0K/iE78qc47c5F+ZUQQ32fhF6c1YopmcMEzzJNNCy6/yRzRnLX0
 iyA0UlW+1QQKbQIqaJugVw8rV7VTU5PWZJ1YwkXHikz5ng4wbWCdDqgo2CJoZegGnog==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=b6+yRFVE; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=b6+yRFVE
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E647740068
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:23 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so5341295e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793796682; x=1794401482;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BG4ovAF8I7ZQBghDYHMcXUwFiT0Vr7iTEz4GO71/daE=;
 b=b6+yRFVEqOEMP2tGkgi/HqtvNtYwOvU4A012eRoNFj7tAHOlGkd2AkAy2RBkcvStoX
 pfipNsaNi5YDMbctkd26sg3hmctzFR3TfVXhm3Lg8hvwd+jvq80l9s6EyRlH0pkqJCT1
 zUCPuVv4HYkP9Pl27oERi8Apbd0RrBRVNQPmlyr1hEe8fyjuJVpc9Pq8A/6Em4u9vReQ
 2j3IegPwoU8CVBPj2bVsQ4dQwHJmG5mZ/1JY9kE5+tpVGG67+c96bBmoQO50EhwSAtaS
 0CexxZ+zqmFnw1DXYOOcfUSmdxBvMMK3eWrGhS0O3X0NGgCYp4v9K1eVbrSGXzzdqiMU
 oPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796682; x=1794401482;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BG4ovAF8I7ZQBghDYHMcXUwFiT0Vr7iTEz4GO71/daE=;
 b=e6tKGlfQYJop3SMqiU1Fi1MH+K8Q3XVLMF8L/8xSKtWCL77IvmAL7eH9cLpoQNEK77
 nYZxKLi1K/225Wn2y4HyjwXvKlmc4OG8qji1UN5/EuN+VQf+/0iNXaiutm9o9+7/qynH
 irOjT73PJUY8wpk/xq7dqpilpODAaAKq4xtqy6gCL7PVQDed76WdagPjjRMuIoTd7s74
 biO2qirO2j3vUdjCcunL7GLHeay0acL5S6Zu6tAHJs4d6cWwFhm1u111lgS6G0J3261B
 18pjc9cU3+4KSDQPiTEi7/LIdi4loB8LIsZjje+HO1KTeCuuty3Oq46gcjZBKoyl2LqW
 AF1w==
X-Gm-Message-State: APuU4Z9A3gQ47nM+5wJxZ9GlJnDUA6JDWcgtGnvWIZ/+Ijcmck7gmSfj
 JojDdTt4lsH7uhFFT2pamFKiitoq28gogMw7h2lmggR7UKBgNr36799A
X-Gm-Gg: AYBFou2hT8ZQ9iKlg2v4Dr54oQAMa5ajFFjK3T0QFY4zkiQu/hYZmPx301W3a/zd2O/
 hJqtLb1PPnNTWkMgxjMTkdiNeBtUu09sn/F6dR/1Zr2+1dFZZqtL69Z2EuR2hjmLIbE8QqooNL5
 BiQnjHy9vFYYqQojAVGoh51hIVTgAm8WFXEWNdCT6uEC/j/qUcKxY/wm4G/ioBaoZfwreuYEqdE
 kQhjYvlhxNbks+q8bKcpqHC5zBP7E1QT7b6QJrQokkM+mK6X5ATnKVCi14JhOqL2RPq/HaWykcC
 G/81+Qn+TVMnr3GTVZ1qje6sdorawh2WYRoj5VHcWHuBG7/aT7iHau5vVz7Prr4VDh9U2Uteanp
 5Icq+JtXP2pBQkezpOiH05K97BatYgckxERbZfpr4IlnP1VViLpBEV3DOpjlgG5XqlA0vNJX/1Q
 L9N7dtlQR3MuaKWmzr/m2PPlijjOlNoOQbkw2z010MMrLKBxwKNpxe7gnmiwZjjEPTZuAgEFtlN
 DFjCAcx9i8z5YOS3tQaPnVnA9b3ooa5WFc265wuHmu5frRecCnRFvy+Dm4rh4utUYiLKMVtXjLU
 Pid+lIVsL4aIRKrgBAUeyrml1gi4K+I=
X-Received: by 2002:a05:600c:698d:b0:4a1:d97e:cd60 with SMTP id
 5b1f17b1804b1-4ac185bd1e2mr363542355e9.16.1793796681439; 
 Wed, 04 Nov 2026 04:51:21 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9fafe08sm224736855e9.3.2026.11.04.04.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:51:20 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 09/14] disk: part_efi: Check the header and entry sizes of
 a GPT
Date: Wed, 04 Nov 2026 12:51:19 +0000
Message-ID: <de761f73-a677-4e67-a312-4f33b6ecb76a@gmail.com>
In-Reply-To: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
References: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
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
checks are in validate_gpt_header(), so they also apply to the header
that is_valid_gpt_buf() checks when fastboot is sent a GPT. That path
still takes partition_entry_lba from the header without checking it
against the size of the download, which is left for a follow-up.

Add a test that gives the primary header of a GPT on a blkmap device
each of these sizes, with CRCs to match, and checks that it is refused
and that the backup header is used instead.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v2)

Changes in v2:
- Include linux/sizes.h, rather than rely on blk.h for SZ_4M (Simon)
- Don't word the commit message as if the fastboot path were fully
  covered: its partition_entry_lba is left for a follow-up (Simon)
- Check the header allocation with ut_assertnonnull() in the test, so
  that ut_assertok() never sees a known -ENOMEM (as Coverity CID 661179
  reports for lib_test_gpt_blkmap())

 disk/part_efi.c     |  47 +++++++++++--
 test/lib/part_efi.c | 163 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 205 insertions(+), 5 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index d8751297fbe..85945634915 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -28,8 +28,15 @@
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/printk.h>
+#include <linux/sizes.h>
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
@@ -89,10 +96,11 @@ static int get_bootable(gpt_entry *p)
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
@@ -103,12 +111,22 @@ static int validate_gpt_header(gpt_header *gpt_h, lbaint_t lba,
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
 
@@ -143,6 +161,24 @@ static int validate_gpt_header(gpt_header *gpt_h, lbaint_t lba,
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
@@ -925,7 +961,7 @@ int is_valid_gpt_buf(struct blk_desc *desc, void *buf)
 	/* determine start of GPT Header in the buffer */
 	gpt_h = buf + (GPT_PRIMARY_PARTITION_TABLE_LBA * desc->blksz);
 	if (validate_gpt_header(gpt_h, GPT_PRIMARY_PARTITION_TABLE_LBA,
-				desc->lba))
+				desc->lba, desc->blksz))
 		return -1;
 
 	/* determine start of GPT Entries in the buffer */
@@ -1095,7 +1131,8 @@ static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
 		return 2;
 	}
 
-	if (validate_gpt_header(pgpt_head, (lbaint_t)lba, desc->lba))
+	if (validate_gpt_header(pgpt_head, (lbaint_t)lba, desc->lba,
+				desc->blksz))
 		return 0;
 
 	if (desc->sig_type == SIG_TYPE_NONE) {
diff --git a/test/lib/part_efi.c b/test/lib/part_efi.c
index 82153fdabfd..42de9109360 100644
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
@@ -280,4 +281,166 @@ static int lib_test_gpt_blkmap(struct unit_test_state *uts)
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
+		/*
+		 * fastboot checks a GPT it is sent in memory the same way.
+		 * There a header longer than its block is also refused by its
+		 * CRC, which then takes in the first entry that follows it.
+		 */
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
+	if (!hdr) {
+		free(buf);
+		ut_assertnonnull(hdr);
+	}
+	ret = blkmap_create(GPT_TEST_LABEL, &dev);
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
