Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61236EF5862
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 06:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1CD68366F;
	Wed, 25 Feb 2026 07:19:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="s5cFLbLW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C44683DCB; Wed, 25 Feb 2026 07:19:56 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52DC682A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6DBA83FC1E; 
 Wed, 25 Feb 2026 06:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772000393;
 bh=Abj/6VywZX6hDwfB6ALSXG3x5Tw3GZU7xmZdFU0XqRs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=s5cFLbLWDZlUfaexHpY68bl/EfS6jFvOyOlSBGj09EP99+9ZpCmsjlpPinhBMKLa/
 BAQKpz6KVnWE9qfNJzPkh7lftoKt7KZyS4UXI06N4eWBI0RyXCHl254SLBTsET64VH
 YNLs+7oBJ7lTzWZsIJmw9BCJLvRRSR6HWKCNS+TxKTyBin69wjpHUXfoIve7+EsCFw
 sKF21v6L7PiXOvm+SowPAmSo01qKRJ0VFY2dEz/SaDA3Qh6MKX4rVxZTfhs+N+Cysf
 p3Q0DC/H1O2YxOselnuppAIEbHbhOO3GCIjKc0aF3psj2sRQrdZUYfIR0funNvAq+5
 nWOeBNfSU6wAYpLt++7S20EeNJDXyqFqmX+9GrSeNIaWFEo927Lzm7/66wTAb9x+hJ
 zYmLHc64PG3Wv7KIpfAMOo/Ygw5cpR5iwxJVwKQY7uKoL/ZbUTvdMWop3X0xkRzdZd
 HpYqdMaGo/h9kbxQ013dVXM4C+R2FqMqYe714kw350SneM25FSaxXwcHb5NQVGUlyW
 tZMixAdbNZMVTieFLWnpKSHrFF9Ho2SFTW+vwAV+zYmP8sg+y3HNKDXmlu3buvPtv9
 Q02S+JobYSROT2eM9CVvUZYNYv6em9YegTe6j80bXp7KZ8FUtFt6gDe8MXUcnkGgfs
 5MuGIt3K1Ybwe4IzjZR4Cxak=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>
Cc: Tom Rini <trini@konsulko.com>, adsp-linux@analog.com, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] arm/mach-sc5xx: don't select non-existent
 GIC_600_CLEAR_RDPD
Date: Wed, 25 Feb 2026 07:19:51 +0100
Message-ID: <20260225061951.46329-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

The symbol CONFIG_GIC_600_CLEAR_RDPD does not exist.
Don't select it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/mach-sc5xx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index ec1d5539dc9..e781603a8cf 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -44,7 +44,6 @@ config SC59X_64
 	select COMMON_CLK_ADI_SC598
 	select GICV3
 	select GICV3_SUPPORT_GIC600
-	select GIC_600_CLEAR_RDPD
 	select MMC_SDHCI_ADMA_FORCE_32BIT
 	select NOP_PHY if PHY
 
-- 
2.51.0

