Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7511AC369DF
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 333CB88CFC;
	Wed, 25 Sep 2024 14:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jUitddV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A091A88CEF; Wed, 25 Sep 2024 14:58:12 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 113FC88D16
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5356aa9a0afso10635824e87.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269086; x=1727873886; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIn1C54qDJR55pgGUSKWnRxN4Q/DDbjdhw/QXkHKHKQ=;
 b=jUitddV4YWCjmSOt446aESqwT7YNuiz179tF+IzGwCj788qSf4FPxzDGFeNvkOipSO
 4Zkyv5yYcHBydD7qaaYcTUZw/nk+Qmcffb+vlCoIiGsD02MvD84ANHUiIxN/pn0SasZY
 ccgBW7iXBxrSPLJuHgDgedZKl+PzS0uaRtd6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269086; x=1727873886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jIn1C54qDJR55pgGUSKWnRxN4Q/DDbjdhw/QXkHKHKQ=;
 b=XbHYJvhRHJQ4oyqT+DC5kUpI7bWNd7MOypqijeiGxCblOLOFi+0BNdhH5YX4VtCiK0
 Y/y8fFsgHp3gPH7cw3NKGaDkEF5gFemgo6HWaJpDisyPybP44C619YTs3WpTh43puJT5
 j8EobkG9lNfyDwOB0pTwtXkv5MiAITLoInV6eYG+9EJtWubjUCBEUkramjoWXZ5DnTbz
 Z6yyaD8rJc05xTsBx5wsihcH+zqSQoG16xTzltNd9rXpVrMkorx1p4XkLlv7RLBY/TD3
 lSoOF8QfULlJP/fnKwrscLb1+d75Wf+L8SbaHA4qmz3rWZTxKKTh0eWbp2fVXTCh8Qw0
 CxEQ==
X-Gm-Message-State: AOJu0Yz1W1w+BsUsw3/6IGu8sIRpG/PiC/QTIkaBZJgaS/r5vrZH5C4R
 XbgIsRNUKVHm0j3fASZu0IQODtoH295+zwQ8Aj+cnkHmblQp1aLAU6G7Ikq3kjGPGHZ01WegfXR
 tAQ==
X-Google-Smtp-Source: AGHT+IE7qHTSzqvTBDB+2apE9VtnFL9xyRWAWzed0106I1YyPcRsqc6cmkE9t0CNmWBiF4KESHqEaw==
X-Received: by 2002:a05:6512:1285:b0:536:741a:6bc5 with SMTP id
 2adb3069b0e04-5387048a771mr2248644e87.12.1727269085933; 
 Wed, 25 Sep 2024 05:58:05 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:58:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 10/19] spl: Plumb in the relocating loader
Date: Wed, 25 Sep 2024 14:55:36 +0200
Message-ID: <20240925125622.197915-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

This is fairly easy to use. The SPL loader sets up some fields in the
spl_image_info struct and calls spl_reloc_prepare(). When SPL is ready
to do the jump it must call spl_reloc_jump() instead of jump_to_image().

Add this logic.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 52f7900b431..d01e9861f88 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -829,6 +829,18 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	}
 
 	spl_board_prepare_for_boot();
+
+	if (CONFIG_IS_ENABLED(RELOC_LOADER)) {
+		int ret;
+
+		ret = spl_reloc_jump(&spl_image, jump_to_image);
+		if (ret) {
+			if (spl_phase() == PHASE_VPL)
+				printf("jump failed %d\n", ret);
+			hang();
+		}
+	}
+
 	jump_to_image(&spl_image);
 }
 
-- 
2.43.0

