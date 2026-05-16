Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3742CD4F21
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 07:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 666B584659;
	Sat, 16 May 2026 09:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="P5AwQuOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E353484099; Sat, 16 May 2026 09:40:43 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9938783EF9
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 09:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3664df30f53so341532a91.1
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 00:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1778917240; x=1779522040; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hnZAd/gq8Y0JxqL+SeU4pc/njB8GmBtdrLg0v53DPfs=;
 b=P5AwQuOJiiI1praLkRk+0yB9R5dhLaK8aZ42COHseJekQVZv4riuz87AE6xP7kcQAs
 Ke/v1fQZ3sV9Y7PSwGclY1dQxZUV9vvilIYu1IbXSNgmUAnajI5BoHqs6n0fv1KhcLHr
 fyW/BDR0Dl6R+Bi3qHt8ErIB5/s5EQGDk0hdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778917240; x=1779522040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hnZAd/gq8Y0JxqL+SeU4pc/njB8GmBtdrLg0v53DPfs=;
 b=NBHrYPUnuavRzukN4RDzbxjCzqyCdWQTiu1weqd3mijpdmcF5POExXrjhJT9Sh3eez
 YCUE7DX9S23RlRxKIk0aM5mLM0YpBoRHBDv8Ex2tQJ7NkhM45XUTIRqwR0jh+CtzHH1F
 e7Jssd/gsqlirSOvXNB3nWN+93z9oTbBneomlijFHA9okY4Txj9ZLZ9Y8fkYtzdFe7ay
 2qw4k1nN39k8ozSNzx2+W0q3hInNV4ifGXvIaHUXxP6rbyAy518T9xe7EEoF6nG8mTqi
 TAOlQP2JRO23XeoUUzpHJvBLZaKAEoDVtVYfAMOyxQFkaGlxbfWaplgwmMtLL/n52Md6
 zP7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ98rKTLbHs+isztEoNyvPDkO5YegoWdZFBrW5xYFvFPPzvijXPrqf+NcQfuzajVAsnUtyVB78c=@lists.denx.de
X-Gm-Message-State: AOJu0YzrcZkO4KQ42cQY/3A65snmJS3bHcZQbHbfiowkU0ALfwf0Vpyu
 i0aPjHYeAapgt/7d6o4ht41WUTKBfEdZHUkZb12VJfx53Za46bqP5LQ7d64NSfUz0KU=
X-Gm-Gg: Acq92OHIY1TxAULmTkwSwJgq9RnarojFhLlsLBQ8a9pd4Icvb9vw3rbSYVZXZdxYM2N
 4hH8+JDeiAPidnrODAl2oJ4AIG+cnTOYjOeY3lC95izYcqZpY+q10d6+cTujf89J9xx8ByRGRR2
 8GVZgXOE9zJgM8qwj2JRhpk4cbRjiGPU3ebLm1onA/poPSk5UrDo/dbKn2ojbXcjCbzlJ+A8iNt
 zfbSlM7oQJ1e4S4DlPXlrXBjX/imSBzTU2TtkrofxnJ2+Sf9HanFhgDk+bYLDzkQTTZd5n6xthX
 nlGCc00hT4/u4RGTcuHfEzaj9BOYDARrO9IUEV7mm3xBxO5fNK84WOr4xXzbxB7TSHmAuP/pcGe
 42bMvjUJTdDlfV1mEosLlz+mQQS0SnIRFdiPTiZn66m/xY5ncHd+UQM799J8v77DTK/uGW8ZaNk
 B/Le7ClAA7oKJs/MX9vf6//ZzWxKmI/gcOa8Bx+1NUdZa+/be1ZECSfwWqI056ms68SHoPbz8Go
 CAo1KAmLiQTRg==
X-Received: by 2002:a17:90b:2d43:b0:368:7a49:cad8 with SMTP id
 98e67ed59e1d1-36951b75c1bmr6822373a91.18.1778917240105; 
 Sat, 16 May 2026 00:40:40 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1620034-ipxg00d01sizuokaden.shizuoka.ocn.ne.jp. [122.29.136.34])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-369514361b6sm4702672a91.12.2026.05.16.00.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 00:40:39 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: 
Cc: Daniel Palmer <daniel@thingy.jp>, trini@konsulko.com, visitorckw@gmail.com,
 angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: [PATCH v7 3/9] rtc: goldfish: Use __raw_readl() and __raw_writel()
Date: Sat, 16 May 2026 16:39:55 +0900
Message-ID: <20260516074016.885146-4-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516074016.885146-1-daniel@thingy.jp>
References: <20260516074016.885146-1-daniel@thingy.jp>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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
2.53.0

