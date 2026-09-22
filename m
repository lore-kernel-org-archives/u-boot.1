Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4050C982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 14:40:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 449F640AFE;
	Tue, 22 Sep 2026 14:40:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R8L5qfh2w3MY; Tue, 22 Sep 2026 14:40:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8932C40797
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790088005;
	b=Q2Jm8SIk+6cW2GUbmtdG/uNj0TVdf/oRQ1332Ehp4ln/r2GUb4P5ERRX5xObTLcidSKe
	 f95ohmOboWrtSn2pfcvweZPa3HEw9UZ0W7JyfmSYPSOrbySycRP/5SLUzt3Y5CGk2uBD0
	 LkFknLAAGXjy48attOySExgfLMuR64MDps9TocVrqRMwmyFzu5DXwJ0nRsbL41Bvc5xfq
	 hNeFtutnr3H9LXrXpbZO3jyjZq9/IkdZhtCTp/llb1wAjwzrN0GEcrhz0WAMiUnta0X3E
	 oVdbSVoAv+9pzIwohZ1rh9L9JgoBesl/lGU6luza/uhXU2dDmrOv2kKFMKCgx2Nu28A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790088005;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jdjRVs5ydbcIrSFH78HR766DCi3O2qfqpZu6g9P0GWA=;
	b=DICGf28c3aUsUWXNOQ1ES1gpSEDXSaPhgwSXABppNF05A94BjdqfhZglbGWasIw7SEEh
	 Nhk6GSjQjXames2aHIU20YgKJYd2kN69L1oPo8+/EKA9t9fIhN8jftdFQ9DliKVp6W/qS
	 t6JSJf1AqsStPlEi3A1IJ6GW+6mCa3oaGtZVYRjDjktWv2AqjReueeY1kO6SEkQIZTNGb
	 LA49JyR3NbMhws1dcaEmAz6Sj6Gnuj2EGsmTRmJKkQy5zivUCHrDlaZt+cVmW3FELm9QA
	 hjVr+4+snyyV5tD4fNKmFXAfYVOf7Mvc8BAYODkBuXpr+weDC53B4yiylQfW5q1TcJA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=none header.from=pigmoral.tech;
	dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=Q18NqOZF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790088005;
	bh=jdjRVs5ydbcIrSFH78HR766DCi3O2qfqpZu6g9P0GWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RrgIKWMDTLq+VESizzQVIcLlll0aYrNxvozAGCE6/VbK+cpiswf3MIOE3ybso6mpY
	 lDxeKnLSqXI5LcFmE43SfW+S4GgZlNyuoijt6WegVqygKmDHP0BDbtjdhUdbxt/lwD
	 USBgmQ+ZoV+8pl33EC4R3VNFR7Ly6owOOUMl1+PYqcUAdgaUWzDEDhqN3EeKZOELLA
	 6emg/rqCBXDmpMtJPKpWqeYSGp0zzMFUX7DvPw0VXMhfHuNNU2SWrA+AhiopDuy9rL
	 hkQNpdO7CTkIS4wy3XOiKADPkyJlpvLfaeEkDXvwwcnjo73f+ezPD7jZiyeoWTs2ri
	 Vk3b4bKoq47HA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8932C40797;
	Tue, 22 Sep 2026 14:40:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C51412C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12CFE40780
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:40:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VzwcJ6wp7ho8 for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 14:40:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 277D440AE3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790088003;
 b=RV0xef/8wo/Z9Yc/XOCCSSmognGS0Zo4kJ2wtqU1KNXetEj0afuDjDH8VnOD5DMMi3Xv
 9tAmKkUQgp77Tv1ynlhwM0OvRJp1dPsrfIk3FDy8GluTKf2PK24ffEo2jLvGbukr7A5Sb
 AK+pieLWHxwP9Et3fE+8Gyyf6ZdzLHG5S+iw1963nTFp8DaqQgLbRnwUqQaoVOQVlF0U+
 eQgo+1p0nGox2WM77rfM3hShXE9uN5f3B0zqkFIRy96Pe/NvVXwToIYkOmLTtcyMNgrnm
 r+5CksChcFquhhNsxNyuJhjcPQr0z+353MmBOHIkdgeJxSjDtPBoqU1CbjKDVTMVNJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790088003;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-ZohoMailClient;
 bh=jdjRVs5ydbcIrSFH78HR766DCi3O2qfqpZu6g9P0GWA=;
 b=egXfD5+PYpEiujLg/gnMHBgS29ZprnnLgHGgakUo9sj9SusrHpMR81cRwPANA4SY1b1t
 Ls9O1RehrfXhlMIlzEF3ls2L+1/MsxmgADtdWDPE8CRrib2xKZssGuIWJqh22ZopJCnI4
 OSQoe4xhnnISS1zTPlvR1cjc7rk2uaaJwzS+iVJkADGr+p4qjGElidFUXrIEKGdktqrav
 fL0m4LiiSbOFuBIgokRaTf+uoUuLWbKEjPJ86hTxQQ8MYAGPOYGQBHeWySyIu0LmEVyuf
 jFa0QWYbqsPNbwHF9zLL4FB2xSgf2gBnpF4JsCIFkbIH9Pq2Ap7Qa7Mt4BqpiyUGImA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=none header.from=pigmoral.tech; 
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=Q18NqOZF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=pigmoral.tech
 header.i=junhui.liu@pigmoral.tech header.a=rsa-sha256 header.s=zmail
 header.b=Q18NqOZF
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 277D440AE3
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790087978; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fCUSJdenxPLEUGZ4yQxx13KyP9yh+/a9zWJAMyBhoB3h8moEHO7elcfUFsNPieAdNv25G9eMd2CPYH7cmpnHbjy6CnwHXDhaaz34WgtCEBHNX2oSEUGqRG3nSTwDYTqAfV8b4+agdXbwl7iVqBk6HN1tuAIg9kpGfnMHtJhtHaQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790087978;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=jdjRVs5ydbcIrSFH78HR766DCi3O2qfqpZu6g9P0GWA=; 
 b=BVtkeUz24orHBsn53B8MQZzNJNQCScAFgmYX9NnmRCBgMBjkamUTGAT8BFaaR99eI0202iBEIBMqL9uQBqhsfUtFF5Cdg/tqetBmkwIoCbZTyj4rvlt5UrY8EKUyFxiVfsvvmDZw4FZxF4AGSXq6Pi94d5okJNgBVIorunXY8qw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790087978; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=jdjRVs5ydbcIrSFH78HR766DCi3O2qfqpZu6g9P0GWA=;
 b=Q18NqOZFkcHD25dN1r4JKIBc//W4+0CGMKTztWeDcs/CSPukIyq1S9v448v7NVWo
 UBNJzvgxXiEWmhIZ9yioG4hSWP7MQQvV/ptKroWsUaR8oM8DzAu69wSpA8Zcbht9Jb7
 6O0JHCtgO7VhPWC+bQx+uVYHj34kgPRrJ4+Z/tKo=
Received: by smtp.zohomail.com with SMTPS id 1790087976597264.32675447771896; 
 Tue, 22 Sep 2026 07:39:36 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 22 Sep 2026 22:38:47 +0800
Subject: [PATCH 3/3] riscv: starfive: visionfive2: Use the common memory
 FDT fixup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-riscv-fixup-memory-v1-3-83b3166320e6@pigmoral.tech>
References: <20260922-riscv-fixup-memory-v1-0-83b3166320e6@pigmoral.tech>
In-Reply-To: <20260922-riscv-fixup-memory-v1-0-83b3166320e6@pigmoral.tech>
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org, 
 u-boot-spacemit@groups.io
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>, Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=OIYtL0j5WLMwtWYDuqm+gSUR4oYrEGWA7BNy6Atm224=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLI2TWZr4+Xc2Mj03cojbHmEh9+R1sKLrTqO0j/Kzrdwh
 YiFyHR0lLIwiHExyIopsnD5i/+z1uH5dkSg9T7MHFYmkCEMXJwCMJFgA0aGV1xpIhu/F+wTm53+
 NW1W1MIwU1ZBWSd3pSqJZM1Hhe0MjAybN7ZvvnNkaYavkO2drJOdu/NvyG0Pv8WwcbV/5N3Xjxw
 ZAQ==
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The RISC-V arch_fixup_fdt() now updates the OS memory nodes from
gd->dram[], making VisionFive 2's ft_board_setup() redundant.

Remove the board hook, its unused header and global data declaration,
and disable CONFIG_OF_BOARD_SETUP.

Keep the SPL memory fixup, which passes the detected DRAM size to U-Boot
proper through the device tree.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 board/starfive/visionfive2/starfive_visionfive2.c | 7 -------
 configs/starfive_visionfive2_defconfig            | 1 -
 2 files changed, 8 deletions(-)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 97f40715f8fe..f526ce9ecf50 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -6,7 +6,6 @@
 
 #include <cpu_func.h>
 #include <dm.h>
-#include <fdt_support.h>
 #include <env.h>
 #include <log.h>
 #include <asm/arch/eeprom.h>
@@ -14,7 +13,6 @@
 #include <asm/sections.h>
 #include <linux/bitops.h>
 
-DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
 
@@ -100,8 +98,3 @@ int board_late_init(void)
 
 	return 0;
 }
-
-int ft_board_setup(void *blob, struct bd_info *bd)
-{
-	return fdt_fixup_memory(blob, 0x40000000, gd->ram_size);
-}
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 6fd43544a0c4..83b2fb88bfe0 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -36,7 +36,6 @@ CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_QSPI_BOOT=y
 CONFIG_SD_BOOT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 debug rootwait earlycon=sbi"
 CONFIG_USE_PREBOOT=y

-- 
2.55.0

