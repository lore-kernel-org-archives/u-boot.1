Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAA6EE49AA
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F40E487071;
	Mon, 21 Aug 2023 15:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h0nfUUKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFD6D87069; Mon, 21 Aug 2023 15:51:32 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0028587074
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-319779f0347so2987491f8f.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 06:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692625889; x=1693230689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ls20OKhVk8mknnS6GLFBhmTjxLz0/7fKNgK2nzSEs6M=;
 b=h0nfUUKHqteSaQqflnkXT9zc90H1nKLTOoG4B78CtKhSKUI/thuMDU61AtN+enWvFJ
 MdvU9OW3jOHeg+LRrxur+6+N4V9k4nGhm2BGwtj56A1DDfCLgk5+Vg38dhi1a24kfBH9
 d5w6HXOg3wdMizdTsyL0PbugSX7K9ByL9XKpH646NdsnqcikQNdmT2OeiGAmonEmHXAa
 FII1SypkiZ5TOFcJx9N4X2XqMM3CNxyUsDs6+AV4dTPnjtXaElWj1fQcz8bLn/9q88/X
 UCvE35N4Y37FFgb+5uTi+00hcLIavYKYrLEpNAclnl9NKFSUAUJyabqQM0+riy1OSMHF
 5YBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692625889; x=1693230689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ls20OKhVk8mknnS6GLFBhmTjxLz0/7fKNgK2nzSEs6M=;
 b=Gmm/6GKzL921nU50fcXK4FdwCaAc1DVbDj7ilfjHfBXRaw/k3mmUZ/l5nbwGsTUYUU
 VX6nd+xFgekVSP5Cns7th6+jnbBBaoaCZUfZYGIhQjEH3JMxxpo17+eNdfCTuo7TjTdl
 MtWwxmceukhRiNql2W7VOHfb5CXBxorcXXcy3szcEJOlzxIqqUDQcLjNgoe5d2Kpkv9Y
 6qkNp6XFyfQCMAMGjF68T5eViaLcvFHFIsvmjXlMU7Ohhhm2We4SK9nBsr6gUgyaxmNs
 qBLKVZKf+iC9WptVFbXhAML6gJZJo+JQu/tGHHfLf7rm/WT+1VhmDKBgpU1CzA8BRqcG
 t+og==
X-Gm-Message-State: AOJu0YxCm+p57uF96KzOW9kggq2KLZimSeriKFH9gpv8fgoy+ddR1X7S
 9HsUigoZFUND3/u7rp+XB9qHn3dcZTU=
X-Google-Smtp-Source: AGHT+IEwSW6rIF+3ua5ruA0V/p8R0SXlrxBIJRwdiP9dn7nhkL8gMfhxYppZ2c8jWSzauubY8xUVnQ==
X-Received: by 2002:adf:e482:0:b0:31a:dc27:e10 with SMTP id
 i2-20020adfe482000000b0031adc270e10mr4721868wrm.65.1692625889315; 
 Mon, 21 Aug 2023 06:51:29 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 r11-20020a5d4e4b000000b00317b063590fsm12600049wrt.55.2023.08.21.06.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 06:51:28 -0700 (PDT)
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
Subject: [PATCH v5 03/13] video: test: Test partial updates of hardware frame
 buffer
Date: Mon, 21 Aug 2023 16:51:00 +0300
Message-Id: <20230821135111.3558478-4-alpernebiyasak@gmail.com>
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

With VIDEO_COPY enabled, only the modified parts of the frame buffer are
intended to be copied to the hardware. Add a test that checks this, by
overwriting contents we prepared without telling the video uclass and
then checking if the overwritten contents have been redrawn on the next
sync.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v5:
- Add patch "video: test: Test partial updates of hardware frame buffer"

 test/dm/video.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/test/dm/video.c b/test/dm/video.c
index b9ff3da10c18..e4bd27a6b76f 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -657,3 +657,57 @@ static int dm_test_video_truetype_bs(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_video_truetype_bs, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+
+/* Test partial rendering onto hardware frame buffer */
+static int dm_test_video_copy(struct unit_test_state *uts)
+{
+	struct sandbox_sdl_plat *plat;
+	struct video_uc_plat *uc_plat;
+	struct udevice *dev, *con;
+	struct video_priv *priv;
+	const char *test_string = "\n\tCriticism may not be agreeable, but it is necessary.\t";
+	ulong addr;
+
+	if (!IS_ENABLED(CONFIG_VIDEO_COPY))
+		return -EAGAIN;
+
+	ut_assertok(uclass_find_first_device(UCLASS_VIDEO, &dev));
+	ut_assertnonnull(dev);
+	uc_plat = dev_get_uclass_plat(dev);
+	uc_plat->hide_logo = true;
+	plat = dev_get_plat(dev);
+	plat->font_size = 32;
+	ut_assert(!device_active(dev));
+	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
+	ut_assertnonnull(dev);
+	priv = dev_get_uclass_priv(dev);
+
+	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
+	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
+
+	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
+	vidconsole_put_string(con, "\n\n\n\n\n");
+	vidconsole_put_string(con, test_string);
+	vidconsole_put_string(con, test_string);
+
+	ut_asserteq(6678, compress_frame_buffer(uts, dev, false));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
+
+	/*
+	 * Secretly clear the hardware frame buffer, but in a different
+	 * color (black) to see which parts will be overwritten.
+	 */
+	memset(priv->copy_fb, 0, priv->fb_size);
+
+	/*
+	 * We should have the full content on the main buffer, but only
+	 * the new content should have been copied to the copy buffer.
+	 */
+	vidconsole_put_string(con, test_string);
+	vidconsole_put_string(con, test_string);
+	ut_asserteq(7589, compress_frame_buffer(uts, dev, false));
+	ut_asserteq(5278, compress_frame_buffer(uts, dev, true));
+
+	return 0;
+}
+DM_TEST(dm_test_video_copy, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
-- 
2.40.1

