Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CD9C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC97482887;
	Wed, 19 Mar 2025 15:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HaqSKe3s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D41828B3; Wed, 19 Mar 2025 15:56:57 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4945F8219D
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso31734085e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396214; x=1743001014; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7b5os9cxFsOcI2bOKWFSzEOvoTPx/ufcgRqLdYhAyY4=;
 b=HaqSKe3so9vVnm3WGmOX+r+kcn+tJWw+CEXM1/XBSmyYsy6+Qna8gms2AkGupMGjF9
 bMzjBVgN01dUdJG6TEU94uM7LygI8RWeku3V0/cY2kvz/5FVPA3IbobgfA2zZXYasDN1
 tlLQmnwLywZZokG2iC0NUMWVUa+3ZAvFRUUhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396214; x=1743001014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7b5os9cxFsOcI2bOKWFSzEOvoTPx/ufcgRqLdYhAyY4=;
 b=b5GhY8U7VvvjQ786cjjWVTYsDoEuwXty80+ImcsGJJTprNkiOuY01wB6SHn2MqhOaa
 M1HOe/1PPAv4IlBK1Vdjw4wTLK/6kYW/M0hlFDZ4hCl9rc/YCwOjoTxd1sxGU0NrNg0c
 BhXo65kuI8/m03BakiIGD91lz7Ems7gjDrTXDcJcnnhqd8AUOmiOQ5Fu6X090vEAXTJz
 fn+TzZAGNDlMNObvqhCHj/UOi17qE8dGkPcGRhz51uEFQs7H5WBfZ5bbDRkDp82q+27a
 HmjJ2mB8TGryHpvEarPt6xg6WS+URdnQt2LN8+bD/HTiobaPbuwH6iL4w7wRZKQ5K6qI
 m28g==
X-Gm-Message-State: AOJu0Yw6kuKxZOFvRfKwPC/osBzxzE/3T6ep87RUtSU90NBi5qfMfam3
 OOgV8uuKYxE+oOBsjReeTM57H9Q1c6cJY3V3Kc+678z+wnOH0TDl2p2+0SE2cf5bnKACVq1c+7A
 =
X-Gm-Gg: ASbGnctcXA5hLGEhBO9v7mxKveF5fZBCesomRa0yS2l9OldZ9D9EkEXhUNpabCd/ez/
 cHeXU7Nt2PkXbXUbYlv79mTxWdWVm3PSnRANlLydUUZL64PPQrT2BC7qRXNE0xbTyhMutbeMznZ
 WmE42wOm41SlEPN3dZRyEgidVyEsazBxGgn6yM2C7MPUHx9d0KOGfKc2iN2Od6p6vKCIAz9NbPf
 Uyc0LqdHSV2cmzJsrCFlZ4YU07ByrH/Qs5mM/ddquqg7zCUrmgcH1gPUPea9o3RhQounQumw4tr
 75lciDdyhdvyZRb9QkswxFnIt3bT6ygx5rumgHqA2pF2sqwx4wBh
X-Google-Smtp-Source: AGHT+IEe5QsCc5rNMSyKbNMn3MkBAwJaawoN3hTp02AvoySekmTYRMmtLqoWg46MwQXB+SLdv4cqjg==
X-Received: by 2002:a05:600c:4fc6:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-43d4378d08dmr34037965e9.11.1742396214117; 
 Wed, 19 Mar 2025 07:56:54 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 47/52] expo: Provide a way to position things relative to
 display
Date: Wed, 19 Mar 2025 15:54:52 +0100
Message-ID: <20250319145512.2391122-48-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

It is often necessary to centre objects within the display area. Add a
special position value to indicate this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c   | 5 +++++
 include/expo.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/boot/scene.c b/boot/scene.c
index 02494fff603..7acd14b9eec 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -363,6 +363,11 @@ static void handle_alignment(enum scene_obj_align horiz,
 {
 	int width, height;
 
+	if (bbox->x1 == SCENEOB_DISPLAY_MAX)
+		bbox->x1 = xsize ?: 1280;
+	if (bbox->y1 == SCENEOB_DISPLAY_MAX)
+		bbox->y1 = ysize ?: 1024;
+
 	width = bbox->x1 - bbox->x0;
 	height = bbox->y1 - bbox->y0;
 
diff --git a/include/expo.h b/include/expo.h
index 2addddd5012..4dee479e9a0 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -242,6 +242,12 @@ struct scene_obj_dims {
 	int y;
 };
 
+/* special values for dimensions */
+enum {
+	/* width/height of the display */
+	SCENEOB_DISPLAY_MAX	= 0x7f000000,
+};
+
 /**
  * enum scene_obj_halign - Horizontal alignment of objects
  *
-- 
2.43.0

