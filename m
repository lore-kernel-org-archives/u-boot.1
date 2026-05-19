Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03B1CD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 04:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F001E8460E;
	Tue, 19 May 2026 06:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fCRqzsJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48D7C84693; Tue, 19 May 2026 05:56:19 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F065803C6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 05:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prashant.kamble223@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ba4efedbeaso21986025ad.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 20:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779162975; x=1779767775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZkD1KTnHI6e35BStmyI5Q2msMq8wIxZkKQmjt5/drLc=;
 b=fCRqzsJlX2PfVTPFIbXmcXf2yiOxXTaK/XNNiMG5023bt1c2Dz5ksnAozLDhCV2QlE
 RDg6ypvY+ooKgxMuehwEmsG3wrC2QkzbkRb/kzQaX/VoUu3DL5LM9BjA2b2b/PXnVaKc
 SV1FwPoyYC2VJ21UejYUU1DrD3DS7xmgPtY79mFiseSEY/GMeF/uvslnN5ybYPpCgeIk
 U+hpkqs7GgR8acNq34xwQowZY7NLFbMc3kp03kcpEdPpw7X0Bs0nJC5eLILF6Nnm5NpN
 mbwhYUgrBXUT6zHj0HMztdauMoaC3+CkFAfcnljusTDbhWGccZfDcYCSROEkZbmSPSVS
 Ovmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779162975; x=1779767775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZkD1KTnHI6e35BStmyI5Q2msMq8wIxZkKQmjt5/drLc=;
 b=kwMlz5olucPowblR1xufoIwyHXL6i6/taRTDxv5b6EbzIEx5/FGEcAba2rJeRoOIy3
 ukPc6f283oa3DQalpdk8bXZMbWzpYxNTAYuF+2LcN1Q9WCpU+jZGrvV4Ih9S9IPLlUzu
 Xy7FXMNOZzXr9XiFcfurlBIJ5tn01ka1XcMHOwzKjsl/ntzVrhh3hj2khSQG0wrUNIDj
 +idP3W62y2biDEPwhzE5HH3zFKlOqqoWTOZh6EuWqfXly/8xCvht61sbktfOzXIe5aJt
 pea+cEy/eoGZ3azCOPOXFMZP/oMFSlfJiroAMv8DcM7w8FjolkuH/dK6x9TZNtV4+lXR
 +SVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dDVPMmK21pTGajH40cDu9/14jvyLtovTX8Vm/caxY/WPDecEXQ2UdtS5C1jfWI+0QEJWz5BM=@lists.denx.de
X-Gm-Message-State: AOJu0YxG8LyJW9LgKXG8hSv3f2GbBkVYy1elwmp931NdEoE5WPMvggE4
 iPRkFjz770O/G/OsjjRaiCeC72d6puC1gIsMVKlZvh7YT6HFBA64hEvraQk9JQoE5Xs=
X-Gm-Gg: Acq92OFnnLcyUJ6oyHa2zsOVkJnZIp4uktBA9NSuKn2gnaD6h+GE2GlGkUXegx6AJG0
 lmDk836Dugl+/WYPMQmESkQZeCi8GNl3F5F/1f6b/E5f4dennXvAuCLtQpDWK8CAFXF2lvoqL4N
 p8De41PE90KncNF3PNEqjry6MXxgcHZ69oDQCh77f26Bkn3cgUz9nOxEgRDVTXuz6Yjf7GQMIsP
 yj8avsA7f0wMwRfajJ3Qx3nC7uTjqCJzNTnPpq62gGivVI+J0/R1uDeruC0hRx7Ife4oS6bAgnZ
 40re1cdOFAEgrDNT3As1/5gzxoT5FOr6l3uAUIqV46MqakVqVIJXotIgrwWfgTKquu/2AiGshSP
 rBKqY6xPkLNNNLhIpqPUbqbEaKS7kzxVjkOHUrOhgWIvU6BTc5vSezgwAal7BH0FoyD524YQQ4S
 TtSXga/iR4mQ466Jb0yGeU9uWrCJVfXFjHUx5FGn9mn+W1NPCXKzVb0uAx0OGEg/9Lsg2ZJfVtb
 ZuWAUXkvXaCsg==
X-Received: by 2002:a17:903:240e:b0:2bd:3bfd:74f2 with SMTP id
 d9443c01a7336-2bd7e831c89mr193677155ad.10.1779162975462; 
 Mon, 18 May 2026 20:56:15 -0700 (PDT)
Received: from prashant-Victus-by-HP-Gaming-Laptop-15-fa0xxx..
 ([2402:e280:3e1d:2f8:626f:a898:813f:854b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe4935sm175425385ad.42.2026.05.18.20.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 20:56:15 -0700 (PDT)
From: Prashant Kamble <prashant.kamble223@gmail.com>
To: 
Cc: prashant.kamble223@gmail.com, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] nvme: fix dcache invalidation range in identify command
Date: Tue, 19 May 2026 09:26:01 +0530
Message-ID: <20260519035608.15186-1-prashant.kamble223@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 19 May 2026 06:24:25 +0200
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

Signed-off-by: Prashant Kamble <prashant.kamble223@gmail.com>
---
 drivers/nvme/nvme.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 4f9473367d3..298010de536 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -456,6 +456,7 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid,
 	u32 page_size = dev->page_size;
 	int offset = dma_addr & (page_size - 1);
 	int length = sizeof(struct nvme_id_ctrl);
+	dma_addr_t orig_dma_addr = dma_addr;
 	int ret;
 
 	memset(&c, 0, sizeof(c));
@@ -473,13 +474,13 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid,
 
 	c.identify.cns = cpu_to_le32(cns);
 
-	invalidate_dcache_range(dma_addr,
-				dma_addr + sizeof(struct nvme_id_ctrl));
+	invalidate_dcache_range(orig_dma_addr,
+				orig_dma_addr + sizeof(struct nvme_id_ctrl));
 
 	ret = nvme_submit_admin_cmd(dev, &c, NULL);
 	if (!ret)
-		invalidate_dcache_range(dma_addr,
-					dma_addr + sizeof(struct nvme_id_ctrl));
+		invalidate_dcache_range(orig_dma_addr,
+					orig_dma_addr + sizeof(struct nvme_id_ctrl));
 
 	return ret;
 }
-- 
2.43.0

