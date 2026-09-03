Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD223C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A94B810DE;
	Thu,  3 Sep 2026 14:00:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I_3VyhTcyS6r; Thu,  3 Sep 2026 14:00:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2C763810CA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788444003;
	b=ImOQ9hZ2X0VHJnnAvDBTkuSkNrvlZ0zpH6Hexx+hesBIbAwNfg0jBhUwU7/Sjylp6BPk
	 2dChMlzdAZCZkOS/HXzEMfcrfJBpH6y4WzPdZhl0SJj5y6mLBN+KDltth1dkIy75sha8n
	 WV+j6GhPsPWFdejJHgymhEVNkEIowbK0Ym5vW2B0agnR45t7S6iziJ0o6bGuakTRKpUxi
	 5FHcXeGMBBzmgRL3Kyrl08wz3gjYKiWYlE4kdGzN0IXNKBwvlb3Z1G0mmETdR/lDu2KP/
	 SQ6R/0FDVicwoXX2M5nRhNfkkUMExveJroxTpYh0dpfpQXUsmztimWUHP2CA612sQeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788444003;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=y0NSq8CxGTB8wReJBXg7NB+1TlCicUNNK/73PEWZoKI=;
	b=cY2jKaX2MnkOKOK47aIf71UqH2CdSxWYjmbUJcT10rLivYjbwuZs2+Uv2mfrDet6bkUR
	 h9EIh5K8QpMeyPvehpEE0eBaM7/x76Xg08ugHaBnb+/1uiBVUUbe40Vu8wMZkhBLUB8xm
	 W8kkf9igf2OiXRwxw7tvX6blwIrA/uQaA9wBYHW4Pm9wS4kAHMvpcC0YMrgbqhguzYn+Z
	 lKp+8FxXFLm2i1mKRH3gxM0hPRiHp2kuholTL0Hze0gtNU11fnGAMurAnUQoKFPzxQrMy
	 cCAkgnnOtDoV62bi32gA/vSiMHIecKx48joyXoPCfIRJjPbD1k04H+Sg1UkSTSLy8SA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788444003;
	bh=y0NSq8CxGTB8wReJBXg7NB+1TlCicUNNK/73PEWZoKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jXbqAvvD76NydAw6awaqEPHNo+M9AEx3plIjCW8rsfgRPldc++Y3RvQ8BdiwzYx2/
	 i583MtVBauvBxBloPn/Qds20p9/jjrSQ3luOdXrXyUJILPKHDx6n/Hslvs0j12OHN9
	 QTAeIh1pSh3z+XdvUFHQrq6c7AxYk4ftcTBc8frc6tPjPB1TnOunNoHFLOtVYP3Kh7
	 jEgENCPmSUyXfii3hHauekWwxX1MYKV1IXRm3wBefREGmr2Z1eZOr6wo56l2HJxhfK
	 puz4kRpux01NIj6xqSiqIpgGqUgAKdMtKYQCXuepBHbmF3yG+zdpzYDN11jenGMCWT
	 IRaLXKPM23QDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C763810CA;
	Thu,  3 Sep 2026 14:00:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F67622F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 316AE40454
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:00:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HjaR_6R0WVjI for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:00:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0207740462
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788444000;
 b=WJ/7wXXf5o54at3DMcV9ljAAqdb8noT8tBDzLjBT8HtqQzLWzzOSUscb/+gH6MlIhDWO
 6FHsLmUtHZVeQ30hj/i0mWXIGIfR/TuuucZknC0Ag4BHb5B1sfA1PTLfAAM8haNSArhmv
 ++v4UWaFQzwAiuJgrLDqdDpZbaF7dEqls9iy7zlJffJ5m+n4M0i+NJrQEq93ohY40+dJt
 Q/y5H5XFJQaGzr1ioWCrI0Ioxu7ej6dk5r486zpYskZIqvACMOUMYNqKPL+lTXFyIkieO
 DnqfSWuq9YC2FHo6YLi5TmX88j3N/pzsc6+pLIKvIyQE3WpB4SA19pFcWWdid1iClFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788444000;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=y0NSq8CxGTB8wReJBXg7NB+1TlCicUNNK/73PEWZoKI=;
 b=rvwkSfrZKzGYcpmKATDhCjotNYpwi1ctC+GEki8zda71jjpFPvYnA22ihJsXWihrmLx8
 9HBlOFy3OAvo4Ue5bFx7PzYeKsomMnv6Hv3LhqpAoSjr5NXr90d+CDfdfCpDa4mLQvLgI
 2Eh/aBpBJ6Xa3a7+0gkKtmBxdJfkPc+D2VUzGnjuuAS5Jp8CvZQzYPjvhRILSw+e3SuhN
 YHIUwwyY40U9gixyeeDyXYd51k6tv4EKG8UMf1pb7n+28wo5z8xK1R4Hij33fPlE0Q4aQ
 WYwZ5/q4IgY53L4NWe0ail9mwCqY9vlrHPfnkWXCIKwbxiGmixHCBN/VeKT+A0rpzgw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=iadwmzAl; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=iadwmzAl
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0207740462
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:59:59 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49b0dbfbf7bso16689025e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788443997; x=1789048797;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y0NSq8CxGTB8wReJBXg7NB+1TlCicUNNK/73PEWZoKI=;
 b=iadwmzAlfR8FFUHIjRN2jIgKVd2pMmI10UzfVDFQ2muuQ//00bypc0rsSGhUUNCC40
 R33Z4UjUM+tukosBtif4GqzRDDAksG8vCYvUky3HBipBpmUY/k0PmKweDnDIM2z1tfqM
 MVIHlfsNboRhAMYDEEmVHlHPHsvX16ayLio8NktlZJM8ckqoKU8IQhyIzTO++KASs7Kw
 uMdf4bwusaDUH6wD0+SwUlu2jiKmdyYxpOSVwnMdz0N44ZiSMoI7PGxlU49lvJxhk7h+
 rVnEHaP6mY3S7ouAgs0p+9anRx0qYcXeRx4Ty2xV1I2oQHiH8TD12xWnx6/C218q3AHz
 YqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443997; x=1789048797;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y0NSq8CxGTB8wReJBXg7NB+1TlCicUNNK/73PEWZoKI=;
 b=pnpERDUHz6thi+nCGhmSnozAthNk+BsYEbY89Rig6zojK3EgSFdM0+/hZY9iBurfn3
 2o1Gftth4imZo4hbL7pKDJg8SYqc01osMp28AaSUU1rdGoUClbHoyn3ueHhFRlRoe8vG
 3WRFAlXbZDepDveYxnM/oS1OWB0+fdcGOv8Wog4+cTNR60wZVIzt0A5PrV2PvBs081V6
 yLdG56Ccbkt4h8eGCTY328z0RTYtg5h8ZTRyev9WhVLRY/jJ0F4ezKEGI3CGlbAivXhj
 fv97dg9VJUiot1cqENyZYOgW9FEacPxHXGcL9FmmChQoRBFz1OTWEQuz8kL9CfF0zmUg
 MChg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLagl2TmV4kF9dPYnQQhJ9y9juYfv62AiIY+crnD/wXN4TFJl8f/CVz2MHot7SPAPFIqMAyQY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lwRCgBC0ufOQHs9kTmjjvzCIvLp9qN+Mqbc8ZAA2r/aEj0qvMO
 zH66et7cmyfK08GZ2WJcru3RV1xCf//lD3pZJMcWrwiH6j/wtXKVvKsFN0o0yHeO86Q=
X-Gm-Gg: AYBFou1PGJc1PgnnIIQFLUndQXUYkGsQFPDx57xlA9JC06cVsS/+2TzJgf4F7cKolnN
 YwCq86VY96gkWe4ipsI8fKddHezwXO9my/SKuebE43mREbcdU3iNZLEJCc42kBAKFKYf4EoO/Yu
 iM3Ck9H3mcoxBGAS9/xOoB6CdeyZOGof2iTo7sz/ArcikwyV5wr+sLcNzNDq81tCMYRSvvpQblB
 +RCbcaz2keu+RInipP6MfJPf5AsaRJlh8CKMfvrws6x83vjZXA73Kj4BGtUEoNjO7EIcIY806/v
 O/IS856BXUAsrVocwnqSFpUiESslMkwB3xXlIS40hBGRMnq8y+IVsFjS/HRs1Y8yXKOppzPCT50
 TKnWL++jXM+OomjTSAap578jkEjkug39k8eEr4WQgnltF/pg8izoIohti6uUDPPCvHIjA3xF2gY
 rHwCpnuh57PyG/yo6NtJvX8eni80LPmSRidk2eVnzojGka5SkgTk6Seth1UlxYL+bJJoDPOa4mF
 joNm5dvBtvHXbcP4tgB/nhJ/XO+PMSGSn+68CVbfK60pYGuxDI6p941YvPSnepJbCwk5IQZBaeG
 Mf17N+cYboQaS+72ywTk7PfjMNmG6vmSNHC4wUIv6K+v
X-Received: by 2002:a05:600c:6209:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-49ce582039fmr239412865e9.7.1788443996758; 
 Thu, 03 Sep 2026 06:59:56 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f912esm74213505e9.4.2026.09.03.06.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:59:56 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 03 Sep 2026 15:59:35 +0200
Subject: [PATCH v2 2/2] video: fix build with CONFIG_VIDEO &&
 !CONFIG_VIDEO_LOGO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-fix-build-with-config-video-but-config-video-logo-disabled-v2-2-18c22bdd9f2d@baylibre.com>
References: <20260903-fix-build-with-config-video-but-config-video-logo-disabled-v2-0-18c22bdd9f2d@baylibre.com>
In-Reply-To: <20260903-fix-build-with-config-video-but-config-video-logo-disabled-v2-0-18c22bdd9f2d@baylibre.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

Building with CONFIG_VIDEO enabled but CONFIG_VIDEO_LOGO disabled fails
at link time:

  video-uclass.o: in function `video_get_u_boot_logo':
  video-uclass.c:593: undefined reference to `__splash_u_boot_logo_begin'

The __splash_u_boot_logo_begin/_end symbols are provided by
u_boot_logo.bmp.o, which is only built when CONFIG_VIDEO_LOGO is set:

  obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.bmp.o

The only remaining caller, video_post_probe(), is fine: it sits under an
if (CONFIG_IS_ENABLED(VIDEO_LOGO) && ...) check and is eliminated when
the logo is disabled. video_get_u_boot_logo() however is an exported
function and is always emitted, leaving the reference dangling.

Guard the splash symbol declaration and video_get_u_boot_logo() with
CONFIG_IS_ENABLED(VIDEO_LOGO), and provide a static inline stub
returning NULL for the disabled case in video.h. Callers already handle
a NULL logo pointer (e.g. bootflow_menu.c), so no caller changes are
needed.

Reproduce with any board that enables VIDEO without VIDEO_LOGO or
enabling SPLASH_SCREEN (it disables automatically VIDEO_LOGO).

Fixes: 0d3890188d6b ("video: Add function to obtain the U-Boot logo")
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/video-uclass.c | 2 ++
 include/video.h              | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 1a268137bde..22183d00d97 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -579,6 +579,7 @@ int video_get_ysize(struct udevice *dev)
 	return priv->ysize;
 }
 
+#if CONFIG_IS_ENABLED(VIDEO_LOGO)
 #define SPLASH_DECL(_name) \
 	extern u8 __splash_ ## _name ## _begin[]; \
 	extern u8 __splash_ ## _name ## _end[]
@@ -591,6 +592,7 @@ void *video_get_u_boot_logo(void)
 {
 	return SPLASH_START(u_boot_logo);
 }
+#endif
 
 int video_default_font_height(struct udevice *dev)
 {
diff --git a/include/video.h b/include/video.h
index 9ea6b676463..8e4c1544e56 100644
--- a/include/video.h
+++ b/include/video.h
@@ -418,9 +418,16 @@ bool video_is_active(void);
 /**
  * video_get_u_boot_logo() - Get a pointer to the U-Boot logo
  *
- * Returns: Pointer to logo
+ * Returns: Pointer to logo, or NULL if CONFIG_VIDEO_LOGO is disabled
  */
+#if CONFIG_IS_ENABLED(VIDEO_LOGO)
 void *video_get_u_boot_logo(void);
+#else
+static inline void *video_get_u_boot_logo(void)
+{
+	return NULL;
+}
+#endif
 
 /*
  * bmp_display() - Display BMP (bitmap) data located in memory

-- 
2.55.0

