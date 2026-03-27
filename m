Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C1010F286A
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 20:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 820AB83C5E;
	Fri, 27 Mar 2026 21:10:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lPgYo27A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6740A84020; Fri, 27 Mar 2026 21:10:11 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A95EC8394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 21:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso2358416a34.0
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774642204; x=1775247004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGlhJEYGz7uPXBUA8haEGMmMdi/jMV7rUX6HmMfLCEU=;
 b=lPgYo27AeclA8xCcL9WUAJ0GitFdRHSUHZh1boGl/R5wCthCBDBOQ0D4p7uhk9wyeo
 HL4DLK7iXZUkZtN/iX9Mus6GjKUwgjQEnfDYAZTpQkqVozUgt0DAoFPUxgHry+ENWp5t
 zjanIBbtnCfcXGAtgnBetwvvKh2ATRgaRuhq+BBDIwCDiZr3j5+/m3dpSw+1JNqL0aBM
 3a3osCeDVZlBPVExz4UjjPlYOfbSLb6BjkEk4KZfgqLMrnH+PtW1CstNDwqfus3UKCWJ
 gWOo2c8vBmlKKkJiP4DjDUIuFPcN3s1nUM4kvk2A/ziz++sVIS9LcJwl2EDzkE/UyqHD
 +xDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774642204; x=1775247004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iGlhJEYGz7uPXBUA8haEGMmMdi/jMV7rUX6HmMfLCEU=;
 b=lEENHKjjqgShQQBo7XwkdKaUEjnh3Y5/cFh1bcd/j9cn2+OI2c5hO/2E9Wt8Jjl8rO
 N8lZvpwZUEfAEFqRPlLL1CUUT1yU+53IEQKyaZ8npieBfPnQKhNSzqpeqvFU+zD2G2YK
 E93Bq/zntWBFOkVSGRpxx4LJEXuxSNcHWHhLNkc/0h2zT9RU7o94z9Wm2sqcl6DIFN+x
 avcQ3v7evc3BidKVDJvtl5LhRPi1QWb4Z2yq4/cd1iNs/2sb54H7xBQ2ZFqrxY2iRgEx
 yWTmghPuOFJelu3diH1bGYLbYGLwO9qNIXJNmyhBStFwm8Ie7u6yZ6fsoz6t1ETGO8Nb
 012g==
X-Gm-Message-State: AOJu0YxLUAjUwOPpl12YeHnoPs+oilWn0f2NXM8I0NYipoqxJb4j8ILF
 rO+1o2yJ23jNHywqoU+s1srF2+RRd5/5uVmz137YjpBgASvDSHkVZHiOYJU2GICg
X-Gm-Gg: ATEYQzy5NgV75YbGx7llqXSTpvmUMgs3Q2Xnfs+mfVcq1isokR2P4BPDn+u+DBjR7kh
 5V6YveW25Vmw1NFIRqeyxHbS8MCMOfKEzKODuTakauQTv9HAYsohprPgopRM9EfRtbNEnwvV7CI
 heAa6Pj1mzpL/TkIquLwEGfm0jKVqLzzzhYRXWnD2zeCNrmm7Hu9TRZxFRnfSmH9zPNj322KaSG
 yQZkkoD6oOUDSKg5ryER+NVIXapYlY/1wjcZxC3izq/s4Txgk3JFo8t0kIieV7+c1fy+N1QBS7O
 HJobEXXwb6VgKfCEm18r+VquGMbGXpkafT9pbe+sYnpWXxMvhgax08DJVMrzAzxm0CJQRPQv7Md
 ja3puTsHoLgTMwUOD0vdZXUGyX2B81FRnmOlSQWpoT3LfZBIOS5jwi2i/DBKBZn6SpCAQ4/GE+0
 5XrHSYYEL1ZZ17UPc9hXGWAWK3Bhj2aj/yX944cuhMb5rwnUz99IwP8tMw8cqHrP/adVf6iBBB6
 wLah4QvOPUVik/slPO58O5d3ZhYQyLcT74Jn1Qm87QKDG/lo/hGDCs93sg+
X-Received: by 2002:a05:6830:710a:b0:7d7:f457:5551 with SMTP id
 46e09a7af769-7d9faf8b034mr2241836a34.31.1774642204311; 
 Fri, 27 Mar 2026 13:10:04 -0700 (PDT)
Received: from james-x399.localdomain (71-33-142-50.hlrn.qwest.net.
 [71.33.142.50]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a7b5b41sm166102a34.15.2026.03.27.13.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 13:10:04 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Samuel Holland <samuel@sholland.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Alexander Graf <agraf@csgraf.de>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: [PATCH v4 4/5] dt-bindings: memory: allwinner: add sunxi DRAM type
 constants
Date: Fri, 27 Mar 2026 14:09:15 -0600
Message-ID: <20260327200932.2016910-4-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327200932.2016910-1-james.hilliard1@gmail.com>
References: <20260327200932.2016910-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add numeric DRAM type constants for the Allwinner DRAM
bindings so H616 DT nodes can describe the dram-type property
without using string values.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 include/dt-bindings/memory/sunxi-dram.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 include/dt-bindings/memory/sunxi-dram.h

diff --git a/include/dt-bindings/memory/sunxi-dram.h b/include/dt-bindings/memory/sunxi-dram.h
new file mode 100644
index 00000000000..c0a3201123a
--- /dev/null
+++ b/include/dt-bindings/memory/sunxi-dram.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef _DT_BINDINGS_MEMORY_SUNXI_DRAM_H
+#define _DT_BINDINGS_MEMORY_SUNXI_DRAM_H
+
+#define SUNXI_DRAM_TYPE_DDR3		3
+#define SUNXI_DRAM_TYPE_DDR4		4
+#define SUNXI_DRAM_TYPE_LPDDR3		7
+#define SUNXI_DRAM_TYPE_LPDDR4		8
+
+#endif
-- 
2.43.0

