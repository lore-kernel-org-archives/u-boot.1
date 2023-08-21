Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB7DEE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D08B3867A0;
	Mon, 21 Aug 2023 15:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oaK1+upy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D15587084; Mon, 21 Aug 2023 15:51:40 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA4E1869B6
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-317f1c480eeso3049475f8f.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692625897; x=1693230697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yrfRyMChh1ygDQtR1jl9BYhd6F+V0coaR3saA65Ao8=;
 b=oaK1+upyGYfwOr4/nZR8RIRT+Yn2PZ+2dy2+GMSjffIkOUvAA4SwUrsuBUHVmQ+cIg
 Q0F+D60Mp5/MzkFm9rwAnrQpO2uJb9esI/U8crcERtM+p1p5iKU9VNHrwRjlzB4VfG3E
 1rFRNOOhGpyPBS6RY+cJD557cLeGMoVUsQbv3xfnShrQg142CAOgzdQ4AtJ3FYRDngOc
 QiczfO53zpeOnZjhBAa5aw7TDgIqHuR1bYCYIRraWJdIl9Cxa6ZDN1IozoPg6hutV+SE
 77oOM9VfIYyC8B3q6wdaduzcH0Qgeq3IEzfE54DLVtS/yT5z2vJiPtnfnV2pXzjU01Iq
 l7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692625897; x=1693230697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7yrfRyMChh1ygDQtR1jl9BYhd6F+V0coaR3saA65Ao8=;
 b=NgyE/5/ABpribqDY5ykRBi/ftUfa+3meGxemZJPAl2gCi2+PfUEbrdHMbSPz/8nbY9
 qS/5UPv+41yRmDLmqeaNK/RXif7qV+CdVrg4K7xD0x/HbezXsIvKSc6rs5IqPqQvp0lx
 JDuescRAcyrjtBjBFIAsrOx0+GynSijvWQArLcJRL330eiNnBn0HYRiVFqfEy3jpv5Hz
 13zk9q/GW8Hc7GRtA+FAkeUqJ3t8VaRzHLfoUJO3zFS8bWXgnWUAbCx0OOB9MahUqvyv
 s/jpw79ZhFlhzO/Nwa63SlfQi+T3dAiYQ3kpBDgz7YFjSxvYaFYJDW3ihVDv8VTIiLdl
 WB8Q==
X-Gm-Message-State: AOJu0YwqmT7iLKiUZblbrZz+UE4GebW514Sdllsg7NS//fk35AzXbHd7
 7wXdC1ugEQP9Gez3jIRiAyQs4cDTcVc=
X-Google-Smtp-Source: AGHT+IHO/arCmWeM8GYL18CXATu4Sh++TdyEswajL5QnvTaImLdSHvMUo+xc/gBkyHdBnNYS/qgvaQ==
X-Received: by 2002:adf:cd0b:0:b0:31c:3013:9fa5 with SMTP id
 w11-20020adfcd0b000000b0031c30139fa5mr3560706wrm.59.1692625897248; 
 Mon, 21 Aug 2023 06:51:37 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 r11-20020a5d4e4b000000b00317b063590fsm12600049wrt.55.2023.08.21.06.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 06:51:36 -0700 (PDT)
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
Subject: [PATCH v5 06/13] vidconsole: Add damage notifications to all
 vidconsole drivers
Date: Mon, 21 Aug 2023 16:51:03 +0300
Message-Id: <20230821135111.3558478-7-alpernebiyasak@gmail.com>
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

Now that we have a damage tracking API, let's populate damage done by
vidconsole drivers. We try to declare as little memory as damaged as
possible.

Signed-off-by: Alexander Graf <agraf@csgraf.de>
Reported-by: Da Xue <da@libre.computer>
[Alper: Rebase for met->baseline, fontdata->height/width, make rotated
        console_putc_xy() damages pass tests, edit patch message]
Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v5:
- Use met->baseline instead of priv->baseline
- Use fontdata->height/width instead of VIDEO_FONT_HEIGHT/WIDTH
- Update console_rotate.c video_damage() calls to pass video tests
- Remove mention about not having minimal damage for console_rotate.c

Changes in v2:
- Fix ranges in truetype target
- Limit rotate to necessary damage

 drivers/video/console_normal.c   | 18 +++++++++++
 drivers/video/console_rotate.c   | 54 ++++++++++++++++++++++++++++++++
 drivers/video/console_truetype.c | 21 +++++++++++++
 drivers/video/video-uclass.c     |  1 +
 4 files changed, 94 insertions(+)

diff --git a/drivers/video/console_normal.c b/drivers/video/console_normal.c
index 413c7abee9e1..a19ce6a2bc11 100644
--- a/drivers/video/console_normal.c
+++ b/drivers/video/console_normal.c
@@ -39,6 +39,12 @@ static int console_set_row(struct udevice *dev, uint row, int clr)
 	if (ret)
 		return ret;
 
+	video_damage(dev->parent,
+		     0,
+		     fontdata->height * row,
+		     vid_priv->xsize,
+		     fontdata->height);
+
 	return 0;
 }
 
@@ -60,6 +66,12 @@ static int console_move_rows(struct udevice *dev, uint rowdst,
 	if (ret)
 		return ret;
 
+	video_damage(dev->parent,
+		     0,
+		     fontdata->height * rowdst,
+		     vid_priv->xsize,
+		     fontdata->height * count);
+
 	return 0;
 }
 
@@ -90,6 +102,12 @@ static int console_putc_xy(struct udevice *dev, uint x_frac, uint y, char ch)
 	if (ret)
 		return ret;
 
+	video_damage(dev->parent,
+		     x,
+		     y,
+		     fontdata->width,
+		     fontdata->height);
+
 	ret = vidconsole_sync_copy(dev, start, line);
 	if (ret)
 		return ret;
diff --git a/drivers/video/console_rotate.c b/drivers/video/console_rotate.c
index 65358a1c6e74..6c3e7c1bb8dc 100644
--- a/drivers/video/console_rotate.c
+++ b/drivers/video/console_rotate.c
@@ -36,6 +36,12 @@ static int console_set_row_1(struct udevice *dev, uint row, int clr)
 	if (ret)
 		return ret;
 
+	video_damage(dev->parent,
+		     vid_priv->xsize - ((row + 1) * fontdata->height),
+		     0,
+		     fontdata->height,
+		     vid_priv->ysize);
+
 	return 0;
 }
 
@@ -64,6 +70,12 @@ static int console_move_rows_1(struct udevice *dev, uint rowdst, uint rowsrc,
 		dst += vid_priv->line_length;
 	}
 
+	video_damage(dev->parent,
+		     vid_priv->xsize - ((rowdst + count) * fontdata->height),
+		     0,
+		     count * fontdata->height,
+		     vid_priv->ysize);
+
 	return 0;
 }
 
@@ -96,6 +108,12 @@ static int console_putc_xy_1(struct udevice *dev, uint x_frac, uint y, char ch)
 	if (ret)
 		return ret;
 
+	video_damage(dev->parent,
+		     vid_priv->xsize - y - fontdata->height,
+		     linenum - 1,
+		     fontdata->height,
+		     fontdata->width);
+
 	return VID_TO_POS(fontdata->width);
 }
 
@@ -121,6 +139,12 @@ static int console_set_row_2(struct udevice *dev, uint row, int clr)
 	if (ret)
 		return ret;
 
+	video_damage(dev->parent,
+		     0,
+		     vid_priv->ysize - (row + 1) * fontdata->height,
+		     vid_priv->xsize,
+		     fontdata->height);
+
 	return 0;
 }
 
@@ -142,6 +166,12 @@ static int console_move_rows_2(struct udevice *dev, uint rowdst, uint rowsrc,
 	vidconsole_memmove(dev, dst, src,
 			   fontdata->height * vid_priv->line_length * count);
 
+	video_damage(dev->parent,
+		     0,
+		     vid_priv->ysize - (rowdst + count) * fontdata->height,
+		     vid_priv->xsize,
+		     count * fontdata->height);
+
 	return 0;
 }
 
@@ -174,6 +204,12 @@ static int console_putc_xy_2(struct udevice *dev, uint x_frac, uint y, char ch)
 	if (ret)
 		return ret;
 
+	video_damage(dev->parent,
+		     x - fontdata->width + 1,
+		     linenum - fontdata->height + 1,
+		     fontdata->width,
+		     fontdata->height);
+
 	return VID_TO_POS(fontdata->width);
 }
 
@@ -198,6 +234,12 @@ static int console_set_row_3(struct udevice *dev, uint row, int clr)
 	if (ret)
 		return ret;
 
+	video_damage(dev->parent,
+		     row * fontdata->height,
+		     0,
+		     fontdata->height,
+		     vid_priv->ysize);
+
 	return 0;
 }
 
@@ -224,6 +266,12 @@ static int console_move_rows_3(struct udevice *dev, uint rowdst, uint rowsrc,
 		dst += vid_priv->line_length;
 	}
 
+	video_damage(dev->parent,
+		     rowdst * fontdata->height,
+		     0,
+		     count * fontdata->height,
+		     vid_priv->ysize);
+
 	return 0;
 }
 
@@ -255,6 +303,12 @@ static int console_putc_xy_3(struct udevice *dev, uint x_frac, uint y, char ch)
 	if (ret)
 		return ret;
 
+	video_damage(dev->parent,
+		     y,
+		     linenum - fontdata->width + 1,
+		     fontdata->height,
+		     fontdata->width);
+
 	return VID_TO_POS(fontdata->width);
 }
 
diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 0f9bb49e44f7..0adbf9cc3d67 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -178,6 +178,7 @@ struct console_tt_priv {
 static int console_truetype_set_row(struct udevice *dev, uint row, int clr)
 {
 	struct video_priv *vid_priv = dev_get_uclass_priv(dev->parent);
+	struct vidconsole_priv *vc_priv = dev_get_uclass_priv(dev);
 	struct console_tt_priv *priv = dev_get_priv(dev);
 	struct console_tt_metrics *met = priv->cur_met;
 	void *end, *line;
@@ -221,6 +222,12 @@ static int console_truetype_set_row(struct udevice *dev, uint row, int clr)
 	if (ret)
 		return ret;
 
+	video_damage(dev->parent,
+		     0,
+		     vc_priv->y_charsize * row,
+		     vid_priv->xsize,
+		     vc_priv->y_charsize);
+
 	return 0;
 }
 
@@ -228,6 +235,7 @@ static int console_truetype_move_rows(struct udevice *dev, uint rowdst,
 				     uint rowsrc, uint count)
 {
 	struct video_priv *vid_priv = dev_get_uclass_priv(dev->parent);
+	struct vidconsole_priv *vc_priv = dev_get_uclass_priv(dev);
 	struct console_tt_priv *priv = dev_get_priv(dev);
 	struct console_tt_metrics *met = priv->cur_met;
 	void *dst;
@@ -246,6 +254,12 @@ static int console_truetype_move_rows(struct udevice *dev, uint rowdst,
 	for (i = 0; i < priv->pos_ptr; i++)
 		priv->pos[i].ypos -= diff;
 
+	video_damage(dev->parent,
+		     0,
+		     vc_priv->y_charsize * rowdst,
+		     vid_priv->xsize,
+		     vc_priv->y_charsize * count);
+
 	return 0;
 }
 
@@ -403,6 +417,13 @@ static int console_truetype_putc_xy(struct udevice *dev, uint x, uint y,
 
 		line += vid_priv->line_length;
 	}
+
+	video_damage(dev->parent,
+		     VID_TO_PIXEL(x) + xoff,
+		     y + met->baseline + yoff,
+		     width,
+		     height);
+
 	ret = vidconsole_sync_copy(dev, start, line);
 	if (ret)
 		return ret;
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index ebf409d839f0..8bfcbc88dda7 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -199,6 +199,7 @@ int video_fill_part(struct udevice *dev, int xstart, int ystart, int xend,
 		}
 		line += priv->line_length;
 	}
+
 	ret = video_sync_copy(dev, start, line);
 	if (ret)
 		return ret;
-- 
2.40.1

