Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4771FD5AE46
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 02:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FCDD891E8;
	Thu,  7 Nov 2024 03:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YDHkoFVB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8160888A9D; Thu,  7 Nov 2024 03:58:37 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAEE688F14
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 03:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-28862804c9dso284059fac.0
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 18:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730948314; x=1731553114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=27I/8DAFwpgBTnzNDA2ziB6i+v5XF25fCmsqLLE1Nhg=;
 b=YDHkoFVB/AWqYYKAoR+au0X5x9NxLvLRqVQsa0/TFTVP2oq000x8DsINQHVlAUrzsP
 Avo7KaOT7bREjMenbqM0b9XzucNiBrdTotTY7UL9plHKuczM7G0uglqhYNog6EXP+ga6
 TI7M0YJK34DNkTt6VZj9Qs3Plzcfs55S4sncPrulaOh0OCl1XpDhn1fLN1UWCEMpwPMH
 Onkq1y8GRkhjIerlF7G5u5CKqmELeBgz9c37RsGZ6k3yuoZuhecb5HBd71rZBUL3/Wjh
 7/Evouu2hJ0eD6Ukual8qNjreEGipEnrAFnrW25ESs5gSHpFqNaHduCSKch4boC7tnCF
 N0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730948314; x=1731553114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=27I/8DAFwpgBTnzNDA2ziB6i+v5XF25fCmsqLLE1Nhg=;
 b=i4LTxpAkVn3t56IhFN2QJpVhCfTPg9xajVG6q7B6YRA3W8yfVo4q094l6CFP2QZVKM
 Mh/B4h1kaVyUBiBVmRNaRifL6zt8LKd4eRC/De1Mm4EGhMcLZ9rHAoDRk7zOeD4STzoT
 mmrGwUNjgj+4J4QrmaKdQjElqD+1VbSBiSeCxFUl2RixAb3lY0o/6eOfablRORkhnaX1
 UXY/3au+W66fnz/+hTpzBPP2PkpeqeoNY4i/Ir0SGqg43NQW/KqYEZjfiZ7Ohpf32hfl
 JGQPpdAiUm+f3InEQX8n/ky6PLHjw6O4TJWBaIZXIjQv70dpHHWsaT9uKkvgObusAQy8
 4OwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOLFJlzJDY1QtcApaHqS9zzgOQUsXqG96fTZumeW9g2OQTQDBgd/WLY5jgBk05srz77lKyaSs=@lists.denx.de
X-Gm-Message-State: AOJu0YzWFcK39vTtQI5A+VCq0L06+p1AVoCU2QEDZdNHeba2u7qIjSZc
 LV9u/T4E5DnVLh3bhxaZfjlDj+E6Cu/RK0KC/pDWPm5ZWTkcIbG7BUXcZE4Vp2E=
X-Google-Smtp-Source: AGHT+IEJTeG1fL4+8RIeRbTfShxaBaP3xA6Bjcr1QuPrewSwQDNLEZwWQtBa1blDr+lLNsOz9MiaSw==
X-Received: by 2002:a05:6870:1995:b0:265:b32b:c465 with SMTP id
 586e51a60fabf-295429773cbmr937410fac.9.1730948313716; 
 Wed, 06 Nov 2024 18:58:33 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29546edff0fsm155636fac.43.2024.11.06.18.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 18:58:33 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: David Feng <fenghua@phytium.com.cn>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/2] armv8: cpu: Implement allow_unaligned()
Date: Wed,  6 Nov 2024 20:58:31 -0600
Message-Id: <20241107025831.5459-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241107025831.5459-1-semen.protsenko@linaro.org>
References: <20241107025831.5459-1-semen.protsenko@linaro.org>
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

Usually ARMv8 platforms allow unaligned access for Normal memory. But
some chips might not allow it by default, having SCTLR.A bit set to 1
before U-Boot execution. One such example is Exynos850 SoC. As
allow_unaligned() is not implemented for ARMv8 at the moment, its __weak
implementation is used, which does nothing. That might lead to unaligned
access abort, for example when running EFI selftest. Fix that by
implementing allow_unaligned() for ARMv8.

The issue was found when running EFI selftest on E850-96 board
(Exynos850 based):

    => bootefi selftest $fdtcontroladdr

    ...
    Executing 'HII database protocols'
    "Synchronous Abort" handler, esr 0x96000021, far 0xbaac0991
    ...
    resetting ...

Unaligned abort happens in u16_strnlen(), which is called from
efi_hii_sibt_string_ucs2_block_next():

    u16_strlen(blk->string_text)

where 'blk' type is struct efi_hii_sibt_string_ucs2_block. Because this
struct is packed, doing "->string_text" makes 'blk' address incremented
by 1 byte, which makes it unaligned. Although allow_unaligned() was
called in efi_init_early() before EFI selftest execution, it wasn't
implemented for ARMv8 CPUs, so data abort happened.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - None

 arch/arm/cpu/armv8/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/cpu/armv8/cpu.c b/arch/arm/cpu/armv8/cpu.c
index d568efa427ab..82ecf02f4b03 100644
--- a/arch/arm/cpu/armv8/cpu.c
+++ b/arch/arm/cpu/armv8/cpu.c
@@ -94,3 +94,8 @@ void armv8_setup_psci(void)
 	secure_ram_addr(psci_arch_init)();
 }
 #endif
+
+void allow_unaligned(void)
+{
+	set_sctlr(get_sctlr() & ~CR_A);
+}
-- 
2.39.5

