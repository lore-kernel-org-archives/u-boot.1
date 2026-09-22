Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BA7C982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 06:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BE8760674;
	Tue, 22 Sep 2026 06:10:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NImx6YvaieWo; Tue, 22 Sep 2026 06:10:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 247AC60665
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790057406;
	b=Y5iuq2i1agUws4lbJsf/QyYe+gSvUwteNNlnIrdbgeHxWPsX9DVQbo8mRYse0Q9QJ+Jk
	 bMxA6CQW/AVqQzeeN8YQMlA6AxCvgS4zcEBxQKbQ+2QJWgXhR/JgsRLx3P0UQJJa9iWBV
	 zTy7789FMnOZnQjoy0POM0szXAfD2YwPpPZSJEnhYh7HX1tTlIqB0L+p44J31lQ8ArjrA
	 SPSnkQaWfcZII5ECTQeizrL05cQOyLuFg7tHRhnhJZ6Ouv6Vj/+95kBfQ/Hd/RGbX+xst
	 aeW9wfgC9rZmTw11ESV3Fn/Xil0Ud9tV6rbz6oBmUURNxf5G5ia1MKvNRMZiw5j0yPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790057406;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=erqPaKnSDh4Wgg/bfmOvurVqo1WUHsHynVdix2PpByY=;
	b=SX3fIbrdPZGpmWzlKKNcojOMVgIhQ1lWzflhCNnv69QeIYd3MZJtvPUUjdSMT6pvMYCY
	 Fwao9cGZBaoXDPHpFmLK4ZNsgnAmbNHTgx0Zcmxvab1wCEX9jsZQ14/Qbgl65rNRAhpkN
	 1t8REmye5T8IWXFaXo5oIY/if44mIyhFV5UG/1yCklTFl8KkwsXCuwNVDSTy/AdS2zOBA
	 iEjgd8fQYtD4k2Gl6kYqgywFNwbuP24KNnanNyu9Pwzc5p65b7pTgqqRWpiTiFajaEw5Q
	 RIdnTqSI//1RhqhvBw5rP42Cf5pSNM0qjebXyd4muAb/DCJTMebp5XktNvuGiz/cZ4w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790057406;
	bh=erqPaKnSDh4Wgg/bfmOvurVqo1WUHsHynVdix2PpByY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1LnBPhBB6Mnb5FblHMiFk+rPfCaBaxJPz70vnlIB6ojttPuXeUPX2OKzNfVO7hJ8L
	 tkyiEaoG9Zg3KxZazHaNv/0zabVfPLfrpiikl6UzmpMysbUoS2CcU0Riq6/EEyejdT
	 vInwfswBccvKbs1FOkP9T98tokgK6SEyfPzih5BAyQKeqkMmzZS2pzKimWud1kDmyg
	 kfYPdJtpNl7N5wzsjQRodOcA/vJ6chkshiSweUl1dulpeGezBUsx5thjTPE893byb3
	 CQibZB7B40F4QtTstNOvSfPEdQ+XHyRPiacdpxBq1odKR7G053SnVEyPLAMJd8oeV5
	 KSAcdiix26YNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 247AC60665;
	Tue, 22 Sep 2026 06:10:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F9C2472
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0173D40779
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:10:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ns-JJpPHXE1 for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 06:10:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DFFE54076B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790057404;
 b=TF0RRkVuMn41unkPTpKai7TUS6rNpVrKAQ4p0KI6YU7iqmqxlcbDYekjTOVSv/WFEvVg
 4M+6NaEKQcoRulcHPEz6mP+NxNEja7aKF6mGA0ZJ5WgqWNpHByY9WhSVXLZcFK/FgZCBs
 bbJNEZS1Bm4MSQUAcZI+iYt45ocF42KMWtQSt/71+8qcK+Dt/meZX3aYZYnCKs0pg9peB
 SC/+ygbJR4+ccTbz318XV0Dn8CDekjnYat9YnHop8sH2xllpgP057tZ4tDLlt9MqSdIj2
 xlD37Nbylo+ZeIKn1dDUPKanPHDKyDyODr7rZyLH3g+xnkw8Bu5Dr/L4ZJGjiFRx5zA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790057404;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=erqPaKnSDh4Wgg/bfmOvurVqo1WUHsHynVdix2PpByY=;
 b=dvypSDuH9bMoLrnqhULJ0aoqs7JTQMC7svAMKJCDrh9IIAIVtPESOHqQjkPZHD1k6jbk
 Is5f5jgJK7v3GtQeODXjXxzPMVmV8/sS2Q9aLvLHWSH/1aHURy//MKbrQgWXcKriCcbi8
 IrPGnnZxJTzUi8L0PjHoTgS/8VdHNrZpUZXkKC42hlZDlv4cj+0cfhCI/4lCSaTTlq3jg
 k1eIUgfwRTLSLgOK0oH7NRQAKxZm3cHQa199zvzX4AGZK/ceEF8CHPOV02q5bbf6kKoFc
 j2tkYMzYYoEAgMp8JVclG1TXr8w609Cb29ilojmEd3B9gD2qLfrOLWy+S7q3LKQrxsw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ciLggVJU; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ciLggVJU
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DFFE54076B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:10:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0410E1056C0; Tue, 22 Sep 2026 08:09:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790057395; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=erqPaKnSDh4Wgg/bfmOvurVqo1WUHsHynVdix2PpByY=;
 b=ciLggVJUCJ26Eot7DPmbhadj9RyRxrYrCJ0bi7gtl3gC0zE75loKFc4E3umYkW1ICTllYF
 pCu1dlW7XBBVibcLYZU/X+DqVgInm0liJ+DgHssLaItJvwE5Pyfn97ipzJHPAW6A3zOZoW
 R2Z+5ce1l/5NvEKDZEjCrIbGVjN0fh9J5GT1AXCUVaIt2qmz1hz63tg7e+hpFjuZEGgra3
 4T2GPLhvX0fJUAD46T812FLl46IZcWXjOmMI8GjRXMhqjLJR/N68lWYMcJLl19qwy9f4AS
 Cd34Qy0pzIr9crq7hRypj08av8EmyuvcJx7vY78XqilNQcUBIi/pSLppM0OnYQ==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Vignesh R <vigneshr@ti.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Heiko Schocher <hs@nabladev.com>, Anshul Dalal <anshuld@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Guodong Xu <guodong@riscstar.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Ssunk <ssunkkan@gmail.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 0/3] mtd: spi: Microchip 23LCV1024 SPI SRAM
Date: Tue, 22 Sep 2026 08:09:29 +0200
Message-ID: <20260922060941.534035-1-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The 23LCV1024 is a 1 Mbit serial SRAM with battery backup on an SPI
bus, used as non volatile scratch storage. This adds a driver for it,
plus a sandbox emulation and a unit test.

The emulation implements all three operating modes of the device and
advances the address counter as the data sheet describes for each of
them, so the test can tell whether the driver puts the device into the
mode it needs. Reaching the emulation means going through the hook of
the sandbox SPI bus, which so far bound the SPI NOR flash emulator for
every slave, hence the second patch.

Patch 2 and 3 touch sandbox and the tests not the SPI NOR subsystem.

Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=213&view=results
is fine.


Heiko Schocher (2):
  sandbox: spi: let a slave name the driver that emulates it
  test: dm: add a test for the Microchip 23LCV1024 SPI SRAM

Stefan Bigler (1):
  mtd: spi: add driver for the Microchip 23LCV1024 SPI SRAM

 arch/sandbox/dts/test.dts         |  14 ++
 arch/sandbox/include/asm/test.h   |   8 +
 configs/sandbox_defconfig         |   2 +
 drivers/mtd/spi/Kconfig           |  20 +++
 drivers/mtd/spi/Makefile          |   2 +
 drivers/mtd/spi/sandbox.c         |  25 ++-
 drivers/mtd/spi/spi_ram.c         | 280 ++++++++++++++++++++++++++++++
 drivers/mtd/spi/spi_ram_sandbox.c | 189 ++++++++++++++++++++
 drivers/spi/Kconfig               |   2 +-
 test/dm/Makefile                  |   1 +
 test/dm/spi_ram.c                 |  96 ++++++++++
 11 files changed, 636 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mtd/spi/spi_ram.c
 create mode 100644 drivers/mtd/spi/spi_ram_sandbox.c
 create mode 100644 test/dm/spi_ram.c

---
base-commit: 75df64103873fac09642860cedadaffb8cf6b2c7
branch: spi-ram-v1

-- 
2.55.0

