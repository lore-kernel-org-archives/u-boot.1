Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C78C88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F26AD80EC8;
	Mon, 14 Sep 2026 14:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6MlCrzzT3Uxw; Mon, 14 Sep 2026 14:17:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1BAD980EA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395463;
	b=no3WJJeaL8a/3ftNsTPqIw7umyzjf6zF9fhn6O++kinTF44zSjChSURyaMtDruHkMyL1
	 7g2w+PX7A9SSFzybdV8rj4Gf+5RAtymv7M2X3bUjT5bUCHJ0K37KwCb97FhSPSqsYu5EF
	 Mh23SUpPbEN2yfJMufee7pfCtOx5FtL6x3QnvHNP7FAII4ZjS6r6ScjjMg6C8TdP8t5qM
	 pNQhy9ExPhO5nKoCNT8EqEiTvoKVUBjCU1BA+rX2ohVpwu5cNtXHKm2bt6qHRgDGZ6ow8
	 tJE0woVvMEFogFNERhm2mbaEMb1KcNxwQ5a0bNO9xp47HpPAwC3aISmtAXAY2s4c8ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395463;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6IdFlk80W68Om9bKdr5/1riIG/Fd3UzNTNeZ9XjovaE=;
	b=bG6LgR/Wfj+D7nX3wRgcdhwEYNt2iRKDcvo4KyluDxaMYkUxnxTHwkArLPXMkNQAR7LV
	 UgfVfH54pwpdHkWrBnYSrdF2pk3rXrTn4yt2lhuCLdohrxTCwvm+hKzGDQ4F1Yvfha2Hj
	 i1ki8VJgYkb3Rw6Ex7mZgk+2E3/cBROTSwcCy1eIsd/cXDuQxbDyOgiL6ElHrtirobcLB
	 Ut/xHlEYIIyBwIya6w3tGtJNm+nZMbVjLE4l+XqiRewVTBMKbFJYgBg+nbMH3F4rZMIFZ
	 y5jreB+CLdWAZkf6lk/QvSbQ0OzUwOtu1ZviNkBMH1MPbUB62eH5Sjlufl8dLg68Tpg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Maxg7weB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395463;
	bh=6IdFlk80W68Om9bKdr5/1riIG/Fd3UzNTNeZ9XjovaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YnbnWpWzqozixedS64KBYPiLJIMQegY/2h2bqng8qLD1j7O4+WZeXDnXUUnkjU183
	 2esunX+zxvqWzjK2bM1otj94VEYFlg/5wjDspAaftC7+xkf+Wj5kFi+9bx3o/zeVMI
	 adWC+30xIp/W6t62NSl6g2C35NmEV6ElbpfZ1ojsAWqZCaVqg88OPQPp62g/+hC7VF
	 cn9sp8l93B+PbjWf9DvPwq/9P+HzQ3mgAVd9TRD9T1O/PR8ovWANK8vB9sRa7ll7Xl
	 61kx+eSyTB8Q9Pi1ofldzLFVhvRnCwcEgu3Fv68lz8PO/pc6Tt5mCl3pe9Yjg5dsNK
	 COEXZLOq5GDSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BAD980EA6;
	Mon, 14 Sep 2026 14:17:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 14F53362
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06C8180D93
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a6ewIIuodfFK for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 39FB680DA1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=Zpa0ERg5bOsAzU6cuQLltQi4gs+kP7ULCRj1mW2dm695siCK4wo0f7PgO2i9g0QsKiUZ
 ofqpc87QGuvThp/BOO2dBeR1RgIGKEM5avmVYne9io9n1og9k2GGzGkjC7anN2MYaXA22
 3QrcrzT1qkadaGY5HK5A/EfKbZ8qeMyvu1lGvimWp7U79FBl5HZGsMgNklylWaMk3S2wc
 RGZsI/gKP+sQrobua+pdF5WMXGUXxLQ/msRKMWGZbcFceK4kFw7fhWoe15ASwPIfBLO2h
 8+9axs+f4gtg3kVvlIPCVOHjKj5ZI4/QEaKZCR2sbTqTWe9CfDRD11YFBXKjNfs6vkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=6IdFlk80W68Om9bKdr5/1riIG/Fd3UzNTNeZ9XjovaE=;
 b=f0vr/1OtPZ3pRbwYiGQNSQi3QlXHhoY/bXueZveUY9oDUc2GQI/Bu7uPmAKT54zIAYXn
 OrCuFJfIeLCh5Rm7HITwwsmMVPexE6+o4nE/vPhFuJ3wfnFw2cHWe/kqY1AvWGYSEu/bF
 csliuEW2JvUyD7coDh8v8pBQwtzw8HpclqclCQ2ICpo0lzfAm3sE/WalDpUQyD1aU0sB8
 q1HlFvGykIyffozG+fx7Sx4a/ah/c8w1tPX0anOAAhn21GDJKMGZhRMbMe5LSwGBAC1Ll
 9ayPOnnActUHn6P+G/afBzsQ8UsYLYQ2EvxBsPPMFlKeC+bhymBSy/kOGP9s5ZJUWEQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=Maxg7weB; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=Maxg7weB
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 39FB680DA1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C82341C2B;
 Mon, 14 Sep 2026 04:01:26 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1649C3F86F;
 Mon, 14 Sep 2026 04:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383690; bh=PVQhgQNKu3ossKQrQP56LdchsNYBLhZ3hc2TeyRK2Es=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Maxg7weBIdX23SiSdVamN7/brWiQJePPADSQEPU9saVTkTttlp1AEeZ77zWtsHhNq
 wtoNFNtu/5dN9+ylV+u+4S2dqps6qpz/tsqw4e0H3ojqZdWG+hiWn/AN46QS5tr45S
 M6EMYY5WFe0pXu+3RwmaoDPWoYfSLFTPaQ/dZjC4=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 02/22] arm-ffa: store boot-discovered runtime data
 separately
Date: Mon, 14 Sep 2026 12:00:46 +0100
Message-Id: <20260914110106.1974894-3-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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
2.34.1

