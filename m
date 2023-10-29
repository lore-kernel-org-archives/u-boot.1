Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9FEC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 08:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 773C28743A;
	Sun, 29 Oct 2023 09:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZobItus1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D501A8789B; Sun, 29 Oct 2023 09:46:01 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D356E87286
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 09:45:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 19A983FB49; 
 Sun, 29 Oct 2023 08:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698569158;
 bh=VcR4ySP5fDs3HMT8N61V073Uw58uedJ26+9wMWwA8A0=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=ZobItus1g441oA+0/O/KUamTC7aQcJwsezi2N3hslcgiG/jXUBSlFv7xRykygn7qU
 kGRF0FwiEm2JLCv9Ij41uZwvrUjq87UzmWQ+Fb3NF7+llkZSU/Tm+jvFV3MKTu9RjD
 RK7llBNqQY3jPWzmp5mDBgtYrf+VfN2przaezGdEUvAsaj4u8JkGxWEYCO2CKBpKD2
 NST9uiUsgsIdZXx4qSdCgzsqOXLzkn1x6Yx/C6e5wf9jlCEblLgHS5Rc7AMkwKQe7g
 aeHbYdFiYjw2os9/mKcymac7aymGzuwf1NlwHvQO9IvUVmyy/2Laof2k2y/LFQoN+j
 Qelo5PgzUz7ng==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Anup Patel <apatel@ventanamicro.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC v2 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA extension
Date: Sun, 29 Oct 2023 09:45:31 +0100
Message-Id: <20231029084533.44607-1-heinrich.schuchardt@canonical.com>
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

Heinrich Schuchardt (2):
  riscv: allow resume after exception
  rng: Provide a RNG based on the RISC-V Zkr ISA extension

 arch/riscv/lib/interrupts.c |  13 ++++
 drivers/rng/Kconfig         |   8 +++
 drivers/rng/Makefile        |   1 +
 drivers/rng/riscv_zkr_rng.c | 116 ++++++++++++++++++++++++++++++++++++
 include/interrupt.h         |  22 +++++++
 5 files changed, 160 insertions(+)
 create mode 100644 drivers/rng/riscv_zkr_rng.c
 create mode 100644 include/interrupt.h

-- 
2.40.1

