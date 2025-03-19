Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B336BC35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47E0F8272A;
	Wed, 19 Mar 2025 15:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kXre2pxe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DE6A82107; Wed, 19 Mar 2025 15:56:49 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A37AA8213E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so33005395e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396206; x=1743001006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ccsgKwcaQEeejZD0evGES572XtjQuT5UPQ4oZj/e+28=;
 b=kXre2pxe43TKXxP1uPDw2E9+zIkczrUylL+bpiuRRDz9MUsK/GggdNru+2ia1EUcfp
 LKK0EKz1wmoSwZM6cKgjeXF6o8pFvJR9mHHEEm2lBgOLNyIecRUoZBYDAA/bcWGFSii3
 jSDA2RTweb60Ak4VrL78Eh52nidBo0jMMAeOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396206; x=1743001006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ccsgKwcaQEeejZD0evGES572XtjQuT5UPQ4oZj/e+28=;
 b=MPD1IGb7epG4nJgX6MKVTZf3gXD3aG4LBDBzBQjpIphSdKks4jko1SZw+BtMH0asGF
 od600/2b+k+LunqKisoQKg8zH+PEv4gkmbz7ahG5FJWHlVAtDrsyFeyrEJZnJB50i5FB
 nnnuYH3mnJUysCU2J1qHLy4y6saLYFNpla3ki3D6tLghVifJKKaJjkG71QqaPKu0qufI
 yfdU2Pha/BN50eNP4yXRc17/Vp3E/2JK4Xbs8khRg/lCwjuIUHO1Kbd6HJQXCVAit04j
 Mxm2qzu1aV+kzKM5Fovu8XIc+KgNnVThLlgk857bQ4QPIeRdbDFi4GxCoUDAvmoAoR9l
 FBrA==
X-Gm-Message-State: AOJu0YxdWFNCvIDeqMXqiRZ1158U8VsfCwhJ/fSg9fRASvLnGDErL5wX
 XBQZ7nD4ATv9ZWxtco5P19MjFfUx75gRQeuRAKbZZbr5wp+oemhHvix+31n3P7RwU04cI3tjALA
 =
X-Gm-Gg: ASbGncsm05tu5t09AmnumD5WIfZ7b3xjE0MAc0MO9TstwcWhKsDjvhtcnU3+XLCx7oe
 RekBWJDLUxHE3kaakZaPtFUGNFTQh5ayoV1S1I679gK9cCBbKNlOW0XIHtArUzWjw58eAcKNu6A
 4msYTAxEw+8kSNHNoQy4a5hpnxEK7fAyBYBNWhxEQqYIXTWd0SXEDa4ekxlvVwVID6k52IaE8dT
 q+nlGsolnBSQyqqG3VNsUB5ryWLEXaJ76IjGoaJvvzWxOrFZgochIGJ5pea2QjaaS4QMBEIk+10
 6Od0OSxU8gAThMNsSK5B5l9x4Tt4qCE5ZMQ4jH61jQ==
X-Google-Smtp-Source: AGHT+IEXIX3W+4SI6wx0GQZn1BsjoXMMPD5AAFU/B4JcMz4YuMFCFw08PiKVY4yD3DLSjL4QQkWm/Q==
X-Received: by 2002:a05:600c:674f:b0:43c:e2dd:98ea with SMTP id
 5b1f17b1804b1-43d43842641mr33126685e9.22.1742396205512; 
 Wed, 19 Mar 2025 07:56:45 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 42/52] expo: Drop the gap between groups of menu items
Date: Wed, 19 Mar 2025 15:54:47 +0100
Message-ID: <20250319145512.2391122-43-sjg@chromium.org>
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

The gap is intended to separate options which are on different bootdevs,
but most of the time there is only one. So drop this gap.

Keep the code around in case it becomes useful to have it in the style,
or based on some other mechanism.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow_menu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 986334e95e2..ace89545fa9 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -117,6 +117,9 @@ int bootflow_menu_add(struct expo *exp, struct bootflow *bflow, int seq,
 	}
 
 	add_gap = priv->last_bootdev != bflow->dev;
+
+	/* disable this gap for now, since it looks a little ugly */
+	add_gap = false;
 	priv->last_bootdev = bflow->dev;
 
 	ret = expo_str(exp, "prompt", STR_POINTER, ">");
-- 
2.43.0

