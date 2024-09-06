Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AE9CE7AB8
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96E4788DA2;
	Fri,  6 Sep 2024 09:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="B917TJO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9E9A88D3A; Fri,  6 Sep 2024 09:23:09 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 088ED88D65
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c27067b81aso1843506a12.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607380; x=1726212180; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BibBHeId230ujWEmv7GmMRoolIMliZaaBq9TMM5XcBI=;
 b=B917TJO7rp0wCqMH71Qen9Oka6TZlfWEBreruUwiMTIonwrWz/DUXg1QjVQrrVdCMH
 xXPtrQh+ObdO/apZXSxeKJDGebLJAIec+HCPKdCfutljK4VCyVrdDYMiBKlSBlg9hRua
 q8J7FV90PnG+B4mpjCPShf3DMuucd0PRB8cdnDUv7QARYm8KBLX15hn5ARy266fEFcPm
 Ub3QSIxJUS/cyPFrMcGZ0oLFhXOVI7mWZe9RrgaHkmT2yQynvuT+i5x5BaWIuPqWK38q
 ss0N9jcxvM6Iwtxt3Atu8GS8oDO87LsU7R1Oc5TBjUes4vH0XNVjfEx9jeJYvUCTG9xo
 4g5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607380; x=1726212180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BibBHeId230ujWEmv7GmMRoolIMliZaaBq9TMM5XcBI=;
 b=wc+Lr7OCAwR3uAfpURQjiZ4fWrW1OCW7y4gFJXcvs43YyGc83M9t4UkghJpIVld/Ac
 Qj5fXOIeY0a2i9Qg3/1NiiTk1I8MMgJ1r4uV0O3auF83gYSIqml8EOD68Mh+Uy9ABFpd
 P33YRHVulomKb0zara26gcmUpWWlLARcMWUR4UcDgnQMKY3sXKMp10jSLHZI5tOfGaM+
 9gNfR4REUvxb3VfD/cAIslRw0Rll3G85RfTCsP505P4vr3FW+auiQQvYvZx61vhUwx7d
 jc3rBnatXfuD824QWCmbAGhV1a78LQ/3GWu7yY3j56QSTFUJyaM+V1/JQsrNb3vvQNj5
 Tg/g==
X-Gm-Message-State: AOJu0YyqqLUxOiYLL053z84j40m5v+n7MAI7SDvSm/1GfowZsUoDolt8
 pdsIoQmZeXbTRo0Dsn3KoTPJka7Js1uzOYR75YnF1Q+y7crF6oej/+6V08b5vop6gntQEARzmSz
 E
X-Google-Smtp-Source: AGHT+IHmFc9UIV8qpPH+uZLw5J2kW8dSu7x0OFtNazRQ3/NPFDzbph4lnno6KK1GAUlKy5SWuq8gZA==
X-Received: by 2002:a17:906:dc8d:b0:a8a:8cdb:83a7 with SMTP id
 a640c23a62f3a-a8a8cdbc1b7mr76232366b.54.1725607380508; 
 Fri, 06 Sep 2024 00:23:00 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:23:00 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 27/28] arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
Date: Fri,  6 Sep 2024 09:22:29 +0200
Message-ID: <20240906072231.2531491-28-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
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
2.45.2

