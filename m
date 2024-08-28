Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0745EC54746
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:45:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49DA688AB1;
	Wed, 28 Aug 2024 03:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kyyzKZCt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E6188AB9; Wed, 28 Aug 2024 03:44:39 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 761D488875
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-829e856a159so99394239f.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809476; x=1725414276; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDOiqFhz2OsOFW5+x4XSU9o6CZZXqfGYV7F7shvPuNg=;
 b=kyyzKZCth5wLPi9q3Q5WIBZe6DT/JDHfjPW2C016BPESHkaBxCacWg0OPG2+DrmFad
 kUidrttE5hUnAqHapw2OTv9CApKVRsFKPrE8M/xcm4gP5L/X/9xgZ9sf6/av5z6nOX6V
 jE/Fo0DCHXH+aQ2jWzDTGXYCO86sEvvY84N0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809476; x=1725414276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KDOiqFhz2OsOFW5+x4XSU9o6CZZXqfGYV7F7shvPuNg=;
 b=tXSoDsFGTmfCpv/MXkCYizIs0JVgnGkI1E2Gdmb48NYy3GJsDmE98YFMR4Za4XJXg2
 70LJJgKxSallPVr1JyIml24EMcdngMMZhcxODEEtn4UuFG/QAwB6YA9RgF8/ovSa+xsr
 /vbonL7vIgj/TzGZsPkTPpPFBYim42cBG76pDs1jMTuSQYR9oFLMWqU/nEsOry6qsFqF
 UPyew4vhTjcF2bqFJU4IhQ58ijyc7DbyybDYD3ClN8coSvT85LwcZ0YkHodK/vGMciWs
 PqFpjZl07rA3QmBU1bYFlXCkiBvqUZxj4mgJ3pSdJoIWMrkd72NtEz4nk7AsYTnGCxq/
 Qdjw==
X-Gm-Message-State: AOJu0YwXdyi5uFOFd52jj4QcLAPejFLiAUTXhUZhm66o6i2LXihpcT4C
 C0HcWXl1bN2ic3nDXbcp8Lfmu/7/24lS/xfoUjLtZ+6M4DNs/+aS+Ppx6eslW4L7VUX0VXqm/Mc
 =
X-Google-Smtp-Source: AGHT+IEY12qltEsnaa1g1Goj9mcgl50dWZFBP5NTtak2Ambih/c5voif0dWT0XBU4KO4yeflmu0kBA==
X-Received: by 2002:a05:6602:2cc6:b0:824:d6bd:d6c9 with SMTP id
 ca18e2360f4ac-8278814184cmr1705613539f.9.1724809476008; 
 Tue, 27 Aug 2024 18:44:36 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8253d3da8b9sm366342439f.0.2024.08.27.18.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:44:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/6] x86: Avoid timer-clock overflow
Date: Tue, 27 Aug 2024 19:44:26 -0600
Message-Id: <20240828014429.3320011-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014429.3320011-1-sjg@chromium.org>
References: <20240828014429.3320011-1-sjg@chromium.org>
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

When the clock speed is above about 4GHz, e.g. on modern PC hardware,
the timer overflows, resulting in a much lower frequency than expected.
Deal with this by capping the clock speed.

It would be possible to move to a 64-bit value for the clock, but that
is a pain to deal with. A better approach might be to express the clock
in MHz but that is left for later consideration.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/timer/tsc_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/timer/tsc_timer.c b/drivers/timer/tsc_timer.c
index d11227cf440..2f2c2f27b7f 100644
--- a/drivers/timer/tsc_timer.c
+++ b/drivers/timer/tsc_timer.c
@@ -442,6 +442,7 @@ static void tsc_timer_ensure_setup(bool early)
 			return;
 
 done:
+		fast_calibrate = min(fast_calibrate, 4000UL);
 		if (!gd->arch.clock_rate)
 			gd->arch.clock_rate = fast_calibrate * 1000000;
 	}
-- 
2.34.1

