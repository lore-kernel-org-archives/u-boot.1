Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C33C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 10:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D510087854;
	Thu, 21 Dec 2023 11:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="c23wxK8j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 070A587854; Thu, 21 Dec 2023 11:50:35 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B94F5874D5
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 11:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 41D683F2D2; 
 Thu, 21 Dec 2023 10:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703155831;
 bh=XSnmAcsqd5rb9UOKZN3/iBHGbxcXIfMK/6w9NDDGGKk=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=c23wxK8jj6BGMLUNZ2M/8Jj8JzjAba1/eH81ZtkhO8NWpM12e8C+yV/ihFJyVNKwZ
 gD2MuEPLcR8ij0QbvQXFo7w9Yafd//O49/54VnuD0TK4PGfiAhJmo+V1CH5+EXG3oz
 +9CsO0ZcrARxZozstRAgBo9XmUs/RpnK+cSxU+aJAmI3fwIPcApiDadPel9F6y0qZT
 /mBDZ4D4dLrJZbjqKHNQqMMdEhrJHhX8btd2U+LJO9Y/sXw9lzyEpredKtTnVwCNUU
 SxIOsVhZjH8omTQ5v8KqMJ6HHJFZIg0lGucWFmNhLjfwmZU6sr5kfpx+d2kivEPfpC
 L9gM3JEzZnh7Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] smbios: copy QEMU tables
Date: Thu, 21 Dec 2023 11:50:15 +0100
Message-Id: <20231221105017.6895-1-heinrich.schuchardt@canonical.com>
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

QEMU provides SMBIOS tables with detailed information. We should not try to
replicate them in U-Boot.

With this series we add code to copy the QEMU generated SMBIOS tables to
RAM. efi_smbios_register() later installs the SMBIOS table as EFI
configuration table for the OS to pick it up.

If we want to inform about U-Boot, we can add a Firmware Inventory
Information (type 45) table in future.

With 32bit ARM I did not see a correct SMBIOS table being transferred. We
need to check if our code in qfw_read_entry() is 32bit compliant.

For providing SMBIOS support in QEMU for RISC-V I have sent a patch
upstream:

[PATCH 1/1] target/riscv: SMBIOS support for RISC-V virt machine
https://lore.kernel.org/qemu-riscv/9183a3fb-b9f7-470c-b9a6-8d8cc6dce7c3@canonical.com/T/#t

Currently we have a predefined constant TABLE_SIZE = SZ_4K in
lib/efi_loader/efi_smbios.c. We should strive to refactor the code in
future to provide the length of the SMBIOS tables in global data. But
that is beyond the scope of this series.

Further we should find a matainer for drivers/misc/qfw*. It would be
plausible to add it to 'ACPI' maintenance.

Heinrich Schuchardt (2):
  smbios: SMBIOS 3.0 (64-bit) Entry Point structure
  smbios: copy QEMU tables

 drivers/misc/Kconfig        |   8 ++
 drivers/misc/Makefile       |   1 +
 drivers/misc/qfw_smbios.c   | 195 ++++++++++++++++++++++++++++++++++++
 include/smbios.h            |  26 +++++
 lib/efi_loader/efi_smbios.c |   4 +-
 5 files changed, 233 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/qfw_smbios.c

-- 
2.40.1

