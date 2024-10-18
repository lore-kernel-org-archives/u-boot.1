Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BED2D3000A
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 13:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C97789093;
	Fri, 18 Oct 2024 15:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CRSQPbLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A61E89057; Fri, 18 Oct 2024 15:53:12 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6245088EC9
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 15:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a628b68a7so199544266b.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729259590; x=1729864390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bUKneQogeTe3J3lhTG7jtybMtaKq5ic7SwNABOZ9fkM=;
 b=CRSQPbLQyYOwoecXoq8+rF/fF9zSoDRLWbYkYFRTszaB7A71GvR4qk0ANLRl+FwuLx
 OdTgLYsf0ep+Uti8+HOjEGflMt+ifXBn0QnZnhcbUso6H66JnyWEXp8jVcdwA29JXuAC
 U73BaKTad9eHvCPx1kkmnflLajiAPOS9zwSwHHX8x9dFFAz7igoEBUs2ByHF1d5gPDN7
 QwNKMnjbFIjUyW+0J02+K9JHNTd5YQdFgE6gPIs/3OI8K0WvbC2OmaJ7ddz0QjrmC7ku
 7eDJMy75wXatwJD0kXHoQ3+cT+/g55YKGCQO9gA6pnj4tWO+w1Nuqk6j88ld7LtEqOs3
 x9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729259590; x=1729864390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bUKneQogeTe3J3lhTG7jtybMtaKq5ic7SwNABOZ9fkM=;
 b=TR8NkTlf7XFpEoyluf6f3iieZglzJp2F3IdzmcrF+1lhL6O+y5pfPSFDc0iYqchLjS
 lAMY1h8wIc9PjK/axVfvs++CDoBjzQyIZvgXYIxj4aBXkXOnn5yDna3CUKzsoaGzqrXh
 p0OtcmZmUIFPWdnCRu4rdbcyBaKNCky5//w4wdLBnHsjsPkfb9JIBByG85g20BfkU5Me
 DDqJaq0iYIrRF6V4Ho+6y3EHi2Odu1WPaOZZDCcYtJf4oI+Rj8awUfNtNPb6FJw706UT
 Ng17fUX4Pf4WZsGfk+Yp7iSJfLwaHS3Odc1bIk9QkktjTp+0u9iVR5LMGMbq3lxelEAd
 yw4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZarFVp7MRONw5jenbZuVZTyKEsmEQIgf7Olv3CvkU6AQ5t3Mr5vtLk+8bbetCZdKxaaOtMSA=@lists.denx.de
X-Gm-Message-State: AOJu0YyPB5Iy/XhB56n0RbuMtDTb2yRBRKFy17i+ne8IHZsFTpJeEPG0
 N7WyuQ/4TMQWmkMBOs/iqQkjevkUcQqQ8N0vz/1JpZ5j5l1Z2zdIOM4RNPBEVi10nKSmtg1fKXU
 g
X-Google-Smtp-Source: AGHT+IFvhnx3pv/qJvx3Rik1Hdbh3I+ZLlMS4OozZne9OLbE7DJXU+EhzaqNWVArisNjW5umUIlmhw==
X-Received: by 2002:a17:907:3d90:b0:a86:82e2:8c64 with SMTP id
 a640c23a62f3a-a9a69b75728mr216607266b.35.1729259589758; 
 Fri, 18 Oct 2024 06:53:09 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a68bc4f97sm99002066b.116.2024.10.18.06.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 06:53:09 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH] lmb: notify when adjacent regions are added
Date: Fri, 18 Oct 2024 15:51:07 +0200
Message-ID: <20241018135112.3978130-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.46.2
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

lmb_add_region() returns a positive integer if the added regions causes
existing regions to be coalesced. We still want to notify the EFI
subsystem about these added regions though, so adjust lmb_add() to only
bail on errors.

This fixes EFI memory allocation on boards with adjacent memory banks as is the
case on several Qualcomm boards like the RB3 Gen 2.

Fixes: 2f6191526a13 (lmb: notify of any changes to the LMB memory map)
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Cc: u-boot-qcom@groups.io
---
 lib/lmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 78fe2d4de7c6..7e90f178763b 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -486,9 +486,9 @@ long lmb_add(phys_addr_t base, phys_size_t size)
 	long ret;
 	struct alist *lmb_rgn_lst = &lmb.free_mem;
 
 	ret = lmb_add_region(lmb_rgn_lst, base, size);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	if (lmb_should_notify(LMB_NONE))
 		return lmb_map_update_notify(base, size, MAP_OP_ADD);
-- 
2.46.2

