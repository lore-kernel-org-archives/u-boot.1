Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A595C87FCF
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B910A8397A;
	Fri, 25 Jul 2025 14:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xGvUGN1f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 578D38397F; Fri, 25 Jul 2025 14:57:31 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE9083979
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso1639989f8f.1
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753448249; x=1754053049; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VvrQU34pPbxmEIrK+R0FqpIsm+0OlyEZqPb2VWQ0uAw=;
 b=xGvUGN1fFN9+vUGtguvaR5fxNk3LWVg95E19GuhbzzqdI598U4OSgIqMtTbyBHBcDu
 5xFJOtlqMu6K3mB2XehV1+c+75FURf+sCIXHCDHPHvvrSta99w1eotoos9JaKarqN8ln
 lAqIZXvrtSxm4vtwPaN+n7479hiB1UnfC66bgaIojv6swzjXDaaeAiVl9K0dOXahWszp
 GUmwtS5HBSJ/DYugSFpsme9fUNor+49ZuMGWC4a6hkzj1rNJqLhjhnxvSJkWPb9q/PTR
 SQ8I+H2L81675102mK0PXah0Iz/lN34ECdSpdtPxYDx5BnLZFrP6BYryJYOSX614ZXpH
 65Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448249; x=1754053049;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VvrQU34pPbxmEIrK+R0FqpIsm+0OlyEZqPb2VWQ0uAw=;
 b=Nmtt2mANDrs54qZMIHs+jKnEFBTipSu3NiPPOhaZYLsbUiKuJMu50x5K9YXtSd6MiS
 cirpKk6bHxV14qtULUfCIdqfpGlRms1u/AiRcnVjAO/EDjptU3nIuhhAjjlcgWsCMahR
 D4L8z4ew+ZnkWW7/6vH2yOxiJ74ohM8WjepfXrAqUXebXItjmZ9jCsOf9F6Hp4RJGkoz
 NnWFL47kiPr4gl2Cl25fGWBlamXdqbvq0u1KS180t4GZN7I5jpkewCZb1rp1cbXHPrYO
 gyeUaK8NI/YZVJ7xYydz7SacTzM1ERAkMjGeNLgOPEMA9CKrjE9hW86pzw4u+Iof1fCr
 VH2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7nr+t+1jJSj5AtgNK+TJoOqPMuMaDEKUDHieXcRsbdS6X0l6DvSqo1yrXg77IhDNeBX2htNc=@lists.denx.de
X-Gm-Message-State: AOJu0YxZAt6Nk41v1iAFSG+fgec+i9jQJtbVx+Y3pUtLyueo8sJ1+ce/
 Iwya2GcHvTYUm6d4L9ORsHJUnJgoig5c1Y1sYgyUGii4VwAbFlV5JTyeVxkj39t9Drg=
X-Gm-Gg: ASbGnct1yMo5Ghk/uKXZM7L6+4XL3B9nSY9mAbMPL4XO4T8lxwVzSCH3N25vYX3Lpry
 wVMp8SClX/nv6xjnITuZgLF+I/estFld+qfCkT6LAsXCKkLUn7t9R9i7y68AjB9tEwQcADO2MHg
 DpH8hONbcWjTUZLPSWALz/sEPMdhNmNhG+RcQxeqJCTbYZiAAryCg3XxgFiejgcms+0k0Ghh/Nc
 axkgbnqPS+yR2yKW8RurR+2aFmWTV8R1IjMr+N817BKcmx/hMs+Q/QNm9hKEJPSASLN7QnARgpC
 IOxGDFXfbPW8oyca/WGewp3T+9FxBSN0VapNHfX0oZLIbCoh1qdST9xzKzf69+/jMgL9+mV55CL
 X14xZJZN368GgUcWM11+92oYVqDyfmTMUm9SNKmNIZ1URbLP+uoV9Ly5fRIx6Jf+rLA==
X-Google-Smtp-Source: AGHT+IEOz9ugummbhTryYU75Vt5MNQQzsd7UVT2f2HqoijnOIzYz2Mt2l7ocll/qgRk8y7z5oScOYw==
X-Received: by 2002:a05:6000:2c0a:b0:3a6:ec1d:1cba with SMTP id
 ffacd0b85a97d-3b77672e6aemr1888029f8f.20.1753448248804; 
 Fri, 25 Jul 2025 05:57:28 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4fcfsm53115355e9.29.2025.07.25.05.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:57:28 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 25 Jul 2025 14:57:05 +0200
Subject: [PATCH v2 1/7] cmd/exception: missing include string.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250725-b4-arm64-backtrace-symbols-v2-1-230a9665085b@linaro.org>
References: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
In-Reply-To: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=SynZRFcuoVNhmqWaTEfw4m8Xvb82eAyArhOOllI9wR4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhozmetOoinUTMs8/fybe2J1g06pgNXlt6XeB22mPLiyvN
 fKSb/zTUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACay0JnhF1PFZOZ3RQmXzk0t
 ezH32EfVAyqrT63x4MzdOUNrI+P996cZGaaUlX957DPJgvXJUY91OyewHnztds2gZsaPBwLLghp
 jlqgBAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

When building qemu_arm64_defconfig with CMD_EXCEPTION a build error occurs:

    In file included from cmd/arm/exception64.c:87:
    include/exception.h: In function ‘exception_complete’:
    include/exception.h:41:23: error: implicit declaration of
    function ‘strlen’ [-Wimplicit-function-declaration]
       41 |                 len = strlen(argv[1]);
          |                       ^~~~~~

Add the missing include.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 include/exception.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exception.h b/include/exception.h
index a7f21e73d753..0d4dff49954b 100644
--- a/include/exception.h
+++ b/include/exception.h
@@ -5,8 +5,9 @@
  * Copyright (c) 2018, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
 #include <command.h>
+#include <string.h>
 
 static int do_exception(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {

-- 
2.50.1

