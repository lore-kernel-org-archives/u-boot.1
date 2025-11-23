Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DD6CFD2F6
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 22:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FCC983C5E;
	Sun, 23 Nov 2025 23:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XNROSbPf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F38283B7E; Sun, 23 Nov 2025 23:58:27 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3553483C4B
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0F1C844973; 
 Sun, 23 Nov 2025 22:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938682;
 bh=xpVMxRqwbU1YGyKGq8IgJoSggcdpZsUI87d42N5GlB8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=XNROSbPfUC/AwjaMmeQkWnQgLpL3LS7HT7QDbNZqUh5ont3pwjOK3YhQc7TX7rHjB
 WmZE+dpalpFGIFVwaLb8Cef/6guUnOjejp1ccwv3IBxjSfLGXXRYybH0raUiNtNS0/
 qSi9X9/lHX1n1+9c7FoHIyITfLrld5VLSVStoc2Ea4pHyUpAWMfWlu+UbcaxK+Re1D
 IQDDRNb5v3d2U4A6UZNgK7A7ZbODBilSSrQ4X8dRg87Mvpx66etlj1syCIF4EET4s/
 usgjQzwMRIP9CN48srBHlD8Lohaoz17LP+3SCkbAP4SCmInhq2D9GUNnsbqfuARAG4
 aXM6uvlSyrbiL5R9zijhlvAH/BJJ/U7EEe1I/CwGU0ixRuBjNfSTgi/l0Fu9T/1Ja5
 TiYAk5VEpulpJxFqLq0JHe9JbVGo7Z/rAiNOjgOahXD/MSv7OvuTOX6ZwjUH7bC/6V
 MC1LBM3rGLehQeWOnq8RoS7nG68KQOp/mfCLNSx0bGhaxa5lzOfxOrJdDgS1SL4Yw9
 enFHq1WjPKZOAGfOuJu+yU5woSg3w/3szHRmHi49QyVYf9yhdmquYtN02VdXTBp2IX
 +aBs1mezJyXBgr10os+3ixCGtQcs30/0Nbmq7xTRSIBQobax+QTQZ6BeY+pcK+UK/B
 MBKxmYfp9epFQeldD/+rA7/M=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Richard Weinberger <richard@nod.at>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 08/19] test: do not assume memory size 256 MiB in
 cmd_test_meminfo
Date: Sun, 23 Nov 2025 23:57:00 +0100
Message-ID: <20251123225711.227016-9-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
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

256 GiB is the default memory size of the sandbox. But in our CI other
boards like qemu-x86_64_defconfig run with a different memory size.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/meminfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/cmd/meminfo.c b/test/cmd/meminfo.c
index 53b41e3b49e..40c3520496e 100644
--- a/test/cmd/meminfo.c
+++ b/test/cmd/meminfo.c
@@ -14,7 +14,7 @@
 static int cmd_test_meminfo(struct unit_test_state *uts)
 {
 	ut_assertok(run_command("meminfo", 0));
-	ut_assert_nextline("DRAM:  256 MiB");
+	ut_assert_nextlinen("DRAM:  ");
 	ut_assert_nextline_empty();
 
 	ut_assert_nextline("Region           Base     Size      End      Gap");
-- 
2.51.0

