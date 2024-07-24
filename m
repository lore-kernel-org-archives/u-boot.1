Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AAEC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65DAA8898A;
	Wed, 24 Jul 2024 17:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jcOsL6uI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14A3C8896F; Wed, 24 Jul 2024 17:09:43 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 809058897A
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-396ce435923so3223765ab.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833779; x=1722438579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/NHRnTr81ESdc73IYY0ypZPXqi+/NQVZ25bFqd0Y0w=;
 b=jcOsL6uInr705c8CB/Su/FHNrynW4dr/egM0EG1WzJcy4QKBPwI7LpMyqFww0RfpP1
 R/mAs2Fiz5dYP0BgspMtikX4IwQa5DNVcBgLdjPik7fUhcuuOwUeDlGEQjIrjjR9sl7e
 XKxbHumrht6fl4zmXO8E9qH6UBRTtT+YNeU2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833779; x=1722438579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G/NHRnTr81ESdc73IYY0ypZPXqi+/NQVZ25bFqd0Y0w=;
 b=sxt887oMavZpafDBU0x4D2yVx5WF91FmHqvS44w8+iIpPuxhL5N0NNL4iichuJaGTx
 HeSwbSzOE5PwoBFyOsND6v6WlKvcW9nQ6A3mZiCJAF36eelnkko/xnoa53HruO+JEv7v
 OPFzLbroWWyyTri+gfSa+t2wjsnmKw8tHJ5Ract5RWq2KqqDAl1X/fp8a3eKCuAiDg3y
 flNIp1dXMnxDqOHfq1HQ754zesiMVH5WYsqRrSlsa+m2C2WCFU5525VAJJc3e0SQEfaP
 ww93zuZRer6mPiNj2IGWvB1UPW4jBH1upkWX4wm2qM0fmyGmoK18jVRa03jpB3LxA/l9
 dg1w==
X-Gm-Message-State: AOJu0YynJQDdmPuSquopgn7/NEeUuSOEyf+YCUqxme7mYN/XlwXHcaBM
 kD2W3vk+p6UOnw5atw+xxZDSvCofNmFzDoluavW0jH3daEymplx/fe73WAFMGVk9pGGWw6+0vgo
 =
X-Google-Smtp-Source: AGHT+IFvgRm4DoHSjZFaNiXWBkctuj/aHb8f0dZr365c8fIeqoU6wBoBegJ4BQPL8WxoA579/kS23g==
X-Received: by 2002:a05:6e02:1649:b0:396:3d2c:28e9 with SMTP id
 e9e14a558f8ab-39a1a7bfbf1mr14828425ab.14.1721833779000; 
 Wed, 24 Jul 2024 08:09:39 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 03/35] video: Add a function to obtain the framebuffer address
Date: Wed, 24 Jul 2024 09:08:50 -0600
Message-Id: <20240724150922.2343249-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

 drivers/video/video-uclass.c | 14 ++++++++++++++
 include/video.h              | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index ff1382f4a43..cb3144f68e0 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -146,6 +146,20 @@ int video_reserve(ulong *addrp)
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
index 4d8df9baaad..ab3a7ff4930 100644
--- a/include/video.h
+++ b/include/video.h
@@ -418,4 +418,15 @@ int bmp_info(ulong addr);
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

