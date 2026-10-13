Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE72ECA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 13:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40B67606D3;
	Tue, 13 Oct 2026 13:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n6I2-WwWIoFo; Tue, 13 Oct 2026 13:03:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5D2FC60688
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791896598;
	b=tSm82QNqFMRsl3O6NHC1SBy2g25gdRnrMimwphhB4ov0VaNsWW/tjqfVGfqp09LM0Fwx
	 c7283h6aj2kBvRPbfCAftUVZUnSYyWZN+Pc3P1hd7qeJtc0wlmnHzDKe21B50zmFZivWT
	 1aC1gltOZMH166a17UMTfkaWo2zGlL7/HDCpO0C2ndk0lyWuZ3WY5Zu6sEgrCh3iLyFMO
	 M4APSpPzg3ruXT4GRJWWQaV+5JEBvtf7AT1SmhtSowMHYcYoEiIZdVVpLPVgrdzBDeokX
	 ZJ59M6G2dpWi9OBvBbuIhdXQsxBsb5dN2YLzepVZumLw7gEGwAJ3j0a6qVW4V7gKi5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791896598;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eKsIZ6K2Y1VvsQW/rtsDTm4yqad4Pr5ONaW2WvnDwP8=;
	b=mST1pvCVIfDbtxDoXwoBCLAmQ/c0M5CqddByfv42c5ovPxhq6KPJBfIcp1dv44KNFCwi
	 q1ZZh5PEq3yiltNrLBfd52QEQKHgUknAR56HX+vCepulC/dI57hEcnwTHx1dxsdkGuU9v
	 ECf/or/iu8g4rcbKrn95pipmv0vqI313zpRoyI+D79fOYUW5QdV9FUstnopNrzpyB7QaN
	 gZHSTunF52yB6lpugn7JhLteOD3tcweO2K+OUqklZo0FmoUCna/bHff5UW4PtSEQvm/qU
	 SMaPnaBvYPpW0dNFTWhQCkh5m0UQsUSeyfgAvLX6rslMqI8ibCBx0U1I+SUNIT8kmZQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ibpquWUM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791896598;
	bh=eKsIZ6K2Y1VvsQW/rtsDTm4yqad4Pr5ONaW2WvnDwP8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=t5FvKmQjmRt9X15L5YT10ka9MAVu7bynIgdJwO9JBqZPdKYpHoQdKlzvimBHnH/ok
	 GT8lwsH9zdVwd3SiHtKulW5L2t33nJ5Ge4iG2dZFDwoMuCGk5WqdK+G1B60B/9ZHQz
	 r0wHne3HDY4UeKt3+AEvsePnNLowCe5uYeRYnJqFS1KIOe6zDasdyjw9d5YFhXyRPS
	 Qkh/8eUrQM6yb3BePrZb8h331gK+BS+1Ym7/pxlwWPphqwdoFkARAI+iI4LC2CeuP5
	 Mi2I5wq4kc9m3sr46W520al8uFQ/i4KH8VU7vnOPnxMKxkkWLKX3HZ9KlK9agXu8lu
	 yVEb7DCB4Q9WA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D2FC60688;
	Tue, 13 Oct 2026 13:03:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C649129B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E41F60644
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:03:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n7fgWFTJteCk for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 13:03:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A7B2605F3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791896594;
 b=UPeMsNZiVJN9Zj5P9oxRiB6IvkjH/7TCNO6sLGahWiLrSnJMb8ZJsjFVf9K8WI+BpWyK
 8td42SchfERXKe1DWjQBKEEJA4XyEST/3t3POJj363/y6iU8zTshznD8iJrnxoNvuPRRr
 b9t6e0TNpZyX46M+NYRphsPRlENxYajz9UwxdkiAcTSYX7co0UhgajKKOeaCiQ48PSCo6
 WWaRJJLSyafCwECpgntV8iymkVrGVJu+rpCListaGpVCT4GyYAR/Sk5arSozmygQMh52A
 yWIcbrXBEM05PJ95yHdfzgPIQdVJ2cmGzS6ORbB/Xmtlp6B3yQGhNydIgPZkBI1QFPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791896594;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
 bh=eKsIZ6K2Y1VvsQW/rtsDTm4yqad4Pr5ONaW2WvnDwP8=;
 b=DBoa0zFtePB9JK9jdLhLprnz1qKQHB3EDbOtKY5YQbwm2Tj1ixOH2MKzt0k87E2o0IDO
 mNHEtEQVJGANRhYnTPXAs0DX0JsP8XpGl5ju2dbVmamfbE2qrjQHEkAhPHbtc5B1jHCvL
 fgccPBHTsSu5yI2jHX2bS5LUevlkui2kqRSYEs1pltoEqASHQPxm6DC8PjVDhpv8utbHf
 G5mHC/i2R3zvl64AjqQbJwTnf9BrZikUBQcYh5nhUtF8Ljsvn4cDDiGqu699XgB0i+kI9
 9nj/sWjRQjSFiS6yC0Y+172cQvRkcl+vT5f/ygi1IMpDMg3W5li6i80fQblzuJGw7tA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=ibpquWUM; 
 arc=none smtp.remote-ip=220.197.31.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.4;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=ibpquWUM
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A7B2605F3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=eK
 sIZ6K2Y1VvsQW/rtsDTm4yqad4Pr5ONaW2WvnDwP8=; b=ibpquWUMJqOVEkgc+L
 hZ/qFW5CS3SXMymgTOHvT7VH/Y7u/A6mzCtbpAxa5vdZYDxik1uF9r2ZCDN9DTWG
 FCfJLOWPOcWersFAzq0FIAlEcnwTZzxhcy3jzBjT4T7fBYj2UBIIA9azpN9AJnkY
 Ycrn0l2mxz9TRqkDTDAX8SXv0=
Received: from nh50.. (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgDnT4brK85qiFBwEQ--.17862S2;
 Tue, 13 Oct 2026 21:02:36 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, alchark@flipper.net,
 daniel@makrotopia.org, jbx6244@gmail.com, quentin.schulz@cherry.de
Subject: [PATCH v2 0/2] bootstd: Support scripts in raw partitions
Date: Tue, 13 Oct 2026 21:02:33 +0800
Message-ID: <20261013130235.3172204-1-hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgDnT4brK85qiFBwEQ--.17862S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCryDKr1UJw1DGF4DJw1fZwb_yoW5AF18p3
 9rKas8twn7GF13X3y3A3WIyw1fCrs7Gay5XFy7Xa45JrZrtFW0y3ZxK34jyry7ZFZYqa4U
 ZF18JF95GFn8u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jog4fUUUUU=
X-Originating-IP: [2409:8a62:2b4:2720:a989:5f4f:c438:1387]
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbC8QxUJ2rOK+xrGAAA3e
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

This series adds a bootmeth for U-Boot script images stored directly in a
named partition, without a filesystem. It first adds bounds checks to the
shared legacy script parser, so the existing script bootmeth and source
command benefit from the same protection.

The raw bootmeth supports legacy scripts and FIT scripts with embedded
data. It bounds reads by the partition size and a configurable limit,
validates the FIT structure, and rejects external data. A separate
bootmeth keeps raw-partition scanning independently selectable from
filesystem script lookup while sharing verification and execution.

Changes since v1:
- Split the shared legacy parser bounds checks into patch 1.
- Name the parser regression test image_legacy_script_bounds to make its
  legacy-only coverage explicit.
- Keep genimg_get_format() and check the known header size before probing.
- Remove duplicate legacy parsing and redundant raw image checks.
- Move the raw FIT minimum-size check into the FIT branch.
- Add log_msg_ret() diagnostics to raw bootmeth rejection paths.
- Fix the documentation title and explain the self-contained FIT policy.
- Enable CONFIG_BOOTMETH_SCRIPT_RAW in sandbox_defconfig.
- Replace the Python execution tests with C bootflow tests and a generated
  GPT image in test/py/img/script_raw.py; require sgdisk for image setup.
- Update existing bootflow/bootmeth tests for the additional method and
  preserve BOOTFLOWIF_SKIP_GLOBAL coverage in the iterator test.

Validation:
- Sandbox build and 40 selected bootflow, bootmeth, image-bounds and image
  setup tests passed. Both patches passed checkpatch without findings.
- Strict HTML documentation build passed without warnings.
- v2 was also successfully tested on LCKFB Taishan Pi RK3566 using
  lckfb-tspi-rk3566_defconfig with CONFIG_BOOTMETH_SCRIPT_RAW enabled.

He Yong (2):
  image: Bound legacy script parsing by the image size
  bootstd: Add a bootmeth for scripts in raw partitions

 MAINTAINERS                           |   1 +
 arch/sandbox/dts/test.dts             |  12 ++
 boot/Kconfig                          |  26 ++++
 boot/Makefile                         |   1 +
 boot/bootmeth_script.c                |   4 +-
 boot/bootmeth_script_raw.c            | 183 ++++++++++++++++++++++++++
 boot/image-board.c                    |  30 ++++-
 configs/sandbox_defconfig             |   1 +
 doc/develop/bootstd/index.rst         |   1 +
 doc/develop/bootstd/script_raw.rst    |  51 +++++++
 doc/device-tree-bindings/bootmeth.txt |   1 +
 include/bootmeth.h                    |  12 ++
 include/image.h                       |   3 +-
 test/boot/bootflow.c                  |  84 +++++++++++-
 test/boot/bootmeth.c                  |  31 ++++-
 test/boot/image.c                     |  77 +++++++++++
 test/py/img/__init__.py               |   2 +
 test/py/img/script_raw.py             | 107 +++++++++++++++
 test/py/tests/test_ut.py              |   9 ++
 19 files changed, 626 insertions(+), 10 deletions(-)
 create mode 100644 boot/bootmeth_script_raw.c
 create mode 100644 doc/develop/bootstd/script_raw.rst
 create mode 100644 test/py/img/__init__.py
 create mode 100644 test/py/img/script_raw.py

