Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A84606A92D
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UKR62GR6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=Q+8EvuHW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8563F60877;
	Thu,  5 Nov 2026 16:42:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z2IVgahsytUd; Thu,  5 Nov 2026 16:42:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F266B60865
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793896961;
	b=FGzk8AXm6VC+bNGX58qxecxi3HiESzHwP3f200KO8G7iM0UYVKEtoK1ivQ/+7X35B3UK
	 JawYY+mz8YwgLlJ03LvBDsXL25hhalKmsU2XYAtzc0G0nbEnnK4bxSLC59Ql6lexXCYZP
	 q2V1o5fH4Gk6cbkwyNuX7bFhkLOzCk8U6Jttb+stNTXq8EMymVPv/FOYVuQawSc22Xgep
	 1/hL283j6/LRVu3Zs3QAW2xT90mOOOB56izOVb2Qoz4lignPLzS7DYsVLoILidS5k10ZL
	 Ws2R/H+VKD0xKd6JDw4+B49YLMcyzccSxrhaKAzUKrxa5DsVw8d+2b++TQtiMI4P8FA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793896961;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jVG96Qs1SlGCIYLj7/FdosVCyjyLkYhlnyjQU2SUAvo=;
	b=DfhRz6aJOsb8ICueo4nJ4IEiaQKMb3baUDi4nY8agR5hhPanTlgUgVMS3cwtngiH0gni
	 TLeBMlDo9fesmMgyNCX3Wa9M3VXnI04AV8MA6hFUI+wGTLn8PGIrbyJ7xpWZ/I2fsqekb
	 qAJozWXRedE6SwAQtfk2x/3gNatMR0k9syd/MLFhVDanjBPi1mb/8GX4KdDPiGnRulSpP
	 Z5Xc59hz35t5xBloDe7AS04j8J7LsCp8HO+nb4f3WyxUwO2ZwrZuNtRkAwWvcm0sN80OY
	 aOernRN2XE1NNx8E2X53sPNpTmhuDseXUr8iNb2yS+GD6MntKM2AWQiTfTWJn1k9NMw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793896961;
	bh=jVG96Qs1SlGCIYLj7/FdosVCyjyLkYhlnyjQU2SUAvo=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UKR62GR6nQ18aPgAqJcb4cYyi0md4cqVI4IKXRV3PLLiaHQpd/jyCwffaPmXEc0gO
	 3VHHNLtzE8v6Nv4rX+2ZGTOZkS9PqejW5kMsI4IpSGejU6ebFuohoY6hpKXdutAkqK
	 rvkyFJnC2lhhAlw5y0AwQZcCxvsTQRx7DSzYDuZ7FfEv59mKXik3PKwSP+wu14mTdO
	 doZ41mda/1ECSzF8tf3YjY0ej9/yykwH3ibrN7tpQawe7aXJWxRJeMd9Ps6DIkCl0z
	 +bpzqUM/9XsML+GJTA+/v40fnGFd4452O7UdRWqyziEri8GKMMuiHMcqc+U+wLpmsM
	 iVZ5qkQu5HK+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F266B60865;
	Thu,  5 Nov 2026 16:42:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A62CA235
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8981F80ACC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:42:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0bdgJpLoHSx4 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 16:42:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 20E67808D2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=Q+8EvuHW
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20E67808D2
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:42:33 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=Q+8EvuHWJkBlawp2IZFWMY0gbXjY/4kfAun2YWy6l13N238EB2NrOLpNB9HVbTT1Ngc9Vm9PJFJqUZaMvE9aFisLoQqm5ZMEgnHdFr3pvtIFy9OwjKo4MhYqlSh2lrJN0CKckyOGXmNwEkS5dFDqxK9+Uag0RIM8dZAej1CjI+g=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=jVG96Qs1SlGCIYLj7/FdosVCyjyLkYhlnyjQU2SUAvo=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793896924866302.3402541915814;
 Thu, 5 Nov 2026 08:42:04 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH 0/5] riscv: spacemit: k3: Add SPL LPDDR5 initialization
Date: Fri, 06 Nov 2026 00:40:38 +0800
Message-Id: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NSQqAMBAEvyJzNpDEBfEr4kGTUUfBZaIiiH83L
 seC6uoTHDKhgzw4gXEnR9PoQYUBmK4aWxRkPYOWOlVKxmKIhLUssiTNElMZ2UgNXp4ZGzreUFF
 +7La6R7M+699gXDb/sP7add2mYybGfwAAAA==
X-Change-ID: 20261104-k3-ddr-85685cac0f02
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@kernel.org>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, E Shattow <e@freeshell.de>, 
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2799;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=7DytqnWqvuWWZADc3CcQUphXvQQd5Ej3e8atHiKSttQ=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLLebNylzh775KJOw8nMjyHle5mYzJKvfqn91htcbWbpK
 H0z5J5CRykLgxgXg6yYIguXv/g/ax2eb0cEWu/DzGFlAhnCwMUpABM59Yrhf2XRZvGTR1/wRxw0
 UqtbPa99jy5nRuDmi23Ft6V7Ch3P/2VkeLVA74b5Bra6vhkGXGpveC9ddog6nrtHb8HCctv2Pms
 vBgA=
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add initial SPL support for LPDDR5 initialization on the SpacemiT K3
SoC.

The DDR driver follows the vendor initialization sequence, selects a
memory profile using the DDR part number read from the board's EEPROM,
and configures both DDR controllers and PHYs to perform LPDDR5 training.

Loading the next boot stage is not implemented yet. SPL currently
returns BOOT_DEVICE_NONE and stops with "Unsupported Boot Device!"
after successful DRAM initialization. No LPDDR4X boards are currently
available for testing, so LPDDR4X support will be added in a separate
series in the future.

Tested on 8 GiB and 16 GiB Pico-ITX boards and an 8 GiB COM260 board by
entering BootROM USB download mode and running:

fastboot stage spl/u-boot-spl-mkimage.bin && fastboot continue

---
Junhui Liu (5):
      ram: spacemit: Add DDR driver for K3 SoC
      riscv: spacemit: k3: Add SPL initialization support
      riscv: dts: spacemit: k3: Add SPL device and image descriptions
      configs: spacemit: k3: Enable SPL support
      doc: spacemit: k3: Add SPL build instructions

 arch/riscv/cpu/k3/Kconfig                      |    6 +-
 arch/riscv/cpu/k3/Makefile                     |    1 +
 arch/riscv/cpu/k3/spl.c                        |   52 +
 arch/riscv/dts/spacemit-k3-binman.dtsi         |   24 +
 arch/riscv/dts/spacemit-k3-u-boot.dtsi         |   54 +
 arch/riscv/include/asm/arch-k3/csr.h           |   20 +
 arch/riscv/include/asm/arch-k3/spl.h           |   11 +
 board/spacemit/k3/Makefile                     |    5 +
 board/spacemit/k3/spl.c                        |  127 ++
 configs/spacemit_k3_defconfig                  |   22 +
 doc/board/spacemit/spacemit-pico-itx.rst       |   12 +-
 drivers/ram/Kconfig                            |    1 +
 drivers/ram/Makefile                           |    1 +
 drivers/ram/spacemit/Kconfig                   |    6 +
 drivers/ram/spacemit/Makefile                  |    3 +
 drivers/ram/spacemit/k3/Makefile               |    9 +
 drivers/ram/spacemit/k3/k3_ddr.c               |  134 ++
 drivers/ram/spacemit/k3/k3_ddr.h               |  169 +++
 drivers/ram/spacemit/k3/k3_ddr_ctrl.c          |   73 ++
 drivers/ram/spacemit/k3/k3_ddr_lpddr5.c        |  538 ++++++++
 drivers/ram/spacemit/k3/k3_ddr_lpddr5_tables.c | 1668 ++++++++++++++++++++++++
 drivers/ram/spacemit/k3/k3_ddr_phy.c           |  149 +++
 drivers/ram/spacemit/k3/k3_ddr_profile.c       |   54 +
 include/configs/spacemit-k3.h                  |    3 +
 include/soc/spacemit/k3-ddr.h                  |   13 +
 25 files changed, 3150 insertions(+), 5 deletions(-)
---
base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
change-id: 20261104-k3-ddr-85685cac0f02

Best regards,
--  
Junhui Liu <junhui.liu@pigmoral.tech>

