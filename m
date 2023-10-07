Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB29E95A66
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B9E286F48;
	Sun,  8 Oct 2023 01:16:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gxI/Lkwe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50F7C86E9F; Sun,  8 Oct 2023 01:14:00 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3464386EE5
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7a26fd82847so141434239f.3
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720390; x=1697325190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkzDQ/S/CT3zcUpv9qb05eSd0JS/JFyueV4dU8Nfim0=;
 b=gxI/Lkwe/L+WbpB9520yaXIc7Xzm5pNu4/NMA4ijBLifwXfmd8I3xDBLnPIpkavwjE
 gEOZUkF3XETCbQpzZR93e2Wi1YFZZCZeccYqrSCS5HwveOKkSub9RqOBkzx8SYyuqZbL
 kD9EFYXjMn3BmW4BorAA5QHT4qpyVcP9vh6Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720390; x=1697325190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkzDQ/S/CT3zcUpv9qb05eSd0JS/JFyueV4dU8Nfim0=;
 b=aA0P+0Fyx8uFTcjvanOKd21eWMikjlUbQVqhr1saaJO22RdEB+C2Mak7DqaCwlDNGw
 vlbxdScwT2Pe85y7Mmv9egO2rkeas5v4sh0v69zWdrZWPV1q7Zm4oHx7reeU/CyGJceI
 S7s7pTrOM1VcbMsfEvdAbV5k0Cco+eHv1W0TL8s7LGNemF1novCj6S0MEwjnRyWfnxnl
 t1CYVA9g8hZ28JganMgZDYT+hiaRvgk2ECNEdO2LkwO39QVEvOm+/7RR1eHTScSbFKYT
 rsoqH0zSbm0BvZCJmm7+xLJfsTqJ0vqzlvhlrqCX2VQJ7rAk2/9J3r+lT46jdh3rZsfm
 EAaQ==
X-Gm-Message-State: AOJu0YxFYn5EQuCNRQjatiDSYL5/fdCUImemZM3Xf09Wl+vvAKcSY/MI
 tOMPPhhMvguBBtVCOu6Pruc4F4aity0ANrqGYO8=
X-Google-Smtp-Source: AGHT+IEhq9rWgNwhdb9nTe28rlgK/fKug1dgEErR0/yRrIX+STa6UPJOPlUsXffkrbXbi7yMDWEFpg==
X-Received: by 2002:a05:6e02:20ee:b0:349:2d48:66ac with SMTP id
 q14-20020a056e0220ee00b003492d4866acmr15667429ilv.12.1696720390757; 
 Sat, 07 Oct 2023 16:13:10 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 08/27] sifive: Change #ifdef for nop
Date: Sat,  7 Oct 2023 17:12:27 -0600
Message-ID: <20231007231255.277623-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

This code is normally compiled for sifive, but sandbox can also compile
it. We should not use UNIT_TEST as a synonym for SANDBOX, since it is
possible to disable UNIT_TEST for sandbox.

Correct the condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/k210/pll.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/k210/pll.h b/include/k210/pll.h
index fd16a89cb203..6dd60b2eb4fc 100644
--- a/include/k210/pll.h
+++ b/include/k210/pll.h
@@ -13,7 +13,7 @@ struct k210_pll_config {
 	u8 od;
 };
 
-#ifdef CONFIG_UNIT_TEST
+#ifdef CONFIG_SANDBOX
 TEST_STATIC int k210_pll_calc_config(u32 rate, u32 rate_in,
 				     struct k210_pll_config *best);
 #ifndef nop
-- 
2.42.0.609.gbb76f46606-goog

