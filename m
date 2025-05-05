Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF92C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB26582A4B;
	Mon,  5 May 2025 17:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wcs1wlPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9395A801BE; Mon,  5 May 2025 17:44:15 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89D05829E4
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-acae7e7587dso738217166b.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459851; x=1747064651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p1RTL01aHDDoz3SgpMIG+Tz12nuE2+cW2sPImc+kdFA=;
 b=Wcs1wlPdWKBnzqRhrYIk/lLO5F6TPSmmAa1KRuaAr8TVCjIcHdD+2RF/8Im3DExYeM
 YLNvDFOlySH0kHSj8TsISCSFMZGA78da7T7Q+5wlb+hWYaVQA0W+8y3Iqbc3+3p9e0xY
 2ykmUW388SECk6B+tErwN87nCfmJ8nRMP//rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459851; x=1747064651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1RTL01aHDDoz3SgpMIG+Tz12nuE2+cW2sPImc+kdFA=;
 b=uaOLdo3EzwrhOJ/FyrTPk6EDG0/+RHvuoeQBiXb3chWBPXqgrrsvVd//EMYaaT+4HD
 iUkaTk/MTOQKP11nY8aea7UbPZ38icQpiJSvUM1GmhsmvPTj7swcrDf0qBjc36FexCrr
 pgULNWZxQk+/NmkIJ5PlyqVsu/MUuJOeLB0/VjEoMRm3hDeV/wijcvfBDKXbUY4jrCXn
 h0PoPlelTjSBVNYI2XKsopkJ+iesKG6OtxlkzFMJfBi23MyVu1HoL4J1PUhkMZSwfdXj
 sS+G63VnEjRQsqAY85QBu5q5l5U8asH2n16FVdsOdt0ob8xNNb0HneISUgPqAW6gTmVY
 33ew==
X-Gm-Message-State: AOJu0YxCvoeAwxfe26bBaHl0GnPtVJ6JRcXBGLuqyiL0iENOCDEszKaP
 2HFoqQh24NRLGuYoHqbguVuaOndRdDEdAGRAMGRn5nn7oiDrvGa5Tmab9PKMCOzZOrwE1rUWBcA
 OLTIoV3w=
X-Gm-Gg: ASbGncsmyyyaAkq8hS9KuCPGgw9gwMAPB9f5W2jbFG5AbQlkCDxqBIbCWymhEONsunl
 G22+CJ/4dpGrjTee0zgcf0jFT9soOWar9fir97d5thdshRtWrfSfqGU7fnjjZvBS+yXIAx7j4k3
 I72hGx3yJPMzWKnczI0lnRI06vmw2s7cHUo4HotZe42PTWJ2LNboaYp7R2cQwebDoKbRRb8i//E
 3Qz4iu3S9ZLzloTUx0eFAMoh0bmpQpw0oTGUNzVCAwgfwqQR5xkMLi0EHXWn/3xjcGPSJx9HkVI
 eCJq0TmnAD+USyWwQ9sX6mgeioMxy//eGW7pdUQ5v8wt29E=
X-Google-Smtp-Source: AGHT+IHbtl3CxZe+LKBhNuporm+H/nY8Lglo2vy/6u68YyZM0zYfSwJMxd6KTcgH2I08HD1ubmY+dQ==
X-Received: by 2002:a17:906:9c94:b0:aca:cb18:9ad0 with SMTP id
 a640c23a62f3a-ad1a4a8dabbmr687401066b.45.1746459851444; 
 Mon, 05 May 2025 08:44:11 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:44:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/19] expo: Simplify scene_textline dimension calculation
Date: Mon,  5 May 2025 17:42:51 +0200
Message-ID: <20250505154308.2911248-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505154308.2911248-1-sjg@chromium.org>
References: <20250505154308.2911248-1-sjg@chromium.org>
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

The goal here is to obtain the dimensions of the edit field, which does
not change.

Since scene_arrange() now handles setting the bounding-box size based on
the dimensions there is no need to do it here.

Adjust the code to simply set up the dimensions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene_textline.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/boot/scene_textline.c b/boot/scene_textline.c
index 7bc35a997dc..07711d147c3 100644
--- a/boot/scene_textline.c
+++ b/boot/scene_textline.c
@@ -61,8 +61,7 @@ void scene_textline_calc_bbox(struct scene_obj_textline *tline,
 
 int scene_textline_calc_dims(struct scene_obj_textline *tline)
 {
-	struct scene_obj *obj = &tline->obj;
-	struct scene *scn = obj->scene;
+	struct scene *scn = tline->obj.scene;
 	struct vidconsole_bbox bbox;
 	struct scene_obj_txt *txt;
 	int ret;
@@ -77,16 +76,10 @@ int scene_textline_calc_dims(struct scene_obj_textline *tline)
 		return log_msg_ret("nom", ret);
 
 	if (bbox.valid) {
+		struct scene_obj *obj = &txt->obj;
+
 		obj->dims.x = bbox.x1 - bbox.x0;
 		obj->dims.y = bbox.y1 - bbox.y0;
-		if (!(obj->flags & SCENEOF_SIZE_VALID)) {
-			obj->bbox.x1 = obj->bbox.x0 + obj->dims.x;
-			obj->bbox.y1 = obj->bbox.y0 + obj->dims.y;
-			obj->flags |= SCENEOF_SIZE_VALID;
-		}
-		scene_obj_set_size(scn, tline->edit_id,
-				   obj->bbox.x1 - obj->bbox.x0,
-				   obj->bbox.y1 - obj->bbox.y0);
 	}
 
 	return 0;
-- 
2.43.0

