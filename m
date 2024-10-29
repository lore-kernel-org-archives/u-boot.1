Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD8AD5B85E
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 01:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBB0789167;
	Tue, 29 Oct 2024 02:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Wo63dz8x";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RbTtQeH7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E72A88D06; Tue, 29 Oct 2024 02:06:35 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F5289161
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 02:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XcsXS5Tz4z9sbl;
 Tue, 29 Oct 2024 02:06:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730163992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fdNOk225olH/9UZ+TWu98hvVXJ8tyWHmqiFF/z8eSGU=;
 b=Wo63dz8xMd7UynNK/eSf3hMjAEvBUv1wtkLq2Dhha12usNVBZeMo6X6mV6pumbxbYfIdMV
 8NZhYGiW4xx9EfUt4NgXTKtTZQGZ81tG2QlqtUVWkopEplU37HBcNzrGiHSUUAh2LARMqO
 Dna6fMDCwGJ84OLTitWyJRHS/kfT+gku+AjNG4WCjpuXOza9RrakFsdNeVd6QW1BEmzBL4
 Jw5UvYz2T0MybhY5Z36ECvkuIwwKPzNKvvxuMM9dIvUZohn5edJcSiBT7rcp1BPSjtmwkE
 eW5z59JU/eNGMFlR+7ndCIZwMZnOwBGAL2O68RKPSClTM1hTWSb/gmdlL+rxBg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730163990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fdNOk225olH/9UZ+TWu98hvVXJ8tyWHmqiFF/z8eSGU=;
 b=RbTtQeH7PfBZSnh2ywlxeKU9JIbhGmNUHYUGkFsdJAYT/DbkalVmssLFf3g4grSIZR1CwP
 Pe0Y7BVPv98ENbrSdRme23wM9MUrvTwQPYeyh1C691Jop5tJU/Haoh08SWjqG4HPxmYOAb
 2py1zOJ9sYZ9APXSQrwpeiR8Vtivr1j9/FPt3zP97QwSqJzf9hH5hZn1PhdHeVsqgNuAl8
 OBPFOITRFTsrXhPwPcvJYC5ZGU2dJ0BZSy6lRFbK5PhEfZDVjcqLJR4PUgPI0CdZHqMkHq
 O6pnpcsOWpkDo1lMr2nYnXMkhpu3SwaRXd5dv8DGGijwregQIYdkyjG7Fi/eTg==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PULL] u-boot-sh/master
Date: Tue, 29 Oct 2024 02:05:47 +0100
Message-ID: <20241029010611.175198-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hbohtadu17ep5wuisop9zbnscw9tfbrx
X-MBO-RS-ID: 65bc31793d4110a1f25
X-Rspamd-Queue-Id: 4XcsXS5Tz4z9sbl
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

The following changes since commit 3df6145db0ed3430a2af089db5a82372bea3f4d5:

  x86: Missed removal of CMD_BOOTEFI_HELLO_COMPILE (2024-10-27 20:11:36 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 400d06cb86a074dbd23cbb7f1210dad26f392807:

  mmc: renesas-sdhi: Add compatible string for rzg2l-sdhi (2024-10-28 16:27:34 +0100)

----------------------------------------------------------------
Marek Vasut (3):
      ARM: renesas: Drop old unused clock DT headers
      ARM: renesas: Drop old unused power DT headers
      ARM: renesas: Add top level board/renesas/ MAINTAINERS file

Paul Barker (1):
      mmc: renesas-sdhi: Add compatible string for rzg2l-sdhi

 board/renesas/MAINTAINERS                          | 17 ++++
 drivers/mmc/renesas-sdhi.c                         |  1 +
 include/dt-bindings/clock/r8a774a1-cpg-mssr.h      | 59 -------------
 include/dt-bindings/clock/r8a774b1-cpg-mssr.h      | 57 -------------
 include/dt-bindings/clock/r8a774c0-cpg-mssr.h      | 61 --------------
 include/dt-bindings/clock/r8a774e1-cpg-mssr.h      | 59 -------------
 include/dt-bindings/clock/r8a7790-cpg-mssr.h       | 48 -----------
 include/dt-bindings/clock/r8a7791-cpg-mssr.h       | 44 ----------
 include/dt-bindings/clock/r8a7792-cpg-mssr.h       | 39 ---------
 include/dt-bindings/clock/r8a7793-cpg-mssr.h       | 44 ----------
 include/dt-bindings/clock/r8a7794-cpg-mssr.h       | 43 ----------
 include/dt-bindings/clock/r8a7795-cpg-mssr.h       | 66 ---------------
 include/dt-bindings/clock/r8a7796-cpg-mssr.h       | 65 ---------------
 include/dt-bindings/clock/r8a77961-cpg-mssr.h      | 65 ---------------
 include/dt-bindings/clock/r8a77965-cpg-mssr.h      | 62 --------------
 include/dt-bindings/clock/r8a77970-cpg-mssr.h      | 44 ----------
 include/dt-bindings/clock/r8a77980-cpg-mssr.h      | 51 ------------
 include/dt-bindings/clock/r8a77990-cpg-mssr.h      | 62 --------------
 include/dt-bindings/clock/r8a77995-cpg-mssr.h      | 54 ------------
 include/dt-bindings/clock/r8a779a0-cpg-mssr.h      | 55 -------------
 include/dt-bindings/clock/r8a779f0-cpg-mssr.h      | 64 ---------------
 include/dt-bindings/clock/r8a779g0-cpg-mssr.h      | 91 --------------------
 .../dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h  | 96 ----------------------
 include/dt-bindings/clock/renesas-cpg-mssr.h       | 15 ----
 include/dt-bindings/power/r8a774a1-sysc.h          | 31 -------
 include/dt-bindings/power/r8a774b1-sysc.h          | 26 ------
 include/dt-bindings/power/r8a774c0-sysc.h          | 25 ------
 include/dt-bindings/power/r8a774e1-sysc.h          | 36 --------
 include/dt-bindings/power/r8a7790-sysc.h           | 31 -------
 include/dt-bindings/power/r8a7791-sysc.h           | 23 ------
 include/dt-bindings/power/r8a7792-sysc.h           | 23 ------
 include/dt-bindings/power/r8a7793-sysc.h           | 25 ------
 include/dt-bindings/power/r8a7794-sysc.h           | 23 ------
 include/dt-bindings/power/r8a7795-sysc.h           | 38 ---------
 include/dt-bindings/power/r8a7796-sysc.h           | 33 --------
 include/dt-bindings/power/r8a77961-sysc.h          | 32 --------
 include/dt-bindings/power/r8a77965-sysc.h          | 29 -------
 include/dt-bindings/power/r8a77970-sysc.h          | 28 -------
 include/dt-bindings/power/r8a77980-sysc.h          | 43 ----------
 include/dt-bindings/power/r8a77990-sysc.h          | 26 ------
 include/dt-bindings/power/r8a77995-sysc.h          | 20 -----
 include/dt-bindings/power/r8a779a0-sysc.h          | 59 -------------
 include/dt-bindings/power/r8a779f0-sysc.h          | 30 -------
 include/dt-bindings/power/r8a779g0-sysc.h          | 46 -----------
 include/dt-bindings/power/renesas,r8a779h0-sysc.h  | 49 -----------
 45 files changed, 18 insertions(+), 1920 deletions(-)
 create mode 100644 board/renesas/MAINTAINERS
 delete mode 100644 include/dt-bindings/clock/r8a774a1-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a774b1-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a774c0-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a774e1-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a7790-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a7791-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a7792-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a7793-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a7794-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a7795-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a7796-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a77961-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a77965-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a77970-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a77980-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a77990-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a77995-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a779a0-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a779f0-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a779g0-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/renesas-cpg-mssr.h
 delete mode 100644 include/dt-bindings/power/r8a774a1-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a774b1-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a774c0-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a774e1-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a7790-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a7791-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a7792-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a7793-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a7794-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a7795-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a7796-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a77961-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a77965-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a77970-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a77980-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a77990-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a77995-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a779a0-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a779f0-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a779g0-sysc.h
 delete mode 100644 include/dt-bindings/power/renesas,r8a779h0-sysc.h
