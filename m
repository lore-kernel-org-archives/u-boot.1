Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCFCF8A146
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E284884258;
	Thu, 16 Apr 2026 11:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="k8ETBCSl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E62684246; Thu, 16 Apr 2026 11:40:08 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 298CA8407E
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82a655cfab5so6364939b3a.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776332404; x=1776937204; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y13x06t9MNZeSMACuzaERlgtCziZSbpHJl/qeN8+ObQ=;
 b=k8ETBCSltjoTvaq5Uh46MjM9DM0nus+6XDjZGu0r7n4XdnllS+b1dt8Nd7fwHo7J3W
 nQxZAj/f5xP/UXmmmcKXun533bXGmj4KUkodVQkkfY7BBkWfht4tARFtoHCBWhSrGFSp
 sw2iuOJFNvQVSJzJzmvPMLm5CDs26fyKQ83MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776332404; x=1776937204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y13x06t9MNZeSMACuzaERlgtCziZSbpHJl/qeN8+ObQ=;
 b=ck0h5iq2fucfH/u1xF1T1F1qzJ7HLB52uJUL9wfp1mzc1CdJWnfS5zKcYXTHAZp06S
 uWdwC9RryIzSpDDN/6PyZzxocANrah33nyS/M3rrijk/sMq+zRlWuMXd5mtLB83mdyKT
 OaanHK61iY8Zya+b5REmVV0E+uioXgPu8aYlW/g2AE3IEGfJZpOQbjwq9eKillrf/yqi
 /Obu7dNscAyAC+TmPcBXb3w04Pbh9NV0Zi2NMoPQAfvFUd247pHkJzl0/qdNrskHAOmw
 kugoq6GRv8fUuUaHLRoGXBGPxw+PeecHQJzCNchpgZbxkI6AB9122D1K1+14VoJzmVgH
 mHZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/p7IvanA23FISKhA7J4snmXWL6PdmGtUA3708Kn8wszudQc9IU1vgf9fVDcj9ubME1yxVlc/g=@lists.denx.de
X-Gm-Message-State: AOJu0YwK+wOqdexNLmKBv75O5lStM2pUWIBJA2WOodMR1wKLZTZX3PIb
 gMJL8EH5QB80HJojV5bMiZJPHhjalkJsDDtiM8M1LhvEHjc/Jn0SbHRVY5M0wEc7Tlo=
X-Gm-Gg: AeBDiesE19oxJMn3do5kp6F8jHFLuaRiSvomp/QX7QbAXcgPXEoAt/jcpadW/cKY5Xu
 zPWYme9h9UHZ0ZX0U2ckDAbv4fPoLPkhKVhFEVabLhaHPctpYhFsumKrl135KBtI/WQb9Dlmn7t
 1weS/eX312XMSeRO6f2rFvAWxBIq4+P7lX2DgTnYRht1Jr+8xeOcvcWp7FTOlXgZ7KnLHgVIbcv
 VnefpnAhCGV+aLQT0zUCL4TMIonFiTkM+QjuOVnpRCDXDLVOHofYW1Y8RXFqcuA5kaIkf/xY7+O
 v5sc7hhtBAMMkFbSsR3NEfSzNL6tL7tKdEfb2Ru8uxY95xWkVLIUgrMHgKCE3hltmoirbc2kmRs
 i6Jco8/Y/FOLSBAlfrjpBkNl45zZcjLiwXVCe1M5K9g+KwtkxocjKIOfdDoZqpSzylqU34aXKzi
 v0e2MCOVtw6mKvvA054HR47SyMa2fI+VQDHZUxgu/Kw8wupXLPYs3ha1b55cbN54mbGkpn2XFrd
 wivFw7J7mxEtQ==
X-Received: by 2002:a05:6a20:9188:b0:399:196:1430 with SMTP id
 adf61e73a8af0-39fe3d82535mr27711530637.20.1776332404629; 
 Thu, 16 Apr 2026 02:40:04 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1329195-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [114.145.5.195])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c79581a2fc2sm4423568a12.21.2026.04.16.02.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:40:04 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v5 3/8] timer: goldfish: Use __raw_readl()
Date: Thu, 16 Apr 2026 18:39:22 +0900
Message-ID: <20260416093927.602613-4-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260416093927.602613-1-daniel@thingy.jp>
References: <20260416093927.602613-1-daniel@thingy.jp>
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
2.51.0

