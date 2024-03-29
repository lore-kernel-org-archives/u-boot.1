Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3612C6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 11:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 091EA88224;
	Fri, 29 Mar 2024 12:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711711107;
	bh=4etpwCtHCK9Zs6jSwtB12OyWve4UsIRTqx0mmsWrHkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i5lYl1Fx0pNInK3DRsw+wkaRUFyZZNPFD+T8rtg+9s6gLRKnmpMnWwvvCBuu5BnBV
	 HQic5vy8QeKhihp51DyVxJGSCwL/MAPAF+JeTwLdaQNyuGt3cFvwjEn80Cl86BZZt9
	 IYM+pPs75RPxcC6gyHyJ9005EfMhn5koR+Ovai6OQku03mOfKT+KzfZz3+y172HJuw
	 91b9cfasvMg0t+VUxjlE2F2+jbwvZ95XHwiLfnQkFWU+KBr/dpMb4bQdsz8PcnmO3z
	 +cs0CHO5y5qYlAjWtG+aZqrh8/RZIrA145ODvgbUe8WhV++FAxAyr6+kNRINNYkM7D
	 HGAtI8mtmgt3w==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 95A2E88234;
 Fri, 29 Mar 2024 12:18:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711711103;
 bh=4etpwCtHCK9Zs6jSwtB12OyWve4UsIRTqx0mmsWrHkM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t2E7eMvI7oSEVuWuof2UYslJHajibndp/4ZvCpen9TYsM7m6a/LA0felCP4BKPWJ+
 x6Xg+X+ZSkQKjMRoQHVDYDYz1SB/tej+wXF7r2D8F1dnD81T0fDsOpe1moy13U+fZj
 Qs4+uCTAS3CQdWHgBatw8RmLoGFWjv1juXXPi1KhUY+HhDUuUrz/cj0LQNigp06mwJ
 /7pasNpoilyJygkaBdVnuY6Jz/OdBzgTwY2CZBmi+I8Ybi4WV/Lww6+mxEu7GEHati
 LcX1mGcZSpSnzIC6soaflHFebGGzHZ0vM3B4Aqvf0e0KGStrQmbjwxh7Gu/9WAn/Nr
 D688HLNY2fnbA==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] arm: spl: Add definition for PHY reset GPIO for XEA HW
 rev. 2
Date: Fri, 29 Mar 2024 12:18:07 +0100
Message-Id: <20240329111809.3959962-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240329111809.3959962-1-lukma@denx.de>
References: <20240329111809.3959962-1-lukma@denx.de>
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

The imx287 based XEA board's revision 2 uses GPIO_3_21 for PHY reset

It is safe to keep the GPIO_2_13 as well, as in the SPL SPI1 is not
used for transmission. This simplifies the code, as the proper
configuration is performed either in falcon boot's read DTB or in
u-boot proper (with correct FIT configuration chosen).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

(no changes since v1)

 board/liebherr/xea/spl_xea.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/liebherr/xea/spl_xea.c b/board/liebherr/xea/spl_xea.c
index 551ed6fbae..4068a2ad49 100644
--- a/board/liebherr/xea/spl_xea.c
+++ b/board/liebherr/xea/spl_xea.c
@@ -225,7 +225,8 @@ const iomux_cfg_t iomux_setup[] = {
 	MX28_PAD_ENET0_TXD0__ENET0_TXD0 | MUX_CONFIG_ENET,
 	MX28_PAD_ENET0_TXD1__ENET0_TXD1 | MUX_CONFIG_ENET,
 	MX28_PAD_ENET0_TXD3__ENET1_TXD1 | MUX_CONFIG_ENET,
-	MX28_PAD_SSP1_CMD__GPIO_2_13, /* PHY reset */
+	MX28_PAD_SSP1_CMD__GPIO_2_13, /* PHY reset HW Rev. 1*/
+	MX28_PAD_SAIF0_LRCLK__GPIO_3_21, /* PHY reset HW Rev. 2*/
 
 	/* TIVA boot control */
 	MX28_PAD_GPMI_RDY3__GPIO_0_23 | MUX_CONFIG_BOOT, /* TIVA0 */
-- 
2.39.2

