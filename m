Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BE4C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 15:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F288432F;
	Wed,  6 Aug 2025 17:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G3FltEVO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB0E2842EE; Wed,  6 Aug 2025 17:24:41 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E3384312
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 17:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b8d0f1fb49so3571038f8f.2
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754493877; x=1755098677; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MYkTfxUaNShseXoYhFDZefL1wRCTEwkg8adkAlfhu/4=;
 b=G3FltEVOea5NnWWvUhHPi2c1PsrcuO6uxatM63fA0WsOwVmM37LlmOPQJvwPoE+BMV
 ODgbp2EfUlOaeStrtR6bHISs6yoUd/v/LQu24hBLdpuB5O/bxMpwhrYg2FDMZKGPLQ3n
 4zI+YWBtLQNNQfE9mogCExYGQTnaeQ6tl+cGCFiaaTaXqNSBDk30/mLpWqnu8Ec1WYlC
 KXpXxkVY6dWcm7UpDXBPCcgdMRqQBMHlHvBVeJFsNNnuI/1OMkThSa2xQOCJBEwdOFGe
 BNwYtp9V08oWHLa+Vj1YAvYBRu79kRQkwYvcgWYnjflBRCpwJ8WzHwfzbJrLnI6Kf4Tb
 RhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754493877; x=1755098677;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MYkTfxUaNShseXoYhFDZefL1wRCTEwkg8adkAlfhu/4=;
 b=q6c03tU3GAlpXMt5pjbx/dKefxhuNhk+q8Woju0czZ8m9bEq2n/Kt+Ocl+c+Lh2W5p
 eXe7/JqrGBgH0kow8jeABf+xtBKxpXq/m3wVAvAhSY7Vss54L50f+F3Rao4iuFi0OJtr
 ffwiNK5HUtVt/vUWpeQNeB3xxwMGN/a1qwJtPtCup3DIC4cF7bX8JWSP/bAl7x/i1Yts
 E1F6+wNOD1qarcYU54/7o4oyHKjA7pjbm67OsVO6fT4b+vp97vUN31kAdMCxIMXaqWI9
 CecuGpoIwnA5t7yxE67AVtKbCEFvh9tie8TPxoCZRYaX3HqGmdmg7rbNSfNirOkztZ8x
 l8aQ==
X-Gm-Message-State: AOJu0YxeZF6q+NLiWmB64lZs1ZR7+BQXrdRDRV/9goAfGqNc3A48PBsK
 bMmgFTOUcxypXKe9W2diq8tA2T2hfCcH2tn2bbQ49ABS9aGz7dBCFzCzhsBl6u0nnyk=
X-Gm-Gg: ASbGncteRgMbOfp97CcJEAWxxuqOJZRvfFXIwmfFg4RX4edf98hsh0ilIjCbzXEcV06
 kYsR4ri+iKEKFS4MegnGQqxMLyjfH6k0m5Pl8hhkZgfrcLANB68s8/ZApc31IJiI8yqC4Dx16HX
 1g9ORdi9sYVg8GvQWec5Lw+2Dc2Muc1B2NJQZ3YUZBzLQkxScAmD+kb1PoBIJdEtxgdSiHxGJl/
 aRPQNsxRbg9pVdsT83LIjBQn7K5NR22AyULc5qb8SBd8dJONLuq+45OYSIDe1XyY9PeN+bEVS9J
 lSIiAFFhCQ82uNs8kPBigmqSpi1SZkxTFcJ+UoxGQAj8lRv7j5Fw8bX2LjZlDLaMoo1QnqUUe9v
 oNdM2jVssoLK/Oh8iPyR34K/vGS5o1JAmjjukmb6bonBnF8CETZs=
X-Google-Smtp-Source: AGHT+IEOdWz+E09o7T88ZuWIgg8KJjktE+IuyMsHB6sAKXQWck8ZOlP8EULPedoq+KFwn+gPtSQYng==
X-Received: by 2002:a05:6000:22c7:b0:3b7:8984:5134 with SMTP id
 ffacd0b85a97d-3b8f41b2be7mr2454241f8f.16.1754493877396; 
 Wed, 06 Aug 2025 08:24:37 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:6501:9a0d:7129:a02b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4595cfea56fsm98132075e9.1.2025.08.06.08.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 08:24:36 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 06 Aug 2025 16:24:34 +0100
Subject: [PATCH 2/2] phy: cadence: torrent: Set an error code for return
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-phy-cadence-sierra-v1-2-2f0830caaacb@linaro.org>
References: <20250806-phy-cadence-sierra-v1-0-2f0830caaacb@linaro.org>
In-Reply-To: <20250806-phy-cadence-sierra-v1-0-2f0830caaacb@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In cdns_torrent_phy_probe the test for too many lanes configured does
not set an error code before taking the error path. This could lead to a
silent failure if the calling code does not detect the error. Add the
code to return -EINVAL in this case.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 1f566d082f9..28fe026223c 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -719,6 +719,7 @@ static int cdns_torrent_phy_probe(struct udevice *dev)
 
 	if (total_num_lanes > MAX_NUM_LANES) {
 		dev_err(dev, "Invalid lane configuration\n");
+		ret = -EINVAL;
 		goto put_lnk_rst;
 	}
 

-- 
2.39.5

