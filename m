Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FD9C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 04:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227A3807B1;
	Fri,  6 Jun 2025 06:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="FZebYn7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5305E81E25; Fri,  6 Jun 2025 06:28:24 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78BAD800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 06:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 2FEFF25F3F;
 Fri,  6 Jun 2025 06:28:21 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LnJoK8uu3zf2; Fri,  6 Jun 2025 06:28:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1749184100; bh=9gYBFAaQXGCtqxgFKAQ0UDg9cQzDSsYV+4pFfp4M65c=;
 h=From:To:Cc:Subject:Date;
 b=FZebYn7gBpNkYG2033igEYyNPMWdhcBEPlv+eeIfP38x+nN+t7MQH6dMqLsGp0tQz
 vL9yQ1yfrQX27WbLokmLOUMCW+1YUyqZ68XMF+tPJaD3H0i9djWS+cTz7KmHrPZuND
 QRWpb7yPl2T8ETT5a2uacvHaocwT2/qt+kXnVBzCtN9tuJwCEh5DABVCPR6LnLkcoN
 Q+l6bIBSZ5xgBpgYSbaN6viplGRddlYDYt+WfkqJLy+RlLnuMhJowpNpmK7KsKYlSY
 TSdW9WbWaQSyEj/s1Upr7jbdg7o/sa17Vx+njowR3/Gpu2A19jKkMccuJGk1070qf5
 XWXRUFbPcJmyw==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Yao Zi <ziyao@disroot.org>, Maksim Kiselev <bigunclemax@gmail.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 0/5] Bring up secondary cores on Lichee Pi 4A
Date: Fri,  6 Jun 2025 04:27:59 +0000
Message-ID: <20250606042804.64311-1-ziyao@disroot.org>
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

TH1520 ships four Xuantie C910 cores, but only one of them is
automatically brought up by hardware on coldboot. This series adds IPI
support with T-Head C900 CLINT, setup CPU features to prepare for SMP
operation, and finally bring the rest three cores up.

Booted with the series, Linux kernel correctly shows and makes use of
four available cores,

	[    0.042371] smp: Bringing up secondary CPUs ...
	[    0.052448] smp: Brought up 1 node, 4 CPUs

This depends on v1 of series "Convert Lichee Pi 4A to use S-Mode proper
U-Boot"[1] to function correctly.

[1]: https://lore.kernel.org/all/20250530094851.57198-1-ziyao@disroot.org/

Yao Zi (5):
  riscv: aclint_ipi: Support T-Head C900 CLINT
  riscv: cpu: th1520: Setup CPU feature CSRs in harts_early_init
  riscv: cpu: th1520: Add a routine to bring up secondary cores
  riscv: dts: th1520: Preserve CLINT node for SPL
  board: thead: licheepi4a: Bring up secondary cores in SPL

 arch/riscv/cpu/th1520/cpu.c              | 29 ++++++++-
 arch/riscv/cpu/th1520/spl.c              | 83 ++++++++++++++++++++++++
 arch/riscv/dts/th1520.dtsi               |  1 +
 arch/riscv/include/asm/arch-th1520/cpu.h |  1 +
 arch/riscv/lib/aclint_ipi.c              |  5 ++
 board/thead/th1520_lpi4a/spl.c           |  3 +
 6 files changed, 121 insertions(+), 1 deletion(-)

-- 
2.49.0

