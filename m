Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CC6CF34C4
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B34883F7D;
	Wed, 19 Nov 2025 15:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K9Q2prXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 835E783F8E; Wed, 19 Nov 2025 15:55:26 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F40A983F72
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3e3dac349easo4055652fac.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564121; x=1764168921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=86e6S9XiNrKtWPHyZSxJ1eeNOlbqONZDJwFlTUBmUpc=;
 b=K9Q2prXMApryShcZeHXc/sgZSHyV6o4S7DovB/5P/gKoUhYsuJuAfoUP+L0sfVBqr4
 /gl0TfgPgYagcKYfTfyfxsyftxJVIPIRQgA4bzB5raKNCaxIRDJ0UHOIKmltCwB0MQ02
 4yo3xZuvhPCbn4h6BJOnl9q0qYVj93fHjbac0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564121; x=1764168921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86e6S9XiNrKtWPHyZSxJ1eeNOlbqONZDJwFlTUBmUpc=;
 b=U6TgvE32bg7XjVm56IJq+EXIam8NTPuz6jgk2Ev9EtYVoZ7OzxKiN5QMAF9rw0TjZU
 2AVqu9vMT3SwTRiJPIKYrDJtTf7GMsWzFdY3AdiCjy4JSTnrgjNSOySoEVoeQM03xqmh
 QJ3QwCWRt/PTkscJGa5X88LcBTbs2TbrO/MxfLrqaqtwltzg34Be8xFUWnBr2VwNCOLv
 7xRWnyyi/3Dg8xGVruaEc1wvU+y8nGCHdJ2kqRLq5cGveevcowhtxwvMBruTACGzKEu0
 dfXjSiJHfLs069Pm7I13jwNTerVL75BWxAQn043gUrcfHyv2kKmgqtKAuRmrX0/5oclc
 7uNQ==
X-Gm-Message-State: AOJu0YzOl9rsGx2PllDX141iZL5kLDHkLmNlCXk+tgUnhxOMhDhUyDwP
 Vv3oJAkIF+8OVjb/I2VbYGL7+6J9IFO0YNF3har/UQT7jv0GrChPGX25gphkiujitGeRxctRq49
 ZWC7zOApWBQ==
X-Gm-Gg: ASbGnctZwVp57v2lLhphxdgteL6nn16Alb/sQjYRZxrEMqjnNmbGxGxPeKdVZRpdOns
 Vs//iJ2N3DU706KyCeX6iz1WJGD7UXgyhLbsa+jtyNsP/5NDddC3DZWdh8vyPOYFH3nPqWkx2O0
 Tg7XDwmQ9rRRSjeTDBsV24VcyH5LKLGlv7ipoyUfEH83D8dJBrLaqB/x2uKWWOmWxJAukZNpqEa
 VjUgruK9vWwfq1NPlG0hKw/fFDAoLI7sHDCVNBr2ntlXjPsJTmL0bejFCDN37XEE8GaldnQ3Q0L
 Wu83IgF6HdSFnvtIxJcS5R57Jv5jdi3M1RoqAVinAxhmxAIwFoSQTQomlOD5ZUZDVZNCmYBS1NR
 P3q+OLslT/ygnH4qQZYbn0/uIHESvCX9xSJxhV9ZZdXyiSLYGdDVEibmsjn/c1djeYMDSxSFo7P
 nIaJkSsDkuaCrJRi06zt4V9oP3MotWB5b02uXc7DxpULpxbEIZc//4
X-Google-Smtp-Source: AGHT+IF4NiOM5GTq2QN66XuBCqHTWHVLl7ggHldKOgS3mShb5M4YG6bzb4TjuEI678EuWLbmgJlZPQ==
X-Received: by 2002:a05:6870:3313:b0:3dc:b701:c9b3 with SMTP id
 586e51a60fabf-3e8691844bcmr11613021fac.45.1763564120586; 
 Wed, 19 Nov 2025 06:55:20 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e851ffcdd8sm8344360fac.3.2025.11.19.06.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Rick Chen <rick@andestech.com>
Subject: [PATCH] ae350: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:55:19 -0600
Message-ID: <20251119145519.843178-1-trini@konsulko.com>
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

Cc: Rick Chen <rick@andestech.com>
---
 include/configs/ae350.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/ae350.h b/include/configs/ae350.h
index 23e4801379de..43b1878b520d 100644
--- a/include/configs/ae350.h
+++ b/include/configs/ae350.h
@@ -83,7 +83,6 @@
 #include <config_distro_bootcmd.h>
 
 #define CFG_EXTRA_ENV_SETTINGS	\
-				"fdt_high=0xffffffffffffffff\0" \
 				"initrd_high=0xffffffffffffffff\0" \
 				"kernel_addr_r=0x00600000\0" \
 				"kernel_comp_addr_r=0x04600000\0" \
-- 
2.43.0

