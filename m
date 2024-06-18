Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B24FC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A0C882D4;
	Tue, 18 Jun 2024 17:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AqSXXVzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7492A882EF; Tue, 18 Jun 2024 17:50:01 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14D968332E
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52bd48cf36bso6384722e87.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 08:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718725798; x=1719330598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EUt0vP1DvKduH+Sw1vMHEyp08EqoNWqet+e5YZUlITY=;
 b=AqSXXVzrrEkfd5ehMDVWS+bKIKGOaeWN/tKQSMNREX0R1V8ObuNKFRJVbskTq/c9tV
 zVAQrHOkzoVPeS92dk5pWy/MGfZVaW6O8734w5ApUT+qyP6YrKWzzJiyWggPYqyZD3Dy
 vnU0hrbc/24ooBvJVqo95uah9jrQxfOuZVlgtvnoKIVlvrhibBlYVrXKpBPAWXMOtpCx
 o5Op8NW86jHn1/hhQu3BEo0e/mCBs+dRPmLCpmASRvg/OjIoE6d1sY+KOjdg6lSm8NmS
 zmFSErmZosSb08/sQ1jXCEJblAvVh5oM25APr8RyiswZgtczou4NXKJgwKtFG6Ue1X9y
 kO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718725798; x=1719330598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EUt0vP1DvKduH+Sw1vMHEyp08EqoNWqet+e5YZUlITY=;
 b=L61PBaf7cmFtkvunOFrxR2mErWrFFjVNuqvrdZdtOoOj0dv4RfYbT+p/8DiNKxAfmI
 IQCwv9Pb+XoGC77ny02h6CBiQiLIctuBzfGxYKaS8715AGui4AY0kZA21iU0uGAPkPEo
 Pna6pFpBUIQxuAr/zL6Scs76Aqf+kSsqADW6cOkJlwW9mrumHTDLPPHZbQPnZLma7lCB
 Sb4b9eIeq1qKFXsnNhlKhOfeUKkzaDnDdB+BWf/Cv2RHA58aY2wrcpQK+ITk2ZNKWcLL
 mEhL+guYrTmIk2SBTxY1uwhb66eweZ7787r3KHSqsPeTYXZj9urX9Jnr0NV8KReiqMi9
 D8Rw==
X-Gm-Message-State: AOJu0YwtqPgT4B0owfmABmfqRv3Cy1BKm4VQFCBiQ6lhQXCni0rhuS2S
 l8oLR11bJM/vO6FJqqXHo+c4h8Wnv5WAakFNqL6gSJhlY4WsH8EEQ96S/woi0RGMlep63fXoCyY
 wmZQ=
X-Google-Smtp-Source: AGHT+IG0OckhHMpOciOWOq//XIYXgzHMKhuby2sohmPhGxYibee5CB6RsZzXp+rMIf/9e74EOWUPcQ==
X-Received: by 2002:a05:6512:b90:b0:52c:aa8e:12da with SMTP id
 2adb3069b0e04-52ccaa55645mr20705e87.7.1718725797816; 
 Tue, 18 Jun 2024 08:49:57 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-362822f53f6sm1012254f8f.0.2024.06.18.08.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 08:49:57 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: u-boot@lists.denx.de,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] efi_loader: adjust config options for capsule updates
Date: Tue, 18 Jun 2024 18:49:52 +0300
Message-ID: <20240618154952.12314-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

EFI_IGNORE_OSINDICATIONS is used to ignore OsIndications if setvariable
at runtime is not supported and allow the platform to perform capsule
updates on disk. With the recent changes boards can conditionally enable
setvariable at runtime using EFI_RT_VOLATILE_STORE.

So let's make the options depend on each other and clarify their
functionality. When EFI_RT_VOLATILE_STORE, setvariable at runtime is
supported and EFI_IGNORE_OSINDICATIONS, which also breaks the EFI spec, is
not needed anymore.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 430bb7f0f7dc..c84064de1366 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -220,6 +220,8 @@ config EFI_CAPSULE_ON_DISK
 config EFI_IGNORE_OSINDICATIONS
 	bool "Ignore OsIndications for CapsuleUpdate on-disk"
 	depends on EFI_CAPSULE_ON_DISK
+	depends on !EFI_RT_VOLATILE_STORE
+	default y
 	help
 	  There are boards where U-Boot does not support SetVariable at runtime.
 	  Select this option if you want to use the capsule-on-disk feature
-- 
2.45.2

