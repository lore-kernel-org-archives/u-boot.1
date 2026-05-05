Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD6ACD342F
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 07:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E42184702;
	Tue,  5 May 2026 09:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="lhewHefJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 387D8846D5; Tue,  5 May 2026 09:50:02 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDC82846A1
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 09:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b9e9a6802aso12273735ad.3
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 00:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1777967398; x=1778572198; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/EYKSlhXInd2BXTSpOvHX1obS9WXJv9JAji0pQvlS4=;
 b=lhewHefJQMAzX/2Wn19BsSh9tEjAg2krzqRce+of1QVR0xWXjwikfameNikgNTUQqh
 EqnM898p8Qs2xGUWdJLPI6wqClSr/PO0EexOeKEACgXgJKW9N+P4J4SmPrHrZdoTSQHj
 WnrVu9uqCBbGAh4Go0EItPUd1e9BTiJBetCMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777967398; x=1778572198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h/EYKSlhXInd2BXTSpOvHX1obS9WXJv9JAji0pQvlS4=;
 b=ik6aLXD6HuzAZJhOqKLKALZ/OCjASM0357Ofx2d9Mw3I/ug+N7BnCgqlcHvcFKxa+5
 dF+Grplk69Ujh6KL7ySN9lDMYn1i7Daf3EI0t0QwAZPYOWywMMXYh016dB+svY9vWt0v
 BtDIaaUrphGYXdIdLpbem7Fs/4ysLbjksCtZiUBAr1HtS+ffOgQojVhoaEr4wzaoLZEh
 j46AmUDAl7C4R4pGakGD/6tYsjDnHuFHj94ENTE2SmDR8ahCldxdftX2ryeKney8z7T3
 Hzanlhs+nRES3/mitkBCdM7HoTPfCBh/K27jtWKevOpdfLBz7gMILINabYJTVjL+Qd24
 TTkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vuBHisUZKwkq6xHTMpEd6gtVPVFvH1vTqpOwKx4yTw//XFqR/M9UCZIlRT/CuR9XNOreYnwk=@lists.denx.de
X-Gm-Message-State: AOJu0YyYBSUX7H+YoPMHU38g04pV4wXEaLn4ARr+ZiIV6gDlJ5trKcYS
 yavgRYCmsQID7R5KhGj2t76EoUSEIA406qsy0EnzUJeXMdWyp2qz4c1IzGzCK26K1ok=
X-Gm-Gg: AeBDietx6Rr9vItmOSvGVL7kpan5Vcb9v8aOgMsD0vS2t0iKFXcj/rLDU5tImEE3EIR
 kkMfKIjgXzJBN81NTmd7p/3TImgXs5amXDO9/SJnCoJ0qby5js5AbjIQGM4hyoo25H4VkpTGQVM
 UMCcJBYQ0aEYbHUZm3KTNY4Z3unL+8dr8mpnNx3sMLICq8SAsheiECXGnwkQ2BPcWXkaex/s/fv
 nSUziW2j5zcuhsA/Dip8odvaDyviVM2jFhaWMSeaGltFUalqEZa8jXgRLGoo7RFvJ8W87cOaCeR
 MfpUOuL1xWKeW+SigPqSWnyrEwbMCr40yvnn4zlojDeirvkQDnLnmT426q/oxDwrPI2KhCFmPCY
 com3kV7m21EDNiI+7Rwr8lezQ+8OKaf0p5deQyuWL4Esm/9RZsOk6zBFhjxmkhPk/qUlu7NjC7z
 vRh2ZBLiKSmQbsWat0HuaKwb33Gg6kb4wMmeRY35H4XyOsLYfPJoWq6OG4t/Sc49x17ffs+tH9Y
 6xyui/Vgoir9kfso8s2RLi8yuE=
X-Received: by 2002:a17:902:cf49:b0:2ba:3b71:5814 with SMTP id
 d9443c01a7336-2ba3b715c4emr32571945ad.18.1777967398409; 
 Tue, 05 May 2026 00:49:58 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1387170-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [153.221.239.170])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ba038ae95csm89160495ad.46.2026.05.05.00.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 00:49:58 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v6 2/8] rtc: goldfish: Use __raw_readl() and __raw_writel()
Date: Tue,  5 May 2026 16:49:35 +0900
Message-ID: <20260505074948.2603870-3-daniel@thingy.jp>
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
2.53.0

