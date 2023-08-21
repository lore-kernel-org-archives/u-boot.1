Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5C4EE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CAC987085;
	Mon, 21 Aug 2023 15:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mvjKik+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6192687085; Mon, 21 Aug 2023 15:51:45 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1E718706A
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fee17aebc8so20256405e9.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692625902; x=1693230702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUPwGyIUGhu07FwRipI6J5nz3cUBWpffvk0k2vprnLg=;
 b=mvjKik+ts2RRqakLQOi9t7J1i101HYF0aguRZ/P4y3h8SvaC+jrWNXPy+MyUiGFatO
 EW5N4iqonVrCvE+i19nnSxA3TW5G5ItgSDTN6yq5TEp806h08MC17nKgCuRk/Urg+Nkj
 ZewK+CW+lOR6k2kB8LtZylmeke1YHCeGMXq9VMK1hsm4co4hgSx0ZJ1OXiP5+tc4mVug
 L2WSO1+ILyeHTT0N/dHw3FHShX08Y0SisUe32K946KofaqN6teHjb172uNMPVvd4Nk1S
 G2GYNvIigYOzyXNzeBRUDXG3TkK8+ioXwBLZ4iqTsf77Dc0p2ePFbhc23gHzBcKBpUSc
 O2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692625902; x=1693230702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OUPwGyIUGhu07FwRipI6J5nz3cUBWpffvk0k2vprnLg=;
 b=PY5C635/8jWW5ixQ4L1L3j9qeTGHNNV7zdPW6utGplgCgNorieSsCHQweRvRmMeEuD
 MFr4iXeMz4fuhtbE79McVeS1D2v3BXvw2DX52qn7G6MlWSp/OVuocmhZPavm+DsYq7wJ
 D//vupLeuSNo0SXsniHXWL8NlKNfz7qnozFFui+kEvO0IwOmVbDRI99V9uZM3ng9hERg
 y3hKkIFQSgXYtPJ+4h3reOPhrZLXW5t/o9rXjgeC+l6WyxkI6UASNgww0aC0iwiIg40B
 enEpHJN00lL6FOkCuYsMay4itv3ydNVuzZHbW7w6tmgDHIWKLg4yi4tFuiSgl+EnJluq
 pqDw==
X-Gm-Message-State: AOJu0YzfIxtWigpVmRfL01E4NvwPLzRkCCjd173t25icCTVna47obihz
 mXXbV/Xvlo7hwqge7/MU2LnnCJaUcgE=
X-Google-Smtp-Source: AGHT+IFzj3fGJ3yOnSTVNmg3QQIrMsHdzvHVI7a3IQjx0jS8kD0qBSvWJ3Z5+c4jA0D6oPZBiuGxwA==
X-Received: by 2002:a5d:6811:0:b0:319:8a5a:ab5e with SMTP id
 w17-20020a5d6811000000b003198a5aab5emr4349395wru.38.1692625902291; 
 Mon, 21 Aug 2023 06:51:42 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 r11-20020a5d4e4b000000b00317b063590fsm12600049wrt.55.2023.08.21.06.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 06:51:41 -0700 (PDT)
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
Subject: [PATCH v5 08/13] video: Add damage notification on bmp display
Date: Mon, 21 Aug 2023 16:51:05 +0300
Message-Id: <20230821135111.3558478-9-alpernebiyasak@gmail.com>
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

Let's report the video damage when we draw a bitmap on the screen. This
way we can later lazily flush only relevant regions to hardware.

Signed-off-by: Alexander Graf <agraf@csgraf.de>
Reported-by: Da Xue <da@libre.computer>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

(no changes since v1)

 drivers/video/video_bmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
index 45f003c8251a..10943b9ca19f 100644
--- a/drivers/video/video_bmp.c
+++ b/drivers/video/video_bmp.c
@@ -460,6 +460,8 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
 		break;
 	};
 
+	video_damage(dev, x, y, width, height);
+
 	/* Find the position of the top left of the image in the framebuffer */
 	fb = (uchar *)(priv->fb + y * priv->line_length + x * bpix / 8);
 	ret = video_sync_copy(dev, start, fb);
-- 
2.40.1

