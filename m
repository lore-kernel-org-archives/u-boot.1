Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91840606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zL5XsCdd;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ci7fYE7C
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A14481288;
	Wed, 18 Nov 2026 13:18:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qbJhQurxmsnH; Wed, 18 Nov 2026 13:18:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF8BF81275
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007938;
	b=fznq0miLfpj2W6GtNoCElmgGapoHZpdK6t1XJW1IwHGmsM13aXnprrhdPhFk57/ZWUeu
	 dOji3COGMWqur5+WzpOmXRhKnS9WhzG5hHR5G37V3bYc24+KR4dBX2TxVmFrmHrTau2vR
	 6WBskZmrrfpzc2GHFCZKTKXd3POJhW00+9B8VIkcGCx1ZeLuUqelqqfmxuMuewFX1njgk
	 PC9qBhgr2PstJxx+5r9ZDFqaSQMHgr1G0GYKn1efNSO6Crt7sfm9lbcRuphKRlfYJh+XJ
	 i2hWlil/42dzXwXY0nEApI21NWlTzg4pyUhDepw1Uwva6SFi/Ecivi3xyIYE/ypwcTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007938;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5u2dKWbNzyJeh1qIdPTyA4qLvO0SrHKzPrWMU45Jk54=;
	b=MfV0fBg/05xWV+UMvcaewvsYJnz7ZaTR/+2bj167ySDujXx+5JZlMdpxXn+e/VoNFOo6
	 fkdb23ceeFaTL2BpTC0r/DdUUxCIX/4WLOq3x4VMex2Bk3uSTd48sOMbpthDtoy/x+UWc
	 mGJtLuIu8djvTuC8Qf4w0269ByMtfBa6bDTMvMF0SroIEfDIofn3cf1Tilya2S6AKP/3B
	 oNMhWGpF3f0Kt7/H0v7d2T6KastVFIqruDakGF+2RP8eefC5o0AE1ACD7Mvde55eQ1V5n
	 3EaZ0mKM8vqwlfLj/EEv7VW/4cK/qTbMnoEV8/Kci3uabd7SoHDcdITxAe8q6nEN1rw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007938;
	bh=5u2dKWbNzyJeh1qIdPTyA4qLvO0SrHKzPrWMU45Jk54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zL5XsCddWd9cXiONwBKjNC2Uc7XKufFrVS8N9TTEsev0o/M0F0SeLmNGF4sNlXiyd
	 hqmRCjZi5lOtxmflYBVUE0pymoV99yL9zDQkfsP9+zX3M0f3gXoaknRF7w21HkCikq
	 Am7AMAxD5qEf/BJY1xAYxufvADIMCqcrP6/0iRGwySI21KD7pCjIeVkJnF3ReAa3RP
	 DyJ3sE2jBHREosTh1FPexf2qSj23fsWmcMMADqROrsHfr0oS2ahvd7EbY76QlEl6mS
	 y1zK4dD/L8by3P4pDEi4q0RbEKRcD2d20TR+lXQEdS4WPKGS/cm9Ap4kiDNCFA6XxG
	 Z+4obxvEYYxkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF8BF81275;
	Wed, 18 Nov 2026 13:18:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F150977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84DDC60A6B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rHQwz-oApSCU for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:18:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9BDBD60A51
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=Ci7fYE7C
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9BDBD60A51
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id E58C11A16D4;
 Wed, 18 Nov 2026 13:18:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AC6EC5FE9B;
 Wed, 18 Nov 2026 13:18:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 81B1011BC1443; Wed, 18 Nov 2026 14:18:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007932; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=5u2dKWbNzyJeh1qIdPTyA4qLvO0SrHKzPrWMU45Jk54=;
 b=Ci7fYE7CuvgqdEby6Gnu7vdKLbJe8HaX88FVFfM5eOfgp2zY1XErlKPdkn3uV2dupqHoiJ
 mDjTzR4NVHPrTrH0ZVWy/g5Fiy5l/EYGGCdGcnSwDiYJtV2PIM744eJusUFWN3CoOaSFIp
 yVXcRSV6cbCGJjRmYFsJXG6tiAvCg//4nIwcOvQ16vgc/CC95yZtpOR9MK+GDJnYZesP6k
 4eI7U3Mr+vv+SI/MrnvLZVEyFaTg8uxaLZ28EW521CvR70EQwp0DXq63rKl4f+BzZpYVtp
 z1SDASfHtfHWXP0llWmSVg4pHisu16w8KuGI6QQ4f9jrVcHdBGhK0nK9t/pVgA==
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
Subject: [PATCH v7 09/20] board: mach-k3: r5: common: Set PMIC NSLEEP triggers
 bits at resume
Date: Wed, 18 Nov 2026 14:17:56 +0100
Message-ID: <20261118131807.135859-10-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
