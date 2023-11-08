Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412BFC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5BC86E2F;
	Wed,  8 Nov 2023 17:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m1NBK3CF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52AB687546; Wed,  8 Nov 2023 17:49:14 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB5DC876F1
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7781b176131so385278785a.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462150; x=1700066950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x4/nJDtJzFruXZDy2Na7Ni+YAVb2R0HJrlj5vS/qcUM=;
 b=m1NBK3CFLIAu6KnxweE7h/nxprCaHEvd8BnvQVKTBshAeBoZE8zjSj1u25k71ctROJ
 gjTKBOFeTKyNe2KabRWIFrCy4g/H6lZ69bH6CptTVCSYS0iVtdkHqGfViDHTbJnPSYTI
 RmtsJ9KZqn93Ye9S/isyc0xyaeJ7EhlTuYO2euigt+xpp0M1CVxu6yyaT2KhjNWMKI4F
 BWOMB7VjYPbFyxtU853p0Hbpg3+LUVGoOOJdZKJ6Y3k7lcolAK9l6S/n8uq3QFMhnaYE
 GjtWESGKuzZjQGtQ/tekPqgGoejEhnR0+NcmCSymxwixlhY9LJtB76GLTjxTvDjbhvE7
 4QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462150; x=1700066950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x4/nJDtJzFruXZDy2Na7Ni+YAVb2R0HJrlj5vS/qcUM=;
 b=FLh/MKA6k7lva35XWlmPlY5CqsX99y+S9gBqbyKWWR+z9WUih7S0OuJsEbKFReMeXP
 +KneBxBN4WaSJQCqBw0Z8CiOxaHL89jj9iVsR3loaLizEDP2DsMxrxkedkvZWD67xjfb
 5w76yjskqC/T/E+RnaiudjTX0vZBjgsZ4+kyb3JPPJBhydGppkB7zq6V7wL3DQuH14f4
 lm5Aw5US5IjzqrCSU4m9JmIxoLPcPUuY6OJVi1wqHMlktJ+JfD4GoFbwUYHH2QJby5dl
 urGiIMQqlkALVfTkBKwm738muH8cUmai2WlBAjsByIXT3NP2/9L8yMj4KIFrCy9XTPmT
 sjLg==
X-Gm-Message-State: AOJu0Yy1YVvctZLiDfCZI0jIPEbdXr2Ftolq3JBNOOM1bMhQqD0VdJRz
 1g/9E0mpAivEqKGge2CqG0M=
X-Google-Smtp-Source: AGHT+IEhGB3bEJhbasaW6TuAQKAslddJLn0yTELEQ8aDBMKqSTuRLcQ71IXwz4/cULV+Fb6sBjrGLw==
X-Received: by 2002:ae9:e515:0:b0:777:fec:5741 with SMTP id
 w21-20020ae9e515000000b007770fec5741mr2093387qkf.33.1699462150516; 
 Wed, 08 Nov 2023 08:49:10 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 bj9-20020a05620a190900b0077772296f9dsm1216712qkb.126.2023.11.08.08.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:10 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 uboot-imx@nxp.com
Subject: [PATCH v7 07/26] spl: Take advantage of bl_len's power-of-twoness
Date: Wed,  8 Nov 2023 11:48:39 -0500
Message-Id: <20231108164858.3497420-8-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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

bl_len must be a power of two, so we can use ALIGN instead of roundup and
similar tricks to avoid divisions.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

Changes in v6:
- New

 common/spl/spl_fit.c           | 2 +-
 common/spl/spl_imx_container.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 70d8d5942d9..6084ead0919 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -194,7 +194,7 @@ static int get_aligned_image_overhead(struct spl_load_info *info, int offset)
 	if (info->filename)
 		return offset & (ARCH_DMA_MINALIGN - 1);
 
-	return offset % info->bl_len;
+	return offset & (info->bl_len - 1);
 }
 
 static int get_aligned_image_size(struct spl_load_info *info, int data_size,
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 127802f5cb7..1cc51782766 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -33,13 +33,13 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 	images = (struct boot_img_t *)((u8 *)container +
 				       sizeof(struct container_hdr));
 
-	if (images[image_index].offset % info->bl_len) {
+	if (!IS_ALIGNED(images[image_index].offset, info->bl_len)) {
 		printf("%s: image%d offset not aligned to %u\n",
 		       __func__, image_index, info->bl_len);
 		return NULL;
 	}
 
-	sectors = roundup(images[image_index].size, info->bl_len) /
+	sectors = ALIGN(images[image_index].size, info->bl_len) /
 		info->bl_len;
 	sector = images[image_index].offset / info->bl_len +
 		container_sector;
@@ -69,7 +69,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
 	u32 sectors;
 	int i, size, ret = 0;
 
-	size = roundup(CONTAINER_HDR_ALIGNMENT, info->bl_len);
+	size = ALIGN(CONTAINER_HDR_ALIGNMENT, info->bl_len);
 	sectors = size / info->bl_len;
 
 	/*
@@ -103,7 +103,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
 	debug("Container length %u\n", length);
 
 	if (length > CONTAINER_HDR_ALIGNMENT) {
-		size = roundup(length, info->bl_len);
+		size = ALIGN(length, info->bl_len);
 		sectors = size / info->bl_len;
 
 		free(container);
-- 
2.37.1

