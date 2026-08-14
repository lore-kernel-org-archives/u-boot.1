Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24AFC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 19:15:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 834B960A6F;
	Fri, 14 Aug 2026 19:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uS1F7khlvlOE; Fri, 14 Aug 2026 19:15:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC61660866
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786734958;
	bh=mDC664FM9jkpQaMq0MIE3BZKM7ujjHBo7hxF8/si86Y=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SM14szjzjZ2FP0ykQHvuubm9Hn7kBz3UGJryeaxy10J6w7pB+RnC4kaXMrD/qbuxn
	 /S4u2u6P7lKwp6fMTbuAAO9xO1AvdJ0rAp9uvuXlIafhGeU4pwuwySO0FaEMDpuUNE
	 cwR5Obk2myE8tzjwNTQupMBtD+5xX+NuFKNwHnrTHrSFVhnwr7vVvbV0jvE4AvQxNS
	 0FcpFoR1YhorPVttlaVaLMxNHfY6wqV16MawMna3hyUil7Ayrjp5NnIrsx0prIGtUf
	 h2LBRnVSG2C5BxKtW/f/gLpfDa9Mnx2KducwPjnpQ7m3qSk1WyNLNiMhMFU+nqCM4w
	 kDFyZSz9P+kog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC61660866;
	Fri, 14 Aug 2026 19:15:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B38973A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 19:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B182E60866
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 19:15:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vDbxZzXb0hBf for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 19:15:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4C0D760614
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C0D760614
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=D57Ko4mD
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C0D760614
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 19:15:55 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-495b27007d0so898371b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 12:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786734954; x=1787339754;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mDC664FM9jkpQaMq0MIE3BZKM7ujjHBo7hxF8/si86Y=;
 b=D57Ko4mDOmwLvXvNVCBR1EnDUghoqsGDFNWBZu46RmobOQV/is0OXwqvW8Dy2wiOa7
 kT44bvY1HEzz05E5QzvDtV8nrBf5SiDhLFE93Nt+CLwCrJcdt1u1SqIZYDWljcV53bVr
 LwnCZszYf5IWolijUfPo+VQn0YfiLk5+U6ZDd+DCfX37Ft44olPdjus9aabVfvqTeWk7
 1bT9HnsoGbcBdrv5QW3etGfNQDiFjAI60nXIVkmGl7FkGNGv2R37TZmcIkN47D0hjAMv
 S0dgpZRFAcqfERTDPvXPNPtCHa9V7N2R+VVkQV/wXs1Zlu+0JFvDk4Eok/ZyPWJTxM6w
 opEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786734954; x=1787339754;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mDC664FM9jkpQaMq0MIE3BZKM7ujjHBo7hxF8/si86Y=;
 b=EwiHMfay3ee478AfeMjiJDmac8q7TziR+qa18r3IyfS+gluQJoQa4kx/wMU082m89u
 ga3Gz740LwNBhndGwWNJl49EmOkTaf5I1+LXjqoYqDXeO21Wr72/syCAtNGiC4uOoBW6
 l0P1ixoiYRLbHk6ad9KmxQMgn7Ix/KhiTKYtYIwPZTyTv/vNi6QS+t69XBS3SAH2rZmL
 IgqQ6r0b8Q+3Dvu0mrTyL0POfPwvW6hVEraM22OFcrXi7bI21GMno7cSeyhpQvPqFD+C
 scJwKr+zsIqK+Low6AVRtxJnNmKeSMVsRJmVxAwWgGBQ06GUK2criY/6diqZm/O41KSh
 zXRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3fUY4s659p6UPmgGC3bPP8yZkNRLWKr5YHR04wADTlVjqJv2dyVgbdd2TvSeikOO/+FmPV28=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwsLhEps3HhNmgOxo2vhFNrRJCkBJZMmcf49x3AdqlLbHkNgQd5
 8A/mDUK06NxVbxxKtRhrzulqAfpD2QvmfPbXJJ5KvvRE2i57gst05wV7s4zFHe/7GBA=
X-Gm-Gg: AR+sD127h73nfMTaG+BwHD517Vz0/kmcCj0XjTsw/9/UU9tV5TlqO3OsL2+0UjJMWTV
 274PxqOI0MMRhyU5wLzsoECMucv6UwL8My7Kc3H0uzOjT13kXlxLc2c/yQaoe4gOLxOAcycFN2f
 VM9LpldzEknbabUHtfd64tiKoqWLfuSgIELUvYjTYqP11yKtAqli/mXzV/oe/4qTsAWdZDyQIgD
 fpbEk10KXOY7ikJR3ZBnL8si6eqligszAG3m6TeqvI3DRp/4TxjT0NT/2hjN22/bgrufLbdS4yL
 KKvFVU0hK7CXTWumhofhbpH/9NDJKw8GEbZbNXJLeFc2sf3XnJYg7zHX4uYCYou30TUfcyYKmzm
 vRRJkT0O4DjFeft04R7Mz3RgKMrM/+gTQM/3aFqL6H5lDE0LMHi1CuvjNSkQ6f6zSPOQyHo+02a
 eGQS9v+/ra5UoGgKOFRTIqPPIKoZ03TmGoUM/AoOM+Uo0HVlqpMCWFy5U53HLpnjDuUQ==
X-Received: by 2002:a05:6820:c84:b0:6a3:8ffa:2d28 with SMTP id
 006d021491bc7-6b0d61180c2mr6754190eaf.10.1786734954460; 
 Fri, 14 Aug 2026 12:15:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7124:5000:3b37:b131])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0d95d42f4sm2391633eaf.5.2026.08.14.12.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 12:15:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 14 Aug 2026 14:15:45 -0500
Subject: [PATCH] video: pwm_backlight: support num-interpolated-steps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-video-pwm-backlight-num-interpolated-steps-v1-1-140b06287868@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNTQ6CMBBA4auQWTsJLYYSr2Jc9GeEUWibtqAJ4
 e5WXX6b93bIlJgyXJodEm2cOfgKcWrATtqPhOyqQbaybwdxxo0dBYyvBY22z5nHqaBfF2RfKMU
 w60IOc6GYUbm+s0rJwRkBNRgT3fn9m11vf+fVPMiW7wGO4wMsxuXIjgAAAA==
X-Change-ID: 20260814-video-pwm-backlight-num-interpolated-steps-7d63c7728db1
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5676; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=8SizHy7VJ3l4l0cHH9qDLDCRSAk0wpT5tBpFL4qFY68=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqf2lixHV/ntBq02C6i8ynVWY8udDCemJcGYS4g
 VVhm0jl9ViJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan9pYhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AsbcH/3762cRskm7oAf0eThaKyHo7dGRhjw0itTBeWEO
 iBF7DchP9GPrNYbrMwpboDsf903EaS8u/kY30642f2WxMQDIpGJ5MUZJrYg4i4WgEnRWVO3Qt05
 cyQyjXyWG2Ay9GK7CtzrRwuHibB+xEy0IeJMV4vdAi29camPCINlcn3R9Y1Nd71cGzKolP4Hebd
 IcbbH1mZsGg/kzhyUXLWkoKb+y/6I9oIpckd9FYwOaj4ZFTTNX9QtQXDjZJDLjSOBsz+LR0ep8P
 4WmrS54qbd6zGeHh95az4W3ncv99Tn/wMaDkcH0C+nRHEkprqcu110kKNb3hDOwRd36fp3ckgik
 E0iw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add support for the num-interpolated-steps devicetree property to the
pwm_backlight driver. This is used in cases where there are many points
and we don't want to list them all in brightness-levels.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This will be used by the MediaTek Genio 360 EVK that we are currently
working to bring up.
---
 drivers/video/pwm_backlight.c | 124 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 112 insertions(+), 12 deletions(-)

diff --git a/drivers/video/pwm_backlight.c b/drivers/video/pwm_backlight.c
index 1470eaf4cab..cd469417552 100644
--- a/drivers/video/pwm_backlight.c
+++ b/drivers/video/pwm_backlight.c
@@ -16,6 +16,65 @@
 #include <linux/math64.h>
 #include <power/regulator.h>
 
+/**
+ * build_interpolated_levels() - Build a linearly interpolated levels table
+ *
+ * Some "brightness-levels" tables only list a few anchor points and rely on
+ * "num-interpolated-steps" to fill in the values between them, so that a
+ * high resolution PWM duty cycle can be used without listing every value.
+ *
+ * @raw_levels: Anchor point values read from "brightness-levels"
+ * @count:	Number of anchor points in @raw_levels
+ * @num_steps:	Number of interpolated steps between each anchor point
+ * @levels:	Returns newly allocated table of (count - 1) * num_steps + 1
+ *		entries
+ * @num_levels: Returns the number of entries in @levels
+ * Return: 0 on success, -EINVAL if @count or @num_steps are invalid, -ENOMEM
+ *	   on allocation failure
+ */
+static int build_interpolated_levels(const u32 *raw_levels, u32 count,
+				     u32 num_steps, u32 **levels,
+				     u32 *num_levels)
+{
+	u64 count_out64;
+	u32 count_out, *table, i, x;
+
+	/*
+	 * num_steps must fit in the s32 divisor of div_s64(), and count_out64
+	 * must fit both u32 (it is stored as such) and the byte size passed
+	 * to malloc().
+	 */
+	if (count < 2 || num_steps == 0 || num_steps > S32_MAX)
+		return -EINVAL;
+
+	count_out64 = (u64)(count - 1) * num_steps + 1;
+	if (count_out64 > U32_MAX || count_out64 > SIZE_MAX / sizeof(u32))
+		return -EINVAL;
+
+	count_out = count_out64;
+
+	table = malloc(count_out * sizeof(u32));
+	if (!table)
+		return -ENOMEM;
+
+	for (i = 0; i < count - 1; i++) {
+		u32 x1 = i * num_steps;
+		u32 x2 = x1 + num_steps;
+		u32 y1 = raw_levels[i];
+		u32 y2 = raw_levels[i + 1];
+		s64 dy = (s64)y2 - y1;
+
+		for (x = x1; x < x2; x++)
+			table[x] = y1 + div_s64(dy * (x - x1), num_steps);
+	}
+
+	table[count_out - 1] = raw_levels[count - 1];
+	*levels = table;
+	*num_levels = count_out;
+
+	return 0;
+}
+
 /**
  * Private information for the PWM backlight
  *
@@ -49,7 +108,7 @@ struct pwm_backlight_priv {
 	 */
 	bool polarity;
 	u32 *levels;
-	int num_levels;
+	u32 num_levels;
 	uint default_level;
 	int cur_level;
 	uint min_level;
@@ -196,6 +255,7 @@ static int pwm_backlight_of_to_plat(struct udevice *dev)
 	struct ofnode_phandle_args args;
 	int index, ret, count, len;
 	const u32 *cell;
+	u32 num_steps;
 
 	log_debug("start\n");
 	ret = uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
@@ -232,20 +292,60 @@ static int pwm_backlight_of_to_plat(struct udevice *dev)
 	index = dev_read_u32_default(dev, "default-brightness-level", 255);
 	cell = dev_read_prop(dev, "brightness-levels", &len);
 	count = len / sizeof(u32);
-	if (cell && count > index) {
-		priv->levels = malloc(len);
-		if (!priv->levels)
+
+	/*
+	 * If present, "num-interpolated-steps" means the levels above are
+	 * just anchor points, and the actual table used for
+	 * default-brightness-level and PWM duty cycle is the interpolated
+	 * table built from those anchor points. Interpolating needs at
+	 * least two anchor points.
+	 */
+	num_steps = dev_read_u32_default(dev, "num-interpolated-steps", 0);
+
+	priv->default_level = index;
+	priv->max_level = 255;
+
+	if (cell && count >= (num_steps ? 2 : 1)) {
+		u32 *raw_levels;
+
+		raw_levels = malloc(len);
+		if (!raw_levels)
 			return log_ret(-ENOMEM);
-		ret = dev_read_u32_array(dev, "brightness-levels", priv->levels,
+
+		ret = dev_read_u32_array(dev, "brightness-levels", raw_levels,
 					 count);
-		if (ret)
+		if (ret) {
+			free(raw_levels);
 			return log_msg_ret("levels", ret);
-		priv->num_levels = count;
-		priv->default_level = priv->levels[index];
-		priv->max_level = priv->levels[count - 1];
-	} else {
-		priv->default_level = index;
-		priv->max_level = 255;
+		}
+
+		if (num_steps) {
+			ret = build_interpolated_levels(raw_levels, count, num_steps,
+							&priv->levels,
+							&priv->num_levels);
+			free(raw_levels);
+			if (ret)
+				return log_ret(ret);
+		} else {
+			priv->levels = raw_levels;
+			priv->num_levels = count;
+		}
+
+		if (index < priv->num_levels) {
+			priv->default_level = priv->levels[index];
+			priv->max_level = priv->levels[priv->num_levels - 1];
+		} else {
+			/*
+			 * default-brightness-level is out of range for the
+			 * table: fall back to raw 0-255 PWM scaling instead
+			 * of using the table at all.
+			 */
+			log_warning("default-brightness-level %d out of range for %u-entry brightness-levels table, ignoring table\n",
+				    index, priv->num_levels);
+			free(priv->levels);
+			priv->levels = NULL;
+			priv->num_levels = 0;
+		}
 	}
 	priv->cur_level = priv->default_level;
 	log_debug("done\n");

---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
change-id: 20260814-video-pwm-backlight-num-interpolated-steps-7d63c7728db1

Best regards,
--  
David Lechner <dlechner@baylibre.com>

