Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDA7F0180E
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 08:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E1283F9D;
	Fri,  6 Mar 2026 09:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="RB8kyCiO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE20839A8; Fri,  6 Mar 2026 09:58:39 +0100 (CET)
Received: from mail-244120.protonmail.ch (mail-244120.protonmail.ch
 [109.224.244.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF1AB83F2D
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 09:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail; t=1772787517; x=1773046717;
 bh=1pY87M5pGYz852DIxnUXjO5fesmLfEZnre9AuTD3QyE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=RB8kyCiOX4g60Qx9kLXqpqZ/XljuTrK8d9CtFy+r2+fa1Evk6245iWTDBgm+JvPCD
 ZkWWdWK12Uwm9Kgmk/bm35xG2HQKN+3D9gs7tc1/hhC3baMiTDvCLdJA9tmsbSO5DC
 /UJdlgjK3kQT/GJHpTmDMgF0QABj1b8bw3DpaPWa+0T0bxllk3p109w9WwW70yPOR7
 swUNgIwJUJQnogW+AVF8TUlJNsS6GPl7UMdZ9RBYfd3i5RFsRIRv5nOEZUQA49BgHG
 PlySNWvUH70PTUPg3fBmF/RBM9pnMxoJxbo5si+zB3WuLWG7Hz/jhZD8xXHEuWv51w
 Dhc/DNOYaPxng==
Date: Fri, 06 Mar 2026 08:58:34 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: linux@analog.com, Philip Molloy <philip.molloy@analog.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] ddr: imx: Remove undefined declarations
Message-ID: <20260306085824.886254-3-philip@philipmolloy.com>
In-Reply-To: <20260306085824.886254-1-philip@philipmolloy.com>
References: <20260306085824.886254-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: 665a39a4bf44f88c7a2484f7526eac2acb4d88f6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

From: Philip Molloy <philip.molloy@analog.com>

Signed-off-by: Philip Molloy <philip.molloy@analog.com>
---

 arch/arm/include/asm/arch-imx8m/ddr.h | 1 -
 arch/arm/include/asm/arch-imx9/ddr.h  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx8m/ddr.h b/arch/arm/include/asm/a=
rch-imx8m/ddr.h
index 5092ccae188..bf2d1f6bc40 100644
--- a/arch/arm/include/asm/arch-imx8m/ddr.h
+++ b/arch/arm/include/asm/arch-imx8m/ddr.h
@@ -707,7 +707,6 @@ extern struct dram_timing_info dram_timing;
 void ddr_load_train_firmware(enum fw_type type);
 int ddr_init(struct dram_timing_info *timing_info);
 int ddr_cfg_phy(struct dram_timing_info *timing_info);
-void load_lpddr4_phy_pie(void);
 void ddrphy_trained_csr_save(struct dram_cfg_param *param, unsigned int nu=
m);
 void *dram_config_save(struct dram_timing_info *info, unsigned long base);
 void board_dram_ecc_scrub(void);
diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/ar=
ch-imx9/ddr.h
index a8e3f7354c7..f6ae3baf3b0 100644
--- a/arch/arm/include/asm/arch-imx9/ddr.h
+++ b/arch/arm/include/asm/arch-imx9/ddr.h
@@ -103,7 +103,6 @@ extern struct dram_timing_info dram_timing;
 void ddr_load_train_firmware(enum fw_type type);
 int ddr_init(struct dram_timing_info *timing_info);
 int ddr_cfg_phy(struct dram_timing_info *timing_info);
-void load_lpddr4_phy_pie(void);
 void ddrphy_trained_csr_save(struct dram_cfg_param *param, unsigned int nu=
m);
 void *dram_config_save(struct dram_timing_info *info, unsigned long base);
 void board_dram_ecc_scrub(void);
--=20
2.53.0


