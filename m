Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C7606EE82
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HHTO/mLV;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yByBWVar
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E12B3606AA;
	Thu,  5 Nov 2026 14:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ayPX_yzhf-1N; Thu,  5 Nov 2026 14:06:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5689860778
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793887573;
	b=sMYvSOcNba5YAiknL9p8UvvWNcbwx6cHuVcnVNJWqsh+4QfMUIjZEfOAr1ezDh81zGeI
	 xMO7+lc+nmDKZgrA4JdNz80ZxegnrtAHF02GIzc99DYSRTKjjkmN6PgMLSXq1N61TlBnM
	 mJn67NsPjywodE1+zoXD/9zabNoT00JLugzy20TvkcDK/5RZgsu1Mt4kh4WHrZU8Y4dNn
	 /YCkgUwygO5SyzGxRJtOJUGV3saqp+xyTIlEOoKV1EP9sYqsDgYrhe7/nB1DI2qJtdPQ+
	 MtpriRs7yFS6CyF+XjZ+Pqi1EWmdXWB7I9rAua13m0VYciadG6yHFWUkHtSL7mQ1tgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793887573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WcaReJ9sYQ6nKbRPHj2zfyCcde+E8V6Hm7/BxWS4aBM=;
	b=q8aZhZiYokz/zFlNoGh+dZi2ym/vxV3FnvOn+9Cv2Pbh64YJGGRG5DL646MPRUmaUWyH
	 aS8hmswuNc9x5ztsWYoiw7A22sJla/yFt8ipY7ohYruQJctADjD3gNMv0OJXkRdVROZaJ
	 vnnWGbf5hA/YHJj+dTn/ZTsXs/7+VKlxUnOiUJkGc9fx2VZpCRIvV9ELFFXMQDFzc1G6x
	 RgJyUye0euBU90NL7UuYdNBJxX8AwCxvDzPme7qTXIiL3JTca4Otd4qhFr3N6BkWELCPt
	 ajzdY5GILqh156Mua6AmV/dqs0P1Lc/5O6lrCm2/CE+nKSMqMv0GP5/5+vgjZoEXigg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793887573;
	bh=WcaReJ9sYQ6nKbRPHj2zfyCcde+E8V6Hm7/BxWS4aBM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HHTO/mLVvwqno+rA471y51LJiWozN8uFzNtXDdyjp/wlMwKCrrQ9g7NKBmYcLhHd4
	 mwpdGTee/462rFFWd6+P093yyj9p2YbEW/MvMCXZ6d5JtiF5x1ZaOghklJAcVBcJb7
	 EJ2TAtyeTCt3V1S4qEhTLG9WlSW6QD84e9WLE1GH5htoUfvj+bQ1FZLRzEHVp4vLoe
	 LEvgQ5N0uEWYmvfs7r50ScbNa1EXfz6/qDzAH8MBbZylA1hSrl0yuGLjjpxISAqQ7d
	 qRYHW5Uem+Nt6MqQd+RgnZE4Xc3qxGAlgINyAQ/512eS+bfwdJqhO0l4Li1zB6NEJO
	 Y1UkIA+ExRd9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5689860778;
	Thu,  5 Nov 2026 14:06:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22B2E235
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 065824072E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:06:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YIP8QmHZPzSR for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 14:06:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 48CB8406AE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=thomas.perrot@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=yByBWVar
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48CB8406AE
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:06:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 8C8AC4E40826
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:06:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 50A8B5FF85;
 Thu,  5 Nov 2026 14:06:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3462810329258; Thu,  5 Nov 2026 15:06:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793887565; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=WcaReJ9sYQ6nKbRPHj2zfyCcde+E8V6Hm7/BxWS4aBM=;
 b=yByBWVarXhSw7P03DcMrgsUOPM/xIGks4ZWTqpWhesqr4yoTQjwo9GdrqC/wabYRAE1MLy
 PJP15qr+nknJrrJrTNKblYwsmo23XPjyZjfOx+latmAVg6jTta4dpLwK7jfs+q6jxZIA7n
 CKiQPfoarhfcRFKRSAZrh3ayxwc8QWNoO3opn3swJzQnfbjk3QZlaHBY3Hyr2czljC5hW0
 5Sre39FTVYs5FxQNeyE9YyuvsLEvBD/x7EkC6nm0NJKJHglRi6Ua5DFZLF7titzMz8ME/s
 +3UcO1ZkPrCHVtOCc6ZUFqaigStY3f/H2ik8w2pwqF8ZcGSn2ntjEd0uLDS0mQ==
From: Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [PATCH RESEND 0/3] riscv: Add support for the BeagleBoard.org
 BeagleV-Ahead
Date: Thu, 05 Nov 2026 15:05:55 +0100
Message-Id: <20261105-dev-tprrt-beaglev-ahead-spl-v1-0-ba7472d69ebf@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot@lists.u-boot-project.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Thomas Perrot <thomas.perrot@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the BeagleBoard.org BeagleV-Ahead, a single
board computer built around the T-Head TH1520 SoC (4x Xuantie C910) with
4 GB of LPDDR4X and 16 GB of eMMC.

Most of the work is already upstream: the TH1520 SoC support added for the
Lichee Pi 4A (SPL, DDR controller, clock and pinctrl drivers, binman FIT
generation) and the BeagleV-Ahead devicetree, which is available through
OF_UPSTREAM. The board therefore only needs a small board directory, a
U-Boot specific devicetree include and a defconfig.

The one missing piece is in the DDR controller driver, which only accepts
the dual rank firmware and fails with -EINVAL on the BeagleV-Ahead. The
first patch makes it program the rank configuration and the address map
from the number of ranks described by the firmware.

As on the Lichee Pi 4A, u-boot-with-spl.bin contains the SPL, the DDR
firmware, OpenSBI and U-Boot proper, and is loaded into SRAM through
fastboot.

The BeagleV-Ahead has a single rank of LPDDR4X, so the DDR firmware has to
be generated from lpddr4x-3733-singlerank.lua, which is already provided by
https://github.com/ziyao233/th1520-firmware, instead of the dual rank
configuration used by the Lichee Pi 4A. This is described in the
documentation added by the third patch.

Testing: the series builds with the Bootlin riscv64 glibc toolchain
(2026.08-1) together with OpenSBI v1.9, and produces a u-boot-with-spl.bin
holding the SPL, the DDR firmware and the FIT image.

The image was loaded into SRAM through the BROM fastboot interface on a
BeagleV-Ahead. Without the first patch the SPL stops with "failed to
initialize DDR controller: -22". With it, the DDR is initialized with the
single rank firmware, OpenSBI and U-Boot proper start, and the console
reports "Model: BeagleV Ahead", "DRAM:  4 GiB", both MMC controllers and
the Ethernet device. The Ethernet link, the eMMC and microSD accesses and
writing U-Boot to the eMMC were not tested. The dual rank behavior is
unchanged by the first patch, but I could not test it on a Lichee Pi 4A.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>

>

---
Thomas Perrot (3):
      ram: thead: th1520: Add single rank support
      board: beagle: Add BeagleV-Ahead board support
      doc: board: beagle: Add BeagleV-Ahead documentation

 arch/riscv/Kconfig                              |   9 ++
 arch/riscv/dts/th1520-beaglev-ahead-u-boot.dtsi |  32 +++++++
 board/beagle/beaglev_ahead/Kconfig              |  43 +++++++++
 board/beagle/beaglev_ahead/MAINTAINERS          |   8 ++
 board/beagle/beaglev_ahead/Makefile             |   7 ++
 board/beagle/beaglev_ahead/board.c              |  14 +++
 board/beagle/beaglev_ahead/spl.c                |  51 +++++++++++
 configs/beaglev_ahead_defconfig                 | 110 ++++++++++++++++++++++++
 doc/board/beagle/beaglev_ahead.rst              | 102 ++++++++++++++++++++++
 doc/board/beagle/index.rst                      |   9 ++
 drivers/ram/thead/th1520_ddr.c                  |  13 ++-
 include/configs/beaglev_ahead.h                 |  20 +++++
 12 files changed, 415 insertions(+), 3 deletions(-)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261014-dev-tprrt-beaglev-ahead-spl-7dc2a4fc0a28

Best regards,
-- 
Thomas Perrot <thomas.perrot@bootlin.com>

