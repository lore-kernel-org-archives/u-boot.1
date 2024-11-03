Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352C6E67807
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 05:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A480F8910A;
	Sun,  3 Nov 2024 06:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eVxypz3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37CC68910E; Sun,  3 Nov 2024 06:36:18 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EB06890FC
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 06:36:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5CB423FE11; 
 Sun,  3 Nov 2024 05:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730612174;
 bh=xuUoNYhmbHYBCzCD8KrNVYRgnUpPkDL1cGTQJuBLhtU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=eVxypz3Dj/+fDPEHmJeG0GD98gi+EPL7202Q76giD3Ms7WNeFHQasyNML69Z9d4Q0
 Y+AyNLkFV0BaV3NMwvdCoF2oPYWvpK1ri2fzllN0X0N7oCmOEBdTSaXcYNjX576Qbn
 Txy00dDNXzKhB+XCqdL+P9EWzJNZgZSVItJaA/0vHJvARPeidEnJRbKehYX981Q9Ki
 ZLM14h31SWSgSvMay4wELumM3ay+3POgY+85bG+3qqaW2BdqUrXwAh+wVWbOEgb8dr
 +01GebIDudOAt/HbFnMIe2x8+uHG8BXPEIDqh9NC1UuKpvnLHPMrv0gvn1gZF+hcXC
 8ryJtcuuNCoOg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kalen Brunham <kalen.brunham@intel.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] examples: adjust LOAD_ADDR on arm64
Date: Sun,  3 Nov 2024 06:35:50 +0100
Message-ID: <20241103053551.52715-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241103053551.52715-1-heinrich.schuchardt@canonical.com>
References: <20241103053551.52715-1-heinrich.schuchardt@canonical.com>
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

Change the load address on arm64 such that it is compatible with the memory
available on qemu_arm64_defconfig.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 examples/api/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/examples/api/Makefile b/examples/api/Makefile
index ca4eb1f71ad..ec1643e4875 100644
--- a/examples/api/Makefile
+++ b/examples/api/Makefile
@@ -9,8 +9,12 @@ ifeq ($(ARCH),powerpc)
 LOAD_ADDR = 0x40000
 endif
 ifeq ($(ARCH),arm)
+ifdef CONFIG_64BIT
+LOAD_ADDR = 0x40400000
+else
 LOAD_ADDR = 0x1000000
 endif
+endif
 ifeq ($(ARCH),mips)
 ifdef CONFIG_64BIT
 LOAD_ADDR = 0xffffffff80200000
-- 
2.45.2

