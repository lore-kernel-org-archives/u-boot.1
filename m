Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F38CCCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C14DF88D99;
	Thu, 26 Sep 2024 10:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="O7v57SqK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B51DB88D82; Thu, 26 Sep 2024 10:02:53 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E8E788D75
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5365cc68efaso662917e87.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337756; x=1727942556; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuAtYiV37lHVXKik/5kHZmwyI+vxZzd5Fd5yKBNPjE4=;
 b=O7v57SqKKVmOpHkhZSnUOtPb8bhULXvo28kc8eaa8isxYUCzGpwFqGhDzHopdKGA2M
 7CTFtSl7UQ+s8vce2d/jwf66kleX/091tw3/rvbOMbdNnDEUkd6DgEFRUyQ+qvrkj0rC
 TyqtoOtzLYFKgPF7Y3xXl23WaOMcYRstTpTkPfDONmnGD/VAsuyUp6jhZ8cHaQ8xFkus
 8G/3vmilDXdsgBk05qdbzg4g9Ao4Lj7SZK+vJeBWr3FHfZ3GCWGajG8Zp1IR/5ZP6x+a
 VUmeall3vdSxqsWJod9HZCYn5zYBnJVYuBA+xixvZUzx0zfKu8X49gKw7PSuvvAvBaYh
 DJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337756; x=1727942556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WuAtYiV37lHVXKik/5kHZmwyI+vxZzd5Fd5yKBNPjE4=;
 b=GvE4cnN0k5t5bYqT9rFhZUk6OoAjFEhmhjU0xK2JCuGrVWyhafPmmDm2p0biNKfRJE
 svSXAt9F4iziKDz/O/F+KbRvAzIMS5uNr1nWZJ2md3Jwbz172jfDY2tfSkA03ER/Gpgo
 Lp0P2tsWf5R7OOH22vQLQ/iJxjLSW9oIzboWBGe7HlEDbHnhQp47cjLRqfg0i6oys939
 Dlj9CVXMDXd6DzQyvn70g6WhnHrWrhRQuVWtVaCWjyuHouuoW/yoKuWV+YhRQwG5CSdR
 m4Ksh6KU8AjKb3fijTnn1/Ddx8EYvwMoMiXM4QdFMSlRKGk776IKRsQUomdI2DbU/A14
 Hqtg==
X-Gm-Message-State: AOJu0YwY1SfP3rTEyE4QDWBgE71pfH99Tl1f2zvmylmzHqMJMRdYL3V8
 BosovRWB61V7k7PLE/ZZP00SL4H/JXO7ShxMcowK7EK11/V5zQpXJtruyok2mVZyfbTc4X9fMQD
 Z
X-Google-Smtp-Source: AGHT+IFS3v5U03OhOZewdTRNcYJfVV/7mlAwzPBzk13Ef+B+cmbrU9dN6OmF7XCXjwvhmagVn23nhQ==
X-Received: by 2002:a05:6512:3d91:b0:533:efaf:ab26 with SMTP id
 2adb3069b0e04-5387753923bmr3759818e87.36.1727337756266; 
 Thu, 26 Sep 2024 01:02:36 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:02:35 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 10/36] acpi: Add ACPITAB for PPTT and GTDT
Date: Thu, 26 Sep 2024 09:58:58 +0200
Message-ID: <20240926080021.148031-11-patrick.rudolph@9elements.com>
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
2.46.0

