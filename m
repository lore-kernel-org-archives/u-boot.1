Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BBF606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mYzpZCHu;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=YnxLJdxa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52358810AC;
	Wed, 18 Nov 2026 01:26:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EfY84oVLLWOy; Wed, 18 Nov 2026 01:26:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B120981132
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965178;
	b=XgITOcXkS/aSbE3qlhzlN7ymh1rVRyFBgyLakePCp6iecfWEXq9xfOX0q7yd1NwSQDEs
	 xsCPGaggCx781CTAFkv5auL+py8RtEJLW9jVlo0iyh/C7nejPZsmKKdk+XnowrrjnOHDy
	 5CluVsWj1jDU/ELY0m+WP7MIooKwybRs0QtwsmJl5IQK5RCZke1Xq9wBqPbJWq7TkrL2c
	 qU3sc21Ds7pI+3P99el/3W3nRdlKwcOv9lqygctQkD+JvZ5olMXs8VdQBZs6/sFhoy6nM
	 IbzyauzPU3OBOIX56bKoC0UL1/i5xFJogZKJPvIcZxbasWQlyWWIw9LTFdOi95+Wb3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965178;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=R75D+nd+JGab0PxMSqRcXtkk4DEVX8QwUZYmlRjs5os=;
	b=aMdytfC3QgZL5Lae9PUMapPomSUr78sR8aP4JMnaJnyXZEdQRXy+wUZiJE+1ZNGjRLGq
	 tVcsPXNNY9hwBU7RhPzGdpemd1kW9UREiUgHOkgnLgByDnqXJVLtrwo8nSYqfXFOVWrrd
	 aCftFKb2Evx/LuF7vd2NB5IMFMUSAjVlgTk7NhZklDFW9+uZQDgLEb/EHeePPmuKu4k5y
	 fLaw9nFMbKuQ/6OUfwlxovCqMxoDwhvkrSdMiZT5Xu4v39xfdTc9ELSGBmuJKK0U0sKec
	 pt/tx/YfnvsaxeinshmiDUaaspHGpAyvDAmbeuT6RDBPZIvlKsxoEgY/m/Ig+mEI2cA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965178;
	bh=R75D+nd+JGab0PxMSqRcXtkk4DEVX8QwUZYmlRjs5os=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mYzpZCHuSDlZlFNYYtobyOpKHVXpLOX7BTbJfAWyC0iDtwGHCIozPB9DnQmD3hLau
	 If3JJOZscIHky1J4BMKqAWbpWit3XNjEP0kh/SorvYz3zHC4u2u9vnvn447J+sxWwe
	 K0sJ7n6du1uX2dA3vaFWh0JvKCU0pnJ7QAzWjQSgG84d9wezwe+bbaCdBLm6eHXPTO
	 6sV42B8Tfw/I3li5Qfq0UABZWTA56dk83cHkWtl6Wn+ulwNTKtokdgCKeUBELOlfDw
	 VtN8ahRCpjLBF0i5vzxv0BWF03zkn1XpuGv4mvsBzYFKD69xza5AzVGnC7OpVQ7My5
	 jK6n2YQiRZtUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B120981132;
	Wed, 18 Nov 2026 01:26:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 871901A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84B8E605DE
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:56:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jmzeL18d4drs for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 23:56:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 56F1F605DA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 17 Nov 2026 23:56:39 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=YnxLJdxa
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=774fa3f08=romain.caritey@microchip.com; receiver=<UNKNOWN> 
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56F1F605DA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1794959799; x=1826495799;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Y3SqadZXtq57FCwBd6cahhDDbmUIiT6OWwIWx3sguTA=;
 b=YnxLJdxaiLqvqGrASEIOtZUY3ACceYJoZMYA+q4pkSaCssTHDjqwdknq
 U4Fa3DVxJ3CHhW1b7zqTmTOJlyoFS1ZRcmRX4srSJ7eqhCX/wKjnng99V
 zYwOA2oIjMVmUYnA5OCnxLKuNo3Aqi5SVdXsiN2tm+/N9CqI02F/obGdj
 R7vo0NODUG1HBCgnX/K02Ymtmnj86nG+BkfyRwzXVMNE1oJ3uACe8Iz5M
 c87SGVT5VM3u5bEP81obI0g3hW45NvuUorVsXgl2DveJawXQaszDBEb+j
 DbFBMVbTJ161pqJeEbtQtPIjXZsJ3W9+qmFfQtqFMXxt/yJOSeigqaNbt A==;
X-CSE-ConnectionGUID: d2LkCShuQd2JNKxzoVVg0Q==
X-CSE-MsgGUID: FSljIGgRQIuqe5DExAFdlQ==
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="77405146"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 17 Nov 2026 16:55:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 17 Nov 2026 16:55:34 -0700
Received: from bby-cbu-c71245.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 17 Nov 2026 16:55:33 -0700
From: Romain Caritey <romain.caritey@microchip.com>
To: <u-boot@lists.u-boot-project.org>, Leo Liang <leo.liang@sifive.com>, "Tim
 Ouyang" <tim609@andestech.com>
CC: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 <charles.perry@microchip.com>, <mamemaria.mbaye@microchip.com>, "Romain
 Caritey" <romain.caritey@microchip.com>
Subject: [PATCH 0/4] riscv: support running U-Boot proper at any address
Date: Tue, 17 Nov 2026 15:54:09 -0800
Message-ID: <20261117235433.3601945-1-romain.caritey@microchip.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 18 Nov 2026 01:25:48 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot proper on RISC-V must currently be loaded and run at
CONFIG_TEXT_BASE. This series adds a POSITION_INDEPENDENT option, as on
ARM, so that it can be run from another address, for instance when the
previous stage does not load it at a fixed place.

This is needed for the Microchip PIC64 SoC [1], which has two
clusters running U-Boot from different addresses. With this series, a
single U-Boot build can run on both clusters, instead of one build per
cluster with a different CONFIG_TEXT_BASE.

Patch 1 replaces la by lla in start.S. With -fpic, la loads the address
from the GOT, which only holds the right value once relocations have
been applied.

Patch 2 adds a checkriscvreloc build check, modelled after
checkarmreloc, to make sure only R_RISCV_RELATIVE relocations are
generated. This is the case for every configuration with -static -pie.

Patch 3 moves the .rela.dyn processing to a subroutine and drops the
unused symbol-based branch, so that it can be called twice.

Patch 4 adds POSITION_INDEPENDENT, INIT_SP_RELATIVE and
SYS_INIT_SP_BSS_OFFSET: start.S fixes the relocations for the run-time
address before any C code runs, including board_init_f_alloc_reserve()
and harts_early_init(), and computes the early stack pointer from
__bss_start. The first hart to enter _start applies the relocations,
the other harts wait for it to be done.

Note on Kconfig: POSITION_INDEPENDENT, INIT_SP_RELATIVE and
SYS_INIT_SP_BSS_OFFSET are now defined in both arch/arm/Kconfig and
arch/riscv/Kconfig, with the same meaning but different dependencies.
I kept them per architecture to keep this series contained to RISC-V.
They could be unified in a shared place (for instance a common Kconfig
with per-architecture dependencies) as a follow-up, if preferred.

Tested on QEMU virt with OpenSBI fw_jump (S-mode) and in M-mode, with
1, 4 and 8 harts, using qemu-riscv64_smode_defconfig and
qemu-riscv64_defconfig + POSITION_INDEPENDENT:
- loaded at CONFIG_TEXT_BASE (no fixup needed),
- linked at 0x80400000 and loaded at 0x80200000,
- linked at 0x0 and loaded at 0x80200000,
- M-mode linked at 0x80100000 and loaded at 0x80000000.
All reach the prompt; bdinfo, env and bootefi hello behave as with a
non-PIE build. A harts_early_init() calling through a function pointer
in .data, which crashed with the fixup placed after it, now boots.
Builds without POSITION_INDEPENDENT are unchanged.

Also tested on hardware, on a Microchip PIC64 HPSC [1] board in
unified mode with 8 harts.

Romain Caritey:
  riscv: start.S: use lla instead of la
  riscv: check that only R_RISCV_RELATIVE relocations are generated
  riscv: start.S: move .rela.dyn processing to a subroutine
  riscv: add support for POSITION_INDEPENDENT

 Makefile               |  10 +++
 arch/riscv/Kconfig     |  35 +++++++++
 arch/riscv/config.mk   |   5 ++
 arch/riscv/cpu/start.S | 163 +++++++++++++++++++++++++----------------
 common/board_f.c       |   3 +
 5 files changed, 152 insertions(+), 64 deletions(-)

[1] https://www.microchip.com/en-us/products/microprocessors/64-bit-mpus/


base-commit: 6201222134cd704b5717211fc917e2ca6263577a
-- 
2.47.3

