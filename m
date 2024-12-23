Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF00E7718D
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 07:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9CBC806E5;
	Mon, 23 Dec 2024 08:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kZVwmUc+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28D65806DB; Mon, 23 Dec 2024 08:07:17 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 341A880642
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 08:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa6b4cc7270so571458166b.0
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 23:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734937635; x=1735542435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyBNgAETSmhj1zDkYdHRiWuD4zt0sS37ize3kFmuXLQ=;
 b=kZVwmUc+YByX80U/OeQBtCpfx1JIX9QcmCa16UCFvjbK7tC1PexMQmFz1CYm2cEswr
 VzQULNHAvomZ3tldl9rCNb/C/RjR9MYVQa1fYzBjL4aJHLfkLenoS0YbuC3t7BT5LhCH
 SVwZX6Bfn9XFn1KcrrwVgJBOO1rRn0emjX6RdWFrcXsRKXUSi5q9T9IU89IJAe4C0eaV
 5h1P3VTt426DbLvWny6lcsRQ5VewC5ZHbXT7FMILS27HnY0zwHFc5T3xWIWaIxwBHCFX
 lA6PMxcp5vJpp222qUtKvWm57OsooP/eZX+uYTbCDX7P2gsBzk0h78UY1Y70ZLjL0cFg
 SB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734937635; x=1735542435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyBNgAETSmhj1zDkYdHRiWuD4zt0sS37ize3kFmuXLQ=;
 b=agmjnP8b092Jub0lUJZOZzLSGj5p7iXSJvr3uj/ONuIqnjzwK2nBYT38YHp80zWSM6
 jHVIPe8Ry9AekZTUpYujQJWxRUvQd2XK7/9gZhWsFCOD3t5I+xenzZ9CLRsfAdqHHHKE
 LItRf355E+k4staJKTbiwZ5qmaygpLBHrrDW1E9FKwxDeu5NPmj3z83k67g85W6cPLu6
 5N8IC2wiYVzgtB+cYgrS7wdN9pwcc3cBoA3keTYQsloTwYNi7MPdiE3ypn97H10xFuHG
 asxXvL8eWbBHReHYhqZQJ2rye3U8E7/O/LS4cQh8F4zQYeIpcy5/tPB9mFrbhi/jHW0s
 yigQ==
X-Gm-Message-State: AOJu0YzdR/GOiURs6XMjceXQPKgHVgr42z/EkryVZO43NYYfmMt35UwZ
 XEOFucScGyf1d7cwvz4BJ7Ip6hrbKx6zwPQTte24eyshg3k2qcEH
X-Gm-Gg: ASbGncv+eCS09iz3vBnIeVBu7aiSCLwoE/QYKW9H3t/VqY5fm5tLLAU/UqzkIsc86uN
 XB4FaBPzcdNXq4XDrUTYbfH20s8A7ar5oTNUuK7xwNz7+Kt1GulyfJCysR0wbNQTVXvLUl4IG5q
 HnbVGjOhHruLBVwkNBs6ZHUeWB8bbVcnwk9SDKFEsAzpbYTev54yAyyzeIn3qyh6IZ7EBijk8C3
 HSplpA4KI+v58eDU4iEcJkZwYQLF4wSha3VPOnKwS2uTFlE
X-Google-Smtp-Source: AGHT+IE0+hiY9lfmK3E75gI+0rJT2q9OZWLYK2QXGv2jY12dWdoqc6zRgUIe8hLyw036baRl4l8q8Q==
X-Received: by 2002:a05:6402:5189:b0:5d0:81f5:a398 with SMTP id
 4fb4d7f45d1cf-5d81dd846ecmr25928134a12.1.1734937634423; 
 Sun, 22 Dec 2024 23:07:14 -0800 (PST)
Received: from xeon.. ([188.163.112.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80678c8dbsm4511895a12.40.2024.12.22.23.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 23:07:14 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/7] video: tegra20: dc: dsi: add Tegra K1 compatible
Date: Mon, 23 Dec 2024 09:06:33 +0200
Message-ID: <20241223070638.35748-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241223070638.35748-1-clamor95@gmail.com>
References: <20241223070638.35748-1-clamor95@gmail.com>
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

Tegra K1 is fully compatible with existing DC and DSI implementation
using Tegra 4 data.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c  | 3 +++
 drivers/video/tegra20/tegra-dsi.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index e366df9ab51..16a2b5281bf 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -553,6 +553,9 @@ static const struct udevice_id tegra_lcd_ids[] = {
 	}, {
 		.compatible = "nvidia,tegra114-dc",
 		.data = (ulong)&tegra114_dc_soc_info
+	}, {
+		.compatible = "nvidia,tegra124-dc",
+		.data = (ulong)&tegra114_dc_soc_info
 	}, {
 		/* sentinel */
 	}
diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 0b395dbf9fa..b57df6b82bf 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -1073,6 +1073,7 @@ static const struct panel_ops tegra_dsi_bridge_ops = {
 static const struct udevice_id tegra_dsi_bridge_ids[] = {
 	{ .compatible = "nvidia,tegra30-dsi", .data = DSI_V0 },
 	{ .compatible = "nvidia,tegra114-dsi", .data = DSI_V1 },
+	{ .compatible = "nvidia,tegra124-dsi", .data = DSI_V1 },
 	{ }
 };
 
-- 
2.43.0

