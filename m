Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B511CCE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD37E86C2C;
	Tue, 19 Sep 2023 20:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fZW5F5TO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C195086BFC; Tue, 19 Sep 2023 20:09:47 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA0C086C13
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34fc96995ddso12459535ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146984; x=1695751784; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIf5GY7E98K/C20/v2JBzGURhjk8M+JGeTFIwpXBvGE=;
 b=fZW5F5TOo6dT8KhXmUeTfX8zpN/nh1EeHo4izeDtfV/JzqQJBkZ2Sx+6ry/H3eFNld
 KTo+qa2vSNx1WJhBhmfasgr0FRMZl2kDUHIqIlaAfSyMu9mkVRs1XHE2Ze+P/P//h5Jq
 ml7J/HK3D1q9+Gwgpn6Ww/Qt4pBVHdVhdhQq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146984; x=1695751784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIf5GY7E98K/C20/v2JBzGURhjk8M+JGeTFIwpXBvGE=;
 b=C2SlfrBaddQbLY2BLgBj19b5W7fHn/II75zY0drN1zPdb2Ru7TEtRqmWo2pJK2b3IE
 UtMPpPxUGTxj1LcS8ceTuzyZglWkIGoBAULrxH5hMHSm72sRNDLgNEPNPZa7Jz56uBl6
 DpGwRHv567ny7qvKqRWY3V7H/HoGsslW+JnLenCw8Nl/fmCrHITAkOMOj/kkCiifp7UZ
 OdwXyUae9kCVKG+E/5X4SC65AkMgINwUCm3SDcLzSxrMOYMG/gk/bM9B1EkETGdMMPWr
 49VuJEyzCKP8o2Uth+W09OF0RhaKeigAqDCfQC5K0kla4xhMZ4wX0KZnZ5Wrcc3udJhu
 s9/w==
X-Gm-Message-State: AOJu0YyVfnxyXPnM34bkEkvx+dqKUzGP0HdoWIRLd8NeDbAEdfttmpaz
 jd1qQE4ynYx5h71788ATNR+VPOHZ/rOLSPFaHh0=
X-Google-Smtp-Source: AGHT+IEBSfOmcBeKnSKHdHvhFeg+ZEgkAz3v4psk4nUvIlnqRBKdDNq588kJ1SYKXdg90D48n8SrpA==
X-Received: by 2002:a05:6e02:1a8f:b0:34f:2cb0:5d0 with SMTP id
 k15-20020a056e021a8f00b0034f2cb005d0mr667939ilv.30.1695146984382; 
 Tue, 19 Sep 2023 11:09:44 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 21/36] expo: Correct some swallowed errors in scene
Date: Tue, 19 Sep 2023 12:08:51 -0600
Message-ID: <20230919180918.2904313-22-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

Return the reported error, rather than assuming it is -ENOMEM

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 08ed85e9188..9c4466c1a47 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -137,7 +137,7 @@ int scene_img(struct scene *scn, const char *name, uint id, char *data,
 			    sizeof(struct scene_obj_img),
 			    (struct scene_obj **)&img);
 	if (ret < 0)
-		return log_msg_ret("obj", -ENOMEM);
+		return log_msg_ret("obj", ret);
 
 	img->data = data;
 
@@ -157,7 +157,7 @@ int scene_txt(struct scene *scn, const char *name, uint id, uint str_id,
 			    sizeof(struct scene_obj_txt),
 			    (struct scene_obj **)&txt);
 	if (ret < 0)
-		return log_msg_ret("obj", -ENOMEM);
+		return log_msg_ret("obj", ret);
 
 	txt->str_id = str_id;
 
@@ -183,7 +183,7 @@ int scene_txt_str(struct scene *scn, const char *name, uint id, uint str_id,
 			    sizeof(struct scene_obj_txt),
 			    (struct scene_obj **)&txt);
 	if (ret < 0)
-		return log_msg_ret("obj", -ENOMEM);
+		return log_msg_ret("obj", ret);
 
 	txt->str_id = str_id;
 
-- 
2.42.0.459.ge4e396fd5e-goog

