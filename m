Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A958606A886
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kpuWyngt;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Cdsp4Km6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1B084074E;
	Tue, 17 Nov 2026 06:42:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6n_mfNhhd3xi; Tue, 17 Nov 2026 06:42:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CBCD240600
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794897760;
	b=NRkHkzPGpci4GNTS6C7jMzhl2NeHtFCiMNQiocNt4gvJTFouJv17tQKQBLSr6sBv7hf6
	 IizwiYT9EDwLeHt1RtEDiaP2gQIXTO81HDZf3qDfkOSIAUn9YXDZxWk4R5LlREReUE1Hs
	 +Zf9FoTQGELdqfkRhphf2+ssFuQM1Z/leRsW4xwZNJ5IyLQmepF0lRYIanrA+wmJiitHD
	 1YDSvPX2g+EsSbYj3k+HPaQa0fGSBLs4TqMIxSHzM7jz9lkBVshy7NI/lYlhVRuBLXBhr
	 LcLfsT8+bh19/vnqt61lrItN5jv9SZPgQleQgZqjOfU0jIsUdA+a+JTzNpFJy1/InMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794897760;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gz/3MvtBAxKZoipIQcbqe+K+aFd1UPlCfI8mJ+adcpw=;
	b=Rp96SbSPjnUbvXkt3MzTwAE3rN9v8YOU6RUr8C6pK+9r8XoML3+JjOQD3dL7ihLCJmOT
	 zQwLmqGg0ynSMHWlgkhfXp7cb2phzP70UYFPHTtZ12rEIwJ6zXl52ZXpe4El4vMW4QRmr
	 sYmsVZ+Mm8CsZOBsc2wTwU5GFf8K9ZdQuSGYZe4/R8j3KWi5p+TtJZZoQSvBAPVMqIFSF
	 mogd1Lz2mo8nD3YX9mHGDL+Iy7b7ZPiYy53OXTegvn4+yQYZtIpGL6shHPJJp6mkzpeKv
	 m6gl/m/deHi9oRzVIwGddmmtiSgouCxgWljiH6tKD2eFX0YXbdiRUfIVCsCKt7mVMIQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794897759;
	bh=gz/3MvtBAxKZoipIQcbqe+K+aFd1UPlCfI8mJ+adcpw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kpuWyngtIxXtNMx//0FkGNwsuqqNZqXQFC8909MFSULYZM9mZL5SJMA2yD+Zo00xA
	 /PAuY8H9AUF/K492HM1qE7F0NzR4V1ZbGjXr3sczypbutkrKQ+MGybgQ7tUdM2b8It
	 pax1bl8Bn96WDJDyRYkQewXl6kkqOxmhYA03o2I4fE0tVpF/LXAgLAFrcfww+g2pwO
	 o50jj47qizVyNP5MdYSfdWmtMbhw1/dVPVklk9M9JLSM9l3F/jl0RNRZtWJ8N6Tqa6
	 n3GVmhij8RflS49HWYKVKMO+bfDKC29gSr4vViYrVC+HPuWnU2uk7U+QecMETbgDD/
	 2UBrrLR9VJIpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBCD240600;
	Tue, 17 Nov 2026 06:42:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3849213C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FD8060835
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:42:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T8u8waUQQwiJ for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 06:42:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CDE8060600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Cdsp4Km6
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDE8060600
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:42:36 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4bb6c7b6dbdso25020305e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794897754; x=1795502554;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gz/3MvtBAxKZoipIQcbqe+K+aFd1UPlCfI8mJ+adcpw=;
 b=Cdsp4Km6o2dVjeZyefO6al3N8hsIv5Epks8SwwSWu4E6GQYHxD6UckzHTbpihoIiDo
 N9uzQSk5OpLTQJukKbhT1woba03lWy4a6zVv6MKQe/eBMrPTHoCXs3oo2o1+Zg/niFLB
 An5gO1qBrnoB4BmwQyfGBCT8v02leAs7oJLdBbsKpTP/z9L73SMMQHEyaLfVsRUV/kcE
 6JSkb1xlWKAvFIT9uFnjP7vCeavCxoU5F9uOFMS3Lz3piB/s6O9/nTP941lapq6oAzqZ
 jn9w+dGIQEGV3nKifcurvb8TDOt5sPZnOudNAK4hL3pAnwd7u7HxGzXtWBERIZqETngu
 iDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794897754; x=1795502554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gz/3MvtBAxKZoipIQcbqe+K+aFd1UPlCfI8mJ+adcpw=;
 b=Z53VvNEXEIo02l5XtKjGbS2siv70cDMGKJKEXpf5VFOrp39n6bkja2Olb2gOon6LyT
 Z2NAP+0+0BxRmGRpcPZYGnfNcxy/IHwEQTKloKSN4YgjlyuFRV6grOFMH1wKVkkZqA21
 HIDv6sCPoLu+ar1+C/SsqlZSucibtk9Dli5TykYJxQ4JMKysfUrIh2Ita13Gmk90Ic2Z
 tpYP4LL9lCJgIqLab4IvzBh1okICWVvHHctq8wK+/5VWhZuHWHod1z1lpk4nQme+Zzpo
 EHD2K546vV1XqbaG/A41TTvSagKaSwv9Xv6jOZBfkmSHRydb74reqgqnH4+VgwIk5bCw
 uO/Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGAtuHvSQw+1HL1bpkZ2peTepx8pll2/87We+3OB+SDysi4RRmwTw1+i/bKYGY1JB7P0iC+jv0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Fls3g2CNlVK1TzpLbxqk9vSlff3ZutW2W/wEo0V3Psziyc0bS
 9VT1cCIdknmgYeopJCqqOUL30BKFfE3UXYQIaiYErB1WMDNa9mY5sAxa5lytckF4Sv4=
X-Gm-Gg: AZFdTZddPOyM08/9sVEljdMaDtyu8girqOC5RXwacoceHZyYyg2H2wc3vr1EGhtBnVl
 jDCBk2pZ01X9hCUs7FXXqrF9UyAgS/XGzL7Ss/dCZ/dHPQ9WuLh+1juDCrC4NDicLV5U1VO1xPe
 iISSBr0RnLuU/qPZI4k5yBPp/ofENY4oESPz6wKNvr0DtwErGlIdTAhHd7YH5VztxU6lzufxyT3
 20vGmXJ+5+39WL0TskatNpGasss7+ZqCYplv8dYZnuEyAI6uu5vDIA9o/6KyMqIIf0/hhsWejzC
 vZ6pS6uiY82phEtaQavQbMKzRWNJqPX59GgwvdVtNVOgqGPtB7NrhdAyWyWwF41ZQV3sIAmFnjm
 KNNL3mAiHVUcAKB0S4xRgRh5tVGsixx8vIAIbnOMgQI5FupIkT7kgRRNMfaNPr9uJCC5X7X+AgC
 8zpBp0KjnVVWUbqCR4ggCV9jvfiYnNUwW1KXR7u6TlUErAiITSRFHK3s/irfS/q0+sWd7trQoEF
 cGXvQX0KvRfA9UA8V8Ie3orxG5TSSK77C6HGcPc6XTmC8JaLR8yD/dGRBSFkdYUIaeo3qNnVA6p
 sWAz1W6Mov7PFalOUlqcXIUM0AJtnyBo54jDD6pX2hWofo90mckW8ztrsfhkUzUJLK/ixiVvkM0
 noer7e4s88GHFkPBuOazJ3DlrRZTGK9oAhE+TkBjPV2H5y2ZjUhZFPRlxv391rqLEi8m02bK2Ww
 sSn5nrk+gkj3QvwQGt7HLU3OChPxKtgUVvYSpS4rlaRLDVUqgb7xBpAVZYa1kEqI/iYKAjfSxHm
 dripaAEPr+37lYsBx3dAlO7itFoVHRR6KY/OWiNkC6+tjDBfBXiiCSNidfBAmguWcywywJcmPq7
 Rt8iIXAGhUk244H2ayKj5zDtnfaKIPhlwDL1kiyMLkJfcQyRoB+jAdOpduBdo3pme5X0jLvXkv6
 cw30SnTPNtJEbk/ucDVfgNWIYS/oV++1pB+kyCdwjiRb+fiKEdYctCTQ3FGfoV04m
X-Received: by 2002:a05:6000:1624:b0:49d:7da6:7d4a with SMTP id
 ffacd0b85a97d-49d7da67e6cmr13429586f8f.34.1794897753923; 
 Mon, 16 Nov 2026 22:42:33 -0800 (PST)
Received: from hades ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5fe370f8sm23520710f8f.27.2026.11.16.22.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 22:42:33 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com,
	igor.opaniuk@oss.qualcomm.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] Revert "optee: rpmb: select the RPMB partition per request"
Date: Tue, 17 Nov 2026 08:42:24 +0200
Message-ID: <20261117064225.797584-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This reverts commit f473480c43a85961b62a45436a7e095e16c2cdab.
We discussed in the thread that this isn't need but was inadvertently
picked during the merge. Revert it

Link: https://lore.kernel.org/u-boot/CAC_iWj+0wVosYVrq3pAyDF+ekjf=sq7oOnRZfb_CfddDZq4c-Q@mail.gmail.com/T/#m7cc19b8ca8b05a2ad192b8264629f08c6a5ea86a
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/tee/optee/rpmb_emmc.c | 88 ++++++++++++++---------------------
 1 file changed, 36 insertions(+), 52 deletions(-)

diff --git a/drivers/tee/optee/rpmb_emmc.c b/drivers/tee/optee/rpmb_emmc.c
index a40573c92818..c00e46be9494 100644
--- a/drivers/tee/optee/rpmb_emmc.c
+++ b/drivers/tee/optee/rpmb_emmc.c
@@ -42,55 +42,51 @@ struct rpmb_dev_info {
 
 static void release_mmc(struct optee_private *priv)
 {
+	int rc;
+
 	if (!priv->rpmb_mmc)
 		return;
 
+	rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
+				      priv->rpmb_original_part);
+	if (rc)
+		debug("%s: blk_select_hwpart_devnum() failed: %d\n",
+		      __func__, rc);
+
 	priv->rpmb_mmc = NULL;
 }
 
-/*
- * The RPMB hardware partition is selected for the duration of a single
- * request only. Between two requests other users of the same eMMC, for
- * instance libavb reading the user area while verifying a chain of
- * partitions, switch the device back to the user area. Keeping RPMB
- * selected across requests would make those reads, and the following RPMB
- * frames, hit the wrong partition. get_mmc() therefore selects the RPMB
- * partition on every call, and restore_part() puts the previous one back
- * once the frames have been routed.
- */
 static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
 {
 	struct mmc *mmc;
 	int rc;
 
-	if (!priv->rpmb_mmc || priv->rpmb_dev_id != dev_id) {
-		release_mmc(priv);
+	if (priv->rpmb_mmc && priv->rpmb_dev_id == dev_id)
+		return priv->rpmb_mmc;
 
-		mmc = find_mmc_device(dev_id);
-		if (!mmc) {
-			debug("Cannot find RPMB device\n");
-			return NULL;
-		}
-		if (mmc_init(mmc)) {
-			log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d init failed\n",
-			    __func__, dev_id);
-			return NULL;
-		}
-		if (!(mmc->version & MMC_VERSION_MMC)) {
-			debug("Device id %d is not an eMMC device\n", dev_id);
-			return NULL;
-		}
-		if (mmc->version < MMC_VERSION_4_41) {
-			debug("Device id %d: RPMB not supported before version 4.41\n",
-			      dev_id);
-			return NULL;
-		}
+	release_mmc(priv);
 
-		priv->rpmb_mmc = mmc;
-		priv->rpmb_dev_id = dev_id;
+	mmc = find_mmc_device(dev_id);
+	if (!mmc) {
+		debug("Cannot find RPMB device\n");
+		return NULL;
+	}
+	if (mmc_init(mmc)) {
+		log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d init failed\n", __func__, dev_id);
+		return NULL;
+	}
+	if (!(mmc->version & MMC_VERSION_MMC)) {
+		debug("Device id %d is not an eMMC device\n", dev_id);
+		return NULL;
+	}
+	if (mmc->version < MMC_VERSION_4_41) {
+		debug("Device id %d: RPMB not supported before version 4.41\n",
+		      dev_id);
+		return NULL;
 	}
 
-	priv->rpmb_original_part = mmc_get_blk_desc(priv->rpmb_mmc)->hwpart;
+	priv->rpmb_original_part = mmc_get_blk_desc(mmc)->hwpart;
+
 	rc = blk_select_hwpart_devnum(UCLASS_MMC, dev_id, MMC_PART_RPMB);
 	if (rc) {
 		debug("Device id %d: cannot select RPMB partition: %d\n",
@@ -98,18 +94,9 @@ static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
 		return NULL;
 	}
 
-	return priv->rpmb_mmc;
-}
-
-static void restore_part(struct optee_private *priv)
-{
-	int rc;
-
-	rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
-				      priv->rpmb_original_part);
-	if (rc)
-		debug("%s: blk_select_hwpart_devnum() failed: %d\n",
-		      __func__, rc);
+	priv->rpmb_mmc = mmc;
+	priv->rpmb_dev_id = dev_id;
+	return mmc;
 }
 
 static u32 rpmb_get_dev_info(u16 dev_id, struct rpmb_dev_info *info)
@@ -143,7 +130,6 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
 {
 	struct rpmb_req *sreq = req;
 	struct mmc *mmc;
-	int rc;
 
 	if (req_size < sizeof(*sreq))
 		return TEE_ERROR_BAD_PARAMETERS;
@@ -153,11 +139,9 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
 		mmc = get_mmc(priv, sreq->dev_id);
 		if (!mmc)
 			return TEE_ERROR_ITEM_NOT_FOUND;
-		rc = mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
-					   req_size - sizeof(struct rpmb_req),
-					   rsp, rsp_size);
-		restore_part(priv);
-		if (rc)
+		if (mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
+					  req_size - sizeof(struct rpmb_req),
+					  rsp, rsp_size))
 			return TEE_ERROR_BAD_PARAMETERS;
 		return TEE_SUCCESS;
 
-- 
2.53.0

