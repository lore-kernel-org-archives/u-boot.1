Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8EDEE49AC
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2380887084;
	Mon, 21 Aug 2023 15:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i+1wSJUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2081087081; Mon, 21 Aug 2023 15:51:43 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45F8E8707A
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fee600dce6so18065515e9.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 06:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692625900; x=1693230700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=du9K8HAMfjDBv9t9zq9p8Zs+vCZHJ6g2zmB7iSzSF7o=;
 b=i+1wSJUCYpv3D2Y4WhFT+a+eXACMjCfu9K5FQkWQdC2smyIukzPLOT9TKll1BIlZ+S
 0BSrF+Vp8/DGT40HSh+wXWV4jYRbGaai6uC9HETzas7pJ6Qhy+ffz2UKdEYLi1VLHsaq
 X75Z5dWmXphu9f83rAKezE9CYHm+PJtfCCmN6nzYmKby9xzdvEmPjC4JmCjqvh+sqORE
 Bzxq55zbOUyTxIzqT01tuFNOw/v8W0H5dQ6fFOCzvxrMmYV1xWY68YL/0QqfqG2DG5q1
 XPDS0Sgg6L+yzBD2e/I0iNDZaFfXRDq4jvWBkELBWMrWm1880C9/qHFlPwFRRUlHYf+M
 4DSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692625900; x=1693230700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=du9K8HAMfjDBv9t9zq9p8Zs+vCZHJ6g2zmB7iSzSF7o=;
 b=ejVU1hfEMyFZ7BfMSqaYec4EUOoA0M467Rm/YLD9WqMi6MKcePqHndqYIVtBdIb8pl
 jE/EUHhBvvRp1Bn9zpDfUbCUk27iKZaqWwqAa4ZLknDsCStzGovzG2+wKem8yoP2H1jp
 e5tUVYZa2/MESz/zDnwWZV528p3+eHhCUUWBwTCt3plzb+SWqR1j0T40nBrUB+tDj1b0
 VYDTZvDCxDhQRGlLmMYX8QtWf/waAzPl5ePXvPhus06aR5+7O2V28M8yF2xRcceFSIQR
 4T2k/MBwCdM1+mpz6TnKB+zjN6Kj0TmPzEo9o6Pcc/lXWY0kRniuHFu0fzE84gOcGlOi
 Xfyw==
X-Gm-Message-State: AOJu0YxMuk5t4Hh2FasrdRfRr0tLxX8vAgGS5cfNm5tZpbvKz9V6ip/a
 g8C3FsqqNAKybynks3ECaaBXn+kLAr4=
X-Google-Smtp-Source: AGHT+IE0aHC9IeAZ9om6v+CX5lhGhaikzyvs7K+JjasiPPxFotFPaEOG+0SHfy/L4wW7iRlvWFh0mw==
X-Received: by 2002:a5d:568f:0:b0:317:e5ec:8767 with SMTP id
 f15-20020a5d568f000000b00317e5ec8767mr4615501wrv.21.1692625899711; 
 Mon, 21 Aug 2023 06:51:39 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 r11-20020a5d4e4b000000b00317b063590fsm12600049wrt.55.2023.08.21.06.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 06:51:39 -0700 (PDT)
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
Subject: [PATCH v5 07/13] video: test: Test video damage tracking via
 vidconsole
Date: Mon, 21 Aug 2023 16:51:04 +0300
Message-Id: <20230821135111.3558478-8-alpernebiyasak@gmail.com>
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

With VIDEO_DAMAGE, the video uclass tracks updated regions of the frame
buffer in order to avoid unnecessary work during a video sync. Enable
the config in sandbox and add a test for it, by printing strings at a
few locations and checking the tracked region.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
This is hard to test because most things issue video syncs that process
and reset the damaged region.

Changes in v5:
- Add patch "video: test: Test video damage tracking via vidconsole"

 configs/sandbox_defconfig |  1 +
 test/dm/video.c           | 56 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 259f31f26cee..51b820f13121 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -307,6 +307,7 @@ CONFIG_USB_ETH_CDC=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_FONT_SUN12X22=y
 CONFIG_VIDEO_COPY=y
+CONFIG_VIDEO_DAMAGE=y
 CONFIG_CONSOLE_ROTATION=y
 CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_CONSOLE_TRUETYPE_CANTORAONE=y
diff --git a/test/dm/video.c b/test/dm/video.c
index e4bd27a6b76f..8c7d9800a42e 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -711,3 +711,59 @@ static int dm_test_video_copy(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_video_copy, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+
+/* Test video damage tracking */
+static int dm_test_video_damage(struct unit_test_state *uts)
+{
+	struct sandbox_sdl_plat *plat;
+	struct udevice *dev, *con;
+	struct video_priv *priv;
+	const char *test_string_1 = "Criticism may not be agreeable, ";
+	const char *test_string_2 = "but it is necessary.";
+	const char *test_string_3 = "It fulfils the same function as pain in the human body.";
+
+	if (!IS_ENABLED(CONFIG_VIDEO_DAMAGE))
+		return -EAGAIN;
+
+	ut_assertok(uclass_find_device(UCLASS_VIDEO, 0, &dev));
+	ut_assert(!device_active(dev));
+	plat = dev_get_plat(dev);
+	plat->font_size = 32;
+
+	ut_assertok(video_get_nologo(uts, &dev));
+	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
+	priv = dev_get_uclass_priv(dev);
+
+	vidconsole_position_cursor(con, 14, 10);
+	vidconsole_put_string(con, test_string_2);
+	ut_asserteq(449, priv->damage.xstart);
+	ut_asserteq(325, priv->damage.ystart);
+	ut_asserteq(661, priv->damage.xend);
+	ut_asserteq(350, priv->damage.yend);
+
+	vidconsole_position_cursor(con, 7, 5);
+	vidconsole_put_string(con, test_string_1);
+	ut_asserteq(225, priv->damage.xstart);
+	ut_asserteq(164, priv->damage.ystart);
+	ut_asserteq(661, priv->damage.xend);
+	ut_asserteq(350, priv->damage.yend);
+
+	vidconsole_position_cursor(con, 21, 15);
+	vidconsole_put_string(con, test_string_3);
+	ut_asserteq(225, priv->damage.xstart);
+	ut_asserteq(164, priv->damage.ystart);
+	ut_asserteq(1280, priv->damage.xend);
+	ut_asserteq(510, priv->damage.yend);
+
+	video_sync(dev, false);
+	ut_asserteq(priv->xsize, priv->damage.xstart);
+	ut_asserteq(priv->ysize, priv->damage.ystart);
+	ut_asserteq(0, priv->damage.xend);
+	ut_asserteq(0, priv->damage.yend);
+
+	ut_asserteq(7339, compress_frame_buffer(uts, dev, false));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
+
+	return 0;
+}
+DM_TEST(dm_test_video_damage, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
-- 
2.40.1

