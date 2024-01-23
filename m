Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE15C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9C1287D8E;
	Tue, 23 Jan 2024 18:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eysj9G0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C57087D29; Tue, 23 Jan 2024 18:17:10 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65D3787D4C
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a30799d6aa0so209558566b.3
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030226; x=1706635026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPHHlg9FdQ90XVd55iFRYgLj7sgCzPVYVcdb591IuIs=;
 b=eysj9G0CRf9cdGpOu+0tymsCX+lKt/eaBmgklaNxKYTliIsOHo5XMSSGc/hskW7uBj
 UQtaW0rltm5ZdvQpucMxtvbPWrzUhfqgT3mznAjMSVKU5cpme5N9TGPkjKcA5FL8nwT8
 +g2BQNcVZxdF/y0SdWquehpgnCE6mP5b2M1BQ+sRk3fbTR6ArTn2qm/K4b38QLhnA6Cy
 qJl1Z5KOATcc3eWz2Vso7NZltbD6WWk/XAPx1cX2ityB/G5wXUw81t/KQvqcDcxw9MIf
 AljQygud4/RVnAjopsaA0OG34InqHQ1ZtOKFqclkPbY6+f/JCcjwJ8qB+Pi+7oujN/m+
 AAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030226; x=1706635026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zPHHlg9FdQ90XVd55iFRYgLj7sgCzPVYVcdb591IuIs=;
 b=re5NZiw7Cfq/g6jR6QbHcK01GJqCKidgqTbibuXPjLdaYmkwJTdAhfoI5+VpEDIeta
 uZHLeAxOslkGu2425aSwnzdRSk+Fmms4bCwP+O7Jep9zDvyulPzeqlcz5zLi/+xqolvo
 UdGN+ZAJd5b7j7GXiwXl2fyhVKzfkm58Rbsxnnpl0GptRutTJmxg9o94UseJLizeLMV/
 W304X1FnweQhQ2KC8q65+LgFyeJIZYrjCa2ENpN8BvAn4wElaBni2GBU7ukTHLAqcOT8
 UwCVsr1BmuEgIy8Fe2HjsH4YAFhylZgNa+B0uaaM5EQdfB6sfp3Z5ZANzAo7U5vghiTH
 j7Ow==
X-Gm-Message-State: AOJu0Yy0BA8dqSmtB4cDAp5humGPBsI+r3ih/oTyCZvK2hq9kNjpUMsb
 BD9RAiztwg/WdjIdKJTXq3dOzVoQUo2ACIK+6wyxW7EYgkxEHpvH
X-Google-Smtp-Source: AGHT+IEwV3+A1fLHRbBPG66p/qQBFoqeZDNzqB9efp592OGEvwnamfAteo68Eztt2OoDpcjv/L67uw==
X-Received: by 2002:a17:906:5290:b0:a30:8d46:4cac with SMTP id
 c16-20020a170906529000b00a308d464cacmr132173ejm.67.1706030225719; 
 Tue, 23 Jan 2024 09:17:05 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:05 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 02/18] video: tegra20: dc: fix image shift on rotated panels
Date: Tue, 23 Jan 2024 19:16:17 +0200
Message-Id: <20240123171633.246057-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
References: <20240123171633.246057-1-clamor95@gmail.com>
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

Subtracting 1 from x and y fixes image shifting on rotated
panels.

Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS Grouper E1565
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 7605e77bc1..bcc2748623 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -242,8 +242,8 @@ static int setup_window(struct tegra_lcd_priv *priv,
 			struct disp_ctl_win *win)
 {
 	if (priv->rotation) {
-		win->x = priv->width * 2;
-		win->y = priv->height;
+		win->x = priv->width * 2 - 1;
+		win->y = priv->height - 1;
 	} else {
 		win->x = 0;
 		win->y = 0;
-- 
2.40.1

