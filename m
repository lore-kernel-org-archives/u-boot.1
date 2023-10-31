Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03599C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 18:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1070A875F5;
	Tue, 31 Oct 2023 19:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fsJNcKp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7040875ED; Tue, 31 Oct 2023 19:47:09 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9520A875F1
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 19:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507c91582fdso8684171e87.2
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698778027; x=1699382827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhGV3JQv45J74qLc6gznDny+8lzcoxSSwiPZlA865/M=;
 b=fsJNcKp6f8GhO3TaSFi5mhqJQrnNpF1H/LhuVym6ERTJWlIZGGdmqpVvBW1QABuFci
 sSg04npGWN8NCqzi+06rbZDyNIWNLmPpG2B2q0kSjqN87n4jFbGNV7u3pL6QUMPOLGiA
 vWJeA73d9B95Q/KYGLwVxZJqcUo/oYqhm9VDI2Kz/DTUSOW+HMUCLYENoTRfwWoolVbT
 nujUjDghFxNp3Wzx1M6E9TBZkzI8MpOVCeMIt+hdXfSTmb7FlcSpj195tlgNSh40VgTS
 kgoL+TguCEIELstbCVCe659XDMq0BMsNCofUrrR2j2bBlwkW8bZdJDq83kQ7BsaqiCzy
 Y0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698778027; x=1699382827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhGV3JQv45J74qLc6gznDny+8lzcoxSSwiPZlA865/M=;
 b=PWO3dKHe6r9bzjpyDVLuAaRzzz4sqQ7s9yHHO7bYK4aEVDjvUPDSzNlYKvBJgY2DwP
 pP4wTqkAYtUyMfesjNK5qUs8Kqb0gok9CW7/Q48bgQ9qsvl/gfpZU2q4MSLDDTMqqcRM
 y7P+aErNeIHsxE0YZo3VFka3hPLAbyY0dAtZeRVOmhx7RebjYetPcK4c8zsWfHhpybrg
 krp/nIqFxbdX+2mMBR6YPDzo+dPuxpK+k0hz7nkcOrenitXK/DqPc1TLQdcYdy2nA/Yh
 ATDwJtRKz0DikvCYzGGwTSgbU00RkoSXIgs4/5mnmnKoiyzZoY8ndHXqfdmlNh26Q2bK
 wGYA==
X-Gm-Message-State: AOJu0YyMnC81Vl8kNMt0wk2PwuqxeUsAvg/fLaXlnUl7lsXPpoY5usQS
 E/hHkVOenw3NHrXk2rXFc94=
X-Google-Smtp-Source: AGHT+IEpwFWyvI7dQEE8EBrWA/zVUcWG3bGkC/Tgd+Emq7kT/k8YlZaFyErj7P6SpQIGgtc+7WKwXA==
X-Received: by 2002:a19:5513:0:b0:507:a8d1:6e57 with SMTP id
 n19-20020a195513000000b00507a8d16e57mr9508133lfe.40.1698778026606; 
 Tue, 31 Oct 2023 11:47:06 -0700 (PDT)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 u7-20020ac25bc7000000b0050804a97f01sm278794lfn.160.2023.10.31.11.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 11:47:06 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: 
Cc: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v1 1/1] MAINTAINERS: Step up as co-maintainer of Tegra SOC
 platform
Date: Tue, 31 Oct 2023 20:46:50 +0200
Message-Id: <20231031184650.9141-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031184650.9141-1-clamor95@gmail.com>
References: <20231031184650.9141-1-clamor95@gmail.com>
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

Update maintainers for Tegra SoC platform. Include device trees
and drivers which contain tegra in the name.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cde778bc4d..f07386dc77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -665,11 +665,14 @@ F:	drivers/video/sunxi/
 F:	tools/sunxi*
 
 ARM TEGRA
-M:	Tom Warren <twarren@nvidia.com>
+M:	Thierry Reding <treding@nvidia.com>
+M:	Svyatoslav Ryhel <clamor95@gmail.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-tegra.git
-F:	arch/arm/mach-tegra/
+F:	arch/arm/dts/tegra*
 F:	arch/arm/include/asm/arch-tegra*/
+F:	arch/arm/mach-tegra/
+F:	drivers/*/tegra*
 
 ARM TI
 M:	Tom Rini <trini@konsulko.com>
-- 
2.39.2

