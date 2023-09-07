Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B00EC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DEF686A9E;
	Thu,  7 Sep 2023 17:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M9Xt/s/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 432B986A34; Thu,  7 Sep 2023 17:58:43 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8802386A4F
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7926de0478eso57446439f.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102317; x=1694707117; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZkdyB470/+vpfIqa1aFoDTvyYH2jxToDMAfjF41G+7M=;
 b=M9Xt/s/PlIOphC8CkCQ742Qion2bYu49mAuFOfkonXIsYW5XyBOiUK7hYlSbh4ygmr
 72btLBN0H0iLQ3oYjZiY8ovgRP0No+DZKsOWMQbF/sOkkhPhC21vd3DEr+0EjTZXs8Ji
 tmkH7q6kWtCYcqawuAW4ft85xejM9GsT5EDlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102317; x=1694707117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZkdyB470/+vpfIqa1aFoDTvyYH2jxToDMAfjF41G+7M=;
 b=PIM5JYs9+826l2HIyczm8uHx2dylBrf5m6kUHBPvIYZ6bGtk4/JhoTrg9Fj7rqa4Jg
 GWtsuNweSZCUPJgH/eZq8HNtIyRZ/e5TpmNokK81OkB2fHBeR6qXyNcQTybAUEdcHXq8
 zXYsaLPrEIt40YnKJp/yW6qeee+k+9zwVNXHdg7W1fxG+AqGok2BXVRJSYCZE2H7+dtC
 0NFrxrTmbXeycbat58DSlbvNHmPd+jiAhTuSon78dPffO2Omdr91uze8/GOOlk5f+PgD
 nAJkx0E1GLbTrNaFXlywLpmwyVB8nocDozIgMFle4KM6z4+ppN3or8iuBtnF06w5yWas
 3TJQ==
X-Gm-Message-State: AOJu0Yz5t58MCXlEsu6p4gyo463DMOObLTb/tHwMlpSA7NnMLztn1OER
 CFy7GZj1Lvrk9MCX1nyVw/pLqTaB87s63qm8bqI=
X-Google-Smtp-Source: AGHT+IGFns237LCYErMh2z36aybQ1Afz84Z6qlNBdG4yW42aCgw1y+abMvy8udWLNL0FqJRhleKqSA==
X-Received: by 2002:a05:6e02:188d:b0:348:d683:36bf with SMTP id
 o13-20020a056e02188d00b00348d68336bfmr2423142ilu.12.1694102317183; 
 Thu, 07 Sep 2023 08:58:37 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a02b881000000b004317dfe68e7sm5498839jam.153.2023.09.07.08.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:58:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 8/9] x86: dm: Mark driver model as dead when disabling CAR
Date: Thu,  7 Sep 2023 09:58:20 -0600
Message-ID: <20230907155825.48056-9-sjg@chromium.org>
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

When turning off CAR, set the flag to make sure that nothing tries to use
driver model in SPL before jumping to U-Bot proper, since its tables are
in CAR.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to mark driver model as dead when disabling CAR

 arch/x86/lib/spl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index 335dacf47fd0..c15f11f8cdf4 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -230,6 +230,9 @@ void board_init_f_r(void)
 	mtrr_commit(false);
 	init_cache();
 	gd->flags &= ~GD_FLG_SERIAL_READY;
+
+	/* make sure driver model is not accessed from now on */
+	gd->flags |= GD_FLG_DM_DEAD;
 	debug("cache status %d\n", dcache_status());
 	board_init_r(gd, 0);
 }
-- 
2.42.0.283.g2d96d420d3-goog

