Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229A1C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 14:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B907040CC6;
	Tue, 22 Sep 2026 14:40:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yobwgyMchxnR; Tue, 22 Sep 2026 14:40:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BAA5340814
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790088011;
	b=GYh8AajjB4D8+jEpo2leJQSRgKQdjy0d8C1lRPZBqKSXjo1lB9Fdnl7E4/etAyyfKfAp
	 QaoYYKyMnIhFGruKfAK9nmXUS+hrdiKB2OBYHaijc8vYhW2LoogNLEC5L9ZJc5upHdhK7
	 8yx9jIroBeqDn6cBMJqG+FBPhUa/XMl5CwjIcxwZG2M8DQb9eeBA5eMcRoHW+ZEbyFlO7
	 PYHyRl6SQ5hQYPN4e/hYOEEaDmY1rO7SiIkZ5qtX6iDmZpvOJ5kftLFKuo49pXQfSQsq5
	 2an2e735H1qb0+iuhH5U0RwJMl66zHUqX6AKJxS5MhIDldl29E0ERANVjas8pDZTdGg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790088011;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dlFi6xsq/apBmSJ0y1dIDl4wDJqhWIyq/S81uPzW3HU=;
	b=eUltVgG8BhoL00uCRRI+j/XWOUQ7wHR6lYBDzsDn+X1GFuvNSeUZ4MGAtlhaLWSMOqTh
	 ZL4GKF2PO1mZrOvQ2d6B9ks3xzN7wb4uBTzEeP54qaFAr50Tld3jfj5Ol9zqclWzWUv1m
	 MDeoymCjPbKsVwNNMYjOiI3ThYorPSAE0K9qI8ohuLKpwrqv6jGOvy+tJJwIAHyKfMkTk
	 spSFhcpN9hNRJY/cwUEqU42HELf9YbAZJDdibnscvqGcA9c1xCnzeYCRM0za5J5/cWGb6
	 L1vm/lJ3PefWmMT+Ly5OH8ySl1M9hygnaE/16WMsNUaFyT9V+mFyt9in0KfdYacV8Dw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790088011;
	bh=dlFi6xsq/apBmSJ0y1dIDl4wDJqhWIyq/S81uPzW3HU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E447smJOrbopfe0n6/t43XmwQlcvNtNT5fHM1EbAJpDP0iVqJ4P8tjgQEP/z9E6DP
	 IVAvgIvTSEaVX/cP+BlQGcUTbbBXDTb8dspFTVEl9rD3OO/ZKnJOuJlXAOsdqTcmr5
	 iClMvcBEhnO1Az5wkOmOJ/LbF5yCDeCU3W+Cgv6GMw41qsSz8IlL2vaMBt9mIL9Wo+
	 4mDI1HW3igKjVWlsulI5d0vUZULWAWoFOES4gKZybYIRMwXukw+lXZUvHAGFrm5sE5
	 XvIWA1HP28jWWjp5krnBJ4EjXQ3l2jqaSCudrwnAMnOQy+fcDliVtU/0rtbzBifM/b
	 QCpG3oP/J+K9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAA5340814;
	Tue, 22 Sep 2026 14:40:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E92F352
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:40:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 02A9F60677
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:40:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3qOhF8PfpiIS for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 14:40:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 68E1B60674
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790088003;
 b=R0H/wPrKGJHXVeIH11ALlGWn61nd35JIEP4wVjxzKg39jOd/V2YgLLsW7VBk9dF+h1Uv
 agD7E1SbrnYiEVz9oZnQLybJ2Ro/B3q4yDMACjsdTbcbHQV4WpE4ABGJGWhRhVvdTxc30
 OfUTdSwfWlI/kwMPrKz5kMVamHqN30C4BpOEhyPfRZiljIOgyWakgopaTF71zLuDsVFUd
 kvUab1v5J3ni0zMg7TWk/lgnQsVAGULS4o5CMqKy2QjTLMMwRaX89dRIe1t3VINpQ7jZh
 TsGccXtwNzomZzO/wg1+O35eGlsRzTfFRdNhHfUNlgPjPrrMVQ+WVMCTpDuIHnH49PQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790088003;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-ZohoMailClient;
 bh=dlFi6xsq/apBmSJ0y1dIDl4wDJqhWIyq/S81uPzW3HU=;
 b=dtbrEA9t7FYDrptSeWn9t+hUyq3Q/nM+wKtcqSxFYwloTebnnkUaL3+X+I5zdr7WXO0D
 yKBjlQ0x4O/0BqGhp+H5TK6lmni2ffpkZ9fVdQzhmfDvXHwNLlRYVjp7Gd13VSNxFo7Kb
 Lwzdb/gYeYQz601PKBqmDRiWhcobDG9JcaSGL6Oqzx69EXj+l6i68rIaRQos9rlQ1j9LH
 z3hAe55tB49yiI3DpkEnjr+s/zXi0CyrCvVxDNk6Ndvu2/xDlyyUhPS5JVB8kkkonpHiq
 UzqEitveEEtGc6n3em1FalWUMkWyylZElEI5j1Y5u3RzSfGNQo5XsY19htzGedXGKTQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=none header.from=pigmoral.tech; 
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=hVj1XrQ4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=hVj1XrQ4
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68E1B60674
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790087962; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BY5g/Zu94Vekz/ks4ddxQGwGynMajiy5R4u4n4IXu15NWl0dUjWyLXfGAIe6D02xnogx5ruQUc0rg5+vUilJkWBFBtvSk7MJDnmMRsRHou8wdBmIOhZ1Q9V3qgffBh88GS+frhIUi/caaAjGHj6JIPnbFS+V5nV2xM398mofrks=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790087962;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=dlFi6xsq/apBmSJ0y1dIDl4wDJqhWIyq/S81uPzW3HU=; 
 b=MylDaQi+VllRaNYMvl+E1go2azL5nEjSb2cNIB5dyHXhColDmBKnQGo0ib26VUhNE1AYmMmjbyyuAXRlIMd3lLkcTRZUi47kLhiFxptn8y6W1zCU/mZ0o5DZyARIf34Rz4rOI6Vj6mvy3hnOOABgc1LaAjgL4yyoH2Ad1gBiEwM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790087962; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=dlFi6xsq/apBmSJ0y1dIDl4wDJqhWIyq/S81uPzW3HU=;
 b=hVj1XrQ4b3XpoCx4zRmD7RtS+WDkoGoccNTG6zlgRYLB972Ll8nt7U5WRBrsxYk6
 nG/v91RnMtr1cj/ryP5UAgKo1jir+dZ/X8vJ5LFhhgklCqtpp33Y3YYEWhoDaT038pk
 IG/YfBXKthuEiSCRAvR2a5hFmuZlNItBT8jhNZJU=
Received: by smtp.zohomail.com with SMTPS id 1790087960304796.8488496559819;
 Tue, 22 Sep 2026 07:39:20 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 22 Sep 2026 22:38:45 +0800
Subject: [PATCH 1/3] riscv: Fix up the OS memory nodes from the DRAM banks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-riscv-fixup-memory-v1-1-83b3166320e6@pigmoral.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2325;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=LswiawVHJhxC0gAWNMAr7BUNq5ugclaVvuraRfzVgDU=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLI2TWZw3Ki569kZ49qupUbzrPbW/e4uLu6Z/ud6lPh7+
 wR73j13OkpZGMS4GGTFFFm4/MX/WevwfDsi0HofZg4rE8gQBi5OAZhIAgvDPxOm21snNBQ5XWD4
 PzPk3Lu7H/eKiau+5JyifkJcpVdD7jnDP82iILGq2qzpjev6y9abGpqyi5X4XSvI7a9VVPaWqf/
 MAwA=
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

The device tree loaded for the OS may contain a static memory
description that does not match the layout determined by the firmware.
RISC-V currently relies on board-specific fixups to pass that layout to
the OS.

Update the OS memory nodes from gd->dram[] in arch_fixup_fdt(), as ARM
already does. Platforms that need to keep the memory description in the
OS device tree unchanged can disable CONFIG_ARCH_FIXUP_FDT_MEMORY.

Disable this option for the generic Microchip MPFS configuration. The
supported Icicle Kit device tree uses multiple memory nodes, whereas
fdt_fixup_memory_banks() writes all banks into the first node and leaves
the others untouched. This would duplicate memory ranges, so preserve
the existing memory description for this configuration.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/lib/fdt_fixup.c               | 16 ++++++++++++++++
 configs/microchip_mpfs_generic_defconfig |  1 +
 2 files changed, 17 insertions(+)

diff --git a/arch/riscv/lib/fdt_fixup.c b/arch/riscv/lib/fdt_fixup.c
index 6dfd1a2d5b8f..0786a03e58cd 100644
--- a/arch/riscv/lib/fdt_fixup.c
+++ b/arch/riscv/lib/fdt_fixup.c
@@ -160,6 +160,22 @@ int arch_fixup_fdt(void *blob)
 		return log_msg_ret("could not set boot-hartid", err);
 #endif
 
+	if (IS_ENABLED(CONFIG_ARCH_FIXUP_FDT_MEMORY)) {
+		u64 start[CONFIG_NR_DRAM_BANKS];
+		u64 size[CONFIG_NR_DRAM_BANKS];
+		int i;
+
+		for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+			start[i] = gd->dram[i].start;
+			size[i] = gd->dram[i].size;
+		}
+
+		err = fdt_fixup_memory_banks(blob, start, size,
+					     CONFIG_NR_DRAM_BANKS);
+		if (err)
+			return err;
+	}
+
 	/* Copy the reserved-memory node to the DT used by OS */
 	err = riscv_fdt_copy_resv_mem_node(gd->fdt_blob, blob);
 	if (err < 0)
diff --git a/configs/microchip_mpfs_generic_defconfig b/configs/microchip_mpfs_generic_defconfig
index e3d794f08b9d..bd62f630828e 100644
--- a/configs/microchip_mpfs_generic_defconfig
+++ b/configs/microchip_mpfs_generic_defconfig
@@ -15,6 +15,7 @@ CONFIG_RISCV_SMODE=y
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_DEFAULT_FDT_FILE="microchip/mpfs-icicle-kit.dtb"
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=282

-- 
2.55.0

