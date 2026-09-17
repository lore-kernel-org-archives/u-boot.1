Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60B8C982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:19:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83E7560B70;
	Thu, 17 Sep 2026 17:19:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nz_33wBDGVKl; Thu, 17 Sep 2026 17:19:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7245660B9C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665578;
	b=Wl/2JevEouYH8bOZYO/cn0kaT268BXjDKj0wZS3KNf+TDzycqme857BMRzOwDE/N8dXt
	 gXq8H8wu5Iyo0t+7lR+853FZBKODjK5322JOqq12+K5QdK8UGw3wM2zK6aS3ITdm0TLPB
	 wpI7YN+IeJtXYBVCb6tSlk+oUZV7/j9ZAFI3gf/W875svA32lARxDWcZ6noe+NIAFpZUk
	 KwkNNdJ/GZ6AJt3MkUDJG0OJWPzI2Yv4P8WH9QkSQj0rD1fn/wDNywdW2LiPSXLJdAZWo
	 7gtm/Tkqf9/ZxXF9bZotD4LSS1odtDmMQdAeDNY77m7WgL408mBp+Y5EVDSJKKB6VJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665578;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qd71Qhd2IbC5wvfnYe25IBQCsnMc+RhuTTVIY4bTv5c=;
	b=eB8KRD3Z/7jPvFb0q93/zD+uit1qaLfNqtruRtqDaEx3bqcV+6+fz5+p20dhDXgYqbSi
	 fIIYq/W3e7Y143ZhoowowoPUykq5JrqmqWmV2086WEF15nQAdWP9sm4AgSdhQE2iukOgd
	 3txgIfpH06RoB76AkomWX37k1IUBde2WBjeZfOENi5wFFc70oqZ8sTxWUTc/mZKVBWoQv
	 cAYriQuTatjoyOwgzCRCu2U55+M/LD67mct3ZBz7bxtdoEWIXRuQq8VmkdAYRebiaEMsx
	 TUTISzg3prn8n1OS4omoItFz4ByzzKMVN0/jioRZt+OsOQjLQIPfnQG/tiJu+L33OUg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rKaBhf+z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665578;
	bh=qd71Qhd2IbC5wvfnYe25IBQCsnMc+RhuTTVIY4bTv5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KCNmVG9VVJ7Nyc1G1cO7synmUk1Dn1k+nUnTsN83+HT5Lof6H+3jLD1GHJfYjgroO
	 Mo8SIGSmchnJPLt3qlFEMuMA6NGvOBbs7ds5TpkChw1NStu5STARyOsJCUJkXEozn3
	 cpcgWG5+gCCyG2xh1robdMUx4Uf0eIMK/8DaV9hTzw11DLx75X5YEKMXM9iJeW6j2f
	 LD2NDaLuyJ5ugd26ZJ/QxOiq/sMbTUi/5qjNClwYICwl4JMxsrOxzzpRv7QnEd8TyD
	 uq9q2H0ViKFtLNlgsI9shX2DaQhCAcVGBJaANxgkqDBBJgE5mP5t8HHced6A7ThuPV
	 egZ/YL+WeArlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7245660B9C;
	Thu, 17 Sep 2026 17:19:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 820303AF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73D2160B64
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GeHIg49Quymf for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:18:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 63FBF60B2D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665527;
 b=OH97O4JN7Pg+6Vk49JQcvMw3K03CIpcQf1ZhzOLj5PSqX1OMqybqR4zXxd41tGU9h7NW
 i8lUnDEd0u+DT2hMmOWhddSqrU+8v3eEgwkI/BCSW8zqNqdaVSdZqsS+Bc+blCagiAq56
 9Epqg0spZILW4TIN6bVgjqj5tE3mVWl8p8UbUGvXIeAk2PQW6SPuOAtbevms9fR442sGa
 FUvgDLfxCQq01YVXvaNv/sOcyqZ2CLs6KHSu976s0VIlWkaACarSqNutOkqOUyCgWYrlA
 ST6xlqVZk8BZg3Vu/E+uJle7NYnekmQc2if9cOJUY3LaP0P92v6Ux1fUMJPpjgl9uAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665527;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=qd71Qhd2IbC5wvfnYe25IBQCsnMc+RhuTTVIY4bTv5c=;
 b=qzLYRQjok29eAEs0FdJS4kS89K8jmYik8PgeHw1sV6yxVuz2LfccsEY3VbMpqjClxVfg
 9w2hqjMRZTgFRcPpFMgiipR0ULNpp2v+mpbeuOTyCrR5Icw5dU3BTrpNC+/lQRms5Eywb
 TDLhyNabLXs4Mzkm6PZTWAcvj+YQ0OiuLXPR4y//5ov4r/vB9uA/pGecPZTz0UF36Jlna
 d+ZWJ5t3L+p/0JbpgwpGMCRn5rv8RvZO3XbO1SQFG2aTZKAeD3vlA2huVITurfzIkt3DI
 k2Vn+yzZzpS7TGTopXInIESLTqbfULWqueI9jyuT4Qti9/rKEdkv7FJ/ANEFB5Pyp0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=rKaBhf+z; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=rKaBhf+z
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63FBF60B2D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD41F1F02;
 Thu, 17 Sep 2026 10:18:39 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 546D33F7B4;
 Thu, 17 Sep 2026 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665523; bh=iIo5SF9xr3hnKVe6HMNzJwYpxcdfTj95iwPUWF9N6rk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rKaBhf+zbb3dJMHEbdvnm6sM8+7SbsztySb0/yjDTFC6NTFo77Lj5mOR5rIlhkCXd
 h5zZ61IaZHPQC/rVX4G5gPBe14BjM6SW8ZsnmW1DSBSGcbNEII1WNJQ+wK+eFEdaSh
 myMGWJ2Tmi7mxgWM+Re7FfRNjSyWxmKtyq6yHb50=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v6 04/24] arm_ffa: sandbox: Improve the readability of
 clearing the X registers
Date: Thu, 17 Sep 2026 18:17:50 +0100
Message-ID: <20260917171810.4122899-5-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:15 +0000
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Make clearing the must be zero registers more readable in the emulator

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 .../sandbox/include/asm/sandbox_arm_ffa_priv.h | 17 +++--------------
 drivers/firmware/arm-ffa/ffa-emul-uclass.c     | 18 +++++++++---------
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h b/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h
index b0881822d78..fdb38bdf46c 100644
--- a/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h
+++ b/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2025-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -39,19 +39,8 @@
 #define RXTX_BUFFERS_MIN_SIZE (RXTX_4K)
 #define RXTX_BUFFERS_MIN_PAGES (1)
 
-/* MBZ registers info */
-
-/* x1-x7 MBZ */
-#define FFA_X1X7_MBZ_CNT (7)
-#define FFA_X1X7_MBZ_REG_START (&res->a1)
-
-/* x4-x7 MBZ */
-#define FFA_X4X7_MBZ_CNT (4)
-#define FFA_X4X7_MBZ_REG_START (&res->a4)
-
-/* x3-x7 MBZ */
-#define FFA_X3X7_MBZ_CNT (5)
-#define FFA_X3_MBZ_REG_START (&res->a3)
+/* A helper macro used for clearing registers that Must Be Zero (MBZ) */
+#define FFA_X_REG_SIZE_IN_BYTE sizeof((((ffa_value_t *)0)->a0))
 
 /* number of emulated FF-A secure partitions (SPs) */
 #define SANDBOX_PARTITIONS_CNT (4)
diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
index 1cdd188b6fb..9ebc53dc1e6 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -80,7 +80,7 @@ static int sandbox_ffa_version(struct udevice *emul, ffa_value_t *pargs, ffa_val
 	res->a0 = priv->fwk_version;
 
 	/* x1-x7 MBZ */
-	memset(FFA_X1X7_MBZ_REG_START, 0, FFA_X1X7_MBZ_CNT * sizeof(ulong));
+	memset(&res->a1, 0, 7 * FFA_X_REG_SIZE_IN_BYTE);
 
 	return 0;
 }
@@ -108,7 +108,7 @@ static int sandbox_ffa_id_get(struct udevice *emul, ffa_value_t *pargs, ffa_valu
 	res->a2 = priv->id;
 
 	/* x3-x7 MBZ */
-	memset(FFA_X3_MBZ_REG_START, 0, FFA_X3X7_MBZ_CNT * sizeof(ulong));
+	memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
 
 	return 0;
 }
@@ -133,14 +133,14 @@ static int sandbox_ffa_features(ffa_value_t *pargs, ffa_value_t *res)
 		res->a2 = RXTX_BUFFERS_MIN_SIZE;
 		res->a3 = 0;
 		/* x4-x7 MBZ */
-		memset(FFA_X4X7_MBZ_REG_START, 0, FFA_X4X7_MBZ_CNT * sizeof(ulong));
+		memset(&res->a4, 0, 4 * FFA_X_REG_SIZE_IN_BYTE);
 		return 0;
 	}
 
 	res->a0 = FFA_SMC_32(FFA_ERROR);
 	res->a2 = -NOT_SUPPORTED;
 	/* x3-x7 MBZ */
-	memset(FFA_X3_MBZ_REG_START, 0, FFA_X3X7_MBZ_CNT * sizeof(ulong));
+	memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
 	log_err("FF-A interface %lx not implemented\n", pargs->a1);
 
 	return ffa_to_std_errmap[NOT_SUPPORTED];
@@ -245,7 +245,7 @@ cleanup:
 	res->a1 = 0;
 
 	/* x3-x7 MBZ */
-	memset(FFA_X3_MBZ_REG_START, 0, FFA_X3X7_MBZ_CNT * sizeof(ulong));
+	memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
 
 	return ret;
 }
@@ -302,7 +302,7 @@ feedback:
 	res->a1 = 0;
 
 	/* x3-x7 MBZ */
-	memset(FFA_X3_MBZ_REG_START, 0, FFA_X3X7_MBZ_CNT * sizeof(ulong));
+	memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
 
 	return ret;
 }
@@ -349,7 +349,7 @@ feedback:
 	res->a1 = 0;
 
 	/* x3-x7 MBZ */
-	memset(FFA_X3_MBZ_REG_START, 0, FFA_X3X7_MBZ_CNT * sizeof(ulong));
+	memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
 
 	return ret;
 }
@@ -385,7 +385,7 @@ static int sandbox_ffa_rx_release(struct udevice *emul, ffa_value_t *pargs, ffa_
 	res->a1 = 0;
 
 	/* x3-x7 MBZ */
-	memset(FFA_X3_MBZ_REG_START, 0, FFA_X3X7_MBZ_CNT * sizeof(ulong));
+	memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
 
 	return ret;
 }
@@ -445,7 +445,7 @@ static int sandbox_ffa_msg_send_direct_req(struct udevice *emul,
 		res->a2 = -INVALID_PARAMETERS;
 
 		/* x3-x7 MBZ */
-		memset(FFA_X3_MBZ_REG_START, 0, FFA_X3X7_MBZ_CNT * sizeof(ulong));
+		memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
 
 		return ffa_to_std_errmap[INVALID_PARAMETERS];
 	}
-- 
2.43.0

