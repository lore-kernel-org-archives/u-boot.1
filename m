Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83932CDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B2986F1E;
	Tue, 17 Oct 2023 00:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LCaYvWTJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19A6186E2F; Tue, 17 Oct 2023 00:30:31 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF33286E64
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-77432add7caso290008385a.2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495396; x=1698100196; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YIlJFqinmGQ4PPUxXFvxOelNqNNg13k0jmOLDQ1e6E0=;
 b=LCaYvWTJYnSnGEDeTky+oB1DtWtq2TZ+Btmo1LKyf8NyFpK7VmOvxdekh/GZqiDyJa
 udt/2eyRAg6jBYqj+5kCKlEhw/jXSmzil9SgIi2eRG1N+xI8cMg64DRdlkHLQlA6fR6E
 HshVFNl9nK7AhA036y08iyTV8aPGdepMz+NpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495396; x=1698100196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YIlJFqinmGQ4PPUxXFvxOelNqNNg13k0jmOLDQ1e6E0=;
 b=d0vd+HSAkvczMwsYhLoZFwmxAuphBTJjF9CxyEMIgzgc9JfpgxWnat3IdFi7qEWS9a
 LjXXUtI7UrEt7ZPvs1bIjSM+rKD6zlJsdkJcNIFti9ZJHwUGXCG+F212Rx2eg7KaxMBH
 Lq5cDc9s/yvCqFObMA2xYaKjSCNee1xEsNawXWNQ8xrZv8UdFvBOOkFiPEiD+/m3E/7l
 KvlHThe6fgYvh/GFRS0vdOMAzcdstBdDwyrhtaoW21LXEjE6fw/7kpbTffIEN+SHbu3O
 aXu3iHDaGE9PrJml2T1SW2YfTCS0zRFZNhbNqKovOj0FqGCUnFQjKMDeguDCRl8MCbtf
 JQpw==
X-Gm-Message-State: AOJu0Yw1Ju+md+iMCvWw2pWHqSFa4HjQdW1zG29Ppr8bZhr+U3XVv6Ql
 Z171Dcjq21vgJM8o4UhUaZEsGRAK9T/WZMFNhoK9tw==
X-Google-Smtp-Source: AGHT+IFa+6/UQuiCiAp+Ed6IF9dqdedS4lQIYW4omKWlbI+PKiSZLiP4+5lfzm+w1pqlwU8ZQW8zxQ==
X-Received: by 2002:a05:620a:2406:b0:774:16fc:65eb with SMTP id
 d6-20020a05620a240600b0077416fc65ebmr612726qkn.4.1697495396420; 
 Mon, 16 Oct 2023 15:29:56 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:29:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3 06/32] sifive: Drop an unnecessary #ifdef
Date: Mon, 16 Oct 2023 16:27:57 -0600
Message-ID: <20231016222835.596572-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

Drop the condition since it isn't needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v3:
- Just drop the condition instead

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
2.42.0.655.g421f12c284-goog

