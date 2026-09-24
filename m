Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1746BC9831C
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D59704082A;
	Thu, 24 Sep 2026 12:36:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gz0buoxEkCs6; Thu, 24 Sep 2026 12:36:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1134B40CAC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253418;
	b=sUxIoCIBKpH+mcVvElzxNJjQ3ERyR5my9AeMOrTA+Ksv3skr5S7Ps7/2q3QWZxMSkmcV
	 D2X5yWrZL7Fg8+bP3wp6ZXsM9IKVme4kIuXIMh3kJj5r/PszRbCNdVD5iE5dqP2aeiMNk
	 XYExBWOthXaOdrmG3R+7LA95Ju3jGWQ9M5vXk8m0vM4rajhhEj7D4yTwqpcu9DLUrHT2b
	 w5MWYimIub5CWZsQ3eYVdCnKL7Fi+TRe5Jy2BLVcdblovz7z7d6TGKE+t5MIYV0zpRZyZ
	 gwDIRhQfd7/SVAWYd/dH+mJNfJbawffAUVPAfqHugikKCRYojH5tCBLiIT5ySH8KXkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8+I95D8CMasXHOIOgXedGfUtlWqw+MLRXRio8ymHor8=;
	b=Wupp0/1M2fB1FSvG2BeRIY+VupONfB8JNCfkYfwPWcOReOoA90RjmJWdn8fdaeCadgsy
	 hTWJbrkUS6UbIB4tDfgFMBs4ZuVEyveeVXIKLQ8+vLKP1CT3HVU412BfXnKAsjafW/iao
	 0zvEPOXb4HpTDHHAqnl8bexBuDA6QDkdEWMEzz6NMGB9lIpnXZv/arBM/8B76oXRLpaEM
	 bayNUU+BkahicBduob8/sIzkM4L3zkWTSmOaqAtkDwH4SzqBR37egUb+ftK50KOA1RmZj
	 Y7J9IogURlS8ra3PLx6EKmV6L2WCzSZSbdAWezNqQDerRFRJba+B5AUO8AXtfo8po+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253418;
	bh=8+I95D8CMasXHOIOgXedGfUtlWqw+MLRXRio8ymHor8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VLgFu4ei4F42u4KWlcyOpk5FvZQigrs+GQWzXRGOKZSYtdVHom3S454ZK5iZKMMG8
	 2S0WP7ekPFHDf2quyZkoSYfI+uR1jPkB06O4nXz15igbVCLoTERJmgaf/ouos7xw1E
	 zYC3qFRXHRzPxD+gPTenQxemyfCWLncqb+CX4DKsXjEmBMJLDQ/cMBQEM10o36XH0w
	 nHNmTbHJeFKXChc7FqVWNDhIMT/VO1ZyGf9HkBnYKOseBrKaxjFZf5v5ot1k8Y64Dg
	 fjv+qk0qRSjjwW9wkC22PJ6hT3pf0VSkWpC+hsChYHOujyTT0Tuz8R3Bd20oIEyO3x
	 4dh5g8DV3a4zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1134B40CAC;
	Thu, 24 Sep 2026 12:36:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B51182F5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5FB140456
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SWwG-PDnisZm for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:36:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E4DCD400FB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253416;
 b=oAGylYqJmihbLoYsVFVIHGpQH5PF/pRRef+H/wQ7JEkCEaTmQatarBeKpHRHmS8Wnm3O
 LWV27vKYYMJrivq+//lNRmfs3BLC5s+nvp+jxvP0HaGkuoi2o3JlPMHBWhjEiUcxJYBab
 4UIuyzSVRzzpCbi5LXy2lh5Xrn95Bz2R1cOhHyeYOIVu8lP+xK4G7rghNIRuFOaDaMCFb
 YIoDwRTTs8/8kzeQePEQdr/OAVhM3zH29EB5XOPYM4amTl4vw2CszXzytAifSwHOZPxue
 QbqIsE0YNyvlEXbxjD3tH7gBW4gZjzSJJG107f0lgubdMRIsMnhMfGjBWo407Onp+Cw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253416;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=8+I95D8CMasXHOIOgXedGfUtlWqw+MLRXRio8ymHor8=;
 b=IeZgKKjVraxz9vEArU8Xq3WaPL+cHBJP9RmurDx6DeOIJunJ3Kni8PYgZp/npyWkTKpf
 WP1K4mGO1mGhplSx6qa2Z1/ZqwXLLn3Pw63Da+hMFNoNT8UJW/HbqE+/Qo8oo5Ol/Q/ih
 PzIEUb3w+ePS+Z1Lq9xNFDEdRQ/YF1xD1rxwPoScuV5XMG9hxGp7oK1On2cm4BQXz7AgB
 UkexBxyOBqXr8R9/oKXpf0xGvxxsYuagpOCIH6X5GaCCqDaytuH8e46gksJvxSCe5Wi6e
 jsdsiVMQ0oOkfIViDKuX7lityLLysB9RicC6io8RsgLIZYemoSHsmu+cvFaLkhyfogw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=nZR9LOAl; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=nZR9LOAl
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4DCD400FB
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 562D0C211C1;
 Thu, 24 Sep 2026 12:37:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D921360341;
 Thu, 24 Sep 2026 12:36:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2086B10329466; 
 Thu, 24 Sep 2026 14:36:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253412; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=8+I95D8CMasXHOIOgXedGfUtlWqw+MLRXRio8ymHor8=;
 b=nZR9LOAl/8CTCaklB3gKZd38+vralyoPkiSqAbcBgW832qx6sIBGdM/jMnoPwtp8r1vQ3Z
 v+LqSOqjEWxZf3mb47mraiPtEuVlDOzytfwEtVrNqtp7N39goIDGr5rHXK/+NDpeKiDVwA
 xvD2s4MRmLBMEIVu/VXBRVaVPzqeeYQbSWliYqQMb5/ZY5KUvAAAgMtfRYjZJgFgmXJkDB
 wWg0xcxfWYuketZCFwq1MXsuM9Ps+WVQDoVXA9x/cExRI/sEJOi4Zuo4TyAGp990YPGpVM
 ontuQvnFKOk35iRsC3Vlio0eOza4WSOzQk9eT2yNCNgV2qg/CVRLQyqfy3YX6g==
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
Subject: [PATCH v6 11/22] board: mach-k3: r5: common: Set PMIC NSLEEP triggers
 bits at resume
Date: Thu, 24 Sep 2026 14:35:22 +0200
Message-ID: <20260924123533.2599438-12-richard.genoud@bootlin.com>
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

If we are resuming NSLEEP triggers bits of PMIC-A and PMIC-B shall be set
to prevent transition to S2R state while clearing interrupts.
For example PMIC RTC Linux driver accesses to interrupt registers, in this
case if NSLEEP triggers bits are not set it triggers a S2R transition.

Suggested-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/r5/lpm-common.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index 6595f0caebcf..bf74507a4127 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -27,6 +27,9 @@
 /* PMIC register where the magic value resides */
 #define K3_LPM_SCRATCH_PAD_REG_3 0xcb
 
+/* PMIC NSLEEP register */
+#define K3_LPM_NSLEEP_TRIGGER_REG 0x86
+
 /* Wake-up source IDs */
 #define K3_LPM_WAKE_SOURCE_MAIN_IO 0x80
 #define K3_LPM_WAKE_SOURCE_MCU_IO 0x81
@@ -92,7 +95,7 @@ bool j7xx_board_is_resuming(void)
 {
 	static enum k3_resume_state k3_resuming;
 	struct lpm_scratch_space *lpm_scratch;
-	struct udevice *pmic;
+	struct udevice *pmic, *pmic_b;
 	u32 pmctrl_val = 0;
 	int ret, magic;
 
@@ -142,6 +145,25 @@ bool j7xx_board_is_resuming(void)
 
 		if (ret)
 			printf("Failed to clean magic value for suspend detection in PMIC\n");
+
+		/*
+		 * Ensure that NSLEEP triggers bits are set to prevent a
+		 * suspend/resume transition when accessing PMIC interrupt
+		 * registers.
+		 */
+
+		/* Some boards may have more than one pmic */
+		ret = uclass_get_device_by_name(UCLASS_PMIC, "pmic@4c", &pmic_b);
+		if (ret == 0) {
+			ret = pmic_reg_write(pmic_b, K3_LPM_NSLEEP_TRIGGER_REG, 0x03);
+			if (ret)
+				printf("Failed to set NSLEEP triggers bits on PMIC-B\n");
+		}
+
+		ret = pmic_reg_write(pmic, K3_LPM_NSLEEP_TRIGGER_REG, 0x3);
+		if (ret)
+			printf("Failed to set PMIC NSLEEP triggers. Spurious suspend/resume may happen.\n");
+
 		/*
 		 * For robustness, the DM should also clean the magic value at
 		 * startup.
-- 
2.55.0

