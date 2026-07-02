Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D456C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 01:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67CC284C5F;
	Thu,  2 Jul 2026 03:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fsbNvtS8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02D2684C5C; Thu,  2 Jul 2026 03:47:45 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C202584C15
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 03:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-69eb8b6bea8so635633eaf.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 18:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782956861; x=1783561661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lUwG10cAo8NY4DezcHtqRH6FIefQmFlivc6icHsUgPA=;
 b=fsbNvtS8eDSi8S4LyIrHbJxzEi8zoyKdJuv9fdtjWvN3ApNKRP7cQikLuvI5pxHUqQ
 SR+pPOc27fBgE1dL3QznHZlvIvT1l0vdj7v4XvO77W2ZHsNeqcfW2DYThfDmc+BbTbho
 jrFxqO8V5+ADaoJZoT8aT2zfMYiG9wyO+BSvgSl1wPJo1IPsOxDaQNOc+1XIKU5OzpD3
 kdOLV0R9y1HsZi0rdGrknW3tAjRMQvLMxCqkr9Atnbn4zzoGKLtDF6coWrPcPDqciZM9
 5CFD27kggrOwnLseCJIHS5xnGN8y3MaAy338dTXCJCJFGHTD77sEMCOns20e53/z1MSU
 T62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782956861; x=1783561661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lUwG10cAo8NY4DezcHtqRH6FIefQmFlivc6icHsUgPA=;
 b=OESCspjndvj1XjdcwK/Y65QHfezAiD9CqIVl+xElmAOfN4Cl4Kz17blfAu0MFBmxEw
 N92bFMeEpbtN2LdqOxKsgVd5NXt3yPeh2sYMY7rh8bOzSLqr3E0iGhacz9nO2/0rAL7Z
 tF7tja4SPinNQ6XFv86Ktd1XJYenDdPK6eQSAWqa/Q0mjCkEYGZrRfSzfFuj2Q9cQs1E
 wPRCo5kyYoM3ofQFqhp0LHTg97P4fr/e1+gCYkeuH9938GtNMVP96ES6cT4ihbkA39WB
 79uiPhCh4Txw21JA5GoJKkPBBucWKWdXYj+Y8JBIkgAAoWUz0nZ8x3yQXO96fKgkxeCW
 4SRg==
X-Gm-Message-State: AOJu0YxiqHL/hB4U55tP/RTv7dxtpt2K8uXgN+WVV0ivu3QLlPQPJWql
 cD8fEtdN3+0ZcguILDU7a3h5SLZ7Cw4BtUuYtxNvDgvQ+OEYE6YvlWBZIzw5GQKX8wQ=
X-Gm-Gg: AfdE7cnoYt+JlGhe2+kbCFgVFo/QzFLoa9MnelZ6Y0u8wNAhmoJGXTU78CNAH9iMBBS
 qjU+gqBQzB+7TjN0pKOY120z2AfCyi39qmTDqoOlfX37azv4/SqZ8Jsej9KJ9t2hyvoxVF1enTx
 BGtuI/E92DOrtB9oSw/iXDZBwqcH7+fiHznK+LWoeuEG+E3+4KS/r09lla3gvIvMhx/r+mkDufS
 HoVy4lMkqOvaXnpm4LOwyxuGq9NM+sc6485hHkop4WNtFhE6JzT/s6wDRX1NmscsoCIm8dU59Hr
 Q7QRBhhAN7HLIlgOdsRcPsw0feqPN6y61ALVqBqZBQAH8rBA5gDPhEVgk8h9iz3IKSjgRdzXMtJ
 sSkDU0spEEd1F69CXO/QjhNuzPH5kJV+uc6fohhPYi7H/PmFOz0tswbh6/iWlKgGqs+MlTfFXmn
 +E+Di+zpupmUqzjD+pcv44Qj5fEv4BBUCHsOtoQBOVls63TshmLiPou0Yd8u1ponnklocmJN0kQ
 0L1dXabbJPX6IlFELNTWFZm5iJu52HsoGJ0j5y2N9LV8W7CPImvyf0HB6D9gpbSCVSOuNWgvILz
 VKRoCwNg2vGRMWM=
X-Received: by 2002:a05:6820:82b:b0:6a1:50eb:d511 with SMTP id
 006d021491bc7-6a309bf5966mr2431326eaf.66.1782956861331; 
 Wed, 01 Jul 2026 18:47:41 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a310051cfcsm1284511eaf.8.2026.07.01.18.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 18:47:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>
Subject: [PATCH 1/9] cmd: aes: fix DM operation handling
Date: Wed,  1 Jul 2026 19:46:51 -0600
Message-ID: <20260702014724.1534351-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The DM AES command path takes operation-specific arguments after the
common arguments. Parse the requested operation before reading those
arguments so encrypt and decrypt use the correct positions.

Also handle in-place operations by reusing the source mapping when the
source and destination addresses match. Mapping and unmapping the same
range twice can break UCLASS_AES providers that perform DMA-backed
operations.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/aes.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/cmd/aes.c b/cmd/aes.c
index 3fd83013ffe..a74a68ee641 100644
--- a/cmd/aes.c
+++ b/cmd/aes.c
@@ -175,9 +175,9 @@ int cmd_aes_ecb(int argc, char *const argv[], u32 key_len)
 	if (ret)
 		return ret;
 
-	if (!strncmp(argv[1], "enc", 3))
+	if (!strncmp(argv[2], "enc", 3))
 		enc = 1;
-	else if (!strncmp(argv[1], "dec", 3))
+	else if (!strncmp(argv[2], "dec", 3))
 		enc = 0;
 	else
 		return CMD_RET_USAGE;
@@ -187,7 +187,10 @@ int cmd_aes_ecb(int argc, char *const argv[], u32 key_len)
 	len = hextoul(argv[5], NULL);
 
 	src_ptr = (uint8_t *)map_sysmem(src_addr, len);
-	dst_ptr = (uint8_t *)map_sysmem(dst_addr, len);
+	if (src_addr == dst_addr)
+		dst_ptr = src_ptr;
+	else
+		dst_ptr = (uint8_t *)map_sysmem(dst_addr, len);
 
 	/* Calculate the number of AES blocks to encrypt. */
 	aes_blocks = DIV_ROUND_UP(len, AES_BLOCK_LENGTH);
@@ -198,7 +201,8 @@ int cmd_aes_ecb(int argc, char *const argv[], u32 key_len)
 		ret = dm_aes_ecb_decrypt(dev, src_ptr, dst_ptr, aes_blocks);
 
 	unmap_sysmem(src_ptr);
-	unmap_sysmem(dst_ptr);
+	if (dst_ptr != src_ptr)
+		unmap_sysmem(dst_ptr);
 
 	if (ret) {
 		printf("Unable to do ecb operation: %d\n", ret);
@@ -223,9 +227,9 @@ int cmd_aes_cbc(int argc, char *const argv[], u32 key_len)
 	if (ret)
 		return ret;
 
-	if (!strncmp(argv[1], "enc", 3))
+	if (!strncmp(argv[2], "enc", 3))
 		enc = 1;
-	else if (!strncmp(argv[1], "dec", 3))
+	else if (!strncmp(argv[2], "dec", 3))
 		enc = 0;
 	else
 		return CMD_RET_USAGE;
@@ -237,7 +241,10 @@ int cmd_aes_cbc(int argc, char *const argv[], u32 key_len)
 
 	iv_ptr = (uint8_t *)map_sysmem(iv_addr, AES_BLOCK_LENGTH);
 	src_ptr = (uint8_t *)map_sysmem(src_addr, len);
-	dst_ptr = (uint8_t *)map_sysmem(dst_addr, len);
+	if (src_addr == dst_addr)
+		dst_ptr = src_ptr;
+	else
+		dst_ptr = (uint8_t *)map_sysmem(dst_addr, len);
 
 	/* Calculate the number of AES blocks to encrypt. */
 	aes_blocks = DIV_ROUND_UP(len, AES_BLOCK_LENGTH);
@@ -249,7 +256,8 @@ int cmd_aes_cbc(int argc, char *const argv[], u32 key_len)
 
 	unmap_sysmem(iv_ptr);
 	unmap_sysmem(src_ptr);
-	unmap_sysmem(dst_ptr);
+	if (dst_ptr != src_ptr)
+		unmap_sysmem(dst_ptr);
 
 	if (ret) {
 		printf("Unable to do cbc operation: %d\n", ret);
-- 
2.53.0

