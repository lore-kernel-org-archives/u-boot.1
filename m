Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C11C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 15:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34F2D87B99;
	Thu, 18 Jan 2024 16:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kKqZcD0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E6D187BA1; Thu, 18 Jan 2024 16:06:51 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D614878D3
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 16:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-28b93b04446so2242483a91.0
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 07:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590408; x=1706195208; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fhFr7rVw4uOX8Xwe/5hEuybQJUXgkfswewRopIGXQYY=;
 b=kKqZcD0+4YBBdfIQzBLIx/fYtoCGiHBxrpg9n2wO6smQskx5UCWputhjuyEHtUVQTJ
 +JyZH6urgianKEgKEbFILnVmAt9M27YzaKbTQP2nCdbZKvZ3SPb17Yqt836icoZV4XQO
 1/FtuiAj67pVfR8SisrZFXnf+z8s9DSJtGBvlTe+8PVFciEl3F9DKZmu/5gLgVkiBNp7
 +eo/rQPeC4fGrZycl9qt9D9aDzohZ+YkbSOio2/ZMflTXToUpaiDADXovhvsT3KxirqH
 cbrtF5+U44ekKvQEuZh3cUXwpZBo7ne99pZryDVzGzTR51wU08lMscJeGnGoAO1PbXQA
 6BTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590408; x=1706195208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fhFr7rVw4uOX8Xwe/5hEuybQJUXgkfswewRopIGXQYY=;
 b=vPbWpaOVwbNhtftw3+OQ8Gb/V7rYapNmvbDAk+/mBfNeayMaDdatOUraI4QJxOWsrN
 xARpgbZKca2sZwi4RV/E46uWUF7TCnqRbndxbLaZ2+1WlyIq2rYeulsIterF1lPfdNn1
 LOHRiPMdrPa2fZkfD4KZt4U7OQ8B4j6OMLieWW6c84D6ApqRwsaEJV0zb1y2mcj2pBdO
 1WcsWFIPAeQmlkbeBvihNe/7TZgGdffPS610IV5W59RA/Z8KgDZsrxyKbE1Vl1uG/dy2
 yXO0RkXpSyC+Oipp5Igur0Tsa++CuqBwQFrEcw4ylf1Rs/gkWABiD49oz2H+3KlYS6Tw
 Ko4w==
X-Gm-Message-State: AOJu0YygJ6nH+BhmHv4ILBYqBNZPasG6GYIl7NrMzb1SuKN9FcH8e4UB
 EzbnKjIEJL+CMtRrnb8sfuE6zNwYukb6eksqSeISWrItyOiNfPDJ
X-Google-Smtp-Source: AGHT+IFUTNpwe4GtERUrPg5/ofckFl3TegagR98qr2nPH+AdzmUox8joMV4Kxwb92aX/2jZqGB51hQ==
X-Received: by 2002:a17:90b:d97:b0:28e:3989:c49f with SMTP id
 bg23-20020a17090b0d9700b0028e3989c49fmr1758868pjb.1.1705590407765; 
 Thu, 18 Jan 2024 07:06:47 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a109:42dd:8789:4db3])
 by smtp.gmail.com with ESMTPSA id
 oh12-20020a17090b3a4c00b0028cc9afaae9sm1930417pjb.34.2024.01.18.07.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:06:47 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: uboot-imx@nxp.com, marex@denx.de, thomas.schaefer@kontron.com,
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] imx8m: Enable LTO by default
Date: Thu, 18 Jan 2024 12:06:39 -0300
Message-Id: <20240118150640.3802089-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

In an attempt to select ARMV8_SPL_EXCEPTION_VECTORS, the SPL size
could not fit into the internal SRAM of some imx8m targets:

   aarch64:  +   imx8mm_phg
+aarch64-linux-ld.bfd: u-boot-spl section `__u_boot_list' will not fit in region `.sram'
+aarch64-linux-ld.bfd: region `.sram' overflowed by 1824 bytes

Select LTO to prevent that.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/mach-imx/imx8m/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index b1937198402f..328c3e388051 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -5,6 +5,7 @@ config IMX8M
 	select BINMAN
 	select GICV3 if ARMV8_PSCI
 	select HAS_CAAM
+	select LTO
 	select ROM_UNIFIED_SECTIONS
 	select ARMV8_CRYPTO
 
-- 
2.34.1

