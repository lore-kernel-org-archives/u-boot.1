Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F2BCDB479
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 14:26:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAFAB84A1D;
	Tue, 23 Jun 2026 16:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="E4/LlQCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC3CB849F0; Tue, 23 Jun 2026 16:16:09 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B8AD849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 16:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 084C13F181
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782224167;
 bh=xUXdkcKv1pZdcaykCOWlhnFfj1KV6WGNwFbKHYXZcKM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=E4/LlQCGcbwmrRNFZmLyMid2PJl0mLwmR2VQb96P1KdZRR31cgq3kMTlNcuZh6ZdB
 USJwkcG/62aX6KsIc27iwKXqVV5S9aGZkqFBvPPyyzOqEP0iwDYzJtguJYi6T/Hhco
 tGVmIH8SXl3+jtCuH/6t966MkWKYSQge48pQk22infDMoGXwKoCMgA3E6FDlfN7g7x
 hKTYG8owRvM24i9wkeSH6DXsTp9n+q1k8yGLNbCR8bU/H7lxZyA1u6POL+KNqaym+Y
 JbgoVjWCA3Um2ePpOVBpjGl2nlihY8BcCPF9QRuCv02Ht/5Hb+VQbs3MHN+ZlFZPfI
 XA5N8KHxSGM1VDlNdmsJVcdF5P91WlY227Z3V4KLzoyWYPzZqrwCSXfJfjHJQiAl16
 VobnHhoW1eugK7LOW5xnLcXlJtNi8f5Vw1+9VB8fpbJtr0xVkpR9d9FZKRfRQ5DuG2
 cWqUO48c1ye34hKlhKsJ103cznFsIAbPfVFHsBdaHMturK6mhDpQOVaW0YtbxpTr+k
 jfPI17zfF6Byij10iqgkGRTXO4jGm5DVfZX0mJm9CmJBqRaFsZUZwAreBDNe6/O9zs
 wjBaIkHAci/leckBwahqvVgsLuiTIwrj7ctNZc5jP3lQGcQ/LAS+O+mIAmxonkr1Pr
 aFcyLpH8i+11u2M5jmfkjFmY=
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c354050c34so46573885ad.3
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 07:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782224165; x=1782828965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xUXdkcKv1pZdcaykCOWlhnFfj1KV6WGNwFbKHYXZcKM=;
 b=Avh52skHcnnLQBDtRkesUzJQu075A6+K6PriR+OB+kMgxA6VCw7ObOwy/kdru5XbtE
 iWeN+strw6FgmmjRXio4H4FfnVG7sYNjthKnZ0KP2QRM6lPx6wcaS0c2zD6hl+98d3vC
 9dbwSLlrS8oH7DV688PdSTiW8ibeG06E7FpnYMJ77het1D35sOZGVrBZZL/Z8WtqHH8D
 B6+vO2rRvMQh0o1HbwnVdh8/GYqlDju7xT5KDWT3gfoiEKBQW2+LpMJ064SbOb/ugdM7
 X7k5EDdpCp7ghgpgBnOIjRlJuWp+5uzXHiU5ks1jjY9fWeFDfe+MB707Yyh/RK5m2jo7
 ylcQ==
X-Gm-Message-State: AOJu0YxB7P2VXxCg5QK5oX/YzMrJFinvtQSq+a/qSLGLHgT/ltqS2TjV
 9yfSuaFZX4XPB81/KPUX2JhZOnFnbB/2vKe8vKIeAYf1NBsRlvmerVE/vM727aCGuSO5f++L/BT
 v/XtZeQ62HO8FCDdp5fYIVoL6CvnhGWvl5E8xvvsN58uNVq2wK+uVUiyJw5ZQ175yv000R//Ads
 u1SF3ypw==
X-Gm-Gg: AfdE7cl06vMiy//07aItvp48Ni27zYkR1nhoV6ABqeiEu8wqHYeneES2OSpjOHplTuf
 2n2g4cqHR8rjDKAuR1Mn7HPphRbrhdITfkPAVVgL0d6ukwna04+3DkJIQ8dpVGAtz3YxPIEfV9B
 KUBj2vi1HjjVfJ0ri6icPc4RsxRpDIF28YRqKQusz2CUxh0ux5iPaUlMawuklXAFlOOVBYDCk7I
 mzznPcMy7hzEnFuWSfXFMHOEhsY9Gi1n8M/R0lJOse2qVUPnG4P0vB4jnIilJBACNHpzMKE6J8p
 IJ3tv0SJ/mPtprDxR4ftEdsSShLqgrhkbM0SqORkEcUfdz2k93imjNRyHaPHC4xrpwrXAq8RrrQ
 TxWjQA0gdoiBbFojm4h9Z8yXuZJCzfh1OAspTpk7zuKOtxAMcmSqvA1avCrN+Ag==
X-Received: by 2002:a17:902:ec8f:b0:2c0:e5ee:f56c with SMTP id
 d9443c01a7336-2c7c99def24mr28770905ad.20.1782224165522; 
 Tue, 23 Jun 2026 07:16:05 -0700 (PDT)
X-Received: by 2002:a17:902:ec8f:b0:2c0:e5ee:f56c with SMTP id
 d9443c01a7336-2c7c99def24mr28770535ad.20.1782224165155; 
 Tue, 23 Jun 2026 07:16:05 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7436d3505sm110410325ad.19.2026.06.23.07.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 07:16:04 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 4/4] arm: k3: drop redundant tifsstub runtime filter
Date: Tue, 23 Jun 2026 14:15:18 +0000
Message-ID: <20260623141540.618272-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623141540.618272-1-aristo.chen@canonical.com>
References: <20260528132746.719699-1-aristo.chen@canonical.com>
 <20260623141540.618272-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jun 2026 16:25:36 +0200
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

With all AM62x family boards (TI EVMs, phytec phycore, toradex
verdin) now using per-security-state FIT configurations and selecting
the right one via board_fit_config_name_match(), the runtime filter
in board_fit_image_post_process() that zero'd out *p_size for the
wrong tifsstub variant is no longer reached. Only one tifsstub
variant is present in the selected FIT configuration, and it is
always the correct one for the current silicon.

Drop the filter so board_fit_image_post_process() simply debug-logs
the variant name and returns.

Acked-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 arch/arm/mach-k3/r5/common.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 484d96f9536..13736ca5dbc 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -348,19 +348,7 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 	}
 
 	if (i < IMAGE_AMT && i > IMAGE_ID_DM_FW) {
-		int device_type = get_device_type();
-
-		if ((device_type == K3_DEVICE_TYPE_HS_SE &&
-		     strcmp(os, "tifsstub-hs")) ||
-		   (device_type == K3_DEVICE_TYPE_HS_FS &&
-		     strcmp(os, "tifsstub-fs")) ||
-		   (device_type == K3_DEVICE_TYPE_GP &&
-		     strcmp(os, "tifsstub-gp"))) {
-			*p_size = 0;
-		} else {
-			debug("tifsstub-type: %s\n", os);
-		}
-
+		debug("tifsstub-type: %s\n", os);
 		return;
 	}
 
-- 
2.43.0

