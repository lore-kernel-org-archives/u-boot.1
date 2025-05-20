Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BCFC3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58C7082D05;
	Tue, 20 May 2025 07:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bHLMcxiC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E94F82BF3; Tue, 20 May 2025 07:22:55 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37FBA82BF2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso55047825e9.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718573; x=1748323373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5jcnIi8Xv2opCm71TAt0RB54Sh5hkfyPHcWVe0qpMw=;
 b=bHLMcxiCv5ba7C2s7u8F8lDWF6lHOpFZKz+BQsExMGBeIlyfjGYN6LNH308au9awj6
 25L5DaMFmyZt8pl/gyg1Nse0k8fEhoQ99HfJ08u26Po/OhfehgxLp+C7Yya1CO7K4350
 J3QFrKtNCcU0whjrjvKJpGDrxk6vS2jRjaZT0OkDq4AYP37Bopru0dw6Yxnv8pcmnxTU
 3cHrl9ULBMqcw7+mvrHBs7Fx37UPxlCaZX/u9fDqKg6xB0eFI8+0Tfo9c4ceQ05EFecO
 hv+kEbbrhLyVK/xCRA0OHfT1PD3QUilNeZHP86MZFJdGdMasRzuYV4ZLJAzzvNdMD/BW
 xFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718573; x=1748323373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5jcnIi8Xv2opCm71TAt0RB54Sh5hkfyPHcWVe0qpMw=;
 b=mDZCioKbcVvzAGRx6tfe+Y8g7FgsCVsfjp+XvxN+gkpFCZrjKqzHLBOA6JLpCb2nLu
 PgkoIVeAtDYlbH7QPEzYJNFSSOjrpSp9FewLYc4dB9QSoR92VdjGtQAtOV2ko7tugQXt
 2dLXwu8CXi3s4OIBjLXqAo+HhkdSbzLqk1JEamuwOppbKmrWJQ3qQAqTt+JzcqJUz0Tu
 NBMKtsCeQoPErBg8Mwamt/QcFGJ9u5scDm4vwARTdqXHq9cHIg0rNwhietHp0DXz/WsL
 JWy43ll8NVRzBYbiEW3YesdejdsS+Wa6s2yVish2mKzHlnwVrUttRjzQTsXNAAIXLbQr
 IadA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoBjWRYzcOY3Xlfa9wa/yffRUL6FmAIu5gh4QtG43MoJuTcn5mnsFperKcPtIa8Q42QXREZes=@lists.denx.de
X-Gm-Message-State: AOJu0YxaA1Nf8SGPbngXlHiZqRobYHdTd7we2jhggnnn+IM1nXWmlcul
 typDeS2pfRejeHXu/taSLGsdvvTO8yBfbhujYvYqfQGdFbgqNvRflfgldnJpOIEHUDA=
X-Gm-Gg: ASbGncuYiJ/y2wensvtglaS0z6wlmmshx138ESafTci43YzfXCwBatgYHWGeD5Vnz5P
 JWBrhXRo7myS4ckTqs7/9LMMIh6t01CRWMNNRrKYWVkvQ4MXH4mLpl47UuTxd7prIGO276xNAbo
 ImHHPIpuqxSdvV0Xg7HIxAnvkrfbvDgeK0FZiYM3xJtOw+Q0nUskRZ3nMVV4v8V5O6G9txA35EB
 AMcdji7F4pUcxeP+zrlLtfPU1s4nTze0c4OScNOilND93Pt4nT956GRmrnV9NJZJZYe1hRWLPS9
 PuuOPZriFfPgz6rCGepnOaZILlJvv+foadXnli54ZYMYkSwz7S/f8BhlBHSLilrQdS/rWDDGQ8s
 =
X-Google-Smtp-Source: AGHT+IHmEnNFhj5td5iKoKP3/5nv3+DtJcx2nJpQ5X172PniehjOP7rDpywoTHD0snefQocwxxxADA==
X-Received: by 2002:a05:6000:4305:b0:3a3:7987:945e with SMTP id
 ffacd0b85a97d-3a3798794f1mr920442f8f.56.1747718572738; 
 Mon, 19 May 2025 22:22:52 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:52 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 22/24] kbuild: remove unused archmrproper
Date: Tue, 20 May 2025 08:21:33 +0300
Message-ID: <20250520052153.307194-23-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit b421b8a6cb87 ("kbuild: remove unused archmrproper")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 09d36b8cbbed..00876ef54a2a 100644
--- a/Makefile
+++ b/Makefile
@@ -2281,7 +2281,7 @@ mrproper: rm-dirs  := $(wildcard $(MRPROPER_DIRS))
 mrproper: rm-files := $(wildcard $(MRPROPER_FILES))
 mrproper-dirs      := $(addprefix _mrproper_,scripts)
 
-PHONY += $(mrproper-dirs) mrproper archmrproper
+PHONY += $(mrproper-dirs) mrproper
 $(mrproper-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
 
-- 
2.49.0

