Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27BFD1D483
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 19:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA7284285;
	Thu,  8 Jan 2026 20:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eQMO0Ad9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87F7A8422D; Thu,  8 Jan 2026 20:16:33 +0100 (CET)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEE6284285
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 20:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-b8010b8f078so566540166b.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 11:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767899790; x=1768504590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xAYHI9+ILIhYyNmCSRMcUCdVDOq+hC6B1cRrxAF2ceQ=;
 b=eQMO0Ad9XUsyGW9Q2y/DlEiyQMymctsyN9XXUV0wxTsPfmtWpQtMCNSyjONrxXk2JQ
 BxTTfozQ8lx3SY/cEb9C5rn6QCCDw7AyOI6zzhkSZweMBGf2iytIDuaP3zEhn7l07L9O
 /uWF8ecSQbleSBkQUqivCqinvDEcFfxSvXuGs8l2Yqut2/OMm392fl7uyunTpqYdBhdi
 ocbxXZmPy7NTyysVrgsZfZobVo9WtkajZR9EIU8KfUtKDHsiJ8+hKzfodBhWM/xOIYM6
 9ObbTYNMDeTvh6bX4Yx7Ts/rBLF6sEiIXZN2aD1D4j6zjOh5TocL32ybAeW4k2nbfukD
 4oLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767899790; x=1768504590;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xAYHI9+ILIhYyNmCSRMcUCdVDOq+hC6B1cRrxAF2ceQ=;
 b=YlrcBHNGd+h0ha1V9ubeiith7cHTyw/xG5O0xvS44weu1oX0NQgLcPvRtj5yxLYur/
 H4LWNohJ2OCFogdOB4MAlsJEEeT6L6GEwnqHZN9lgZUiqkO+p751BX261ChxYBGKnQ48
 yUD0Y+0d81oMUL2n/rBxv0ytaMSQOgAI52iXSd9CO4gQFvvJo4zFdjGJAcImCzP2nc+S
 sajrNWjNa4fsoLg2YjPgjXx7aritV23xITBMg9p97+Wms5dGNvxUpLEyBXXHH+RyeAfn
 4krZ5omN1jLDVZHRmvV08ZD8XoFg82Y4UIys18439+hIfJbR6SoBwV1CbRtBJg3icTrz
 d2fg==
X-Gm-Message-State: AOJu0YxtyXLsMLR6Dr+bokFcSZ//QFZYHC/2Ae3YXhpgjqELRWCqOsQK
 7QOGwinLgZsrCLoDqqG3z79mrLU51CF9C0ZnqrrdzRkmK0VhSQKt3rWogLBtcdTz3tyNVNU1ZmN
 tB5T4jqY=
X-Gm-Gg: AY/fxX7ELgR5L3b7YX+N4YpGHnT3m68VzEmElXZx3iqFUZYC2bFjmyBz3gZZq7WhHOH
 VCvHEOJLapEJjZMc55jXSsfdA6hZrkbO1Vg6hxbqZQcDpSmec5QVf/y+IfRZTWETZ/4nKesmzDN
 7fjRdGRYddbK5wY0iIFy7ZveW5Lq3xYMqkAe/lGjECpHWnU5M7AQErnEtUaR+WupuWqemrsHTVe
 NpM+nUz5VBEu0hIe4jPVfEG8Urdn39N3xIwETBcojYYleUFVfUaNkSRrEGQPdbpLLEcOj7oZNno
 BmaEkWc1UNnSYDg0UQDsCW23yAJqLISrSzuW5MKUpyhELVgsEbGTskKRFBpKKB3vocRY4Tm46Jw
 7zTRSu7cnClTjPnKcAp8yJW+ZuhtknSxhcQPPNnXZlqH3BGIgzsLgc13SBQoV6cT711BIp4VJjr
 9ja3qLUp3I3NLPKcYGLcVzSX+XMnZzE9aKUx0fWxVRu0QZSX3lTiG7zxLWatF+Tg==
X-Google-Smtp-Source: AGHT+IFPlPDRxEi276vqVWpm6m97sW6YtWoWdxOPxiWh4RZsiqVMlt744SoAZdzP29dVnduOjIdQzQ==
X-Received: by 2002:a17:907:9483:b0:b80:3101:cd13 with SMTP id
 a640c23a62f3a-b8444d4eb13mr833660266b.10.1767899790133; 
 Thu, 08 Jan 2026 11:16:30 -0800 (PST)
Received: from lion.tail248178.ts.net (p5b29e30b.dip0.t-ipconnect.de.
 [91.41.227.11]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a563f73sm922240266b.61.2026.01.08.11.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 11:16:29 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] ufs: uclass: fix potential unitialised use
Date: Thu,  8 Jan 2026 20:16:17 +0100
Message-ID: <20260108191626.3119582-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.51.0
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

When host_ref_clk_freq is 0, err will be returned before being set.
Assign a default value to fix the warning.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/ufs/ufs-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 3c8e4299259c..8dfba2140b68 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1854,9 +1854,9 @@ enum ufs_ref_clk_freq ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba, struct
 }
 
 static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
 {
-	int err;
+	int err = 0;
 	struct clk *ref_clk;
 	u32 host_ref_clk_freq;
 	u32 dev_ref_clk_freq;
 
-- 
2.51.0

