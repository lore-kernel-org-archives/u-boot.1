Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED28C36002
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 22:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E20981DCC;
	Sun, 23 Mar 2025 23:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nLs0fnxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DABB81B5B; Sun, 23 Mar 2025 23:51:48 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0179481D3B
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 23:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anarsoul@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-224100e9a5cso68396435ad.2
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 15:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742770304; x=1743375104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IK0omPYIRqkfKY4cvUTfOeTIdmFuP5r2Baw6eoMbBo=;
 b=nLs0fnxQatpAG2bvuliVV7FJ+wZzl78vsq7R8S7wXH01uIfXX6GjoeHtzuKgeGOdO4
 XaVVFWBB/N1cYhpwEewT/Jv6v1gZWaSJnoBo5I0lFIUi7L4FnB4t7y7VT+krXBrkWSRp
 WGQU1Ekj8sj726ETjx+Oc+U8C1KrdaF4wx5w9NCZmaMHliel1DGb41YCoLe3KSwKKS7S
 6V2vFB51+yHQRI5RYM+1t7xVaoJwCw6YpfXbY54mNbOZ1FoEWhddVPWxEEUpr2kaWt/V
 adSt0jvbvtZhdEfneut2/g2a4kdXZbwRxUly5eWl5c8XE0ZdRrHjoDEkS81kmGjw+uYH
 2iNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742770304; x=1743375104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0IK0omPYIRqkfKY4cvUTfOeTIdmFuP5r2Baw6eoMbBo=;
 b=eP8l+ll6ZoHlenTIYTLSrrppl3ZDy9aNNvUEiwbbQI45Ff7AYyWieq7evBPcdExI6J
 RH1uLOMzFPQQqkpv1cwani0vhoH62nXgHfu0LWeK0FoP0by4585BSj/fKlQqjAsMDiDo
 ykO+l11aKpnslGfvDINcNyZMBDdw7bdUKCOlw/ahQ5A3u+g3OcnQFiYYvXjW/OsqCybs
 Sn+o+0G61DLyv7tNluSUPgkvpnYHHFpEoMhpj6WWiwPInSpiTVmJVXupDSADe/eg6T5G
 YZuMC1MvVTLdnqDQgHo8xq+CLoo3e7VeE4/AmHxjpfCckRZXuliwTQPLTDK7I1iJz6B4
 n6lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9l/4MNtlFN3XXQnVzQPlLWy111pcmp2Wwv3iWQNOAwDH7obwotjSLkJYHH9IxiDEPk/NuMtc=@lists.denx.de
X-Gm-Message-State: AOJu0YwJ+Jw9Ll4g/Jr1zgnvY5ShWSM4eRKRK6XPiqgczxVuNQD5Qbiy
 6vGXGK/bD8c1eT3RQZLRrKs3PPDqFG3PISUn9LaEEsSUEjuR1NP5
X-Gm-Gg: ASbGncvnd1MLlw+PjTEsLdyUiC9ylrn5gvT24NRQ0LzrhwszDmvJRoWPhBMPfLQT5jc
 nkYnRI2zj/BtP1WgX2jSOJ4PAQpgmco4ClrlIy47KKqgQcIn61Nl+hd5i786inMqoj1cXuafbey
 t3wSqUe9cj0K4o6AWRYuKTyNouDUXoNAewxqW1KH5pA1963NnIYHlKiVeDlyjgGd48YVDxzeZ1U
 ZNl8ADTyKzYVbxRWCTeGVwoVuMSpfo+daaXg+I5A83J1DL/qaXS0MX5yx9Z7PsUoJEG/P3SiwEP
 5AYHTUz+vattcnS37CmkGFnCE3Bb3jvVDdyU
X-Google-Smtp-Source: AGHT+IH7jT4IxjeRd4hrgaVjd9GD1NxulLIS4eXAi8pvtH2j6BjzEeHB81ZgWa/qtnT+Bjn+ijFepQ==
X-Received: by 2002:a05:6a00:843:b0:732:5611:cbb5 with SMTP id
 d2e1a72fcca58-739059d770bmr18121330b3a.11.1742770304317; 
 Sun, 23 Mar 2025 15:51:44 -0700 (PDT)
Received: from anarsoul-xps15.lan ([2001:569:7d4f:2900::398])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fab628sm6368536b3a.6.2025.03.23.15.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 15:51:43 -0700 (PDT)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Anatolij Gustschin <agust@denx.de>,
 Jagan Teki <jagan@edgeble.ai>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v2 2/3] video: rockchip: rk3328: filter unsupported modes
Date: Sun, 23 Mar 2025 15:50:57 -0700
Message-ID: <20250323225134.2369473-2-anarsoul@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250323225134.2369473-1-anarsoul@gmail.com>
References: <20250323225134.2369473-1-anarsoul@gmail.com>
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

While RK3328 is capable of 4K resolutions, dw-hdmi driver in u-boot
seems to have some issue with 4K. 1440p or lower works fine.

Limit max resolutions to 2560x1440x60Hz, by filtering the modes with
pixel clock > 297MHz

Fixes: f3ea872970d603 ("video: rockchip: Add rk3328 hdmi support")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
v2: add a comment that max pixel clock limit is a workaround

drivers/video/rockchip/rk3328_hdmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/video/rockchip/rk3328_hdmi.c b/drivers/video/rockchip/rk3328_hdmi.c
index 763669c09be..ff351aaac7c 100644
--- a/drivers/video/rockchip/rk3328_hdmi.c
+++ b/drivers/video/rockchip/rk3328_hdmi.c
@@ -105,9 +105,20 @@ static int rk3328_hdmi_probe(struct udevice *dev)
 	return 0;
 }
 
+static bool rk3328_hdmi_mode_valid(struct udevice *dev,
+				   const struct display_timing *timing)
+{
+	/* Limit pixel clock to 297MHz. While RK3328 support higher rates and it
+	 * works in Linux, it doesn't seem to work in u-boot. That limits max
+	 * resolution to 1440p
+	 */
+	return timing->pixelclock.typ <= 297000000;
+}
+
 static const struct dm_display_ops rk3328_hdmi_ops = {
 	.read_edid = rk_hdmi_read_edid,
 	.enable = rk3328_hdmi_enable,
+	.mode_valid = rk3328_hdmi_mode_valid,
 };
 
 static const struct udevice_id rk3328_hdmi_ids[] = {
-- 
2.49.0

