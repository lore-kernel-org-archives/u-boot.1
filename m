Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBBDE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 13:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47CF5801F5;
	Fri, 10 Jan 2025 14:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="HKYu1tDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ED8A805EA; Fri, 10 Jan 2025 09:53:17 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39AAF800C2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 09:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.lin@sifive.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2164b662090so27315045ad.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 00:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736499194; x=1737103994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tr75m9C9S0AwMpUgRHmLBOe/pATZR7OZXJKp7ez5JYY=;
 b=HKYu1tDvmycHUCkpO+2xp5qXKVftIM+SJWbTmeF1CBCUnlGxCtyUUZJYFVRIVm7lzP
 zIACmPwgmi3UhnksjP96vfhB+OZcgGcZct7TkllJnoRUJ/8k7UnQc2Ldnwa8DlzKCunf
 Fs41QGKdGffTGj2SdKtqtsJDij+ZeUzrDvX5AhJXa6PxGMjqvm9xUKJPsIPo/dnxg5Eq
 Ecty5eGkGfI3SnOtThphCSCGCSrXHh7BPiyHUsWw/NBrqNOYLnjt2SMDkuwtszRDy+T8
 ZiZvigcVKB7nRGsRR4d5Amx1f9KcY1wdm1bMsUCPBtTure5UAIZUQyLUeLTve1Pv81oR
 U8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736499194; x=1737103994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tr75m9C9S0AwMpUgRHmLBOe/pATZR7OZXJKp7ez5JYY=;
 b=sOqLglizP4arX4+2A/HBfXylSe9145kPF0vZoAm7XXhJGSA8SmDiJa4cpRVboZo7Tu
 fVvjzkKkKIZF4PVfq0yzNtNzSFvCMXrtjsgxItSvu2laz0LutUz8kaAE/T91iiOjQZks
 RhMu1Xo8qlx7zvXHnRlMX3YcICUwuPnLNN5WP6m2OcNzYu8kvYrRDi7TCdoJFT442onC
 8jsYh5JahOE877XlnFv8cVDnQDNW4qgR9FxpAFhyzg31g2a/2p6UfUA4tB/OJBuL+U0c
 lkA8Fee2tiLcPUvnjL7hSUWPY5Yh06P2KoEwslIk9Zgfnir72w51II8LlFcEikDZpfp/
 cwXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4JHtq6/14uCyE0kaeAykEB7/wS6ilnnj4dy5CocxPy4rBlHHrtUDxzRMPyaWrj6cGlazhNA0=@lists.denx.de
X-Gm-Message-State: AOJu0YzziEf0WMnl5tfCsERojlfCtm5dIlzM0SnWaqTky0AEOSa5a/R3
 skduM49NGEFzPYYv386R1TmAmylbY6ipxN9UrDC0/Gi+tIsRcOPbaAvPX+uXLGg=
X-Gm-Gg: ASbGncsrNIHyzsZwxtZXeu1wB+D3++PchDO+vRV3MNDJi+7GbuoEKtoQ8/zX8eHo+Zn
 vnw4s8BXMB9WM+K7z5ey6TH3Hhybz0VpUSpH/DM/kPVfC0tIWs1Ho9cLbtVAAHwoU4M2ddnvxDP
 kqJTdOK8oiE4k+NsdGDNbFf+DqZk56XWW1x9Cp6jJ602ZDoqbcAM60OwUw8SDtwaJAFr5cSmmDn
 T98zaUYVzbcSM2VwSrLen/1iXK/7BqEZkAKOZ9VevpdprXVX3kbaAhW5dsEYVjCRcSx5fy5zzbI
 +dOsF8HVJNrYuxupWRgU9cLhPRs=
X-Google-Smtp-Source: AGHT+IEd10PgQ3fagYS9UVAhDwnJeYXu3yqYcEazVzQcvvpY0rTC0Hpc9bzmRNfhSvurzIGH6/rLaQ==
X-Received: by 2002:a17:903:1cf:b0:216:1cfa:2bbf with SMTP id
 d9443c01a7336-21a83fc77c3mr156685615ad.35.1736499193738; 
 Fri, 10 Jan 2025 00:53:13 -0800 (PST)
Received: from peterlin-1873.internal.sifive.com ([210.176.154.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f217b38sm9813315ad.145.2025.01.10.00.53.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 00:53:13 -0800 (PST)
From: Yu-Chien Peter Lin <peter.lin@sifive.com>
To: zong.li@sifive.com, greentime.hu@sifive.com, ycliang@andestech.com,
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 jiaxun.yang@flygoat.com, u-boot@lists.denx.de
Cc: Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [PATCH] Kconfig: Add a default cache line size for RISC-V
Date: Fri, 10 Jan 2025 16:53:08 +0800
Message-Id: <20250110085308.20760-1-peter.lin@sifive.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Jan 2025 14:54:57 +0100
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

Some RISC-V platforms do not define the d-cache line size
through SYS_CACHE_SHIFT_n. Set a default value of 64 bytes
for such cases.

Signed-off-by: Yu-Chien Peter Lin <peter.lin@sifive.com>
---
This patch resolves compilation errors that occurs when
the TEE driver is enabled:

  drivers/tee/tee-uclass.c:247:41: error: 'CONFIG_SYS_CACHELINE_SIZE' undeclared (first use in this function); did you mean 'CONFIG_SYS_CBSIZE'?
    247 |                                         CONFIG_SYS_CACHELINE_SIZE);
        |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~ 
  drivers/tee/optee/core.c: In function 'flush_shm_dcache':
  drivers/tee/optee/core.c:505:50: error: 'CONFIG_SYS_CACHELINE_SIZE' undeclared (first use in this function); did you mean 'CONFIG_SYS_CBSIZE'?
    505 |         flush_dcache_range(rounddown((ulong)arg, CONFIG_SYS_CACHELINE_SIZE),
        |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
---
 arch/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index bb2e7bedd10..b0190b1f415 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -52,7 +52,8 @@ config SYS_CACHELINE_SIZE
 	default 64 if SYS_CACHE_SHIFT_6
 	default 32 if SYS_CACHE_SHIFT_5
 	default 16 if SYS_CACHE_SHIFT_4
-	# Fall-back for MIPS
+	# Fall-back for MIPS and RISC-V
+	default 64 if RISCV
 	default 32 if MIPS
 
 config LINKER_LIST_ALIGN
-- 
2.39.3

