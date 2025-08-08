Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93435C87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 12:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AAD4846F9;
	Fri,  8 Aug 2025 14:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ekVd0Pef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E408A846F5; Fri,  8 Aug 2025 14:00:29 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2B9E846F0
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 14:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b7825e2775so1856458f8f.2
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 05:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754654426; x=1755259226; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jCqWsb2B72YJdOXIuB+eVVmndxuVde7VjwY/ZBvl/z8=;
 b=ekVd0Pef6ooqoi6eWtVDjAeWU5AgKsXRsoDcAFAcCL1/j5LmuA6xf7Dzm4yzsZ0GOK
 0pg+6aSe+DnGlCwH42KTh+JpO7pjNgOo6+UsKZxyqOHOKQApYXsl/+UfHQg/CHXIryzS
 n7YzwcVaiuRJ1xMfKDUTTeuG3f4TZQ5tBMouYRfSZRUB9kXYN+EnBk08shgWcbgk4oZR
 DnQYx/W2nkqcTcG2rc9CbN9q1DKRToEdcF10DNETNgNu0qOTyx/RpF2WIjuX9sl7yDAU
 GPcr9amg1iN9rI5uVCSkJw2KJiGmykez0wd8r+eMFLoJbeiTSWd/7/GIrKS0rNvVcLQc
 pqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754654426; x=1755259226;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jCqWsb2B72YJdOXIuB+eVVmndxuVde7VjwY/ZBvl/z8=;
 b=BQ+K7sOETLhdu6bjjXqe3CreuCP74SpWsqWj2w6pSwBXSxnNi9CGMyE/ssH7nhlCn0
 +Hl3+QBZiBtSp8qnb318AgiWqn+FbuZxk4Yd/t8L9mfeDkyqEvQ39A9cbb8fXh9J/doU
 6raj1n1WD8dqRNNCtyLiPs6nov0Dys8o1i/K3Ouc/7k7Y0Xn5trItUEUj1O04BIp9c+F
 EjItavdqR+5A3vokOFy6q441egFTZx8+eAUgjdobcFWS4E0jBjPc9XFsS9tnZQyewePP
 MlCSlmlyJ6w6u6A7ucm13m0VJkoLXHPtWy9v7h5ZaNyqCfPQLMaKVkrMoHwJSmgDY6tc
 elaw==
X-Gm-Message-State: AOJu0YwgoiveK7RV/x1T2vxe+xOsh8bHA0jayCthMtAtwu5wJKpJrGeN
 GQx9+uxYRHL0EA1B0x9Yv2b6lPUUihSkjEVfH/ilzYf+1HVKMKIQTZmROgzTUCN5QH8=
X-Gm-Gg: ASbGncsTnFshpOkzMAI+Q6bSB/FitpqP7z8w5z0mKEYDDCMy2QFyth9WEnQhXMbYtMY
 SjM5Mcf+6ye2HXRnhvb0dlg03r7N3PCQoe7rzfhEHBvhTgEBJbySiaSl9IlivPkuCsos+RF3MU7
 BpyqpxoV1RShkw4Jgi5+coRMy+hZ8RZYwazINWxFrOtBLDyYlWc2L6OdKmWNgTbeDbkgyQLB6C0
 R+1m6Kw4CJNOagabO8EAq2BecoiG65ij9snHayApjThJU6ZEm/D8B6zq0/xwtQ4qnq5yKSBLTZS
 OKp3UYn9nvQUNaXwQ4BVfcOf6GHm42ex7UVmLeens1c4xIfrvQipvWrcouEnO6bPA2qzvMgCJUM
 SdKL/sl6NXRogTX2yDYXLB7nIdn5GPFM9NKMWtBBmntJsrbZ9fDA=
X-Google-Smtp-Source: AGHT+IFOnbYC/Kf9lpdVEw5TGkHAEXnTp99x/QnP9IOKJUv3QY15cpCOpTpPgw08f0OMDhIujUke4A==
X-Received: by 2002:a05:6000:4283:b0:3b7:8af8:b91d with SMTP id
 ffacd0b85a97d-3b900b72e05mr2759015f8f.35.1754654426277; 
 Fri, 08 Aug 2025 05:00:26 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:e7fc:9a8d:4024:d186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5c84b8csm69962645e9.4.2025.08.08.05.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 05:00:25 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 08 Aug 2025 13:00:23 +0100
Subject: [PATCH 2/2] remoteproc: k3-r5: Ensure ret is initialised
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-remoteproc_tik3-v1-2-f7dae0b177b2@linaro.org>
References: <20250808-remoteproc_tik3-v1-0-f7dae0b177b2@linaro.org>
In-Reply-To: <20250808-remoteproc_tik3-v1-0-f7dae0b177b2@linaro.org>
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

In k3_r5f_split_reset and k3_r5f_unprepare ret may not have been
assigned to before the code reaches the return ret at the function exit.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/remoteproc/ti_k3_r5f_rproc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index f4bab6868ee..3a25ef6bf87 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -441,7 +441,7 @@ proc_release:
 
 static int k3_r5f_split_reset(struct k3_r5f_core *core)
 {
-	int ret;
+	int ret = 0;
 
 	dev_dbg(core->dev, "%s\n", __func__);
 
@@ -476,7 +476,7 @@ static int k3_r5f_unprepare(struct udevice *dev)
 {
 	struct k3_r5f_core *core = dev_get_priv(dev);
 	struct k3_r5f_cluster *cluster = core->cluster;
-	int ret;
+	int ret = 0;
 
 	dev_dbg(dev, "%s\n", __func__);
 

-- 
2.39.5

