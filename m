Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74674E67485
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 22:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3ECD88B9F;
	Thu, 31 Oct 2024 23:06:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nhzCm7M2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36BA888E67; Thu, 31 Oct 2024 23:06:10 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04570885F5
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 23:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3e601b6a33aso898557b6e.0
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 15:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730412366; x=1731017166; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qR0zX7trzfvi3Ap7gMmvRhuyQXMXuwd4OGFUCePUp80=;
 b=nhzCm7M2KoUpySvymub5+HB2fyABjeee3YZ8Kf1IyrQe1PP1v6XdTqSTAUns2080Ol
 KfDzKIQ2G0sZTBxIInW9ROTxFoy40BNN5olyw9DRs/uyMUZrOZZREqL3QWK9/B7bBZ3L
 MBWWFjht/saGBHohu4dG+z2wyJKaVbJGrQyKgq1izf6ciu8CNc8Usc+tgrGPja8jXGnK
 uv7yQRjfzEIlnOTQEbD18Z/9yMKggbOaLEUwvpYObzcrktu10Uf6ZEg7o7ZaBUZFUouH
 aSs+OiBG+FfBFJOH4bX0lJKUnW4qOesmORcR4/d7KinYHKc0nSm56H8VwkSYvU5L54Hy
 OMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730412366; x=1731017166;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qR0zX7trzfvi3Ap7gMmvRhuyQXMXuwd4OGFUCePUp80=;
 b=JDJh68b1RXqNXAH0k3aw0iSD5IaAKWb2ybeWlTBJYxZvan4UIZv9vzvIMfZ5maZcoy
 IoBVWlLBhDmqoZA/D+KmjARR5ZkvtmMxW+F8gtF0rNiHf7EJJXfTaEtbYdcqcpEO6dkR
 qKLvHGHbIuro1bBw3UKsISQhUnj5G6rsFQDaF6dGsKtW82dIFbNMeQvmVdAoXSONdhCc
 eqAbxVCwo+jHvFG1yLbx/ShDbf9E7iWyMpd87rjV6M2xVCkc+JB6lHb8JUca9WDT4nLc
 2dm9gxXRPosY1mGib01Ri+6ioi+unrJie1+c1PWB9Zu/ObH9Xv/CghrnkY5r7G6qqwyY
 KTsA==
X-Gm-Message-State: AOJu0YwCqTlz1lRjx7IlOBNSi6D8YR1A+Arn7BgbjRz+DeIvvzVlGEN7
 EavLbzirCPD1zsgm3M52o6cvKJpsOWw2mP8Dl0TqXralNxE3vyQUzUnGizYFXmc=
X-Google-Smtp-Source: AGHT+IGcs+8QlTlATmV9ULDypeAqwYmE9VsMtS0E8pJpvUYi0kLE68g/U5mGzGfoU1hrRiSZ/7IaFg==
X-Received: by 2002:a05:6830:2117:b0:710:f5bf:c4df with SMTP id
 46e09a7af769-7189b55edcbmr5166837a34.30.1730412366575; 
 Thu, 31 Oct 2024 15:06:06 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7189cc597c3sm514952a34.8.2024.10.31.15.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 15:06:06 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH] armv8: cpu: Implement allow_unaligned()
Date: Thu, 31 Oct 2024 17:06:05 -0500
Message-Id: <20241031220605.31684-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

