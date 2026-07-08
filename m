Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD9BC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 01:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B78C384A0F;
	Wed,  8 Jul 2026 03:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jeGqD/c7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F132384A30; Wed,  8 Jul 2026 03:30:31 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6494284118
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so191821a34.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 18:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783474228; x=1784079028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8I+RwIoxwoZlXLkzMb777mM1fQUeYDfh1S6OEyz4RPw=;
 b=jeGqD/c7W+EtEjCtKTNq+7yK9+n7I9NHUBfZ3TPxrxabcy0EvOR5vxDRlJwIx1GC5r
 nTqb1RJ51X5hMWYmwSv3w3QBYYSzziC35AJ7MlVF7o7RL+ASB/xTuXga5p+S6qkDx9o8
 kspvZCBR0zVLHSSfXhK4cF9dgznSofTq87Q0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783474228; x=1784079028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8I+RwIoxwoZlXLkzMb777mM1fQUeYDfh1S6OEyz4RPw=;
 b=Li8fltdaU/XID/tIOPrs+lqL+1O8uKftXYFk75yd3DDeUrjrZjlDd09kbGFTU9oLSq
 Uby6lj7jY6PIyTLJgdtoKB01Knr3e9ic73Fg3L7VDumgavfENhmMpqHtF/ne4PzoTwyJ
 7YgjYInSCbvl76Ul+YkJVUSGAsJBCkgsek3r2Z6xdFJuwyBnjq2oQs1A462GGP24RRF4
 DfitzweIjdYEwzAKiylViksMhXPB/Q8cA2Qxq+mnGBYr3scV+Pec25/mi5f5tilQAkkO
 QZq/LVJaQBUe/+Tov9xNtRPCOLW0kjRO5S5cIF6NpSnPECKxeN33fzlUR+ESmbuLyI1J
 rqkQ==
X-Gm-Message-State: AOJu0YyRvOeTZn81zM6NvA8rb5G7hPMa50cnjGUDA5AL/KQudN/mGDqe
 v+PFo47VB0LqJnIHr2SlA9Eca6XQGf6Onws7ywkOwhhKk/DduThGUQor76CDh2MY1XdCpWYg0SX
 HXluTbq4=
X-Gm-Gg: AfdE7ckhY19Gm3jhQGXN8X0o34R9tr0O/MUzLFU3D/bON/fFdF6RjWEcQqbWh9oiM7b
 iSOpG9YorjtkPX6PGikGTS27VOATELcxQYwIBSQmG2MuHjA2a4fLzoE77acXatyhD5HP9jG1AwN
 HpmlhEeMC7kLAmT273hCTZaLBpJDXcf4Yb6U9AB1QV03m2ZMmru8GZqyNCBHhXXhFJXQGbc9W6t
 yS4rF/jE9rqlx6XBbHHvCk/L01KDEzrx7BY4t6swLBKdy7ukZ/QxFhELag1+uOuUXIxj2SQL9gG
 wU08vDEda4SdKCjaKaJvmvd42Q6kAYVWkwByaMDEekK3/k6P/JuIiua9NpYkzfMwsMWbWmxoWJ2
 hWfQrQOJyluuSRMcYtIyxDdc8vSCgzFSK9549mmQ9ToyBeyz7ca81VCyQ+V4iz/Oy/70xvu0nPi
 m+ucNgCbR+cBzIuPOJm0d8mfFSyxij2Nx7+xx1DVvkvmYglUwzo+t2z9SYXi57I2Kq+05WNMCBc
 eJsxHLLQUPtK2cwHzhPh92aag8PXrUiuQHpdZvBg06sxurbz4f8D3jUlxJg0w==
X-Received: by 2002:a05:6830:6f45:b0:7dc:e090:68a with SMTP id
 46e09a7af769-7ebcfed3e61mr247468a34.0.1783474228069; 
 Tue, 07 Jul 2026 18:30:28 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcaf77ba4sm780182a34.9.2026.07.07.18.30.27
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 18:30:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 6/7] powerpc: drop qemu-ppce500 dts
Date: Tue,  7 Jul 2026 19:25:16 -0600
Message-ID: <20260708013019.288985-7-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708013019.288985-1-trini@konsulko.com>
References: <20260708013019.288985-1-trini@konsulko.com>
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

Now that we are not building this device tree, we can drop it from the
tree.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/powerpc/dts/Makefile         |  1 -
 arch/powerpc/dts/qemu-ppce500.dts | 10 ----------
 2 files changed, 11 deletions(-)
 delete mode 100644 arch/powerpc/dts/qemu-ppce500.dts

diff --git a/arch/powerpc/dts/Makefile b/arch/powerpc/dts/Makefile
index 4fd3478ac2fa..a9075c16fefc 100644
--- a/arch/powerpc/dts/Makefile
+++ b/arch/powerpc/dts/Makefile
@@ -17,7 +17,6 @@ dtb-$(CONFIG_TARGET_P2020RDB) += p2020rdb-pc.dtb p2020rdb-pc_36b.dtb
 dtb-$(CONFIG_TARGET_P3041DS) += p3041ds.dtb
 dtb-$(CONFIG_TARGET_P4080DS) += p4080ds.dtb
 dtb-$(CONFIG_TARGET_P5040DS) += p5040ds.dtb
-dtb-$(CONFIG_TARGET_QEMU_PPCE500) += qemu-ppce500.dtb
 dtb-$(CONFIG_TARGET_SOCRATES) += socrates.dtb
 dtb-$(CONFIG_TARGET_T1024RDB) += t1024rdb.dtb
 dtb-$(CONFIG_TARGET_T1042D4RDB) += t1042d4rdb.dtb
diff --git a/arch/powerpc/dts/qemu-ppce500.dts b/arch/powerpc/dts/qemu-ppce500.dts
deleted file mode 100644
index e88e09e17961..000000000000
--- a/arch/powerpc/dts/qemu-ppce500.dts
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
-/*
- * Empty device tree for qemu-ppce400
- *
- * Copyright 2021 Google LLC
- */
-/dts-v1/;
-
-/ {
-};
-- 
2.43.0

