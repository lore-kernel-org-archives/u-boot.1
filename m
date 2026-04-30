Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA31FCCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 11:40:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD8E78460D;
	Thu, 30 Apr 2026 13:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mba1ADDn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0BEE84653; Thu, 30 Apr 2026 13:39:55 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 591D8845E9
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 13:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4645dde00a7so1332548b6e.1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777549191; x=1778153991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OrRYGTdyq7s0A31ABfvjf4Ro2tkXeUzCc7DLYN9Tp98=;
 b=mba1ADDnzCjkTFOiSJ1Tg6MRsCeG60kuUFydmK57UXSu0QmBW8jox+3neEbP7BEY2W
 b25B/Gd80Y+j18rMEpHK6NyJRKOG0HDubGABBuek9ltblYQxYx5jxZICSW1OWM4wnuQ9
 8jcXukySQK+O1E4gz1q4iyp0mNvm+bSbwywMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777549191; x=1778153991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OrRYGTdyq7s0A31ABfvjf4Ro2tkXeUzCc7DLYN9Tp98=;
 b=onEW+AK+bJm1/Vmd1+Tw9mGsgLfuSA6TzHLyPMqFW2GP5eGrQvU0ZIVV4DVZaMxVqH
 EYAf/SWohZ+07aFnASckQnADeZX7N7iASMKnpYQThu+A3x+6N8QnytvMJiuspGw3Fka+
 SHOVdNCAJCU7r9LWRrXaSlUnv3oc9kZybYT6Rbi1BjoTTJ/UbQVdEvt2vBk6/2lsxEAm
 Z+H9YQe5TgLh2elZcmwQxR1A1JjmJkDlDPm1lkiiExsUw0To9xBv0/s4VMv1mWCogLlL
 O4okdlVeSrxKx1wNfTWb3Z/pHGbEyzm/DehFi4s2Nq+VlcuTiSxh5KlKBKYX0qizzRjd
 M7uw==
X-Gm-Message-State: AOJu0YwS3XTCJZq+nDPmPHSuHB+fV8z3t8t3Kg6ipsgovGXXor7lmOvc
 LDRQeY+0rJeM08eKmp67HNEeYawjw+BfektbrBFsTYRJQ4HspgKHmtJAqJf47EgX+a+CgJRSY/k
 zmoLDwg==
X-Gm-Gg: AeBDiev+UmlQPDvDm16/4YbI40wNeA5KiC2tisC++FdT/GIwJ9CZpuZkKlwXdJuQDA9
 V9m5jjb+KHcc5Z5cjf8Ex9KHGpUliRjtwRyLD7ipj3GTxs3UF6TY13FFl2yldi0s3bR50mes8wN
 3Q4LhJQQOFbi6wtXNTBGZREceSZv0dSkxRUAK9LBIvsscwA89mLmtGB7GjNVMkRkPdFJ2wURe2q
 k29iL8Xh4I+L+w7kOjBNm0j5yJtKqzgEFjXM1Fk3vyCIm1lZW+53wMXCq9XXUsfQN72f/GUnpIN
 Pk03rOEUlzonnJOd2BVTj8hym6RgcVAjjYQ1MEBX9dHsxP0gnUm1/G2V9HshZGmgW1JOaLJLxLR
 LucFR/tUmRIkbwHoV//k53EO6GRwPpw5LsQE1XvpENxKLHWPzj0sxdP4YEHlM/XEyffvXO4JQ/T
 yaqvyAi2sop2IO8cc6pYS0MV+VHg/N
X-Received: by 2002:a05:6808:8489:b0:47b:d07b:ec9a with SMTP id
 5614622812f47-47c6208140bmr583516b6e.15.1777549191433; 
 Thu, 30 Apr 2026 04:39:51 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c43ee0400sm2715523b6e.7.2026.04.30.04.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 04:39:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] bitops: Guard GENMASK and GENMASK_ULL against prior
 defines
Date: Thu, 30 Apr 2026 05:38:33 -0600
Message-ID: <20260430113937.1274693-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430113937.1274693-1-sjg@chromium.org>
References: <20260430113937.1274693-1-sjg@chromium.org>
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

Some headers - notably the ec_commands.h synced from upstream
Chrome OS EC - define GENMASK and GENMASK_ULL themselves before
linux/bitops.h is pulled in. The unguarded definitions here then trigger
a 'redefined' warning at the second site, even though both spellings
produce the same mask.

Wrap the two macros in '#ifndef' guards so a pre-existing definition
wins. The U-Boot expressions are unchanged.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/linux/bitops.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 29e0da48de8..8b381c916cf 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -26,6 +26,7 @@
  * position @h. For example
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
+#ifndef GENMASK
 #ifdef CONFIG_SANDBOX
 #define GENMASK(h, l) \
 	(((~0UL) << (l)) & (~0UL >> (CONFIG_SANDBOX_BITS_PER_LONG - 1 - (h))))
@@ -33,9 +34,12 @@
 #define GENMASK(h, l) \
 	(((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
 #endif
+#endif
 
+#ifndef GENMASK_ULL
 #define GENMASK_ULL(h, l) \
 	(((~0ULL) << (l)) & (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
+#endif
 
 /*
  * ffs: find first bit set. This is defined the same way as
-- 
2.43.0

