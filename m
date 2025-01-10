Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5C0E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 21:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFC5580613;
	Fri, 10 Jan 2025 22:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HAU88EdG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29EEA8069D; Fri, 10 Jan 2025 22:56:57 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 033348060C
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 22:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d8e773ad77so17009336d6.2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 13:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736546213; x=1737151013; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dGdYweszTH0Gbua+E98vh/apNUJuT5CBi+lFkk2uZg=;
 b=HAU88EdGev2QCI2J5xkeuqI29vYlrp4KmqJ9PgY5cuZM0GQkEFZRi4V9L9mXaXrtib
 Ox/ybZlAoWUEssPjRlvXx815EHevHG04krS1ogL1gTbkHZ/H4wXUkoWHTrKWYOC1NwbE
 52bqEWz+HI/kW5R0E43l/jBOWTPhFbsc7ms69WgYSh2TOAkeGXFIRV9AOzX9pd1iKyYT
 H8Fvz1I8rLHHqg4HSayD7/rtJIU3S4xRSedO2Um5a9S+QALvT7owIfYV5cnWIknGirxu
 DF1v5jvMtGiBDDKujUzouGaonr/3q/ilGptHw0ReclIFZXdnLQ8PHJO+QEuYoZnehsPm
 sbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736546213; x=1737151013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dGdYweszTH0Gbua+E98vh/apNUJuT5CBi+lFkk2uZg=;
 b=R2KCwG3MFwsPhUrCdHurENfmBUXc88FIoFntGQyAjMZ18244TVoV/CqID+Uf8qjz82
 pd/I7HTvCO7+GUM3Mj3vbQS61G1ajrUoiITQDXcpFpy5PKQt3yhxttPZq/Wc2AKQh8Lu
 CRIG5pUFLtLJG5YLFNvn0mpQ6LyCvwd7W5TyIhiz5+9PfGCFAQOnpUJFY9B/jfwYipRW
 KBh2cnzbiNsGZ0FHiW/lDYG+jJAGi9BjxPbQsF+tYzi37jbFvb9SpYwTFGPCGCIeE2Py
 kvVlUnQnLtFr8uHuo2mtqOGlRfrxTO6WCefozh0EtAN6KSinbFOvrltPxsdJF8ZVYO2J
 XO4Q==
X-Gm-Message-State: AOJu0YxnhlEnNXNU1tuJtg+FsmQo2oEohuXR92cHwYXOjbXNoTowiE3s
 8cY5TkByJmyeNnsocTXi/hSc2GwMSowKVOdO0ehhKsQrN0Id5GEjNe4sXhGkqzxlWVxMnj/2eXy
 sbEc=
X-Gm-Gg: ASbGnctqkgxtzlqemDGfICkjjWzvb+VVAoFV7hNOoVNtjHtdKv7rp15/h2gwQdYACuB
 foJeh97SGgfTWn5baXfZshZL5QUHKFWC15/O6jblKlji90sj4CBzoBpXvJguh4r2yqxPSnfxYFr
 c62tcltybKZcgmYHIQo1nNJhdQSZ8eQxZ8i89ztFpRRD3CxVN38bHDRnpHBThKk87H6aNw2MW4R
 sX6J7QrSmNGiGM9s4LEx1k/rWPhyffSP51yv8NnGhbRhTJMlz67JpcEXKWTD0X62ub/0Yk/UTi+
 mkArrwS89EBUWubSu7bGNVcUnnt3UBxKHgkWmq3lxZxj6U34r6PB72g=
X-Google-Smtp-Source: AGHT+IEdRKCbx9M5mW+7bu1DuP5bfnYDBq8pPS2jYWa9n2SF2G4Lks6877fYgDSYc4e2ITf9EVX0VQ==
X-Received: by 2002:a05:6214:5097:b0:6d8:9a85:5b3d with SMTP id
 6a1803df08f44-6df9b1cc402mr227202976d6.7.1736546213463; 
 Fri, 10 Jan 2025 13:56:53 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad85f6bdsm13839496d6.17.2025.01.10.13.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 13:56:52 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: [PATCH v4 2/3] tcg2: decouple eventlog size from efi
Date: Fri, 10 Jan 2025 13:56:34 -0800
Message-Id: <20250110215640.892539-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110215640.892539-1-raymond.mao@linaro.org>
References: <20250110215640.892539-1-raymond.mao@linaro.org>
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

Move default eventlog size from efi to tpm for using in both
modules.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v4
- Initial patch.

 include/efi_tcg2.h | 2 --
 include/tpm_tcg2.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/efi_tcg2.h b/include/efi_tcg2.h
index 8dfb1bc952..7ed8880991 100644
--- a/include/efi_tcg2.h
+++ b/include/efi_tcg2.h
@@ -28,8 +28,6 @@
 #define EFI_TCG2_MAX_PCR_INDEX 23
 #define EFI_TCG2_FINAL_EVENTS_TABLE_VERSION 1
 
-#define TPM2_EVENT_LOG_SIZE CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE
-
 typedef u32 efi_tcg_event_log_bitmap;
 typedef u32 efi_tcg_event_log_format;
 typedef u32 efi_tcg_event_algorithm_bitmap;
diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
index 6519004cc4..25a31daf65 100644
--- a/include/tpm_tcg2.h
+++ b/include/tpm_tcg2.h
@@ -65,6 +65,8 @@
 #define EFI_DTB_EVENT_STRING \
 	"DTB DATA"
 
+#define TPM2_EVENT_LOG_SIZE CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE
+
 /**
  *  struct TCG_EfiSpecIdEventAlgorithmSize - hashing algorithm information
  *
-- 
2.25.1

