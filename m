Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB1E606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vYx1eDSD;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rgLy49RP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B2C781111;
	Sun,  1 Nov 2026 07:02:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mFII7rYO7gK3; Sun,  1 Nov 2026 07:02:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EE12181112
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793516562;
	b=LLlah1YUxvrcPvGgSvgpXOwI8jww/Fi5vYfS+3pzkYv4OLyp5WjI6WWNosWh7MggU9va
	 I2cFbgbWeRAmzi4NIY/M5qZUpdLaQtCVaM3btmk0eJQOGNaNkwUbaoaIUTFTg6WBXZK+I
	 Mqizi8RUQ3bl1coZNSaxO6o8Xl2yFo17S5K+a7sfWWlsZCn3Au4dTXlrdb8ZjmEFsxqVV
	 W+PSQsVyVb69s2bJuQp4PwOuQVePCyd+LF7dh+L5CIB+dl/v1NW06oMqgsAvrDqeDH3Vv
	 wXx0OfiLlZ/0jn5hudL+lFmRjrWqZxAzBaBI9eitOnIbRq023GV30U7G5/8PgWBZUTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793516562;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BG4ovAF8I7ZQBghDYHMcXUwFiT0Vr7iTEz4GO71/daE=;
	b=f/wDavuEbx+X1yhLTXi3NUatpmrEtGHx5aTqxRJ328qHASr6jSkhFV/ozxYUFdqIC6ko
	 N7bdAqPw51/aXJ6b4gSdL//vlVuUcWuTO+x2qsJupuIUp3SSBDoGBjl+KFCQCTS9O6cXw
	 5ixKeRw1JLd9zhIMBnQghoyQD8Wr5O9fc1nhoYuEwmYDPbthwYqBrCzUXn9WUcpe5th1f
	 hAJWWiPhHE4fYV2hHSMfJVUs7ME+yJ1DmIXrpSOmKLti85dKzckKCBt1zH+RS2gCLnisA
	 m+xxoDM99XR/SpuHkdlfcCzFKQMrWYqDFV/f1XqqxT33Bnjn0qRNkkEF5FKS8Re+1LA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793516562;
	bh=BG4ovAF8I7ZQBghDYHMcXUwFiT0Vr7iTEz4GO71/daE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vYx1eDSDnIOLmr7BpuXXrVbuWTi2HHZturcL1sCPfT4h+cvshaoKfPKatMkEIA6ap
	 qY0R+b6HYJ78CXVEH5ywkjH+OnQu+++gvS+urNNaGoj+0171sAj/LFmkOF3v4kWYIn
	 JNF0EgUvsb1Wqva4HRNsMwcOzCDyQ/R/jEMurEXhzBDNe6oEM2nx80sCcZUeo5tgPt
	 SbMi3SDtmIyuU/tHV+GgpQ1HP/g6J/CkUrg/zQs9zNQbTlM+u+If7pSqXx1sFbLI9a
	 QD9D91Tz1uBs5EKl5Nn5dYevy+E7pEuceGaSAp6OSrpX7ongX4VsisBVfJ1uZbG5mL
	 8QGRRuhihUstA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE12181112;
	Sun,  1 Nov 2026 07:02:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF4D3380
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4B90400AF
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RmRj_h9BqQSN for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:02:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 689414004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793516559;
 b=ousJq9IuACf8pzjQkV2R/IA0TawHwfFxdLdsZlXTFKmdV3EGLIZlh2mgXo5L3HScpZQR
 nRhGkGYrnlKTtuwuzSiadp06e3Zez0GgUJA4GUWtEdiHncNOot2ofGQVnXm/n9QryFYN0
 QmOL4XtC5wGsBdvD8Qi3sb2PaeJCyVAOdAsqkdD3tHApHJqJgsGNPY2bh7EmedSmeG9lN
 aDnojLf6fDZc8LyxKTwWpQNoeyUm0BngQUJoQ3+ra7Y4Lu8vlcoNeHkUjXa0ozCctYQ9+
 +65e0EYzS1D9HAfjyfeNl9Nm6FSkd4tdy+aDsX52b4/9F6Pte70uJiNXfRA6YQ0CBwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793516559;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=BG4ovAF8I7ZQBghDYHMcXUwFiT0Vr7iTEz4GO71/daE=;
 b=FySA/7TmYU4uReSHf072RSH6bOwJW07qtm9Bn8zEI0snPj72XAWqbc4aKEku9I1dggyH
 6FGJkKC3NGsu6sREnWmv3tI2mdazw5vCW1AZggQ6T9Tjzi558IspAUFu3v2C8Z1/62FS9
 w1kbrCcN9f36rQ8xNYsBfPunPpBUBpqZ/GnFAYAF1Qr0HO8qpslRgMzwf22U0acYAJprm
 GaF7UsH4BVKLn7jSa5rgo30Ogi8+4VsqQRRXHGXrurM1j84HHtNBNsAY9eCFj4UC9VZbT
 T1kTMsUYSrnEGuFXv8aOKDo2x4+IOBo4fZfJm3GrRanNUu6F1PlUJ1z2R4qfIEXE/vA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=rgLy49RP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=rgLy49RP
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 689414004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:39 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so11357315e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 00:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793516557; x=1794121357;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BG4ovAF8I7ZQBghDYHMcXUwFiT0Vr7iTEz4GO71/daE=;
 b=rgLy49RPU2rYDtsCgj+ZSk9vsjxsYSGqHCInb8CRjfQX3lq1id/1ZYkpGncTk24YUr
 Dj88vVp4c9wQyDmAe2LDxsNvWNpn8YwR0l1E2uuVtNpdUdhMHuyLIQPPfdLCjnoJ7mhE
 Tk7ngOHgC9jGPL6ZF2DcprPMl5A5sCM789nCbCpy+GSrNNdywIoj3m/aOqs6oJOCq4XF
 TH9WuNF7u1YY7uTbAZiX6IyCt1INo3IHIQ10w57tkRyMpjpf1QBbich1cK83q7CCycP+
 mKPtEyhY84rOeEg4Nmk5cstUcP4PzwItM13YyTlT7m1AQbxuxaCaxviss9j4auVYvsZb
 KAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793516557; x=1794121357;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BG4ovAF8I7ZQBghDYHMcXUwFiT0Vr7iTEz4GO71/daE=;
 b=cH3n8EoE0oRNhfsCnQ3e8fysXhrvnEra3ewihkxc5wQWivwelcHTYaoEkNLTIkRkqh
 L62C2KLi74BEAWa+xEIUBb9nD9MdL6QuMZPTjFT0Igumn7Pa1nqyyHD/qm64uTo7yTHb
 LCI8Oyc/s2+CPX9BTOrOHr06LtoY6ELdr/bwUs+2M8qpt92CFfs9eUp0PiY9sAeo88iS
 gLmSvt6HYiSTh3CdFS/hA/ECfxVY68SpOrQrdmVoHhTW2RVJGch5uLXp7r/+D0s/RZVl
 SlnYB1z/qYeXVWqLAOB9DY5xZu4AY7RLBkmUCKIYrmJB118O+i/aZGf6eEhK22dodxcq
 kLLA==
X-Gm-Message-State: AFq9FYKO27IriD2OL7bLP2op5YJckRKFlFECmuBgIoRDfQ29zZb1O0+B
 mUhKxnjuXmEtU1ZLJDAOXTd3XZl0CmAwKg816beZWvWKUKxKiw5mPUMN
X-Gm-Gg: AYBFou3BwardlV1a71KWMyl5DNHQZiepRD6HpMkat0KjZIo1gV621lgnn0XpWF0ggRW
 IEfkJEKzJMefJruWr9Z36MGgvNrFtzzADk88y65V2S0w64P5CguQOwDPoVWbA9ARxP07WeFCqqR
 fN2TGHZ7TxbUFz6eJWGyYqyor4pg3aJQTSXaOqXqdoOLpjrH+RpuogFtJR+4ylmnKAqot6Qniq8
 Kli5O8Mvnqh/BpWCLuvop/BI9QMnfyV1WQLLCWrWcLk53reVTA40xh3piYbLjOhw8RpM6PuL6aF
 yGHenMvpgxT6BEiDWqA4NE5Mgjx+2Q6qqiPUZUUK/zhYLNfv2aBedeC/qJ6YJhYddsvEN5RjNdc
 KTg8KYw275NuNuA/solNMyo3UrjSHN80mklguUZ4kJUugrJhAr+s3mRJag70mB5hS6n6opJN6xs
 K/L6fB6b8WO9wBqSPmrm/Jud8LzXxPkJGBQhfWxdP0E3qd5IUb/QsSADfL5C+guoeR1fBupFfDI
 6dvEJ4gO0cfcSmaPpUyZC4zwNU193F3HIMfM0X8mkYCmEkeTTpqe+F2wpNNjfSr4VHM0tdm9xc7
 5PNj8Oih0zS1zITZFL1nI6MRiQXWauA=
X-Received: by 2002:a05:600c:8116:b0:4a2:150f:160f with SMTP id
 5b1f17b1804b1-4ac1913eecdmr154070075e9.25.1793516557017; 
 Sun, 01 Nov 2026 00:02:37 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa813d295csm254577025e9.7.2026.11.01.00.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 00:02:36 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 09/14] disk: part_efi: Check the header and entry sizes of
 a GPT
Date: Sun, 01 Nov 2026 07:02:35 +0000
Message-ID: <7c1b828a-2961-4c94-b6e9-2263892e9773@gmail.com>
In-Reply-To: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
References: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
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
