Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168AECFD31D
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7BF989324;
	Fri, 11 Oct 2024 12:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="DHHaJpCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0999F8930E; Fri, 11 Oct 2024 12:34:45 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19DF58930E
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a99b1f43aceso182977366b.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642882; x=1729247682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhKl0+27wwnmWUfvyWSNiYNJopYPLhW2o3uTph2q/y8=;
 b=DHHaJpCimWKoakYynp8BGpqQaUdnpXriwL7TBrA6VVFETmGvAzCq9wNblXdkpEN0Zc
 ZbM0V6J+6IvFQrD/4beVMpjTYy6TmweAGKtoyl5BWPzUmdy4pCVBs6niP+rN2bemqKuQ
 R9KMl3jnV+hPWMYCUn3PUl7RxOydxPVmhfeWB8pwyeA/ewaBEXetyt9LQGBg6qNuRstv
 cnu2aXy9QkDXU408Wi75IJZTzvjYQW9EkkOrOuuD/m06XeOGOJR9AN/WSImKfuTRaYzj
 YN5tY+/MlHEIsr0CwW6LHIsaZ5VagfGllrOKYevUWAscRxpz0264fcwZiShCT5bxfJf3
 ixgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642882; x=1729247682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bhKl0+27wwnmWUfvyWSNiYNJopYPLhW2o3uTph2q/y8=;
 b=QwPKHPHAgWiN542YgUYcRyngrpS0t/bev2lKVf1ZcGI5Q3bL8Y/yfUj9cS+j4xLRqE
 NLzHCb+URZPrtysD9PciIyD/CtdgKgecGf4oQeVdUrWDx+QW0lGsEHtIH8i9sEs2QY+L
 irOJ6Yx1gztVkLzm17vnpxJ7ZrGuiFmqzrLsap9UT90XOSeY5PG7loQF5xD0pkYgw95R
 t1t01loh56ambx+9Rq3dYdpyxIaKTEib8LJLyuhYypdbrF28tbaTsFpr/DLAo+LgPyq8
 1aj9F341IWYpsS7zxVq6J+UqYqMjc7CBE8Kpea/94/DFQ9YvqL8ykViroipBD9NoZey6
 /whQ==
X-Gm-Message-State: AOJu0Yzs6pyZdE59LWRuvpeelJe7kEq2PbATvCH/hezgI88f40mXT6u/
 ER3RU46YFiM+ToFS5XYHu/ysDwXn/VUkwMOjBig9qYwtWKQQKKlL0qC1A8lPTFDUy8XnFV8AQm9
 DUN4=
X-Google-Smtp-Source: AGHT+IFHXfyzDs2PZ7reyR48ebyf7mMt3vmqLUjQsVnVCJAt348wJLSBmeRdopgcHmd3W/cU0f4h2Q==
X-Received: by 2002:a17:907:7f8e:b0:a8d:4954:c209 with SMTP id
 a640c23a62f3a-a99a13ae710mr591879666b.22.1728642882502; 
 Fri, 11 Oct 2024 03:34:42 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:34:42 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 10/37] acpi: Add ACPITAB for PPTT and GTDT
Date: Fri, 11 Oct 2024 12:22:51 +0200
Message-ID: <20241011102419.12523-11-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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

