Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686ADC98314
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DC8181D4F;
	Thu, 24 Sep 2026 12:37:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y99lgRKiDVio; Thu, 24 Sep 2026 12:37:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A19208195D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253422;
	b=TtJASnFEbC09YlJZZwnp+oFw+6A89z2OXweojgbdJ2Vyc8B9utmRUgGALS+O6hXnf0pw
	 RO5fQ6/v94wxAgOuSlwTYOp89CL98VEyjgrgW8ZK+AhW1FKqvXgk3kM5zlWTlgZyn5n8C
	 DSi/qDG0ZXi6doH+mEiyXo/cgy+n0h/g4dr+O7L51TjveX4NJwQm33iadYTBuxTJY3QDN
	 Ie/H/9a3mLK8KelISv+h0LNH/uA4XAE6hKTq9Asue8KquLYCWi1eXqT5M8F5o4bPHUJY3
	 e+aJlYvXFDgzIM2IDb7ETpXwKXj1T97qjWCs9cG4ThCq/0ZiVjxfmd6oItDan/+c+2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253422;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IoFGC26Qdbmw9dbgTneRJefLt10IVg/3DDwJwfH8Ua0=;
	b=AmwiB2KbIaIMhU8f+WH1VlIKcqDnOBWc7NBH57EeZOH4neI6KGhNOGAUeyU1f5GmU9eG
	 hRWeKuvK4qUcJ5L7fxFeLdFqZxpSDgZ0ewk00xcY3lJB35L8jYb2GB0ZmbzkBfTQ4XXdb
	 /DDIptn4w/6ARkV3OnSbYrtAFu1A2d0ljBHWfVxPlINwzGyH0IaM8+hY5klZSnT+azOkp
	 1kRwi72pcv75fAgIFcvLaRmEJcQ20lMD6jhrQNZIsPBBwKVVM3bMWlGtRUA2Rcjxq/Gkh
	 tJ3nATiPpvqA4PBYFr8v7RAUgIdEictwMM3WJbKs5+RIuAmtcQDivErrIclA3deNq/g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253422;
	bh=IoFGC26Qdbmw9dbgTneRJefLt10IVg/3DDwJwfH8Ua0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e6DsittZlQSA9Lfi/Z5gsENlp3TtnrJdUMV+JSzwDJ6IhDmhPhF7MB34/gwkIByvv
	 gO4/7kUlhyGXO5Q5bo5zuJRAaXRYqclKF3+idSVOFUTrpadhZJ9ce7Dybfr8WjZ3uT
	 Ih5Lq8nDdivw4UOzVyzf3prUxIEIpmy4rHtvumxlJyCoKW1AI0Z4n2ecluQZ7Ksm7k
	 DmEk+dQzfAjVfNQpu7De/Y6jV9NxcZA2UevvSqi4Q3gHiy8sbsEVU8MDmHU2WKQyJa
	 806luv7/Bi3pu8b66io71Tl3/DPFR8m6B8F6mo6Q7C4QEbsj/PIH0D1eONOOCpmaVk
	 vBCVjYGK2JpQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A19208195D;
	Thu, 24 Sep 2026 12:37:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 557AB35A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B5D740456
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ErowiNygKEzz for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:36:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 75D48400FB
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253419;
 b=BsZRuUKlrEHqKyJSvYV/xJXVM0dxGWgIj9QwzOZbURikDExUr9aa/D63/uVTENHDb5cO
 9yVasp6lsH5O/UqaAjDqiV7I3Qe7ikrGZjxhqVatuVaeLD5Cpg71Mnycr/6u2Q98pd9oU
 VkijUeB7Nv5x8QSxhtHI0Vw1oG2HBN2fGLozkktwFIRzPkG8FJAttXAB3u9nCC32T3eb8
 GC/N093O/1rxABquGnwwIjDXPo9DdwWSzPEVvCpuuxIdexA9tAhvWysXtaD9weXMrubHS
 6JF0hC8V4kB+zfjWYJWQusp6gHEOFPck/kTnwK6seEdbYODPkCxkkYCAmn4mT4F0J3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253419;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=IoFGC26Qdbmw9dbgTneRJefLt10IVg/3DDwJwfH8Ua0=;
 b=LoaNyaajGOsDZVr5w9ps9P4tS3YW7jK4NBavWOOfisOapi+qop+kYH/hxkhRhL0gwnuK
 TKYmRGbvVf7EYEUo4yuQsq3rxMOm+hnz+9rrcQ3yIAhrK9kyBwsmeHtIQk1BnqDsn1WoG
 Dkg05p06r4WeOsmdGwA6elBGfjmznUEbRYdHBVX/v4857oa7IFY3EN54t8raTsyXjyV8/
 034CsR9tF+Ej5l+eDeBJqNtI3Z4H1o9vwF4zXvNxsO2S/p650HxmdlWKczo/i2QLI0Glr
 BFNTLr1Op7ornUMsZEI+va83D6xwcJO0jc5RXImLUcW1UdXrRPRZ9X3du+ZdEOonIpg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=O5cLh3QX; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=O5cLh3QX
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 75D48400FB
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:58 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C83704E41059;
 Thu, 24 Sep 2026 12:36:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9C93F60341;
 Thu, 24 Sep 2026 12:36:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3673A103284AD; 
 Thu, 24 Sep 2026 14:36:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253415; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=IoFGC26Qdbmw9dbgTneRJefLt10IVg/3DDwJwfH8Ua0=;
 b=O5cLh3QXtATCguoHEyPjNzSMbupgzbSyRbeEn2UEHdQ/6kip9VEgCN7H7PtobDNtfSp7YH
 dm9QbrhJ6nYanEPbFDoqK/gnoqZvmHfDJkXaTfRKDjErHsEFUzPQvVPUrOim7Gk5zp4lJT
 XFfh15ZKFQZlLgWJrbEtp4TbXTktq9RmrJdHoNvwEQZq3Ja+ZgRm8VWuCWymSv6tC+UAUN
 OKfB04hkG4qtWfEzgsa6fopkOMv3FFXDosLKYlpTgeOYPb3nNn13j2TfaCDKls9LY0DyBj
 N6TP8OACtp2f2tMDnjLOHMgmYL4EG6xY3Gxr2o84sWhzxaxOtvnTV6NTjrDpFQ==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 12/22] ram: k3-ddrss: Add exit retention support
Date: Thu, 24 Sep 2026 14:35:23 +0200
Message-ID: <20260924123533.2599438-13-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>

Add functions that implements retention exit sequence of DDR.

Typical DDR resume sequence is:
- exit DDR from retention
- de-assert the DDR_RET pin
- restore DDR max frequency
- exit DDR from low power

We have to separate each action in order to de-assert the DDR_RET pins
at the right time, because the DDR_RET pins are all tied together
in hardware.
Additional interleaving to be taken care and configuring of PMIC differs
device to device depending on number of PMIC.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/include/mach/k3-ddr.h |  16 ++
 drivers/ram/k3-ddrss/k3-ddrss.c        | 253 +++++++++++++++++++++++++
 drivers/ram/k3-ddrss/lpddr4_k3_reg.h   |  94 +++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 drivers/ram/k3-ddrss/lpddr4_k3_reg.h

diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/include/mach/k3-ddr.h
index 6ac7f682fb80..5dd4025bdbb7 100644
--- a/arch/arm/mach-k3/include/mach/k3-ddr.h
+++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
@@ -7,6 +7,7 @@
 #define _K3_DDR_H_
 
 #include <spl.h>
+#include <compiler.h>
 
 /* We need 4 extra entries for:
  * 1. SoC peripherals
@@ -17,10 +18,25 @@
 #define K3_MEM_MAP_LEN			((CONFIG_NR_DRAM_BANKS) + 4)
 #define K3_MEM_MAP_FIRST_BANK_IDX	3
 
+struct k3_ddrss_regs {
+	u32 ctl_141;
+	u32 phy_1305;
+	u32 ctl_88;
+	u32 pi_134;
+	u32 pi_7;
+	u32 ctl_20;
+	u32 wdqlvl_f1;
+	u32 wdqlvl_f2;
+};
+
 int dram_init(void);
 int dram_init_banksize(void);
 
 void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image);
 void fixup_memory_node(struct spl_image_info *spl_image);
 
+/* LPDDR4 power management functions */
+void k3_ddrss_lpddr4_exit_retention(struct udevice *dev, struct k3_ddrss_regs *regs);
+void k3_ddrss_lpddr4_change_freq(struct udevice *dev);
+void k3_ddrss_lpddr4_exit_low_power(struct udevice *dev, struct k3_ddrss_regs *regs);
 #endif /* _K3_DDR_H_ */
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 54e191df8de9..d8ec8356b286 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -19,12 +19,14 @@
 #include <power-domain.h>
 #include <wait_bit.h>
 #include <power/regulator.h>
+#include <mach/k3-ddr.h>
 
 #include "k3-ddrss-lpm.h"
 #include "lpddr4_obj_if.h"
 #include "lpddr4_if.h"
 #include "lpddr4_structs_if.h"
 #include "lpddr4_ctl_regs.h"
+#include "lpddr4_k3_reg.h"
 
 #define SRAM_MAX 512
 
@@ -441,6 +443,257 @@ static int k3_ddrss_ofdata_to_priv(struct udevice *dev)
 	return ret;
 }
 
+#if defined(CONFIG_K3_J721E_DDRSS)
+
+void k3_ddrss_lpddr4_exit_retention(struct udevice *dev,
+				    struct k3_ddrss_regs *regs)
+{
+	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
+	u32 regval;
+	unsigned int pll_ctrl;
+	unsigned int val;
+
+	/*
+	 * Saving registers
+	 */
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_141, &regs->ctl_141);
+	lpddr4_k3_readreg_phy(ddrss, DENALI_PHY_1305, &regs->phy_1305);
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_88, &regs->ctl_88);
+	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_134, &regs->pi_134);
+	/* PI_139 cannot be restored */
+	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_7, &regs->pi_7);
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_20, &regs->ctl_20);
+
+	/* disable auto entry / exit */
+	lpddr4_k3_clr_ctl(ddrss, DENALI_CTL_141, (0xF << 24) | (0xF << 16));
+
+	/* Configure DFI Interface, DDR retention exit occurs through PHY */
+	lpddr4_k3_readreg_phy(ddrss, LPDDR4__PHY_SET_DFI_INPUT_0__REG, &regval);
+	regval &= ~0xF0F; /* Set DFI_Input_1 = 0 */
+	regval |= 0x01;   /* Set DFI Input_0 = 1 */
+	lpddr4_k3_writereg_phy(ddrss, LPDDR4__PHY_SET_DFI_INPUT_0__REG, regval);
+
+	/* PWRUP_SREFRESH_EXIT = 1 */
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__PWRUP_SREFRESH_EXIT__REG, 0x1);
+
+	/* PI_PWRUP_SREFRESH_EXIT = 0 */
+	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_PWRUP_SREFRESH_EXIT__REG, 0x1 << 16);
+
+	/* PI_DRAM_INIT_EN = 0 */
+	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_DRAM_INIT_EN__REG, 0x1 << 8);
+
+	/* PI_DFI_PHYMSTR_STATE_SEL_R = 1  (force memory into self-refresh) */
+	lpddr4_k3_set_pi(ddrss, LPDDR4__PI_DFI_PHYMSTR_STATE_SEL_R__REG, (1 << 24));
+
+	/*  PHY_INDEP_INIT_MODE = 0 */
+	lpddr4_k3_clr_ctl(ddrss, LPDDR4__PHY_INDEP_INIT_MODE__REG, (0x1 << 16));
+
+	/* PHY_INDEP_TRAIN_MODE = 1 */
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__PHY_INDEP_TRAIN_MODE__REG, 0x1);
+
+	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F1__REG, &regs->wdqlvl_f1);
+	regs->wdqlvl_f1 &= LPDDR4__DENALI_PI_214__PI_WDQLVL_EN_F1_MASK;
+
+	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F2__REG, &regs->wdqlvl_f2);
+	regs->wdqlvl_f2 &= LPDDR4__DENALI_PI_217__PI_WDQLVL_EN_F2_MASK;
+
+	/* clear periodic WDQLVL for F0 */
+	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F0__REG,
+			 0x2 << LPDDR4__DENALI_PI_212__PI_WDQLVL_EN_F0_SHIFT);
+
+	/* clear periodic WDQLVL for F1 */
+	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F1__REG,
+			 0x2 << LPDDR4__DENALI_PI_214__PI_WDQLVL_EN_F1_SHIFT);
+
+	/* clear periodic WDQLVL for F2 */
+	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F2__REG,
+			 0x2 << LPDDR4__DENALI_PI_217__PI_WDQLVL_EN_F2_SHIFT);
+
+#define PLL_CTRL_OFF 0x20
+#define PLL_CFG 0x00680000
+	switch (ddrss->instance) {
+	case 0:
+		pll_ctrl = PLL_CFG + 12 * 0x1000 + PLL_CTRL_OFF;
+		break;
+	case 1:
+		pll_ctrl = PLL_CFG + 26 * 0x1000 + PLL_CTRL_OFF;
+		break;
+	case 2:
+		pll_ctrl = PLL_CFG + 27 * 0x1000 + PLL_CTRL_OFF;
+		break;
+	case 3:
+		pll_ctrl = PLL_CFG + 28 * 0x1000 + PLL_CTRL_OFF;
+		break;
+	}
+
+	*(unsigned int *)pll_ctrl |= 0x80000000;
+	val = *(unsigned int *)pll_ctrl;
+	if ((val & 0x80000000) != 0x80000000)
+		val = *(unsigned int *)pll_ctrl;
+}
+
+void k3_ddrss_lpddr4_change_freq(struct udevice *dev)
+{
+	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
+	u32 regval;
+	unsigned long tmo;
+
+	/* PI_START=1 */
+	lpddr4_k3_set_pi(ddrss, LPDDR4__PI_START__REG, 0x01);
+	/* START=1 */
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__START__REG, 0x01);
+
+	k3_lpddr4_freq_update(ddrss);
+
+	tmo = timer_get_us() + 100000;
+	do {
+		lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_INT_STATUS__REG, &regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & (1 << 0)) == 0x00);
+
+	tmo = timer_get_us() + 4000;
+	do {
+		lpddr4_k3_readreg_ctl(ddrss, LPDDR4__INT_STATUS_0__REG, &regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & (1 << 9)) == 0x00);
+
+	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_INT_STATUS__REG, &regval);
+	debug("%s: PI interrupt status: 0x%08x\n", __func__, regval);
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__INT_STATUS_0__REG, &regval);
+	debug("%s: Controller interrupt status: 0x%08x\n", __func__, regval);
+
+	debug("%s: Successfully exited Retention\n", __func__);
+}
+
+void k3_ddrss_lpddr4_exit_low_power(struct udevice *dev,
+				    struct k3_ddrss_regs *regs)
+{
+	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
+	u32 regval, fspop, fspwr;
+	unsigned long tmo;
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+
+	/* make sure that LP flag is clear before going through this process */
+	lpddr4_k3_writereg_ctl(ddrss, LPDDR4__INT_ACK_0__REG, (0x1 << 10));
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__CKSRX_F1__REG, &regval);
+	regval &= ~(0x7F << 24);
+	regval |= (0x2 << 24); /* set low power mode exit */
+	lpddr4_k3_writereg_ctl(ddrss, LPDDR4__CKSRX_F1__REG, regval);
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+
+	/* wait until low power operation has been completed */
+	tmo = timer_get_us() + 4000;
+	do {
+		lpddr4_k3_readreg_ctl(ddrss, LPDDR4__INT_STATUS_0__REG, &regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & (0x1 << 10)) == 0);
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+
+	lpddr4_k3_writereg_ctl(ddrss, LPDDR4__INT_ACK_0__REG, (0x1 << 10));
+
+	/*
+	 * bit 6 / 14 -- lp_state valid
+	 * bits 13:8 / 5:0 0x0F SRPD Long with Mem and Controller Clk Gating
+	 */
+	tmo = timer_get_us() + 4000;
+	do {
+		lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & 0x4F4F) != 0x4040);
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+
+	/*
+	 * MR13 data within the PI is based upon CS but NOT based upon
+	 * frequency set point.
+	 * MR13 is the current MR13 value
+	 */
+	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_MR13_DATA_0__REG, &regval);
+	fspop = (regval & ((u32)1 << 31)) >> 31;
+	fspwr = (regval & ((u32)1 << 30)) >> 30;
+
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__FSP_OP_CURRENT__REG,
+			  fspop << LPDDR4__DENALI_CTL_192__FSP_OP_CURRENT_SHIFT);
+
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__FSP_WR_CURRENT__REG,
+			  fspwr << LPDDR4__DENALI_CTL_192__FSP_WR_CURRENT_SHIFT);
+
+	/* do not allow CTL to update MR */
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__FSP_PHY_UPDATE_MRW__REG,
+			  1 << LPDDR4__DENALI_CTL_191__FSP_PHY_UPDATE_MRW_SHIFT);
+
+	/* do not allow PI to update MR */
+	lpddr4_k3_clr_pi(ddrss, DENALI_PI_64, 1 << 0);
+
+	/* PI_FREQ_MAP defines supported working frequencies */
+	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_FREQ_MAP__REG, &regval);
+	if (regval & (0x1 << 1)) {
+		/* define FSP0 and FSP1 as trained */
+		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F0__REG,
+				  LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F0_MASK);
+		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F1__REG,
+				  LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F1_MASK);
+	}
+	if (regval & (0x1 << 2)) {
+		/* define FSP0 and FSP2 as trained */
+		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F0__REG,
+				  LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F0_MASK);
+		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F2__REG,
+				  LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F2_MASK);
+	}
+
+	/*
+	 * Restore registers
+	 */
+	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_141, regs->ctl_141);
+	lpddr4_k3_writereg_phy(ddrss, DENALI_PHY_1305, regs->phy_1305);
+	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_88, regs->ctl_88);
+	lpddr4_k3_writereg_pi(ddrss, DENALI_PI_134, regs->pi_134);
+	/* PI_139 cannot be restored */
+	lpddr4_k3_writereg_pi(ddrss, DENALI_PI_7, regs->pi_7);
+	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_20, regs->ctl_20);
+
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_141, &regs->ctl_141);
+	lpddr4_k3_readreg_phy(ddrss, DENALI_PHY_1305, &regs->phy_1305);
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_88, &regs->ctl_88);
+	/* PI_139 cannot be restored */
+	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_7, &regs->pi_7);
+
+	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_79, &regval);
+	lpddr4_k3_writereg_pi(ddrss, DENALI_PI_80, regval);
+
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_293, &regval);
+	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_295, regval);
+
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_294, &regval);
+	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_296, regval);
+
+	lpddr4_k3_set_pi(ddrss, DENALI_PI_214, regs->wdqlvl_f1);
+	lpddr4_k3_set_pi(ddrss, DENALI_PI_217, regs->wdqlvl_f2);
+}
+#endif /* CONFIG_K3_J721E_DDRSS */
+
 void k3_lpddr4_probe(struct k3_ddrss_desc *ddrss)
 {
 	u32 status = 0U;
diff --git a/drivers/ram/k3-ddrss/lpddr4_k3_reg.h b/drivers/ram/k3-ddrss/lpddr4_k3_reg.h
new file mode 100644
index 000000000000..aca56200a96b
--- /dev/null
+++ b/drivers/ram/k3-ddrss/lpddr4_k3_reg.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef LPDDR4_K3_REG
+#define LPDDR4_K3_REG
+
+#define _lpddr4_k3_readreg(_shift, _fnct, _ddrss, _reg, _p) do {	\
+	u16 offset = 0U;						\
+	u32 result = 0U;						\
+	TH_OFFSET_FROM_REG(_reg, _shift, offset);			\
+	result = (_fnct)(&(_ddrss)->pd, _p, (u16 *)(&offset), 1);	\
+	if (result > 0U) {						\
+		printf("%s: Failed to read %s\n", __func__, xstr(_reg));\
+		hang();							\
+	}								\
+} while (0)
+
+#define _lpddr4_k3_writereg(_shift, _fnct, _ddrss, _reg, _val)  do {	\
+	u16 offset = 0U;						\
+	u32 result = 0U;						\
+	u32 writeval = _val;						\
+	TH_OFFSET_FROM_REG(_reg, _shift, offset);			\
+	result = (_fnct)(&(_ddrss)->pd,	&writeval, (u16 *)(&offset), 1);\
+	if (result > 0U) {						\
+		printf("%s: Failed to write %s\n", __func__, xstr(_reg));\
+		hang();							\
+	}								\
+} while (0)
+
+#define lpddr4_k3_readreg_ctl(_ddrss, _reg, _pt)		\
+	_lpddr4_k3_readreg(CTL_SHIFT,				\
+			   (_ddrss)->driverdt->readctlconfig,	\
+			   _ddrss, _reg, _pt)
+
+#define lpddr4_k3_readreg_pi(_ddrss, _reg, _pt)				\
+	_lpddr4_k3_readreg(PI_SHIFT,					\
+			   (_ddrss)->driverdt->readphyindepconfig,	\
+			   _ddrss, _reg, _pt)
+
+#define lpddr4_k3_readreg_phy(_ddrss, _reg, _pt)		\
+	_lpddr4_k3_readreg(PHY_SHIFT,				\
+			   (_ddrss)->driverdt->readphyconfig,	\
+			   _ddrss, _reg, _pt)
+
+#define lpddr4_k3_writereg_ctl(_ddrss, _reg, _val)		\
+	_lpddr4_k3_writereg(CTL_SHIFT,				\
+			    (_ddrss)->driverdt->writectlconfig,	\
+			    _ddrss, _reg, _val)
+
+#define lpddr4_k3_writereg_pi(_ddrss, _reg, _val)			\
+	_lpddr4_k3_writereg(PI_SHIFT,					\
+			    (_ddrss)->driverdt->writephyindepconfig,	\
+			    _ddrss, _reg, _val)
+
+#define lpddr4_k3_writereg_phy(_ddrss, _reg, _val)		\
+	_lpddr4_k3_writereg(PHY_SHIFT,				\
+			    (_ddrss)->driverdt->writephyconfig,	\
+			    _ddrss, _reg, _val)
+
+#define _lpddr4_k3_set(_type, _ddrss, _reg, _mask) do {	\
+	u32 _val;					\
+	lpddr4_k3_readreg_##_type(_ddrss, _reg, &_val);	\
+	_val |= _mask;					\
+	lpddr4_k3_writereg_##_type(_ddrss, _reg, _val);	\
+} while (0)
+
+#define _lpddr4_k3_clr(_type, _ddrss, _reg, _mask) do {	\
+	u32 _val;					\
+	lpddr4_k3_readreg_##_type(_ddrss, _reg, &_val);	\
+	_val &= ~(_mask);				\
+	lpddr4_k3_writereg_##_type(_ddrss, _reg, _val);	\
+} while (0)
+
+#define lpddr4_k3_set_ctl(_ddrss, _reg, _mask)	\
+	_lpddr4_k3_set(ctl, _ddrss, _reg, _mask)
+
+#define lpddr4_k3_clr_ctl(_ddrss, _reg, _mask) \
+	_lpddr4_k3_clr(ctl, _ddrss, _reg, _mask)
+
+#define lpddr4_k3_set_pi(_ddrss, _reg, _mask) \
+	_lpddr4_k3_set(pi, _ddrss, _reg, _mask)
+
+#define lpddr4_k3_clr_pi(_ddrss, _reg, _mask) \
+	_lpddr4_k3_clr(pi, _ddrss, _reg, _mask)
+
+#define lpddr4_k3_set_phy(_ddrss, _reg, _mask) \
+	_lpddr4_k3_set(phy, _ddrss, _reg, _mask)
+
+#define lpddr4_k3_clr_phy(_ddrss, _reg, _mask) \
+	_lpddr4_k3_clr(phy, _ddrss, _reg, _mask)
+
+#endif  /* LPDDR4_K3_REG */
-- 
2.55.0

