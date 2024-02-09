Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6511BC48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 19:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00ADE87E7B;
	Fri,  9 Feb 2024 20:21:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="ZnWN6ssE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A15D87E8F; Fri,  9 Feb 2024 20:21:03 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69CF587E88
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 20:21:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55ff5f6a610so1616594a12.3
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 11:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707506460; x=1708111260; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kROet1+r4UQB5ZDgXfRjlOqXpbtOTXZQBq4d0IsmJB4=;
 b=ZnWN6ssEyMt9h+MA2G5d3THEsShOzMWcj/vcrlgPTjN7EdeHIGHC+fDSGMyntJxjPJ
 Q64wZKiaQykCgXlRHV/Lcdav/L9+/yZD0vN6RERKPJvHxQS8KkKwAw2WQDI5q5aSx5jE
 XvVS6vuBUNY+af1axrU2aaRVrXSaBMP8hvmqt62OldgBhpjDbcZTecEDQwkZjJnhkHv0
 pG77+tYvj4iIIVYyx68/RtjKsAVNPpc/StJzc1GBJLeSs2wVfot2wc+Mn291115apm/l
 CwQD2wvwB7Cy+6rN7KNvi0uk/qpW4YNurHsJrcnko5RiM8Xr4xf2EB5fJ41MjNLosqUx
 rETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707506460; x=1708111260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kROet1+r4UQB5ZDgXfRjlOqXpbtOTXZQBq4d0IsmJB4=;
 b=RUJHqVNYv9v85yb65/8U8Asj5xJ5AohIId4H4Wviryk5BVttH6SNbYXJXi0f1CAElc
 3TB28alusq4ci0olELc81RTiWPgsmtz1MT5EauEWYuTW0nIHSyRXVM2LbGrICK6dXTkx
 B7IDtrogaUW2k0eztHCbVgikJBfkgLWcrutkTVFcXULeY2CukWsmoUuBZ1Bz1MzHS0RI
 FGHxDuFXBgC1ZmBxzXC4AFm8spKh4xKta6uORtn/5HdoEoxS9Tv2DSjd/mejlpG7n4y2
 vW/3ETAQlaSpAyM+GHzqpzEuvuNj2iPp/kUozowjaidG9b7AJwWn4GqG7Q5p5hS+o3lv
 v6CQ==
X-Gm-Message-State: AOJu0YxpNwnsn2hu0QiTBrqs9bXkXrB3lHt59Bt/qCZB4cyszs1tKNlc
 +FplAP4sz+JsYBFd84HSfKMPtl9g9TXaPWSOM47G4t16Zqxll9vRzoy0n4pvBeQN35sV5egM9lP
 9df8=
X-Google-Smtp-Source: AGHT+IFzQubK2nQnyVNiJ98OlLuOjHe8HnEJfnqJV3tkuMjJRo0kV/xIupUfqBcrB08EL05E49+6tg==
X-Received: by 2002:a17:906:6d5:b0:a3c:11a0:8d10 with SMTP id
 v21-20020a17090606d500b00a3c11a08d10mr55510ejb.3.1707506460346; 
 Fri, 09 Feb 2024 11:21:00 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX+0qaJBzAj1nVL7T9MuqwlQY29qhCVPgqIjdiNBtlw19uvhoN0EAuqm/Qn21E7BW/1dnsMohOopwJQ2Yhy7GuhHCWFrwTbhV5qqLA+FQctob/3RniyPlGBbouWOTB0eSrr73qs5VMhWRv1oJEZgczvFgHVj98jFopzNs4HJIOU0Tf1t5Xm4MsGMjjzZ0k3Fd0=
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 fj7-20020a1709069c8700b00a3875804883sm1029841ejc.124.2024.02.09.11.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:20:59 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/7] common: avb_verify: rework error/debug prints
Date: Fri,  9 Feb 2024 20:20:41 +0100
Message-Id: <20240209192045.3961832-4-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Igor Opaniuk <igor.opaniuk@gmail.com>

Make error prints more verbose with additional context.
Also s/print/debug/g for prints, which might be relevant only
for debugging purposes.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

Changes in v2:
- Mattijs Korpershoek R-b tag applied

 common/avb_verify.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index 938a5383b5d..ed58239cf8a 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -279,9 +279,9 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
 	 * Reading fails on unaligned buffers, so we have to
 	 * use aligned temporary buffer and then copy to destination
 	 */
-
 	if (unaligned) {
-		printf("Handling unaligned read buffer..\n");
+		debug("%s: handling unaligned read buffer, addr = 0x%p\n",
+		      __func__, buffer);
 		tmp_buf = get_sector_buf();
 		buf_size = get_sector_buf_size();
 		if (sectors > buf_size / part->info.blksz)
@@ -320,7 +320,8 @@ static unsigned long mmc_write(struct mmc_part *part, lbaint_t start,
 	if (unaligned) {
 		tmp_buf = get_sector_buf();
 		buf_size = get_sector_buf_size();
-		printf("Handling unaligned wrire buffer..\n");
+		debug("%s: handling unaligned read buffer, addr = 0x%p\n",
+		      __func__, buffer);
 		if (sectors > buf_size / part->info.blksz)
 			sectors = buf_size / part->info.blksz;
 
@@ -348,30 +349,35 @@ static struct mmc_part *get_partition(AvbOps *ops, const char *partition)
 	dev_num = get_boot_device(ops);
 	part->mmc = find_mmc_device(dev_num);
 	if (!part->mmc) {
-		printf("No MMC device at slot %x\n", dev_num);
+		printf("%s: no MMC device at slot %x\n", __func__, dev_num);
 		goto err;
 	}
 
-	if (mmc_init(part->mmc)) {
-		printf("MMC initialization failed\n");
+	ret = mmc_init(part->mmc);
+	if (ret) {
+		printf("%s: MMC initialization failed, err = %d\n",
+		       __func__, ret);
 		goto err;
 	}
 
 	if (IS_MMC(part->mmc)) {
 		ret = mmc_switch_part(part->mmc, part_num);
-		if (ret)
+		if (ret) {
+			printf("%s: MMC part switch failed, err = %d\n",
+			       __func__, ret);
 			goto err;
+		}
 	}
 
 	mmc_blk = mmc_get_blk_desc(part->mmc);
 	if (!mmc_blk) {
-		printf("Error - failed to obtain block descriptor\n");
+		printf("%s: failed to obtain block descriptor\n", __func__);
 		goto err;
 	}
 
 	ret = part_get_info_by_name(mmc_blk, partition, &part->info);
 	if (ret < 0) {
-		printf("Can't find partition '%s'\n", partition);
+		printf("%s: can't find partition '%s'\n", __func__, partition);
 		goto err;
 	}
 
@@ -684,7 +690,7 @@ static AvbIOResult read_rollback_index(AvbOps *ops,
 {
 #ifndef CONFIG_OPTEE_TA_AVB
 	/* For now we always return 0 as the stored rollback index. */
-	printf("%s not supported yet\n", __func__);
+	debug("%s: rollback protection is not implemented\n", __func__);
 
 	if (out_rollback_index)
 		*out_rollback_index = 0;
@@ -730,7 +736,7 @@ static AvbIOResult write_rollback_index(AvbOps *ops,
 {
 #ifndef CONFIG_OPTEE_TA_AVB
 	/* For now this is a no-op. */
-	printf("%s not supported yet\n", __func__);
+	debug("%s: rollback protection is not implemented\n", __func__);
 
 	return AVB_IO_RESULT_OK;
 #else
@@ -766,8 +772,7 @@ static AvbIOResult read_is_device_unlocked(AvbOps *ops, bool *out_is_unlocked)
 {
 #ifndef CONFIG_OPTEE_TA_AVB
 	/* For now we always return that the device is unlocked. */
-
-	printf("%s not supported yet\n", __func__);
+	debug("%s: device locking is not implemented\n", __func__);
 
 	*out_is_unlocked = true;
 
-- 
2.34.1

