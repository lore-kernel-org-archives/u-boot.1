Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507FDFF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 07:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EAFB846E7;
	Tue,  5 May 2026 09:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="e5R8Be7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 159048470B; Tue,  5 May 2026 09:50:06 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB837846C7
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 09:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b24fcc2b5dso28829195ad.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1777967400; x=1778572200; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aksnehCe/ISwAbC6oZ1a246nU64oxZ1zDgh3FfVB4k8=;
 b=e5R8Be7H76ou2hOftMGjOI6nXYT52wwnkMz9GfJ+1xZ5iA3GR2vFVm42SGRCh5z8Ct
 c3czbjmPAixNrb/t9ejFo5gRV3WrjSfxMFpPEc7/0d0gLAkFwFN+76A97TFf9bf8suuV
 jXcbnc0BK+EO3lY7S9g2wkmoVxbCawNZynPH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777967400; x=1778572200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aksnehCe/ISwAbC6oZ1a246nU64oxZ1zDgh3FfVB4k8=;
 b=hRmcbxJh7S1GdqwyHl6UYEPixDwS8jWUePMEFl11yDI7cjjPRu7QEPbnPiv+UTSmz1
 UcO9qqrxLJRydOG2vlS06qr+z72k6GyvKlCFDCrJuvgTdn+jy/g+pQYyFMIlrLFO8EO2
 T08XtaFu2u4xHLBxZkDN5SHAEYsls1RShkPVEsKqqwh+N/iJKi9uJvGli4kAkFuh63a4
 0GR9NFSG6hhikFQlwg8sgRQgsUNrsH3YGrC1FGoZ18ze6KZFz44Ik180Tu1Q4BSZY3HO
 YMQOuHbqV8o0eKU4oAJpHSIMkLeljIwfeu1119EaABDrAySp5bpmgLnqx9KNfvzi0AUI
 Y0AQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OtEqUyO9jldXiZuPnP5uWChZffJN2xeQo5zk2s0RWFZVrpI2RfY8c4Rqj/1fIKGSXuEkyC4U=@lists.denx.de
X-Gm-Message-State: AOJu0YzOeC2edWost/TfrRmX7rexh8jiK2GztTd8KztwbvD4Kk0CgXBe
 Wk/O4air3ss+r2h90394PV4StCCPW5eDmnwKpW7U4+vahO1nnkVd5LwEd91Il7ZsYtQ=
X-Gm-Gg: AeBDiet1SfOzqqcawSbrtvI0MlBst5nCCNbOocaTJz2MzUWbOmFdMrGDAjEMK53MArN
 R6nSb3ebAqk4FdO88Hfilhyw7f5MXITdBeDBnTs5lWpzocIPtAS/1bSIB7IxjHU+ppiDZ81h4sZ
 lPmMSiX9XZELvtsUr04nTTotDMiNPOR17I7213mu/EPwdmfAos4nWocQdoZhm8MhAymfu5o+ZPj
 k5P3ykAwIdVNqZ9DiMlPxcG/X1R3eiAG7qUCLuViak9izZ/jGtW5/Zl041g9cCmPeD+IFr0k6OP
 xdfDbG2t4ZIhWDhSy6v41ccar9KtNIHOhChXNThPmjuCIlybzbT+lKdcBwh5CVYhP7nzNFEZJ06
 tghgDbhwVIM0eF0Lhy6q9B5tHM8LtV8NKSAiYAOX+UWOvqZpMz6SM5hNZaOHz1Q6c5QD7qE4GiM
 pFJJYPBttgNFwXDvepNDqLaWuNvkE1AXF1g1sqG2vETDPTGHh7GyN18ej2BHgMHOVl1kp9z1Ynk
 l5wFFyr7Xv2ia5tS+1lrUlTwgjL/lWFFmbtfg==
X-Received: by 2002:a17:902:f70a:b0:2b7:aa20:3c61 with SMTP id
 d9443c01a7336-2b9f2838afamr119104075ad.33.1777967400150; 
 Tue, 05 May 2026 00:50:00 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1387170-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [153.221.239.170])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ba038ae95csm89160495ad.46.2026.05.05.00.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 00:49:59 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v6 3/8] timer: goldfish: Use __raw_readl()
Date: Tue,  5 May 2026 16:49:36 +0900
Message-ID: <20260505074948.2603870-4-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505074948.2603870-1-daniel@thingy.jp>
References: <20260505074948.2603870-1-daniel@thingy.jp>
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

The Goldfish timer registers are native endian, so they act as
big-endian on the m68k virt machine. Currently, this driver uses
readl(), which works by luck because it's currently broken on m68k.

Use __raw_readl() instead to avoid breaking this driver when the
endianness of readl() is fixed.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Daniel Palmer <daniel@thingy.jp>
Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/timer/goldfish_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/timer/goldfish_timer.c b/drivers/timer/goldfish_timer.c
index 70673bbd93c2..91277d7932ac 100644
--- a/drivers/timer/goldfish_timer.c
+++ b/drivers/timer/goldfish_timer.c
@@ -31,8 +31,8 @@ static u64 goldfish_timer_get_count(struct udevice *dev)
 	 * We must read LOW before HIGH to latch the high 32-bit value
 	 * and ensure a consistent 64-bit timestamp.
 	 */
-	low = readl(priv->base + TIMER_TIME_LOW);
-	high = readl(priv->base + TIMER_TIME_HIGH);
+	low = __raw_readl(priv->base + TIMER_TIME_LOW);
+	high = __raw_readl(priv->base + TIMER_TIME_HIGH);
 
 	time = ((u64)high << 32) | low;
 
-- 
2.53.0

