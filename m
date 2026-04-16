Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8312F8A14D
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5B2C8423F;
	Thu, 16 Apr 2026 11:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="CzOwZbS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C0984105; Thu, 16 Apr 2026 11:40:07 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 638A284105
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c795a88e8acso590689a12.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776332403; x=1776937203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMlSqEMzLHIBrMWBPw3/su0lh/eopHFl9flEYxjRn38=;
 b=CzOwZbS1oRR4/2GwTl8EB3z4PDk6ZTCJP2rvqi7I5pNBpcngWqWL3orySMtd8wGEHq
 pi6eO/X5D1H1rFW1AQN0QcCALNzF5IAaQG/y56tKrWxOC9NT7y2oivApAdE3yXYC0juU
 16TpSAk2VfQ/wDesmsWWxY8o24SuTVmpSmad8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776332403; x=1776937203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nMlSqEMzLHIBrMWBPw3/su0lh/eopHFl9flEYxjRn38=;
 b=EMj16M4kYP+wC4pC5UUkKTRZiEZ//hcUENpDq75zNRsRHgs3WCk3g/3HjGM7+wnlI5
 BJaPSyvgHnEJzBsOh4fvQPPQtymkno7Yx88PjtQ7/LMYoYBzQDSJKtH5lU55DAjKxEEJ
 gv4Y6khKx5pYZU0omjG9pT84NhB/3rITmQW0xxNZRClXQwh+LX2avmTgU7G9JRxs3Asr
 I5GvhT9+zT8amKdXUQonJhULRns97H/bwRMxB7AbX2OcqvAmnCOVaIqRZYFMUoLtT2E6
 rqwnP1gNAxzwjt+QxWYkGEmbkfBQnNitAqR4MfLVP6C65Z6Z178Q52e5DizeopzRwqVw
 DkZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3JkAnQa3hw7rUX+9YJJHpe1vlZzd/V4exNdhRjXT7dTNcd9iJWFjY1k7r9pThlYveEu+uYqs=@lists.denx.de
X-Gm-Message-State: AOJu0YxSaenvhqYhIpScb8U4eTN0NCWUB6oV0xkSAkKXabg59AqIOYJm
 HnOjj4BWo0eGb0Z75f3noqi/F7xSB+zn8nVvQ7nEO6QssFu8nX9UZPpr9QNTZMQyZjI=
X-Gm-Gg: AeBDievr7KK+6NTU3a69tQ8XKSUwmjU7XfPOycLchc2r5NWevrv+a2p1Y2XsWHYXXYF
 B2AIlLwAqRv5P9Y2RfL3P9n07MV+AwtFS5X5EZ1mdDUrfpW8zlPaifd9ZJ3tcCjW5qlh3ofKf82
 GTel5sT85caK361CLYjQ3r26T1NllmnAsWHJtkjX+qNjurKV9m0F2lFR6aGYZe1YbsdXBDrtrv8
 gkr6+r2uMOt+aqJ2iNfzeGrOGCAUtbrKWtbAFeA1fnORP7KUNiQSOY12xW5hlSzj7iRkDcOYHNI
 upXKD/UtDt+dnXyyrGVTuH94mPV6UuG/3XEkprXjhLTv1Ge+uooWrKgiPoZWMRstFGl80GsS46y
 NwLI+dMrgeFaEtYYeHbqPiuA7x9eYsyLqugSVtKLKazuFyKhJonswG7b+W2dKpB3T0YN5PKP5EF
 Enexuvc25vcIPlCpS8uAtj5sfgn9jshLNjXe0P6IcM22NmyKjsPJ8T+XaIZqGIrkqA0Yhgd3wY4
 uyweYJy1yJ4SA==
X-Received: by 2002:a05:6a21:644d:b0:39b:d937:8020 with SMTP id
 adf61e73a8af0-39fe400f835mr22638395637.42.1776332402900; 
 Thu, 16 Apr 2026 02:40:02 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1329195-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [114.145.5.195])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c79581a2fc2sm4423568a12.21.2026.04.16.02.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:40:02 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v5 2/8] rtc: goldfish: Use __raw_readl() and __raw_writel()
Date: Thu, 16 Apr 2026 18:39:21 +0900
Message-ID: <20260416093927.602613-3-daniel@thingy.jp>
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

In QEMU, the Goldfish RTC is explicitly instantiated as a big-endian
device on the m68k virt machine (via the 'big-endian=true' property).
Currently, this driver uses ioread32() and iowrite32(), which works
by luck because the underlying readl() and writel() are currently
broken on m68k.

Use __raw_readl() and __raw_writel() instead to avoid breaking this
driver when the endianness of readl() and writel() is fixed.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Daniel Palmer <daniel@thingy.jp>
Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/rtc/goldfish_rtc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/goldfish_rtc.c b/drivers/rtc/goldfish_rtc.c
index d2991ca67192..4892a63f8d80 100644
--- a/drivers/rtc/goldfish_rtc.c
+++ b/drivers/rtc/goldfish_rtc.c
@@ -40,8 +40,8 @@ static int goldfish_rtc_get(struct udevice *dev, struct rtc_time *time)
 	u64 time_low;
 	u64 now;
 
-	time_low = ioread32(base + GOLDFISH_TIME_LOW);
-	time_high = ioread32(base + GOLDFISH_TIME_HIGH);
+	time_low = __raw_readl(base + GOLDFISH_TIME_LOW);
+	time_high = __raw_readl(base + GOLDFISH_TIME_HIGH);
 	now = (time_high << 32) | time_low;
 
 	do_div(now, 1000000000U);
@@ -62,8 +62,8 @@ static int goldfish_rtc_set(struct udevice *dev, const struct rtc_time *time)
 		return -EINVAL;
 
 	now = rtc_mktime(time) * 1000000000ULL;
-	iowrite32(now >> 32, base + GOLDFISH_TIME_HIGH);
-	iowrite32(now, base + GOLDFISH_TIME_LOW);
+	__raw_writel(now >> 32, base + GOLDFISH_TIME_HIGH);
+	__raw_writel(now, base + GOLDFISH_TIME_LOW);
 
 	if (time->tm_isdst > 0)
 		priv->isdst = 1;
-- 
2.51.0

