Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20E2CAC5AC
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 09:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE508340C;
	Mon, 22 Sep 2025 11:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YaE2maWm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88784833F9; Mon, 22 Sep 2025 11:36:54 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E79E3833E8
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 11:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so2787256f8f.3
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 02:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758533811; x=1759138611; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGu4/bXKM7lUcNH48gpVT0m2A1N8DJGofrMOFUm9XqM=;
 b=YaE2maWmIXw61hfPQOl+AwIrOZ1s46DWjusNWtPnTAq/9UMli/SFFhNVyw4W/+581C
 YNJfivkOiqqC1+xL6ocW+Xdic17f7p8v3ghwv6pAJG/PbnCZvFgkMIrmMiOLp2bUmhXl
 mXSSINefK0Tlbf1ASTpRXaPU1Q83/R/WyD3QKixlxgDQ/ZinP9RdspdUrqx6sQ7R1Yv4
 E1+/Nf99RtSW2h+H0weKTBf/IGH8rMbn/Z1vXSlhx0ppYzYwAnVbErNaqacn9A533OzJ
 +FfKw3VBVEX4cpDwj/v+c0MZ6iG95/VSKtgQQJcDCqQ6QYcdEySAlmRfu2mUOZsbLHYX
 C2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758533811; x=1759138611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGu4/bXKM7lUcNH48gpVT0m2A1N8DJGofrMOFUm9XqM=;
 b=QkCSmfTkuKtckyFv/Z43cURev3HG4DJMUqZR5dqAFD++yWICLq/gSFkGuZb1e+Xw4i
 DnSUpC1VUmLkdooJnWrhWAZhxNAH+lNEAVDtmRzei1oA37me1I7O14PoaJzDvjvqsrI7
 85BAJ4j594+1dyv2ZBLpzmub2JFtws5hz01w00OqsMQ62zDgKZ8FwhAuQzY/YVE4UpF1
 Aw27PbfIPHmi2xSO8LGv2VJ0KjzTkyBvVs8DVX2BlIIoQAIUaS3QwhY6OYTWMy9JfDCe
 I+e49CNwkZy7kjQmzwnu+bbGScN3NKn9NUdQKPwa6egBqIXWMk8rXxwmZp8Zqa0bWZhm
 fNVg==
X-Gm-Message-State: AOJu0Yya/pma8m91H9nociw3LVwuBTLnBpsMsWMC9TwaL+wufndpISDO
 a7aop4nZJAuLNToVkr0cSTKifjwVm2WcR6u4XciXm5sBo2njn3J8GNbBStAdzmz6ZqozOuoGxiO
 Kc7DVH2U=
X-Gm-Gg: ASbGncsnKBxpaRf3cguNXlwleypQOdd9oBDlqYAPwgck9FHlu+WlLySBV5+2NRVWVxE
 JtosvoPM2MZz2ZjOk6xhZYfRnYQrp2oxEAyM5Lx2RsOHxmNNtAk+BlRKlJE+bKepLeRRfM58qkR
 SjX7sRHU43Sy/aL3uk1bIkAbWj9Mqu93/ytc5MY9is9op5Yttkz/Fi+C8vM6laX5oHX0Fwtodvs
 s0HMFVLUwpEndRQYCY3MEf64zrin2trBQozpoOiqxgG+OBu4Uxj9LYcYPq2zoyXPRLVKb0mwPAM
 VsF+oImnP19e+BvAHqffSbdF5NYFwVqCP2UgQKzcKmwaEGRiuDXlEDKtKFio5eagDLhKSsLbp4R
 HDrvRGt6PKwwtvB1OyvG/Z9DT7JOeXwJWIvFvLbs1PA==
X-Google-Smtp-Source: AGHT+IGZW7ocznOByua2DXjKz3LeFqfuXti8W51l46/loTqsiR5FkkURX/BYdsFp/zTlSc785IcsIQ==
X-Received: by 2002:a05:6000:2f83:b0:3d3:1ad0:e8b7 with SMTP id
 ffacd0b85a97d-3ee7d6864e9mr9693019f8f.12.1758533811162; 
 Mon, 22 Sep 2025 02:36:51 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:fe8b:a136:2e69:4bd1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407d0asm19177840f8f.17.2025.09.22.02.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:36:50 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] net: lwip: dhcp: make NTP servers usable by the sntp
 command
Date: Mon, 22 Sep 2025 11:35:42 +0200
Message-ID: <20250922093629.2547703-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250922093629.2547703-1-jerome.forissier@linaro.org>
References: <20250922093629.2547703-1-jerome.forissier@linaro.org>
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

When both CMD_DHCP and CMD_SNTP are enabled, one would expect the NTP
servers received by DHCP to be used by the sntp command by default. Fix
dhcp_loop() so that it is indeed the case.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reported-by: Michal Simek <michal.simek@amd.com>
---

 net/lwip/dhcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 4c9cb0ecaa07..cbdfea3ba82a 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -8,6 +8,7 @@
 #include <dm/device.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <lwip/apps/sntp.h>
 #include <lwip/dhcp.h>
 #include <lwip/dns.h>
 #include <lwip/timeouts.h>
@@ -48,6 +49,13 @@ static int dhcp_loop(struct udevice *udev)
 	if (!netif)
 		return CMD_RET_FAILURE;
 
+	/*
+	 * Request the DHCP stack to parse and store the NTP servers for
+	 * eventual use by the SNTP command
+	 */
+	if (CONFIG_IS_ENABLED(CMD_SNTP))
+		sntp_servermode_dhcp(1);
+
 	start = get_timer(0);
 
 	if (dhcp_start(netif))
-- 
2.48.1

