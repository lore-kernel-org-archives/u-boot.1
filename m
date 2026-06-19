Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E95BCD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 16:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE28849E9;
	Fri, 19 Jun 2026 18:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="larsFY/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B6EC849AE; Fri, 19 Jun 2026 12:55:53 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29C0C847C3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 12:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qstrydom0@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso25301745e9.0
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 03:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781866550; x=1782471350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rO96LYYvM6BGZ1Ik9iDxoCKy0gb+183SoZNvF55aDYM=;
 b=larsFY/+wJZleFbz3UCMspQxBCGkV+DWAa27PW791LlfhvM++EIsKKuZKoSKfgSFC8
 IhfZ/okPqIsnsiiQZZFc2ViJjUbCIAwgSJ7Pq5iDj19v/WlOq3X0zf52xTbXhT4G+jsM
 jm53ESx/D2cvXjG0QZEMAIKi524wUO0I+J5Sh34lUpmL49IBQL8RpdD9hGw3Tp0CkyYm
 AA1jta2vUiiOvanBbqS4wXGwfq3n2jk6iqEq2WrjX+enRhJSEgTPh2KX0NOaZIhYgHOF
 ZeRBdyHyW8VVCXq08IxU01diQCzywUr2Gv3T+qsHK+DhbVxtZZD5K2nMXgmDqIS6AcvK
 5dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781866550; x=1782471350;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rO96LYYvM6BGZ1Ik9iDxoCKy0gb+183SoZNvF55aDYM=;
 b=Wui21rfI5gOIYoS6Vrds00p7D91thDNpZgPlCjo7m/cubEZLc9Foh+2fGbvmtY16vG
 0KUyjzqB0YeQI7uVBnfq47VoC+FgrkzISrYUFEZ4B+ADGAq/C+229PRYrFL8vI1eoPfD
 CCwbW+CLzSQw/cRrYjfSNKI5vz0UeSJkxb8cpDCCDmdiv8L6tQX78J3y4epd/yVLCFlU
 BjIdQEBHT5xoI6aZDCkjFc7LCopWrWJ6XZa2oMAt51895a+zjmZbvwK2YG85dM6zKEwE
 TW+MK70I9qZCCw1ux9OMwDSWi3pyxgT70qBx5gkQjiP+wk+HKjBcs4Y2f9vtMAiApR+X
 7F6g==
X-Gm-Message-State: AOJu0YwIQlFD9CkU7Q5yeq7Ay/CVjQO+DRxcGmACUcxfuoLBLljje2ka
 Gv0h6lFdBORsmKurvqO5t8Sx3m5e4Dhu/JU/+6d6XeaEtvtYRaLnWPI04DsJNrMC
X-Gm-Gg: AfdE7cm9mre2qWouuzUqi925rDkpTRt46wqkkzTfJ9LpOHDjQtF+8PyrS0Ff6GpogQ9
 tYzrICQcMMuaxJCMbL9gvZQkzqSGIaci/w62h/Qb0n0PU7v/0BBW3eNPaHinqi5c8WGyzTEiC3m
 A8sSNki1+hR6T3EwOan/67aFvx9kjZWpdgg0xYXEMQoho2ZuAjGzMh9OX6a8v2A1zghHavUIxTB
 Tt/NxJ2kZf1gqve18wqAaJRRLjsGipmuMCG+XtrZsyKhi+DVY+KDay/XlijTEEhmg5Qzm6nwmDZ
 woLeB5BOR7MWO7Xo1G6fFdQTh6PvVILbHY/zUvX+PnSrT6s/m3R6lhzfqi6lpHjCWkglp1q32b9
 rGeNaRjqlDThnMug2ckoUc52RB9R5YckbBCRIegCGb9hJKIlsuuNX4ak1joZt/coRWWjmdUB9ov
 JsJ9riysy6os4jBXA=
X-Received: by 2002:a05:600c:a40f:b0:492:432b:d78b with SMTP id
 5b1f17b1804b1-492432bdad3mr26279365e9.15.1781866550405; 
 Fri, 19 Jun 2026 03:55:50 -0700 (PDT)
Received: from home.powerhub ([2a0a:ef40:30:7801:4c2b:2403:9030:81cb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fe7b9e5sm60655175e9.10.2026.06.19.03.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 03:55:50 -0700 (PDT)
From: Quentin Strydom <qstrydom0@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, sjg@chromium.org,
 james.hilliard1@gmail.com, malysagreg@gmail.com, tien.fong.chee@altera.com,
 sughosh.ganu@arm.com, philip.molloy@analog.com, qstrydom0@gmail.com
Subject: [PATCH] spl: pad external DTB to _image_binary_end with separate BSS
Date: Fri, 19 Jun 2026 11:55:29 +0100
Message-ID: <20260619105529.50815-1-qstrydom0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 19 Jun 2026 18:31:25 +0200
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

When CONFIG_SPL_SEPARATE_BSS is enabled, fdt_find_separate()
expects the SPL control DTB at _image_binary_end. However,
u-boot-spl-dtb.bin is currently generated by concatenating
u-boot-spl-nodtb.bin and the SPL DTB directly, without padding
up to _image_binary_end.

On evb-ast2600 this places the appended SPL DTB at 0xc92c while
_image_binary_end is 0xc930. The SPL therefore checks four bytes
past the FDT header and fails early with:

  Missing DTB
  No serial driver found

Add padding between the xPL nodtb binary and the DTB when separate
BSS is enabled, so the DTB is placed where fdt_find_separate()
expects it.

Signed-off-by: Quentin Strydom <qstrydom0@gmail.com>
---
 scripts/Makefile.xpl | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index a3fd3e1375f..fcb79df3cc4 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -332,8 +332,8 @@ endif
 
 ifneq ($(build_dtb),)
 $(obj)/$(SPL_BIN)-dtb.bin: $(obj)/$(SPL_BIN)-nodtb.bin \
-		$(if $(CONFIG_$(PHASE_)SEPARATE_BSS),,$(obj)/$(SPL_BIN)-pad.bin) \
-		$(FINAL_DTB_CONTAINER)  FORCE
+		$(if $(CONFIG_$(PHASE_)SEPARATE_BSS),$(obj)/$(SPL_BIN)-image-end-pad.bin,$(obj)/$(SPL_BIN)-pad.bin) \
+		$(FINAL_DTB_CONTAINER) FORCE
 	$(call if_changed,cat)
 
 $(obj)/$(SPL_BIN).bin: $(obj)/$(SPL_BIN)-dtb.bin FORCE
@@ -343,6 +343,17 @@ $(obj)/$(SPL_BIN).bin: $(obj)/$(SPL_BIN)-nodtb.bin FORCE
 	$(call if_changed,copy)
 endif
 
+# Create a file that pads from the end of the xPL nodtb binary to _image_binary_end
+$(obj)/$(SPL_BIN)-image-end-pad.bin: $(obj)/$(SPL_BIN) $(obj)/$(SPL_BIN)-nodtb.bin
+	@image_end=$$($(NM) $(obj)/$(SPL_BIN) | awk '/ _image_binary_end/ {print "ibase=16; " toupper($$1)}' | bc); \
+	actual=$$(wc -c < $(obj)/$(SPL_BIN)-nodtb.bin); \
+	count=$$((image_end - actual)); \
+	if [ $$count -lt 0 ]; then \
+		echo "Invalid xPL padding: image_end=$$image_end actual=$$actual"; \
+		exit 1; \
+	fi; \
+	dd if=/dev/zero of=$@ bs=1 count=$$count 2>/dev/null
+
 # Create a file that pads from the end of u-boot-spl-nodtb.bin to bss_end
 $(obj)/$(SPL_BIN)-pad.bin: $(obj)/$(SPL_BIN)
 	@bss_size_str=$(shell $(NM) $< | awk 'BEGIN {size = 0} /__bss_size/ {size = $$1} END {print "ibase=16; " toupper(size)}' | bc); \
-- 
2.43.0

