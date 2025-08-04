Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB63C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B32C84019;
	Mon,  4 Aug 2025 23:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g714vDZc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18FE384002; Mon,  4 Aug 2025 23:57:34 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A5983FE6
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3e3d7b135c2so62063775ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344647; x=1754949447; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nbBEa97MAWUWnFjEy/ffDPsZgvcjcLsw4Pf4OIxUvPY=;
 b=g714vDZcVtxmdwOMoznXjYOOvBA7JCbJoB8GkDZACIgVQhqMkz5rzy/36Aeukf1g6n
 06etqbI21NS+x3/le56KQSl1GHgTLlrl7nRN47amku/jWky6CNiG6h4H9Q8TsC072L6K
 j1PmuRZGOMOj2qXL44Mx4XYuklE0ex+upkoEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344647; x=1754949447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nbBEa97MAWUWnFjEy/ffDPsZgvcjcLsw4Pf4OIxUvPY=;
 b=MOf7Pz/sJsD2lnDN8ekEHdTu2uZwj4kuSL/2jDFw1Z7vEhPpTCAiXKUAZYx43AU+fR
 jWouxttveEk0QYCcIEuAG7UbCjBDEZLwCpE1s1XgIh3M2pZr7JQi+jqrRQJk6TyQep97
 LFIeTUW0XYxmyolTXLnahaM08u5nlW8wVNYJeAyKDt7JuthgQtgl+GWPh8Mixs2kjXJ+
 o6J89mOJieMDNK3yHZcALHhlJUKQJ9mlpfb+SiPJZBmFZp0zX7UimC8EyVtDxscdPqTY
 Vf/lWEWAHjDS0N7Xyx0nZRpUw6iVIwzsAnNsklZ5XRtS3wYCM2igk+r+0+b1WGGaKYVH
 4G5A==
X-Gm-Message-State: AOJu0YzMqeUvJs2Gxxi2InhmRgI51PPZYrMStscXdZv13jI1wkHMtqhA
 XpXipb8drhnqDb76RLp8F/UrJvaze0uiS+ObE+4zi03BNaouNwT6SL2tnLnXR5CyBz9NpOSl+TU
 gIhsCTKc=
X-Gm-Gg: ASbGnctpxW8KPFdqheWTIYtCcvM90WFkK36LrMVbLURT9SETKiTbe2fZUVTKm9KR+x3
 Ce9hbyACM9dTeIEWo2PidgA6meFHCe9EFQroFQ/3ki9kHDejDqy5xl8HvnLUwriTc/HsWXEt2EY
 p+GsBxapzeIXwF1qWxYoApOygZHDsBsubiRVq1fZXJIpRgZAIJAldH2bqfByS5qmQUyfdj1q1WK
 kQII9b9ToF7ZQNZpDWAKplU9CYd3f/VN/MWRf/zCblf8lesBin1KpTVTvor2IND4lc5DxKGC7yk
 R1bObHDT8pTlNX6lcFA8h6UtTCH3yV/c+alM/3ti4VU1ACLThgFN4Ex4LDojXoMlF1g0CE9Yv3X
 zrOw/Y+uhzvLsKcrWW1H88aQMwYlwn4uA867XjLik/nXLP0n3MzK1P3O+atafWbIlK7mE
X-Google-Smtp-Source: AGHT+IHBCC+1ltiMBeT89HdVWyhfv2ei7p+x6p5mJhqy/5ZcCBbBeg6GHKBIxkz3AK27JG2MBWoC+A==
X-Received: by 2002:a05:6e02:2610:b0:3e5:f75:ec62 with SMTP id
 e9e14a558f8ab-3e50f75ee17mr34532525ab.12.1754344642087; 
 Mon, 04 Aug 2025 14:57:22 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a9f677f81sm1066177173.39.2025.08.04.14.57.21
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:57:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/3] rtc: mc146818: Fix building on more architectures
Date: Mon,  4 Aug 2025 15:57:11 -0600
Message-ID: <20250804215719.1413106-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804215719.1413106-1-trini@konsulko.com>
References: <20250804215719.1413106-1-trini@konsulko.com>
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

This driver makes calls to in8/out8(). On PowerPC these are separate and
real calls but elsewhere they are able to simply be wrappers to
inb/outb. Rework this logic to be able to build this driver on more
platforms.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/rtc/mc146818.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/mc146818.c b/drivers/rtc/mc146818.c
index c0d86c6d063d..08bc528aeaf7 100644
--- a/drivers/rtc/mc146818.c
+++ b/drivers/rtc/mc146818.c
@@ -11,9 +11,9 @@
 #include <command.h>
 #include <dm.h>
 #include <rtc.h>
-
-#if defined(CONFIG_X86) || defined(CONFIG_TARGET_MALTA)
 #include <asm/io.h>
+
+#if !defined(CONFIG_PPC)
 #define in8(p) inb(p)
 #define out8(p, v) outb(v, p)
 #endif
-- 
2.43.0

