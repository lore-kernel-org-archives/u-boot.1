Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F1ECDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 20:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2F4D8701E;
	Wed, 18 Oct 2023 22:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="afLhzyf1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C515986FE0; Wed, 18 Oct 2023 22:54:12 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A86F18701E
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 22:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b6f4c118b7so4354058b3a.0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 13:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697662448; x=1698267248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M/Ikj8SmmIIqhwyofazdjS6RQ3LM55YhfBDV7PMJSyo=;
 b=afLhzyf19LZLh4eY0d7h+F75lI757ESdoAL1elNMo40enTN0i//CKraY1JV/YpTVYg
 u8ySYpnj26whQiyW/m8M67ZEsBl/b5aCMI+bOw2SPdhl2CKmALLMSrjiyaFpB4SsAfXN
 C5WJkG8MQvbzQoTPHi5wuqYp4l0My8BIov9NbGYydGPHqdHpmfiJESYb2OBzjVHI9ydj
 cCLEX8FoOSgEs1EUFp2h0M8nA/Lf6I8x98Q1Z0VkUJDQ4tjANbpLnSzqbAw8lVDEqxdu
 7eHUQdwv9VDXX71ODyYlbxx7wbjf+AKy9eUZ51Jv7MHtX6aZLpODa+vwcPBg/MzK0npE
 UH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697662448; x=1698267248;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M/Ikj8SmmIIqhwyofazdjS6RQ3LM55YhfBDV7PMJSyo=;
 b=j+0zauCNWX3/CaQNvHGriNW7xl8Z5lPD/oGXf4J5HMJfXZoLv0KmUeOWzsi11fXVCi
 OzcxE8JelrzyuXHz5zN4qABjWG1Ac5wHxNRm9zmgA4+6VWXxjqyTkq03K/TiZhK8Kbz2
 BnhKiE9EwJDkgCSy5xigqq7f5mwg/g9XVMbZ4eFl5OTYlE6kcGLAOtejFsdDcznqQkEC
 owOxhW7LHkZkH737rVQR4pSDNXUWstYiQ0RqMWK5AnQ9a4DAMWaaX38+BJMU7HObdzOc
 qJ+WOcWnvLqw7MDC3NuIXjqPAJSis+NyIsTtcWhNA7hCu927dq89be1vyX3CDCloNYsy
 zfXg==
X-Gm-Message-State: AOJu0YywVcMPSfMsyWzgyM3FHk1vRY9JIH9TOPplwqhOaC1QRYhSvs/2
 1Gu83Z4OLzRsa5Ew051h2fcvVKGFgb+Qqg==
X-Google-Smtp-Source: AGHT+IFohrduk3EUx3SXWpGMQKyEdzEjrSh5KPYd0q5Kkw2OtKukPWmq5ecaemlcmLF/FW8vYEd+Wg==
X-Received: by 2002:a05:6a00:15cf:b0:6be:20d5:e8f8 with SMTP id
 o15-20020a056a0015cf00b006be20d5e8f8mr258830pfu.1.1697662448558; 
 Wed, 18 Oct 2023 13:54:08 -0700 (PDT)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:24c2:a105:c9b3:8d7d])
 by smtp.gmail.com with ESMTPSA id
 m188-20020a6258c5000000b0069327d0b491sm3888573pfb.195.2023.10.18.13.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 13:54:08 -0700 (PDT)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Marc Zyngier <maz@kernel.org>, Chris Packham <judge.packham@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: mvebu: AC5/AC5X: use fixed page table size
Date: Thu, 19 Oct 2023 09:53:54 +1300
Message-ID: <20231018205358.1557234-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Since commit 6cdf6b7a340d ("arm64: Use FEAT_HAFDBS to track dirty pages
when available") the default get_page_table_size() sets some flags for
more efficient handling of dirty page table entries. This causes
problems on the AC5/AC5X SoC (specifically a lockup when calling
__asm_switch_ttbr() via mmu_set_region_dcache_behaviour()).

The reason for the lockup isn't at all clear but it can be avoided if we
provide our own get_page_table_size() which stops gd->arch.has_hafdbs
from being set to true effectively returning the AC5/AC5X to the older
behaviour. This also opts for a simple fixed page table size rather than
trying to duplicate the more complicated logic to optimise the table
size.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 arch/arm/mach-mvebu/alleycat5/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-mvebu/alleycat5/cpu.c b/arch/arm/mach-mvebu/alleycat5/cpu.c
index 8204d9627515..7ba57ae75e76 100644
--- a/arch/arm/mach-mvebu/alleycat5/cpu.c
+++ b/arch/arm/mach-mvebu/alleycat5/cpu.c
@@ -63,6 +63,11 @@ static struct mm_region ac5_mem_map[] = {
 
 struct mm_region *mem_map = ac5_mem_map;
 
+u64 get_page_table_size(void)
+{
+	return 0x80000;
+}
+
 void reset_cpu(void)
 {
 }
-- 
2.42.0

