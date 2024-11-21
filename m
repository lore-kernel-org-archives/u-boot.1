Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E041AD78768
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86E89896E0;
	Thu, 21 Nov 2024 15:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ompJ2Wwi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8597989762; Thu, 21 Nov 2024 15:25:40 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A560896BB
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 313B240D9A
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732199138;
 bh=9CdxqocVlquViiBXv4++Gl5uFTUIDpC66u6GT/LE+hE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ompJ2WwiEij99o1NPn80M1LipaQ98PAuuen2EF0LEENt4+Xxu+us1yP4Uuw2LWQCu
 Kl7EpHjWEOMtjk/MDEBV2ebrlYrkNHO94ZaDpJXxAWgoDZYc3zmKWRdBqvrVRx9Uzz
 F3liPP5dKzZkQM4fC2E3CgdionT0bBCFjOl8KPloxZNGtCbBx4l4K16zTHay4b2gpO
 T4ZHiCHY3psW/QHcLQ9wsXLC2Sbb+iAHZ9ePgEkhF+NWxZ7NigB0j8MAE2hf8I+L+7
 Rsp/Q8flT29eYRr3dTbQf4LqfrYwUX8nKjK8OT2id2UGdfrPMziPcxrXxmWplx7Xop
 dRFp965s9TMKw==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-382357b294aso478142f8f.3
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 06:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732199137; x=1732803937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9CdxqocVlquViiBXv4++Gl5uFTUIDpC66u6GT/LE+hE=;
 b=V2MRjL62nZz5Lx/AqbMzi6xi59S+GAE8VcLVl9OkHBVIV2KnctE9m6ijE2PJqZiZd3
 yUGi4Sw57+3uXLSmh+lqnZtkwCgerUIAQY2ty5rlHxtYAsXSs7wzN7Lww6RqlXuHOR7W
 kzGPAgZwIEkev+wySYzxnerR9o3d6Ggn3Q+NmiknF+h3x7LGrWyrCKTok+NZiPEgoc0g
 Bv1IoNm1OB2CrNHcbmAAZM070h+GdVkXZpGLVIoKhIVkZZgbssOWlmAaxgrL1HR669Bw
 QbVhrdcq72nRAd2jB3AR0T/N2T3UvxMzeMBSvupjBLASONxRlIB/uVGlnzWrC16h3/5S
 zCSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaobbpb1RhL6ekOGB0oLpom3qep7OQXUv67wNVNHz4bTbXtjdc3l65dLZPp6aEEuJNySahevU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8otpI6r192vDCM+WZiUIiPiOJZ5LMvOsI61UpVHXQhyOq8iFt
 KvbSt+onvK8v+doyrREDvtQjutMvd0ltx9Fe+8lwSs3xb/CK3qcnq65n3GGKeg5Y/Y7AfbNO3Z1
 c1ZjRi9RXFlLtHMCozmm6j/vE6DwbRlz1mDrPLs5W9Ri+y/oCzDjSOhWwQIQDVZWRWIs=
X-Gm-Gg: ASbGncuAcUK+5nUgCpXODs+SMPwqfqkIMzCAu+4K/AdfnVXAu0UCJj45nolFciiohbT
 LvbqT0YiQccqBxCmDu/IfFfGXbYXmANB7SbvF2j2p6xy0h/kuDfKdwr+XqJJ0vpjepACeCxqGPy
 DJnJBbfhsKQHRD1/2EzOCbguC5XrSy5MU6gIN1R5E13ffIRUM7Ynmn+U09wxJvu8l3HTWXEllr4
 UTBQktfXK4mreJabuBqugbVMIafGoNKLeHB1VBQOBXujpmf6qSBEPPs1bwkO8fm7BFy/NFiM0p1
 wqLtlJ5jb4uClOTCRPkr9poEKyuwpISnK+wn0qchlv7Bd+M9dYnp
X-Received: by 2002:a5d:6dae:0:b0:382:450c:2628 with SMTP id
 ffacd0b85a97d-38254b157b7mr5590533f8f.44.1732199137080; 
 Thu, 21 Nov 2024 06:25:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFX+jAA6RmMsqvHLCutO6428gvMe9ko+1wlogUaFkhCuIfbj5gKW6IfO0yM61FiwW3mODnzLQ==
X-Received: by 2002:a5d:6dae:0:b0:382:450c:2628 with SMTP id
 ffacd0b85a97d-38254b157b7mr5590509f8f.44.1732199136732; 
 Thu, 21 Nov 2024 06:25:36 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b4616843sm57238085e9.20.2024.11.21.06.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 06:25:35 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Nam Cao <namcao@linutronix.de>,
 Andreas Schwab <schwab@suse.de>, Jaehoon Chung <jh80.chung@samsung.com>,
 E Shattow <lucent@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] efi_loader: allow EFI_LOADER_BOUNCE_BUFFER on all
 architectures
Date: Thu, 21 Nov 2024 15:25:21 +0100
Message-ID: <20241121142522.59059-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121142522.59059-1-heinrich.schuchardt@canonical.com>
References: <20241121142522.59059-1-heinrich.schuchardt@canonical.com>
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

Commit 775f7657ba58 ("Kconfig: clean up the efi configuration status")
by mistake revoked commit dcd1b63b7072 ("efi_loader: allow
EFI_LOADER_BOUNCE_BUFFER on all architectures").

Fixes: 775f7657ba58 ("Kconfig: clean up the efi configuration status")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 58d49789f12..d93f28b8422 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -481,7 +481,6 @@ endmenu
 menu "Misc options"
 config EFI_LOADER_BOUNCE_BUFFER
 	bool "EFI Applications use bounce buffers for DMA operations"
-	depends on ARM64
 	help
 	  Some hardware does not support DMA to full 64bit addresses. For this
 	  hardware we can create a bounce buffer so that payloads don't have to
-- 
2.45.2

