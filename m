Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45647C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 12:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED2038198F;
	Tue, 18 Mar 2025 13:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PZJiFy8j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC4C811BB; Tue, 18 Mar 2025 09:31:43 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A317E810E8
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 09:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arturkow2000@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso982955966b.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742286701; x=1742891501; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=atpsG9vcLoel0zCk2MsO381WuNKoH2r0N8Fi57XZXNk=;
 b=PZJiFy8jHf0DN5u+i9T6oqVs7zhIABiuQHs7CzIVFKRWLFaGfC6Omyy7M7Lpl9y59S
 TbwQLRmTACw60+AQGUdTS+nATQyfLc756nO451H24Rv0Vz+M4xDNDQj5NVa6to13kqsi
 DrQCrd+SQbV9n1+GNO/5N7F6Qsw4mLd1cNf0OSQOW/5U2H949xGnl4476SN4NsRNzSSx
 tjkUobcsLeu8vBoGS3D47L3AIS59SuqNDkBqbiUuS7Zb63eQKPdfFEjAiS93/LVotBRn
 WaYclKfe9DF/Xm7dOAyLcOFNmq9TuA8xtJCeWmJKu8bkLMd/oXDRcgDuBnBbRNwLTZkv
 d6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742286701; x=1742891501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=atpsG9vcLoel0zCk2MsO381WuNKoH2r0N8Fi57XZXNk=;
 b=mT1Ne4sskKqM6bwYcVQCatUNfigSF1juQzKvBVb3WGcoaxYl5J2+b6ub/zM/c3/Chm
 3bRVigb/6mb5kg9y7x1emU5qJ/jCjJs4wRzqcmBi6h14shgKmge+oV3DNNPPVHUVr54S
 +dWL6fA9+d6ACreWYPYbjVEJqKdpG/BXybVL2U4JTkpnAqLAa7KiG4BNMsjh2PrQLSzz
 8tdKdDX1JeQb/3HOsO6Z9Kd/DRTMOsoeaVWpEsOH+9K9+fbjNa1thMir9eyqUBSQnbjG
 WhX/GlyIkYJ7DHBgOKcQauXSn/Zg9kEfFISRRENeDIS973fSzlDneFPW+aBDC4pNJoFl
 UPHg==
X-Gm-Message-State: AOJu0YwY7UCIVuIuGA7Idk82Cx9IItXlMqeIgCxaiMaZlXLSaMFiAcXA
 AvJZwCtyNExVarfby4htdqaIzmR5PCBLBchpySXonxNPchcXz0tdJC+qhrI7
X-Gm-Gg: ASbGncuHXybLYRBZ8GfxUS9qwGdUbdR0H2oesAnB0uudQGMJePGk49/tzlcmCMeMNKg
 zCFSrVctAJ3PXeJ+tHl/L9hLMs01CyjTPh8XIiW46CVYZU6poGT6yzEETiXLNXBz7/bMmjO9k5y
 JMNXFDLnDbYwPBjXthfSwNIyXfvHavun5ycsd6HNH1Tj3bukHMSynNmqUIigyxa/p/HrJdDsfja
 NH0vDiRwPmWLK7sOyfh506hmNqAWVVLYK+pPhGJlBZyR+jWC23Zs7ZLXyi+NMlt4O91XGKYRLBX
 ShSUVefFZJZheFENYm29i/XbeWsl1jjOeHqs5ctXyHbp1fgKpRxe
X-Google-Smtp-Source: AGHT+IHf7bpFJ0D4ScEr08isQ7Pzrq3WBcl3Ie2BPl22NtuRpjyjQ0qzTvYrnkuT6U6f4R/DREabiw==
X-Received: by 2002:a17:907:7ea4:b0:ac3:4229:91dc with SMTP id
 a640c23a62f3a-ac38d58acf9mr238114266b.47.1742286700534; 
 Tue, 18 Mar 2025 01:31:40 -0700 (PDT)
Received: from eta.play.pl ([2a02:a312:c49b:a180:4e11:d045:a94e:c696])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a3e0acsm816189366b.142.2025.03.18.01.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 01:31:39 -0700 (PDT)
From: Artur Kowalski <arturkow2000@gmail.com>
To: u-boot@lists.denx.de
Cc: Artur Kowalski <arturkow2000@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Tom Warren <twarren@nvidia.com>
Subject: [PATCH 3/4] ARM: tegra: expose UART-A over uSD on Transformer T20
Date: Tue, 18 Mar 2025 09:30:46 +0100
Message-ID: <20250318083103.63250-4-arturkow2000@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318083103.63250-1-arturkow2000@gmail.com>
References: <20250318083103.63250-1-arturkow2000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Mar 2025 13:47:17 +0100
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

Default pinmux setting using IRTX and IRRX pins doesn't seem ever used.
Change that to SDB and SDD pins, so that the device can be debugged
through uSD slot when UART is set to UART-A.

Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---

 arch/arm/mach-tegra/tegra20/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/tegra20/Kconfig b/arch/arm/mach-tegra/tegra20/Kconfig
index 3349f1e2786..aa98b4d3d5f 100644
--- a/arch/arm/mach-tegra/tegra20/Kconfig
+++ b/arch/arm/mach-tegra/tegra20/Kconfig
@@ -57,6 +57,7 @@ config TARGET_TEC
 config TARGET_TRANSFORMER_T20
 	bool "Asus Tegra20 Transformer board"
 	select BOARD_LATE_INIT
+	select TEGRA_UARTA_SDB_SDD
 
 config TARGET_TRIMSLICE
 	bool "Compulab TrimSlice board"
-- 
2.48.1

