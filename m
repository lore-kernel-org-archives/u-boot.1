Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31A5C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DBAC88E18;
	Wed, 21 Aug 2024 18:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VAlHLllo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B1CE8811A; Wed, 21 Aug 2024 18:19:42 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F3088BFA
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7095bfd6346so4121508a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257179; x=1724861979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ont5n+HBPeqe602t4iRpZkS4y8Zw4yWb4IY57gAjKSA=;
 b=VAlHLllo8NWAlYDHJtA1+h9euEjFQAd6V+uOzseXlwXMVD3V97qKikf6ruSR6XIl4W
 rHj96bNAknZ+P3dhFpzBKAlTpiO62csTT2iD2l8I7TPMQAeb+8JdmXtJvWHj+OgPYznW
 pyqiHPV7yfU1BjwaVocgsPkseH4c7OOGggjUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257179; x=1724861979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ont5n+HBPeqe602t4iRpZkS4y8Zw4yWb4IY57gAjKSA=;
 b=QUKlgRYqgGF8eGyYY8oOOd1MUb3m1NiD4Z7X/YubZ8M4Ou5i5wGQ0K979KvTGvPqF8
 O4UFtvZsZqQlnF0QPro3DF0Rry+zeRf3WALxU4omw9PuhQVMpXmwvpfEvhr4LX+1SYB9
 ALrl80FOe2n4349VoEYJL2w3vrmxi+nTNUyvOI4kzBOuwoSQWKStVRqtfPX/pRSPbmRN
 C6cmdfEtoyZykgX02vzCFdAJSOJjqeO/JKveTGp3M+dxePBTRL8PHNccJXDSyXIGAwkL
 4KSLr5Hkp3mHDf7A71iBwJk35Yj0LEKKXv6+ihTmUtkg8aS+RWvfxGbd/GGFODmUA9vF
 ny2Q==
X-Gm-Message-State: AOJu0YwoNO/SATWPmlV9MSwuMwI45qRkxzymYiZK0r4CsfcO26XPmZrH
 W0TxVMfD1jdAkHrq/DBwPALwob6i04Ux5NkCGzB1R3PQEzmn6Wf0AJcHmhbza0kHIh6ekvIeRJk
 =
X-Google-Smtp-Source: AGHT+IFphYzp+fzykoM5dHHGhKBy11mWZmbOKPgegKBPVN992XW7aZCasyHgU6Gfh+nSGMhgo81Nlw==
X-Received: by 2002:a05:6830:3114:b0:70c:a547:1c43 with SMTP id
 46e09a7af769-70df85f9d2cmr2979870a34.9.1724257179036; 
 Wed, 21 Aug 2024 09:19:39 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 04/35] video: mxc: Avoid setting global_data fb_base
Date: Wed, 21 Aug 2024 10:18:56 -0600
Message-Id: <20240821161927.695717-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

This is not used, so don't set it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/imx/mxc_ipuv3_fb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/imx/mxc_ipuv3_fb.c b/drivers/video/imx/mxc_ipuv3_fb.c
index 039b22086a9..fdeb3cabea7 100644
--- a/drivers/video/imx/mxc_ipuv3_fb.c
+++ b/drivers/video/imx/mxc_ipuv3_fb.c
@@ -403,7 +403,6 @@ static int mxcfb_map_video_memory(struct fb_info *fbi)
 		(uint32_t) fbi->fix.smem_start, fbi->fix.smem_len);
 
 	fbi->screen_size = fbi->fix.smem_len;
-	gd->fb_base = fbi->fix.smem_start;
 
 	/* Clear the screen */
 	memset((char *)fbi->screen_base, 0, fbi->fix.smem_len);
@@ -633,7 +632,6 @@ static int ipuv3_video_probe(struct udevice *dev)
 	mmu_set_region_dcache_behaviour(fb_start, fb_end - fb_start,
 					DCACHE_WRITEBACK);
 	video_set_flush_dcache(dev, true);
-	gd->fb_base = fb_start;
 
 	return 0;
 }
-- 
2.34.1

