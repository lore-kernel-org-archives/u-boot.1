Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1650C3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13FF388B6E;
	Thu, 18 Jul 2024 19:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NmawWcQ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09F9488B6E; Thu, 18 Jul 2024 19:37:02 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F36888B78
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3683f56b9bdso71870f8f.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324211; x=1721929011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DANLmQPGPhYmw2xH6QkZGO+SL2iH6sEgRD3d92YlDlQ=;
 b=NmawWcQ1SczRb22R8dosFL5y0ydNhyPtlcrZv9lkLw6NDBU40KQvHZqRAvb3EGCgfL
 qMxyHefzhIajU8lOODh1OEV1VY+Xe6MT2Xn+UBsDJ003Bn0H+FHuahN0ZZx/l7ERmsBF
 YCzsCritSBLIvjb8Y1dT4LGNdLs1at4MG1GtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324211; x=1721929011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DANLmQPGPhYmw2xH6QkZGO+SL2iH6sEgRD3d92YlDlQ=;
 b=FQ5O/6KcvlpGqGs4v2Ckt+EkKnyUg58YQ0jg0RhLCPLciM5qr5dNCHHOipfAeqKWgq
 V4bV6U2E1cNcATLvcoMS4W/lpnUJRdJW61h3jPWCH7Tik3KXOKKRx2YLEkqoJw8oJTev
 IHmMxO9immnvaBELeNn24hk9AQS5L+BRTG93f9S7tQ1zdxZSvoGaBslDp//SI7FHDceh
 RWYCkup7WEbyFJqhcqwrY0OsdlgeYlq64YFr3gq1mF+Lo7EpennkmFwKLpIeE6YMgt09
 sKWt36linddxwk9uWgf/iRWJ8oSZxiuZcL1w8fYTCDIJcJREMchNNqpELukJqY07AN5T
 PxKg==
X-Gm-Message-State: AOJu0YyCxxh0KPv6IYo7B9SQ4T4iru6HV38GjCyvgyy7zELh8T7NhrVB
 24aJQafI+6HRZPkcvZDUweHBqynAV/VTJ+xs8VAMLTe8rVwf2PVx+G6pmC+4KRY5dILSZU/wTXI
 =
X-Google-Smtp-Source: AGHT+IF8KiTYGT6NoQjSreRVo04o7me4eIL2RpdrdoL3NCQHsK4dAtMh2jPpE1dCXfsISqT3/FnKBQ==
X-Received: by 2002:adf:e34c:0:b0:367:9279:c401 with SMTP id
 ffacd0b85a97d-3683165c8cfmr3656230f8f.34.1721324210768; 
 Thu, 18 Jul 2024 10:36:50 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Philip Richard Oberfichtner <pro@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 19/20] i2c: Remove CFG_SYS_I2C_MAX_HOPS
Date: Thu, 18 Jul 2024 18:36:10 +0100
Message-Id: <20240718173611.4014274-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
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

Now that this is always 0, remove it and the associated dead code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 README                 | 10 +---------
 cmd/i2c.c              | 23 -----------------------
 drivers/i2c/i2c_core.c | 37 -------------------------------------
 include/i2c.h          |  7 -------
 4 files changed, 1 insertion(+), 76 deletions(-)

diff --git a/README b/README
index 4b4d946e3fa..44dafa3be98 100644
--- a/README
+++ b/README
@@ -773,19 +773,11 @@ The following options need to be configured:
 
 		CFG_SYS_I2C_DIRECT_BUS
 		define this, if you don't use i2c muxes on your hardware.
-		if CFG_SYS_I2C_MAX_HOPS is not defined or == 0 you can
-		omit this define.
-
-		CFG_SYS_I2C_MAX_HOPS
-		define how many muxes are maximal consecutively connected
-		on one i2c bus. If you not use i2c muxes, omit this
-		define.
 
 		CFG_SYS_I2C_BUSES
 		hold a list of buses you want to use, only used if
 		CFG_SYS_I2C_DIRECT_BUS is not defined, for example
-		a board with CFG_SYS_I2C_MAX_HOPS = 1 and
-		CFG_SYS_NUM_I2C_BUSES = 9:
+		a board with CFG_SYS_NUM_I2C_BUSES = 9:
 
 		 CFG_SYS_I2C_BUSES	{{0, {I2C_NULL_HOP}}, \
 					{0, {{I2C_MUX_PCA9547, 0x70, 1}}}, \
diff --git a/cmd/i2c.c b/cmd/i2c.c
index 7dac0a9fb6c..7246c4fa3e7 100644
--- a/cmd/i2c.c
+++ b/cmd/i2c.c
@@ -1698,18 +1698,6 @@ static int do_i2c_show_bus(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		for (i = 0; i < CFG_SYS_NUM_I2C_BUSES; i++) {
 			printf("Bus %d:\t%s", i, I2C_ADAP_NR(i)->name);
-#ifndef CFG_SYS_I2C_DIRECT_BUS
-			int j;
-
-			for (j = 0; j < CFG_SYS_I2C_MAX_HOPS; j++) {
-				if (i2c_bus[i].next_hop[j].chip == 0)
-					break;
-				printf("->%s@0x%2x:%d",
-				       i2c_bus[i].next_hop[j].mux.name,
-				       i2c_bus[i].next_hop[j].chip,
-				       i2c_bus[i].next_hop[j].channel);
-			}
-#endif
 			printf("\n");
 		}
 #endif
@@ -1734,17 +1722,6 @@ static int do_i2c_show_bus(struct cmd_tbl *cmdtp, int flag, int argc,
 			return -1;
 		}
 		printf("Bus %d:\t%s", i, I2C_ADAP_NR(i)->name);
-#ifndef CFG_SYS_I2C_DIRECT_BUS
-			int j;
-			for (j = 0; j < CFG_SYS_I2C_MAX_HOPS; j++) {
-				if (i2c_bus[i].next_hop[j].chip == 0)
-					break;
-				printf("->%s@0x%2x:%d",
-				       i2c_bus[i].next_hop[j].mux.name,
-				       i2c_bus[i].next_hop[j].chip,
-				       i2c_bus[i].next_hop[j].channel);
-			}
-#endif
 		printf("\n");
 #endif
 	}
diff --git a/drivers/i2c/i2c_core.c b/drivers/i2c/i2c_core.c
index 7c43a5546d3..f371d952af5 100644
--- a/drivers/i2c/i2c_core.c
+++ b/drivers/i2c/i2c_core.c
@@ -111,23 +111,6 @@ static int i2c_mux_set_all(void)
 	struct i2c_bus_hose *i2c_bus_tmp = &i2c_bus[I2C_BUS];
 	int i;
 
-	/* Connect requested bus if behind muxes */
-	if (i2c_bus_tmp->next_hop[0].chip != 0) {
-		/* Set all muxes along the path to that bus */
-		for (i = 0; i < CFG_SYS_I2C_MAX_HOPS; i++) {
-			int	ret;
-
-			if (i2c_bus_tmp->next_hop[i].chip == 0)
-				break;
-
-			ret = i2c_mux_set(I2C_ADAP,
-					i2c_bus_tmp->next_hop[i].mux.id,
-					i2c_bus_tmp->next_hop[i].chip,
-					i2c_bus_tmp->next_hop[i].channel);
-			if (ret != 0)
-				return ret;
-		}
-	}
 	return 0;
 }
 
@@ -140,26 +123,6 @@ static int i2c_mux_disconnect_all(void)
 	if (I2C_ADAP->init_done == 0)
 		return 0;
 
-	/* Disconnect current bus (turn off muxes if any) */
-	if ((i2c_bus_tmp->next_hop[0].chip != 0) &&
-	    (I2C_ADAP->init_done != 0)) {
-		i = CFG_SYS_I2C_MAX_HOPS;
-		do {
-			uint8_t	chip;
-			int ret;
-
-			chip = i2c_bus_tmp->next_hop[--i].chip;
-			if (chip == 0)
-				continue;
-
-			ret = I2C_ADAP->write(I2C_ADAP, chip, 0, 0, &buf, 1);
-			if (ret != 0) {
-				printf("i2c: mux disconnect error\n");
-				return ret;
-			}
-		} while (i > 0);
-	}
-
 	return 0;
 }
 #endif
diff --git a/include/i2c.h b/include/i2c.h
index f468b52cd7b..180b71f1451 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -645,15 +645,9 @@ void i2c_early_init_f(void);
  */
 #define I2C_RXTX_LEN	128	/* maximum tx/rx buffer length */
 
-#if !defined(CFG_SYS_I2C_MAX_HOPS)
 /* no muxes used bus = i2c adapters */
 #define CFG_SYS_I2C_DIRECT_BUS	1
-#define CFG_SYS_I2C_MAX_HOPS		0
 #define CFG_SYS_NUM_I2C_BUSES	ll_entry_count(struct i2c_adapter, i2c)
-#else
-/* we use i2c muxes */
-#undef CFG_SYS_I2C_DIRECT_BUS
-#endif
 
 struct i2c_adapter {
 	void		(*init)(struct i2c_adapter *adap, int speed,
@@ -712,7 +706,6 @@ struct i2c_next_hop {
 
 struct i2c_bus_hose {
 	int	adapter;
-	struct i2c_next_hop	next_hop[CFG_SYS_I2C_MAX_HOPS];
 };
 #define I2C_NULL_HOP	{{-1, ""}, 0, 0}
 extern struct i2c_bus_hose	i2c_bus[];
-- 
2.34.1

