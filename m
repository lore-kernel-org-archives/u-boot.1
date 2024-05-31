Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A301C25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D8B887DA;
	Fri, 31 May 2024 16:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WBewpLSM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04410887C7; Fri, 31 May 2024 16:19:16 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE11C887EA
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70234297ef9so1719973b3a.3
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165152; x=1717769952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jS/rYDAQ1xa9Q+qHSkaY5aRH65+EVGYXvZS6VR4uDs=;
 b=WBewpLSM906pjukmpWoz75CBBfhjAUNCIX8DM+y8zmdD+AOfQMSwK6KoVGHCwvU1JB
 oRBhjFh//IHiCTf5PrL8+K8a9B4OfbKbmyL1auYVyK3C7YpbBfVgmnXhMYjYYUJvKHjc
 CoRSAQpUppPPJJnX89j+yLwqZblgNDoX9m6Il3NuXSXRK9nAMBGaA5i1Q+dND1FJ4sgc
 rURnhIVcxJLzePsm0zC5YJaklRW4Tkt8HB6NWdoxe3WDqlo05ap762pvxyOnwctN9KhQ
 MCTASkzYpsT6JvDHnf33i6zLwF7SlUJno1RBXaGL/puj86M7zFwwHa9REmIk8fmyTIOQ
 Ag8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165152; x=1717769952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jS/rYDAQ1xa9Q+qHSkaY5aRH65+EVGYXvZS6VR4uDs=;
 b=SNfY/+88NVxNzOd35hHQ7RzVZkaaWxn3BZOhnkI+suqk26k8UHi0N96+VNrIEOZvGz
 4soarac/VX57S2hZl8gtEfhEsiAu/C41JPixI3wUJvbEZONkn5K2QQa6U8uebKRYJUlC
 /igM+uhNcLNVzuyAtDsY/JYDfnlcaTfd4RUWCQoE7F96Et4k9+Aq1GM/J+fYVT0gx2fu
 UPl5arFeiR1NELTnzY0XLOPsTDIGhQd+TA2h8wQIQwfynTezd021tx2xAFBy/lntpqg5
 9seorENrvt0LCxG29QAOcz6RdJqD2spqAawINy7hoUZE/8L5jnqEk+sl8d+BOr7oZOqj
 nFLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeOlOvCqGjWOm9UWBPzKU7csrr8QEdATdG1BTUIlFO/5y2BzQpIMYP07LtjdvoF8ibuygI6WC4oG3p62Q5PrnKtUFG2w==
X-Gm-Message-State: AOJu0YxgZhttADjbtArNJiEhGQSzrfXC3+PY3Fu3FKVwIeJdSXVs9tTC
 Wi2ZrMEef7F+/NsLbpC9W7+pSO6FiHiI5Hc+8QefhG0WxKNYpt6g
X-Google-Smtp-Source: AGHT+IEBk4ctarbuNyQRu3f+CvuANTUj9EUGKNfb6VoktNpzst+UKZJNVK00jrkUdX1SPlTERMFhzw==
X-Received: by 2002:a05:6a20:3d86:b0:1b1:f3d6:18c0 with SMTP id
 adf61e73a8af0-1b26f12170amr2667046637.19.1717165152302; 
 Fri, 31 May 2024 07:19:12 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:11 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 06/23] rockchip: RK3568: Read the reset cause from
 clock reset unit for RK356x SoC
Date: Fri, 31 May 2024 19:48:20 +0530
Message-ID: <20240531141837.13189-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531141837.13189-1-linux.amoon@gmail.com>
References: <20240531141837.13189-1-linux.amoon@gmail.com>
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

From: Anand Moon <anand@edgeble.ai>

Read the reset cause from clock reset unit for RK356x SoC.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/mach-rockchip/cpu-info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index e7cbcf5090..e12f84a1d2 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -18,6 +18,8 @@ char *get_reset_cause(void)
 	struct rk3328_cru *cru = rockchip_get_cru();
 #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3399)
 	struct rockchip_cru *cru = rockchip_get_cru();
+#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3568)
+	struct rk3568_cru *cru = rockchip_get_cru();
 #endif
 	char *cause = NULL;
 
-- 
2.44.0

