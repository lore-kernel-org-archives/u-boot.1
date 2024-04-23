Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE423C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 05:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54E0988594;
	Tue, 23 Apr 2024 07:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uIw8fTpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 551BA88599; Tue, 23 Apr 2024 07:45:32 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 138778858B
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 07:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2dae975d0dcso62751291fa.1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 22:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713851129; x=1714455929; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rIeB/7QFIWfUQxg22uoQKSDBKf+OQquWJF3Ka+5LAOM=;
 b=uIw8fTplbq/KCWP6YP5abUHc4zYQLNqxJMeB0ro5nvb7ZTVAGZg4MyrOp/qekHdrcW
 5tUABK/bDfHO6HSl7Lnd+fgsRhE7Lsh59QBSZoXKVwuDUqTnE6AMO+eCTK6lcHvRod8g
 26Fhe6iL6mJkJWbeuDxWhw1atHpBp+tZ/x+Z6R6c2TXnNhVbY33vnaEb6I86Nd6H2Iz2
 EToXX+t00dVmdxPzD3GsEEzL5beWueAqEbiHp0wyxCJo5oK7DsFSXIewpsdJ3gAAGKkn
 sB3Mffbh/SMGjDpQKP84YVnwDUZsZ/9QSsh+LE7NtmHDLt7X/VeqxVWO7Eopu9AJW8XY
 5qMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713851129; x=1714455929;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rIeB/7QFIWfUQxg22uoQKSDBKf+OQquWJF3Ka+5LAOM=;
 b=HU+y8+1DTH0NOd/SFqdlkPPeCE9+Ap4ICD8auYdo9nx5Z4m6CpL6AvcnSW/ynDvjis
 LxrTuaOdYCBSLbm5lq3Y1rhkfyIJArXLwjgBuEqDc3dw5NifyxsOAt/+dIDGpu3ZcnVN
 TDGg6EiEk3MHSulROnr7VKuf7DnVIEO/+XJVVzsmHVTlKsHM+8gTHgPJa2HyFdiLBmPw
 a5gCmw6d0E7pZSfXBm65O49IC2grmhIUAmv1q/LEmDdFl0INmJ/8xTkyvMO8M+ALZgCN
 H/b/CdlKsfVqXmgoFQ+1uUqfDQvwxnjIIXjrwuG+XpgsiDi2VVXOO7OINt46oZf3CoOv
 v5Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+CRSIWuA9Txs0jFK4QyTue5VuWDnTkJOn7vQCyKc1denB5YUXe7jHtYYsdn3z9hqvwNjKqT88Kj26x3Qf7fEGY4i5Ow==
X-Gm-Message-State: AOJu0Yxv1/htXPqaP93NNGzModhWb9II8wilAniwcEq7qitZb7pOdqoO
 3u2gmZYovb8rGkLOxtsaYebNiWFX804Eww4xMGyuDwzm/LnihT9Wfx3Lq7yk5rVh9Das4938sqG
 kYBc=
X-Google-Smtp-Source: AGHT+IFbbkvcVk1w5qcMyedAJ4El2t+s73UXCulads59QFIRh2PozuLCgsl6abCMT//2XvJGC6OYCw==
X-Received: by 2002:a05:6402:3494:b0:572:145a:77d1 with SMTP id
 v20-20020a056402349400b00572145a77d1mr2029494edc.14.1713850697000; 
 Mon, 22 Apr 2024 22:38:17 -0700 (PDT)
Received: from localhost.localdomain (ppp089210108048.access.hol.gr.
 [89.210.108.48]) by smtp.gmail.com with ESMTPSA id
 i19-20020a50fc13000000b0056fed8e7817sm6138188edr.20.2024.04.22.22.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 22:38:11 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: address coverity report 492766 for dead code
Date: Tue, 23 Apr 2024 08:38:06 +0300
Message-ID: <20240423053806.4962-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

The check of the return code is already done a few lines above.
Although it doesn't cause any functional issues, remove the superfluous
checks

Addresses-Coverity-ID: 492766 Control flow issues  (DEADCODE)
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_var_mem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
index 940ab6638823..139e16aad7c6 100644
--- a/lib/efi_loader/efi_var_mem.c
+++ b/lib/efi_loader/efi_var_mem.c
@@ -232,8 +232,6 @@ efi_status_t efi_var_mem_init(void)
 	efi_var_buf->length = (uintptr_t)efi_var_buf->var -
 			      (uintptr_t)efi_var_buf;
 
-	if (ret != EFI_SUCCESS)
-		return ret;
 	ret = efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE, TPL_CALLBACK,
 			       efi_var_mem_notify_virtual_address_map, NULL,
 			       NULL, &event);
-- 
2.43.0

