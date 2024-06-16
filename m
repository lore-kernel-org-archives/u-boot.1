Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A75C27C6E
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 17:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D281888167;
	Sun, 16 Jun 2024 19:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZI+dRJGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1327D88131; Sun, 16 Jun 2024 19:31:10 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98FA988167
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 19:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-041-025.um47.pools.vodafone-ip.de
 [178.202.41.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CB6773F2E8; 
 Sun, 16 Jun 2024 17:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718559067;
 bh=oPyTy069VwLOb74GOipUcO/4wICa0Cr2EphXAg3D43I=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ZI+dRJGE6JS5sZNtN2hkbCvs8erP+UKlOmpuOP4f0x9roUcvm7fH+FdYXzHgOI/hq
 JQk0AsC3Tb21mJf38ATOEjTO6dhRrgHoHrmNgWTq//KBeKQ7k1RfTjF0rX1OVU58zW
 wLt/7Rf9DV/rj9P5R4OPMorvPUYjPVOddLl38XLPNvJO0j5LtoDbeRoyw7OZatT9Yj
 vlQ9dbz/ZC3coQuowf9EdPSYqjYWtC4CvXx1dRGB85K8jkQSWbq5fc7FO+aMy6qjh6
 TT599btsxbUg+UNNn5GDX2SAoAXY4Ars2otoFhZN6KGDDxwngXxf4ZjGMidDgp+Lwj
 Uw0cgZoElLXEA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] cmd: avoid duplicate weak flush_dcache_all()
Date: Sun, 16 Jun 2024 19:31:03 +0200
Message-ID: <20240616173105.7430-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
References: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
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

If we have multiple weak implementations of functions, the linker might
choose any of these. ARM and RISC-V already provide a weak implementation
of flush_dcache_all().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cmd/cache.c b/cmd/cache.c
index 0254ff17f9b..16fa0f7c652 100644
--- a/cmd/cache.c
+++ b/cmd/cache.c
@@ -52,11 +52,14 @@ static int do_icache(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+/* ARM and RISC-V define a weak flush_dcache_all() themselves. */
+#if !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
 void __weak flush_dcache_all(void)
 {
 	puts("No arch specific flush_dcache_all available!\n");
 	/* please define arch specific flush_dcache_all */
 }
+#endif
 
 static int do_dcache(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
-- 
2.43.0

