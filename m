Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA85EE49AC
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A59F87086;
	Mon, 21 Aug 2023 15:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BdIntNrw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C3FD867A0; Mon, 21 Aug 2023 15:51:39 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546E686F0A
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31c3df710bdso1066363f8f.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692625895; x=1693230695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfyiNp4RS7b8BQCxsUs1afKXNK4WMu1bUdXxDQXJn1U=;
 b=BdIntNrw+JbVTri7AodJPuA4KoTwuid2ByavDMP+gEZwSfMkjrlWlFROWNdM4E2KeC
 btsSXcPQO3jMnyoxVbS5g4DL2PkXPHNZO/Lw5Db4La4RGjoB4ks8w4G1nQ5kVo8NIXlQ
 7da1BVmm9tlV2cmt2LVuLp3WDWvgE5vJ9kVj8BH8fjD+gKc5wVOKtRIPJnqL8Eqj55A5
 y8xjVcW5ldxVps2jj0kE7Mq8LG2R6Bd37Zsw+Dq3Cj/1khMgLkYog8/Nf+k2uYXPQpjA
 TS03XR6eJ7GQcRUf0iWft80hVZMVk6KF2AWuF04HcJ/goyNj4MGGFun0tanDYNImJzv0
 A/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692625895; x=1693230695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rfyiNp4RS7b8BQCxsUs1afKXNK4WMu1bUdXxDQXJn1U=;
 b=N71LYmMnxX45xKNJxNk72goiD3Cf5e0f3znUaZ/B4Ue95/rqpwn6vLQvhNkxjyJjKz
 QxOUGBKeP4pdGPJD2eVZgEA1+8cyBu3q0BssvtHzLuXCZtgGmVE+jhS1ZplzCePV5HDq
 cpjabmm8tLydQpgXN42bXGeg5S7C2hbuWb9P1yFz0T2VRKDhKfnBacDMMyCM77q885Xq
 scmyG9QS6JjzzhlNCx2LAvunQyb5Ub3Jeac6w62kdW5d82X5hQ7R5IuMhO6HB9cXSoIL
 q4cciYJYPkkgJo7cJBCGs9hpoG7mAiYugMX3xvTX0AozIxV+I0RqRnIaeK4YPRctAqDa
 B+ZQ==
X-Gm-Message-State: AOJu0Yzo17fP4SdOljTzWNaDUk2p0KMalzHe92zD3l/uyJxeFYnVtZ6Z
 JKO6vwp7AEEfITHacMlSfDnu20sRQPA=
X-Google-Smtp-Source: AGHT+IEaweUWG6MdegfaF+T8dg4D4mXuTL2UTLikuqRhtfAyLWNc6xApEfO0HHPUExbseBScRw20SA==
X-Received: by 2002:a5d:44d1:0:b0:313:f94f:3b15 with SMTP id
 z17-20020a5d44d1000000b00313f94f3b15mr5140696wrr.2.1692625894567; 
 Mon, 21 Aug 2023 06:51:34 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 r11-20020a5d4e4b000000b00317b063590fsm12600049wrt.55.2023.08.21.06.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 06:51:34 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Andrew Davis <afd@ti.com>,
 Da Xue <da@libre.computer>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Derald Woods <woods.technical@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 uboot-stm32@st-md-mailman.stormreply.com, Simon Glass <sjg@chromium.org>,
 Matthias Brugger <mbrugger@suse.com>, u-boot-amlogic@groups.io,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v5 05/13] dm: video: Add damage notification on display fills
Date: Mon, 21 Aug 2023 16:51:02 +0300
Message-Id: <20230821135111.3558478-6-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
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

From: Alexander Graf <agraf@csgraf.de>

Let's report the video damage when we fill parts of the screen. This
way we can later lazily flush only relevant regions to hardware.

Signed-off-by: Alexander Graf <agraf@csgraf.de>
Reported-by: Da Xue <da@libre.computer>
[Alper: Call video_damage() in video_fill_part(), edit commit message]
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
Does video_fill_part() need a video_sync(dev, false) here?

Changes in v5:
- Call video_damage() also in video_fill_part()

 drivers/video/video-uclass.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 447689581668..ebf409d839f0 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -203,6 +203,8 @@ int video_fill_part(struct udevice *dev, int xstart, int ystart, int xend,
 	if (ret)
 		return ret;
 
+	video_damage(dev, xstart, ystart, xend - xstart, yend - ystart);
+
 	return 0;
 }
 
@@ -249,6 +251,8 @@ int video_fill(struct udevice *dev, u32 colour)
 	if (ret)
 		return ret;
 
+	video_damage(dev, 0, 0, priv->xsize, priv->ysize);
+
 	return video_sync(dev, false);
 }
 
-- 
2.40.1

