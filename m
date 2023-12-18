Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A681C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 18:20:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B7DA8743A;
	Mon, 18 Dec 2023 19:19:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="unyCHCl6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A7C98749F; Mon, 18 Dec 2023 19:19:56 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC9C870D5
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 19:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3b9d8bfe845so2859884b6e.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702923593; x=1703528393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qO5wMGyLmtP17mXl6SJk+QUJ9h/FXcc299FuxgH2TWU=;
 b=unyCHCl6b3zLKI9Kh2GrNH+Wwr/3PvM+33s5rfyu87T3rN/hpkyTGcmhnk4sCjfbzI
 LctA3CiV8T4nPFVG9hs/mRju0sKW4C7Lu4q80CJnKnrHR3nrHdAss87S2jRWEYwMI29U
 qbOIpFGcXWgR061qpbuXicNAtjgCpa2b/XbPoLpHRyOYpZMhkg6YuCc1J9GyGP8mL3T9
 cDT0n069547BQwjqFFG2JVEeJsAB+Ji1WAmVOSQLzRXkHBS4Z3n0Ak3Q2jzXrmm6+42f
 qnNAkmjSjq72ll7O0bszW79W0nTLlXSYEQqivsSi55IxJitsQAjdxxP4ti5RS7qWeHty
 TiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702923593; x=1703528393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qO5wMGyLmtP17mXl6SJk+QUJ9h/FXcc299FuxgH2TWU=;
 b=asnG7eM69WSwrltLaLcx4N/6/zTvi/vKkOrbSU96QgoVW8kYJoUMNfiN4VsOb8xXb9
 v/JqxkxxgKj2VS4w8TLChh1Cnon7MGmnaoyB3QkxrL2c4VSnMrofknbxBB11mk88U6Dj
 81qgYU85NAIHryESf6+bl/JzCA46ysQfBdYPvASg5UqiZJiUqPQUnlpGQMiizKmYepRx
 T+mf75hPa3m9oKQCHcYcmgngd0RR3T096pngnlZEp5RkkmWLdpj0SFvkK64IRBLk3tQA
 j7vUsKUIJI/4kxviePXhLWG1bR3CciT8/vB1Ecv78uukjkN66TtTupn+TjUjU5K37DaY
 Odcg==
X-Gm-Message-State: AOJu0YxSdJeee2wApSOkxFKKPn+BtyZGWEeDb8UfXiQW97Ek08KnJTo5
 oETACf0Nm1HteqAb1JVh16WaDgSIw2KKir54dQE=
X-Google-Smtp-Source: AGHT+IEZX+dn1+D7n2k8zkXvEYchVa4W1ravAe7v+I1ysSs3jN3u3IRgxZz2VbnWSPkW+sHI8ZP65w==
X-Received: by 2002:a05:6808:1285:b0:3b8:b063:6b9d with SMTP id
 a5-20020a056808128500b003b8b0636b9dmr20685803oiw.76.1702923592802; 
 Mon, 18 Dec 2023 10:19:52 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dy7-20020ad44e87000000b0067f213933bdsm3046136qvb.2.2023.12.18.10.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:19:52 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 04/14] bloblist: Set version to 1
Date: Mon, 18 Dec 2023 10:18:49 -0800
Message-Id: <20231218181901.337515-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218181901.337515-1-raymond.mao@linaro.org>
References: <20231218181901.337515-1-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

The new bloblist for v0.9 has version 1 so update this value.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/bloblist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/bloblist.h b/include/bloblist.h
index 72c785411d..7eff709ec8 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -74,7 +74,7 @@
 #include <mapmem.h>
 
 enum {
-	BLOBLIST_VERSION	= 0,
+	BLOBLIST_VERSION	= 1,
 	BLOBLIST_MAGIC		= 0x4a0fb10b,
 
 	BLOBLIST_ALIGN_LOG2	= 3,
-- 
2.25.1

