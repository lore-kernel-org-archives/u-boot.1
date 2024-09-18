Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF09CDD541
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2482288ED0;
	Wed, 18 Sep 2024 17:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="UfzLvbB3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD60988D69; Wed, 18 Sep 2024 17:22:11 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F13C988D4D
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c4146c7d5dso7770492a12.3
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672929; x=1727277729; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Z98JUEI4Vklj0ZGWYCm4gZxFPyaa2g/fPdA0X1eCB4=;
 b=UfzLvbB32pZ8O2qx8HHev4xbpw8+UWoyjXnWoidCmPjrg1TRKBfk0ugtvn6S6tqm4z
 2K9fYZJZc8GAYUNLy7wQ3aj9ID9AMgj3FcgLqRLyEHjAZq77/6Js1Vr+dCYMiiBe1oKJ
 +h/1o7G/ACKyCSkczzCLVjs8sVuA3TEf2BD/6c9eLPyuBIFCmXLPhJ7DQbVIVr6iOusm
 rzEnatNfiOuKFoFSK3IU7saJYplrU7s2j0sbB3DPoT+sB6GKX07comi8EDMw1zJM3+mu
 /Gk6TmGHqvIf3X4feehbfphgawf8ACQymiLKqm0YkSXj731lHq2fz0z6xVsT7+pPLwuZ
 7nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672929; x=1727277729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Z98JUEI4Vklj0ZGWYCm4gZxFPyaa2g/fPdA0X1eCB4=;
 b=RkvIucEkEISU93Km2zhfQHx64yDgaV39BV+GJPzyNWttDwpz+6v6WHAYu8EwOioliw
 4HNsCld1mH/3rRuzJnGesA46vqGkLFLjfmByP4Si53e9a9hI5oUuoFUDKaJ7YF+xbVoP
 BZqpYAl9ZNi04UlDX897/Dd2Y1J+LZS5TC65a8J7g8Vgb59rraVoy+qucho7pC2lyoU5
 N6zOw59kMgqf/1xV3m1Ti1rzzk+uBNA6rcdxRc0okZ4h0JCDARvx48D7SdWzcAJ3yh4s
 MeF25BKqyVjY3FANk3XrUComorQvVV7pG9lFQ7xyyb+vIZQbvBYuDWZeOsprdpjbSJ9q
 h++w==
X-Gm-Message-State: AOJu0Yw/QB1i1BQ7bib2oN2WFJsFnTmU31DbveB9s1oeqFso5LR78+cY
 aYMnFXEmVBLsvmoxp4LXbMNrt+jywk8WHCPladnB94QruYwLXKr7M97bU5ausWLFRHdIeeCgjMU
 7
X-Google-Smtp-Source: AGHT+IEaHXflxu/okKZUcIOo/wrsGP+AjHdqhIeFNkUKVJm+kggJ8/Omm+vyzAmoCAwMccTGDLdtGg==
X-Received: by 2002:a17:907:2d87:b0:a8d:7046:a1bd with SMTP id
 a640c23a62f3a-a9047d03d80mr1608069166b.28.1726672929419; 
 Wed, 18 Sep 2024 08:22:09 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:22:08 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 06/35] acpi: Add define for GTDT
Date: Wed, 18 Sep 2024 17:20:10 +0200
Message-ID: <20240918152136.3395170-7-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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
2.46.0

