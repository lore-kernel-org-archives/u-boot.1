Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F16DEC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA22186A4F;
	Thu,  7 Sep 2023 17:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QDmcqfoF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB382869A3; Thu,  7 Sep 2023 17:58:41 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07D3886A6C
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79536bc6697so46385139f.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102316; x=1694707116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+B30j6FDwyLJp+/49RYF6ztnLZnUXruCSRkA4W9djbY=;
 b=QDmcqfoFUNedFObIhsTmMWQmePla5WnkNng2z1//3Jw1ApMpiTvLvZtOWKp1Ed8etx
 dm3XGy/fcrZn7Q4MIUfm1R/wPY3s/35bSzPpIvWFzd/u05ifBnUGf4UqcSUxXb+5Z+fL
 2+8befB53LQlrWUE3znYYGvHBS9J/eA0WoqzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102316; x=1694707116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+B30j6FDwyLJp+/49RYF6ztnLZnUXruCSRkA4W9djbY=;
 b=kVobk4rbscTQSRM+hDLgftUlQlvIqHYr4S3J6r8H0COIn0HepDrwF2liRI3rczgNM6
 L/NyHGlrb5KaVwXfMuZIxKPRse2DfdPDDKKWV1UEykMh+LvUmmQpkBnUgFcmZIR9Mumk
 b4Oeg/BaDHOLuyvKJ1WX1P2q0qtkEpeiOaCtRU+RmreAzEmsGmLnQnjGlY0r40d7fAoc
 caxhETG/XDH0vOTkYLVUaGGLaUsu9fINRrGYrPmN8CVKEL1KDB/ouLaEEukiMr7cfzNk
 NqmjuJNcGjfAruoiSJFIgVnd38vayyqFfhthCgWnV60JS9d2ELCVcrnTH6MMmu/W7LOr
 /gJA==
X-Gm-Message-State: AOJu0YyaS0VDSWwcZB46MVenNtUhXO2ylKBKX7nh3JsY6PqZmI4Oc0NZ
 l8amshzKrqtozzSDu7++bZSCxL1UMW6EkDZnIz8=
X-Google-Smtp-Source: AGHT+IG1MNDe6pT4Ri5QRgykuIU/AktLqunYNAV9NmqWO1nazuHYyVLn3xA8vh1gyCqU9uZ6/PTG6A==
X-Received: by 2002:a5d:9c92:0:b0:77e:3598:e516 with SMTP id
 p18-20020a5d9c92000000b0077e3598e516mr157501iop.2.1694102316470; 
 Thu, 07 Sep 2023 08:58:36 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a02b881000000b004317dfe68e7sm5498839jam.153.2023.09.07.08.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:58:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 7/9] x86: broadwell: Set up MTRRs
Date: Thu,  7 Sep 2023 09:58:19 -0600
Message-ID: <20230907155825.48056-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155825.48056-1-sjg@chromium.org>
References: <20230907155825.48056-1-sjg@chromium.org>
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

The current condition does not handle the samus_tpl case where it sets
up the RAM in SPL but needs to commit the MTRRs in U-Boot proper.

Add another case to handle this and update the comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/init_helpers.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/init_helpers.c b/arch/x86/lib/init_helpers.c
index 60a2707dcf1b..bf0c921577d1 100644
--- a/arch/x86/lib/init_helpers.c
+++ b/arch/x86/lib/init_helpers.c
@@ -15,7 +15,8 @@ DECLARE_GLOBAL_DATA_PTR;
 int init_cache_f_r(void)
 {
 	bool do_mtrr = CONFIG_IS_ENABLED(X86_32BIT_INIT) ||
-		 IS_ENABLED(CONFIG_FSP_VERSION2);
+		 IS_ENABLED(CONFIG_FSP_VERSION2) ||
+		 (IS_ENABLED(CONFIG_TPL) && IS_ENABLED(CONFIG_HAVE_MRC));
 	int ret;
 
 	/*
@@ -23,11 +24,9 @@ int init_cache_f_r(void)
 	 *
 	 * booting from slimbootloader - MTRRs are already set up
 	 * booting with FSPv1 - MTRRs are already set up
-	 * booting with FSPv2 - MTRRs must be set here
+	 * booting with FSPv2 or MRC - MTRRs must be set here
 	 * booting from coreboot - in this case there is no SPL, so we set up
 	 *	the MTRRs here
-	 * Note: if there is an SPL, then it has already set up MTRRs so we
-	 *	don't need to do that here
 	 */
 	do_mtrr &= !IS_ENABLED(CONFIG_FSP_VERSION1) &&
 		!IS_ENABLED(CONFIG_SYS_SLIMBOOTLOADER);
-- 
2.42.0.283.g2d96d420d3-goog

