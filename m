Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E671606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nLRg08pm;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PByCb3SW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6987180F61;
	Wed, 28 Oct 2026 05:51:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id juRFSSPlM_WW; Wed, 28 Oct 2026 05:51:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 40E7C80DDD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166717;
	b=HE4j8j5nfPKE587vG6Os3qqXjr7IU8ZCHW1/BulrXnExMmdgkLGqR9+TPdQyn6byVOi0
	 TAZXVZBbDlmV2nB3CO8xvNHqXSPHkNY3ID92Uyytxyc4DmzKmo5FoQU8r5O2of5AePRuD
	 e7QTiVDDm11LN/S+SgeAy8tpdSAI4a9ehcOdRJS0cLLHwF7+Idp8KEdDFHZMBOK9hKsII
	 Mdre3DdbYuUXIji5vS6hpdONxTGr/PILxZLQ2OmzL9GceJoN0daxsSmVnaiKRPQYiuoue
	 YkUlFd/Bf9rQG1QCigUmMld0NxtPe8gN8Zxz4Cu44esyV6xADYjtmIYrpRv5v3nD2QQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=coObINQQcBv3AoF10OouBl8ccqZsMHDH3PZ6OmZ2Yww=;
	b=fa5Dcg0hdOzEjAAkkqf/+tu8+Y/G7GtrSqHvxuySB8ixqlKLnghaaizZEnuGKO5oe94D
	 u44JyMExafuvXmb/3HWUHKwxQQEN0Wapg///R52rHucwqFjy1cKixtGEokAOPY60UWg4S
	 mxl4mcu+PneZ4gs+Ud8gNY5VYLIJOe+vOlRu/75+XOr1QUNEflROwqDLlUIYv1s6J1UaP
	 ubgdBBjj8Ou7Qh4Y5YNSrQIhgnmLElWyGoCEuXQ7H23b3uKeiIhP3dDmahgCsnt5wI+ZL
	 jP8MsXzcKPm1OgZ0O9qIEpaCHq5EC86J2nQFBN/IxBeZt8OJv9r7ca3HRbpeY0wtJhA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166717;
	bh=coObINQQcBv3AoF10OouBl8ccqZsMHDH3PZ6OmZ2Yww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nLRg08pmMRGiSw6bLshFWikb5wzQv6CqD0z+0hsw/3TXqnCfD+dAMk1PAg9S/CduT
	 ezDGmwk0mq2aZaMgQWdMeW94jrBsR9mhU7JaHosWThGotVG7i619lW/uM6lJX9KRSE
	 yNUoW6rbZuaHnj4CAJieKg7kL5cx+6aOHZIRt+JEP8JNCSNWCLPJn0JkO5RyLi8Ikl
	 Q+3rYNFlJwTPT2uCBVf3DAWbvbcf+UQ9Dp+mSySJGg2608zpdhw8ak3vrU/gPMf3Wu
	 NzenZiOpgcRAyyi/skYwB4MHvL4WATQ/gDewS0WWwL4vi+8A4/E7aNs5pgSZ5pEEWK
	 Yff1/+lxsJPsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40E7C80DDD;
	Wed, 28 Oct 2026 05:51:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B69F3D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B43754016B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2dvx_wnDenN9 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:51:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6198F4006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166714;
 b=nQrTeivuSyRYk/F1ZzLVt1NChfIo5tB9Wt1Owq1e4sCY2t9MvIQz1uAXcqlZaV31l2cv
 Bs6hGlhCxKMuowj7JehN8WYrR//oPDM1SYpS5RuXIqnKresBF22uY/OPl8l59eFn9GJ0P
 MPjSz/GW2lA5/TpqWhmXEdqeBuvKKbd3mq5GAX2DX1RymguanCnlRigOst+SKRRYOX239
 mtuI9KUAZb6gBaEJpdDqRo7FJ9ZyuonpgGFz7hnpBWkTo2Nam7tv2GyHDQesgyefs6ER1
 yV7xVCPI3e/hVo0Ws4aHqHXqIxodafyKRmLaj5AjFQgn+duDrLqCpVf7/YRaQELMTxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166714;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=coObINQQcBv3AoF10OouBl8ccqZsMHDH3PZ6OmZ2Yww=;
 b=EXuRfNZW5Su/yW4IjzsId1iT7XEifW2qwc23o+g4g3xsonmb2WCdonHn9XNBRKaBiFon
 gB18YChgeXf5G1XwW/Q7LCniKIrhBvlN5bmz6lT1rZ7xYYQHLdkeRtDqSEYJaC+UZP6Vb
 jQLqn+H96Zc78fiI+hQHMH7skcmd3UtBwFndH4pOsFwhRGTBpnrO/JXxHZMryYP9MbIMT
 H1dqzg8b6lougwbvNaa9T4Rmmi4AURcb6FzXhd5C0dX8PUZGDQbGm0zCnvuJhenMonmDm
 njEwOySRvL4yf1Oa5Bwj2Jh39w4f2O8bmgef9OD6bWdHcyCtPu0OxUjH1FxNi1vUMww==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=PByCb3SW; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=PByCb3SW
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6198F4006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:54 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so344426f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166712; x=1793771512;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=coObINQQcBv3AoF10OouBl8ccqZsMHDH3PZ6OmZ2Yww=;
 b=PByCb3SWuC5hsHUatlLXk9/oqJvubRWZxpmKSueX48DPpfjYgDX8jFTkd7jf3+yPbi
 GUPrVI2m0nQDuIlASrEk1PeVqmjdSsI62cYGxtNQinfVFztpxG6853mPOf/PEZKlV1I2
 G3cpxK2s8fJ+Ud0OIKhe8RXpBMtQURXoPKOskoe2hSuaAywW+vUWU5SJIi8uING4t4Xc
 XMvTnhG/brnutYddX5qOmwD0mF0ADpPKoHxRjRLH+odbuEicW2I0J3emY+mOFn3Yhrzm
 dsQcdO6XOlYiqCD1txvTOXYP/jshuoAL9MraLTy3sQ7dFivkmBrdmsAEV0aXYrh5+N6w
 IO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166712; x=1793771512;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=coObINQQcBv3AoF10OouBl8ccqZsMHDH3PZ6OmZ2Yww=;
 b=JOKnaQo4zCBjaR4E8tyA9ZqdxprRbjtHoPIuLGjzD0xXidBgrp3v9xAapBNEUjcYoI
 Htd4V3Kb0Z9aqVYQA1GQrRmqYWgjLwww1sxrGjINBtjq8X+rjcSTLqse4Y5GowXrMeDz
 EXKRMyyy6LYM4MurE5+BBmAQdNHVx2e99vwRXfn3oWRKQN0/+aq6C6SEukPsQKUJkcd8
 NscE7M7ahCmox2hT+ZgZGLuXvzNk4nvpN2WRWWiy9PtPetpTRCiKW8ptLXNvjji/85Ox
 GTxDt8iyrt0GL2+cE8HtSupRItk2/b7QreVikZn6cFOP5lAvWzPl0B8lPaLY8m95OGum
 1/4Q==
X-Gm-Message-State: AFq9FYJJ5D/WwgjSRKV7tRa7q5UWFIqp0KfCRmLRmJ/Hnj6psncP3Qs7
 u1+VaAOuX5mNmF6aUjCrxCxjxjgynr/i5ZrXvR3BN0z6RdAhZ9lKirMf
X-Gm-Gg: AYBFou1/xEPGoAtGQENGz70ELVKXdfzxJssVawm9YpIny7do6ndFf3gmhaxTGGVc2av
 7oQkOiUOBobrSLgktjr7MzQYOlJMk3eZSgd/Rn2hbNpcn+2mvb8URmp0kSSjhatN9oHW/q6Zc10
 69cSwq8FqHObe8Xquy3hNMSmxqS2mKOaIrVX1xNawmP4wJwPvFuIu3zDqxGHkIhCIqvAe1IYvx5
 xkjZW0ry0zAh/AIYnIforZczFEZGTlZeDeSeZeVQ6721ygTMs3mHoEwdNa+Y44zRJEDJjX6RKS/
 Iz3ZkyECxAwhws4vVe6Y+bJz/yk7FJZ+BetwYlt6Jy5AwRjz1tgVdjnXppEHxA9YVW9YHagmwAR
 wNOaHPFk4q1Qu70544Cl8CTTAP13GjTSpICrOI5UTtSCzOaHZDGNLERURySfVlEvaFeq5YwtaZG
 mHDkSr0A2lfv26YQ1N44uxpIR5fLnhgzMw8aw049vTZVw6Eg2UewJCu2gxtpXdFCnQN1fH1qXRT
 nG/nr0StsQ5nvhxJE+euWEwTcxz7ApUG/11cKYKTSsMV9t9DXO7NZBlmgSEnMpuPRCQDBo/ci6T
 8n7vw0L3bJuUAatkytFL1N81R8GQ3Gl3ve8mYSqtKJw6a9o+A8Gi
X-Received: by 2002:adf:fc8e:0:b0:48d:faf4:54a8 with SMTP id
 ffacd0b85a97d-48e5d58f76fmr2433440f8f.11.1793166712134; 
 Tue, 27 Oct 2026 22:51:52 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb9cesm27667902f8f.27.2026.10.27.22.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:51:51 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 09/12] disk: part_efi: Check the header and entry sizes of
 a GPT
Date: Wed, 28 Oct 2026 05:51:50 +0000
Message-ID: <7a66f202-37b4-425c-9c12-9ccb10d68c2f@gmail.com>
In-Reply-To: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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
---
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
