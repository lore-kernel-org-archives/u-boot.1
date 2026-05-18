Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E726CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 04:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1766583AA9;
	Mon, 18 May 2026 06:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U7HALrzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489C184150; Mon, 18 May 2026 04:26:05 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2190F83AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 04:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prashant.kamble223@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2bc763e2ba8so6911015ad.3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 19:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779071161; x=1779675961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cfTNEqcnDWokfjXi+7yun5yDliYNlMT0UHljAsbnc1w=;
 b=U7HALrzda0KCP+P3thn9Pzl5Kra+rNb/deJPP5FLZlEC2/x62Ed86muJZWNrxz9f9f
 8exoqipqKR2BW28wU/hMLg1N6NOIl1HtNEhOYsoF764f1U53wOieUv9nACGj1OpR1ZOL
 qXAmCaQ4jxRoZkbGZC1aq4I3yxJEuIXHPup/8aL7LiO9Kz1+rHVDe+51lT7aSa3fMr9C
 CwEWm5UMPlmYMhTK+hleqhuSc+Syb/HmBvo2o/QB8dNFasEIRXP+F2IK0n/oiZn5AHyh
 0t9Nl3adI9ClVDA03yuIt6sE0lZxPN/tcSHjjZWMRr1jkq0EIU0MZ8jrhRmKLJdXAmw8
 mZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779071161; x=1779675961;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cfTNEqcnDWokfjXi+7yun5yDliYNlMT0UHljAsbnc1w=;
 b=XLRbITIqQxBmKiaic9MvJFiXuB89ElGXm5v7T8V3pe1rC4fJ4szkUhqCfllQu5qwct
 kyfMscm/V+Z27th0XcoJ87WiREHBgKT0y2plDiyNF/NDIXIZWwXqVCO4w84KXayq4bDp
 +KvxZ1F8qFwuLbOC+bqv+aBbRf2dRA7iE2UzQ4UdLj+Ivae0/E06D7PwGDt5OypEKsLn
 Anj2I++UDLMYR8lxTWnrRGdQ0VSk1qlPiOXMZcjWHM7/6y6GZf4E69HvMQzlmxUh+fK7
 IzmO2wsPlscv6Mgi7hbExliTzstjAapZmGttyGmlpLvUJE8EA3QV3RpIZo9H4xz1JqSL
 FmGA==
X-Gm-Message-State: AOJu0Yw2N9pZ/AKneMTMVVBE0O8l9ZJXwEiXWgpIdZ/vjbc0o4/ouPjQ
 e1t2w3KIPj9kfn8G/dFjMYaCgtt8BI+3K4CeE8ceBfyTvTBDgbGpD0TNaG3w2RdM+a8=
X-Gm-Gg: Acq92OFmJCDAIawovRlRMJQiBpq3sXhWUEf7rW8R8yJEAKtE86xWoyKLnZQGPZdMVzI
 2rDoc/Gr4QLSg/OvKI5voGrbcY0IEj9R8Bb6O8pVVVQLEeMKGbS4HiamjFIvK2V5DxWcknlETFy
 JP+AU4AO/DRuDVxX8BDfC3s38t+Ysop16gDSS2u0xesjxEdo53epU2v1EURPxG8mcO+ea8+6jvS
 ioboVIlPU6CEmk9t+vZ7apt2cIAoINY+Pv0YoAqO94j7KTY4bca8ZozFWHC08BKJ3JOA3p1+9FZ
 UJcDYgzOCHkND9nThN0PjZtwG0Ao2Cj6Qt6EABfyfv6UoT65vSupBxgoC7Mv8evEM/9/Xx2ASk8
 rUcoDq80CiEnX5zYAIB570MeVDYl3P2x+gwR18MWtIzwVYWD534bc0mO7yVohpGsJVpkU7MqoKJ
 HdvrHOOmEdhtuilRQAkiOGnyIKXYhAJoM8VjgnLXMJeFXulevai2seG9c0/5Q4z4YfTFcIdl+kN
 QUnZYR2MhXL
X-Received: by 2002:a17:902:d2ce:b0:2bd:ba44:6c07 with SMTP id
 d9443c01a7336-2bdba446c6fmr63442025ad.16.1779071160976; 
 Sun, 17 May 2026 19:26:00 -0700 (PDT)
Received: from prashant-Victus-by-HP-Gaming-Laptop-15-fa0xxx..
 ([2402:e280:3e1d:2f8:5e4d:cf9e:625:dac1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5fe67sm136422375ad.3.2026.05.17.19.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 19:26:00 -0700 (PDT)
From: Prashant Kamble <prashant.kamble223@gmail.com>
To: u-boot@lists.denx.de
Cc: prashant.kamble223@gmail.com, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH] nvme: Fix PRP list pointer arithmetic for chained transfers
Date: Mon, 18 May 2026 07:55:35 +0530
Message-ID: <20260518022535.17197-1-prashant.kamble223@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 May 2026 06:56:42 +0200
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

The PRP setup code advances prp_pool using u64 pointer
arithmetic:

        prp_pool += page_size;

This increments the pointer by page_size * sizeof(u64)
bytes instead of page_size bytes, resulting in invalid
PRP list addresses when multiple PRP list pages are
required.

The issue becomes visible for large transfers, typically
above 2 MiB when MDTS > 9.

Fix it by using byte-wise pointer arithmetic when
advancing to the next PRP list page.

Signed-off-by: Prashant Kamble <prashant.kamble223@gmail.com>
---
 drivers/nvme/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 2b14437f69c..3ce98de1a5c 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -94,7 +94,7 @@ static int nvme_setup_prps(struct nvme_dev *dev, u64 *prp2,
 			*(prp_pool + i) = cpu_to_le64((ulong)prp_pool +
 					page_size);
 			i = 0;
-			prp_pool += page_size;
+			prp_pool = (u64 *)((uintptr_t)prp_pool + page_size);
 		}
 		*(prp_pool + i++) = cpu_to_le64(dma_addr);
 		dma_addr += page_size;
-- 
2.43.0

