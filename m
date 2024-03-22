Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1C9C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 20:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DED587F50;
	Fri, 22 Mar 2024 21:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fM4RmPsn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AA7487D87; Fri, 22 Mar 2024 21:50:55 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D06E87D87
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 21:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b79c=K5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711140637; bh=b38LZKNa5dghyXfbEbDiJ4eqeX2Lozr+QS9nfo4B1Lk=;
 b=fM4RmPsn07cR34ag2CM6O3SUwjpmOllqRRHCu8FSKsfIDoOkXGA/2bji5v7B+Yy6KbSxu87jp
 MYO7IhzVDmSTXMM0ILGD5KBqASpC7JtUy1ExoXN5dZBNRBlmRuimuZ20GsM+3apg8aUxktbmILI
 GyV9vkQaE+Ln++to+pLS+J9TcawTHld3Q9lb2A5bsXP/XeicTQHlpUTt5vvdM7vlx7+VWxroStU
 H5YJHO1vzYDU0t0bPMXlw3y8j7ZRiVLj1j7dzcosvQUUrv975hzzXdzdSJDPjMXNCbsnGgj5yGl
 ChYcGDeigsEmPlbir2HC5eNJFWHvZaO0AliMhWuciMyQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Christopher Obbard <chris.obbard@collabora.com>, Dragan Simic
 <dsimic@manjaro.org>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>, Jason Zhu <jason.zhu@rock-chips.com>
Subject: [PATCH v2 1/3] rockchip: bootrom: Sync bootsource id enum from bootrom
Date: Fri, 22 Mar 2024 20:50:20 +0000
Message-ID: <20240322205027.3860170-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240322205027.3860170-1-jonas@kwiboo.se>
References: <20240322205027.3860170-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65fdef1d1b2ab365f8308b0f
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

From: Jason Zhu <jason.zhu@rock-chips.com>

Add more bootsource id:
1. BROM_BOOTSOURCE_UNKNOWN
2. BROM_BOOTSOURCE_I2C
3. BROM_BOOTSOURCE_SPI

Signed-off-by: Jason Zhu <jason.zhu@rock-chips.com>
[jonas@kwiboo.se: Update commit message]
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- New patch
---
 arch/arm/include/asm/arch-rockchip/bootrom.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
index 4276a0f6811a..ecf3b4e7428c 100644
--- a/arch/arm/include/asm/arch-rockchip/bootrom.h
+++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
@@ -43,11 +43,14 @@ void back_to_bootrom(enum rockchip_bootrom_cmd brom_cmd);
  * Boot-device identifiers as used by the BROM
  */
 enum {
+	BROM_BOOTSOURCE_UNKNOWN = 0,
 	BROM_BOOTSOURCE_NAND = 1,
 	BROM_BOOTSOURCE_EMMC = 2,
 	BROM_BOOTSOURCE_SPINOR = 3,
 	BROM_BOOTSOURCE_SPINAND = 4,
 	BROM_BOOTSOURCE_SD = 5,
+	BROM_BOOTSOURCE_I2C = 8,
+	BROM_BOOTSOURCE_SPI = 9,
 	BROM_BOOTSOURCE_USB = 10,
 	BROM_LAST_BOOTSOURCE = BROM_BOOTSOURCE_USB
 };
-- 
2.43.2

