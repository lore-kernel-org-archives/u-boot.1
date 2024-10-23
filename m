Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D20FCF5389
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD0489312;
	Wed, 23 Oct 2024 15:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="e3YLUudM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E49FE892E3; Wed, 23 Oct 2024 15:28:44 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2331C892E3
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4315e62afe0so67953685e9.1
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690120; x=1730294920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZE3Q9T5BP6Yd6Zrt+nzATlRAqqpRrDp0DGnyCPfWr0=;
 b=e3YLUudMBeEmKOa+EJLk5EC/OKeeVqNU2G3nlHhoXikCCgb8Z4PoWiGsCN+UepmR7c
 0UEOYPlEgND6/O5+EyDHpeVOSUL6yuMvdHIZXIjqhU1zu8CupvNBxfgTwb74Rqe0Sp26
 bH01MXAOaSgdBPeaNw9AZiJw0ewdAqIsilNH21HPW9xGFR6gnEKmGnRiQzaj9ICdRSRB
 ZdJklqZkkDQjOwUBRTuhzjLcGnfMGYXumiXe704ac4UWIsUf8SfsPYmdJz7hmPwax6jW
 q5kqsZCLqLbZihez+zZaXdkNdX+2n1zf3M2km8gMW3/7aITMOJ5lpEyq7YNn+svWLrO+
 jALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690120; x=1730294920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZE3Q9T5BP6Yd6Zrt+nzATlRAqqpRrDp0DGnyCPfWr0=;
 b=Tka2W9IihMg8ASv6LJqE2oaWHLojD2guoM63DTgh6oO74UuMXaWEp3rHIiH1q7M++S
 1ElewyX9hvqH0SMdTSaSPXqaNgv+YsEtndakB1XHElwgfJVojiP7I6anzySp+KSxT2qd
 XYB7H9K/Ne01+pl757YgO2OGGdp2CYX/qW83HdQQygRiTDjK4O+8a9qm9LK59rF1pp2o
 NCYD4D2GLyJHpmFu4tOhUG2SPTYkxLLX2YOm4pdK6eTnRZvO1VBizBa8sDb3zAs+VGJl
 Qu7zYee2aM/vDzTU44IaFWzo70yrAa1Zvqlnmiw+qLn0r4h/OU8jUWGnLHos3lEw/I7s
 0kdg==
X-Gm-Message-State: AOJu0YxdTxIig/TwEsSB1RPDDKRZKN0uBhjwJwkkm8m1bQ8uRDuC/YkP
 QNTCPFspkY8Xrr+Pg2/OZGSmuCmHxS886NeNddCkbNb08iG4gnw+g50fVaO5uVmHG6Le5xeCMxc
 B
X-Google-Smtp-Source: AGHT+IFQC/1YLtZVDGczJ2L7uTKVZW9DxRGzqOY/hIobUC7ihhykyPJmiDI/loqNfw0rzI8WPqWzjg==
X-Received: by 2002:a05:600c:35ce:b0:431:5bae:c600 with SMTP id
 5b1f17b1804b1-431841a3679mr21252025e9.34.1729690120504; 
 Wed, 23 Oct 2024 06:28:40 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:28:40 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 06/37] acpi: Add define for GTDT
Date: Wed, 23 Oct 2024 15:19:49 +0200
Message-ID: <20241023132116.970117-7-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

Add the interrupt flag used in ACPI GTDT table as define.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
---
 include/acpi/acpi_table.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index a1bdab7305..c6a3e44a95 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -707,6 +707,8 @@ struct acpi_gtdt {
 	u32 virt_el2_flags;
 } __packed;
 
+#define GTDT_FLAG_INT_ACTIVE_LOW	BIT(1)
+
 /**
  * struct acpi_bgrt -  Boot Graphics Resource Table (BGRT)
  *
-- 
2.46.2

