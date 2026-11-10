Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4224A606A7E7
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yvRgYYUN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FNMK69k1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E93E381469;
	Tue, 10 Nov 2026 13:06:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aheIrIIhP3R2; Tue, 10 Nov 2026 13:06:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E736A812E8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315976;
	b=Wsh1c+z28LfKHM5QDw++UCnc25Y/Su9Ww/XObKB4W2pMf9irT3LvFsMCnA0hO3xH+75J
	 60PU+OXb2ec337W19kr6Fx6J4LOK+sdQT15yqbqnUCCn7HyCIV+Pw4Pr4k6WazKse6yRb
	 eIX+AnTZTMimrsrIOU1l/Wh2mkZ4S4uwJkcZdsJa2nyLbtL4qFqbH3gjua6L+Pq9hc6em
	 uRlJYrMwp0FQISpEpTgOYWyS/nIKZ0c3GwsNvqZBgAbFQ9WPR7KW8rwvbhxtBEzm05RN7
	 Id94yx9go6kE/gW7Rphyi1FrzaBkV1Md62J2z0IeWh3zTJVIJRGvJq2M1bFcgEJSaFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315976;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Isghowl55yudAiPQtESe/5W0hmDDYf82g78DUA2DoQI=;
	b=W/JMKccwctmUOCwYh+wwhH7qiOKaVVd1db0/2s09xKnzFW7KhmJ8j9iiBo6DyAdEnst6
	 obc3ovrkxzyBmvHnYPZpVpoIC/xuExmKdv6on8yL5n2dTwqwn0eJ74owzM8ByY2AMMW95
	 QzvaCYsEN0MHcj3D+fxuwLonUG2NBEu/q+mIO5fNSaXpTgG9vUcB6N6P0XWg8aDu3s5MY
	 ttF0LGc3yngRMPAGIV+o5fNc6oZdv7mB4RtYjvl5+vQFR9XD3WXzAMvCw/b8d3DtjQCKi
	 i0DKuPXUmmUk+O+KLuv/17HLhy0Dlk17Bxe9XonxhjDN/vEpixiWSf1sErCLDLJUwaQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FNMK69k1;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315976;
	bh=Isghowl55yudAiPQtESe/5W0hmDDYf82g78DUA2DoQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yvRgYYUNXKjscCJa7954jgLjPt+/MDZMRELsYjdCA29JNroQopufgLzPJ+nlCqI2e
	 XelWFQrvvXXXVEYjPltgm2vEzXAOILvJrfm7DK4y3b6ePNuzrPGrlKMaWD8GP3gtAe
	 zUOlLpkXjKsmbpzVxn3yFr+1SZsZZOgOETp/5SPu5gI/asS1l0FiTjK9KBoslYKuvB
	 RV6PdFBh9RuVTX9gnruN64BtiNujlh0FnhZZmoYn08vpGvUFZR6+1J3bh3GUej5Z3x
	 pyCne/Uj1kSuWZVomkNwmnUZ/yYnKRJZF3qJHHvP2DOD7o9alE5SeWiJSmWZPUpwGR
	 vJ3fX9CcmH5wA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E736A812E8;
	Tue, 10 Nov 2026 13:06:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D7833F15
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA57681111
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6SSKhvR3zM2W for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A0B18122C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=FNMK69k1
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A0B18122C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C4781EDB;
 Tue, 10 Nov 2026 01:58:12 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E59113F632;
 Tue, 10 Nov 2026 01:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304695; bh=z9sBYcJREkTpc1ldZP94NoTpVh4PcHfBbdtHjYaosEM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FNMK69k1cyUMVC/gusDMxdIPxv+RFi+GJaGhwpjv1DWaEJ+McXVMqEPn4pTwToMpZ
 JMo/OLtxj9ifsURUULwriHIjlo3MggudiLx5HHeSaANay4I+dLPBy5adIiIJtAAGyI
 qUVuKo2879600ID+FwvPRlcWHmxh8LX3+aD0MolE=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 02/22] arm-ffa: store boot-discovered runtime data
 separately
Date: Tue, 10 Nov 2026 09:57:43 +0000
Message-ID: <33856ab79e87d921a86e829fc4d49bbe16c95eb0.1794221712.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794221712.git.harsimransingh.tungal@arm.com>
References: <cover.1794221712.git.harsimransingh.tungal@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

