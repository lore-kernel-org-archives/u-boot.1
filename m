Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30738D64083
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 07:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96D1F83AB0;
	Wed, 17 Dec 2025 08:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="PvThsfTM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51DC383AB0; Wed, 17 Dec 2025 08:26:07 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DFB283979
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 08:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso64453975e9.0
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 23:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1765956365; x=1766561165; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ivRO25U71Lmj2Osj9DfECnxU4JqPqrXMzssQysj7Ex4=;
 b=PvThsfTMZn//Knnmn23jsTvZRVKmqIyRnJQmCANFVODksgSNNHaMrZokZtzOnQaynq
 Da3k5fBnzGkY2gVpwoBMK3gTlbaG6PruHlA6sRa+TCTgW12hFVceaL9moySuSUA8nyZC
 v2UbNpYPIRc36HYLPlYUVptUd/gyf4UxVHrH/errL4c8jqn19sFfXwRqY5Ttu7xavWZb
 l7hRlFlF9UOqLMnNahpTH8rTU3GOLw7PgplLh8P+WEw3qLE3f2GGJsbEBDsY8dWyDugH
 MURmbV/xm3FrRS8xQhJr0b7SRAoLd47lemtAiZX+NkHsZVIdbvug8Z9ULO7nN5/00aMJ
 LL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765956365; x=1766561165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivRO25U71Lmj2Osj9DfECnxU4JqPqrXMzssQysj7Ex4=;
 b=p6HVLcNqNsKw4hofxPIVF/am/LMMBz/v7SWLlK+5bmnzkZVPk8x7CPRPfeg57FS3XU
 wcP4vDw5whePKyZqQrrESKNYwftFubQITPUJYzFBgKWtfyku0RCz9UF3XMWfe0F2Jknh
 G+JWTuv3obYXHkbZVYe+SrFpwD/mH8d9LJPKGhM/u53zhgiKNoyEEBxbGoD2lyPfqb57
 FV4VsFrzWfoJF1Lkfdh9WImFsiu7Fnjr83IB0UnlpPRNyuq9hSRKQ0iuUzxS74MaZeNp
 wVIVhEdHsfXeC3DEHo8UKmd17i5ppS41+4/gbOHA3zk+mZ+GRG2mhI1L2LGecZpuC/4l
 kTOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMh1r1+WrLnq9zOl2QbhT/OdEu0YY43eFk1IIJzi/06xt3B8TshKxSVqcgKnShXDHLOzmQ2bY=@lists.denx.de
X-Gm-Message-State: AOJu0YwjGpn2x/83cE0mKMy/dswe0CPCgjp7zkR40dtYytCkxhLNQgAd
 QoqG0ikpiKKGmj4WzZGfr1jbMZRCnCHiu4x5FdEviroMq661QJm9AnVQZd+Lfo6yf7ogabQJBHx
 0pCJJIfo=
X-Gm-Gg: AY/fxX6LPxdChTSHF8Fn66P6AlC0tvd0ShyoRsjA0J4+zwdQ90q4aIqZE5uE52MxsKi
 FX5ne0E2j4X73E24zohVeKCPS+53pFdX0aZNLKgutwyqdJO/c91yBjEnDc18cpIP6dsC9ZpG/CV
 Ev20yKySwePB4X9fG3EkV+96ldy6c7H31jaWYkdS/3lTgLJfw0fIefbLcIItNukszTK1ayXp0a/
 Z8bsB4I1TG+roEzoMZLzyIe1A77+zaDMYaJOzeD1wIA9J3YRzxiKetg3kC4ZigUvlbG62/7JzZZ
 jtR4b4EwrWaRc/XZQSy/PZSbcVp41qpVpu+BRFPKYsjTghjyOy962JlSNdpe6KwyQT9lp9Rk3La
 /nz9+jT1CFIo3394gAV1WwkeoJT4WtdvFrVKOd4Oa/hpAYj56PytG+JNnkTSG6qHpaAMf28EilP
 5r/PREfq0MZ0XZldBQwcNs/eO2UbYqlaHdTA0BA2J1M48bWmnaIeRwsBU/ML5r+Z8v6vt+1FsZ1
 5dujLUsatLZqPSl
X-Google-Smtp-Source: AGHT+IH3+NrCQnY+KyxMX3RQY4KFh7MTj+BuIfDojU66xtTm2uPI2leweaC+nQwnTAZ5ispRG0qcdw==
X-Received: by 2002:a05:600c:34c8:b0:477:7a87:48d1 with SMTP id
 5b1f17b1804b1-47bdd5d15b8mr9590115e9.30.1765956364768; 
 Tue, 16 Dec 2025 23:26:04 -0800 (PST)
Received: from T14sGen4.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bd932a3e5sm24248265e9.0.2025.12.16.23.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 23:26:04 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [PATCH 1/2] timer: tsc_timer: Fix FTRACE support
Date: Wed, 17 Dec 2025 08:25:56 +0100
Message-ID: <20251217072558.2949569-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.52.0
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

Currently FTRACE aborts on the first function call since getting the
timestamp causes a recursion and tracing is immediately disabled.

Fix that by adding 'notrace' to TSC timer functions.
TEST=The 'trace' cmd reports that functions have been traced on
     qemu-q35 when CONFIG_TRACE is enabled and FTRACE=1.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/timer/tsc_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/timer/tsc_timer.c b/drivers/timer/tsc_timer.c
index dd16ab320b2..d17fb2337dc 100644
--- a/drivers/timer/tsc_timer.c
+++ b/drivers/timer/tsc_timer.c
@@ -395,14 +395,14 @@ void __udelay(unsigned long usec)
 #endif
 }
 
-static u64 tsc_timer_get_count(struct udevice *dev)
+static u64 notrace tsc_timer_get_count(struct udevice *dev)
 {
 	u64 now_tick = rdtsc();
 
 	return now_tick - gd->arch.tsc_base;
 }
 
-static void tsc_timer_ensure_setup(bool early)
+static void notrace tsc_timer_ensure_setup(bool early)
 {
 	if (gd->arch.tsc_inited)
 		return;
-- 
2.52.0

