Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54D4CD5BB1
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 12:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CB4A8469A;
	Sun, 24 May 2026 14:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a6G6YhJK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 655EF8469A; Sun, 24 May 2026 12:06:58 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E0EF83EF9
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 12:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prashant.kamble223@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-841513664bbso1712074b3a.1
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 03:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779617213; x=1780222013; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhiMMGmSg09qs8DEOf4jzUPR27m7h8uatNz6Czgj/j4=;
 b=a6G6YhJKh0zX9liOLs/SAlBbXEMuMCs4YQYvpEdoZRchRTxgyuJE1zleIwVVsPnsE2
 NjA18Wpxm3B924RokQrwa6LTyqVVV+rzqP52G+A26b1Etm3v/D9gVuRbc0rMlqWHoeTC
 vGHzqIW3Im6zKyuZrestzgow7nFOXPl4J7OkMihpOnrFwpHIk+HM/xFJKjzmtsiVfUVl
 hiNutQk68otlYv1ig0iau8oaKkkYP78tUPvMG6mtHnbJT+tvEbZZF23kZt4M8cQF4rUY
 Kmlp+HEbP4+aEqa5AJYS3aZY19uPgzsBYsbquXsDQZ7SqaWkNls8elTR1EEquADrxSm3
 zY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779617213; x=1780222013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UhiMMGmSg09qs8DEOf4jzUPR27m7h8uatNz6Czgj/j4=;
 b=rU5G4EUu3lUovPstSs4DAxYLh6LJRT8G6x7mZOAnIidKsLe7kti1N89trM0tSh2d78
 MmJS+iUYSGG4lb0p3ekI9u8ahV0oXq34vcFRuoCwmNclPQCyYB0ceUL1axnp9W/ysD8t
 j2DVxQP3s49hqKJApLfKttid+ADVAT/TeGOd6GqKQwxZfk9IpXGlM3TZNd3KOKdy8jst
 D6fIN+voeEhr9o3RM0kjQaDdQ16gIapaHtIfxqchyMxivdoMykpG4yXQbjREDJ+HBy24
 9c/ryIiwIqkmj4I1SndG6dAY/rPRs3jX8QeEXFXJKvRW/v8OqbfMMnNp1WN+t79Fn8D5
 xwrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hIGz6ujTjTjAc23Zpvg9IxaIp5cFQyqcIi0EtCOrGrfFNqAfQdJ8fDsK6QPs471S5WX8q0+s=@lists.denx.de
X-Gm-Message-State: AOJu0YzFR8eUwsqHqUooIJvBnp6AiGMYoZXqmmeyvA0T2YRa8KALVHfz
 rJw4UVmFJKRNc39ZfClGE5IT3gor3PgRV4p/0IhyV0Ux2x7HWLw0lb7GbvPw1+2QmHM=
X-Gm-Gg: Acq92OHkG6kZ+SMDxf8Bscrl0ZpHYf3vcSFkoW/f7CEwXtb75Ei/HQSdrnO7mpSyyek
 UAX37ZISkp9hOHReyYDnRvR5yZutqVF4rpBxtoQVHpFoAHgDPY7kZAUfFOtOubg3jA/8Dpjsx5E
 LkVIpu8i8HX3pUPMCK0K/d7/CgyfDYjVIDMGbw7kL1kiYvEPRKdP7Qw1VoDObeAbcWcN61aB0Sn
 4gAffiWFvEZBd//acxgcAoUzz3DKnJWBJalwmnyHDy6GzIex9Sb9nnJdkotmZ9rgdUYU0eLVmle
 OQITKOpR3Cw8RKw8OeNk7ofKE0/LMUEUnxOW6OtYAy5Gl7G+zAemUuMmMb37QYI9X5qos8znuMO
 0ig1mDi2Hnfytr/2xN2tUziix5zt0IBtUO8LpgNta0MtvxFxQUmi/v3VtawmEekCf+KUvL2xfDQ
 L0V6FMlOnhH1SGTAFU03pyP9JWdc/CZ512V59JQf7HVyBk+EvnF89E5+7m7i49p58GALsa3AoVM
 oPZJcoXOg==
X-Received: by 2002:a05:6a21:3992:b0:39f:2af3:e8ee with SMTP id
 adf61e73a8af0-3b3296a03a9mr8080960637.13.1779617213471; 
 Sun, 24 May 2026 03:06:53 -0700 (PDT)
Received: from prashant-Victus-by-HP-Gaming-Laptop-15-fa0xxx..
 ([49.205.205.62]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84165009761sm7639457b3a.60.2026.05.24.03.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 03:06:53 -0700 (PDT)
From: Prashant Kamble <prashant.kamble223@gmail.com>
To: 
Cc: prashant.kamble223@gmail.com, Neil Armstrong <neil.armstrong@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2] nvme: fix dcache invalidation range in identify command
Date: Sun, 24 May 2026 15:36:21 +0530
Message-ID: <20260524100625.11135-1-prashant.kamble223@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519035608.15186-1-prashant.kamble223@gmail.com>
References: <20260519035608.15186-1-prashant.kamble223@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 24 May 2026 14:52:27 +0200
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

When the identify buffer crosses a page boundary, PRP2 is used
and dma_addr is advanced to the second page:

    dma_addr += (page_size - offset);

The subsequent invalidate_dcache_range() calls then use the
modified dma_addr instead of the original buffer start address.

As a result, the beginning of the identify buffer is not
invalidated and the invalidation range extends past the end of
the buffer.

Fix this by preserving the original DMA buffer address for cache
invalidation.

Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Prashant Kamble <prashant.kamble223@gmail.com>

---
v2:
- Align invalidate range to cacheline boundaries
- Add local helper function to calculate the invalidate range
---
 drivers/nvme/nvme.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 0631b190b97..da7dad9f52b 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -27,6 +27,23 @@
 #define IO_TIMEOUT		30
 #define MAX_PRP_POOL		512
 
+/**
+ * nvme_invalidate_cache_aligned() - invalidate cache with proper alignment
+ *
+ * Aligns cache invalidation to cacheline boundaries to ensure correct
+ * behavior even when the DMA buffer is not aligned to page boundaries.
+ *
+ * @addr:	The start address of the buffer
+ * @length:	The length of the buffer in bytes
+ */
+static inline void nvme_invalidate_cache_aligned(uintptr_t addr, int length)
+{
+	uintptr_t start_addr = addr & ~(ARCH_DMA_MINALIGN - 1);
+	uintptr_t end_addr = ALIGN(addr + length, ARCH_DMA_MINALIGN);
+
+	invalidate_dcache_range(start_addr, end_addr);
+}
+
 static int nvme_wait_csts(struct nvme_dev *dev, u32 mask, u32 val)
 {
 	int timeout;
@@ -456,6 +473,7 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid,
 	u32 page_size = dev->page_size;
 	int offset = dma_addr & (page_size - 1);
 	int length = sizeof(struct nvme_id_ctrl);
+	dma_addr_t orig_dma_addr = dma_addr;
 	int ret;
 
 	memset(&c, 0, sizeof(c));
@@ -473,13 +491,13 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid,
 
 	c.identify.cns = cpu_to_le32(cns);
 
-	invalidate_dcache_range(dma_addr,
-				dma_addr + sizeof(struct nvme_id_ctrl));
+	nvme_invalidate_cache_aligned((uintptr_t)orig_dma_addr,
+				      sizeof(struct nvme_id_ctrl));
 
 	ret = nvme_submit_admin_cmd(dev, &c, NULL);
 	if (!ret)
-		invalidate_dcache_range(dma_addr,
-					dma_addr + sizeof(struct nvme_id_ctrl));
+		nvme_invalidate_cache_aligned((uintptr_t)orig_dma_addr,
+					      sizeof(struct nvme_id_ctrl));
 
 	return ret;
 }
-- 
2.43.0

