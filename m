Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66615EE49A6
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B23478708D;
	Mon, 21 Aug 2023 15:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rvkBTDGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E994E87081; Mon, 21 Aug 2023 15:51:47 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A29E8708E
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso3057122f8f.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692625905; x=1693230705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHWfOmBWnCfG15vLo7N7Y/b5x/nSoPE0dmgy30xOm9Q=;
 b=rvkBTDGokSsZ+zHSmCyephYHOa1zCgYEH1V/eHcDIaJehG3LF1h3ZetBhv0F1WCnRL
 dg0OqSl4nhT+d01IqkhLNI1FTeIJQeE/FHwY83jActydA9RdIKB97V7VAmOnABjsedPs
 n/m1fNRUpKdpm/TBglBcCWTlhrozxmO+plcVOAjMhNlQQGUGkRo1eq/yHOw8pzfiIQVT
 4G4hJi3ePKSsEYbd1YuMZSkrzN70N+Erw/eeRb2QAdkn4J6xcJyPMEWirh7uNV2erutB
 ZzxtmQOTBV9y19HeQkYKJeCnpReJ2LaLzTJj72ehPZpZqbYfj67OE+MeCC6Yt/m3YILh
 fpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692625905; x=1693230705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHWfOmBWnCfG15vLo7N7Y/b5x/nSoPE0dmgy30xOm9Q=;
 b=i5Ecd9fdl1ZJU0VqAc78F3Pmf9jo/gquJagwYJOv+0Gs8ayWCAJVUNkBV1a10fi3YU
 uHNi0JjDvPtp8HPET+X5ywPbVDMbGOtad+ZjijeZL+mbC+Zc+lN2Oy35AoZjAeiYYqcL
 qr+tjpJBWmj7lsr4rZ+Tqpc5m93dDUcxAeKZeOas3KQ+oM/S5zaPEb6puDJuVXTGbx9/
 NF+fyUg6I5MN+ZrT/+2pj8da5MpJaSlYzzymyg7JmdELwMKcBJsOuVNFfj+kXHLAmapY
 MCO+hRidacGMoSYFLc/PHU7rU1qZqAWuizW35JPJmGYWschbDBhU5HWTPkJ8ifdZ9dqO
 7kkA==
X-Gm-Message-State: AOJu0YxlhwAy04+v9sqR7+z6BpzMYlqGrKNxnrBV5TAuFHvCn94+0y5X
 UCsHr11K/guiHrF8/+oTMNTEUjwCaRQ=
X-Google-Smtp-Source: AGHT+IF9A6Dqme3W/tV3JyovhEsU6i4A15qi8QyYKIlOrt7P6EPMkzmv+B+4oB2S58BxD/9oTr/SHQ==
X-Received: by 2002:a5d:4988:0:b0:31a:e6c2:770d with SMTP id
 r8-20020a5d4988000000b0031ae6c2770dmr4196623wrq.36.1692625904737; 
 Mon, 21 Aug 2023 06:51:44 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 r11-20020a5d4e4b000000b00317b063590fsm12600049wrt.55.2023.08.21.06.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 06:51:44 -0700 (PDT)
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
Subject: [PATCH v5 09/13] efi_loader: GOP: Add damage notification on BLT
Date: Mon, 21 Aug 2023 16:51:06 +0300
Message-Id: <20230821135111.3558478-10-alpernebiyasak@gmail.com>
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
UEFI payloads when they BLT data onto the screen.

Signed-off-by: Alexander Graf <agraf@csgraf.de>
Reported-by: Da Xue <da@libre.computer>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
[Alper: Add struct comment for new member]
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v5:
- Document new vdev field in struct efi_gop_obj comment

Changes in v4:
- Skip damage on EfiBltVideoToBltBuffer

Changes in v3:
- Adapt to always assume DM is used

Changes in v2:
- Remove ifdefs from gop

 lib/efi_loader/efi_gop.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
index 778b693f983a..db6535e080c4 100644
--- a/lib/efi_loader/efi_gop.c
+++ b/lib/efi_loader/efi_gop.c
@@ -24,6 +24,7 @@ static const efi_guid_t efi_gop_guid = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
  * @ops:	graphical output protocol interface
  * @info:	graphical output mode information
  * @mode:	graphical output mode
+ * @vdev:	backing video device
  * @bpix:	bits per pixel
  * @fb:		frame buffer
  */
@@ -32,6 +33,7 @@ struct efi_gop_obj {
 	struct efi_gop ops;
 	struct efi_gop_mode_info info;
 	struct efi_gop_mode mode;
+	struct udevice *vdev;
 	/* Fields we only have access to during init */
 	u32 bpix;
 	void *fb;
@@ -120,6 +122,7 @@ static __always_inline efi_status_t gop_blt_int(struct efi_gop *this,
 	u32 *fb32 = gopobj->fb;
 	u16 *fb16 = gopobj->fb;
 	struct efi_gop_pixel *buffer = __builtin_assume_aligned(bufferp, 4);
+	bool blt_to_video = (operation != EFI_BLT_VIDEO_TO_BLT_BUFFER);
 
 	if (delta) {
 		/* Check for 4 byte alignment */
@@ -243,6 +246,9 @@ static __always_inline efi_status_t gop_blt_int(struct efi_gop *this,
 		dlineoff += dwidth;
 	}
 
+	if (blt_to_video)
+		video_damage(gopobj->vdev, dx, dy, width, height);
+
 	return EFI_SUCCESS;
 }
 
@@ -548,6 +554,7 @@ efi_status_t efi_gop_register(void)
 	gopobj->info.pixels_per_scanline = col;
 	gopobj->bpix = bpix;
 	gopobj->fb = fb;
+	gopobj->vdev = vdev;
 
 	return EFI_SUCCESS;
 }
-- 
2.40.1

