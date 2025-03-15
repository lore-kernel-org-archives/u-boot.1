Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D06C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AAB081F66;
	Sat, 15 Mar 2025 15:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QENCyN9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E399180756; Sat, 15 Mar 2025 15:28:48 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF7081F59
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso3942245e9.0
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048925; x=1742653725; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HpCseeffol6lsasERzt05JBB2EGhLIKJkSpiJ+MSXyM=;
 b=QENCyN9NWUjqZN49PMoS7/JkVNPtbKdDe84kBZsd1eVj3ciikl8z6cILW31NNTz0Pq
 Z/BBOeVyj92SvflQ3fGHxXzABTW7ymtIxKs/JxKxRuEuTJelU7gd8fQ9XUCr75D1Jc2H
 ZZduOlVCXrS6jZPD5JpuNq/npFPSkRABn6hyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048925; x=1742653725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HpCseeffol6lsasERzt05JBB2EGhLIKJkSpiJ+MSXyM=;
 b=kWS35u0ay3H3px7I0FKTfEwAJ1eKLKfCoI7oQCJB3Q+PkhKxlAJAP9fuGd0c0u0/7R
 VUn/FGd01MG7tkioVPOcnYRrVMxgSbwmx/9PjekrcP2o7UQO8L/PHUxa2tiiZD6RZ8QQ
 Vgr0KsdpCctmrQw/Wg2VkQ+cFfR17XbEdMyGwb+j6LQsc4aDdPKTuXyTl/6vB7PvxXtj
 9EsfaXz+TWU2SHxzLy8BBlyn1TKTDf3hERmc/Nd1mm1akfoOFz0PMrcxmcE+2wq7ISw/
 bjg+6AfOR9FkcOw2C+rC9CwJ1qin8tYN0T3rEL/9Ju21mTqwyrHInD8rIw/6You/AXRd
 rPlA==
X-Gm-Message-State: AOJu0YyQ87Zwn68ZzCc/J8Am1KuBK9jbdL7A9abn4IQ+RKR+Aw9DbaBe
 5xl3J6MGr/ThX20VLB/v+yZCYs3Wv9V8ijL9YLC4QBqmOmG9VD7aahCRfwd+C2ktKE/fjyHmAbF
 MLg==
X-Gm-Gg: ASbGncuvggC9TqJDgqYRkKZeYQK/OHdqhV+jbR2YunyNZZgEQ8jPiQXZJtA+TGd6s9q
 W7xyb7wqDFBD98P4Pq5fWLgd9cWyS9AYlywQqFRA8giBV1zW9eqFCa01JMzPSoKxh52ZFjxjwo8
 JPFxg3PrE+0hBTgrD1hoapqgQk4HlfZxT6or7CpTHsqlHpDMzuAo6tOc0PVfXC1Sww1aHcvUaMA
 WnvhkENDPlcC8E4gqEO9v0aiua2fOZcbiSwVEQ0uQrbQKX2aair5bZ2Toqy9NYRi0jnFxJ5ktLy
 Cp2aAlx15fMs13FjeYRa8I1yP3iN6YBArlKDTxz9/A==
X-Google-Smtp-Source: AGHT+IGY3Qy1z27vhkqANQ7vApbZHlJOOvTLfgG9gxzSKDZkkkHIrfM2ylqiJYADIRF3LtHr5hi1fg==
X-Received: by 2002:a05:600c:5493:b0:43c:f6c6:578c with SMTP id
 5b1f17b1804b1-43d1ecc77f2mr87190145e9.15.1742048925491; 
 Sat, 15 Mar 2025 07:28:45 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 43/46] acpi: Add a checksum to the DMAR table
Date: Sat, 15 Mar 2025 14:26:03 +0000
Message-ID: <20250315142643.2600605-44-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

This table lacks a correct checksum at present, so fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to add a checksum to the DMAR table

 lib/acpi/acpi_table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 3805b61159e..4044a64d688 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -66,6 +66,7 @@ int acpi_create_dmar(struct acpi_dmar *dmar, enum dmar_flags flags)
 
 	dmar->host_address_width = info.address_width - 1;
 	dmar->flags = flags;
+	header->checksum = table_compute_checksum(dmar, header->length);
 
 	return 0;
 }
-- 
2.43.0

