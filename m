Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D4BCCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B60FB88D39;
	Thu, 26 Sep 2024 10:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="FEOhVGkE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB6488D39; Thu, 26 Sep 2024 10:02:25 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB6B6886E7
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5365c512b00so814987e87.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337741; x=1727942541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Z98JUEI4Vklj0ZGWYCm4gZxFPyaa2g/fPdA0X1eCB4=;
 b=FEOhVGkER/+gX+hTYYVm8jqJCLg1eumiJTXRTKpvF8SQIEJ9B+hVr6wrm4B6r/XePS
 97mrERd0no+vEgoTRAgsqquF9PbbXu9afUP+kZfjosxe9l2K7/oZL78V6q37MUMpPZuE
 GLJOoIalYiWs4EaDz+jc81Az1n9nxkjTAUclFUOkrp50P1SvunnEPQN164N+As7Z94v2
 wHAbxK6g5i/RtWaXrDxyDEMXTGJaRXT4gBryUbxXlzHAPiUWEbeNtXKRyKOp0DrBI59a
 pKF51FzyWNiV4VKL9fv8RhwV0x0r6X5zeEALRxzSOYkiLPSWBzP7Zo9H7/bSf7ewNvit
 v1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337741; x=1727942541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Z98JUEI4Vklj0ZGWYCm4gZxFPyaa2g/fPdA0X1eCB4=;
 b=A3BDYlsj7LpH7Ld9sj0IIsHni0qY+kD+SkcLpbIBA2bDIVipe/DnO60Lhqtb2PPcv3
 js1WHLV/DctnT+8nVV2m8qkKXG/8I/9YpIWPJjLD70agwOmBoklRV9Giz/8tJ511neB8
 MgHg3ChBGWd0GIOcFUKmJdVX3W5qKhFSe0rdUNfzsnJLW6qR0rd3c9I7+NAy/HRIeCuL
 dyP/NZbWSKE5FAfPyr+UywPa4N1GfCHV8wC1m0T8T/8yUTzqluL7Xch34wgm+yo/iPF4
 xqjqMvgsS3Gm0GhOhEimFju7KT8LpBMEpSpy2SkLW6biYV/SwLf6X/9bYPkuLEwxUuV7
 wQew==
X-Gm-Message-State: AOJu0Yxw7X8BO6pG642EbMavRFEPjbfuASdNG1WBMAgBZ2GdgA59jKIX
 Ol6MP4gNkVU3Z6/pbqmfnJASs2bZ7vxNpoeTObjhb6WqptrUWOgrXm3O9Bg2xuHZCOT1Ph8pw7m
 F
X-Google-Smtp-Source: AGHT+IFRomKrA8V3GNhyyjHLVC5zMoMin2fBbXrEriYmzfVwbP/3HMltDfZNI2nxoRrXRNSr1dH/gQ==
X-Received: by 2002:a05:6512:1082:b0:536:5646:251e with SMTP id
 2adb3069b0e04-538729d854amr3489974e87.10.1727337740928; 
 Thu, 26 Sep 2024 01:02:20 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:02:19 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 06/36] acpi: Add define for GTDT
Date: Thu, 26 Sep 2024 09:58:54 +0200
Message-ID: <20240926080021.148031-7-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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

