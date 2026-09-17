Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8645CC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:19:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5ABDA60B83;
	Thu, 17 Sep 2026 17:19:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t3Xgm9yGPyG3; Thu, 17 Sep 2026 17:19:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D8FC660B94
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665573;
	b=ZCEalRhPFp3pVSN/DYesmlk1j67eHvI99k15I7SIC2NT+/SwmsPSqXRZn7LOw7jlCICH
	 wcx6znIu7SCA6/DpMJqIsEIrSPw/PIsUq3/LmcTpng6AVINidMuBe+8BGCzFG/xqI4ZQt
	 WdfeTlvq0dvuJb/lY7zFNz5ztyWV/FLVgfMEe4FJgBcrPw2enVO248aKTClUzx5hETf+I
	 8qwn8Hub6VUW5EvsFJM3KyaVF+iMpBFtaA8EbgDIxB3utSj12o7mbLPeW71N/rnu4hGFh
	 1yA5NVnb/3KGM6RY4XUJ7GQQjj3nQPAXNcr5awPfAXQaP7VWXc2PWyVlWDAlJXAh0Iw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ltdckUTehWUA0t04W8CtsCIGJnjOK9pXqpmMm7DjBLw=;
	b=WMzuXITNR4tHzdCJsxM5GbznvnTLF5cpTxHd6ixNEiNAqaL0LeTbTVhRxzQSJCG2gJbX
	 C8APUuP1t4C7xL6ERU9h5VRt3v890FyD7Mb1eUVUoaD5sQT5NRxHLtcLzpP9PJCSpvYes
	 AgDDreBm8qC8F5yXI43UDTobMCZduc26P8rOn0BEWxdDJTf01WmgaCl5Qq/K+WVOnz2DI
	 j051vRCgae16A74Z/q+pj/sYTzwoGrqW0CTVj3i5cCWO6JFYR1khiUhEgRJWsNCMMcrJi
	 Bz9nasiI/W/E6TXMWDLBe9+Sxfsn0W4z+pqAZIL9kNW1NEzZ7EoA6RJfNqK7iN3ACuw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XOZIkxAp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665573;
	bh=ltdckUTehWUA0t04W8CtsCIGJnjOK9pXqpmMm7DjBLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w3Txy+fJ5S/CYif+Qgm9sVVDaiw1O25ENaWgn1o1H+MwaDB2VWOcAzdJsXDk3N6OV
	 R+uK0p/0gyKyyieWJY9opBbGt4te9zXbQ9S2PyvK+kcGinwKlrlQdy/evy5vfpT5BD
	 1K6xV6ZLP65bcuB9H4rEVM2L4SCfj9WnN+jpKD5yhMot8HQfigiQzKtE03riGFcSVk
	 5po/fMfzr9UBqsgVYx4sAM5JPQZpeGByqP/dQzCuC8w394VLh+R9LilMpLiduyEK0z
	 EA1I8/saIDynLPe85uzoUM/3DSR1MW2zbJpzt3OL2HYutn7bnTwHUJYixzvEabA2Qm
	 Qj82aLo2oSrlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8FC660B94;
	Thu, 17 Sep 2026 17:19:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F4F3422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E956460B6C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9GmvOtHiQV4g for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:18:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9B48560B64
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665525;
 b=ikfRUWqDYOrLBvtqa1W1Dg4jH/czc9XSxrW1D8ke7c52mMmnxzijr1b1ttrGeX3vbj/1
 jkXN91UARAH55IoUSN5ZR8GctYjBKQQtkXI+f7rg817PxHbtVkehDW02DuSR4sbWHcxDQ
 k7N1i1rBUWxnOr/xhxmN40Lgm7oyuOke87cUE+STTzQt1A19LDnVtfoZuoVPn2qjUll+1
 8zZYyxla5Gg9Kf/UNp5qVPb4tG92ExBkZf0ztxZmNfW0LfsiVoAzln0MJeubrSJmllWCq
 Uxbg3vhtyTguDB8e4wsq64siURClH3DCyRh1MY5d7Fm5/CNcPdagvQiRdryf2dau4Xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665525;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ltdckUTehWUA0t04W8CtsCIGJnjOK9pXqpmMm7DjBLw=;
 b=edKvATpj/vnWNe0Vex0qYuSOxQVo9Yf0oZX6fbyiD2Qrwyer6NpIMV/CWUlDAAs1/Zm6
 D+onF4xI0eUodR0Q7YS8mwyUDaeKtIm41Bn5iOHSJgo4+qV0vOD4vxBZFgh6EFASvrfOZ
 6EhM1BMl0P9vpdU0xFePIhNxrUf407nRF0MVF78lY4quVx6hy5Y2DKW+p9nmntSiHbhVo
 5qdKY8K4Ax7kqdTYSzy4hRmtA/y8ePyiAPkEdqDBnRILzL3rVthk4Kdc4Hx5xpiiNOnOB
 3b1EqpsWxk3gY47QQUcHbfjJ27bGuAetLGLwnsEfEfha+MRA3y8s6YZxqNVXojgOHNg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=XOZIkxAp; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=XOZIkxAp
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9B48560B64
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EAD11596;
 Thu, 17 Sep 2026 10:18:41 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5E393F7B4;
 Thu, 17 Sep 2026 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665524; bh=kJJJlfcsdojxGvj4Pam50fV9hglGEUZDYnVDgghg9lc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XOZIkxAplB6MElpLFWgbxNZvNLgYRDDocnp8uuBGgD11thxs266ri2b0AOtPDGoDX
 5zkjTgEfZS3ph/f6ay3Lmoe/KZD+mxo615TPjjTphn6TpSghKSJtkLt9jcwADiG0+D
 cFmy1nV0RBXG4VuEnX5jRioyKUwAlSLuVTaQZuhs=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v6 05/24] arm_ffa: sandbox: Add FFA_MEM_SHARE emulation
Date: Thu, 17 Sep 2026 18:17:51 +0100
Message-ID: <20260917171810.4122899-6-harsimransingh.tungal@arm.com>
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

Add FFA_MEM_SHARE support to the FF-A emulator

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 .../include/asm/sandbox_arm_ffa_priv.h        |  4 ++
 drivers/firmware/arm-ffa/ffa-emul-uclass.c    | 43 +++++++++++++++++++
 drivers/firmware/arm-ffa/sandbox_ffa.c        |  3 +-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h b/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h
index fdb38bdf46c..d77842d1377 100644
--- a/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h
+++ b/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h
@@ -38,6 +38,7 @@
 /*  RX/TX buffers minimum size */
 #define RXTX_BUFFERS_MIN_SIZE (RXTX_4K)
 #define RXTX_BUFFERS_MIN_PAGES (1)
+#define RXTX_BUFFERS_MIN_PAGES_SIZE (RXTX_BUFFERS_MIN_PAGES * SZ_4K)
 
 /* A helper macro used for clearing registers that Must Be Zero (MBZ) */
 #define FFA_X_REG_SIZE_IN_BYTE sizeof((((ffa_value_t *)0)->a0))
@@ -59,6 +60,9 @@
 #define SANDBOX_SERVICE2_UUID_A3	0x9cc02d72
 #define SANDBOX_SERVICE2_UUID_A4	0xcdd998a7
 
+/* Globally unique Handle to identify the shared memory region */
+#define SANDBOX_MEM_HANDLE		0xffffffff
+
 /**
  * struct ffa_rxtxpair_info - structure hosting the RX/TX buffers flags
  * @rxbuf_owned:	RX buffer ownership flag (the owner is non secure world)
diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
index 9ebc53dc1e6..fca34ad7a2a 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -560,6 +560,46 @@ static int sandbox_ffa_get_parts(struct udevice *emul, struct ffa_sandbox_data *
 	return 0;
 }
 
+/**
+ * sandbox_ffa_memory_share() - Emulated FFA_MEM_SHARE handler
+ * @emul: The sandbox FF-A emulator device
+ * @pargs: The SMC call input arguments a0-a7
+ * @res:  The SMC return data
+ *
+ * Emulate FFA_MEM_SHARE FF-A function.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+static int sandbox_ffa_memory_share(struct udevice *emul, ffa_value_t *pargs,
+				    ffa_value_t *res)
+{
+	int ret;
+
+	res->a1 = 0;
+
+	if (!pargs->a1 || pargs->a1 > RXTX_BUFFERS_MIN_PAGES_SIZE) {
+		/* FFA_ERROR encoding */
+		res->a0 = FFA_SMC_32(FFA_ERROR);
+		res->a2 = -INVALID_PARAMETERS;
+		ret = ffa_to_std_errmap[INVALID_PARAMETERS];
+		/* x3-x7 MBZ */
+		memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
+
+		return ret;
+	}
+
+	/* FFA_SUCCESS encoding */
+	res->a0 = FFA_SMC_32(FFA_SUCCESS);
+	res->a2 = SANDBOX_MEM_HANDLE;
+	res->a3 = SANDBOX_MEM_HANDLE;
+	/* x4-x7 MBZ */
+	memset(&res->a4, 0, 4 * FFA_X_REG_SIZE_IN_BYTE);
+
+	return 0;
+}
+
 /**
  * sandbox_query_ffa_emul_state() - Inspect the FF-A ABIs
  * @queried_func_id:	The FF-A function to be queried
@@ -650,6 +690,9 @@ void sandbox_arm_ffa_smccc_smc(ffa_value_t *args, ffa_value_t *res)
 	case FFA_SMC_32(FFA_RX_RELEASE):
 		ret = sandbox_ffa_rx_release(emul, args, res);
 		break;
+	case FFA_SMC_32(FFA_MEM_SHARE):
+		ret = sandbox_ffa_memory_share(emul, args, res);
+		break;
 	default:
 		log_err("Undefined FF-A interface (%lx)\n",
 			args->a0);
diff --git a/drivers/firmware/arm-ffa/sandbox_ffa.c b/drivers/firmware/arm-ffa/sandbox_ffa.c
index f1e8de4bf0d..34d332979dd 100644
--- a/drivers/firmware/arm-ffa/sandbox_ffa.c
+++ b/drivers/firmware/arm-ffa/sandbox_ffa.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2025-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -88,6 +88,7 @@ static const struct ffa_bus_ops sandbox_ffa_ops = {
 	.partition_info_get = ffa_get_partitions_info_hdlr,
 	.sync_send_receive = ffa_msg_send_direct_req_hdlr,
 	.rxtx_unmap = ffa_unmap_rxtx_buffers_hdlr,
+	.memory_share = ffa_memory_share_hdlr,
 };
 
 static const struct udevice_id sandbox_ffa_id[] = {
-- 
2.43.0

