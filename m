Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D5CEE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C3A87091;
	Mon, 21 Aug 2023 15:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SJ3CoTwS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C6786F0A; Mon, 21 Aug 2023 15:51:50 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F3B86E80
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31aeef88a55so1551204f8f.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692625907; x=1693230707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/DCoXVnGlEMqWseytQAYuhC9MvrFlVv7QEu+lzOB9U=;
 b=SJ3CoTwShv0m1a2l77IYGRiPJhE773qxJozbJ8TLkbWb/Fs3vzMjaetMjO1LteCIix
 nxWVY9KC93yaMYqJT6SqYWKi1BaFToYnd6muvummJcQpRouAllJWg2nVkF0e6rb8GdHn
 kEvHDvCo4Xq4Lrpvs6/W0ONesn+kGcCJbX3+BARXOoTD87bHAQpb5gcTr6FjYwUraYf/
 31t1qEak7+tRD5cuPx0ItVaX8KSHeAMuueL0gEw6Wt64zNUyAO7W7cCRNJFMIsBkB2Lw
 IOsoOk7kBgIqU/InShFLnIoLlW9EafAood5bDff+/ADKYaXgkgxpBbWQWgtF6tmmvjGO
 gfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692625907; x=1693230707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/DCoXVnGlEMqWseytQAYuhC9MvrFlVv7QEu+lzOB9U=;
 b=Tx8Anl+tKgGLw4YpMhb5VbWFhDaaZ7izCBtT/Mun3zxxONGjrw/1uYrQVf/HxeEzcw
 0VQqKGIC9Kek3RaHw20BGPdbmmDTmaVo3IGNrikhp2qDmM0bBH2AVbn0K5MV5t9dwKsA
 U5D/cFon6pqj8sco6Dd5oVBskjrgqlgNtd3HXzCrfuFmFtsXxecVmlgKOnnE8Kj+CGGI
 D2EMM/0yQCq/vuxC4/ISIiaRk0/6GCX55V8DYg+claM+h691kk/LGeEGXJqs5X1wFGQU
 EZeKiKrY2VvqZ7yOXoriyel6QE7BvHmCmurDC+oji/do1hnGp/6NPxPFV/ABKsRmjPGY
 V6Eg==
X-Gm-Message-State: AOJu0YxqpYt8rTBNvBZ9hiz/qYI+xhkc2uURaJNeyYssFbd+tACGWJtX
 6fE/7qVWobRKTs1ZWXtn3qcomaeF/nc=
X-Google-Smtp-Source: AGHT+IHlrJ5IlwhVESQ4N6S+FeCJPNau4Ry7TWJN4H6yUmdpI19HJsGEPwtYtoPvcLuI4yNltjc9CQ==
X-Received: by 2002:a5d:4483:0:b0:317:dada:2417 with SMTP id
 j3-20020a5d4483000000b00317dada2417mr4326536wrq.31.1692625907186; 
 Mon, 21 Aug 2023 06:51:47 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 r11-20020a5d4e4b000000b00317b063590fsm12600049wrt.55.2023.08.21.06.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 06:51:46 -0700 (PDT)
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
Subject: [PATCH v5 10/13] video: Only dcache flush damaged lines
Date: Mon, 21 Aug 2023 16:51:07 +0300
Message-Id: <20230821135111.3558478-11-alpernebiyasak@gmail.com>
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

Now that we have a damage area tells us which parts of the frame buffer
actually need updating, let's only dcache flush those on video_sync()
calls. With this optimization in place, frame buffer updates - especially
on large screen such as 4k displays - speed up significantly.

Signed-off-by: Alexander Graf <agraf@csgraf.de>
Reported-by: Da Xue <da@libre.computer>
[Alper: Use damage.xstart/yend, IS_ENABLED()]
Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v5:
- Use xstart, ystart, xend, yend as names for damage region
- Use IS_ENABLED() instead of CONFIG_IS_ENABLED()

Changes in v2:
- Fix dcache range; we were flushing too much before
- Remove ifdefs

 drivers/video/video-uclass.c | 41 +++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 8bfcbc88dda7..a50220bcc684 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -385,6 +385,41 @@ void video_damage(struct udevice *vid, int x, int y, int width, int height)
 	priv->damage.yend = max(yend, priv->damage.yend);
 }
 
+#if defined(CONFIG_ARM) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
+static void video_flush_dcache(struct udevice *vid)
+{
+	struct video_priv *priv = dev_get_uclass_priv(vid);
+
+	if (!priv->flush_dcache)
+		return;
+
+	if (!IS_ENABLED(CONFIG_VIDEO_DAMAGE)) {
+		flush_dcache_range((ulong)priv->fb,
+				   ALIGN((ulong)priv->fb + priv->fb_size,
+					 CONFIG_SYS_CACHELINE_SIZE));
+
+		return;
+	}
+
+	if (priv->damage.xend && priv->damage.yend) {
+		int lstart = priv->damage.xstart * VNBYTES(priv->bpix);
+		int lend = priv->damage.xend * VNBYTES(priv->bpix);
+		int y;
+
+		for (y = priv->damage.ystart; y < priv->damage.yend; y++) {
+			ulong fb = (ulong)priv->fb;
+			ulong start = fb + (y * priv->line_length) + lstart;
+			ulong end = start + lend - lstart;
+
+			start = ALIGN_DOWN(start, CONFIG_SYS_CACHELINE_SIZE);
+			end = ALIGN(end, CONFIG_SYS_CACHELINE_SIZE);
+
+			flush_dcache_range(start, end);
+		}
+	}
+}
+#endif
+
 /* Flush video activity to the caches */
 int video_sync(struct udevice *vid, bool force)
 {
@@ -404,11 +439,7 @@ int video_sync(struct udevice *vid, bool force)
 	 * out whether it exists? For now, ARM is safe.
 	 */
 #if defined(CONFIG_ARM) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
-	if (priv->flush_dcache) {
-		flush_dcache_range((ulong)priv->fb,
-				   ALIGN((ulong)priv->fb + priv->fb_size,
-					 CONFIG_SYS_CACHELINE_SIZE));
-	}
+	video_flush_dcache(vid);
 #elif defined(CONFIG_VIDEO_SANDBOX_SDL)
 	static ulong last_sync;
 
-- 
2.40.1

