Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81634CC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5020C406FA;
	Wed, 14 Oct 2026 20:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a3D8Szrq1O57; Wed, 14 Oct 2026 20:03:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 360A9406CB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008201;
	b=N6RQCS8q3xgbNfoVd40uQUajKiqH7KTYzGxSETFcm1/jIku7FfUyA4YOv71QbpiOYqk7
	 e03VCI1c+NhOtzZIkAnNdk/jSIfjepMt/E6r/9SoMZVtNAMAzteMgqRXSZcTcHX/rhSoG
	 jqykKdHLYw2fmLg3oJkTJNpQOX6nLwwr+tQqlZ/prGTZPhf/RMWScLuRH2sXEwrefXPdP
	 K7t5pp0etZUQa6lVhnjgguFwUGJi7HRGOVlQqCuH3Ccm2H7ufK/Y/q3u236SgMcIV+XBs
	 KgIU6cvfwDKlVIuNvLUg+xFMNIsCAtm5qunEzdo614B/5G2G7j8pVrfhmbpH/YG5wZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008201;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Isghowl55yudAiPQtESe/5W0hmDDYf82g78DUA2DoQI=;
	b=gcGv+wIqkvKS/alUw7hTwsZGrnwQ0dcW/tpD9a4B4It0OhavIlnsCDBGIjBPEK/ev7jy
	 GdjZwQGf5SxiPcIXfVtjTCYpaXOtc5TOzIb/0vU8H2mfTHvbhHRxAsMJVriEOnMS0a8wX
	 Ta9BG6DFz1+L74Rp66RAZgehNrNlJjM7LU0uCjIduezPuRjj1uA117k2qtlb/YTVL7eLa
	 vmdIXUlkpHuKlAE4IhWO9hOcdV3pgy8nuLNXfEmwyrLZjl9I6bURZYFbdhzRzVUvs1lgz
	 NM1bVCxMCXnv44oI5jBxgglVrrqs1F0RJ0SG6Oi6Wbj1lZgTVeR9REqrNW9LaSbBcjg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008201;
	bh=Isghowl55yudAiPQtESe/5W0hmDDYf82g78DUA2DoQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pRBMUbI26/XoiE6mqO1u1Zxm0Dz2pgRm3OW0cZ7FBtMn9Z3gUQ40Ui/kX/akxGGVW
	 3eEJJesxOQ3Tcfrf8tDIM+sNSQ1mxT53Df8dKdgtJ9IJHstYIq3tknk7qVF2f6AIrO
	 X7+bWZLJODSMdlH2ZKlQRo15AsjH1DdCHY21wPwCeOna0UxLPQNbkeREWm+AoQQHGs
	 Y/HeODb4MbIzVq39YJmXsmFG05y3q0qqBw4UDax6w/JB3y1ohR7X1+Wuc3F/kFTD7B
	 5PVz4CuUoP33szoukEt6kBrT2Odi8NZS8nViY21PzoQMFN68nrlD/8p6TBoULdhUkj
	 Cu7Wl49a1rIiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 360A9406CB;
	Wed, 14 Oct 2026 20:03:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 457E52E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B8BD40191
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mA_Z9-mhgIme for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5AC5F4009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002195;
 b=EIw+J71BalCYSIRXSik5arhLm9G03DZYjhO/fWWdye3BQoX7pZ2WZZcVmP1W/b/7ewox
 S4lNLZkaA7FBvndtFxMi3HBmvJX37zgsd7Qn/a4noVMDL/6Fyi/jBq/3K0uVDvLbxVvOs
 9F8aGtD7E4wby6JnCCO1RnRyBd0DR0fZXysltdZKla5lafksSYI+ks3HQihby6OTmXyjt
 52L5zHsKrzjeg3Ejng9iJG5cmIyAkR8NFnJMoRvQg0fwkRxulPcGczHhxXVdX2g54+47R
 MzY03dH7MG5xq5KBnb3ezxFyUacmcKgE4NE/arhV1rRqSKKtlksASVOQ+m7/HgDJ/Wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002195;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Isghowl55yudAiPQtESe/5W0hmDDYf82g78DUA2DoQI=;
 b=FN8F3BexiRfHugiIS/C9siHNGptx01vnKF7IPo9Hp0tWx6XQakYAziyWby3YyxenbS8C
 9X/qwL4ZbgNKGNWNeZ0VS3ysUu1TMHCOSeb/7REeqsTJUc1B03z8ISTaVHuaoCVxVEt35
 nT6fq1LLs7fJCPPu/Wfdbb5RpKjuhe2apx9wxgr4zNijrZNOLfMK76/vWiBG8u6hXbN8g
 AGVvyDKQHA1mMehfdIz38mp/DcJuzrZg5LLN8qHPFBtk243YHgIap3lD/BNLOpXI2pguD
 8FvyDNgRA471RCl5ggv2zdRWGjuho3hwYVisgv/HX7SQUOxeLMB9Nn8uq3VKMgiSgTg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=O++1M6ay; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=O++1M6ay
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5AC5F4009D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02B55152B;
 Wed, 14 Oct 2026 11:23:11 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 001623F871;
 Wed, 14 Oct 2026 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002194; bh=z9sBYcJREkTpc1ldZP94NoTpVh4PcHfBbdtHjYaosEM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=O++1M6ayqyhqYDh2MAHVmkqBiyLhlUzX2Qn/TsCZAw+MGapQgagq2aEsxD6ykOFor
 1J4qL4vglPnt4pcyAgeOdSHNvmPFS9IKeB2b0mIw+KBFJzlnsVAqdGL6Y9kjueYPUz
 8BRQZ9s1FuA+a7GRiKjtdeaYI/I6XVMA4jzywRUY=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 02/22] arm-ffa: store boot-discovered runtime data
 separately
Date: Wed, 14 Oct 2026 19:22:42 +0100
Message-ID: <4f7b7ff8f7bf1252767589950f35d01d77133b07.1792001844.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792001844.git.harsimransingh.tungal@arm.com>
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 20:03:15 +0000
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

The FF-A runtime transport needs the framework version and U-Boot
endpoint ID after ExitBootServices(). Keep these fields in a dedicated
runtime sub-structure inside struct ffa_priv so they can be copied into
resident storage later.

Update existing users to access the values through uc_priv->rt. This
does not enable runtime behaviour yet.

Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 drivers/firmware/arm-ffa/arm-ffa-uclass.c | 12 ++++++------
 include/arm_ffa_priv.h                    | 22 +++++++++++++++++-----
 test/dm/ffa.c                             |  6 +++---
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
index 76a8775e911..eb159dbfade 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -204,7 +204,7 @@ int ffa_get_version_hdlr(struct udevice *dev)
 		if (dev) {
 			uc_priv = dev_get_uclass_priv(dev);
 			if (uc_priv)
-				uc_priv->fwk_version = res.a0;
+				uc_priv->rt.fwk_version = res.a0;
 		}
 
 		return 0;
@@ -238,8 +238,8 @@ static int ffa_get_endpoint_id(struct udevice *dev)
 			}, &res);
 
 	if (res.a0 == FFA_SMC_32(FFA_SUCCESS)) {
-		uc_priv->id = GET_SELF_ENDPOINT_ID((u32)res.a2);
-		log_debug("FF-A endpoint ID is %u\n", uc_priv->id);
+		uc_priv->rt.id = GET_SELF_ENDPOINT_ID((u32)res.a2);
+		log_debug("FF-A endpoint ID is %u\n", uc_priv->rt.id);
 
 		return 0;
 	}
@@ -461,7 +461,7 @@ int ffa_unmap_rxtx_buffers_hdlr(struct udevice *dev)
 
 	invoke_ffa_fn((ffa_value_t){
 			.a0 = FFA_SMC_32(FFA_RXTX_UNMAP),
-			.a1 = PREP_SELF_ENDPOINT_ID(uc_priv->id),
+			.a1 = PREP_SELF_ENDPOINT_ID(uc_priv->rt.id),
 			}, &res);
 
 	if (res.a0 == FFA_SMC_32(FFA_SUCCESS)) {
@@ -890,7 +890,7 @@ int ffa_msg_send_direct_req_hdlr(struct udevice *dev, u16 dst_part_id,
 
 	invoke_ffa_fn((ffa_value_t){
 			.a0 = req_mode,
-			.a1 = PREP_SELF_ENDPOINT_ID(uc_priv->id) |
+			.a1 = PREP_SELF_ENDPOINT_ID(uc_priv->rt.id) |
 				PREP_PART_ENDPOINT_ID(dst_part_id),
 			.a2 = 0,
 			.a3 = msg->data0,
diff --git a/include/arm_ffa_priv.h b/include/arm_ffa_priv.h
index d564c33c647..3c74c63dfa6 100644
--- a/include/arm_ffa_priv.h
+++ b/include/arm_ffa_priv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -200,11 +200,24 @@ struct ffa_partitions {
 };
 
 /**
- * struct ffa_priv - the driver private data structure
+ * struct ffa_priv_runtime - the driver's private runtime data structure
  *
  * @fwk_version:	FF-A framework version
- * @emul:	FF-A sandbox emulator
  * @id:	u-boot endpoint ID
+ *
+ * The device private runtime data structure containing all the
+ * data read from secure world.
+ */
+struct ffa_priv_runtime {
+	u32 fwk_version;
+	u16 id;
+};
+
+/**
+ * struct ffa_priv - the driver private data structure
+ *
+ * @rt:		Runtime data captured at boot time
+ * @emul:	FF-A sandbox emulator
  * @partitions:	The partitions descriptors structure
  * @pair:	The RX/TX buffers pair
  *
@@ -212,9 +225,8 @@ struct ffa_partitions {
  * data read from secure world.
  */
 struct ffa_priv {
-	u32 fwk_version;
+	struct ffa_priv_runtime rt;
 	struct udevice *emul;
-	u16 id;
 	struct ffa_partitions partitions;
 	struct ffa_rxtxpair pair;
 };
diff --git a/test/dm/ffa.c b/test/dm/ffa.c
index 593b7177fce..a0c95e62607 100644
--- a/test/dm/ffa.c
+++ b/test/dm/ffa.c
@@ -2,7 +2,7 @@
 /*
  * Functional tests for UCLASS_FFA  class
  *
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -26,14 +26,14 @@ static int check_fwk_version(struct ffa_priv *uc_priv, struct unit_test_state *u
 	func_data.data0 = &fwk_version;
 	func_data.data0_size = sizeof(fwk_version);
 	ut_assertok(sandbox_query_ffa_emul_state(FFA_VERSION, &func_data));
-	ut_asserteq(uc_priv->fwk_version, fwk_version);
+	ut_asserteq(uc_priv->rt.fwk_version, fwk_version);
 
 	return 0;
 }
 
 static int check_endpoint_id(struct ffa_priv *uc_priv, struct unit_test_state *uts)
 {
-	ut_asserteq(0, uc_priv->id);
+	ut_asserteq(0, uc_priv->rt.id);
 
 	return 0;
 }
-- 
2.43.0

