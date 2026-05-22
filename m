Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38130CD5BB1
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3450F847AF;
	Fri, 22 May 2026 15:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="LUwT+Mco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6FBE846A7; Fri, 22 May 2026 14:31:40 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C2B8841D7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 14:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e6128bd9b3so51237a34.1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 05:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779453097; x=1780057897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gn1NB+QXzFcvhgwbvJEIioVnPpxOJix/hKUGmxf9mRs=;
 b=LUwT+McopASaw0PQGrAUC+3/OC6lp2Y3yWFbazmA/UQPNsTNr4gBvSCQBhKUYAEYaq
 7TqNgF+aNs7G9gHHnKiypweAl9dwRU5fESE0hhQ4yAcVYfjfhLYXHN3AUn0CHN/7HnqL
 un0W5ON5CfD/jC44fb/o9MbqoxWYpUCWvcpD0hag+iI/a5EiZkdJtpusId48mO01VGOA
 cIfBvwAE2hzjbiD9UvREbtL4KbrbORz2S0vUQmkRAz95J/g5l5AHKoyiwe/QqHN3loh9
 3hvVXUuezdHy+zM/clPUfcz+m+gsCJ4vwi3Q8D700+2AhhcPzBFc59qPzCvwqUUDOWxb
 8ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779453097; x=1780057897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gn1NB+QXzFcvhgwbvJEIioVnPpxOJix/hKUGmxf9mRs=;
 b=snOziduOdqGMQ7stNEhzYPWbsTmMjBui+7T1iJ6x8eyFO2h548bHVPEJzrw19CTLH/
 jqCvWFeZSeUK+bVnKKjpbcaewtz282BlH6BKbaHKIso7EZ2mU5ZcVl5CZiQB/TV43t8+
 25QIrDvqpAywxzZLPu9HRhcY5Vmg+q14QPhc0Vk8jhzttt+diHM/vH3cV0EUIEgsnnOw
 9RdFNI+vNDgZsLpC5wp13rKUWo4Mjwj4r0I/epPnGcwviLN99zcuRLstM4vOQNHWlDgQ
 F/L/0nrFwN1NdjzP7DG99/4YzwgdtrG1kJaF//6xeMoksqeWwA/DmOqJPtqJ9cap/eYK
 7GfQ==
X-Gm-Message-State: AOJu0YyeMY2J2CBnOQIJRHEq+zXKkWNh89gNMXctDnqmuS8J28nvmxNe
 sIwcr7ZZgZ6npDEGw9MNcpyVGbt0qV1WgnvhoocyR1gJ4JxDZM74YiOsr8fwCIY1dBdJ/7yNgmM
 0QsKu
X-Gm-Gg: Acq92OGzwsN5mUF4fs3bM++WakJ0bVCpHl+y4tGQ+dMvm/zbSOzO+3Q4pLZjxrWPgiR
 XCabBJ9VxqKFvJpb9i6q32VmaUPU3jcDHVJwvmX1OJd8os1ZIeTG+e5A1D4fzUubYCUGnkVkl0L
 FDwOL9U1ZOg6PdHxSx07BCXR09Rrsh8BXxzxmYN8NHpqYWZm0EzNS4zru3v7O7//+7MISy649bW
 ky8XhOzcfbQRh13p6JQUKWN3OztjF5OglBKNy9WcOKlWFxOL7NR2gfEDF+nbPiByNM3lWr/Q/L4
 38dGyk9TUOSLLGpbLjueHD2iet0oQ/ydilJD9of2KWqRh9Gy/K5Y0+QfXdGVZR5iovNYKNtuMd2
 vJgYKeygEY4d5NU9Ow0YMqceRGKz4osvEjoTp1yGhBTe9vJGdp+tmgkzGdq+Oc1bsx09HTZjK1x
 LpFCgNrdxCIPId2ADa4vx3krpF6+70fFZAW0i3hHinan6HVA==
X-Received: by 2002:a05:6830:4705:b0:7d9:b2b8:e06f with SMTP id
 46e09a7af769-7e5feec29damr2035693a34.21.1779453097125; 
 Fri, 22 May 2026 05:31:37 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm4016553f8f.36.2026.05.22.05.31.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 May 2026 05:31:36 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	vr@binarly.io
Subject: [PATCH] image-fit-sig: Check that the strings region is within bounds
Date: Fri, 22 May 2026 13:30:21 +0100
Message-ID: <20260522123024.6292-2-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522123024.6292-1-anton@binarly.io>
References: <20260522123024.6292-1-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 15:09:24 +0200
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

From: Binarly Vulnerability Research <vr@binarly.io>

The fit_config_check_sig() function in boot/image-fit-sig.c builds a
list of FDT regions that cover the parts of the FIT that must be
hashed for the signature verification. Once the structure regions
have been collected, the function adds one extra region for the
string table, using the 'hashed-strings' property:

	/* Add the strings */
	strings = fdt_getprop(fit, noffset, "hashed-strings", NULL);
	if (strings) {
		/*
			* The strings region offset must be a static 0x0.
			* This is set in tool/image-host.c
			*/
		fdt_regions[count].offset = fdt_off_dt_strings(fit);
		fdt_regions[count].size = fdt32_to_cpu(strings[1]);
		count++;
	}

	/* Allocate the region list on the stack */
	struct image_region region[count];

	fit_region_make_list(fit, fdt_regions, count, region);
	if (info.crypto->verify(&info, region, count, fit_value,
				fit_value_len)) {
		*err_msgp = "Verification failed";
		return -1;
	}

'strings' is a pointer to the raw bytes of the 'hashed-strings'
property in the FIT. No check is performed on strings[1], and it is
assigned verbatim as the size of the strings region. The
fit_region_make_list() function then copies the size verbatim into
the 'region' array:

	for (i = 0; i < count; i++) {
		debug("%10x %10x\n", fdt_regions[i].offset,
				fdt_regions[i].size);
		region[i].data = fit + fdt_regions[i].offset;
		region[i].size = fdt_regions[i].size;
	}

info.crypto->verify for 'sha1,rsa2048' is rsa_verify(), located in
lib/rsa/rsa-verify.c, which calls hash_calculate() defined in
lib/hash-checksum.c:

	for (i = 0; i < region_count - 1; i++) {
		ret = algo->hash_update(algo, ctx, region[i].data,
					region[i].size, 0);
		if (ret)
			return ret;
	}

hash_update_sha1(), defined in common/hash.c, takes the per-region
size as an unsigned int and feeds it directly to sha1_update(). With
an attacker-chosen value such as 0xFFFFFFFF, the SHA update reads
nearly four gigabytes from fit + fdt_off_dt_strings(fit), walking
well past the end of the FIT image and into unmapped memory.

Fix: Validate that the declared size is non-negative and fits within
the FIT before adding the strings region to the list. The offset
itself is already validated by fdt_check_header().

Signed-off-by: Binarly Vulnerability Research <vr@binarly.io>
---
 boot/image-fit-sig.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 433df20281f..bdfb5e3eb7c 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -512,8 +512,18 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
 		 * The strings region offset must be a static 0x0.
 		 * This is set in tool/image-host.c
 		 */
-		fdt_regions[count].offset = fdt_off_dt_strings(fit);
-		fdt_regions[count].size = fdt32_to_cpu(strings[1]);
+		int offset = fdt_off_dt_strings(fit);
+		int size = fdt32_to_cpu(strings[1]);
+		/*
+		 * The offset should be already validated by fdt_check_header();
+		 * validate the size here.
+		 */
+		if (size < 0 || size > fdt_totalsize(fit) - offset) {
+			*err_msgp = "Strings region is out of bounds";
+			return -1;
+		}
+		fdt_regions[count].offset = offset;
+		fdt_regions[count].size = size;
 		count++;
 	}
 
-- 
2.53.0

