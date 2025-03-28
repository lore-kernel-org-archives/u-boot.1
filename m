Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A05C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 225CE8214B;
	Fri, 28 Mar 2025 14:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IvdFxlgh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A1A81E3E; Fri, 28 Mar 2025 14:08:39 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ABFD81273
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d4469b35e4so17948935ab.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167315; x=1743772115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wR/TftPg5DusnHiWl/w53EMK1rbwnUKO+9RsTnqzRpc=;
 b=IvdFxlgh2u6nwcW69L8UaNjnbHVXzjYDMOEe8VRB4z7WYk1eSsoPIekp5Ao69hX/VN
 9Mm4BM2pDsyZV38EA15Lf9HtDWVFsf7BNjwVl1I/6X+pwLob/TxxGYhvNaeF0d/Vq0zh
 /Iz3riSBnxIy+NrJA6yxqoMmya9ZWrwwjDENI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167315; x=1743772115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wR/TftPg5DusnHiWl/w53EMK1rbwnUKO+9RsTnqzRpc=;
 b=xFgZPDOtE7dB0rdZdMwTEuzSZy9UzH932WcorDwvGqWdqj/u0btufgKt5dTCTkAYVl
 l2XrFTUPLhu8X1lCYT0dsJAyegV4Pbu+jPx8hu0QxtfNXVhvWRzVgeWWIWRlOKXeOSF0
 lBHPYNFaRJgY3hEXGBBiTOMalIMF5A9yBio+owxlVqRKnTFpKF0PXM3oR7YtHN4y00IO
 xZNuVxdIL+t7LU022q68KFtxaSAijh9qHv/G2Hd19pt+zk/qvBwHakaYyT3DnLCTysbj
 TOOJlA36eP7Syp74refRiWq+1LfEVEBvRkFYxfJyUMFGOeVZ8y8igF5EzgU46P6usldO
 XWyg==
X-Gm-Message-State: AOJu0YwwlLzILnFXDN5omUuGTUJdAhb7GVzsQF4HwCUpk+DEBtMUTV1O
 mKn9AbY3aZ4svfRXVRC8QSjq4pc3iqxTrt7AKYcNddD1tufqvBlMPTzJNNcPsKcC1TKcXNNkqXg
 =
X-Gm-Gg: ASbGnctCNlm2/P7WpNlK68V1rgjdWeOMy3uIluY8+ZOrfM06jtJ+FYni1JAhArCWNGb
 HBpquib3bTkYJyyjbHD8xzyeL1HeRJB6lrpnBlGW+4yefYDuL/NVeDPIj+K4UMcWru0sAmyNLV7
 kRcf3XnCqNQz9KkMx20ad1J0cOaPWGuxqXi4oO65MF9tYVvdkTfSzJgG06vXv68/tdbPp6SY4bw
 9aBQCT2ZoqcsB47hfbpqBz43cL5oalG3SBBvAFoGbeBVGEqlaoqhTu/YsT4GqaixexAc5ZkfR+B
 oyT/k4bsq7vblctOj0GCP4QeuHGpm3pczo9YoyPfOBNLk41+BzLaA20fBUrr1opE+sggjnL7xe2
 rsDorDQ==
X-Google-Smtp-Source: AGHT+IEHZ2L8MVYM6k8tjQKlvV5wsf7VzgVuatGIXnM9F12oO49BlMDylVc8YI2gYEjFx0Sj4PhUNQ==
X-Received: by 2002:a05:6e02:3004:b0:3d3:d823:5402 with SMTP id
 e9e14a558f8ab-3d5ccdcab08mr88247795ab.7.1743167315243; 
 Fri, 28 Mar 2025 06:08:35 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 41/56] expo: Support white-on-black in the theme
Date: Fri, 28 Mar 2025 07:06:28 -0600
Message-ID: <20250328130713.2612648-42-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

Allow this setting to be controlled from the theme.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/boot/expo.c b/boot/expo.c
index a0be1404f1c..4e855f60d84 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -277,6 +277,7 @@ int expo_apply_theme(struct expo *exp, ofnode node)
 {
 	struct scene *scn;
 	struct expo_theme *theme = &exp->theme;
+	bool white_on_black;
 	int ret;
 
 	log_debug("Applying theme %s\n", ofnode_get_name(node));
@@ -287,6 +288,9 @@ int expo_apply_theme(struct expo *exp, ofnode node)
 	ofnode_read_u32(node, "menuitem-gap-y", &theme->menuitem_gap_y);
 	ofnode_read_u32(node, "menu-title-margin-x",
 			&theme->menu_title_margin_x);
+	white_on_black = ofnode_read_bool(node, "white-on-black");
+	if (exp->display)
+		video_set_white_on_black(exp->display, white_on_black);
 
 	list_for_each_entry(scn, &exp->scene_head, sibling) {
 		ret = scene_apply_theme(scn, theme);
-- 
2.43.0

