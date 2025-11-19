Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010D5CF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C52183FCD;
	Wed, 19 Nov 2025 15:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AiSo/4os";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FFE38004F; Wed, 19 Nov 2025 15:55:33 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8348783FBC
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-450154aa53fso2767554b6e.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564130; x=1764168930; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o8eikFhlW44LBAT25rM2jPkPInsghPj0YEdSCe8Vh74=;
 b=AiSo/4oswDXl2GH0wPgN6LgBSmhhnHi7xz8qfkoWg/P+V/h+t7Zaqr5DM49XU6vc1z
 Z+RJ1scED/RAgUvjrlU9ZfGgufU3gzp1GuSVQZIUcpadcIc5l82H/CFTHRoD5oWz3nGv
 oEvyL/ViG0s2hRMfhP6cmDMOeXzky6SSKrrco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564130; x=1764168930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8eikFhlW44LBAT25rM2jPkPInsghPj0YEdSCe8Vh74=;
 b=oONePTFTIMlDVNVUsoEHJCkkxBIFvMtlAv5+uHuplhXieYDdgB/bUcWHI+Pj6nUZgI
 /aiu64jl42XKhnWeE3gDeKDa/9Wp+PS2lyq3XrkwqPmZun9k0XIsD+hUf4AtdSF4gK4V
 SHdqfHl0ut8fCHTUHzR7orPdbFdX4AF5avXllDzW3bMraV/50Dm04Nj2TgKDGFAVsP1x
 km29XuFbDT0lEeKrq8W1TDovfR+w+O5R4Wz0HXypOHHr/Bsri8hPkwd0cj9OWpOSR1kg
 GeATRWCHUO+ekaWLjMvTF9C3ZP9Ge3zpFxl60yZmgfDOljm+ao2i7Wnt244CcDe2p0+8
 2FDQ==
X-Gm-Message-State: AOJu0YzKrHiatebi1EoSQzfQYYC+oF9q0UwCQvrGC+OBS2E97aheFBgR
 npxBfeuNjiQq5HxmM8950OI7YiwKcuuobciJzEx7o1dLnRUCYgOO2qDa7JH59ZFWi1zAKGRg8LD
 byLk+4q4EbQ==
X-Gm-Gg: ASbGncu5ecT0a1ZfAs7Rnodg5WOmIvtDCTXrPoFI6wJade21gxwui56RWGvaCzfwWJ1
 SVlXWWexV7Z/rdxw2pwTPAsYlGqXM57T3vFg8mOMJJYtZpr72+RebI9oB3CZjhHJAPNt0h5EOFq
 6KoiZpSBL17VX9a8LBFCkk7A8TIEy4TYY57IkrcdW0pL/UhTUNDq010DFhynwzRy/XBSwId4Wkx
 0A1ghhJuP6ASP7Xm6HK2e/c5di3TMUPpvUQ9CWtFEutN7GMc0a6t/i/FHu0oQ4/HYZpC3P/AG+D
 ejCMq+Rr9AMov8zvuCCE3ox86C/xzo/kGGsYFC/caSO+CoMZf1PmyPRnEeIcRlqsD2vdvB0+Glo
 FTZSUwugnZEZk1GI08sCUoVWaD3IWxkfQq2Fnq+GtGFBWXDJY/bNvze/tSksqOEIot2smZfFT5g
 ipzgHYwSt3yQoW8iB7KBt5RaI+YTlGox2JEziNXabtaZJj5JjyfhN3nG5I9wbLDPU=
X-Google-Smtp-Source: AGHT+IHnAId7aDchlXcX5OO0L7UCILndyF7JUZiABZFzEz+kEWvr+2w6IGLeuYXUlybeVkgCy0eHlA==
X-Received: by 2002:a05:6808:c188:b0:437:eb1d:cdde with SMTP id
 5614622812f47-45097585105mr8471675b6e.33.1763564130258; 
 Wed, 19 Nov 2025 06:55:30 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a283b6asm7853662a34.5.2025.11.19.06.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Pramod Kumar <pramod.kumar_1@nxp.com>
Subject: [PATCH] ls1012afrdm: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:55:28 -0600
Message-ID: <20251119145528.843285-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Pramod Kumar <pramod.kumar_1@nxp.com>
---
 include/configs/ls1012afrdm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/ls1012afrdm.h b/include/configs/ls1012afrdm.h
index 4243a21f1f18..8059092fac8f 100644
--- a/include/configs/ls1012afrdm.h
+++ b/include/configs/ls1012afrdm.h
@@ -19,7 +19,6 @@
 #undef CFG_EXTRA_ENV_SETTINGS
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"verify=no\0"				\
-	"fdt_high=0xffffffffffffffff\0"		\
 	"kernel_addr=0x01000000\0"		\
 	"scriptaddr=0x80000000\0"		\
 	"fdtheader_addr_r=0x80100000\0"		\
-- 
2.43.0

