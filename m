Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B18C83F04
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 13:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22AA980E9A;
	Wed,  2 Jul 2025 15:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kZu4rNy+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F05F081FEE; Wed,  2 Jul 2025 15:49:59 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12AB9800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 15:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-60700a745e5so8907493a12.3
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751464197; x=1752068997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=032zl2BE0VM1VyVnx2V7iwVN0D1Yt68rHOs8B+HbQ2w=;
 b=kZu4rNy+DItp142BMTZmylB7ps7gIJTIx8fXPKSvgdpLWpvcmb7Ug+ZUDHLCPQ19FG
 6PynT6WAPbuFR7FpKW22+zGNoWSuAEQQ8YRiIVtMF+BiDxfeC2kvrFNoVsI7211H2IyC
 tPbfs0yKQsJ33VA5X0iYL3Pm0TTqzkOwoz7wBHcR4B7vqPNiJX+5E6i4vYmQWzYD0Z9G
 vW+6NjOEOZ7VW1PIHDiYo/GLuzRKUlZLeb5oP2PeNmLNqb4K81LDFZKz8VfpHYB+8Zag
 B1JdWee974bVh32+/91k14l6d0hD6lriK8DI2G2ZixJ7KApL+6Lj++KsRLSUUxBuXEAX
 gPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751464197; x=1752068997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=032zl2BE0VM1VyVnx2V7iwVN0D1Yt68rHOs8B+HbQ2w=;
 b=YtVQTQ4A2zj8O9d9QyE1oP1APr6wEHWRqTuaea709WTHosU4ZnMpyDax1CQP9YsA0c
 +vHPr5eL0b8nT2mgCR832fsm5E0kul1KewF3fMIISKUMnwTpV4BmzzBGmq6x6p4TQz/y
 WZR11OIVsYsFzfRsLebzqqfy/rFbXMeeMHmMFdUBu03SFNA6sCFGx877OC4XS3DPlQXl
 0QgAaXK4ogEHY7uVu9mP6rXxUlC3HrtYpqTpzjZtIAqoyUIyTPWp367sOQAwBNHAd8gQ
 EmTi135g3aFCViysUgVNeR0wu61hunWRdkqOPUgMJ9KjdhiJTkPuTfVdztNKDGyiafdd
 EQgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX59V114V39WaO9lTG4hpKN8oQpTmT+T7xVoeHG9DL2DxNmiYXFVVyB8f0wF/PpgHN55WLzaxg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx54pI9pU8Glb73CwkVKAeCTVw3MoQxWjb3E3bY8HbFyPUV2gpz
 6J98kzmYBYrNHC/2ivsN0+XQfuUjQF8wNDjxPbVuQrF6oOF07L8fZaoa
X-Gm-Gg: ASbGncus3V58TxIj4po4z5nERL/aQAzvqgI1n3JBdrrVefcd8+bhRgxhWZvepmUNkTW
 Bych0YGC99Xg3yKuzODbkQEQ9zqQ/j+5Lr88d+dsnAqs1+v0KrwBmnwhQtZDIHHzydfd+vjpl/2
 TRugWMTti+1bqoIefEGA2cBzkWNN7lnpLMYGWxDa144fLXWAX2k2o1nMQDavLsQBVBDW7Pcs32v
 B4A+piScRNz1//lTUZWuOnEZl6mMMFk/Vjx2OTO7nPHo/qi1UMao2tfJMyr64Tqh1YOYB0FLD5y
 Ux3BCzCEvNd2lyiQcA189Ia/i5rpAtYU4dwm8NZ42C8Dt8mCUuw8VcJGfEVKyhIjj+QTi06vsaL
 yqQGe8Erv
X-Google-Smtp-Source: AGHT+IGtsQknpIyH3H0dbJ29BbahG20ILMBHnv3Xloo+TQf0sILDfLHqD0cyCy69VPOJh1cs4rHrlA==
X-Received: by 2002:a17:906:4fc7:b0:ae0:9fdf:25e8 with SMTP id
 a640c23a62f3a-ae3c2ca3ebamr277672766b.47.1751464197107; 
 Wed, 02 Jul 2025 06:49:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:1f00:7f2f:5fbe:4831])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c01bd1sm1101810666b.92.2025.07.02.06.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 06:49:55 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 2/2] configs: verdin-am62p: enable RNG support for KASLR
Date: Wed,  2 Jul 2025 15:49:37 +0200
Message-ID: <20250702134942.1483436-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702134942.1483436-1-ghidoliemanuele@gmail.com>
References: <20250702134942.1483436-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Enable DM_RNG in U-Boot to populate /chosen/kaslr-seed automatically.
Enable OP-TEE, which supports RNG, to provide entropy.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/verdin-am62p_a53_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/verdin-am62p_a53_defconfig b/configs/verdin-am62p_a53_defconfig
index e782ad4faca7..f6cb21aad18a 100644
--- a/configs/verdin-am62p_a53_defconfig
+++ b/configs/verdin-am62p_a53_defconfig
@@ -172,6 +172,7 @@ CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_REMOTEPROC_TI_K3_DSP=y
 CONFIG_REMOTEPROC_TI_K3_R5F=y
 CONFIG_RESET_TI_SCI=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SOC_DEVICE_TI_K3=y
@@ -179,6 +180,8 @@ CONFIG_SOC_TI=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
@@ -197,3 +200,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
 CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_HEXDUMP=y
+# CONFIG_OPTEE_LIB is not set
-- 
2.43.0

