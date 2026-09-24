Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6B5C98314
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D413F81BC6;
	Thu, 24 Sep 2026 12:36:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OXFXDA8_R18q; Thu, 24 Sep 2026 12:36:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0AD2C81105
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253389;
	b=UefKxtoxWFspL2RW2lDQW392jp1kGVGYOUTv9sBgJVSl5k21bPJ6DSKn7i7E8JcB5fjW
	 P9nTMJcZGGcFd+vMv5NeQGUK9TdKfxHghz/UgZHnDFKgjjb23nJgxWjV6MGmcPwyOkvMi
	 O20kUu8zwY6Lt4LtPAc2ce2BlWK/J1st9v0KFxpfFI4kHMdG4H/eSLcxwMM/qt9GHWN3B
	 GNjLdf5elPqrZ5iaLAcqCcZ3OAwn6rCpyYTaABM90gIyV9Dz2l91emVZHA+dakZcaUGIB
	 WPzIUaPX255VVDGvqsC6Gv63O3oyJj+mJYMgCQOa0LFFcSoNuKcneguJcmYotaCb3fQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253389;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rjFkHIY4455rPdCRuF7LBDEGFYG44YgzTaL+3neYCj4=;
	b=lDsQnUm/uuLKsYoHdJn/mszDA2D074VaDvHTRbNM6OyiRDKSTTvYSqyp4swD5LNMJN2I
	 FCooFSMrt1+NXWSilG/o+Es1Bi/TMW/Bw45KDYkJ6ohUv46eScHqY4C2qix182MO1nFht
	 V1PDgm1J3qFiBessQnjuSxxEd6M0z/U2FnvbPsIlE9FH0DiChD7lasbNB7YCbB3fBMtGo
	 I/PpmQYhKcwDloDt1e1C8Viq6g3dqhlhA2x757XWw8874yRs7dQzVxqkvFS3plrM/pnxt
	 MTqq1bMHIHfI5c/GycjyiD6AtvmtP6ygLRuIpx1nGv6sXpZaiL1N8yawYj9MjxjaATQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253389;
	bh=rjFkHIY4455rPdCRuF7LBDEGFYG44YgzTaL+3neYCj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yUjFuno4P4kAf15t6o0XKHAvH4KMJ/DtIRCzlad+Lqn0+MNbxABlPBJ+h4R59yD5C
	 BE+RGcODAgcZOpC1MHpi/KBahIt222bnBiBSCjG+OLVGKLej83r7BDvwQJrWf7Uzwz
	 VUCDOMKkM3m31MDNH1mpzvppcHrc9CjbOEPHl0VY8dsD2Zd7SPKGjVJabh9eHVuq5I
	 rD+LkfbucOex/3VaQ0uk27ut8hcHiGJeb4RXZ+Rgq0gMiboMMPex7xJhuY/Jy4XDXa
	 dsxDmOgRZpksrjY7G87td0HFsRg4N+Kb0O7R6ovLSBN+Cl1vJiowMeWO3Vs8ko3aj8
	 U70HC9pM5P1iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AD2C81105;
	Thu, 24 Sep 2026 12:36:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23015194
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 148F86081B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7lLM-KeNdGjw for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:36:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2ACA9607E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253386;
 b=fc7HcEIRh2C4M+z8gudBSekLVG7YXapvnB48yf9UsBEaGBoDMpO1OY9odNNr8zP6I3x2
 UUX/ytDiMp8EvkMyoEwFb7JkIumzPIo7wgiAEz7nVLS/YYByZ2pHVOTtDXS/WvHC6nh/P
 G0tAAZfzQivK+WzBsrgtDH5vTjm+ujQgKl3k4oWXHPuUKiQ0hkOF4+TvCKQFifa0WX/SO
 +WPucQlztCcfTtZxXA6Ybv11wYzq5AkNhcbFSaYeS2SMDt0ysb9lTBVnyeRrzrYfwwsOt
 Tg6MPCO/AGQvmj29mEbknw9RnFGshBGmVC2yUEgYXbFoD38PtEIDJuDDe1hbKsGJI6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253386;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=rjFkHIY4455rPdCRuF7LBDEGFYG44YgzTaL+3neYCj4=;
 b=NR6OFMPmZH87p6nNgVDGIKSaHdoo8cWsEjhTMNQIS81bFvvKPtI/DBsbMc5GaYXktemH
 px8pHGoRKY9mWZ9vCeWBeagVvq7tfXWbppVPHUL6lLF+tG6B/sfkSbQIH78KHDVQjbbt5
 KM1PklcO1qBRsf9GFCbBSS8ZCZZSQeJPKgzYf2ORy/+GPdpzZejkWlPP2egnSKvAc7GyQ
 3uAsn5ERA31e5aMhdY1bnU099+/Z1B+6/2uRtfGRaDk9IddUJQabpj9ZV4u/cNJcklssL
 Fvwd2U6BKxKXph03+brW+tSEFX0FMb1Izfa4LEhqPt5loQ+nxlKENYj/GlhEM/9remA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=x6BA3iYO; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=x6BA3iYO
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2ACA9607E4
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:26 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E1C98C211C1;
 Thu, 24 Sep 2026 12:37:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 768CD60341;
 Thu, 24 Sep 2026 12:36:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1310010329456; 
 Thu, 24 Sep 2026 14:36:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253381; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=rjFkHIY4455rPdCRuF7LBDEGFYG44YgzTaL+3neYCj4=;
 b=x6BA3iYOZPsW41e4ccpGjA6cdXroQWXpxBAlqrzRFamY9r6ViSdTZ7/IfTBkE2vLkEGT5Q
 sAPJIwnfpnXSg+cOt0P4AvZaSy8DitA0x+jWgoUI5uQiIVCCaOqTC8tNnRsRYF5INpdkEh
 /AsL1iD/c0hjANQ/Kw4iBKplQhbShzDbgzkVjDf7LgYWC1Rq9C3QJamS/azJlrn3lg7dMo
 1Jv9xfdTqmfvTq2wGekDCq72OGA1jknpc4pUOJYbvL0AAkv02bwnQ+Heni3KVm6JL0AJ+H
 ZAXX9ePMhM1Fp8R/hqNpho50TpG2ItgCzbbV9qn4HmokBO9SXLGcVZxPMpQmQw==
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
Subject: [PATCH v6 06/22] mach-k3: r5: common: introduce
 j7xx_board_is_resuming()
Date: Thu, 24 Sep 2026 14:35:17 +0200
Message-ID: <20260924123533.2599438-7-richard.genoud@bootlin.com>
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

Add the capability to detect a resume on J7200, J784s4, j722s, j721s2
SoCs.

To detect the resume, SPL searches a magic value (0xBA) in a register
of PMIC.
This value is set by DM-Firmware during the suspend sequence.

NB: Although this is called in board_init_f(), we can use global/static
variables because CONFIG_SPL_EARLY_BSS is selected.

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/common.c                |  6 +++
 arch/arm/mach-k3/include/mach/hardware.h |  1 +
 arch/arm/mach-k3/r5/lpm-common.c         | 53 +++++++++++++++++++++++-
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 6e382efdb3be..d934f732b330 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -713,3 +713,9 @@ int spl_start_uboot(void)
 	return 0;
 }
 #endif
+
+/* if r5/lpm-common.c is compiled, this will be overridden */
+__weak bool j7xx_board_is_resuming(void)
+{
+	return false;
+}
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 2c771a1195f5..c45bd3747163 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -137,6 +137,7 @@ u32 get_boot_device(void);
 const char *get_reset_reason(void);
 enum k3_device_type get_device_type(void);
 int k3_fit_config_match_security_state(const char *name);
+bool j7xx_board_is_resuming(void);
 
 #define writel_verify(val, addr) \
 do { \
diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index 91707fd19501..5d484f6df037 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -7,17 +7,25 @@
  */
 
 #include <clk.h>
+#include <dm/device.h>
 #include <dm/read.h>
 #include <elf.h>
 #include <linux/printk.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <power-domain.h>
+#include <power/pmic.h>
 #include <remoteproc.h>
 #include <mach/security.h>
 
 #include "../common.h"
 #include "../lpm-common.h"
 
+/* Magic value in PMIC register to indicate the suspend state (SOC_OFF) */
+#define K3_LPM_MAGIC_SUSPEND 0xba
+
+/* PMIC register where the magic value resides */
+#define K3_LPM_SCRATCH_PAD_REG_3 0xcb
+
 #define CONTEXT_SAVE_SZ	0x80000
 #define ATF_CERT_SZ	0x80000
 #define OPTEE_CERT_SZ	0x100000
@@ -32,9 +40,50 @@ struct lpm_addr_info {
 	u32 size;
 };
 
-__weak bool j7xx_board_is_resuming(void)
+enum k3_resume_state {
+	K3_RESUME_STATE_UNKNOWN = 0,
+	K3_RESUME_STATE_BOOTING,
+	K3_RESUME_STATE_RESUMING
+};
+
+bool j7xx_board_is_resuming(void)
 {
-	return false;
+	static enum k3_resume_state k3_resuming;
+	struct udevice *pmic;
+	int ret, magic;
+
+	if (k3_resuming != K3_RESUME_STATE_UNKNOWN)
+		goto end;
+
+	ret = uclass_get_device_by_name(UCLASS_PMIC,
+					"pmic@48", &pmic);
+	if (ret) {
+		printf("Getting PMIC init failed: %d\n", ret);
+		goto end;
+	}
+	debug("%s: PMIC is detected (%s)\n", __func__, pmic->name);
+
+	magic = pmic_reg_read(pmic, K3_LPM_SCRATCH_PAD_REG_3);
+
+	if (magic == K3_LPM_MAGIC_SUSPEND) {
+		debug("%s: board is resuming\n", __func__);
+		k3_resuming = K3_RESUME_STATE_RESUMING;
+
+		/* clean magic suspend */
+		ret = pmic_reg_write(pmic, K3_LPM_SCRATCH_PAD_REG_3, 0);
+
+		if (ret)
+			printf("Failed to clean magic value for suspend detection in PMIC\n");
+		/*
+		 * For robustness, the DM should also clean the magic value at
+		 * startup.
+		 */
+	} else {
+		debug("%s: board is booting (no resume detected)\n", __func__);
+		k3_resuming = K3_RESUME_STATE_BOOTING;
+	}
+end:
+	return k3_resuming == K3_RESUME_STATE_RESUMING;
 }
 
 static const char *lpm_core_compatible;
-- 
2.55.0

