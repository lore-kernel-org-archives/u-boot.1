Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694B0C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 848D088CAA;
	Sat, 20 Jul 2024 14:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IxdegUyE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pVkG5dWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F9DC88675; Sat, 20 Jul 2024 14:43:57 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB1C88C8D
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WR5nl4DnGz9sT1;
 Sat, 20 Jul 2024 14:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xSQ2T3J33QHVudqzrFDnc32l54DZLT27rOQDAtMNOOU=;
 b=IxdegUyEBxi30XD8A8ZOmoXsm/uS6ETocipKpb1v9WQSHEMdYjwI1XufN5wUg02RhK7v8q
 a9flW5P9si8rgHvWsGSZa0/iKbm/IzxKYwoXkaRCYHWTpB1mf+fyk2vY37Eu3LQBjSZG+8
 5f7P6e5EbrsAovwCKG3t+3gcOZu6j7dRStVlUeIPYHcMlbuKR3ijeELNlDlhPz+CxVRzJ6
 LgvO9De6LYLssO+xKd+9hehbAGmkl8xM0RM4Zpw3TeArnPhFWgrDA6MHH7rF1gpEWcLK9P
 Hi3OSw5bRcn7EF0wrHsWEaRh5EAqXUMU7naxrz7VasFzZypFQWva/VuTY+bY8A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xSQ2T3J33QHVudqzrFDnc32l54DZLT27rOQDAtMNOOU=;
 b=pVkG5dWyiUQEwuCnzngn9wopvdT6O/iJghNF1nLWc6/RptJjf4uajL9aLq6OUGJ815dkVQ
 er9DA5Z01y89VExLJGL6eeMaFKrT4h2UPelvKLidg/QSMjrrx7XzXtap6Snl3rqEfF4i7Q
 EqIWOwVruhD0XTyVmGuKhRBqRtSBf2s1TG96L+RuSB7pH/UUpHt7FSFmFDBOstNo7J4xdU
 /amnWokmBLE/Y0/md+GSq4myFtClrp3TJ2crETrP7gh8Uxd5q+rtqBUT0CYGsCqYs4MeHN
 COA/6ak15busmUXqPeMIl8fSHeOEcUK+mCOdmxXQXbBBbEkahlGy7g1t1gjkbQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 25/40] drivers: ram: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:50 +0200
Message-ID: <20240720124239.7553-25-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: aa4ef0e3feafba4314e
X-MBO-RS-META: jspaqd3xpf56xqeg9fs1yg6orsxx8nqo
X-Rspamd-Queue-Id: 4WR5nl4DnGz9sT1
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/ram/rockchip/dmc-rk3368.c   | 3 ---
 drivers/ram/stm32_sdram.c           | 2 --
 drivers/ram/stm32mp1/stm32mp1_ddr.c | 1 -
 3 files changed, 6 deletions(-)

diff --git a/drivers/ram/rockchip/dmc-rk3368.c b/drivers/ram/rockchip/dmc-rk3368.c
index 42114a5aa91..ab087275fe2 100644
--- a/drivers/ram/rockchip/dmc-rk3368.c
+++ b/drivers/ram/rockchip/dmc-rk3368.c
@@ -138,7 +138,6 @@ enum {
 #define DDR3_MR2_TWL(n) \
 	(((n - 5) & 0x7) << 3)
 
-
 #ifdef CONFIG_TPL_BUILD
 
 static void ddr_set_noc_spr_err_stall(struct rk3368_grf *grf, bool enable)
@@ -524,7 +523,6 @@ static int pctl_calc_timings(struct rk3368_sdram_params *params,
 	pctl_timing->tckesr = pctl_timing->tcke + 1;  /* JESD-79: tCKE + 1tCK */
 	pctl_timing->tdpd = 0;    /* RK3368 TRM: "allowed values for DDR3: 0" */
 
-
 	/*
 	 * The controller can represent tFAW as 4x, 5x or 6x tRRD only.
 	 * We want to use the smallest multiplier that satisfies the tFAW
@@ -987,7 +985,6 @@ static struct ram_ops rk3368_dmc_ops = {
 	.get_info = rk3368_dmc_get_info,
 };
 
-
 static const struct udevice_id rk3368_dmc_ids[] = {
 	{ .compatible = "rockchip,rk3368-dmc" },
 	{ }
diff --git a/drivers/ram/stm32_sdram.c b/drivers/ram/stm32_sdram.c
index 10dc05dd640..954995c499c 100644
--- a/drivers/ram/stm32_sdram.c
+++ b/drivers/ram/stm32_sdram.c
@@ -333,7 +333,6 @@ static int stm32_fmc_of_to_plat(struct udevice *dev)
 			return -EINVAL;
 		}
 
-
 		params->bank_params[bank].sdram_timing =
 			(struct stm32_sdram_timing *)
 			 ofnode_read_u8_array_ptr(bank_node,
@@ -346,7 +345,6 @@ static int stm32_fmc_of_to_plat(struct udevice *dev)
 			return -EINVAL;
 		}
 
-
 		bank_params->sdram_ref_count = ofnode_read_u32_default(bank_node,
 						"st,sdram-refcount", 8196);
 		bank++;
diff --git a/drivers/ram/stm32mp1/stm32mp1_ddr.c b/drivers/ram/stm32mp1/stm32mp1_ddr.c
index d7834b32299..0e37ea93fbc 100644
--- a/drivers/ram/stm32mp1/stm32mp1_ddr.c
+++ b/drivers/ram/stm32mp1/stm32mp1_ddr.c
@@ -707,7 +707,6 @@ void stm32mp1_ddr_init(struct ddr_info *priv,
 		break;
 	}
 
-
 	if (config->c_reg.mstr & DDRCTRL_MSTR_DDR3)
 		ret = board_ddr_power_init(STM32MP_DDR3);
 	else if (config->c_reg.mstr & DDRCTRL_MSTR_LPDDR2) {
-- 
2.43.0

