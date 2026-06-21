Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53714CDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 08:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F10E849D1;
	Sun, 21 Jun 2026 10:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="S5YooVI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41528849C5; Sun, 21 Jun 2026 10:19:23 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D35F883FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 10:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-176-006-085-155.176.6.pool.telefonica.de
 [176.6.85.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CFDA93F1E4; 
 Sun, 21 Jun 2026 08:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782029960;
 bh=0/XinVGZjvrv+WhEe9S/ftS4gX0YFxL895R1Xr08i9w=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=S5YooVI8s60dW9Zg5yv6yaSShWQ54g44qcuA7oc8LNl0+RK5z3iIbLF85lnPh4aEU
 Nva7Wju8D6XjEIDvvmM6KKSb7VSdZZ4WmtpwN9q3Uy34u/JR6T2K88E7JWMCT1Sk1N
 tvmjz4/l4Ri8IzEwzN0bQRB/3jnqDCLq85/HapPARsIBqrYC8TNdBOGeHAwgXaosdt
 98qC+1hVU2aNv1nu6XRrsAFK9fbav+n/sQboiQ3WB7iEmABO+m9hEzeVs0xz0EefYr
 wdQCnAcMiL8v22RoWLj6+eGmDyLJY18a9ftpzXpbXVLiVQMJMMg6EG0W6TVMr5DuoJ
 gcC+XpfhiSCzYmODWbX7IQyshvC/W2SF0N6S499X13IzgwZ2hiWWG4kVLNYf2YH2iQ
 azvBGApSMRdr0IwSUa4VG3gxysWytOrB5D1iYvB8E5pvjLqnd2BZWhAoLH5wgddY3m
 SaE9XvABABjNAHMRUuLIHQJis9/JBG8AiwMg95a8XPv9Ik6zmq6YXIXlTsuxx4c7xE
 FQJ6+w8780+ZOH7vOglLUD0cpOOE2KLbjNtX04wQLiCKgNUkXksTbakfAVaAjlQCx2
 pQxZHX4EyiSmBprgmy+HMK8toDZ2YbtNfYKgeUxVcGXA4jUQsiF7dYcRllAa/XoxtE
 Meyp4albDabGp9R+XfTIVaBc=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 00/11] efi_loader: fix ACPI table installation
Date: Sun, 21 Jun 2026 10:19:04 +0200
Message-ID: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
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

Heinrich Schuchardt (11):
  efi_loader: use pointers in efi_acpi_register()
  efi_selftest: add ACPI configuration table test
  efi_loader: smbiosdump: fix starts_with() returning NULL
  efi_loader: fix open_file_system() memory leak on fallback path
  efi_loader: add efi_app_common skeleton
  efi_loader: move console-input helpers to efi_app_common
  efi_loader: move string helpers to efi_app_common
  efi_loader: move file-system helpers to efi_app_common
  efi_loader: move efi_main and command loop to efi_app_common
  qfw: fix RSDP ext_checksum recomputation
  efi_loader: add ACPI table dump EFI app

 drivers/misc/qfw_acpi.c              |   1 +
 lib/efi_loader/Makefile              |  14 +-
 lib/efi_loader/acpidump.c            | 563 +++++++++++++++++++++++++++
 lib/efi_loader/dbginfodump.c         | 230 +----------
 lib/efi_loader/dtbdump.c             | 482 ++---------------------
 lib/efi_loader/efi_acpi.c            |  35 +-
 lib/efi_loader/efi_app_common.c      | 415 ++++++++++++++++++++
 lib/efi_loader/efi_app_common.h      | 136 +++++++
 lib/efi_loader/initrddump.c          | 406 +------------------
 lib/efi_loader/smbiosdump.c          | 466 ++--------------------
 lib/efi_selftest/Makefile            |   1 +
 lib/efi_selftest/efi_selftest_acpi.c | 138 +++++++
 12 files changed, 1380 insertions(+), 1507 deletions(-)
 create mode 100644 lib/efi_loader/acpidump.c
 create mode 100644 lib/efi_loader/efi_app_common.c
 create mode 100644 lib/efi_loader/efi_app_common.h
 create mode 100644 lib/efi_selftest/efi_selftest_acpi.c

-- 
2.53.0

