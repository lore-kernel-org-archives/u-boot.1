Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B599C77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 17:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E92982CDF;
	Wed, 25 Jun 2025 19:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qBu0hDf/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C8D782D21; Wed, 25 Jun 2025 19:15:37 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E97282C4C
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 19:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ae0c571f137so35153166b.0
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750871733; x=1751476533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kgRDL4i3rXlN4JfdqvLyQ/WWC8cMyzVMzmQjln0oLwI=;
 b=qBu0hDf/614HOmV0pWfwQ6wCXP3HEiLZCy1gxoiHiEBp+46zAxLDiy3iW1sIe+d+ZQ
 SP2bCX1z3XSv0zI/kYEy4Uv3hxw9ETfkytQh3DBO2BNDbpN4l3swhOl8MxGKatQF+9lI
 ydq9IAJpbk6atUhI9EdoAoZdoHcaFu6G6QEHNo/84/lLO5l2Chq6xy6fgWHE3WXsqD2z
 8u+UnGuZ56LqfP3DZuCuyidxNng2HOkl8Hb3yG08s3s87Q6Y7j9f8JOYCMPMJEqTaEW+
 JPwUX0gBEswVUctA2r7BugJd8UBofGuYJ19sNhKdq2Ni1xxL/hz9jV/wJYc5QI2mvKk0
 6iFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750871733; x=1751476533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kgRDL4i3rXlN4JfdqvLyQ/WWC8cMyzVMzmQjln0oLwI=;
 b=caUjEqHkyHwUUJ8ylATOYX007jnlExBFbPp0XbMl/240mwJ297cJOM7qotFqdO4STz
 TNHZ5eGBSOlDVvq0Bjbz3LrANX3+Z/qLkzju74ud7k2xBG+uuAywEOyE8r8CUq+y0Jg6
 UaZ4pSEb8OA3JJBfkhWvWEE0P7oIMr7WrhtdwCfT8OV2yuM+Gdq4Dfvc70e8lFDf/uv/
 RjwdfI3eIYNqVZZ8c9VuUxmjFzSM28Z/PfunzeYIKkEkIuHK466hBH5ld3f3yZFzSnOX
 XEUhyDpVXmYiVYh1dRDNPv+PzWF0HccwoT0iKedGQmrmVFfVJpfgOyqYxVCMOOjDkoDp
 YK4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYrhHW6hC1nbKSvN6D9+2g/a133h3hbbYizmIMoehPfQlfNi1PfSxwR2qhs615WFXdxSM6IDM=@lists.denx.de
X-Gm-Message-State: AOJu0YxVfLGp3WoFUuBMIZMNQirdDfo6sPmuRoKA+FXOeGcn0mN1NOs6
 TSFKjFN6xKb4cqe1XtBYmmUcx5A3RB0MlED0y6EiwyLIUbMDOS92G9fNeuBmtZtDzgk=
X-Gm-Gg: ASbGncuXxTHCECHQOtiFeiIrraA6AfyPswg7QthjoXZXADkgdbwJrvsqNZD1atsnAKD
 Tcels6HQ5okR8pP1EbeKkduoftYo32o+Nd5IixzTaTTP4zd98xsaMTmSRn9I5t8M6Ta+1kf2wTp
 7gmFY7QaIh8iG9AL1L2zYXrK6vx/tc2r9QX8vzg/yLnzS4ZUcQfYWQ+eQz1aabryAlIutvN2jaP
 Y/E2cgJ8Mu9jNo5XrnEGumvP4u0xqQjhXEoDtzkJxPPXp/2L5kdPslbZrsMqHWRwcSBfyGd/0Yc
 WsOQzwESuoPKWO2fYuWFrGt6WEd9QIEYieD6IagY1UVbUKRNono43CSHLyK9Kp2Kz2hBgCgDSUd
 6J2pFWELWlJRq1dZGvkCR
X-Google-Smtp-Source: AGHT+IGkCPA1q+gXMiBwRx6x/aluLA3LChWUDjLMfhOT2VrtXKjHbCRiuHMKv1z0IBwLmCIkk/QNXA==
X-Received: by 2002:a17:907:3d06:b0:ad8:9c97:c2f7 with SMTP id
 a640c23a62f3a-ae0d0b1cb76mr88035666b.2.1750871732759; 
 Wed, 25 Jun 2025 10:15:32 -0700 (PDT)
Received: from hera.. (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae0cab0ed04sm75853666b.135.2025.06.25.10.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 10:15:31 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: initialize 'total' variable
Date: Wed, 25 Jun 2025 20:15:28 +0300
Message-ID: <20250625171528.1062540-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

This variable might end up being uninitialized if we exit early.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_bootmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index b9437a81c642..662993fb8095 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1134,7 +1134,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 {
 	u32 i;
 	efi_status_t ret;
-	efi_uintn_t count, num, total;
+	efi_uintn_t count, num, total = 0;
 	efi_handle_t *handles = NULL;
 	struct eficonfig_media_boot_option *opt = NULL;

--
2.49.0

