Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44A4C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A81A8842F;
	Sat, 27 Apr 2024 16:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JxJbOVXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8AF58841F; Sat, 27 Apr 2024 16:11:18 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A67BC88407
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78f02298dc6so264210485a.1
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227075; x=1714831875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sq2izgVs7Lw6D8mI1LpZ/ppdr1fvuYew17FptJ8UaKQ=;
 b=JxJbOVXGc/ei7HC8pWqRBBtDy26LWRZlW2Lpkk+E36qQS0YY8kEQqx5Qnf6v/CBVAP
 yVNnpMljgRpSumuc7SuvjerZBSX6ZJDWAyWNagUbcF4WaZF3ikCFTtf2Pas0293bvwlL
 aZy+IYqR2ffEUSkVsSAAiMgqMb+pnKhMuG3aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227075; x=1714831875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sq2izgVs7Lw6D8mI1LpZ/ppdr1fvuYew17FptJ8UaKQ=;
 b=qGWeCCeQEFsysPuLxrupkhezqmeDXH7JszMncwNB92wlzS9arm55IKdFDSBfWejXGs
 ZYcaqDRnpis00KzURHph5CTAwLcOyHJMFNnxslunKs8wkGhdKprreM5oscqrtKzt+FNU
 7BBGm+PPIXm1akgqqmO0ZrSMN6dRLtMGVm/YNlc5ukPj4ZeZtnbjIJYN1s6GfzKdtdbS
 FRFzBKJ9+3Y3XRBCbtLYHJi0V9WFUJyR9oJkxq1iwpp1HgAgTQmkbzvT0pwBdkkEMrmK
 boHamrt8lph0BYOtdsa8edQBfv7yebGRWEjG0L5+ORQIWWNWDYYnnYczzGFa3SWiv5PF
 qH5Q==
X-Gm-Message-State: AOJu0YxrmknXgwdeM6EiihoQ1BAedcFnbGdMdU2qVB/r8rZGdGwzfXiv
 B6THhEa2e/Rmi7I2beNM0a2RL7omc/R3DJR6rvpLBUHg46qsNM5JF4pCPl/rkjeDMMcSPq/7Pti
 gr941pA==
X-Google-Smtp-Source: AGHT+IGD199JyHhUuprGZcDnAjWLbZ8pFspdrc62P/VID+2/1eLUpdTQrHJyIIFGRB42csrEV4WzSA==
X-Received: by 2002:a05:620a:4da:b0:790:9648:8505 with SMTP id
 26-20020a05620a04da00b0079096488505mr9592616qks.26.1714227075311; 
 Sat, 27 Apr 2024 07:11:15 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 03/18] mpc85xx.h: Use <config.h> directly
Date: Sat, 27 Apr 2024 08:10:51 -0600
Message-Id: <20240427141106.3406000-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427141106.3406000-1-trini@konsulko.com>
References: <20240427141106.3406000-1-trini@konsulko.com>
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

To ensure that board config headers which set values here in the CFG_SYS
range are used, this header needs to include <config.h> directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/mpc85xx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/mpc85xx.h b/include/mpc85xx.h
index 636734dd3c63..ff86c7c12e0c 100644
--- a/include/mpc85xx.h
+++ b/include/mpc85xx.h
@@ -6,6 +6,7 @@
 #ifndef	__MPC85xx_H__
 #define __MPC85xx_H__
 
+#include <config.h>
 #if defined(CONFIG_E500)
 #include <e500.h>
 #endif
-- 
2.34.1

