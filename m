Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A8CC3DA61
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:23:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB1988795;
	Sat, 27 Jul 2024 09:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="WICzg1Xr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8925D887E3; Sat, 27 Jul 2024 09:20:40 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A607C88792
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7aada2358fso401332366b.0
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064838; x=1722669638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmTP8S0NJD7EisbOMGH7Y28sMtcgrZPf9zLE2A1u6do=;
 b=WICzg1Xrkiwu7U0Gvv0qWXj25kcdgoNKYHYgOD7SKYnO5bzCsUuFe/fUaXrZ1NdsV4
 WLKcnftI+J+jnwxKWgCHZvu/3OHWfaA2SIXdSTaN/n3svdwpHeJsjyGaKgg9YNYs/YC+
 ql2VbkTVZ7HEooMqaH8YhJ3N1W8jIl5igYRsv1lcyGhiAvy8a5Ni23cKmXMva3TmeFQf
 wc0NEZHhrlNgXJDW5s0goxebAHRabDvcEFz/pSsw8cpdrI1ANWw4fdiJjGFihdAvL2iL
 3NODlHd25kZWUWbTz/rtyD3x1We3JKm0c62qPEkuWkgltGteyRLQS7QvwJKX8eKnTxQj
 0XIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064838; x=1722669638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmTP8S0NJD7EisbOMGH7Y28sMtcgrZPf9zLE2A1u6do=;
 b=C7kads10TCZjWm0lPqPhOHgEj0Qy0L44Q2L/ECY2L5NtogAhQCv6jW/4WSlqITg9H4
 qmTBDIgbvuwReRvlv9jUTf80iVjIWk5Q5TRT6dOBKAjku9w2blqPqMSZxo0kv1gT+N8A
 L4nqYqNw23m8foiSUf+LEe1Prm/TgV7z2HtU0obFI3LLaVLhrsGiYW5r0bRw6VQnSEV0
 XU87GHdarQLsBCLD6FRi5wusd/XTx1mieiX92ULGE/p+B+ubHardgirTq1CKv0CHpm5d
 1ICkSR1hMPBUHaJvjMHGfbM5nE3KAlIGic5VnNId4xoFebcu8tdOw+5F+XKjy209Ey/m
 sx7A==
X-Gm-Message-State: AOJu0Yww3fU0GS5F/LMFg4GUyx/11Dic4ri9GwhF5PIS7Of0+UHFcFwI
 rE8Ir0VZbo1Cnuf+eizupOKHffMkJlMV+Q66Xuo4+6gxn6rsL0ICml0xRdl7HHbBifR4g1bs9aM
 IWiQ=
X-Google-Smtp-Source: AGHT+IGDDxRHMJME+NctzR9a5fku/vf0hvX3c2rNVZBs6oSSgiQDMQJqMBTVIzdc84HNLXqI73ypXg==
X-Received: by 2002:a17:906:d555:b0:a7a:afe8:1015 with SMTP id
 a640c23a62f3a-a7d3fa35126mr142563666b.29.1722064838210; 
 Sat, 27 Jul 2024 00:20:38 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:37 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, bmeng.cn@gmail.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 16/17] arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
Date: Sat, 27 Jul 2024 09:17:17 +0200
Message-ID: <20240727071742.1735703-17-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
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

TEST: - Aps enter U-Boot when run on qemu-system-aarch64 -machine raspi4b
      -	APs on real hardware do not enter U-Boot! To be investigated.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
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
2.45.2

