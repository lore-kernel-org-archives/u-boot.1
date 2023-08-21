Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352CEEE49A6
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 909B287075;
	Mon, 21 Aug 2023 15:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q9fX66MT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 801C187082; Mon, 21 Aug 2023 15:51:55 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D67548709E
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-317716a4622so3055294f8f.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 06:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692625912; x=1693230712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pB2qI48avq9qUXnFEl+wSnmS8SG0cxx3SZjicfp6H7M=;
 b=Q9fX66MTTcUQaIK9Ypbt13c6159mxahNRVYZb/qRcTZRgB9DWf7SyL5B6iwaerzl6H
 V/NgeKQknUqjdF1rx5cN+0oUlRjL/uqf2PRT1u/2iPSTrLx9ImfxO59U1v7bkAyqsRHD
 9d/OLcbkmN2dqLKXGEJEhw9wRWn6PflMZfMjZfJ6PgDh1lldO8RAGdA+f9Wv0Uqs/CHY
 M6HHFEIenHnWt15i3RWPMrP09rbx4OkOqYNXz1V/3BWUxb3tRe+1IqwA2n/oEpR5c0PM
 YcGRP1tNM3yqfxG53IdsPPiujOtSHSbvtWSyefvk7z3wSlVPYMzicea8BirSi8/Ag/R0
 CJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692625912; x=1693230712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pB2qI48avq9qUXnFEl+wSnmS8SG0cxx3SZjicfp6H7M=;
 b=L5dQ5I1/r76Ec7WfGFYq1iqhI4RaRdXt+61BNvttoSzkuI28cDeE9IYg5h41YdBzNd
 t6sNriBN4Qc+mGdOBHQb7hoI62tzka68Qd18eexmWznS1lz73CJWNA6nW0T2heZpmRnx
 frQSxlPNxv5FZ2eXSdZLRIhWG0T0L+B+G/6B665+1/N1tvTFCLsToL2GaiGnEskSn3rJ
 wQPY7b2lG/xkfWZiNERig8/6ZMW5R3QQDdOucA/FVYuHY4/dr+9UuPEHaimYzTwzN6AM
 aehqXj0h7YO8NjF9HG1n1T4hEYq0FKqbcb2t+hLAUBpzGBjLNrpCdWa9LzQWN0EEJw8H
 /ijQ==
X-Gm-Message-State: AOJu0YwwdmeqIA0FUSFZkbrYH8d4F3YWnny6MkSqZvX6DQEtu9Y/TVK7
 x418Ed0mXh7BUNyNIuPNquOOpbM3J+o=
X-Google-Smtp-Source: AGHT+IFpiAY2BjXpJaKJJodzwN7aKj9YFF3eAkfmZgRFnB94o3W7mQtEZgXERHeKNVbIpRB5HlMypw==
X-Received: by 2002:a05:6000:1205:b0:31c:4f80:9f7 with SMTP id
 e5-20020a056000120500b0031c4f8009f7mr1593479wrx.45.1692625912317; 
 Mon, 21 Aug 2023 06:51:52 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 r11-20020a5d4e4b000000b00317b063590fsm12600049wrt.55.2023.08.21.06.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 06:51:51 -0700 (PDT)
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
Subject: [PATCH v5 12/13] video: Always compile cache flushing code
Date: Mon, 21 Aug 2023 16:51:09 +0300
Message-Id: <20230821135111.3558478-13-alpernebiyasak@gmail.com>
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

The dcache flushing code path was conditional on ARM && !DCACHE config
options. However, dcaches exist on other platforms as well and may need
clearing if their driver requires it.

Simplify the compile logic and always enable the dcache flush logic in
the video core. That way, drivers can always rely on it to call the arch
specific callbacks.

This will increase code size for non-ARM platforms with CONFIG_VIDEO=y
slightly.

Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Alexander Graf <agraf@csgraf.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

(no changes since v4)

Changes in v4:
- Add patch "video: Always compile cache flushing code"

 drivers/video/video-uclass.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index c79499252a22..3f9ddaadd15d 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -377,11 +377,13 @@ void video_damage(struct udevice *vid, int x, int y, int width, int height)
 	priv->damage.yend = max(yend, priv->damage.yend);
 }
 
-#if defined(CONFIG_ARM) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
 static void video_flush_dcache(struct udevice *vid)
 {
 	struct video_priv *priv = dev_get_uclass_priv(vid);
 
+	if (CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		return;
+
 	if (!priv->flush_dcache)
 		return;
 
@@ -410,7 +412,6 @@ static void video_flush_dcache(struct udevice *vid)
 		}
 	}
 }
-#endif
 
 static void video_flush_copy(struct udevice *vid)
 {
@@ -449,14 +450,9 @@ int video_sync(struct udevice *vid, bool force)
 			return ret;
 	}
 
-	/*
-	 * flush_dcache_range() is declared in common.h but it seems that some
-	 * architectures do not actually implement it. Is there a way to find
-	 * out whether it exists? For now, ARM is safe.
-	 */
-#if defined(CONFIG_ARM) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
 	video_flush_dcache(vid);
-#elif defined(CONFIG_VIDEO_SANDBOX_SDL)
+
+#if defined(CONFIG_VIDEO_SANDBOX_SDL)
 	static ulong last_sync;
 
 	if (force || get_timer(last_sync) > 100) {
-- 
2.40.1

