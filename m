Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5892D2069A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F42D88B8F;
	Wed, 16 Oct 2024 08:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="g2h18qn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECC7C88DD0; Wed, 16 Oct 2024 08:12:45 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 060E488D7E
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so595630166b.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729059163; x=1729663963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZE3Q9T5BP6Yd6Zrt+nzATlRAqqpRrDp0DGnyCPfWr0=;
 b=g2h18qn5EstzDk4mJf7T/0/uPRYuSxoeIOKEV1KfcZfM3GulCY7vgqI7w5LaeRF7l1
 WExTqNfBvTltQzLXfRCw+0CsI+gjAKIZwkL3lAdGABLiRb+Pz0jd4vZaxT34OsrTkw97
 Si7blw4DzH7sX3w8Kv1tgWo7PDptZrVM2mtn7YGLO3+qvtomQcfCUngn2WEXVaM55hfL
 /Mn51rdFI2UpyqzwZW/5m9+d8oxTCwRRh5pBAw3yHb+tTZehUhip7lWnCNxdjTJTKE6Q
 OanU8WnTMf3oUPKqgXerBSCGKg7/P+QdK1QXrRcdpbzj2qhbUADhXb3h/O9QADpwlydj
 oMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729059163; x=1729663963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZE3Q9T5BP6Yd6Zrt+nzATlRAqqpRrDp0DGnyCPfWr0=;
 b=mh7tDSmITEhQpKJxz5VJk1+161eb6y1xjLdfE1PaUdQLgUvqULigcDWvloYUF+PoEK
 OqK8u07v3fl9fHrLbS97CFSfuKRY19ZpzZyTUQymqLovWFovMoit7kOe4OPl/gaGIU19
 wxUjUAFzBPPVsqEFaftZdTP3yjJlj77GQ+95pDf5UUYzQtdkiaouNuVoFUpLqhOzE+fL
 rrAzRxUHInKUNfxF3Sk8W1253kALURyzFozX8PciQSAacOs0qzrq7478FCRw7jq0Iksg
 mm25p0PrEuwATcSiPI9BJKPD3w26uUkaPDZzhLjSqDERt/mVYtyTnkkT0uAIpDi1HHsn
 EZOQ==
X-Gm-Message-State: AOJu0Yyd+8UVvgK/dM0jJqM7Kyqfz3OFKuTOWFF+MHhGmlO//T/vTlty
 XwGcM8X3ztWyqP6cDbnw5hawdR8NRxzPTHOyJiMat+OxRJz1SrYsLqosycCq2Vx65aWjkxvzvAC
 L
X-Google-Smtp-Source: AGHT+IH/L6o4O4ngL2WxjVBeEhil+cJT3FnlRcmCfbzj19NcXgKL9yFaoknM57wHS3aPJPfrmYwXTQ==
X-Received: by 2002:a17:906:7951:b0:a9a:558:3929 with SMTP id
 a640c23a62f3a-a9a05583a0bmr1029020666b.48.1729059163446; 
 Tue, 15 Oct 2024 23:12:43 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 23:12:43 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 06/37] acpi: Add define for GTDT
Date: Wed, 16 Oct 2024 08:03:52 +0200
Message-ID: <20241016060523.888804-7-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
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

