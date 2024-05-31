Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F3AC25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFCAE88802;
	Fri, 31 May 2024 16:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jw2a3yKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C5208880E; Fri, 31 May 2024 16:19:35 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1511D885AF
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-6c191abea71so1212868a12.1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165171; x=1717769971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EBP23PYfJ6fxra0ga7mTMdMDm8jWS4WQt5Y7ZkYS/U=;
 b=jw2a3yKpwz7O1/96pSXn+aqtF6RFOUb08LaVFruk6ZZ8u4trl/+WIDy9rvg+Ep3vwW
 h8xxtdAjJbtrm0jdMY/noP2mf8yv0Y8vrIYJpmNmDsKxBiPw7DFbtUco3P7R7gWRSzMu
 FtCIXuSCZCWqDEQEjXc9FF8f7m5IzkwP4zJYsO/rTjiUAfFoJb2fG9bEFiznb8b2iIse
 CivnI3QFEKvkgjMZEg37Uf6lSe0qgrPUI5aJzthZKixmmS7FDSasF76l+aOeNLeSByxN
 kQY2GaO6V7E7yYnpQJL3r81yRif0JeGgFVPntK1sF33vVqHxBLixysHiO5Nq7ECg0hY/
 iyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165171; x=1717769971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/EBP23PYfJ6fxra0ga7mTMdMDm8jWS4WQt5Y7ZkYS/U=;
 b=U5u18FJEDcIs1UrGnzgkgLMoi3iSD5R5JN+otFJ4BEDmGm/UO1fjBmnhgtE2z2if2h
 UGhY0gsKpAui7gLeJqLSvWPcIoGTIlw9tzAN0MyfE9DqkuZcWx7Ch9NtLviMuDCZu8jx
 0MYrK+r6PjrKAY32MMASHOk4vmE/aP3ejtazfJBI9JmafjpEbIovCLtUqvrxuzvMRzK/
 lzMRB416e1iJ35jSfEje9APtx7SJz3j+Kp1+vLb3Ks9A3M7ohkEK/lCj2uBrmEyBLJAt
 QGSBssl7dQZJ0nZ+O7KJwabBvmkVcNckU6n52lHYwkF886ogcvDXoWWMn058ZKgdgq+L
 Dgqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAOhUO6fXKcd+uuXMQtdARp2wqAWW+AYpbhTlG/2NSEQvCbXplUh+92/7odCV9Sfp6JDFT7eqsg0Tl6QkxcWJyyUK7rA==
X-Gm-Message-State: AOJu0YxdjHbaUuHUJGgT8bfCtcSPe70aQY0GbKxp8qW8Y1VdmbTja3KF
 lTZ/b/aPaon25j1peNXhJrGJ1b8dZyLJOPP8L8n18EOobTugJzPr
X-Google-Smtp-Source: AGHT+IG44PFwGPM8Wzfdf6BxyUgbJ+mwB6fcGVbY3p6BHlkKA8ZV8LATVKDIE4OE4n36aIEZsUX9Kg==
X-Received: by 2002:a17:90a:cc0c:b0:2c1:a7e7:bb1c with SMTP id
 98e67ed59e1d1-2c1dc573627mr2024407a91.16.1717165171589; 
 Fri, 31 May 2024 07:19:31 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:31 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 12/23] rockchip: RK3288: Read the reset cause from
 clock reset unit for RK3288 SoC
Date: Fri, 31 May 2024 19:48:26 +0530
Message-ID: <20240531141837.13189-13-linux.amoon@gmail.com>
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

Read the reset cause from clock reset unit for RK3288 SoC.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/mach-rockchip/cpu-info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index 9be28754fd..383aa3d2ee 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -24,6 +24,8 @@ char *get_reset_cause(void)
 	struct rk3588_cru *cru = rockchip_get_cru();
 #elif IS_ENABLED(CONFIG_ROCKCHIP_PX30)
 	struct px30_cru *cru = rockchip_get_cru();
+#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3288)
+	struct rockchip_cru *cru = rockchip_get_cru();
 #endif
 	char *cause = NULL;
 
-- 
2.44.0

