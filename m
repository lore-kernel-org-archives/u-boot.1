Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9947B606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q1vouPM2;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=0OyEu9qa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66CCC80E61;
	Mon, 23 Nov 2026 11:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nzFvdOmAA-8N; Mon, 23 Nov 2026 11:26:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D03B780E3E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795433199;
	b=T+bRiyB8fx8f7oFgB5VXy8e0zLlu6BSlNnZCu99pzwAz5lII1Po+c7cb/OxDS0Cc0n5D
	 ew0m2mrwUydyyiZ/InsteSyASzNdOxMxS5J0HMrFb1WhZ7Ny9SlA7Rtd59I23iLU75Ojk
	 UBlwhEoJhhYEBYvTOMIqX5AHfd6mzLd6h7ILYf0tau/pFcbdwN6u78lpepG50IjKMr5Wm
	 P3mBqdw46xlSCO+ipMt3ZKy41fwqlaJcci0HDxnrVGtioTXuN7LoZViRDamOOSM5AKcqc
	 2155H1+iqba8i5uOZISX1xwyDfjo8/CWSSA+gz+8jjhbABPIl6oKV0N/KA51Bj1xRgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795433199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=q8DB6jJgfuloUOi//YrKIyJDVq3SV2pT64k82wRg+eI=;
	b=QCE4ZJs1R42tJVALXXuMfuePuY3dLEQm0ZxBjJycJaKHd9WvYJyuRXeNyl+MQ91HvqpT
	 Z7E6lp72KFyJCSv30Q0KPT9cDQptr2WsRCOJhBKl6dzhwGS6YwAAR0j5T5osNWZ6F0QTn
	 lfml1Xx7lM3zWjyYzdQwKabl7e49iZ+C7DcmcdWpj1fwP/NkbzewVop2eS7ZtsIEP29DM
	 QuhDuOi9TXGfwGBPQsklmUvhOy43Gk3sxxDvtrRYI/XW/2EimMby7QqGg8SgYyyynqs2A
	 VvhhxgBFIudYUjWu9VHxfUQ8NbG6n2TrqWywf+oGcFQEl/V8089SEHU+ll10miQHeDg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=0OyEu9qa;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795433199;
	bh=q8DB6jJgfuloUOi//YrKIyJDVq3SV2pT64k82wRg+eI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q1vouPM2ks+6qx6I6Jn4OREhHtcoVyJkIDZzKEUWd9RaHI2lbcA8yMF6XlFmRXwJ0
	 obTkHvAO719sqTVcti1DjseV93ihByW1h8ssI8KxZfsF3V9Ed8xIANhF5ftmjqnZv/
	 4FWahX+orwzPvtHCZbhyxRUWYy5aerjgG8j7kQRs96P3GScCYRsJ+Va8IdzIZi8wr4
	 oRGjKf43++D3iHknkfaQBzj7qRqg2WPdb7T8jIEZMI32GHTvUPSmbqFKwGmDcQKHjo
	 6eGUkfM3Xpup0RMMzVTdl/EWSlCrU6fIcoEFTODdhE8IvLozqJmaGSiqKMBSQhYYQd
	 P3xji7z7kz6Lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D03B780E3E;
	Mon, 23 Nov 2026 11:26:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D53CF79D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:26:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B779480E23
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:26:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RRONpsPfRhOP for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 11:26:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 099F480E1B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=0OyEu9qa
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 099F480E1B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:26:33 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jY3YK63KczMlL1;
 Mon, 23 Nov 2026 12:26:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1795433189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q8DB6jJgfuloUOi//YrKIyJDVq3SV2pT64k82wRg+eI=;
 b=0OyEu9qa+IoJCyJWSz47rD2VL+b6Tn0xuCocZBVsD+Y030S8G0I9t1yCi51ZHHmYK4f8v3
 ijeUEs3KIfglkqfWqZZEPLnordOwqw9QByBHxPLv8UHnDF1iCKHrWQvliF00VaCpvejXDo
 Om6HA6tKU5yJxZhp5C6OlWIxfehhP4TOvl8+i86uT2qKFZJhc0Z0/f+s6DN44fQBzn7vBD
 +KJKXhrflzowHVNgARkqx/WMGqzvyrbzdAIzAcBlLgbNHGgHHpjxP2mbyxyrMVJVBYcacf
 IbSlSPGLDbkliJ4AcuZpSCSXyWO5PU8R592X2Rtgqn865GFXo/KHqFCXWbCBlg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Subject: [PATCH v4 0/2] arm: mediatek: run SPL and pre-relocation U-Boot
 with caches
Date: Mon, 23 Nov 2026 12:26:21 +0100
Message-Id: <20261123-std-upstream-mt8188-spl-caches-v4-0-521e424fd1ad@beckhoff.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOwWrDMBAE0F8JOldltbJsK6f+R8nBWq9qtXVsJ
 MWkBP97rbTQUgo+Dgxv5iYSx8BJHA83EXkJKUznLVQPB0FDd35hGfotCwSsFWAjU+7lZU45cjf
 KMbeqbWWa3yV1NHCS6CtsVI1GoxUbMkf24XofeD595XRxr0y5qKUxhJSn+HF/sKjS+x7TsDe2K
 AnSVcaCIacsqSfH9DZM3j/SNIqyt+CPqMDuiriJTUveabZAxvwj6l8i7n/U5aPpXAO9qQHqP+K
 6rp+kjbUVhQEAAA==
X-Change-ID: 20261027-std-upstream-mt8188-spl-caches-2f4271625329
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795433188; l=4443;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=jVSFeeqdtjWVeRuMozJsJtIj6aUD/6mB1/FaDbA7ZGA=;
 b=jPkRH22jS4DG0pn/NkY7bxO+7tFnuQu339Hbspe11jdhG3FZR55wc77iENnihFi2rrKdgUl3F
 OkMdE3/0Gc+Ctn4Drfkq6r76nyzvaltQuHBhxp7u5l5RiD3p8yFpCXY
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jY3YK63KczMlL1
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Running u-boot without caches is slow, especially if using rsa
signatures. This series turns the caches in u-boot spl and proper on
early.

Measured on an MT8370 module (Beckhoff SM0101, not upstream yet) with TF-A
BL2 as DDR loader and SPL loading a 2.7 MB FIT (BL31, OP-TEE, U-Boot,
SHA-256 hashes) from SPI NOR:

SPL, from its banner and from selecting the FIT to the first BL31
output:

  caches   signature   SPL total              FIT -> BL31
  off      -           848.3 / 848.6 ms       792.3 / 793.1 ms
  on       -           95.7 / 118.8 ms        95.7 / 118.8 ms
  off      RSA-3072    1903.6 / 1903.0 ms     1836.7 / 1837.2 ms
  on       RSA-3072    128.3 / 143.3 ms       128.3 / 143.3 ms

U-Boot proper, from bootstage marks before each initcall:

  initcall          caches off       caches on
  initf_dm          349.8 / 349.7    4.6 / 4.6 ms
  serial_init       204.7 / 204.7    3.0 / 3.0 ms
  dram_init         162.2 / 162.1    2.3 / 2.3 ms
  relocation copy    22.0 / 22.0     0.4 / 0.4 ms
  board_init_f() to main_loop()
                    819 / 819        87 / 87 ms

Autoboot prompt after power-on, which includes a 5 s USB download wait
in the BootROM:

                    unsigned FIT            RSA-3072 signed FIT
  without series    8369 / 8373 ms          9447 / 9437 ms
  patch 1           7634 / 7633 ms          7659 / 7658 ms
  both patches      6901 / 6903 ms          6933 / 6932 ms

The module tests used a v2026.10 based tree with the Genio SPL support
cherry picked.

The early page tables (32K) are at a fixed address, MTK_EARLY_TLB_ADDR,
instead of in a static array. On MT8188 the default is 0x401f8000, the
last 32K of the first 2 MiB of DRAM, as David suggested.

I used an LLM to help write and test the patches.

---
Changes in v4:
- Rename the options to MTK_EARLY_DCACHE and SPL_MTK_EARLY_DCACHE, the
  functions to mtk_early_{enable,disable}_dcache() and the size to
  MTK_EARLY_TLB_SIZE (Carlo)
- Add Reviewed-by and Tested-by tags
- Link to v3: https://patch.msgid.link/20261120-std-upstream-mt8188-spl-caches-v3-0-b5ab70d56006@beckhoff.com

Changes in v3:
- Add MTK_EARLY_CACHES and SPL_MTK_EARLY_CACHES, enabled by default
  only on MT8188
- Use GPL-2.0-only
- Explain the early page table size
- Explain the I-cache handling around cleanup_before_linux()
- Put the early page tables at MTK_EARLY_TLB_ADDR instead of into a
  static array, so we don't increase binary size
- Link to v2: https://patch.msgid.link/20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com

Changes in v2:
- Make it generic for MediaTek ARM64 instead of MT8188 specific
- Put the early page tables into a static allocation
- Enable the I-cache in SPL as well
- Turn the MMU and the caches off with cleanup_before_linux() before
  leaving SPL
- Use if (IS_ENABLED()) instead of #if
- Link to v1: https://patch.msgid.link/20261030-std-upstream-mt8188-spl-caches-v1-0-b45905cb19c1@beckhoff.com

To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Cc: Carlo Caione <ccaione@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Chris Chen <chris-qj.chen@mediatek.com>

---
Steffen Dirkwinkel (2):
      arm: mediatek: enable the caches in SPL
      arm: mediatek: run board_init_f() with the caches on

 arch/arm/include/asm/arch-mediatek/misc.h |  3 +++
 arch/arm/mach-mediatek/Kconfig            | 25 +++++++++++++++++++++++++
 arch/arm/mach-mediatek/Makefile           |  1 +
 arch/arm/mach-mediatek/cpu.c              |  6 ++++++
 arch/arm/mach-mediatek/early_caches.c     | 31 +++++++++++++++++++++++++++++++
 arch/arm/mach-mediatek/spl.c              | 14 ++++++++++++++
 6 files changed, 80 insertions(+)
---
base-commit: 810d7132c6f03430588ff45dacf62e62f3906598
change-id: 20261027-std-upstream-mt8188-spl-caches-2f4271625329

Best regards,
--  
Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

