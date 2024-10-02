Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C745CF31A9
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6304E8901D;
	Wed,  2 Oct 2024 11:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="bUYdSB1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B20BB8900A; Wed,  2 Oct 2024 11:51:53 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C36DD88F1F
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42e82f7f36aso52672645e9.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862711; x=1728467511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhKl0+27wwnmWUfvyWSNiYNJopYPLhW2o3uTph2q/y8=;
 b=bUYdSB1vLzqki4rC1FGLFb2TUteUrwgqcKqgRUvPx5FbnMo3rrNijYvVlfO36vv+2t
 xMSMKH23T1JB3dwebeh7hUCIFhNmq3SOJqYoesDvrwTGLny5e3X0dGI9KFcyn9KO6dez
 r9/Kilb04VJiEGppddROtbfjurhXq9qALPT8t64hZZJfzvtYf0486vkz0Vv/NzGlY5Ca
 uup1n+XK1IlQNrhCQphEKiQEndSSMkO/15ykd/ryXE5edTXKX6t1p6GY0dzjylZPT4Mx
 ly89QFE95MyqkNRm4qK3XR3tjIJhR+GbP6fgx68nJ4OkRjF2yLPyZMDhniwu/WdCQyAo
 auxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862711; x=1728467511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bhKl0+27wwnmWUfvyWSNiYNJopYPLhW2o3uTph2q/y8=;
 b=IQc+ZtOVqY2bZtgOeVJzkoyl2ESs6F7G2djcd/9BEJMPs1YQavjMscVFe+IMZfFz0b
 iISqenE3o8E4oPXP5v7zOOMBN89SAa4MGjwwLM7peN1QxcCd2a8onsulHViqevQhEuBu
 DLUSHBmySilSXAiG8/Ax65afqyzFFMzSNONeePx5rMP96g8dWnAPTjDqbvOmMGB6R5iI
 Dq0Dvoas+pplfqaUL0EbH9QY+xrAqZMxiky3Izf/q6IeiL1KJMyVXpwuarsgG5e6EEHc
 dm8hvVW1cJJzB+xjeKfYI8rPYm8yWqQ68sq/CYwi9sQjyDq/z70+60EX8TojnSFmQ+Se
 lVqQ==
X-Gm-Message-State: AOJu0Yy4qEz8oGlp+GT1YB3GAzqfOYXMQjkPKzN/II1I2RBurE7yD8gx
 rIqINRDr5m8zDa9M4lGojKOLtDGi7+f1uD31EVTpHlWcca2eIgKbFa7irjnSDfCy69akiC6wRgg
 I
X-Google-Smtp-Source: AGHT+IHqvKDkDGQHAnMmoztLFJm5TN0Hikk11NjjJHXqkbaozaJSnfXQEvziF9UMchzLbMCRODyWKA==
X-Received: by 2002:a05:600c:1e22:b0:426:6e86:f82 with SMTP id
 5b1f17b1804b1-42f778f060cmr18509225e9.22.1727862711260; 
 Wed, 02 Oct 2024 02:51:51 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:51:50 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 10/37] acpi: Add ACPITAB for PPTT and GTDT
Date: Wed,  2 Oct 2024 11:47:01 +0200
Message-ID: <20241002094832.24933-11-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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

Return the ACPI table revision in acpi_get_table_revision() for
PPTT and GTDT. Match both to ACPI 6.2.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
---
 include/acpi/acpi_table.h | 2 ++
 lib/acpi/acpi_table.c     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 48f8ce248f..7ee3248ff6 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -841,12 +841,14 @@ enum acpi_tables {
 	ACPITAB_ECDT,
 	ACPITAB_FACS,
 	ACPITAB_FADT,
+	ACPITAB_GTDT,
 	ACPITAB_HEST,
 	ACPITAB_HPET,
 	ACPITAB_IVRS,
 	ACPITAB_MADT,
 	ACPITAB_MCFG,
 	ACPITAB_NHLT,
+	ACPITAB_PPTT,
 	ACPITAB_RSDP,
 	ACPITAB_RSDT,
 	ACPITAB_SLIT,
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 959cac9e2e..2dc7b998e2 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -107,6 +107,10 @@ int acpi_get_table_revision(enum acpi_tables table)
 		return 1;
 	case ACPITAB_SPCR:
 		return 2;
+	case ACPITAB_PPTT: /* ACPI 6.2: 1 */
+		return 1;
+	case ACPITAB_GTDT: /* ACPI 6.2: 2, ACPI 6.3: 3 */
+		return 2;
 	default:
 		return -EINVAL;
 	}
-- 
2.46.2

