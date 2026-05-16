Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB61CD4F21
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 07:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B4E284686;
	Sat, 16 May 2026 09:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="UqIa4N7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D9284683; Sat, 16 May 2026 09:40:46 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20D6983EF9
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 09:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3664df30f53so341543a91.1
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 00:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1778917242; x=1779522042; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDFWtuBdE/THRcdlcEecSLhn28pkHJWXsme8e50tU0Y=;
 b=UqIa4N7QfKvGkTj2KrMmq4XVk/SH8chlaiuXGAd3/XU0gPX/cWZ/k4Iz+vUKMk/zv2
 zvtL0OSCjL22H/PTKZ5jYSBk51oNBYNre+n9iPzyp5R7EoQsV6OG3CmjT2drIdToZTid
 eg1oMQEtQ5+pk7m3BFbkhSbbrkQbpRZB5zJIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778917242; x=1779522042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WDFWtuBdE/THRcdlcEecSLhn28pkHJWXsme8e50tU0Y=;
 b=rP4QWMAWHHw9bWgb9ykJ6q3JhgntYQ2aZYKhQgqCXm4kQ/1vQBQAPnoCG6FJep8Hu6
 QNPRaGe+jpihVgN++Hj5o3+NvnVxzD2uV/tidy/SNd6qNNW3oWYVWtK18W4t3EjOC2JU
 7EREyLglP482q6bGX5M2E57G+T7YDrcW4qMSWxITStPXKQ6hJVtkP885MKa8DT63cmM+
 OU2jSrFHGyUhStKJ3PCJDt8Q75kg6zMmEDxqPNc1pQoBnTYN1biVSzGfg30CxWdGUU+a
 AjXRy73+oJUTzYh2AADw1VzMOd4qs1u9SP7j6KAas8A26q+1STy9Fjw5AZrN04Ob9qSF
 2rMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xW6oLF2tHnsuBS13zmjVuppvSXvjZE28kc4b6Y47MArQJSgpwUi/ziNro+SmNfM8s4gEK0wk=@lists.denx.de
X-Gm-Message-State: AOJu0YztrwbLXKkkRaapsq7Na9PDgAsPBdlyLy92CXSv6Fgi4FsTd2yH
 f9hK3YuuU6lw/WjVGumKyKPer7cf1UrhOezouUNlKsLARvEowTsusUJdjynu/Uf+98ifobIBGRJ
 hsB3o
X-Gm-Gg: Acq92OHic2lGn0+aiWWvLCKQRkhIgMuefnjZmquYKr+OYsA6XOe+j71Ql8ePu6G5Kqh
 HgKnk7PwCsRYnjwlP7U7ZXYTSklANzs/h8wkgoeGZrhFFJdFUtPuit1WYc+oLh7zXVxZv1CkB8n
 v65udd0victrr4+ab7C2VSGtiSmp2p4VEEe0NcfHJqSR9/Qto2edRPj9+9cNgELUjH2qK3E7g0E
 sAztWsYSXYyaR9ltQdfki2UoEjDLOcbhAw5pTkqVaP9T7FqlDwrQDUbLfNFI9TXd/dyNOpfT+Xe
 8N56NeA5A4znJ4wrNlImJF3479Zr4cPtd9ntdlmciwK8TBKnbEq2LdpcFWz0FRlSEFUd0EzzrsV
 8+S7AJGq+DvDc5qkejqVmsN3jSC+AxQuYhBfaTNKdGRj1ApRDE4c4glxci6gcChs8uiyhoatSy4
 MkX+lOEdqzmO9aJfRO9RcjwYHSbvPD9jrfKWQk5VM0ybh5PoUn31IUEEwBO+onzyLiZPoI1Hp5y
 fEiQ0re529Ycg==
X-Received: by 2002:a17:90b:4a0e:b0:368:b724:6d53 with SMTP id
 98e67ed59e1d1-369518bad42mr7462382a91.4.1778917242582; 
 Sat, 16 May 2026 00:40:42 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1620034-ipxg00d01sizuokaden.shizuoka.ocn.ne.jp. [122.29.136.34])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-369514361b6sm4702672a91.12.2026.05.16.00.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 00:40:42 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: 
Cc: Daniel Palmer <daniel@thingy.jp>, trini@konsulko.com, visitorckw@gmail.com,
 angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: [PATCH v7 4/9] timer: goldfish: Use __raw_readl()
Date: Sat, 16 May 2026 16:39:56 +0900
Message-ID: <20260516074016.885146-5-daniel@thingy.jp>
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

The Goldfish timer registers are native endian, so they act as
big-endian on the m68k virt machine. Currently, this driver uses
readl(), which works by luck because it's currently broken on m68k.

Use __raw_readl() instead to avoid breaking this driver when the
endianness of readl() is fixed.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Daniel Palmer <daniel@thingy.jp>
Reviewed-by: Simon Glass <sjg@chromium.org>
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

