Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AE9EE0212
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B32D9891E2;
	Wed, 11 Sep 2024 08:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="AH+4vSXv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3532D8918D; Wed, 11 Sep 2024 08:26:17 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F355891F2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c26852aff1so7425562a12.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035974; x=1726640774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCgHZVyJu6BPQQ1zHWgMaYVM6lAPOMYbRs3teCFuWKM=;
 b=AH+4vSXvypjf6ZydjErdRNFdcVKz4v4k82p0WRISF2UUqMCYtXAaW8nowFzRuKRqon
 VRgaKgjbA9bQ/2/z9qJ3ETgifHRSlqIhyuXZcF4niW1Vka4OwyNa2KXck2+y+iYBQTcm
 DLDn/js28rd+b0hS66Fj/F1YiX4Gstk0y/V0x6DI8/MtGW6ViG95SXhy3mcswW6eaWDp
 qpp2kgChE+v0+2CwGTd/UDvmpenL/7nurJJVm1iGEdbYPmVqm0+2XRMVFPQKAViFeAtk
 2XRtuH+k9r4D5IlsPh4HS1INP1tn70YTIYrgkgBtI+S9BtUsnCRRx/ZpXLZW1f1YWWR4
 YilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035974; x=1726640774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZCgHZVyJu6BPQQ1zHWgMaYVM6lAPOMYbRs3teCFuWKM=;
 b=xGNJ68KgyLFkCymrnN0Xf8PXxd/zmSS8+iZBiBupBqE6JVOwfPGruCwSvawY63iIz1
 ehnxqnXIDSiEJqvDb2ptMtVX+/iw+pSN+XKFl3ONdjXbd050rrbsOdOOigiYE9cdEMNH
 CMmt8Qpi+NTQNL56P75Eha54fMvyYyyfVYhAh8i+HrHN42ftm5mItUDmBEpRiOSIdwpz
 as6lGrnnO5UdSen9RXDtu+hwSuAniZeKnqw7FUQMIStxaGwbm+5rLZ9mEAoDxpbJLk7m
 wh0NWo88UOR5lEuD0irR++BlECdLvrYd2FQwzE04ho28Etd+cDcPn1d6gzyPwoyZLVYs
 u1Gw==
X-Gm-Message-State: AOJu0YxeXGBCp+guruux4wqhK9Pg27qiVEZu1eJqWIUwTj8+ALi8lGEN
 62z5yxPz6m+XS5qKVckge8Z9cQ2baYX9bVgqlRZEYTPIpqCiqqLX2BEEK6b8rcvDTpMqR7GPW7u
 j1LA=
X-Google-Smtp-Source: AGHT+IF49u9VaIQbS3vYd1GpVHyBXxRi3FN2ZYwMkDET3NIBPGnx6+nHU5CLgsgkduNfNDkJjggdwQ==
X-Received: by 2002:a17:907:da6:b0:a7a:9f0f:ab2c with SMTP id
 a640c23a62f3a-a8ffab8f0aemr274668366b.29.1726035974500; 
 Tue, 10 Sep 2024 23:26:14 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:26:14 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 29/30] arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
Date: Wed, 11 Sep 2024 08:24:19 +0200
Message-ID: <20240911062511.494855-30-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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

On FDT platforms the APs are brought out of reset using the spin-table
as defined in the DT. On ACPI enabled platforms there's no FDT, thus
enable the ARMV8_MULTIENTRY to use the ACPI parking protocol instead.

TEST: - APs enter Linux when run on qemu-system-aarch64 -machine raspi4b
      -	APs on real hardware do not enter Linux, but continue spinning in
        their ACPI parking protocol spinloop. To be investigated.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-bcm283x/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-bcm283x/Kconfig b/arch/arm/mach-bcm283x/Kconfig
index de783aa8f5..d2abeb778f 100644
--- a/arch/arm/mach-bcm283x/Kconfig
+++ b/arch/arm/mach-bcm283x/Kconfig
@@ -26,6 +26,7 @@ config BCM2837_64B
 	depends on ARCH_BCM283X
 	select BCM2837
 	select ARM64
+	select ARMV8_MULTIENTRY if GENERATE_ACPI_TABLE
 
 config BCM2711
 	bool "Broadcom BCM2711 SoC support"
@@ -45,6 +46,7 @@ config BCM2711_64B
 	depends on ARCH_BCM283X
 	select BCM2711
 	select ARM64
+	select ARMV8_MULTIENTRY if GENERATE_ACPI_TABLE
 
 menu "Broadcom BCM283X family"
 	depends on ARCH_BCM283X
-- 
2.46.0

