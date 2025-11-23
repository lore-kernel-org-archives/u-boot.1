Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC48CFD315
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 01:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1859A83B8B;
	Sun, 23 Nov 2025 02:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QA3v/Ft6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9CEE83B9B; Sun, 23 Nov 2025 02:19:31 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76E7C83B7E
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 02:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5A4674248F; 
 Sun, 23 Nov 2025 01:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763860768;
 bh=oQ4y6vsljhb52mERZhKSVQ4nFAu5/D8+erwJmz9NFnM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=QA3v/Ft600faC5V+5HhPUjdnQso1gMVfWChVUwpj5XojZhkuAuFHPooY3UiXqCnE7
 sG0pjeT2kn3yS+XKocvdrC9/G9QvcuPPp1WjTZwgq+IYC1VA+c7MIRmBrs3wnoG2CD
 AEgV3RNjFsDM6t33b+Z8ISAodkVxcEDQbIt5NsGu563YoXBCc4+EVHHemi0bIDo+jS
 R2dBbS+bdvj6iJM3zLuBJEtSJILDzLc0ko1fXtSdLbpwWUBs1eHbZ62KKjt03dGjWu
 4QxShLsKagP3BrUWqXMz8v3tO1Km21iHmmBwvYH8JJWwA2/ljNPZyy8PfNXzbZPsEs
 MKOCONj5Qb1JZDGfDlXXg7fWR/yj5GV9s2elDkzKmWWVx24z1hFtLZaH+070FElIwG
 ZLXgpdtbM2SGHMAZnGSfSS2kbMyT5VlTjeIm5rce34BT/W5XYOWNQbAfqut3mvRTw9
 KFEPBwYftHtpQ5DANvvmC+K6hN5C3yTBRmlfUZd7pVSEECloTdCo6VgLLiDrx6FFnp
 LrxLTkO1OWkpCY0oS1K20MdSII0JiB6Rn1HV4wDcmktM/L0RGN/TF1Lt8nnvVHogs6
 HZOa51ae8CQM7nNMa3SlHCfXLhoFWFRFX6fkkzQLtlsHDbo5MnjgWaPl7AAZ6RMDW9
 +YHAvLmLOeeNlW/V0xbLB4Jo=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] test: cmd/bdinfo: consider ARM architecture specific info
Date: Sun, 23 Nov 2025 02:18:58 +0100
Message-ID: <20251123011900.91233-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123011900.91233-1-heinrich.schuchardt@canonical.com>
References: <20251123011900.91233-1-heinrich.schuchardt@canonical.com>
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

On ARM the bdinfo command prints architecture specific information.
The test needs to accept these output lines.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/bdinfo.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 28d448a0866..9ffa0d3cdd5 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -224,6 +224,34 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 	if (gd->arch.firmware_fdt_addr)
 		ut_check_console_linen(uts, "firmware fdt");
 #endif
+#ifdef CONFIG_ARM
+	ut_check_console_linen(uts, "arch_number");
+#ifdef CFG_SYS_MEM_RESERVE_SECURE
+	if (gd->arch.secure_ram & MEM_RESERVE_SECURE_SECURED)
+		ut_check_console_linen(uts, "Secure ram");
+#endif
+#ifdef CONFIG_RESV_RAM
+	if (gd->arch.resv_ram)
+		ut_check_console_linen(uts, "Reserved ram");
+#endif
+#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+	ut_check_console_linen(uts, "TLB addr");
+#endif
+	ut_check_console_linen(uts, "irq_sp");
+	ut_check_console_linen(uts, "sp start");
+#ifdef CONFIG_CLOCKS
+	ut_check_console_linen(uts, "ARM frequency =");
+	ut_check_console_linen(uts, "DSP frequency =");
+	ut_check_console_linen(uts, "DDR frequency =");
+#endif
+#ifdef CONFIG_BOARD_TYPES
+	ut_check_console_linen(uts, "Board Type  =");
+#endif
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
+	ut_check_console_linen(uts, "Early malloc usage:");
+#endif
+
+#endif /* CONFIG_ARM */
 
 	return 0;
 }
-- 
2.51.0

