Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021A8C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 14:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44FC784A51;
	Tue, 30 Jun 2026 16:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KqIbYp8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A431884ABE; Tue, 30 Jun 2026 16:42:54 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5470C84A49
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 16:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4924593f45dso58593005e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782830572; x=1783435372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qAPmMgkU7WRlpmD9FFuFej5/DiXzheuo/ZQ8cxQCMnI=;
 b=KqIbYp8x3Y6VvDxYhhC3KB/8uS/VP92jTf8BMWjD1iP3OETkVRI2ev4196HB67G2b4
 om6BnVbObG+Sfm0zvD1ZaTi0/ZS6qEIyClYgcf7yUYh0hGGzBXxJKGhwRFqGnrHJHCg6
 dyhMgt9jZZCmwFCYbStAsmD85W537fzPQ3vIWzmKkZlEp73sZkacEG8Derip9FYnDxWI
 e00k0oGn6nigdzjfvhJl94fdw8QOxTgHEC+T+TWnRkDnxiLPvzPSlixYB5+YOxz2bF4a
 ggc3nqBcID1TW8hmmra3E9JNP0Xm34xVAkcWYpHw3vc2+uMBbmgIRMYSspKXOoy2v80p
 PcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782830572; x=1783435372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qAPmMgkU7WRlpmD9FFuFej5/DiXzheuo/ZQ8cxQCMnI=;
 b=h15PMoqcLPtkhZZbjCbIuCtnw+KrDKFnD13o3UudBY59cEU8wG4PRboguYFDyUMmWa
 X9f4GvieUbwmKMsVVJlTFVK2dgWPEdvvWfgNb4KR5P7uRZrFcOCwN9nJF41oBYPSWKoc
 D4+d3UWYD2yNfqDr3NavTJVPnX4ovifbZTt4MkrEqmUNqEWiT8UgvRes6g3t6MKgKy1G
 NuGcplTcqZkq/jA+pNyRXGyLOPgoZAicLLvhfOM0zLIX6ei+2PyTeksz8v05llIQ0qpz
 fKDWrURgnTA46CEbm8zz9PaDfvOs1Wf2xczNMXyYsnvNjCG218wRqr+yV6pJDt9g8QN7
 O1QA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OfkwById7R01iXNtBJORsbqWpjSEYSpe5JY5obxl0bMWPhlR8MT4FeS5+I98hNGuhpMTY2KY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4/JGaEU/GPRxGrWq/vy+c/CQ65ucirGdUMw4h0fxyeh03iAlN
 K20o2x0w7JTcKS7eHl/k2GY5ZZlQTVXBfP3f0ROk9zqJWPgU2OOUuRyDO+Hd4ZAszB4=
X-Gm-Gg: AfdE7ckX1kNf1oe2hAq16lC+H/zvG6bIzya9ghKVpSXP9DbbBWRzN5dTSc8rztsKn8f
 RuPm+lhhgZSrRO13W+K5nLeNr8ETV+wVDQrYb04A+X7lAPfxyJTn3Orvjvhw57EaKRDoO3OPYNE
 LEIPY9Zf+2PR5/iOnbKOYHWhBKv2VmdNwab2kLc3wmdMfoZAAEBIs07c94hQF0rvqmpLghng+Mz
 I+PM26SV3I1DFZrFiwtyOWFJWE8J6cDdkB0eqYVWE6F/VH6Vpu8KoFzQSw8g1+hIkii28Gs5Emm
 KBb1muh4nqGwI2IcwLYk7tPRWSFBxvztn5fghOonoWWXuf23Mnazzk6hmXHIqvwixgcvgJs9Gpu
 GOswdOkELzt3LiXbmVuw0x70BaXOqmMoRuOV/HRjeo9f97VVNx/WMKpWH1NPhmTbrSfHNk0+YbY
 cguoO0QDR/rKm+YcIXkCGeDDS+9Tp76QX1u1HXnKg60Vutld9Zlt6oc6nh3yaGEQcvdsKVeBUZ9
 f9QJ0lVOWV9uZekfngL8KUHOpokVn1OUuIYRpMDMmdWth4uzl7hlp5RsgVDy6V8NuhLqVfkdDx5
 0V1Ox1rnOYvqoFMMet4EECVI9BboyxGniqdbosswRdf7NIBHB9NwK2+AG0n8SkQKWNJfAcxzvOB
 MKlX121QZ8FtlBUulnHZFFRrcEMuZ89l0kjyGO4vyYqRLSptmHKL+r9i0sFuewbp9ndXPztDA6M
 LJXKr70XCmYv2SbuBDTaoRrkknvetVAE64GWBGDtJ7U6ewxbkCc4Qz4S9Gf1bC+aQUrdMTBXrtU
 wf4HbdqO6ZvO6RI1g==
X-Received: by 2002:a05:600c:5250:b0:493:b771:de06 with SMTP id
 5b1f17b1804b1-493bda3863fmr13299845e9.5.1782830571585; 
 Tue, 30 Jun 2026 07:42:51 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4540aesm958175e9.0.2026.06.30.07.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 07:42:51 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH] MAINTAINERS: Add entry for ARM
Date: Tue, 30 Jun 2026 17:42:42 +0300
Message-ID: <20260630144244.449753-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Since I've added various features in the arm architecture
support and review most of the patches nowadays, add myself
as a co-maintainer

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 571af1964654..45e9076de671 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -154,6 +154,7 @@ F:	include/configs/apple.h
 
 ARM
 M:	Tom Rini <trini@konsulko.com>
+M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-arm.git
 F:	arch/arm/
-- 
2.43.0

