Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0822606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UMa6SuSW;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fSsfCokx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8227560AAA;
	Sat, 24 Oct 2026 12:17:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 88PAM10ABDsf; Sat, 24 Oct 2026 12:17:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D2E9560AEC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792844244;
	b=UWWnHj29UeBDTrgiWbyHNdImvjauAlesjWCQWq3nJSxrVIHJB/mfX3bDhcofiutUG2WL
	 fOtIh54hfxtjCcv/aiiF80+6kWwLNbx6ZHQr0jTOwbzKsfW2iXgUM/0LA0Ve3yml141F3
	 w/78ImhW4PIlxBVlx3XoCb6qXnS2gIoa2hRYcaZDS8Nyg1OsIsvwVjo/4LJwJAjrFrFWi
	 moW39tUU3E4FHy/ULOJgoZJCR/3cF4OC+CjbUpXo0exJILFUTjIF2DGYba8JiBj9B0XNy
	 hgKimjKIW8KMjwz93uhS47TZShcaWUdouoHQVVrBDarQGOfYQ9czpqFzCfQW/m5KTtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792844244;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KB5N1DoBeFTaiC6lwPbToL9FV673HfBqgrQ0mf/H4XE=;
	b=e/R4hDrKgm75Jc7b92MFotUTq9GrBne/Ap+fxDwUK7LtPPNtDzSjoFKZGe09rsXv5FBx
	 zopqvPOnHJAS/k8gwTyP0s1C6+cWzHRfYqwzTPxE6CkcBYka/MKSWz6FA19hkUAhLRpsY
	 RobRFPgfGrlB82XtUhsOVkj1zZOlV1HSwMsvNk6n5jfpwFNd1laTXESv/swc1GzhzIf84
	 jdxZkjkf08Yh6DTEWjdds1T7vQF6ZrLDspAUwnXgA3zDj8bbG6TA2sxGSz5cZhcts6T/C
	 ubhOub7Mh8qOW6CRkCWxzzf1WyxjwL+Jb9iezRLTk2G3XVhK4dMur1H/pkfKjEtTnqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792844244;
	bh=KB5N1DoBeFTaiC6lwPbToL9FV673HfBqgrQ0mf/H4XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UMa6SuSWcl2+rnWdq08vdv+we+tuwTWRbU1FBP+txhx0E13+Ovgc2R3GjlPaknPq5
	 Zcz4jvW9AMetFFLox/EN6UqOpkvj/bz4LH4FDJv5fBbI97MIRPJEAH3nl6f5Vy5SBD
	 hkO8Kx5hQCvc8M0cILifLabXIlIrozTXMvZsKIV7XqQpYKYbjhxMdGHDAhbDrdSOZX
	 bhBNLHvPAwHmjf/p19Ixg5RdchsRVF0u7qheVryt2pdAFZEOKwZRjyzcitnsQOqACa
	 UuBWJVnDJlQPGF7Mej/9pnFrZ5DvjwPHtipUU+xd60ikqHn676Py+BTNQ/6e9hp3Db
	 iejO1YAWzPOnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2E9560AEC;
	Sat, 24 Oct 2026 12:17:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A30FE43
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94D25400E0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uYroG913B_1i for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 12:17:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4286A400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792844241;
 b=ca7B83umLQiZYCdTDd2BnGiDPdFZDnp0sq/bBrwM7bPEgloy2DTn6CydJ68vEuzTMRrZ
 gNGggVSOdDhgaXYlVXOlrCexVjxjaPgyD9CNCXmAJkC47lNSAmI+muJi6NmpltKfjzTZ+
 rZXIUj9A9HCGLQe+5jq4egyBy5S2zu6xqxxp5GAPgAZ028QGne51qWQ+6LhL7NUv9a5B3
 BUNDgbc3I5n0l3MdutzGRzIYS4tO0TwfLIhCNKXjgi5wJY9EglW2lwKst5Iz5FATkATI7
 v6vW0Aa6FdYxVBufLc+e6t/KT1frSmIe9p0qCTDAESOGSqCYfqdPZbShAEZGo2USL4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792844241;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=KB5N1DoBeFTaiC6lwPbToL9FV673HfBqgrQ0mf/H4XE=;
 b=rYyj0m1Ez6N0o4yk8mYP6HynKq5yHh66kPE1kE9wH+qBgj7XmMNeOO4oUAhIiq1d2jXR
 BXRiYrp2Bsj3agsDllxAsyqvzA4Dat2yM335MX9TePJxH4vkMiJG07ekunMYaE2qrMXY1
 /rBhkqImlIeB9QWPTKgOvyfQFcZOyXj8+AhfWKYO3j3VXMwQclDjljFyL0LE85aSXFWD/
 NF8/ODvOZI4h8KyRn5WcKm0TAuL9NHnqiZhQwP6xO7TykARnHGIQbjU5TiiWwyzNusESU
 yWSqU0LmDCZKAkfiy4+bc1NShHjp+jelR6V410+Tooz4/rr409KZz4cRBY5T3f1XiQg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fSsfCokx; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=fSsfCokx
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4286A400D5
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:20 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a20b122af8so13915485e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 05:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792844239; x=1793449039;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KB5N1DoBeFTaiC6lwPbToL9FV673HfBqgrQ0mf/H4XE=;
 b=fSsfCokxQwyYEGcg1p8kZE03a+ILPGYfoKIPlBsuoq+FdhBF1yGM+kONQO95Tygj2K
 Ha9A8egPv7vN+ehTWfgzzJSn81JFM9GvKM03rGCtY+7Jz0hCRwunZsgtbSwWwvpFDrJz
 AA28p3Ea/vxFMvh7dXbz7hdP1dp0V5BxZIyKXN2OVven/q/tAD664+v7doovL0V4TJgo
 s3byVWslET+LDO3Vx93K97yVjJOTnj5x+i2ezyR43zU5//cXIl30xoKGitEKfnEnQLD3
 SetkP3u5HrbMFdx9Rbz5uBsLrvLYlXuU0RM+fIwtL/rcib2OeY+3SpkeYUXzid1c7F1Z
 W/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792844239; x=1793449039;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KB5N1DoBeFTaiC6lwPbToL9FV673HfBqgrQ0mf/H4XE=;
 b=jarhREuv9xcdObIzZnHr1vFGPEEvRuMnB5qGqqY5wVHxsr5HpUxcWiAw67B5qdg3Dc
 KqNjc0w6EuB8zEOBOWIstn098yLlbedOewJ0ncdt/wZF3wuZvFbj53IjFW5vo97u0JHu
 rsoN1O5Ah3LZQQSToryxiKhHQuLB3Zrw25k/fn88daTW7i8oSaumaHdBHbRJIrgWq9CL
 JmwlnpSDDBTrC3sFMDOI8Kwqi9L1Mm9kuDvedjkMhdHk9E1F5ESYJJix26elQRH5yajS
 Jt/2HHo5AnScQbXremOQwCD0PLNpx+VGM3TYyeszaotwB9VXPwkLigEZclYCgN6m5qcU
 jtPA==
X-Gm-Message-State: AFq9FYKPe/AUKVqqGlS9ZGzfn3MyAuulvO2AjaNXLO2qfBboPcidQo3p
 hGTfEy33dgtsy4ba7iRuc8oWEy8nyBOnIZoTHHFqTJ9TcpbwtYECKmHZCUBiG5Gh
X-Gm-Gg: AYBFou0Kb28mOTrDKA/ILMgbjSyt5ekc2eYV3BSwNowg79MSnQjmkFwUCe1LRlVoZ6x
 k63y2V8fye1lSLQKjYwNZI/9Ne7dsCseQhaeAzrpg1fJ7+x+kpsmGGxAufJ9TXma2HDTXRv1yYx
 MXwUPvrjkvHTrnNkLo3XEGytmrwERjhfkvA6D8N21CGeeQXYgkdzcZhdP+sNTk0mW/SDaCtCCWc
 h8kKZitSEJQAD/MF8pPWdyOLENf1XlpfKSFff/fyqVRqTeYtXcYmKe/ZOdYw80qkG28zOrgweTt
 d4z334yhAoF/ycLG36zkWUUP0FbV0bnLcg+9NPedixweQI+v0UANu1qkapj6w+3xxV7Z3d3iCOB
 bHXmFfFO/Wr0YgLSGLykBtviY5TYQ2F5eLFBPFUJwQk5RRufGe5XReEbcjy2tRpriC6qGQsV8cO
 xye0gBFRdCnFhaTdsoTSRfaTGjf6XwhkMMY7Z7QO7eGp0bNjlRe2TJaqKCF+/vvVYm8UPKOa3Yd
 XFuo4ycMkPsmYwQZgp+LoDq7jSjsEREEJXhZfgI3geRKxBcnAZ+e+OfsA==
X-Received: by 2002:a05:600c:6094:b0:4a2:1612:637b with SMTP id
 5b1f17b1804b1-4a35acc7532mr26933425e9.33.1792844238968; 
 Sat, 24 Oct 2026 05:17:18 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a30e22csm51248045e9.2.2026.10.24.05.17.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 05:17:18 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH RESEND 9/9] efi_loader: Check the GPT header before measuring
 it
Date: Sat, 24 Oct 2026 12:17:17 +0000
Message-ID: <e7aa5f28-e3b6-4b52-9019-1136d4ef7a82@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

tcg2_measure_gpt_data() reads the primary GPT header of the disk an EFI
application is started from, and uses num_partition_entries and
sizeof_partition_entry as the header gives them: the entries are read
into a buffer whose size is their product, worked out in 32 bits, and
then walked num_partition_entries times with sizeof_partition_entry as
the stride. Nothing checks the header first, not even its signature or
CRC, so a product that wraps, or an entry size smaller than the GUID
read from each entry, makes the walks read past the end of the buffer.

The partition driver does check the header, in validate_gpt_header(),
but when the primary header is not valid it uses the backup one. The
partitions of a disk whose primary header it refuses can then still be
found, and an application started from one of them gets that refused
header used here.

Export validate_gpt_header() and check the header with it before using
its sizes. When the header is not valid, measure no GPT event but return
success, as an error would make efi_tcg2_measure_efi_app_invocation()
skip the separators. EDK2 likewise measures no GPT event when it finds
no valid header (the checks added for CVE-2022-36763) and still measures
the image. Its partition driver restores a primary header that is not
valid from the backup, so that the restored header is measured; U-Boot
leaves the disk alone, so no GPT event is measured for such a disk.

Add a test that starts an EFI application from a GPT disk on sandbox
and checks PCR 5: with a valid GPT it holds the GPT event and the
separator, and with a primary header whose entry array comes to one
block in 32 bits, only the separator. Without this change sandbox
crashes in the second case. Call validate_gpt_header() directly in
lib_test_gpt_sizes too.

Fixes: ce3dbc5d080d ("efi_loader: add UEFI GPT measurement")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 disk/part_efi.c                |   4 +-
 include/part.h                 |  23 +++++
 lib/efi_loader/efi_tcg2.c      |  16 ++++
 test/lib/part_efi.c            |   6 ++
 test/py/tests/test_efi_tcg2.py | 170 +++++++++++++++++++++++++++++++++
 5 files changed, 217 insertions(+), 2 deletions(-)
 create mode 100644 test/py/tests/test_efi_tcg2.py

diff --git a/disk/part_efi.c b/disk/part_efi.c
index efb6756cf2c..dc379559b4c 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -94,8 +94,8 @@ static int get_bootable(gpt_entry *p)
 	return ret;
 }
 
-static int validate_gpt_header(gpt_header *gpt_h, lbaint_t lba,
-		lbaint_t lastlba, unsigned long blksz)
+int validate_gpt_header(gpt_header *gpt_h, lbaint_t lba,
+			lbaint_t lastlba, unsigned long blksz)
 {
 	uint32_t crc32_backup = 0;
 	uint32_t calc_crc32;
diff --git a/include/part.h b/include/part.h
index 1dc510cb6b1..a886a46ae18 100644
--- a/include/part.h
+++ b/include/part.h
@@ -680,6 +680,29 @@ int get_disk_guid(struct blk_desc *desc, char *guid);
  */
 int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e);
 
+/**
+ * validate_gpt_header() - Check a GPT header read from a disk
+ *
+ * Check the signature, size and CRC of the header, its own LBA, its usable
+ * LBAs and the size of its partition entries. The CRC field is zeroed while
+ * the CRC is computed, and then put back.
+ *
+ * @gpt_h:	GPT header, at the start of a buffer of @blksz bytes
+ * @lba:	LBA the header was read from
+ * @lastlba:	number of blocks of the disk, which no usable LBA may be past
+ * @blksz:	block size of the disk
+ *
+ * Return:	0 if the header is valid, -1 if not
+ */
+int validate_gpt_header(gpt_header *gpt_h, lbaint_t lba, lbaint_t lastlba,
+			unsigned long blksz);
+
+#else
+static inline int validate_gpt_header(gpt_header *gpt_h, lbaint_t lba,
+				      lbaint_t lastlba, unsigned long blksz)
+{
+	return -1;
+}
 #endif
 
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 5f9bbe97455..c858e8df6d7 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -16,6 +16,7 @@
 #include <efi_tcg2.h>
 #include <log.h>
 #include <malloc.h>
+#include <part.h>
 #include <smbios.h>
 #include <version_string.h>
 #include <tpm_api.h>
@@ -1220,6 +1221,21 @@ tcg2_measure_gpt_data(struct udevice *dev,
 	if (ret != EFI_SUCCESS)
 		goto out2;
 
+	/*
+	 * The header gives the number and the size of the entries read and
+	 * walked below, so check it with the partition driver's header check,
+	 * which takes the number of blocks of the disk. If it is not valid, the
+	 * partitions may have been found through the backup header: measure no
+	 * GPT then, but return success, as an error would skip the separators.
+	 */
+	if (validate_gpt_header(gpt_h, GPT_PRIMARY_PARTITION_TABLE_LBA,
+				block_io->media->last_block + 1,
+				block_io->media->block_size)) {
+		log_warning("Primary GPT header is not valid, not measured\n");
+		ret = EFI_SUCCESS;
+		goto out2;
+	}
+
 	/* read GPT entry */
 	total_gpt_entry_size = gpt_h->num_partition_entries *
 			       gpt_h->sizeof_partition_entry;
diff --git a/test/lib/part_efi.c b/test/lib/part_efi.c
index c8fdfe2f41c..e2990bdb0b5 100644
--- a/test/lib/part_efi.c
+++ b/test/lib/part_efi.c
@@ -366,6 +366,12 @@ static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
 		ut_asserteq(1, blk_dwrite(desc, GPT_PRIMARY_PARTITION_TABLE_LBA,
 					  1, hdr));
 
+		/* efi_tcg2 reads the header itself and checks it with this */
+		ret = validate_gpt_header(hdr, GPT_PRIMARY_PARTITION_TABLE_LBA,
+					  desc->lba, blksz);
+		ut_assertf(ret == cases[i].ret, "case %d: header check %d\n", i,
+			   ret);
+
 		/*
 		 * Read it back into a buffer as large as the one above, so
 		 * that a header longer than its block is refused by the size
diff --git a/test/py/tests/test_efi_tcg2.py b/test/py/tests/test_efi_tcg2.py
new file mode 100644
index 00000000000..ae21ff76da8
--- /dev/null
+++ b/test/py/tests/test_efi_tcg2.py
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+"""Test the measurements made by the EFI_TCG2_PROTOCOL on sandbox
+
+The sandbox TPM starts with every PCR clear, and the events measured when an
+EFI application is started (boot variables, GPT, separators) are only measured
+the first time one is. So each case restarts U-Boot, starts one application
+and checks PCR 5 against the events it should then hold.
+"""
+
+import hashlib
+import os
+import re
+import shutil
+import struct
+import zlib
+
+import pytest
+
+import utils
+from tests.fs_helper import FsHelper
+
+# EFI System Partition
+ESP_TYPE = 'C12A7328-F81F-11D2-BA4B-00A0C93EC93B'
+SECTOR = 512
+
+# Fields of the GPT header, by offset
+GPT_HEADER_SIZE = 92
+GPT_HDR_SIZE_OFF = 12
+GPT_HDR_CRC_OFF = 16
+GPT_ENTRIES_OFF = 72    # partition_entry_lba, num_partition_entries, ...
+GPT_NUM_ENTRIES_OFF = 80
+GPT_ENTRY_SIZE = 128
+
+
+def extend(pcr, data):
+    """Extend a SHA256 PCR value with the digest of some data
+
+    Args:
+        pcr (bytes): PCR value before
+        data (bytes): Event data
+
+    Returns:
+        bytes: PCR value after
+    """
+    return hashlib.sha256(pcr + hashlib.sha256(data).digest()).digest()
+
+
+def make_gpt_disk(ubman, fname):
+    """Write a GPT disk image with helloworld.efi on its only partition
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        fname (str): Filename of the disk image
+    """
+    with FsHelper(ubman.config, 'vfat', 1, 'tcg2') as fsh:
+        shutil.copy(os.path.join(ubman.config.build_dir,
+                                 'lib/efi_loader/helloworld.efi'),
+                    fsh.srcdir)
+        fsh.mk_fs()
+        with open(fsh.fs_img, 'rb') as inf:
+            fs_data = inf.read()
+
+    # 1MiB for the primary GPT, the partition, 1MiB for the backup GPT
+    with open(fname, 'wb') as outf:
+        outf.truncate((2 << 20) + len(fs_data))
+    utils.run_and_log(ubman, f'sfdisk {fname}',
+                      stdin=(f'label: gpt\nstart=2048, '
+                             f'size={len(fs_data) // SECTOR}, '
+                             f'type={ESP_TYPE}\n').encode())
+    with open(fname, 'r+b') as outf:
+        outf.seek(1 << 20)
+        outf.write(fs_data)
+
+
+def gpt_event(fname):
+    """Get the EV_EFI_GPT_EVENT data for the primary GPT of a disk image
+
+    Args:
+        fname (str): Filename of the disk image
+
+    Returns:
+        bytes: The header, the number of partitions, then their entries
+    """
+    with open(fname, 'rb') as inf:
+        disk = inf.read()
+    hdr = disk[SECTOR:SECTOR + GPT_HEADER_SIZE]
+    entry_lba, num, size = struct.unpack_from('<QII', hdr, GPT_ENTRIES_OFF)
+    entries = []
+    for i in range(num):
+        start = entry_lba * SECTOR + i * size
+        entry = disk[start:start + size]
+        if any(entry[:16]):
+            entries.append(entry)
+    return hdr + struct.pack('<Q', len(entries)) + b''.join(entries)
+
+
+def set_num_entries(fname, num):
+    """Set num_partition_entries in the primary GPT header and fix its CRC
+
+    Args:
+        fname (str): Filename of the disk image
+        num (int): Number of partition entries
+    """
+    with open(fname, 'r+b') as outf:
+        outf.seek(SECTOR)
+        hdr = bytearray(outf.read(SECTOR))
+        struct.pack_into('<I', hdr, GPT_NUM_ENTRIES_OFF, num)
+        struct.pack_into('<I', hdr, GPT_HDR_CRC_OFF, 0)
+        hdr_size = struct.unpack_from('<I', hdr, GPT_HDR_SIZE_OFF)[0]
+        struct.pack_into('<I', hdr, GPT_HDR_CRC_OFF,
+                         zlib.crc32(hdr[:hdr_size]))
+        outf.seek(SECTOR)
+        outf.write(hdr)
+
+
+def boot_and_read_pcr5(ubman, fname):
+    """Start helloworld.efi from a disk image on a fresh U-Boot
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        fname (str): Filename of the disk image
+
+    Returns:
+        bytes: PCR 5 after the application has run
+    """
+    addr = utils.find_ram_base(ubman) + (4 << 20)
+    ubman.restart_uboot()
+    ubman.run_command(f'host bind 0 {fname}')
+    output = ubman.run_command(f'load host 0:1 {addr:x} helloworld.efi')
+    assert 'bytes read' in output
+    output = ubman.run_command(f'bootefi {addr:x}')
+    assert 'Hello, world!' in output
+    output = ubman.run_command(f'tpm2 pcr_read 5 {addr:x}')
+    assert 'PCR #5 sha256 32 byte content' in output
+    digest = output.split('content', 1)[1].split('\n', 1)[1]
+    return bytes.fromhex(''.join(re.findall(r'\b[0-9a-f]{2}\b', digest)))
+
+
+@pytest.mark.boardspec('sandbox')
+# EFI applications are built with the sanitizer but cannot run with it
+@pytest.mark.notbuildconfigspec('asan')
+@pytest.mark.buildconfigspec('efi_tcg2_protocol')
+@pytest.mark.buildconfigspec('efi_partition')
+@pytest.mark.buildconfigspec('cmd_tpm_v2')
+@pytest.mark.buildconfigspec('bootefi_hello_compile')
+def test_efi_tcg2_gpt_header(ubman):
+    """Check that the GPT is measured only when its header is valid
+
+    PCR 5 holds the GPT event and then the separator. A primary header that
+    the partition driver refuses gives no GPT event, though the partitions
+    are still found through the backup header, and the separator is still
+    measured.
+    """
+    fname = os.path.join(ubman.config.persistent_data_dir, 'tcg2_gpt.img')
+    separator = struct.pack('<I', 0)
+    try:
+        make_gpt_disk(ubman, fname)
+        expect = extend(extend(bytes(32), gpt_event(fname)), separator)
+        assert boot_and_read_pcr5(ubman, fname) == expect
+
+        # an entry array whose size comes to one block in 32 bits
+        set_num_entries(fname, (1 << 32) // GPT_ENTRY_SIZE +
+                        SECTOR // GPT_ENTRY_SIZE)
+        expect = extend(bytes(32), separator)
+        assert boot_and_read_pcr5(ubman, fname) == expect
+    finally:
+        if os.path.exists(fname):
+            os.remove(fname)
+        ubman.restart_uboot()
