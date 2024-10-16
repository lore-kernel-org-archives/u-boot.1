Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACA4D2069A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46D8988E00;
	Wed, 16 Oct 2024 08:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="MxTuOwNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CFB188DF1; Wed, 16 Oct 2024 08:12:54 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B52988D7E
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9932aa108cso925006066b.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729059172; x=1729663972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhKl0+27wwnmWUfvyWSNiYNJopYPLhW2o3uTph2q/y8=;
 b=MxTuOwNWO9lLjnslynGweLnnFj2gZFSIaoPBY2xwPvRpKqRZoadOEm0buhAKhlyShq
 oMpWOP9Dzgs/LGx3EixSomj3UADObx/7spVEQc/dkLkzR6IXMWGa/IrtsJNgvbe/Dr8T
 4PsdPa+w0G8up0g2CSB6C/2XbNXuEsNxViXStFkffhFwOFCUL9fPCz/GJpsG+WsTLOhb
 G46rQ25Ka4kpwFggGf1/I4UVhqgIZd15OHFsrN8HNAnH/Mjiv/POnz85goIyzlA2+GKW
 6Tjlb7XXOcPG2tZo/J/bHM2UUl7ufgEmj6vUUfHoQd3VXAjReRjH+3IfviINmaUZsUV8
 LqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729059172; x=1729663972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bhKl0+27wwnmWUfvyWSNiYNJopYPLhW2o3uTph2q/y8=;
 b=NQUGP2p6uh2s0vTjRT4jygTVnz5xlSTAMbh5gau8WU7iWq5Sgt/6rBrZ6uygeZ3I6W
 p3xkK8n/UCOSTNGo2IK8+ZI4JRBU0MJjqY724i4H17h2C2wiKugSgSU7SbMPwiMYaWxU
 VHgZ/ERUG/ABuIxV0qlZb3fC+3DQdUmAzrg3e7EAu++odi+35ais1hyNQ11tZcX3wabG
 +kvw52FR0Wy2iazWJlrJvhiKDVNlBh5b0Yc1Hi+rEqdxhTSQVCdfsmcyzMkl8brruOUo
 KJMIcmN4azWAbiPThUoO8hY48EWsK7oekoAmC289k70sK4vTuEZ0R2HjIkCYPWmHfSS+
 nI0Q==
X-Gm-Message-State: AOJu0YyU1dxtosdl8OMTfx/Tn4wuYJWUO7lGDA6mZGBMi1I4bJBJ9qYK
 a2pP10qCBePUwHS0cS6knbbwz5sGpYoBf0xpD9mpdC6GfVc+PsTjI20YKM0MA/AVPp6EI0HDS48
 t
X-Google-Smtp-Source: AGHT+IHuBFvgEsJjcOoy+cGQakNSQyudVQehOfaEUIGaCptcjHrFzo8OUfphrWRac+lgGp7eTz0qNg==
X-Received: by 2002:a17:907:7f89:b0:a99:f14e:7b11 with SMTP id
 a640c23a62f3a-a99f14e7b73mr1159777466b.10.1729059171768; 
 Tue, 15 Oct 2024 23:12:51 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 23:12:50 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 10/37] acpi: Add ACPITAB for PPTT and GTDT
Date: Wed, 16 Oct 2024 08:03:56 +0200
Message-ID: <20241016060523.888804-11-patrick.rudolph@9elements.com>
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

