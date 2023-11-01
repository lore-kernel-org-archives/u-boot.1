Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D88C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23B6487D20;
	Wed,  1 Nov 2023 17:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fmXjmOhp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B267587D24; Wed,  1 Nov 2023 17:28:45 +0100 (CET)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B914687D1D
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4a40d304601so2699321e0c.2
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856115; x=1699460915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I1/ItcXJ6mZw3wXk9V+RJi21NczmWryU6xagEM+zZUo=;
 b=fmXjmOhpbrGa6qnAGvh9h5xtu5h5WupcFQ6J1NXb8Rp/I0OvLYGXd6/Rkgg985ZQ6q
 6LB1CPaJ4ymoD9L9uoefiYLnpm0GkotJTgPv4oRWFArlptvqwVQUQI/ih4dK3OiQhpBg
 nTqAnLC2QEo+qFZhWoSKIKYTb2jTxGLUiV5hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856115; x=1699460915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1/ItcXJ6mZw3wXk9V+RJi21NczmWryU6xagEM+zZUo=;
 b=tJyMeeIgkWf6eoSa9juLTRVhMhFao/YABK7ooDpIwJjFda5s98pikps5fBTty+qw1H
 npu8JwQMJJ+RzTUT1xxIhwCFNsoes1zck0IQnZ31Gj6Oz+GfhLjPpSHN7PjtoX4riDQP
 857+oUc0B/aWqytLoQpu5FKP4/VTgN6MgrZmKMgYCwEvnXUU9N59WweD0Bxr63OH9Fqc
 NgJNPgg7UTYr2Vhcu6+8FyujdkBiDza8ZHVe5Cn3df0bnPrgB6JPdOFwACWXVKpum94K
 2uYL/kFzoBlHpFSxnUsgautaR9OgZwLtuxKmPQfJ1DlrOZoXmT+i7/KQoealrxh9HkP1
 gHFA==
X-Gm-Message-State: AOJu0YyD2gAMB2FVhBF14bNK31Zfyrr6MlaTInff+WaW5TrZnF99XlAZ
 IE3iSYqfYqtB40hJH3IFu/JV0GW8ZFrM0eDDPCvWeA==
X-Google-Smtp-Source: AGHT+IGPL7vhtNwYLjs8rxSzpU+wueyLWQ+Oo+yhosu2Mz0nuQsuToCnHzng1DKpsIgmkeFKvytYcg==
X-Received: by 2002:a05:6102:2041:b0:457:bc46:8ba3 with SMTP id
 q1-20020a056102204100b00457bc468ba3mr15740665vsr.9.1698856114739; 
 Wed, 01 Nov 2023 09:28:34 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.34
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 10/20] powerpc: Rework <asm/fsl_lbc.h> includes
Date: Wed,  1 Nov 2023 12:28:14 -0400
Message-Id: <20231101162824.3755579-10-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

This file should not include <config.h> nor should it include <common.h>
so remove both.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/powerpc/include/asm/fsl_lbc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_lbc.h b/arch/powerpc/include/asm/fsl_lbc.h
index a03f091c3059..95f0f559b4cd 100644
--- a/arch/powerpc/include/asm/fsl_lbc.h
+++ b/arch/powerpc/include/asm/fsl_lbc.h
@@ -6,9 +6,6 @@
 #ifndef __ASM_PPC_FSL_LBC_H
 #define __ASM_PPC_FSL_LBC_H
 
-#include <config.h>
-#include <common.h>
-
 #ifdef CONFIG_MPC85xx
 void lbc_sdram_init(void);
 #endif
-- 
2.34.1

