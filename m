Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD614C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 719E287239;
	Sun, 12 Nov 2023 21:03:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E7vgVRQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41A9687125; Sun, 12 Nov 2023 21:03:12 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 311A3871A1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3594c100735so9276295ab.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819384; x=1700424184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N01xdQnRqSiOiPSHeROMKytPElnZ4+m9DHozO6Y+2tk=;
 b=E7vgVRQ/WDmCsZmrgi7YXKUstn4/3gWnPhuR/uxjOHgCwnsdfofGiB63axorQRS25K
 t7uMBIj8GeEXV7mIwgZKSoXgt7dzQKH+XDzo7X7SD3n4gdeJuMOrYhiyxHfPxaDvKCGs
 QHESBifXJRNYgPSEIHXO36tAfdfLiAjDw6tb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819384; x=1700424184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N01xdQnRqSiOiPSHeROMKytPElnZ4+m9DHozO6Y+2tk=;
 b=bvQ/Y6btlQcSzH/ybVVRnAsSqRat+zFPoKP7vHCk3BWGXUtvO5LNHgGq3y6SczvplL
 OB+/AklTAxsev65G+hcojo2/3zM+2GuazQRYwvU8FhSyXjYpDno5AMZ+nuSxmdUXMOyk
 VAGBrRzF6ha6Hqv0ggRV57SY+4OknV3hxiNddp5+4xfS2cBpNxP71tQ27Guh1ioeJZLc
 uic7Ncfnd/lMYw9Nnk01SdJgHI3jfZGjfDafkSwNjoQKhOESDTMJZ/usHscDHxE8Dr3U
 lMyNgCsUGjZWO0I/sPyLRCAj87PelVUOYxk8Fz/tMr6yzffdYzeinjo1MR6OeGV6IeAT
 jtkQ==
X-Gm-Message-State: AOJu0YypeuPCSWcYFblWaWIVpFHpD5lMAO8kTjZ5QTaO4ee6L6E8mKUx
 SWOOQEL6TyezqU2ii92zPELLrWNQULPMZrRUs5c9Aw==
X-Google-Smtp-Source: AGHT+IFr1n6awSCXnruywWuZ0g7aoiDOhzr9JdT9yw9NYBQqEkfaWecdGvAglDmrzXLCwU8qJUaw1A==
X-Received: by 2002:a05:6e02:1ca8:b0:359:3294:91a9 with SMTP id
 x8-20020a056e021ca800b00359329491a9mr4678515ill.14.1699819384795; 
 Sun, 12 Nov 2023 12:03:04 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a923204000000b0035761b749casm1208256ile.46.2023.11.12.12.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:03:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v4 06/12] expo: Correct background colour
Date: Sun, 12 Nov 2023 13:02:43 -0700
Message-ID: <20231112130245.v4.6.I0229a119165879ecce6bafc8568708326bf5ba78@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112200255.172351-1-sjg@chromium.org>
References: <20231112200255.172351-1-sjg@chromium.org>
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

Use the correct background colour when using white-on-black.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v1)

 boot/expo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/boot/expo.c b/boot/expo.c
index 139d684f8e6e..cadb6a0ad6e3 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -190,10 +190,12 @@ int expo_render(struct expo *exp)
 	struct udevice *dev = exp->display;
 	struct video_priv *vid_priv = dev_get_uclass_priv(dev);
 	struct scene *scn = NULL;
+	enum colour_idx back;
 	u32 colour;
 	int ret;
 
-	colour = video_index_to_colour(vid_priv, VID_WHITE);
+	back = CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK) ? VID_BLACK : VID_WHITE;
+	colour = video_index_to_colour(vid_priv, back);
 	ret = video_fill(dev, colour);
 	if (ret)
 		return log_msg_ret("fill", ret);
-- 
2.42.0.869.gea05f2083d-goog

