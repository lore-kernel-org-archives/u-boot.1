Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA804C36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0D5381EBB;
	Fri, 28 Mar 2025 16:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nbi92RV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC67D81E60; Fri, 28 Mar 2025 16:35:55 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CE9C81E72
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:35:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-85e73f7ba09so195636739f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176151; x=1743780951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pHuPxgffbBSb/QuMc4MfxmXQ/mhTUkd1AJtfj5Ieic=;
 b=Nbi92RV0TzSjm/OzzkAe4j1ELnFIG2g/WBc8uRLwDVe7akjOqhbOagIYojGYnG41Pq
 noDGeqsmkCSCf99M9p2I3GLfyyVi80gQbjjw6aZFhwvl3RjWcIc8TAL/uCNIbAb1Kikk
 s0ukVdPM0gDMFT52sYF1yaaI4+3cwpkA+ahCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176151; x=1743780951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2pHuPxgffbBSb/QuMc4MfxmXQ/mhTUkd1AJtfj5Ieic=;
 b=sSBo5lY7bBUP0cpMDSQlCroyN2K4J6zv9zqzO9KwHcm5EJKgdT6JUB556CRgjdFdLl
 CMmwP43QzY88LAjY31bWGln9a5Yxc3NTbqk8p/ANiKZXEZjiliSt8CGywbm3SPwNXl6W
 AjheNXmFBnPst2C6p6jWCMDFgR1tn0NGD+kO3w64ctmok00zl/W7h+ZNAMWw/jLr3/b3
 X6fsxOT06eaOoG6+/12s3nCWSmC+c4baEW0ZycbnOLm+lUWXhreXI0bV2kOzPy+N921L
 Q3ZmqV33GpRfoLXcBpHbFShAOHE4L1N/52mh+WgT0zaCla7TBIUCYbP6/Ad93AXm5qYF
 PEUA==
X-Gm-Message-State: AOJu0YwgQRNR6zpH3WlIIMGpeHsDeexWnEFj2KUYHcmI/LIRGo5hcY/X
 TLjs6E2bsPvJK7tOjnSWW08qoiQcvyK5DY65zDVGGh6z039VmoZOWTbWoctZZjXVAawv1xHVXQs
 =
X-Gm-Gg: ASbGnctC//QSE2HaKGWr5CkSPZI9zfPfQR+6FCvE+cRrq9Dm2Ia5MSuqhGDXK8d2AcC
 7Bjt/ekMvfDDBEz5fU3BRvSKgpZh29oNL+YjHLCrs+vq4a1KVuDt+J87F0iC//V4B76U3AXAIZD
 A8UaTf7fMaK8dR/nb1SH1O5uoDYtEtQXKEo9C2TFvOaE9OuPNCCvAWfhiP0a4VnLMh75FH0/kMq
 fdPCxIke1Nrl5YhnZ/jNNg3tixw/jorurPt8+PUpdLuhQF0pvqd1Ree0y+ESsKJ1zVzPPTvnBv5
 xYMeHm3LrETnNgzlBOe2Z+maUFw8Muann1CnLBkcKZbYhUIAP+Q3V5S5XML93u2tSGXRh74RiNp
 XCcri0w==
X-Google-Smtp-Source: AGHT+IEJ+04ygDgzVnKgWmUsPxMWO0Ej+Zc1uP2uoX9Hn+q/R4dN6oMaNQeD10vyGlovJjLscDBUcA==
X-Received: by 2002:a05:6602:380a:b0:85e:2e53:ed27 with SMTP id
 ca18e2360f4ac-85e820564ebmr958760839f.3.1743176151073; 
 Fri, 28 Mar 2025 08:35:51 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:35:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 05/31] rockchip: dts: Correct the OS for U-Boot
Date: Fri, 28 Mar 2025 09:34:45 -0600
Message-ID: <20250328153522.3555472-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

The U-Boot section is currently getting an invalid OS. Use the correct
value to fix this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
---

(no changes since v2)

Changes in v2:
- Put this patch before 'Factor out arch and compression'

 arch/arm/dts/rockchip-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index c8c928c7e50..e9ed1d4b573 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -50,7 +50,7 @@
 				u-boot {
 					description = "U-Boot";
 					type = "standalone";
-					os = "U-Boot";
+					os = "u-boot";
 #ifdef CONFIG_ARM64
 					arch = "arm64";
 #else
-- 
2.43.0

