Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4102C282DE
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 08:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93C59811DF;
	Sun, 16 Mar 2025 09:33:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="cAHUYrQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C134C811DF; Sun, 16 Mar 2025 09:33:26 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75984803DF
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 09:33:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e5cd420781so6599301a12.2
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1742114003; x=1742718803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+4DD7ylqx3lgBItL7zcOFivcRfc2S5e+lspwOfvEw0=;
 b=cAHUYrQydiTB/ir5oUArWbtRR9ivS7w1F0inOsAPggddSp/jdJuSF8fOgLs/17IzeA
 KDSsQ/ox+zHEMhqD7iaUVmmBe8BCCuw+5dgBR15HLW+QeRBq937Cfb4pUY4n68haB25P
 dqYAxempxIc7oiB93jFdHIkJ51rFKddXO0cHCW50VP8T7GiOY9OVn2cl5EZuIIvzn1WC
 EIqbCGQb3lLshdEoRpNvgH6xL0YFJQ+CZh5rfiUQygYLtCQLcNeEbQTN6h/kcsqYSLdm
 AKXWv6dhghvq6kuE5zPybobFtZ7VNKun+fbCx3nvCVozo7a/FbnPdIUkKdjFF46uPB+Q
 cfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742114003; x=1742718803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+4DD7ylqx3lgBItL7zcOFivcRfc2S5e+lspwOfvEw0=;
 b=YqaGl3ztyoZ2i7xXzhDvOK2IZrM5slppL6BOcAEuGNLn/rOVY1mkG3oBlF0dLZttU0
 EUSGTPZblod7YfygHm/cb9E7oNbQtnszdwarBp7sU3vmE6Z91kD74MENsa4ZRmJEqN6A
 QcpzDwUdbwoYAZRvAboGUOIupyg5LZMGUrGMqw0bJQNCirB+NugyEtIiFpnuENN/lJZW
 1RGpXC2ApKxDJzc/8pLsxfYfSzrlHD4sjrWncC80XRYNixZUlY06v3DyD95D+2odEkH4
 hGCHepMZPAW1XQtrJE2jlv8OlVDdVbUm2LgvoGF9LCfFrtUkegl3+UurCWeRFaYDY6HF
 IbYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1QRAE2/iMIdj3WymnaotYTdacY6SsLP98K9kYEUkykvo87eYKw3malI8x9Mi0yl0cUCAuD2c=@lists.denx.de
X-Gm-Message-State: AOJu0YzyDwgVrdHMmaDwQmXRzoO1G8ZlJmRdIMxN7Ch0nsESIFq0gpAA
 jt25zS9FRNmYKf2mYq4mndFN9aZNJ9OG1Js+qQQpgecFlqbWlBTKs9Y0h38r7mA=
X-Gm-Gg: ASbGncvf8kBBY7KbaLXOIQfOz3pt9VLdvR/TEme3QuzSTLQrY2rf9fUo0MWFZVbJkbE
 ge2tF+sWb0qsmNOsIMO7qRVJUYinpzX0pTTh7CehwH/XxYAjeo7tXVZLTkjYsYngmE2EH9i45oK
 DoeBVL9jBHk+V76suB3ilEPssurjiVxv1QtvEnFEa2s2mLyU0O6y0DhgvaFfeIHgIKVX2J7sK1/
 9Uyr6AomB3ZXIVBlKj+8CLF0VDk7DgM1NlhPog9XWipgKl7rLnP/Sx6N+KQ8FR95yhfxYvB36UE
 h7KzosKDrVo1msU33yCx+/yr9IUJoD+7EBhvCD5DMcLkagHI8a2hFhPFuM/mHP/cV1TBU/DU3lt
 JAX8mubxLsRE+kl3EtDwdJlGdkOghnLB39+zUt026JUE=
X-Google-Smtp-Source: AGHT+IFfQiND9D76OCdw4oz3lcS9b9K6QRRs7DH+l2la9w6maeLOnV569frZMAQK98PaLcdxi3m1Pg==
X-Received: by 2002:a05:6402:42c3:b0:5dc:7823:e7e4 with SMTP id
 4fb4d7f45d1cf-5e89fa2c0d2mr8438131a12.12.1742114002804; 
 Sun, 16 Mar 2025 01:33:22 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e816ad38f3sm4335232a12.63.2025.03.16.01.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 01:33:22 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [PATCH 3/5] acpi: Clear reserved bits in IORT
Date: Sun, 16 Mar 2025 09:32:54 +0100
Message-ID: <20250316083300.2692377-3-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316083300.2692377-1-patrick.rudolph@9elements.com>
References: <20250316083300.2692377-1-patrick.rudolph@9elements.com>
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

The IORT spec says that reserved bits must be set to zero, thus clear
all fields of the struct before starting to fill out non-reserved
fields.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 lib/acpi/acpi_table.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 97cd8e8ddb0..fc43862ec37 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -615,6 +615,7 @@ int acpi_iort_add_named_component(struct acpi_ctx *ctx,
 	node->length += strlen(device_name) + 1;
 
 	comp = (struct acpi_iort_named_component *)node->node_data;
+	memset(comp, '\0', sizeof(struct acpi_iort_named_component));
 
 	comp->node_flags = node_flags;
 	comp->memory_properties = memory_properties;
@@ -655,6 +656,8 @@ int acpi_iort_add_rc(struct acpi_ctx *ctx,
 	node->length += sizeof(struct acpi_iort_id_mapping) * num_mappings;
 
 	rc = (struct acpi_iort_rc *)node->node_data;
+	memset(rc, '\0', sizeof(struct acpi_iort_rc));
+
 	rc->mem_access_properties = mem_access_properties;
 	rc->ats_attributes = ats_attributes;
 	rc->pci_segment_number = pci_segment_number;
@@ -713,6 +716,7 @@ int acpi_iort_add_smmu_v3(struct acpi_ctx *ctx,
 	node->length += sizeof(struct acpi_iort_id_mapping) * num_mappings;
 
 	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
+	memset(smmu, '\0', sizeof(struct acpi_iort_smmu_v3));
 
 	smmu->base_address = base_address;
 	smmu->flags = flags;
-- 
2.48.1

