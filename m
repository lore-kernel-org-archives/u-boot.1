Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B754E6ADD5
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 08:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B17F389403;
	Sat, 23 Nov 2024 09:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HJ/3ZayK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BA48893EB; Sat, 23 Nov 2024 09:48:23 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3516A893ED
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 09:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A3E613FE11; 
 Sat, 23 Nov 2024 08:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732351699;
 bh=qcYXNZx9Ho35oItjLwhMwJk9VFAZhjOL4iNlXKzNBa4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=HJ/3ZayKmUzXrxQqrF/R4b1PFH/zdOm8D7psDyCQBuNDHy2VfteliJohm1BgIUVkN
 MHR++nkWKG66/uWuk7KltwZpnetxXPQ0tsYrseaRlJy5gi7Wmly9VUddPZGWHMS09I
 DogFteB1ljNfRu4eI1IOT/3P6cHGnlL3RTllHcTZMSVg76Lzjiiow8kqzG1LbsJiqY
 F44wz3t0FYkI6DGeM+FsqWoElscjX85WS1aLzjff0a2l758nwe1oAgCOj7yUa3X4dj
 InGK3RbKXgh4iZlzsJaDMMrABrAa8vfwL4s5rJLzUwJ8jaR/cdoJAe17cYNViIyTpb
 aQ0Uhpz5oKOvg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kalen Brunham <kalen.brunham@intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/4] examples: use QEMU compatible LOAD_ADDR on RISC-V
Date: Sat, 23 Nov 2024 09:47:54 +0100
Message-ID: <20241123084754.59182-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241123084754.59182-1-heinrich.schuchardt@canonical.com>
References: <20241123084754.59182-1-heinrich.schuchardt@canonical.com>
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

On some RISC-V including QEMU $loadaddr is 0x80200000.
For bootelf to work choose a different LOAD_ADDR to which the demo ELF
binary is relocated.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 examples/api/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/examples/api/Makefile b/examples/api/Makefile
index 13e859cf080..722c7e45904 100644
--- a/examples/api/Makefile
+++ b/examples/api/Makefile
@@ -22,6 +22,9 @@ else
 LOAD_ADDR = 0x80200000
 endif
 endif
+ifeq ($(ARCH),riscv)
+LOAD_ADDR = 0x84000000
+endif
 
 # Resulting ELF and binary exectuables will be named demo and demo.bin
 extra-y = demo
-- 
2.45.2

