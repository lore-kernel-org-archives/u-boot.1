Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F39DCA0FFF
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 16:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF1F683965;
	Mon,  1 Sep 2025 18:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T2Rr+2fk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1645D839A1; Mon,  1 Sep 2025 15:44:22 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E32C5831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 15:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhimeswararao.matsa@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b47052620a6so3895175a12.1
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756734258; x=1757339058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7kiBcWB/mc3EvJNkCsxJqa+LEE4VkGUW+nyiuJsP7XM=;
 b=T2Rr+2fktmZzBP0P035XJoxf/Cn8A95C2rtIDPZrQVnGOolwP9tJeTmmaEt2GNF48e
 Dp7SFDhXM8drUiJNMp4pOef/C7OKFHOKjLQqfvyV0scSzB0Jg8+WGYStDDtvf8Dc1Dgw
 KtTsW9Cssy5XxpFBGIjrQnvMklvFkvs1TxuulND7EST6hTXkjdRHRfTdqLi7oo+MsNWk
 ym+5ob5FmKl6ouJTt1Ij2Y1CyyfzisXjhzwS5vRqPKEuERClBoJbo7qmtyE21pvF/iiv
 NxlcWV0KPKnUid8EMU922uVoX1bwt5NGaDxqwCjIeqa26Q16XBc0Bu+qDKHZeAfP5Oem
 yKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756734258; x=1757339058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7kiBcWB/mc3EvJNkCsxJqa+LEE4VkGUW+nyiuJsP7XM=;
 b=JSdCXrbgI+2t/XwGc+NZEUsTFMXVxslYSaguF4e1z/vy4Fv00NocgYQ2khV5lKy4zt
 8Yu29808QU93GSMuVXWYjNlZiIUWSZCYslrPmPi2mb2MPihbz0Q0xFNzKkhfu3VylLFr
 JVxQkHoupxvN6Y7L1DnSk4X6sXt8ymONB42WB4KHIdKfMHwca8+FT4bB2Iu8FjZXmqcd
 st7lxh/2dqG4MIbr3PlekVmTrFepiqrjW6/dTeYLfWsmR+rb/qnQnGqUmCp/SRfAW7jv
 FrX/H4v5WWUoL9hz8ASrgMXXKA/4yO5sCf4axa4NMqg9bXYHjaZwwT+mHaBtoHdydvvu
 IEOQ==
X-Gm-Message-State: AOJu0YwscqUtAGaaC69keaQxTv+QBR8yEfBrzNJ9OQh1uj/4KNtds0Om
 4jDc0huQ7ahrxm1dL0kpzWMLa3MCfoSEJ8SDRXpBtgkiEbDTh2zk4sWueJ/lOw==
X-Gm-Gg: ASbGnctNQO+qEYwr+ih37I5JCdVYLdolL1i3hXSqnIHtm1ae2EhZ+MYYL3fUg7GhNU/
 yoH8VuR20AMtVQ831MZUF+ZvuwJEcbYvgG8imjCN9dzS3UeGgi3pxgFK5ns7vDpPxnDlJpyV3JH
 1k+MAYwZgU/4uVaIozO9/QWjDRFDjMZj/iZxEdYxXnrNEVSbHeFvPg6VfA7DnrFuj7eaq/UzyhM
 dgr1Gwt73R7g0nzVaBSVz89agwavcygRZK3sc8u2VpykFetDO3GynYN80ZWKdZjWKNf4focJNZq
 9DrHFTXPMdJEFOM1IMuoSA0TVHfScsQTZJrRLTkn8i0WgBG1n6xfmhhvOedUUIuW7Rc5djar7z9
 1TE4WDXaBHRaoHUGI1t49M+wLJrlMWJPjxmHSucgykn1dg7cyZdDBy5ER5A/+AzyA0zrQq7Qxk1
 Ckc3jzo7P4YLrwjNoPmLy/
X-Google-Smtp-Source: AGHT+IFocKSTGBZqr2ooui7jCNIB6hju5RKJ2TSB91HsEEROklDYmVEvnb5QpKK845ADhdlB1gX1Pw==
X-Received: by 2002:a17:902:fc8f:b0:24a:4560:49be with SMTP id
 d9443c01a7336-24a45604eeamr100384625ad.28.1756734257701; 
 Mon, 01 Sep 2025 06:44:17 -0700 (PDT)
Received: from kumara-Inspiron-15-3530.. ([49.207.220.140])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249066dfa71sm105780465ad.140.2025.09.01.06.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 06:44:17 -0700 (PDT)
From: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
To: u-boot@lists.denx.de
Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Subject: [PATCH] mmc: core: style fixes in mmc.c
Date: Mon,  1 Sep 2025 19:14:10 +0530
Message-ID: <20250901134410.34344-1-bhimeswararao.matsa@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Sep 2025 18:31:50 +0200
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

Fix a couple of style issues reported by checkpatch.pl:

- Replace `#ifdef CONFIG_MMC_TRACE` with `if (IS_ENABLED(CONFIG_MMC_TRACE))`
  to follow the preferred kernel style for config-dependent branches.
- Drop explicit zero initialization of a static variable.

No functional change intended.

Signed-off-by: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
---
 drivers/mmc/mmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 5f2efbe6df9..54ee6d40a75 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -104,8 +104,7 @@ __weak int board_mmc_getcd(struct mmc *mmc)
 	return -1;
 }
 #endif
-
-#ifdef CONFIG_MMC_TRACE
+#if (IS_ENABLED(CONFIG_MMC_TRACE))
 void mmmc_trace_before_send(struct mmc *mmc, struct mmc_cmd *cmd)
 {
 	printf("CMD_SEND:%d\n", cmd->cmdidx);
@@ -3190,7 +3189,7 @@ static int mmc_probe(struct bd_info *bis)
 
 int mmc_initialize(struct bd_info *bis)
 {
-	static int initialized = 0;
+	static int initialized;
 	int ret;
 	if (initialized)	/* Avoid initializing mmc multiple times */
 		return 0;
-- 
2.43.0

