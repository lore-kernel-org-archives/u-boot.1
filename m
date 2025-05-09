Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681E4C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 07:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F25829CD;
	Fri,  9 May 2025 09:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mt+SmLiO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F37F829CD; Fri,  9 May 2025 09:03:35 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E6EB8210D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 09:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b239763eeddso401757a12.1
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 00:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746774212; x=1747379012; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7ltAtejEdAV9MZhiUQDNqnwnzqsCUJMvK6vihAk1oc=;
 b=Mt+SmLiOs1Pse2TYNCOR6sguRK8lmTeD6a/IDQxW9yb+wc0NhiuHPGkLiH0kUB2A55
 qSO46h4c2WNhG3yvGLEBGLVGcYWVz67XUHtSvtHyeEiR+zy0gcB+lu+D50yHYWhViRAs
 EuWKGW6LO/6Bt6y2KRU+LtGCvCN8uOJUtbqcLHye062MfNE4gG8M8h1NTsEkj0Ww6Mh5
 L2sm/YZsgSdPID1CGMqtNlDbtc8ypbAk6UD68lSu8XBRJ//o0KALRN23rff1Fenn83tZ
 8ItyOqANlAsO9DO+54KlvcgrOevrWGzmPQgCNQi2Whkki30dGJBUgMDo12tHBKrWQus1
 KNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746774212; x=1747379012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7ltAtejEdAV9MZhiUQDNqnwnzqsCUJMvK6vihAk1oc=;
 b=WjUQU/S1lELl6SECW6J7r2qlrDEqkZ2Vi8U3q7pH34D9WxN1ZGFOtYWJY/DUuqHPQB
 o4+2FS8uwrnmag0nztyj2RyWIIuW51lAFsg+Gkyvkc3P2Z2DvBAZCoviToe8gR0FAzzt
 7KJhyepGpsVaXRThlzQIdlGAobfBGX0mHkk2qUsSiIppq40o3uRnDj9nHSDaWnPTTGna
 s1qH/AP4FIGro5dsXi8VWdoYSj594lZW8JN4Q0ezBUoaVlChuADKBV0+Rr/esn8nt8pC
 hAdajPQFMoV76RXNjjNp8dipdF4PIvoXj/rZGjw+4NEG/q0oa8Vp6RgZLQCuK7TlEOzi
 OgSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+59jsal9ksrMMkr+8g6SHKlrAUY5MM3yviEChEvMEfkx7bz8CNfSkUWc56VrkASNb4LK3e70=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3CMUZb+dyOW62AwniA4/6xQ6YfRwDDGEk95M16H4XE2BHXqNb
 8EQhjRomVOdLi+Elx5X6JF7/bZ1/NRpkDn1dqghahVYZk0TNo6arcXNc8Q==
X-Gm-Gg: ASbGnctV/N4RLOiy755W/H25YsV+U9RoDhu2qW4bUrVIrIOE58GgEsiBSsskicCNIKG
 sUJTNBse5YNuKA4KLsTfdZgGNT+ufQGox0to7UXh6I19dS9+B+C3XHpXdwe2YkiPKoJcOhOJJMv
 liWRdD9JI7vbdj+GA+pC4u9LC4el3k3akCYbBrqm8WXma53O6n4PLEGWSPgxY9Ihj8k4BV4mFid
 MGKBGUKkzLpMf7miDUVv95sxfad9Tsq/28DmD4cprVaNh/9MOlzk4jsNOC19uJfVq2mpuL+0l5H
 /LSVanxRV0TFMAxzob1t1f4UDhhfouRYidF7F9MJE0h4xc/MTmci
X-Google-Smtp-Source: AGHT+IG/sjj7nZqG5DQYQuTkBLUYQ/gToIH94TtNAsYnyGMVlxfrHWVaZFTOl8AZqVkWpD+BNFR3xA==
X-Received: by 2002:a17:90b:2d8d:b0:2ee:d63f:d73 with SMTP id
 98e67ed59e1d1-30c3d0ea49bmr4254116a91.11.1746774211358; 
 Fri, 09 May 2025 00:03:31 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 00:03:30 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.denx.de (open list), u-boot-amlogic@groups.io (open list:P200)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Wayne Schroeder <raz@chewies.net>
Subject: [RFC v1 2/7] configs: odorid-c2: Enable Onboard HUB driver
Date: Fri,  9 May 2025 12:32:07 +0530
Message-ID: <20250509070258.5077-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509070258.5077-1-linux.amoon@gmail.com>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
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

Enable the onboard USB HUB driver to power the
USB_HUB_GL852G-OHG on the Odroid C2.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/odroid-c2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
index bcaab46f8bc..f8a66a923c9 100644
--- a/configs/odroid-c2_defconfig
+++ b/configs/odroid-c2_defconfig
@@ -59,6 +59,7 @@ CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 # CONFIG_VIDEO_BPP16 is not set
-- 
2.49.0

