Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C555C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 10:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06627406E5;
	Mon, 27 Jul 2026 10:09:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E7PiZ9a8FBWz; Mon, 27 Jul 2026 10:09:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74C5140621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785146950;
	bh=zteAOsqJsK5DA+CEKjm2UV8bh/Z+8mF2vMRsz3VrQTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GtrZQIvt6YLvmCJHfO1gsEEw1y9pD+9u9L6jI/KylZQnwWXmU6X9X58jrfDjy1W9p
	 d+q51QpCtn1cProW2GxC4wXDFjHLuvqGF7DttkiS/GT13rsXCyRIXUSvEZyrCr09LY
	 /7tU5pLGrbG6Ks51feJmWYvVWSoW/EHb2rB+LWxKm145s0qLKUFRU8FDJSqmW1r6W4
	 Q0cjFngZxuwa6RhV2g+DHCS18rQ8BI/za1zC/YCNP8tk1yGC3keOxrzGubf7W80ggw
	 C+VN/8ZLemi+L9n28Ca/i3QD45dgwiJb/e4w/NERkMn5tvZJj9nKx8okx8jMORKZtC
	 ACs6DWwRaonmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74C5140621;
	Mon, 27 Jul 2026 10:09:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FF5D39E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1014880D66
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:09:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l5QCLEPM8P5V for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 10:09:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=igor.opaniuk@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 90F0B80BCE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90F0B80BCE
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 90F0B80BCE
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:09:02 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so21251935e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 03:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785146940; x=1785751740;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zteAOsqJsK5DA+CEKjm2UV8bh/Z+8mF2vMRsz3VrQTo=;
 b=DuuixHuRwpAnd8SZYtFBUxX54P5dKWiBNxroUoDxzv0VLlhKwecKCvw5czWMfNCDm0
 UcupLZQKZHHuApUTcdKttc370sfl3R1PXhUcdiCbvRd4k2OJCHcIoQPwzbogXK5HBD1P
 jE7kAtRLXTaYu/rKzHIJTWmhJ4PKBtFWOMb7qdKD8f/lpNPEIiuWuwK/I3b6h7AQuzEG
 +jsZmjymSiUHQC+cLg2xf2bgC92HZJCNCMui7oJoeoC3c6+HNDenAsxX8VC1x8tDAKOX
 xDOdtW2TofVEfKR4z+DbptQcimz/FEaXuZ2F+x5Rr//0ngPgBahmQ0Rf9WbS3DMQxUl8
 BilA==
X-Gm-Message-State: AOJu0YyGEqSat38Xczc3UpHiVyEaZVnwG0YCDhyV/WjL2RshO9Z7Sit1
 6w/wMYSR9+Zwai5pqmYWR+aKVcaS5lGdqu41relKraU/3WmvAo5d+mrl
X-Gm-Gg: AR+sD119qw5JH3XkXydc4D+rJJq+HCAkPqmRjVPs9mAkXD8ZySDZtbbsWSxAYe/JZcs
 We1vWgV7tZEU9YVROmHlYXGcSqDynLzWwdBIvuNPYno8+T24ktUq4neWvgHn1g4HbcXZknTTii5
 hNInHv7jU0aSsR5O6rw7ZAx5XwC92z3g6Qccq7l1bWiBbZ5jhFV9nSRZPaT3tmq3GC0egZ6uKmp
 thEBvKiV0/T0p76aXrpMOK5kUGQEWeiTfJq3KP+/AS/mY9iPYv97l3DJr/MeBsbBFs/xvkQHQ/f
 MX2HRbHk+9Pb6/pK5MXz7kEPQsbe+vLOKY0aJumpXLJkn/xecOR1PzS1c3e+1hrlxHZaRq/sO7H
 EKWaG2zH1rcRX4ip03ZZgARlTbYgdjc4FZh+IFbBW9x34lsp6uhCt1hi2nt5sR1fsl2wNG98T70
 xBgxHRa5zJZyOjVcFkrXqVRyOS//HKNNtEKSq9xVByahjDuHSd/uCqBto64CJpCEPkOw/jLQ==
X-Received: by 2002:a05:600c:b90:b0:495:4732:1eb9 with SMTP id
 5b1f17b1804b1-496b570d870mr102898885e9.21.1785146940100; 
 Mon, 27 Jul 2026 03:09:00 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f5665f0sm256805375e9.0.2026.07.27.03.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 03:08:59 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 27 Jul 2026 12:08:53 +0200
Subject: [PATCH v2 1/2] libavb: update to AOSP 1.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-avb-libavb-1-3-v2-1-fcad1a79af24@gmail.com>
References: <20260727-avb-libavb-1-3-v2-0-fcad1a79af24@gmail.com>
In-Reply-To: <20260727-avb-libavb-1-3-v2-0-fcad1a79af24@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785146940; x=1785751740;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zteAOsqJsK5DA+CEKjm2UV8bh/Z+8mF2vMRsz3VrQTo=;
 b=peW9aTnH08yYV7peI2/Gg+/r+TB6PZh/ePJBGNSpNYPuRymA4zik2ttFqJ0laCaL2q
 GNdybA4YOL1snXazPCjUp85CkOzeBOyD0yLCIXtg2KlsSENl1HWNkVX/vi42CyO0bOJV
 9Turl9jvDUQSyYzz5rFBBg5QScNkN9EZh9R2FEFyFzsll/ERyjuu2s+3bhvULvYtThZF
 JSCoV7VJvdmgz4RBTbKRU7r9sLBni/+EavlKq+zT1lGcqCrP6rpsx3U6sHTBMzke0pMa
 9Pq4pakHvE3sDBE1nW1X+NnrhPN6unQa+Hd6rp+dlKnAhliycuOIUuPq9uOti8nQTv8k
 xj3w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=peW9aTnH
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Re-sync the vendored libavb from AOSP external/avb, moving from the ~2019
snapshot (v1.1.0) to v1.3.0. v1.1.0 rejected any vbmeta whose required
libavb minor version was greater than 1 with UNSUPPORTED_VERSION; this
lifts that ceiling and picks up the accumulated upstream fixes.

Synced from commit a1fe228b8654 ("libavb: support chain partition no ab"),
which is where AVB version 1.3.0 was introduced; the vendored files match
this commit verbatim except for the -Wstrict-prototypes fixup noted below.
For more details check [1].

Functionality now parsed by the library:
  - AvbVBMetaImageHeader.rollback_index_location (v1.2)
  - AvbChainPartitionDescriptor flags / DO_NOT_USE_AB (v1.3)
  - AvbHashtreeDescriptor FLAGS_CHECK_AT_MOST_ONCE
  - AVB_HASHTREE_ERROR_MODE_PANIC

The AvbOps callback set is unchanged, so the integration layer in
common/avb_verify.c needs no changes.

U-Boot-specific adaptations are preserved rather than pulling upstream's
BoringSSL-oriented crypto restructure (sha/, boringssl/): the U-Boot port
in avb_sysdeps.h / avb_sysdeps_posix.c and the flat avb_sha.h /
avb_sha256.c / avb_sha512.c are kept as-is. The SHA API signatures are
unchanged, so the retained implementation is compatible with the updated
code.

Imported files keep U-Boot's SPDX-License-Identifier header style
and their upstream per-file licenses (avb_rsa.c stays MIT OR
BSD-3-Clause). The unused, Apache-2.0-licensed avb_crc32.c is not
imported.

The import keeps U-Boot's existing local fix from commit fbfcb614e05
("libavb: Fix a warning with clang-15"): avb_new_cmdline_subst_list() is
kept with a (void) parameter list instead of reverting to upstream's
empty () form, which clang rejects under -Werror,-Wstrict-prototypes.

[1] https://android.googlesource.com/platform/external/avb/+/a1fe228b86543a21739c51352f5ce72f134fccfa
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
 lib/libavb/avb_chain_partition_descriptor.c |   1 +
 lib/libavb/avb_chain_partition_descriptor.h |  16 +-
 lib/libavb/avb_cmdline.c                    |  42 +---
 lib/libavb/avb_descriptor.c                 |  62 ++++--
 lib/libavb/avb_hashtree_descriptor.h        |   3 +
 lib/libavb/avb_property_descriptor.h        |   8 +-
 lib/libavb/avb_rsa.c                        |   6 +-
 lib/libavb/avb_slot_verify.c                | 313 +++++++++++++++-------------
 lib/libavb/avb_slot_verify.h                |   6 +-
 lib/libavb/avb_util.c                       |  46 +++-
 lib/libavb/avb_util.h                       | 140 +++++++------
 lib/libavb/avb_vbmeta_image.c               |   1 +
 lib/libavb/avb_vbmeta_image.h               |   8 +-
 lib/libavb/avb_version.h                    |   2 +-
 14 files changed, 377 insertions(+), 277 deletions(-)

diff --git a/lib/libavb/avb_chain_partition_descriptor.c b/lib/libavb/avb_chain_partition_descriptor.c
index e2993063103..0354276c64a 100644
--- a/lib/libavb/avb_chain_partition_descriptor.c
+++ b/lib/libavb/avb_chain_partition_descriptor.c
@@ -24,6 +24,7 @@ bool avb_chain_partition_descriptor_validate_and_byteswap(
   dest->rollback_index_location = avb_be32toh(dest->rollback_index_location);
   dest->partition_name_len = avb_be32toh(dest->partition_name_len);
   dest->public_key_len = avb_be32toh(dest->public_key_len);
+  dest->flags = avb_be32toh(dest->flags);
 
   if (dest->rollback_index_location < 1) {
     avb_error("Invalid rollback index location value.\n");
diff --git a/lib/libavb/avb_chain_partition_descriptor.h b/lib/libavb/avb_chain_partition_descriptor.h
index 80e2271782e..31c7298d1df 100644
--- a/lib/libavb/avb_chain_partition_descriptor.h
+++ b/lib/libavb/avb_chain_partition_descriptor.h
@@ -16,6 +16,16 @@
 extern "C" {
 #endif
 
+/* Flags for chain descriptors.
+ *
+ * AVB_CHAIN_PARTITION_DESCRIPTOR_FLAGS_DO_NOT_USE_AB: Do not apply the default A/B
+ *   partition logic to this partition. This is intentionally a negative boolean
+ *   because A/B should be both the default and most used in practice.
+ */
+typedef enum {
+  AVB_CHAIN_PARTITION_DESCRIPTOR_FLAGS_DO_NOT_USE_AB = (1 << 0),
+} AvbChainPartitionDescriptorFlags;
+
 /* A descriptor containing a pointer to signed integrity data stored
  * on another partition. The descriptor contains the partition name in
  * question (without the A/B suffix), the public key used to sign the
@@ -28,13 +38,17 @@ extern "C" {
  *
  * The |reserved| field is for future expansion and must be set to NUL
  * bytes.
+ *
+ * Changes in v1.3:
+ *   - flags field is added which supports AVB_CHAIN_PARTITION_DESCRIPTOR_FLAGS_DO_NOT_USE_AB
  */
 typedef struct AvbChainPartitionDescriptor {
   AvbDescriptor parent_descriptor;
   uint32_t rollback_index_location;
   uint32_t partition_name_len;
   uint32_t public_key_len;
-  uint8_t reserved[64];
+  uint32_t flags;
+  uint8_t reserved[60];
 } AVB_ATTR_PACKED AvbChainPartitionDescriptor;
 
 /* Copies |src| to |dest| and validates, byte-swapping fields in the
diff --git a/lib/libavb/avb_cmdline.c b/lib/libavb/avb_cmdline.c
index a58ce6c48c0..842629abe0e 100644
--- a/lib/libavb/avb_cmdline.c
+++ b/lib/libavb/avb_cmdline.c
@@ -7,8 +7,6 @@
 #include "avb_sha.h"
 #include "avb_util.h"
 #include "avb_version.h"
-#include <log.h>
-#include <malloc.h>
 
 #define NUM_GUIDS 3
 
@@ -149,30 +147,6 @@ static int cmdline_append_option(AvbSlotVerifyData* slot_data,
   return 1;
 }
 
-#define AVB_MAX_DIGITS_UINT64 32
-
-/* Writes |value| to |digits| in base 10 followed by a NUL byte.
- * Returns number of characters written excluding the NUL byte.
- */
-static size_t uint64_to_base10(uint64_t value,
-                               char digits[AVB_MAX_DIGITS_UINT64]) {
-  char rev_digits[AVB_MAX_DIGITS_UINT64];
-  size_t n, num_digits;
-
-  for (num_digits = 0; num_digits < AVB_MAX_DIGITS_UINT64 - 1;) {
-    rev_digits[num_digits++] = avb_div_by_10(&value) + '0';
-    if (value == 0) {
-      break;
-    }
-  }
-
-  for (n = 0; n < num_digits; n++) {
-    digits[n] = rev_digits[num_digits - 1 - n];
-  }
-  digits[n] = '\0';
-  return n;
-}
-
 static int cmdline_append_version(AvbSlotVerifyData* slot_data,
                                   const char* key,
                                   uint64_t major_version,
@@ -182,8 +156,8 @@ static int cmdline_append_version(AvbSlotVerifyData* slot_data,
   char combined[AVB_MAX_DIGITS_UINT64 * 2 + 1];
   size_t num_major_digits, num_minor_digits;
 
-  num_major_digits = uint64_to_base10(major_version, major_digits);
-  num_minor_digits = uint64_to_base10(minor_version, minor_digits);
+  num_major_digits = avb_uint64_to_base10(major_version, major_digits);
+  num_minor_digits = avb_uint64_to_base10(minor_version, minor_digits);
   avb_memcpy(combined, major_digits, num_major_digits);
   combined[num_major_digits] = '.';
   avb_memcpy(combined + num_major_digits + 1, minor_digits, num_minor_digits);
@@ -196,7 +170,7 @@ static int cmdline_append_uint64_base10(AvbSlotVerifyData* slot_data,
                                         const char* key,
                                         uint64_t value) {
   char digits[AVB_MAX_DIGITS_UINT64];
-  uint64_to_base10(value, digits);
+  avb_uint64_to_base10(value, digits);
   return cmdline_append_option(slot_data, key, digits);
 }
 
@@ -359,11 +333,11 @@ AvbSlotVerifyResult avb_append_options(
         // Should never get here because MANAGED_RESTART_AND_EIO is
         // remapped by avb_manage_hashtree_error_mode().
         avb_assert_not_reached();
-        ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_ARGUMENT;
-        goto out;
-      default:
-        ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_ARGUMENT;
-        goto out;
+        break;
+      case AVB_HASHTREE_ERROR_MODE_PANIC:
+        verity_mode = "panicking";
+        dm_verity_mode = "panic_on_corruption";
+        break;
     }
     new_ret = avb_replace(
         slot_data->cmdline, "$(ANDROID_VERITY_MODE)", dm_verity_mode);
diff --git a/lib/libavb/avb_descriptor.c b/lib/libavb/avb_descriptor.c
index 56a3a91fc23..f4ff16694e6 100644
--- a/lib/libavb/avb_descriptor.c
+++ b/lib/libavb/avb_descriptor.c
@@ -6,8 +6,6 @@
 #include "avb_descriptor.h"
 #include "avb_util.h"
 #include "avb_vbmeta_image.h"
-#include <log.h>
-#include <malloc.h>
 
 bool avb_descriptor_validate_and_byteswap(const AvbDescriptor* src,
                                           AvbDescriptor* dest) {
@@ -31,6 +29,8 @@ bool avb_descriptor_foreach(const uint8_t* image_data,
   const uint8_t* desc_start;
   const uint8_t* desc_end;
   const uint8_t* p;
+  uint64_t desc_offset = 0;
+  uint64_t desc_size = 0;
 
   if (image_data == NULL) {
     avb_error("image_data is NULL\n.");
@@ -42,6 +42,9 @@ bool avb_descriptor_foreach(const uint8_t* image_data,
     goto out;
   }
 
+  /* The data is supposed to have been cryptographically verified at this point,
+   * This check is just adding defense in depth.
+   */
   if (image_size < sizeof(AvbVBMetaImageHeader)) {
     avb_error("Length is smaller than header.\n");
     goto out;
@@ -58,23 +61,53 @@ bool avb_descriptor_foreach(const uint8_t* image_data,
   header = (const AvbVBMetaImageHeader*)image_data;
   image_end = image_data + image_size;
 
-  desc_start = image_data + sizeof(AvbVBMetaImageHeader) +
-               avb_be64toh(header->authentication_data_block_size) +
-               avb_be64toh(header->descriptors_offset);
+  /* Since the data is supposed to have been cryptographically verified at this
+   * point, being overflow-safe is just for defense.
+   * The following lines are overflow-safe version of:
+   * desc_offset = sizeof(AvbVBMetaImageHeader) +
+   *               avb_be64toh(header->authentication_data_block_size)) +
+   *               avb_be64toh(header->descriptors_offset)
+   */
+  if (!avb_safe_add(&desc_offset,
+                    sizeof(AvbVBMetaImageHeader),
+                    avb_be64toh(header->authentication_data_block_size))) {
+    avb_error("Invalid authentication data block size.\n");
+    goto out;
+  }
+  if (!avb_safe_add_to(&desc_offset, avb_be64toh(header->descriptors_offset))) {
+    avb_error("Invalid descriptors offset.\n");
+    goto out;
+  }
+
+  if (desc_offset > (uint64_t)(image_end - image_data)) {
+    avb_error("Descriptors not inside passed-in data.\n");
+    goto out;
+  }
 
-  desc_end = desc_start + avb_be64toh(header->descriptors_size);
+  desc_start = image_data + desc_offset;
 
-  if (desc_start < image_data || desc_start > image_end ||
-      desc_end < image_data || desc_end > image_end || desc_end < desc_start) {
+  desc_size = avb_be64toh(header->descriptors_size);
+  if (desc_size > (uint64_t)(image_end - desc_start)) {
     avb_error("Descriptors not inside passed-in data.\n");
     goto out;
   }
 
+  desc_end = desc_start + desc_size;
+
   for (p = desc_start; p < desc_end;) {
-    const AvbDescriptor* dh = (const AvbDescriptor*)p;
-    avb_assert_aligned(dh);
-    uint64_t nb_following = avb_be64toh(dh->num_bytes_following);
+    uint64_t nb_following;
     uint64_t nb_total = 0;
+    const AvbDescriptor* dh;
+
+    if (sizeof(AvbDescriptor) > (size_t)(desc_end - p)) {
+      avb_error("Invalid descriptor length.\n");
+      goto out;
+    }
+
+    dh = (const AvbDescriptor*)p;
+    avb_assert_aligned(dh);
+    nb_following = avb_be64toh(dh->num_bytes_following);
+
     if (!avb_safe_add(&nb_total, sizeof(AvbDescriptor), nb_following)) {
       avb_error("Invalid descriptor length.\n");
       goto out;
@@ -85,7 +118,7 @@ bool avb_descriptor_foreach(const uint8_t* image_data,
       goto out;
     }
 
-    if (nb_total + p < desc_start || nb_total + p > desc_end) {
+    if (nb_total > (uint64_t)(desc_end - p)) {
       avb_error("Invalid data in descriptors array.\n");
       goto out;
     }
@@ -94,10 +127,7 @@ bool avb_descriptor_foreach(const uint8_t* image_data,
       goto out;
     }
 
-    if (!avb_safe_add_to((uint64_t*)(&p), nb_total)) {
-      avb_error("Invalid descriptor length.\n");
-      goto out;
-    }
+    p += nb_total;
   }
 
   ret = true;
diff --git a/lib/libavb/avb_hashtree_descriptor.h b/lib/libavb/avb_hashtree_descriptor.h
index d7f3eb501a3..5f74c465fed 100644
--- a/lib/libavb/avb_hashtree_descriptor.h
+++ b/lib/libavb/avb_hashtree_descriptor.h
@@ -21,9 +21,12 @@ extern "C" {
  * AVB_HASHTREE_DESCRIPTOR_FLAGS_DO_NOT_USE_AB: Do not apply the default A/B
  *   partition logic to this partition. This is intentionally a negative boolean
  *   because A/B should be both the default and most used in practice.
+ * AVB_HASHTREE_DESCRIPTOR_FLAGS_CHECK_AT_MOST_ONCE: supports to validate hashes
+ *   at most once in DM-Verity.
  */
 typedef enum {
   AVB_HASHTREE_DESCRIPTOR_FLAGS_DO_NOT_USE_AB = (1 << 0),
+  AVB_HASHTREE_DESCRIPTOR_FLAGS_CHECK_AT_MOST_ONCE = (1 << 1),
 } AvbHashtreeDescriptorFlags;
 
 /* A descriptor containing information about a dm-verity hashtree.
diff --git a/lib/libavb/avb_property_descriptor.h b/lib/libavb/avb_property_descriptor.h
index 917c58f9fea..b4df1c433a6 100644
--- a/lib/libavb/avb_property_descriptor.h
+++ b/lib/libavb/avb_property_descriptor.h
@@ -18,10 +18,10 @@ extern "C" {
 
 /* A descriptor for properties (free-form key/value pairs).
  *
- * Following this struct are |key_num_bytes| bytes of key data,
- * followed by a NUL byte, then |value_num_bytes| bytes of value data,
- * followed by a NUL byte and then enough padding to make the combined
- * size a multiple of 8.
+ * Following this struct are |key_num_bytes| bytes of key data encoded
+ * as UTF-8, followed by a NUL byte, then |value_num_bytes| bytes of
+ * value data, followed by a NUL byte and then enough padding to make
+ * the combined size a multiple of 8.
  */
 typedef struct AvbPropertyDescriptor {
   AvbDescriptor parent_descriptor;
diff --git a/lib/libavb/avb_rsa.c b/lib/libavb/avb_rsa.c
index d7bf8905be2..b64749980c0 100644
--- a/lib/libavb/avb_rsa.c
+++ b/lib/libavb/avb_rsa.c
@@ -3,6 +3,11 @@
  * Copyright (C) 2016 The Android Open Source Project
  */
 
+/* Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
+ * Use of this source code is governed by a BSD-style license that can be
+ * found in the LICENSE file.
+ */
+
 /* Implementation of RSA signature verification which uses a pre-processed
  * key for computation. The code extends libmincrypt RSA verification code to
  * support multiple RSA key lengths and hash digest algorithms.
@@ -12,7 +17,6 @@
 #include "avb_sha.h"
 #include "avb_util.h"
 #include "avb_vbmeta_image.h"
-#include <malloc.h>
 
 typedef struct IAvbKey {
   unsigned int len; /* Length of n[] in number of uint32_t */
diff --git a/lib/libavb/avb_slot_verify.c b/lib/libavb/avb_slot_verify.c
index ae8e1dffa4c..d37ffed0148 100644
--- a/lib/libavb/avb_slot_verify.c
+++ b/lib/libavb/avb_slot_verify.c
@@ -14,8 +14,6 @@
 #include "avb_util.h"
 #include "avb_vbmeta_image.h"
 #include "avb_version.h"
-#include <log.h>
-#include <malloc.h>
 
 /* Maximum number of partitions that can be loaded with avb_slot_verify(). */
 #define MAX_NUMBER_OF_LOADED_PARTITIONS 32
@@ -26,6 +24,9 @@
 /* Maximum size of a vbmeta image - 64 KiB. */
 #define VBMETA_MAX_SIZE (64 * 1024)
 
+/* Test buffer used to check the existence of a partition. */
+#define TEST_BUFFER_SIZE 1
+
 static AvbSlotVerifyResult initialize_persistent_digest(
     AvbOps* ops,
     const char* part_name,
@@ -72,7 +73,7 @@ static AvbSlotVerifyResult load_full_partition(AvbOps* ops,
   /* We are going to implicitly cast image_size from uint64_t to size_t in the
    * following code, so we need to make sure that the cast is safe. */
   if (image_size != (size_t)(image_size)) {
-    avb_errorv(part_name, ": Partition size too large to load.\n", NULL);
+    avb_error(part_name, ": Partition size too large to load.\n");
     return AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
   }
 
@@ -83,16 +84,16 @@ static AvbSlotVerifyResult load_full_partition(AvbOps* ops,
     if (io_ret == AVB_IO_RESULT_ERROR_OOM) {
       return AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
     } else if (io_ret != AVB_IO_RESULT_OK) {
-      avb_errorv(part_name, ": Error loading data from partition.\n", NULL);
+      avb_error(part_name, ": Error loading data from partition.\n");
       return AVB_SLOT_VERIFY_RESULT_ERROR_IO;
     }
 
     if (*out_image_buf != NULL) {
+      *out_image_preloaded = true;
       if (part_num_read != image_size) {
-        avb_errorv(part_name, ": Read incorrect number of bytes.\n", NULL);
+        avb_error(part_name, ": Read incorrect number of bytes.\n");
         return AVB_SLOT_VERIFY_RESULT_ERROR_IO;
       }
-      *out_image_preloaded = true;
     }
   }
 
@@ -112,11 +113,11 @@ static AvbSlotVerifyResult load_full_partition(AvbOps* ops,
     if (io_ret == AVB_IO_RESULT_ERROR_OOM) {
       return AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
     } else if (io_ret != AVB_IO_RESULT_OK) {
-      avb_errorv(part_name, ": Error loading data from partition.\n", NULL);
+      avb_error(part_name, ": Error loading data from partition.\n");
       return AVB_SLOT_VERIFY_RESULT_ERROR_IO;
     }
     if (part_num_read != image_size) {
-      avb_errorv(part_name, ": Read incorrect number of bytes.\n", NULL);
+      avb_error(part_name, ": Read incorrect number of bytes.\n");
       return AVB_SLOT_VERIFY_RESULT_ERROR_IO;
     }
   }
@@ -150,7 +151,7 @@ static AvbSlotVerifyResult read_persistent_digest(AvbOps* ops,
   size_t stored_digest_size = 0;
 
   if (ops->read_persistent_value == NULL) {
-    avb_errorv(part_name, ": Persistent values are not implemented.\n", NULL);
+    avb_error(part_name, ": Persistent values are not implemented.\n");
     return AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
   }
   persistent_value_name =
@@ -187,19 +188,17 @@ static AvbSlotVerifyResult read_persistent_digest(AvbOps* ops,
   } else if (io_ret == AVB_IO_RESULT_ERROR_NO_SUCH_VALUE) {
     // Treat a missing persistent value as a verification error, which is
     // ignoreable, rather than a metadata error which is not.
-    avb_errorv(part_name, ": Persistent digest does not exist.\n", NULL);
+    avb_error(part_name, ": Persistent digest does not exist.\n");
     return AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION;
   } else if (io_ret == AVB_IO_RESULT_ERROR_INVALID_VALUE_SIZE ||
              io_ret == AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE) {
-    avb_errorv(
-        part_name, ": Persistent digest is not of expected size.\n", NULL);
+    avb_error(part_name, ": Persistent digest is not of expected size.\n");
     return AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
   } else if (io_ret != AVB_IO_RESULT_OK) {
-    avb_errorv(part_name, ": Error reading persistent digest.\n", NULL);
+    avb_error(part_name, ": Error reading persistent digest.\n");
     return AVB_SLOT_VERIFY_RESULT_ERROR_IO;
   } else if (expected_digest_size != stored_digest_size) {
-    avb_errorv(
-        part_name, ": Persistent digest is not of expected size.\n", NULL);
+    avb_error(part_name, ": Persistent digest is not of expected size.\n");
     return AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
   }
   return AVB_SLOT_VERIFY_RESULT_OK;
@@ -225,23 +224,21 @@ static AvbSlotVerifyResult initialize_persistent_digest(
   }
 
   if (is_device_unlocked) {
-    avb_debugv(part_name,
-               ": Digest does not exist, device unlocked so not initializing "
-               "digest.\n",
-               NULL);
+    avb_debug(part_name,
+              ": Digest does not exist, device unlocked so not initializing "
+              "digest.\n");
     return AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION;
   }
 
   // Device locked; initialize digest with given initial value.
-  avb_debugv(part_name,
-             ": Digest does not exist, initializing persistent digest.\n",
-             NULL);
+  avb_debug(part_name,
+            ": Digest does not exist, initializing persistent digest.\n");
   io_ret = ops->write_persistent_value(
       ops, persistent_value_name, digest_size, initial_digest);
   if (io_ret == AVB_IO_RESULT_ERROR_OOM) {
     return AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
   } else if (io_ret != AVB_IO_RESULT_OK) {
-    avb_errorv(part_name, ": Error initializing persistent digest.\n", NULL);
+    avb_error(part_name, ": Error initializing persistent digest.\n");
     return AVB_SLOT_VERIFY_RESULT_ERROR_IO;
   }
 
@@ -251,9 +248,8 @@ static AvbSlotVerifyResult initialize_persistent_digest(
   // initial_digest ensures that this will not recurse again.
   ret = read_persistent_digest(ops, part_name, digest_size, NULL, out_digest);
   if (ret != AVB_SLOT_VERIFY_RESULT_OK) {
-    avb_errorv(part_name,
-               ": Reading back initialized persistent digest failed!\n",
-               NULL);
+    avb_error(part_name,
+              ": Reading back initialized persistent digest failed!\n");
   }
   return ret;
 }
@@ -356,11 +352,11 @@ static AvbSlotVerifyResult load_and_verify_hash_partition(
       ret = AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
       goto out;
     } else if (io_ret != AVB_IO_RESULT_OK) {
-      avb_errorv(part_name, ": Error determining partition size.\n", NULL);
+      avb_error(part_name, ": Error determining partition size.\n");
       ret = AVB_SLOT_VERIFY_RESULT_ERROR_IO;
       goto out;
     }
-    avb_debugv(part_name, ": Loading entire partition.\n", NULL);
+    avb_debug(part_name, ": Loading entire partition.\n");
   }
 
   ret = load_full_partition(
@@ -392,14 +388,14 @@ static AvbSlotVerifyResult load_and_verify_hash_partition(
     digest = avb_sha512_final(&sha512_ctx);
     digest_len = AVB_SHA512_DIGEST_SIZE;
   } else {
-    avb_errorv(part_name, ": Unsupported hash algorithm.\n", NULL);
+    avb_error(part_name, ": Unsupported hash algorithm.\n");
     ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
     goto out;
   }
 
   if (hash_desc.digest_len == 0) {
     /* Expect a match to a persistent digest. */
-    avb_debugv(part_name, ": No digest, using persistent digest.\n", NULL);
+    avb_debug(part_name, ": No digest, using persistent digest.\n");
     expected_digest_len = digest_len;
     expected_digest = expected_digest_buf;
     avb_assert(expected_digest_len <= sizeof(expected_digest_buf));
@@ -418,16 +414,14 @@ static AvbSlotVerifyResult load_and_verify_hash_partition(
   }
 
   if (digest_len != expected_digest_len) {
-    avb_errorv(
-        part_name, ": Digest in descriptor not of expected size.\n", NULL);
+    avb_error(part_name, ": Digest in descriptor not of expected size.\n");
     ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
     goto out;
   }
 
   if (avb_safe_memcmp(digest, expected_digest, digest_len) != 0) {
-    avb_errorv(part_name,
-               ": Hash of data does not match digest in descriptor.\n",
-               NULL);
+    avb_error(part_name,
+              ": Hash of data does not match digest in descriptor.\n");
     ret = AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION;
     goto out;
   }
@@ -441,7 +435,7 @@ out:
       image_buf != NULL) {
     AvbPartitionData* loaded_partition;
     if (slot_data->num_loaded_partitions == MAX_NUMBER_OF_LOADED_PARTITIONS) {
-      avb_errorv(part_name, ": Too many loaded partitions.\n", NULL);
+      avb_error(part_name, ": Too many loaded partitions.\n");
       ret = AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
       goto fail;
     }
@@ -451,6 +445,7 @@ out:
     loaded_partition->data_size = image_size;
     loaded_partition->data = image_buf;
     loaded_partition->preloaded = image_preloaded;
+    loaded_partition->verify_result = ret;
     image_buf = NULL;
   }
 
@@ -493,11 +488,11 @@ static AvbSlotVerifyResult load_requested_partitions(
       ret = AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
       goto out;
     } else if (io_ret != AVB_IO_RESULT_OK) {
-      avb_errorv(part_name, ": Error determining partition size.\n", NULL);
+      avb_error(part_name, ": Error determining partition size.\n");
       ret = AVB_SLOT_VERIFY_RESULT_ERROR_IO;
       goto out;
     }
-    avb_debugv(part_name, ": Loading entire partition.\n", NULL);
+    avb_debug(part_name, ": Loading entire partition.\n");
 
     ret = load_full_partition(
         ops, part_name, image_size, &image_buf, &image_preloaded);
@@ -507,7 +502,7 @@ static AvbSlotVerifyResult load_requested_partitions(
 
     /* Move to slot_data. */
     if (slot_data->num_loaded_partitions == MAX_NUMBER_OF_LOADED_PARTITIONS) {
-      avb_errorv(part_name, ": Too many loaded partitions.\n", NULL);
+      avb_error(part_name, ": Too many loaded partitions.\n");
       ret = AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
       goto out;
     }
@@ -544,18 +539,19 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
     AvbSlotVerifyFlags flags,
     bool allow_verification_error,
     AvbVBMetaImageFlags toplevel_vbmeta_flags,
-    int rollback_index_location,
+    uint32_t rollback_index_location,
     const char* partition_name,
     size_t partition_name_len,
     const uint8_t* expected_public_key,
     size_t expected_public_key_length,
     AvbSlotVerifyData* slot_data,
     AvbAlgorithmType* out_algorithm_type,
-    AvbCmdlineSubstList* out_additional_cmdline_subst) {
+    AvbCmdlineSubstList* out_additional_cmdline_subst,
+    bool use_ab_suffix) {
   char full_partition_name[AVB_PART_NAME_MAX_SIZE];
   AvbSlotVerifyResult ret;
   AvbIOResult io_ret;
-  size_t vbmeta_offset;
+  uint64_t vbmeta_offset;
   size_t vbmeta_size;
   uint8_t* vbmeta_buf = NULL;
   size_t vbmeta_num_read;
@@ -599,17 +595,27 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
     ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
     goto out;
   }
-
-  /* Construct full partition name e.g. system_a. */
-  if (!avb_str_concat(full_partition_name,
+  if (!use_ab_suffix) {
+    /*No ab_suffix, just copy the partition name as is.*/
+    if (partition_name_len >= AVB_PART_NAME_MAX_SIZE) {
+      avb_error("Partition name does not fit.\n");
+      ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
+      goto out;
+    }
+    avb_memcpy(full_partition_name, partition_name, partition_name_len);
+    full_partition_name[partition_name_len] = '\0';
+  }else{
+    /* Construct full partition name e.g. system_a. */
+    if (!avb_str_concat(full_partition_name,
                       sizeof full_partition_name,
                       partition_name,
                       partition_name_len,
                       ab_suffix,
                       avb_strlen(ab_suffix))) {
-    avb_error("Partition name and suffix does not fit.\n");
-    ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
-    goto out;
+      avb_error("Partition name and suffix does not fit.\n");
+      ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
+      goto out;
+    }
   }
 
   /* If we're loading from the main vbmeta partition, the vbmeta struct is in
@@ -635,7 +641,7 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
       ret = AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
       goto out;
     } else if (io_ret != AVB_IO_RESULT_OK) {
-      avb_errorv(full_partition_name, ": Error loading footer.\n", NULL);
+      avb_error(full_partition_name, ": Error loading footer.\n");
       ret = AVB_SLOT_VERIFY_RESULT_ERROR_IO;
       goto out;
     }
@@ -643,43 +649,67 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
 
     if (!avb_footer_validate_and_byteswap((const AvbFooter*)footer_buf,
                                           &footer)) {
-      avb_debugv(full_partition_name, ": No footer detected.\n", NULL);
+      avb_debug(full_partition_name, ": No footer detected.\n");
     } else {
       /* Basic footer sanity check since the data is untrusted. */
       if (footer.vbmeta_size > VBMETA_MAX_SIZE) {
-        avb_errorv(
-            full_partition_name, ": Invalid vbmeta size in footer.\n", NULL);
+        avb_error(full_partition_name, ": Invalid vbmeta size in footer.\n");
       } else {
         vbmeta_offset = footer.vbmeta_offset;
         vbmeta_size = footer.vbmeta_size;
       }
     }
+  } else {
+    uint64_t partition_size = 0;
+    io_ret =
+        ops->get_size_of_partition(ops, full_partition_name, &partition_size);
+    if (io_ret == AVB_IO_RESULT_OK) {
+      if (partition_size < vbmeta_size && partition_size > 0) {
+        avb_debug(full_partition_name,
+                  ": Using partition size as vbmeta size\n");
+        vbmeta_size = partition_size;
+      }
+    } else {
+      avb_debug(full_partition_name, ": Failed to get partition size\n");
+      // libavb might fall back to other partitions if current vbmeta partition
+      // isn't found. So AVB_IO_RESULT_ERROR_NO_SUCH_PARTITION is recoverable,
+      // but other errors are not.
+      if (io_ret != AVB_IO_RESULT_ERROR_NO_SUCH_PARTITION) {
+        ret = AVB_SLOT_VERIFY_RESULT_ERROR_IO;
+        goto out;
+      }
+    }
   }
 
-  vbmeta_buf = avb_malloc(vbmeta_size);
-  if (vbmeta_buf == NULL) {
-    ret = AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
-    goto out;
-  }
+  /* Use result from previous I/O operation to check the existence of the
+   * partition before allocating the big chunk of memory on heap
+   * for vbmeta later. `io_ret` will be used later to decide whether
+   * to fallback on the `boot` partition.
+   */
+  if (io_ret != AVB_IO_RESULT_ERROR_NO_SUCH_PARTITION) {
+    vbmeta_buf = avb_malloc(vbmeta_size);
+    if (vbmeta_buf == NULL) {
+      ret = AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
+      goto out;
+    }
 
-  if (vbmeta_offset != 0) {
-    avb_debugv("Loading vbmeta struct in footer from partition '",
-               full_partition_name,
-               "'.\n",
-               NULL);
-  } else {
-    avb_debugv("Loading vbmeta struct from partition '",
-               full_partition_name,
-               "'.\n",
-               NULL);
-  }
-
-  io_ret = ops->read_from_partition(ops,
-                                    full_partition_name,
-                                    vbmeta_offset,
-                                    vbmeta_size,
-                                    vbmeta_buf,
-                                    &vbmeta_num_read);
+    if (vbmeta_offset != 0) {
+      avb_debug("Loading vbmeta struct in footer from partition '",
+                full_partition_name,
+                "'.\n");
+    } else {
+      avb_debug("Loading vbmeta struct from partition '",
+                full_partition_name,
+                "'.\n");
+    }
+
+    io_ret = ops->read_from_partition(ops,
+                                      full_partition_name,
+                                      vbmeta_offset,
+                                      vbmeta_size,
+                                      vbmeta_buf,
+                                      &vbmeta_num_read);
+  }
   if (io_ret == AVB_IO_RESULT_ERROR_OOM) {
     ret = AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
     goto out;
@@ -689,9 +719,8 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
      */
     if (is_main_vbmeta && io_ret == AVB_IO_RESULT_ERROR_NO_SUCH_PARTITION &&
         !look_for_vbmeta_footer) {
-      avb_debugv(full_partition_name,
-                 ": No such partition. Trying 'boot' instead.\n",
-                 NULL);
+      avb_debug(full_partition_name,
+                ": No such partition. Trying 'boot' instead.\n");
       ret = load_and_verify_vbmeta(ops,
                                    requested_partitions,
                                    ab_suffix,
@@ -705,10 +734,11 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
                                    0 /* expected_public_key_length */,
                                    slot_data,
                                    out_algorithm_type,
-                                   out_additional_cmdline_subst);
+                                   out_additional_cmdline_subst,
+                                   use_ab_suffix);
       goto out;
     } else {
-      avb_errorv(full_partition_name, ": Error loading vbmeta data.\n", NULL);
+      avb_error(full_partition_name, ": Error loading vbmeta data.\n");
       ret = AVB_SLOT_VERIFY_RESULT_ERROR_IO;
       goto out;
     }
@@ -729,11 +759,10 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
     case AVB_VBMETA_VERIFY_RESULT_HASH_MISMATCH:
     case AVB_VBMETA_VERIFY_RESULT_SIGNATURE_MISMATCH:
       ret = AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION;
-      avb_errorv(full_partition_name,
-                 ": Error verifying vbmeta image: ",
-                 avb_vbmeta_verify_result_to_string(vbmeta_ret),
-                 "\n",
-                 NULL);
+      avb_error(full_partition_name,
+                ": Error verifying vbmeta image: ",
+                avb_vbmeta_verify_result_to_string(vbmeta_ret),
+                "\n");
       if (!allow_verification_error) {
         goto out;
       }
@@ -742,17 +771,15 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
     case AVB_VBMETA_VERIFY_RESULT_INVALID_VBMETA_HEADER:
       /* No way to continue this case. */
       ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
-      avb_errorv(full_partition_name,
-                 ": Error verifying vbmeta image: invalid vbmeta header\n",
-                 NULL);
+      avb_error(full_partition_name,
+                ": Error verifying vbmeta image: invalid vbmeta header\n");
       goto out;
 
     case AVB_VBMETA_VERIFY_RESULT_UNSUPPORTED_VERSION:
       /* No way to continue this case. */
       ret = AVB_SLOT_VERIFY_RESULT_ERROR_UNSUPPORTED_VERSION;
-      avb_errorv(full_partition_name,
-                 ": Error verifying vbmeta image: unsupported AVB version\n",
-                 NULL);
+      avb_error(full_partition_name,
+                ": Error verifying vbmeta image: unsupported AVB version\n");
       goto out;
   }
 
@@ -766,14 +793,16 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
   } else {
     if (vbmeta_header.flags != 0) {
       ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
-      avb_errorv(full_partition_name,
-                 ": chained vbmeta image has non-zero flags\n",
-                 NULL);
+      avb_error(full_partition_name,
+                ": chained vbmeta image has non-zero flags\n");
       goto out;
     }
   }
 
   uint32_t rollback_index_location_to_use = rollback_index_location;
+  if (is_main_vbmeta) {
+    rollback_index_location_to_use = vbmeta_header.rollback_index_location;
+  }
 
   /* Check if key used to make signature matches what is expected. */
   if (pk_data != NULL) {
@@ -781,10 +810,9 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
       avb_assert(!is_main_vbmeta);
       if (expected_public_key_length != pk_len ||
           avb_safe_memcmp(expected_public_key, pk_data, pk_len) != 0) {
-        avb_errorv(full_partition_name,
-                   ": Public key used to sign data does not match key in chain "
-                   "partition descriptor.\n",
-                   NULL);
+        avb_error(full_partition_name,
+                  ": Public key used to sign data does not match key in chain "
+                  "partition descriptor.\n");
         ret = AVB_SLOT_VERIFY_RESULT_ERROR_PUBLIC_KEY_REJECTED;
         if (!allow_verification_error) {
           goto out;
@@ -827,16 +855,14 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
         ret = AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
         goto out;
       } else if (io_ret != AVB_IO_RESULT_OK) {
-        avb_errorv(full_partition_name,
-                   ": Error while checking public key used to sign data.\n",
-                   NULL);
+        avb_error(full_partition_name,
+                  ": Error while checking public key used to sign data.\n");
         ret = AVB_SLOT_VERIFY_RESULT_ERROR_IO;
         goto out;
       }
       if (!key_is_trusted) {
-        avb_errorv(full_partition_name,
-                   ": Public key used to sign data rejected.\n",
-                   NULL);
+        avb_error(full_partition_name,
+                  ": Public key used to sign data rejected.\n");
         ret = AVB_SLOT_VERIFY_RESULT_ERROR_PUBLIC_KEY_REJECTED;
         if (!allow_verification_error) {
           goto out;
@@ -852,17 +878,15 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
     ret = AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
     goto out;
   } else if (io_ret != AVB_IO_RESULT_OK) {
-    avb_errorv(full_partition_name,
-               ": Error getting rollback index for location.\n",
-               NULL);
+    avb_error(full_partition_name,
+              ": Error getting rollback index for location.\n");
     ret = AVB_SLOT_VERIFY_RESULT_ERROR_IO;
     goto out;
   }
   if (vbmeta_header.rollback_index < stored_rollback_index) {
-    avb_errorv(
+    avb_error(
         full_partition_name,
-        ": Image rollback index is less than the stored rollback index.\n",
-        NULL);
+        ": Image rollback index is less than the stored rollback index.\n");
     ret = AVB_SLOT_VERIFY_RESULT_ERROR_ROLLBACK_INDEX;
     if (!allow_verification_error) {
       goto out;
@@ -878,7 +902,7 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
     }
   }
   if (slot_data->num_vbmeta_images == MAX_NUMBER_OF_VBMETA_IMAGES) {
-    avb_errorv(full_partition_name, ": Too many vbmeta images.\n", NULL);
+    avb_error(full_partition_name, ": Too many vbmeta images.\n");
     ret = AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
     goto out;
   }
@@ -902,8 +926,7 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
    */
   if (vbmeta_header.flags & AVB_VBMETA_IMAGE_FLAGS_VERIFICATION_DISABLED) {
     AvbSlotVerifyResult sub_ret;
-    avb_debugv(
-        full_partition_name, ": VERIFICATION_DISABLED bit is set.\n", NULL);
+    avb_debug(full_partition_name, ": VERIFICATION_DISABLED bit is set.\n");
     /* If load_requested_partitions() fail it is always a fatal
      * failure (e.g. ERROR_INVALID_ARGUMENT, ERROR_OOM, etc.) rather
      * than recoverable (e.g. one where result_should_continue()
@@ -936,7 +959,7 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
     AvbDescriptor desc;
 
     if (!avb_descriptor_validate_and_byteswap(descriptors[n], &desc)) {
-      avb_errorv(full_partition_name, ": Descriptor is invalid.\n", NULL);
+      avb_error(full_partition_name, ": Descriptor is invalid.\n");
       ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
       goto out;
     }
@@ -966,31 +989,32 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
 
         /* Only allow CHAIN_PARTITION descriptors in the main vbmeta image. */
         if (!is_main_vbmeta) {
-          avb_errorv(full_partition_name,
-                     ": Encountered chain descriptor not in main image.\n",
-                     NULL);
+          avb_error(full_partition_name,
+                    ": Encountered chain descriptor not in main image.\n");
           ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
           goto out;
         }
 
         if (!avb_chain_partition_descriptor_validate_and_byteswap(
                 (AvbChainPartitionDescriptor*)descriptors[n], &chain_desc)) {
-          avb_errorv(full_partition_name,
-                     ": Chain partition descriptor is invalid.\n",
-                     NULL);
+          avb_error(full_partition_name,
+                    ": Chain partition descriptor is invalid.\n");
           ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
           goto out;
         }
 
         if (chain_desc.rollback_index_location == 0) {
-          avb_errorv(full_partition_name,
-                     ": Chain partition has invalid "
-                     "rollback_index_location field.\n",
-                     NULL);
+          avb_error(full_partition_name,
+                    ": Chain partition has invalid "
+                    "rollback_index_location field.\n");
           ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
           goto out;
         }
-
+        if ((chain_desc.flags & AVB_HASH_DESCRIPTOR_FLAGS_DO_NOT_USE_AB) != 0){
+          use_ab_suffix = false;
+        }else{
+          use_ab_suffix = true;
+        }
         chain_partition_name = ((const uint8_t*)descriptors[n]) +
                                sizeof(AvbChainPartitionDescriptor);
         chain_public_key = chain_partition_name + chain_desc.partition_name_len;
@@ -1009,7 +1033,8 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
                                    chain_desc.public_key_len,
                                    slot_data,
                                    NULL, /* out_algorithm_type */
-                                   NULL /* out_additional_cmdline_subst */);
+                                   NULL, /* out_additional_cmdline_subst */
+                                   use_ab_suffix);
         if (sub_ret != AVB_SLOT_VERIFY_RESULT_OK) {
           ret = sub_ret;
           if (!result_should_continue(ret)) {
@@ -1026,9 +1051,8 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
         if (!avb_kernel_cmdline_descriptor_validate_and_byteswap(
                 (AvbKernelCmdlineDescriptor*)descriptors[n],
                 &kernel_cmdline_desc)) {
-          avb_errorv(full_partition_name,
-                     ": Kernel cmdline descriptor is invalid.\n",
-                     NULL);
+          avb_error(full_partition_name,
+                    ": Kernel cmdline descriptor is invalid.\n");
           ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
           goto out;
         }
@@ -1038,9 +1062,8 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
 
         if (!avb_validate_utf8(kernel_cmdline,
                                kernel_cmdline_desc.kernel_cmdline_length)) {
-          avb_errorv(full_partition_name,
-                     ": Kernel cmdline is not valid UTF-8.\n",
-                     NULL);
+          avb_error(full_partition_name,
+                    ": Kernel cmdline is not valid UTF-8.\n");
           ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
           goto out;
         }
@@ -1100,8 +1123,7 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
 
         if (!avb_hashtree_descriptor_validate_and_byteswap(
                 (AvbHashtreeDescriptor*)descriptors[n], &hashtree_desc)) {
-          avb_errorv(
-              full_partition_name, ": Hashtree descriptor is invalid.\n", NULL);
+          avb_error(full_partition_name, ": Hashtree descriptor is invalid.\n");
           ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
           goto out;
         }
@@ -1155,7 +1177,7 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
                                 "sha512") == 0) {
             digest_len = AVB_SHA512_DIGEST_SIZE;
           } else {
-            avb_errorv(part_name, ": Unsupported hash algorithm.\n", NULL);
+            avb_error(part_name, ": Unsupported hash algorithm.\n");
             ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
             goto out;
           }
@@ -1188,15 +1210,14 @@ static AvbSlotVerifyResult load_and_verify_vbmeta(
     }
   }
 
-  if (rollback_index_location < 0 ||
-      rollback_index_location >= AVB_MAX_NUMBER_OF_ROLLBACK_INDEX_LOCATIONS) {
-    avb_errorv(
-        full_partition_name, ": Invalid rollback_index_location.\n", NULL);
+  if (rollback_index_location_to_use >=
+      AVB_MAX_NUMBER_OF_ROLLBACK_INDEX_LOCATIONS) {
+    avb_error(full_partition_name, ": Invalid rollback_index_location.\n");
     ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA;
     goto out;
   }
 
-  slot_data->rollback_indexes[rollback_index_location] =
+  slot_data->rollback_indexes[rollback_index_location_to_use] =
       vbmeta_header.rollback_index;
 
   if (out_algorithm_type != NULL) {
@@ -1315,7 +1336,7 @@ out:
 
 static bool has_system_partition(AvbOps* ops, const char* ab_suffix) {
   char part_name[AVB_PART_NAME_MAX_SIZE];
-  char* system_part_name = "system";
+  const char* system_part_name = "system";
   char guid_buf[37];
   AvbIOResult io_ret;
 
@@ -1348,7 +1369,7 @@ AvbSlotVerifyResult avb_slot_verify(AvbOps* ops,
                                     AvbSlotVerifyFlags flags,
                                     AvbHashtreeErrorMode hashtree_error_mode,
                                     AvbSlotVerifyData** out_data) {
-  AvbSlotVerifyResult ret = AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_ARGUMENT;
+  AvbSlotVerifyResult ret;
   AvbSlotVerifyData* slot_data = NULL;
   AvbAlgorithmType algorithm_type = AVB_ALGORITHM_TYPE_NONE;
   bool using_boot_for_vbmeta = false;
@@ -1456,7 +1477,8 @@ AvbSlotVerifyResult avb_slot_verify(AvbOps* ops,
                                    0 /* expected_public_key_length */,
                                    slot_data,
                                    &algorithm_type,
-                                   additional_cmdline_subst);
+                                   additional_cmdline_subst,
+                                   true /*use_ab_suffix*/);
       if (!allow_verification_error && ret != AVB_SLOT_VERIFY_RESULT_OK) {
         goto fail;
       }
@@ -1477,7 +1499,8 @@ AvbSlotVerifyResult avb_slot_verify(AvbOps* ops,
                                  0 /* expected_public_key_length */,
                                  slot_data,
                                  &algorithm_type,
-                                 additional_cmdline_subst);
+                                 additional_cmdline_subst,
+                                 true /*use_ab_suffix*/);
     if (!allow_verification_error && ret != AVB_SLOT_VERIFY_RESULT_OK) {
       goto fail;
     }
@@ -1686,7 +1709,7 @@ const char* avb_slot_verify_result_to_string(AvbSlotVerifyResult result) {
   return ret;
 }
 
-void avb_slot_verify_data_calculate_vbmeta_digest(AvbSlotVerifyData* data,
+void avb_slot_verify_data_calculate_vbmeta_digest(const AvbSlotVerifyData* data,
                                                   AvbDigestType digest_type,
                                                   uint8_t* out_digest) {
   bool ret = false;
diff --git a/lib/libavb/avb_slot_verify.h b/lib/libavb/avb_slot_verify.h
index 8d0fa536935..b86c96cbd06 100644
--- a/lib/libavb/avb_slot_verify.h
+++ b/lib/libavb/avb_slot_verify.h
@@ -69,7 +69,8 @@ typedef enum {
   AVB_HASHTREE_ERROR_MODE_RESTART,
   AVB_HASHTREE_ERROR_MODE_EIO,
   AVB_HASHTREE_ERROR_MODE_LOGGING,
-  AVB_HASHTREE_ERROR_MODE_MANAGED_RESTART_AND_EIO
+  AVB_HASHTREE_ERROR_MODE_MANAGED_RESTART_AND_EIO,
+  AVB_HASHTREE_ERROR_MODE_PANIC
 } AvbHashtreeErrorMode;
 
 /* Flags that influence how avb_slot_verify() works.
@@ -138,6 +139,7 @@ typedef struct {
   uint8_t* data;
   size_t data_size;
   bool preloaded;
+  AvbSlotVerifyResult verify_result;
 } AvbPartitionData;
 
 /* AvbVBMetaData contains a vbmeta struct loaded from a partition when
@@ -291,7 +293,7 @@ typedef struct {
  * in |out_digest| which must be large enough to hold a digest
  * of the requested type.
  */
-void avb_slot_verify_data_calculate_vbmeta_digest(AvbSlotVerifyData* data,
+void avb_slot_verify_data_calculate_vbmeta_digest(const AvbSlotVerifyData* data,
                                                   AvbDigestType digest_type,
                                                   uint8_t* out_digest);
 
diff --git a/lib/libavb/avb_util.c b/lib/libavb/avb_util.c
index 8719ede15a7..25af46075a7 100644
--- a/lib/libavb/avb_util.c
+++ b/lib/libavb/avb_util.c
@@ -4,11 +4,17 @@
  */
 
 #include "avb_util.h"
-#include <log.h>
-#include <malloc.h>
 
 #include <stdarg.h>
 
+uint16_t avb_be16toh(uint16_t in) {
+  uint8_t* d = (uint8_t*)&in;
+  uint16_t ret;
+  ret = ((uint16_t)d[0]) << 8;
+  ret |= ((uint16_t)d[1]);
+  return ret;
+}
+
 uint32_t avb_be32toh(uint32_t in) {
   uint8_t* d = (uint8_t*)&in;
   uint32_t ret;
@@ -33,6 +39,17 @@ uint64_t avb_be64toh(uint64_t in) {
   return ret;
 }
 
+/* Converts a 16-bit unsigned integer from host to big-endian byte order. */
+uint16_t avb_htobe16(uint16_t in) {
+  union {
+    uint16_t word;
+    uint8_t bytes[2];
+  } ret;
+  ret.bytes[0] = (in >> 8) & 0xff;
+  ret.bytes[1] = in & 0xff;
+  return ret.word;
+}
+
 /* Converts a 32-bit unsigned integer from host to big-endian byte order. */
 uint32_t avb_htobe32(uint32_t in) {
   union {
@@ -159,6 +176,12 @@ bool avb_str_concat(char* buf,
                     size_t str2_len) {
   uint64_t combined_len;
 
+  // Doesn't make sense to pass 0 for buf_size since there's
+  // no room for the terminating NUL byte.
+  if (buf_size == 0) {
+    return false;
+  }
+
   if (!avb_safe_add(&combined_len, str1_len, str2_len)) {
     avb_error("Overflow when adding string sizes.\n");
     return false;
@@ -411,3 +434,22 @@ char* avb_bin2hex(const uint8_t* data, size_t data_len) {
   hex_data[n * 2] = '\0';
   return hex_data;
 }
+
+size_t avb_uint64_to_base10(uint64_t value,
+                            char digits[AVB_MAX_DIGITS_UINT64]) {
+  char rev_digits[AVB_MAX_DIGITS_UINT64];
+  size_t n, num_digits;
+
+  for (num_digits = 0; num_digits < AVB_MAX_DIGITS_UINT64 - 1;) {
+    rev_digits[num_digits++] = avb_div_by_10(&value) + '0';
+    if (value == 0) {
+      break;
+    }
+  }
+
+  for (n = 0; n < num_digits; n++) {
+    digits[n] = rev_digits[num_digits - 1 - n];
+  }
+  digits[n] = '\0';
+  return n;
+}
diff --git a/lib/libavb/avb_util.h b/lib/libavb/avb_util.h
index 26dc6b045ac..d0612cc97f3 100644
--- a/lib/libavb/avb_util.h
+++ b/lib/libavb/avb_util.h
@@ -16,9 +16,44 @@
 extern "C" {
 #endif
 
+#define AVB_CONCAT(x, y) x##y
 #define AVB_STRINGIFY(x) #x
 #define AVB_TO_STRING(x) AVB_STRINGIFY(x)
 
+#define AVB__COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, x, ...) x
+#define AVB_COUNT_ARGS(...) \
+  AVB__COUNT_ARGS(, ##__VA_ARGS__, 7, 6, 5, 4, 3, 2, 1, 0)
+
+#define AVB__REPEAT0(x)
+#define AVB__REPEAT1(x) x
+#define AVB__REPEAT2(x) AVB__REPEAT1(x) x
+#define AVB__REPEAT3(x) AVB__REPEAT2(x) x
+#define AVB__REPEAT4(x) AVB__REPEAT3(x) x
+#define AVB__REPEAT5(x) AVB__REPEAT4(x) x
+#define AVB__REPEAT6(x) AVB__REPEAT5(x) x
+#define AVB__REPEAT7(x) AVB__REPEAT6(x) x
+#define AVB__REPEAT(n, x) AVB_CONCAT(AVB__REPEAT, n)(x)
+#define AVB_REPEAT(n, x) AVB__REPEAT(n, x)
+
+#ifdef AVB_USE_PRINTF_LOGS
+#define AVB_LOG(level, message, ...)                                        \
+  avb_printf("%s:%d: " level                                                \
+             ": " AVB_REPEAT(AVB_COUNT_ARGS(message, ##__VA_ARGS__), "%s"), \
+             avb_basename(__FILE__),                                        \
+             __LINE__,                                                      \
+             message,                                                       \
+             ##__VA_ARGS__)
+#else
+#define AVB_LOG(level, message, ...)  \
+  avb_printv(avb_basename(__FILE__),  \
+             ":",                     \
+             AVB_TO_STRING(__LINE__), \
+             ": " level ": ",         \
+             message,                 \
+             ##__VA_ARGS__,           \
+             NULL)
+#endif
+
 #ifdef AVB_ENABLE_DEBUG
 /* Aborts the program if |expr| is false.
  *
@@ -30,21 +65,28 @@ extern "C" {
       avb_fatal("assert fail: " #expr "\n"); \
     }                                        \
   } while (0)
-#else
-#define avb_assert(expr)
-#endif
 
 /* Aborts the program if reached.
  *
  * This has no effect unless AVB_ENABLE_DEBUG is defined.
  */
-#ifdef AVB_ENABLE_DEBUG
 #define avb_assert_not_reached()         \
   do {                                   \
     avb_fatal("assert_not_reached()\n"); \
   } while (0)
+
+/* Print functions, used for diagnostics.
+ *
+ * These have no effect unless AVB_ENABLE_DEBUG is defined.
+ */
+#define avb_debug(message, ...)               \
+  do {                                        \
+    AVB_LOG("DEBUG", message, ##__VA_ARGS__); \
+  } while (0)
 #else
+#define avb_assert(expr)
 #define avb_assert_not_reached()
+#define avb_debug(message, ...)
 #endif
 
 /* Aborts the program if |addr| is not word-aligned.
@@ -54,85 +96,42 @@ extern "C" {
 #define avb_assert_aligned(addr) \
   avb_assert((((uintptr_t)addr) & (AVB_ALIGNMENT_SIZE - 1)) == 0)
 
-#ifdef AVB_ENABLE_DEBUG
-/* Print functions, used for diagnostics.
- *
- * These have no effect unless AVB_ENABLE_DEBUG is defined.
- */
-#define avb_debug(message)              \
-  do {                                  \
-    avb_printv(avb_basename(__FILE__),  \
-               ":",                     \
-               AVB_TO_STRING(__LINE__), \
-               ": DEBUG: ",             \
-               message,                 \
-               NULL);                   \
-  } while (0)
-#define avb_debugv(message, ...)        \
-  do {                                  \
-    avb_printv(avb_basename(__FILE__),  \
-               ":",                     \
-               AVB_TO_STRING(__LINE__), \
-               ": DEBUG: ",             \
-               message,                 \
-               ##__VA_ARGS__);          \
-  } while (0)
-#else
-#define avb_debug(message)
-#define avb_debugv(message, ...)
-#endif
-
 /* Prints out a message. This is typically used if a runtime-error
  * occurs.
  */
-#define avb_error(message)              \
-  do {                                  \
-    avb_printv(avb_basename(__FILE__),  \
-               ":",                     \
-               AVB_TO_STRING(__LINE__), \
-               ": ERROR: ",             \
-               message,                 \
-               NULL);                   \
-  } while (0)
-#define avb_errorv(message, ...)        \
-  do {                                  \
-    avb_printv(avb_basename(__FILE__),  \
-               ":",                     \
-               AVB_TO_STRING(__LINE__), \
-               ": ERROR: ",             \
-               message,                 \
-               ##__VA_ARGS__);          \
+#define avb_error(message, ...)               \
+  do {                                        \
+    AVB_LOG("ERROR", message, ##__VA_ARGS__); \
   } while (0)
 
 /* Prints out a message and calls avb_abort().
  */
-#define avb_fatal(message)              \
-  do {                                  \
-    avb_printv(avb_basename(__FILE__),  \
-               ":",                     \
-               AVB_TO_STRING(__LINE__), \
-               ": FATAL: ",             \
-               message,                 \
-               NULL);                   \
-    avb_abort();                        \
-  } while (0)
-#define avb_fatalv(message, ...)        \
-  do {                                  \
-    avb_printv(avb_basename(__FILE__),  \
-               ":",                     \
-               AVB_TO_STRING(__LINE__), \
-               ": FATAL: ",             \
-               message,                 \
-               ##__VA_ARGS__);          \
-    avb_abort();                        \
+#define avb_fatal(message, ...)               \
+  do {                                        \
+    AVB_LOG("FATAL", message, ##__VA_ARGS__); \
+    avb_abort();                              \
   } while (0)
 
+#ifndef AVB_USE_PRINTF_LOGS
+/* Deprecated legacy logging functions -- kept for client compatibility.
+ */
+#define avb_debugv(message, ...) avb_debug(message, ##__VA_ARGS__)
+#define avb_errorv(message, ...) avb_error(message, ##__VA_ARGS__)
+#define avb_fatalv(message, ...) avb_fatal(message, ##__VA_ARGS__)
+#endif
+
+/* Converts a 16-bit unsigned integer from big-endian to host byte order. */
+uint16_t avb_be16toh(uint16_t in) AVB_ATTR_WARN_UNUSED_RESULT;
+
 /* Converts a 32-bit unsigned integer from big-endian to host byte order. */
 uint32_t avb_be32toh(uint32_t in) AVB_ATTR_WARN_UNUSED_RESULT;
 
 /* Converts a 64-bit unsigned integer from big-endian to host byte order. */
 uint64_t avb_be64toh(uint64_t in) AVB_ATTR_WARN_UNUSED_RESULT;
 
+/* Converts a 16-bit unsigned integer from host to big-endian byte order. */
+uint16_t avb_htobe16(uint16_t in) AVB_ATTR_WARN_UNUSED_RESULT;
+
 /* Converts a 32-bit unsigned integer from host to big-endian byte order. */
 uint32_t avb_htobe32(uint32_t in) AVB_ATTR_WARN_UNUSED_RESULT;
 
@@ -261,6 +260,11 @@ void avb_uppercase(char* str);
  */
 char* avb_bin2hex(const uint8_t* data, size_t data_len);
 
+/* Writes |value| to |digits| in base 10 followed by a NUL byte.
+ * Returns number of characters written excluding the NUL byte.
+ */
+#define AVB_MAX_DIGITS_UINT64 32
+size_t avb_uint64_to_base10(uint64_t value, char digits[AVB_MAX_DIGITS_UINT64]);
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/libavb/avb_vbmeta_image.c b/lib/libavb/avb_vbmeta_image.c
index 384f5ac19e5..44d75fda322 100644
--- a/lib/libavb/avb_vbmeta_image.c
+++ b/lib/libavb/avb_vbmeta_image.c
@@ -254,6 +254,7 @@ void avb_vbmeta_image_header_to_host_byte_order(const AvbVBMetaImageHeader* src,
 
   dest->rollback_index = avb_be64toh(dest->rollback_index);
   dest->flags = avb_be32toh(dest->flags);
+  dest->rollback_index_location = avb_be32toh(dest->rollback_index_location);
 }
 
 const char* avb_vbmeta_verify_result_to_string(AvbVBMetaVerifyResult result) {
diff --git a/lib/libavb/avb_vbmeta_image.h b/lib/libavb/avb_vbmeta_image.h
index 24f8519ff60..221ccd1d383 100644
--- a/lib/libavb/avb_vbmeta_image.h
+++ b/lib/libavb/avb_vbmeta_image.h
@@ -157,10 +157,12 @@ typedef struct AvbVBMetaImageHeader {
    */
   uint32_t flags;
 
-  /* 124: Reserved to ensure |release_string| start on a 16-byte
-   * boundary. Must be set to zeroes.
+  /* 124: The location of the rollback index defined in this header.
+   * Only valid for the main vbmeta. For chained partitions, the rollback
+   * index location must be specified in the AvbChainPartitionDescriptor
+   * and this value must be set to 0.
    */
-  uint8_t reserved0[4];
+  uint32_t rollback_index_location;
 
   /* 128: The release string from avbtool, e.g. "avbtool 1.0.0" or
    * "avbtool 1.0.0 xyz_board Git-234abde89". Is guaranteed to be NUL
diff --git a/lib/libavb/avb_version.h b/lib/libavb/avb_version.h
index 57c6ece851c..e6f7798769d 100644
--- a/lib/libavb/avb_version.h
+++ b/lib/libavb/avb_version.h
@@ -18,7 +18,7 @@ extern "C" {
 
 /* The version number of AVB - keep in sync with avbtool. */
 #define AVB_VERSION_MAJOR 1
-#define AVB_VERSION_MINOR 1
+#define AVB_VERSION_MINOR 3
 #define AVB_VERSION_SUB 0
 
 /* Returns a NUL-terminated string for the libavb version in use.  The

-- 
2.53.0

