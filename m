Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AE4EE4993
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 13:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8985586FF7;
	Sat, 19 Aug 2023 15:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qNgxluXP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2733F87005; Sat, 19 Aug 2023 15:12:34 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C8B7807B4
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 15:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B8E5A4009F; 
 Sat, 19 Aug 2023 13:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692450751;
 bh=op3fKsAfZAZn2BT/W/PQjJdOLuv1GdXLEKjcLnedmTs=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=qNgxluXPk7mvKTVYiWYGJqejVRGYGm8CZrj+NxYgaKSzN+Wh4WBPHCkjOi/+Pno+Z
 q0/IC1SueKZWoX8RceXmcPvZ07Of96EhdRwmfxU3rn/zHW3KMLw8dEKo5JUfLz2yku
 kV7kjpIL+x7guZq8asizYQPd9qtVBIwubMVa+rfWnvClCVtlCsnYvyUl74JBA2eSPe
 RDVMsc0LWcJeYp/YoYwwY4q2LjIQN6sBy26nsN5IzQKQMTknG9TDWUhCCet3JQcSvh
 fs20YMgZ3OLjUEz4+tGRKCYQYOxWEJF7Qc+qEzhHCq6j4ebwQKPPZeSIqJ5nfk4w3T
 6GVK8fPCi/gxA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Anup Patel <apatel@ventanamicro.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] risc-v: implement DBCN based debug console
Date: Sat, 19 Aug 2023 15:12:48 +0200
Message-Id: <20230819131250.10251-1-heinrich.schuchardt@canonical.com>
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

Currently we only offer an SBI based debug UART for SBI v0.1.
With OpenSBI 1.3 the Debug Console Extension (DBCN) has become available.
This allows us to implement a debug UART in a device independent manor.

Heinrich Schuchardt (2):
  risc-v: implement DBCN write byte
  risc-v: implement DBCN based debug console

 arch/riscv/include/asm/sbi.h |  1 +
 arch/riscv/lib/sbi.c         | 16 ++++++++++++++++
 drivers/serial/Kconfig       |  3 ++-
 drivers/serial/serial_sbi.c  | 19 +++++++++++++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.40.1

