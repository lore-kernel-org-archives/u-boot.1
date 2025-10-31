Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621C7CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 19:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAF6A83AE7;
	Fri, 31 Oct 2025 20:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="f8YsIT+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A2BE83AEE; Fri, 31 Oct 2025 20:59:37 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20A0183AE4
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 20:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 26808401CC; 
 Fri, 31 Oct 2025 19:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761940774;
 bh=MAnGPi3CpfQzQEv+HvHgHkTnpmtCuoV0UrVvwJagShs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=f8YsIT+uhtGxIxwsC3W1QXEp1L3snNfHelEZCCqkI2V94tmvqiAGNwmN0D0Bf1YLd
 FiHpeK7p73Gskq4G53Tu5hSJvws6j2ZxYbl2+Xh6AG1MyBuNYRVikXW71E5xKanGIX
 9yhfTnpoa4wrGwou24aRbUISzPjo+ogs7NwzLH6OrJShI70MUGgG+F4LPzr3l0mUhz
 9+y95BLpVo3RBIL69mzApd81Ue8PsR/xHcBsJOxQI5Jvj04RKbuyLAkFkA5TJaDuR5
 3f9DavEGfJnIN0qSLlfheOVMtzNTx4IW6w4cWayGtrEX88751ucptE1z+HLd/kLbCZ
 jj/CZkzapKU2Q8x0wqZavt48kXTqc5yqudZPZpgLMqttnHZFtWIDTjWhQW8EShlcPV
 KrmoWO3UT/Rx8wk3hCuaycoMYtU3SeGkQwKqfSbCL8CZSvvH+sGU7/zzRQlW9xDVml
 rwH+h5/MsHqzSi1XaJrffL8YEmzge/JBKpKaCFtXsgv+pNdft2aMioJIstZq3wXnP3
 aXS5m99TVq/CEe1PZjXbQvdywEHf7SfK2y5tkeKWnIVrDBOwGF3kc8i1+cSnB2jT70
 YQ8tq66QHk3OQFKY2N8z8bzfHVX7W6pyo+tWSh0Uxfd36B2S79YSgIAtUnhx8l4iRI
 ezl/rYXYrYfZVwmjxazgZmBM=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] qfw/acpi: do not zero out XSDT address
Date: Fri, 31 Oct 2025 20:59:28 +0100
Message-ID: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Since release 2025.01 the discovery of QEMU ACPI tables is broken.

* Remove the line erasing the pointer to the XSDT table
* Add a test for the 'acpi list' command
* Provide a configuration that can run this test

This series goes together with patch

[PATCH 1/1] CI: test qemu-riscv64_smode[_acpi]
https://lore.kernel.org/u-boot/20251028131720.55212-1-heinrich.schuchardt@canonical.com/

which enables running CI tests on qemu-riscv64_smode_acpi_defconfig.

Heinrich Schuchardt (3):
  qfw/acpi: do not zero out XSDT address
  test: provide test for 'acpi list' command
  configs: CONFIG_CONSOLE_RECORD=y on qemu-riscv64_smode_acpi

 configs/qemu-riscv64_smode_acpi_defconfig |  1 +
 drivers/misc/qfw_acpi.c                   |  1 -
 test/cmd/Makefile                         |  3 ++
 test/cmd/acpi.c                           | 52 +++++++++++++++++++++++
 4 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 test/cmd/acpi.c

-- 
2.51.0

