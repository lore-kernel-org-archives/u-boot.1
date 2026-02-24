Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F77F357AC
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 14:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0466283F39;
	Tue, 24 Feb 2026 15:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y2P8qfkc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF75F83F32; Tue, 24 Feb 2026 15:26:40 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEB1E83DEB
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4c68f0e47so3349188a34.1
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 06:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771943196; x=1772547996; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKo6CRa4sfSGx30QoDLi3BF+j3s4ERpNEX0xcXFfN0o=;
 b=Y2P8qfkce3dqPyrI7wrSXMyOmxkKquaJWnJvO32AYvbGXm50PnqmJyrXrBNfOQJBaU
 VF/BpFDJALYMglhPpD/9vsqaN8xDRlj6ow3L5W5oKPeznaH+SfPF5dDlIrmzuUBqq53d
 lZoLpiQqRI9muMr894KAo6Uuz6Pl8HR992RJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943196; x=1772547996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eKo6CRa4sfSGx30QoDLi3BF+j3s4ERpNEX0xcXFfN0o=;
 b=NYaZF1yo5k1vllLzYvnLVtJ+FQrd7rWsREAnLMNYqnVroC9A0qsJC5gScYUyXK34Pi
 dP/p5ru11iLF4jq04pSTl1SXrl7QCUQzeiAr5mYIQtWRabpPrQXK6h5UtSljn6RxaXJj
 BuD7ML7XCMM2+XSVcaHGCCksYw2uFJ0kVr0MqE0vrVGe4785TPZT9rts8MW73rRufPaY
 3VXX+C9Tj8yGz+mIsBgtNX6t7zQiqh7Lw2fCOXpHl6J8OKsNZsF5dNLdTXJ8nw30TYrp
 6Bt/Yz61bZZnw6fcts0IygX19Uyrd9bFHRs1g/p2UH8yQ7UI4JelTlSEcwzqIX0PCB5W
 7adA==
X-Gm-Message-State: AOJu0YzrgZAiIcKG74OBqroPEI6MTMXZ1/GQGuwDCo7ch7YgsU1oFNkf
 XFNBD9C7prZ2C5z3LzZJCqeRDY5Q04sEycNJAPxPmOupPQyoQjHytTg0NMqtFo8qkEe7BAcYKuh
 WO4M=
X-Gm-Gg: ATEYQzzDqdN2CHIilnLDGtV14SjIxGYZiq65igY/eUzOhGZAFJO0kxgffNRQUaqqLUT
 pC8bthViM/ej17pnxY9x8lp+BE9ruNIfnbxdnessZCqJ+9OgijCTMef6uxTm6xoW1NvV8Zrgom1
 xraFFrsmN8JfjOfswZJlP7HxFO9I6xGKg/pdO1Yt08GUIbaIcytFL95KnsxC70Gdwdkr2mNd9Wr
 1oZzeQ7cxQamArXLlzCaKZRDrst+i7zSgUr3dsFmMhSZg+A+MgdGO1Nk67tB9Pj5dHX72ShS3y0
 Gu823wPFcrVTwvhMg4QUx4yUULBkLfWJujwrDtuZ1zrxQi9thyaSz9Y+qOk4CgVr6n4Dg0rGI4/
 JLWCtgEyPNkszK9uT/62g+lHUb6+PauXlpNfYGRdEZ1x53m7qAcUChRHvmTBcNjezztDMwEq1Qk
 ERWRS+mKbm7cHCnwyPGPPk40dWRDCd3g==
X-Received: by 2002:a05:6870:7193:b0:40e:e60d:16dd with SMTP id
 586e51a60fabf-4157b18bdddmr6056850fac.48.1771943196441; 
 Tue, 24 Feb 2026 06:26:36 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cd5e168sm10199478fac.4.2026.02.24.06.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:26:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH v2 9/9] x86: Add cleanup_before_linux()
Date: Tue, 24 Feb 2026 07:25:51 -0700
Message-ID: <20260224142553.1608883-10-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224142553.1608883-1-simon.glass@canonical.com>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
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

This function is not present on x86, but there is an x86-specific
version which is never called. This is a bug, meaning that APs are not
parked before booting.

The original weak function was added in 2012 by:
commit f30fc4de4160 ("x86: Add a default implementation for cleanup_before_linux()")

At later change made use of the weak function but was actually dead
code. The Fixes tag reflects that.

Add cleanup_before_linux(), making it call x86_cleanup_before_linux()

Fixes: 99a573fb326f ("x86: mp: Park CPUs before running the OS")
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

(no changes since v1)

 arch/x86/cpu/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
index c373b14df30..f756a9ebf09 100644
--- a/arch/x86/cpu/cpu.c
+++ b/arch/x86/cpu/cpu.c
@@ -80,6 +80,11 @@ int __weak x86_cleanup_before_linux(void)
 	return 0;
 }
 
+int cleanup_before_linux(void)
+{
+	return x86_cleanup_before_linux();
+}
+
 int x86_init_cache(void)
 {
 	enable_caches();
-- 
2.43.0

