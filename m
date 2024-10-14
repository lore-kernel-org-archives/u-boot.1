Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42552D16260
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F11B089101;
	Mon, 14 Oct 2024 15:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Mrl/1TbV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1285089048; Mon, 14 Oct 2024 15:12:20 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEE5C88EE3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d4c482844so2413349f8f.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911535; x=1729516335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZE3Q9T5BP6Yd6Zrt+nzATlRAqqpRrDp0DGnyCPfWr0=;
 b=Mrl/1TbVTrkmmxjNDNd926/C/RtiuT4zBGm82JBvv9Yk4Dfo28A+/7e5nhv9wQnGeT
 TTdFKF2NIngQpuD5V30OZIgGNNuy8UN75AjVL4Ulh4zY5sb1PCeJtiMFQM/4YbiZJkdK
 JKYwHMc7wGRG1OFMH/TRfeIHdk5s1h3aYAtz8BIkRpd2ASl6TdMmrxA8LzSkQNgWNF7G
 ErgdowcOqNWaY5RAJjGT2wu5eqCzfhsMJy88FKRM8yB9/6WTlBzUub+QylDtQOjBJ6nu
 F8qPzz5Q2ovAccvf9P6PynWNOAlJwFxsNPkSURzw0HBimEN/FxdcmWzx3l3hS0tFYjJg
 rVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911535; x=1729516335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZE3Q9T5BP6Yd6Zrt+nzATlRAqqpRrDp0DGnyCPfWr0=;
 b=Zkmf/cFa/wjyW1JRvJp1hrGwziRAdSvrPjU5cfiLsnR1XqgFHyy9KY1tMFzyQIw2U2
 r5i5mw70hj7he0lH4RZ+b622o+JDs3UMJbjtHoPXlG4ufELQ6wY2LFO6+SnjwhwzhKTu
 HgJXsOksIIuMtzcDrwnMFY3sIulx91t930mbFvwxemJKnmOww4UqKt7sYFhxjg1i6f7w
 MVjMAJSDC0XlkHCUF5CZU6i5YioJog+qoin8BZCNFyDARS8jLBGig/Bg+y9PSqg/Hip9
 cgSsnFliXQ4puImq+xHjNu7oVRfvk4uoQoQ0j7sKC+ENY5GLMHw97sj+GV6r25tsqwq9
 ErNw==
X-Gm-Message-State: AOJu0Yx+LEolkWHT/rqpyQy/dQ9WpeMfyx2Kzs7+lqLd/xqwGqNe2q9x
 utNVtD2pwPYN27BNb26tKdvZhzl0kKZgRfRrAbMEUkpFBVpXNMarwMcsDiMGtCrjppucGu0/KAb
 1
X-Google-Smtp-Source: AGHT+IESkXoUMb1Yvaac1ZwmrBcu8x22uSjcXenUFo6ZLCvVi8mrZZ15bBDdgozgjv63wsVBt9f7GQ==
X-Received: by 2002:adf:e78d:0:b0:37d:4894:6895 with SMTP id
 ffacd0b85a97d-37d551e432cmr8666121f8f.15.1728911534690; 
 Mon, 14 Oct 2024 06:12:14 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:12:14 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 06/37] acpi: Add define for GTDT
Date: Mon, 14 Oct 2024 15:10:22 +0200
Message-ID: <20241014131152.267405-7-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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

