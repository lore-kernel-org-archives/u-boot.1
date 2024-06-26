Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26097C3064D
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D80C884DB;
	Wed, 26 Jun 2024 18:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TIGct8rI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F40B884C7; Wed, 26 Jun 2024 18:00:12 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D32A884FC
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-421eab59723so50656145e9.3
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719417609; x=1720022409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XeXW3Qkj/z7FbBVWiNsQkea6rMAPAsdsziJNKVVIk2Y=;
 b=TIGct8rI45gNGIB/8VFEgduTdnX0cCksGc2/6lfobmFV2gukcoRObG5wKN9zFh9udS
 zlqP+JFkowtFSD1zq4cMocV2ixWAlEv+bVhBguV+e6WXGqfL/ifbpYGN8DKCiBUC1z7Z
 AICBNWtTyJxOT/1PffXGZ6XdUVCJrt2qOo6Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417609; x=1720022409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeXW3Qkj/z7FbBVWiNsQkea6rMAPAsdsziJNKVVIk2Y=;
 b=HdZx2h/mdJSJ/FoY1+S3TlqO47QCc/HXfdbECPJ1dJqtD022BkJPiX7A+HudSeN/wV
 kzV8N04sRdEgWv/gz1Q4EN2DQvsPqmJX3Uus61v5tDTMom8B/A87IBfOBF7Pj0tlXxMG
 biP13E0Aqd7x7qU3O/TF6sAPsWrMwsC+wAiY/XJp7dutpeFSPuVQJZ+wi1B+hsPeyjKP
 leH9i3WHcdEZ/DxRJ5+90FJxFHzlY3WLluDr624OJ228f8DssTVGrSULWBvLhNPNkvN9
 GnGE0bXjmPlKd3FH5uauAmpBQ2BJCxhfX5SJUN3TQqfXmp0hw/cs/RsFJuwsajtjiiCb
 kepA==
X-Gm-Message-State: AOJu0Yxzj6pEyaG2gkDjJxoEKg4xfkTW+ntNWVazEX5OKjqX0l8k11oy
 zPmqNqh/bEgiqpFV5zQDoO6JCNdxp8legWJAXKBNPMWlS/rSA6M+k4mLh6peD4b9PHvzip4hBqJ
 m2g==
X-Google-Smtp-Source: AGHT+IHPx0vvGCLnGsEm4a0ERb3KcfbRvQFYpwKSaMKXER3YknNPYT6g0Q1U0BYeD1F2UyN2Iyr/yw==
X-Received: by 2002:a05:600c:3b11:b0:422:fa63:33ff with SMTP id
 5b1f17b1804b1-42489e37068mr76747155e9.1.1719417609530; 
 Wed, 26 Jun 2024 09:00:09 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c827507bsm30753715e9.22.2024.06.26.09.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:00:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 06/16] nvidia: nyan-big: Disable debug UART
Date: Wed, 26 Jun 2024 16:59:35 +0100
Message-Id: <20240626155945.278640-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626155945.278640-1-sjg@chromium.org>
References: <20240626155945.278640-1-sjg@chromium.org>
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

This cannot be enabled early in boot since some other init is needed.
At this point it is unclear exactly what init is needed, so disable
the debug UART to avoid a hang.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/nyan-big_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/nyan-big_defconfig b/configs/nyan-big_defconfig
index 1483d17d975..4dec710cf8d 100644
--- a/configs/nyan-big_defconfig
+++ b/configs/nyan-big_defconfig
@@ -17,7 +17,6 @@ CONFIG_TEGRA124=y
 CONFIG_TARGET_NYAN_BIG=y
 CONFIG_TEGRA_GPU=y
 CONFIG_SYS_LOAD_ADDR=0x82408000
-CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
 CONFIG_FIT_BEST_MATCH=y
 CONFIG_BOOTSTAGE=y
-- 
2.34.1

