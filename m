Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC2AD4662F
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 22:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F4680325;
	Thu, 15 Jan 2026 23:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t79q8kGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A1FD830E4; Thu, 15 Jan 2026 23:28:44 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B2B682BF2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 23:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7cfda2de4efso860658a34.3
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768516121; x=1769120921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHz1fIVegkD6Xjxp7kKwyU7cuHq1s6FF64sA5y9J7lw=;
 b=t79q8kGd8moZ0DRl+5MglLTrkgao1YSOjmR1pxG1/p/r6BCwnDt8z3s5nU5oClXR9r
 GHGRIHlsj7I1EYtDEkw4DUOm616NzPJR+YclhVjwAFx324wed+zJeva3nBtypz3yTaDa
 5Ep+J/a9qr8ebT5SDax1zkJmIUaBb53dfw0Yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768516121; x=1769120921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MHz1fIVegkD6Xjxp7kKwyU7cuHq1s6FF64sA5y9J7lw=;
 b=OtYIvZ8v9halxMoIwVmDGw6VWKSmaYIDTQpbAKqh81K6+6D4Khx0LWRwP5pcgG7y6d
 lA5ayoeOptcKP/6klcGO4WLC7XfSy4b6DziWE5jvncA9Sjx4cS6v0DvKKeu3YzXv8MJ8
 iUzUW82zSIVNB2xldbvkGcTza3uW94TqtQ/9AV2CDSTfFMIJb62OVKvZdsxg8x2jBmaU
 WiehnlxFm9TQ2CVfI4U6Je6K2l0wTgPFlBX2hbHL+wFHbVpMRa3LtoYtPYObq+CBFN6O
 jBkDqRO1KdHqEKDrZIEOCBpH+jpleTQ5tQOZf27fVKBiiEPiG4vmxwcFpZ/fcncod/1E
 hiVA==
X-Gm-Message-State: AOJu0YzJrEl6ohIOtIEBwiM6cxcuTlSRFZXlIQAgbsUo2pMhgDfj/KgT
 JjBkCQFPTBg2ObUM4Z5sVSicyi256UY+248VZf+Bvxufg19k08huhyYCTqCJEmx5nZ6Xz23tGCH
 A+LtsXbI=
X-Gm-Gg: AY/fxX7/UGyqQRwPEEx656rhqaIEQuJxZ3LsEc6ft+PuShP1FwmH/KOLWbVefvIMIcd
 YHJewLgoccHiEP7AehLFNLQvtbsGYn5Kpa1Q0CDq8tXp2jyxgsheXvweMKUCfYA1LHwvhn6xLfO
 IhENKk9dNyzU00a/EyNgjFRllXyei6ArXx9Q52s41zSLuNL2y1mdTYmxXy/zKMG/yREJg3sDG+h
 9Gz1U9i1+9KkWIbh3YyjLg74YCBmime5emxLD2JtBf3tX4wazHq91nvKIWIiDIxWrc/fAgHoe8y
 GpFfRkm++P9dYaXcJsK1RUHzphMmD6cXHXByipzJ+vpcopljTp8q4TDR8pxrJIU6ACqYQGZA0il
 ddheuUTn413XOB9Q5XjhNuCHj357HOBaCiU6XYsIXYA9XbBJVfqPgOsNDiGsGXasBBYRTH5wx8i
 rYXuYsnH6/RBjORcwhYP8mWoS+2gM/ZqTUENy61w3ulPQXQVPXhQ9BU0XUz/CQxq/BhSENZYFeq
 K520LhzH2UU4vXHvHXkus9X3lItxOxhFbmP+vHV9g==
X-Received: by 2002:a05:6830:3bc3:b0:7cf:d96d:7882 with SMTP id
 46e09a7af769-7cfded33d6bmr621400a34.3.1768516120707; 
 Thu, 15 Jan 2026 14:28:40 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b5aaesm544074a34.31.2026.01.15.14.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:28:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Chou <thomas@wytron.com.tw>
Subject: [PATCH 06/10] nios2: Update linker scripts to ensure appended device
 tree is aligned
Date: Thu, 15 Jan 2026 16:19:36 -0600
Message-ID: <20260115222828.3931345-7-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115222828.3931345-1-trini@konsulko.com>
References: <20260115222828.3931345-1-trini@konsulko.com>
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

With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
that we must have ALIGN(x) statements inside of a section to ensure that
padding is included and not simply that the linker address counter is
incremented. To that end, this patch:
- Aligns the final section before _end 8-bytes by adding '. = ALIGN(8);'
  to the final section before the symbol.
- Remove a now-spurious  '. = ALIGN(x);' statement that was intended to
  provide the above alignments.
- Ensure that we do have alignment by adding an ASSERT so that when not
  aligned we fail to link (and explain why).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Chou <thomas@wytron.com.tw>
---
 arch/nios2/cpu/u-boot.lds | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/nios2/cpu/u-boot.lds b/arch/nios2/cpu/u-boot.lds
index 5b9e27d94062..fc366d44341d 100644
--- a/arch/nios2/cpu/u-boot.lds
+++ b/arch/nios2/cpu/u-boot.lds
@@ -60,8 +60,8 @@ SECTIONS
 	  *(.sdata)
 	  *(.sdata.*)
 	  *(.gnu.linkonce.s.*)
+	  . = ALIGN(8);
 	}
-	. = ALIGN(4);
 
 	_edata = .;
 	PROVIDE (edata = .);
@@ -124,3 +124,5 @@ SECTIONS
 	.debug_typenames 0 : { *(.debug_typenames) }
 	.debug_varnames	 0 : { *(.debug_varnames) }
 }
+
+ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
-- 
2.43.0

