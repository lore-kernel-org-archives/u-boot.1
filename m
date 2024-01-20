Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB97C47DAF
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 16:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA97787EF4;
	Sat, 20 Jan 2024 17:56:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tgx/aDJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DBD587E67; Sat, 20 Jan 2024 17:56:28 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A6C787D97
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 17:56:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a2c179aa5c4so185162866b.0
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 08:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705769783; x=1706374583; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZn6/uxg6r1IwvYRfh8ty8ZUnZEuYkBnACGTUPyycFc=;
 b=Tgx/aDJgbba0qIftmD7uj9240hMZRT8a3QOmuwqk5w0MpVnrnNT9t+6E2h4rpmOZyp
 Sl7UyRp2qA3EHNvrCb/lnr09+JHwWh/uKJDDClKPNB7B9OIxtQs2YbjQcq8Hj02PEXoj
 WPhNFBDeeKExj91h9CZf1ncrhkNMfeBDOXwL9JKK5dW+6mqJNb0JxKyjh+IH6GF0KWa6
 sQGFZaGcD/zf1YVtMLMOl2iAtN8xEo6v/qFo66pMSs7cv6XOiZndqf0KvD1X4+7ksljn
 8lAiTDnRQoF3qnsHFY69UqlZBSpqJqJN3+nnFyKBqmaY3Y7NPL9SbHLTSuTm53R9qb+2
 tQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705769783; x=1706374583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZn6/uxg6r1IwvYRfh8ty8ZUnZEuYkBnACGTUPyycFc=;
 b=hLvt82h67vvFnTmal0jf9PlvDgxHoRis8p5FQK1CayP//L4KPYUfyzPysEc4xCd9dg
 agmNgdzKtWIIGFxT3lPoL0O0/DgTqof/ugmJ5+AhI57+6T522UfGuhn/sYu7dPVRbhER
 fWRD/lJhZnQC8MTrYx5ZEXKqFB/T7KVNo2QaTHSQf0/l2L5JBEsgBerOwr/DrUWZ0HaT
 p8AOt1Rpw9cggvVce0VsFF3uVj6wyQVNSVI7asKRwgYJTGUPjrCUATKWFeOWGex9fQdy
 VW5zosiZLVReFHpAmuENth6Z+Xnzl3Hmyd3Wa9k70XPwK8Eazy/KbWiCWxFazj2yrUev
 rlfg==
X-Gm-Message-State: AOJu0YzbvP5x4Hxln4bB3nAK2QRTcJT2tqye+jG/Ji4xtyThXguNmS6c
 JBLY4oYWKRLWXrK9+wp+pEqnR745qRoiNYylgtpvY1o2nzXUL+rc
X-Google-Smtp-Source: AGHT+IGr1wM4WzO5iRgdk2XSsP0dNjmVPl4S/9gzyShD1SicmiTXjILQt7pVt0tuL7PoJvrjemwWFg==
X-Received: by 2002:a17:907:8743:b0:a2f:1687:f746 with SMTP id
 qo3-20020a170907874300b00a2f1687f746mr843643ejc.83.1705769783162; 
 Sat, 20 Jan 2024 08:56:23 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 ca13-20020a170906a3cd00b00a2c869be22dsm11311548ejb.143.2024.01.20.08.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 08:56:22 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 12/13] video: tegra20: dsi: remove pre-configuration
Date: Sat, 20 Jan 2024 18:55:42 +0200
Message-Id: <20240120165543.10226-13-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120165543.10226-1-clamor95@gmail.com>
References: <20240120165543.10226-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

Configuration for DC driver command mode is not required for
every panel. Removed.

Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 6408026808..e60a1d2ac4 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -766,8 +766,6 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	tegra_dsi_configure(dev, 0);
-
 	ret = panel_set_backlight(priv->panel, BACKLIGHT_DEFAULT);
 	if (ret)
 		return ret;
-- 
2.40.1

