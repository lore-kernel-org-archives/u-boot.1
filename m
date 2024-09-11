Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2845AEE01F3
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA9089185;
	Wed, 11 Sep 2024 08:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="OZqVG1cr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BC589164; Wed, 11 Sep 2024 08:25:30 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62FEF8916B
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8d2daa2262so408193466b.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035928; x=1726640728; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9wNhUgErQea9dH0iHY6sp+nGnmHi766qf499kv3mCmI=;
 b=OZqVG1crT4NxBtxR4lIw2UPyCBzxfM3+WWOrljI2M4gXemXeTPjAsmpva5ppLVA90e
 YSExipD4dvVBgXd38SswT9LBNiikAD6DcSdsyciTqLo7uSDZGDqUmXxt3tthfwdTfZAC
 Ou5X5lJeFKAIfQufGPv7M7yQ3gGhZEWqq2k1sWxmluDAKGVMqpP59ONiR0FYdUm9o3dB
 blB17F22mjxLGUgXxGCi7u+73V09qbtJhXEeTu+Pe9TtV6Tb1akHJ0Mg1bGp1VSuKJXV
 WPCr2VBHkU0GaSJ0Ms7z+5VCxIwxo6ljYTJzZJV6QKhjd2wNs+xyohbkzri+JmdPtKeV
 dXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035928; x=1726640728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9wNhUgErQea9dH0iHY6sp+nGnmHi766qf499kv3mCmI=;
 b=boD+Jeo0CmqLx/nugx9y6GZIBM0oTJq1K8TNyDs8Zlcio5QUbOE2lpgVHwFOtkg6DW
 dw1h2LOzsb2OdYT7hE+14GYHyAWxZWowWGlyfLMvqxNJCXSJQxZbfC3+T8BFwWFKUClS
 LHYR27o7MPtsAyrNv1bViLEXHOKj+YfVN+4yC+TNAwexl6WBFQU7Fqqtwesl7J1lNcj5
 Fbrq90K7zyazCDhSagQYxfANIcG+CYrQatqKrYuhbaZT2PrusHk7y4hgPOL8XyaOwjiN
 RYPAzhZmvpreYmjgT4XKnyQCfhQ3enFZE4/zWsmQqo1Yl1/YWpZ57hyTZtqQ0ljvWNNh
 B3kw==
X-Gm-Message-State: AOJu0YxSB+jSQyyq1OaXzRcKwmI45bVnGbfKi7zot3UZw9CBIb+j7dOw
 cKnOhMmOm2kFWXDrXkHQXYZRu2dGghC1MmzkdxUX3VL/UTsaPE1azpNo/E8hN4D4/iGq4zdT0/t
 w
X-Google-Smtp-Source: AGHT+IH/jDKtyfBw6Y5zqhzDV4NqbacYt+TieRZZHbdHxLAZshiRoWnRfN0cx+geCdSQFA+8Juuwvg==
X-Received: by 2002:a17:906:f59b:b0:a7d:a080:baa with SMTP id
 a640c23a62f3a-a8ffab8f0c4mr241425166b.34.1726035927789; 
 Tue, 10 Sep 2024 23:25:27 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:27 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 06/30] acpi: Add define for GTDT
Date: Wed, 11 Sep 2024 08:23:56 +0200
Message-ID: <20240911062511.494855-7-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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
index 26da42967f..f465dd10ee 100644
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
2.46.0

