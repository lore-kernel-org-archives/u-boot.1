Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08DCC28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08E881E47;
	Wed, 12 Mar 2025 19:15:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RtgeOEU+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B6A281DFA; Wed, 12 Mar 2025 19:15:47 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 215278141D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e5cded3e2eso106591a12.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803344; x=1742408144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EkjX1Vr1ZsnXRH5MwJhBcRk5RIbotJNwdEBOvAZTGgM=;
 b=RtgeOEU+hE6LZxoN+YF58/M+Ve+S6Krcb4BIPhN5bmjie42+M5OjUJtww4u8OqHNnr
 gINglQpaou2RIgCxiMCcm710tcHDsQ2P7TqP45qSRi2VT8E48DzWOJSJCyZr4kwm2svj
 IPBugIjrVwEXMPBfK+kUTpbSi/X+jOy/qVLXS5DO1cHafJpBhA916XaBlElEIjuRkSMn
 8li89WOb+3dZdf70D7SJ+Rn1DJdaMR9hVJJQVQkvj8Zj8nJdiYHI/SPBUk0WpauUZCB6
 L3mTHKQNA0hFCX3apdid8c9OzMu9RTUFjOqOhZq4oTdpazBkOQvbletlnNe0SiS6GOVF
 jvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803344; x=1742408144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EkjX1Vr1ZsnXRH5MwJhBcRk5RIbotJNwdEBOvAZTGgM=;
 b=ZAZdooOe75hyUad5uwDcvMxAnFiX38A/e+Zrf1vqIR6/+1rolmtsMMCZ+pmk0qqfr2
 Nvpk+YhvZ6xB/n3hvENxyrt67abCBPqUxneFw0CzHsH75cbqq1FTjFBUwWgoVVRwiL+b
 yuDxYVxjUy1cHrFRKvJKJ3p9R69B48YAD+zIkrFCG+lk0kiGL9tb3MxFdfiHz/BS3Flm
 qtKTKem1MrAdNNPeINiwp8cfrnbvjWqIZQAedaFU1tPz2WctItbFhP6ZZpR2/yuB4B7s
 p1Eob2yJEN4FBfLWA1eorMmhkplFJiIAzwdxFbD/qctwObfvBGH90JvC8YF5nGirjFZh
 qNNA==
X-Gm-Message-State: AOJu0YyiFvU9mJ2L8M9iTfQSGKwpEOE3B+3XmOT16bOHmuDjb4/hxY9/
 Cb+XBl+3MzBlxpAQijdb5Yc3pOMMFi8TneKYx7azpLByzDp07iEqGZ6myQ==
X-Gm-Gg: ASbGnct6+gBRt0hUngxICSDM+l6FJBfz09trCLYo2JfqJcYAfF+LQfE54/2JZy8eaws
 TYnuEogLnKRWnKpMPFGIJI7AkQJNmCBORvlLcnWhllo7pzBFxM0iU7BgKVymmmmr9HE7KwAu11B
 nCnSndzQDjIBI3/3piPf49+5cV7kfPWjtyTfQXhvf+rr0NyR5/Nv7DmTVvZSd5gRULD0GMQqKjI
 muIoEIbnkkjT5+8wQwsCZGL836iSghmVcxLB19SSnwEobcosEFJ5cesRwlU+CmuMOvqm5It+mRx
 18lyfqqtEeVCjzKdwo3g9g/CCnEHzhlv3hWE
X-Google-Smtp-Source: AGHT+IHW3mwcT8pE615iDHJ6us2p2C0oSUhMqub2koM5uye90/bHHBrSCcLCVjad51SwnlVUc+qGgQ==
X-Received: by 2002:a17:907:9391:b0:ac2:c41b:f32b with SMTP id
 a640c23a62f3a-ac2c41c0272mr745945666b.28.1741803344409; 
 Wed, 12 Mar 2025 11:15:44 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac28c11561dsm641906666b.145.2025.03.12.11.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:15:44 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 11/11] video: sharp-lq101r1sx01: add missing LPM flag
Date: Wed, 12 Mar 2025 20:15:23 +0200
Message-ID: <20250312181523.121313-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312181523.121313-1-clamor95@gmail.com>
References: <20250312181523.121313-1-clamor95@gmail.com>
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

Add missing MIPI_DSI_MODE_LPM mode flag.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/sharp-lq101r1sx01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/sharp-lq101r1sx01.c b/drivers/video/sharp-lq101r1sx01.c
index 5d8453fd796..4fdf0da8a94 100644
--- a/drivers/video/sharp-lq101r1sx01.c
+++ b/drivers/video/sharp-lq101r1sx01.c
@@ -255,6 +255,7 @@ static int sharp_lq101r1sx01_probe(struct udevice *dev)
 	/* fill characteristics of DSI data link */
 	plat->lanes = 4;
 	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_LPM;
 
 	return sharp_lq101r1sx01_hw_init(dev);
 }
-- 
2.43.0

