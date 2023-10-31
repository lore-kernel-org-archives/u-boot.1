Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656F5C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 12:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 886A887C8F;
	Tue, 31 Oct 2023 13:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mAz1fkgY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96FD687C9E; Tue, 31 Oct 2023 13:56:12 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B5487C76
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 13:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [159.148.28.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E9B8C3F5FD; 
 Tue, 31 Oct 2023 12:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698756964;
 bh=4JgGYH3q0C3bg7IkG2xauPuA6tc11SfQkJxXG2N1tCo=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=mAz1fkgYsxRaeRq4Nx0K05QbvszLhp8R2vpWnyk5Z2RsEh58uPoAgwLJ2CGr3PrvS
 xJ8VlXkvSNeFMY199A3Ni9XUGKVV5pVAsHiN7CXAc7rtBUhAbKHCkeWQlVD5jfk8W/
 k+GBBPYDa4SjOPl0ywr7elIAePcuptkCj+4xZmXpNmya+1xHQa8y3pHFlYfAtSwSWb
 kOfmkVvkCMB+fsyre+rTqzbviDsxB88KxUpg8WNl7pUx8gI5PRoI4zVbjQNpIp9vdP
 Ex6ApPBHAJg2dhEnXZi+DgVdxgyw8daZPDIQvtlOO6LHCi8eVar6+adiEom3xmwwNM
 SflSdi5Iwzd2g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Date: Tue, 31 Oct 2023 14:55:50 +0200
Message-Id: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR. It
provides an interface to a physical entropy source.

A RNG driver based on the seed CSR is provided. It depends on
mseccfg.sseed being set in the SBI firmware.

If the seed CSR readable, is not determinable by S-mode without risking
an exception. For safe driver probing allow to resume via a longjmp
after an exception.

As the driver depends on mseccfg.sseed=1 we should wait with merging the
driver until a decision has been taken in the RISC-V PRS TG on prescribing
this.

Setting mseccfg.sseed=1 is queued for OpenSBI [1]. This has been discussed
in the RISC-V Boot & Runtime Services TG. Standardization has to be pursued
via the upcoming platform specification.

A bug fix for QEMU relating to the Zkr extension is available in [2].

A similar Linux driver has been proposed in [3].

[1] lib: sbi: Configure seed bits when MSECCFG is readable
    https://patchwork.ozlabs.org/project/opensbi/patch/20230712083254.1585244-1-sameo@rivosinc.com/
[2] [PATCH v2 1/1] target/riscv: correct csr_ops[CSR_MSECCFG]
    https://lore.kernel.org/qemu-devel/20231030102105.19501-1-heinrich.schuchardt@canonical.com/
[3] [PATCH v4 4/4] RISC-V: Implement archrandom when Zkr is available
    https://lore.kernel.org/linux-riscv/20230712084134.1648008-5-sameo@rivosinc.com/

v3:
	Add API documentation.
v2:
	Catch exception if mseccfg.sseed=0.

Heinrich Schuchardt (2):
  riscv: allow resume after exception
  rng: Provide a RNG based on the RISC-V Zkr ISA extension

 arch/riscv/lib/interrupts.c |  13 ++++
 doc/api/index.rst           |   1 +
 drivers/rng/Kconfig         |   8 +++
 drivers/rng/Makefile        |   1 +
 drivers/rng/riscv_zkr_rng.c | 116 ++++++++++++++++++++++++++++++++++++
 include/interrupt.h         |  45 ++++++++++++++
 6 files changed, 184 insertions(+)
 create mode 100644 drivers/rng/riscv_zkr_rng.c
 create mode 100644 include/interrupt.h

-- 
2.40.1

