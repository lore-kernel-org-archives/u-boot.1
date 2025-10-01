Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D663DCCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C50983693;
	Wed,  1 Oct 2025 22:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZCE8Wq/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8411E83677; Wed,  1 Oct 2025 22:30:51 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BD558349B
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-30ccec59b4bso274901fac.3
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350648; x=1759955448; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZbnjHwhSLrI5UnC23/E7wZHhK4bI+6sb4DEhSBlek3Q=;
 b=ZCE8Wq/16Us086WMIMxK1S+/5EHmoH98uTilhZDiW/F6+1UWMXp17xvaxRgMSyhiPU
 OFZI0cEVR3bpDQcyugrETF2C4OOMb9IeWZ7pOf2UyEtUuGUuBChvruxRT/bHVyCm/CYq
 nfbagOpfa4nxi6JDUJQ088STS2mVlU1hsTqFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350648; x=1759955448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZbnjHwhSLrI5UnC23/E7wZHhK4bI+6sb4DEhSBlek3Q=;
 b=D32Gbw84RS76sJgloFfC1r1cCDDEY/NXusYcAHmAEwPsP1OELYoKC8V2v/NHAtEFmq
 x0mT1RUiRHSW4m+Vd03ZMXQ0UHcf1QAMfmAUTFE4BneML6IW8ihC+5N86D4X3B94MsMK
 knxycDEW+TtuTe5D1o9qZohb7vbZB631WtI+LROtJ4kuXIYL4ZY1GOSIYx1Qd7+kS0pA
 GQ2trgCbePdKozzP8l7eOVTAvrmijW0lYPIcReVbxZLVdx79AJJN1HIEG6KusGghKnkz
 amQyvb3nJ29GC2n2n9LfiAtHZ8z85hzqrP9Bd9AnIXC+riSX2w4YZxenrSbJPNWjnkw2
 N4/A==
X-Gm-Message-State: AOJu0YwP7edwXgtFicdUYwAP//nDHWQu2b4fWGAECHMMlDz5Y5pMEMkR
 t+CXX5xs3QWazndJPfRMNKzGLdsiVpEioa38dnl0YN+3BjrtQw283mDtFnB8N+5XIpSHFnuP2qv
 QGl5fU0U=
X-Gm-Gg: ASbGncszff6eG7kgnJGLQzmxeESI4u8t2wsgjrSn6Ay552c5QhvZB8D89goo3h4hUJz
 x/qXOM7qAKqlCO42fjRBa0bGf/UziCfIbHFZvEFSVpUx8KRS27u80bkoBWZb+6yO9AsLultDfif
 Jwh5+wcvQjUqMGWRrvhK5wWy9f/s9vbwoQqOrzXqPXqZsy21D0tRj6neDqSq0Fj2Jvf8LHr/2am
 sy370RBhEKzRAT1TZ0lNshbq/BAZzYvP9BF6+EKxE3CI5jtLp2bkjoST2s/TgIGLEdCCgS9KrfW
 5ILjZsnLk/KcfnLWrMo05zvhhi/qJcJkI+F7py6806bfRmQtWcoRT07F6IdwLRnmlrx77yQKl8u
 3gsVH+sDT6Xz2XfCiEPTbbjUsGW6DVrOoRBPHqobxN4yb4D75H/JnYzsUVoBSCci43RdBYBEt2T
 vVCbB1sqY=
X-Google-Smtp-Source: AGHT+IFDKvWUdhvzxRBSSCQFUm+OKb8S9I7B5b7svUADctGRlJfjhaWOqI44xAp1wp0M5PBstYLisg==
X-Received: by 2002:a05:6871:2317:b0:30b:7d90:1061 with SMTP id
 586e51a60fabf-39b8fbbb5c9mr3364115fac.4.1759350648113; 
 Wed, 01 Oct 2025 13:30:48 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf43028b6asm116395a34.26.2025.10.01.13.30.46
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] video: Only build bridge code for the appropriate phase
Date: Wed,  1 Oct 2025 14:30:46 -0600
Message-ID: <20251001203046.2828415-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

At this time, we can't make use of the video bridge code in xPL, and
there is no symbol to enable it. Start by only descending to this
directory when support in the future is enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/video/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 984768ea156d..81164fea40cd 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -90,6 +90,6 @@ obj-$(CONFIG_VIDEO_VESA) += vesa.o
 obj-$(CONFIG_VIDEO_SEPS525) += seps525.o
 obj-$(CONFIG_VIDEO_ZYNQMP_DPSUB) += zynqmp/
 
-obj-y += bridge/
+obj-$(CONFIG_$(PHASE_)VIDEO_BRIDGE) += bridge/
 obj-y += sunxi/
 obj-y += tegra/
-- 
2.43.0

