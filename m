Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126D5C43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 08:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39F578494B;
	Sun, 28 Jun 2026 10:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CKRErsTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E21584942; Sun, 28 Jun 2026 10:28:15 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2243E84409
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 10:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box
 (dynamic-046-114-110-002.46.114.pool.telefonica.de [46.114.110.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C9CAE42099; 
 Sun, 28 Jun 2026 08:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782635292;
 bh=huBuQf+uTdl63zPL58lihLZBJjrxr7wIhrglIIttEhk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=CKRErsTm0NGZyBDiiHBIn+H+bH/1pFYu7Qrw/+g+ZZGtEF+E56nCZEn+tFUH2RFRU
 zWx9Dxwm6WwrorC1i0QboPOxbrXY+X8FlqpfHl8D1CRTvcJsxcVfVtTNoC8412Isc9
 aoVE69Y3ynk5tZGFDrJBrB5FEe4EDplEGaQ5Vx4SSvJSdFG62qMdUK6jsBw9LDURSD
 qPCU/orZdRq9uXYrd4Yp6zEFY07VciBGECac1XabMHIqnecFSMcnbD1pzM0ANDiL+8
 u7f8iRYp0AFkGFVPVhLN1FG1z5nkp12y3giY3Ag2sV0jKEvNVRoZ66JznEiGyeeRs5
 5Xd/uF34Os+BKSqpx5LdGWa0RGHM9PHrOogqMRNLYca4CylptpBsEISI8DCA6Nb6g8
 9wYvuTlXi3bN+oNzMj7e36Re2QltqOItgytytWZ11EAMbypKyzpvNWvSr3eYIDI9jD
 /CrQwSxUwbvpdzvD8LH2Ky3xoGp3hIW1Z9UUKoEIvTCgTu1BStfiRU2dtN9DPIqocA
 mtNhS4K9XAhC0YAVdKZa1LJUysyn4TUdC5u1g6PPrj6kNzJ6UEriL6FCgx6jF7dl5K
 iKQnOYbrCmGfiYcEM8hD69FQDZ1rlI8pznVpRtACF14EstR3XLcBz8nb/48g+PSd22
 THz7q/diHGmBBauXge5zhrnQ=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 00/11] efi_loader: fix ACPI table installation
Date: Sun, 28 Jun 2026 10:27:58 +0200
Message-ID: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

On the sandbox efi_acpi_register() used sandbox virtual addressed instead
of pointers required by the invoked API function. This lead to EFI
applications crashing when trying to access the tables.

The first patch corrects the API invocation.

The second patch provides a unit test to ensure we don't do this wrong
again.

The third patch fixes starts_with() in smbiosdump returning NULL instead of
false though the return value is declared as boolean.

The fourth patch fixes an incorrect condition for freeing a buffer in
dtbdump.c and smbiosdump.c.

The next for five patches factor out common code of the EFI apps
dbginfodump, dtbdump, initrddump, and smbiosdump.

The tenth patch corrects the checksum in the RSDP table.

The last patch provides an EFI app to dump ACPI tables.

Changes in v3:

4/11

rephrase the subject line and the commit message

5/11

mention bs, handle, systable are deduplicated in a later patch
mention printx() signature change

6/11
actually add drain_input() to dbginfodump

8/11
use sizeof(efi_guid_t) when calling memcmp() for GUID
correct type of ret in save_file()
document the partition search logic of open_file_system and save_file

9/11

move external variable to efi_app_common.h
remove printx comment (which is in 05/11 now)
safely handle command with length 0 in command_loop()
smbiosdump: don't remove check in do_save()
dbginfodump: remove stray blank line
dbginfodump: keep writing error if Device Path To Text protocol not found
intirddump: use efi_status_t for status code

11/11

extend the commit message
reformat with clang-format
roll in u32_to_utf16_dec()
in add_tables() check against max_tables

Heinrich Schuchardt (11):
  efi_loader: use pointers in efi_acpi_register()
  efi_selftest: add ACPI configuration table test
  efi_loader: smbiosdump: fix starts_with() returning NULL
  efi_loader: fix void* check in open_file_system()
  efi_loader: add efi_app_common skeleton
  efi_loader: move console-input helpers to efi_app_common
  efi_loader: move string helpers to efi_app_common
  efi_loader: move file-system helpers to efi_app_common
  efi_loader: move efi_main and command loop to efi_app_common
  qfw: fix RSDP ext_checksum recomputation
  efi_loader: add ACPI table dump EFI app

 drivers/misc/qfw_acpi.c              |   1 +
 lib/efi_loader/Makefile              |  14 +-
 lib/efi_loader/acpidump.c            | 566 +++++++++++++++++++++++++++
 lib/efi_loader/dbginfodump.c         | 234 +----------
 lib/efi_loader/dtbdump.c             | 482 ++---------------------
 lib/efi_loader/efi_acpi.c            |  35 +-
 lib/efi_loader/efi_app_common.c      | 413 +++++++++++++++++++
 lib/efi_loader/efi_app_common.h      | 156 ++++++++
 lib/efi_loader/initrddump.c          | 410 +------------------
 lib/efi_loader/smbiosdump.c          | 442 ++-------------------
 lib/efi_selftest/Makefile            |   1 +
 lib/efi_selftest/efi_selftest_acpi.c | 138 +++++++
 13 files changed, 1408 insertions(+), 1489 deletions(-)
 create mode 100644 lib/efi_loader/acpidump.c
 create mode 100644 lib/efi_loader/efi_app_common.c
 create mode 100644 lib/efi_loader/efi_app_common.h
 create mode 100644 lib/efi_selftest/efi_selftest_acpi.c

-- 
2.53.0

