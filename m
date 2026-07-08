Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1D2C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7D1E849BA;
	Wed,  8 Jul 2026 19:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="QXCpULkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD08F849D2; Wed,  8 Jul 2026 19:32:25 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D1838407E
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 19:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so1493175e9.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 10:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783531943; x=1784136743; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lm3qncQYKJ+ToJavg+A8K3tu6BQ2Bq38AsofTMpA1dw=;
 b=QXCpULkdD6CT8pfsODh5V5i7N1LaQjxbL2lCNtALeDOJz3H7/sbJ6yGb/G7A1VJmBS
 ZbwTvxg6pyerx39DtQ5Vgc9J5qEBqu7WBCa1JK0YBdJi1C6Ffi4mt6LkIM9/w9pYe39M
 3W2mlD1bpKB6RqJZl0bA5FlvRtUszxpaW2dO3wkR8fEY5NlSVfeTIrc/rVdEBqHCSX1c
 FcCPl5BYY/HzN7HBwQjrrtdVAsMhZhqRYQqDGmoi6jbESd22KrUPHv2XZ8Nc//xKWf9T
 1QqwWIbg1dg1vxD1b/REMhmiwTfTsBq35cDi1sdtmzQKVwo/oD5U9T1O/qkGyOsSXitC
 VPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783531943; x=1784136743;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lm3qncQYKJ+ToJavg+A8K3tu6BQ2Bq38AsofTMpA1dw=;
 b=kY70fLLZQLoz+8dC8jjVfJirW6X98BVEMJ4l0VPg3Jbj7YIAk4gacpH7zBC/VHWFQO
 zAw2wm7GaQWFD5lH6rKd9XsFzr9LtgyERAyCcXXvLfFQgSkHIIy95D+yyCvzohkBo7Ws
 /s8Skih/S9wcKXJNpL4bau2RTb7bJnYRDiFDPM5AQHY72mFr6MJ/Fuic4sGtspV/6sCP
 bR+EOkURx8J3Ap+mcRNImI1tH+ByNTphNhxcXZC3Akf9HBotL9bawGXTOriJ/+TmQaPL
 dtQHODZ021Zq1Wq21fBvgyfb2+BHDKgmvGq3mjJGtm5RwPB2RkeRPAiTqkafIWe+0XFz
 pZlw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+LPIXER6SH13fCbbZ1huTHPZt0a380+A6mEqG65DXzh2B1m1yq8zOa6Su7ILGtlT6ASRrD2c=@lists.denx.de
X-Gm-Message-State: AOJu0YzwK7ImDWBfFPDMpNBf1CS772BHzReUcYUij6vnnIHkNw4uFRsg
 XQdTO6Em0j8pHq8/pGUeTCqBWajpqpLqb/nzhZwP+N0RDEs0XIZkdHG9j8tvKggEjOY=
X-Gm-Gg: AfdE7cnS0OAHUHan+I1nb4puL2n1oFlPMys0aAiFMAN9vUnkXsz0lA8kPjsHDyPR16Z
 bfd1k8folcExBTEU/FUmy9gou0nzmDlojcVBhO4yLovfMTztqIU8poE2clqSLbGhOjczgHKORC1
 bqOnZLDy3Eix2CBQGqR5XEBzHbR8NON+OUzPmk3SI914Db2Efgb/Ym8NWzc7NMvJisEvIsIG4yg
 nvbhRpLkA9HAiA829zi+yD5CjYRqcf84xwW+ZDti3MchAfnZn6fw++tjFxFrqHBckg/WmPS2oeO
 eOCk9rtMsFNZithownBLMOOt+sfez6F5V4TaolBgbG1XY7jI/XPgK0/3Bxehj3psAP1UZf2dFYI
 0dohFWb7nq9VB4sLK3Q35WWxaR1jwj/k8VkTjiY6X9ZRNDb1uyXPIMGRe/5Hby7vjRJEoKfXHVA
 4Qdos5vUCax9oCOYnIJ3gMBgoXZp3eu/8zvKBm7OA/+G1sxwyXmi401jQoSM/70U14
X-Received: by 2002:a05:600c:1f94:b0:493:d3c5:6c32 with SMTP id
 5b1f17b1804b1-493e63711a6mr36098985e9.6.1783531942890; 
 Wed, 08 Jul 2026 10:32:22 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0faee30sm131991785e9.10.2026.07.08.10.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 10:32:22 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 08 Jul 2026 21:32:07 +0400
Subject: [PATCH] boot: android: fix out-of-bounds access in bootconfig parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-image-android-oob-fix-v1-1-a96de8ccd25e@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywqEMAwAf0Vy3kAV0bK/Ih76iBphW2lXEcR/N
 +pxBmYOyJSYMnyLAxJtnDkGgfJTgJtMGAnZC0Olqka1SiP/jEgTfIrsMUaLA++orXZky7ZRNYG
 0SyLRz7frX86rncn97xmc5wV9FU4LeQAAAA==
X-Change-ID: 20260708-image-android-oob-fix-8b8ceb17604e
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Safae Ouajih <souajih@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4232; i=alchark@flipper.net;
 h=from:subject:message-id; bh=lnZs9TNOWH4xFV23h+xy3f8mNx/h2mgUw7cURXOEGP8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT5dS5JYf5aIyGflPtLqdPt/Utdf5Et5hUe0761r1p9b
 /XxxxZTOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjq28WMDIv5JLimGHB2rt+7Rdrb7+0n2+9G/zQ/Cy+tdW841aaptYaRYb+Nx+S
 4+eqrlu9ad21f0O7+2Vu4N1es+zEp2PXEuqvzOFgA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

When android_image_get_vendor_bootimg_size is called, its buffer is only
allocated with enough space for the bootconfig header, but the
android_vendor_boot_image_v3_v4_parse_hdr helper attempts to append a
bootconfig trailer to it, causing an out-of-bounds access and heap
corruption in some cases (e.g. triggered in sandbox test builds when
extra bootmeths are added, resulting in a segfault of the sandbox
process).

Skip the dangerous memcpy operations altogether when the
android_vendor_boot_image_v3_v4_parse_hdr helper is only called for size
calculation purposes, and only append the bootconfig trailer when called
from the actual bootconfig parsing code path.

Fixes: 57e405e1f474 ("android: boot: support bootconfig")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
This was uncovered while adjusting the test suite to cover the BLS type 1
boot method following Simon's feedback at [1]. While my BLS code did
indeed leak memory as Simon pointed out (tripping some of the tests),
it also happened to uncover a latent bug in the existing Android boot
method which only seems to be triggered when the heap is pre-filled with
more boot methods than were used in the master branch so far, so even
fixed BLS code still resulted in a failing test there.

[1] https://lore.kernel.org/u-boot/CAFLszTikihqsUmOGdmb8Q9WypiEHb0nq-a7vXH5XrXNxRVeNjg@mail.gmail.com/
---
 boot/image-android.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index fb26290d40c7..7740cae8cb62 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -131,7 +131,8 @@ static void android_boot_image_v3_v4_parse_hdr(const struct andr_boot_img_hdr_v3
 }
 
 static void android_vendor_boot_image_v3_v4_parse_hdr(const struct andr_vnd_boot_img_hdr
-						      *hdr, struct andr_image_data *data)
+						      *hdr, struct andr_image_data *data,
+						      bool write_trailer)
 {
 	ulong end;
 
@@ -167,12 +168,23 @@ static void android_vendor_boot_image_v3_v4_parse_hdr(const struct andr_vnd_boot
 	end += ALIGN(hdr->vendor_ramdisk_table_size, hdr->page_size);
 	data->bootconfig_addr = end;
 	if (hdr->bootconfig_size) {
-		void *bootconfig_ptr = map_sysmem(data->bootconfig_addr,
-						  data->bootconfig_size +
-						  BOOTCONFIG_TRAILER_SIZE);
-		data->bootconfig_size += add_trailer((ulong)bootconfig_ptr,
-						     data->bootconfig_size);
-		unmap_sysmem(bootconfig_ptr);
+		if (write_trailer) {
+			void *bootconfig_ptr = map_sysmem(data->bootconfig_addr,
+							  data->bootconfig_size +
+							  BOOTCONFIG_TRAILER_SIZE);
+			data->bootconfig_size += add_trailer((ulong)bootconfig_ptr,
+							     data->bootconfig_size);
+			unmap_sysmem(bootconfig_ptr);
+		} else {
+			/*
+			 * Only the header has been loaded here (this is a
+			 * size-only query), so the bootconfig region is not
+			 * present in the buffer. Account for the trailer that
+			 * will be appended at load time without writing it, to
+			 * avoid corrupting memory past the header buffer.
+			 */
+			data->bootconfig_size += BOOTCONFIG_TRAILER_SIZE;
+		}
 		data->ramdisk_size += data->bootconfig_size;
 	}
 	end += ALIGN(data->bootconfig_size, hdr->page_size);
@@ -265,7 +277,7 @@ bool android_image_get_vendor_bootimg_size(const void *hdr, u32 *vendor_boot_img
 		return false;
 	}
 
-	android_vendor_boot_image_v3_v4_parse_hdr(hdr, &data);
+	android_vendor_boot_image_v3_v4_parse_hdr(hdr, &data, false);
 
 	*vendor_boot_img_size = data.vendor_boot_img_total_size;
 
@@ -304,7 +316,7 @@ bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
 			return false;
 		}
 		android_boot_image_v3_v4_parse_hdr((const struct andr_boot_img_hdr_v3 *)bhdr, data);
-		android_vendor_boot_image_v3_v4_parse_hdr(vhdr, data);
+		android_vendor_boot_image_v3_v4_parse_hdr(vhdr, data, true);
 		unmap_sysmem(vhdr);
 	} else {
 		android_boot_image_v0_v1_v2_parse_hdr(bhdr, data);

---
base-commit: a18265f1ccb7a272721ed4286ed3b5a6182ff424
change-id: 20260708-image-android-oob-fix-8b8ceb17604e

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

