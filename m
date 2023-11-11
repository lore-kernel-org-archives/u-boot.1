Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599D2C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 13:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DDC1870E6;
	Sat, 11 Nov 2023 14:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="A5Q/mFgL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACEE786F1C; Sat, 11 Nov 2023 14:42:40 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BAA686D85
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 14:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E86BB3F6CB; 
 Sat, 11 Nov 2023 13:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699710158;
 bh=9oclvER4cUnAdK6ySNwT3czZxmNGoBHEKrNz2Qfywwo=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=A5Q/mFgLf/NGkjISXiuEdE3fiNnlwEqwqPyq40ohgdOrJ9HDrA+DO/pu6QSyQ/iph
 L7GZ3xk/nsDhwwQKBw40b5imruN/LZ+xa8Kd7WjdELdRZG+VdGvA91PsS+8F+FBxiw
 TguZMixr3zfK+ui9mwJ/oU2qcjDeH4GgGFxsO3BqmRaOojJdPmgDxfYrH2QkqpSRn2
 0B/6a+13wvkON/FqzYwEk/1dQDNxSnFIU5T9Y+SGXC/Ozzq+Qsmv7rcEAhbTEOPC25
 NH0zoISexiIpMQyPQNqWwyuJEGNgii9i7ulMLjyTqqGI9nd0QHjTXOK25zcFMMKTKg
 wh5WskqAWuvuA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] cmd: acpi: fix acpi list command
Date: Sat, 11 Nov 2023 14:41:09 +0100
Message-Id: <20231111134112.165377-1-heinrich.schuchardt@canonical.com>
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

ACPI tables may comprise either RSDT, XSDT, or both. The current code fails
to check the presence of the RSDT table before accessing it. This leads to
an exception if the RSDT table is not provided.

Our definition of the XSDT table structure is not correctly packed.

The XSDT table takes precedence over the RSDT table.

Addresses in the XSDT table are 64-bit. Adjust the output and the unit test
accordingly.

The ACPI specification does not require that the sequence of tables are the
same in XSDT and RSDT. Comparing entries with the same index makes no
sense.

The FACS table header does not provide revision information. Correct the
description of dump_hdr().

Heinrich Schuchardt (3):
  acpi: fix struct acpi_xsdt
  cmd: acpi: fix acpi list command
  test: dm: adjust ACPI test

 cmd/acpi.c                | 48 +++++++++++++++++++++++----------------
 include/acpi/acpi_table.h |  2 +-
 test/dm/acpi.c            | 18 +++++++--------
 3 files changed, 39 insertions(+), 29 deletions(-)

-- 
2.40.1

