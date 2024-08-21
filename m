Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E16C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDC6C88BFA;
	Wed, 21 Aug 2024 18:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JLMVGOzV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C764488E15; Wed, 21 Aug 2024 18:19:41 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B39988D9B
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-70943b07c2cso3863125a34.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257178; x=1724861978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYxZARxVNjL917E+Z5GGoPmtN0HaCSv/gBB6KMGbd3g=;
 b=JLMVGOzVgOJR75vepXem1EMDXr4qDWU944YQZZnlVv3IxhDKHsLJ2B/8A8V4CVXwxB
 7xIjhbMueRnSxziKyWhfWj0QZtmlLmEvrhwz56u3sQ7X8sVMAqsoAVt02ykNOE5rr7ev
 C22sAomrTCA9iXO7I80hRB3dCYaM9zOb8cfEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257178; x=1724861978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYxZARxVNjL917E+Z5GGoPmtN0HaCSv/gBB6KMGbd3g=;
 b=CnshS9hc8sI8cuMh/CNisMume4aUB5Fv1VCUqg4k+agVBxIXvs8Co83+fB7OHn3Cp1
 Pekk1aYHEjTBx5SLJpdKTVUF7gGu+H7ezdqzDsQEWMCHcfDKsMV0n4Hiqhhv0U3bWEcv
 RXQnBs8vRNEpFzlXmD6Z5mmqKsYK7hiDT1ZKXfvfyw0AOmIEpkoJOkzL1Xr1HByVcXcV
 d0qHS76NRvDNUQez0p3t5BOkn0qeYPCqca9uYYzqeQ4jcDBsIZ8sOQorbN4KGXQesLZ6
 9Ud4flcz618eonqozM5xulmRaACfNO6od7vFvymN2ECSixGRAP7e/fVCpAk1KOlizrBd
 q8Tw==
X-Gm-Message-State: AOJu0YxxDS9y6JKIblZZD5mj1oTsJQ/4hGxs73PxqvoFCk9T3rP594In
 +d+tal3oS6SEEhOosO9ArBLoGbLSLgcgKaV5rqlGDjOdNdQwsc44T3eQpb+g7g63eSLER0j4BAY
 =
X-Google-Smtp-Source: AGHT+IEF27nohzPFuGTB7N/xHQXDSVITyhoohRGxxy84QCyn2Foeghgqalho6ajFU8ll6BH5qS3ZXg==
X-Received: by 2002:a05:6830:2586:b0:709:41c2:5104 with SMTP id
 46e09a7af769-70df85fd28dmr2883101a34.8.1724257178261; 
 Wed, 21 Aug 2024 09:19:38 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 03/35] video: Add a function to obtain the framebuffer
 address
Date: Wed, 21 Aug 2024 10:18:55 -0600
Message-Id: <20240821161927.695717-4-sjg@chromium.org>
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

Add a new function which returns the framebuffer address of the first
video device. This will allow the global_data field top be dropped.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/video-uclass.c | 14 ++++++++++++++
 include/video.h              | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index a5aa8dd5295..e358a7949e0 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -152,6 +152,20 @@ int video_reserve(ulong *addrp)
 	return 0;
 }
 
+ulong video_get_fb(void)
+{
+	struct udevice *dev;
+
+	uclass_find_first_device(UCLASS_VIDEO, &dev);
+	if (dev) {
+		const struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+
+		return uc_plat->base;
+	}
+
+	return 0;
+}
+
 int video_fill_part(struct udevice *dev, int xstart, int ystart, int xend,
 		    int yend, u32 colour)
 {
diff --git a/include/video.h b/include/video.h
index 4013a949983..606c8a37fb8 100644
--- a/include/video.h
+++ b/include/video.h
@@ -420,4 +420,15 @@ int bmp_info(ulong addr);
  */
 int video_reserve_from_bloblist(struct video_handoff *ho);
 
+/**
+ * video_get_fb() - Get the first framebuffer address
+ *
+ * This function does not probe video devices, so can only be used after a video
+ * device has been activated.
+ *
+ * Return: address of the framebuffer of the first video device found, or 0 if
+ * there is no device
+ */
+ulong video_get_fb(void);
+
 #endif
-- 
2.34.1

