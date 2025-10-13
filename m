Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FD7CCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 04:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A76838D7;
	Mon, 13 Oct 2025 06:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="dm2lY8Vi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7C3C836B8; Mon, 13 Oct 2025 03:38:12 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E2FF83631
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 03:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jimmy.ho@sifive.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-26c209802c0so35131675ad.0
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 18:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1760319488; x=1760924288; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0JcI/Le/VlMNqypey98xZwA4DNBjm3X1iMMxbsMH4jE=;
 b=dm2lY8ViuOsIPeDm9JVxwwz/tJ/Z+ac0NCozUaueMjGtIYOT9mJDK1WZ2NHk5jN4r4
 e+AGzvatDXh//vJ/zmdWC2JLPFXe+sOVZFP2PibocjYmu9TfVL+60q1u4B2HDbSibEY2
 w4un3Iooh01XAVCCMjt8YMo4q8Sy7GfuXF1Wq9HRDVrdxwEW1m7Hdo1S2Jr9GH5jav2x
 ktB4syJaNX44tyF/z2mzhFKR3jB/M6hM3R0m155U/sT9EbarCjFdgMuTItrT3XK2LB0Y
 tCh4zgJ0nsuT+9AvJk8EDTvL1Ru9th+4El4XK/Msh2blObDeGTEf75QR+Zovi3pJhVU4
 0lKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760319488; x=1760924288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0JcI/Le/VlMNqypey98xZwA4DNBjm3X1iMMxbsMH4jE=;
 b=d/fmwK9JPUeqpLmSR5pQIu1cIszILwPXEub7QLN7EcQ5KiwVLU0a2uyk9mMq0OG7iT
 kYvxIbsrBKnF7IdTqeZi3VPJNq0y7nX84KYvwiYz0BcUfi5OeuHpdtoXWeBYUDxHDGRM
 75OSLctuKogamNtfHRkXeBjo5vl4fHzfmv4KyOOXAdVtyXPQKCEODFfaoUA5gv/18ZtR
 bc4Su0BIYCpm7IhPQzGBgv+SqWuFNFqq2GABoiZ8q+dVgnP2K3EWgelyZHSQZZ00jXtb
 zqTHMvcIIIGL5KKwkl3P54bFTyR46ZWr5zDfWmm1ID1g3zvjnL02b4eUhwFB3h3Cefh3
 Nm6w==
X-Gm-Message-State: AOJu0YyYF0GiDKivAAeq+guZQ4wzSUoVjf2GIzat2AdNTTNKMzf1WtU/
 zn8x2HXtLSx6aZIrKpeaYXVcuzlKevuExDVbAWeFZj/gO80lcoLc8f5w0ocbqwLJSDECHhckMC7
 E7VhNjpxoF11WiiNFjOhuod7+XTALZmcf0NCYIrCYlcLZxFjk7RZ8kUolZwJCAEwDKJYkkXNaRE
 75wTarHB+0hD2OPBOh0zwQkkF48SsD6iux9Wrj9X4x
X-Gm-Gg: ASbGncubpT1Eyzni9E64g8gxwKnol/sBR/aztccDC3s9C73QeQq613tcZu178l3bHXj
 GPpJ1L8d8qf04wqr+nITEIKzauR3IckkisAE5n9MESs18XxtZtBRdZeb0DmyofZZwl9vMAHlz8G
 g1K5l1cMdixyIdvadd9Kqkv6PnWqYCyIa/ZZt9c31rbzr152oB73btlbIrTy+szs5SygSjN2R2y
 DOS1TfeA+ybyJOKNiHKDuBEli+fz/zZ2hUvxhEhiTY7HyoEYNUX8zBJFyz+OpWjMVkfYXapD73v
 8ijBAVaPoFTSHIm33D2r8/t28v6sw+3tKRuXYSLipRhFx2WgY07u5i3mC9wrrefr/52fpc3WyOK
 HazqcTsXkCYwQ1JCVps3JnqRaTD+nB52Y9JsLcSnYFqAPQFc2UCTR6NYVdHlAyQHh
X-Google-Smtp-Source: AGHT+IHcgfe0zSCHBe2L/0ONvWoeL4ttirmpnQ7VKCjgHN2dtx1LByMFRPhshscH0Duo1b6Y8M8S2A==
X-Received: by 2002:a17:903:2302:b0:263:ac60:fc41 with SMTP id
 d9443c01a7336-290274030a0mr254252885ad.48.1760319488248; 
 Sun, 12 Oct 2025 18:38:08 -0700 (PDT)
Received: from hsinchu01.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f089a3sm117321545ad.76.2025.10.12.18.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Oct 2025 18:38:07 -0700 (PDT)
From: Jimmy Ho <jimmy.ho@sifive.com>
To: u-boot@lists.denx.de
Cc: greentime.hu@sifive.com, Jimmy Ho <jimmy.ho@sifive.com>,
 Vincent Chen <vincent.chen@sifive.com>,
 Wayling Chen <wayling.chen@sifive.com>, Max Hsu <max.hsu@sifive.com>
Subject: [PATCH] timer: sifive_clint: Add GHRTv2 compaible string 
Date: Mon, 13 Oct 2025 09:37:52 +0800
Message-ID: <20251013013752.20403-1-jimmy.ho@sifive.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Oct 2025 06:18:05 +0200
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

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Wayling Chen <wayling.chen@sifive.com>
Signed-off-by: Max Hsu <max.hsu@sifive.com>
Signed-off-by: Jimmy Ho <jimmy.ho@sifive.com>
---
 drivers/timer/riscv_aclint_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/timer/riscv_aclint_timer.c b/drivers/timer/riscv_aclint_timer.c
index 35da1ea2fd2..175956bcfd3 100644
--- a/drivers/timer/riscv_aclint_timer.c
+++ b/drivers/timer/riscv_aclint_timer.c
@@ -83,6 +83,7 @@ static int riscv_aclint_timer_probe(struct udevice *dev)
 static const struct udevice_id riscv_aclint_timer_ids[] = {
 	{ .compatible = "riscv,clint0", .data = CLINT_MTIME_OFFSET },
 	{ .compatible = "sifive,clint0", .data = CLINT_MTIME_OFFSET },
+	{ .compatible = "sifive,clint2", .data = CLINT_MTIME_OFFSET },
 	{ .compatible = "riscv,aclint-mtimer", .data = ACLINT_MTIME_OFFSET },
 	{ }
 };
-- 
2.39.3

